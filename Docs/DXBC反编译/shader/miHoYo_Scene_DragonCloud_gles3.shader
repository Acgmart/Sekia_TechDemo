//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Scene/DragonCloud" {
Properties {
_CloudColorA ("CloudColorA", Color) = (0,0.1333333,0.2,1)
_CloudColorB ("CloudColorB", Color) = (0.8970588,0.8970588,0.8970588,1)
_CloudColorC ("CloudColorC", Color) = (0.3019608,0.372549,0.4196078,1)
_MainTex ("MainTex", 2D) = "white" { }
_MianTex_Uspeed ("MianTex_Uspeed", Float) = 0
_MainTex_Vspeed ("MainTex_Vspeed", Float) = 0
_NoiseTex ("NoiseTex", 2D) = "white" { }
_NoiseTex_Uspeed ("NoiseTex_Uspeed", Float) = 0.01
_NoiseTex_Vspeed ("NoiseTex_Vspeed", Float) = 0.03
_Noise_Scaler ("Noise_Scaler", Float) = 0.05
_CloudTex01 ("CloudTex01", 2D) = "white" { }
_CloudTex01Speed ("CloudTex01Speed", Float) = 0.2
_CloudScaler ("CloudScaler", Float) = 10
_CloudOffset ("CloudOffset", Float) = -0.01
_CloudIntensity ("CloudIntensity", Float) = 0.05
[MHYToggle] _LightningToggle ("LightningToggle", Float) = 1
_LightningTex ("LightningTex", 2D) = "white" { }
_LightningTexSpeed ("LightningTexSpeed", Float) = -0.02
_LightningBrightness ("LightningBrightness", Float) = 7
_FlashCloudTex ("FlashCloudTex", 2D) = "white" { }
_FlashColor ("FlashColor", Color) = (1,0.4338235,0.4338235,1)
_FlashBrightness ("FlashBrightness", Float) = 10
_FlashFrequency ("FlashFrequency", Float) = 1
_FlashSpeed ("FlashSpeed", Float) = 1
_Opacity ("Opacity", Range(0, 1)) = 1
[Header(Motion Vectors)] _MotionVectorsAlphaCutoff ("Motion Vectors Alpha Cutoff", Range(0, 1)) = 0.1
[Header(Cull Mode)] [Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
_MHYZBias ("Z Bias", Float) = 0
_PolygonOffsetFactor ("Polygon Offset Factor", Float) = 0
_PolygonOffsetUnit ("Polygon Offset Unit", Float) = 0
[Header(Blend Mode)] [Enum(UnityEngine.Rendering.BlendMode)] _SrcBlendMode ("Src Blend Mode", Float) = 1
[Enum(UnityEngine.Rendering.BlendMode)] _DstBlendMode ("Dst Blend Mode", Float) = 0
[Enum(UnityEngine.Rendering.BlendOp)] _BlendOP ("BlendOp Mode", Float) = 0
[Header(Depth Mode)] [Enum(Off, 0, On, 1)] _Zwrite ("ZWrite Mode", Float) = 1
[Enum(UnityEngine.Rendering.CompareFunction)] _Ztest ("ZTest Mode", Float) = 4
[Header(Fog Mode)] [Toggle(EFFECTED_BY_FOG)] _EffectedByFog ("Effected by fog", Float) = 0
}
SubShader {
 Tags { "AllowDistortionVectors" = "False" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "MAIN"
  Tags { "AllowDistortionVectors" = "False" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 4397
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
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
uniform 	mediump float _LightningToggle;
uniform 	vec4 _CloudColorA;
uniform 	vec4 _CloudColorB;
uniform 	float _MianTex_Uspeed;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTex_Vspeed;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Scaler;
uniform 	vec4 _CloudColorC;
uniform 	float _FlashFrequency;
uniform 	float _FlashSpeed;
uniform 	vec4 _FlashCloudTex_ST;
uniform 	mediump vec4 _FlashColor;
uniform 	mediump float _FlashBrightness;
uniform 	vec4 _CloudTex01_ST;
uniform 	float _CloudTex01Speed;
uniform 	float _CloudIntensity;
uniform 	float _CloudOffset;
uniform 	float _CloudScaler;
uniform 	vec4 _LightningTex_ST;
uniform 	float _LightningTexSpeed;
uniform 	mediump float _LightningBrightness;
uniform 	mediump float _Opacity;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CloudTex01;
uniform lowp sampler2D _FlashCloudTex;
uniform lowp sampler2D _LightningTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
vec3 u_xlat3;
vec2 u_xlat4;
mediump vec3 u_xlat16_4;
lowp float u_xlat10_4;
vec2 u_xlat8;
vec2 u_xlat9;
mediump float u_xlat16_9;
bool u_xlatb12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _LightningTex_ST.xy + _LightningTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_LightningTexSpeed) + u_xlat0.xy;
    u_xlat10_0 = texture(_LightningTex, u_xlat0.xy).x;
    u_xlat16_0 = u_xlat10_0 * _LightningBrightness;
    u_xlat4.xy = vs_TEXCOORD0.xy * _CloudTex01_ST.xy + _CloudTex01_ST.zw;
    u_xlat4.xy = _Time.yy * vec2(_CloudTex01Speed) + u_xlat4.xy;
    u_xlat10_4 = texture(_CloudTex01, u_xlat4.xy).x;
    u_xlat8.x = u_xlat10_4 + _CloudOffset;
    u_xlat8.x = u_xlat8.x * _CloudScaler;
    u_xlat0.x = u_xlat16_0 * u_xlat8.x;
    u_xlat0.x = u_xlat10_4 * _CloudIntensity + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.x = _Time.y * _FlashFrequency;
    u_xlat4.x = sin(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _FlashSpeed;
    u_xlat8.xy = vs_TEXCOORD0.xy * _FlashCloudTex_ST.xy + _FlashCloudTex_ST.zw;
    u_xlat4.xy = u_xlat4.xx * vec2(0.300000012, 2.0) + u_xlat8.xy;
    u_xlat10_4 = texture(_FlashCloudTex, u_xlat4.xy).x;
    u_xlat16_4.xyz = vec3(u_xlat10_4) * _FlashColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(_FlashBrightness);
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.x = _Time.y * _NoiseTex_Uspeed + u_xlat1.x;
    u_xlat2.y = _Time.y * _NoiseTex_Vspeed + u_xlat1.y;
    u_xlat10_1.xy = texture(_NoiseTex, u_xlat2.xy).xy;
    u_xlat9.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.x = _Time.y * _MianTex_Uspeed + u_xlat9.x;
    u_xlat2.y = _Time.y * _MainTex_Vspeed + u_xlat9.y;
    u_xlat1.xy = u_xlat10_1.xy * vec2(_Noise_Scaler) + u_xlat2.xy;
    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyw;
    u_xlat2.xyz = (-_CloudColorA.xyz) + _CloudColorB.xyz;
    u_xlat2.xyz = u_xlat10_1.xxx * u_xlat2.xyz + _CloudColorA.xyz;
    u_xlat3.xyz = (-u_xlat2.xyz) + _CloudColorC.xyz;
    u_xlat1.xyw = u_xlat10_1.yyy * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat16_9 = u_xlat10_1.z * _Opacity;
    SV_Target0.w = u_xlat16_9;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_4.xyz + u_xlat1.xyw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_LightningToggle==1.0);
#else
    u_xlatb12 = _LightningToggle==1.0;
#endif
    SV_Target0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyz : u_xlat1.xyw;
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
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
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
uniform 	vec4 _Time;
uniform 	mediump float _LightningToggle;
uniform 	vec4 _CloudColorA;
uniform 	vec4 _CloudColorB;
uniform 	float _MianTex_Uspeed;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTex_Vspeed;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Scaler;
uniform 	vec4 _CloudColorC;
uniform 	float _FlashFrequency;
uniform 	float _FlashSpeed;
uniform 	vec4 _FlashCloudTex_ST;
uniform 	mediump vec4 _FlashColor;
uniform 	mediump float _FlashBrightness;
uniform 	vec4 _CloudTex01_ST;
uniform 	float _CloudTex01Speed;
uniform 	float _CloudIntensity;
uniform 	float _CloudOffset;
uniform 	float _CloudScaler;
uniform 	vec4 _LightningTex_ST;
uniform 	float _LightningTexSpeed;
uniform 	mediump float _LightningBrightness;
uniform 	mediump float _Opacity;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CloudTex01;
uniform lowp sampler2D _FlashCloudTex;
uniform lowp sampler2D _LightningTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
vec3 u_xlat3;
vec2 u_xlat4;
mediump vec3 u_xlat16_4;
lowp float u_xlat10_4;
vec2 u_xlat8;
vec2 u_xlat9;
mediump float u_xlat16_9;
bool u_xlatb12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _LightningTex_ST.xy + _LightningTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_LightningTexSpeed) + u_xlat0.xy;
    u_xlat10_0 = texture(_LightningTex, u_xlat0.xy).x;
    u_xlat16_0 = u_xlat10_0 * _LightningBrightness;
    u_xlat4.xy = vs_TEXCOORD0.xy * _CloudTex01_ST.xy + _CloudTex01_ST.zw;
    u_xlat4.xy = _Time.yy * vec2(_CloudTex01Speed) + u_xlat4.xy;
    u_xlat10_4 = texture(_CloudTex01, u_xlat4.xy).x;
    u_xlat8.x = u_xlat10_4 + _CloudOffset;
    u_xlat8.x = u_xlat8.x * _CloudScaler;
    u_xlat0.x = u_xlat16_0 * u_xlat8.x;
    u_xlat0.x = u_xlat10_4 * _CloudIntensity + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.x = _Time.y * _FlashFrequency;
    u_xlat4.x = sin(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _FlashSpeed;
    u_xlat8.xy = vs_TEXCOORD0.xy * _FlashCloudTex_ST.xy + _FlashCloudTex_ST.zw;
    u_xlat4.xy = u_xlat4.xx * vec2(0.300000012, 2.0) + u_xlat8.xy;
    u_xlat10_4 = texture(_FlashCloudTex, u_xlat4.xy).x;
    u_xlat16_4.xyz = vec3(u_xlat10_4) * _FlashColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(_FlashBrightness);
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.x = _Time.y * _NoiseTex_Uspeed + u_xlat1.x;
    u_xlat2.y = _Time.y * _NoiseTex_Vspeed + u_xlat1.y;
    u_xlat10_1.xy = texture(_NoiseTex, u_xlat2.xy).xy;
    u_xlat9.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.x = _Time.y * _MianTex_Uspeed + u_xlat9.x;
    u_xlat2.y = _Time.y * _MainTex_Vspeed + u_xlat9.y;
    u_xlat1.xy = u_xlat10_1.xy * vec2(_Noise_Scaler) + u_xlat2.xy;
    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyw;
    u_xlat2.xyz = (-_CloudColorA.xyz) + _CloudColorB.xyz;
    u_xlat2.xyz = u_xlat10_1.xxx * u_xlat2.xyz + _CloudColorA.xyz;
    u_xlat3.xyz = (-u_xlat2.xyz) + _CloudColorC.xyz;
    u_xlat1.xyw = u_xlat10_1.yyy * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat16_9 = u_xlat10_1.z * _Opacity;
    SV_Target0.w = u_xlat16_9;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_4.xyz + u_xlat1.xyw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_LightningToggle==1.0);
#else
    u_xlatb12 = _LightningToggle==1.0;
#endif
    SV_Target0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyz : u_xlat1.xyw;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump float _LightningToggle;
uniform 	vec4 _CloudColorA;
uniform 	vec4 _CloudColorB;
uniform 	float _MianTex_Uspeed;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTex_Vspeed;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Scaler;
uniform 	vec4 _CloudColorC;
uniform 	float _FlashFrequency;
uniform 	float _FlashSpeed;
uniform 	vec4 _FlashCloudTex_ST;
uniform 	mediump vec4 _FlashColor;
uniform 	mediump float _FlashBrightness;
uniform 	vec4 _CloudTex01_ST;
uniform 	float _CloudTex01Speed;
uniform 	float _CloudIntensity;
uniform 	float _CloudOffset;
uniform 	float _CloudScaler;
uniform 	vec4 _LightningTex_ST;
uniform 	float _LightningTexSpeed;
uniform 	mediump float _LightningBrightness;
uniform 	mediump float _Opacity;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CloudTex01;
uniform lowp sampler2D _FlashCloudTex;
uniform lowp sampler2D _LightningTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp float u_xlat10_1;
vec3 u_xlat2;
mediump float u_xlat16_2;
lowp float u_xlat10_2;
vec2 u_xlat4;
vec2 u_xlat7;
lowp float u_xlat10_7;
float u_xlat8;
bool u_xlatb10;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = _Time.y * _MianTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _MainTex_Vspeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat2.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.y;
    u_xlat10_0.xy = texture(_NoiseTex, u_xlat2.xy).xy;
    u_xlat0.xy = u_xlat10_0.xy * vec2(_Noise_Scaler) + u_xlat1.xy;
    u_xlat10_0.xyz = texture(_MainTex, u_xlat0.xy).xyw;
    u_xlat1.xyz = (-_CloudColorA.xyz) + _CloudColorB.xyz;
    u_xlat1.xyz = u_xlat10_0.xxx * u_xlat1.xyz + _CloudColorA.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _CloudColorC.xyz;
    u_xlat0.xyw = u_xlat10_0.yyy * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.x = _Time.y * _FlashFrequency;
    u_xlat4.xy = vs_TEXCOORD0.xy * _FlashCloudTex_ST.xy + _FlashCloudTex_ST.zw;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _FlashSpeed;
    u_xlat1.xy = u_xlat1.xx * vec2(0.300000012, 2.0) + u_xlat4.xy;
    u_xlat7.xy = vs_TEXCOORD0.xy * _CloudTex01_ST.xy + _CloudTex01_ST.zw;
    u_xlat7.xy = _Time.yy * vec2(_CloudTex01Speed) + u_xlat7.xy;
    u_xlat10_7 = texture(_CloudTex01, u_xlat7.xy).x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _LightningTex_ST.xy + _LightningTex_ST.zw;
    u_xlat10_1 = texture(_FlashCloudTex, u_xlat1.xy).x;
    u_xlat16_1.xyw = vec3(u_xlat10_1) * _FlashColor.xyz;
    u_xlat16_1.xyw = u_xlat16_1.xyw * vec3(_FlashBrightness);
    u_xlat8 = u_xlat10_7 + _CloudOffset;
    u_xlat8 = u_xlat8 * _CloudScaler;
    u_xlat2.xy = _Time.yy * vec2(_LightningTexSpeed) + u_xlat2.xy;
    u_xlat10_2 = texture(_LightningTex, u_xlat2.xy).x;
    u_xlat16_2 = u_xlat10_2 * _LightningBrightness;
    u_xlat2.x = u_xlat16_2 * u_xlat8;
    u_xlat7.x = u_xlat10_7 * _CloudIntensity + u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat7.xxx * u_xlat16_1.xyw + u_xlat0.xyw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_LightningToggle==1.0);
#else
    u_xlatb10 = _LightningToggle==1.0;
#endif
    SV_Target0.xyz = (bool(u_xlatb10)) ? u_xlat1.xyz : u_xlat0.xyw;
    u_xlat16_0 = u_xlat10_0.z * _Opacity;
    SV_Target0.w = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
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
uniform 	vec4 _Time;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump float _LightningToggle;
uniform 	vec4 _CloudColorA;
uniform 	vec4 _CloudColorB;
uniform 	float _MianTex_Uspeed;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTex_Vspeed;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Scaler;
uniform 	vec4 _CloudColorC;
uniform 	float _FlashFrequency;
uniform 	float _FlashSpeed;
uniform 	vec4 _FlashCloudTex_ST;
uniform 	mediump vec4 _FlashColor;
uniform 	mediump float _FlashBrightness;
uniform 	vec4 _CloudTex01_ST;
uniform 	float _CloudTex01Speed;
uniform 	float _CloudIntensity;
uniform 	float _CloudOffset;
uniform 	float _CloudScaler;
uniform 	vec4 _LightningTex_ST;
uniform 	float _LightningTexSpeed;
uniform 	mediump float _LightningBrightness;
uniform 	mediump float _Opacity;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CloudTex01;
uniform lowp sampler2D _FlashCloudTex;
uniform lowp sampler2D _LightningTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp float u_xlat10_1;
vec3 u_xlat2;
mediump float u_xlat16_2;
lowp float u_xlat10_2;
vec2 u_xlat4;
vec2 u_xlat7;
lowp float u_xlat10_7;
float u_xlat8;
bool u_xlatb10;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = _Time.y * _MianTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _MainTex_Vspeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat2.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.y;
    u_xlat10_0.xy = texture(_NoiseTex, u_xlat2.xy).xy;
    u_xlat0.xy = u_xlat10_0.xy * vec2(_Noise_Scaler) + u_xlat1.xy;
    u_xlat10_0.xyz = texture(_MainTex, u_xlat0.xy).xyw;
    u_xlat1.xyz = (-_CloudColorA.xyz) + _CloudColorB.xyz;
    u_xlat1.xyz = u_xlat10_0.xxx * u_xlat1.xyz + _CloudColorA.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _CloudColorC.xyz;
    u_xlat0.xyw = u_xlat10_0.yyy * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.x = _Time.y * _FlashFrequency;
    u_xlat4.xy = vs_TEXCOORD0.xy * _FlashCloudTex_ST.xy + _FlashCloudTex_ST.zw;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _FlashSpeed;
    u_xlat1.xy = u_xlat1.xx * vec2(0.300000012, 2.0) + u_xlat4.xy;
    u_xlat7.xy = vs_TEXCOORD0.xy * _CloudTex01_ST.xy + _CloudTex01_ST.zw;
    u_xlat7.xy = _Time.yy * vec2(_CloudTex01Speed) + u_xlat7.xy;
    u_xlat10_7 = texture(_CloudTex01, u_xlat7.xy).x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _LightningTex_ST.xy + _LightningTex_ST.zw;
    u_xlat10_1 = texture(_FlashCloudTex, u_xlat1.xy).x;
    u_xlat16_1.xyw = vec3(u_xlat10_1) * _FlashColor.xyz;
    u_xlat16_1.xyw = u_xlat16_1.xyw * vec3(_FlashBrightness);
    u_xlat8 = u_xlat10_7 + _CloudOffset;
    u_xlat8 = u_xlat8 * _CloudScaler;
    u_xlat2.xy = _Time.yy * vec2(_LightningTexSpeed) + u_xlat2.xy;
    u_xlat10_2 = texture(_LightningTex, u_xlat2.xy).x;
    u_xlat16_2 = u_xlat10_2 * _LightningBrightness;
    u_xlat2.x = u_xlat16_2 * u_xlat8;
    u_xlat7.x = u_xlat10_7 * _CloudIntensity + u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat7.xxx * u_xlat16_1.xyw + u_xlat0.xyw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_LightningToggle==1.0);
