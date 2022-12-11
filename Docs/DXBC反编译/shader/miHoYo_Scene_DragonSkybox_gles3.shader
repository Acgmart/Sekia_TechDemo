//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Scene/DragonSkybox" {
Properties {
_CloudColorA ("CloudColorA", Color) = (0,0.1333333,0.2,1)
_CloudColorB ("CloudColorB", Color) = (0.8970588,0.8970588,0.8970588,1)
_MainTex ("MainTex", 2D) = "white" { }
_MianTex_Uspeed ("MianTex_Uspeed", Float) = 0
_MainTex_Vspeed ("MainTex_Vspeed", Float) = 0
[MHYToggle] _UseTwoCloudTex ("UseTwoCloudTex", Float) = 1
_SecTex ("SecTex", 2D) = "black" { }
_SecTexUspeed ("SecTexUspeed", Float) = 0
_SecTexVspeed ("SecTexVspeed", Float) = 0
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
[Header(Cull Mode)] [Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
_MHYZBias ("Z Bias", Float) = 0
_PolygonOffsetUnit ("Polygon Offset Unit", Float) = 0
_PolygonOffsetFactor ("Polygon Offset Factor", Float) = 0
[Header(Blend Mode)] [Enum(UnityEngine.Rendering.BlendMode)] _SrcBlendMode ("Src Blend Mode", Float) = 1
[Enum(UnityEngine.Rendering.BlendMode)] _DstBlendMode ("Dst Blend Mode", Float) = 0
[Enum(UnityEngine.Rendering.BlendOp)] _BlendOP ("BlendOp Mode", Float) = 0
[Header(Depth Mode)] [Enum(Off, 0, On, 1)] _Zwrite ("ZWrite Mode", Float) = 1
[Enum(UnityEngine.Rendering.CompareFunction)] _Ztest ("ZTest Mode", Float) = 4
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "FORWARD"
  Tags { "DebugView" = "On" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 15440
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
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
    u_xlat0.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position = u_xlat0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1 = vec4(u_xlat10) * u_xlat1.xyzz;
    u_xlat16_2.x = u_xlat1.y * u_xlat1.y;
    u_xlat16_2.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_2.x);
    u_xlat16_3 = u_xlat1.yzwx * u_xlat1.xywz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_3);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_3);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_3);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_4.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_2.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat5 = u_xlat0.y * _ProjectionParams.x;
    u_xlat0.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.w = u_xlat5 * 0.5;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    vs_TEXCOORD4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
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
uniform 	float _MianTex_Uspeed;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTex_Vspeed;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Scaler;
uniform 	mediump float _Opacity;
uniform 	mediump float _LightningToggle;
uniform 	vec4 _CloudColorA;
uniform 	vec4 _CloudColorB;
uniform 	mediump float _UseTwoCloudTex;
uniform 	float _SecTexUspeed;
uniform 	vec4 _SecTex_ST;
uniform 	float _SecTexVspeed;
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
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SecTex;
uniform lowp sampler2D _CloudTex01;
uniform lowp sampler2D _FlashCloudTex;
uniform lowp sampler2D _LightningTex;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp vec2 u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
bool u_xlatb1;
vec3 u_xlat2;
lowp float u_xlat10_2;
mediump vec2 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_7;
lowp vec2 u_xlat10_10;
vec2 u_xlat12;
float u_xlat16;
lowp float u_xlat10_16;
bool u_xlatb16;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = _Time.y * _MianTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _MainTex_Vspeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD3.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat2.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.y;
    u_xlat10_0.xy = texture(_NoiseTex, u_xlat2.xy).xy;
    u_xlat16_3.xy = u_xlat10_0.xy * vec2(_Noise_Scaler) + u_xlat1.xy;
    u_xlat10_10.xy = texture(_MainTex, u_xlat16_3.xy).xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UseTwoCloudTex==1.0);
#else
    u_xlatb1 = _UseTwoCloudTex==1.0;
#endif
    if(u_xlatb1){
        u_xlat1.xy = vs_TEXCOORD3.xy * _SecTex_ST.xy + _SecTex_ST.zw;
        u_xlat2.x = _Time.y * _SecTexUspeed + u_xlat1.x;
        u_xlat2.y = _Time.y * _SecTexVspeed + u_xlat1.y;
        u_xlat16_3.xy = u_xlat10_0.xy * vec2(_Noise_Scaler) + u_xlat2.xy;
        u_xlat10_0.x = texture(_SecTex, u_xlat16_3.xy).x;
        u_xlat16_0 = u_xlat10_10.x + u_xlat10_0.x;
        u_xlat16_0 = u_xlat16_0;
    } else {
        u_xlat16_0 = u_xlat10_10.x;
    //ENDIF
    }
    u_xlat1.xyz = (-_CloudColorA.xyz) + _CloudColorB.xyz;
    u_xlat1.xyz = vec3(u_xlat16_0) * u_xlat1.xyz + _CloudColorA.xyz;
    u_xlat16 = _Time.y * _FlashFrequency;
    u_xlat2.xy = vs_TEXCOORD3.xy * _FlashCloudTex_ST.xy + _FlashCloudTex_ST.zw;
    u_xlat16 = sin(u_xlat16);
    u_xlat16 = u_xlat16 * _FlashSpeed;
    u_xlat2.xy = vec2(u_xlat16) * vec2(0.300000012, 2.0) + u_xlat2.xy;
    u_xlat12.xy = vs_TEXCOORD3.xy * _CloudTex01_ST.xy + _CloudTex01_ST.zw;
    u_xlat12.xy = _Time.yy * vec2(_CloudTex01Speed) + u_xlat12.xy;
    u_xlat10_16 = texture(_CloudTex01, u_xlat12.xy).x;
    u_xlat12.xy = vs_TEXCOORD3.xy * _LightningTex_ST.xy + _LightningTex_ST.zw;
    u_xlat10_2 = texture(_FlashCloudTex, u_xlat2.xy).x;
    u_xlat16_4.xyz = vec3(u_xlat10_2) * _FlashColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(_FlashBrightness);
    u_xlat2.x = u_xlat10_16 + _CloudOffset;
    u_xlat2.x = u_xlat2.x * _CloudScaler;
    u_xlat7.xy = _Time.yy * vec2(_LightningTexSpeed) + u_xlat12.xy;
    u_xlat10_7 = texture(_LightningTex, u_xlat7.xy).x;
    u_xlat16_7 = u_xlat10_7 * _LightningBrightness;
    u_xlat2.x = u_xlat16_7 * u_xlat2.x;
    u_xlat16 = u_xlat10_16 * _CloudIntensity + u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat16_4.xyz + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(_LightningToggle==1.0);
#else
    u_xlatb16 = _LightningToggle==1.0;
#endif
    SV_Target0.xyz = (bool(u_xlatb16)) ? u_xlat2.xyz : u_xlat1.xyz;
    u_xlat16_1 = u_xlat10_10.y * _Opacity;
    SV_Target0.w = u_xlat16_1;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
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
    u_xlat1.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat2 = u_xlat6.xxxx * u_xlat2.xyzz;
    u_xlat16_3.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_3.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_3.x);
    u_xlat16_4 = u_xlat2.yzwx * u_xlat2.xywz;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_5.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat6.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat1.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.w = u_xlat6.x * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat6.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat6.xyz;
    vs_TEXCOORD4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat6.xyz;
    vs_TEXCOORD4.w = 0.0;
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
uniform 	float _MianTex_Uspeed;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTex_Vspeed;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Scaler;
uniform 	mediump float _Opacity;
uniform 	mediump float _LightningToggle;
uniform 	vec4 _CloudColorA;
uniform 	vec4 _CloudColorB;
uniform 	mediump float _UseTwoCloudTex;
uniform 	float _SecTexUspeed;
uniform 	vec4 _SecTex_ST;
uniform 	float _SecTexVspeed;
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
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SecTex;
uniform lowp sampler2D _CloudTex01;
uniform lowp sampler2D _FlashCloudTex;
uniform lowp sampler2D _LightningTex;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp vec2 u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
bool u_xlatb1;
vec3 u_xlat2;
lowp float u_xlat10_2;
mediump vec2 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_7;
lowp vec2 u_xlat10_10;
vec2 u_xlat12;
float u_xlat16;
lowp float u_xlat10_16;
bool u_xlatb16;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = _Time.y * _MianTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _MainTex_Vspeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD3.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat2.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.y;
    u_xlat10_0.xy = texture(_NoiseTex, u_xlat2.xy).xy;
    u_xlat16_3.xy = u_xlat10_0.xy * vec2(_Noise_Scaler) + u_xlat1.xy;
    u_xlat10_10.xy = texture(_MainTex, u_xlat16_3.xy).xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UseTwoCloudTex==1.0);
#else
    u_xlatb1 = _UseTwoCloudTex==1.0;
#endif
    if(u_xlatb1){
        u_xlat1.xy = vs_TEXCOORD3.xy * _SecTex_ST.xy + _SecTex_ST.zw;
        u_xlat2.x = _Time.y * _SecTexUspeed + u_xlat1.x;
        u_xlat2.y = _Time.y * _SecTexVspeed + u_xlat1.y;
        u_xlat16_3.xy = u_xlat10_0.xy * vec2(_Noise_Scaler) + u_xlat2.xy;
        u_xlat10_0.x = texture(_SecTex, u_xlat16_3.xy).x;
        u_xlat16_0 = u_xlat10_10.x + u_xlat10_0.x;
        u_xlat16_0 = u_xlat16_0;
    } else {
        u_xlat16_0 = u_xlat10_10.x;
    //ENDIF
    }
    u_xlat1.xyz = (-_CloudColorA.xyz) + _CloudColorB.xyz;
    u_xlat1.xyz = vec3(u_xlat16_0) * u_xlat1.xyz + _CloudColorA.xyz;
    u_xlat16 = _Time.y * _FlashFrequency;
    u_xlat2.xy = vs_TEXCOORD3.xy * _FlashCloudTex_ST.xy + _FlashCloudTex_ST.zw;
    u_xlat16 = sin(u_xlat16);
    u_xlat16 = u_xlat16 * _FlashSpeed;
    u_xlat2.xy = vec2(u_xlat16) * vec2(0.300000012, 2.0) + u_xlat2.xy;
    u_xlat12.xy = vs_TEXCOORD3.xy * _CloudTex01_ST.xy + _CloudTex01_ST.zw;
    u_xlat12.xy = _Time.yy * vec2(_CloudTex01Speed) + u_xlat12.xy;
    u_xlat10_16 = texture(_CloudTex01, u_xlat12.xy).x;
    u_xlat12.xy = vs_TEXCOORD3.xy * _LightningTex_ST.xy + _LightningTex_ST.zw;
    u_xlat10_2 = texture(_FlashCloudTex, u_xlat2.xy).x;
    u_xlat16_4.xyz = vec3(u_xlat10_2) * _FlashColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(_FlashBrightness);
    u_xlat2.x = u_xlat10_16 + _CloudOffset;
    u_xlat2.x = u_xlat2.x * _CloudScaler;
    u_xlat7.xy = _Time.yy * vec2(_LightningTexSpeed) + u_xlat12.xy;
    u_xlat10_7 = texture(_LightningTex, u_xlat7.xy).x;
    u_xlat16_7 = u_xlat10_7 * _LightningBrightness;
    u_xlat2.x = u_xlat16_7 * u_xlat2.x;
    u_xlat16 = u_xlat10_16 * _CloudIntensity + u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat16_4.xyz + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(_LightningToggle==1.0);
#else
    u_xlatb16 = _LightningToggle==1.0;
#endif
    SV_Target0.xyz = (bool(u_xlatb16)) ? u_xlat2.xyz : u_xlat1.xyz;
    u_xlat16_1 = u_xlat10_10.y * _Opacity;
    SV_Target0.w = u_xlat16_1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
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
    u_xlat0.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position = u_xlat0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1 = vec4(u_xlat10) * u_xlat1.xyzz;
    u_xlat16_2.x = u_xlat1.y * u_xlat1.y;
    u_xlat16_2.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_2.x);
    u_xlat16_3 = u_xlat1.yzwx * u_xlat1.xywz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_3);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_3);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_3);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_4.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_2.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat5 = u_xlat0.y * _ProjectionParams.x;
    u_xlat0.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.w = u_xlat5 * 0.5;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    vs_TEXCOORD4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
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
uniform 	float _MianTex_Uspeed;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTex_Vspeed;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Scaler;
uniform 	mediump float _Opacity;
uniform 	mediump float _LightningToggle;
uniform 	vec4 _CloudColorA;
uniform 	vec4 _CloudColorB;
uniform 	mediump float _UseTwoCloudTex;
uniform 	float _SecTexUspeed;
uniform 	vec4 _SecTex_ST;
uniform 	float _SecTexVspeed;
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
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SecTex;
uniform lowp sampler2D _CloudTex01;
uniform lowp sampler2D _FlashCloudTex;
uniform lowp sampler2D _LightningTex;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp vec2 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump float u_xlat16_1;
bool u_xlatb1;
vec3 u_xlat2;
lowp float u_xlat10_2;
mediump vec2 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_7;
lowp vec2 u_xlat10_10;
vec2 u_xlat12;
float u_xlat16;
lowp float u_xlat10_16;
bool u_xlatb16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = _Time.y * _MianTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _MainTex_Vspeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD3.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat2.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.y;
    u_xlat10_0.xy = texture(_NoiseTex, u_xlat2.xy).xy;
    u_xlat16_3.xy = u_xlat10_0.xy * vec2(_Noise_Scaler) + u_xlat1.xy;
    u_xlat10_10.xy = texture(_MainTex, u_xlat16_3.xy).xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UseTwoCloudTex==1.0);
#else
    u_xlatb1 = _UseTwoCloudTex==1.0;
#endif
    if(u_xlatb1){
        u_xlat1.xy = vs_TEXCOORD3.xy * _SecTex_ST.xy + _SecTex_ST.zw;
        u_xlat2.x = _Time.y * _SecTexUspeed + u_xlat1.x;
        u_xlat2.y = _Time.y * _SecTexVspeed + u_xlat1.y;
        u_xlat16_3.xy = u_xlat10_0.xy * vec2(_Noise_Scaler) + u_xlat2.xy;
        u_xlat10_0.x = texture(_SecTex, u_xlat16_3.xy).x;
        u_xlat16_0 = u_xlat10_10.x + u_xlat10_0.x;
        u_xlat16_0 = u_xlat16_0;
    } else {
        u_xlat16_0 = u_xlat10_10.x;
    //ENDIF
    }
    u_xlat1.xyz = (-_CloudColorA.xyz) + _CloudColorB.xyz;
    u_xlat1.xyz = vec3(u_xlat16_0) * u_xlat1.xyz + _CloudColorA.xyz;
    u_xlat16 = _Time.y * _FlashFrequency;
    u_xlat2.xy = vs_TEXCOORD3.xy * _FlashCloudTex_ST.xy + _FlashCloudTex_ST.zw;
    u_xlat16 = sin(u_xlat16);
    u_xlat16 = u_xlat16 * _FlashSpeed;
    u_xlat2.xy = vec2(u_xlat16) * vec2(0.300000012, 2.0) + u_xlat2.xy;
    u_xlat12.xy = vs_TEXCOORD3.xy * _CloudTex01_ST.xy + _CloudTex01_ST.zw;
    u_xlat12.xy = _Time.yy * vec2(_CloudTex01Speed) + u_xlat12.xy;
    u_xlat10_16 = texture(_CloudTex01, u_xlat12.xy).x;
    u_xlat12.xy = vs_TEXCOORD3.xy * _LightningTex_ST.xy + _LightningTex_ST.zw;
    u_xlat10_2 = texture(_FlashCloudTex, u_xlat2.xy).x;
    u_xlat16_4.xyz = vec3(u_xlat10_2) * _FlashColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(_FlashBrightness);
    u_xlat2.x = u_xlat10_16 + _CloudOffset;
    u_xlat2.x = u_xlat2.x * _CloudScaler;
    u_xlat7.xy = _Time.yy * vec2(_LightningTexSpeed) + u_xlat12.xy;
    u_xlat10_7 = texture(_LightningTex, u_xlat7.xy).x;
    u_xlat16_7 = u_xlat10_7 * _LightningBrightness;
    u_xlat2.x = u_xlat16_7 * u_xlat2.x;
    u_xlat16 = u_xlat10_16 * _CloudIntensity + u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat16_4.xyz + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(_LightningToggle==1.0);
