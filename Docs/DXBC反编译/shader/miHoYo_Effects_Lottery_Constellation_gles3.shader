//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Effects/Lottery_Constellation" {
Properties {
_MainTex ("MainTex", 2D) = "white" { }
_MainColor ("MainColor", Color) = (1,1,1,0)
_Opacity ("Opacity", Range(0, 1)) = 1
[Enum(Dissipate,0,UV,1)] _AlphaGradualSwitch ("AlphaGradualSwitch", Float) = 1
[Enum(Texture,0,Color,1)] _TexOrColorSwitch ("TexOrColorSwitch", Float) = 1
_Dissmap ("Dissmap", 2D) = "white" { }
_Noise ("Noise", 2D) = "white" { }
_NoiseColor ("NoiseColor", Color) = (1,1,1,0)
_Speed ("Speed", Float) = 0
_OP ("OP", Range(0, 1)) = 1
_texcoord ("", 2D) = "white" { }
[Header(Cull Mode)] [Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
_MHYZBias ("Z Bias", Float) = 0
_PolygonOffsetFactor ("Polygon Offset Factor", Float) = 0
_PolygonOffsetUnit ("Polygon Offset Unit", Float) = 0
[Header(Blend Mode)] [Enum(UnityEngine.Rendering.BlendMode)] _SrcBlendMode ("Src Blend Mode", Float) = 1
[Enum(UnityEngine.Rendering.BlendMode)] _DstBlendMode ("Dst Blend Mode", Float) = 0
[Enum(UnityEngine.Rendering.BlendOp)] _BlendOP ("BlendOp Mode", Float) = 0
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "MAIN"
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Off
  GpuProgramID 29750
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
uniform 	mediump float _TexOrColorSwitch;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Speed;
uniform 	vec4 _Noise_ST;
uniform 	mediump vec4 _NoiseColor;
uniform 	mediump float _AlphaGradualSwitch;
uniform 	mediump float _Opacity;
uniform 	vec4 _Dissmap_ST;
uniform 	mediump float _OP;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Dissmap;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bvec3 u_xlatb0;
vec2 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_4;
lowp float u_xlat10_4;
bool u_xlatb4;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat8.x = _Time.y * _Speed;
    u_xlat1.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat8.xy = u_xlat8.xx * vec2(-1.0, 0.0) + u_xlat1.xy;
    u_xlat10_1.xyz = texture(_Noise, u_xlat8.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_TexOrColorSwitch==0.0);
#else
    u_xlatb8 = _TexOrColorSwitch==0.0;
#endif
    if(u_xlatb8){
        u_xlat10_2.xyz = texture(_MainTex, u_xlat0.xy).xyz;
        u_xlat16_2.xyz = u_xlat10_2.xyz * _MainColor.xyz;
        u_xlat16_2.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
        SV_Target0.xyz = u_xlat16_2.xyz;
    } else {
#ifdef UNITY_ADRENO_ES3
        u_xlatb8 = !!(_TexOrColorSwitch==1.0);
#else
        u_xlatb8 = _TexOrColorSwitch==1.0;
#endif
        u_xlat16_3.xyz = u_xlat10_1.xyz * _NoiseColor.xyz;
        SV_Target0.xyz = (bool(u_xlatb8)) ? u_xlat16_3.xyz : vec3(0.0, 0.0, 0.0);
    //ENDIF
    }
    u_xlat8.xy = vs_TEXCOORD0.xy * _Dissmap_ST.xy + _Dissmap_ST.zw;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy).w;
    u_xlat16_3.x = (-_Opacity) + 1.0;
    u_xlat10_4 = texture(_Dissmap, u_xlat8.xy).x;
    u_xlat16_4 = (-u_xlat10_4) + u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4 = min(max(u_xlat16_4, 0.0), 1.0);
#else
    u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
#endif
    u_xlat16_0 = (-u_xlat16_4) + u_xlat10_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_Opacity>=vs_TEXCOORD0.x);
