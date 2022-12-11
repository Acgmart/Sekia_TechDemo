//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Effects/Amber" {
Properties {
_Scale ("Scale Compared to Maya", Float) = 0.01
[Header(Element View)] _ElementViewEleID ("Element ID", Float) = 0
[Toggle] _ReceiveShadow ("Receive Shadow", Float) = 0
[Toggle] _EnableAlphaTest ("Enable Alpha Test", Float) = 0
_CutOff ("Mask Clip Value", Range(0, 1)) = 0
[Enum(OFF, 0, ON, 1)] _OutlineOn ("Outline Type", Float) = 0
_OutlineWidth ("Outline Width", Range(0, 100)) = 0.05
_OutlineColor ("Outline Color", Color) = (0,0,0,1)
_MaxOutlineZOffset ("Max Outline Z Offset", Range(0, 100)) = 1
[Header(Dithering)] [Toggle(USINGDITHERALPAH)] _UsingDitherAlpha ("UsingDitherAlpha", Float) = 0
_DitherAlpha ("Dither Alpha Value", Range(0, 1)) = 1
_ElementMask ("ElementMask", 2D) = "white" { }
_CubeMap ("CubeMap", Cube) = "white" { }
_CubeMapBrightness ("CubeMapBrightness", Float) = 4
_CubeMaskTex ("CubeMaskTex", 2D) = "white" { }
_CubeMapIntensity ("CubeMapIntensity", Range(0, 1)) = 0.007757068
_Fresnal_Power ("Fresnal_Power", Float) = 3
_Fresnal_Scale ("Fresnal_Scale", Float) = 1
_Highlight_Color ("Highlight_Color", Color) = (0.7334559,0.8970082,0.9779412,0)
_BumpTex ("BumpTex", 2D) = "white" { }
_BumpOffsetHeight ("BumpOffsetHeight", Float) = 14.89
_BumpTexIntensity ("BumpTexIntensity", Range(0, 2)) = 1
_MainNormalIntensity ("MainNormalIntensity", Color) = (1,1,1,0)
_LightColor ("LightColor", Color) = (0.5073529,0.9692103,1,0)
_DarkColor ("DarkColor", Color) = (0.05482266,0.1121853,0.1911765,0)
_GlobalBightness ("GlobalBightness", Float) = 1
_EmissiveIntensity ("EmissiveIntensity", Range(0, 1)) = 1
[MHYToggle] _TillingNormalToggle ("TillingNormalToggle", Float) = 1
_NormalMap ("NormalMap", 2D) = "white" { }
_TillingNormal ("TillingNormal", 2D) = "white" { }
_NormalIntensity ("NormalIntensity", Color) = (0.659,0.672,1,0)
_EdgeColor ("EdgeColor", Color) = (0,0,0,0)
_EdgePower ("EdgePower", Float) = 0.99
_EdgeWidth ("EdgeWidth", Float) = 1.48
_ElementPatternIntensity ("ElementPatternIntensity", Float) = 0
_ElementPatternColor ("ElementPatternColor", Color) = (0,0,0,0)
_texcoord ("", 2D) = "white" { }
}
SubShader {
 Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "HYBRIDDEFERRED"
  Tags { "LIGHTMODE" = "HYBRIDDEFERRED" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 28257
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
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TANGENT0;
out highp vec3 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat15;
float u_xlat16;
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
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.yzx;
    vs_TEXCOORD0.xyz = u_xlat1.zxy;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    vs_TEXCOORD4.w = 0.0;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.zxy;
    vs_TEXCOORD4.xyz = u_xlat2.yzx;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD5.xyz = u_xlat1.zxy;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat15 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat4.x = u_xlat2.z;
    u_xlat4.z = u_xlat1.x;
    u_xlat4.y = u_xlat3.y;
    u_xlat4.xyz = u_xlat0.yyy * u_xlat4.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat2.z = u_xlat1.y;
    u_xlat1.y = u_xlat3.x;
    u_xlat2.y = u_xlat3.z;
    u_xlat0.xyw = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
    vs_TEXCOORD7.xyz = u_xlat2.xyz * u_xlat0.zzz + u_xlat0.xyw;
    vs_TEXCOORD7.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _ReceiveShadow;
uniform 	float _EnableAlphaTest;
uniform 	float _CutOff;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	float _TillingNormalToggle;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _TillingNormal_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _BumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	vec4 _MainNormalIntensity;
uniform 	float _BumpTexIntensity;
uniform 	float _EdgePower;
uniform 	float _EdgeWidth;
uniform 	vec4 _EdgeColor;
uniform 	vec4 _ElementPatternColor;
uniform 	vec4 _ElementMask_ST;
uniform 	float _ElementPatternIntensity;
uniform 	vec4 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _CubeMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _GlobalBightness;
uniform 	float _EmissiveIntensity;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _TillingNormal;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _ElementMask;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _CubeMaskTex;
in highp vec3 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
uvec3 u_xlatu0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp float u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat14;
vec2 u_xlat23;
float u_xlat27;
bool u_xlatb27;
float u_xlat28;
float u_xlat31;
lowp float u_xlat10_31;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatb0.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingDitherAlpha, _EnableAlphaTest, _UsingDitherAlpha, _UsingDitherAlpha)).xy;
    if(u_xlatb0.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0.x = !!(_DitherAlpha<0.949999988);
#else
        u_xlatb0.x = _DitherAlpha<0.949999988;
#endif
        if(u_xlatb0.x){
            u_xlat0.xz = vs_TEXCOORD1.yx / vs_TEXCOORD1.ww;
            u_xlat0.xz = u_xlat0.xz * _ScreenParams.yx;
            u_xlat0.xz = u_xlat0.xz * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat0.xzxx, (-u_xlat0.xzxx)).xy;
            u_xlat0.xz = fract(abs(u_xlat0.xz));
            u_xlat0.x = (u_xlatb1.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.z = (u_xlatb1.y) ? u_xlat0.z : (-u_xlat0.z);
            u_xlat0.xz = u_xlat0.xz * vec2(4.0, 4.0);
            u_xlatu0.xz = uvec2(u_xlat0.xz);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.z)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.z)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.z)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.z)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = _DitherAlpha * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + -0.00999999978;