#else
    u_xlatb16 = _LightningToggle==1.0;
#endif
    SV_Target0.xyz = (bool(u_xlatb16)) ? u_xlat2.xyz : u_xlat1.xyz;
    u_xlat16_1 = u_xlat10_10.y * _Opacity;
    SV_Target0.w = u_xlat16_1;
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

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
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
    u_xlat1.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat2 = u_xlat6.xxxx * u_xlat2.xyzz;
    u_xlat16_3.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_3.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_3.x);
    u_xlat16_4 = u_xlat2.yzwx * u_xlat2.xywz;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_5.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat6.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat1.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.w = u_xlat6.x * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat6.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat6.xyz;
    vs_TEXCOORD4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat6.xyz;
    vs_TEXCOORD4.w = 0.0;
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
uniform 	float _MianTex_Uspeed;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTex_Vspeed;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Scaler;
uniform 	mediump float _Opacity;
uniform 	mediump float _LightningToggle;
uniform 	vec4 _CloudColorA;
uniform 	vec4 _CloudColorB;
uniform 	mediump float _UseTwoCloudTex;
uniform 	float _SecTexUspeed;
uniform 	vec4 _SecTex_ST;
uniform 	float _SecTexVspeed;
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
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SecTex;
uniform lowp sampler2D _CloudTex01;
uniform lowp sampler2D _FlashCloudTex;
uniform lowp sampler2D _LightningTex;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp vec2 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump float u_xlat16_1;
bool u_xlatb1;
vec3 u_xlat2;
lowp float u_xlat10_2;
mediump vec2 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_7;
lowp vec2 u_xlat10_10;
vec2 u_xlat12;
float u_xlat16;
lowp float u_xlat10_16;
bool u_xlatb16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = _Time.y * _MianTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _MainTex_Vspeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD3.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat2.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.y;
    u_xlat10_0.xy = texture(_NoiseTex, u_xlat2.xy).xy;
    u_xlat16_3.xy = u_xlat10_0.xy * vec2(_Noise_Scaler) + u_xlat1.xy;
    u_xlat10_10.xy = texture(_MainTex, u_xlat16_3.xy).xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UseTwoCloudTex==1.0);
#else
    u_xlatb1 = _UseTwoCloudTex==1.0;
#endif
    if(u_xlatb1){
        u_xlat1.xy = vs_TEXCOORD3.xy * _SecTex_ST.xy + _SecTex_ST.zw;
        u_xlat2.x = _Time.y * _SecTexUspeed + u_xlat1.x;
        u_xlat2.y = _Time.y * _SecTexVspeed + u_xlat1.y;
        u_xlat16_3.xy = u_xlat10_0.xy * vec2(_Noise_Scaler) + u_xlat2.xy;
        u_xlat10_0.x = texture(_SecTex, u_xlat16_3.xy).x;
        u_xlat16_0 = u_xlat10_10.x + u_xlat10_0.x;
        u_xlat16_0 = u_xlat16_0;
    } else {
        u_xlat16_0 = u_xlat10_10.x;
    //ENDIF
    }
    u_xlat1.xyz = (-_CloudColorA.xyz) + _CloudColorB.xyz;
    u_xlat1.xyz = vec3(u_xlat16_0) * u_xlat1.xyz + _CloudColorA.xyz;
    u_xlat16 = _Time.y * _FlashFrequency;
    u_xlat2.xy = vs_TEXCOORD3.xy * _FlashCloudTex_ST.xy + _FlashCloudTex_ST.zw;
    u_xlat16 = sin(u_xlat16);
    u_xlat16 = u_xlat16 * _FlashSpeed;
    u_xlat2.xy = vec2(u_xlat16) * vec2(0.300000012, 2.0) + u_xlat2.xy;
    u_xlat12.xy = vs_TEXCOORD3.xy * _CloudTex01_ST.xy + _CloudTex01_ST.zw;
    u_xlat12.xy = _Time.yy * vec2(_CloudTex01Speed) + u_xlat12.xy;
    u_xlat10_16 = texture(_CloudTex01, u_xlat12.xy).x;
    u_xlat12.xy = vs_TEXCOORD3.xy * _LightningTex_ST.xy + _LightningTex_ST.zw;
    u_xlat10_2 = texture(_FlashCloudTex, u_xlat2.xy).x;
    u_xlat16_4.xyz = vec3(u_xlat10_2) * _FlashColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(_FlashBrightness);
    u_xlat2.x = u_xlat10_16 + _CloudOffset;
    u_xlat2.x = u_xlat2.x * _CloudScaler;
    u_xlat7.xy = _Time.yy * vec2(_LightningTexSpeed) + u_xlat12.xy;
    u_xlat10_7 = texture(_LightningTex, u_xlat7.xy).x;
    u_xlat16_7 = u_xlat10_7 * _LightningBrightness;
    u_xlat2.x = u_xlat16_7 * u_xlat2.x;
    u_xlat16 = u_xlat10_16 * _CloudIntensity + u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat16_4.xyz + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(_LightningToggle==1.0);
#else
    u_xlatb16 = _LightningToggle==1.0;
#endif
    SV_Target0.xyz = (bool(u_xlatb16)) ? u_xlat2.xyz : u_xlat1.xyz;
    u_xlat16_1 = u_xlat10_10.y * _Opacity;
    SV_Target0.w = u_xlat16_1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MSAA_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
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
    u_xlat0.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position = u_xlat0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1 = vec4(u_xlat10) * u_xlat1.xyzz;
    u_xlat16_2.x = u_xlat1.y * u_xlat1.y;
    u_xlat16_2.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_2.x);
    u_xlat16_3 = u_xlat1.yzwx * u_xlat1.xywz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_3);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_3);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_3);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_4.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_2.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat5 = u_xlat0.y * _ProjectionParams.x;
    u_xlat0.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.w = u_xlat5 * 0.5;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    vs_TEXCOORD4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
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
uniform 	float _MianTex_Uspeed;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTex_Vspeed;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Scaler;
uniform 	mediump float _Opacity;
uniform 	mediump float _LightningToggle;
uniform 	vec4 _CloudColorA;
uniform 	vec4 _CloudColorB;
uniform 	mediump float _UseTwoCloudTex;
uniform 	float _SecTexUspeed;
uniform 	vec4 _SecTex_ST;
uniform 	float _SecTexVspeed;
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
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SecTex;
uniform lowp sampler2D _CloudTex01;
uniform lowp sampler2D _FlashCloudTex;
uniform lowp sampler2D _LightningTex;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp vec2 u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
bool u_xlatb1;
vec3 u_xlat2;
lowp float u_xlat10_2;
mediump vec2 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_7;
lowp vec2 u_xlat10_10;
vec2 u_xlat12;
float u_xlat16;
lowp float u_xlat10_16;
bool u_xlatb16;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = _Time.y * _MianTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _MainTex_Vspeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD3.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat2.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.y;
    u_xlat10_0.xy = texture(_NoiseTex, u_xlat2.xy).xy;
    u_xlat16_3.xy = u_xlat10_0.xy * vec2(_Noise_Scaler) + u_xlat1.xy;
    u_xlat10_10.xy = texture(_MainTex, u_xlat16_3.xy).xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UseTwoCloudTex==1.0);
#else
    u_xlatb1 = _UseTwoCloudTex==1.0;
#endif
    if(u_xlatb1){
        u_xlat1.xy = vs_TEXCOORD3.xy * _SecTex_ST.xy + _SecTex_ST.zw;
        u_xlat2.x = _Time.y * _SecTexUspeed + u_xlat1.x;
        u_xlat2.y = _Time.y * _SecTexVspeed + u_xlat1.y;
        u_xlat16_3.xy = u_xlat10_0.xy * vec2(_Noise_Scaler) + u_xlat2.xy;
        u_xlat10_0.x = texture(_SecTex, u_xlat16_3.xy).x;
        u_xlat16_0 = u_xlat10_10.x + u_xlat10_0.x;
        u_xlat16_0 = u_xlat16_0;
    } else {
        u_xlat16_0 = u_xlat10_10.x;
    //ENDIF
    }
    u_xlat1.xyz = (-_CloudColorA.xyz) + _CloudColorB.xyz;
    u_xlat1.xyz = vec3(u_xlat16_0) * u_xlat1.xyz + _CloudColorA.xyz;
    u_xlat16 = _Time.y * _FlashFrequency;
    u_xlat2.xy = vs_TEXCOORD3.xy * _FlashCloudTex_ST.xy + _FlashCloudTex_ST.zw;
    u_xlat16 = sin(u_xlat16);
    u_xlat16 = u_xlat16 * _FlashSpeed;
    u_xlat2.xy = vec2(u_xlat16) * vec2(0.300000012, 2.0) + u_xlat2.xy;
    u_xlat12.xy = vs_TEXCOORD3.xy * _CloudTex01_ST.xy + _CloudTex01_ST.zw;
    u_xlat12.xy = _Time.yy * vec2(_CloudTex01Speed) + u_xlat12.xy;
    u_xlat10_16 = texture(_CloudTex01, u_xlat12.xy).x;
    u_xlat12.xy = vs_TEXCOORD3.xy * _LightningTex_ST.xy + _LightningTex_ST.zw;
    u_xlat10_2 = texture(_FlashCloudTex, u_xlat2.xy).x;
    u_xlat16_4.xyz = vec3(u_xlat10_2) * _FlashColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(_FlashBrightness);
    u_xlat2.x = u_xlat10_16 + _CloudOffset;
    u_xlat2.x = u_xlat2.x * _CloudScaler;
    u_xlat7.xy = _Time.yy * vec2(_LightningTexSpeed) + u_xlat12.xy;
    u_xlat10_7 = texture(_LightningTex, u_xlat7.xy).x;
    u_xlat16_7 = u_xlat10_7 * _LightningBrightness;
    u_xlat2.x = u_xlat16_7 * u_xlat2.x;
    u_xlat16 = u_xlat10_16 * _CloudIntensity + u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat16_4.xyz + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(_LightningToggle==1.0);
#else
    u_xlatb16 = _LightningToggle==1.0;
#endif
    SV_Target0.xyz = (bool(u_xlatb16)) ? u_xlat2.xyz : u_xlat1.xyz;
    u_xlat16_1 = u_xlat10_10.y * _Opacity;
    SV_Target0.w = u_xlat16_1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MSAA_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
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
    u_xlat1.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat2 = u_xlat6.xxxx * u_xlat2.xyzz;
    u_xlat16_3.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_3.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_3.x);
    u_xlat16_4 = u_xlat2.yzwx * u_xlat2.xywz;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_5.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat6.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat1.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.w = u_xlat6.x * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat6.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat6.xyz;
    vs_TEXCOORD4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat6.xyz;
    vs_TEXCOORD4.w = 0.0;
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
uniform 	float _MianTex_Uspeed;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTex_Vspeed;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Scaler;
uniform 	mediump float _Opacity;
uniform 	mediump float _LightningToggle;
uniform 	vec4 _CloudColorA;
uniform 	vec4 _CloudColorB;
uniform 	mediump float _UseTwoCloudTex;
uniform 	float _SecTexUspeed;
uniform 	vec4 _SecTex_ST;
uniform 	float _SecTexVspeed;
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
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SecTex;
uniform lowp sampler2D _CloudTex01;
uniform lowp sampler2D _FlashCloudTex;
uniform lowp sampler2D _LightningTex;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp vec2 u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
bool u_xlatb1;
vec3 u_xlat2;
lowp float u_xlat10_2;
mediump vec2 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_7;
lowp vec2 u_xlat10_10;
vec2 u_xlat12;
float u_xlat16;
lowp float u_xlat10_16;
bool u_xlatb16;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = _Time.y * _MianTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _MainTex_Vspeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD3.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat2.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.y;
    u_xlat10_0.xy = texture(_NoiseTex, u_xlat2.xy).xy;
    u_xlat16_3.xy = u_xlat10_0.xy * vec2(_Noise_Scaler) + u_xlat1.xy;
    u_xlat10_10.xy = texture(_MainTex, u_xlat16_3.xy).xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UseTwoCloudTex==1.0);
#else
    u_xlatb1 = _UseTwoCloudTex==1.0;
#endif
    if(u_xlatb1){
        u_xlat1.xy = vs_TEXCOORD3.xy * _SecTex_ST.xy + _SecTex_ST.zw;
        u_xlat2.x = _Time.y * _SecTexUspeed + u_xlat1.x;
        u_xlat2.y = _Time.y * _SecTexVspeed + u_xlat1.y;
        u_xlat16_3.xy = u_xlat10_0.xy * vec2(_Noise_Scaler) + u_xlat2.xy;
        u_xlat10_0.x = texture(_SecTex, u_xlat16_3.xy).x;
        u_xlat16_0 = u_xlat10_10.x + u_xlat10_0.x;
        u_xlat16_0 = u_xlat16_0;
    } else {
        u_xlat16_0 = u_xlat10_10.x;
    //ENDIF
    }
    u_xlat1.xyz = (-_CloudColorA.xyz) + _CloudColorB.xyz;
    u_xlat1.xyz = vec3(u_xlat16_0) * u_xlat1.xyz + _CloudColorA.xyz;
    u_xlat16 = _Time.y * _FlashFrequency;
    u_xlat2.xy = vs_TEXCOORD3.xy * _FlashCloudTex_ST.xy + _FlashCloudTex_ST.zw;
    u_xlat16 = sin(u_xlat16);
    u_xlat16 = u_xlat16 * _FlashSpeed;
    u_xlat2.xy = vec2(u_xlat16) * vec2(0.300000012, 2.0) + u_xlat2.xy;
    u_xlat12.xy = vs_TEXCOORD3.xy * _CloudTex01_ST.xy + _CloudTex01_ST.zw;
    u_xlat12.xy = _Time.yy * vec2(_CloudTex01Speed) + u_xlat12.xy;
    u_xlat10_16 = texture(_CloudTex01, u_xlat12.xy).x;
    u_xlat12.xy = vs_TEXCOORD3.xy * _LightningTex_ST.xy + _LightningTex_ST.zw;
    u_xlat10_2 = texture(_FlashCloudTex, u_xlat2.xy).x;
    u_xlat16_4.xyz = vec3(u_xlat10_2) * _FlashColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(_FlashBrightness);
    u_xlat2.x = u_xlat10_16 + _CloudOffset;
    u_xlat2.x = u_xlat2.x * _CloudScaler;
    u_xlat7.xy = _Time.yy * vec2(_LightningTexSpeed) + u_xlat12.xy;
    u_xlat10_7 = texture(_LightningTex, u_xlat7.xy).x;
    u_xlat16_7 = u_xlat10_7 * _LightningBrightness;
    u_xlat2.x = u_xlat16_7 * u_xlat2.x;
    u_xlat16 = u_xlat10_16 * _CloudIntensity + u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat16_4.xyz + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(_LightningToggle==1.0);
#else
    u_xlatb16 = _LightningToggle==1.0;