#else
    u_xlatb10 = _LightningToggle==1.0;
#endif
    SV_Target0.xyz = (bool(u_xlatb10)) ? u_xlat1.xyz : u_xlat0.xyw;
    u_xlat16_0 = u_xlat10_0.z * _Opacity;
    SV_Target0.w = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump float _LightningToggle;
uniform 	vec4 _CloudColorA;
uniform 	vec4 _CloudColorB;
uniform 	float _MianTex_Uspeed;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTex_Vspeed;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Scaler;
uniform 	vec4 _CloudColorC;
uniform 	float _FlashFrequency;
uniform 	float _FlashSpeed;
uniform 	vec4 _FlashCloudTex_ST;
uniform 	mediump vec4 _FlashColor;
uniform 	mediump float _FlashBrightness;
uniform 	vec4 _CloudTex01_ST;
uniform 	float _CloudTex01Speed;
uniform 	float _CloudIntensity;
uniform 	float _CloudOffset;
uniform 	float _CloudScaler;
uniform 	vec4 _LightningTex_ST;
uniform 	float _LightningTexSpeed;
uniform 	mediump float _LightningBrightness;
uniform 	mediump float _Opacity;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CloudTex01;
uniform lowp sampler2D _FlashCloudTex;
uniform lowp sampler2D _LightningTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
vec3 u_xlat3;
vec2 u_xlat4;
mediump vec3 u_xlat16_4;
lowp float u_xlat10_4;
vec2 u_xlat8;
vec2 u_xlat9;
mediump float u_xlat16_9;
bool u_xlatb12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _LightningTex_ST.xy + _LightningTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_LightningTexSpeed) + u_xlat0.xy;
    u_xlat10_0 = texture(_LightningTex, u_xlat0.xy).x;
    u_xlat16_0 = u_xlat10_0 * _LightningBrightness;
    u_xlat4.xy = vs_TEXCOORD0.xy * _CloudTex01_ST.xy + _CloudTex01_ST.zw;
    u_xlat4.xy = _Time.yy * vec2(_CloudTex01Speed) + u_xlat4.xy;
    u_xlat10_4 = texture(_CloudTex01, u_xlat4.xy).x;
    u_xlat8.x = u_xlat10_4 + _CloudOffset;
    u_xlat8.x = u_xlat8.x * _CloudScaler;
    u_xlat0.x = u_xlat16_0 * u_xlat8.x;
    u_xlat0.x = u_xlat10_4 * _CloudIntensity + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.x = _Time.y * _FlashFrequency;
    u_xlat4.x = sin(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _FlashSpeed;
    u_xlat8.xy = vs_TEXCOORD0.xy * _FlashCloudTex_ST.xy + _FlashCloudTex_ST.zw;
    u_xlat4.xy = u_xlat4.xx * vec2(0.300000012, 2.0) + u_xlat8.xy;
    u_xlat10_4 = texture(_FlashCloudTex, u_xlat4.xy).x;
    u_xlat16_4.xyz = vec3(u_xlat10_4) * _FlashColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(_FlashBrightness);
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.x = _Time.y * _NoiseTex_Uspeed + u_xlat1.x;
    u_xlat2.y = _Time.y * _NoiseTex_Vspeed + u_xlat1.y;
    u_xlat10_1.xy = texture(_NoiseTex, u_xlat2.xy).xy;
    u_xlat9.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.x = _Time.y * _MianTex_Uspeed + u_xlat9.x;
    u_xlat2.y = _Time.y * _MainTex_Vspeed + u_xlat9.y;
    u_xlat1.xy = u_xlat10_1.xy * vec2(_Noise_Scaler) + u_xlat2.xy;
    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyw;
    u_xlat2.xyz = (-_CloudColorA.xyz) + _CloudColorB.xyz;
    u_xlat2.xyz = u_xlat10_1.xxx * u_xlat2.xyz + _CloudColorA.xyz;
    u_xlat3.xyz = (-u_xlat2.xyz) + _CloudColorC.xyz;
    u_xlat1.xyw = u_xlat10_1.yyy * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat16_9 = u_xlat10_1.z * _Opacity;
    SV_Target0.w = u_xlat16_9;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_4.xyz + u_xlat1.xyw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_LightningToggle==1.0);
