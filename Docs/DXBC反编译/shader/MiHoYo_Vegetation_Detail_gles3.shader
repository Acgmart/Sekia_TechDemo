//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "MiHoYo/Vegetation/Detail" {
Properties {
[Header(Random)] _RandomScaleMin ("Random Scale Min", Range(0, 10)) = 1
_RandomScaleMax ("Random Scale Max", Range(0, 10)) = 1
[Space] _RandomRotateMin ("Random Rotate Y Min", Range(0, 360)) = 1
_RandomRotateMax ("Random Rotate Y Max", Range(0, 360)) = 1
[Header(Albedo)] _MainTex ("Main Texture", 2D) = "white" { }
_MainColor ("Main Color", Color) = (1,1,1,1)
_Shininess ("Shininess", Range(0.01, 0.99)) = 0.3
_CutOff ("Cut Off", Range(0, 1)) = 0.001
[Header(Depth Blend)] [Toggle(ENABLE_DEPTH_BLEND_ON)] _EnableDepthBlend ("Enable Depth Blend", Float) = 0
_DepthBiasScaled ("Depth bias scaled", Range(0, 16)) = 1
_WorldOffsetRange ("Heightmap World Offset and Range", Vector) = (0,0,128,128)
_Heightmap ("Heightmap", 2D) = "black" { }
_HeightScale ("Height Scale", Float) = 100
}
SubShader {
 LOD 100
 Tags { "QUEUE" = "AlphaTest-1" "RenderType" = "Opaque" }
 Pass {
  LOD 100
  Tags { "LIGHTMODE" = "HYBRIDDEFERRED" "QUEUE" = "AlphaTest-1" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 27147
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVPZero[4];
uniform 	vec4 _WorldOffsetRange;
uniform 	float _HeightScale;
uniform 	vec4 _MainTex_ST;
uniform highp sampler2D _Heightmap;
in mediump vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
out mediump vec3 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
float u_xlat7;
void main()
{
    u_xlat0.xy = (-_WorldOffsetRange.xy) + vec2(1.0, 1.0);
    u_xlat4.xy = vec2(_WorldOffsetRange.z + float(2.0), _WorldOffsetRange.w + float(2.0));
    u_xlat0.xy = u_xlat0.xy / u_xlat4.xy;
    u_xlat0.x = textureLod(_Heightmap, u_xlat0.xy, 0.0).x;
    u_xlat0.y = u_xlat0.x * _HeightScale;
    u_xlat0.x = float(0.0);
    u_xlat0.z = float(0.0);
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVPZero[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVPZero[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVPZero[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVPZero[3];
    gl_Position = u_xlat0;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = u_xlat1.xy;
    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD2 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump vec3 _MainColor;
uniform 	mediump float _Shininess;
uniform 	mediump float _CutOff;
uniform lowp sampler2D _MainTex;
in mediump vec3 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_CutOff);
    SV_Target1.xyz = u_xlat10_0.xyz * _MainColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb0 = u_xlat16_1.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat16_1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * vs_TEXCOORD0.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : 0.0399999991;
    SV_Target2.xy = vec2(0.0399999991, 0.0399999991);
    SV_Target2.w = _Shininess;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "ENABLE_DEPTH_BLEND_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVPZero[4];
uniform 	vec4 _WorldOffsetRange;
uniform 	float _HeightScale;
uniform 	vec4 _MainTex_ST;
uniform highp sampler2D _Heightmap;
in mediump vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
out mediump vec3 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
float u_xlat7;
void main()
{
    u_xlat0.xy = (-_WorldOffsetRange.xy) + vec2(1.0, 1.0);
    u_xlat4.xy = vec2(_WorldOffsetRange.z + float(2.0), _WorldOffsetRange.w + float(2.0));
    u_xlat0.xy = u_xlat0.xy / u_xlat4.xy;
    u_xlat0.x = textureLod(_Heightmap, u_xlat0.xy, 0.0).x;
    u_xlat0.y = u_xlat0.x * _HeightScale;
    u_xlat0.x = float(0.0);
    u_xlat0.z = float(0.0);
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVPZero[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVPZero[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVPZero[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVPZero[3];
    gl_Position = u_xlat0;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = u_xlat1.xy;
    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD2 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _DepthBiasScaled;
uniform 	mediump vec3 _MainColor;
uniform 	mediump float _Shininess;
uniform 	mediump float _CutOff;
uniform lowp sampler2D _MainTex;
uniform highp sampler2D _CameraDepthBlendTexture;
uniform lowp sampler2D _CameraDepthBlendNormTexture;
uniform lowp sampler2D _CameraDepthBlendDiffTexture;
in mediump vec3 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
vec3 u_xlat4;
bool u_xlatb4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_11;
lowp vec3 u_xlat10_11;
bool u_xlatb21;
mediump float u_xlat16_22;
float u_xlat25;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_1.xyz = u_xlat10_0.xyz * _MainColor.xyz;
    u_xlat16_22 = u_xlat10_0.w + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(u_xlat16_22<0.0);
#else
    u_xlatb21 = u_xlat16_22<0.0;
#endif
    if((int(u_xlatb21) * int(0xffffffffu))!=0){discard;}
    u_xlat16_22 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_22 = inversesqrt(u_xlat16_22);
    u_xlat16_2.xyz = vec3(u_xlat16_22) * vs_TEXCOORD0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(vs_TEXCOORD2.w<100.0);
#else
    u_xlatb21 = vs_TEXCOORD2.w<100.0;
#endif
    if(u_xlatb21){
        u_xlat3.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat4.x = texture(_CameraDepthBlendTexture, u_xlat3.xy).x;
        u_xlat4.x = _ZBufferParams.z * u_xlat4.x + _ZBufferParams.w;
        u_xlat4.x = float(1.0) / u_xlat4.x;
        u_xlat4.x = u_xlat4.x + (-vs_TEXCOORD2.w);
        u_xlat4.x = abs(u_xlat4.x) * _DepthBiasScaled;
#ifdef UNITY_ADRENO_ES3
        u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
        u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
        u_xlat4.x = sqrt(u_xlat4.x);
        u_xlat10_11.xyz = texture(_CameraDepthBlendNormTexture, u_xlat3.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_11.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat10_11.xyz = texture(_CameraDepthBlendDiffTexture, u_xlat3.xy).xyz;
        u_xlat16_6.xyz = u_xlat10_0.xyz * _MainColor.xyz + (-u_xlat10_11.xyz);
        u_xlat1.xyz = u_xlat4.xxx * u_xlat16_6.xyz + u_xlat10_11.xyz;
        u_xlat16_11.xyz = vs_TEXCOORD0.xyz * vec3(u_xlat16_22) + (-u_xlat16_5.xyz);
        u_xlat4.xyz = u_xlat4.xxx * u_xlat16_11.xyz + u_xlat16_5.xyz;
        u_xlat25 = dot(u_xlat4.xyz, u_xlat4.xyz);
        u_xlat25 = inversesqrt(u_xlat25);
        u_xlat2.xyz = vec3(u_xlat25) * u_xlat4.xyz;
        u_xlat16_1.xyz = u_xlat1.xyz;
        u_xlat16_2.xyz = u_xlat2.xyz;
    //ENDIF
    }
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb4 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb4) ? 0.0 : 0.0399999991;
    SV_Target0.w = 0.0;
    SV_Target1.xyz = u_xlat16_1.xyz;
    SV_Target1.w = 0.0;
    SV_Target2.xy = vec2(0.0399999991, 0.0399999991);
    SV_Target2.w = _Shininess;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVPZero[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _WorldOffsetRange;
uniform 	float _HeightScale;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _RandomScaleMin;
uniform 	mediump float _RandomScaleMax;
uniform 	mediump float _RandomRotateMin;
uniform 	mediump float _RandomRotateMax;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform highp sampler2D _Heightmap;
in highp vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec3 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
int u_xlati1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
vec3 u_xlat5;
vec3 u_xlat7;
vec3 u_xlat8;
uint u_xlatu8;
float u_xlat19;
void main()
{
    u_xlat16_0 = (-_RandomRotateMin) + _RandomRotateMax;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati1 = u_xlati1 << 2;
    u_xlat7.xyz = in_TEXCOORD1.yyy * unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TEXCOORD1.xxx + u_xlat7.xyz;
    u_xlat7.xyz = u_xlat7.xyz + unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat2.x = u_xlat7.y * u_xlat7.x;
    u_xlat2.x = u_xlat7.z * u_xlat2.x;
    u_xlat8.xyz = u_xlat7.xyz + vec3(0.212699994, 0.212699994, 0.212699994);
    u_xlat2.xyz = u_xlat2.xxx * vec3(0.371300012, 0.371300012, 0.371300012) + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat2.xyz * vec3(489.122986, 489.122986, 489.122986);
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat8.xyz = sin(u_xlat8.xyz);
    u_xlat8.xyz = u_xlat8.xyz * vec3(4.78900003, 4.78900003, 4.78900003);
    u_xlat8.x = u_xlat8.y * u_xlat8.x;
    u_xlat8.x = u_xlat8.z * u_xlat8.x;
    u_xlat2.x = u_xlat2.x * u_xlat8.x;
    u_xlat2.x = fract(u_xlat2.x);
    u_xlat8.x = u_xlat2.x * u_xlat16_0 + _RandomRotateMin;
    u_xlat8.x = u_xlat8.x * 0.0174532942;
    u_xlat3.x = sin(u_xlat8.x);
    u_xlat4 = cos(u_xlat8.x);
    u_xlat5.x = sin((-u_xlat8.x));
    u_xlat5.z = u_xlat3.x;
    u_xlat5.y = u_xlat4;
    u_xlat8.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat8.xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat8.xyz + unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) + u_xlat8.xyz;
    u_xlat3.x = dot(u_xlat5.yz, u_xlat8.xz);
    u_xlat3.z = dot(u_xlat5.xy, u_xlat8.xz);
    u_xlat3.y = u_xlat8.y;
    u_xlat16_0 = (-_RandomScaleMin) + _RandomScaleMax;
    u_xlat2.x = u_xlat2.x * u_xlat16_0 + _RandomScaleMin;
    u_xlat8.x = float(floatBitsToUint(unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[2]).w);
    u_xlat8.x = u_xlat8.x * 5.96046448e-08;
    u_xlatu8 = uint(u_xlat8.x);
    u_xlatu8 = u_xlatu8 & 3u;
    u_xlat8.x = float(u_xlatu8);
    u_xlat2.x = u_xlat2.x * u_xlat8.x;
    u_xlat2.x = u_xlat2.x * 0.333000004;
    u_xlat0.xyz = u_xlat3.xyz * u_xlat2.xxx + u_xlat7.xyz;
    u_xlat7.xy = u_xlat7.xz + (-_WorldOffsetRange.xy);
    u_xlat7.xy = u_xlat7.xy + vec2(1.0, 1.0);
    u_xlat2.xy = vec2(_WorldOffsetRange.z + float(2.0), _WorldOffsetRange.w + float(2.0));
    u_xlat7.xy = u_xlat7.xy / u_xlat2.xy;
    u_xlat7.x = textureLod(_Heightmap, u_xlat7.xy, 0.0).x;
    u_xlat0.w = u_xlat7.x * _HeightScale + u_xlat0.y;
    u_xlat7.xyz = u_xlat0.xwz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0 = u_xlat7.yyyy * hlslcc_mtx4x4unity_MatrixVPZero[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVPZero[0] * u_xlat7.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVPZero[2] * u_xlat7.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVPZero[3];
    gl_Position = u_xlat0;
    u_xlat7.xyz = in_NORMAL0.yyy * unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_NORMAL0.xxx + u_xlat7.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_NORMAL0.zzz + u_xlat7.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = u_xlat1.xy;
    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD2 = u_xlat0;
    vs_SV_InstanceID0 = uint(0u);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump vec3 _MainColor;
uniform 	mediump float _Shininess;
uniform 	mediump float _CutOff;
uniform lowp sampler2D _MainTex;
in mediump vec3 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_CutOff);
    SV_Target1.xyz = u_xlat10_0.xyz * _MainColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb0 = u_xlat16_1.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat16_1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * vs_TEXCOORD0.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : 0.0399999991;
    SV_Target2.xy = vec2(0.0399999991, 0.0399999991);
    SV_Target2.w = _Shininess;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "ENABLE_DEPTH_BLEND_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVPZero[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _WorldOffsetRange;
uniform 	float _HeightScale;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _RandomScaleMin;
uniform 	mediump float _RandomScaleMax;
uniform 	mediump float _RandomRotateMin;
uniform 	mediump float _RandomRotateMax;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform highp sampler2D _Heightmap;
in highp vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec3 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
int u_xlati1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
vec3 u_xlat5;
vec3 u_xlat7;
vec3 u_xlat8;
uint u_xlatu8;
float u_xlat19;
void main()
{
    u_xlat16_0 = (-_RandomRotateMin) + _RandomRotateMax;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati1 = u_xlati1 << 2;
    u_xlat7.xyz = in_TEXCOORD1.yyy * unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TEXCOORD1.xxx + u_xlat7.xyz;
    u_xlat7.xyz = u_xlat7.xyz + unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat2.x = u_xlat7.y * u_xlat7.x;
    u_xlat2.x = u_xlat7.z * u_xlat2.x;
    u_xlat8.xyz = u_xlat7.xyz + vec3(0.212699994, 0.212699994, 0.212699994);
    u_xlat2.xyz = u_xlat2.xxx * vec3(0.371300012, 0.371300012, 0.371300012) + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat2.xyz * vec3(489.122986, 489.122986, 489.122986);
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat8.xyz = sin(u_xlat8.xyz);
    u_xlat8.xyz = u_xlat8.xyz * vec3(4.78900003, 4.78900003, 4.78900003);
    u_xlat8.x = u_xlat8.y * u_xlat8.x;
    u_xlat8.x = u_xlat8.z * u_xlat8.x;
    u_xlat2.x = u_xlat2.x * u_xlat8.x;
    u_xlat2.x = fract(u_xlat2.x);
    u_xlat8.x = u_xlat2.x * u_xlat16_0 + _RandomRotateMin;
    u_xlat8.x = u_xlat8.x * 0.0174532942;
    u_xlat3.x = sin(u_xlat8.x);
    u_xlat4 = cos(u_xlat8.x);
    u_xlat5.x = sin((-u_xlat8.x));
    u_xlat5.z = u_xlat3.x;
    u_xlat5.y = u_xlat4;
    u_xlat8.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat8.xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat8.xyz + unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) + u_xlat8.xyz;
    u_xlat3.x = dot(u_xlat5.yz, u_xlat8.xz);
    u_xlat3.z = dot(u_xlat5.xy, u_xlat8.xz);
    u_xlat3.y = u_xlat8.y;
    u_xlat16_0 = (-_RandomScaleMin) + _RandomScaleMax;
    u_xlat2.x = u_xlat2.x * u_xlat16_0 + _RandomScaleMin;
    u_xlat8.x = float(floatBitsToUint(unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[2]).w);
    u_xlat8.x = u_xlat8.x * 5.96046448e-08;
    u_xlatu8 = uint(u_xlat8.x);
    u_xlatu8 = u_xlatu8 & 3u;
    u_xlat8.x = float(u_xlatu8);
    u_xlat2.x = u_xlat2.x * u_xlat8.x;
    u_xlat2.x = u_xlat2.x * 0.333000004;
    u_xlat0.xyz = u_xlat3.xyz * u_xlat2.xxx + u_xlat7.xyz;
    u_xlat7.xy = u_xlat7.xz + (-_WorldOffsetRange.xy);
    u_xlat7.xy = u_xlat7.xy + vec2(1.0, 1.0);
    u_xlat2.xy = vec2(_WorldOffsetRange.z + float(2.0), _WorldOffsetRange.w + float(2.0));
    u_xlat7.xy = u_xlat7.xy / u_xlat2.xy;
    u_xlat7.x = textureLod(_Heightmap, u_xlat7.xy, 0.0).x;
    u_xlat0.w = u_xlat7.x * _HeightScale + u_xlat0.y;
    u_xlat7.xyz = u_xlat0.xwz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0 = u_xlat7.yyyy * hlslcc_mtx4x4unity_MatrixVPZero[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVPZero[0] * u_xlat7.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVPZero[2] * u_xlat7.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVPZero[3];
    gl_Position = u_xlat0;
    u_xlat7.xyz = in_NORMAL0.yyy * unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_NORMAL0.xxx + u_xlat7.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_NORMAL0.zzz + u_xlat7.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = u_xlat1.xy;
    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD2 = u_xlat0;
    vs_SV_InstanceID0 = uint(0u);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _DepthBiasScaled;
uniform 	mediump vec3 _MainColor;
uniform 	mediump float _Shininess;
uniform 	mediump float _CutOff;
uniform lowp sampler2D _MainTex;
uniform highp sampler2D _CameraDepthBlendTexture;
uniform lowp sampler2D _CameraDepthBlendNormTexture;
uniform lowp sampler2D _CameraDepthBlendDiffTexture;
in mediump vec3 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
vec3 u_xlat4;
bool u_xlatb4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_11;
lowp vec3 u_xlat10_11;
bool u_xlatb21;
mediump float u_xlat16_22;
float u_xlat25;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_1.xyz = u_xlat10_0.xyz * _MainColor.xyz;
    u_xlat16_22 = u_xlat10_0.w + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(u_xlat16_22<0.0);
#else
    u_xlatb21 = u_xlat16_22<0.0;
#endif
    if((int(u_xlatb21) * int(0xffffffffu))!=0){discard;}
    u_xlat16_22 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_22 = inversesqrt(u_xlat16_22);
    u_xlat16_2.xyz = vec3(u_xlat16_22) * vs_TEXCOORD0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(vs_TEXCOORD2.w<100.0);
#else
    u_xlatb21 = vs_TEXCOORD2.w<100.0;
#endif
    if(u_xlatb21){
        u_xlat3.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat4.x = texture(_CameraDepthBlendTexture, u_xlat3.xy).x;
        u_xlat4.x = _ZBufferParams.z * u_xlat4.x + _ZBufferParams.w;
        u_xlat4.x = float(1.0) / u_xlat4.x;
        u_xlat4.x = u_xlat4.x + (-vs_TEXCOORD2.w);
        u_xlat4.x = abs(u_xlat4.x) * _DepthBiasScaled;
#ifdef UNITY_ADRENO_ES3
        u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
        u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
        u_xlat4.x = sqrt(u_xlat4.x);
        u_xlat10_11.xyz = texture(_CameraDepthBlendNormTexture, u_xlat3.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_11.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat10_11.xyz = texture(_CameraDepthBlendDiffTexture, u_xlat3.xy).xyz;
        u_xlat16_6.xyz = u_xlat10_0.xyz * _MainColor.xyz + (-u_xlat10_11.xyz);
        u_xlat1.xyz = u_xlat4.xxx * u_xlat16_6.xyz + u_xlat10_11.xyz;
        u_xlat16_11.xyz = vs_TEXCOORD0.xyz * vec3(u_xlat16_22) + (-u_xlat16_5.xyz);
        u_xlat4.xyz = u_xlat4.xxx * u_xlat16_11.xyz + u_xlat16_5.xyz;
        u_xlat25 = dot(u_xlat4.xyz, u_xlat4.xyz);
        u_xlat25 = inversesqrt(u_xlat25);
        u_xlat2.xyz = vec3(u_xlat25) * u_xlat4.xyz;
        u_xlat16_1.xyz = u_xlat1.xyz;
        u_xlat16_2.xyz = u_xlat2.xyz;
    //ENDIF
    }
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb4 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb4) ? 0.0 : 0.0399999991;
    SV_Target0.w = 0.0;
    SV_Target1.xyz = u_xlat16_1.xyz;
    SV_Target1.w = 0.0;
    SV_Target2.xy = vec2(0.0399999991, 0.0399999991);
    SV_Target2.w = _Shininess;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DITHER_FADE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVPZero[4];
uniform 	vec4 _WorldOffsetRange;
uniform 	float _HeightScale;
uniform 	vec4 _MainTex_ST;
uniform highp sampler2D _Heightmap;
in mediump vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
out mediump vec3 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = (-_WorldOffsetRange.xy) + vec2(1.0, 1.0);
    u_xlat4.xy = vec2(_WorldOffsetRange.z + float(2.0), _WorldOffsetRange.w + float(2.0));
    u_xlat0.xy = u_xlat0.xy / u_xlat4.xy;
    u_xlat0.x = textureLod(_Heightmap, u_xlat0.xy, 0.0).x;
    u_xlat0.y = u_xlat0.x * _HeightScale;
    u_xlat0.x = float(0.0);
    u_xlat0.z = float(0.0);
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVPZero[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVPZero[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVPZero[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVPZero[3];
    gl_Position = u_xlat0;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat1.xyz = u_xlat4.xxx * u_xlat1.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = u_xlat1.xy;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD2.xyw = u_xlat0.xyw;
    vs_TEXCOORD2.z = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
float ImmCB_0_0_0[64];
uniform 	vec4 _ScreenParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump vec3 _MainColor;
uniform 	mediump float _Shininess;
uniform 	mediump float _CutOff;
uniform lowp sampler2D _MainTex;
in mediump vec3 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
void main()
{
	ImmCB_0_0_0[0] = 1.0;
	ImmCB_0_0_0[1] = 49.0;
	ImmCB_0_0_0[2] = 13.0;
	ImmCB_0_0_0[3] = 61.0;
	ImmCB_0_0_0[4] = 4.0;
	ImmCB_0_0_0[5] = 52.0;
	ImmCB_0_0_0[6] = 16.0;
	ImmCB_0_0_0[7] = 64.0;
	ImmCB_0_0_0[8] = 33.0;
	ImmCB_0_0_0[9] = 17.0;
	ImmCB_0_0_0[10] = 45.0;
	ImmCB_0_0_0[11] = 29.0;
	ImmCB_0_0_0[12] = 36.0;
	ImmCB_0_0_0[13] = 20.0;
	ImmCB_0_0_0[14] = 48.0;
	ImmCB_0_0_0[15] = 32.0;
	ImmCB_0_0_0[16] = 9.0;
	ImmCB_0_0_0[17] = 57.0;
	ImmCB_0_0_0[18] = 5.0;
	ImmCB_0_0_0[19] = 53.0;
	ImmCB_0_0_0[20] = 12.0;
	ImmCB_0_0_0[21] = 60.0;
	ImmCB_0_0_0[22] = 8.0;
	ImmCB_0_0_0[23] = 56.0;
	ImmCB_0_0_0[24] = 41.0;
	ImmCB_0_0_0[25] = 25.0;
	ImmCB_0_0_0[26] = 37.0;
	ImmCB_0_0_0[27] = 21.0;
	ImmCB_0_0_0[28] = 44.0;
	ImmCB_0_0_0[29] = 28.0;
	ImmCB_0_0_0[30] = 40.0;
	ImmCB_0_0_0[31] = 24.0;
	ImmCB_0_0_0[32] = 3.0;
	ImmCB_0_0_0[33] = 51.0;
	ImmCB_0_0_0[34] = 15.0;
	ImmCB_0_0_0[35] = 63.0;
	ImmCB_0_0_0[36] = 2.0;
	ImmCB_0_0_0[37] = 50.0;
	ImmCB_0_0_0[38] = 14.0;
	ImmCB_0_0_0[39] = 62.0;
	ImmCB_0_0_0[40] = 35.0;
	ImmCB_0_0_0[41] = 19.0;
	ImmCB_0_0_0[42] = 47.0;
	ImmCB_0_0_0[43] = 31.0;
	ImmCB_0_0_0[44] = 34.0;
	ImmCB_0_0_0[45] = 18.0;
	ImmCB_0_0_0[46] = 46.0;
	ImmCB_0_0_0[47] = 30.0;
	ImmCB_0_0_0[48] = 11.0;
	ImmCB_0_0_0[49] = 59.0;
	ImmCB_0_0_0[50] = 7.0;
	ImmCB_0_0_0[51] = 55.0;
	ImmCB_0_0_0[52] = 10.0;
	ImmCB_0_0_0[53] = 58.0;
	ImmCB_0_0_0[54] = 6.0;
	ImmCB_0_0_0[55] = 54.0;
	ImmCB_0_0_0[56] = 43.0;
	ImmCB_0_0_0[57] = 27.0;
	ImmCB_0_0_0[58] = 39.0;
	ImmCB_0_0_0[59] = 23.0;
	ImmCB_0_0_0[60] = 42.0;
	ImmCB_0_0_0[61] = 26.0;
	ImmCB_0_0_0[62] = 38.0;
	ImmCB_0_0_0[63] = 22.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat16_0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
        u_xlat0.xy = u_xlat16_0.xy * _ScreenParams.yx;
        u_xlat0.xy = u_xlat0.xy * vec2(0.125, 0.125);
        u_xlat0.xy = fract(u_xlat0.xy);
        u_xlat0.xy = u_xlat0.xy * vec2(7.99900007, 7.99900007);
        u_xlat0.xy = trunc(u_xlat0.xy);
        u_xlat0.x = u_xlat0.x * 8.0 + u_xlat0.y;
        u_xlati0 = int(u_xlat0.x);
        u_xlat0.x = (-ImmCB_0_0_0[u_xlati0]) * 0.015625 + vs_TEXCOORD2.z;
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(u_xlat0.x<0.0);
#else
        u_xlatb0 = u_xlat0.x<0.0;
#endif
        if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    SV_Target1.xyz = u_xlat10_0.xyz * _MainColor.xyz;
    u_xlat16_1.x = u_xlat10_0.w + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb0 = u_xlat16_1.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat16_1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * vs_TEXCOORD0.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : 0.0399999991;
    SV_Target0.w = 0.0;
    SV_Target1.w = 0.0;
    SV_Target2.xy = vec2(0.0399999991, 0.0399999991);
    SV_Target2.w = _Shininess;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "ENABLE_DEPTH_BLEND_ON" "DITHER_FADE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVPZero[4];
uniform 	vec4 _WorldOffsetRange;
uniform 	float _HeightScale;
uniform 	vec4 _MainTex_ST;
uniform highp sampler2D _Heightmap;
in mediump vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
out mediump vec3 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = (-_WorldOffsetRange.xy) + vec2(1.0, 1.0);
    u_xlat4.xy = vec2(_WorldOffsetRange.z + float(2.0), _WorldOffsetRange.w + float(2.0));
    u_xlat0.xy = u_xlat0.xy / u_xlat4.xy;
    u_xlat0.x = textureLod(_Heightmap, u_xlat0.xy, 0.0).x;
    u_xlat0.y = u_xlat0.x * _HeightScale;
    u_xlat0.x = float(0.0);
    u_xlat0.z = float(0.0);
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVPZero[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVPZero[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVPZero[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVPZero[3];
    gl_Position = u_xlat0;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat1.xyz = u_xlat4.xxx * u_xlat1.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = u_xlat1.xy;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD2.xyw = u_xlat0.xyw;
    vs_TEXCOORD2.z = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
float ImmCB_0_0_0[64];
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _DepthBiasScaled;
uniform 	mediump vec3 _MainColor;
uniform 	mediump float _Shininess;
uniform 	mediump float _CutOff;
uniform lowp sampler2D _MainTex;
uniform highp sampler2D _CameraDepthBlendTexture;
uniform lowp sampler2D _CameraDepthBlendNormTexture;
uniform lowp sampler2D _CameraDepthBlendDiffTexture;
in mediump vec3 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
float u_xlat12;
float u_xlat18;
mediump float u_xlat16_20;
void main()
{
	ImmCB_0_0_0[0] = 1.0;
	ImmCB_0_0_0[1] = 49.0;
	ImmCB_0_0_0[2] = 13.0;
	ImmCB_0_0_0[3] = 61.0;
	ImmCB_0_0_0[4] = 4.0;
	ImmCB_0_0_0[5] = 52.0;
	ImmCB_0_0_0[6] = 16.0;
	ImmCB_0_0_0[7] = 64.0;
	ImmCB_0_0_0[8] = 33.0;
	ImmCB_0_0_0[9] = 17.0;
	ImmCB_0_0_0[10] = 45.0;
	ImmCB_0_0_0[11] = 29.0;
	ImmCB_0_0_0[12] = 36.0;
	ImmCB_0_0_0[13] = 20.0;
	ImmCB_0_0_0[14] = 48.0;
	ImmCB_0_0_0[15] = 32.0;
	ImmCB_0_0_0[16] = 9.0;
	ImmCB_0_0_0[17] = 57.0;
	ImmCB_0_0_0[18] = 5.0;
	ImmCB_0_0_0[19] = 53.0;
	ImmCB_0_0_0[20] = 12.0;
	ImmCB_0_0_0[21] = 60.0;
	ImmCB_0_0_0[22] = 8.0;
	ImmCB_0_0_0[23] = 56.0;
	ImmCB_0_0_0[24] = 41.0;
	ImmCB_0_0_0[25] = 25.0;
	ImmCB_0_0_0[26] = 37.0;
	ImmCB_0_0_0[27] = 21.0;
	ImmCB_0_0_0[28] = 44.0;
	ImmCB_0_0_0[29] = 28.0;
	ImmCB_0_0_0[30] = 40.0;
	ImmCB_0_0_0[31] = 24.0;
	ImmCB_0_0_0[32] = 3.0;
	ImmCB_0_0_0[33] = 51.0;
	ImmCB_0_0_0[34] = 15.0;
	ImmCB_0_0_0[35] = 63.0;
	ImmCB_0_0_0[36] = 2.0;
	ImmCB_0_0_0[37] = 50.0;
	ImmCB_0_0_0[38] = 14.0;
	ImmCB_0_0_0[39] = 62.0;
	ImmCB_0_0_0[40] = 35.0;
	ImmCB_0_0_0[41] = 19.0;
	ImmCB_0_0_0[42] = 47.0;
	ImmCB_0_0_0[43] = 31.0;
	ImmCB_0_0_0[44] = 34.0;
	ImmCB_0_0_0[45] = 18.0;
	ImmCB_0_0_0[46] = 46.0;
	ImmCB_0_0_0[47] = 30.0;
	ImmCB_0_0_0[48] = 11.0;
	ImmCB_0_0_0[49] = 59.0;
	ImmCB_0_0_0[50] = 7.0;
	ImmCB_0_0_0[51] = 55.0;
	ImmCB_0_0_0[52] = 10.0;
	ImmCB_0_0_0[53] = 58.0;
	ImmCB_0_0_0[54] = 6.0;
	ImmCB_0_0_0[55] = 54.0;
	ImmCB_0_0_0[56] = 43.0;
	ImmCB_0_0_0[57] = 27.0;
	ImmCB_0_0_0[58] = 39.0;
	ImmCB_0_0_0[59] = 23.0;
	ImmCB_0_0_0[60] = 42.0;
	ImmCB_0_0_0[61] = 26.0;
	ImmCB_0_0_0[62] = 38.0;
	ImmCB_0_0_0[63] = 22.0;
    u_xlatb0.xy = lessThan(vs_TEXCOORD2.zwzz, vec4(0.949999988, 100.0, 0.0, 0.0)).xy;
    if(u_xlatb0.x){
        u_xlat16_0.xz = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
        u_xlat0.xz = u_xlat16_0.xz * _ScreenParams.yx;
        u_xlat0.xz = u_xlat0.xz * vec2(0.125, 0.125);
        u_xlat0.xz = fract(u_xlat0.xz);
        u_xlat0.xz = u_xlat0.xz * vec2(7.99900007, 7.99900007);
        u_xlat0.xz = trunc(u_xlat0.xz);
        u_xlat0.x = u_xlat0.x * 8.0 + u_xlat0.z;
        u_xlati0 = int(u_xlat0.x);
        u_xlat0.x = (-ImmCB_0_0_0[u_xlati0]) * 0.015625 + vs_TEXCOORD2.z;
#ifdef UNITY_ADRENO_ES3
        u_xlatb0.x = !!(u_xlat0.x<0.0);
#else
        u_xlatb0.x = u_xlat0.x<0.0;
#endif
        if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    //ENDIF
    }
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_2.xyz = u_xlat10_1.xyz * _MainColor.xyz;
    u_xlat16_20 = u_xlat10_1.w + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_20<0.0);
#else
    u_xlatb0.x = u_xlat16_20<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat16_20 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_20 = inversesqrt(u_xlat16_20);
    u_xlat16_3.xyz = vec3(u_xlat16_20) * vs_TEXCOORD0.xyz;
    if(u_xlatb0.y){
        u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat12 = texture(_CameraDepthBlendTexture, u_xlat0.xy).x;
        u_xlat12 = _ZBufferParams.z * u_xlat12 + _ZBufferParams.w;
        u_xlat12 = float(1.0) / u_xlat12;
        u_xlat12 = u_xlat12 + (-vs_TEXCOORD2.w);
        u_xlat12 = abs(u_xlat12) * _DepthBiasScaled;
#ifdef UNITY_ADRENO_ES3
        u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
        u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
        u_xlat12 = sqrt(u_xlat12);
        u_xlat10_4.xyz = texture(_CameraDepthBlendNormTexture, u_xlat0.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat10_0.xyw = texture(_CameraDepthBlendDiffTexture, u_xlat0.xy).xyz;
        u_xlat16_1.xyz = u_xlat10_1.xyz * _MainColor.xyz + (-u_xlat10_0.xyw);
        u_xlat2.xyz = vec3(u_xlat12) * u_xlat16_1.xyz + u_xlat10_0.xyw;
        u_xlat16_0.xyw = vs_TEXCOORD0.xyz * vec3(u_xlat16_20) + (-u_xlat16_5.xyz);
        u_xlat0.xyz = vec3(u_xlat12) * u_xlat16_0.xyw + u_xlat16_5.xyz;
        u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat18 = inversesqrt(u_xlat18);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat0.xyz;
        u_xlat16_2.xyz = u_xlat2.xyz;
        u_xlat16_3.xyz = u_xlat3.xyz;
    //ENDIF
    }
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0.x) ? 0.0 : 0.0399999991;
    SV_Target0.w = 0.0;
    SV_Target1.xyz = u_xlat16_2.xyz;
    SV_Target1.w = 0.0;
    SV_Target2.xy = vec2(0.0399999991, 0.0399999991);
    SV_Target2.w = _Shininess;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "DITHER_FADE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVPZero[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _WorldOffsetRange;
uniform 	float _HeightScale;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _RandomScaleMin;
uniform 	mediump float _RandomScaleMax;
uniform 	mediump float _RandomRotateMin;
uniform 	mediump float _RandomRotateMax;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform highp sampler2D _Heightmap;
in highp vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec3 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
int u_xlati1;
uint u_xlatu1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
vec3 u_xlat5;
vec3 u_xlat7;
vec3 u_xlat8;
uint u_xlatu8;
void main()
{
    u_xlat16_0 = (-_RandomRotateMin) + _RandomRotateMax;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati1 = u_xlati1 << 2;
    u_xlat7.xyz = in_TEXCOORD1.yyy * unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TEXCOORD1.xxx + u_xlat7.xyz;
    u_xlat7.xyz = u_xlat7.xyz + unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat2.x = u_xlat7.y * u_xlat7.x;
    u_xlat2.x = u_xlat7.z * u_xlat2.x;
    u_xlat8.xyz = u_xlat7.xyz + vec3(0.212699994, 0.212699994, 0.212699994);
    u_xlat2.xyz = u_xlat2.xxx * vec3(0.371300012, 0.371300012, 0.371300012) + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat2.xyz * vec3(489.122986, 489.122986, 489.122986);
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat8.xyz = sin(u_xlat8.xyz);
    u_xlat8.xyz = u_xlat8.xyz * vec3(4.78900003, 4.78900003, 4.78900003);
    u_xlat8.x = u_xlat8.y * u_xlat8.x;
    u_xlat8.x = u_xlat8.z * u_xlat8.x;
    u_xlat2.x = u_xlat2.x * u_xlat8.x;
    u_xlat2.x = fract(u_xlat2.x);
    u_xlat8.x = u_xlat2.x * u_xlat16_0 + _RandomRotateMin;
    u_xlat8.x = u_xlat8.x * 0.0174532942;
    u_xlat3.x = sin(u_xlat8.x);
    u_xlat4 = cos(u_xlat8.x);
    u_xlat5.x = sin((-u_xlat8.x));
    u_xlat5.z = u_xlat3.x;
    u_xlat5.y = u_xlat4;
    u_xlat8.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat8.xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat8.xyz + unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) + u_xlat8.xyz;
    u_xlat3.x = dot(u_xlat5.yz, u_xlat8.xz);
    u_xlat3.z = dot(u_xlat5.xy, u_xlat8.xz);
    u_xlat3.y = u_xlat8.y;
    u_xlat16_0 = (-_RandomScaleMin) + _RandomScaleMax;
    u_xlat2.x = u_xlat2.x * u_xlat16_0 + _RandomScaleMin;
    u_xlat8.x = float(floatBitsToUint(unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[2]).w);
    u_xlat8.x = u_xlat8.x * 5.96046448e-08;
    u_xlatu8 = uint(u_xlat8.x);
    u_xlatu8 = u_xlatu8 & 3u;
    u_xlat8.x = float(u_xlatu8);
    u_xlat2.x = u_xlat2.x * u_xlat8.x;
    u_xlat2.x = u_xlat2.x * 0.333000004;
    u_xlat0.xyz = u_xlat3.xyz * u_xlat2.xxx + u_xlat7.xyz;
    u_xlat7.xy = u_xlat7.xz + (-_WorldOffsetRange.xy);
    u_xlat7.xy = u_xlat7.xy + vec2(1.0, 1.0);
    u_xlat2.xy = vec2(_WorldOffsetRange.z + float(2.0), _WorldOffsetRange.w + float(2.0));
    u_xlat7.xy = u_xlat7.xy / u_xlat2.xy;
    u_xlat7.x = textureLod(_Heightmap, u_xlat7.xy, 0.0).x;
    u_xlat0.w = u_xlat7.x * _HeightScale + u_xlat0.y;
    u_xlat7.xyz = u_xlat0.xwz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0 = u_xlat7.yyyy * hlslcc_mtx4x4unity_MatrixVPZero[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVPZero[0] * u_xlat7.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVPZero[2] * u_xlat7.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVPZero[3];
    gl_Position = u_xlat0;
    u_xlat7.xyz = in_NORMAL0.yyy * unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_NORMAL0.xxx + u_xlat7.xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_NORMAL0.zzz + u_xlat7.xyz;
    u_xlatu1 = 4278190080u & floatBitsToUint(unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[3]).w;
    u_xlat1.x = float(u_xlatu1);
    u_xlat0.z = u_xlat1.x * 2.33743719e-10;
    u_xlat1.x = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat7.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = u_xlat1.xy;
    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD2 = u_xlat0;
    vs_SV_InstanceID0 = uint(0u);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
float ImmCB_0_0_0[64];
uniform 	vec4 _ScreenParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump vec3 _MainColor;
uniform 	mediump float _Shininess;
uniform 	mediump float _CutOff;
uniform lowp sampler2D _MainTex;
in mediump vec3 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
void main()
{
	ImmCB_0_0_0[0] = 1.0;
	ImmCB_0_0_0[1] = 49.0;
	ImmCB_0_0_0[2] = 13.0;
	ImmCB_0_0_0[3] = 61.0;
	ImmCB_0_0_0[4] = 4.0;
	ImmCB_0_0_0[5] = 52.0;
	ImmCB_0_0_0[6] = 16.0;
	ImmCB_0_0_0[7] = 64.0;
	ImmCB_0_0_0[8] = 33.0;
	ImmCB_0_0_0[9] = 17.0;
	ImmCB_0_0_0[10] = 45.0;
	ImmCB_0_0_0[11] = 29.0;
	ImmCB_0_0_0[12] = 36.0;
	ImmCB_0_0_0[13] = 20.0;
	ImmCB_0_0_0[14] = 48.0;
	ImmCB_0_0_0[15] = 32.0;
	ImmCB_0_0_0[16] = 9.0;
	ImmCB_0_0_0[17] = 57.0;
	ImmCB_0_0_0[18] = 5.0;
	ImmCB_0_0_0[19] = 53.0;
	ImmCB_0_0_0[20] = 12.0;
	ImmCB_0_0_0[21] = 60.0;
	ImmCB_0_0_0[22] = 8.0;
	ImmCB_0_0_0[23] = 56.0;
	ImmCB_0_0_0[24] = 41.0;
	ImmCB_0_0_0[25] = 25.0;
	ImmCB_0_0_0[26] = 37.0;
	ImmCB_0_0_0[27] = 21.0;
	ImmCB_0_0_0[28] = 44.0;
	ImmCB_0_0_0[29] = 28.0;
	ImmCB_0_0_0[30] = 40.0;
	ImmCB_0_0_0[31] = 24.0;
	ImmCB_0_0_0[32] = 3.0;
	ImmCB_0_0_0[33] = 51.0;
	ImmCB_0_0_0[34] = 15.0;
	ImmCB_0_0_0[35] = 63.0;
	ImmCB_0_0_0[36] = 2.0;
	ImmCB_0_0_0[37] = 50.0;
	ImmCB_0_0_0[38] = 14.0;
	ImmCB_0_0_0[39] = 62.0;
	ImmCB_0_0_0[40] = 35.0;
	ImmCB_0_0_0[41] = 19.0;
	ImmCB_0_0_0[42] = 47.0;
	ImmCB_0_0_0[43] = 31.0;
	ImmCB_0_0_0[44] = 34.0;
	ImmCB_0_0_0[45] = 18.0;
	ImmCB_0_0_0[46] = 46.0;
	ImmCB_0_0_0[47] = 30.0;
	ImmCB_0_0_0[48] = 11.0;
	ImmCB_0_0_0[49] = 59.0;
	ImmCB_0_0_0[50] = 7.0;
	ImmCB_0_0_0[51] = 55.0;
	ImmCB_0_0_0[52] = 10.0;
	ImmCB_0_0_0[53] = 58.0;
	ImmCB_0_0_0[54] = 6.0;
	ImmCB_0_0_0[55] = 54.0;
	ImmCB_0_0_0[56] = 43.0;
	ImmCB_0_0_0[57] = 27.0;
	ImmCB_0_0_0[58] = 39.0;
	ImmCB_0_0_0[59] = 23.0;
	ImmCB_0_0_0[60] = 42.0;
	ImmCB_0_0_0[61] = 26.0;
	ImmCB_0_0_0[62] = 38.0;
	ImmCB_0_0_0[63] = 22.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat16_0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
        u_xlat0.xy = u_xlat16_0.xy * _ScreenParams.yx;
        u_xlat0.xy = u_xlat0.xy * vec2(0.125, 0.125);
        u_xlat0.xy = fract(u_xlat0.xy);
        u_xlat0.xy = u_xlat0.xy * vec2(7.99900007, 7.99900007);
        u_xlat0.xy = trunc(u_xlat0.xy);
        u_xlat0.x = u_xlat0.x * 8.0 + u_xlat0.y;
        u_xlati0 = int(u_xlat0.x);
        u_xlat0.x = (-ImmCB_0_0_0[u_xlati0]) * 0.015625 + vs_TEXCOORD2.z;
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(u_xlat0.x<0.0);
#else
        u_xlatb0 = u_xlat0.x<0.0;
#endif
        if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    SV_Target1.xyz = u_xlat10_0.xyz * _MainColor.xyz;
    u_xlat16_1.x = u_xlat10_0.w + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb0 = u_xlat16_1.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat16_1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * vs_TEXCOORD0.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : 0.0399999991;
    SV_Target0.w = 0.0;
    SV_Target1.w = 0.0;
    SV_Target2.xy = vec2(0.0399999991, 0.0399999991);
    SV_Target2.w = _Shininess;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "ENABLE_DEPTH_BLEND_ON" "DITHER_FADE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVPZero[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _WorldOffsetRange;
uniform 	float _HeightScale;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _RandomScaleMin;
uniform 	mediump float _RandomScaleMax;
uniform 	mediump float _RandomRotateMin;
uniform 	mediump float _RandomRotateMax;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform highp sampler2D _Heightmap;
in highp vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec3 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
int u_xlati1;
uint u_xlatu1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
vec3 u_xlat5;
vec3 u_xlat7;
vec3 u_xlat8;
uint u_xlatu8;
void main()
{
    u_xlat16_0 = (-_RandomRotateMin) + _RandomRotateMax;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati1 = u_xlati1 << 2;
    u_xlat7.xyz = in_TEXCOORD1.yyy * unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TEXCOORD1.xxx + u_xlat7.xyz;
    u_xlat7.xyz = u_xlat7.xyz + unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat2.x = u_xlat7.y * u_xlat7.x;
    u_xlat2.x = u_xlat7.z * u_xlat2.x;
    u_xlat8.xyz = u_xlat7.xyz + vec3(0.212699994, 0.212699994, 0.212699994);
    u_xlat2.xyz = u_xlat2.xxx * vec3(0.371300012, 0.371300012, 0.371300012) + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat2.xyz * vec3(489.122986, 489.122986, 489.122986);
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat8.xyz = sin(u_xlat8.xyz);
    u_xlat8.xyz = u_xlat8.xyz * vec3(4.78900003, 4.78900003, 4.78900003);
    u_xlat8.x = u_xlat8.y * u_xlat8.x;
    u_xlat8.x = u_xlat8.z * u_xlat8.x;
    u_xlat2.x = u_xlat2.x * u_xlat8.x;
    u_xlat2.x = fract(u_xlat2.x);
    u_xlat8.x = u_xlat2.x * u_xlat16_0 + _RandomRotateMin;
    u_xlat8.x = u_xlat8.x * 0.0174532942;
    u_xlat3.x = sin(u_xlat8.x);
    u_xlat4 = cos(u_xlat8.x);
    u_xlat5.x = sin((-u_xlat8.x));
    u_xlat5.z = u_xlat3.x;
    u_xlat5.y = u_xlat4;
    u_xlat8.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat8.xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat8.xyz + unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) + u_xlat8.xyz;
    u_xlat3.x = dot(u_xlat5.yz, u_xlat8.xz);
    u_xlat3.z = dot(u_xlat5.xy, u_xlat8.xz);
    u_xlat3.y = u_xlat8.y;
    u_xlat16_0 = (-_RandomScaleMin) + _RandomScaleMax;
    u_xlat2.x = u_xlat2.x * u_xlat16_0 + _RandomScaleMin;
    u_xlat8.x = float(floatBitsToUint(unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[2]).w);
    u_xlat8.x = u_xlat8.x * 5.96046448e-08;
    u_xlatu8 = uint(u_xlat8.x);
    u_xlatu8 = u_xlatu8 & 3u;
    u_xlat8.x = float(u_xlatu8);
    u_xlat2.x = u_xlat2.x * u_xlat8.x;
    u_xlat2.x = u_xlat2.x * 0.333000004;
    u_xlat0.xyz = u_xlat3.xyz * u_xlat2.xxx + u_xlat7.xyz;
    u_xlat7.xy = u_xlat7.xz + (-_WorldOffsetRange.xy);
    u_xlat7.xy = u_xlat7.xy + vec2(1.0, 1.0);
    u_xlat2.xy = vec2(_WorldOffsetRange.z + float(2.0), _WorldOffsetRange.w + float(2.0));
    u_xlat7.xy = u_xlat7.xy / u_xlat2.xy;
    u_xlat7.x = textureLod(_Heightmap, u_xlat7.xy, 0.0).x;
    u_xlat0.w = u_xlat7.x * _HeightScale + u_xlat0.y;
    u_xlat7.xyz = u_xlat0.xwz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0 = u_xlat7.yyyy * hlslcc_mtx4x4unity_MatrixVPZero[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVPZero[0] * u_xlat7.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVPZero[2] * u_xlat7.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVPZero[3];
    gl_Position = u_xlat0;
    u_xlat7.xyz = in_NORMAL0.yyy * unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_NORMAL0.xxx + u_xlat7.xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_NORMAL0.zzz + u_xlat7.xyz;
    u_xlatu1 = 4278190080u & floatBitsToUint(unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[3]).w;
    u_xlat1.x = float(u_xlatu1);
    u_xlat0.z = u_xlat1.x * 2.33743719e-10;
    u_xlat1.x = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat7.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = u_xlat1.xy;
    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD2 = u_xlat0;
    vs_SV_InstanceID0 = uint(0u);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
float ImmCB_0_0_0[64];
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _DepthBiasScaled;
uniform 	mediump vec3 _MainColor;
uniform 	mediump float _Shininess;
uniform 	mediump float _CutOff;
uniform lowp sampler2D _MainTex;
uniform highp sampler2D _CameraDepthBlendTexture;
uniform lowp sampler2D _CameraDepthBlendNormTexture;
uniform lowp sampler2D _CameraDepthBlendDiffTexture;
in mediump vec3 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
float u_xlat12;
float u_xlat18;
mediump float u_xlat16_20;
void main()
{
	ImmCB_0_0_0[0] = 1.0;
	ImmCB_0_0_0[1] = 49.0;
	ImmCB_0_0_0[2] = 13.0;
	ImmCB_0_0_0[3] = 61.0;
	ImmCB_0_0_0[4] = 4.0;
	ImmCB_0_0_0[5] = 52.0;
	ImmCB_0_0_0[6] = 16.0;
	ImmCB_0_0_0[7] = 64.0;
	ImmCB_0_0_0[8] = 33.0;
	ImmCB_0_0_0[9] = 17.0;
	ImmCB_0_0_0[10] = 45.0;
	ImmCB_0_0_0[11] = 29.0;
	ImmCB_0_0_0[12] = 36.0;
	ImmCB_0_0_0[13] = 20.0;
	ImmCB_0_0_0[14] = 48.0;
	ImmCB_0_0_0[15] = 32.0;
	ImmCB_0_0_0[16] = 9.0;
	ImmCB_0_0_0[17] = 57.0;
	ImmCB_0_0_0[18] = 5.0;
	ImmCB_0_0_0[19] = 53.0;
	ImmCB_0_0_0[20] = 12.0;
	ImmCB_0_0_0[21] = 60.0;
	ImmCB_0_0_0[22] = 8.0;
	ImmCB_0_0_0[23] = 56.0;
	ImmCB_0_0_0[24] = 41.0;
	ImmCB_0_0_0[25] = 25.0;
	ImmCB_0_0_0[26] = 37.0;
	ImmCB_0_0_0[27] = 21.0;
	ImmCB_0_0_0[28] = 44.0;
	ImmCB_0_0_0[29] = 28.0;
	ImmCB_0_0_0[30] = 40.0;
	ImmCB_0_0_0[31] = 24.0;
	ImmCB_0_0_0[32] = 3.0;
	ImmCB_0_0_0[33] = 51.0;
	ImmCB_0_0_0[34] = 15.0;
	ImmCB_0_0_0[35] = 63.0;
	ImmCB_0_0_0[36] = 2.0;
	ImmCB_0_0_0[37] = 50.0;
	ImmCB_0_0_0[38] = 14.0;
	ImmCB_0_0_0[39] = 62.0;
	ImmCB_0_0_0[40] = 35.0;
	ImmCB_0_0_0[41] = 19.0;
	ImmCB_0_0_0[42] = 47.0;
	ImmCB_0_0_0[43] = 31.0;
	ImmCB_0_0_0[44] = 34.0;
	ImmCB_0_0_0[45] = 18.0;
	ImmCB_0_0_0[46] = 46.0;
	ImmCB_0_0_0[47] = 30.0;
	ImmCB_0_0_0[48] = 11.0;
	ImmCB_0_0_0[49] = 59.0;
	ImmCB_0_0_0[50] = 7.0;
	ImmCB_0_0_0[51] = 55.0;
	ImmCB_0_0_0[52] = 10.0;
	ImmCB_0_0_0[53] = 58.0;
	ImmCB_0_0_0[54] = 6.0;
	ImmCB_0_0_0[55] = 54.0;
	ImmCB_0_0_0[56] = 43.0;
	ImmCB_0_0_0[57] = 27.0;
	ImmCB_0_0_0[58] = 39.0;
	ImmCB_0_0_0[59] = 23.0;
	ImmCB_0_0_0[60] = 42.0;
	ImmCB_0_0_0[61] = 26.0;
	ImmCB_0_0_0[62] = 38.0;
	ImmCB_0_0_0[63] = 22.0;
    u_xlatb0.xy = lessThan(vs_TEXCOORD2.zwzz, vec4(0.949999988, 100.0, 0.0, 0.0)).xy;
    if(u_xlatb0.x){
        u_xlat16_0.xz = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
        u_xlat0.xz = u_xlat16_0.xz * _ScreenParams.yx;
        u_xlat0.xz = u_xlat0.xz * vec2(0.125, 0.125);
        u_xlat0.xz = fract(u_xlat0.xz);
        u_xlat0.xz = u_xlat0.xz * vec2(7.99900007, 7.99900007);
        u_xlat0.xz = trunc(u_xlat0.xz);
        u_xlat0.x = u_xlat0.x * 8.0 + u_xlat0.z;
        u_xlati0 = int(u_xlat0.x);
        u_xlat0.x = (-ImmCB_0_0_0[u_xlati0]) * 0.015625 + vs_TEXCOORD2.z;
#ifdef UNITY_ADRENO_ES3
        u_xlatb0.x = !!(u_xlat0.x<0.0);
#else
        u_xlatb0.x = u_xlat0.x<0.0;
#endif
        if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    //ENDIF
    }
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_2.xyz = u_xlat10_1.xyz * _MainColor.xyz;
    u_xlat16_20 = u_xlat10_1.w + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_20<0.0);
#else
    u_xlatb0.x = u_xlat16_20<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat16_20 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_20 = inversesqrt(u_xlat16_20);
    u_xlat16_3.xyz = vec3(u_xlat16_20) * vs_TEXCOORD0.xyz;
    if(u_xlatb0.y){
        u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat12 = texture(_CameraDepthBlendTexture, u_xlat0.xy).x;
        u_xlat12 = _ZBufferParams.z * u_xlat12 + _ZBufferParams.w;
        u_xlat12 = float(1.0) / u_xlat12;
        u_xlat12 = u_xlat12 + (-vs_TEXCOORD2.w);
        u_xlat12 = abs(u_xlat12) * _DepthBiasScaled;
#ifdef UNITY_ADRENO_ES3
        u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
        u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
        u_xlat12 = sqrt(u_xlat12);
        u_xlat10_4.xyz = texture(_CameraDepthBlendNormTexture, u_xlat0.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat10_0.xyw = texture(_CameraDepthBlendDiffTexture, u_xlat0.xy).xyz;
        u_xlat16_1.xyz = u_xlat10_1.xyz * _MainColor.xyz + (-u_xlat10_0.xyw);
        u_xlat2.xyz = vec3(u_xlat12) * u_xlat16_1.xyz + u_xlat10_0.xyw;
        u_xlat16_0.xyw = vs_TEXCOORD0.xyz * vec3(u_xlat16_20) + (-u_xlat16_5.xyz);
        u_xlat0.xyz = vec3(u_xlat12) * u_xlat16_0.xyw + u_xlat16_5.xyz;
        u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat18 = inversesqrt(u_xlat18);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat0.xyz;
        u_xlat16_2.xyz = u_xlat2.xyz;
        u_xlat16_3.xyz = u_xlat3.xyz;
    //ENDIF
    }
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0.x) ? 0.0 : 0.0399999991;
    SV_Target0.w = 0.0;
    SV_Target1.xyz = u_xlat16_2.xyz;
    SV_Target1.w = 0.0;
    SV_Target2.xy = vec2(0.0399999991, 0.0399999991);
    SV_Target2.w = _Shininess;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVPZero[4];
uniform 	vec4 _WorldOffsetRange;
uniform 	float _HeightScale;
uniform 	vec4 _MainTex_ST;
uniform highp sampler2D _Heightmap;
in mediump vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
out mediump vec3 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
float u_xlat7;
void main()
{
    u_xlat0.xy = (-_WorldOffsetRange.xy) + vec2(1.0, 1.0);
    u_xlat4.xy = vec2(_WorldOffsetRange.z + float(2.0), _WorldOffsetRange.w + float(2.0));
    u_xlat0.xy = u_xlat0.xy / u_xlat4.xy;
    u_xlat0.x = textureLod(_Heightmap, u_xlat0.xy, 0.0).x;
    u_xlat0.y = u_xlat0.x * _HeightScale;
    u_xlat0.x = float(0.0);
    u_xlat0.z = float(0.0);
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVPZero[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVPZero[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVPZero[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVPZero[3];
    gl_Position = u_xlat0;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = u_xlat1.xy;
    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD2 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump vec3 _MainColor;
uniform 	mediump float _Shininess;
uniform 	mediump float _CutOff;
uniform lowp sampler2D _MainTex;
in mediump vec3 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_CutOff);
    SV_Target1.xyz = u_xlat10_0.xyz * _MainColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb0 = u_xlat16_1.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat16_1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * vs_TEXCOORD0.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : 0.0399999991;
    SV_Target2.xy = vec2(0.0399999991, 0.0399999991);
    SV_Target2.w = _Shininess;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "ENABLE_DEPTH_BLEND_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVPZero[4];
uniform 	vec4 _WorldOffsetRange;
uniform 	float _HeightScale;
uniform 	vec4 _MainTex_ST;
uniform highp sampler2D _Heightmap;
in mediump vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
out mediump vec3 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
float u_xlat7;
void main()
{
    u_xlat0.xy = (-_WorldOffsetRange.xy) + vec2(1.0, 1.0);
    u_xlat4.xy = vec2(_WorldOffsetRange.z + float(2.0), _WorldOffsetRange.w + float(2.0));
    u_xlat0.xy = u_xlat0.xy / u_xlat4.xy;
    u_xlat0.x = textureLod(_Heightmap, u_xlat0.xy, 0.0).x;
    u_xlat0.y = u_xlat0.x * _HeightScale;
    u_xlat0.x = float(0.0);
    u_xlat0.z = float(0.0);
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVPZero[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVPZero[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVPZero[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVPZero[3];
    gl_Position = u_xlat0;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = u_xlat1.xy;
    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD2 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _DepthBiasScaled;
uniform 	mediump vec3 _MainColor;
uniform 	mediump float _Shininess;
uniform 	mediump float _CutOff;
uniform lowp sampler2D _MainTex;
uniform highp sampler2D _CameraDepthBlendTexture;
uniform lowp sampler2D _CameraDepthBlendNormTexture;
uniform lowp sampler2D _CameraDepthBlendDiffTexture;
in mediump vec3 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
vec3 u_xlat4;
bool u_xlatb4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_11;
lowp vec3 u_xlat10_11;
bool u_xlatb21;
mediump float u_xlat16_22;
float u_xlat25;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_1.xyz = u_xlat10_0.xyz * _MainColor.xyz;
    u_xlat16_22 = u_xlat10_0.w + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(u_xlat16_22<0.0);
#else
    u_xlatb21 = u_xlat16_22<0.0;
#endif
    if((int(u_xlatb21) * int(0xffffffffu))!=0){discard;}
    u_xlat16_22 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_22 = inversesqrt(u_xlat16_22);
    u_xlat16_2.xyz = vec3(u_xlat16_22) * vs_TEXCOORD0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(vs_TEXCOORD2.w<100.0);
#else
    u_xlatb21 = vs_TEXCOORD2.w<100.0;
#endif
    if(u_xlatb21){
        u_xlat3.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat4.x = texture(_CameraDepthBlendTexture, u_xlat3.xy).x;
        u_xlat4.x = _ZBufferParams.z * u_xlat4.x + _ZBufferParams.w;
        u_xlat4.x = float(1.0) / u_xlat4.x;
        u_xlat4.x = u_xlat4.x + (-vs_TEXCOORD2.w);
        u_xlat4.x = abs(u_xlat4.x) * _DepthBiasScaled;
#ifdef UNITY_ADRENO_ES3
        u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
        u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
        u_xlat4.x = sqrt(u_xlat4.x);
        u_xlat10_11.xyz = texture(_CameraDepthBlendNormTexture, u_xlat3.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_11.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat10_11.xyz = texture(_CameraDepthBlendDiffTexture, u_xlat3.xy).xyz;
        u_xlat16_6.xyz = u_xlat10_0.xyz * _MainColor.xyz + (-u_xlat10_11.xyz);
        u_xlat1.xyz = u_xlat4.xxx * u_xlat16_6.xyz + u_xlat10_11.xyz;
        u_xlat16_11.xyz = vs_TEXCOORD0.xyz * vec3(u_xlat16_22) + (-u_xlat16_5.xyz);
        u_xlat4.xyz = u_xlat4.xxx * u_xlat16_11.xyz + u_xlat16_5.xyz;
        u_xlat25 = dot(u_xlat4.xyz, u_xlat4.xyz);
        u_xlat25 = inversesqrt(u_xlat25);
        u_xlat2.xyz = vec3(u_xlat25) * u_xlat4.xyz;
        u_xlat16_1.xyz = u_xlat1.xyz;
        u_xlat16_2.xyz = u_xlat2.xyz;
    //ENDIF
    }
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb4 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb4) ? 0.0 : 0.0399999991;
    SV_Target0.w = 0.0;
    SV_Target1.xyz = u_xlat16_1.xyz;
    SV_Target1.w = 0.0;
    SV_Target2.xy = vec2(0.0399999991, 0.0399999991);
    SV_Target2.w = _Shininess;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVPZero[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _WorldOffsetRange;
uniform 	float _HeightScale;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _RandomScaleMin;
uniform 	mediump float _RandomScaleMax;
uniform 	mediump float _RandomRotateMin;
uniform 	mediump float _RandomRotateMax;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform highp sampler2D _Heightmap;
in highp vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec3 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
int u_xlati1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
vec3 u_xlat5;
vec3 u_xlat7;
vec3 u_xlat8;
uint u_xlatu8;
float u_xlat19;
void main()
{
    u_xlat16_0 = (-_RandomRotateMin) + _RandomRotateMax;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati1 = u_xlati1 << 2;
    u_xlat7.xyz = in_TEXCOORD1.yyy * unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TEXCOORD1.xxx + u_xlat7.xyz;
    u_xlat7.xyz = u_xlat7.xyz + unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat2.x = u_xlat7.y * u_xlat7.x;
    u_xlat2.x = u_xlat7.z * u_xlat2.x;
    u_xlat8.xyz = u_xlat7.xyz + vec3(0.212699994, 0.212699994, 0.212699994);
    u_xlat2.xyz = u_xlat2.xxx * vec3(0.371300012, 0.371300012, 0.371300012) + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat2.xyz * vec3(489.122986, 489.122986, 489.122986);
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat8.xyz = sin(u_xlat8.xyz);
    u_xlat8.xyz = u_xlat8.xyz * vec3(4.78900003, 4.78900003, 4.78900003);
    u_xlat8.x = u_xlat8.y * u_xlat8.x;
    u_xlat8.x = u_xlat8.z * u_xlat8.x;
    u_xlat2.x = u_xlat2.x * u_xlat8.x;
    u_xlat2.x = fract(u_xlat2.x);
    u_xlat8.x = u_xlat2.x * u_xlat16_0 + _RandomRotateMin;
    u_xlat8.x = u_xlat8.x * 0.0174532942;
    u_xlat3.x = sin(u_xlat8.x);
    u_xlat4 = cos(u_xlat8.x);
    u_xlat5.x = sin((-u_xlat8.x));
    u_xlat5.z = u_xlat3.x;
    u_xlat5.y = u_xlat4;
    u_xlat8.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat8.xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat8.xyz + unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) + u_xlat8.xyz;
    u_xlat3.x = dot(u_xlat5.yz, u_xlat8.xz);
    u_xlat3.z = dot(u_xlat5.xy, u_xlat8.xz);
    u_xlat3.y = u_xlat8.y;
    u_xlat16_0 = (-_RandomScaleMin) + _RandomScaleMax;
    u_xlat2.x = u_xlat2.x * u_xlat16_0 + _RandomScaleMin;
    u_xlat8.x = float(floatBitsToUint(unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[2]).w);
    u_xlat8.x = u_xlat8.x * 5.96046448e-08;
    u_xlatu8 = uint(u_xlat8.x);
    u_xlatu8 = u_xlatu8 & 3u;
    u_xlat8.x = float(u_xlatu8);
    u_xlat2.x = u_xlat2.x * u_xlat8.x;
    u_xlat2.x = u_xlat2.x * 0.333000004;
    u_xlat0.xyz = u_xlat3.xyz * u_xlat2.xxx + u_xlat7.xyz;
    u_xlat7.xy = u_xlat7.xz + (-_WorldOffsetRange.xy);
    u_xlat7.xy = u_xlat7.xy + vec2(1.0, 1.0);
    u_xlat2.xy = vec2(_WorldOffsetRange.z + float(2.0), _WorldOffsetRange.w + float(2.0));
    u_xlat7.xy = u_xlat7.xy / u_xlat2.xy;
    u_xlat7.x = textureLod(_Heightmap, u_xlat7.xy, 0.0).x;
    u_xlat0.w = u_xlat7.x * _HeightScale + u_xlat0.y;
    u_xlat7.xyz = u_xlat0.xwz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0 = u_xlat7.yyyy * hlslcc_mtx4x4unity_MatrixVPZero[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVPZero[0] * u_xlat7.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVPZero[2] * u_xlat7.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVPZero[3];
    gl_Position = u_xlat0;
    u_xlat7.xyz = in_NORMAL0.yyy * unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_NORMAL0.xxx + u_xlat7.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_NORMAL0.zzz + u_xlat7.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = u_xlat1.xy;
    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD2 = u_xlat0;
    vs_SV_InstanceID0 = uint(0u);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump vec3 _MainColor;
uniform 	mediump float _Shininess;
uniform 	mediump float _CutOff;
uniform lowp sampler2D _MainTex;
in mediump vec3 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_CutOff);
    SV_Target1.xyz = u_xlat10_0.xyz * _MainColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb0 = u_xlat16_1.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat16_1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * vs_TEXCOORD0.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : 0.0399999991;
    SV_Target2.xy = vec2(0.0399999991, 0.0399999991);
    SV_Target2.w = _Shininess;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "ENABLE_DEPTH_BLEND_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVPZero[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _WorldOffsetRange;
uniform 	float _HeightScale;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _RandomScaleMin;
uniform 	mediump float _RandomScaleMax;
uniform 	mediump float _RandomRotateMin;
uniform 	mediump float _RandomRotateMax;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform highp sampler2D _Heightmap;
in highp vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec3 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
int u_xlati1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
vec3 u_xlat5;
vec3 u_xlat7;
vec3 u_xlat8;
uint u_xlatu8;
float u_xlat19;
void main()
{
    u_xlat16_0 = (-_RandomRotateMin) + _RandomRotateMax;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati1 = u_xlati1 << 2;
    u_xlat7.xyz = in_TEXCOORD1.yyy * unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TEXCOORD1.xxx + u_xlat7.xyz;
    u_xlat7.xyz = u_xlat7.xyz + unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat2.x = u_xlat7.y * u_xlat7.x;
    u_xlat2.x = u_xlat7.z * u_xlat2.x;
    u_xlat8.xyz = u_xlat7.xyz + vec3(0.212699994, 0.212699994, 0.212699994);
    u_xlat2.xyz = u_xlat2.xxx * vec3(0.371300012, 0.371300012, 0.371300012) + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat2.xyz * vec3(489.122986, 489.122986, 489.122986);
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat8.xyz = sin(u_xlat8.xyz);
    u_xlat8.xyz = u_xlat8.xyz * vec3(4.78900003, 4.78900003, 4.78900003);
    u_xlat8.x = u_xlat8.y * u_xlat8.x;
    u_xlat8.x = u_xlat8.z * u_xlat8.x;
    u_xlat2.x = u_xlat2.x * u_xlat8.x;
    u_xlat2.x = fract(u_xlat2.x);
    u_xlat8.x = u_xlat2.x * u_xlat16_0 + _RandomRotateMin;
    u_xlat8.x = u_xlat8.x * 0.0174532942;
    u_xlat3.x = sin(u_xlat8.x);
    u_xlat4 = cos(u_xlat8.x);
    u_xlat5.x = sin((-u_xlat8.x));
    u_xlat5.z = u_xlat3.x;
    u_xlat5.y = u_xlat4;
    u_xlat8.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat8.xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat8.xyz + unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) + u_xlat8.xyz;
    u_xlat3.x = dot(u_xlat5.yz, u_xlat8.xz);
    u_xlat3.z = dot(u_xlat5.xy, u_xlat8.xz);
    u_xlat3.y = u_xlat8.y;
    u_xlat16_0 = (-_RandomScaleMin) + _RandomScaleMax;
    u_xlat2.x = u_xlat2.x * u_xlat16_0 + _RandomScaleMin;
    u_xlat8.x = float(floatBitsToUint(unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[2]).w);
    u_xlat8.x = u_xlat8.x * 5.96046448e-08;
    u_xlatu8 = uint(u_xlat8.x);
    u_xlatu8 = u_xlatu8 & 3u;
    u_xlat8.x = float(u_xlatu8);
    u_xlat2.x = u_xlat2.x * u_xlat8.x;
    u_xlat2.x = u_xlat2.x * 0.333000004;
    u_xlat0.xyz = u_xlat3.xyz * u_xlat2.xxx + u_xlat7.xyz;
    u_xlat7.xy = u_xlat7.xz + (-_WorldOffsetRange.xy);
    u_xlat7.xy = u_xlat7.xy + vec2(1.0, 1.0);
    u_xlat2.xy = vec2(_WorldOffsetRange.z + float(2.0), _WorldOffsetRange.w + float(2.0));
    u_xlat7.xy = u_xlat7.xy / u_xlat2.xy;
    u_xlat7.x = textureLod(_Heightmap, u_xlat7.xy, 0.0).x;
    u_xlat0.w = u_xlat7.x * _HeightScale + u_xlat0.y;
    u_xlat7.xyz = u_xlat0.xwz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0 = u_xlat7.yyyy * hlslcc_mtx4x4unity_MatrixVPZero[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVPZero[0] * u_xlat7.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVPZero[2] * u_xlat7.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVPZero[3];
    gl_Position = u_xlat0;
    u_xlat7.xyz = in_NORMAL0.yyy * unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_NORMAL0.xxx + u_xlat7.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_NORMAL0.zzz + u_xlat7.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = u_xlat1.xy;
    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD2 = u_xlat0;
    vs_SV_InstanceID0 = uint(0u);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _DepthBiasScaled;
uniform 	mediump vec3 _MainColor;
uniform 	mediump float _Shininess;
uniform 	mediump float _CutOff;
uniform lowp sampler2D _MainTex;
uniform highp sampler2D _CameraDepthBlendTexture;
uniform lowp sampler2D _CameraDepthBlendNormTexture;
uniform lowp sampler2D _CameraDepthBlendDiffTexture;
in mediump vec3 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
vec3 u_xlat4;
bool u_xlatb4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_11;
lowp vec3 u_xlat10_11;
bool u_xlatb21;
mediump float u_xlat16_22;
float u_xlat25;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_1.xyz = u_xlat10_0.xyz * _MainColor.xyz;
    u_xlat16_22 = u_xlat10_0.w + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(u_xlat16_22<0.0);
#else
    u_xlatb21 = u_xlat16_22<0.0;
#endif
    if((int(u_xlatb21) * int(0xffffffffu))!=0){discard;}
    u_xlat16_22 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_22 = inversesqrt(u_xlat16_22);
    u_xlat16_2.xyz = vec3(u_xlat16_22) * vs_TEXCOORD0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(vs_TEXCOORD2.w<100.0);
#else
    u_xlatb21 = vs_TEXCOORD2.w<100.0;
#endif
    if(u_xlatb21){
        u_xlat3.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat4.x = texture(_CameraDepthBlendTexture, u_xlat3.xy).x;
        u_xlat4.x = _ZBufferParams.z * u_xlat4.x + _ZBufferParams.w;
        u_xlat4.x = float(1.0) / u_xlat4.x;
        u_xlat4.x = u_xlat4.x + (-vs_TEXCOORD2.w);
        u_xlat4.x = abs(u_xlat4.x) * _DepthBiasScaled;
#ifdef UNITY_ADRENO_ES3
        u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
        u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
        u_xlat4.x = sqrt(u_xlat4.x);
        u_xlat10_11.xyz = texture(_CameraDepthBlendNormTexture, u_xlat3.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_11.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat10_11.xyz = texture(_CameraDepthBlendDiffTexture, u_xlat3.xy).xyz;
        u_xlat16_6.xyz = u_xlat10_0.xyz * _MainColor.xyz + (-u_xlat10_11.xyz);
        u_xlat1.xyz = u_xlat4.xxx * u_xlat16_6.xyz + u_xlat10_11.xyz;
        u_xlat16_11.xyz = vs_TEXCOORD0.xyz * vec3(u_xlat16_22) + (-u_xlat16_5.xyz);
        u_xlat4.xyz = u_xlat4.xxx * u_xlat16_11.xyz + u_xlat16_5.xyz;
        u_xlat25 = dot(u_xlat4.xyz, u_xlat4.xyz);
        u_xlat25 = inversesqrt(u_xlat25);
        u_xlat2.xyz = vec3(u_xlat25) * u_xlat4.xyz;
        u_xlat16_1.xyz = u_xlat1.xyz;
        u_xlat16_2.xyz = u_xlat2.xyz;
    //ENDIF
    }
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb4 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb4) ? 0.0 : 0.0399999991;
    SV_Target0.w = 0.0;
    SV_Target1.xyz = u_xlat16_1.xyz;
    SV_Target1.w = 0.0;
    SV_Target2.xy = vec2(0.0399999991, 0.0399999991);
    SV_Target2.w = _Shininess;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "DITHER_FADE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVPZero[4];
uniform 	vec4 _WorldOffsetRange;
uniform 	float _HeightScale;
uniform 	vec4 _MainTex_ST;
uniform highp sampler2D _Heightmap;
in mediump vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
out mediump vec3 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = (-_WorldOffsetRange.xy) + vec2(1.0, 1.0);
    u_xlat4.xy = vec2(_WorldOffsetRange.z + float(2.0), _WorldOffsetRange.w + float(2.0));
    u_xlat0.xy = u_xlat0.xy / u_xlat4.xy;
    u_xlat0.x = textureLod(_Heightmap, u_xlat0.xy, 0.0).x;
    u_xlat0.y = u_xlat0.x * _HeightScale;
    u_xlat0.x = float(0.0);
    u_xlat0.z = float(0.0);
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVPZero[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVPZero[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVPZero[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVPZero[3];
    gl_Position = u_xlat0;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat1.xyz = u_xlat4.xxx * u_xlat1.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = u_xlat1.xy;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD2.xyw = u_xlat0.xyw;
    vs_TEXCOORD2.z = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
float ImmCB_0_0_0[64];
uniform 	vec4 _ScreenParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump vec3 _MainColor;
uniform 	mediump float _Shininess;
uniform 	mediump float _CutOff;
uniform lowp sampler2D _MainTex;
in mediump vec3 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
void main()
{
	ImmCB_0_0_0[0] = 1.0;
	ImmCB_0_0_0[1] = 49.0;
	ImmCB_0_0_0[2] = 13.0;
	ImmCB_0_0_0[3] = 61.0;
	ImmCB_0_0_0[4] = 4.0;
	ImmCB_0_0_0[5] = 52.0;
	ImmCB_0_0_0[6] = 16.0;
	ImmCB_0_0_0[7] = 64.0;
	ImmCB_0_0_0[8] = 33.0;
	ImmCB_0_0_0[9] = 17.0;
	ImmCB_0_0_0[10] = 45.0;
	ImmCB_0_0_0[11] = 29.0;
	ImmCB_0_0_0[12] = 36.0;
	ImmCB_0_0_0[13] = 20.0;
	ImmCB_0_0_0[14] = 48.0;
	ImmCB_0_0_0[15] = 32.0;
	ImmCB_0_0_0[16] = 9.0;
	ImmCB_0_0_0[17] = 57.0;
	ImmCB_0_0_0[18] = 5.0;
	ImmCB_0_0_0[19] = 53.0;
	ImmCB_0_0_0[20] = 12.0;
	ImmCB_0_0_0[21] = 60.0;
	ImmCB_0_0_0[22] = 8.0;
	ImmCB_0_0_0[23] = 56.0;
	ImmCB_0_0_0[24] = 41.0;
	ImmCB_0_0_0[25] = 25.0;
	ImmCB_0_0_0[26] = 37.0;
	ImmCB_0_0_0[27] = 21.0;
	ImmCB_0_0_0[28] = 44.0;
	ImmCB_0_0_0[29] = 28.0;
	ImmCB_0_0_0[30] = 40.0;
	ImmCB_0_0_0[31] = 24.0;
	ImmCB_0_0_0[32] = 3.0;
	ImmCB_0_0_0[33] = 51.0;
	ImmCB_0_0_0[34] = 15.0;
	ImmCB_0_0_0[35] = 63.0;
	ImmCB_0_0_0[36] = 2.0;
	ImmCB_0_0_0[37] = 50.0;
	ImmCB_0_0_0[38] = 14.0;
	ImmCB_0_0_0[39] = 62.0;
	ImmCB_0_0_0[40] = 35.0;
	ImmCB_0_0_0[41] = 19.0;
	ImmCB_0_0_0[42] = 47.0;
	ImmCB_0_0_0[43] = 31.0;
	ImmCB_0_0_0[44] = 34.0;
	ImmCB_0_0_0[45] = 18.0;
	ImmCB_0_0_0[46] = 46.0;
	ImmCB_0_0_0[47] = 30.0;
	ImmCB_0_0_0[48] = 11.0;
	ImmCB_0_0_0[49] = 59.0;
	ImmCB_0_0_0[50] = 7.0;
	ImmCB_0_0_0[51] = 55.0;
	ImmCB_0_0_0[52] = 10.0;
	ImmCB_0_0_0[53] = 58.0;
	ImmCB_0_0_0[54] = 6.0;
	ImmCB_0_0_0[55] = 54.0;
	ImmCB_0_0_0[56] = 43.0;
	ImmCB_0_0_0[57] = 27.0;
	ImmCB_0_0_0[58] = 39.0;
	ImmCB_0_0_0[59] = 23.0;
	ImmCB_0_0_0[60] = 42.0;
	ImmCB_0_0_0[61] = 26.0;
	ImmCB_0_0_0[62] = 38.0;
	ImmCB_0_0_0[63] = 22.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat16_0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
        u_xlat0.xy = u_xlat16_0.xy * _ScreenParams.yx;
        u_xlat0.xy = u_xlat0.xy * vec2(0.125, 0.125);
        u_xlat0.xy = fract(u_xlat0.xy);
        u_xlat0.xy = u_xlat0.xy * vec2(7.99900007, 7.99900007);
        u_xlat0.xy = trunc(u_xlat0.xy);
        u_xlat0.x = u_xlat0.x * 8.0 + u_xlat0.y;
        u_xlati0 = int(u_xlat0.x);
        u_xlat0.x = (-ImmCB_0_0_0[u_xlati0]) * 0.015625 + vs_TEXCOORD2.z;
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(u_xlat0.x<0.0);
#else
        u_xlatb0 = u_xlat0.x<0.0;
#endif
        if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    SV_Target1.xyz = u_xlat10_0.xyz * _MainColor.xyz;
    u_xlat16_1.x = u_xlat10_0.w + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb0 = u_xlat16_1.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat16_1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * vs_TEXCOORD0.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : 0.0399999991;
    SV_Target0.w = 0.0;
    SV_Target1.w = 0.0;
    SV_Target2.xy = vec2(0.0399999991, 0.0399999991);
    SV_Target2.w = _Shininess;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "ENABLE_DEPTH_BLEND_ON" "DITHER_FADE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVPZero[4];
uniform 	vec4 _WorldOffsetRange;
uniform 	float _HeightScale;
uniform 	vec4 _MainTex_ST;
uniform highp sampler2D _Heightmap;
in mediump vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
out mediump vec3 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = (-_WorldOffsetRange.xy) + vec2(1.0, 1.0);
    u_xlat4.xy = vec2(_WorldOffsetRange.z + float(2.0), _WorldOffsetRange.w + float(2.0));
    u_xlat0.xy = u_xlat0.xy / u_xlat4.xy;
    u_xlat0.x = textureLod(_Heightmap, u_xlat0.xy, 0.0).x;
    u_xlat0.y = u_xlat0.x * _HeightScale;
    u_xlat0.x = float(0.0);
    u_xlat0.z = float(0.0);
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVPZero[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVPZero[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVPZero[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVPZero[3];
    gl_Position = u_xlat0;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat1.xyz = u_xlat4.xxx * u_xlat1.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = u_xlat1.xy;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD2.xyw = u_xlat0.xyw;
    vs_TEXCOORD2.z = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
float ImmCB_0_0_0[64];
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _DepthBiasScaled;
uniform 	mediump vec3 _MainColor;
uniform 	mediump float _Shininess;
uniform 	mediump float _CutOff;
uniform lowp sampler2D _MainTex;
uniform highp sampler2D _CameraDepthBlendTexture;
uniform lowp sampler2D _CameraDepthBlendNormTexture;
uniform lowp sampler2D _CameraDepthBlendDiffTexture;
in mediump vec3 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
float u_xlat12;
float u_xlat18;
mediump float u_xlat16_20;
void main()
{
	ImmCB_0_0_0[0] = 1.0;
	ImmCB_0_0_0[1] = 49.0;
	ImmCB_0_0_0[2] = 13.0;
	ImmCB_0_0_0[3] = 61.0;
	ImmCB_0_0_0[4] = 4.0;
	ImmCB_0_0_0[5] = 52.0;
	ImmCB_0_0_0[6] = 16.0;
	ImmCB_0_0_0[7] = 64.0;
	ImmCB_0_0_0[8] = 33.0;
	ImmCB_0_0_0[9] = 17.0;
	ImmCB_0_0_0[10] = 45.0;
	ImmCB_0_0_0[11] = 29.0;
	ImmCB_0_0_0[12] = 36.0;
	ImmCB_0_0_0[13] = 20.0;
	ImmCB_0_0_0[14] = 48.0;
	ImmCB_0_0_0[15] = 32.0;
	ImmCB_0_0_0[16] = 9.0;
	ImmCB_0_0_0[17] = 57.0;
	ImmCB_0_0_0[18] = 5.0;
	ImmCB_0_0_0[19] = 53.0;
	ImmCB_0_0_0[20] = 12.0;
	ImmCB_0_0_0[21] = 60.0;
	ImmCB_0_0_0[22] = 8.0;
	ImmCB_0_0_0[23] = 56.0;
	ImmCB_0_0_0[24] = 41.0;
	ImmCB_0_0_0[25] = 25.0;
	ImmCB_0_0_0[26] = 37.0;
	ImmCB_0_0_0[27] = 21.0;
	ImmCB_0_0_0[28] = 44.0;
	ImmCB_0_0_0[29] = 28.0;
	ImmCB_0_0_0[30] = 40.0;
	ImmCB_0_0_0[31] = 24.0;
	ImmCB_0_0_0[32] = 3.0;
	ImmCB_0_0_0[33] = 51.0;
	ImmCB_0_0_0[34] = 15.0;
	ImmCB_0_0_0[35] = 63.0;
	ImmCB_0_0_0[36] = 2.0;
	ImmCB_0_0_0[37] = 50.0;
	ImmCB_0_0_0[38] = 14.0;
	ImmCB_0_0_0[39] = 62.0;
	ImmCB_0_0_0[40] = 35.0;
	ImmCB_0_0_0[41] = 19.0;
	ImmCB_0_0_0[42] = 47.0;
	ImmCB_0_0_0[43] = 31.0;
	ImmCB_0_0_0[44] = 34.0;
	ImmCB_0_0_0[45] = 18.0;
	ImmCB_0_0_0[46] = 46.0;
	ImmCB_0_0_0[47] = 30.0;
	ImmCB_0_0_0[48] = 11.0;
	ImmCB_0_0_0[49] = 59.0;
	ImmCB_0_0_0[50] = 7.0;
	ImmCB_0_0_0[51] = 55.0;
	ImmCB_0_0_0[52] = 10.0;
	ImmCB_0_0_0[53] = 58.0;
	ImmCB_0_0_0[54] = 6.0;
	ImmCB_0_0_0[55] = 54.0;
	ImmCB_0_0_0[56] = 43.0;
	ImmCB_0_0_0[57] = 27.0;
	ImmCB_0_0_0[58] = 39.0;
	ImmCB_0_0_0[59] = 23.0;
	ImmCB_0_0_0[60] = 42.0;
	ImmCB_0_0_0[61] = 26.0;
	ImmCB_0_0_0[62] = 38.0;
	ImmCB_0_0_0[63] = 22.0;
    u_xlatb0.xy = lessThan(vs_TEXCOORD2.zwzz, vec4(0.949999988, 100.0, 0.0, 0.0)).xy;
    if(u_xlatb0.x){
        u_xlat16_0.xz = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
        u_xlat0.xz = u_xlat16_0.xz * _ScreenParams.yx;
        u_xlat0.xz = u_xlat0.xz * vec2(0.125, 0.125);
        u_xlat0.xz = fract(u_xlat0.xz);
        u_xlat0.xz = u_xlat0.xz * vec2(7.99900007, 7.99900007);
        u_xlat0.xz = trunc(u_xlat0.xz);
        u_xlat0.x = u_xlat0.x * 8.0 + u_xlat0.z;
        u_xlati0 = int(u_xlat0.x);
        u_xlat0.x = (-ImmCB_0_0_0[u_xlati0]) * 0.015625 + vs_TEXCOORD2.z;
#ifdef UNITY_ADRENO_ES3
        u_xlatb0.x = !!(u_xlat0.x<0.0);
#else
        u_xlatb0.x = u_xlat0.x<0.0;
#endif
        if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    //ENDIF
    }
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_2.xyz = u_xlat10_1.xyz * _MainColor.xyz;
    u_xlat16_20 = u_xlat10_1.w + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_20<0.0);
#else
    u_xlatb0.x = u_xlat16_20<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat16_20 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_20 = inversesqrt(u_xlat16_20);
    u_xlat16_3.xyz = vec3(u_xlat16_20) * vs_TEXCOORD0.xyz;
    if(u_xlatb0.y){
        u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat12 = texture(_CameraDepthBlendTexture, u_xlat0.xy).x;
        u_xlat12 = _ZBufferParams.z * u_xlat12 + _ZBufferParams.w;
        u_xlat12 = float(1.0) / u_xlat12;
        u_xlat12 = u_xlat12 + (-vs_TEXCOORD2.w);
        u_xlat12 = abs(u_xlat12) * _DepthBiasScaled;
#ifdef UNITY_ADRENO_ES3
        u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
        u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
        u_xlat12 = sqrt(u_xlat12);
        u_xlat10_4.xyz = texture(_CameraDepthBlendNormTexture, u_xlat0.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat10_0.xyw = texture(_CameraDepthBlendDiffTexture, u_xlat0.xy).xyz;
        u_xlat16_1.xyz = u_xlat10_1.xyz * _MainColor.xyz + (-u_xlat10_0.xyw);
        u_xlat2.xyz = vec3(u_xlat12) * u_xlat16_1.xyz + u_xlat10_0.xyw;
        u_xlat16_0.xyw = vs_TEXCOORD0.xyz * vec3(u_xlat16_20) + (-u_xlat16_5.xyz);
        u_xlat0.xyz = vec3(u_xlat12) * u_xlat16_0.xyw + u_xlat16_5.xyz;
        u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat18 = inversesqrt(u_xlat18);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat0.xyz;
        u_xlat16_2.xyz = u_xlat2.xyz;
        u_xlat16_3.xyz = u_xlat3.xyz;
    //ENDIF
    }
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0.x) ? 0.0 : 0.0399999991;
    SV_Target0.w = 0.0;
    SV_Target1.xyz = u_xlat16_2.xyz;
    SV_Target1.w = 0.0;
    SV_Target2.xy = vec2(0.0399999991, 0.0399999991);
    SV_Target2.w = _Shininess;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "DITHER_FADE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVPZero[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _WorldOffsetRange;
uniform 	float _HeightScale;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _RandomScaleMin;
uniform 	mediump float _RandomScaleMax;
uniform 	mediump float _RandomRotateMin;
uniform 	mediump float _RandomRotateMax;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform highp sampler2D _Heightmap;
in highp vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec3 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
int u_xlati1;
uint u_xlatu1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
vec3 u_xlat5;
vec3 u_xlat7;
vec3 u_xlat8;
uint u_xlatu8;
void main()
{
    u_xlat16_0 = (-_RandomRotateMin) + _RandomRotateMax;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati1 = u_xlati1 << 2;
    u_xlat7.xyz = in_TEXCOORD1.yyy * unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TEXCOORD1.xxx + u_xlat7.xyz;
    u_xlat7.xyz = u_xlat7.xyz + unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat2.x = u_xlat7.y * u_xlat7.x;
    u_xlat2.x = u_xlat7.z * u_xlat2.x;
    u_xlat8.xyz = u_xlat7.xyz + vec3(0.212699994, 0.212699994, 0.212699994);
    u_xlat2.xyz = u_xlat2.xxx * vec3(0.371300012, 0.371300012, 0.371300012) + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat2.xyz * vec3(489.122986, 489.122986, 489.122986);
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat8.xyz = sin(u_xlat8.xyz);
    u_xlat8.xyz = u_xlat8.xyz * vec3(4.78900003, 4.78900003, 4.78900003);
    u_xlat8.x = u_xlat8.y * u_xlat8.x;
    u_xlat8.x = u_xlat8.z * u_xlat8.x;
    u_xlat2.x = u_xlat2.x * u_xlat8.x;
    u_xlat2.x = fract(u_xlat2.x);
    u_xlat8.x = u_xlat2.x * u_xlat16_0 + _RandomRotateMin;
    u_xlat8.x = u_xlat8.x * 0.0174532942;
    u_xlat3.x = sin(u_xlat8.x);
    u_xlat4 = cos(u_xlat8.x);
    u_xlat5.x = sin((-u_xlat8.x));
    u_xlat5.z = u_xlat3.x;
    u_xlat5.y = u_xlat4;
    u_xlat8.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat8.xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat8.xyz + unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) + u_xlat8.xyz;
    u_xlat3.x = dot(u_xlat5.yz, u_xlat8.xz);
    u_xlat3.z = dot(u_xlat5.xy, u_xlat8.xz);
    u_xlat3.y = u_xlat8.y;
    u_xlat16_0 = (-_RandomScaleMin) + _RandomScaleMax;
    u_xlat2.x = u_xlat2.x * u_xlat16_0 + _RandomScaleMin;
    u_xlat8.x = float(floatBitsToUint(unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[2]).w);
    u_xlat8.x = u_xlat8.x * 5.96046448e-08;
    u_xlatu8 = uint(u_xlat8.x);
    u_xlatu8 = u_xlatu8 & 3u;
    u_xlat8.x = float(u_xlatu8);
    u_xlat2.x = u_xlat2.x * u_xlat8.x;
    u_xlat2.x = u_xlat2.x * 0.333000004;
    u_xlat0.xyz = u_xlat3.xyz * u_xlat2.xxx + u_xlat7.xyz;
    u_xlat7.xy = u_xlat7.xz + (-_WorldOffsetRange.xy);
    u_xlat7.xy = u_xlat7.xy + vec2(1.0, 1.0);
    u_xlat2.xy = vec2(_WorldOffsetRange.z + float(2.0), _WorldOffsetRange.w + float(2.0));
    u_xlat7.xy = u_xlat7.xy / u_xlat2.xy;
    u_xlat7.x = textureLod(_Heightmap, u_xlat7.xy, 0.0).x;
    u_xlat0.w = u_xlat7.x * _HeightScale + u_xlat0.y;
    u_xlat7.xyz = u_xlat0.xwz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0 = u_xlat7.yyyy * hlslcc_mtx4x4unity_MatrixVPZero[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVPZero[0] * u_xlat7.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVPZero[2] * u_xlat7.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVPZero[3];
    gl_Position = u_xlat0;
    u_xlat7.xyz = in_NORMAL0.yyy * unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_NORMAL0.xxx + u_xlat7.xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_NORMAL0.zzz + u_xlat7.xyz;
    u_xlatu1 = 4278190080u & floatBitsToUint(unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[3]).w;
    u_xlat1.x = float(u_xlatu1);
    u_xlat0.z = u_xlat1.x * 2.33743719e-10;
    u_xlat1.x = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat7.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = u_xlat1.xy;
    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD2 = u_xlat0;
    vs_SV_InstanceID0 = uint(0u);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
float ImmCB_0_0_0[64];
uniform 	vec4 _ScreenParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump vec3 _MainColor;
uniform 	mediump float _Shininess;
uniform 	mediump float _CutOff;
uniform lowp sampler2D _MainTex;
in mediump vec3 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
void main()
{
	ImmCB_0_0_0[0] = 1.0;
	ImmCB_0_0_0[1] = 49.0;
	ImmCB_0_0_0[2] = 13.0;
	ImmCB_0_0_0[3] = 61.0;
	ImmCB_0_0_0[4] = 4.0;
	ImmCB_0_0_0[5] = 52.0;
	ImmCB_0_0_0[6] = 16.0;
	ImmCB_0_0_0[7] = 64.0;
	ImmCB_0_0_0[8] = 33.0;
	ImmCB_0_0_0[9] = 17.0;
	ImmCB_0_0_0[10] = 45.0;
	ImmCB_0_0_0[11] = 29.0;
	ImmCB_0_0_0[12] = 36.0;
	ImmCB_0_0_0[13] = 20.0;
	ImmCB_0_0_0[14] = 48.0;
	ImmCB_0_0_0[15] = 32.0;
	ImmCB_0_0_0[16] = 9.0;
	ImmCB_0_0_0[17] = 57.0;
	ImmCB_0_0_0[18] = 5.0;
	ImmCB_0_0_0[19] = 53.0;
	ImmCB_0_0_0[20] = 12.0;
	ImmCB_0_0_0[21] = 60.0;
	ImmCB_0_0_0[22] = 8.0;
	ImmCB_0_0_0[23] = 56.0;
	ImmCB_0_0_0[24] = 41.0;
	ImmCB_0_0_0[25] = 25.0;
	ImmCB_0_0_0[26] = 37.0;
	ImmCB_0_0_0[27] = 21.0;
	ImmCB_0_0_0[28] = 44.0;
	ImmCB_0_0_0[29] = 28.0;
	ImmCB_0_0_0[30] = 40.0;
	ImmCB_0_0_0[31] = 24.0;
	ImmCB_0_0_0[32] = 3.0;
	ImmCB_0_0_0[33] = 51.0;
	ImmCB_0_0_0[34] = 15.0;
	ImmCB_0_0_0[35] = 63.0;
	ImmCB_0_0_0[36] = 2.0;
	ImmCB_0_0_0[37] = 50.0;
	ImmCB_0_0_0[38] = 14.0;
	ImmCB_0_0_0[39] = 62.0;
	ImmCB_0_0_0[40] = 35.0;
	ImmCB_0_0_0[41] = 19.0;
	ImmCB_0_0_0[42] = 47.0;
	ImmCB_0_0_0[43] = 31.0;
	ImmCB_0_0_0[44] = 34.0;
	ImmCB_0_0_0[45] = 18.0;
	ImmCB_0_0_0[46] = 46.0;
	ImmCB_0_0_0[47] = 30.0;
	ImmCB_0_0_0[48] = 11.0;
	ImmCB_0_0_0[49] = 59.0;
	ImmCB_0_0_0[50] = 7.0;
	ImmCB_0_0_0[51] = 55.0;
	ImmCB_0_0_0[52] = 10.0;
	ImmCB_0_0_0[53] = 58.0;
	ImmCB_0_0_0[54] = 6.0;
	ImmCB_0_0_0[55] = 54.0;
	ImmCB_0_0_0[56] = 43.0;
	ImmCB_0_0_0[57] = 27.0;
	ImmCB_0_0_0[58] = 39.0;
	ImmCB_0_0_0[59] = 23.0;
	ImmCB_0_0_0[60] = 42.0;
	ImmCB_0_0_0[61] = 26.0;
	ImmCB_0_0_0[62] = 38.0;
	ImmCB_0_0_0[63] = 22.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat16_0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
        u_xlat0.xy = u_xlat16_0.xy * _ScreenParams.yx;
        u_xlat0.xy = u_xlat0.xy * vec2(0.125, 0.125);
        u_xlat0.xy = fract(u_xlat0.xy);
        u_xlat0.xy = u_xlat0.xy * vec2(7.99900007, 7.99900007);
        u_xlat0.xy = trunc(u_xlat0.xy);
        u_xlat0.x = u_xlat0.x * 8.0 + u_xlat0.y;
        u_xlati0 = int(u_xlat0.x);
        u_xlat0.x = (-ImmCB_0_0_0[u_xlati0]) * 0.015625 + vs_TEXCOORD2.z;
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(u_xlat0.x<0.0);
#else
        u_xlatb0 = u_xlat0.x<0.0;
#endif
        if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    SV_Target1.xyz = u_xlat10_0.xyz * _MainColor.xyz;
    u_xlat16_1.x = u_xlat10_0.w + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb0 = u_xlat16_1.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat16_1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * vs_TEXCOORD0.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : 0.0399999991;
    SV_Target0.w = 0.0;
    SV_Target1.w = 0.0;
    SV_Target2.xy = vec2(0.0399999991, 0.0399999991);
    SV_Target2.w = _Shininess;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "ENABLE_DEPTH_BLEND_ON" "DITHER_FADE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVPZero[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _WorldOffsetRange;
uniform 	float _HeightScale;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _RandomScaleMin;
uniform 	mediump float _RandomScaleMax;
uniform 	mediump float _RandomRotateMin;
uniform 	mediump float _RandomRotateMax;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform highp sampler2D _Heightmap;
in highp vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec3 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
int u_xlati1;
uint u_xlatu1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
vec3 u_xlat5;
vec3 u_xlat7;
vec3 u_xlat8;
uint u_xlatu8;
void main()
{
    u_xlat16_0 = (-_RandomRotateMin) + _RandomRotateMax;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati1 = u_xlati1 << 2;
    u_xlat7.xyz = in_TEXCOORD1.yyy * unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TEXCOORD1.xxx + u_xlat7.xyz;
    u_xlat7.xyz = u_xlat7.xyz + unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat2.x = u_xlat7.y * u_xlat7.x;
    u_xlat2.x = u_xlat7.z * u_xlat2.x;
    u_xlat8.xyz = u_xlat7.xyz + vec3(0.212699994, 0.212699994, 0.212699994);
    u_xlat2.xyz = u_xlat2.xxx * vec3(0.371300012, 0.371300012, 0.371300012) + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat2.xyz * vec3(489.122986, 489.122986, 489.122986);
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat8.xyz = sin(u_xlat8.xyz);
    u_xlat8.xyz = u_xlat8.xyz * vec3(4.78900003, 4.78900003, 4.78900003);
    u_xlat8.x = u_xlat8.y * u_xlat8.x;
    u_xlat8.x = u_xlat8.z * u_xlat8.x;
    u_xlat2.x = u_xlat2.x * u_xlat8.x;
    u_xlat2.x = fract(u_xlat2.x);
    u_xlat8.x = u_xlat2.x * u_xlat16_0 + _RandomRotateMin;
    u_xlat8.x = u_xlat8.x * 0.0174532942;
    u_xlat3.x = sin(u_xlat8.x);
    u_xlat4 = cos(u_xlat8.x);
    u_xlat5.x = sin((-u_xlat8.x));
    u_xlat5.z = u_xlat3.x;
    u_xlat5.y = u_xlat4;
    u_xlat8.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat8.xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat8.xyz + unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) + u_xlat8.xyz;
    u_xlat3.x = dot(u_xlat5.yz, u_xlat8.xz);
    u_xlat3.z = dot(u_xlat5.xy, u_xlat8.xz);
    u_xlat3.y = u_xlat8.y;
    u_xlat16_0 = (-_RandomScaleMin) + _RandomScaleMax;
    u_xlat2.x = u_xlat2.x * u_xlat16_0 + _RandomScaleMin;
    u_xlat8.x = float(floatBitsToUint(unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[2]).w);
    u_xlat8.x = u_xlat8.x * 5.96046448e-08;
    u_xlatu8 = uint(u_xlat8.x);
    u_xlatu8 = u_xlatu8 & 3u;
    u_xlat8.x = float(u_xlatu8);
    u_xlat2.x = u_xlat2.x * u_xlat8.x;
    u_xlat2.x = u_xlat2.x * 0.333000004;
    u_xlat0.xyz = u_xlat3.xyz * u_xlat2.xxx + u_xlat7.xyz;
    u_xlat7.xy = u_xlat7.xz + (-_WorldOffsetRange.xy);
    u_xlat7.xy = u_xlat7.xy + vec2(1.0, 1.0);
    u_xlat2.xy = vec2(_WorldOffsetRange.z + float(2.0), _WorldOffsetRange.w + float(2.0));
    u_xlat7.xy = u_xlat7.xy / u_xlat2.xy;
    u_xlat7.x = textureLod(_Heightmap, u_xlat7.xy, 0.0).x;
    u_xlat0.w = u_xlat7.x * _HeightScale + u_xlat0.y;
    u_xlat7.xyz = u_xlat0.xwz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0 = u_xlat7.yyyy * hlslcc_mtx4x4unity_MatrixVPZero[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVPZero[0] * u_xlat7.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVPZero[2] * u_xlat7.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVPZero[3];
    gl_Position = u_xlat0;
    u_xlat7.xyz = in_NORMAL0.yyy * unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_NORMAL0.xxx + u_xlat7.xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_NORMAL0.zzz + u_xlat7.xyz;
    u_xlatu1 = 4278190080u & floatBitsToUint(unity_Builtins0Array[u_xlati1 / 4].hlslcc_mtx4x4unity_ObjectToWorldArray[3]).w;
    u_xlat1.x = float(u_xlatu1);
    u_xlat0.z = u_xlat1.x * 2.33743719e-10;
    u_xlat1.x = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat7.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = u_xlat1.xy;
    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD2 = u_xlat0;
    vs_SV_InstanceID0 = uint(0u);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
float ImmCB_0_0_0[64];
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _DepthBiasScaled;
uniform 	mediump vec3 _MainColor;
uniform 	mediump float _Shininess;
uniform 	mediump float _CutOff;
uniform lowp sampler2D _MainTex;
uniform highp sampler2D _CameraDepthBlendTexture;
uniform lowp sampler2D _CameraDepthBlendNormTexture;
uniform lowp sampler2D _CameraDepthBlendDiffTexture;
in mediump vec3 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
float u_xlat12;
float u_xlat18;
mediump float u_xlat16_20;
void main()
{
	ImmCB_0_0_0[0] = 1.0;
	ImmCB_0_0_0[1] = 49.0;
	ImmCB_0_0_0[2] = 13.0;
	ImmCB_0_0_0[3] = 61.0;
	ImmCB_0_0_0[4] = 4.0;
	ImmCB_0_0_0[5] = 52.0;
	ImmCB_0_0_0[6] = 16.0;
	ImmCB_0_0_0[7] = 64.0;
	ImmCB_0_0_0[8] = 33.0;
	ImmCB_0_0_0[9] = 17.0;
	ImmCB_0_0_0[10] = 45.0;
	ImmCB_0_0_0[11] = 29.0;
	ImmCB_0_0_0[12] = 36.0;
	ImmCB_0_0_0[13] = 20.0;
	ImmCB_0_0_0[14] = 48.0;
	ImmCB_0_0_0[15] = 32.0;
	ImmCB_0_0_0[16] = 9.0;
	ImmCB_0_0_0[17] = 57.0;
	ImmCB_0_0_0[18] = 5.0;
	ImmCB_0_0_0[19] = 53.0;
	ImmCB_0_0_0[20] = 12.0;
	ImmCB_0_0_0[21] = 60.0;
	ImmCB_0_0_0[22] = 8.0;
	ImmCB_0_0_0[23] = 56.0;
	ImmCB_0_0_0[24] = 41.0;
	ImmCB_0_0_0[25] = 25.0;
	ImmCB_0_0_0[26] = 37.0;
	ImmCB_0_0_0[27] = 21.0;
	ImmCB_0_0_0[28] = 44.0;
	ImmCB_0_0_0[29] = 28.0;
	ImmCB_0_0_0[30] = 40.0;
	ImmCB_0_0_0[31] = 24.0;
	ImmCB_0_0_0[32] = 3.0;
	ImmCB_0_0_0[33] = 51.0;
	ImmCB_0_0_0[34] = 15.0;
	ImmCB_0_0_0[35] = 63.0;
	ImmCB_0_0_0[36] = 2.0;
	ImmCB_0_0_0[37] = 50.0;
	ImmCB_0_0_0[38] = 14.0;
	ImmCB_0_0_0[39] = 62.0;
	ImmCB_0_0_0[40] = 35.0;
	ImmCB_0_0_0[41] = 19.0;
	ImmCB_0_0_0[42] = 47.0;
	ImmCB_0_0_0[43] = 31.0;
	ImmCB_0_0_0[44] = 34.0;
	ImmCB_0_0_0[45] = 18.0;
	ImmCB_0_0_0[46] = 46.0;
	ImmCB_0_0_0[47] = 30.0;
	ImmCB_0_0_0[48] = 11.0;
	ImmCB_0_0_0[49] = 59.0;
	ImmCB_0_0_0[50] = 7.0;
	ImmCB_0_0_0[51] = 55.0;
	ImmCB_0_0_0[52] = 10.0;
	ImmCB_0_0_0[53] = 58.0;
	ImmCB_0_0_0[54] = 6.0;
	ImmCB_0_0_0[55] = 54.0;
	ImmCB_0_0_0[56] = 43.0;
	ImmCB_0_0_0[57] = 27.0;
	ImmCB_0_0_0[58] = 39.0;
	ImmCB_0_0_0[59] = 23.0;
	ImmCB_0_0_0[60] = 42.0;
	ImmCB_0_0_0[61] = 26.0;
	ImmCB_0_0_0[62] = 38.0;
	ImmCB_0_0_0[63] = 22.0;
    u_xlatb0.xy = lessThan(vs_TEXCOORD2.zwzz, vec4(0.949999988, 100.0, 0.0, 0.0)).xy;
    if(u_xlatb0.x){
        u_xlat16_0.xz = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
        u_xlat0.xz = u_xlat16_0.xz * _ScreenParams.yx;
        u_xlat0.xz = u_xlat0.xz * vec2(0.125, 0.125);
        u_xlat0.xz = fract(u_xlat0.xz);
        u_xlat0.xz = u_xlat0.xz * vec2(7.99900007, 7.99900007);
        u_xlat0.xz = trunc(u_xlat0.xz);
        u_xlat0.x = u_xlat0.x * 8.0 + u_xlat0.z;
        u_xlati0 = int(u_xlat0.x);
        u_xlat0.x = (-ImmCB_0_0_0[u_xlati0]) * 0.015625 + vs_TEXCOORD2.z;
#ifdef UNITY_ADRENO_ES3
        u_xlatb0.x = !!(u_xlat0.x<0.0);
#else
        u_xlatb0.x = u_xlat0.x<0.0;
#endif
        if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    //ENDIF
    }
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_2.xyz = u_xlat10_1.xyz * _MainColor.xyz;
    u_xlat16_20 = u_xlat10_1.w + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_20<0.0);
#else
    u_xlatb0.x = u_xlat16_20<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat16_20 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_20 = inversesqrt(u_xlat16_20);
    u_xlat16_3.xyz = vec3(u_xlat16_20) * vs_TEXCOORD0.xyz;
    if(u_xlatb0.y){
        u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat12 = texture(_CameraDepthBlendTexture, u_xlat0.xy).x;
        u_xlat12 = _ZBufferParams.z * u_xlat12 + _ZBufferParams.w;
        u_xlat12 = float(1.0) / u_xlat12;
        u_xlat12 = u_xlat12 + (-vs_TEXCOORD2.w);
        u_xlat12 = abs(u_xlat12) * _DepthBiasScaled;
#ifdef UNITY_ADRENO_ES3
        u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
        u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
        u_xlat12 = sqrt(u_xlat12);
        u_xlat10_4.xyz = texture(_CameraDepthBlendNormTexture, u_xlat0.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat10_0.xyw = texture(_CameraDepthBlendDiffTexture, u_xlat0.xy).xyz;
        u_xlat16_1.xyz = u_xlat10_1.xyz * _MainColor.xyz + (-u_xlat10_0.xyw);
        u_xlat2.xyz = vec3(u_xlat12) * u_xlat16_1.xyz + u_xlat10_0.xyw;
        u_xlat16_0.xyw = vs_TEXCOORD0.xyz * vec3(u_xlat16_20) + (-u_xlat16_5.xyz);
        u_xlat0.xyz = vec3(u_xlat12) * u_xlat16_0.xyw + u_xlat16_5.xyz;
        u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat18 = inversesqrt(u_xlat18);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat0.xyz;
        u_xlat16_2.xyz = u_xlat2.xyz;
        u_xlat16_3.xyz = u_xlat3.xyz;
    //ENDIF
    }
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0.x) ? 0.0 : 0.0399999991;
    SV_Target0.w = 0.0;
    SV_Target1.xyz = u_xlat16_2.xyz;
    SV_Target1.w = 0.0;
    SV_Target2.xy = vec2(0.0399999991, 0.0399999991);
    SV_Target2.w = _Shininess;
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
Keywords { "ENABLE_DEPTH_BLEND_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "ENABLE_DEPTH_BLEND_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DITHER_FADE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "ENABLE_DEPTH_BLEND_ON" "DITHER_FADE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "DITHER_FADE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "ENABLE_DEPTH_BLEND_ON" "DITHER_FADE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "ENABLE_DEPTH_BLEND_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "ENABLE_DEPTH_BLEND_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "DITHER_FADE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "ENABLE_DEPTH_BLEND_ON" "DITHER_FADE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "DITHER_FADE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "ENABLE_DEPTH_BLEND_ON" "DITHER_FADE_ON" }
""
}
}
}
}
}