#else
    u_xlatb4 = _Opacity>=vs_TEXCOORD0.x;
#endif
    u_xlat16_3.x = u_xlat16_0 * 3.0;
    u_xlat16_3.x = u_xlat16_3.x * _OP;
    u_xlatb0.xz = equal(vec4(_AlphaGradualSwitch), vec4(0.0, 0.0, 1.0, 0.0)).xz;
    u_xlat16_7 = (u_xlatb4) ? _OP : 0.0;
    u_xlat16_7 = (u_xlatb0.z) ? u_xlat16_7 : 0.0;
    SV_Target0.w = (u_xlatb0.x) ? u_xlat16_3.x : u_xlat16_7;
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
uniform 	mediump float _TexOrColorSwitch;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Speed;
uniform 	vec4 _Noise_ST;
uniform 	mediump vec4 _NoiseColor;
uniform 	mediump float _AlphaGradualSwitch;
uniform 	mediump float _Opacity;
uniform 	vec4 _Dissmap_ST;
uniform 	mediump float _OP;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Dissmap;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bvec3 u_xlatb0;
vec2 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_4;
lowp float u_xlat10_4;
bool u_xlatb4;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat8.x = _Time.y * _Speed;
    u_xlat1.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat8.xy = u_xlat8.xx * vec2(-1.0, 0.0) + u_xlat1.xy;
    u_xlat10_1.xyz = texture(_Noise, u_xlat8.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_TexOrColorSwitch==0.0);
#else
    u_xlatb8 = _TexOrColorSwitch==0.0;
#endif
    if(u_xlatb8){
        u_xlat10_2.xyz = texture(_MainTex, u_xlat0.xy).xyz;
        u_xlat16_2.xyz = u_xlat10_2.xyz * _MainColor.xyz;
        u_xlat16_2.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
        SV_Target0.xyz = u_xlat16_2.xyz;
    } else {
#ifdef UNITY_ADRENO_ES3
        u_xlatb8 = !!(_TexOrColorSwitch==1.0);
#else
        u_xlatb8 = _TexOrColorSwitch==1.0;
#endif
        u_xlat16_3.xyz = u_xlat10_1.xyz * _NoiseColor.xyz;
        SV_Target0.xyz = (bool(u_xlatb8)) ? u_xlat16_3.xyz : vec3(0.0, 0.0, 0.0);
    //ENDIF
    }
    u_xlat8.xy = vs_TEXCOORD0.xy * _Dissmap_ST.xy + _Dissmap_ST.zw;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy).w;
    u_xlat16_3.x = (-_Opacity) + 1.0;
    u_xlat10_4 = texture(_Dissmap, u_xlat8.xy).x;
    u_xlat16_4 = (-u_xlat10_4) + u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4 = min(max(u_xlat16_4, 0.0), 1.0);
#else
    u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
#endif
    u_xlat16_0 = (-u_xlat16_4) + u_xlat10_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_Opacity>=vs_TEXCOORD0.x);
#else
    u_xlatb4 = _Opacity>=vs_TEXCOORD0.x;
#endif
    u_xlat16_3.x = u_xlat16_0 * 3.0;
    u_xlat16_3.x = u_xlat16_3.x * _OP;
    u_xlatb0.xz = equal(vec4(_AlphaGradualSwitch), vec4(0.0, 0.0, 1.0, 0.0)).xz;
    u_xlat16_7 = (u_xlatb4) ? _OP : 0.0;
    u_xlat16_7 = (u_xlatb0.z) ? u_xlat16_7 : 0.0;
    SV_Target0.w = (u_xlatb0.x) ? u_xlat16_3.x : u_xlat16_7;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
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
uniform 	mediump float _TexOrColorSwitch;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Speed;
uniform 	vec4 _Noise_ST;
uniform 	mediump vec4 _NoiseColor;
uniform 	mediump float _AlphaGradualSwitch;
uniform 	mediump float _Opacity;
uniform 	vec4 _Dissmap_ST;
uniform 	mediump float _OP;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Dissmap;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bvec3 u_xlatb0;
vec2 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_4;
lowp float u_xlat10_4;
bool u_xlatb4;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat8.x = _Time.y * _Speed;
    u_xlat1.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat8.xy = u_xlat8.xx * vec2(-1.0, 0.0) + u_xlat1.xy;
    u_xlat10_1.xyz = texture(_Noise, u_xlat8.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_TexOrColorSwitch==0.0);