#ifdef UNITY_ADRENO_ES3
            u_xlatb0.x = !!(u_xlat0.x<0.0);
#else
            u_xlatb0.x = u_xlat0.x<0.0;
#endif
            if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xzw = u_xlat0.xxx * vs_TEXCOORD2.xyz;
    u_xlat1.xy = vs_TEXCOORD3.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb1.x = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb1.x){
        u_xlat1.xy = vs_TEXCOORD3.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_1.xyz = texture(_TillingNormal, u_xlat1.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_2.xyz;
        u_xlat1.xyz = u_xlat16_3.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat1.xyz = u_xlat16_2.xyz;
    //ENDIF
    }
    u_xlat4.x = vs_TEXCOORD4.x;
    u_xlat4.y = vs_TEXCOORD6.x;
    u_xlat4.z = vs_TEXCOORD5.x;
    u_xlat5.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat6.x = vs_TEXCOORD4.y;
    u_xlat6.y = vs_TEXCOORD6.y;
    u_xlat6.z = vs_TEXCOORD5.y;
    u_xlat5.y = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat7.x = vs_TEXCOORD4.z;
    u_xlat7.y = vs_TEXCOORD6.z;
    u_xlat7.z = vs_TEXCOORD5.z;
    u_xlat5.z = dot(u_xlat7.xyz, u_xlat1.xyz);
    u_xlat28 = dot(u_xlat5.xyz, u_xlat0.xzw);
    u_xlat28 = (-u_xlat28) + 1.0;
    u_xlat28 = max(u_xlat28, 9.99999975e-05);
    u_xlat28 = log2(u_xlat28);
    u_xlat28 = u_xlat28 * _Fresnal_Power;
    u_xlat28 = exp2(u_xlat28);
    u_xlat28 = u_xlat28 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD3.xy * _BumpTex_ST.xy + _BumpTex_ST.zw;
    u_xlat31 = dot(vs_TEXCOORD7.xyz, vs_TEXCOORD7.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat23.x = _BumpOffsetHeight + -1.0;
    u_xlat8.xy = u_xlat16_2.xy * _MainNormalIntensity.xy;
    u_xlat8.xy = vs_TEXCOORD7.xy * vec2(u_xlat31) + u_xlat8.xy;
    u_xlat23.xy = u_xlat23.xx * u_xlat8.xy;
    u_xlat5.xy = u_xlat23.xy * vec2(0.100000001, 0.100000001) + u_xlat5.xy;
    u_xlat31 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat8.xyz = vec3(u_xlat31) * vs_TEXCOORD5.xyz;
    u_xlat31 = dot(u_xlat8.xyz, u_xlat0.xzw);
    u_xlat31 = (-u_xlat31) + 1.0;
    u_xlat31 = max(u_xlat31, 9.99999975e-05);
    u_xlat31 = log2(u_xlat31);
    u_xlat31 = u_xlat31 * _EdgePower;
    u_xlat31 = exp2(u_xlat31);
    u_xlat31 = u_xlat31 * _EdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat10_5 = texture(_BumpTex, u_xlat5.xy).x;
    u_xlat5.x = u_xlat10_5 * _BumpTexIntensity;
    u_xlat14.x = (-u_xlat31) + 1.0;
    u_xlat5.x = u_xlat14.x * u_xlat5.x;
    u_xlat14.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat14.xyz + _DarkColor.xyz;
    u_xlat8.xyz = (-u_xlat5.xyz) + _EdgeColor.xyz;
    u_xlat5.xyz = vec3(u_xlat31) * u_xlat8.xyz + u_xlat5.xyz;
    u_xlat8.xy = vs_TEXCOORD3.xy * _ElementMask_ST.xy + _ElementMask_ST.zw;
    u_xlat10_31 = texture(_ElementMask, u_xlat8.xy).x;
    u_xlat31 = u_xlat10_31 * _ElementPatternIntensity;
    u_xlat8.xyz = (-u_xlat5.xyz) + _ElementPatternColor.xyz;
    u_xlat5.xyz = vec3(u_xlat31) * u_xlat8.xyz + u_xlat5.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _NormalIntensity.xyz;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.y = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat4.z = dot(u_xlat7.xyz, u_xlat1.xyz);
    u_xlat1.x = dot((-u_xlat0.xzw), u_xlat4.xyz);
    u_xlat1.x = u_xlat1.x + u_xlat1.x;
    u_xlat0.xzw = u_xlat4.xyz * (-u_xlat1.xxx) + (-u_xlat0.xzw);
    u_xlat1.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xzw = u_xlat0.xzw * u_xlat1.xxx;
    u_xlat1.xy = vs_TEXCOORD3.xy * _CubeMaskTex_ST.xy + _CubeMaskTex_ST.zw;
    u_xlat10_0.xzw = texture(_CubeMap, u_xlat0.xzw).xyz;
    u_xlat10_1.x = texture(_CubeMaskTex, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1.x * _CubeMapIntensity;
    u_xlat0.xzw = u_xlat10_0.xzw * vec3(_CubeMapBrightness) + (-u_xlat5.xyz);
    u_xlat0.xzw = u_xlat1.xxx * u_xlat0.xzw + u_xlat5.xyz;
    u_xlat0.xzw = u_xlat0.xzw * vec3(vec3(_GlobalBightness, _GlobalBightness, _GlobalBightness));
    u_xlat1.xyz = vec3(u_xlat28) * _Highlight_Color.xyz + u_xlat0.xzw;
    u_xlat0.x = (-_CutOff) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat0.x<0.0);
#else
    u_xlatb0.x = u_xlat0.x<0.0;
#endif
    u_xlatb0.x = u_xlatb0.y && u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity));
    u_xlat27 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * vs_TEXCOORD0.xyz;
    SV_Target0.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb27 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_2.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb27) ? u_xlat16_2.x : u_xlat0.z;
    SV_Target0.w = 0.00392156886;
    u_xlat1.w = _ReceiveShadow;
    SV_Target1 = u_xlat1;
    SV_Target2.xy = u_xlat0.xy;
    SV_Target2.w = 0.223606795;
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
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TANGENT0;
out highp vec3 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat16;
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
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat5.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * u_xlat2.yzx;
    vs_TEXCOORD0.xyz = u_xlat5.zxy;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.zxy;
    vs_TEXCOORD4.xyz = u_xlat2.yzx;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD5.xyz = u_xlat5.zxy;
    vs_TEXCOORD5.w = 0.0;
    u_xlat3.xyz = u_xlat5.yzx * u_xlat2.zxy;
    u_xlat3.xyz = u_xlat5.xyz * u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat4.x = u_xlat2.z;
    u_xlat4.z = u_xlat5.x;
    u_xlat4.y = u_xlat3.y;
    u_xlat4.xyz = u_xlat1.yyy * u_xlat4.xyz;
    u_xlat5.x = u_xlat2.y;
    u_xlat2.z = u_xlat5.y;
    u_xlat5.y = u_xlat3.x;
    u_xlat2.y = u_xlat3.z;
    u_xlat0.xyz = u_xlat5.xyz * u_xlat1.xxx + u_xlat4.xyz;
    vs_TEXCOORD7.xyz = u_xlat2.xyz * u_xlat1.zzz + u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _ReceiveShadow;
