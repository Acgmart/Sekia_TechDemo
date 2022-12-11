//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Particles/Particle_FakeLighting_Opaque" {
Properties {
_Scale ("Scale Compared to Maya", Float) = 0.01
[Header(Element View)] _ElementViewEleID ("Element ID", Float) = 0
[MHYToggle] _ReceiveShadow ("Receive Shadow", Float) = 0
_MaterialShadowBias ("Shadow Bias", Range(0, 0.1)) = 0
[Toggle] _EnableAlphaTest ("Enable Alpha Test", Float) = 0
_CutOff ("Mask Clip Value", Range(0, 1)) = 0
[Header(Dithering)] [Toggle(USINGDITHERALPAH)] _UsingDitherAlpha ("UsingDitherAlpha", Float) = 0
_DitherAlpha ("Dither Alpha Value", Range(0, 1)) = 1
[Toggle(_NORMALMAPTOGGLE_ON)] _NormalMapToggle ("NormalMapToggle", Float) = 0
_NormalMap ("NormalMap", 2D) = "bump" { }
_NormalIntensity ("NormalIntensity", Range(0, 20)) = 1
_WorldNormalScale ("WorldNormalScale", Range(0, 50)) = 1
_LightingScale ("LightingScale", Range(-1, 1)) = 0
_LightColor ("LightColor", Color) = (1,1,1,0)
_DarkColor ("DarkColor", Color) = (0,0,0,0)
_ColorBrightness ("ColorBrightness", Float) = 1
_BaseTex ("BaseTex", 2D) = "white" { }
[Enum(RGB,0,R,1,G,2,B,3,A,4)] _BaseTexColorChannelSwitch ("BaseTexColorChannelSwitch", Float) = 0
[Toggle(_MATCAPTOGGLE_ON)] _MatcapToggle ("MatcapToggle", Float) = 0
_Matcap ("Matcap", 2D) = "white" { }
_MatcapSize ("MatcapSize", Range(0, 2)) = 1
_Matcap_Brightness ("Matcap_Brightness", Float) = 1
_MeshParticleColorArray ("MeshParticleColorArray", Vector) = (1,1,1,1)
_DayColor ("DayColor", Color) = (1,1,1,1)
_EmissionStrength ("EmissionStrength", Float) = 1.5
_texcoord ("", 2D) = "white" { }
}
SubShader {
 Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "HYBRIDDEFERRED"
  Tags { "LIGHTMODE" = "HYBRIDDEFERRED" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 64846
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TANGENT0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_COLOR0;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD5.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	float _ReceiveShadow;
uniform 	float _ColorBrightness;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	float _LightingScale;
uniform 	float _WorldNormalScale;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	mediump float _EmissionStrength;
uniform lowp sampler2D _BaseTex;
in highp vec3 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec3 u_xlat4;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat4.xyz = u_xlat0.xxx * vs_TEXCOORD0.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.xyz * u_xlat0.xxx + vec3(_LightingScale);
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_WorldNormalScale, _WorldNormalScale, _WorldNormalScale));
    SV_Target0.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.00392156886;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + _DarkColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb12 = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat1.xy = vs_TEXCOORD3.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat1.xy);
    u_xlat12 = u_xlatb12 ? u_xlat1.w : float(0.0);
    u_xlatb2 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat12 = (u_xlatb2.w) ? u_xlat1.z : u_xlat12;
    u_xlat12 = (u_xlatb2.z) ? u_xlat1.y : u_xlat12;
    u_xlat12 = (u_xlatb2.y) ? u_xlat1.x : u_xlat12;
    u_xlat1.xyz = (u_xlatb2.x) ? u_xlat1.xyz : vec3(u_xlat12);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.w = _ReceiveShadow;
    SV_Target1 = u_xlat0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb12 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_3 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb12) ? u_xlat16_3 : u_xlat0.z;
    SV_Target2.xy = u_xlat0.xy;
    u_xlat16_0 = _EmissionStrength * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_0 = sqrt(u_xlat16_0);
    SV_Target2.w = u_xlat16_0;
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
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_COLOR0;
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
    u_xlat1.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat1.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat2.xyz = u_xlat3.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD5.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	float _ReceiveShadow;