#else
    u_xlatb8 = _TexOrColorSwitch==0.0;
#endif
    if(u_xlatb8){
        u_xlat10_2.xyz = texture(_MainTex, u_xlat0.xy).xyz;
        u_xlat16_2.xyz = u_xlat10_2.xyz * _MainColor.xyz;
        u_xlat16_2.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
        SV_Target0.xyz = u_xlat16_2.xyz;
    } else {
#ifdef UNITY_ADRENO_ES3
        u_xlatb8 = !!(_TexOrColorSwitch==1.0);
#else
        u_xlatb8 = _TexOrColorSwitch==1.0;
#endif
        u_xlat16_3.xyz = u_xlat10_1.xyz * _NoiseColor.xyz;
        SV_Target0.xyz = (bool(u_xlatb8)) ? u_xlat16_3.xyz : vec3(0.0, 0.0, 0.0);
    //ENDIF
    }
    u_xlat8.xy = vs_TEXCOORD0.xy * _Dissmap_ST.xy + _Dissmap_ST.zw;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy).w;
    u_xlat16_3.x = (-_Opacity) + 1.0;
    u_xlat10_4 = texture(_Dissmap, u_xlat8.xy).x;
    u_xlat16_4 = (-u_xlat10_4) + u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4 = min(max(u_xlat16_4, 0.0), 1.0);
#else
    u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
#endif
    u_xlat16_0 = (-u_xlat16_4) + u_xlat10_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_Opacity>=vs_TEXCOORD0.x);
#else
    u_xlatb4 = _Opacity>=vs_TEXCOORD0.x;
#endif
    u_xlat16_3.x = u_xlat16_0 * 3.0;
    u_xlat16_3.x = u_xlat16_3.x * _OP;
    u_xlatb0.xz = equal(vec4(_AlphaGradualSwitch), vec4(0.0, 0.0, 1.0, 0.0)).xz;
    u_xlat16_7 = (u_xlatb4) ? _OP : 0.0;
    u_xlat16_7 = (u_xlatb0.z) ? u_xlat16_7 : 0.0;
    SV_Target0.w = (u_xlatb0.x) ? u_xlat16_3.x : u_xlat16_7;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
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
uniform 	mediump float _TexOrColorSwitch;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Speed;
uniform 	vec4 _Noise_ST;
uniform 	mediump vec4 _NoiseColor;
uniform 	mediump float _AlphaGradualSwitch;
uniform 	mediump float _Opacity;
uniform 	vec4 _Dissmap_ST;
uniform 	mediump float _OP;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Dissmap;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bvec3 u_xlatb0;
vec2 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_4;
lowp float u_xlat10_4;
bool u_xlatb4;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat8.x = _Time.y * _Speed;
    u_xlat1.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat8.xy = u_xlat8.xx * vec2(-1.0, 0.0) + u_xlat1.xy;
    u_xlat10_1.xyz = texture(_Noise, u_xlat8.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_TexOrColorSwitch==0.0);
#else
    u_xlatb8 = _TexOrColorSwitch==0.0;