#else
    u_xlatb12 = _LightningToggle==1.0;
#endif
    SV_Target0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyz : u_xlat1.xyw;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
flat out highp uint vs_SV_InstanceID0;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _Time;
uniform 	mediump float _LightningToggle;
uniform 	vec4 _CloudColorA;
uniform 	vec4 _CloudColorB;
uniform 	float _MianTex_Uspeed;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTex_Vspeed;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Scaler;
uniform 	vec4 _CloudColorC;
uniform 	float _FlashFrequency;
uniform 	float _FlashSpeed;
uniform 	vec4 _FlashCloudTex_ST;
uniform 	mediump vec4 _FlashColor;
uniform 	mediump float _FlashBrightness;
uniform 	vec4 _CloudTex01_ST;
uniform 	float _CloudTex01Speed;
uniform 	float _CloudIntensity;
uniform 	float _CloudOffset;
uniform 	float _CloudScaler;
uniform 	vec4 _LightningTex_ST;
uniform 	float _LightningTexSpeed;
uniform 	mediump float _LightningBrightness;
uniform 	mediump float _Opacity;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CloudTex01;
uniform lowp sampler2D _FlashCloudTex;
uniform lowp sampler2D _LightningTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
vec3 u_xlat3;
vec2 u_xlat4;
mediump vec3 u_xlat16_4;
lowp float u_xlat10_4;
vec2 u_xlat8;
vec2 u_xlat9;
mediump float u_xlat16_9;
bool u_xlatb12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _LightningTex_ST.xy + _LightningTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_LightningTexSpeed) + u_xlat0.xy;
    u_xlat10_0 = texture(_LightningTex, u_xlat0.xy).x;
    u_xlat16_0 = u_xlat10_0 * _LightningBrightness;
    u_xlat4.xy = vs_TEXCOORD0.xy * _CloudTex01_ST.xy + _CloudTex01_ST.zw;
    u_xlat4.xy = _Time.yy * vec2(_CloudTex01Speed) + u_xlat4.xy;
    u_xlat10_4 = texture(_CloudTex01, u_xlat4.xy).x;
    u_xlat8.x = u_xlat10_4 + _CloudOffset;
    u_xlat8.x = u_xlat8.x * _CloudScaler;
    u_xlat0.x = u_xlat16_0 * u_xlat8.x;
    u_xlat0.x = u_xlat10_4 * _CloudIntensity + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.x = _Time.y * _FlashFrequency;
    u_xlat4.x = sin(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _FlashSpeed;
    u_xlat8.xy = vs_TEXCOORD0.xy * _FlashCloudTex_ST.xy + _FlashCloudTex_ST.zw;
    u_xlat4.xy = u_xlat4.xx * vec2(0.300000012, 2.0) + u_xlat8.xy;
    u_xlat10_4 = texture(_FlashCloudTex, u_xlat4.xy).x;
    u_xlat16_4.xyz = vec3(u_xlat10_4) * _FlashColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(_FlashBrightness);
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.x = _Time.y * _NoiseTex_Uspeed + u_xlat1.x;
    u_xlat2.y = _Time.y * _NoiseTex_Vspeed + u_xlat1.y;
    u_xlat10_1.xy = texture(_NoiseTex, u_xlat2.xy).xy;
    u_xlat9.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.x = _Time.y * _MianTex_Uspeed + u_xlat9.x;
    u_xlat2.y = _Time.y * _MainTex_Vspeed + u_xlat9.y;
    u_xlat1.xy = u_xlat10_1.xy * vec2(_Noise_Scaler) + u_xlat2.xy;
    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyw;
    u_xlat2.xyz = (-_CloudColorA.xyz) + _CloudColorB.xyz;
    u_xlat2.xyz = u_xlat10_1.xxx * u_xlat2.xyz + _CloudColorA.xyz;
    u_xlat3.xyz = (-u_xlat2.xyz) + _CloudColorC.xyz;
    u_xlat1.xyw = u_xlat10_1.yyy * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat16_9 = u_xlat10_1.z * _Opacity;
    SV_Target0.w = u_xlat16_9;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_4.xyz + u_xlat1.xyw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_LightningToggle==1.0);
