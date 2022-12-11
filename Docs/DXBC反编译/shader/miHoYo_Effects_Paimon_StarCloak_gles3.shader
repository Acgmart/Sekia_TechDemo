//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Effects/Paimon_StarCloak" {
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
_MainTex ("MainTex", 2D) = "white" { }
_StarTex ("StarTex", 2D) = "black" { }
_StarBrightness ("StarBrightness", Float) = 60
_StarHeight ("StarHeight", Float) = 14.89
_Star02Tex ("Star02Tex", 2D) = "black" { }
_Star02Height ("Star02Height", Float) = 0
_NoiseTex01 ("NoiseTex01", 2D) = "white" { }
_Noise01Speed ("Noise01Speed", Float) = 0.1
_NoiseTex02 ("NoiseTex02", 2D) = "white" { }
_Noise02Speed ("Noise02Speed", Float) = -0.1
_ColorPaletteTex ("ColorPaletteTex", 2D) = "white" { }
_ColorPalletteSpeed ("ColorPalletteSpeed", Float) = -0.1
_ConstellationTex ("ConstellationTex", 2D) = "white" { }
_ConstellationHeight ("ConstellationHeight", Float) = 1.2
_ConstellationBrightness ("ConstellationBrightness", Float) = 5
_Star01Speed ("Star01Speed", Float) = 0
_Noise03Brightness ("Noise03Brightness", Float) = 0.2
_CloudTex ("CloudTex", 2D) = "white" { }
_CloudBrightness ("CloudBrightness", Float) = 1
_CloudHeight ("CloudHeight", Float) = 1
_texcoord ("", 2D) = "white" { }
}
SubShader {
 Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "HYBRIDDEFERRED"
  Tags { "LIGHTMODE" = "HYBRIDDEFERRED" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 28749
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
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat15 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.yxz;
    u_xlat4.y = u_xlat3.x;
    u_xlat4.z = u_xlat1.y;
    u_xlat4.x = u_xlat2.x;
    u_xlat4.xyz = u_xlat0.yyy * u_xlat4.xyz;
    u_xlat1.y = u_xlat3.z;
    u_xlat3.z = u_xlat1.x;
    u_xlat3.x = u_xlat2.z;
    u_xlat1.x = u_xlat2.y;
    u_xlat0.xyw = u_xlat3.xyz * u_xlat0.xxx + u_xlat4.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz * u_xlat0.zzz + u_xlat0.xyw;
    vs_TEXCOORD3.w = 0.0;
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
uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _ReceiveShadow;
uniform 	float _EnableAlphaTest;
uniform 	float _CutOff;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _StarTex_ST;
uniform 	float _Star01Speed;
uniform 	float _StarHeight;
uniform 	vec4 _Star02Tex_ST;
uniform 	float _Star02Height;
uniform 	float _ColorPalletteSpeed;
uniform 	vec4 _ColorPaletteTex_ST;
uniform 	float _StarBrightness;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01Speed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02Speed;
uniform 	vec4 _ConstellationTex_ST;
uniform 	float _ConstellationHeight;
uniform 	float _ConstellationBrightness;
uniform 	vec4 _CloudTex_ST;
uniform 	float _Noise03Brightness;
uniform 	float _CloudHeight;
uniform 	float _CloudBrightness;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ColorPaletteTex;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _StarTex;
uniform lowp sampler2D _Star02Tex;
uniform lowp sampler2D _ConstellationTex;
in highp vec3 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
uvec3 u_xlatu0;
bvec2 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
vec3 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump float u_xlat16_5;
vec2 u_xlat6;
lowp float u_xlat10_6;
bool u_xlatb6;
vec3 u_xlat8;
vec2 u_xlat12;
vec2 u_xlat14;
vec2 u_xlat16;
float u_xlat18;
lowp float u_xlat10_18;
bool u_xlatb18;
float u_xlat21;
lowp float u_xlat10_21;
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
    u_xlat0.xz = vs_TEXCOORD2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = texture(_MainTex, u_xlat0.xz);
    u_xlat2.xy = vs_TEXCOORD2.xy * _StarTex_ST.xy + _StarTex_ST.zw;
    u_xlat0.x = _Time.y * _Star01Speed;
    u_xlat2.z = _Time.y * _Star01Speed + u_xlat2.y;
    u_xlat12.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat12.xy = u_xlat12.xx * vs_TEXCOORD3.xy;
    u_xlat8.x = _StarHeight + -1.0;
    u_xlat8.xz = u_xlat12.xy * u_xlat8.xx;
    u_xlat2.xy = u_xlat8.xz * vec2(-0.100000001, -0.100000001) + u_xlat2.xz;
    u_xlat3.xy = vs_TEXCOORD2.xy * _Star02Tex_ST.xy + _Star02Tex_ST.zw;
    u_xlat3.z = u_xlat0.x * 0.5 + u_xlat3.y;
    u_xlat0.x = _Star02Height + -1.0;
    u_xlat14.xy = u_xlat12.xy * u_xlat0.xx;
    u_xlat14.xy = u_xlat14.xy * vec2(-0.100000001, -0.100000001) + u_xlat3.xz;
    u_xlat3.yz = vs_TEXCOORD2.xy * _ColorPaletteTex_ST.xy + _ColorPaletteTex_ST.zw;
    u_xlat3.x = _Time.y * _ColorPalletteSpeed + u_xlat3.y;
    u_xlat10_3.xyz = texture(_ColorPaletteTex, u_xlat3.xz).xyz;
    u_xlat4.xy = vs_TEXCOORD2.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat16.xy = vs_TEXCOORD2.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat4.xy = _Time.yy * vec2(_Noise01Speed) + u_xlat4.xy;
    u_xlat10_0 = texture(_NoiseTex01, u_xlat4.xy).x;
    u_xlat4.xy = _Time.yy * vec2(_Noise02Speed) + u_xlat16.xy;
    u_xlat10_21 = texture(_NoiseTex02, u_xlat4.xy).x;
    u_xlat16_0 = u_xlat10_0 * u_xlat10_21;
    u_xlat4.xy = vs_TEXCOORD2.xy * _ConstellationTex_ST.xy + _ConstellationTex_ST.zw;
    u_xlat21 = _ConstellationHeight + -1.0;
    u_xlat16.xy = u_xlat12.xy * vec2(u_xlat21);
    u_xlat4.xy = u_xlat16.xy * vec2(-0.100000001, -0.100000001) + u_xlat4.xy;
    u_xlat16.xy = vs_TEXCOORD2.xy * _CloudTex_ST.xy + _CloudTex_ST.zw;
    u_xlat21 = _CloudHeight + -1.0;
    u_xlat12.xy = u_xlat12.xy * vec2(u_xlat21);
    u_xlat16.xy = vec2(u_xlat16_0) * vec2(_Noise03Brightness) + u_xlat16.xy;
    u_xlat12.xy = u_xlat12.xy * vec2(-0.100000001, -0.100000001) + u_xlat16.xy;
    u_xlat6.y = texture(_CloudTex, u_xlat12.xy).x;
    u_xlat18 = (-_CutOff) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat18<0.0);
#else
    u_xlatb18 = u_xlat18<0.0;
#endif
    u_xlatb6 = u_xlatb0.y && u_xlatb18;
    if((int(u_xlatb6) * int(0xffffffffu))!=0){discard;}
    u_xlat10_6 = texture(_StarTex, u_xlat2.xy).x;
    u_xlat10_18 = texture(_Star02Tex, u_xlat14.xy).y;
    u_xlat6.x = u_xlat10_18 + u_xlat10_6;
    u_xlat6.xy = u_xlat6.xy * u_xlat1.ww;
    u_xlat2.xyz = u_xlat10_3.xyz * u_xlat6.xxx;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_StarBrightness);
    u_xlat10_4.xyz = texture(_ConstellationTex, u_xlat4.xy).xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * vec3(vec3(_ConstellationBrightness, _ConstellationBrightness, _ConstellationBrightness));
    u_xlat0.xyw = u_xlat2.xyz * vec3(u_xlat16_0) + u_xlat4.xyz;
    u_xlat12.x = u_xlat6.y * _CloudBrightness;
    u_xlat0.xyz = u_xlat12.xxx * u_xlat10_3.xyz + u_xlat0.xyw;
    u_xlat18 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * vs_TEXCOORD0.xyz;
    SV_Target0.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb18 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_5 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb18) ? u_xlat16_5 : u_xlat0.z;
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
    u_xlat5.xyz = u_xlat5.xxx * u_xlat2.xyz;
    vs_TEXCOORD0.xyz = u_xlat5.xyz;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat1.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.yxz;
    u_xlat3.xyz = u_xlat5.zxy * u_xlat2.yxz;
    u_xlat3.xyz = u_xlat5.yzx * u_xlat2.xzy + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.yxz;
    u_xlat4.y = u_xlat3.x;
    u_xlat4.x = u_xlat2.y;
    u_xlat4.z = u_xlat5.y;
    u_xlat4.xyz = u_xlat1.yyy * u_xlat4.xyz;
    u_xlat2.y = u_xlat3.z;
    u_xlat3.x = u_xlat2.z;
    u_xlat3.z = u_xlat5.x;
    u_xlat2.z = u_xlat5.z;
    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xxx + u_xlat4.xyz;
    vs_TEXCOORD3.xyz = u_xlat2.xyz * u_xlat1.zzz + u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
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
uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _ReceiveShadow;
uniform 	float _EnableAlphaTest;
uniform 	float _CutOff;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _StarTex_ST;
uniform 	float _Star01Speed;
uniform 	float _StarHeight;
uniform 	vec4 _Star02Tex_ST;
uniform 	float _Star02Height;
uniform 	float _ColorPalletteSpeed;
uniform 	vec4 _ColorPaletteTex_ST;
uniform 	float _StarBrightness;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01Speed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02Speed;
uniform 	vec4 _ConstellationTex_ST;
uniform 	float _ConstellationHeight;
uniform 	float _ConstellationBrightness;
uniform 	vec4 _CloudTex_ST;
uniform 	float _Noise03Brightness;
uniform 	float _CloudHeight;
uniform 	float _CloudBrightness;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ColorPaletteTex;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _StarTex;
uniform lowp sampler2D _Star02Tex;
uniform lowp sampler2D _ConstellationTex;
in highp vec3 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
uvec3 u_xlatu0;
bvec2 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
vec3 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump float u_xlat16_5;
vec2 u_xlat6;
lowp float u_xlat10_6;
bool u_xlatb6;
vec3 u_xlat8;
vec2 u_xlat12;
vec2 u_xlat14;
vec2 u_xlat16;
float u_xlat18;
lowp float u_xlat10_18;
bool u_xlatb18;
float u_xlat21;
lowp float u_xlat10_21;
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
    u_xlat0.xz = vs_TEXCOORD2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = texture(_MainTex, u_xlat0.xz);
    u_xlat2.xy = vs_TEXCOORD2.xy * _StarTex_ST.xy + _StarTex_ST.zw;
    u_xlat0.x = _Time.y * _Star01Speed;
    u_xlat2.z = _Time.y * _Star01Speed + u_xlat2.y;
    u_xlat12.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat12.xy = u_xlat12.xx * vs_TEXCOORD3.xy;
    u_xlat8.x = _StarHeight + -1.0;
    u_xlat8.xz = u_xlat12.xy * u_xlat8.xx;
    u_xlat2.xy = u_xlat8.xz * vec2(-0.100000001, -0.100000001) + u_xlat2.xz;
    u_xlat3.xy = vs_TEXCOORD2.xy * _Star02Tex_ST.xy + _Star02Tex_ST.zw;
    u_xlat3.z = u_xlat0.x * 0.5 + u_xlat3.y;
    u_xlat0.x = _Star02Height + -1.0;
    u_xlat14.xy = u_xlat12.xy * u_xlat0.xx;
    u_xlat14.xy = u_xlat14.xy * vec2(-0.100000001, -0.100000001) + u_xlat3.xz;
    u_xlat3.yz = vs_TEXCOORD2.xy * _ColorPaletteTex_ST.xy + _ColorPaletteTex_ST.zw;
    u_xlat3.x = _Time.y * _ColorPalletteSpeed + u_xlat3.y;
    u_xlat10_3.xyz = texture(_ColorPaletteTex, u_xlat3.xz).xyz;
    u_xlat4.xy = vs_TEXCOORD2.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat16.xy = vs_TEXCOORD2.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat4.xy = _Time.yy * vec2(_Noise01Speed) + u_xlat4.xy;
    u_xlat10_0 = texture(_NoiseTex01, u_xlat4.xy).x;
    u_xlat4.xy = _Time.yy * vec2(_Noise02Speed) + u_xlat16.xy;
    u_xlat10_21 = texture(_NoiseTex02, u_xlat4.xy).x;
    u_xlat16_0 = u_xlat10_0 * u_xlat10_21;
    u_xlat4.xy = vs_TEXCOORD2.xy * _ConstellationTex_ST.xy + _ConstellationTex_ST.zw;
    u_xlat21 = _ConstellationHeight + -1.0;
    u_xlat16.xy = u_xlat12.xy * vec2(u_xlat21);
    u_xlat4.xy = u_xlat16.xy * vec2(-0.100000001, -0.100000001) + u_xlat4.xy;
    u_xlat16.xy = vs_TEXCOORD2.xy * _CloudTex_ST.xy + _CloudTex_ST.zw;
    u_xlat21 = _CloudHeight + -1.0;
    u_xlat12.xy = u_xlat12.xy * vec2(u_xlat21);
    u_xlat16.xy = vec2(u_xlat16_0) * vec2(_Noise03Brightness) + u_xlat16.xy;
    u_xlat12.xy = u_xlat12.xy * vec2(-0.100000001, -0.100000001) + u_xlat16.xy;
    u_xlat6.y = texture(_CloudTex, u_xlat12.xy).x;
    u_xlat18 = (-_CutOff) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat18<0.0);