uniform 	float _ColorBrightness;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	float _LightingScale;
uniform 	float _WorldNormalScale;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	mediump float _EmissionStrength;
uniform lowp sampler2D _BaseTex;
in highp vec3 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec3 u_xlat4;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat4.xyz = u_xlat0.xxx * vs_TEXCOORD0.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.xyz * u_xlat0.xxx + vec3(_LightingScale);
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_WorldNormalScale, _WorldNormalScale, _WorldNormalScale));
    SV_Target0.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.00392156886;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + _DarkColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb12 = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat1.xy = vs_TEXCOORD3.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat1.xy);
    u_xlat12 = u_xlatb12 ? u_xlat1.w : float(0.0);
    u_xlatb2 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat12 = (u_xlatb2.w) ? u_xlat1.z : u_xlat12;
    u_xlat12 = (u_xlatb2.z) ? u_xlat1.y : u_xlat12;
    u_xlat12 = (u_xlatb2.y) ? u_xlat1.x : u_xlat12;
    u_xlat1.xyz = (u_xlatb2.x) ? u_xlat1.xyz : vec3(u_xlat12);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.w = _ReceiveShadow;
    SV_Target1 = u_xlat0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb12 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_3 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb12) ? u_xlat16_3 : u_xlat0.z;
    SV_Target2.xy = u_xlat0.xy;
    u_xlat16_0 = _EmissionStrength * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_0 = sqrt(u_xlat16_0);
    SV_Target2.w = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_NORMALMAPTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TANGENT0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_COLOR0;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD5.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	float _ReceiveShadow;
uniform 	float _ColorBrightness;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	float _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _LightingScale;
uniform 	float _WorldNormalScale;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	mediump float _EmissionStrength;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _BaseTex;
in highp vec3 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec3 u_xlat4;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD0.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.00392156886;
    u_xlat0.x = vs_TEXCOORD4.x;
    u_xlat0.y = vs_TEXCOORD5.x;
    u_xlat0.z = vs_TEXCOORD0.x;
    u_xlat1.xy = vs_TEXCOORD3.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_NormalIntensity);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat1.x = vs_TEXCOORD4.y;
    u_xlat1.y = vs_TEXCOORD5.y;
    u_xlat1.z = vs_TEXCOORD0.y;
    u_xlat0.y = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat1.x = vs_TEXCOORD4.z;
    u_xlat1.y = vs_TEXCOORD5.z;
    u_xlat1.z = vs_TEXCOORD0.z;
    u_xlat0.z = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + vec3(_LightingScale);
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WorldNormalScale, _WorldNormalScale, _WorldNormalScale));
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + _DarkColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb12 = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat1.xy = vs_TEXCOORD3.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat1.xy);
    u_xlat12 = u_xlatb12 ? u_xlat1.w : float(0.0);
    u_xlatb2 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat12 = (u_xlatb2.w) ? u_xlat1.z : u_xlat12;
    u_xlat12 = (u_xlatb2.z) ? u_xlat1.y : u_xlat12;
    u_xlat12 = (u_xlatb2.y) ? u_xlat1.x : u_xlat12;
    u_xlat1.xyz = (u_xlatb2.x) ? u_xlat1.xyz : vec3(u_xlat12);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.w = _ReceiveShadow;
    SV_Target1 = u_xlat0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb12 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_3 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb12) ? u_xlat16_3 : u_xlat0.z;
    SV_Target2.xy = u_xlat0.xy;
    u_xlat16_0 = _EmissionStrength * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_0 = sqrt(u_xlat16_0);
    SV_Target2.w = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_NORMALMAPTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

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
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_COLOR0;
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
    u_xlat1.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat1.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat2.xyz = u_xlat3.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD5.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	float _ReceiveShadow;