#endif
    SV_Target0.xyz = (bool(u_xlatb16)) ? u_xlat2.xyz : u_xlat1.xyz;
    u_xlat16_1 = u_xlat10_10.y * _Opacity;
    SV_Target0.w = u_xlat16_1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MSAA_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
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
    u_xlat0.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position = u_xlat0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1 = vec4(u_xlat10) * u_xlat1.xyzz;
    u_xlat16_2.x = u_xlat1.y * u_xlat1.y;
    u_xlat16_2.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_2.x);
    u_xlat16_3 = u_xlat1.yzwx * u_xlat1.xywz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_3);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_3);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_3);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_4.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_2.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat5 = u_xlat0.y * _ProjectionParams.x;
    u_xlat0.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.w = u_xlat5 * 0.5;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    vs_TEXCOORD4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
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
uniform 	float _MianTex_Uspeed;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTex_Vspeed;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Scaler;
uniform 	mediump float _Opacity;
uniform 	mediump float _LightningToggle;
uniform 	vec4 _CloudColorA;
uniform 	vec4 _CloudColorB;
uniform 	mediump float _UseTwoCloudTex;
uniform 	float _SecTexUspeed;
uniform 	vec4 _SecTex_ST;
uniform 	float _SecTexVspeed;
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
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SecTex;
uniform lowp sampler2D _CloudTex01;
uniform lowp sampler2D _FlashCloudTex;
uniform lowp sampler2D _LightningTex;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp vec2 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump float u_xlat16_1;
bool u_xlatb1;
vec3 u_xlat2;
lowp float u_xlat10_2;
mediump vec2 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_7;
lowp vec2 u_xlat10_10;
vec2 u_xlat12;
float u_xlat16;
lowp float u_xlat10_16;
bool u_xlatb16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = _Time.y * _MianTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _MainTex_Vspeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD3.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat2.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.y;
    u_xlat10_0.xy = texture(_NoiseTex, u_xlat2.xy).xy;
    u_xlat16_3.xy = u_xlat10_0.xy * vec2(_Noise_Scaler) + u_xlat1.xy;
    u_xlat10_10.xy = texture(_MainTex, u_xlat16_3.xy).xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UseTwoCloudTex==1.0);
#else
    u_xlatb1 = _UseTwoCloudTex==1.0;
#endif
    if(u_xlatb1){
        u_xlat1.xy = vs_TEXCOORD3.xy * _SecTex_ST.xy + _SecTex_ST.zw;
        u_xlat2.x = _Time.y * _SecTexUspeed + u_xlat1.x;
        u_xlat2.y = _Time.y * _SecTexVspeed + u_xlat1.y;
        u_xlat16_3.xy = u_xlat10_0.xy * vec2(_Noise_Scaler) + u_xlat2.xy;
        u_xlat10_0.x = texture(_SecTex, u_xlat16_3.xy).x;
        u_xlat16_0 = u_xlat10_10.x + u_xlat10_0.x;
        u_xlat16_0 = u_xlat16_0;
    } else {
        u_xlat16_0 = u_xlat10_10.x;
    //ENDIF
    }
    u_xlat1.xyz = (-_CloudColorA.xyz) + _CloudColorB.xyz;
    u_xlat1.xyz = vec3(u_xlat16_0) * u_xlat1.xyz + _CloudColorA.xyz;
    u_xlat16 = _Time.y * _FlashFrequency;
    u_xlat2.xy = vs_TEXCOORD3.xy * _FlashCloudTex_ST.xy + _FlashCloudTex_ST.zw;
    u_xlat16 = sin(u_xlat16);
    u_xlat16 = u_xlat16 * _FlashSpeed;
    u_xlat2.xy = vec2(u_xlat16) * vec2(0.300000012, 2.0) + u_xlat2.xy;
    u_xlat12.xy = vs_TEXCOORD3.xy * _CloudTex01_ST.xy + _CloudTex01_ST.zw;
    u_xlat12.xy = _Time.yy * vec2(_CloudTex01Speed) + u_xlat12.xy;
    u_xlat10_16 = texture(_CloudTex01, u_xlat12.xy).x;
    u_xlat12.xy = vs_TEXCOORD3.xy * _LightningTex_ST.xy + _LightningTex_ST.zw;
    u_xlat10_2 = texture(_FlashCloudTex, u_xlat2.xy).x;
    u_xlat16_4.xyz = vec3(u_xlat10_2) * _FlashColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(_FlashBrightness);
    u_xlat2.x = u_xlat10_16 + _CloudOffset;
    u_xlat2.x = u_xlat2.x * _CloudScaler;
    u_xlat7.xy = _Time.yy * vec2(_LightningTexSpeed) + u_xlat12.xy;
    u_xlat10_7 = texture(_LightningTex, u_xlat7.xy).x;
    u_xlat16_7 = u_xlat10_7 * _LightningBrightness;
    u_xlat2.x = u_xlat16_7 * u_xlat2.x;
    u_xlat16 = u_xlat10_16 * _CloudIntensity + u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat16_4.xyz + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(_LightningToggle==1.0);
#else
    u_xlatb16 = _LightningToggle==1.0;
#endif
    SV_Target0.xyz = (bool(u_xlatb16)) ? u_xlat2.xyz : u_xlat1.xyz;
    u_xlat16_1 = u_xlat10_10.y * _Opacity;
    SV_Target0.w = u_xlat16_1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MSAA_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
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
    u_xlat1.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat2 = u_xlat6.xxxx * u_xlat2.xyzz;
    u_xlat16_3.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_3.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_3.x);
    u_xlat16_4 = u_xlat2.yzwx * u_xlat2.xywz;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_5.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat6.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat1.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.w = u_xlat6.x * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat6.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat6.xyz;
    vs_TEXCOORD4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat6.xyz;
    vs_TEXCOORD4.w = 0.0;
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
uniform 	float _MianTex_Uspeed;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTex_Vspeed;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Scaler;
uniform 	mediump float _Opacity;
uniform 	mediump float _LightningToggle;
uniform 	vec4 _CloudColorA;
uniform 	vec4 _CloudColorB;
uniform 	mediump float _UseTwoCloudTex;
uniform 	float _SecTexUspeed;
uniform 	vec4 _SecTex_ST;
uniform 	float _SecTexVspeed;
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
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SecTex;
uniform lowp sampler2D _CloudTex01;
uniform lowp sampler2D _FlashCloudTex;
uniform lowp sampler2D _LightningTex;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp vec2 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump float u_xlat16_1;
bool u_xlatb1;
vec3 u_xlat2;
lowp float u_xlat10_2;
mediump vec2 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_7;
lowp vec2 u_xlat10_10;
vec2 u_xlat12;
float u_xlat16;
lowp float u_xlat10_16;
bool u_xlatb16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = _Time.y * _MianTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _MainTex_Vspeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD3.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat2.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.y;
    u_xlat10_0.xy = texture(_NoiseTex, u_xlat2.xy).xy;
    u_xlat16_3.xy = u_xlat10_0.xy * vec2(_Noise_Scaler) + u_xlat1.xy;
    u_xlat10_10.xy = texture(_MainTex, u_xlat16_3.xy).xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UseTwoCloudTex==1.0);
#else
    u_xlatb1 = _UseTwoCloudTex==1.0;
#endif
    if(u_xlatb1){
        u_xlat1.xy = vs_TEXCOORD3.xy * _SecTex_ST.xy + _SecTex_ST.zw;
        u_xlat2.x = _Time.y * _SecTexUspeed + u_xlat1.x;
        u_xlat2.y = _Time.y * _SecTexVspeed + u_xlat1.y;
        u_xlat16_3.xy = u_xlat10_0.xy * vec2(_Noise_Scaler) + u_xlat2.xy;
        u_xlat10_0.x = texture(_SecTex, u_xlat16_3.xy).x;
        u_xlat16_0 = u_xlat10_10.x + u_xlat10_0.x;
        u_xlat16_0 = u_xlat16_0;
    } else {
        u_xlat16_0 = u_xlat10_10.x;
    //ENDIF
    }
    u_xlat1.xyz = (-_CloudColorA.xyz) + _CloudColorB.xyz;
    u_xlat1.xyz = vec3(u_xlat16_0) * u_xlat1.xyz + _CloudColorA.xyz;
    u_xlat16 = _Time.y * _FlashFrequency;
    u_xlat2.xy = vs_TEXCOORD3.xy * _FlashCloudTex_ST.xy + _FlashCloudTex_ST.zw;
    u_xlat16 = sin(u_xlat16);
    u_xlat16 = u_xlat16 * _FlashSpeed;
    u_xlat2.xy = vec2(u_xlat16) * vec2(0.300000012, 2.0) + u_xlat2.xy;
    u_xlat12.xy = vs_TEXCOORD3.xy * _CloudTex01_ST.xy + _CloudTex01_ST.zw;
    u_xlat12.xy = _Time.yy * vec2(_CloudTex01Speed) + u_xlat12.xy;
    u_xlat10_16 = texture(_CloudTex01, u_xlat12.xy).x;
    u_xlat12.xy = vs_TEXCOORD3.xy * _LightningTex_ST.xy + _LightningTex_ST.zw;
    u_xlat10_2 = texture(_FlashCloudTex, u_xlat2.xy).x;
    u_xlat16_4.xyz = vec3(u_xlat10_2) * _FlashColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(_FlashBrightness);
    u_xlat2.x = u_xlat10_16 + _CloudOffset;
    u_xlat2.x = u_xlat2.x * _CloudScaler;
    u_xlat7.xy = _Time.yy * vec2(_LightningTexSpeed) + u_xlat12.xy;
    u_xlat10_7 = texture(_LightningTex, u_xlat7.xy).x;
    u_xlat16_7 = u_xlat10_7 * _LightningBrightness;
    u_xlat2.x = u_xlat16_7 * u_xlat2.x;
    u_xlat16 = u_xlat10_16 * _CloudIntensity + u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat16_4.xyz + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(_LightningToggle==1.0);
#else
    u_xlatb16 = _LightningToggle==1.0;
#endif
    SV_Target0.xyz = (bool(u_xlatb16)) ? u_xlat2.xyz : u_xlat1.xyz;
    u_xlat16_1 = u_xlat10_10.y * _Opacity;
    SV_Target0.w = u_xlat16_1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat7;
float u_xlat9;
mediump float u_xlat16_10;
float u_xlat14;
bool u_xlatb14;
float u_xlat16;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
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
    u_xlat0.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position = u_xlat0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat14 = u_xlat2.y * _HeigtFogParams.x;
    u_xlat22 = u_xlat14 * -1.44269502;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = (-u_xlat22) + 1.0;
    u_xlat22 = u_xlat22 / u_xlat14;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(0.00999999978<abs(u_xlat14));
#else
    u_xlatb14 = 0.00999999978<abs(u_xlat14);
#endif
    u_xlat16_3.x = (u_xlatb14) ? u_xlat22 : 1.0;
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = sqrt(u_xlat14);
    u_xlat22 = u_xlat14 * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat22 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat23 = u_xlat22 * -1.44269502;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat23 = u_xlat23 / u_xlat22;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(0.00999999978<abs(u_xlat22));
#else
    u_xlatb22 = 0.00999999978<abs(u_xlat22);
#endif
    u_xlat16_10 = (u_xlatb22) ? u_xlat23 : 1.0;
    u_xlat22 = u_xlat14 * _HeigtFogParams2.y;
    u_xlat16_10 = u_xlat22 * u_xlat16_10;
    u_xlat16_10 = exp2((-u_xlat16_10));
    u_xlat16_3.y = (-u_xlat16_10) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat22 = u_xlat14 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat22) + 2.0;
    u_xlat16_10 = u_xlat22 * u_xlat16_10;
    u_xlat22 = u_xlat16_10 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat22 = u_xlat22 + 1.0;
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat22 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat23 = (-u_xlat22) + 1.0;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat9 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat9);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat9;
#endif
    u_xlat9 = u_xlat14 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat14 = u_xlat14 + (-_HeigtFogRamp.w);
    u_xlat14 = u_xlat14 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat9) + 2.0;
    u_xlat9 = u_xlat16 * u_xlat9;
    u_xlat16 = u_xlat9 * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat16 : u_xlat9;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat9 = u_xlat1.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat9) + 2.0;
    u_xlat16_3.x = u_xlat9 * u_xlat16_3.x;
    u_xlat4.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat5.xyz = (-u_xlat4.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat4.xyz = vec3(u_xlat14) * u_xlat5.xyz + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat2.xxx * u_xlat4.xyz;
    u_xlat14 = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat23 * u_xlat14;
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat4.xyz;
    u_xlat14 = u_xlat1.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.xyz = vec3(u_xlat14) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz * vec3(u_xlat22) + u_xlat2.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat1 = vec4(u_xlat14) * u_xlat1.xyzz;
    u_xlat16_3.x = u_xlat1.y * u_xlat1.y;
    u_xlat16_3.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_3.x);
    u_xlat16_2 = u_xlat1.yzwx * u_xlat1.xywz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_6.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_6.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat7 = u_xlat0.y * _ProjectionParams.x;
    u_xlat0.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.w = u_xlat7 * 0.5;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    vs_TEXCOORD4.w = 0.0;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	float _MianTex_Uspeed;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTex_Vspeed;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Scaler;
uniform 	mediump float _Opacity;
uniform 	mediump float _LightningToggle;
uniform 	vec4 _CloudColorA;
uniform 	vec4 _CloudColorB;
uniform 	mediump float _UseTwoCloudTex;
uniform 	float _SecTexUspeed;
uniform 	vec4 _SecTex_ST;
uniform 	float _SecTexVspeed;
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
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SecTex;
uniform lowp sampler2D _CloudTex01;
uniform lowp sampler2D _FlashCloudTex;
uniform lowp sampler2D _LightningTex;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp vec2 u_xlat10_0;
vec3 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
lowp float u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
bool u_xlatb4;
mediump float u_xlat16_5;
float u_xlat7;
vec2 u_xlat8;
mediump float u_xlat16_8;
lowp float u_xlat10_8;
float u_xlat10;
lowp vec2 u_xlat10_12;
float u_xlat13;
vec2 u_xlat14;
float u_xlat19;
lowp float u_xlat10_19;
bool u_xlatb19;
float u_xlat20;
bool u_xlatb20;
mediump float u_xlat16_21;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = _Time.y * _MianTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _MainTex_Vspeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD3.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat2.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.y;
    u_xlat10_0.xy = texture(_NoiseTex, u_xlat2.xy).xy;
    u_xlat16_3.xy = u_xlat10_0.xy * vec2(_Noise_Scaler) + u_xlat1.xy;
    u_xlat10_12.xy = texture(_MainTex, u_xlat16_3.xy).xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UseTwoCloudTex==1.0);
#else
    u_xlatb1 = _UseTwoCloudTex==1.0;
#endif
    if(u_xlatb1){
        u_xlat1.xy = vs_TEXCOORD3.xy * _SecTex_ST.xy + _SecTex_ST.zw;
        u_xlat2.x = _Time.y * _SecTexUspeed + u_xlat1.x;
        u_xlat2.y = _Time.y * _SecTexVspeed + u_xlat1.y;
        u_xlat16_3.xy = u_xlat10_0.xy * vec2(_Noise_Scaler) + u_xlat2.xy;
        u_xlat10_0.x = texture(_SecTex, u_xlat16_3.xy).x;
        u_xlat16_0 = u_xlat10_12.x + u_xlat10_0.x;
        u_xlat16_0 = u_xlat16_0;
    } else {
        u_xlat16_0 = u_xlat10_12.x;
    //ENDIF
    }
    u_xlat1.xyz = (-_CloudColorA.xyz) + _CloudColorB.xyz;
    u_xlat1.xyz = vec3(u_xlat16_0) * u_xlat1.xyz + _CloudColorA.xyz;
    u_xlat19 = _Time.y * _FlashFrequency;
    u_xlat2.xy = vs_TEXCOORD3.xy * _FlashCloudTex_ST.xy + _FlashCloudTex_ST.zw;
    u_xlat19 = sin(u_xlat19);
    u_xlat19 = u_xlat19 * _FlashSpeed;
    u_xlat2.xy = vec2(u_xlat19) * vec2(0.300000012, 2.0) + u_xlat2.xy;
    u_xlat14.xy = vs_TEXCOORD3.xy * _CloudTex01_ST.xy + _CloudTex01_ST.zw;
    u_xlat14.xy = _Time.yy * vec2(_CloudTex01Speed) + u_xlat14.xy;
    u_xlat10_19 = texture(_CloudTex01, u_xlat14.xy).x;
    u_xlat14.xy = vs_TEXCOORD3.xy * _LightningTex_ST.xy + _LightningTex_ST.zw;
    u_xlat10_2 = texture(_FlashCloudTex, u_xlat2.xy).x;
    u_xlat16_4.xyz = vec3(u_xlat10_2) * _FlashColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(_FlashBrightness);
    u_xlat2.x = u_xlat10_19 + _CloudOffset;
    u_xlat2.x = u_xlat2.x * _CloudScaler;
    u_xlat8.xy = _Time.yy * vec2(_LightningTexSpeed) + u_xlat14.xy;
    u_xlat10_8 = texture(_LightningTex, u_xlat8.xy).x;
    u_xlat16_8 = u_xlat10_8 * _LightningBrightness;
    u_xlat2.x = u_xlat16_8 * u_xlat2.x;
    u_xlat19 = u_xlat10_19 * _CloudIntensity + u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat16_4.xyz + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(_LightningToggle==1.0);