uniform 	float _EnableAlphaTest;
uniform 	float _CutOff;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	float _TillingNormalToggle;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _TillingNormal_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _BumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	vec4 _MainNormalIntensity;
uniform 	float _BumpTexIntensity;
uniform 	float _EdgePower;
uniform 	float _EdgeWidth;
uniform 	vec4 _EdgeColor;
uniform 	vec4 _ElementPatternColor;
uniform 	vec4 _ElementMask_ST;
uniform 	float _ElementPatternIntensity;
uniform 	vec4 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _CubeMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _GlobalBightness;
uniform 	float _EmissiveIntensity;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _TillingNormal;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _ElementMask;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _CubeMaskTex;
in highp vec3 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
uvec3 u_xlatu0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp float u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat14;
vec2 u_xlat23;
float u_xlat27;
bool u_xlatb27;
float u_xlat28;
float u_xlat31;
lowp float u_xlat10_31;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatb0.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingDitherAlpha, _EnableAlphaTest, _UsingDitherAlpha, _UsingDitherAlpha)).xy;
    if(u_xlatb0.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0.x = !!(_DitherAlpha<0.949999988);
#else
        u_xlatb0.x = _DitherAlpha<0.949999988;
#endif
        if(u_xlatb0.x){
            u_xlat0.xz = vs_TEXCOORD1.yx / vs_TEXCOORD1.ww;
            u_xlat0.xz = u_xlat0.xz * _ScreenParams.yx;
            u_xlat0.xz = u_xlat0.xz * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat0.xzxx, (-u_xlat0.xzxx)).xy;
            u_xlat0.xz = fract(abs(u_xlat0.xz));
            u_xlat0.x = (u_xlatb1.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.z = (u_xlatb1.y) ? u_xlat0.z : (-u_xlat0.z);
            u_xlat0.xz = u_xlat0.xz * vec2(4.0, 4.0);
            u_xlatu0.xz = uvec2(u_xlat0.xz);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.z)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.z)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.z)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.z)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = _DitherAlpha * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + -0.00999999978;
