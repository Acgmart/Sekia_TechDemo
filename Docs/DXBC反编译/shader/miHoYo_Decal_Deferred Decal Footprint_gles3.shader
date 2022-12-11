//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Decal/Deferred Decal Footprint" {
Properties {
_MaskTex ("Mask Texture (R)", 2D) = "white" { }
_Color ("Albedo (Multiplier)", Color) = (1,1,1,1)
_NormalTex ("Normal Map", 2D) = "bump" { }
_NormalMultiplier ("Normal (Multiplier)", Float) = 1
_Opacity ("Opacity", Range(0, 1)) = 1
_AddingShininess ("Adding Shininess", Range(0, 0.5)) = 0.1
_AngleLimit ("Angle Limit", Float) = 0.5
_InstancedTexST ("", Vector) = (1,1,0,0)
_InstancedNomralTexST ("", Vector) = (1,1,0,0)
}
SubShader {
 Pass {
  Tags { "LIGHTMODE" = "PREPASSDECALFINAL" }
  ZTest GEqual
  ZWrite Off
  Cull Front
  GpuProgramID 21762
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat1.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    u_xlat0.x = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * hlslcc_mtx4x4unity_ObjectToWorld[2].xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * hlslcc_mtx4x4unity_ObjectToWorld[0].xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 _Color;
uniform 	float _NormalMultiplier;
uniform 	float _AngleLimit;
uniform 	mediump vec4 _LightColor0;
uniform 	float _Opacity;
uniform 	float _AddingShininess;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _CameraNormalsTexture;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _CameraAlbedoTexture;
uniform lowp sampler2D _CameraSpecularTexture;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec2 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
bvec3 u_xlatb2;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
vec3 u_xlat9;
mediump vec3 u_xlat16_9;
bool u_xlatb9;
mediump vec3 u_xlat16_10;
float u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
bool u_xlatb18;
float u_xlat19;
lowp vec2 u_xlat10_19;
bool u_xlatb19;
float u_xlat27;
mediump float u_xlat16_27;
mediump float u_xlat16_30;
mediump float u_xlat16_31;
void main()
{
    u_xlat0.x = _ProjectionParams.z / vs_TEXCOORD2.z;
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat27 = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat27 = _ZBufferParams.x * u_xlat27 + _ZBufferParams.y;
    u_xlat27 = float(1.0) / u_xlat27;
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat2.xyz = -abs(u_xlat0.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlatb2.xyz = lessThan(u_xlat2.xyzx, vec4(0.0, 0.0, 0.0, 0.0)).xyz;
    u_xlatb18 = u_xlatb2.y || u_xlatb2.x;
    u_xlatb18 = u_xlatb2.z || u_xlatb18;
    if((int(u_xlatb18) * int(0xffffffffu))!=0){discard;}
    u_xlat10_2.xyz = texture(_CameraNormalsTexture, u_xlat1.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_18 = dot(u_xlat16_3.xyz, vs_TEXCOORD3.xyz);
    u_xlat18 = u_xlat16_18 + (-_AngleLimit);
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat18<0.0);
#else
    u_xlatb18 = u_xlat18<0.0;
#endif
    if((int(u_xlatb18) * int(0xffffffffu))!=0){discard;}
    u_xlat0.w = (-u_xlat0.x);
    u_xlat0.xy = vec2(u_xlat0.w + float(0.5), u_xlat0.y + float(0.5));
    u_xlat10_18 = texture(_MaskTex, u_xlat0.xy).x;
    u_xlat10_0.xyw = texture(_NormalTex, u_xlat0.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_0.xyw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_30 = u_xlat10_18 * _Opacity + -0.00100000005;
    u_xlat0.x = u_xlat10_18 * _Opacity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat16_30<0.0);
#else
    u_xlatb9 = u_xlat16_30<0.0;
#endif
    if((int(u_xlatb9) * int(0xffffffffu))!=0){discard;}
    u_xlat2.z = u_xlat16_4.z;
    u_xlat2.xy = u_xlat16_4.xy * vec2(_NormalMultiplier);
    u_xlat16_4.xyz = vs_TEXCOORD3.xyz * vs_TEXCOORD4.zxy;
    u_xlat16_4.xyz = vs_TEXCOORD3.zxy * vs_TEXCOORD4.xyz + (-u_xlat16_4.xyz);
    u_xlat16_9.xyz = u_xlat16_3.zxy * u_xlat16_4.xyz;
    u_xlat9.xyz = u_xlat16_3.yzx * u_xlat16_4.yzx + (-u_xlat16_9.xyz);
    u_xlat19 = dot(vs_TEXCOORD4.xyz, u_xlat9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(u_xlat19));
#else
    u_xlatb19 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(u_xlat19);
#endif
    u_xlat16_5.xyz = (bool(u_xlatb19)) ? (-u_xlat9.yxz) : u_xlat9.yxz;
    u_xlat16_6.x = u_xlat16_5.y;
    u_xlat16_6.y = u_xlat16_4.z;
    u_xlat16_6.z = u_xlat16_3.x;
    u_xlat7.x = dot(u_xlat2.xyz, u_xlat16_6.xyz);
    u_xlat8.z = u_xlat2.z;
    u_xlat16_5.y = u_xlat16_4.x;
    u_xlat8.xy = u_xlat2.xy;
    u_xlat16_4.x = u_xlat16_5.z;
    u_xlat16_4.z = u_xlat16_3.z;
    u_xlat7.z = dot(u_xlat8.xyz, u_xlat16_4.xyz);
    u_xlat16_5.z = u_xlat16_3.y;
    u_xlat7.y = dot(u_xlat2.xyz, u_xlat16_5.xyz);
    u_xlat9.xyz = (-u_xlat16_3.xyz) + u_xlat7.xyz;
    u_xlat9.xyz = u_xlat0.xxx * u_xlat9.xyz + u_xlat16_3.xyz;
    u_xlat19 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat9.xyz = u_xlat9.xyz * vec3(u_xlat19);
    u_xlat2.xyz = (-vs_TEXCOORD5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat19 = dot(u_xlat9.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat7.xyz = vec3(u_xlat19) * _LightColor0.xyz;
    u_xlat10_19.xy = texture(_ShadowMapTexture, u_xlat1.xy).xy;
    u_xlat7.xyz = u_xlat10_19.xxx * u_xlat7.xyz;
    u_xlat10_8.xyz = texture(_CameraAlbedoTexture, u_xlat1.xy).xyz;
    u_xlat10_3 = texture(_CameraSpecularTexture, u_xlat1.xy);
    u_xlat16_4.xyz = u_xlat10_8.xyz * _Color.xyz + (-u_xlat10_8.xyz);
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz + u_xlat10_8.xyz;
    u_xlat7.xyz = u_xlat16_4.xyz * u_xlat7.xyz;
    u_xlat8.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat16_5.xyz = u_xlat8.xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat16_31 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_5.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat16_5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat9.x = dot(u_xlat9.xyz, u_xlat16_5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat18 = (-u_xlat1.x) + 1.0;
    u_xlat16_31 = u_xlat18 * u_xlat18;
    u_xlat16_31 = u_xlat18 * u_xlat16_31;
    u_xlat16_31 = u_xlat18 * u_xlat16_31;
    u_xlat16_31 = u_xlat18 * u_xlat16_31;
    u_xlat16_2.xyz = (-u_xlat10_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = vec3(u_xlat16_31) * u_xlat16_2.xyz;
    u_xlat18 = u_xlat10_3.w + _AddingShininess;
    u_xlat18 = min(u_xlat18, 0.5);
    u_xlat16_31 = (-u_xlat18) + 1.0;
    u_xlat16_18 = u_xlat16_31 * u_xlat16_31;
    u_xlat16_27 = (-u_xlat16_18) * u_xlat16_18 + 1.0;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_27 = u_xlat16_27 + u_xlat16_27;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_27) + u_xlat10_3.xyz;
    u_xlat27 = u_xlat9.x * u_xlat16_18 + (-u_xlat9.x);
    u_xlat9.x = u_xlat27 * u_xlat9.x + 1.0;
    u_xlat9.x = u_xlat9.x * u_xlat9.x;
    u_xlat9.x = max(u_xlat9.x, 9.99999997e-07);
    u_xlat9.x = u_xlat16_18 / u_xlat9.x;
    u_xlat9.x = u_xlat9.x * 0.318309873;
    u_xlat9.x = min(u_xlat9.x, 64.0);
    u_xlat8.xyz = u_xlat16_2.xyz * u_xlat9.xxx;
    u_xlat9.xyz = u_xlat9.xxx * u_xlat16_2.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat9.xyz = u_xlat8.xyz / u_xlat9.xyz;
    u_xlat9.xyz = u_xlat9.xyz + u_xlat9.xyz;
    u_xlat9.xyz = u_xlat9.xyz * _LightColor0.xyz;
    u_xlat9.xyz = u_xlat10_19.xxx * u_xlat9.xyz;
    u_xlat16_1.x = u_xlat10_19.y + -1.0;
    u_xlat16_1.x = u_xlat16_1.x * 0.349999994 + 1.0;
    u_xlat9.xyz = u_xlat9.xyz * u_xlat16_1.xxx;
    u_xlat16_1.x = (-u_xlat16_1.x) * 0.5 + 0.5;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_5.xyz = abs(u_xlat16_4.xyz) + vec3(0.00100000005, 0.00100000005, 0.00100000005);
    u_xlat16_10.xyz = log2(u_xlat16_5.xyz);
    u_xlat16_1.xyz = u_xlat16_10.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat9.xyz = u_xlat7.xyz * u_xlat16_1.xyz + u_xlat9.xyz;
    u_xlat9.xyz = vs_TEXCOORD6.xyz * u_xlat16_4.xyz + u_xlat9.xyz;
    SV_Target0.xyz = u_xlat0.xxx * u_xlat9.xyz;
    SV_Target0.w = u_xlat0.x;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat4.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat4.x * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat4.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat2.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat2.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat2.www + u_xlat4.xyz;
    vs_TEXCOORD2.xyz = u_xlat4.xyz * vec3(-1.0, -1.0, 1.0);
    u_xlat4.x = dot(unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz;
    vs_TEXCOORD3.xyz = u_xlat4.xyz;
    u_xlat4.x = dot(unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat0.xyz = u_xlat4.xxx * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.xyz = vec3(0.0, 0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _Color;
uniform 	float _NormalMultiplier;
uniform 	float _AngleLimit;
uniform 	mediump vec4 _LightColor0;
uniform 	float _Opacity;
uniform 	float _AddingShininess;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _CameraNormalsTexture;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _CameraAlbedoTexture;
uniform lowp sampler2D _CameraSpecularTexture;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD6;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec2 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
bvec3 u_xlatb2;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
vec3 u_xlat9;
mediump vec3 u_xlat16_9;
bool u_xlatb9;
mediump vec3 u_xlat16_10;
float u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
bool u_xlatb18;
float u_xlat19;
lowp vec2 u_xlat10_19;
bool u_xlatb19;
float u_xlat27;
mediump float u_xlat16_27;
int u_xlati27;
mediump float u_xlat16_30;
mediump float u_xlat16_31;
void main()
{
    u_xlat0.x = _ProjectionParams.z / vs_TEXCOORD2.z;
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat27 = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat27 = _ZBufferParams.x * u_xlat27 + _ZBufferParams.y;
    u_xlat27 = float(1.0) / u_xlat27;
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    u_xlati27 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlati27 = u_xlati27 << 3;
    u_xlat2.xyz = u_xlat0.yyy * unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz + unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3].xyz;
    u_xlat2.xyz = -abs(u_xlat0.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlatb2.xyz = lessThan(u_xlat2.xyzx, vec4(0.0, 0.0, 0.0, 0.0)).xyz;
    u_xlatb18 = u_xlatb2.y || u_xlatb2.x;
    u_xlatb18 = u_xlatb2.z || u_xlatb18;
    if((int(u_xlatb18) * int(0xffffffffu))!=0){discard;}
    u_xlat10_2.xyz = texture(_CameraNormalsTexture, u_xlat1.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_18 = dot(u_xlat16_3.xyz, vs_TEXCOORD3.xyz);
    u_xlat18 = u_xlat16_18 + (-_AngleLimit);
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat18<0.0);
#else
    u_xlatb18 = u_xlat18<0.0;
#endif
    if((int(u_xlatb18) * int(0xffffffffu))!=0){discard;}
    u_xlat0.w = (-u_xlat0.x);
    u_xlat0.xy = vec2(u_xlat0.w + float(0.5), u_xlat0.y + float(0.5));
    u_xlat10_18 = texture(_MaskTex, u_xlat0.xy).x;
    u_xlat10_0.xyw = texture(_NormalTex, u_xlat0.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_0.xyw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_30 = u_xlat10_18 * _Opacity + -0.00100000005;
    u_xlat0.x = u_xlat10_18 * _Opacity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat16_30<0.0);
#else
    u_xlatb9 = u_xlat16_30<0.0;
#endif
    if((int(u_xlatb9) * int(0xffffffffu))!=0){discard;}
    u_xlat2.z = u_xlat16_4.z;
    u_xlat2.xy = u_xlat16_4.xy * vec2(_NormalMultiplier);
    u_xlat16_4.xyz = vs_TEXCOORD3.xyz * vs_TEXCOORD4.zxy;
    u_xlat16_4.xyz = vs_TEXCOORD3.zxy * vs_TEXCOORD4.xyz + (-u_xlat16_4.xyz);
    u_xlat16_9.xyz = u_xlat16_3.zxy * u_xlat16_4.xyz;
    u_xlat9.xyz = u_xlat16_3.yzx * u_xlat16_4.yzx + (-u_xlat16_9.xyz);
    u_xlat19 = dot(vs_TEXCOORD4.xyz, u_xlat9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(u_xlat19));
#else
    u_xlatb19 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(u_xlat19);
#endif
    u_xlat16_5.xyz = (bool(u_xlatb19)) ? (-u_xlat9.yxz) : u_xlat9.yxz;
    u_xlat16_6.x = u_xlat16_5.y;
    u_xlat16_6.y = u_xlat16_4.z;
    u_xlat16_6.z = u_xlat16_3.x;
    u_xlat7.x = dot(u_xlat2.xyz, u_xlat16_6.xyz);
    u_xlat8.z = u_xlat2.z;
    u_xlat8.xy = u_xlat2.xy;
    u_xlat16_5.y = u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_5.z;
    u_xlat16_4.z = u_xlat16_3.z;
    u_xlat7.z = dot(u_xlat8.xyz, u_xlat16_4.xyz);
    u_xlat16_5.z = u_xlat16_3.y;
    u_xlat7.y = dot(u_xlat2.xyz, u_xlat16_5.xyz);
    u_xlat9.xyz = (-u_xlat16_3.xyz) + u_xlat7.xyz;
    u_xlat9.xyz = u_xlat0.xxx * u_xlat9.xyz + u_xlat16_3.xyz;
    u_xlat19 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat9.xyz = u_xlat9.xyz * vec3(u_xlat19);
    u_xlat2.xyz = (-vs_TEXCOORD5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat19 = dot(u_xlat9.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat7.xyz = vec3(u_xlat19) * _LightColor0.xyz;
    u_xlat10_19.xy = texture(_ShadowMapTexture, u_xlat1.xy).xy;
    u_xlat7.xyz = u_xlat10_19.xxx * u_xlat7.xyz;
    u_xlat10_8.xyz = texture(_CameraAlbedoTexture, u_xlat1.xy).xyz;
    u_xlat10_3 = texture(_CameraSpecularTexture, u_xlat1.xy);
    u_xlat16_4.xyz = u_xlat10_8.xyz * _Color.xyz + (-u_xlat10_8.xyz);
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz + u_xlat10_8.xyz;
    u_xlat7.xyz = u_xlat16_4.xyz * u_xlat7.xyz;
    u_xlat8.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat16_5.xyz = u_xlat8.xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat16_31 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_5.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat16_5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat9.x = dot(u_xlat9.xyz, u_xlat16_5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat18 = (-u_xlat1.x) + 1.0;
    u_xlat16_31 = u_xlat18 * u_xlat18;
    u_xlat16_31 = u_xlat18 * u_xlat16_31;
    u_xlat16_31 = u_xlat18 * u_xlat16_31;
    u_xlat16_31 = u_xlat18 * u_xlat16_31;
    u_xlat16_2.xyz = (-u_xlat10_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = vec3(u_xlat16_31) * u_xlat16_2.xyz;
    u_xlat18 = u_xlat10_3.w + _AddingShininess;
    u_xlat18 = min(u_xlat18, 0.5);
    u_xlat16_31 = (-u_xlat18) + 1.0;
    u_xlat16_18 = u_xlat16_31 * u_xlat16_31;
    u_xlat16_27 = (-u_xlat16_18) * u_xlat16_18 + 1.0;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_27 = u_xlat16_27 + u_xlat16_27;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_27) + u_xlat10_3.xyz;
    u_xlat27 = u_xlat9.x * u_xlat16_18 + (-u_xlat9.x);
    u_xlat9.x = u_xlat27 * u_xlat9.x + 1.0;
    u_xlat9.x = u_xlat9.x * u_xlat9.x;
    u_xlat9.x = max(u_xlat9.x, 9.99999997e-07);
    u_xlat9.x = u_xlat16_18 / u_xlat9.x;
    u_xlat9.x = u_xlat9.x * 0.318309873;
    u_xlat9.x = min(u_xlat9.x, 64.0);
    u_xlat8.xyz = u_xlat16_2.xyz * u_xlat9.xxx;
    u_xlat9.xyz = u_xlat9.xxx * u_xlat16_2.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat9.xyz = u_xlat8.xyz / u_xlat9.xyz;
    u_xlat9.xyz = u_xlat9.xyz + u_xlat9.xyz;
    u_xlat9.xyz = u_xlat9.xyz * _LightColor0.xyz;
    u_xlat9.xyz = u_xlat10_19.xxx * u_xlat9.xyz;
    u_xlat16_1.x = u_xlat10_19.y + -1.0;
    u_xlat16_1.x = u_xlat16_1.x * 0.349999994 + 1.0;
    u_xlat9.xyz = u_xlat9.xyz * u_xlat16_1.xxx;
    u_xlat16_1.x = (-u_xlat16_1.x) * 0.5 + 0.5;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_5.xyz = abs(u_xlat16_4.xyz) + vec3(0.00100000005, 0.00100000005, 0.00100000005);
    u_xlat16_10.xyz = log2(u_xlat16_5.xyz);
    u_xlat16_1.xyz = u_xlat16_10.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat9.xyz = u_xlat7.xyz * u_xlat16_1.xyz + u_xlat9.xyz;
    u_xlat9.xyz = vs_TEXCOORD6.xyz * u_xlat16_4.xyz + u_xlat9.xyz;
    SV_Target0.xyz = u_xlat0.xxx * u_xlat9.xyz;
    SV_Target0.w = u_xlat0.x;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat1.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    u_xlat0.x = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * hlslcc_mtx4x4unity_ObjectToWorld[2].xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * hlslcc_mtx4x4unity_ObjectToWorld[0].xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 _Color;
uniform 	float _NormalMultiplier;
uniform 	float _AngleLimit;
uniform 	mediump vec4 _LightColor0;
uniform 	float _Opacity;
uniform 	float _AddingShininess;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _ShadowMapTexture;
uniform lowp sampler2DMS _CameraNormalsTexture;
uniform lowp sampler2DMS _CameraAlbedoTexture;
uniform lowp sampler2DMS _CameraSpecularTexture;
uniform lowp sampler2DMS _CameraDepthTextureMS;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec2 u_xlat1;
mediump float u_xlat16_1;
lowp vec2 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
uvec4 u_xlatu2;
vec3 u_xlat3;
bvec3 u_xlatb3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
vec3 u_xlat9;
vec3 u_xlat10;
mediump vec3 u_xlat16_10;
bool u_xlatb10;
vec3 u_xlat11;
float u_xlat20;
mediump float u_xlat16_20;
lowp float u_xlat10_20;
bool u_xlatb20;
vec2 u_xlat21;
bool u_xlatb21;
float u_xlat30;
mediump float u_xlat16_30;
float u_xlat31;
mediump float u_xlat16_34;
void main()
{
    u_xlat0.x = _ProjectionParams.z / vs_TEXCOORD2.z;
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat21.xy = u_xlat1.xy * _ScreenParams.xy;
    u_xlat10_1.xy = texture(_ShadowMapTexture, u_xlat1.xy).xy;
    u_xlat21.xy = floor(u_xlat21.xy);
    u_xlatu2.xy = uvec2(ivec2(u_xlat21.xy));
    u_xlatu2.z = uint(uint(0u));
    u_xlatu2.w = uint(uint(0u));
    u_xlat30 = texelFetch(_CameraDepthTextureMS, ivec2(u_xlatu2.xy), 0).x;
    u_xlat30 = _ZBufferParams.x * u_xlat30 + _ZBufferParams.y;
    u_xlat30 = float(1.0) / u_xlat30;
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat3.xyz = -abs(u_xlat0.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlatb3.xyz = lessThan(u_xlat3.xyzx, vec4(0.0, 0.0, 0.0, 0.0)).xyz;
    u_xlatb20 = u_xlatb3.y || u_xlatb3.x;
    u_xlatb20 = u_xlatb3.z || u_xlatb20;
    if((int(u_xlatb20) * int(0xffffffffu))!=0){discard;}
    u_xlat3.xyz = texelFetch(_CameraNormalsTexture, ivec2(u_xlatu2.xy), 0).xyz;
    u_xlat16_4.xyz = u_xlat3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_20 = dot(u_xlat16_4.xyz, vs_TEXCOORD3.xyz);
    u_xlat20 = u_xlat16_20 + (-_AngleLimit);
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(u_xlat20<0.0);
#else
    u_xlatb20 = u_xlat20<0.0;
#endif
    if((int(u_xlatb20) * int(0xffffffffu))!=0){discard;}
    u_xlat0.w = (-u_xlat0.x);
    u_xlat0.xy = vec2(u_xlat0.w + float(0.5), u_xlat0.y + float(0.5));
    u_xlat10_20 = texture(_MaskTex, u_xlat0.xy).x;
    u_xlat10_0.xyw = texture(_NormalTex, u_xlat0.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_0.xyw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_34 = u_xlat10_20 * _Opacity + -0.00100000005;
    u_xlat0.x = u_xlat10_20 * _Opacity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat16_34<0.0);
#else
    u_xlatb10 = u_xlat16_34<0.0;
#endif
    if((int(u_xlatb10) * int(0xffffffffu))!=0){discard;}
    u_xlat3.z = u_xlat16_5.z;
    u_xlat3.xy = u_xlat16_5.xy * vec2(_NormalMultiplier);
    u_xlat16_5.xyz = vs_TEXCOORD3.xyz * vs_TEXCOORD4.zxy;
    u_xlat16_5.xyz = vs_TEXCOORD3.zxy * vs_TEXCOORD4.xyz + (-u_xlat16_5.xyz);
    u_xlat16_10.xyz = u_xlat16_4.zxy * u_xlat16_5.xyz;
    u_xlat10.xyz = u_xlat16_4.yzx * u_xlat16_5.yzx + (-u_xlat16_10.xyz);
    u_xlat21.x = dot(vs_TEXCOORD4.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(u_xlat21.x));
#else
    u_xlatb21 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(u_xlat21.x);
#endif
    u_xlat16_6.xyz = (bool(u_xlatb21)) ? (-u_xlat10.yxz) : u_xlat10.yxz;
    u_xlat16_7.x = u_xlat16_6.y;
    u_xlat16_7.z = u_xlat16_4.x;
    u_xlat16_7.y = u_xlat16_5.z;
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat16_7.xyz);
    u_xlat9.z = u_xlat3.z;
    u_xlat16_6.y = u_xlat16_5.x;
    u_xlat9.xy = u_xlat3.xy;
    u_xlat16_5.x = u_xlat16_6.z;
    u_xlat16_5.z = u_xlat16_4.z;
    u_xlat8.z = dot(u_xlat9.xyz, u_xlat16_5.xyz);
    u_xlat16_6.z = u_xlat16_4.y;
    u_xlat8.y = dot(u_xlat3.xyz, u_xlat16_6.xyz);
    u_xlat10.xyz = (-u_xlat16_4.xyz) + u_xlat8.xyz;
    u_xlat10.xyz = u_xlat0.xxx * u_xlat10.xyz + u_xlat16_4.xyz;
    u_xlat21.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat21.x = inversesqrt(u_xlat21.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat21.xxx;
    u_xlat3.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21.x = inversesqrt(u_xlat21.x);
    u_xlat8.xyz = (-vs_TEXCOORD5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat31 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat8.xyz = vec3(u_xlat31) * u_xlat8.xyz;
    u_xlat16_4.xyz = u_xlat3.xyz * u_xlat21.xxx + u_xlat8.xyz;
    u_xlat16_34 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_34 = inversesqrt(u_xlat16_34);
    u_xlat16_4.xyz = vec3(u_xlat16_34) * u_xlat16_4.xyz;
    u_xlat21.x = dot(u_xlat10.xyz, u_xlat16_4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat21.x = min(max(u_xlat21.x, 0.0), 1.0);
#else
    u_xlat21.x = clamp(u_xlat21.x, 0.0, 1.0);
#endif
    u_xlat10.x = dot(u_xlat10.xyz, u_xlat8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat20 = dot(u_xlat8.xyz, u_xlat16_4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat20 = (-u_xlat20) + 1.0;
    u_xlat3.xyz = u_xlat10.xxx * _LightColor0.xyz;
    u_xlat3.xyz = u_xlat10_1.xxx * u_xlat3.xyz;
    u_xlat4 = texelFetch(_CameraSpecularTexture, ivec2(u_xlatu2.xy), 0);
    u_xlat2.xyz = texelFetch(_CameraAlbedoTexture, ivec2(u_xlatu2.xy), 0).xyz;
    u_xlat10.x = u_xlat4.w + _AddingShininess;
    u_xlat10.x = min(u_xlat10.x, 0.5);
    u_xlat16_5.x = (-u_xlat10.x) + 1.0;
    u_xlat16_10.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_30 = u_xlat16_10.x * u_xlat16_10.x;
    u_xlat16_10.x = (-u_xlat16_10.x) * u_xlat16_10.x + 1.0;
    u_xlat16_10.x = u_xlat16_10.x + u_xlat16_10.x;
    u_xlat31 = u_xlat21.x * u_xlat16_30 + (-u_xlat21.x);
    u_xlat21.x = u_xlat31 * u_xlat21.x + 1.0;
    u_xlat21.x = u_xlat21.x * u_xlat21.x;
    u_xlat21.x = max(u_xlat21.x, 9.99999997e-07);
    u_xlat30 = u_xlat16_30 / u_xlat21.x;
    u_xlat30 = u_xlat30 * 0.318309873;
    u_xlat30 = min(u_xlat30, 64.0);
    u_xlat16_5.x = u_xlat20 * u_xlat20;
    u_xlat16_5.x = u_xlat20 * u_xlat16_5.x;
    u_xlat16_5.x = u_xlat20 * u_xlat16_5.x;
    u_xlat16_5.x = u_xlat20 * u_xlat16_5.x;
    u_xlat8.xyz = (-u_xlat4.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat8.xyz = u_xlat16_5.xxx * u_xlat8.xyz;
    u_xlat8.xyz = u_xlat8.xyz * u_xlat16_10.xxx + u_xlat4.xyz;
    u_xlat9.xyz = vec3(u_xlat30) * u_xlat8.xyz;
    u_xlat10.xyz = vec3(u_xlat30) * u_xlat8.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat10.xyz = u_xlat9.xyz / u_xlat10.xyz;
    u_xlat10.xyz = u_xlat10.xyz + u_xlat10.xyz;
    u_xlat10.xyz = u_xlat10.xyz * _LightColor0.xyz;
    u_xlat10.xyz = u_xlat10_1.xxx * u_xlat10.xyz;
    u_xlat16_1 = u_xlat10_1.y + -1.0;
    u_xlat16_1 = u_xlat16_1 * 0.349999994 + 1.0;
    u_xlat10.xyz = u_xlat10.xyz * vec3(u_xlat16_1);
    u_xlat16_1 = (-u_xlat16_1) * 0.5 + 0.5;
    u_xlat16_1 = max(u_xlat16_1, 0.00100000005);
    u_xlat16_5.xyz = u_xlat2.xyz * _Color.xyz + (-u_xlat2.xyz);
    u_xlat16_5.xyz = u_xlat0.xxx * u_xlat16_5.xyz + u_xlat2.xyz;
    u_xlat11.xyz = u_xlat3.xyz * u_xlat16_5.xyz;
    u_xlat16_6.xyz = abs(u_xlat16_5.xyz) + vec3(0.00100000005, 0.00100000005, 0.00100000005);
    u_xlat16_2.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_2.xyz = vec3(u_xlat16_1) * u_xlat16_2.xyz;
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat10.xyz = u_xlat11.xyz * u_xlat16_2.xyz + u_xlat10.xyz;
    u_xlat10.xyz = vs_TEXCOORD6.xyz * u_xlat16_5.xyz + u_xlat10.xyz;
    SV_Target0.xyz = u_xlat0.xxx * u_xlat10.xyz;
    SV_Target0.w = u_xlat0.x;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat4.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat4.x * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat4.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat2.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat2.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat2.www + u_xlat4.xyz;
    vs_TEXCOORD2.xyz = u_xlat4.xyz * vec3(-1.0, -1.0, 1.0);
    u_xlat4.x = dot(unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz;
    vs_TEXCOORD3.xyz = u_xlat4.xyz;
    u_xlat4.x = dot(unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat0.xyz = u_xlat4.xxx * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.xyz = vec3(0.0, 0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _Color;
uniform 	float _NormalMultiplier;
uniform 	float _AngleLimit;
uniform 	mediump vec4 _LightColor0;
uniform 	float _Opacity;
uniform 	float _AddingShininess;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _ShadowMapTexture;
uniform lowp sampler2DMS _CameraNormalsTexture;
uniform lowp sampler2DMS _CameraAlbedoTexture;
uniform lowp sampler2DMS _CameraSpecularTexture;
uniform lowp sampler2DMS _CameraDepthTextureMS;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD6;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec2 u_xlat1;
mediump float u_xlat16_1;
lowp vec2 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
uvec4 u_xlatu2;
vec3 u_xlat3;
bvec3 u_xlatb3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
vec3 u_xlat9;
vec3 u_xlat10;
mediump vec3 u_xlat16_10;
bool u_xlatb10;
vec3 u_xlat11;
float u_xlat20;
mediump float u_xlat16_20;
lowp float u_xlat10_20;
bool u_xlatb20;
vec2 u_xlat21;
bool u_xlatb21;
float u_xlat30;
mediump float u_xlat16_30;
int u_xlati30;
float u_xlat31;
mediump float u_xlat16_34;
void main()
{
    u_xlat0.x = _ProjectionParams.z / vs_TEXCOORD2.z;
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat21.xy = u_xlat1.xy * _ScreenParams.xy;
    u_xlat10_1.xy = texture(_ShadowMapTexture, u_xlat1.xy).xy;
    u_xlat21.xy = floor(u_xlat21.xy);
    u_xlatu2.xy = uvec2(ivec2(u_xlat21.xy));
    u_xlatu2.z = uint(uint(0u));
    u_xlatu2.w = uint(uint(0u));
    u_xlat30 = texelFetch(_CameraDepthTextureMS, ivec2(u_xlatu2.xy), 0).x;
    u_xlat30 = _ZBufferParams.x * u_xlat30 + _ZBufferParams.y;
    u_xlat30 = float(1.0) / u_xlat30;
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    u_xlati30 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlati30 = u_xlati30 << 3;
    u_xlat3.xyz = u_xlat0.yyy * unity_Builtins0Array[u_xlati30 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati30 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati30 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz * u_xlat0.zzz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz + unity_Builtins0Array[u_xlati30 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3].xyz;
    u_xlat3.xyz = -abs(u_xlat0.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlatb3.xyz = lessThan(u_xlat3.xyzx, vec4(0.0, 0.0, 0.0, 0.0)).xyz;
    u_xlatb20 = u_xlatb3.y || u_xlatb3.x;
    u_xlatb20 = u_xlatb3.z || u_xlatb20;
    if((int(u_xlatb20) * int(0xffffffffu))!=0){discard;}
    u_xlat3.xyz = texelFetch(_CameraNormalsTexture, ivec2(u_xlatu2.xy), 0).xyz;
    u_xlat16_4.xyz = u_xlat3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_20 = dot(u_xlat16_4.xyz, vs_TEXCOORD3.xyz);
    u_xlat20 = u_xlat16_20 + (-_AngleLimit);
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(u_xlat20<0.0);
#else
    u_xlatb20 = u_xlat20<0.0;
#endif
    if((int(u_xlatb20) * int(0xffffffffu))!=0){discard;}
    u_xlat0.w = (-u_xlat0.x);
    u_xlat0.xy = vec2(u_xlat0.w + float(0.5), u_xlat0.y + float(0.5));
    u_xlat10_20 = texture(_MaskTex, u_xlat0.xy).x;
    u_xlat10_0.xyw = texture(_NormalTex, u_xlat0.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_0.xyw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_34 = u_xlat10_20 * _Opacity + -0.00100000005;
    u_xlat0.x = u_xlat10_20 * _Opacity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat16_34<0.0);
#else
    u_xlatb10 = u_xlat16_34<0.0;
#endif
    if((int(u_xlatb10) * int(0xffffffffu))!=0){discard;}
    u_xlat3.z = u_xlat16_5.z;
    u_xlat3.xy = u_xlat16_5.xy * vec2(_NormalMultiplier);
    u_xlat16_5.xyz = vs_TEXCOORD3.xyz * vs_TEXCOORD4.zxy;
    u_xlat16_5.xyz = vs_TEXCOORD3.zxy * vs_TEXCOORD4.xyz + (-u_xlat16_5.xyz);
    u_xlat16_10.xyz = u_xlat16_4.zxy * u_xlat16_5.xyz;
    u_xlat10.xyz = u_xlat16_4.yzx * u_xlat16_5.yzx + (-u_xlat16_10.xyz);
    u_xlat21.x = dot(vs_TEXCOORD4.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(u_xlat21.x));
#else
    u_xlatb21 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(u_xlat21.x);
#endif
    u_xlat16_6.xyz = (bool(u_xlatb21)) ? (-u_xlat10.yxz) : u_xlat10.yxz;
    u_xlat16_7.x = u_xlat16_6.y;
    u_xlat16_7.z = u_xlat16_4.x;
    u_xlat16_7.y = u_xlat16_5.z;
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat16_7.xyz);
    u_xlat9.z = u_xlat3.z;
    u_xlat9.xy = u_xlat3.xy;
    u_xlat16_6.y = u_xlat16_5.x;
    u_xlat16_5.x = u_xlat16_6.z;
    u_xlat16_5.z = u_xlat16_4.z;
    u_xlat8.z = dot(u_xlat9.xyz, u_xlat16_5.xyz);
    u_xlat16_6.z = u_xlat16_4.y;
    u_xlat8.y = dot(u_xlat3.xyz, u_xlat16_6.xyz);
    u_xlat10.xyz = (-u_xlat16_4.xyz) + u_xlat8.xyz;
    u_xlat10.xyz = u_xlat0.xxx * u_xlat10.xyz + u_xlat16_4.xyz;
    u_xlat21.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat21.x = inversesqrt(u_xlat21.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat21.xxx;
    u_xlat3.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21.x = inversesqrt(u_xlat21.x);
    u_xlat8.xyz = (-vs_TEXCOORD5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat31 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat8.xyz = vec3(u_xlat31) * u_xlat8.xyz;
    u_xlat16_4.xyz = u_xlat3.xyz * u_xlat21.xxx + u_xlat8.xyz;
    u_xlat16_34 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_34 = inversesqrt(u_xlat16_34);
    u_xlat16_4.xyz = vec3(u_xlat16_34) * u_xlat16_4.xyz;
    u_xlat21.x = dot(u_xlat10.xyz, u_xlat16_4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat21.x = min(max(u_xlat21.x, 0.0), 1.0);
#else
    u_xlat21.x = clamp(u_xlat21.x, 0.0, 1.0);
#endif
    u_xlat10.x = dot(u_xlat10.xyz, u_xlat8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat20 = dot(u_xlat8.xyz, u_xlat16_4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat20 = (-u_xlat20) + 1.0;
    u_xlat3.xyz = u_xlat10.xxx * _LightColor0.xyz;
    u_xlat3.xyz = u_xlat10_1.xxx * u_xlat3.xyz;
    u_xlat4 = texelFetch(_CameraSpecularTexture, ivec2(u_xlatu2.xy), 0);
    u_xlat2.xyz = texelFetch(_CameraAlbedoTexture, ivec2(u_xlatu2.xy), 0).xyz;
    u_xlat10.x = u_xlat4.w + _AddingShininess;
    u_xlat10.x = min(u_xlat10.x, 0.5);
    u_xlat16_5.x = (-u_xlat10.x) + 1.0;
    u_xlat16_10.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_30 = u_xlat16_10.x * u_xlat16_10.x;
    u_xlat16_10.x = (-u_xlat16_10.x) * u_xlat16_10.x + 1.0;
    u_xlat16_10.x = u_xlat16_10.x + u_xlat16_10.x;
    u_xlat31 = u_xlat21.x * u_xlat16_30 + (-u_xlat21.x);
    u_xlat21.x = u_xlat31 * u_xlat21.x + 1.0;
    u_xlat21.x = u_xlat21.x * u_xlat21.x;
    u_xlat21.x = max(u_xlat21.x, 9.99999997e-07);
    u_xlat30 = u_xlat16_30 / u_xlat21.x;
    u_xlat30 = u_xlat30 * 0.318309873;
    u_xlat30 = min(u_xlat30, 64.0);
    u_xlat16_5.x = u_xlat20 * u_xlat20;
    u_xlat16_5.x = u_xlat20 * u_xlat16_5.x;
    u_xlat16_5.x = u_xlat20 * u_xlat16_5.x;
    u_xlat16_5.x = u_xlat20 * u_xlat16_5.x;
    u_xlat8.xyz = (-u_xlat4.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat8.xyz = u_xlat16_5.xxx * u_xlat8.xyz;
    u_xlat8.xyz = u_xlat8.xyz * u_xlat16_10.xxx + u_xlat4.xyz;
    u_xlat9.xyz = vec3(u_xlat30) * u_xlat8.xyz;
    u_xlat10.xyz = vec3(u_xlat30) * u_xlat8.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat10.xyz = u_xlat9.xyz / u_xlat10.xyz;
    u_xlat10.xyz = u_xlat10.xyz + u_xlat10.xyz;
    u_xlat10.xyz = u_xlat10.xyz * _LightColor0.xyz;
    u_xlat10.xyz = u_xlat10_1.xxx * u_xlat10.xyz;
    u_xlat16_1 = u_xlat10_1.y + -1.0;
    u_xlat16_1 = u_xlat16_1 * 0.349999994 + 1.0;
    u_xlat10.xyz = u_xlat10.xyz * vec3(u_xlat16_1);
    u_xlat16_1 = (-u_xlat16_1) * 0.5 + 0.5;
    u_xlat16_1 = max(u_xlat16_1, 0.00100000005);
    u_xlat16_5.xyz = u_xlat2.xyz * _Color.xyz + (-u_xlat2.xyz);
    u_xlat16_5.xyz = u_xlat0.xxx * u_xlat16_5.xyz + u_xlat2.xyz;
    u_xlat11.xyz = u_xlat3.xyz * u_xlat16_5.xyz;
    u_xlat16_6.xyz = abs(u_xlat16_5.xyz) + vec3(0.00100000005, 0.00100000005, 0.00100000005);
    u_xlat16_2.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_2.xyz = vec3(u_xlat16_1) * u_xlat16_2.xyz;
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat10.xyz = u_xlat11.xyz * u_xlat16_2.xyz + u_xlat10.xyz;
    u_xlat10.xyz = vs_TEXCOORD6.xyz * u_xlat16_5.xyz + u_xlat10.xyz;
    SV_Target0.xyz = u_xlat0.xxx * u_xlat10.xyz;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "LIGHTPROBE_SH" }
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat1.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    u_xlat0.x = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * hlslcc_mtx4x4unity_ObjectToWorld[2].xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * hlslcc_mtx4x4unity_ObjectToWorld[0].xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat16_3.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_3.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_3.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD6.xyz = u_xlat16_3.xyz;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 _Color;
uniform 	float _NormalMultiplier;
uniform 	float _AngleLimit;
uniform 	mediump vec4 _LightColor0;
uniform 	float _Opacity;
uniform 	float _AddingShininess;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _CameraNormalsTexture;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _CameraAlbedoTexture;
uniform lowp sampler2D _CameraSpecularTexture;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec2 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
bvec3 u_xlatb2;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
vec3 u_xlat9;
mediump vec3 u_xlat16_9;
bool u_xlatb9;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
float u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
bool u_xlatb18;
float u_xlat19;
lowp vec2 u_xlat10_19;
bool u_xlatb19;
float u_xlat27;
mediump float u_xlat16_27;
mediump float u_xlat16_30;
mediump float u_xlat16_31;
void main()
{
    u_xlat0.x = _ProjectionParams.z / vs_TEXCOORD2.z;
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat27 = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat27 = _ZBufferParams.x * u_xlat27 + _ZBufferParams.y;
    u_xlat27 = float(1.0) / u_xlat27;
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat2.xyz = -abs(u_xlat0.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlatb2.xyz = lessThan(u_xlat2.xyzx, vec4(0.0, 0.0, 0.0, 0.0)).xyz;
    u_xlatb18 = u_xlatb2.y || u_xlatb2.x;
    u_xlatb18 = u_xlatb2.z || u_xlatb18;
    if((int(u_xlatb18) * int(0xffffffffu))!=0){discard;}
    u_xlat10_2.xyz = texture(_CameraNormalsTexture, u_xlat1.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_18 = dot(u_xlat16_3.xyz, vs_TEXCOORD3.xyz);
    u_xlat18 = u_xlat16_18 + (-_AngleLimit);
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat18<0.0);
#else
    u_xlatb18 = u_xlat18<0.0;
#endif
    if((int(u_xlatb18) * int(0xffffffffu))!=0){discard;}
    u_xlat0.w = (-u_xlat0.x);
    u_xlat0.xy = vec2(u_xlat0.w + float(0.5), u_xlat0.y + float(0.5));
    u_xlat10_18 = texture(_MaskTex, u_xlat0.xy).x;
    u_xlat10_0.xyw = texture(_NormalTex, u_xlat0.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_0.xyw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_30 = u_xlat10_18 * _Opacity + -0.00100000005;
    u_xlat0.x = u_xlat10_18 * _Opacity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat16_30<0.0);
#else
    u_xlatb9 = u_xlat16_30<0.0;
#endif
    if((int(u_xlatb9) * int(0xffffffffu))!=0){discard;}
    u_xlat2.z = u_xlat16_4.z;
    u_xlat2.xy = u_xlat16_4.xy * vec2(_NormalMultiplier);
    u_xlat16_4.xyz = vs_TEXCOORD3.xyz * vs_TEXCOORD4.zxy;
    u_xlat16_4.xyz = vs_TEXCOORD3.zxy * vs_TEXCOORD4.xyz + (-u_xlat16_4.xyz);
    u_xlat16_9.xyz = u_xlat16_3.zxy * u_xlat16_4.xyz;
    u_xlat9.xyz = u_xlat16_3.yzx * u_xlat16_4.yzx + (-u_xlat16_9.xyz);
    u_xlat19 = dot(vs_TEXCOORD4.xyz, u_xlat9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(u_xlat19));
#else
    u_xlatb19 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(u_xlat19);
#endif
    u_xlat16_5.xyz = (bool(u_xlatb19)) ? (-u_xlat9.yxz) : u_xlat9.yxz;
    u_xlat16_6.x = u_xlat16_5.y;
    u_xlat16_6.y = u_xlat16_4.z;
    u_xlat16_6.z = u_xlat16_3.x;
    u_xlat7.x = dot(u_xlat2.xyz, u_xlat16_6.xyz);
    u_xlat8.z = u_xlat2.z;
    u_xlat16_5.y = u_xlat16_4.x;
    u_xlat8.xy = u_xlat2.xy;
    u_xlat16_4.x = u_xlat16_5.z;
    u_xlat16_4.z = u_xlat16_3.z;
    u_xlat7.z = dot(u_xlat8.xyz, u_xlat16_4.xyz);
    u_xlat16_5.z = u_xlat16_3.y;
    u_xlat7.y = dot(u_xlat2.xyz, u_xlat16_5.xyz);
    u_xlat9.xyz = (-u_xlat16_3.xyz) + u_xlat7.xyz;
    u_xlat9.xyz = u_xlat0.xxx * u_xlat9.xyz + u_xlat16_3.xyz;
    u_xlat19 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat9.xyz = u_xlat9.xyz * vec3(u_xlat19);
    u_xlat2.xyz = (-vs_TEXCOORD5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat19 = dot(u_xlat9.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat7.xyz = vec3(u_xlat19) * _LightColor0.xyz;
    u_xlat10_19.xy = texture(_ShadowMapTexture, u_xlat1.xy).xy;
    u_xlat7.xyz = u_xlat10_19.xxx * u_xlat7.xyz;
    u_xlat10_8.xyz = texture(_CameraAlbedoTexture, u_xlat1.xy).xyz;
    u_xlat10_3 = texture(_CameraSpecularTexture, u_xlat1.xy);
    u_xlat16_4.xyz = u_xlat10_8.xyz * _Color.xyz + (-u_xlat10_8.xyz);
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz + u_xlat10_8.xyz;
    u_xlat7.xyz = u_xlat16_4.xyz * u_xlat7.xyz;
    u_xlat8.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat16_5.xyz = u_xlat8.xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat16_31 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_5.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat16_5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat9.x = dot(u_xlat9.xyz, u_xlat16_5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat18 = (-u_xlat1.x) + 1.0;
    u_xlat16_31 = u_xlat18 * u_xlat18;
    u_xlat16_31 = u_xlat18 * u_xlat16_31;
    u_xlat16_31 = u_xlat18 * u_xlat16_31;
    u_xlat16_31 = u_xlat18 * u_xlat16_31;
    u_xlat16_2.xyz = (-u_xlat10_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = vec3(u_xlat16_31) * u_xlat16_2.xyz;
    u_xlat18 = u_xlat10_3.w + _AddingShininess;
    u_xlat18 = min(u_xlat18, 0.5);
    u_xlat16_31 = (-u_xlat18) + 1.0;
    u_xlat16_18 = u_xlat16_31 * u_xlat16_31;
    u_xlat16_27 = (-u_xlat16_18) * u_xlat16_18 + 1.0;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_27 = u_xlat16_27 + u_xlat16_27;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_27) + u_xlat10_3.xyz;
    u_xlat27 = u_xlat9.x * u_xlat16_18 + (-u_xlat9.x);
    u_xlat9.x = u_xlat27 * u_xlat9.x + 1.0;
    u_xlat9.x = u_xlat9.x * u_xlat9.x;
    u_xlat9.x = max(u_xlat9.x, 9.99999997e-07);
    u_xlat9.x = u_xlat16_18 / u_xlat9.x;
    u_xlat9.x = u_xlat9.x * 0.318309873;
    u_xlat9.x = min(u_xlat9.x, 64.0);
    u_xlat8.xyz = u_xlat16_2.xyz * u_xlat9.xxx;
    u_xlat9.xyz = u_xlat9.xxx * u_xlat16_2.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat9.xyz = u_xlat8.xyz / u_xlat9.xyz;
    u_xlat9.xyz = u_xlat9.xyz + u_xlat9.xyz;
    u_xlat9.xyz = u_xlat9.xyz * _LightColor0.xyz;
    u_xlat9.xyz = u_xlat10_19.xxx * u_xlat9.xyz;
    u_xlat16_1.x = u_xlat10_19.y + -1.0;
    u_xlat16_1.x = u_xlat16_1.x * 0.349999994 + 1.0;
    u_xlat9.xyz = u_xlat9.xyz * u_xlat16_1.xxx;
    u_xlat16_5.xyz = abs(u_xlat16_4.xyz) + vec3(0.00100000005, 0.00100000005, 0.00100000005);
    u_xlat16_10.xyz = log2(u_xlat16_5.xyz);
    u_xlat16_2.x = (-u_xlat16_1.x) * 0.5 + 0.5;
    u_xlat11.xyz = u_xlat16_1.xxx * vs_TEXCOORD6.xyz;
    u_xlat16_1.x = max(u_xlat16_2.x, 0.00100000005);
    u_xlat16_1.xyz = u_xlat16_10.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat9.xyz = u_xlat7.xyz * u_xlat16_1.xyz + u_xlat9.xyz;
    u_xlat9.xyz = u_xlat11.xyz * u_xlat16_4.xyz + u_xlat9.xyz;
    SV_Target0.xyz = u_xlat0.xxx * u_xlat9.xyz;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "LIGHTPROBE_SH" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
mediump vec4 u_xlat16_0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat6.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat6.x * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat6.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat2.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat2.zzz + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat2.www + u_xlat6.xyz;
    vs_TEXCOORD2.xyz = u_xlat6.xyz * vec3(-1.0, -1.0, 1.0);
    u_xlat6.x = dot(unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz;
    vs_TEXCOORD3.xyz = u_xlat6.xyz;
    u_xlat1.x = dot(unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat16_4.x = u_xlat6.y * u_xlat6.y;
    u_xlat16_4.x = u_xlat6.x * u_xlat6.x + (-u_xlat16_4.x);
    u_xlat16_0 = u_xlat6.yzzx * u_xlat6.xyzz;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_5.xyz;
    vs_TEXCOORD6.xyz = u_xlat16_4.xyz;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _Color;
uniform 	float _NormalMultiplier;
uniform 	float _AngleLimit;
uniform 	mediump vec4 _LightColor0;
uniform 	float _Opacity;
uniform 	float _AddingShininess;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _CameraNormalsTexture;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _CameraAlbedoTexture;
uniform lowp sampler2D _CameraSpecularTexture;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD6;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec2 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
bvec3 u_xlatb2;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
mediump vec3 u_xlat16_8;
lowp vec3 u_xlat10_8;
vec3 u_xlat9;
vec3 u_xlat10;
mediump vec3 u_xlat16_10;
bool u_xlatb10;
mediump vec3 u_xlat16_11;
float u_xlat20;
mediump float u_xlat16_20;
lowp float u_xlat10_20;
bool u_xlatb20;
float u_xlat21;
lowp vec2 u_xlat10_21;
bool u_xlatb21;
float u_xlat30;
mediump float u_xlat16_30;
int u_xlati30;
mediump float u_xlat16_33;
mediump float u_xlat16_34;
mediump float u_xlat16_37;
void main()
{
    u_xlat0.x = _ProjectionParams.z / vs_TEXCOORD2.z;
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat30 = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat30 = _ZBufferParams.x * u_xlat30 + _ZBufferParams.y;
    u_xlat30 = float(1.0) / u_xlat30;
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    u_xlati30 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlati30 = u_xlati30 << 3;
    u_xlat2.xyz = u_xlat0.yyy * unity_Builtins0Array[u_xlati30 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati30 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati30 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz + unity_Builtins0Array[u_xlati30 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3].xyz;
    u_xlat2.xyz = -abs(u_xlat0.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlatb2.xyz = lessThan(u_xlat2.xyzx, vec4(0.0, 0.0, 0.0, 0.0)).xyz;
    u_xlatb20 = u_xlatb2.y || u_xlatb2.x;
    u_xlatb20 = u_xlatb2.z || u_xlatb20;
    if((int(u_xlatb20) * int(0xffffffffu))!=0){discard;}
    u_xlat10_2.xyz = texture(_CameraNormalsTexture, u_xlat1.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_20 = dot(u_xlat16_3.xyz, vs_TEXCOORD3.xyz);
    u_xlat20 = u_xlat16_20 + (-_AngleLimit);
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(u_xlat20<0.0);
#else
    u_xlatb20 = u_xlat20<0.0;
#endif
    if((int(u_xlatb20) * int(0xffffffffu))!=0){discard;}
    u_xlat0.w = (-u_xlat0.x);
    u_xlat0.xy = vec2(u_xlat0.w + float(0.5), u_xlat0.y + float(0.5));
    u_xlat10_20 = texture(_MaskTex, u_xlat0.xy).x;
    u_xlat10_0.xyw = texture(_NormalTex, u_xlat0.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_0.xyw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_33 = u_xlat10_20 * _Opacity + -0.00100000005;
    u_xlat0.x = u_xlat10_20 * _Opacity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat16_33<0.0);
#else
    u_xlatb10 = u_xlat16_33<0.0;
#endif
    if((int(u_xlatb10) * int(0xffffffffu))!=0){discard;}
    u_xlat2.z = u_xlat16_4.z;
    u_xlat2.xy = u_xlat16_4.xy * vec2(_NormalMultiplier);
    u_xlat16_4.xyz = vs_TEXCOORD3.xyz * vs_TEXCOORD4.zxy;
    u_xlat16_4.xyz = vs_TEXCOORD3.zxy * vs_TEXCOORD4.xyz + (-u_xlat16_4.xyz);
    u_xlat16_10.xyz = u_xlat16_3.zxy * u_xlat16_4.xyz;
    u_xlat10.xyz = u_xlat16_3.yzx * u_xlat16_4.yzx + (-u_xlat16_10.xyz);
    u_xlat21 = dot(vs_TEXCOORD4.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(u_xlat21));
#else
    u_xlatb21 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(u_xlat21);
#endif
    u_xlat16_5.xyz = (bool(u_xlatb21)) ? (-u_xlat10.yxz) : u_xlat10.yxz;
    u_xlat16_6.x = u_xlat16_5.y;
    u_xlat16_6.y = u_xlat16_4.z;
    u_xlat16_6.z = u_xlat16_3.x;
    u_xlat7.x = dot(u_xlat2.xyz, u_xlat16_6.xyz);
    u_xlat8.z = u_xlat2.z;
    u_xlat8.xy = u_xlat2.xy;
    u_xlat16_5.y = u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_5.z;
    u_xlat16_4.z = u_xlat16_3.z;
    u_xlat7.z = dot(u_xlat8.xyz, u_xlat16_4.xyz);
    u_xlat16_5.z = u_xlat16_3.y;
    u_xlat7.y = dot(u_xlat2.xyz, u_xlat16_5.xyz);
    u_xlat10.xyz = (-u_xlat16_3.xyz) + u_xlat7.xyz;
    u_xlat10.xyz = u_xlat0.xxx * u_xlat10.xyz + u_xlat16_3.xyz;
    u_xlat21 = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = u_xlat10.xyz * vec3(u_xlat21);
    u_xlat10.xyz = (-vs_TEXCOORD5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat21 = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat10.xyz = u_xlat10.xyz * vec3(u_xlat21);
    u_xlat21 = dot(u_xlat2.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat7.xyz = vec3(u_xlat21) * _LightColor0.xyz;
    u_xlat10_21.xy = texture(_ShadowMapTexture, u_xlat1.xy).xy;
    u_xlat7.xyz = u_xlat10_21.xxx * u_xlat7.xyz;
    u_xlat10_8.xyz = texture(_CameraAlbedoTexture, u_xlat1.xy).xyz;
    u_xlat10_3 = texture(_CameraSpecularTexture, u_xlat1.xy);
    u_xlat16_4.xyz = u_xlat10_8.xyz * _Color.xyz + (-u_xlat10_8.xyz);
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz + u_xlat10_8.xyz;
    u_xlat7.xyz = u_xlat16_4.xyz * u_xlat7.xyz;
    u_xlat8.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat16_5.xyz = u_xlat8.xyz * u_xlat1.xxx + u_xlat10.xyz;
    u_xlat16_34 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_34 = inversesqrt(u_xlat16_34);
    u_xlat16_5.xyz = vec3(u_xlat16_34) * u_xlat16_5.xyz;
    u_xlat10.x = dot(u_xlat10.xyz, u_xlat16_5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat20 = dot(u_xlat2.xyz, u_xlat16_5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat10.x = (-u_xlat10.x) + 1.0;
    u_xlat16_34 = u_xlat10.x * u_xlat10.x;
    u_xlat16_34 = u_xlat10.x * u_xlat16_34;
    u_xlat16_34 = u_xlat10.x * u_xlat16_34;
    u_xlat16_34 = u_xlat10.x * u_xlat16_34;
    u_xlat16_8.xyz = (-u_xlat10_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_8.xyz = vec3(u_xlat16_34) * u_xlat16_8.xyz;
    u_xlat10.x = u_xlat10_3.w + _AddingShininess;
    u_xlat10.x = min(u_xlat10.x, 0.5);
    u_xlat16_34 = (-u_xlat10.x) + 1.0;
    u_xlat16_10.x = u_xlat16_34 * u_xlat16_34;
    u_xlat16_30 = (-u_xlat16_10.x) * u_xlat16_10.x + 1.0;
    u_xlat16_10.x = u_xlat16_10.x * u_xlat16_10.x;
    u_xlat16_30 = u_xlat16_30 + u_xlat16_30;
    u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(u_xlat16_30) + u_xlat10_3.xyz;
    u_xlat30 = u_xlat20 * u_xlat16_10.x + (-u_xlat20);
    u_xlat20 = u_xlat30 * u_xlat20 + 1.0;
    u_xlat20 = u_xlat20 * u_xlat20;
    u_xlat20 = max(u_xlat20, 9.99999997e-07);
    u_xlat10.x = u_xlat16_10.x / u_xlat20;
    u_xlat10.x = u_xlat10.x * 0.318309873;
    u_xlat10.x = min(u_xlat10.x, 64.0);
    u_xlat9.xyz = u_xlat16_8.xyz * u_xlat10.xxx;
    u_xlat10.xyz = u_xlat10.xxx * u_xlat16_8.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat10.xyz = u_xlat9.xyz / u_xlat10.xyz;
    u_xlat10.xyz = u_xlat10.xyz + u_xlat10.xyz;
    u_xlat10.xyz = u_xlat10.xyz * _LightColor0.xyz;
    u_xlat10.xyz = u_xlat10_21.xxx * u_xlat10.xyz;
    u_xlat16_1.x = u_xlat10_21.y + -1.0;
    u_xlat16_1.x = u_xlat16_1.x * 0.349999994 + 1.0;
    u_xlat10.xyz = u_xlat10.xyz * u_xlat16_1.xxx;
    u_xlat16_5.xyz = abs(u_xlat16_4.xyz) + vec3(0.00100000005, 0.00100000005, 0.00100000005);
    u_xlat16_11.xyz = log2(u_xlat16_5.xyz);
    u_xlat16_37 = (-u_xlat16_1.x) * 0.5 + 0.5;
    u_xlat16_37 = max(u_xlat16_37, 0.00100000005);
    u_xlat16_11.xyz = u_xlat16_11.xyz * vec3(u_xlat16_37);
    u_xlat16_11.xyz = exp2(u_xlat16_11.xyz);
    u_xlat10.xyz = u_xlat7.xyz * u_xlat16_11.xyz + u_xlat10.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_5.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_5.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_5.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_5.xyz = u_xlat16_5.xyz + vs_TEXCOORD6.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz;
    u_xlat10.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz + u_xlat10.xyz;
    SV_Target0.xyz = u_xlat0.xxx * u_xlat10.xyz;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "LIGHTPROBE_SH" "MSAA_INTERPOLATION" }
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat1.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    u_xlat0.x = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * hlslcc_mtx4x4unity_ObjectToWorld[2].xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * hlslcc_mtx4x4unity_ObjectToWorld[0].xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat16_3.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_3.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_3.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD6.xyz = u_xlat16_3.xyz;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 _Color;
uniform 	float _NormalMultiplier;
uniform 	float _AngleLimit;
uniform 	mediump vec4 _LightColor0;
uniform 	float _Opacity;
uniform 	float _AddingShininess;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _ShadowMapTexture;
uniform lowp sampler2DMS _CameraNormalsTexture;
uniform lowp sampler2DMS _CameraAlbedoTexture;
uniform lowp sampler2DMS _CameraSpecularTexture;
uniform lowp sampler2DMS _CameraDepthTextureMS;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec2 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec2 u_xlat10_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
uvec4 u_xlatu2;
vec3 u_xlat3;
bvec3 u_xlatb3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
vec3 u_xlat9;
vec3 u_xlat10;
mediump vec3 u_xlat16_10;
bool u_xlatb10;
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
float u_xlat20;
mediump float u_xlat16_20;
lowp float u_xlat10_20;
bool u_xlatb20;
vec2 u_xlat21;
bool u_xlatb21;
float u_xlat30;
mediump float u_xlat16_30;
mediump float u_xlat16_34;
void main()
{
    u_xlat0.x = _ProjectionParams.z / vs_TEXCOORD2.z;
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat21.xy = u_xlat1.xy * _ScreenParams.xy;
    u_xlat10_1.xy = texture(_ShadowMapTexture, u_xlat1.xy).xy;
    u_xlat21.xy = floor(u_xlat21.xy);
    u_xlatu2.xy = uvec2(ivec2(u_xlat21.xy));
    u_xlatu2.z = uint(uint(0u));
    u_xlatu2.w = uint(uint(0u));
    u_xlat30 = texelFetch(_CameraDepthTextureMS, ivec2(u_xlatu2.xy), 0).x;
    u_xlat30 = _ZBufferParams.x * u_xlat30 + _ZBufferParams.y;
    u_xlat30 = float(1.0) / u_xlat30;
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat3.xyz = -abs(u_xlat0.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlatb3.xyz = lessThan(u_xlat3.xyzx, vec4(0.0, 0.0, 0.0, 0.0)).xyz;
    u_xlatb20 = u_xlatb3.y || u_xlatb3.x;
    u_xlatb20 = u_xlatb3.z || u_xlatb20;
    if((int(u_xlatb20) * int(0xffffffffu))!=0){discard;}
    u_xlat3.xyz = texelFetch(_CameraNormalsTexture, ivec2(u_xlatu2.xy), 0).xyz;
    u_xlat16_4.xyz = u_xlat3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_20 = dot(u_xlat16_4.xyz, vs_TEXCOORD3.xyz);
    u_xlat20 = u_xlat16_20 + (-_AngleLimit);
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(u_xlat20<0.0);
#else
    u_xlatb20 = u_xlat20<0.0;
#endif
    if((int(u_xlatb20) * int(0xffffffffu))!=0){discard;}
    u_xlat0.w = (-u_xlat0.x);
    u_xlat0.xy = vec2(u_xlat0.w + float(0.5), u_xlat0.y + float(0.5));
    u_xlat10_20 = texture(_MaskTex, u_xlat0.xy).x;
    u_xlat10_0.xyw = texture(_NormalTex, u_xlat0.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_0.xyw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_34 = u_xlat10_20 * _Opacity + -0.00100000005;
    u_xlat0.x = u_xlat10_20 * _Opacity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat16_34<0.0);
#else
    u_xlatb10 = u_xlat16_34<0.0;
#endif
    if((int(u_xlatb10) * int(0xffffffffu))!=0){discard;}
    u_xlat3.z = u_xlat16_5.z;
    u_xlat3.xy = u_xlat16_5.xy * vec2(_NormalMultiplier);
    u_xlat16_5.xyz = vs_TEXCOORD3.xyz * vs_TEXCOORD4.zxy;
    u_xlat16_5.xyz = vs_TEXCOORD3.zxy * vs_TEXCOORD4.xyz + (-u_xlat16_5.xyz);
    u_xlat16_10.xyz = u_xlat16_4.zxy * u_xlat16_5.xyz;
    u_xlat10.xyz = u_xlat16_4.yzx * u_xlat16_5.yzx + (-u_xlat16_10.xyz);
    u_xlat21.x = dot(vs_TEXCOORD4.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(u_xlat21.x));
#else
    u_xlatb21 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(u_xlat21.x);
#endif
    u_xlat16_6.xyz = (bool(u_xlatb21)) ? (-u_xlat10.yxz) : u_xlat10.yxz;
    u_xlat16_7.x = u_xlat16_6.y;
    u_xlat16_7.z = u_xlat16_4.x;
    u_xlat16_7.y = u_xlat16_5.z;
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat16_7.xyz);
    u_xlat9.z = u_xlat3.z;
    u_xlat16_6.y = u_xlat16_5.x;
    u_xlat9.xy = u_xlat3.xy;
    u_xlat16_5.x = u_xlat16_6.z;
    u_xlat16_5.z = u_xlat16_4.z;
    u_xlat8.z = dot(u_xlat9.xyz, u_xlat16_5.xyz);
    u_xlat16_6.z = u_xlat16_4.y;
    u_xlat8.y = dot(u_xlat3.xyz, u_xlat16_6.xyz);
    u_xlat10.xyz = (-u_xlat16_4.xyz) + u_xlat8.xyz;
    u_xlat10.xyz = u_xlat0.xxx * u_xlat10.xyz + u_xlat16_4.xyz;
    u_xlat21.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat21.x = inversesqrt(u_xlat21.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat21.xxx;
    u_xlat3.xyz = (-vs_TEXCOORD5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat21.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21.x = inversesqrt(u_xlat21.x);
    u_xlat3.xyz = u_xlat21.xxx * u_xlat3.xyz;
    u_xlat21.x = dot(u_xlat10.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat21.x = min(max(u_xlat21.x, 0.0), 1.0);
#else
    u_xlat21.x = clamp(u_xlat21.x, 0.0, 1.0);
#endif
    u_xlat8.xyz = u_xlat21.xxx * _LightColor0.xyz;
    u_xlat8.xyz = u_xlat10_1.xxx * u_xlat8.xyz;
    u_xlat9.xyz = texelFetch(_CameraAlbedoTexture, ivec2(u_xlatu2.xy), 0).xyz;
    u_xlat2 = texelFetch(_CameraSpecularTexture, ivec2(u_xlatu2.xy), 0);
    u_xlat16_4.xyz = u_xlat9.xyz * _Color.xyz + (-u_xlat9.xyz);
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz + u_xlat9.xyz;
    u_xlat8.xyz = u_xlat16_4.xyz * u_xlat8.xyz;
    u_xlat9.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21.x = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat21.x = inversesqrt(u_xlat21.x);
    u_xlat16_5.xyz = u_xlat9.xyz * u_xlat21.xxx + u_xlat3.xyz;
    u_xlat16_34 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_34 = inversesqrt(u_xlat16_34);
    u_xlat16_5.xyz = vec3(u_xlat16_34) * u_xlat16_5.xyz;
    u_xlat21.x = dot(u_xlat3.xyz, u_xlat16_5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat21.x = min(max(u_xlat21.x, 0.0), 1.0);
#else
    u_xlat21.x = clamp(u_xlat21.x, 0.0, 1.0);
#endif
    u_xlat10.x = dot(u_xlat10.xyz, u_xlat16_5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat20 = (-u_xlat21.x) + 1.0;
    u_xlat16_34 = u_xlat20 * u_xlat20;
    u_xlat16_34 = u_xlat20 * u_xlat16_34;
    u_xlat16_34 = u_xlat20 * u_xlat16_34;
    u_xlat16_34 = u_xlat20 * u_xlat16_34;
    u_xlat3.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat3.xyz = vec3(u_xlat16_34) * u_xlat3.xyz;
    u_xlat20 = u_xlat2.w + _AddingShininess;
    u_xlat20 = min(u_xlat20, 0.5);
    u_xlat16_34 = (-u_xlat20) + 1.0;
    u_xlat16_20 = u_xlat16_34 * u_xlat16_34;
    u_xlat16_30 = (-u_xlat16_20) * u_xlat16_20 + 1.0;
    u_xlat16_20 = u_xlat16_20 * u_xlat16_20;
    u_xlat16_30 = u_xlat16_30 + u_xlat16_30;
    u_xlat2.xyz = u_xlat3.xyz * vec3(u_xlat16_30) + u_xlat2.xyz;
    u_xlat30 = u_xlat10.x * u_xlat16_20 + (-u_xlat10.x);
    u_xlat10.x = u_xlat30 * u_xlat10.x + 1.0;
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat10.x = max(u_xlat10.x, 9.99999997e-07);
    u_xlat10.x = u_xlat16_20 / u_xlat10.x;
    u_xlat10.x = u_xlat10.x * 0.318309873;
    u_xlat10.x = min(u_xlat10.x, 64.0);
    u_xlat3.xyz = u_xlat2.xyz * u_xlat10.xxx;
    u_xlat10.xyz = u_xlat10.xxx * u_xlat2.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat10.xyz = u_xlat3.xyz / u_xlat10.xyz;
    u_xlat10.xyz = u_xlat10.xyz + u_xlat10.xyz;
    u_xlat10.xyz = u_xlat10.xyz * _LightColor0.xyz;
    u_xlat10.xyz = u_xlat10_1.xxx * u_xlat10.xyz;
    u_xlat16_1.x = u_xlat10_1.y + -1.0;
    u_xlat16_1.x = u_xlat16_1.x * 0.349999994 + 1.0;
    u_xlat10.xyz = u_xlat10.xyz * u_xlat16_1.xxx;
    u_xlat16_5.xyz = abs(u_xlat16_4.xyz) + vec3(0.00100000005, 0.00100000005, 0.00100000005);
    u_xlat16_11.xyz = log2(u_xlat16_5.xyz);
    u_xlat16_2 = (-u_xlat16_1.x) * 0.5 + 0.5;
    u_xlat12.xyz = u_xlat16_1.xxx * vs_TEXCOORD6.xyz;
    u_xlat16_1.x = max(u_xlat16_2, 0.00100000005);
    u_xlat16_1.xyz = u_xlat16_11.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat10.xyz = u_xlat8.xyz * u_xlat16_1.xyz + u_xlat10.xyz;
    u_xlat10.xyz = u_xlat12.xyz * u_xlat16_4.xyz + u_xlat10.xyz;
    SV_Target0.xyz = u_xlat0.xxx * u_xlat10.xyz;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "LIGHTPROBE_SH" "INSTANCING_ON" "MSAA_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
mediump vec4 u_xlat16_0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat6.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat6.x * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat6.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat2.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat2.zzz + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat2.www + u_xlat6.xyz;
    vs_TEXCOORD2.xyz = u_xlat6.xyz * vec3(-1.0, -1.0, 1.0);
    u_xlat6.x = dot(unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz;
    vs_TEXCOORD3.xyz = u_xlat6.xyz;
    u_xlat1.x = dot(unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat16_4.x = u_xlat6.y * u_xlat6.y;
    u_xlat16_4.x = u_xlat6.x * u_xlat6.x + (-u_xlat16_4.x);
    u_xlat16_0 = u_xlat6.yzzx * u_xlat6.xyzz;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_5.xyz;
    vs_TEXCOORD6.xyz = u_xlat16_4.xyz;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _Color;
uniform 	float _NormalMultiplier;
uniform 	float _AngleLimit;
uniform 	mediump vec4 _LightColor0;
uniform 	float _Opacity;
uniform 	float _AddingShininess;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _ShadowMapTexture;
uniform lowp sampler2DMS _CameraNormalsTexture;
uniform lowp sampler2DMS _CameraAlbedoTexture;
uniform lowp sampler2DMS _CameraSpecularTexture;
uniform lowp sampler2DMS _CameraDepthTextureMS;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD6;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec2 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec2 u_xlat10_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
uvec4 u_xlatu2;
vec4 u_xlat3;
bvec3 u_xlatb3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
vec3 u_xlat9;
vec3 u_xlat10;
mediump vec3 u_xlat16_10;
bool u_xlatb10;
mediump vec3 u_xlat16_11;
float u_xlat20;
mediump float u_xlat16_20;
lowp float u_xlat10_20;
bool u_xlatb20;
vec2 u_xlat21;
bool u_xlatb21;
float u_xlat30;
mediump float u_xlat16_30;
int u_xlati30;
mediump float u_xlat16_34;
void main()
{
    u_xlat0.x = _ProjectionParams.z / vs_TEXCOORD2.z;
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat21.xy = u_xlat1.xy * _ScreenParams.xy;
    u_xlat10_1.xy = texture(_ShadowMapTexture, u_xlat1.xy).xy;
    u_xlat21.xy = floor(u_xlat21.xy);
    u_xlatu2.xy = uvec2(ivec2(u_xlat21.xy));
    u_xlatu2.z = uint(uint(0u));
    u_xlatu2.w = uint(uint(0u));
    u_xlat30 = texelFetch(_CameraDepthTextureMS, ivec2(u_xlatu2.xy), 0).x;
    u_xlat30 = _ZBufferParams.x * u_xlat30 + _ZBufferParams.y;
    u_xlat30 = float(1.0) / u_xlat30;
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    u_xlati30 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlati30 = u_xlati30 << 3;
    u_xlat3.xyz = u_xlat0.yyy * unity_Builtins0Array[u_xlati30 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati30 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati30 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz * u_xlat0.zzz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz + unity_Builtins0Array[u_xlati30 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3].xyz;
    u_xlat3.xyz = -abs(u_xlat0.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlatb3.xyz = lessThan(u_xlat3.xyzx, vec4(0.0, 0.0, 0.0, 0.0)).xyz;
    u_xlatb20 = u_xlatb3.y || u_xlatb3.x;
    u_xlatb20 = u_xlatb3.z || u_xlatb20;
    if((int(u_xlatb20) * int(0xffffffffu))!=0){discard;}
    u_xlat3.xyz = texelFetch(_CameraNormalsTexture, ivec2(u_xlatu2.xy), 0).xyz;
    u_xlat16_4.xyz = u_xlat3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_20 = dot(u_xlat16_4.xyz, vs_TEXCOORD3.xyz);
    u_xlat20 = u_xlat16_20 + (-_AngleLimit);
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(u_xlat20<0.0);
#else
    u_xlatb20 = u_xlat20<0.0;
#endif
    if((int(u_xlatb20) * int(0xffffffffu))!=0){discard;}
    u_xlat0.w = (-u_xlat0.x);
    u_xlat0.xy = vec2(u_xlat0.w + float(0.5), u_xlat0.y + float(0.5));
    u_xlat10_20 = texture(_MaskTex, u_xlat0.xy).x;
    u_xlat10_0.xyw = texture(_NormalTex, u_xlat0.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_0.xyw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_34 = u_xlat10_20 * _Opacity + -0.00100000005;
    u_xlat0.x = u_xlat10_20 * _Opacity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat16_34<0.0);
#else
    u_xlatb10 = u_xlat16_34<0.0;
#endif
    if((int(u_xlatb10) * int(0xffffffffu))!=0){discard;}
    u_xlat3.z = u_xlat16_5.z;
    u_xlat3.xy = u_xlat16_5.xy * vec2(_NormalMultiplier);
    u_xlat16_5.xyz = vs_TEXCOORD3.xyz * vs_TEXCOORD4.zxy;
    u_xlat16_5.xyz = vs_TEXCOORD3.zxy * vs_TEXCOORD4.xyz + (-u_xlat16_5.xyz);
    u_xlat16_10.xyz = u_xlat16_4.zxy * u_xlat16_5.xyz;
    u_xlat10.xyz = u_xlat16_4.yzx * u_xlat16_5.yzx + (-u_xlat16_10.xyz);
    u_xlat21.x = dot(vs_TEXCOORD4.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(u_xlat21.x));
#else
    u_xlatb21 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(u_xlat21.x);
#endif
    u_xlat16_6.xyz = (bool(u_xlatb21)) ? (-u_xlat10.yxz) : u_xlat10.yxz;
    u_xlat16_7.x = u_xlat16_6.y;
    u_xlat16_7.z = u_xlat16_4.x;
    u_xlat16_7.y = u_xlat16_5.z;
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat16_7.xyz);
    u_xlat9.z = u_xlat3.z;
    u_xlat9.xy = u_xlat3.xy;
    u_xlat16_6.y = u_xlat16_5.x;
    u_xlat16_5.x = u_xlat16_6.z;
    u_xlat16_5.z = u_xlat16_4.z;
    u_xlat8.z = dot(u_xlat9.xyz, u_xlat16_5.xyz);
    u_xlat16_6.z = u_xlat16_4.y;
    u_xlat8.y = dot(u_xlat3.xyz, u_xlat16_6.xyz);
    u_xlat10.xyz = (-u_xlat16_4.xyz) + u_xlat8.xyz;
    u_xlat10.xyz = u_xlat0.xxx * u_xlat10.xyz + u_xlat16_4.xyz;
    u_xlat21.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat21.x = inversesqrt(u_xlat21.x);
    u_xlat3.xyz = u_xlat10.xyz * u_xlat21.xxx;
    u_xlat10.xyz = (-vs_TEXCOORD5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat21.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat21.x = inversesqrt(u_xlat21.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat21.xxx;
    u_xlat21.x = dot(u_xlat3.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat21.x = min(max(u_xlat21.x, 0.0), 1.0);
#else
    u_xlat21.x = clamp(u_xlat21.x, 0.0, 1.0);
#endif
    u_xlat8.xyz = u_xlat21.xxx * _LightColor0.xyz;
    u_xlat8.xyz = u_xlat10_1.xxx * u_xlat8.xyz;
    u_xlat9.xyz = texelFetch(_CameraAlbedoTexture, ivec2(u_xlatu2.xy), 0).xyz;
    u_xlat2 = texelFetch(_CameraSpecularTexture, ivec2(u_xlatu2.xy), 0);
    u_xlat16_4.xyz = u_xlat9.xyz * _Color.xyz + (-u_xlat9.xyz);
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz + u_xlat9.xyz;
    u_xlat8.xyz = u_xlat16_4.xyz * u_xlat8.xyz;
    u_xlat9.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21.x = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat21.x = inversesqrt(u_xlat21.x);
    u_xlat16_5.xyz = u_xlat9.xyz * u_xlat21.xxx + u_xlat10.xyz;
    u_xlat16_34 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_34 = inversesqrt(u_xlat16_34);
    u_xlat16_5.xyz = vec3(u_xlat16_34) * u_xlat16_5.xyz;
    u_xlat10.x = dot(u_xlat10.xyz, u_xlat16_5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat20 = dot(u_xlat3.xyz, u_xlat16_5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat10.x = (-u_xlat10.x) + 1.0;
    u_xlat16_34 = u_xlat10.x * u_xlat10.x;
    u_xlat16_34 = u_xlat10.x * u_xlat16_34;
    u_xlat16_34 = u_xlat10.x * u_xlat16_34;
    u_xlat16_34 = u_xlat10.x * u_xlat16_34;
    u_xlat9.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat9.xyz = vec3(u_xlat16_34) * u_xlat9.xyz;
    u_xlat10.x = u_xlat2.w + _AddingShininess;
    u_xlat10.x = min(u_xlat10.x, 0.5);
    u_xlat16_34 = (-u_xlat10.x) + 1.0;
    u_xlat16_10.x = u_xlat16_34 * u_xlat16_34;
    u_xlat16_30 = (-u_xlat16_10.x) * u_xlat16_10.x + 1.0;
    u_xlat16_10.x = u_xlat16_10.x * u_xlat16_10.x;
    u_xlat16_30 = u_xlat16_30 + u_xlat16_30;
    u_xlat2.xyz = u_xlat9.xyz * vec3(u_xlat16_30) + u_xlat2.xyz;
    u_xlat30 = u_xlat20 * u_xlat16_10.x + (-u_xlat20);
    u_xlat20 = u_xlat30 * u_xlat20 + 1.0;
    u_xlat20 = u_xlat20 * u_xlat20;
    u_xlat20 = max(u_xlat20, 9.99999997e-07);
    u_xlat10.x = u_xlat16_10.x / u_xlat20;
    u_xlat10.x = u_xlat10.x * 0.318309873;
    u_xlat10.x = min(u_xlat10.x, 64.0);
    u_xlat9.xyz = u_xlat2.xyz * u_xlat10.xxx;
    u_xlat10.xyz = u_xlat10.xxx * u_xlat2.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat10.xyz = u_xlat9.xyz / u_xlat10.xyz;
    u_xlat10.xyz = u_xlat10.xyz + u_xlat10.xyz;
    u_xlat10.xyz = u_xlat10.xyz * _LightColor0.xyz;
    u_xlat10.xyz = u_xlat10_1.xxx * u_xlat10.xyz;
    u_xlat16_1.x = u_xlat10_1.y + -1.0;
    u_xlat16_1.x = u_xlat16_1.x * 0.349999994 + 1.0;
    u_xlat10.xyz = u_xlat10.xyz * u_xlat16_1.xxx;
    u_xlat16_5.xyz = abs(u_xlat16_4.xyz) + vec3(0.00100000005, 0.00100000005, 0.00100000005);
    u_xlat16_11.xyz = log2(u_xlat16_5.xyz);
    u_xlat16_2 = (-u_xlat16_1.x) * 0.5 + 0.5;
    u_xlat16_2 = max(u_xlat16_2, 0.00100000005);
    u_xlat16_11.xyz = u_xlat16_11.xyz * vec3(u_xlat16_2);
    u_xlat16_11.xyz = exp2(u_xlat16_11.xyz);
    u_xlat10.xyz = u_xlat8.xyz * u_xlat16_11.xyz + u_xlat10.xyz;
    u_xlat3.w = 1.0;
    u_xlat16_5.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_5.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_5.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_5.xyz = u_xlat16_5.xyz + vs_TEXCOORD6.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz;
    u_xlat10.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz + u_xlat10.xyz;
    SV_Target0.xyz = u_xlat0.xxx * u_xlat10.xyz;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_HDR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat1.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    u_xlat0.x = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * hlslcc_mtx4x4unity_ObjectToWorld[2].xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * hlslcc_mtx4x4unity_ObjectToWorld[0].xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 _Color;
uniform 	float _NormalMultiplier;
uniform 	float _AngleLimit;
uniform 	mediump vec4 _LightColor0;
uniform 	float _Opacity;
uniform 	float _AddingShininess;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _CameraNormalsTexture;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _CameraAlbedoTexture;
uniform lowp sampler2D _CameraSpecularTexture;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec2 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
bvec3 u_xlatb2;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
vec3 u_xlat9;
mediump vec3 u_xlat16_9;
bool u_xlatb9;
mediump vec3 u_xlat16_10;
float u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
bool u_xlatb18;
float u_xlat19;
lowp vec2 u_xlat10_19;
bool u_xlatb19;
float u_xlat27;
mediump float u_xlat16_27;
mediump float u_xlat16_30;
mediump float u_xlat16_31;
void main()
{
    u_xlat0.x = _ProjectionParams.z / vs_TEXCOORD2.z;
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat27 = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat27 = _ZBufferParams.x * u_xlat27 + _ZBufferParams.y;
    u_xlat27 = float(1.0) / u_xlat27;
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat2.xyz = -abs(u_xlat0.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlatb2.xyz = lessThan(u_xlat2.xyzx, vec4(0.0, 0.0, 0.0, 0.0)).xyz;
    u_xlatb18 = u_xlatb2.y || u_xlatb2.x;
    u_xlatb18 = u_xlatb2.z || u_xlatb18;
    if((int(u_xlatb18) * int(0xffffffffu))!=0){discard;}
    u_xlat10_2.xyz = texture(_CameraNormalsTexture, u_xlat1.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_18 = dot(u_xlat16_3.xyz, vs_TEXCOORD3.xyz);
    u_xlat18 = u_xlat16_18 + (-_AngleLimit);
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat18<0.0);
#else
    u_xlatb18 = u_xlat18<0.0;
#endif
    if((int(u_xlatb18) * int(0xffffffffu))!=0){discard;}
    u_xlat0.w = (-u_xlat0.x);
    u_xlat0.xy = vec2(u_xlat0.w + float(0.5), u_xlat0.y + float(0.5));
    u_xlat10_18 = texture(_MaskTex, u_xlat0.xy).x;
    u_xlat10_0.xyw = texture(_NormalTex, u_xlat0.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_0.xyw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_30 = u_xlat10_18 * _Opacity + -0.00100000005;
    u_xlat0.x = u_xlat10_18 * _Opacity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat16_30<0.0);
#else
    u_xlatb9 = u_xlat16_30<0.0;
#endif
    if((int(u_xlatb9) * int(0xffffffffu))!=0){discard;}
    u_xlat2.z = u_xlat16_4.z;
    u_xlat2.xy = u_xlat16_4.xy * vec2(_NormalMultiplier);
    u_xlat16_4.xyz = vs_TEXCOORD3.xyz * vs_TEXCOORD4.zxy;
    u_xlat16_4.xyz = vs_TEXCOORD3.zxy * vs_TEXCOORD4.xyz + (-u_xlat16_4.xyz);
    u_xlat16_9.xyz = u_xlat16_3.zxy * u_xlat16_4.xyz;
    u_xlat9.xyz = u_xlat16_3.yzx * u_xlat16_4.yzx + (-u_xlat16_9.xyz);
    u_xlat19 = dot(vs_TEXCOORD4.xyz, u_xlat9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(u_xlat19));
#else
    u_xlatb19 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(u_xlat19);
#endif
    u_xlat16_5.xyz = (bool(u_xlatb19)) ? (-u_xlat9.yxz) : u_xlat9.yxz;
    u_xlat16_6.x = u_xlat16_5.y;
    u_xlat16_6.y = u_xlat16_4.z;
    u_xlat16_6.z = u_xlat16_3.x;
    u_xlat7.x = dot(u_xlat2.xyz, u_xlat16_6.xyz);
    u_xlat8.z = u_xlat2.z;
    u_xlat16_5.y = u_xlat16_4.x;
    u_xlat8.xy = u_xlat2.xy;
    u_xlat16_4.x = u_xlat16_5.z;
    u_xlat16_4.z = u_xlat16_3.z;
    u_xlat7.z = dot(u_xlat8.xyz, u_xlat16_4.xyz);
    u_xlat16_5.z = u_xlat16_3.y;
    u_xlat7.y = dot(u_xlat2.xyz, u_xlat16_5.xyz);
    u_xlat9.xyz = (-u_xlat16_3.xyz) + u_xlat7.xyz;
    u_xlat9.xyz = u_xlat0.xxx * u_xlat9.xyz + u_xlat16_3.xyz;
    u_xlat19 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat9.xyz = u_xlat9.xyz * vec3(u_xlat19);
    u_xlat2.xyz = (-vs_TEXCOORD5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat19 = dot(u_xlat9.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat7.xyz = vec3(u_xlat19) * _LightColor0.xyz;
    u_xlat10_19.xy = texture(_ShadowMapTexture, u_xlat1.xy).xy;
    u_xlat7.xyz = u_xlat10_19.xxx * u_xlat7.xyz;
    u_xlat10_8.xyz = texture(_CameraAlbedoTexture, u_xlat1.xy).xyz;
    u_xlat10_3 = texture(_CameraSpecularTexture, u_xlat1.xy);
    u_xlat16_4.xyz = u_xlat10_8.xyz * _Color.xyz + (-u_xlat10_8.xyz);
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz + u_xlat10_8.xyz;
    u_xlat7.xyz = u_xlat16_4.xyz * u_xlat7.xyz;
    u_xlat8.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat16_5.xyz = u_xlat8.xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat16_31 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_5.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat16_5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat9.x = dot(u_xlat9.xyz, u_xlat16_5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat18 = (-u_xlat1.x) + 1.0;
    u_xlat16_31 = u_xlat18 * u_xlat18;
    u_xlat16_31 = u_xlat18 * u_xlat16_31;
    u_xlat16_31 = u_xlat18 * u_xlat16_31;
    u_xlat16_31 = u_xlat18 * u_xlat16_31;
    u_xlat16_2.xyz = (-u_xlat10_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = vec3(u_xlat16_31) * u_xlat16_2.xyz;
    u_xlat18 = u_xlat10_3.w + _AddingShininess;
    u_xlat18 = min(u_xlat18, 0.5);
    u_xlat16_31 = (-u_xlat18) + 1.0;
    u_xlat16_18 = u_xlat16_31 * u_xlat16_31;
    u_xlat16_27 = (-u_xlat16_18) * u_xlat16_18 + 1.0;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_27 = u_xlat16_27 + u_xlat16_27;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_27) + u_xlat10_3.xyz;
    u_xlat27 = u_xlat9.x * u_xlat16_18 + (-u_xlat9.x);
    u_xlat9.x = u_xlat27 * u_xlat9.x + 1.0;
    u_xlat9.x = u_xlat9.x * u_xlat9.x;
    u_xlat9.x = max(u_xlat9.x, 9.99999997e-07);
    u_xlat9.x = u_xlat16_18 / u_xlat9.x;
    u_xlat9.x = u_xlat9.x * 0.318309873;
    u_xlat9.x = min(u_xlat9.x, 64.0);
    u_xlat8.xyz = u_xlat16_2.xyz * u_xlat9.xxx;
    u_xlat9.xyz = u_xlat9.xxx * u_xlat16_2.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat9.xyz = u_xlat8.xyz / u_xlat9.xyz;
    u_xlat9.xyz = u_xlat9.xyz + u_xlat9.xyz;
    u_xlat9.xyz = u_xlat9.xyz * _LightColor0.xyz;
    u_xlat9.xyz = u_xlat10_19.xxx * u_xlat9.xyz;
    u_xlat16_1.x = u_xlat10_19.y + -1.0;
    u_xlat16_1.x = u_xlat16_1.x * 0.349999994 + 1.0;
    u_xlat9.xyz = u_xlat9.xyz * u_xlat16_1.xxx;
    u_xlat16_1.x = (-u_xlat16_1.x) * 0.5 + 0.5;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_5.xyz = abs(u_xlat16_4.xyz) + vec3(0.00100000005, 0.00100000005, 0.00100000005);
    u_xlat16_10.xyz = log2(u_xlat16_5.xyz);
    u_xlat16_1.xyz = u_xlat16_10.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat9.xyz = u_xlat7.xyz * u_xlat16_1.xyz + u_xlat9.xyz;
    u_xlat9.xyz = vs_TEXCOORD6.xyz * u_xlat16_4.xyz + u_xlat9.xyz;
    SV_Target0.xyz = u_xlat0.xxx * u_xlat9.xyz;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_HDR_ON" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat4.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat4.x * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat4.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat2.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat2.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat2.www + u_xlat4.xyz;
    vs_TEXCOORD2.xyz = u_xlat4.xyz * vec3(-1.0, -1.0, 1.0);
    u_xlat4.x = dot(unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz;
    vs_TEXCOORD3.xyz = u_xlat4.xyz;
    u_xlat4.x = dot(unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat0.xyz = u_xlat4.xxx * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.xyz = vec3(0.0, 0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _Color;
uniform 	float _NormalMultiplier;
uniform 	float _AngleLimit;
uniform 	mediump vec4 _LightColor0;
uniform 	float _Opacity;
uniform 	float _AddingShininess;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _CameraNormalsTexture;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _CameraAlbedoTexture;
uniform lowp sampler2D _CameraSpecularTexture;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD6;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec2 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
bvec3 u_xlatb2;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
vec3 u_xlat9;
mediump vec3 u_xlat16_9;
bool u_xlatb9;
mediump vec3 u_xlat16_10;
float u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
bool u_xlatb18;
float u_xlat19;
lowp vec2 u_xlat10_19;
bool u_xlatb19;
float u_xlat27;
mediump float u_xlat16_27;
int u_xlati27;
mediump float u_xlat16_30;
mediump float u_xlat16_31;
void main()
{
    u_xlat0.x = _ProjectionParams.z / vs_TEXCOORD2.z;
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat27 = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat27 = _ZBufferParams.x * u_xlat27 + _ZBufferParams.y;
    u_xlat27 = float(1.0) / u_xlat27;
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    u_xlati27 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlati27 = u_xlati27 << 3;
    u_xlat2.xyz = u_xlat0.yyy * unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz + unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3].xyz;
    u_xlat2.xyz = -abs(u_xlat0.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlatb2.xyz = lessThan(u_xlat2.xyzx, vec4(0.0, 0.0, 0.0, 0.0)).xyz;
    u_xlatb18 = u_xlatb2.y || u_xlatb2.x;
    u_xlatb18 = u_xlatb2.z || u_xlatb18;
    if((int(u_xlatb18) * int(0xffffffffu))!=0){discard;}
    u_xlat10_2.xyz = texture(_CameraNormalsTexture, u_xlat1.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_18 = dot(u_xlat16_3.xyz, vs_TEXCOORD3.xyz);
    u_xlat18 = u_xlat16_18 + (-_AngleLimit);
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat18<0.0);
#else
    u_xlatb18 = u_xlat18<0.0;
#endif
    if((int(u_xlatb18) * int(0xffffffffu))!=0){discard;}
    u_xlat0.w = (-u_xlat0.x);
    u_xlat0.xy = vec2(u_xlat0.w + float(0.5), u_xlat0.y + float(0.5));
    u_xlat10_18 = texture(_MaskTex, u_xlat0.xy).x;
    u_xlat10_0.xyw = texture(_NormalTex, u_xlat0.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_0.xyw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_30 = u_xlat10_18 * _Opacity + -0.00100000005;
    u_xlat0.x = u_xlat10_18 * _Opacity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat16_30<0.0);
#else
    u_xlatb9 = u_xlat16_30<0.0;
#endif
    if((int(u_xlatb9) * int(0xffffffffu))!=0){discard;}
    u_xlat2.z = u_xlat16_4.z;
    u_xlat2.xy = u_xlat16_4.xy * vec2(_NormalMultiplier);
    u_xlat16_4.xyz = vs_TEXCOORD3.xyz * vs_TEXCOORD4.zxy;
    u_xlat16_4.xyz = vs_TEXCOORD3.zxy * vs_TEXCOORD4.xyz + (-u_xlat16_4.xyz);
    u_xlat16_9.xyz = u_xlat16_3.zxy * u_xlat16_4.xyz;
    u_xlat9.xyz = u_xlat16_3.yzx * u_xlat16_4.yzx + (-u_xlat16_9.xyz);
    u_xlat19 = dot(vs_TEXCOORD4.xyz, u_xlat9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(u_xlat19));
#else
    u_xlatb19 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(u_xlat19);
#endif
    u_xlat16_5.xyz = (bool(u_xlatb19)) ? (-u_xlat9.yxz) : u_xlat9.yxz;
    u_xlat16_6.x = u_xlat16_5.y;
    u_xlat16_6.y = u_xlat16_4.z;
    u_xlat16_6.z = u_xlat16_3.x;
    u_xlat7.x = dot(u_xlat2.xyz, u_xlat16_6.xyz);
    u_xlat8.z = u_xlat2.z;
    u_xlat8.xy = u_xlat2.xy;
    u_xlat16_5.y = u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_5.z;
    u_xlat16_4.z = u_xlat16_3.z;
    u_xlat7.z = dot(u_xlat8.xyz, u_xlat16_4.xyz);
    u_xlat16_5.z = u_xlat16_3.y;
    u_xlat7.y = dot(u_xlat2.xyz, u_xlat16_5.xyz);
    u_xlat9.xyz = (-u_xlat16_3.xyz) + u_xlat7.xyz;
    u_xlat9.xyz = u_xlat0.xxx * u_xlat9.xyz + u_xlat16_3.xyz;
    u_xlat19 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat9.xyz = u_xlat9.xyz * vec3(u_xlat19);
    u_xlat2.xyz = (-vs_TEXCOORD5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat19 = dot(u_xlat9.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat7.xyz = vec3(u_xlat19) * _LightColor0.xyz;
    u_xlat10_19.xy = texture(_ShadowMapTexture, u_xlat1.xy).xy;
    u_xlat7.xyz = u_xlat10_19.xxx * u_xlat7.xyz;
    u_xlat10_8.xyz = texture(_CameraAlbedoTexture, u_xlat1.xy).xyz;
    u_xlat10_3 = texture(_CameraSpecularTexture, u_xlat1.xy);
    u_xlat16_4.xyz = u_xlat10_8.xyz * _Color.xyz + (-u_xlat10_8.xyz);
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz + u_xlat10_8.xyz;
    u_xlat7.xyz = u_xlat16_4.xyz * u_xlat7.xyz;
    u_xlat8.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat16_5.xyz = u_xlat8.xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat16_31 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_5.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat16_5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat9.x = dot(u_xlat9.xyz, u_xlat16_5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat18 = (-u_xlat1.x) + 1.0;
    u_xlat16_31 = u_xlat18 * u_xlat18;
    u_xlat16_31 = u_xlat18 * u_xlat16_31;
    u_xlat16_31 = u_xlat18 * u_xlat16_31;
    u_xlat16_31 = u_xlat18 * u_xlat16_31;
    u_xlat16_2.xyz = (-u_xlat10_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = vec3(u_xlat16_31) * u_xlat16_2.xyz;
    u_xlat18 = u_xlat10_3.w + _AddingShininess;
    u_xlat18 = min(u_xlat18, 0.5);
    u_xlat16_31 = (-u_xlat18) + 1.0;
    u_xlat16_18 = u_xlat16_31 * u_xlat16_31;
    u_xlat16_27 = (-u_xlat16_18) * u_xlat16_18 + 1.0;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_27 = u_xlat16_27 + u_xlat16_27;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_27) + u_xlat10_3.xyz;
    u_xlat27 = u_xlat9.x * u_xlat16_18 + (-u_xlat9.x);
    u_xlat9.x = u_xlat27 * u_xlat9.x + 1.0;
    u_xlat9.x = u_xlat9.x * u_xlat9.x;
    u_xlat9.x = max(u_xlat9.x, 9.99999997e-07);
    u_xlat9.x = u_xlat16_18 / u_xlat9.x;
    u_xlat9.x = u_xlat9.x * 0.318309873;
    u_xlat9.x = min(u_xlat9.x, 64.0);
    u_xlat8.xyz = u_xlat16_2.xyz * u_xlat9.xxx;
    u_xlat9.xyz = u_xlat9.xxx * u_xlat16_2.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat9.xyz = u_xlat8.xyz / u_xlat9.xyz;
    u_xlat9.xyz = u_xlat9.xyz + u_xlat9.xyz;
    u_xlat9.xyz = u_xlat9.xyz * _LightColor0.xyz;
    u_xlat9.xyz = u_xlat10_19.xxx * u_xlat9.xyz;
    u_xlat16_1.x = u_xlat10_19.y + -1.0;
    u_xlat16_1.x = u_xlat16_1.x * 0.349999994 + 1.0;
    u_xlat9.xyz = u_xlat9.xyz * u_xlat16_1.xxx;
    u_xlat16_1.x = (-u_xlat16_1.x) * 0.5 + 0.5;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_5.xyz = abs(u_xlat16_4.xyz) + vec3(0.00100000005, 0.00100000005, 0.00100000005);
    u_xlat16_10.xyz = log2(u_xlat16_5.xyz);
    u_xlat16_1.xyz = u_xlat16_10.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat9.xyz = u_xlat7.xyz * u_xlat16_1.xyz + u_xlat9.xyz;
    u_xlat9.xyz = vs_TEXCOORD6.xyz * u_xlat16_4.xyz + u_xlat9.xyz;
    SV_Target0.xyz = u_xlat0.xxx * u_xlat9.xyz;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_HDR_ON" "MSAA_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat1.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    u_xlat0.x = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * hlslcc_mtx4x4unity_ObjectToWorld[2].xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * hlslcc_mtx4x4unity_ObjectToWorld[0].xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 _Color;
uniform 	float _NormalMultiplier;
uniform 	float _AngleLimit;
uniform 	mediump vec4 _LightColor0;
uniform 	float _Opacity;
uniform 	float _AddingShininess;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _ShadowMapTexture;
uniform lowp sampler2DMS _CameraNormalsTexture;
uniform lowp sampler2DMS _CameraAlbedoTexture;
uniform lowp sampler2DMS _CameraSpecularTexture;
uniform lowp sampler2DMS _CameraDepthTextureMS;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec2 u_xlat1;
mediump float u_xlat16_1;
lowp vec2 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
uvec4 u_xlatu2;
vec3 u_xlat3;
bvec3 u_xlatb3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
vec3 u_xlat9;
vec3 u_xlat10;
mediump vec3 u_xlat16_10;
bool u_xlatb10;
vec3 u_xlat11;
float u_xlat20;
mediump float u_xlat16_20;
lowp float u_xlat10_20;
bool u_xlatb20;
vec2 u_xlat21;
bool u_xlatb21;
float u_xlat30;
mediump float u_xlat16_30;
float u_xlat31;
mediump float u_xlat16_34;
void main()
{
    u_xlat0.x = _ProjectionParams.z / vs_TEXCOORD2.z;
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat21.xy = u_xlat1.xy * _ScreenParams.xy;
    u_xlat10_1.xy = texture(_ShadowMapTexture, u_xlat1.xy).xy;
    u_xlat21.xy = floor(u_xlat21.xy);
    u_xlatu2.xy = uvec2(ivec2(u_xlat21.xy));
    u_xlatu2.z = uint(uint(0u));
    u_xlatu2.w = uint(uint(0u));
    u_xlat30 = texelFetch(_CameraDepthTextureMS, ivec2(u_xlatu2.xy), 0).x;
    u_xlat30 = _ZBufferParams.x * u_xlat30 + _ZBufferParams.y;
    u_xlat30 = float(1.0) / u_xlat30;
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat3.xyz = -abs(u_xlat0.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlatb3.xyz = lessThan(u_xlat3.xyzx, vec4(0.0, 0.0, 0.0, 0.0)).xyz;
    u_xlatb20 = u_xlatb3.y || u_xlatb3.x;
    u_xlatb20 = u_xlatb3.z || u_xlatb20;
    if((int(u_xlatb20) * int(0xffffffffu))!=0){discard;}
    u_xlat3.xyz = texelFetch(_CameraNormalsTexture, ivec2(u_xlatu2.xy), 0).xyz;
    u_xlat16_4.xyz = u_xlat3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_20 = dot(u_xlat16_4.xyz, vs_TEXCOORD3.xyz);
    u_xlat20 = u_xlat16_20 + (-_AngleLimit);
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(u_xlat20<0.0);
#else
    u_xlatb20 = u_xlat20<0.0;
#endif
    if((int(u_xlatb20) * int(0xffffffffu))!=0){discard;}
    u_xlat0.w = (-u_xlat0.x);
    u_xlat0.xy = vec2(u_xlat0.w + float(0.5), u_xlat0.y + float(0.5));
    u_xlat10_20 = texture(_MaskTex, u_xlat0.xy).x;
    u_xlat10_0.xyw = texture(_NormalTex, u_xlat0.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_0.xyw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_34 = u_xlat10_20 * _Opacity + -0.00100000005;
    u_xlat0.x = u_xlat10_20 * _Opacity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat16_34<0.0);
#else
    u_xlatb10 = u_xlat16_34<0.0;
#endif
    if((int(u_xlatb10) * int(0xffffffffu))!=0){discard;}
    u_xlat3.z = u_xlat16_5.z;
    u_xlat3.xy = u_xlat16_5.xy * vec2(_NormalMultiplier);
    u_xlat16_5.xyz = vs_TEXCOORD3.xyz * vs_TEXCOORD4.zxy;
    u_xlat16_5.xyz = vs_TEXCOORD3.zxy * vs_TEXCOORD4.xyz + (-u_xlat16_5.xyz);
    u_xlat16_10.xyz = u_xlat16_4.zxy * u_xlat16_5.xyz;
    u_xlat10.xyz = u_xlat16_4.yzx * u_xlat16_5.yzx + (-u_xlat16_10.xyz);
    u_xlat21.x = dot(vs_TEXCOORD4.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(u_xlat21.x));
#else
    u_xlatb21 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(u_xlat21.x);
#endif
    u_xlat16_6.xyz = (bool(u_xlatb21)) ? (-u_xlat10.yxz) : u_xlat10.yxz;
    u_xlat16_7.x = u_xlat16_6.y;
    u_xlat16_7.z = u_xlat16_4.x;
    u_xlat16_7.y = u_xlat16_5.z;
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat16_7.xyz);
    u_xlat9.z = u_xlat3.z;
    u_xlat16_6.y = u_xlat16_5.x;
    u_xlat9.xy = u_xlat3.xy;
    u_xlat16_5.x = u_xlat16_6.z;
    u_xlat16_5.z = u_xlat16_4.z;
    u_xlat8.z = dot(u_xlat9.xyz, u_xlat16_5.xyz);
    u_xlat16_6.z = u_xlat16_4.y;
    u_xlat8.y = dot(u_xlat3.xyz, u_xlat16_6.xyz);
    u_xlat10.xyz = (-u_xlat16_4.xyz) + u_xlat8.xyz;
    u_xlat10.xyz = u_xlat0.xxx * u_xlat10.xyz + u_xlat16_4.xyz;
    u_xlat21.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat21.x = inversesqrt(u_xlat21.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat21.xxx;
    u_xlat3.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21.x = inversesqrt(u_xlat21.x);
    u_xlat8.xyz = (-vs_TEXCOORD5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat31 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat8.xyz = vec3(u_xlat31) * u_xlat8.xyz;
    u_xlat16_4.xyz = u_xlat3.xyz * u_xlat21.xxx + u_xlat8.xyz;
    u_xlat16_34 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_34 = inversesqrt(u_xlat16_34);
    u_xlat16_4.xyz = vec3(u_xlat16_34) * u_xlat16_4.xyz;
    u_xlat21.x = dot(u_xlat10.xyz, u_xlat16_4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat21.x = min(max(u_xlat21.x, 0.0), 1.0);
#else
    u_xlat21.x = clamp(u_xlat21.x, 0.0, 1.0);
#endif
    u_xlat10.x = dot(u_xlat10.xyz, u_xlat8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat20 = dot(u_xlat8.xyz, u_xlat16_4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat20 = (-u_xlat20) + 1.0;
    u_xlat3.xyz = u_xlat10.xxx * _LightColor0.xyz;
    u_xlat3.xyz = u_xlat10_1.xxx * u_xlat3.xyz;
    u_xlat4 = texelFetch(_CameraSpecularTexture, ivec2(u_xlatu2.xy), 0);
    u_xlat2.xyz = texelFetch(_CameraAlbedoTexture, ivec2(u_xlatu2.xy), 0).xyz;
    u_xlat10.x = u_xlat4.w + _AddingShininess;
    u_xlat10.x = min(u_xlat10.x, 0.5);
    u_xlat16_5.x = (-u_xlat10.x) + 1.0;
    u_xlat16_10.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_30 = u_xlat16_10.x * u_xlat16_10.x;
    u_xlat16_10.x = (-u_xlat16_10.x) * u_xlat16_10.x + 1.0;
    u_xlat16_10.x = u_xlat16_10.x + u_xlat16_10.x;
    u_xlat31 = u_xlat21.x * u_xlat16_30 + (-u_xlat21.x);
    u_xlat21.x = u_xlat31 * u_xlat21.x + 1.0;
    u_xlat21.x = u_xlat21.x * u_xlat21.x;
    u_xlat21.x = max(u_xlat21.x, 9.99999997e-07);
    u_xlat30 = u_xlat16_30 / u_xlat21.x;
    u_xlat30 = u_xlat30 * 0.318309873;
    u_xlat30 = min(u_xlat30, 64.0);
    u_xlat16_5.x = u_xlat20 * u_xlat20;
    u_xlat16_5.x = u_xlat20 * u_xlat16_5.x;
    u_xlat16_5.x = u_xlat20 * u_xlat16_5.x;
    u_xlat16_5.x = u_xlat20 * u_xlat16_5.x;
    u_xlat8.xyz = (-u_xlat4.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat8.xyz = u_xlat16_5.xxx * u_xlat8.xyz;
    u_xlat8.xyz = u_xlat8.xyz * u_xlat16_10.xxx + u_xlat4.xyz;
    u_xlat9.xyz = vec3(u_xlat30) * u_xlat8.xyz;
    u_xlat10.xyz = vec3(u_xlat30) * u_xlat8.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat10.xyz = u_xlat9.xyz / u_xlat10.xyz;
    u_xlat10.xyz = u_xlat10.xyz + u_xlat10.xyz;
    u_xlat10.xyz = u_xlat10.xyz * _LightColor0.xyz;
    u_xlat10.xyz = u_xlat10_1.xxx * u_xlat10.xyz;
    u_xlat16_1 = u_xlat10_1.y + -1.0;
    u_xlat16_1 = u_xlat16_1 * 0.349999994 + 1.0;
    u_xlat10.xyz = u_xlat10.xyz * vec3(u_xlat16_1);
    u_xlat16_1 = (-u_xlat16_1) * 0.5 + 0.5;
    u_xlat16_1 = max(u_xlat16_1, 0.00100000005);
    u_xlat16_5.xyz = u_xlat2.xyz * _Color.xyz + (-u_xlat2.xyz);
    u_xlat16_5.xyz = u_xlat0.xxx * u_xlat16_5.xyz + u_xlat2.xyz;
    u_xlat11.xyz = u_xlat3.xyz * u_xlat16_5.xyz;
    u_xlat16_6.xyz = abs(u_xlat16_5.xyz) + vec3(0.00100000005, 0.00100000005, 0.00100000005);
    u_xlat16_2.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_2.xyz = vec3(u_xlat16_1) * u_xlat16_2.xyz;
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat10.xyz = u_xlat11.xyz * u_xlat16_2.xyz + u_xlat10.xyz;
    u_xlat10.xyz = vs_TEXCOORD6.xyz * u_xlat16_5.xyz + u_xlat10.xyz;
    SV_Target0.xyz = u_xlat0.xxx * u_xlat10.xyz;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_HDR_ON" "INSTANCING_ON" "MSAA_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat4.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat4.x * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat4.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat2.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat2.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat2.www + u_xlat4.xyz;
    vs_TEXCOORD2.xyz = u_xlat4.xyz * vec3(-1.0, -1.0, 1.0);
    u_xlat4.x = dot(unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz;
    vs_TEXCOORD3.xyz = u_xlat4.xyz;
    u_xlat4.x = dot(unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat0.xyz = u_xlat4.xxx * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.xyz = vec3(0.0, 0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _Color;
uniform 	float _NormalMultiplier;
uniform 	float _AngleLimit;
uniform 	mediump vec4 _LightColor0;
uniform 	float _Opacity;
uniform 	float _AddingShininess;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _ShadowMapTexture;
uniform lowp sampler2DMS _CameraNormalsTexture;
uniform lowp sampler2DMS _CameraAlbedoTexture;
uniform lowp sampler2DMS _CameraSpecularTexture;
uniform lowp sampler2DMS _CameraDepthTextureMS;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD6;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec2 u_xlat1;
mediump float u_xlat16_1;
lowp vec2 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
uvec4 u_xlatu2;
vec3 u_xlat3;
bvec3 u_xlatb3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
vec3 u_xlat9;
vec3 u_xlat10;
mediump vec3 u_xlat16_10;
bool u_xlatb10;
vec3 u_xlat11;
float u_xlat20;
mediump float u_xlat16_20;
lowp float u_xlat10_20;
bool u_xlatb20;
vec2 u_xlat21;
bool u_xlatb21;
float u_xlat30;
mediump float u_xlat16_30;
int u_xlati30;
float u_xlat31;
mediump float u_xlat16_34;
void main()
{
    u_xlat0.x = _ProjectionParams.z / vs_TEXCOORD2.z;
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat21.xy = u_xlat1.xy * _ScreenParams.xy;
    u_xlat10_1.xy = texture(_ShadowMapTexture, u_xlat1.xy).xy;
    u_xlat21.xy = floor(u_xlat21.xy);
    u_xlatu2.xy = uvec2(ivec2(u_xlat21.xy));
    u_xlatu2.z = uint(uint(0u));
    u_xlatu2.w = uint(uint(0u));
    u_xlat30 = texelFetch(_CameraDepthTextureMS, ivec2(u_xlatu2.xy), 0).x;
    u_xlat30 = _ZBufferParams.x * u_xlat30 + _ZBufferParams.y;
    u_xlat30 = float(1.0) / u_xlat30;
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    u_xlati30 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlati30 = u_xlati30 << 3;
    u_xlat3.xyz = u_xlat0.yyy * unity_Builtins0Array[u_xlati30 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati30 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati30 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz * u_xlat0.zzz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz + unity_Builtins0Array[u_xlati30 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3].xyz;
    u_xlat3.xyz = -abs(u_xlat0.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlatb3.xyz = lessThan(u_xlat3.xyzx, vec4(0.0, 0.0, 0.0, 0.0)).xyz;
    u_xlatb20 = u_xlatb3.y || u_xlatb3.x;
    u_xlatb20 = u_xlatb3.z || u_xlatb20;
    if((int(u_xlatb20) * int(0xffffffffu))!=0){discard;}
    u_xlat3.xyz = texelFetch(_CameraNormalsTexture, ivec2(u_xlatu2.xy), 0).xyz;
    u_xlat16_4.xyz = u_xlat3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_20 = dot(u_xlat16_4.xyz, vs_TEXCOORD3.xyz);
    u_xlat20 = u_xlat16_20 + (-_AngleLimit);
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(u_xlat20<0.0);
#else
    u_xlatb20 = u_xlat20<0.0;
#endif
    if((int(u_xlatb20) * int(0xffffffffu))!=0){discard;}
    u_xlat0.w = (-u_xlat0.x);
    u_xlat0.xy = vec2(u_xlat0.w + float(0.5), u_xlat0.y + float(0.5));
    u_xlat10_20 = texture(_MaskTex, u_xlat0.xy).x;
    u_xlat10_0.xyw = texture(_NormalTex, u_xlat0.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_0.xyw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_34 = u_xlat10_20 * _Opacity + -0.00100000005;
    u_xlat0.x = u_xlat10_20 * _Opacity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat16_34<0.0);
#else
    u_xlatb10 = u_xlat16_34<0.0;
#endif
    if((int(u_xlatb10) * int(0xffffffffu))!=0){discard;}
    u_xlat3.z = u_xlat16_5.z;
    u_xlat3.xy = u_xlat16_5.xy * vec2(_NormalMultiplier);
    u_xlat16_5.xyz = vs_TEXCOORD3.xyz * vs_TEXCOORD4.zxy;
    u_xlat16_5.xyz = vs_TEXCOORD3.zxy * vs_TEXCOORD4.xyz + (-u_xlat16_5.xyz);
    u_xlat16_10.xyz = u_xlat16_4.zxy * u_xlat16_5.xyz;
    u_xlat10.xyz = u_xlat16_4.yzx * u_xlat16_5.yzx + (-u_xlat16_10.xyz);
    u_xlat21.x = dot(vs_TEXCOORD4.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(u_xlat21.x));
#else
    u_xlatb21 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(u_xlat21.x);
#endif
    u_xlat16_6.xyz = (bool(u_xlatb21)) ? (-u_xlat10.yxz) : u_xlat10.yxz;
    u_xlat16_7.x = u_xlat16_6.y;
    u_xlat16_7.z = u_xlat16_4.x;
    u_xlat16_7.y = u_xlat16_5.z;
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat16_7.xyz);
    u_xlat9.z = u_xlat3.z;
    u_xlat9.xy = u_xlat3.xy;
    u_xlat16_6.y = u_xlat16_5.x;
    u_xlat16_5.x = u_xlat16_6.z;
    u_xlat16_5.z = u_xlat16_4.z;
    u_xlat8.z = dot(u_xlat9.xyz, u_xlat16_5.xyz);
    u_xlat16_6.z = u_xlat16_4.y;
    u_xlat8.y = dot(u_xlat3.xyz, u_xlat16_6.xyz);
    u_xlat10.xyz = (-u_xlat16_4.xyz) + u_xlat8.xyz;
    u_xlat10.xyz = u_xlat0.xxx * u_xlat10.xyz + u_xlat16_4.xyz;
    u_xlat21.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat21.x = inversesqrt(u_xlat21.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat21.xxx;
    u_xlat3.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21.x = inversesqrt(u_xlat21.x);
    u_xlat8.xyz = (-vs_TEXCOORD5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat31 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat8.xyz = vec3(u_xlat31) * u_xlat8.xyz;
    u_xlat16_4.xyz = u_xlat3.xyz * u_xlat21.xxx + u_xlat8.xyz;
    u_xlat16_34 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_34 = inversesqrt(u_xlat16_34);
    u_xlat16_4.xyz = vec3(u_xlat16_34) * u_xlat16_4.xyz;
    u_xlat21.x = dot(u_xlat10.xyz, u_xlat16_4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat21.x = min(max(u_xlat21.x, 0.0), 1.0);
#else
    u_xlat21.x = clamp(u_xlat21.x, 0.0, 1.0);
#endif
    u_xlat10.x = dot(u_xlat10.xyz, u_xlat8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat20 = dot(u_xlat8.xyz, u_xlat16_4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat20 = (-u_xlat20) + 1.0;
    u_xlat3.xyz = u_xlat10.xxx * _LightColor0.xyz;
    u_xlat3.xyz = u_xlat10_1.xxx * u_xlat3.xyz;
    u_xlat4 = texelFetch(_CameraSpecularTexture, ivec2(u_xlatu2.xy), 0);
    u_xlat2.xyz = texelFetch(_CameraAlbedoTexture, ivec2(u_xlatu2.xy), 0).xyz;
    u_xlat10.x = u_xlat4.w + _AddingShininess;
    u_xlat10.x = min(u_xlat10.x, 0.5);
    u_xlat16_5.x = (-u_xlat10.x) + 1.0;
    u_xlat16_10.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_30 = u_xlat16_10.x * u_xlat16_10.x;
    u_xlat16_10.x = (-u_xlat16_10.x) * u_xlat16_10.x + 1.0;
    u_xlat16_10.x = u_xlat16_10.x + u_xlat16_10.x;
    u_xlat31 = u_xlat21.x * u_xlat16_30 + (-u_xlat21.x);
    u_xlat21.x = u_xlat31 * u_xlat21.x + 1.0;
    u_xlat21.x = u_xlat21.x * u_xlat21.x;
    u_xlat21.x = max(u_xlat21.x, 9.99999997e-07);
    u_xlat30 = u_xlat16_30 / u_xlat21.x;
    u_xlat30 = u_xlat30 * 0.318309873;
    u_xlat30 = min(u_xlat30, 64.0);
    u_xlat16_5.x = u_xlat20 * u_xlat20;
    u_xlat16_5.x = u_xlat20 * u_xlat16_5.x;
    u_xlat16_5.x = u_xlat20 * u_xlat16_5.x;
    u_xlat16_5.x = u_xlat20 * u_xlat16_5.x;
    u_xlat8.xyz = (-u_xlat4.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat8.xyz = u_xlat16_5.xxx * u_xlat8.xyz;
    u_xlat8.xyz = u_xlat8.xyz * u_xlat16_10.xxx + u_xlat4.xyz;
    u_xlat9.xyz = vec3(u_xlat30) * u_xlat8.xyz;
    u_xlat10.xyz = vec3(u_xlat30) * u_xlat8.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat10.xyz = u_xlat9.xyz / u_xlat10.xyz;
    u_xlat10.xyz = u_xlat10.xyz + u_xlat10.xyz;
    u_xlat10.xyz = u_xlat10.xyz * _LightColor0.xyz;
    u_xlat10.xyz = u_xlat10_1.xxx * u_xlat10.xyz;
    u_xlat16_1 = u_xlat10_1.y + -1.0;
    u_xlat16_1 = u_xlat16_1 * 0.349999994 + 1.0;
    u_xlat10.xyz = u_xlat10.xyz * vec3(u_xlat16_1);
    u_xlat16_1 = (-u_xlat16_1) * 0.5 + 0.5;
    u_xlat16_1 = max(u_xlat16_1, 0.00100000005);
    u_xlat16_5.xyz = u_xlat2.xyz * _Color.xyz + (-u_xlat2.xyz);
    u_xlat16_5.xyz = u_xlat0.xxx * u_xlat16_5.xyz + u_xlat2.xyz;
    u_xlat11.xyz = u_xlat3.xyz * u_xlat16_5.xyz;
    u_xlat16_6.xyz = abs(u_xlat16_5.xyz) + vec3(0.00100000005, 0.00100000005, 0.00100000005);
    u_xlat16_2.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_2.xyz = vec3(u_xlat16_1) * u_xlat16_2.xyz;
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat10.xyz = u_xlat11.xyz * u_xlat16_2.xyz + u_xlat10.xyz;
    u_xlat10.xyz = vs_TEXCOORD6.xyz * u_xlat16_5.xyz + u_xlat10.xyz;
    SV_Target0.xyz = u_xlat0.xxx * u_xlat10.xyz;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat1.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    u_xlat0.x = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * hlslcc_mtx4x4unity_ObjectToWorld[2].xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * hlslcc_mtx4x4unity_ObjectToWorld[0].xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat16_3.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_3.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_3.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD6.xyz = u_xlat16_3.xyz;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 _Color;
uniform 	float _NormalMultiplier;
uniform 	float _AngleLimit;
uniform 	mediump vec4 _LightColor0;
uniform 	float _Opacity;
uniform 	float _AddingShininess;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _CameraNormalsTexture;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _CameraAlbedoTexture;
uniform lowp sampler2D _CameraSpecularTexture;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec2 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
bvec3 u_xlatb2;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
vec3 u_xlat9;
mediump vec3 u_xlat16_9;
bool u_xlatb9;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
float u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
bool u_xlatb18;
float u_xlat19;
lowp vec2 u_xlat10_19;
bool u_xlatb19;
float u_xlat27;
mediump float u_xlat16_27;
mediump float u_xlat16_30;
mediump float u_xlat16_31;
void main()
{
    u_xlat0.x = _ProjectionParams.z / vs_TEXCOORD2.z;
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat27 = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat27 = _ZBufferParams.x * u_xlat27 + _ZBufferParams.y;
    u_xlat27 = float(1.0) / u_xlat27;
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat2.xyz = -abs(u_xlat0.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlatb2.xyz = lessThan(u_xlat2.xyzx, vec4(0.0, 0.0, 0.0, 0.0)).xyz;
    u_xlatb18 = u_xlatb2.y || u_xlatb2.x;
    u_xlatb18 = u_xlatb2.z || u_xlatb18;
    if((int(u_xlatb18) * int(0xffffffffu))!=0){discard;}
    u_xlat10_2.xyz = texture(_CameraNormalsTexture, u_xlat1.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_18 = dot(u_xlat16_3.xyz, vs_TEXCOORD3.xyz);
    u_xlat18 = u_xlat16_18 + (-_AngleLimit);
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat18<0.0);
#else
    u_xlatb18 = u_xlat18<0.0;
#endif
    if((int(u_xlatb18) * int(0xffffffffu))!=0){discard;}
    u_xlat0.w = (-u_xlat0.x);
    u_xlat0.xy = vec2(u_xlat0.w + float(0.5), u_xlat0.y + float(0.5));
    u_xlat10_18 = texture(_MaskTex, u_xlat0.xy).x;
    u_xlat10_0.xyw = texture(_NormalTex, u_xlat0.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_0.xyw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_30 = u_xlat10_18 * _Opacity + -0.00100000005;
    u_xlat0.x = u_xlat10_18 * _Opacity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat16_30<0.0);
#else
    u_xlatb9 = u_xlat16_30<0.0;
#endif
    if((int(u_xlatb9) * int(0xffffffffu))!=0){discard;}
    u_xlat2.z = u_xlat16_4.z;
    u_xlat2.xy = u_xlat16_4.xy * vec2(_NormalMultiplier);
    u_xlat16_4.xyz = vs_TEXCOORD3.xyz * vs_TEXCOORD4.zxy;
    u_xlat16_4.xyz = vs_TEXCOORD3.zxy * vs_TEXCOORD4.xyz + (-u_xlat16_4.xyz);
    u_xlat16_9.xyz = u_xlat16_3.zxy * u_xlat16_4.xyz;
    u_xlat9.xyz = u_xlat16_3.yzx * u_xlat16_4.yzx + (-u_xlat16_9.xyz);
    u_xlat19 = dot(vs_TEXCOORD4.xyz, u_xlat9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(u_xlat19));
#else
    u_xlatb19 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(u_xlat19);
#endif
    u_xlat16_5.xyz = (bool(u_xlatb19)) ? (-u_xlat9.yxz) : u_xlat9.yxz;
    u_xlat16_6.x = u_xlat16_5.y;
    u_xlat16_6.y = u_xlat16_4.z;
    u_xlat16_6.z = u_xlat16_3.x;
    u_xlat7.x = dot(u_xlat2.xyz, u_xlat16_6.xyz);
    u_xlat8.z = u_xlat2.z;
    u_xlat16_5.y = u_xlat16_4.x;
    u_xlat8.xy = u_xlat2.xy;
    u_xlat16_4.x = u_xlat16_5.z;
    u_xlat16_4.z = u_xlat16_3.z;
    u_xlat7.z = dot(u_xlat8.xyz, u_xlat16_4.xyz);
    u_xlat16_5.z = u_xlat16_3.y;
    u_xlat7.y = dot(u_xlat2.xyz, u_xlat16_5.xyz);
    u_xlat9.xyz = (-u_xlat16_3.xyz) + u_xlat7.xyz;
    u_xlat9.xyz = u_xlat0.xxx * u_xlat9.xyz + u_xlat16_3.xyz;
    u_xlat19 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat9.xyz = u_xlat9.xyz * vec3(u_xlat19);
    u_xlat2.xyz = (-vs_TEXCOORD5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat19 = dot(u_xlat9.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat7.xyz = vec3(u_xlat19) * _LightColor0.xyz;
    u_xlat10_19.xy = texture(_ShadowMapTexture, u_xlat1.xy).xy;
    u_xlat7.xyz = u_xlat10_19.xxx * u_xlat7.xyz;
    u_xlat10_8.xyz = texture(_CameraAlbedoTexture, u_xlat1.xy).xyz;
    u_xlat10_3 = texture(_CameraSpecularTexture, u_xlat1.xy);
    u_xlat16_4.xyz = u_xlat10_8.xyz * _Color.xyz + (-u_xlat10_8.xyz);
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz + u_xlat10_8.xyz;
    u_xlat7.xyz = u_xlat16_4.xyz * u_xlat7.xyz;
    u_xlat8.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat16_5.xyz = u_xlat8.xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat16_31 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_5.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat16_5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat9.x = dot(u_xlat9.xyz, u_xlat16_5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat18 = (-u_xlat1.x) + 1.0;
    u_xlat16_31 = u_xlat18 * u_xlat18;
    u_xlat16_31 = u_xlat18 * u_xlat16_31;
    u_xlat16_31 = u_xlat18 * u_xlat16_31;
    u_xlat16_31 = u_xlat18 * u_xlat16_31;
    u_xlat16_2.xyz = (-u_xlat10_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = vec3(u_xlat16_31) * u_xlat16_2.xyz;
    u_xlat18 = u_xlat10_3.w + _AddingShininess;
    u_xlat18 = min(u_xlat18, 0.5);
    u_xlat16_31 = (-u_xlat18) + 1.0;
    u_xlat16_18 = u_xlat16_31 * u_xlat16_31;
    u_xlat16_27 = (-u_xlat16_18) * u_xlat16_18 + 1.0;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_27 = u_xlat16_27 + u_xlat16_27;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_27) + u_xlat10_3.xyz;
    u_xlat27 = u_xlat9.x * u_xlat16_18 + (-u_xlat9.x);
    u_xlat9.x = u_xlat27 * u_xlat9.x + 1.0;
    u_xlat9.x = u_xlat9.x * u_xlat9.x;
    u_xlat9.x = max(u_xlat9.x, 9.99999997e-07);
    u_xlat9.x = u_xlat16_18 / u_xlat9.x;
    u_xlat9.x = u_xlat9.x * 0.318309873;
    u_xlat9.x = min(u_xlat9.x, 64.0);
    u_xlat8.xyz = u_xlat16_2.xyz * u_xlat9.xxx;
    u_xlat9.xyz = u_xlat9.xxx * u_xlat16_2.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat9.xyz = u_xlat8.xyz / u_xlat9.xyz;
    u_xlat9.xyz = u_xlat9.xyz + u_xlat9.xyz;
    u_xlat9.xyz = u_xlat9.xyz * _LightColor0.xyz;
    u_xlat9.xyz = u_xlat10_19.xxx * u_xlat9.xyz;
    u_xlat16_1.x = u_xlat10_19.y + -1.0;
    u_xlat16_1.x = u_xlat16_1.x * 0.349999994 + 1.0;
    u_xlat9.xyz = u_xlat9.xyz * u_xlat16_1.xxx;
    u_xlat16_5.xyz = abs(u_xlat16_4.xyz) + vec3(0.00100000005, 0.00100000005, 0.00100000005);
    u_xlat16_10.xyz = log2(u_xlat16_5.xyz);
    u_xlat16_2.x = (-u_xlat16_1.x) * 0.5 + 0.5;
    u_xlat11.xyz = u_xlat16_1.xxx * vs_TEXCOORD6.xyz;
    u_xlat16_1.x = max(u_xlat16_2.x, 0.00100000005);
    u_xlat16_1.xyz = u_xlat16_10.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat9.xyz = u_xlat7.xyz * u_xlat16_1.xyz + u_xlat9.xyz;
    u_xlat9.xyz = u_xlat11.xyz * u_xlat16_4.xyz + u_xlat9.xyz;
    SV_Target0.xyz = u_xlat0.xxx * u_xlat9.xyz;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
mediump vec4 u_xlat16_0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat6.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat6.x * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat6.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat2.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat2.zzz + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat2.www + u_xlat6.xyz;
    vs_TEXCOORD2.xyz = u_xlat6.xyz * vec3(-1.0, -1.0, 1.0);
    u_xlat6.x = dot(unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz;
    vs_TEXCOORD3.xyz = u_xlat6.xyz;
    u_xlat1.x = dot(unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat16_4.x = u_xlat6.y * u_xlat6.y;
    u_xlat16_4.x = u_xlat6.x * u_xlat6.x + (-u_xlat16_4.x);
    u_xlat16_0 = u_xlat6.yzzx * u_xlat6.xyzz;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_5.xyz;
    vs_TEXCOORD6.xyz = u_xlat16_4.xyz;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _Color;
uniform 	float _NormalMultiplier;
uniform 	float _AngleLimit;
uniform 	mediump vec4 _LightColor0;
uniform 	float _Opacity;
uniform 	float _AddingShininess;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _CameraNormalsTexture;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _CameraAlbedoTexture;
uniform lowp sampler2D _CameraSpecularTexture;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD6;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec2 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
bvec3 u_xlatb2;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
mediump vec3 u_xlat16_8;
lowp vec3 u_xlat10_8;
vec3 u_xlat9;
vec3 u_xlat10;
mediump vec3 u_xlat16_10;
bool u_xlatb10;
mediump vec3 u_xlat16_11;
float u_xlat20;
mediump float u_xlat16_20;
lowp float u_xlat10_20;
bool u_xlatb20;
float u_xlat21;
lowp vec2 u_xlat10_21;
bool u_xlatb21;
float u_xlat30;
mediump float u_xlat16_30;
int u_xlati30;
mediump float u_xlat16_33;
mediump float u_xlat16_34;
mediump float u_xlat16_37;
void main()
{
    u_xlat0.x = _ProjectionParams.z / vs_TEXCOORD2.z;
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat30 = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat30 = _ZBufferParams.x * u_xlat30 + _ZBufferParams.y;
    u_xlat30 = float(1.0) / u_xlat30;
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    u_xlati30 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlati30 = u_xlati30 << 3;
    u_xlat2.xyz = u_xlat0.yyy * unity_Builtins0Array[u_xlati30 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati30 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati30 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz + unity_Builtins0Array[u_xlati30 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3].xyz;
    u_xlat2.xyz = -abs(u_xlat0.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlatb2.xyz = lessThan(u_xlat2.xyzx, vec4(0.0, 0.0, 0.0, 0.0)).xyz;
    u_xlatb20 = u_xlatb2.y || u_xlatb2.x;
    u_xlatb20 = u_xlatb2.z || u_xlatb20;
    if((int(u_xlatb20) * int(0xffffffffu))!=0){discard;}
    u_xlat10_2.xyz = texture(_CameraNormalsTexture, u_xlat1.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_20 = dot(u_xlat16_3.xyz, vs_TEXCOORD3.xyz);
    u_xlat20 = u_xlat16_20 + (-_AngleLimit);
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(u_xlat20<0.0);
#else
    u_xlatb20 = u_xlat20<0.0;
#endif
    if((int(u_xlatb20) * int(0xffffffffu))!=0){discard;}
    u_xlat0.w = (-u_xlat0.x);
    u_xlat0.xy = vec2(u_xlat0.w + float(0.5), u_xlat0.y + float(0.5));
    u_xlat10_20 = texture(_MaskTex, u_xlat0.xy).x;
    u_xlat10_0.xyw = texture(_NormalTex, u_xlat0.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_0.xyw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_33 = u_xlat10_20 * _Opacity + -0.00100000005;
    u_xlat0.x = u_xlat10_20 * _Opacity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat16_33<0.0);
#else
    u_xlatb10 = u_xlat16_33<0.0;
#endif
    if((int(u_xlatb10) * int(0xffffffffu))!=0){discard;}
    u_xlat2.z = u_xlat16_4.z;
    u_xlat2.xy = u_xlat16_4.xy * vec2(_NormalMultiplier);
    u_xlat16_4.xyz = vs_TEXCOORD3.xyz * vs_TEXCOORD4.zxy;
    u_xlat16_4.xyz = vs_TEXCOORD3.zxy * vs_TEXCOORD4.xyz + (-u_xlat16_4.xyz);
    u_xlat16_10.xyz = u_xlat16_3.zxy * u_xlat16_4.xyz;
    u_xlat10.xyz = u_xlat16_3.yzx * u_xlat16_4.yzx + (-u_xlat16_10.xyz);
    u_xlat21 = dot(vs_TEXCOORD4.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(u_xlat21));
#else
    u_xlatb21 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(u_xlat21);
#endif
    u_xlat16_5.xyz = (bool(u_xlatb21)) ? (-u_xlat10.yxz) : u_xlat10.yxz;
    u_xlat16_6.x = u_xlat16_5.y;
    u_xlat16_6.y = u_xlat16_4.z;
    u_xlat16_6.z = u_xlat16_3.x;
    u_xlat7.x = dot(u_xlat2.xyz, u_xlat16_6.xyz);
    u_xlat8.z = u_xlat2.z;
    u_xlat8.xy = u_xlat2.xy;
    u_xlat16_5.y = u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_5.z;
    u_xlat16_4.z = u_xlat16_3.z;
    u_xlat7.z = dot(u_xlat8.xyz, u_xlat16_4.xyz);
    u_xlat16_5.z = u_xlat16_3.y;
    u_xlat7.y = dot(u_xlat2.xyz, u_xlat16_5.xyz);
    u_xlat10.xyz = (-u_xlat16_3.xyz) + u_xlat7.xyz;
    u_xlat10.xyz = u_xlat0.xxx * u_xlat10.xyz + u_xlat16_3.xyz;
    u_xlat21 = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = u_xlat10.xyz * vec3(u_xlat21);
    u_xlat10.xyz = (-vs_TEXCOORD5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat21 = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat10.xyz = u_xlat10.xyz * vec3(u_xlat21);
    u_xlat21 = dot(u_xlat2.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat7.xyz = vec3(u_xlat21) * _LightColor0.xyz;
    u_xlat10_21.xy = texture(_ShadowMapTexture, u_xlat1.xy).xy;
    u_xlat7.xyz = u_xlat10_21.xxx * u_xlat7.xyz;
    u_xlat10_8.xyz = texture(_CameraAlbedoTexture, u_xlat1.xy).xyz;
    u_xlat10_3 = texture(_CameraSpecularTexture, u_xlat1.xy);
    u_xlat16_4.xyz = u_xlat10_8.xyz * _Color.xyz + (-u_xlat10_8.xyz);
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz + u_xlat10_8.xyz;
    u_xlat7.xyz = u_xlat16_4.xyz * u_xlat7.xyz;
    u_xlat8.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat16_5.xyz = u_xlat8.xyz * u_xlat1.xxx + u_xlat10.xyz;
    u_xlat16_34 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_34 = inversesqrt(u_xlat16_34);
    u_xlat16_5.xyz = vec3(u_xlat16_34) * u_xlat16_5.xyz;
    u_xlat10.x = dot(u_xlat10.xyz, u_xlat16_5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat20 = dot(u_xlat2.xyz, u_xlat16_5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat10.x = (-u_xlat10.x) + 1.0;
    u_xlat16_34 = u_xlat10.x * u_xlat10.x;
    u_xlat16_34 = u_xlat10.x * u_xlat16_34;
    u_xlat16_34 = u_xlat10.x * u_xlat16_34;
    u_xlat16_34 = u_xlat10.x * u_xlat16_34;
    u_xlat16_8.xyz = (-u_xlat10_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_8.xyz = vec3(u_xlat16_34) * u_xlat16_8.xyz;
    u_xlat10.x = u_xlat10_3.w + _AddingShininess;
    u_xlat10.x = min(u_xlat10.x, 0.5);
    u_xlat16_34 = (-u_xlat10.x) + 1.0;
    u_xlat16_10.x = u_xlat16_34 * u_xlat16_34;
    u_xlat16_30 = (-u_xlat16_10.x) * u_xlat16_10.x + 1.0;
    u_xlat16_10.x = u_xlat16_10.x * u_xlat16_10.x;
    u_xlat16_30 = u_xlat16_30 + u_xlat16_30;
    u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(u_xlat16_30) + u_xlat10_3.xyz;
    u_xlat30 = u_xlat20 * u_xlat16_10.x + (-u_xlat20);
    u_xlat20 = u_xlat30 * u_xlat20 + 1.0;
    u_xlat20 = u_xlat20 * u_xlat20;
    u_xlat20 = max(u_xlat20, 9.99999997e-07);
    u_xlat10.x = u_xlat16_10.x / u_xlat20;
    u_xlat10.x = u_xlat10.x * 0.318309873;
    u_xlat10.x = min(u_xlat10.x, 64.0);
    u_xlat9.xyz = u_xlat16_8.xyz * u_xlat10.xxx;
    u_xlat10.xyz = u_xlat10.xxx * u_xlat16_8.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat10.xyz = u_xlat9.xyz / u_xlat10.xyz;
    u_xlat10.xyz = u_xlat10.xyz + u_xlat10.xyz;
    u_xlat10.xyz = u_xlat10.xyz * _LightColor0.xyz;
    u_xlat10.xyz = u_xlat10_21.xxx * u_xlat10.xyz;
    u_xlat16_1.x = u_xlat10_21.y + -1.0;
    u_xlat16_1.x = u_xlat16_1.x * 0.349999994 + 1.0;
    u_xlat10.xyz = u_xlat10.xyz * u_xlat16_1.xxx;
    u_xlat16_5.xyz = abs(u_xlat16_4.xyz) + vec3(0.00100000005, 0.00100000005, 0.00100000005);
    u_xlat16_11.xyz = log2(u_xlat16_5.xyz);
    u_xlat16_37 = (-u_xlat16_1.x) * 0.5 + 0.5;
    u_xlat16_37 = max(u_xlat16_37, 0.00100000005);
    u_xlat16_11.xyz = u_xlat16_11.xyz * vec3(u_xlat16_37);
    u_xlat16_11.xyz = exp2(u_xlat16_11.xyz);
    u_xlat10.xyz = u_xlat7.xyz * u_xlat16_11.xyz + u_xlat10.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_5.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_5.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_5.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_5.xyz = u_xlat16_5.xyz + vs_TEXCOORD6.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz;
    u_xlat10.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz + u_xlat10.xyz;
    SV_Target0.xyz = u_xlat0.xxx * u_xlat10.xyz;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" "MSAA_INTERPOLATION" }
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat1.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    u_xlat0.x = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * hlslcc_mtx4x4unity_ObjectToWorld[2].xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * hlslcc_mtx4x4unity_ObjectToWorld[0].xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat16_3.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_3.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_3.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD6.xyz = u_xlat16_3.xyz;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 _Color;
uniform 	float _NormalMultiplier;
uniform 	float _AngleLimit;
uniform 	mediump vec4 _LightColor0;
uniform 	float _Opacity;
uniform 	float _AddingShininess;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _ShadowMapTexture;
uniform lowp sampler2DMS _CameraNormalsTexture;
uniform lowp sampler2DMS _CameraAlbedoTexture;
uniform lowp sampler2DMS _CameraSpecularTexture;
uniform lowp sampler2DMS _CameraDepthTextureMS;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec2 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec2 u_xlat10_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
uvec4 u_xlatu2;
vec3 u_xlat3;
bvec3 u_xlatb3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
vec3 u_xlat9;
vec3 u_xlat10;
mediump vec3 u_xlat16_10;
bool u_xlatb10;
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
float u_xlat20;
mediump float u_xlat16_20;
lowp float u_xlat10_20;
bool u_xlatb20;
vec2 u_xlat21;
bool u_xlatb21;
float u_xlat30;
mediump float u_xlat16_30;
mediump float u_xlat16_34;
void main()
{
    u_xlat0.x = _ProjectionParams.z / vs_TEXCOORD2.z;
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat21.xy = u_xlat1.xy * _ScreenParams.xy;
    u_xlat10_1.xy = texture(_ShadowMapTexture, u_xlat1.xy).xy;
    u_xlat21.xy = floor(u_xlat21.xy);
    u_xlatu2.xy = uvec2(ivec2(u_xlat21.xy));
    u_xlatu2.z = uint(uint(0u));
    u_xlatu2.w = uint(uint(0u));
    u_xlat30 = texelFetch(_CameraDepthTextureMS, ivec2(u_xlatu2.xy), 0).x;
    u_xlat30 = _ZBufferParams.x * u_xlat30 + _ZBufferParams.y;
    u_xlat30 = float(1.0) / u_xlat30;
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat3.xyz = -abs(u_xlat0.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlatb3.xyz = lessThan(u_xlat3.xyzx, vec4(0.0, 0.0, 0.0, 0.0)).xyz;
    u_xlatb20 = u_xlatb3.y || u_xlatb3.x;
    u_xlatb20 = u_xlatb3.z || u_xlatb20;
    if((int(u_xlatb20) * int(0xffffffffu))!=0){discard;}
    u_xlat3.xyz = texelFetch(_CameraNormalsTexture, ivec2(u_xlatu2.xy), 0).xyz;
    u_xlat16_4.xyz = u_xlat3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_20 = dot(u_xlat16_4.xyz, vs_TEXCOORD3.xyz);
    u_xlat20 = u_xlat16_20 + (-_AngleLimit);
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(u_xlat20<0.0);
#else
    u_xlatb20 = u_xlat20<0.0;
#endif
    if((int(u_xlatb20) * int(0xffffffffu))!=0){discard;}
    u_xlat0.w = (-u_xlat0.x);
    u_xlat0.xy = vec2(u_xlat0.w + float(0.5), u_xlat0.y + float(0.5));
    u_xlat10_20 = texture(_MaskTex, u_xlat0.xy).x;
    u_xlat10_0.xyw = texture(_NormalTex, u_xlat0.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_0.xyw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_34 = u_xlat10_20 * _Opacity + -0.00100000005;
    u_xlat0.x = u_xlat10_20 * _Opacity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat16_34<0.0);
#else
    u_xlatb10 = u_xlat16_34<0.0;
#endif
    if((int(u_xlatb10) * int(0xffffffffu))!=0){discard;}
    u_xlat3.z = u_xlat16_5.z;
    u_xlat3.xy = u_xlat16_5.xy * vec2(_NormalMultiplier);
    u_xlat16_5.xyz = vs_TEXCOORD3.xyz * vs_TEXCOORD4.zxy;
    u_xlat16_5.xyz = vs_TEXCOORD3.zxy * vs_TEXCOORD4.xyz + (-u_xlat16_5.xyz);
    u_xlat16_10.xyz = u_xlat16_4.zxy * u_xlat16_5.xyz;
    u_xlat10.xyz = u_xlat16_4.yzx * u_xlat16_5.yzx + (-u_xlat16_10.xyz);
    u_xlat21.x = dot(vs_TEXCOORD4.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(u_xlat21.x));
#else
    u_xlatb21 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(u_xlat21.x);
#endif
    u_xlat16_6.xyz = (bool(u_xlatb21)) ? (-u_xlat10.yxz) : u_xlat10.yxz;
    u_xlat16_7.x = u_xlat16_6.y;
    u_xlat16_7.z = u_xlat16_4.x;
    u_xlat16_7.y = u_xlat16_5.z;
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat16_7.xyz);
    u_xlat9.z = u_xlat3.z;
    u_xlat16_6.y = u_xlat16_5.x;
    u_xlat9.xy = u_xlat3.xy;
    u_xlat16_5.x = u_xlat16_6.z;
    u_xlat16_5.z = u_xlat16_4.z;
    u_xlat8.z = dot(u_xlat9.xyz, u_xlat16_5.xyz);
    u_xlat16_6.z = u_xlat16_4.y;
    u_xlat8.y = dot(u_xlat3.xyz, u_xlat16_6.xyz);
    u_xlat10.xyz = (-u_xlat16_4.xyz) + u_xlat8.xyz;
    u_xlat10.xyz = u_xlat0.xxx * u_xlat10.xyz + u_xlat16_4.xyz;
    u_xlat21.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat21.x = inversesqrt(u_xlat21.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat21.xxx;
    u_xlat3.xyz = (-vs_TEXCOORD5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat21.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21.x = inversesqrt(u_xlat21.x);
    u_xlat3.xyz = u_xlat21.xxx * u_xlat3.xyz;
    u_xlat21.x = dot(u_xlat10.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat21.x = min(max(u_xlat21.x, 0.0), 1.0);
#else
    u_xlat21.x = clamp(u_xlat21.x, 0.0, 1.0);
#endif
    u_xlat8.xyz = u_xlat21.xxx * _LightColor0.xyz;
    u_xlat8.xyz = u_xlat10_1.xxx * u_xlat8.xyz;
    u_xlat9.xyz = texelFetch(_CameraAlbedoTexture, ivec2(u_xlatu2.xy), 0).xyz;
    u_xlat2 = texelFetch(_CameraSpecularTexture, ivec2(u_xlatu2.xy), 0);
    u_xlat16_4.xyz = u_xlat9.xyz * _Color.xyz + (-u_xlat9.xyz);
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz + u_xlat9.xyz;
    u_xlat8.xyz = u_xlat16_4.xyz * u_xlat8.xyz;
    u_xlat9.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21.x = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat21.x = inversesqrt(u_xlat21.x);
    u_xlat16_5.xyz = u_xlat9.xyz * u_xlat21.xxx + u_xlat3.xyz;
    u_xlat16_34 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_34 = inversesqrt(u_xlat16_34);
    u_xlat16_5.xyz = vec3(u_xlat16_34) * u_xlat16_5.xyz;
    u_xlat21.x = dot(u_xlat3.xyz, u_xlat16_5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat21.x = min(max(u_xlat21.x, 0.0), 1.0);
#else
    u_xlat21.x = clamp(u_xlat21.x, 0.0, 1.0);
#endif
    u_xlat10.x = dot(u_xlat10.xyz, u_xlat16_5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat20 = (-u_xlat21.x) + 1.0;
    u_xlat16_34 = u_xlat20 * u_xlat20;
    u_xlat16_34 = u_xlat20 * u_xlat16_34;
    u_xlat16_34 = u_xlat20 * u_xlat16_34;
    u_xlat16_34 = u_xlat20 * u_xlat16_34;
    u_xlat3.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat3.xyz = vec3(u_xlat16_34) * u_xlat3.xyz;
    u_xlat20 = u_xlat2.w + _AddingShininess;
    u_xlat20 = min(u_xlat20, 0.5);
    u_xlat16_34 = (-u_xlat20) + 1.0;
    u_xlat16_20 = u_xlat16_34 * u_xlat16_34;
    u_xlat16_30 = (-u_xlat16_20) * u_xlat16_20 + 1.0;
    u_xlat16_20 = u_xlat16_20 * u_xlat16_20;
    u_xlat16_30 = u_xlat16_30 + u_xlat16_30;
    u_xlat2.xyz = u_xlat3.xyz * vec3(u_xlat16_30) + u_xlat2.xyz;
    u_xlat30 = u_xlat10.x * u_xlat16_20 + (-u_xlat10.x);
    u_xlat10.x = u_xlat30 * u_xlat10.x + 1.0;
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat10.x = max(u_xlat10.x, 9.99999997e-07);
    u_xlat10.x = u_xlat16_20 / u_xlat10.x;
    u_xlat10.x = u_xlat10.x * 0.318309873;
    u_xlat10.x = min(u_xlat10.x, 64.0);
    u_xlat3.xyz = u_xlat2.xyz * u_xlat10.xxx;
    u_xlat10.xyz = u_xlat10.xxx * u_xlat2.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat10.xyz = u_xlat3.xyz / u_xlat10.xyz;
    u_xlat10.xyz = u_xlat10.xyz + u_xlat10.xyz;
    u_xlat10.xyz = u_xlat10.xyz * _LightColor0.xyz;
    u_xlat10.xyz = u_xlat10_1.xxx * u_xlat10.xyz;
    u_xlat16_1.x = u_xlat10_1.y + -1.0;
    u_xlat16_1.x = u_xlat16_1.x * 0.349999994 + 1.0;
    u_xlat10.xyz = u_xlat10.xyz * u_xlat16_1.xxx;
    u_xlat16_5.xyz = abs(u_xlat16_4.xyz) + vec3(0.00100000005, 0.00100000005, 0.00100000005);
    u_xlat16_11.xyz = log2(u_xlat16_5.xyz);
    u_xlat16_2 = (-u_xlat16_1.x) * 0.5 + 0.5;
    u_xlat12.xyz = u_xlat16_1.xxx * vs_TEXCOORD6.xyz;
    u_xlat16_1.x = max(u_xlat16_2, 0.00100000005);
    u_xlat16_1.xyz = u_xlat16_11.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat10.xyz = u_xlat8.xyz * u_xlat16_1.xyz + u_xlat10.xyz;
    u_xlat10.xyz = u_xlat12.xyz * u_xlat16_4.xyz + u_xlat10.xyz;
    SV_Target0.xyz = u_xlat0.xxx * u_xlat10.xyz;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" "INSTANCING_ON" "MSAA_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
mediump vec4 u_xlat16_0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat6.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat6.x * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat6.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat2.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat2.zzz + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat2.www + u_xlat6.xyz;
    vs_TEXCOORD2.xyz = u_xlat6.xyz * vec3(-1.0, -1.0, 1.0);
    u_xlat6.x = dot(unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz;
    vs_TEXCOORD3.xyz = u_xlat6.xyz;
    u_xlat1.x = dot(unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat16_4.x = u_xlat6.y * u_xlat6.y;
    u_xlat16_4.x = u_xlat6.x * u_xlat6.x + (-u_xlat16_4.x);
    u_xlat16_0 = u_xlat6.yzzx * u_xlat6.xyzz;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_5.xyz;
    vs_TEXCOORD6.xyz = u_xlat16_4.xyz;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _Color;
uniform 	float _NormalMultiplier;
uniform 	float _AngleLimit;
uniform 	mediump vec4 _LightColor0;
uniform 	float _Opacity;
uniform 	float _AddingShininess;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _ShadowMapTexture;
uniform lowp sampler2DMS _CameraNormalsTexture;
uniform lowp sampler2DMS _CameraAlbedoTexture;
uniform lowp sampler2DMS _CameraSpecularTexture;
uniform lowp sampler2DMS _CameraDepthTextureMS;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD6;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec2 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec2 u_xlat10_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
uvec4 u_xlatu2;
vec4 u_xlat3;
bvec3 u_xlatb3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
vec3 u_xlat9;
vec3 u_xlat10;
mediump vec3 u_xlat16_10;
bool u_xlatb10;
mediump vec3 u_xlat16_11;
float u_xlat20;
mediump float u_xlat16_20;
lowp float u_xlat10_20;
bool u_xlatb20;
vec2 u_xlat21;
bool u_xlatb21;
float u_xlat30;
mediump float u_xlat16_30;
int u_xlati30;
mediump float u_xlat16_34;
void main()
{
    u_xlat0.x = _ProjectionParams.z / vs_TEXCOORD2.z;
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat21.xy = u_xlat1.xy * _ScreenParams.xy;
    u_xlat10_1.xy = texture(_ShadowMapTexture, u_xlat1.xy).xy;
    u_xlat21.xy = floor(u_xlat21.xy);
    u_xlatu2.xy = uvec2(ivec2(u_xlat21.xy));
    u_xlatu2.z = uint(uint(0u));
    u_xlatu2.w = uint(uint(0u));
    u_xlat30 = texelFetch(_CameraDepthTextureMS, ivec2(u_xlatu2.xy), 0).x;
    u_xlat30 = _ZBufferParams.x * u_xlat30 + _ZBufferParams.y;
    u_xlat30 = float(1.0) / u_xlat30;
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    u_xlati30 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlati30 = u_xlati30 << 3;
    u_xlat3.xyz = u_xlat0.yyy * unity_Builtins0Array[u_xlati30 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati30 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati30 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz * u_xlat0.zzz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz + unity_Builtins0Array[u_xlati30 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3].xyz;
    u_xlat3.xyz = -abs(u_xlat0.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlatb3.xyz = lessThan(u_xlat3.xyzx, vec4(0.0, 0.0, 0.0, 0.0)).xyz;
    u_xlatb20 = u_xlatb3.y || u_xlatb3.x;
    u_xlatb20 = u_xlatb3.z || u_xlatb20;
    if((int(u_xlatb20) * int(0xffffffffu))!=0){discard;}
    u_xlat3.xyz = texelFetch(_CameraNormalsTexture, ivec2(u_xlatu2.xy), 0).xyz;
    u_xlat16_4.xyz = u_xlat3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_20 = dot(u_xlat16_4.xyz, vs_TEXCOORD3.xyz);
    u_xlat20 = u_xlat16_20 + (-_AngleLimit);
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(u_xlat20<0.0);
#else
    u_xlatb20 = u_xlat20<0.0;
#endif
    if((int(u_xlatb20) * int(0xffffffffu))!=0){discard;}
    u_xlat0.w = (-u_xlat0.x);
    u_xlat0.xy = vec2(u_xlat0.w + float(0.5), u_xlat0.y + float(0.5));
    u_xlat10_20 = texture(_MaskTex, u_xlat0.xy).x;
    u_xlat10_0.xyw = texture(_NormalTex, u_xlat0.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_0.xyw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_34 = u_xlat10_20 * _Opacity + -0.00100000005;
    u_xlat0.x = u_xlat10_20 * _Opacity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat16_34<0.0);
#else
    u_xlatb10 = u_xlat16_34<0.0;
#endif
    if((int(u_xlatb10) * int(0xffffffffu))!=0){discard;}
    u_xlat3.z = u_xlat16_5.z;
    u_xlat3.xy = u_xlat16_5.xy * vec2(_NormalMultiplier);
    u_xlat16_5.xyz = vs_TEXCOORD3.xyz * vs_TEXCOORD4.zxy;
    u_xlat16_5.xyz = vs_TEXCOORD3.zxy * vs_TEXCOORD4.xyz + (-u_xlat16_5.xyz);
    u_xlat16_10.xyz = u_xlat16_4.zxy * u_xlat16_5.xyz;
    u_xlat10.xyz = u_xlat16_4.yzx * u_xlat16_5.yzx + (-u_xlat16_10.xyz);
    u_xlat21.x = dot(vs_TEXCOORD4.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(u_xlat21.x));
#else
    u_xlatb21 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(u_xlat21.x);
#endif
    u_xlat16_6.xyz = (bool(u_xlatb21)) ? (-u_xlat10.yxz) : u_xlat10.yxz;
    u_xlat16_7.x = u_xlat16_6.y;
    u_xlat16_7.z = u_xlat16_4.x;
    u_xlat16_7.y = u_xlat16_5.z;
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat16_7.xyz);
    u_xlat9.z = u_xlat3.z;
    u_xlat9.xy = u_xlat3.xy;
    u_xlat16_6.y = u_xlat16_5.x;
    u_xlat16_5.x = u_xlat16_6.z;
    u_xlat16_5.z = u_xlat16_4.z;
    u_xlat8.z = dot(u_xlat9.xyz, u_xlat16_5.xyz);
    u_xlat16_6.z = u_xlat16_4.y;
    u_xlat8.y = dot(u_xlat3.xyz, u_xlat16_6.xyz);
    u_xlat10.xyz = (-u_xlat16_4.xyz) + u_xlat8.xyz;
    u_xlat10.xyz = u_xlat0.xxx * u_xlat10.xyz + u_xlat16_4.xyz;
    u_xlat21.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat21.x = inversesqrt(u_xlat21.x);
    u_xlat3.xyz = u_xlat10.xyz * u_xlat21.xxx;
    u_xlat10.xyz = (-vs_TEXCOORD5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat21.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat21.x = inversesqrt(u_xlat21.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat21.xxx;
    u_xlat21.x = dot(u_xlat3.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat21.x = min(max(u_xlat21.x, 0.0), 1.0);
#else
    u_xlat21.x = clamp(u_xlat21.x, 0.0, 1.0);
#endif
    u_xlat8.xyz = u_xlat21.xxx * _LightColor0.xyz;
    u_xlat8.xyz = u_xlat10_1.xxx * u_xlat8.xyz;
    u_xlat9.xyz = texelFetch(_CameraAlbedoTexture, ivec2(u_xlatu2.xy), 0).xyz;
    u_xlat2 = texelFetch(_CameraSpecularTexture, ivec2(u_xlatu2.xy), 0);
    u_xlat16_4.xyz = u_xlat9.xyz * _Color.xyz + (-u_xlat9.xyz);
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz + u_xlat9.xyz;
    u_xlat8.xyz = u_xlat16_4.xyz * u_xlat8.xyz;
    u_xlat9.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21.x = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat21.x = inversesqrt(u_xlat21.x);
    u_xlat16_5.xyz = u_xlat9.xyz * u_xlat21.xxx + u_xlat10.xyz;
    u_xlat16_34 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_34 = inversesqrt(u_xlat16_34);
    u_xlat16_5.xyz = vec3(u_xlat16_34) * u_xlat16_5.xyz;
    u_xlat10.x = dot(u_xlat10.xyz, u_xlat16_5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat20 = dot(u_xlat3.xyz, u_xlat16_5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat10.x = (-u_xlat10.x) + 1.0;
    u_xlat16_34 = u_xlat10.x * u_xlat10.x;
    u_xlat16_34 = u_xlat10.x * u_xlat16_34;
    u_xlat16_34 = u_xlat10.x * u_xlat16_34;
    u_xlat16_34 = u_xlat10.x * u_xlat16_34;
    u_xlat9.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat9.xyz = vec3(u_xlat16_34) * u_xlat9.xyz;
    u_xlat10.x = u_xlat2.w + _AddingShininess;
    u_xlat10.x = min(u_xlat10.x, 0.5);
    u_xlat16_34 = (-u_xlat10.x) + 1.0;
    u_xlat16_10.x = u_xlat16_34 * u_xlat16_34;
    u_xlat16_30 = (-u_xlat16_10.x) * u_xlat16_10.x + 1.0;
    u_xlat16_10.x = u_xlat16_10.x * u_xlat16_10.x;
    u_xlat16_30 = u_xlat16_30 + u_xlat16_30;
    u_xlat2.xyz = u_xlat9.xyz * vec3(u_xlat16_30) + u_xlat2.xyz;
    u_xlat30 = u_xlat20 * u_xlat16_10.x + (-u_xlat20);
    u_xlat20 = u_xlat30 * u_xlat20 + 1.0;
    u_xlat20 = u_xlat20 * u_xlat20;
    u_xlat20 = max(u_xlat20, 9.99999997e-07);
    u_xlat10.x = u_xlat16_10.x / u_xlat20;
    u_xlat10.x = u_xlat10.x * 0.318309873;
    u_xlat10.x = min(u_xlat10.x, 64.0);
    u_xlat9.xyz = u_xlat2.xyz * u_xlat10.xxx;
    u_xlat10.xyz = u_xlat10.xxx * u_xlat2.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat10.xyz = u_xlat9.xyz / u_xlat10.xyz;
    u_xlat10.xyz = u_xlat10.xyz + u_xlat10.xyz;
    u_xlat10.xyz = u_xlat10.xyz * _LightColor0.xyz;
    u_xlat10.xyz = u_xlat10_1.xxx * u_xlat10.xyz;
    u_xlat16_1.x = u_xlat10_1.y + -1.0;
    u_xlat16_1.x = u_xlat16_1.x * 0.349999994 + 1.0;
    u_xlat10.xyz = u_xlat10.xyz * u_xlat16_1.xxx;
    u_xlat16_5.xyz = abs(u_xlat16_4.xyz) + vec3(0.00100000005, 0.00100000005, 0.00100000005);
    u_xlat16_11.xyz = log2(u_xlat16_5.xyz);
    u_xlat16_2 = (-u_xlat16_1.x) * 0.5 + 0.5;
    u_xlat16_2 = max(u_xlat16_2, 0.00100000005);
    u_xlat16_11.xyz = u_xlat16_11.xyz * vec3(u_xlat16_2);
    u_xlat16_11.xyz = exp2(u_xlat16_11.xyz);
    u_xlat10.xyz = u_xlat8.xyz * u_xlat16_11.xyz + u_xlat10.xyz;
    u_xlat3.w = 1.0;
    u_xlat16_5.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_5.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_5.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_5.xyz = u_xlat16_5.xyz + vs_TEXCOORD6.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz;
    u_xlat10.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz + u_xlat10.xyz;
    SV_Target0.xyz = u_xlat0.xxx * u_xlat10.xyz;
    SV_Target0.w = u_xlat0.x;
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
Keywords { "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 " {
Keywords { "LIGHTPROBE_SH" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "LIGHTPROBE_SH" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "LIGHTPROBE_SH" "INSTANCING_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_HDR_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_HDR_ON" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_HDR_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_HDR_ON" "INSTANCING_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
""
}
SubProgram "gles3 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" "INSTANCING_ON" "MSAA_INTERPOLATION" }
""
}
}
}
}
}