#else
    u_xlatb19 = _LightningToggle==1.0;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb19)) ? u_xlat2.xyz : u_xlat1.xyz;
    u_xlat0.w = u_xlat10_12.y * _Opacity;
    u_xlat1.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat13 = u_xlat1.x * _HeigtFogParams.y;
    u_xlat2.x = u_xlat1.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat8.x = (-u_xlat2.x) + 2.0;
    u_xlat2.x = u_xlat8.x * u_xlat2.x;
    u_xlat8.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!((-u_xlat19)>=u_xlat8.x);
#else
    u_xlatb19 = (-u_xlat19)>=u_xlat8.x;
#endif
    u_xlat8.x = u_xlat2.x * _HeigtFogColDelta.w;
    u_xlat19 = (u_xlatb19) ? u_xlat8.x : u_xlat2.x;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * unity_FogColor.w;
    u_xlat19 = exp2(u_xlat19);
    u_xlat19 = min(u_xlat19, _HeigtFogColBase.w);
    u_xlat2.x = vs_TEXCOORD4.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_21 = (-u_xlat2.x) + 2.0;
    u_xlat16_21 = u_xlat2.x * u_xlat16_21;
    u_xlat2.xyz = vec3(u_xlat16_21) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat20 = u_xlat1.x + (-_HeigtFogRamp.w);
    u_xlat20 = u_xlat20 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat2.xyz = vec3(u_xlat20) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat20 = u_xlat1.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat20));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat20);
#endif
    u_xlat10 = u_xlat20 * -1.44269502;
    u_xlat10 = exp2(u_xlat10);
    u_xlat10 = (-u_xlat10) + 1.0;
    u_xlat20 = u_xlat10 / u_xlat20;
    u_xlat16_21 = (u_xlatb4) ? u_xlat20 : 1.0;
    u_xlat7 = u_xlat1.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(0.00999999978<abs(u_xlat7));
#else
    u_xlatb20 = 0.00999999978<abs(u_xlat7);
#endif
    u_xlat4.x = u_xlat7 * -1.44269502;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat7 = u_xlat4.x / u_xlat7;
    u_xlat16_5 = (u_xlatb20) ? u_xlat7 : 1.0;
    u_xlat7 = u_xlat1.x * _HeigtFogParams2.y;
    u_xlat16_21 = u_xlat13 * u_xlat16_21;
    u_xlat16_5 = u_xlat7 * u_xlat16_5;
    u_xlat16_21 = exp2((-u_xlat16_21));
    u_xlat16_21 = (-u_xlat16_21) + 1.0;
    u_xlat16_21 = max(u_xlat16_21, 0.0);
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_5 = max(u_xlat16_5, 0.0);
    u_xlat16_21 = u_xlat16_21 + u_xlat16_5;
    u_xlat1.x = u_xlat1.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat1.x) + 2.0;
    u_xlat16_5 = u_xlat1.x * u_xlat16_5;
    u_xlat1.x = u_xlat16_5 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat16_21 = u_xlat1.x * u_xlat16_21;
    u_xlat1.x = min(u_xlat16_21, _HeigtFogColBase.w);
    u_xlat7 = vs_TEXCOORD4.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat7) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat7 = (-u_xlat1.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat7) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat4.xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.x = (-u_xlat19) + 1.0;
    u_xlat1.x = u_xlat7 * u_xlat1.x;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat16_3.xyz + u_xlat2.xyz;
    SV_Target0 = u_xlat0;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
bool u_xlatb7;
vec3 u_xlat9;
mediump float u_xlat16_10;
float u_xlat14;
float u_xlat15;
float u_xlat16;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.xxxx * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1] * in_POSITION0.yyyy + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat7.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat7.xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat7.xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat7.xyz;
    vs_TEXCOORD4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat7.xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat7.xyz;
    u_xlat2.xyz = u_xlat7.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat7.x = u_xlat2.y * _HeigtFogParams.x;
    u_xlat21 = u_xlat7.x * -1.44269502;
    u_xlat21 = exp2(u_xlat21);
    u_xlat21 = (-u_xlat21) + 1.0;
    u_xlat21 = u_xlat21 / u_xlat7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.00999999978<abs(u_xlat7.x));
#else
    u_xlatb7 = 0.00999999978<abs(u_xlat7.x);
#endif
    u_xlat16_3.x = (u_xlatb7) ? u_xlat21 : 1.0;
    u_xlat7.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat21 = u_xlat7.x * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat21 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat21 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat15 = u_xlat21 * -1.44269502;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 / u_xlat21;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.00999999978<abs(u_xlat21));
#else
    u_xlatb21 = 0.00999999978<abs(u_xlat21);
#endif
    u_xlat16_10 = (u_xlatb21) ? u_xlat15 : 1.0;
    u_xlat21 = u_xlat7.x * _HeigtFogParams2.y;
    u_xlat16_10 = u_xlat21 * u_xlat16_10;
    u_xlat16_10 = exp2((-u_xlat16_10));
    u_xlat16_3.y = (-u_xlat16_10) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat21 = u_xlat7.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat21) + 2.0;
    u_xlat16_10 = u_xlat21 * u_xlat16_10;
    u_xlat21 = u_xlat16_10 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_3.x = u_xlat21 * u_xlat16_3.x;
    u_xlat21 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat15 = (-u_xlat21) + 1.0;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat9.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat9.x);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat9.x;
#endif
    u_xlat9.x = u_xlat7.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat7.x + (-_HeigtFogRamp.w);
    u_xlat7.x = u_xlat7.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat9.x) + 2.0;
    u_xlat9.x = u_xlat16 * u_xlat9.x;
    u_xlat16 = u_xlat9.x * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat16 : u_xlat9.x;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat9.x = u_xlat7.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat14 = u_xlat7.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat14) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat16_3.x = (-u_xlat9.x) + 2.0;
    u_xlat16_3.x = u_xlat9.x * u_xlat16_3.x;
    u_xlat9.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat5.xyz = (-u_xlat9.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat9.xyz = u_xlat7.xxx * u_xlat5.xyz + u_xlat9.xyz;
    u_xlat9.xyz = u_xlat2.xxx * u_xlat9.xyz;
    u_xlat7.x = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat15 * u_xlat7.x;
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat9.xyz;
    vs_TEXCOORD0.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat2.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat16_3.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_3.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_3.x);
    u_xlat16_2 = u_xlat0.yzwx * u_xlat0.xywz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_6.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_6.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat1.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.w = u_xlat0.x * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    vs_TEXCOORD4.w = 0.0;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	float _MianTex_Uspeed;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTex_Vspeed;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Scaler;
uniform 	mediump float _Opacity;
uniform 	mediump float _LightningToggle;
uniform 	vec4 _CloudColorA;
uniform 	vec4 _CloudColorB;
uniform 	mediump float _UseTwoCloudTex;
uniform 	float _SecTexUspeed;
uniform 	vec4 _SecTex_ST;
uniform 	float _SecTexVspeed;
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
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SecTex;
uniform lowp sampler2D _CloudTex01;
uniform lowp sampler2D _FlashCloudTex;
uniform lowp sampler2D _LightningTex;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp vec2 u_xlat10_0;
vec3 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
lowp float u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
bool u_xlatb4;
mediump float u_xlat16_5;
float u_xlat7;
vec2 u_xlat8;
mediump float u_xlat16_8;
lowp float u_xlat10_8;
float u_xlat10;
lowp vec2 u_xlat10_12;
float u_xlat13;
vec2 u_xlat14;
float u_xlat19;
lowp float u_xlat10_19;
bool u_xlatb19;
float u_xlat20;
bool u_xlatb20;
mediump float u_xlat16_21;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = _Time.y * _MianTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _MainTex_Vspeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD3.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat2.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.y;
    u_xlat10_0.xy = texture(_NoiseTex, u_xlat2.xy).xy;
    u_xlat16_3.xy = u_xlat10_0.xy * vec2(_Noise_Scaler) + u_xlat1.xy;
    u_xlat10_12.xy = texture(_MainTex, u_xlat16_3.xy).xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UseTwoCloudTex==1.0);
#else
    u_xlatb1 = _UseTwoCloudTex==1.0;
#endif
    if(u_xlatb1){
        u_xlat1.xy = vs_TEXCOORD3.xy * _SecTex_ST.xy + _SecTex_ST.zw;
        u_xlat2.x = _Time.y * _SecTexUspeed + u_xlat1.x;
        u_xlat2.y = _Time.y * _SecTexVspeed + u_xlat1.y;
        u_xlat16_3.xy = u_xlat10_0.xy * vec2(_Noise_Scaler) + u_xlat2.xy;
        u_xlat10_0.x = texture(_SecTex, u_xlat16_3.xy).x;
        u_xlat16_0 = u_xlat10_12.x + u_xlat10_0.x;
        u_xlat16_0 = u_xlat16_0;
    } else {
        u_xlat16_0 = u_xlat10_12.x;
    //ENDIF
    }
    u_xlat1.xyz = (-_CloudColorA.xyz) + _CloudColorB.xyz;
    u_xlat1.xyz = vec3(u_xlat16_0) * u_xlat1.xyz + _CloudColorA.xyz;
    u_xlat19 = _Time.y * _FlashFrequency;
    u_xlat2.xy = vs_TEXCOORD3.xy * _FlashCloudTex_ST.xy + _FlashCloudTex_ST.zw;
    u_xlat19 = sin(u_xlat19);
    u_xlat19 = u_xlat19 * _FlashSpeed;
    u_xlat2.xy = vec2(u_xlat19) * vec2(0.300000012, 2.0) + u_xlat2.xy;
    u_xlat14.xy = vs_TEXCOORD3.xy * _CloudTex01_ST.xy + _CloudTex01_ST.zw;
    u_xlat14.xy = _Time.yy * vec2(_CloudTex01Speed) + u_xlat14.xy;
    u_xlat10_19 = texture(_CloudTex01, u_xlat14.xy).x;
    u_xlat14.xy = vs_TEXCOORD3.xy * _LightningTex_ST.xy + _LightningTex_ST.zw;
    u_xlat10_2 = texture(_FlashCloudTex, u_xlat2.xy).x;
    u_xlat16_4.xyz = vec3(u_xlat10_2) * _FlashColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(_FlashBrightness);
    u_xlat2.x = u_xlat10_19 + _CloudOffset;
    u_xlat2.x = u_xlat2.x * _CloudScaler;
    u_xlat8.xy = _Time.yy * vec2(_LightningTexSpeed) + u_xlat14.xy;
    u_xlat10_8 = texture(_LightningTex, u_xlat8.xy).x;
    u_xlat16_8 = u_xlat10_8 * _LightningBrightness;
    u_xlat2.x = u_xlat16_8 * u_xlat2.x;
    u_xlat19 = u_xlat10_19 * _CloudIntensity + u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat16_4.xyz + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(_LightningToggle==1.0);
#else
    u_xlatb19 = _LightningToggle==1.0;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb19)) ? u_xlat2.xyz : u_xlat1.xyz;
    u_xlat0.w = u_xlat10_12.y * _Opacity;
    u_xlat1.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat13 = u_xlat1.x * _HeigtFogParams.y;
    u_xlat2.x = u_xlat1.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat8.x = (-u_xlat2.x) + 2.0;
    u_xlat2.x = u_xlat8.x * u_xlat2.x;
    u_xlat8.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!((-u_xlat19)>=u_xlat8.x);
#else
    u_xlatb19 = (-u_xlat19)>=u_xlat8.x;
#endif
    u_xlat8.x = u_xlat2.x * _HeigtFogColDelta.w;
    u_xlat19 = (u_xlatb19) ? u_xlat8.x : u_xlat2.x;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * unity_FogColor.w;
    u_xlat19 = exp2(u_xlat19);
    u_xlat19 = min(u_xlat19, _HeigtFogColBase.w);
    u_xlat2.x = vs_TEXCOORD4.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_21 = (-u_xlat2.x) + 2.0;
    u_xlat16_21 = u_xlat2.x * u_xlat16_21;
    u_xlat2.xyz = vec3(u_xlat16_21) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat20 = u_xlat1.x + (-_HeigtFogRamp.w);
    u_xlat20 = u_xlat20 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat2.xyz = vec3(u_xlat20) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat20 = u_xlat1.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat20));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat20);
#endif
    u_xlat10 = u_xlat20 * -1.44269502;
    u_xlat10 = exp2(u_xlat10);
    u_xlat10 = (-u_xlat10) + 1.0;
    u_xlat20 = u_xlat10 / u_xlat20;
    u_xlat16_21 = (u_xlatb4) ? u_xlat20 : 1.0;
    u_xlat7 = u_xlat1.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(0.00999999978<abs(u_xlat7));
#else
    u_xlatb20 = 0.00999999978<abs(u_xlat7);
#endif
    u_xlat4.x = u_xlat7 * -1.44269502;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat7 = u_xlat4.x / u_xlat7;
    u_xlat16_5 = (u_xlatb20) ? u_xlat7 : 1.0;
    u_xlat7 = u_xlat1.x * _HeigtFogParams2.y;
    u_xlat16_21 = u_xlat13 * u_xlat16_21;
    u_xlat16_5 = u_xlat7 * u_xlat16_5;
    u_xlat16_21 = exp2((-u_xlat16_21));
    u_xlat16_21 = (-u_xlat16_21) + 1.0;
    u_xlat16_21 = max(u_xlat16_21, 0.0);
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_5 = max(u_xlat16_5, 0.0);
    u_xlat16_21 = u_xlat16_21 + u_xlat16_5;
    u_xlat1.x = u_xlat1.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat1.x) + 2.0;
    u_xlat16_5 = u_xlat1.x * u_xlat16_5;
    u_xlat1.x = u_xlat16_5 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat16_21 = u_xlat1.x * u_xlat16_21;
    u_xlat1.x = min(u_xlat16_21, _HeigtFogColBase.w);
    u_xlat7 = vs_TEXCOORD4.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat7) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat7 = (-u_xlat1.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat7) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat4.xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.x = (-u_xlat19) + 1.0;
    u_xlat1.x = u_xlat7 * u_xlat1.x;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat16_3.xyz + u_xlat2.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat7;
float u_xlat9;
mediump float u_xlat16_10;
float u_xlat14;
bool u_xlatb14;
float u_xlat16;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
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
    u_xlat0.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position = u_xlat0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat14 = u_xlat2.y * _HeigtFogParams.x;
    u_xlat22 = u_xlat14 * -1.44269502;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = (-u_xlat22) + 1.0;
    u_xlat22 = u_xlat22 / u_xlat14;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(0.00999999978<abs(u_xlat14));
#else
    u_xlatb14 = 0.00999999978<abs(u_xlat14);