#endif
    if(u_xlatb8){
        u_xlat10_2.xyz = texture(_MainTex, u_xlat0.xy).xyz;
        u_xlat16_2.xyz = u_xlat10_2.xyz * _MainColor.xyz;
        u_xlat16_2.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
        SV_Target0.xyz = u_xlat16_2.xyz;
    } else {
#ifdef UNITY_ADRENO_ES3
        u_xlatb8 = !!(_TexOrColorSwitch==1.0);
#else
        u_xlatb8 = _TexOrColorSwitch==1.0;
#endif
        u_xlat16_3.xyz = u_xlat10_1.xyz * _NoiseColor.xyz;
        SV_Target0.xyz = (bool(u_xlatb8)) ? u_xlat16_3.xyz : vec3(0.0, 0.0, 0.0);
    //ENDIF
    }
    u_xlat8.xy = vs_TEXCOORD0.xy * _Dissmap_ST.xy + _Dissmap_ST.zw;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy).w;
    u_xlat16_3.x = (-_Opacity) + 1.0;
    u_xlat10_4 = texture(_Dissmap, u_xlat8.xy).x;
    u_xlat16_4 = (-u_xlat10_4) + u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4 = min(max(u_xlat16_4, 0.0), 1.0);
#else
    u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
#endif
    u_xlat16_0 = (-u_xlat16_4) + u_xlat10_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_Opacity>=vs_TEXCOORD0.x);
#else
    u_xlatb4 = _Opacity>=vs_TEXCOORD0.x;
#endif
    u_xlat16_3.x = u_xlat16_0 * 3.0;
    u_xlat16_3.x = u_xlat16_3.x * _OP;
    u_xlatb0.xz = equal(vec4(_AlphaGradualSwitch), vec4(0.0, 0.0, 1.0, 0.0)).xz;
    u_xlat16_7 = (u_xlatb4) ? _OP : 0.0;
    u_xlat16_7 = (u_xlatb0.z) ? u_xlat16_7 : 0.0;
    SV_Target0.w = (u_xlatb0.x) ? u_xlat16_3.x : u_xlat16_7;
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
uniform 	mediump float _TexOrColorSwitch;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Speed;
uniform 	vec4 _Noise_ST;
uniform 	mediump vec4 _NoiseColor;
uniform 	mediump float _AlphaGradualSwitch;
uniform 	mediump float _Opacity;
uniform 	vec4 _Dissmap_ST;
uniform 	mediump float _OP;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Dissmap;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bvec3 u_xlatb0;
vec2 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_4;
lowp float u_xlat10_4;
bool u_xlatb4;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
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
    u_xlat8.x = _Time.y * _Speed;
    u_xlat1.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat8.xy = u_xlat8.xx * vec2(-1.0, 0.0) + u_xlat1.xy;
    u_xlat10_1.xyz = texture(_Noise, u_xlat8.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_TexOrColorSwitch==0.0);
#else
    u_xlatb8 = _TexOrColorSwitch==0.0;
#endif
    if(u_xlatb8){
        u_xlat10_2.xyz = texture(_MainTex, u_xlat0.xy).xyz;
        u_xlat16_2.xyz = u_xlat10_2.xyz * _MainColor.xyz;
        u_xlat16_2.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
        SV_Target0.xyz = u_xlat16_2.xyz;
    } else {
#ifdef UNITY_ADRENO_ES3
        u_xlatb8 = !!(_TexOrColorSwitch==1.0);
#else
        u_xlatb8 = _TexOrColorSwitch==1.0;
#endif
        u_xlat16_3.xyz = u_xlat10_1.xyz * _NoiseColor.xyz;
        SV_Target0.xyz = (bool(u_xlatb8)) ? u_xlat16_3.xyz : vec3(0.0, 0.0, 0.0);
    //ENDIF
    }
    u_xlat8.xy = vs_TEXCOORD0.xy * _Dissmap_ST.xy + _Dissmap_ST.zw;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy).w;
    u_xlat16_3.x = (-_Opacity) + 1.0;
    u_xlat10_4 = texture(_Dissmap, u_xlat8.xy).x;
    u_xlat16_4 = (-u_xlat10_4) + u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4 = min(max(u_xlat16_4, 0.0), 1.0);