#else
    u_xlatb12 = _LightningToggle==1.0;
#endif
    SV_Target0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyz : u_xlat1.xyw;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump float _LightningToggle;
uniform 	vec4 _CloudColorA;
uniform 	vec4 _CloudColorB;
uniform 	float _MianTex_Uspeed;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTex_Vspeed;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Scaler;
uniform 	vec4 _CloudColorC;
uniform 	float _FlashFrequency;
uniform 	float _FlashSpeed;
uniform 	vec4 _FlashCloudTex_ST;
uniform 	mediump vec4 _FlashColor;
uniform 	mediump float _FlashBrightness;
uniform 	vec4 _CloudTex01_ST;
uniform 	float _CloudTex01Speed;
uniform 	float _CloudIntensity;
uniform 	float _CloudOffset;
uniform 	float _CloudScaler;
uniform 	vec4 _LightningTex_ST;
uniform 	float _LightningTexSpeed;
uniform 	mediump float _LightningBrightness;
uniform 	mediump float _Opacity;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CloudTex01;
uniform lowp sampler2D _FlashCloudTex;
uniform lowp sampler2D _LightningTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp float u_xlat10_1;
vec3 u_xlat2;
mediump float u_xlat16_2;
lowp float u_xlat10_2;
vec2 u_xlat4;
vec2 u_xlat7;
lowp float u_xlat10_7;
float u_xlat8;
bool u_xlatb10;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = _Time.y * _MianTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _MainTex_Vspeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat2.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.y;
    u_xlat10_0.xy = texture(_NoiseTex, u_xlat2.xy).xy;
    u_xlat0.xy = u_xlat10_0.xy * vec2(_Noise_Scaler) + u_xlat1.xy;
    u_xlat10_0.xyz = texture(_MainTex, u_xlat0.xy).xyw;
    u_xlat1.xyz = (-_CloudColorA.xyz) + _CloudColorB.xyz;
    u_xlat1.xyz = u_xlat10_0.xxx * u_xlat1.xyz + _CloudColorA.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _CloudColorC.xyz;
    u_xlat0.xyw = u_xlat10_0.yyy * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.x = _Time.y * _FlashFrequency;
    u_xlat4.xy = vs_TEXCOORD0.xy * _FlashCloudTex_ST.xy + _FlashCloudTex_ST.zw;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _FlashSpeed;
    u_xlat1.xy = u_xlat1.xx * vec2(0.300000012, 2.0) + u_xlat4.xy;
    u_xlat7.xy = vs_TEXCOORD0.xy * _CloudTex01_ST.xy + _CloudTex01_ST.zw;
    u_xlat7.xy = _Time.yy * vec2(_CloudTex01Speed) + u_xlat7.xy;
    u_xlat10_7 = texture(_CloudTex01, u_xlat7.xy).x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _LightningTex_ST.xy + _LightningTex_ST.zw;
    u_xlat10_1 = texture(_FlashCloudTex, u_xlat1.xy).x;
    u_xlat16_1.xyw = vec3(u_xlat10_1) * _FlashColor.xyz;
    u_xlat16_1.xyw = u_xlat16_1.xyw * vec3(_FlashBrightness);
    u_xlat8 = u_xlat10_7 + _CloudOffset;
    u_xlat8 = u_xlat8 * _CloudScaler;
    u_xlat2.xy = _Time.yy * vec2(_LightningTexSpeed) + u_xlat2.xy;
    u_xlat10_2 = texture(_LightningTex, u_xlat2.xy).x;
    u_xlat16_2 = u_xlat10_2 * _LightningBrightness;
    u_xlat2.x = u_xlat16_2 * u_xlat8;
    u_xlat7.x = u_xlat10_7 * _CloudIntensity + u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat7.xxx * u_xlat16_1.xyw + u_xlat0.xyw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_LightningToggle==1.0);