#ifdef UNITY_ADRENO_ES3
            u_xlatb0.x = !!(u_xlat0.x<0.0);
#else
            u_xlatb0.x = u_xlat0.x<0.0;
#endif
            if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xzw = u_xlat0.xxx * vs_TEXCOORD2.xyz;
    u_xlat1.xy = vs_TEXCOORD3.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb1.x = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb1.x){
        u_xlat1.xy = vs_TEXCOORD3.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_1.xyz = texture(_TillingNormal, u_xlat1.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_2.xyz;
        u_xlat1.xyz = u_xlat16_3.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat1.xyz = u_xlat16_2.xyz;
    //ENDIF
    }
    u_xlat4.x = vs_TEXCOORD4.x;
    u_xlat4.y = vs_TEXCOORD6.x;
    u_xlat4.z = vs_TEXCOORD5.x;
    u_xlat5.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat6.x = vs_TEXCOORD4.y;
    u_xlat6.y = vs_TEXCOORD6.y;
    u_xlat6.z = vs_TEXCOORD5.y;
    u_xlat5.y = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat7.x = vs_TEXCOORD4.z;
    u_xlat7.y = vs_TEXCOORD6.z;
    u_xlat7.z = vs_TEXCOORD5.z;
    u_xlat5.z = dot(u_xlat7.xyz, u_xlat1.xyz);
    u_xlat28 = dot(u_xlat5.xyz, u_xlat0.xzw);
    u_xlat28 = (-u_xlat28) + 1.0;
    u_xlat28 = max(u_xlat28, 9.99999975e-05);
    u_xlat28 = log2(u_xlat28);
    u_xlat28 = u_xlat28 * _Fresnal_Power;
    u_xlat28 = exp2(u_xlat28);
    u_xlat28 = u_xlat28 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD3.xy * _BumpTex_ST.xy + _BumpTex_ST.zw;
    u_xlat31 = dot(vs_TEXCOORD7.xyz, vs_TEXCOORD7.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat23.x = _BumpOffsetHeight + -1.0;
    u_xlat8.xy = u_xlat16_2.xy * _MainNormalIntensity.xy;
    u_xlat8.xy = vs_TEXCOORD7.xy * vec2(u_xlat31) + u_xlat8.xy;
    u_xlat23.xy = u_xlat23.xx * u_xlat8.xy;
    u_xlat5.xy = u_xlat23.xy * vec2(0.100000001, 0.100000001) + u_xlat5.xy;
    u_xlat31 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat8.xyz = vec3(u_xlat31) * vs_TEXCOORD5.xyz;
    u_xlat31 = dot(u_xlat8.xyz, u_xlat0.xzw);
    u_xlat31 = (-u_xlat31) + 1.0;
    u_xlat31 = max(u_xlat31, 9.99999975e-05);
    u_xlat31 = log2(u_xlat31);
    u_xlat31 = u_xlat31 * _EdgePower;
    u_xlat31 = exp2(u_xlat31);
    u_xlat31 = u_xlat31 * _EdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat10_5 = texture(_BumpTex, u_xlat5.xy).x;
    u_xlat5.x = u_xlat10_5 * _BumpTexIntensity;
    u_xlat14.x = (-u_xlat31) + 1.0;
    u_xlat5.x = u_xlat14.x * u_xlat5.x;
    u_xlat14.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat14.xyz + _DarkColor.xyz;
    u_xlat8.xyz = (-u_xlat5.xyz) + _EdgeColor.xyz;
    u_xlat5.xyz = vec3(u_xlat31) * u_xlat8.xyz + u_xlat5.xyz;
    u_xlat8.xy = vs_TEXCOORD3.xy * _ElementMask_ST.xy + _ElementMask_ST.zw;
    u_xlat10_31 = texture(_ElementMask, u_xlat8.xy).x;
    u_xlat31 = u_xlat10_31 * _ElementPatternIntensity;
    u_xlat8.xyz = (-u_xlat5.xyz) + _ElementPatternColor.xyz;
    u_xlat5.xyz = vec3(u_xlat31) * u_xlat8.xyz + u_xlat5.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _NormalIntensity.xyz;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.y = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat4.z = dot(u_xlat7.xyz, u_xlat1.xyz);
    u_xlat1.x = dot((-u_xlat0.xzw), u_xlat4.xyz);
    u_xlat1.x = u_xlat1.x + u_xlat1.x;
    u_xlat0.xzw = u_xlat4.xyz * (-u_xlat1.xxx) + (-u_xlat0.xzw);
    u_xlat1.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xzw = u_xlat0.xzw * u_xlat1.xxx;
    u_xlat1.xy = vs_TEXCOORD3.xy * _CubeMaskTex_ST.xy + _CubeMaskTex_ST.zw;
    u_xlat10_0.xzw = texture(_CubeMap, u_xlat0.xzw).xyz;
    u_xlat10_1.x = texture(_CubeMaskTex, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1.x * _CubeMapIntensity;
    u_xlat0.xzw = u_xlat10_0.xzw * vec3(_CubeMapBrightness) + (-u_xlat5.xyz);
    u_xlat0.xzw = u_xlat1.xxx * u_xlat0.xzw + u_xlat5.xyz;
    u_xlat0.xzw = u_xlat0.xzw * vec3(vec3(_GlobalBightness, _GlobalBightness, _GlobalBightness));
    u_xlat1.xyz = vec3(u_xlat28) * _Highlight_Color.xyz + u_xlat0.xzw;
    u_xlat0.x = (-_CutOff) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat0.x<0.0);
#else
    u_xlatb0.x = u_xlat0.x<0.0;
#endif
    u_xlatb0.x = u_xlatb0.y && u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity));
    u_xlat27 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * vs_TEXCOORD0.xyz;
    SV_Target0.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb27 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_2.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb27) ? u_xlat16_2.x : u_xlat0.z;
    SV_Target0.w = 0.00392156886;
    u_xlat1.w = _ReceiveShadow;
    SV_Target1 = u_xlat1;
    SV_Target2.xy = u_xlat0.xy;
    SV_Target2.w = 0.223606795;
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
 Pass {
  Name "HYBRIDDEFERREDOUTLINE"
  Tags { "LIGHTMODE" = "HYBRIDDEFERREDOUTLINE" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Front
  GpuProgramID 97814
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump float _OutlineWidth;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump float _MaxOutlineZOffset;
uniform 	mediump float _Scale;
uniform 	vec3 _OutlineWidthAdjustZs;
uniform 	vec3 _OutlineWidthAdjustScales;
uniform 	float _OutlineCorrectionWidth;
uniform 	mediump float _OutlineOn;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TANGENT0;
out highp vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
bool u_xlatb5;
float u_xlat6;
vec2 u_xlat10;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_OutlineOn==0.0);
#else
    u_xlatb0 = _OutlineOn==0.0;
#endif
    if(u_xlatb0){
        gl_Position = vec4(0.0, 0.0, 0.0, 0.0);
        vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD0.xyz = vec3(0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * hlslcc_mtx4x4unity_ObjectToWorld[0].xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * hlslcc_mtx4x4unity_ObjectToWorld[0].zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_MatrixV[3].xy * hlslcc_mtx4x4unity_ObjectToWorld[0].ww + u_xlat0.xy;
    u_xlat10.xy = hlslcc_mtx4x4unity_ObjectToWorld[1].yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat10.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * hlslcc_mtx4x4unity_ObjectToWorld[1].xx + u_xlat10.xy;
    u_xlat10.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * hlslcc_mtx4x4unity_ObjectToWorld[1].zz + u_xlat10.xy;
    u_xlat10.xy = hlslcc_mtx4x4unity_MatrixV[3].xy * hlslcc_mtx4x4unity_ObjectToWorld[1].ww + u_xlat10.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * hlslcc_mtx4x4unity_ObjectToWorld[2].xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * hlslcc_mtx4x4unity_ObjectToWorld[2].zz + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[3].xy * hlslcc_mtx4x4unity_ObjectToWorld[2].ww + u_xlat1.xy;
    u_xlat2 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat2.xxx + u_xlat3.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat2.zzz + u_xlat3.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat2.www + u_xlat2.xyz;
    u_xlat10.xy = u_xlat10.xy * in_TANGENT0.yy;
    u_xlat0.xy = u_xlat0.xy * in_TANGENT0.xx + u_xlat10.xy;
    u_xlat0.xy = u_xlat1.xy * in_TANGENT0.zz + u_xlat0.xy;
    u_xlat0.z = 0.00999999978;
    u_xlat16_4.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat0.xyz * u_xlat16_4.xxx;
    u_xlat0.x = 2.41400003 / hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat5.x = u_xlat0.x * (-u_xlat2.z);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat5.x<_OutlineWidthAdjustZs.y);
#else
    u_xlatb5 = u_xlat5.x<_OutlineWidthAdjustZs.y;
#endif
    u_xlat1.xy = (bool(u_xlatb5)) ? _OutlineWidthAdjustZs.xy : _OutlineWidthAdjustZs.yz;
    u_xlat1.zw = (bool(u_xlatb5)) ? _OutlineWidthAdjustScales.xy : _OutlineWidthAdjustScales.yz;
    u_xlat0.x = (-u_xlat2.z) * u_xlat0.x + (-u_xlat1.x);
    u_xlat5.xy = vec2((-u_xlat1.x) + u_xlat1.y, (-u_xlat1.z) + u_xlat1.w);
    u_xlat5.x = max(u_xlat5.x, 0.00100000005);
    u_xlat0.x = u_xlat0.x / u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat5.y + u_xlat1.z;
    u_xlat5.x = _OutlineWidth * _OutlineCorrectionWidth;
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = u_xlat0.x * 100.0;
    u_xlat0.x = u_xlat0.x * _Scale;
    u_xlat0.x = u_xlat0.x * 0.414250195;
    u_xlat5.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * u_xlat2.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(_MaxOutlineZOffset);
    u_xlat5.xyz = u_xlat5.xyz * vec3(vec3(_Scale, _Scale, _Scale));
    u_xlat1.x = in_COLOR0.z + -0.5;
    u_xlat5.xyz = u_xlat5.xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat0.xy = u_xlat16_4.xy * u_xlat0.xx + u_xlat5.xy;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat5.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4glstate_matrix_projection[3];
    vs_TEXCOORD0.x = dot(u_xlat16_4.xyz, hlslcc_mtx4x4unity_MatrixV[0].xyz);
    vs_TEXCOORD0.y = dot(u_xlat16_4.xyz, hlslcc_mtx4x4unity_MatrixV[1].xyz);
    vs_TEXCOORD0.z = dot(u_xlat16_4.xyz, hlslcc_mtx4x4unity_MatrixV[2].xyz);
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat6 = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat6 * 0.5;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    gl_Position = u_xlat0;
    vs_COLOR0 = _OutlineColor;
    vs_TEXCOORD1.zw = u_xlat0.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _ES_CharacterAmbientLightOn;
uniform 	float _ES_CharacterAmbientBrightness;
uniform 	vec3 _ES_CharacterMainLightColor;
uniform 	vec3 _ES_CharacterAmbientLightColor;
uniform 	float _ES_CharacterMainLightRatio;
uniform 	float _ES_CharacterAmbientLightRatio;
uniform 	float _ES_CharacterPointLightWholeIntensity;
uniform 	vec4 mhy_CharacterPointLightColor;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	mediump float _DeferredLightThreshold;
uniform 	mediump float _DeferredLightScaler;
uniform 	mediump float _OutlineOn;
uniform 	float _EnableAlphaTest;
uniform 	float _CutOff;
in highp vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec2 u_xlat0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
bvec2 u_xlatb8;
float u_xlat13;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_OutlineOn==0.0);
#else
    u_xlatb0 = _OutlineOn==0.0;
#endif
    if(u_xlatb0){
        SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(_DitherAlpha<0.949999988);
#else
        u_xlatb0 = _DitherAlpha<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD1.yx / vs_TEXCOORD1.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb8.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb8.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = _DitherAlpha * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + -0.00999999978;
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat0.x<0.0);
#else
            u_xlatb0 = u_xlat0.x<0.0;
#endif
            if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
        //ENDIF
        }
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_EnableAlphaTest));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_EnableAlphaTest);
#endif
    u_xlat4.x = (-_CutOff) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4.x<0.0);