uniform 	float _ColorBrightness;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	float _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _LightingScale;
uniform 	float _WorldNormalScale;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	mediump float _EmissionStrength;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _BaseTex;
in highp vec3 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec3 u_xlat4;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD0.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.00392156886;
    u_xlat0.x = vs_TEXCOORD4.x;
    u_xlat0.y = vs_TEXCOORD5.x;
    u_xlat0.z = vs_TEXCOORD0.x;
    u_xlat1.xy = vs_TEXCOORD3.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_NormalIntensity);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat1.x = vs_TEXCOORD4.y;
    u_xlat1.y = vs_TEXCOORD5.y;
    u_xlat1.z = vs_TEXCOORD0.y;
    u_xlat0.y = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat1.x = vs_TEXCOORD4.z;
    u_xlat1.y = vs_TEXCOORD5.z;
    u_xlat1.z = vs_TEXCOORD0.z;
    u_xlat0.z = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + vec3(_LightingScale);
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WorldNormalScale, _WorldNormalScale, _WorldNormalScale));
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + _DarkColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb12 = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat1.xy = vs_TEXCOORD3.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat1.xy);
    u_xlat12 = u_xlatb12 ? u_xlat1.w : float(0.0);
    u_xlatb2 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat12 = (u_xlatb2.w) ? u_xlat1.z : u_xlat12;
    u_xlat12 = (u_xlatb2.z) ? u_xlat1.y : u_xlat12;
    u_xlat12 = (u_xlatb2.y) ? u_xlat1.x : u_xlat12;
    u_xlat1.xyz = (u_xlatb2.x) ? u_xlat1.xyz : vec3(u_xlat12);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.w = _ReceiveShadow;
    SV_Target1 = u_xlat0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb12 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_3 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb12) ? u_xlat16_3 : u_xlat0.z;
    SV_Target2.xy = u_xlat0.xy;
    u_xlat16_0 = _EmissionStrength * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_0 = sqrt(u_xlat16_0);
    SV_Target2.w = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_MATCAPTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TANGENT0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_COLOR0;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD5.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	float _ReceiveShadow;
uniform 	float _ColorBrightness;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	float _LightingScale;
uniform 	float _WorldNormalScale;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	float _MatcapSize;
uniform 	float _Matcap_Brightness;
uniform 	vec4 _DayColor;
uniform 	mediump float _EmissionStrength;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _Matcap;
in highp vec3 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
vec3 u_xlat5;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat5.xyz = u_xlat0.xxx * vs_TEXCOORD0.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.xyz * u_xlat0.xxx + vec3(_LightingScale);
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_WorldNormalScale, _WorldNormalScale, _WorldNormalScale));
    SV_Target0.xyz = u_xlat5.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.00392156886;
    u_xlat0.xy = u_xlat1.yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat1.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(_MatcapSize) + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_Matcap, u_xlat0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(vec3(_Matcap_Brightness, _Matcap_Brightness, _Matcap_Brightness));
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb15 = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat2.xy = vs_TEXCOORD3.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat2 = texture(_BaseTex, u_xlat2.xy);
    u_xlat15 = u_xlatb15 ? u_xlat2.w : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat15 = (u_xlatb3.w) ? u_xlat2.z : u_xlat15;
    u_xlat15 = (u_xlatb3.z) ? u_xlat2.y : u_xlat15;
    u_xlat15 = (u_xlatb3.y) ? u_xlat2.x : u_xlat15;
    u_xlat2.xyz = (u_xlatb3.x) ? u_xlat2.xyz : vec3(u_xlat15);
    u_xlat3.xyz = (-vs_TEXCOORD2.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz + _DarkColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.w = _ReceiveShadow;
    SV_Target1 = u_xlat0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_4 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb15) ? u_xlat16_4 : u_xlat0.z;
    SV_Target2.xy = u_xlat0.xy;
    u_xlat16_0 = _EmissionStrength * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_0 = sqrt(u_xlat16_0);
    SV_Target2.w = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_MATCAPTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

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
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_COLOR0;
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
    u_xlat1.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat1.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat2.xyz = u_xlat3.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD5.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	float _ReceiveShadow;