#else
    u_xlatb10 = _LightningToggle==1.0;
#endif
    SV_Target0.xyz = (bool(u_xlatb10)) ? u_xlat1.xyz : u_xlat0.xyw;
    u_xlat16_0 = u_xlat10_0.z * _Opacity;
    SV_Target0.w = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
flat out highp uint vs_SV_InstanceID0;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _Time;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump float _LightningToggle;
uniform 	vec4 _CloudColorA;
uniform 	vec4 _CloudColorB;
uniform 	float _MianTex_Uspeed;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTex_Vspeed;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Scaler;
uniform 	vec4 _CloudColorC;
uniform 	float _FlashFrequency;
uniform 	float _FlashSpeed;
uniform 	vec4 _FlashCloudTex_ST;
uniform 	mediump vec4 _FlashColor;
uniform 	mediump float _FlashBrightness;
uniform 	vec4 _CloudTex01_ST;
uniform 	float _CloudTex01Speed;
uniform 	float _CloudIntensity;
uniform 	float _CloudOffset;
uniform 	float _CloudScaler;
uniform 	vec4 _LightningTex_ST;
uniform 	float _LightningTexSpeed;
uniform 	mediump float _LightningBrightness;
uniform 	mediump float _Opacity;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CloudTex01;
uniform lowp sampler2D _FlashCloudTex;
uniform lowp sampler2D _LightningTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp float u_xlat10_1;
vec3 u_xlat2;
mediump float u_xlat16_2;
lowp float u_xlat10_2;
vec2 u_xlat4;
vec2 u_xlat7;
lowp float u_xlat10_7;
float u_xlat8;
bool u_xlatb10;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = _Time.y * _MianTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _MainTex_Vspeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat2.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.y;
    u_xlat10_0.xy = texture(_NoiseTex, u_xlat2.xy).xy;
    u_xlat0.xy = u_xlat10_0.xy * vec2(_Noise_Scaler) + u_xlat1.xy;
    u_xlat10_0.xyz = texture(_MainTex, u_xlat0.xy).xyw;
    u_xlat1.xyz = (-_CloudColorA.xyz) + _CloudColorB.xyz;
    u_xlat1.xyz = u_xlat10_0.xxx * u_xlat1.xyz + _CloudColorA.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _CloudColorC.xyz;
    u_xlat0.xyw = u_xlat10_0.yyy * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.x = _Time.y * _FlashFrequency;
    u_xlat4.xy = vs_TEXCOORD0.xy * _FlashCloudTex_ST.xy + _FlashCloudTex_ST.zw;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _FlashSpeed;
    u_xlat1.xy = u_xlat1.xx * vec2(0.300000012, 2.0) + u_xlat4.xy;
    u_xlat7.xy = vs_TEXCOORD0.xy * _CloudTex01_ST.xy + _CloudTex01_ST.zw;
    u_xlat7.xy = _Time.yy * vec2(_CloudTex01Speed) + u_xlat7.xy;
    u_xlat10_7 = texture(_CloudTex01, u_xlat7.xy).x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _LightningTex_ST.xy + _LightningTex_ST.zw;
    u_xlat10_1 = texture(_FlashCloudTex, u_xlat1.xy).x;
    u_xlat16_1.xyw = vec3(u_xlat10_1) * _FlashColor.xyz;
    u_xlat16_1.xyw = u_xlat16_1.xyw * vec3(_FlashBrightness);
    u_xlat8 = u_xlat10_7 + _CloudOffset;
    u_xlat8 = u_xlat8 * _CloudScaler;
    u_xlat2.xy = _Time.yy * vec2(_LightningTexSpeed) + u_xlat2.xy;
    u_xlat10_2 = texture(_LightningTex, u_xlat2.xy).x;
    u_xlat16_2 = u_xlat10_2 * _LightningBrightness;
    u_xlat2.x = u_xlat16_2 * u_xlat8;
    u_xlat7.x = u_xlat10_7 * _CloudIntensity + u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat7.xxx * u_xlat16_1.xyw + u_xlat0.xyw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_LightningToggle==1.0);