#else
    u_xlatb4 = u_xlat4.x<0.0;
#endif
    u_xlatb0 = u_xlatb0 && u_xlatb4;
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ES_CharacterAmbientLightOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ES_CharacterAmbientLightOn);
#endif
    u_xlat4.xyz = vs_COLOR0.xyz * vec3(_ES_CharacterAmbientBrightness);
    u_xlat1.xyz = vec3(vec3(_ES_CharacterPointLightWholeIntensity, _ES_CharacterPointLightWholeIntensity, _ES_CharacterPointLightWholeIntensity)) * mhy_CharacterPointLightColor.xyz;
    u_xlat2.xyz = vec3(_ES_CharacterMainLightColor.x, _ES_CharacterMainLightColor.y, _ES_CharacterMainLightColor.z);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.xyz = min(max(u_xlat2.xyz, 0.0), 1.0);
#else
    u_xlat2.xyz = clamp(u_xlat2.xyz, 0.0, 1.0);
#endif
    u_xlat13 = (-mhy_CharacterPointLightColor.w) + 1.0;
    u_xlat1.xyz = u_xlat2.xyz * vec3(u_xlat13) + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xyz = min(max(u_xlat1.xyz, 0.0), 1.0);
#else
    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat1.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = vec3(vec3(_ES_CharacterMainLightRatio, _ES_CharacterMainLightRatio, _ES_CharacterMainLightRatio)) * u_xlat1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat1.xyz;
    u_xlat1.xyz = _ES_CharacterAmbientLightColor.xyz * vec3(_ES_CharacterAmbientLightRatio);
    u_xlat16_3.xyz = u_xlat4.xyz * vec3(10.0, 10.0, 10.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat1.xyz * u_xlat16_3.xyz + u_xlat4.xyz;
    SV_Target1.xyz = (bool(u_xlatb0)) ? u_xlat4.xyz : vs_COLOR0.xyz;
    SV_Target0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_3.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_3.x : 0.0;
    SV_Target0.w = 0.0196078438;
    SV_Target1.w = _DeferredLightScaler;
    SV_Target2.xy = vec2(0.0, 0.0);
    SV_Target2.w = _DeferredLightThreshold;
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _OutlineWidth;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump float _MaxOutlineZOffset;
uniform 	mediump float _Scale;
uniform 	vec3 _OutlineWidthAdjustZs;
uniform 	vec3 _OutlineWidthAdjustScales;
uniform 	float _OutlineCorrectionWidth;
uniform 	mediump float _OutlineOn;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TANGENT0;
out highp vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
bool u_xlatb5;
float u_xlat6;
vec2 u_xlat11;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_OutlineOn==0.0);
#else
    u_xlatb0 = _OutlineOn==0.0;