uniform 	float _ColorBrightness;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	float _LightingScale;
uniform 	float _WorldNormalScale;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	float _MatcapSize;
uniform 	float _Matcap_Brightness;
uniform 	vec4 _DayColor;
uniform 	mediump float _EmissionStrength;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _Matcap;
in highp vec3 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
vec3 u_xlat5;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat5.xyz = u_xlat0.xxx * vs_TEXCOORD0.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.xyz * u_xlat0.xxx + vec3(_LightingScale);
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_WorldNormalScale, _WorldNormalScale, _WorldNormalScale));
    SV_Target0.xyz = u_xlat5.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.00392156886;
    u_xlat0.xy = u_xlat1.yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat1.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(_MatcapSize) + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_Matcap, u_xlat0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(vec3(_Matcap_Brightness, _Matcap_Brightness, _Matcap_Brightness));
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb15 = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat2.xy = vs_TEXCOORD3.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat2 = texture(_BaseTex, u_xlat2.xy);
    u_xlat15 = u_xlatb15 ? u_xlat2.w : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat15 = (u_xlatb3.w) ? u_xlat2.z : u_xlat15;
    u_xlat15 = (u_xlatb3.z) ? u_xlat2.y : u_xlat15;
    u_xlat15 = (u_xlatb3.y) ? u_xlat2.x : u_xlat15;
    u_xlat2.xyz = (u_xlatb3.x) ? u_xlat2.xyz : vec3(u_xlat15);
    u_xlat3.xyz = (-vs_TEXCOORD2.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz + _DarkColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.w = _ReceiveShadow;
    SV_Target1 = u_xlat0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_4 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb15) ? u_xlat16_4 : u_xlat0.z;
    SV_Target2.xy = u_xlat0.xy;
    u_xlat16_0 = _EmissionStrength * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_0 = sqrt(u_xlat16_0);
    SV_Target2.w = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_MATCAPTOGGLE_ON" "_NORMALMAPTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TANGENT0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_COLOR0;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD5.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	float _ReceiveShadow;