#else
    u_xlatb10 = _LightningToggle==1.0;
#endif
    SV_Target0.xyz = (bool(u_xlatb10)) ? u_xlat1.xyz : u_xlat0.xyw;
    u_xlat16_0 = u_xlat10_0.z * _Opacity;
    SV_Target0.w = u_xlat16_0;
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
Keywords { "UNITY_DEBUG_VIEW_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" }
""
}
}
}
 Pass {
  Name "DISTORTIONVECTORS"
  Tags { "AllowDistortionVectors" = "False" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "DISTORTIONVECTORS" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 114055
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.497999996, 0.497999996, 0.0, 1.0);
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
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
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
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.497999996, 0.497999996, 0.0, 1.0);
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
  Name "MOTIONVECTORS"
  Tags { "AllowDistortionVectors" = "False" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "MOTIONVECTORS" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 180262
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = u_xlat0.x * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat0 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat1.zzzz + u_xlat0;
    vs_TEXCOORD3 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat0 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat1.zzzz + u_xlat0;
    vs_TEXCOORD4 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat1.wwww + u_xlat0;
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
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	float _MianTex_Uspeed;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTex_Vspeed;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Scaler;
uniform 	mediump float _Opacity;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec2 u_xlat1;
ivec2 u_xlati1;
mediump float u_xlat16_2;
vec2 u_xlat6;
ivec2 u_xlati6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.y;
    u_xlat10_0.xy = texture(_NoiseTex, u_xlat1.xy).xy;
    u_xlat6.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = _Time.y * _MianTex_Uspeed + u_xlat6.x;
    u_xlat1.y = _Time.y * _MainTex_Vspeed + u_xlat6.y;
    u_xlat0.xy = u_xlat10_0.xy * vec2(_Noise_Scaler) + u_xlat1.xy;
    u_xlat10_0.x = texture(_MainTex, u_xlat0.xy).w;
    u_xlat16_2 = u_xlat10_0.x * _Opacity + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_2<0.0);