#endif
    if(u_xlatb0){
        gl_Position = vec4(0.0, 0.0, 0.0, 0.0);
        vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD0.xyz = vec3(0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat5.xy = hlslcc_mtx4x4unity_MatrixV[1].xy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yy;
    u_xlat5.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xx + u_xlat5.xy;
    u_xlat5.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].zz + u_xlat5.xy;
    u_xlat5.xy = hlslcc_mtx4x4unity_MatrixV[3].xy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].ww + u_xlat5.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[1].xy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].zz + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[3].xy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].ww + u_xlat1.xy;
    u_xlat11.xy = hlslcc_mtx4x4unity_MatrixV[1].xy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yy;
    u_xlat11.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xx + u_xlat11.xy;
    u_xlat11.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].zz + u_xlat11.xy;
    u_xlat11.xy = hlslcc_mtx4x4unity_MatrixV[3].xy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].ww + u_xlat11.xy;
    u_xlat2 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat2 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat3.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat2.xxx + u_xlat3.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat2.zzz + u_xlat3.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat2.www + u_xlat2.xyz;
    u_xlat0.xw = u_xlat1.xy * in_TANGENT0.yy;
    u_xlat0.xy = u_xlat5.xy * in_TANGENT0.xx + u_xlat0.xw;
    u_xlat0.xy = u_xlat11.xy * in_TANGENT0.zz + u_xlat0.xy;
    u_xlat0.z = 0.00999999978;
    u_xlat16_4.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat0.xyz * u_xlat16_4.xxx;
    u_xlat0.x = 2.41400003 / hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat5.x = u_xlat0.x * (-u_xlat2.z);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat5.x<_OutlineWidthAdjustZs.y);