uniform 	float _ColorBrightness;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	float _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _LightingScale;
uniform 	float _WorldNormalScale;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	float _MatcapSize;
uniform 	float _Matcap_Brightness;
uniform 	vec4 _DayColor;
uniform 	mediump float _EmissionStrength;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _Matcap;
in highp vec3 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD0.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.00392156886;
    u_xlat0.x = vs_TEXCOORD4.x;
    u_xlat0.y = vs_TEXCOORD5.x;
    u_xlat0.z = vs_TEXCOORD0.x;
    u_xlat1.xy = vs_TEXCOORD3.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_NormalIntensity);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat1.x = vs_TEXCOORD4.y;
    u_xlat1.y = vs_TEXCOORD5.y;
    u_xlat1.z = vs_TEXCOORD0.y;
    u_xlat0.y = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat1.x = vs_TEXCOORD4.z;
    u_xlat1.y = vs_TEXCOORD5.z;
    u_xlat1.z = vs_TEXCOORD0.z;
    u_xlat0.z = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18) + vec3(_LightingScale);
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WorldNormalScale, _WorldNormalScale, _WorldNormalScale));
    u_xlat1.xy = u_xlat0.yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat0.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat0.zz + u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(_MatcapSize) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1.xyz = texture(_Matcap, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * vec3(vec3(_Matcap_Brightness, _Matcap_Brightness, _Matcap_Brightness));
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb18 = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat3.xy = vs_TEXCOORD3.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat2 = texture(_BaseTex, u_xlat3.xy);
    u_xlat18 = u_xlatb18 ? u_xlat2.w : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat18 = (u_xlatb3.w) ? u_xlat2.z : u_xlat18;
    u_xlat18 = (u_xlatb3.z) ? u_xlat2.y : u_xlat18;
    u_xlat18 = (u_xlatb3.y) ? u_xlat2.x : u_xlat18;
    u_xlat3.xyz = (u_xlatb3.x) ? u_xlat2.xyz : vec3(u_xlat18);
    u_xlat4.xyz = (-vs_TEXCOORD2.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz + _DarkColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.w = _ReceiveShadow;
    SV_Target1 = u_xlat0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb18 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_5 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb18) ? u_xlat16_5 : u_xlat0.z;
    SV_Target2.xy = u_xlat0.xy;
    u_xlat16_0 = _EmissionStrength * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_0 = sqrt(u_xlat16_0);
    SV_Target2.w = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_MATCAPTOGGLE_ON" "_NORMALMAPTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

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
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_COLOR0;
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
    u_xlat1.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat1.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat2.xyz = u_xlat3.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD5.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	float _ReceiveShadow;
uniform 	float _ColorBrightness;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	float _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _LightingScale;
uniform 	float _WorldNormalScale;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	float _MatcapSize;
uniform 	float _Matcap_Brightness;
uniform 	vec4 _DayColor;
uniform 	mediump float _EmissionStrength;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _Matcap;
in highp vec3 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD0.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.00392156886;
    u_xlat0.x = vs_TEXCOORD4.x;
    u_xlat0.y = vs_TEXCOORD5.x;
    u_xlat0.z = vs_TEXCOORD0.x;
    u_xlat1.xy = vs_TEXCOORD3.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_NormalIntensity);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat1.x = vs_TEXCOORD4.y;
    u_xlat1.y = vs_TEXCOORD5.y;
    u_xlat1.z = vs_TEXCOORD0.y;
    u_xlat0.y = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat1.x = vs_TEXCOORD4.z;
    u_xlat1.y = vs_TEXCOORD5.z;
    u_xlat1.z = vs_TEXCOORD0.z;
    u_xlat0.z = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18) + vec3(_LightingScale);
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_WorldNormalScale, _WorldNormalScale, _WorldNormalScale));
    u_xlat1.xy = u_xlat0.yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat0.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat0.zz + u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(_MatcapSize) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1.xyz = texture(_Matcap, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * vec3(vec3(_Matcap_Brightness, _Matcap_Brightness, _Matcap_Brightness));
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb18 = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat3.xy = vs_TEXCOORD3.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat2 = texture(_BaseTex, u_xlat3.xy);
    u_xlat18 = u_xlatb18 ? u_xlat2.w : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat18 = (u_xlatb3.w) ? u_xlat2.z : u_xlat18;
    u_xlat18 = (u_xlatb3.z) ? u_xlat2.y : u_xlat18;
    u_xlat18 = (u_xlatb3.y) ? u_xlat2.x : u_xlat18;
    u_xlat3.xyz = (u_xlatb3.x) ? u_xlat2.xyz : vec3(u_xlat18);
    u_xlat4.xyz = (-vs_TEXCOORD2.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz + _DarkColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.w = _ReceiveShadow;
    SV_Target1 = u_xlat0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb18 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_5 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb18) ? u_xlat16_5 : u_xlat0.z;
    SV_Target2.xy = u_xlat0.xy;
    u_xlat16_0 = _EmissionStrength * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_0 = sqrt(u_xlat16_0);
    SV_Target2.w = u_xlat16_0;
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
Keywords { "_NORMALMAPTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_NORMALMAPTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "_MATCAPTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_MATCAPTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "_MATCAPTOGGLE_ON" "_NORMALMAPTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_MATCAPTOGGLE_ON" "_NORMALMAPTOGGLE_ON" }
""
}
}
}
 Pass {
  Name "SHADOWCASTER"
  Tags { "LIGHTMODE" = "SHADOWCASTER" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 107651
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _MaterialShadowBias;
in highp vec4 in_POSITION0;
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
  GpuProgramID 176867
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
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