#endif
    u_xlat16_3.x = (u_xlatb14) ? u_xlat22 : 1.0;
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = sqrt(u_xlat14);
    u_xlat22 = u_xlat14 * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat22 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat23 = u_xlat22 * -1.44269502;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat23 = u_xlat23 / u_xlat22;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(0.00999999978<abs(u_xlat22));
#else
    u_xlatb22 = 0.00999999978<abs(u_xlat22);
#endif
    u_xlat16_10 = (u_xlatb22) ? u_xlat23 : 1.0;
    u_xlat22 = u_xlat14 * _HeigtFogParams2.y;
    u_xlat16_10 = u_xlat22 * u_xlat16_10;
    u_xlat16_10 = exp2((-u_xlat16_10));
    u_xlat16_3.y = (-u_xlat16_10) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat22 = u_xlat14 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat22) + 2.0;
    u_xlat16_10 = u_xlat22 * u_xlat16_10;
    u_xlat22 = u_xlat16_10 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat22 = u_xlat22 + 1.0;
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat22 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat23 = (-u_xlat22) + 1.0;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat9 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat9);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat9;
#endif
    u_xlat9 = u_xlat14 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat14 = u_xlat14 + (-_HeigtFogRamp.w);
    u_xlat14 = u_xlat14 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat9) + 2.0;
    u_xlat9 = u_xlat16 * u_xlat9;
    u_xlat16 = u_xlat9 * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat16 : u_xlat9;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat9 = u_xlat1.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat9) + 2.0;
    u_xlat16_3.x = u_xlat9 * u_xlat16_3.x;
    u_xlat4.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat5.xyz = (-u_xlat4.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat4.xyz = vec3(u_xlat14) * u_xlat5.xyz + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat2.xxx * u_xlat4.xyz;
    u_xlat14 = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat23 * u_xlat14;
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat4.xyz;
    u_xlat14 = u_xlat1.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.xyz = vec3(u_xlat14) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz * vec3(u_xlat22) + u_xlat2.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat1 = vec4(u_xlat14) * u_xlat1.xyzz;
    u_xlat16_3.x = u_xlat1.y * u_xlat1.y;
    u_xlat16_3.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_3.x);
    u_xlat16_2 = u_xlat1.yzwx * u_xlat1.xywz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_6.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_6.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat7 = u_xlat0.y * _ProjectionParams.x;
    u_xlat0.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.w = u_xlat7 * 0.5;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    vs_TEXCOORD4.w = 0.0;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _MianTex_Uspeed;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTex_Vspeed;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Scaler;
uniform 	mediump float _Opacity;
uniform 	mediump float _LightningToggle;
uniform 	vec4 _CloudColorA;
uniform 	vec4 _CloudColorB;
uniform 	mediump float _UseTwoCloudTex;
uniform 	float _SecTexUspeed;
uniform 	vec4 _SecTex_ST;
uniform 	float _SecTexVspeed;
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
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SecTex;
uniform lowp sampler2D _CloudTex01;
uniform lowp sampler2D _FlashCloudTex;
uniform lowp sampler2D _LightningTex;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp vec2 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
lowp float u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
bool u_xlatb4;
mediump float u_xlat16_5;
float u_xlat7;
vec2 u_xlat8;
mediump float u_xlat16_8;
lowp float u_xlat10_8;
float u_xlat10;
lowp vec2 u_xlat10_12;
float u_xlat13;
vec2 u_xlat14;
float u_xlat19;
lowp float u_xlat10_19;
bool u_xlatb19;
float u_xlat20;
bool u_xlatb20;
mediump float u_xlat16_21;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = _Time.y * _MianTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _MainTex_Vspeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD3.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat2.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.y;
    u_xlat10_0.xy = texture(_NoiseTex, u_xlat2.xy).xy;
    u_xlat16_3.xy = u_xlat10_0.xy * vec2(_Noise_Scaler) + u_xlat1.xy;
    u_xlat10_12.xy = texture(_MainTex, u_xlat16_3.xy).xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UseTwoCloudTex==1.0);
#else
    u_xlatb1 = _UseTwoCloudTex==1.0;
#endif
    if(u_xlatb1){
        u_xlat1.xy = vs_TEXCOORD3.xy * _SecTex_ST.xy + _SecTex_ST.zw;
        u_xlat2.x = _Time.y * _SecTexUspeed + u_xlat1.x;
        u_xlat2.y = _Time.y * _SecTexVspeed + u_xlat1.y;
        u_xlat16_3.xy = u_xlat10_0.xy * vec2(_Noise_Scaler) + u_xlat2.xy;
        u_xlat10_0.x = texture(_SecTex, u_xlat16_3.xy).x;
        u_xlat16_0 = u_xlat10_12.x + u_xlat10_0.x;
        u_xlat16_0 = u_xlat16_0;
    } else {
        u_xlat16_0 = u_xlat10_12.x;
    //ENDIF
    }
    u_xlat1.xyz = (-_CloudColorA.xyz) + _CloudColorB.xyz;
    u_xlat1.xyz = vec3(u_xlat16_0) * u_xlat1.xyz + _CloudColorA.xyz;
    u_xlat19 = _Time.y * _FlashFrequency;
    u_xlat2.xy = vs_TEXCOORD3.xy * _FlashCloudTex_ST.xy + _FlashCloudTex_ST.zw;
    u_xlat19 = sin(u_xlat19);
    u_xlat19 = u_xlat19 * _FlashSpeed;
    u_xlat2.xy = vec2(u_xlat19) * vec2(0.300000012, 2.0) + u_xlat2.xy;
    u_xlat14.xy = vs_TEXCOORD3.xy * _CloudTex01_ST.xy + _CloudTex01_ST.zw;
    u_xlat14.xy = _Time.yy * vec2(_CloudTex01Speed) + u_xlat14.xy;
    u_xlat10_19 = texture(_CloudTex01, u_xlat14.xy).x;
    u_xlat14.xy = vs_TEXCOORD3.xy * _LightningTex_ST.xy + _LightningTex_ST.zw;
    u_xlat10_2 = texture(_FlashCloudTex, u_xlat2.xy).x;
    u_xlat16_4.xyz = vec3(u_xlat10_2) * _FlashColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(_FlashBrightness);
    u_xlat2.x = u_xlat10_19 + _CloudOffset;
    u_xlat2.x = u_xlat2.x * _CloudScaler;
    u_xlat8.xy = _Time.yy * vec2(_LightningTexSpeed) + u_xlat14.xy;
    u_xlat10_8 = texture(_LightningTex, u_xlat8.xy).x;
    u_xlat16_8 = u_xlat10_8 * _LightningBrightness;
    u_xlat2.x = u_xlat16_8 * u_xlat2.x;
    u_xlat19 = u_xlat10_19 * _CloudIntensity + u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat16_4.xyz + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(_LightningToggle==1.0);
#else
    u_xlatb19 = _LightningToggle==1.0;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb19)) ? u_xlat2.xyz : u_xlat1.xyz;
    u_xlat0.w = u_xlat10_12.y * _Opacity;
    u_xlat1.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat13 = u_xlat1.x * _HeigtFogParams.y;
    u_xlat2.x = u_xlat1.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat8.x = (-u_xlat2.x) + 2.0;
    u_xlat2.x = u_xlat8.x * u_xlat2.x;
    u_xlat8.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!((-u_xlat19)>=u_xlat8.x);
#else
    u_xlatb19 = (-u_xlat19)>=u_xlat8.x;
#endif
    u_xlat8.x = u_xlat2.x * _HeigtFogColDelta.w;
    u_xlat19 = (u_xlatb19) ? u_xlat8.x : u_xlat2.x;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * unity_FogColor.w;
    u_xlat19 = exp2(u_xlat19);
    u_xlat19 = min(u_xlat19, _HeigtFogColBase.w);
    u_xlat2.x = vs_TEXCOORD4.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_21 = (-u_xlat2.x) + 2.0;
    u_xlat16_21 = u_xlat2.x * u_xlat16_21;
    u_xlat2.xyz = vec3(u_xlat16_21) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat20 = u_xlat1.x + (-_HeigtFogRamp.w);
    u_xlat20 = u_xlat20 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat2.xyz = vec3(u_xlat20) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat20 = u_xlat1.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat20));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat20);
#endif
    u_xlat10 = u_xlat20 * -1.44269502;
    u_xlat10 = exp2(u_xlat10);
    u_xlat10 = (-u_xlat10) + 1.0;
    u_xlat20 = u_xlat10 / u_xlat20;
    u_xlat16_21 = (u_xlatb4) ? u_xlat20 : 1.0;
    u_xlat7 = u_xlat1.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(0.00999999978<abs(u_xlat7));
#else
    u_xlatb20 = 0.00999999978<abs(u_xlat7);
#endif
    u_xlat4.x = u_xlat7 * -1.44269502;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat7 = u_xlat4.x / u_xlat7;
    u_xlat16_5 = (u_xlatb20) ? u_xlat7 : 1.0;
    u_xlat7 = u_xlat1.x * _HeigtFogParams2.y;
    u_xlat16_21 = u_xlat13 * u_xlat16_21;
    u_xlat16_5 = u_xlat7 * u_xlat16_5;
    u_xlat16_21 = exp2((-u_xlat16_21));
    u_xlat16_21 = (-u_xlat16_21) + 1.0;
    u_xlat16_21 = max(u_xlat16_21, 0.0);
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_5 = max(u_xlat16_5, 0.0);
    u_xlat16_21 = u_xlat16_21 + u_xlat16_5;
    u_xlat1.x = u_xlat1.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat1.x) + 2.0;
    u_xlat16_5 = u_xlat1.x * u_xlat16_5;
    u_xlat1.x = u_xlat16_5 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat16_21 = u_xlat1.x * u_xlat16_21;
    u_xlat1.x = min(u_xlat16_21, _HeigtFogColBase.w);
    u_xlat7 = vs_TEXCOORD4.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat7) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat7 = (-u_xlat1.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat7) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat4.xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.x = (-u_xlat19) + 1.0;
    u_xlat1.x = u_xlat7 * u_xlat1.x;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat16_3.xyz + u_xlat2.xyz;
    SV_Target0 = u_xlat0;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
bool u_xlatb7;
vec3 u_xlat9;
mediump float u_xlat16_10;
float u_xlat14;
float u_xlat15;
float u_xlat16;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.xxxx * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1] * in_POSITION0.yyyy + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat7.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat7.xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat7.xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat7.xyz;
    vs_TEXCOORD4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat7.xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat7.xyz;
    u_xlat2.xyz = u_xlat7.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat7.x = u_xlat2.y * _HeigtFogParams.x;
    u_xlat21 = u_xlat7.x * -1.44269502;
    u_xlat21 = exp2(u_xlat21);
    u_xlat21 = (-u_xlat21) + 1.0;
    u_xlat21 = u_xlat21 / u_xlat7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.00999999978<abs(u_xlat7.x));
#else
    u_xlatb7 = 0.00999999978<abs(u_xlat7.x);
#endif
    u_xlat16_3.x = (u_xlatb7) ? u_xlat21 : 1.0;
    u_xlat7.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat21 = u_xlat7.x * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat21 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat21 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat15 = u_xlat21 * -1.44269502;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 / u_xlat21;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.00999999978<abs(u_xlat21));
#else
    u_xlatb21 = 0.00999999978<abs(u_xlat21);
#endif
    u_xlat16_10 = (u_xlatb21) ? u_xlat15 : 1.0;
    u_xlat21 = u_xlat7.x * _HeigtFogParams2.y;
    u_xlat16_10 = u_xlat21 * u_xlat16_10;
    u_xlat16_10 = exp2((-u_xlat16_10));
    u_xlat16_3.y = (-u_xlat16_10) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat21 = u_xlat7.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat21) + 2.0;
    u_xlat16_10 = u_xlat21 * u_xlat16_10;
    u_xlat21 = u_xlat16_10 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_3.x = u_xlat21 * u_xlat16_3.x;
    u_xlat21 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat15 = (-u_xlat21) + 1.0;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat9.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat9.x);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat9.x;
#endif
    u_xlat9.x = u_xlat7.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat7.x + (-_HeigtFogRamp.w);
    u_xlat7.x = u_xlat7.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat9.x) + 2.0;
    u_xlat9.x = u_xlat16 * u_xlat9.x;
    u_xlat16 = u_xlat9.x * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat16 : u_xlat9.x;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat9.x = u_xlat7.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat14 = u_xlat7.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat14) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat16_3.x = (-u_xlat9.x) + 2.0;
    u_xlat16_3.x = u_xlat9.x * u_xlat16_3.x;
    u_xlat9.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat5.xyz = (-u_xlat9.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat9.xyz = u_xlat7.xxx * u_xlat5.xyz + u_xlat9.xyz;
    u_xlat9.xyz = u_xlat2.xxx * u_xlat9.xyz;
    u_xlat7.x = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat15 * u_xlat7.x;
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat9.xyz;
    vs_TEXCOORD0.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat2.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat16_3.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_3.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_3.x);
    u_xlat16_2 = u_xlat0.yzwx * u_xlat0.xywz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_6.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_6.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat1.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.w = u_xlat0.x * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    vs_TEXCOORD4.w = 0.0;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _MianTex_Uspeed;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTex_Vspeed;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Scaler;
uniform 	mediump float _Opacity;
uniform 	mediump float _LightningToggle;
uniform 	vec4 _CloudColorA;
uniform 	vec4 _CloudColorB;
uniform 	mediump float _UseTwoCloudTex;
uniform 	float _SecTexUspeed;
uniform 	vec4 _SecTex_ST;
uniform 	float _SecTexVspeed;
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
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SecTex;
uniform lowp sampler2D _CloudTex01;
uniform lowp sampler2D _FlashCloudTex;
uniform lowp sampler2D _LightningTex;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp vec2 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
lowp float u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
bool u_xlatb4;
mediump float u_xlat16_5;
float u_xlat7;
vec2 u_xlat8;
mediump float u_xlat16_8;
lowp float u_xlat10_8;
float u_xlat10;
lowp vec2 u_xlat10_12;
float u_xlat13;
vec2 u_xlat14;
float u_xlat19;
lowp float u_xlat10_19;
bool u_xlatb19;
float u_xlat20;
bool u_xlatb20;
mediump float u_xlat16_21;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = _Time.y * _MianTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _MainTex_Vspeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD3.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat2.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.y;
    u_xlat10_0.xy = texture(_NoiseTex, u_xlat2.xy).xy;
    u_xlat16_3.xy = u_xlat10_0.xy * vec2(_Noise_Scaler) + u_xlat1.xy;
    u_xlat10_12.xy = texture(_MainTex, u_xlat16_3.xy).xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UseTwoCloudTex==1.0);
#else
    u_xlatb1 = _UseTwoCloudTex==1.0;