#else
    u_xlatb5 = u_xlat5.x<_OutlineWidthAdjustZs.y;
#endif
    u_xlat1.xy = (bool(u_xlatb5)) ? _OutlineWidthAdjustZs.xy : _OutlineWidthAdjustZs.yz;
    u_xlat1.zw = (bool(u_xlatb5)) ? _OutlineWidthAdjustScales.xy : _OutlineWidthAdjustScales.yz;
    u_xlat0.x = (-u_xlat2.z) * u_xlat0.x + (-u_xlat1.x);
    u_xlat5.xy = vec2((-u_xlat1.x) + u_xlat1.y, (-u_xlat1.z) + u_xlat1.w);
    u_xlat5.x = max(u_xlat5.x, 0.00100000005);
    u_xlat0.x = u_xlat0.x / u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat5.y + u_xlat1.z;
    u_xlat5.x = _OutlineWidth * _OutlineCorrectionWidth;
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = u_xlat0.x * 100.0;
    u_xlat0.x = u_xlat0.x * _Scale;
    u_xlat0.x = u_xlat0.x * 0.414250195;
    u_xlat5.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * u_xlat2.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(_MaxOutlineZOffset);
    u_xlat5.xyz = u_xlat5.xyz * vec3(vec3(_Scale, _Scale, _Scale));
    u_xlat1.x = in_COLOR0.z + -0.5;
    u_xlat5.xyz = u_xlat5.xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat0.xy = u_xlat16_4.xy * u_xlat0.xx + u_xlat5.xy;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat5.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4glstate_matrix_projection[3];
    vs_TEXCOORD0.x = dot(u_xlat16_4.xyz, hlslcc_mtx4x4unity_MatrixV[0].xyz);
    vs_TEXCOORD0.y = dot(u_xlat16_4.xyz, hlslcc_mtx4x4unity_MatrixV[1].xyz);
    vs_TEXCOORD0.z = dot(u_xlat16_4.xyz, hlslcc_mtx4x4unity_MatrixV[2].xyz);
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat6 = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat6 * 0.5;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    gl_Position = u_xlat0;
    vs_COLOR0 = _OutlineColor;
    vs_TEXCOORD1.zw = u_xlat0.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _ES_CharacterAmbientLightOn;
uniform 	float _ES_CharacterAmbientBrightness;
uniform 	vec3 _ES_CharacterMainLightColor;
uniform 	vec3 _ES_CharacterAmbientLightColor;
uniform 	float _ES_CharacterMainLightRatio;
uniform 	float _ES_CharacterAmbientLightRatio;
uniform 	float _ES_CharacterPointLightWholeIntensity;
uniform 	vec4 mhy_CharacterPointLightColor;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	mediump float _DeferredLightThreshold;
uniform 	mediump float _DeferredLightScaler;
uniform 	mediump float _OutlineOn;
uniform 	float _EnableAlphaTest;
uniform 	float _CutOff;
in highp vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec2 u_xlat0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
bvec2 u_xlatb8;
float u_xlat13;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_OutlineOn==0.0);
#else
    u_xlatb0 = _OutlineOn==0.0;