#else
    u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
#endif
    u_xlat16_0 = (-u_xlat16_4) + u_xlat10_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_Opacity>=vs_TEXCOORD0.x);
#else
    u_xlatb4 = _Opacity>=vs_TEXCOORD0.x;
#endif
    u_xlat16_3.x = u_xlat16_0 * 3.0;
    u_xlat16_3.x = u_xlat16_3.x * _OP;
    u_xlatb0.xz = equal(vec4(_AlphaGradualSwitch), vec4(0.0, 0.0, 1.0, 0.0)).xz;
    u_xlat16_7 = (u_xlatb4) ? _OP : 0.0;
    u_xlat16_7 = (u_xlatb0.z) ? u_xlat16_7 : 0.0;
    SV_Target0.w = (u_xlatb0.x) ? u_xlat16_3.x : u_xlat16_7;
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
uniform 	mediump float _TexOrColorSwitch;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Speed;
uniform 	vec4 _Noise_ST;
uniform 	mediump vec4 _NoiseColor;
uniform 	mediump float _AlphaGradualSwitch;
uniform 	mediump float _Opacity;
uniform 	vec4 _Dissmap_ST;
uniform 	mediump float _OP;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Dissmap;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bvec3 u_xlatb0;
vec2 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_4;
lowp float u_xlat10_4;
bool u_xlatb4;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
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
    u_xlat8.x = _Time.y * _Speed;
    u_xlat1.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat8.xy = u_xlat8.xx * vec2(-1.0, 0.0) + u_xlat1.xy;
    u_xlat10_1.xyz = texture(_Noise, u_xlat8.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_TexOrColorSwitch==0.0);
#else
    u_xlatb8 = _TexOrColorSwitch==0.0;
#endif
    if(u_xlatb8){
        u_xlat10_2.xyz = texture(_MainTex, u_xlat0.xy).xyz;
        u_xlat16_2.xyz = u_xlat10_2.xyz * _MainColor.xyz;
        u_xlat16_2.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
        SV_Target0.xyz = u_xlat16_2.xyz;
    } else {
#ifdef UNITY_ADRENO_ES3
        u_xlatb8 = !!(_TexOrColorSwitch==1.0);
#else
        u_xlatb8 = _TexOrColorSwitch==1.0;
#endif
        u_xlat16_3.xyz = u_xlat10_1.xyz * _NoiseColor.xyz;
        SV_Target0.xyz = (bool(u_xlatb8)) ? u_xlat16_3.xyz : vec3(0.0, 0.0, 0.0);
    //ENDIF
    }
    u_xlat8.xy = vs_TEXCOORD0.xy * _Dissmap_ST.xy + _Dissmap_ST.zw;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy).w;
    u_xlat16_3.x = (-_Opacity) + 1.0;
    u_xlat10_4 = texture(_Dissmap, u_xlat8.xy).x;
    u_xlat16_4 = (-u_xlat10_4) + u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4 = min(max(u_xlat16_4, 0.0), 1.0);
#else
    u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
#endif
    u_xlat16_0 = (-u_xlat16_4) + u_xlat10_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_Opacity>=vs_TEXCOORD0.x);
#else
    u_xlatb4 = _Opacity>=vs_TEXCOORD0.x;