#endif
    if(u_xlatb1){
        u_xlat1.xy = vs_TEXCOORD3.xy * _SecTex_ST.xy + _SecTex_ST.zw;
        u_xlat2.x = _Time.y * _SecTexUspeed + u_xlat1.x;
        u_xlat2.y = _Time.y * _SecTexVspeed + u_xlat1.y;
        u_xlat16_3.xy = u_xlat10_0.xy * vec2(_Noise_Scaler) + u_xlat2.xy;
        u_xlat10_0.x = texture(_SecTex, u_xlat16_3.xy).x;
        u_xlat16_0 = u_xlat10_12.x + u_xlat10_0.x;
        u_xlat16_0 = u_xlat16_0;
    } else {
        u_xlat16_0 = u_xlat10_12.x;
    //ENDIF
    }
    u_xlat1.xyz = (-_CloudColorA.xyz) + _CloudColorB.xyz;
    u_xlat1.xyz = vec3(u_xlat16_0) * u_xlat1.xyz + _CloudColorA.xyz;
    u_xlat19 = _Time.y * _FlashFrequency;
    u_xlat2.xy = vs_TEXCOORD3.xy * _FlashCloudTex_ST.xy + _FlashCloudTex_ST.zw;
    u_xlat19 = sin(u_xlat19);
    u_xlat19 = u_xlat19 * _FlashSpeed;
    u_xlat2.xy = vec2(u_xlat19) * vec2(0.300000012, 2.0) + u_xlat2.xy;
    u_xlat14.xy = vs_TEXCOORD3.xy * _CloudTex01_ST.xy + _CloudTex01_ST.zw;
    u_xlat14.xy = _Time.yy * vec2(_CloudTex01Speed) + u_xlat14.xy;
    u_xlat10_19 = texture(_CloudTex01, u_xlat14.xy).x;
    u_xlat14.xy = vs_TEXCOORD3.xy * _LightningTex_ST.xy + _LightningTex_ST.zw;
    u_xlat10_2 = texture(_FlashCloudTex, u_xlat2.xy).x;
    u_xlat16_4.xyz = vec3(u_xlat10_2) * _FlashColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(_FlashBrightness);
    u_xlat2.x = u_xlat10_19 + _CloudOffset;
    u_xlat2.x = u_xlat2.x * _CloudScaler;
    u_xlat8.xy = _Time.yy * vec2(_LightningTexSpeed) + u_xlat14.xy;
    u_xlat10_8 = texture(_LightningTex, u_xlat8.xy).x;
    u_xlat16_8 = u_xlat10_8 * _LightningBrightness;
    u_xlat2.x = u_xlat16_8 * u_xlat2.x;
    u_xlat19 = u_xlat10_19 * _CloudIntensity + u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat16_4.xyz + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(_LightningToggle==1.0);
#else
    u_xlatb19 = _LightningToggle==1.0;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb19)) ? u_xlat2.xyz : u_xlat1.xyz;
    u_xlat0.w = u_xlat10_12.y * _Opacity;
    u_xlat1.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat13 = u_xlat1.x * _HeigtFogParams.y;
    u_xlat2.x = u_xlat1.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat8.x = (-u_xlat2.x) + 2.0;
    u_xlat2.x = u_xlat8.x * u_xlat2.x;
    u_xlat8.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!((-u_xlat19)>=u_xlat8.x);
#else
    u_xlatb19 = (-u_xlat19)>=u_xlat8.x;
#endif
    u_xlat8.x = u_xlat2.x * _HeigtFogColDelta.w;
    u_xlat19 = (u_xlatb19) ? u_xlat8.x : u_xlat2.x;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * unity_FogColor.w;
    u_xlat19 = exp2(u_xlat19);
    u_xlat19 = min(u_xlat19, _HeigtFogColBase.w);
    u_xlat2.x = vs_TEXCOORD4.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_21 = (-u_xlat2.x) + 2.0;
    u_xlat16_21 = u_xlat2.x * u_xlat16_21;
    u_xlat2.xyz = vec3(u_xlat16_21) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat20 = u_xlat1.x + (-_HeigtFogRamp.w);
    u_xlat20 = u_xlat20 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat2.xyz = vec3(u_xlat20) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat20 = u_xlat1.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat20));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat20);
#endif
    u_xlat10 = u_xlat20 * -1.44269502;
    u_xlat10 = exp2(u_xlat10);
    u_xlat10 = (-u_xlat10) + 1.0;
    u_xlat20 = u_xlat10 / u_xlat20;
    u_xlat16_21 = (u_xlatb4) ? u_xlat20 : 1.0;
    u_xlat7 = u_xlat1.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(0.00999999978<abs(u_xlat7));
#else
    u_xlatb20 = 0.00999999978<abs(u_xlat7);
#endif
    u_xlat4.x = u_xlat7 * -1.44269502;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat7 = u_xlat4.x / u_xlat7;
    u_xlat16_5 = (u_xlatb20) ? u_xlat7 : 1.0;
    u_xlat7 = u_xlat1.x * _HeigtFogParams2.y;
    u_xlat16_21 = u_xlat13 * u_xlat16_21;
    u_xlat16_5 = u_xlat7 * u_xlat16_5;
    u_xlat16_21 = exp2((-u_xlat16_21));
    u_xlat16_21 = (-u_xlat16_21) + 1.0;
    u_xlat16_21 = max(u_xlat16_21, 0.0);
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_5 = max(u_xlat16_5, 0.0);
    u_xlat16_21 = u_xlat16_21 + u_xlat16_5;
    u_xlat1.x = u_xlat1.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat1.x) + 2.0;
    u_xlat16_5 = u_xlat1.x * u_xlat16_5;
    u_xlat1.x = u_xlat16_5 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat16_21 = u_xlat1.x * u_xlat16_21;
    u_xlat1.x = min(u_xlat16_21, _HeigtFogColBase.w);
    u_xlat7 = vs_TEXCOORD4.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat7) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat7 = (-u_xlat1.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat7) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat4.xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.x = (-u_xlat19) + 1.0;
    u_xlat1.x = u_xlat7 * u_xlat1.x;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat16_3.xyz + u_xlat2.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "MSAA_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat7;
float u_xlat9;
mediump float u_xlat16_10;
float u_xlat14;
bool u_xlatb14;
float u_xlat16;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
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
    u_xlat0.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position = u_xlat0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat14 = u_xlat2.y * _HeigtFogParams.x;
    u_xlat22 = u_xlat14 * -1.44269502;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = (-u_xlat22) + 1.0;
    u_xlat22 = u_xlat22 / u_xlat14;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(0.00999999978<abs(u_xlat14));
#else
    u_xlatb14 = 0.00999999978<abs(u_xlat14);
#endif
    u_xlat16_3.x = (u_xlatb14) ? u_xlat22 : 1.0;
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = sqrt(u_xlat14);
    u_xlat22 = u_xlat14 * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat22 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat23 = u_xlat22 * -1.44269502;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat23 = u_xlat23 / u_xlat22;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(0.00999999978<abs(u_xlat22));
#else
    u_xlatb22 = 0.00999999978<abs(u_xlat22);
#endif
    u_xlat16_10 = (u_xlatb22) ? u_xlat23 : 1.0;
    u_xlat22 = u_xlat14 * _HeigtFogParams2.y;
    u_xlat16_10 = u_xlat22 * u_xlat16_10;
    u_xlat16_10 = exp2((-u_xlat16_10));
    u_xlat16_3.y = (-u_xlat16_10) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat22 = u_xlat14 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat22) + 2.0;
    u_xlat16_10 = u_xlat22 * u_xlat16_10;
    u_xlat22 = u_xlat16_10 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat22 = u_xlat22 + 1.0;
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat22 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat23 = (-u_xlat22) + 1.0;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat9 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat9);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat9;
#endif
    u_xlat9 = u_xlat14 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat14 = u_xlat14 + (-_HeigtFogRamp.w);
    u_xlat14 = u_xlat14 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat9) + 2.0;
    u_xlat9 = u_xlat16 * u_xlat9;
    u_xlat16 = u_xlat9 * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat16 : u_xlat9;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat9 = u_xlat1.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat9) + 2.0;
    u_xlat16_3.x = u_xlat9 * u_xlat16_3.x;
    u_xlat4.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat5.xyz = (-u_xlat4.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat4.xyz = vec3(u_xlat14) * u_xlat5.xyz + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat2.xxx * u_xlat4.xyz;
    u_xlat14 = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat23 * u_xlat14;
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat4.xyz;
    u_xlat14 = u_xlat1.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.xyz = vec3(u_xlat14) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz * vec3(u_xlat22) + u_xlat2.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat1 = vec4(u_xlat14) * u_xlat1.xyzz;
    u_xlat16_3.x = u_xlat1.y * u_xlat1.y;
    u_xlat16_3.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_3.x);
    u_xlat16_2 = u_xlat1.yzwx * u_xlat1.xywz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_6.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_6.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat7 = u_xlat0.y * _ProjectionParams.x;
    u_xlat0.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.w = u_xlat7 * 0.5;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    vs_TEXCOORD4.w = 0.0;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	float _MianTex_Uspeed;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTex_Vspeed;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Scaler;
uniform 	mediump float _Opacity;
uniform 	mediump float _LightningToggle;
uniform 	vec4 _CloudColorA;
uniform 	vec4 _CloudColorB;
uniform 	mediump float _UseTwoCloudTex;
uniform 	float _SecTexUspeed;
uniform 	vec4 _SecTex_ST;
uniform 	float _SecTexVspeed;
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
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SecTex;
uniform lowp sampler2D _CloudTex01;
uniform lowp sampler2D _FlashCloudTex;
uniform lowp sampler2D _LightningTex;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp vec2 u_xlat10_0;
vec3 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
lowp float u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
bool u_xlatb4;
mediump float u_xlat16_5;
float u_xlat7;
vec2 u_xlat8;
mediump float u_xlat16_8;
lowp float u_xlat10_8;
float u_xlat10;
lowp vec2 u_xlat10_12;
float u_xlat13;
vec2 u_xlat14;
float u_xlat19;
lowp float u_xlat10_19;
bool u_xlatb19;
float u_xlat20;
bool u_xlatb20;
mediump float u_xlat16_21;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = _Time.y * _MianTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _MainTex_Vspeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD3.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat2.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.y;
    u_xlat10_0.xy = texture(_NoiseTex, u_xlat2.xy).xy;
    u_xlat16_3.xy = u_xlat10_0.xy * vec2(_Noise_Scaler) + u_xlat1.xy;
    u_xlat10_12.xy = texture(_MainTex, u_xlat16_3.xy).xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UseTwoCloudTex==1.0);
#else
    u_xlatb1 = _UseTwoCloudTex==1.0;
#endif
    if(u_xlatb1){
        u_xlat1.xy = vs_TEXCOORD3.xy * _SecTex_ST.xy + _SecTex_ST.zw;
        u_xlat2.x = _Time.y * _SecTexUspeed + u_xlat1.x;
        u_xlat2.y = _Time.y * _SecTexVspeed + u_xlat1.y;
        u_xlat16_3.xy = u_xlat10_0.xy * vec2(_Noise_Scaler) + u_xlat2.xy;
        u_xlat10_0.x = texture(_SecTex, u_xlat16_3.xy).x;
        u_xlat16_0 = u_xlat10_12.x + u_xlat10_0.x;
        u_xlat16_0 = u_xlat16_0;
    } else {
        u_xlat16_0 = u_xlat10_12.x;
    //ENDIF
    }
    u_xlat1.xyz = (-_CloudColorA.xyz) + _CloudColorB.xyz;
    u_xlat1.xyz = vec3(u_xlat16_0) * u_xlat1.xyz + _CloudColorA.xyz;
    u_xlat19 = _Time.y * _FlashFrequency;
    u_xlat2.xy = vs_TEXCOORD3.xy * _FlashCloudTex_ST.xy + _FlashCloudTex_ST.zw;
    u_xlat19 = sin(u_xlat19);
    u_xlat19 = u_xlat19 * _FlashSpeed;
    u_xlat2.xy = vec2(u_xlat19) * vec2(0.300000012, 2.0) + u_xlat2.xy;
    u_xlat14.xy = vs_TEXCOORD3.xy * _CloudTex01_ST.xy + _CloudTex01_ST.zw;
    u_xlat14.xy = _Time.yy * vec2(_CloudTex01Speed) + u_xlat14.xy;
    u_xlat10_19 = texture(_CloudTex01, u_xlat14.xy).x;
    u_xlat14.xy = vs_TEXCOORD3.xy * _LightningTex_ST.xy + _LightningTex_ST.zw;
    u_xlat10_2 = texture(_FlashCloudTex, u_xlat2.xy).x;
    u_xlat16_4.xyz = vec3(u_xlat10_2) * _FlashColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(_FlashBrightness);
    u_xlat2.x = u_xlat10_19 + _CloudOffset;
    u_xlat2.x = u_xlat2.x * _CloudScaler;
    u_xlat8.xy = _Time.yy * vec2(_LightningTexSpeed) + u_xlat14.xy;
    u_xlat10_8 = texture(_LightningTex, u_xlat8.xy).x;
    u_xlat16_8 = u_xlat10_8 * _LightningBrightness;
    u_xlat2.x = u_xlat16_8 * u_xlat2.x;
    u_xlat19 = u_xlat10_19 * _CloudIntensity + u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat16_4.xyz + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(_LightningToggle==1.0);
#else
    u_xlatb19 = _LightningToggle==1.0;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb19)) ? u_xlat2.xyz : u_xlat1.xyz;
    u_xlat0.w = u_xlat10_12.y * _Opacity;
    u_xlat1.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat13 = u_xlat1.x * _HeigtFogParams.y;
    u_xlat2.x = u_xlat1.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat8.x = (-u_xlat2.x) + 2.0;
    u_xlat2.x = u_xlat8.x * u_xlat2.x;
    u_xlat8.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!((-u_xlat19)>=u_xlat8.x);
#else
    u_xlatb19 = (-u_xlat19)>=u_xlat8.x;
#endif
    u_xlat8.x = u_xlat2.x * _HeigtFogColDelta.w;
    u_xlat19 = (u_xlatb19) ? u_xlat8.x : u_xlat2.x;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * unity_FogColor.w;
    u_xlat19 = exp2(u_xlat19);
    u_xlat19 = min(u_xlat19, _HeigtFogColBase.w);
    u_xlat2.x = vs_TEXCOORD4.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_21 = (-u_xlat2.x) + 2.0;
    u_xlat16_21 = u_xlat2.x * u_xlat16_21;
    u_xlat2.xyz = vec3(u_xlat16_21) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat20 = u_xlat1.x + (-_HeigtFogRamp.w);
    u_xlat20 = u_xlat20 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat2.xyz = vec3(u_xlat20) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat20 = u_xlat1.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat20));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat20);
#endif
    u_xlat10 = u_xlat20 * -1.44269502;
    u_xlat10 = exp2(u_xlat10);
    u_xlat10 = (-u_xlat10) + 1.0;
    u_xlat20 = u_xlat10 / u_xlat20;
    u_xlat16_21 = (u_xlatb4) ? u_xlat20 : 1.0;
    u_xlat7 = u_xlat1.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(0.00999999978<abs(u_xlat7));
#else
    u_xlatb20 = 0.00999999978<abs(u_xlat7);
#endif
    u_xlat4.x = u_xlat7 * -1.44269502;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat7 = u_xlat4.x / u_xlat7;
    u_xlat16_5 = (u_xlatb20) ? u_xlat7 : 1.0;
    u_xlat7 = u_xlat1.x * _HeigtFogParams2.y;
    u_xlat16_21 = u_xlat13 * u_xlat16_21;
    u_xlat16_5 = u_xlat7 * u_xlat16_5;
    u_xlat16_21 = exp2((-u_xlat16_21));
    u_xlat16_21 = (-u_xlat16_21) + 1.0;
    u_xlat16_21 = max(u_xlat16_21, 0.0);
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_5 = max(u_xlat16_5, 0.0);
    u_xlat16_21 = u_xlat16_21 + u_xlat16_5;
    u_xlat1.x = u_xlat1.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat1.x) + 2.0;
    u_xlat16_5 = u_xlat1.x * u_xlat16_5;
    u_xlat1.x = u_xlat16_5 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat16_21 = u_xlat1.x * u_xlat16_21;
    u_xlat1.x = min(u_xlat16_21, _HeigtFogColBase.w);
    u_xlat7 = vs_TEXCOORD4.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat7) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat7 = (-u_xlat1.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat7) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat4.xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.x = (-u_xlat19) + 1.0;
    u_xlat1.x = u_xlat7 * u_xlat1.x;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat16_3.xyz + u_xlat2.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "MSAA_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
bool u_xlatb7;
vec3 u_xlat9;
mediump float u_xlat16_10;
float u_xlat14;
float u_xlat15;
float u_xlat16;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.xxxx * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1] * in_POSITION0.yyyy + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat7.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat7.xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat7.xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat7.xyz;
    vs_TEXCOORD4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat7.xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat7.xyz;
    u_xlat2.xyz = u_xlat7.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat7.x = u_xlat2.y * _HeigtFogParams.x;
    u_xlat21 = u_xlat7.x * -1.44269502;
    u_xlat21 = exp2(u_xlat21);
    u_xlat21 = (-u_xlat21) + 1.0;
    u_xlat21 = u_xlat21 / u_xlat7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.00999999978<abs(u_xlat7.x));