#endif
    if(u_xlatb0){
        SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(_DitherAlpha<0.949999988);
#else
        u_xlatb0 = _DitherAlpha<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD1.yx / vs_TEXCOORD1.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb8.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb8.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = _DitherAlpha * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + -0.00999999978;
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat0.x<0.0);
#else
            u_xlatb0 = u_xlat0.x<0.0;
#endif
            if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
        //ENDIF
        }
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_EnableAlphaTest));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_EnableAlphaTest);
#endif
    u_xlat4.x = (-_CutOff) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4.x<0.0);
#else
    u_xlatb4 = u_xlat4.x<0.0;
#endif
    u_xlatb0 = u_xlatb0 && u_xlatb4;
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ES_CharacterAmbientLightOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ES_CharacterAmbientLightOn);
#endif
    u_xlat4.xyz = vs_COLOR0.xyz * vec3(_ES_CharacterAmbientBrightness);
    u_xlat1.xyz = vec3(vec3(_ES_CharacterPointLightWholeIntensity, _ES_CharacterPointLightWholeIntensity, _ES_CharacterPointLightWholeIntensity)) * mhy_CharacterPointLightColor.xyz;
    u_xlat2.xyz = vec3(_ES_CharacterMainLightColor.x, _ES_CharacterMainLightColor.y, _ES_CharacterMainLightColor.z);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.xyz = min(max(u_xlat2.xyz, 0.0), 1.0);
#else
    u_xlat2.xyz = clamp(u_xlat2.xyz, 0.0, 1.0);
#endif
    u_xlat13 = (-mhy_CharacterPointLightColor.w) + 1.0;
    u_xlat1.xyz = u_xlat2.xyz * vec3(u_xlat13) + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xyz = min(max(u_xlat1.xyz, 0.0), 1.0);
#else
    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat1.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = vec3(vec3(_ES_CharacterMainLightRatio, _ES_CharacterMainLightRatio, _ES_CharacterMainLightRatio)) * u_xlat1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat1.xyz;
    u_xlat1.xyz = _ES_CharacterAmbientLightColor.xyz * vec3(_ES_CharacterAmbientLightRatio);
    u_xlat16_3.xyz = u_xlat4.xyz * vec3(10.0, 10.0, 10.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat1.xyz * u_xlat16_3.xyz + u_xlat4.xyz;
    SV_Target1.xyz = (bool(u_xlatb0)) ? u_xlat4.xyz : vs_COLOR0.xyz;
    SV_Target0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_3.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_3.x : 0.0;
    SV_Target0.w = 0.0196078438;
    SV_Target1.w = _DeferredLightScaler;
    SV_Target2.xy = vec2(0.0, 0.0);
    SV_Target2.w = _DeferredLightThreshold;
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
 Pass {
  Name "SHADOWCASTER"
  Tags { "LIGHTMODE" = "SHADOWCASTER" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 177997
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
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
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _EnableAlphaTest;
uniform 	float _CutOff;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
bool u_xlatb0;
bool u_xlatb1;
void main()
{
    u_xlat0 = (-_CutOff) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_EnableAlphaTest));
#else
    u_xlatb1 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_EnableAlphaTest);
#endif
    u_xlatb0 = u_xlatb1 && u_xlatb0;
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0 = vec4(0.0, 0.5, 0.0, 0.5);
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
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _EnableAlphaTest;
uniform 	float _CutOff;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
bool u_xlatb0;
bool u_xlatb1;
void main()
{
    u_xlat0 = (-_CutOff) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_EnableAlphaTest));
#else
    u_xlatb1 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_EnableAlphaTest);
#endif
    u_xlatb0 = u_xlatb1 && u_xlatb0;
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0 = vec4(0.0, 0.5, 0.0, 0.5);
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
 Pass {
  Name "DEPTHONLY"
  Tags { "LIGHTMODE" = "DepthOnly" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 251876
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
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
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _EnableAlphaTest;
uniform 	float _CutOff;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
bool u_xlatb0;
bool u_xlatb1;
void main()
{
    u_xlat0 = (-_CutOff) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_EnableAlphaTest));
#else
    u_xlatb1 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_EnableAlphaTest);
#endif
    u_xlatb0 = u_xlatb1 && u_xlatb0;
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0 = vec4(0.0, 0.5, 0.0, 0.5);
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
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _EnableAlphaTest;
uniform 	float _CutOff;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
bool u_xlatb0;
bool u_xlatb1;
void main()
{
    u_xlat0 = (-_CutOff) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_EnableAlphaTest));
#else
    u_xlatb1 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_EnableAlphaTest);
#endif
    u_xlatb0 = u_xlatb1 && u_xlatb0;
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0 = vec4(0.0, 0.5, 0.0, 0.5);
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
Fallback "Legacy Shaders/VertexLit"
CustomEditor "MiHoYoASEMaterialInspector"
}