#endif
    u_xlat16_3.x = u_xlat16_0 * 3.0;
    u_xlat16_3.x = u_xlat16_3.x * _OP;
    u_xlatb0.xz = equal(vec4(_AlphaGradualSwitch), vec4(0.0, 0.0, 1.0, 0.0)).xz;
    u_xlat16_7 = (u_xlatb4) ? _OP : 0.0;
    u_xlat16_7 = (u_xlatb0.z) ? u_xlat16_7 : 0.0;
    SV_Target0.w = (u_xlatb0.x) ? u_xlat16_3.x : u_xlat16_7;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
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
uniform 	mediump float _TexOrColorSwitch;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Speed;
uniform 	vec4 _Noise_ST;
uniform 	mediump vec4 _NoiseColor;
uniform 	mediump float _AlphaGradualSwitch;
uniform 	mediump float _Opacity;
uniform 	vec4 _Dissmap_ST;
uniform 	mediump float _OP;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Dissmap;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bvec3 u_xlatb0;
vec2 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_4;
lowp float u_xlat10_4;
bool u_xlatb4;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
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
    u_xlat8.x = _Time.y * _Speed;
    u_xlat1.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat8.xy = u_xlat8.xx * vec2(-1.0, 0.0) + u_xlat1.xy;
    u_xlat10_1.xyz = texture(_Noise, u_xlat8.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_TexOrColorSwitch==0.0);
#else
    u_xlatb8 = _TexOrColorSwitch==0.0;
#endif
    if(u_xlatb8){
        u_xlat10_2.xyz = texture(_MainTex, u_xlat0.xy).xyz;
        u_xlat16_2.xyz = u_xlat10_2.xyz * _MainColor.xyz;
        u_xlat16_2.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
        SV_Target0.xyz = u_xlat16_2.xyz;
    } else {
#ifdef UNITY_ADRENO_ES3
        u_xlatb8 = !!(_TexOrColorSwitch==1.0);
#else
        u_xlatb8 = _TexOrColorSwitch==1.0;
#endif
        u_xlat16_3.xyz = u_xlat10_1.xyz * _NoiseColor.xyz;
        SV_Target0.xyz = (bool(u_xlatb8)) ? u_xlat16_3.xyz : vec3(0.0, 0.0, 0.0);
    //ENDIF
    }
    u_xlat8.xy = vs_TEXCOORD0.xy * _Dissmap_ST.xy + _Dissmap_ST.zw;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy).w;
    u_xlat16_3.x = (-_Opacity) + 1.0;
    u_xlat10_4 = texture(_Dissmap, u_xlat8.xy).x;
    u_xlat16_4 = (-u_xlat10_4) + u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4 = min(max(u_xlat16_4, 0.0), 1.0);
#else
    u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
#endif
    u_xlat16_0 = (-u_xlat16_4) + u_xlat10_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_Opacity>=vs_TEXCOORD0.x);
#else
    u_xlatb4 = _Opacity>=vs_TEXCOORD0.x;
#endif
    u_xlat16_3.x = u_xlat16_0 * 3.0;
    u_xlat16_3.x = u_xlat16_3.x * _OP;
    u_xlatb0.xz = equal(vec4(_AlphaGradualSwitch), vec4(0.0, 0.0, 1.0, 0.0)).xz;
    u_xlat16_7 = (u_xlatb4) ? _OP : 0.0;
    u_xlat16_7 = (u_xlatb0.z) ? u_xlat16_7 : 0.0;
    SV_Target0.w = (u_xlatb0.x) ? u_xlat16_3.x : u_xlat16_7;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
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
uniform 	mediump float _TexOrColorSwitch;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Speed;
uniform 	vec4 _Noise_ST;
uniform 	mediump vec4 _NoiseColor;
uniform 	mediump float _AlphaGradualSwitch;
uniform 	mediump float _Opacity;
uniform 	vec4 _Dissmap_ST;
uniform 	mediump float _OP;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Dissmap;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bvec3 u_xlatb0;
vec2 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_4;
lowp float u_xlat10_4;
bool u_xlatb4;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
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
    u_xlat8.x = _Time.y * _Speed;
    u_xlat1.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat8.xy = u_xlat8.xx * vec2(-1.0, 0.0) + u_xlat1.xy;
    u_xlat10_1.xyz = texture(_Noise, u_xlat8.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_TexOrColorSwitch==0.0);
#else
    u_xlatb8 = _TexOrColorSwitch==0.0;