#else
    u_xlatb7 = 0.00999999978<abs(u_xlat7.x);
#endif
    u_xlat16_3.x = (u_xlatb7) ? u_xlat21 : 1.0;
    u_xlat7.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat21 = u_xlat7.x * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat21 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat21 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat15 = u_xlat21 * -1.44269502;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 / u_xlat21;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.00999999978<abs(u_xlat21));
#else
    u_xlatb21 = 0.00999999978<abs(u_xlat21);
#endif
    u_xlat16_10 = (u_xlatb21) ? u_xlat15 : 1.0;
    u_xlat21 = u_xlat7.x * _HeigtFogParams2.y;
    u_xlat16_10 = u_xlat21 * u_xlat16_10;
    u_xlat16_10 = exp2((-u_xlat16_10));
    u_xlat16_3.y = (-u_xlat16_10) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat21 = u_xlat7.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat21) + 2.0;
    u_xlat16_10 = u_xlat21 * u_xlat16_10;
    u_xlat21 = u_xlat16_10 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_3.x = u_xlat21 * u_xlat16_3.x;
    u_xlat21 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat15 = (-u_xlat21) + 1.0;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat9.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat9.x);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat9.x;
#endif
    u_xlat9.x = u_xlat7.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat7.x + (-_HeigtFogRamp.w);
    u_xlat7.x = u_xlat7.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat9.x) + 2.0;
    u_xlat9.x = u_xlat16 * u_xlat9.x;
    u_xlat16 = u_xlat9.x * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat16 : u_xlat9.x;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat9.x = u_xlat7.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat14 = u_xlat7.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat14) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat16_3.x = (-u_xlat9.x) + 2.0;
    u_xlat16_3.x = u_xlat9.x * u_xlat16_3.x;
    u_xlat9.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat5.xyz = (-u_xlat9.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat9.xyz = u_xlat7.xxx * u_xlat5.xyz + u_xlat9.xyz;
    u_xlat9.xyz = u_xlat2.xxx * u_xlat9.xyz;
    u_xlat7.x = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat15 * u_xlat7.x;
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat9.xyz;
    vs_TEXCOORD0.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat2.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat16_3.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_3.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_3.x);
    u_xlat16_2 = u_xlat0.yzwx * u_xlat0.xywz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_6.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_6.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat1.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.w = u_xlat0.x * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    vs_TEXCOORD4.w = 0.0;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	float _MianTex_Uspeed;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTex_Vspeed;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Scaler;
uniform 	mediump float _Opacity;
uniform 	mediump float _LightningToggle;
uniform 	vec4 _CloudColorA;
uniform 	vec4 _CloudColorB;
uniform 	mediump float _UseTwoCloudTex;
uniform 	float _SecTexUspeed;
uniform 	vec4 _SecTex_ST;
uniform 	float _SecTexVspeed;
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
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SecTex;
uniform lowp sampler2D _CloudTex01;
uniform lowp sampler2D _FlashCloudTex;
uniform lowp sampler2D _LightningTex;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp vec2 u_xlat10_0;
vec3 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
lowp float u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
bool u_xlatb4;
mediump float u_xlat16_5;
float u_xlat7;
vec2 u_xlat8;
mediump float u_xlat16_8;
lowp float u_xlat10_8;
float u_xlat10;
lowp vec2 u_xlat10_12;
float u_xlat13;
vec2 u_xlat14;
float u_xlat19;
lowp float u_xlat10_19;
bool u_xlatb19;
float u_xlat20;
bool u_xlatb20;
mediump float u_xlat16_21;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = _Time.y * _MianTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _MainTex_Vspeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD3.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat2.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.y;
    u_xlat10_0.xy = texture(_NoiseTex, u_xlat2.xy).xy;
    u_xlat16_3.xy = u_xlat10_0.xy * vec2(_Noise_Scaler) + u_xlat1.xy;
    u_xlat10_12.xy = texture(_MainTex, u_xlat16_3.xy).xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UseTwoCloudTex==1.0);
#else
    u_xlatb1 = _UseTwoCloudTex==1.0;
#endif
    if(u_xlatb1){
        u_xlat1.xy = vs_TEXCOORD3.xy * _SecTex_ST.xy + _SecTex_ST.zw;
        u_xlat2.x = _Time.y * _SecTexUspeed + u_xlat1.x;
        u_xlat2.y = _Time.y * _SecTexVspeed + u_xlat1.y;
        u_xlat16_3.xy = u_xlat10_0.xy * vec2(_Noise_Scaler) + u_xlat2.xy;
        u_xlat10_0.x = texture(_SecTex, u_xlat16_3.xy).x;
        u_xlat16_0 = u_xlat10_12.x + u_xlat10_0.x;
        u_xlat16_0 = u_xlat16_0;
    } else {
        u_xlat16_0 = u_xlat10_12.x;
    //ENDIF
    }
    u_xlat1.xyz = (-_CloudColorA.xyz) + _CloudColorB.xyz;
    u_xlat1.xyz = vec3(u_xlat16_0) * u_xlat1.xyz + _CloudColorA.xyz;
    u_xlat19 = _Time.y * _FlashFrequency;
    u_xlat2.xy = vs_TEXCOORD3.xy * _FlashCloudTex_ST.xy + _FlashCloudTex_ST.zw;
    u_xlat19 = sin(u_xlat19);
    u_xlat19 = u_xlat19 * _FlashSpeed;
    u_xlat2.xy = vec2(u_xlat19) * vec2(0.300000012, 2.0) + u_xlat2.xy;
    u_xlat14.xy = vs_TEXCOORD3.xy * _CloudTex01_ST.xy + _CloudTex01_ST.zw;
    u_xlat14.xy = _Time.yy * vec2(_CloudTex01Speed) + u_xlat14.xy;
    u_xlat10_19 = texture(_CloudTex01, u_xlat14.xy).x;
    u_xlat14.xy = vs_TEXCOORD3.xy * _LightningTex_ST.xy + _LightningTex_ST.zw;
    u_xlat10_2 = texture(_FlashCloudTex, u_xlat2.xy).x;
    u_xlat16_4.xyz = vec3(u_xlat10_2) * _FlashColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(_FlashBrightness);
    u_xlat2.x = u_xlat10_19 + _CloudOffset;
    u_xlat2.x = u_xlat2.x * _CloudScaler;
    u_xlat8.xy = _Time.yy * vec2(_LightningTexSpeed) + u_xlat14.xy;
    u_xlat10_8 = texture(_LightningTex, u_xlat8.xy).x;
    u_xlat16_8 = u_xlat10_8 * _LightningBrightness;
    u_xlat2.x = u_xlat16_8 * u_xlat2.x;
    u_xlat19 = u_xlat10_19 * _CloudIntensity + u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat16_4.xyz + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(_LightningToggle==1.0);
#else
    u_xlatb19 = _LightningToggle==1.0;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb19)) ? u_xlat2.xyz : u_xlat1.xyz;
    u_xlat0.w = u_xlat10_12.y * _Opacity;
    u_xlat1.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat13 = u_xlat1.x * _HeigtFogParams.y;
    u_xlat2.x = u_xlat1.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat8.x = (-u_xlat2.x) + 2.0;
    u_xlat2.x = u_xlat8.x * u_xlat2.x;
    u_xlat8.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!((-u_xlat19)>=u_xlat8.x);
#else
    u_xlatb19 = (-u_xlat19)>=u_xlat8.x;
#endif
    u_xlat8.x = u_xlat2.x * _HeigtFogColDelta.w;
    u_xlat19 = (u_xlatb19) ? u_xlat8.x : u_xlat2.x;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * unity_FogColor.w;
    u_xlat19 = exp2(u_xlat19);
    u_xlat19 = min(u_xlat19, _HeigtFogColBase.w);
    u_xlat2.x = vs_TEXCOORD4.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_21 = (-u_xlat2.x) + 2.0;
    u_xlat16_21 = u_xlat2.x * u_xlat16_21;
    u_xlat2.xyz = vec3(u_xlat16_21) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat20 = u_xlat1.x + (-_HeigtFogRamp.w);
    u_xlat20 = u_xlat20 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat2.xyz = vec3(u_xlat20) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat20 = u_xlat1.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat20));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat20);
#endif
    u_xlat10 = u_xlat20 * -1.44269502;
    u_xlat10 = exp2(u_xlat10);
    u_xlat10 = (-u_xlat10) + 1.0;
    u_xlat20 = u_xlat10 / u_xlat20;
    u_xlat16_21 = (u_xlatb4) ? u_xlat20 : 1.0;
    u_xlat7 = u_xlat1.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(0.00999999978<abs(u_xlat7));
#else
    u_xlatb20 = 0.00999999978<abs(u_xlat7);
#endif
    u_xlat4.x = u_xlat7 * -1.44269502;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat7 = u_xlat4.x / u_xlat7;
    u_xlat16_5 = (u_xlatb20) ? u_xlat7 : 1.0;
    u_xlat7 = u_xlat1.x * _HeigtFogParams2.y;
    u_xlat16_21 = u_xlat13 * u_xlat16_21;
    u_xlat16_5 = u_xlat7 * u_xlat16_5;
    u_xlat16_21 = exp2((-u_xlat16_21));
    u_xlat16_21 = (-u_xlat16_21) + 1.0;
    u_xlat16_21 = max(u_xlat16_21, 0.0);
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_5 = max(u_xlat16_5, 0.0);
    u_xlat16_21 = u_xlat16_21 + u_xlat16_5;
    u_xlat1.x = u_xlat1.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat1.x) + 2.0;
    u_xlat16_5 = u_xlat1.x * u_xlat16_5;
    u_xlat1.x = u_xlat16_5 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat16_21 = u_xlat1.x * u_xlat16_21;
    u_xlat1.x = min(u_xlat16_21, _HeigtFogColBase.w);
    u_xlat7 = vs_TEXCOORD4.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat7) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat7 = (-u_xlat1.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat7) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat4.xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.x = (-u_xlat19) + 1.0;
    u_xlat1.x = u_xlat7 * u_xlat1.x;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat16_3.xyz + u_xlat2.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "MSAA_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat7;
float u_xlat9;
mediump float u_xlat16_10;
float u_xlat14;
bool u_xlatb14;
float u_xlat16;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
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
    u_xlat0.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position = u_xlat0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat14 = u_xlat2.y * _HeigtFogParams.x;
    u_xlat22 = u_xlat14 * -1.44269502;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = (-u_xlat22) + 1.0;
    u_xlat22 = u_xlat22 / u_xlat14;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(0.00999999978<abs(u_xlat14));
#else
    u_xlatb14 = 0.00999999978<abs(u_xlat14);
#endif
    u_xlat16_3.x = (u_xlatb14) ? u_xlat22 : 1.0;
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = sqrt(u_xlat14);
    u_xlat22 = u_xlat14 * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat22 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat23 = u_xlat22 * -1.44269502;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat23 = u_xlat23 / u_xlat22;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(0.00999999978<abs(u_xlat22));
#else
    u_xlatb22 = 0.00999999978<abs(u_xlat22);
#endif
    u_xlat16_10 = (u_xlatb22) ? u_xlat23 : 1.0;
    u_xlat22 = u_xlat14 * _HeigtFogParams2.y;
    u_xlat16_10 = u_xlat22 * u_xlat16_10;
    u_xlat16_10 = exp2((-u_xlat16_10));
    u_xlat16_3.y = (-u_xlat16_10) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat22 = u_xlat14 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat22) + 2.0;
    u_xlat16_10 = u_xlat22 * u_xlat16_10;
    u_xlat22 = u_xlat16_10 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat22 = u_xlat22 + 1.0;
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat22 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat23 = (-u_xlat22) + 1.0;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat9 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat9);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat9;
#endif
    u_xlat9 = u_xlat14 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat14 = u_xlat14 + (-_HeigtFogRamp.w);
    u_xlat14 = u_xlat14 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat9) + 2.0;
    u_xlat9 = u_xlat16 * u_xlat9;
    u_xlat16 = u_xlat9 * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat16 : u_xlat9;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat9 = u_xlat1.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat9) + 2.0;
    u_xlat16_3.x = u_xlat9 * u_xlat16_3.x;
    u_xlat4.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat5.xyz = (-u_xlat4.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat4.xyz = vec3(u_xlat14) * u_xlat5.xyz + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat2.xxx * u_xlat4.xyz;
    u_xlat14 = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat23 * u_xlat14;
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat4.xyz;
    u_xlat14 = u_xlat1.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.xyz = vec3(u_xlat14) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz * vec3(u_xlat22) + u_xlat2.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat1 = vec4(u_xlat14) * u_xlat1.xyzz;
    u_xlat16_3.x = u_xlat1.y * u_xlat1.y;
    u_xlat16_3.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_3.x);
    u_xlat16_2 = u_xlat1.yzwx * u_xlat1.xywz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_6.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_6.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat7 = u_xlat0.y * _ProjectionParams.x;
    u_xlat0.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.w = u_xlat7 * 0.5;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    vs_TEXCOORD4.w = 0.0;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _MianTex_Uspeed;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTex_Vspeed;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Scaler;
uniform 	mediump float _Opacity;
uniform 	mediump float _LightningToggle;
uniform 	vec4 _CloudColorA;
uniform 	vec4 _CloudColorB;
uniform 	mediump float _UseTwoCloudTex;
uniform 	float _SecTexUspeed;
uniform 	vec4 _SecTex_ST;
uniform 	float _SecTexVspeed;
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
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SecTex;
uniform lowp sampler2D _CloudTex01;
uniform lowp sampler2D _FlashCloudTex;
uniform lowp sampler2D _LightningTex;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp vec2 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
lowp float u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
bool u_xlatb4;
mediump float u_xlat16_5;
float u_xlat7;
vec2 u_xlat8;
mediump float u_xlat16_8;
lowp float u_xlat10_8;
float u_xlat10;
lowp vec2 u_xlat10_12;
float u_xlat13;
vec2 u_xlat14;
float u_xlat19;
lowp float u_xlat10_19;
bool u_xlatb19;
float u_xlat20;
bool u_xlatb20;
mediump float u_xlat16_21;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = _Time.y * _MianTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _MainTex_Vspeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD3.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat2.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.y;
    u_xlat10_0.xy = texture(_NoiseTex, u_xlat2.xy).xy;
    u_xlat16_3.xy = u_xlat10_0.xy * vec2(_Noise_Scaler) + u_xlat1.xy;
    u_xlat10_12.xy = texture(_MainTex, u_xlat16_3.xy).xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UseTwoCloudTex==1.0);
#else
    u_xlatb1 = _UseTwoCloudTex==1.0;