#else
    u_xlatb0 = u_xlat16_2<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat6.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat6.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati6.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati1.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati6.xy = (-u_xlati6.xy) + u_xlati1.xy;
    u_xlat6.xy = vec2(u_xlati6.xy);
    u_xlat0.xy = u_xlat6.xy * u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.498039216, 0.498039216);
    SV_Target0.xy = u_xlat0.xy;
    SV_Target0.zw = vec2(0.0, 1.0);
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
uniform 	mediump float _MHYZBias;
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
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
int u_xlati3;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlati3 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati3 = u_xlati3 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = u_xlat0.x * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat0 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat1.zzzz + u_xlat0;
    vs_TEXCOORD3 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat0 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat1.zzzz + u_xlat0;
    vs_TEXCOORD4 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat1.wwww + u_xlat0;
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
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	float _MianTex_Uspeed;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTex_Vspeed;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Scaler;
uniform 	mediump float _Opacity;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec2 u_xlat1;
ivec2 u_xlati1;
mediump float u_xlat16_2;
vec2 u_xlat6;
ivec2 u_xlati6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.y;
    u_xlat10_0.xy = texture(_NoiseTex, u_xlat1.xy).xy;
    u_xlat6.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = _Time.y * _MianTex_Uspeed + u_xlat6.x;
    u_xlat1.y = _Time.y * _MainTex_Vspeed + u_xlat6.y;
    u_xlat0.xy = u_xlat10_0.xy * vec2(_Noise_Scaler) + u_xlat1.xy;
    u_xlat10_0.x = texture(_MainTex, u_xlat0.xy).w;
    u_xlat16_2 = u_xlat10_0.x * _Opacity + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_2<0.0);
#else
    u_xlatb0 = u_xlat16_2<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat6.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat6.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati6.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati1.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati6.xy = (-u_xlati6.xy) + u_xlati1.xy;
    u_xlat6.xy = vec2(u_xlati6.xy);
    u_xlat0.xy = u_xlat6.xy * u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.498039216, 0.498039216);
    SV_Target0.xy = u_xlat0.xy;
    SV_Target0.zw = vec2(0.0, 1.0);
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
CustomEditor "MiHoYoASEMaterialInspector"
}