#endif
    if(u_xlatb8){
        u_xlat10_2.xyz = texture(_MainTex, u_xlat0.xy).xyz;
        u_xlat16_2.xyz = u_xlat10_2.xyz * _MainColor.xyz;
        u_xlat16_2.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
        SV_Target0.xyz = u_xlat16_2.xyz;
    } else {
#ifdef UNITY_ADRENO_ES3
        u_xlatb8 = !!(_TexOrColorSwitch==1.0);
#else
        u_xlatb8 = _TexOrColorSwitch==1.0;
#endif
        u_xlat16_3.xyz = u_xlat10_1.xyz * _NoiseColor.xyz;
        SV_Target0.xyz = (bool(u_xlatb8)) ? u_xlat16_3.xyz : vec3(0.0, 0.0, 0.0);
    //ENDIF
    }
    u_xlat8.xy = vs_TEXCOORD0.xy * _Dissmap_ST.xy + _Dissmap_ST.zw;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy).w;
    u_xlat16_3.x = (-_Opacity) + 1.0;
    u_xlat10_4 = texture(_Dissmap, u_xlat8.xy).x;
    u_xlat16_4 = (-u_xlat10_4) + u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4 = min(max(u_xlat16_4, 0.0), 1.0);
#else
    u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
#endif
    u_xlat16_0 = (-u_xlat16_4) + u_xlat10_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_Opacity>=vs_TEXCOORD0.x);
#else
    u_xlatb4 = _Opacity>=vs_TEXCOORD0.x;
#endif
    u_xlat16_3.x = u_xlat16_0 * 3.0;
    u_xlat16_3.x = u_xlat16_3.x * _OP;
    u_xlatb0.xz = equal(vec4(_AlphaGradualSwitch), vec4(0.0, 0.0, 1.0, 0.0)).xz;
    u_xlat16_7 = (u_xlatb4) ? _OP : 0.0;
    u_xlat16_7 = (u_xlatb0.z) ? u_xlat16_7 : 0.0;
    SV_Target0.w = (u_xlatb0.x) ? u_xlat16_3.x : u_xlat16_7;
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
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
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
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
}
}
 Pass {
  Name "MOTIONVECTORS"
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "MOTIONVECTORS" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 66787
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousM[4];
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
uniform 	int _HasLastPositionData;
uniform 	float _MotionVectorDepthBias;
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat2 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat1.zzzz + u_xlat2;
    vs_TEXCOORD0 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = in_NORMAL0.xyz;
    u_xlat1.w = 1.0;
    u_xlat1 = (_HasLastPositionData != 0) ? u_xlat1 : in_POSITION0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_PreviousM[1];
    u_xlat2 = hlslcc_mtx4x4_PreviousM[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_PreviousM[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4_PreviousM[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat2 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat1.zzzz + u_xlat2;
    vs_TEXCOORD1 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    gl_Position.z = u_xlat0.x * u_xlat0.w + u_xlat0.z;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	int _ForceNoMotion;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
ivec2 u_xlati0;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_2;
vec2 u_xlat6;
ivec2 u_xlati6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat6.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat6.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlat16_1.x = (_ForceNoMotion != 0) ? 1.0 : 0.0;
    u_xlat16_1.xy = u_xlat16_1.xx * (-u_xlat0.xy) + u_xlat0.xy;
    u_xlati0.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat16_1.xyxx).xy) * 0xFFFFFFFFu);
    u_xlati6.xy = ivec2(uvec2(lessThan(u_xlat16_1.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat16_2.xy = sqrt(abs(u_xlat16_1.xy));
    u_xlati0.xy = (-u_xlati0.xy) + u_xlati6.xy;
    u_xlat0.xy = vec2(u_xlati0.xy);
    u_xlat0.xy = u_xlat0.xy * u_xlat16_2.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.498039216, 0.498039216);
    SV_Target0.xy = u_xlat0.xy;
    SV_Target0.zw = vec2(1.0, 1.0);
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
CustomEditor "MiHoYoASEMaterialInspector"
}