#endif
    if(u_xlatb1){
        u_xlat1.xy = vs_TEXCOORD3.xy * _SecTex_ST.xy + _SecTex_ST.zw;
        u_xlat2.x = _Time.y * _SecTexUspeed + u_xlat1.x;
        u_xlat2.y = _Time.y * _SecTexVspeed + u_xlat1.y;
        u_xlat16_3.xy = u_xlat10_0.xy * vec2(_Noise_Scaler) + u_xlat2.xy;
        u_xlat10_0.x = texture(_SecTex, u_xlat16_3.xy).x;
        u_xlat16_0 = u_xlat10_12.x + u_xlat10_0.x;
        u_xlat16_0 = u_xlat16_0;
    } else {
        u_xlat16_0 = u_xlat10_12.x;
    //ENDIF
    }
    u_xlat1.xyz = (-_CloudColorA.xyz) + _CloudColorB.xyz;
    u_xlat1.xyz = vec3(u_xlat16_0) * u_xlat1.xyz + _CloudColorA.xyz;
    u_xlat19 = _Time.y * _FlashFrequency;
    u_xlat2.xy = vs_TEXCOORD3.xy * _FlashCloudTex_ST.xy + _FlashCloudTex_ST.zw;
    u_xlat19 = sin(u_xlat19);
    u_xlat19 = u_xlat19 * _FlashSpeed;
    u_xlat2.xy = vec2(u_xlat19) * vec2(0.300000012, 2.0) + u_xlat2.xy;
    u_xlat14.xy = vs_TEXCOORD3.xy * _CloudTex01_ST.xy + _CloudTex01_ST.zw;
    u_xlat14.xy = _Time.yy * vec2(_CloudTex01Speed) + u_xlat14.xy;
    u_xlat10_19 = texture(_CloudTex01, u_xlat14.xy).x;
    u_xlat14.xy = vs_TEXCOORD3.xy * _LightningTex_ST.xy + _LightningTex_ST.zw;
    u_xlat10_2 = texture(_FlashCloudTex, u_xlat2.xy).x;
    u_xlat16_4.xyz = vec3(u_xlat10_2) * _FlashColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(_FlashBrightness);
    u_xlat2.x = u_xlat10_19 + _CloudOffset;
    u_xlat2.x = u_xlat2.x * _CloudScaler;
    u_xlat8.xy = _Time.yy * vec2(_LightningTexSpeed) + u_xlat14.xy;
    u_xlat10_8 = texture(_LightningTex, u_xlat8.xy).x;
    u_xlat16_8 = u_xlat10_8 * _LightningBrightness;
    u_xlat2.x = u_xlat16_8 * u_xlat2.x;
    u_xlat19 = u_xlat10_19 * _CloudIntensity + u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat16_4.xyz + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(_LightningToggle==1.0);
#else
    u_xlatb19 = _LightningToggle==1.0;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb19)) ? u_xlat2.xyz : u_xlat1.xyz;
    u_xlat0.w = u_xlat10_12.y * _Opacity;
    u_xlat1.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat13 = u_xlat1.x * _HeigtFogParams.y;
    u_xlat2.x = u_xlat1.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat8.x = (-u_xlat2.x) + 2.0;
    u_xlat2.x = u_xlat8.x * u_xlat2.x;
    u_xlat8.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!((-u_xlat19)>=u_xlat8.x);
#else
    u_xlatb19 = (-u_xlat19)>=u_xlat8.x;
#endif
    u_xlat8.x = u_xlat2.x * _HeigtFogColDelta.w;
    u_xlat19 = (u_xlatb19) ? u_xlat8.x : u_xlat2.x;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * unity_FogColor.w;
    u_xlat19 = exp2(u_xlat19);
    u_xlat19 = min(u_xlat19, _HeigtFogColBase.w);
    u_xlat2.x = vs_TEXCOORD4.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_21 = (-u_xlat2.x) + 2.0;
    u_xlat16_21 = u_xlat2.x * u_xlat16_21;
    u_xlat2.xyz = vec3(u_xlat16_21) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat20 = u_xlat1.x + (-_HeigtFogRamp.w);
    u_xlat20 = u_xlat20 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat2.xyz = vec3(u_xlat20) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat20 = u_xlat1.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat20));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat20);
#endif
    u_xlat10 = u_xlat20 * -1.44269502;
    u_xlat10 = exp2(u_xlat10);
    u_xlat10 = (-u_xlat10) + 1.0;
    u_xlat20 = u_xlat10 / u_xlat20;
    u_xlat16_21 = (u_xlatb4) ? u_xlat20 : 1.0;
    u_xlat7 = u_xlat1.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(0.00999999978<abs(u_xlat7));
#else
    u_xlatb20 = 0.00999999978<abs(u_xlat7);
#endif
    u_xlat4.x = u_xlat7 * -1.44269502;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat7 = u_xlat4.x / u_xlat7;
    u_xlat16_5 = (u_xlatb20) ? u_xlat7 : 1.0;
    u_xlat7 = u_xlat1.x * _HeigtFogParams2.y;
    u_xlat16_21 = u_xlat13 * u_xlat16_21;
    u_xlat16_5 = u_xlat7 * u_xlat16_5;
    u_xlat16_21 = exp2((-u_xlat16_21));
    u_xlat16_21 = (-u_xlat16_21) + 1.0;
    u_xlat16_21 = max(u_xlat16_21, 0.0);
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_5 = max(u_xlat16_5, 0.0);
    u_xlat16_21 = u_xlat16_21 + u_xlat16_5;
    u_xlat1.x = u_xlat1.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat1.x) + 2.0;
    u_xlat16_5 = u_xlat1.x * u_xlat16_5;
    u_xlat1.x = u_xlat16_5 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat16_21 = u_xlat1.x * u_xlat16_21;
    u_xlat1.x = min(u_xlat16_21, _HeigtFogColBase.w);
    u_xlat7 = vs_TEXCOORD4.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat7) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat7 = (-u_xlat1.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat7) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat4.xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.x = (-u_xlat19) + 1.0;
    u_xlat1.x = u_xlat7 * u_xlat1.x;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat16_3.xyz + u_xlat2.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MSAA_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
bool u_xlatb7;
vec3 u_xlat9;
mediump float u_xlat16_10;
float u_xlat14;
float u_xlat15;
float u_xlat16;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.xxxx * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1] * in_POSITION0.yyyy + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat7.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat7.xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat7.xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat7.xyz;
    vs_TEXCOORD4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat7.xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat7.xyz;
    u_xlat2.xyz = u_xlat7.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat7.x = u_xlat2.y * _HeigtFogParams.x;
    u_xlat21 = u_xlat7.x * -1.44269502;
    u_xlat21 = exp2(u_xlat21);
    u_xlat21 = (-u_xlat21) + 1.0;
    u_xlat21 = u_xlat21 / u_xlat7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.00999999978<abs(u_xlat7.x));
#else
    u_xlatb7 = 0.00999999978<abs(u_xlat7.x);
#endif
    u_xlat16_3.x = (u_xlatb7) ? u_xlat21 : 1.0;
    u_xlat7.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat21 = u_xlat7.x * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat21 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat21 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat15 = u_xlat21 * -1.44269502;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 / u_xlat21;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.00999999978<abs(u_xlat21));
#else
    u_xlatb21 = 0.00999999978<abs(u_xlat21);
#endif
    u_xlat16_10 = (u_xlatb21) ? u_xlat15 : 1.0;
    u_xlat21 = u_xlat7.x * _HeigtFogParams2.y;
    u_xlat16_10 = u_xlat21 * u_xlat16_10;
    u_xlat16_10 = exp2((-u_xlat16_10));
    u_xlat16_3.y = (-u_xlat16_10) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat21 = u_xlat7.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat21) + 2.0;
    u_xlat16_10 = u_xlat21 * u_xlat16_10;
    u_xlat21 = u_xlat16_10 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_3.x = u_xlat21 * u_xlat16_3.x;
    u_xlat21 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat15 = (-u_xlat21) + 1.0;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat9.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat9.x);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat9.x;
#endif
    u_xlat9.x = u_xlat7.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat7.x + (-_HeigtFogRamp.w);
    u_xlat7.x = u_xlat7.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat9.x) + 2.0;
    u_xlat9.x = u_xlat16 * u_xlat9.x;
    u_xlat16 = u_xlat9.x * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat16 : u_xlat9.x;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat9.x = u_xlat7.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat14 = u_xlat7.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat14) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat16_3.x = (-u_xlat9.x) + 2.0;
    u_xlat16_3.x = u_xlat9.x * u_xlat16_3.x;
    u_xlat9.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat5.xyz = (-u_xlat9.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat9.xyz = u_xlat7.xxx * u_xlat5.xyz + u_xlat9.xyz;
    u_xlat9.xyz = u_xlat2.xxx * u_xlat9.xyz;
    u_xlat7.x = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat15 * u_xlat7.x;
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat9.xyz;
    vs_TEXCOORD0.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat2.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat16_3.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_3.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_3.x);
    u_xlat16_2 = u_xlat0.yzwx * u_xlat0.xywz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_6.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_6.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat1.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.w = u_xlat0.x * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    vs_TEXCOORD4.w = 0.0;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _MianTex_Uspeed;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTex_Vspeed;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Scaler;
uniform 	mediump float _Opacity;
uniform 	mediump float _LightningToggle;
uniform 	vec4 _CloudColorA;
uniform 	vec4 _CloudColorB;
uniform 	mediump float _UseTwoCloudTex;
uniform 	float _SecTexUspeed;
uniform 	vec4 _SecTex_ST;
uniform 	float _SecTexVspeed;
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
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SecTex;
uniform lowp sampler2D _CloudTex01;
uniform lowp sampler2D _FlashCloudTex;
uniform lowp sampler2D _LightningTex;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp vec2 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
lowp float u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
bool u_xlatb4;
mediump float u_xlat16_5;
float u_xlat7;
vec2 u_xlat8;
mediump float u_xlat16_8;
lowp float u_xlat10_8;
float u_xlat10;
lowp vec2 u_xlat10_12;
float u_xlat13;
vec2 u_xlat14;
float u_xlat19;
lowp float u_xlat10_19;
bool u_xlatb19;
float u_xlat20;
bool u_xlatb20;
mediump float u_xlat16_21;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = _Time.y * _MianTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _MainTex_Vspeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD3.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat2.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.y;
    u_xlat10_0.xy = texture(_NoiseTex, u_xlat2.xy).xy;
    u_xlat16_3.xy = u_xlat10_0.xy * vec2(_Noise_Scaler) + u_xlat1.xy;
    u_xlat10_12.xy = texture(_MainTex, u_xlat16_3.xy).xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UseTwoCloudTex==1.0);
#else
    u_xlatb1 = _UseTwoCloudTex==1.0;
#endif
    if(u_xlatb1){
        u_xlat1.xy = vs_TEXCOORD3.xy * _SecTex_ST.xy + _SecTex_ST.zw;
        u_xlat2.x = _Time.y * _SecTexUspeed + u_xlat1.x;
        u_xlat2.y = _Time.y * _SecTexVspeed + u_xlat1.y;
        u_xlat16_3.xy = u_xlat10_0.xy * vec2(_Noise_Scaler) + u_xlat2.xy;
        u_xlat10_0.x = texture(_SecTex, u_xlat16_3.xy).x;
        u_xlat16_0 = u_xlat10_12.x + u_xlat10_0.x;
        u_xlat16_0 = u_xlat16_0;
    } else {
        u_xlat16_0 = u_xlat10_12.x;
    //ENDIF
    }
    u_xlat1.xyz = (-_CloudColorA.xyz) + _CloudColorB.xyz;
    u_xlat1.xyz = vec3(u_xlat16_0) * u_xlat1.xyz + _CloudColorA.xyz;
    u_xlat19 = _Time.y * _FlashFrequency;
    u_xlat2.xy = vs_TEXCOORD3.xy * _FlashCloudTex_ST.xy + _FlashCloudTex_ST.zw;
    u_xlat19 = sin(u_xlat19);
    u_xlat19 = u_xlat19 * _FlashSpeed;
    u_xlat2.xy = vec2(u_xlat19) * vec2(0.300000012, 2.0) + u_xlat2.xy;
    u_xlat14.xy = vs_TEXCOORD3.xy * _CloudTex01_ST.xy + _CloudTex01_ST.zw;
    u_xlat14.xy = _Time.yy * vec2(_CloudTex01Speed) + u_xlat14.xy;
    u_xlat10_19 = texture(_CloudTex01, u_xlat14.xy).x;
    u_xlat14.xy = vs_TEXCOORD3.xy * _LightningTex_ST.xy + _LightningTex_ST.zw;
    u_xlat10_2 = texture(_FlashCloudTex, u_xlat2.xy).x;
    u_xlat16_4.xyz = vec3(u_xlat10_2) * _FlashColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(_FlashBrightness);
    u_xlat2.x = u_xlat10_19 + _CloudOffset;
    u_xlat2.x = u_xlat2.x * _CloudScaler;
    u_xlat8.xy = _Time.yy * vec2(_LightningTexSpeed) + u_xlat14.xy;
    u_xlat10_8 = texture(_LightningTex, u_xlat8.xy).x;
    u_xlat16_8 = u_xlat10_8 * _LightningBrightness;
    u_xlat2.x = u_xlat16_8 * u_xlat2.x;
    u_xlat19 = u_xlat10_19 * _CloudIntensity + u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat16_4.xyz + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(_LightningToggle==1.0);
#else
    u_xlatb19 = _LightningToggle==1.0;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb19)) ? u_xlat2.xyz : u_xlat1.xyz;
    u_xlat0.w = u_xlat10_12.y * _Opacity;
    u_xlat1.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat13 = u_xlat1.x * _HeigtFogParams.y;
    u_xlat2.x = u_xlat1.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat8.x = (-u_xlat2.x) + 2.0;
    u_xlat2.x = u_xlat8.x * u_xlat2.x;
    u_xlat8.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!((-u_xlat19)>=u_xlat8.x);
#else
    u_xlatb19 = (-u_xlat19)>=u_xlat8.x;
#endif
    u_xlat8.x = u_xlat2.x * _HeigtFogColDelta.w;
    u_xlat19 = (u_xlatb19) ? u_xlat8.x : u_xlat2.x;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * unity_FogColor.w;
    u_xlat19 = exp2(u_xlat19);
    u_xlat19 = min(u_xlat19, _HeigtFogColBase.w);
    u_xlat2.x = vs_TEXCOORD4.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_21 = (-u_xlat2.x) + 2.0;
    u_xlat16_21 = u_xlat2.x * u_xlat16_21;
    u_xlat2.xyz = vec3(u_xlat16_21) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat20 = u_xlat1.x + (-_HeigtFogRamp.w);
    u_xlat20 = u_xlat20 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat2.xyz = vec3(u_xlat20) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat20 = u_xlat1.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat20));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat20);
#endif
    u_xlat10 = u_xlat20 * -1.44269502;
    u_xlat10 = exp2(u_xlat10);
    u_xlat10 = (-u_xlat10) + 1.0;
    u_xlat20 = u_xlat10 / u_xlat20;
    u_xlat16_21 = (u_xlatb4) ? u_xlat20 : 1.0;
    u_xlat7 = u_xlat1.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(0.00999999978<abs(u_xlat7));
#else
    u_xlatb20 = 0.00999999978<abs(u_xlat7);
#endif
    u_xlat4.x = u_xlat7 * -1.44269502;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat7 = u_xlat4.x / u_xlat7;
    u_xlat16_5 = (u_xlatb20) ? u_xlat7 : 1.0;
    u_xlat7 = u_xlat1.x * _HeigtFogParams2.y;
    u_xlat16_21 = u_xlat13 * u_xlat16_21;
    u_xlat16_5 = u_xlat7 * u_xlat16_5;
    u_xlat16_21 = exp2((-u_xlat16_21));
    u_xlat16_21 = (-u_xlat16_21) + 1.0;
    u_xlat16_21 = max(u_xlat16_21, 0.0);
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_5 = max(u_xlat16_5, 0.0);
    u_xlat16_21 = u_xlat16_21 + u_xlat16_5;
    u_xlat1.x = u_xlat1.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat1.x) + 2.0;
    u_xlat16_5 = u_xlat1.x * u_xlat16_5;
    u_xlat1.x = u_xlat16_5 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat16_21 = u_xlat1.x * u_xlat16_21;
    u_xlat1.x = min(u_xlat16_21, _HeigtFogColBase.w);
    u_xlat7 = vs_TEXCOORD4.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat7) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat7 = (-u_xlat1.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat7) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat4.xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.x = (-u_xlat19) + 1.0;
    u_xlat1.x = u_xlat7 * u_xlat1.x;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat16_3.xyz + u_xlat2.xyz;
    SV_Target0 = u_xlat0;
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
Keywords { "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MSAA_INTERPOLATION" }
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
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MSAA_INTERPOLATION" }
""
}
}
}
}
CustomEditor "MiHoYoASEMaterialInspector"
}