#else
    u_xlatb18 = u_xlat18<0.0;
#endif
    u_xlatb6 = u_xlatb0.y && u_xlatb18;
    if((int(u_xlatb6) * int(0xffffffffu))!=0){discard;}
    u_xlat10_6 = texture(_StarTex, u_xlat2.xy).x;
    u_xlat10_18 = texture(_Star02Tex, u_xlat14.xy).y;
    u_xlat6.x = u_xlat10_18 + u_xlat10_6;
    u_xlat6.xy = u_xlat6.xy * u_xlat1.ww;
    u_xlat2.xyz = u_xlat10_3.xyz * u_xlat6.xxx;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_StarBrightness);
    u_xlat10_4.xyz = texture(_ConstellationTex, u_xlat4.xy).xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * vec3(vec3(_ConstellationBrightness, _ConstellationBrightness, _ConstellationBrightness));
    u_xlat0.xyw = u_xlat2.xyz * vec3(u_xlat16_0) + u_xlat4.xyz;
    u_xlat12.x = u_xlat6.y * _CloudBrightness;
    u_xlat0.xyz = u_xlat12.xxx * u_xlat10_3.xyz + u_xlat0.xyw;
    u_xlat18 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * vs_TEXCOORD0.xyz;
    SV_Target0.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb18 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_5 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb18) ? u_xlat16_5 : u_xlat0.z;
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
  GpuProgramID 96591
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
  GpuProgramID 156338
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
  GpuProgramID 243022
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