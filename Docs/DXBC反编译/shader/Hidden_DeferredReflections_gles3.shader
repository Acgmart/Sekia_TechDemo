//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/DeferredReflections" {
Properties {
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  GpuProgramID 50237
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
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
    u_xlat2 = u_xlat0.y * _ProjectionParams.x;
    u_xlat0.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.w = u_xlat2 * 0.5;
    u_xlat0.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD0.zw = u_xlat0.xy * _ScreenParams.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD1.xyz = in_NORMAL0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#extension GL_ARB_texture_query_levels : enable
#extension GL_ARB_shader_image_size : enable
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _ReflectionSkyCubeMap_HDR;
uniform 	vec4 _SsrLightingParams;
uniform 	vec4 _SpecCube0_ProbePosition;
uniform 	vec4 _SpecCube0_BoxMin;
uniform 	vec4 _SpecCube0_BoxMax;
uniform 	vec4 _SpecCube0_HDR;
uniform 	vec4 _SpecCube1_ProbePosition;
uniform 	vec4 _SpecCube1_BoxMin;
uniform 	vec4 _SpecCube1_BoxMax;
uniform 	vec4 _SpecCube1_HDR;
uniform 	vec4 _SpecCube2_ProbePosition;
uniform 	vec4 _SpecCube2_BoxMin;
uniform 	vec4 _SpecCube2_BoxMax;
uniform 	vec4 _SpecCube2_HDR;
uniform 	vec4 _SpecCube3_ProbePosition;
uniform 	vec4 _SpecCube3_BoxMin;
uniform 	vec4 _SpecCube3_BoxMax;
uniform 	vec4 _SpecCube3_HDR;
uniform 	vec4 _SpecCube4_ProbePosition;
uniform 	vec4 _SpecCube4_BoxMin;
uniform 	vec4 _SpecCube4_BoxMax;
uniform 	vec4 _SpecCube4_HDR;
uniform 	vec4 _SpecCube5_ProbePosition;
uniform 	vec4 _SpecCube5_BoxMin;
uniform 	vec4 _SpecCube5_BoxMax;
uniform 	vec4 _SpecCube5_HDR;
uniform 	vec4 _SpecCube6_ProbePosition;
uniform 	vec4 _SpecCube6_BoxMin;
uniform 	vec4 _SpecCube6_BoxMax;
uniform 	vec4 _SpecCube6_HDR;
uniform 	vec4 _SpecCube7_ProbePosition;
uniform 	vec4 _SpecCube7_BoxMin;
uniform 	vec4 _SpecCube7_BoxMax;
uniform 	vec4 _SpecCube7_HDR;
uniform lowp sampler2D _CameraNormalsTexture;
uniform lowp sampler2D _CameraSpecularTexture;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _EnvBRDF;
uniform lowp samplerCube _ReflectionSkyCubeMap;
uniform lowp sampler2D _SsrPyramid;
uniform lowp samplerCube _SpecCube0;
uniform lowp samplerCube _SpecCube1;
uniform lowp samplerCube _SpecCube2;
uniform lowp samplerCube _SpecCube3;
uniform lowp samplerCube _SpecCube4;
uniform lowp samplerCube _SpecCube5;
uniform lowp samplerCube _SpecCube6;
uniform lowp samplerCube _SpecCube7;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
lowp vec2 u_xlat10_3;
ivec4 u_xlati3;
vec4 u_xlat4;
mediump vec4 u_xlat16_4;
bvec4 u_xlatb4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp vec4 u_xlat10_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
bvec3 u_xlatb9;
vec3 u_xlat10;
vec3 u_xlat11;
vec3 u_xlat12;
float u_xlat29;
float u_xlat39;
mediump float u_xlat16_39;
int u_xlati39;
bool u_xlatb39;
float u_xlat41;
uint u_xlatu41;
bool u_xlatb41;
float u_xlat42;
bool u_xlatb42;
void main()
{
    u_xlat10_0.xyz = texture(_CameraNormalsTexture, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_0 = texture(_CameraSpecularTexture, vs_TEXCOORD0.xy);
    u_xlat2.x = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat2.x = _ZBufferParams.x * u_xlat2.x + _ZBufferParams.y;
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat2.xyz = vs_TEXCOORD1.xyz * u_xlat2.xxx + _WorldSpaceCameraPos.xyz;
    u_xlat41 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat41 = inversesqrt(u_xlat41);
    u_xlat3.xyz = vec3(u_xlat41) * vs_TEXCOORD1.xyz;
    u_xlat4.y = (-u_xlat10_0.w) + 1.0;
    u_xlat39 = u_xlat4.y * u_xlat4.y;
    u_xlat41 = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat41 = u_xlat41 + u_xlat41;
    u_xlat5.xyz = u_xlat16_1.xyz * (-vec3(u_xlat41)) + u_xlat3.xyz;
    u_xlat4.x = dot(u_xlat16_1.xyz, (-u_xlat3.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat3.xy = u_xlat4.xy * vec2(0.937749982, 0.937749982) + vec2(0.0311249997, 0.0311249997);
    u_xlat10_3.xy = texture(_EnvBRDF, u_xlat3.xy).xy;
    u_xlatu41 = uint(textureQueryLevels(_SsrPyramid));
    u_xlatu41 = u_xlatu41 + 4294967292u;
    u_xlat29 = (-_SsrLightingParams.y) * 4.0 + 2.45000005;
    u_xlat39 = log2(u_xlat39);
    u_xlat39 = u_xlat39 * u_xlat29;
    u_xlat39 = exp2(u_xlat39);
    u_xlat41 = float(u_xlatu41);
    u_xlat39 = u_xlat39 * u_xlat41;
    u_xlat39 = min(u_xlat41, u_xlat39);
    u_xlat1 = textureLod(_SsrPyramid, vs_TEXCOORD0.xy, u_xlat39);
    u_xlat16_0.xyz = u_xlat10_3.xxx * u_xlat10_0.xyz + u_xlat10_3.yyy;
    u_xlat1.xyz = u_xlat16_0.xyz * u_xlat1.xyz;
    u_xlati3.xyz = ivec3(uvec3(notEqual(u_xlat1.xyzx, u_xlat1.xyzx).xyz) * 0xFFFFFFFFu);
    u_xlati3.w = 0;
    u_xlati3.xy = ivec2(uvec2(uint(u_xlati3.z) | uint(u_xlati3.x), uint(u_xlati3.w) | uint(u_xlati3.y)));
    u_xlati39 = int(uint(u_xlati3.y) | uint(u_xlati3.x));
    u_xlat1 = (int(u_xlati39) != 0) ? vec4(0.0, 0.0, 0.0, 0.0) : u_xlat1;
    u_xlat3.x = sin(_SpecCube0_BoxMin.w);
    u_xlat4.x = cos(_SpecCube0_BoxMin.w);
    u_xlat6.x = (-u_xlat3.x);
    u_xlat16_7.xy = u_xlat2.xz + (-_SpecCube0_ProbePosition.xz);
    u_xlat6.y = u_xlat4.x;
    u_xlat4.x = dot(u_xlat6.yx, u_xlat16_7.xy);
    u_xlat6.z = u_xlat3.x;
    u_xlat4.z = dot(u_xlat6.zy, u_xlat16_7.xy);
    u_xlat3.xz = u_xlat4.xz + _SpecCube0_ProbePosition.xz;
    u_xlat3.y = u_xlat2.y;
    u_xlat16_7.xyz = u_xlat3.xyz + (-_SpecCube0_BoxMax.xyz);
    u_xlat16_8.xyz = (-u_xlat3.xyz) + _SpecCube0_BoxMin.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, u_xlat16_8.xyz);
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_39 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_39 = sqrt(u_xlat16_39);
    u_xlat39 = u_xlat16_39 / _SpecCube0_BoxMax.w;
    u_xlat39 = (-u_xlat39) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb41 = !!(0.0>=u_xlat39);
#else
    u_xlatb41 = 0.0>=u_xlat39;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb42 = !!(u_xlat1.w>=1.0);
#else
    u_xlatb42 = u_xlat1.w>=1.0;
#endif
    u_xlatb41 = u_xlatb41 || u_xlatb42;
    if(!u_xlatb41){
        u_xlat41 = u_xlat4.y * 6.0;
#ifdef UNITY_ADRENO_ES3
        u_xlatb42 = !!(0.0<_SpecCube0_ProbePosition.w);
#else
        u_xlatb42 = 0.0<_SpecCube0_ProbePosition.w;
#endif
        if(u_xlatb42){
            u_xlat4.xzw = _SpecCube0_BoxMin.xyz + (-_SpecCube0_BoxMax.www);
            u_xlat9.xyz = _SpecCube0_BoxMax.www + _SpecCube0_BoxMax.xyz;
            u_xlat42 = dot(u_xlat5.xyz, u_xlat5.xyz);
            u_xlat42 = inversesqrt(u_xlat42);
            u_xlat10.xyz = vec3(u_xlat42) * u_xlat5.xyz;
            u_xlat11.xyz = u_xlat2.xyz + (-_SpecCube0_ProbePosition.xyz);
            u_xlat12.x = dot(u_xlat6.yx, u_xlat11.xz);
            u_xlat12.z = dot(u_xlat6.zy, u_xlat11.xz);
            u_xlat3.xz = u_xlat12.xz + _SpecCube0_ProbePosition.xz;
            u_xlat12.x = dot(u_xlat6.yx, u_xlat10.xz);
            u_xlat12.z = dot(u_xlat6.zy, u_xlat10.xz);
            u_xlat6.xyz = (-u_xlat3.xyz) + u_xlat9.xyz;
            u_xlat12.y = u_xlat10.y;
            u_xlat6.xyz = u_xlat6.xyz / u_xlat12.xyz;
            u_xlat4.xzw = (-u_xlat3.xyz) + u_xlat4.xzw;
            u_xlat4.xzw = u_xlat4.xzw / u_xlat12.xyz;
            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat12.xyzx).xyz;
            u_xlat4.x = (u_xlatb9.x) ? u_xlat6.x : u_xlat4.x;
            u_xlat4.z = (u_xlatb9.y) ? u_xlat6.y : u_xlat4.z;
            u_xlat4.w = (u_xlatb9.z) ? u_xlat6.z : u_xlat4.w;
            u_xlat42 = min(u_xlat4.z, u_xlat4.x);
            u_xlat42 = min(u_xlat4.w, u_xlat42);
            u_xlat4.xzw = u_xlat10.xyz * vec3(u_xlat42) + u_xlat11.xyz;
        } else {
            u_xlat4.xzw = u_xlat5.xyz;
        //ENDIF
        }
        u_xlat10_6 = textureLod(_SpecCube0, u_xlat4.xzw, u_xlat41);
        u_xlat16_7.x = u_xlat10_6.w + -1.0;
        u_xlat16_7.x = _SpecCube0_HDR.w * u_xlat16_7.x + 1.0;
        u_xlat16_7.x = log2(u_xlat16_7.x);
        u_xlat16_7.x = u_xlat16_7.x * _SpecCube0_HDR.y;
        u_xlat16_7.x = exp2(u_xlat16_7.x);
        u_xlat16_7.x = u_xlat16_7.x * _SpecCube0_HDR.x;
        u_xlat16_7.xyz = u_xlat10_6.xyz * u_xlat16_7.xxx;
        u_xlat16_4.xzw = u_xlat16_0.xyz * u_xlat16_7.xyz;
        u_xlat41 = (-u_xlat1.w) + 1.0;
        u_xlat41 = min(u_xlat39, u_xlat41);
        u_xlat1.xyz = u_xlat16_4.xzw * vec3(u_xlat41) + u_xlat1.xyz;
        u_xlat1.w = u_xlat39 + u_xlat1.w;
    //ENDIF
    }
    u_xlat4.x = sin(_SpecCube1_BoxMin.w);
    u_xlat6.x = cos(_SpecCube1_BoxMin.w);
    u_xlat9.x = (-u_xlat4.x);
    u_xlat16_7.xy = u_xlat2.xz + (-_SpecCube1_ProbePosition.xz);
    u_xlat9.y = u_xlat6.x;
    u_xlat6.x = dot(u_xlat9.yx, u_xlat16_7.xy);
    u_xlat9.z = u_xlat4.x;
    u_xlat6.z = dot(u_xlat9.zy, u_xlat16_7.xy);
    u_xlat3.xz = u_xlat6.xz + _SpecCube1_ProbePosition.xz;
    u_xlat16_7.xyz = u_xlat3.xyz + (-_SpecCube1_BoxMax.xyz);
    u_xlat16_8.xyz = (-u_xlat3.xyz) + _SpecCube1_BoxMin.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, u_xlat16_8.xyz);
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_39 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_39 = sqrt(u_xlat16_39);
    u_xlat39 = u_xlat16_39 / _SpecCube1_BoxMax.w;
    u_xlat39 = (-u_xlat39) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb41 = !!(0.0>=u_xlat39);
#else
    u_xlatb41 = 0.0>=u_xlat39;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb42 = !!(u_xlat1.w>=1.0);
#else
    u_xlatb42 = u_xlat1.w>=1.0;
#endif
    u_xlatb41 = u_xlatb41 || u_xlatb42;
    if(!u_xlatb41){
        u_xlat41 = u_xlat4.y * 6.0;
#ifdef UNITY_ADRENO_ES3
        u_xlatb42 = !!(0.0<_SpecCube1_ProbePosition.w);
#else
        u_xlatb42 = 0.0<_SpecCube1_ProbePosition.w;
#endif
        if(u_xlatb42){
            u_xlat4.xzw = _SpecCube1_BoxMin.xyz + (-_SpecCube1_BoxMax.www);
            u_xlat6.xyz = _SpecCube1_BoxMax.www + _SpecCube1_BoxMax.xyz;
            u_xlat42 = dot(u_xlat5.xyz, u_xlat5.xyz);
            u_xlat42 = inversesqrt(u_xlat42);
            u_xlat10.xyz = vec3(u_xlat42) * u_xlat5.xyz;
            u_xlat11.xyz = u_xlat2.xyz + (-_SpecCube1_ProbePosition.xyz);
            u_xlat12.x = dot(u_xlat9.yx, u_xlat11.xz);
            u_xlat12.z = dot(u_xlat9.zy, u_xlat11.xz);
            u_xlat3.xz = u_xlat12.xz + _SpecCube1_ProbePosition.xz;
            u_xlat12.x = dot(u_xlat9.yx, u_xlat10.xz);
            u_xlat12.z = dot(u_xlat9.zy, u_xlat10.xz);
            u_xlat6.xyz = (-u_xlat3.xyz) + u_xlat6.xyz;
            u_xlat12.y = u_xlat10.y;
            u_xlat6.xyz = u_xlat6.xyz / u_xlat12.xyz;
            u_xlat4.xzw = (-u_xlat3.xyz) + u_xlat4.xzw;
            u_xlat4.xzw = u_xlat4.xzw / u_xlat12.xyz;
            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat12.xyzx).xyz;
            u_xlat4.x = (u_xlatb9.x) ? u_xlat6.x : u_xlat4.x;
            u_xlat4.z = (u_xlatb9.y) ? u_xlat6.y : u_xlat4.z;
            u_xlat4.w = (u_xlatb9.z) ? u_xlat6.z : u_xlat4.w;
            u_xlat42 = min(u_xlat4.z, u_xlat4.x);
            u_xlat42 = min(u_xlat4.w, u_xlat42);
            u_xlat4.xzw = u_xlat10.xyz * vec3(u_xlat42) + u_xlat11.xyz;
        } else {
            u_xlat4.xzw = u_xlat5.xyz;
        //ENDIF
        }
        u_xlat10_6 = textureLod(_SpecCube1, u_xlat4.xzw, u_xlat41);
        u_xlat16_7.x = u_xlat10_6.w + -1.0;
        u_xlat16_7.x = _SpecCube1_HDR.w * u_xlat16_7.x + 1.0;
        u_xlat16_7.x = log2(u_xlat16_7.x);
        u_xlat16_7.x = u_xlat16_7.x * _SpecCube1_HDR.y;
        u_xlat16_7.x = exp2(u_xlat16_7.x);
        u_xlat16_7.x = u_xlat16_7.x * _SpecCube1_HDR.x;
        u_xlat16_7.xyz = u_xlat10_6.xyz * u_xlat16_7.xxx;
        u_xlat16_4.xzw = u_xlat16_0.xyz * u_xlat16_7.xyz;
        u_xlat41 = (-u_xlat1.w) + 1.0;
        u_xlat41 = min(u_xlat39, u_xlat41);
        u_xlat1.xyz = u_xlat16_4.xzw * vec3(u_xlat41) + u_xlat1.xyz;
        u_xlat1.w = u_xlat39 + u_xlat1.w;
    //ENDIF
    }
    u_xlat4.x = sin(_SpecCube2_BoxMin.w);
    u_xlat6.x = cos(_SpecCube2_BoxMin.w);
    u_xlat9.x = (-u_xlat4.x);
    u_xlat16_7.xy = u_xlat2.xz + (-_SpecCube2_ProbePosition.xz);
    u_xlat9.y = u_xlat6.x;
    u_xlat6.x = dot(u_xlat9.yx, u_xlat16_7.xy);
    u_xlat9.z = u_xlat4.x;
    u_xlat6.z = dot(u_xlat9.zy, u_xlat16_7.xy);
    u_xlat3.xz = u_xlat6.xz + _SpecCube2_ProbePosition.xz;
    u_xlat16_7.xyz = u_xlat3.xyz + (-_SpecCube2_BoxMax.xyz);
    u_xlat16_8.xyz = (-u_xlat3.xyz) + _SpecCube2_BoxMin.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, u_xlat16_8.xyz);
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_39 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_39 = sqrt(u_xlat16_39);
    u_xlat39 = u_xlat16_39 / _SpecCube2_BoxMax.w;
    u_xlat39 = (-u_xlat39) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb41 = !!(0.0>=u_xlat39);
#else
    u_xlatb41 = 0.0>=u_xlat39;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb42 = !!(u_xlat1.w>=1.0);
#else
    u_xlatb42 = u_xlat1.w>=1.0;
#endif
    u_xlatb41 = u_xlatb41 || u_xlatb42;
    if(!u_xlatb41){
        u_xlat41 = u_xlat4.y * 6.0;
#ifdef UNITY_ADRENO_ES3
        u_xlatb42 = !!(0.0<_SpecCube2_ProbePosition.w);
#else
        u_xlatb42 = 0.0<_SpecCube2_ProbePosition.w;
#endif
        if(u_xlatb42){
            u_xlat4.xzw = _SpecCube2_BoxMin.xyz + (-_SpecCube2_BoxMax.www);
            u_xlat6.xyz = _SpecCube2_BoxMax.www + _SpecCube2_BoxMax.xyz;
            u_xlat42 = dot(u_xlat5.xyz, u_xlat5.xyz);
            u_xlat42 = inversesqrt(u_xlat42);
            u_xlat10.xyz = vec3(u_xlat42) * u_xlat5.xyz;
            u_xlat11.xyz = u_xlat2.xyz + (-_SpecCube2_ProbePosition.xyz);
            u_xlat12.x = dot(u_xlat9.yx, u_xlat11.xz);
            u_xlat12.z = dot(u_xlat9.zy, u_xlat11.xz);
            u_xlat3.xz = u_xlat12.xz + _SpecCube2_ProbePosition.xz;
            u_xlat12.x = dot(u_xlat9.yx, u_xlat10.xz);
            u_xlat12.z = dot(u_xlat9.zy, u_xlat10.xz);
            u_xlat6.xyz = (-u_xlat3.xyz) + u_xlat6.xyz;
            u_xlat12.y = u_xlat10.y;
            u_xlat6.xyz = u_xlat6.xyz / u_xlat12.xyz;
            u_xlat4.xzw = (-u_xlat3.xyz) + u_xlat4.xzw;
            u_xlat4.xzw = u_xlat4.xzw / u_xlat12.xyz;
            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat12.xyzx).xyz;
            u_xlat4.x = (u_xlatb9.x) ? u_xlat6.x : u_xlat4.x;
            u_xlat4.z = (u_xlatb9.y) ? u_xlat6.y : u_xlat4.z;
            u_xlat4.w = (u_xlatb9.z) ? u_xlat6.z : u_xlat4.w;
            u_xlat42 = min(u_xlat4.z, u_xlat4.x);
            u_xlat42 = min(u_xlat4.w, u_xlat42);
            u_xlat4.xzw = u_xlat10.xyz * vec3(u_xlat42) + u_xlat11.xyz;
        } else {
            u_xlat4.xzw = u_xlat5.xyz;
        //ENDIF
        }
        u_xlat10_6 = textureLod(_SpecCube2, u_xlat4.xzw, u_xlat41);
        u_xlat16_7.x = u_xlat10_6.w + -1.0;
        u_xlat16_7.x = _SpecCube2_HDR.w * u_xlat16_7.x + 1.0;
        u_xlat16_7.x = log2(u_xlat16_7.x);
        u_xlat16_7.x = u_xlat16_7.x * _SpecCube2_HDR.y;
        u_xlat16_7.x = exp2(u_xlat16_7.x);
        u_xlat16_7.x = u_xlat16_7.x * _SpecCube2_HDR.x;
        u_xlat16_7.xyz = u_xlat10_6.xyz * u_xlat16_7.xxx;
        u_xlat16_4.xzw = u_xlat16_0.xyz * u_xlat16_7.xyz;
        u_xlat41 = (-u_xlat1.w) + 1.0;
        u_xlat41 = min(u_xlat39, u_xlat41);
        u_xlat1.xyz = u_xlat16_4.xzw * vec3(u_xlat41) + u_xlat1.xyz;
        u_xlat1.w = u_xlat39 + u_xlat1.w;
    //ENDIF
    }
    u_xlat4.x = sin(_SpecCube3_BoxMin.w);
    u_xlat6.x = cos(_SpecCube3_BoxMin.w);
    u_xlat9.x = (-u_xlat4.x);
    u_xlat16_7.xy = u_xlat2.xz + (-_SpecCube3_ProbePosition.xz);
    u_xlat9.y = u_xlat6.x;
    u_xlat6.x = dot(u_xlat9.yx, u_xlat16_7.xy);
    u_xlat9.z = u_xlat4.x;
    u_xlat6.z = dot(u_xlat9.zy, u_xlat16_7.xy);
    u_xlat3.xz = u_xlat6.xz + _SpecCube3_ProbePosition.xz;
    u_xlat16_7.xyz = u_xlat3.xyz + (-_SpecCube3_BoxMax.xyz);
    u_xlat16_8.xyz = (-u_xlat3.xyz) + _SpecCube3_BoxMin.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, u_xlat16_8.xyz);
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_39 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_39 = sqrt(u_xlat16_39);
    u_xlat39 = u_xlat16_39 / _SpecCube3_BoxMax.w;
    u_xlat39 = (-u_xlat39) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb41 = !!(0.0>=u_xlat39);
#else
    u_xlatb41 = 0.0>=u_xlat39;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb42 = !!(u_xlat1.w>=1.0);
#else
    u_xlatb42 = u_xlat1.w>=1.0;
#endif
    u_xlatb41 = u_xlatb41 || u_xlatb42;
    if(!u_xlatb41){
        u_xlat41 = u_xlat4.y * 6.0;
#ifdef UNITY_ADRENO_ES3
        u_xlatb42 = !!(0.0<_SpecCube3_ProbePosition.w);
#else
        u_xlatb42 = 0.0<_SpecCube3_ProbePosition.w;
#endif
        if(u_xlatb42){
            u_xlat4.xzw = _SpecCube3_BoxMin.xyz + (-_SpecCube3_BoxMax.www);
            u_xlat6.xyz = _SpecCube3_BoxMax.www + _SpecCube3_BoxMax.xyz;
            u_xlat42 = dot(u_xlat5.xyz, u_xlat5.xyz);
            u_xlat42 = inversesqrt(u_xlat42);
            u_xlat10.xyz = vec3(u_xlat42) * u_xlat5.xyz;
            u_xlat11.xyz = u_xlat2.xyz + (-_SpecCube3_ProbePosition.xyz);
            u_xlat12.x = dot(u_xlat9.yx, u_xlat11.xz);
            u_xlat12.z = dot(u_xlat9.zy, u_xlat11.xz);
            u_xlat3.xz = u_xlat12.xz + _SpecCube3_ProbePosition.xz;
            u_xlat12.x = dot(u_xlat9.yx, u_xlat10.xz);
            u_xlat12.z = dot(u_xlat9.zy, u_xlat10.xz);
            u_xlat6.xyz = (-u_xlat3.xyz) + u_xlat6.xyz;
            u_xlat12.y = u_xlat10.y;
            u_xlat6.xyz = u_xlat6.xyz / u_xlat12.xyz;
            u_xlat4.xzw = (-u_xlat3.xyz) + u_xlat4.xzw;
            u_xlat4.xzw = u_xlat4.xzw / u_xlat12.xyz;
            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat12.xyzx).xyz;
            u_xlat4.x = (u_xlatb9.x) ? u_xlat6.x : u_xlat4.x;
            u_xlat4.z = (u_xlatb9.y) ? u_xlat6.y : u_xlat4.z;
            u_xlat4.w = (u_xlatb9.z) ? u_xlat6.z : u_xlat4.w;
            u_xlat42 = min(u_xlat4.z, u_xlat4.x);
            u_xlat42 = min(u_xlat4.w, u_xlat42);
            u_xlat4.xzw = u_xlat10.xyz * vec3(u_xlat42) + u_xlat11.xyz;
        } else {
            u_xlat4.xzw = u_xlat5.xyz;
        //ENDIF
        }
        u_xlat10_6 = textureLod(_SpecCube3, u_xlat4.xzw, u_xlat41);
        u_xlat16_7.x = u_xlat10_6.w + -1.0;
        u_xlat16_7.x = _SpecCube3_HDR.w * u_xlat16_7.x + 1.0;
        u_xlat16_7.x = log2(u_xlat16_7.x);
        u_xlat16_7.x = u_xlat16_7.x * _SpecCube3_HDR.y;
        u_xlat16_7.x = exp2(u_xlat16_7.x);
        u_xlat16_7.x = u_xlat16_7.x * _SpecCube3_HDR.x;
        u_xlat16_7.xyz = u_xlat10_6.xyz * u_xlat16_7.xxx;
        u_xlat16_4.xzw = u_xlat16_0.xyz * u_xlat16_7.xyz;
        u_xlat41 = (-u_xlat1.w) + 1.0;
        u_xlat41 = min(u_xlat39, u_xlat41);
        u_xlat1.xyz = u_xlat16_4.xzw * vec3(u_xlat41) + u_xlat1.xyz;
        u_xlat1.w = u_xlat39 + u_xlat1.w;
    //ENDIF
    }
    u_xlat4.x = sin(_SpecCube4_BoxMin.w);
    u_xlat6.x = cos(_SpecCube4_BoxMin.w);
    u_xlat9.x = (-u_xlat4.x);
    u_xlat16_7.xy = u_xlat2.xz + (-_SpecCube4_ProbePosition.xz);
    u_xlat9.y = u_xlat6.x;
    u_xlat6.x = dot(u_xlat9.yx, u_xlat16_7.xy);
    u_xlat9.z = u_xlat4.x;
    u_xlat6.z = dot(u_xlat9.zy, u_xlat16_7.xy);
    u_xlat3.xz = u_xlat6.xz + _SpecCube4_ProbePosition.xz;
    u_xlat16_7.xyz = u_xlat3.xyz + (-_SpecCube4_BoxMax.xyz);
    u_xlat16_8.xyz = (-u_xlat3.xyz) + _SpecCube4_BoxMin.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, u_xlat16_8.xyz);
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_39 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_39 = sqrt(u_xlat16_39);
    u_xlat39 = u_xlat16_39 / _SpecCube4_BoxMax.w;
    u_xlat39 = (-u_xlat39) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb41 = !!(0.0>=u_xlat39);
#else
    u_xlatb41 = 0.0>=u_xlat39;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb42 = !!(u_xlat1.w>=1.0);
#else
    u_xlatb42 = u_xlat1.w>=1.0;
#endif
    u_xlatb41 = u_xlatb41 || u_xlatb42;
    if(!u_xlatb41){
        u_xlat41 = u_xlat4.y * 6.0;
#ifdef UNITY_ADRENO_ES3
        u_xlatb42 = !!(0.0<_SpecCube4_ProbePosition.w);
#else
        u_xlatb42 = 0.0<_SpecCube4_ProbePosition.w;
#endif
        if(u_xlatb42){
            u_xlat4.xzw = _SpecCube4_BoxMin.xyz + (-_SpecCube4_BoxMax.www);
            u_xlat6.xyz = _SpecCube4_BoxMax.www + _SpecCube4_BoxMax.xyz;
            u_xlat42 = dot(u_xlat5.xyz, u_xlat5.xyz);
            u_xlat42 = inversesqrt(u_xlat42);
            u_xlat10.xyz = vec3(u_xlat42) * u_xlat5.xyz;
            u_xlat11.xyz = u_xlat2.xyz + (-_SpecCube4_ProbePosition.xyz);
            u_xlat12.x = dot(u_xlat9.yx, u_xlat11.xz);
            u_xlat12.z = dot(u_xlat9.zy, u_xlat11.xz);
            u_xlat3.xz = u_xlat12.xz + _SpecCube4_ProbePosition.xz;
            u_xlat12.x = dot(u_xlat9.yx, u_xlat10.xz);
            u_xlat12.z = dot(u_xlat9.zy, u_xlat10.xz);
            u_xlat6.xyz = (-u_xlat3.xyz) + u_xlat6.xyz;
            u_xlat12.y = u_xlat10.y;
            u_xlat6.xyz = u_xlat6.xyz / u_xlat12.xyz;
            u_xlat4.xzw = (-u_xlat3.xyz) + u_xlat4.xzw;
            u_xlat4.xzw = u_xlat4.xzw / u_xlat12.xyz;
            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat12.xyzx).xyz;
            u_xlat4.x = (u_xlatb9.x) ? u_xlat6.x : u_xlat4.x;
            u_xlat4.z = (u_xlatb9.y) ? u_xlat6.y : u_xlat4.z;
            u_xlat4.w = (u_xlatb9.z) ? u_xlat6.z : u_xlat4.w;
            u_xlat42 = min(u_xlat4.z, u_xlat4.x);
            u_xlat42 = min(u_xlat4.w, u_xlat42);
            u_xlat4.xzw = u_xlat10.xyz * vec3(u_xlat42) + u_xlat11.xyz;
        } else {
            u_xlat4.xzw = u_xlat5.xyz;
        //ENDIF
        }
        u_xlat10_6 = textureLod(_SpecCube4, u_xlat4.xzw, u_xlat41);
        u_xlat16_7.x = u_xlat10_6.w + -1.0;
        u_xlat16_7.x = _SpecCube4_HDR.w * u_xlat16_7.x + 1.0;
        u_xlat16_7.x = log2(u_xlat16_7.x);
        u_xlat16_7.x = u_xlat16_7.x * _SpecCube4_HDR.y;
        u_xlat16_7.x = exp2(u_xlat16_7.x);
        u_xlat16_7.x = u_xlat16_7.x * _SpecCube4_HDR.x;
        u_xlat16_7.xyz = u_xlat10_6.xyz * u_xlat16_7.xxx;
        u_xlat16_4.xzw = u_xlat16_0.xyz * u_xlat16_7.xyz;
        u_xlat41 = (-u_xlat1.w) + 1.0;
        u_xlat41 = min(u_xlat39, u_xlat41);
        u_xlat1.xyz = u_xlat16_4.xzw * vec3(u_xlat41) + u_xlat1.xyz;
        u_xlat1.w = u_xlat39 + u_xlat1.w;
    //ENDIF
    }
    u_xlat4.x = sin(_SpecCube5_BoxMin.w);
    u_xlat6.x = cos(_SpecCube5_BoxMin.w);
    u_xlat9.x = (-u_xlat4.x);
    u_xlat16_7.xy = u_xlat2.xz + (-_SpecCube5_ProbePosition.xz);
    u_xlat9.y = u_xlat6.x;
    u_xlat6.x = dot(u_xlat9.yx, u_xlat16_7.xy);
    u_xlat9.z = u_xlat4.x;
    u_xlat6.z = dot(u_xlat9.zy, u_xlat16_7.xy);
    u_xlat3.xz = u_xlat6.xz + _SpecCube5_ProbePosition.xz;
    u_xlat16_7.xyz = u_xlat3.xyz + (-_SpecCube5_BoxMax.xyz);
    u_xlat16_8.xyz = (-u_xlat3.xyz) + _SpecCube5_BoxMin.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, u_xlat16_8.xyz);
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_39 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_39 = sqrt(u_xlat16_39);
    u_xlat39 = u_xlat16_39 / _SpecCube5_BoxMax.w;
    u_xlat39 = (-u_xlat39) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb41 = !!(0.0>=u_xlat39);
#else
    u_xlatb41 = 0.0>=u_xlat39;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb42 = !!(u_xlat1.w>=1.0);
#else
    u_xlatb42 = u_xlat1.w>=1.0;
#endif
    u_xlatb41 = u_xlatb41 || u_xlatb42;
    if(!u_xlatb41){
        u_xlat41 = u_xlat4.y * 6.0;
#ifdef UNITY_ADRENO_ES3
        u_xlatb42 = !!(0.0<_SpecCube5_ProbePosition.w);
#else
        u_xlatb42 = 0.0<_SpecCube5_ProbePosition.w;
#endif
        if(u_xlatb42){
            u_xlat4.xzw = _SpecCube5_BoxMin.xyz + (-_SpecCube5_BoxMax.www);
            u_xlat6.xyz = _SpecCube5_BoxMax.www + _SpecCube5_BoxMax.xyz;
            u_xlat42 = dot(u_xlat5.xyz, u_xlat5.xyz);
            u_xlat42 = inversesqrt(u_xlat42);
            u_xlat10.xyz = vec3(u_xlat42) * u_xlat5.xyz;
            u_xlat11.xyz = u_xlat2.xyz + (-_SpecCube5_ProbePosition.xyz);
            u_xlat12.x = dot(u_xlat9.yx, u_xlat11.xz);
            u_xlat12.z = dot(u_xlat9.zy, u_xlat11.xz);
            u_xlat3.xz = u_xlat12.xz + _SpecCube5_ProbePosition.xz;
            u_xlat12.x = dot(u_xlat9.yx, u_xlat10.xz);
            u_xlat12.z = dot(u_xlat9.zy, u_xlat10.xz);
            u_xlat6.xyz = (-u_xlat3.xyz) + u_xlat6.xyz;
            u_xlat12.y = u_xlat10.y;
            u_xlat6.xyz = u_xlat6.xyz / u_xlat12.xyz;
            u_xlat4.xzw = (-u_xlat3.xyz) + u_xlat4.xzw;
            u_xlat4.xzw = u_xlat4.xzw / u_xlat12.xyz;
            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat12.xyzx).xyz;
            u_xlat4.x = (u_xlatb9.x) ? u_xlat6.x : u_xlat4.x;
            u_xlat4.z = (u_xlatb9.y) ? u_xlat6.y : u_xlat4.z;
            u_xlat4.w = (u_xlatb9.z) ? u_xlat6.z : u_xlat4.w;
            u_xlat42 = min(u_xlat4.z, u_xlat4.x);
            u_xlat42 = min(u_xlat4.w, u_xlat42);
            u_xlat4.xzw = u_xlat10.xyz * vec3(u_xlat42) + u_xlat11.xyz;
        } else {
            u_xlat4.xzw = u_xlat5.xyz;
        //ENDIF
        }
        u_xlat10_6 = textureLod(_SpecCube5, u_xlat4.xzw, u_xlat41);
        u_xlat16_7.x = u_xlat10_6.w + -1.0;
        u_xlat16_7.x = _SpecCube5_HDR.w * u_xlat16_7.x + 1.0;
        u_xlat16_7.x = log2(u_xlat16_7.x);
        u_xlat16_7.x = u_xlat16_7.x * _SpecCube5_HDR.y;
        u_xlat16_7.x = exp2(u_xlat16_7.x);
        u_xlat16_7.x = u_xlat16_7.x * _SpecCube5_HDR.x;
        u_xlat16_7.xyz = u_xlat10_6.xyz * u_xlat16_7.xxx;
        u_xlat16_4.xzw = u_xlat16_0.xyz * u_xlat16_7.xyz;
        u_xlat41 = (-u_xlat1.w) + 1.0;
        u_xlat41 = min(u_xlat39, u_xlat41);
        u_xlat1.xyz = u_xlat16_4.xzw * vec3(u_xlat41) + u_xlat1.xyz;
        u_xlat1.w = u_xlat39 + u_xlat1.w;
    //ENDIF
    }
    u_xlat4.x = sin(_SpecCube6_BoxMin.w);
    u_xlat6.x = cos(_SpecCube6_BoxMin.w);
    u_xlat9.x = (-u_xlat4.x);
    u_xlat16_7.xy = u_xlat2.xz + (-_SpecCube6_ProbePosition.xz);
    u_xlat9.y = u_xlat6.x;
    u_xlat6.x = dot(u_xlat9.yx, u_xlat16_7.xy);
    u_xlat9.z = u_xlat4.x;
    u_xlat6.z = dot(u_xlat9.zy, u_xlat16_7.xy);
    u_xlat3.xz = u_xlat6.xz + _SpecCube6_ProbePosition.xz;
    u_xlat16_7.xyz = u_xlat3.xyz + (-_SpecCube6_BoxMax.xyz);
    u_xlat16_8.xyz = (-u_xlat3.xyz) + _SpecCube6_BoxMin.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, u_xlat16_8.xyz);
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_39 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_39 = sqrt(u_xlat16_39);
    u_xlat39 = u_xlat16_39 / _SpecCube6_BoxMax.w;
    u_xlat39 = (-u_xlat39) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb41 = !!(0.0>=u_xlat39);
#else
    u_xlatb41 = 0.0>=u_xlat39;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb42 = !!(u_xlat1.w>=1.0);
#else
    u_xlatb42 = u_xlat1.w>=1.0;
#endif
    u_xlatb41 = u_xlatb41 || u_xlatb42;
    if(!u_xlatb41){
        u_xlat41 = u_xlat4.y * 6.0;
#ifdef UNITY_ADRENO_ES3
        u_xlatb42 = !!(0.0<_SpecCube6_ProbePosition.w);
#else
        u_xlatb42 = 0.0<_SpecCube6_ProbePosition.w;
#endif
        if(u_xlatb42){
            u_xlat4.xzw = _SpecCube6_BoxMin.xyz + (-_SpecCube6_BoxMax.www);
            u_xlat6.xyz = _SpecCube6_BoxMax.www + _SpecCube6_BoxMax.xyz;
            u_xlat42 = dot(u_xlat5.xyz, u_xlat5.xyz);
            u_xlat42 = inversesqrt(u_xlat42);
            u_xlat10.xyz = vec3(u_xlat42) * u_xlat5.xyz;
            u_xlat11.xyz = u_xlat2.xyz + (-_SpecCube6_ProbePosition.xyz);
            u_xlat12.x = dot(u_xlat9.yx, u_xlat11.xz);
            u_xlat12.z = dot(u_xlat9.zy, u_xlat11.xz);
            u_xlat3.xz = u_xlat12.xz + _SpecCube6_ProbePosition.xz;
            u_xlat12.x = dot(u_xlat9.yx, u_xlat10.xz);
            u_xlat12.z = dot(u_xlat9.zy, u_xlat10.xz);
            u_xlat6.xyz = (-u_xlat3.xyz) + u_xlat6.xyz;
            u_xlat12.y = u_xlat10.y;
            u_xlat6.xyz = u_xlat6.xyz / u_xlat12.xyz;
            u_xlat4.xzw = (-u_xlat3.xyz) + u_xlat4.xzw;
            u_xlat4.xzw = u_xlat4.xzw / u_xlat12.xyz;
            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat12.xyzx).xyz;
            u_xlat4.x = (u_xlatb9.x) ? u_xlat6.x : u_xlat4.x;
            u_xlat4.z = (u_xlatb9.y) ? u_xlat6.y : u_xlat4.z;
            u_xlat4.w = (u_xlatb9.z) ? u_xlat6.z : u_xlat4.w;
            u_xlat42 = min(u_xlat4.z, u_xlat4.x);
            u_xlat42 = min(u_xlat4.w, u_xlat42);
            u_xlat4.xzw = u_xlat10.xyz * vec3(u_xlat42) + u_xlat11.xyz;
        } else {
            u_xlat4.xzw = u_xlat5.xyz;
        //ENDIF
        }
        u_xlat10_6 = textureLod(_SpecCube6, u_xlat4.xzw, u_xlat41);
        u_xlat16_7.x = u_xlat10_6.w + -1.0;
        u_xlat16_7.x = _SpecCube6_HDR.w * u_xlat16_7.x + 1.0;
        u_xlat16_7.x = log2(u_xlat16_7.x);
        u_xlat16_7.x = u_xlat16_7.x * _SpecCube6_HDR.y;
        u_xlat16_7.x = exp2(u_xlat16_7.x);
        u_xlat16_7.x = u_xlat16_7.x * _SpecCube6_HDR.x;
        u_xlat16_7.xyz = u_xlat10_6.xyz * u_xlat16_7.xxx;
        u_xlat16_4.xzw = u_xlat16_0.xyz * u_xlat16_7.xyz;
        u_xlat41 = (-u_xlat1.w) + 1.0;
        u_xlat41 = min(u_xlat39, u_xlat41);
        u_xlat1.xyz = u_xlat16_4.xzw * vec3(u_xlat41) + u_xlat1.xyz;
        u_xlat1.w = u_xlat39 + u_xlat1.w;
    //ENDIF
    }
    u_xlat4.x = sin(_SpecCube7_BoxMin.w);
    u_xlat6.x = cos(_SpecCube7_BoxMin.w);
    u_xlat9.x = (-u_xlat4.x);
    u_xlat16_7.xy = u_xlat2.xz + (-_SpecCube7_ProbePosition.xz);
    u_xlat9.y = u_xlat6.x;
    u_xlat6.x = dot(u_xlat9.yx, u_xlat16_7.xy);
    u_xlat9.z = u_xlat4.x;
    u_xlat6.z = dot(u_xlat9.zy, u_xlat16_7.xy);
    u_xlat3.xz = u_xlat6.xz + _SpecCube7_ProbePosition.xz;
    u_xlat16_7.xyz = u_xlat3.xyz + (-_SpecCube7_BoxMax.xyz);
    u_xlat16_8.xyz = (-u_xlat3.xyz) + _SpecCube7_BoxMin.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, u_xlat16_8.xyz);
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_39 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_39 = sqrt(u_xlat16_39);
    u_xlat39 = u_xlat16_39 / _SpecCube7_BoxMax.w;
    u_xlat39 = (-u_xlat39) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb41 = !!(0.0>=u_xlat39);
#else
    u_xlatb41 = 0.0>=u_xlat39;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb42 = !!(u_xlat1.w>=1.0);
#else
    u_xlatb42 = u_xlat1.w>=1.0;
#endif
    u_xlatb41 = u_xlatb41 || u_xlatb42;
    if(!u_xlatb41){
        u_xlat41 = u_xlat4.y * 6.0;
#ifdef UNITY_ADRENO_ES3
        u_xlatb42 = !!(0.0<_SpecCube7_ProbePosition.w);
#else
        u_xlatb42 = 0.0<_SpecCube7_ProbePosition.w;
#endif
        if(u_xlatb42){
            u_xlat4.xzw = _SpecCube7_BoxMin.xyz + (-_SpecCube7_BoxMax.www);
            u_xlat6.xyz = _SpecCube7_BoxMax.www + _SpecCube7_BoxMax.xyz;
            u_xlat42 = dot(u_xlat5.xyz, u_xlat5.xyz);
            u_xlat42 = inversesqrt(u_xlat42);
            u_xlat10.xyz = vec3(u_xlat42) * u_xlat5.xyz;
            u_xlat2.xyz = u_xlat2.xyz + (-_SpecCube7_ProbePosition.xyz);
            u_xlat11.x = dot(u_xlat9.yx, u_xlat2.xz);
            u_xlat11.z = dot(u_xlat9.zy, u_xlat2.xz);
            u_xlat3.xz = u_xlat11.xz + _SpecCube7_ProbePosition.xz;
            u_xlat11.x = dot(u_xlat9.yx, u_xlat10.xz);
            u_xlat11.z = dot(u_xlat9.zy, u_xlat10.xz);
            u_xlat6.xyz = (-u_xlat3.xyz) + u_xlat6.xyz;
            u_xlat11.y = u_xlat10.y;
            u_xlat6.xyz = u_xlat6.xyz / u_xlat11.xyz;
            u_xlat3.xyz = (-u_xlat3.xyz) + u_xlat4.xzw;
            u_xlat3.xyz = u_xlat3.xyz / u_xlat11.xyz;
            u_xlatb4.xzw = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat11.xxyz).xzw;
            u_xlat3.x = (u_xlatb4.x) ? u_xlat6.x : u_xlat3.x;
            u_xlat3.y = (u_xlatb4.z) ? u_xlat6.y : u_xlat3.y;
            u_xlat3.z = (u_xlatb4.w) ? u_xlat6.z : u_xlat3.z;
            u_xlat3.x = min(u_xlat3.y, u_xlat3.x);
            u_xlat3.x = min(u_xlat3.z, u_xlat3.x);
            u_xlat2.xyz = u_xlat10.xyz * u_xlat3.xxx + u_xlat2.xyz;
        } else {
            u_xlat2.xyz = u_xlat5.xyz;
        //ENDIF
        }
        u_xlat10_2 = textureLod(_SpecCube7, u_xlat2.xyz, u_xlat41);
        u_xlat16_7.x = u_xlat10_2.w + -1.0;
        u_xlat16_7.x = _SpecCube7_HDR.w * u_xlat16_7.x + 1.0;
        u_xlat16_7.x = log2(u_xlat16_7.x);
        u_xlat16_7.x = u_xlat16_7.x * _SpecCube7_HDR.y;
        u_xlat16_7.x = exp2(u_xlat16_7.x);
        u_xlat16_7.x = u_xlat16_7.x * _SpecCube7_HDR.x;
        u_xlat16_7.xyz = u_xlat10_2.xyz * u_xlat16_7.xxx;
        u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_7.xyz;
        u_xlat41 = (-u_xlat1.w) + 1.0;
        u_xlat41 = min(u_xlat39, u_xlat41);
        u_xlat1.xyz = u_xlat16_2.xyz * vec3(u_xlat41) + u_xlat1.xyz;
        u_xlat1.w = u_xlat39 + u_xlat1.w;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!(u_xlat1.w<1.0);
#else
    u_xlatb39 = u_xlat1.w<1.0;
#endif
    if(u_xlatb39){
        u_xlat39 = u_xlat4.y * 6.0;
        u_xlat10_2 = textureLod(_ReflectionSkyCubeMap, u_xlat5.xyz, u_xlat39);
        u_xlat16_7.x = u_xlat10_2.w + -1.0;
        u_xlat16_7.x = _ReflectionSkyCubeMap_HDR.w * u_xlat16_7.x + 1.0;
        u_xlat16_7.x = log2(u_xlat16_7.x);
        u_xlat16_7.x = u_xlat16_7.x * _ReflectionSkyCubeMap_HDR.y;
        u_xlat16_7.x = exp2(u_xlat16_7.x);
        u_xlat16_7.x = u_xlat16_7.x * _ReflectionSkyCubeMap_HDR.x;
        u_xlat16_7.xyz = u_xlat10_2.xyz * u_xlat16_7.xxx;
        u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_7.xyz;
        u_xlat39 = (-u_xlat1.w) + 1.0;
        u_xlat1.xyz = u_xlat16_0.xyz * vec3(u_xlat39) + u_xlat1.xyz;
    //ENDIF
    }
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SSR_DISABLED" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
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
    u_xlat2 = u_xlat0.y * _ProjectionParams.x;
    u_xlat0.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.w = u_xlat2 * 0.5;
    u_xlat0.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD0.zw = u_xlat0.xy * _ScreenParams.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD1.xyz = in_NORMAL0.xyz;
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
uniform 	vec4 _ReflectionSkyCubeMap_HDR;
uniform 	vec4 _SpecCube0_ProbePosition;
uniform 	vec4 _SpecCube0_BoxMin;
uniform 	vec4 _SpecCube0_BoxMax;
uniform 	vec4 _SpecCube0_HDR;
uniform 	vec4 _SpecCube1_ProbePosition;
uniform 	vec4 _SpecCube1_BoxMin;
uniform 	vec4 _SpecCube1_BoxMax;
uniform 	vec4 _SpecCube1_HDR;
uniform 	vec4 _SpecCube2_ProbePosition;
uniform 	vec4 _SpecCube2_BoxMin;
uniform 	vec4 _SpecCube2_BoxMax;
uniform 	vec4 _SpecCube2_HDR;
uniform 	vec4 _SpecCube3_ProbePosition;
uniform 	vec4 _SpecCube3_BoxMin;
uniform 	vec4 _SpecCube3_BoxMax;
uniform 	vec4 _SpecCube3_HDR;
uniform 	vec4 _SpecCube4_ProbePosition;
uniform 	vec4 _SpecCube4_BoxMin;
uniform 	vec4 _SpecCube4_BoxMax;
uniform 	vec4 _SpecCube4_HDR;
uniform 	vec4 _SpecCube5_ProbePosition;
uniform 	vec4 _SpecCube5_BoxMin;
uniform 	vec4 _SpecCube5_BoxMax;
uniform 	vec4 _SpecCube5_HDR;
uniform 	vec4 _SpecCube6_ProbePosition;
uniform 	vec4 _SpecCube6_BoxMin;
uniform 	vec4 _SpecCube6_BoxMax;
uniform 	vec4 _SpecCube6_HDR;
uniform 	vec4 _SpecCube7_ProbePosition;
uniform 	vec4 _SpecCube7_BoxMin;
uniform 	vec4 _SpecCube7_BoxMax;
uniform 	vec4 _SpecCube7_HDR;
uniform lowp sampler2D _CameraNormalsTexture;
uniform lowp sampler2D _CameraSpecularTexture;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _EnvBRDF;
uniform lowp samplerCube _ReflectionSkyCubeMap;
uniform lowp samplerCube _SpecCube0;
uniform lowp samplerCube _SpecCube1;
uniform lowp samplerCube _SpecCube2;
uniform lowp samplerCube _SpecCube3;
uniform lowp samplerCube _SpecCube4;
uniform lowp samplerCube _SpecCube5;
uniform lowp samplerCube _SpecCube6;
uniform lowp samplerCube _SpecCube7;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
bool u_xlatb2;
vec3 u_xlat3;
lowp vec2 u_xlat10_3;
vec4 u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_7;
bvec3 u_xlatb7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
bvec3 u_xlatb9;
vec3 u_xlat10;
bvec3 u_xlatb10;
vec3 u_xlat11;
vec3 u_xlat12;
mediump vec3 u_xlat16_13;
vec3 u_xlat14;
float u_xlat33;
bool u_xlatb33;
float u_xlat45;
mediump float u_xlat16_45;
float u_xlat47;
mediump float u_xlat16_47;
bool u_xlatb47;
float u_xlat48;
bool u_xlatb48;
void main()
{
    u_xlat10_0.xyz = texture(_CameraNormalsTexture, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_0 = texture(_CameraSpecularTexture, vs_TEXCOORD0.xy);
    u_xlat2.x = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat2.x = _ZBufferParams.x * u_xlat2.x + _ZBufferParams.y;
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat2.xyz = vs_TEXCOORD1.xyz * u_xlat2.xxx + _WorldSpaceCameraPos.xyz;
    u_xlat47 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat47 = inversesqrt(u_xlat47);
    u_xlat3.xyz = vec3(u_xlat47) * vs_TEXCOORD1.xyz;
    u_xlat4.y = (-u_xlat10_0.w) + 1.0;
    u_xlat45 = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat45 = u_xlat45 + u_xlat45;
    u_xlat5.xyz = u_xlat16_1.xyz * (-vec3(u_xlat45)) + u_xlat3.xyz;
    u_xlat4.x = dot(u_xlat16_1.xyz, (-u_xlat3.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat3.xy = u_xlat4.xy * vec2(0.937749982, 0.937749982) + vec2(0.0311249997, 0.0311249997);
    u_xlat10_3.xy = texture(_EnvBRDF, u_xlat3.xy).xy;
    u_xlat4.x = sin(_SpecCube0_BoxMin.w);
    u_xlat6.x = cos(_SpecCube0_BoxMin.w);
    u_xlat7.x = (-u_xlat4.x);
    u_xlat16_1.xy = u_xlat2.xz + (-_SpecCube0_ProbePosition.xz);
    u_xlat7.y = u_xlat6.x;
    u_xlat6.x = dot(u_xlat7.yx, u_xlat16_1.xy);
    u_xlat7.z = u_xlat4.x;
    u_xlat6.z = dot(u_xlat7.zy, u_xlat16_1.xy);
    u_xlat6.xz = u_xlat6.xz + _SpecCube0_ProbePosition.xz;
    u_xlat6.y = u_xlat2.y;
    u_xlat16_1.xyz = u_xlat6.xyz + (-_SpecCube0_BoxMax.xyz);
    u_xlat16_8.xyz = (-u_xlat6.xyz) + _SpecCube0_BoxMin.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, u_xlat16_8.xyz);
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_45 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_45 = sqrt(u_xlat16_45);
    u_xlat45 = u_xlat16_45 / _SpecCube0_BoxMax.w;
    u_xlat45 = (-u_xlat45) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat45 = min(max(u_xlat45, 0.0), 1.0);
#else
    u_xlat45 = clamp(u_xlat45, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb47 = !!(0.0<u_xlat45);
#else
    u_xlatb47 = 0.0<u_xlat45;
#endif
    if(u_xlatb47){
        u_xlat47 = u_xlat4.y * 6.0;
#ifdef UNITY_ADRENO_ES3
        u_xlatb33 = !!(0.0<_SpecCube0_ProbePosition.w);
#else
        u_xlatb33 = 0.0<_SpecCube0_ProbePosition.w;
#endif
        if(u_xlatb33){
            u_xlat4.xzw = _SpecCube0_BoxMin.xyz + (-_SpecCube0_BoxMax.www);
            u_xlat9.xyz = _SpecCube0_BoxMax.www + _SpecCube0_BoxMax.xyz;
            u_xlat33 = dot(u_xlat5.xyz, u_xlat5.xyz);
            u_xlat33 = inversesqrt(u_xlat33);
            u_xlat10.xyz = vec3(u_xlat33) * u_xlat5.xyz;
            u_xlat11.xyz = u_xlat2.xyz + (-_SpecCube0_ProbePosition.xyz);
            u_xlat12.x = dot(u_xlat7.yx, u_xlat11.xz);
            u_xlat12.z = dot(u_xlat7.zy, u_xlat11.xz);
            u_xlat6.xz = u_xlat12.xz + _SpecCube0_ProbePosition.xz;
            u_xlat12.x = dot(u_xlat7.yx, u_xlat10.xz);
            u_xlat12.z = dot(u_xlat7.zy, u_xlat10.xz);
            u_xlat7.xyz = (-u_xlat6.xyz) + u_xlat9.xyz;
            u_xlat12.y = u_xlat10.y;
            u_xlat7.xyz = u_xlat7.xyz / u_xlat12.xyz;
            u_xlat4.xzw = u_xlat4.xzw + (-u_xlat6.xyz);
            u_xlat4.xzw = u_xlat4.xzw / u_xlat12.xyz;
            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat12.xyzx).xyz;
            u_xlat4.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat4.x;
            u_xlat4.z = (u_xlatb9.y) ? u_xlat7.y : u_xlat4.z;
            u_xlat4.w = (u_xlatb9.z) ? u_xlat7.z : u_xlat4.w;
            u_xlat33 = min(u_xlat4.z, u_xlat4.x);
            u_xlat33 = min(u_xlat4.w, u_xlat33);
            u_xlat4.xzw = u_xlat10.xyz * vec3(u_xlat33) + u_xlat11.xyz;
        } else {
            u_xlat4.xzw = u_xlat5.xyz;
        //ENDIF
        }
        u_xlat10_1 = textureLod(_SpecCube0, u_xlat4.xzw, u_xlat47);
        u_xlat16_8.x = u_xlat10_1.w + -1.0;
        u_xlat16_8.x = _SpecCube0_HDR.w * u_xlat16_8.x + 1.0;
        u_xlat16_8.x = log2(u_xlat16_8.x);
        u_xlat16_8.x = u_xlat16_8.x * _SpecCube0_HDR.y;
        u_xlat16_8.x = exp2(u_xlat16_8.x);
        u_xlat16_8.x = u_xlat16_8.x * _SpecCube0_HDR.x;
        u_xlat16_8.xyz = u_xlat10_1.xyz * u_xlat16_8.xxx;
        u_xlat16_4.xzw = u_xlat10_3.xxx * u_xlat10_0.xyz + u_xlat10_3.yyy;
        u_xlat16_4.xzw = u_xlat16_4.xzw * u_xlat16_8.xyz;
        u_xlat4.xzw = vec3(u_xlat45) * u_xlat16_4.xzw;
    } else {
        u_xlat4.x = float(0.0);
        u_xlat4.z = float(0.0);
        u_xlat4.w = float(0.0);
        u_xlat45 = 0.0;
    //ENDIF
    }
    u_xlat7.x = sin(_SpecCube1_BoxMin.w);
    u_xlat9.x = cos(_SpecCube1_BoxMin.w);
    u_xlat10.x = (-u_xlat7.x);
    u_xlat16_8.xy = u_xlat2.xz + (-_SpecCube1_ProbePosition.xz);
    u_xlat10.y = u_xlat9.x;
    u_xlat9.x = dot(u_xlat10.yx, u_xlat16_8.xy);
    u_xlat10.z = u_xlat7.x;
    u_xlat9.z = dot(u_xlat10.zy, u_xlat16_8.xy);
    u_xlat6.xz = u_xlat9.xz + _SpecCube1_ProbePosition.xz;
    u_xlat16_8.xyz = u_xlat6.xyz + (-_SpecCube1_BoxMax.xyz);
    u_xlat16_13.xyz = (-u_xlat6.xyz) + _SpecCube1_BoxMin.xyz;
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, u_xlat16_13.xyz);
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_47 = dot(u_xlat16_8.xyz, u_xlat16_8.xyz);
    u_xlat16_47 = sqrt(u_xlat16_47);
    u_xlat47 = u_xlat16_47 / _SpecCube1_BoxMax.w;
    u_xlat47 = (-u_xlat47) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat47 = min(max(u_xlat47, 0.0), 1.0);
#else
    u_xlat47 = clamp(u_xlat47, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(0.0>=u_xlat47);
#else
    u_xlatb33 = 0.0>=u_xlat47;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb48 = !!(u_xlat45>=1.0);
#else
    u_xlatb48 = u_xlat45>=1.0;
#endif
    u_xlatb33 = u_xlatb48 || u_xlatb33;
    if(!u_xlatb33){
        u_xlat33 = u_xlat4.y * 6.0;
#ifdef UNITY_ADRENO_ES3
        u_xlatb48 = !!(0.0<_SpecCube1_ProbePosition.w);
#else
        u_xlatb48 = 0.0<_SpecCube1_ProbePosition.w;
#endif
        if(u_xlatb48){
            u_xlat7.xyz = _SpecCube1_BoxMin.xyz + (-_SpecCube1_BoxMax.www);
            u_xlat9.xyz = _SpecCube1_BoxMax.www + _SpecCube1_BoxMax.xyz;
            u_xlat48 = dot(u_xlat5.xyz, u_xlat5.xyz);
            u_xlat48 = inversesqrt(u_xlat48);
            u_xlat11.xyz = vec3(u_xlat48) * u_xlat5.xyz;
            u_xlat12.xyz = u_xlat2.xyz + (-_SpecCube1_ProbePosition.xyz);
            u_xlat14.x = dot(u_xlat10.yx, u_xlat12.xz);
            u_xlat14.z = dot(u_xlat10.zy, u_xlat12.xz);
            u_xlat6.xz = u_xlat14.xz + _SpecCube1_ProbePosition.xz;
            u_xlat14.x = dot(u_xlat10.yx, u_xlat11.xz);
            u_xlat14.z = dot(u_xlat10.zy, u_xlat11.xz);
            u_xlat9.xyz = (-u_xlat6.xyz) + u_xlat9.xyz;
            u_xlat14.y = u_xlat11.y;
            u_xlat9.xyz = u_xlat9.xyz / u_xlat14.xyz;
            u_xlat7.xyz = (-u_xlat6.xyz) + u_xlat7.xyz;
            u_xlat7.xyz = u_xlat7.xyz / u_xlat14.xyz;
            u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat14.xyzx).xyz;
            u_xlat7.x = (u_xlatb10.x) ? u_xlat9.x : u_xlat7.x;
            u_xlat7.y = (u_xlatb10.y) ? u_xlat9.y : u_xlat7.y;
            u_xlat7.z = (u_xlatb10.z) ? u_xlat9.z : u_xlat7.z;
            u_xlat48 = min(u_xlat7.y, u_xlat7.x);
            u_xlat48 = min(u_xlat7.z, u_xlat48);
            u_xlat7.xyz = u_xlat11.xyz * vec3(u_xlat48) + u_xlat12.xyz;
        } else {
            u_xlat7.xyz = u_xlat5.xyz;
        //ENDIF
        }
        u_xlat10_1 = textureLod(_SpecCube1, u_xlat7.xyz, u_xlat33);
        u_xlat16_8.x = u_xlat10_1.w + -1.0;
        u_xlat16_8.x = _SpecCube1_HDR.w * u_xlat16_8.x + 1.0;
        u_xlat16_8.x = log2(u_xlat16_8.x);
        u_xlat16_8.x = u_xlat16_8.x * _SpecCube1_HDR.y;
        u_xlat16_8.x = exp2(u_xlat16_8.x);
        u_xlat16_8.x = u_xlat16_8.x * _SpecCube1_HDR.x;
        u_xlat16_8.xyz = u_xlat10_1.xyz * u_xlat16_8.xxx;
        u_xlat16_7.xyz = u_xlat10_3.xxx * u_xlat10_0.xyz + u_xlat10_3.yyy;
        u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_8.xyz;
        u_xlat33 = (-u_xlat45) + 1.0;
        u_xlat33 = min(u_xlat47, u_xlat33);
        u_xlat4.xzw = u_xlat16_7.xyz * vec3(u_xlat33) + u_xlat4.xzw;
        u_xlat45 = u_xlat45 + u_xlat47;
    //ENDIF
    }
    u_xlat7.x = sin(_SpecCube2_BoxMin.w);
    u_xlat9.x = cos(_SpecCube2_BoxMin.w);
    u_xlat10.x = (-u_xlat7.x);
    u_xlat16_8.xy = u_xlat2.xz + (-_SpecCube2_ProbePosition.xz);
    u_xlat10.y = u_xlat9.x;
    u_xlat9.x = dot(u_xlat10.yx, u_xlat16_8.xy);
    u_xlat10.z = u_xlat7.x;
    u_xlat9.z = dot(u_xlat10.zy, u_xlat16_8.xy);
    u_xlat6.xz = u_xlat9.xz + _SpecCube2_ProbePosition.xz;
    u_xlat16_8.xyz = u_xlat6.xyz + (-_SpecCube2_BoxMax.xyz);
    u_xlat16_13.xyz = (-u_xlat6.xyz) + _SpecCube2_BoxMin.xyz;
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, u_xlat16_13.xyz);
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_47 = dot(u_xlat16_8.xyz, u_xlat16_8.xyz);
    u_xlat16_47 = sqrt(u_xlat16_47);
    u_xlat47 = u_xlat16_47 / _SpecCube2_BoxMax.w;
    u_xlat47 = (-u_xlat47) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat47 = min(max(u_xlat47, 0.0), 1.0);
#else
    u_xlat47 = clamp(u_xlat47, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(0.0>=u_xlat47);
#else
    u_xlatb33 = 0.0>=u_xlat47;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb48 = !!(u_xlat45>=1.0);
#else
    u_xlatb48 = u_xlat45>=1.0;
#endif
    u_xlatb33 = u_xlatb48 || u_xlatb33;
    if(!u_xlatb33){
        u_xlat33 = u_xlat4.y * 6.0;
#ifdef UNITY_ADRENO_ES3
        u_xlatb48 = !!(0.0<_SpecCube2_ProbePosition.w);
#else
        u_xlatb48 = 0.0<_SpecCube2_ProbePosition.w;
#endif
        if(u_xlatb48){
            u_xlat7.xyz = _SpecCube2_BoxMin.xyz + (-_SpecCube2_BoxMax.www);
            u_xlat9.xyz = _SpecCube2_BoxMax.www + _SpecCube2_BoxMax.xyz;
            u_xlat48 = dot(u_xlat5.xyz, u_xlat5.xyz);
            u_xlat48 = inversesqrt(u_xlat48);
            u_xlat11.xyz = vec3(u_xlat48) * u_xlat5.xyz;
            u_xlat12.xyz = u_xlat2.xyz + (-_SpecCube2_ProbePosition.xyz);
            u_xlat14.x = dot(u_xlat10.yx, u_xlat12.xz);
            u_xlat14.z = dot(u_xlat10.zy, u_xlat12.xz);
            u_xlat6.xz = u_xlat14.xz + _SpecCube2_ProbePosition.xz;
            u_xlat14.x = dot(u_xlat10.yx, u_xlat11.xz);
            u_xlat14.z = dot(u_xlat10.zy, u_xlat11.xz);
            u_xlat9.xyz = (-u_xlat6.xyz) + u_xlat9.xyz;
            u_xlat14.y = u_xlat11.y;
            u_xlat9.xyz = u_xlat9.xyz / u_xlat14.xyz;
            u_xlat7.xyz = (-u_xlat6.xyz) + u_xlat7.xyz;
            u_xlat7.xyz = u_xlat7.xyz / u_xlat14.xyz;
            u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat14.xyzx).xyz;
            u_xlat7.x = (u_xlatb10.x) ? u_xlat9.x : u_xlat7.x;
            u_xlat7.y = (u_xlatb10.y) ? u_xlat9.y : u_xlat7.y;
            u_xlat7.z = (u_xlatb10.z) ? u_xlat9.z : u_xlat7.z;
            u_xlat48 = min(u_xlat7.y, u_xlat7.x);
            u_xlat48 = min(u_xlat7.z, u_xlat48);
            u_xlat7.xyz = u_xlat11.xyz * vec3(u_xlat48) + u_xlat12.xyz;
        } else {
            u_xlat7.xyz = u_xlat5.xyz;
        //ENDIF
        }
        u_xlat10_1 = textureLod(_SpecCube2, u_xlat7.xyz, u_xlat33);
        u_xlat16_8.x = u_xlat10_1.w + -1.0;
        u_xlat16_8.x = _SpecCube2_HDR.w * u_xlat16_8.x + 1.0;
        u_xlat16_8.x = log2(u_xlat16_8.x);
        u_xlat16_8.x = u_xlat16_8.x * _SpecCube2_HDR.y;
        u_xlat16_8.x = exp2(u_xlat16_8.x);
        u_xlat16_8.x = u_xlat16_8.x * _SpecCube2_HDR.x;
        u_xlat16_8.xyz = u_xlat10_1.xyz * u_xlat16_8.xxx;
        u_xlat16_7.xyz = u_xlat10_3.xxx * u_xlat10_0.xyz + u_xlat10_3.yyy;
        u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_8.xyz;
        u_xlat33 = (-u_xlat45) + 1.0;
        u_xlat33 = min(u_xlat47, u_xlat33);
        u_xlat4.xzw = u_xlat16_7.xyz * vec3(u_xlat33) + u_xlat4.xzw;
        u_xlat45 = u_xlat45 + u_xlat47;
    //ENDIF
    }
    u_xlat7.x = sin(_SpecCube3_BoxMin.w);
    u_xlat9.x = cos(_SpecCube3_BoxMin.w);
    u_xlat10.x = (-u_xlat7.x);
    u_xlat16_8.xy = u_xlat2.xz + (-_SpecCube3_ProbePosition.xz);
    u_xlat10.y = u_xlat9.x;
    u_xlat9.x = dot(u_xlat10.yx, u_xlat16_8.xy);
    u_xlat10.z = u_xlat7.x;
    u_xlat9.z = dot(u_xlat10.zy, u_xlat16_8.xy);
    u_xlat6.xz = u_xlat9.xz + _SpecCube3_ProbePosition.xz;
    u_xlat16_8.xyz = u_xlat6.xyz + (-_SpecCube3_BoxMax.xyz);
    u_xlat16_13.xyz = (-u_xlat6.xyz) + _SpecCube3_BoxMin.xyz;
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, u_xlat16_13.xyz);
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_47 = dot(u_xlat16_8.xyz, u_xlat16_8.xyz);
    u_xlat16_47 = sqrt(u_xlat16_47);
    u_xlat47 = u_xlat16_47 / _SpecCube3_BoxMax.w;
    u_xlat47 = (-u_xlat47) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat47 = min(max(u_xlat47, 0.0), 1.0);
#else
    u_xlat47 = clamp(u_xlat47, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(0.0>=u_xlat47);
#else
    u_xlatb33 = 0.0>=u_xlat47;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb48 = !!(u_xlat45>=1.0);
#else
    u_xlatb48 = u_xlat45>=1.0;
#endif
    u_xlatb33 = u_xlatb48 || u_xlatb33;
    if(!u_xlatb33){
        u_xlat33 = u_xlat4.y * 6.0;
#ifdef UNITY_ADRENO_ES3
        u_xlatb48 = !!(0.0<_SpecCube3_ProbePosition.w);
#else
        u_xlatb48 = 0.0<_SpecCube3_ProbePosition.w;
#endif
        if(u_xlatb48){
            u_xlat7.xyz = _SpecCube3_BoxMin.xyz + (-_SpecCube3_BoxMax.www);
            u_xlat9.xyz = _SpecCube3_BoxMax.www + _SpecCube3_BoxMax.xyz;
            u_xlat48 = dot(u_xlat5.xyz, u_xlat5.xyz);
            u_xlat48 = inversesqrt(u_xlat48);
            u_xlat11.xyz = vec3(u_xlat48) * u_xlat5.xyz;
            u_xlat12.xyz = u_xlat2.xyz + (-_SpecCube3_ProbePosition.xyz);
            u_xlat14.x = dot(u_xlat10.yx, u_xlat12.xz);
            u_xlat14.z = dot(u_xlat10.zy, u_xlat12.xz);
            u_xlat6.xz = u_xlat14.xz + _SpecCube3_ProbePosition.xz;
            u_xlat14.x = dot(u_xlat10.yx, u_xlat11.xz);
            u_xlat14.z = dot(u_xlat10.zy, u_xlat11.xz);
            u_xlat9.xyz = (-u_xlat6.xyz) + u_xlat9.xyz;
            u_xlat14.y = u_xlat11.y;
            u_xlat9.xyz = u_xlat9.xyz / u_xlat14.xyz;
            u_xlat7.xyz = (-u_xlat6.xyz) + u_xlat7.xyz;
            u_xlat7.xyz = u_xlat7.xyz / u_xlat14.xyz;
            u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat14.xyzx).xyz;
            u_xlat7.x = (u_xlatb10.x) ? u_xlat9.x : u_xlat7.x;
            u_xlat7.y = (u_xlatb10.y) ? u_xlat9.y : u_xlat7.y;
            u_xlat7.z = (u_xlatb10.z) ? u_xlat9.z : u_xlat7.z;
            u_xlat48 = min(u_xlat7.y, u_xlat7.x);
            u_xlat48 = min(u_xlat7.z, u_xlat48);
            u_xlat7.xyz = u_xlat11.xyz * vec3(u_xlat48) + u_xlat12.xyz;
        } else {
            u_xlat7.xyz = u_xlat5.xyz;
        //ENDIF
        }
        u_xlat10_1 = textureLod(_SpecCube3, u_xlat7.xyz, u_xlat33);
        u_xlat16_8.x = u_xlat10_1.w + -1.0;
        u_xlat16_8.x = _SpecCube3_HDR.w * u_xlat16_8.x + 1.0;
        u_xlat16_8.x = log2(u_xlat16_8.x);
        u_xlat16_8.x = u_xlat16_8.x * _SpecCube3_HDR.y;
        u_xlat16_8.x = exp2(u_xlat16_8.x);
        u_xlat16_8.x = u_xlat16_8.x * _SpecCube3_HDR.x;
        u_xlat16_8.xyz = u_xlat10_1.xyz * u_xlat16_8.xxx;
        u_xlat16_7.xyz = u_xlat10_3.xxx * u_xlat10_0.xyz + u_xlat10_3.yyy;
        u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_8.xyz;
        u_xlat33 = (-u_xlat45) + 1.0;
        u_xlat33 = min(u_xlat47, u_xlat33);
        u_xlat4.xzw = u_xlat16_7.xyz * vec3(u_xlat33) + u_xlat4.xzw;
        u_xlat45 = u_xlat45 + u_xlat47;
    //ENDIF
    }
    u_xlat7.x = sin(_SpecCube4_BoxMin.w);
    u_xlat9.x = cos(_SpecCube4_BoxMin.w);
    u_xlat10.x = (-u_xlat7.x);
    u_xlat16_8.xy = u_xlat2.xz + (-_SpecCube4_ProbePosition.xz);
    u_xlat10.y = u_xlat9.x;
    u_xlat9.x = dot(u_xlat10.yx, u_xlat16_8.xy);
    u_xlat10.z = u_xlat7.x;
    u_xlat9.z = dot(u_xlat10.zy, u_xlat16_8.xy);
    u_xlat6.xz = u_xlat9.xz + _SpecCube4_ProbePosition.xz;
    u_xlat16_8.xyz = u_xlat6.xyz + (-_SpecCube4_BoxMax.xyz);
    u_xlat16_13.xyz = (-u_xlat6.xyz) + _SpecCube4_BoxMin.xyz;
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, u_xlat16_13.xyz);
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_47 = dot(u_xlat16_8.xyz, u_xlat16_8.xyz);
    u_xlat16_47 = sqrt(u_xlat16_47);
    u_xlat47 = u_xlat16_47 / _SpecCube4_BoxMax.w;
    u_xlat47 = (-u_xlat47) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat47 = min(max(u_xlat47, 0.0), 1.0);
#else
    u_xlat47 = clamp(u_xlat47, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(0.0>=u_xlat47);
#else
    u_xlatb33 = 0.0>=u_xlat47;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb48 = !!(u_xlat45>=1.0);
#else
    u_xlatb48 = u_xlat45>=1.0;
#endif
    u_xlatb33 = u_xlatb48 || u_xlatb33;
    if(!u_xlatb33){
        u_xlat33 = u_xlat4.y * 6.0;
#ifdef UNITY_ADRENO_ES3
        u_xlatb48 = !!(0.0<_SpecCube4_ProbePosition.w);
#else
        u_xlatb48 = 0.0<_SpecCube4_ProbePosition.w;
#endif
        if(u_xlatb48){
            u_xlat7.xyz = _SpecCube4_BoxMin.xyz + (-_SpecCube4_BoxMax.www);
            u_xlat9.xyz = _SpecCube4_BoxMax.www + _SpecCube4_BoxMax.xyz;
            u_xlat48 = dot(u_xlat5.xyz, u_xlat5.xyz);
            u_xlat48 = inversesqrt(u_xlat48);
            u_xlat11.xyz = vec3(u_xlat48) * u_xlat5.xyz;
            u_xlat12.xyz = u_xlat2.xyz + (-_SpecCube4_ProbePosition.xyz);
            u_xlat14.x = dot(u_xlat10.yx, u_xlat12.xz);
            u_xlat14.z = dot(u_xlat10.zy, u_xlat12.xz);
            u_xlat6.xz = u_xlat14.xz + _SpecCube4_ProbePosition.xz;
            u_xlat14.x = dot(u_xlat10.yx, u_xlat11.xz);
            u_xlat14.z = dot(u_xlat10.zy, u_xlat11.xz);
            u_xlat9.xyz = (-u_xlat6.xyz) + u_xlat9.xyz;
            u_xlat14.y = u_xlat11.y;
            u_xlat9.xyz = u_xlat9.xyz / u_xlat14.xyz;
            u_xlat7.xyz = (-u_xlat6.xyz) + u_xlat7.xyz;
            u_xlat7.xyz = u_xlat7.xyz / u_xlat14.xyz;
            u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat14.xyzx).xyz;
            u_xlat7.x = (u_xlatb10.x) ? u_xlat9.x : u_xlat7.x;
            u_xlat7.y = (u_xlatb10.y) ? u_xlat9.y : u_xlat7.y;
            u_xlat7.z = (u_xlatb10.z) ? u_xlat9.z : u_xlat7.z;
            u_xlat48 = min(u_xlat7.y, u_xlat7.x);
            u_xlat48 = min(u_xlat7.z, u_xlat48);
            u_xlat7.xyz = u_xlat11.xyz * vec3(u_xlat48) + u_xlat12.xyz;
        } else {
            u_xlat7.xyz = u_xlat5.xyz;
        //ENDIF
        }
        u_xlat10_1 = textureLod(_SpecCube4, u_xlat7.xyz, u_xlat33);
        u_xlat16_8.x = u_xlat10_1.w + -1.0;
        u_xlat16_8.x = _SpecCube4_HDR.w * u_xlat16_8.x + 1.0;
        u_xlat16_8.x = log2(u_xlat16_8.x);
        u_xlat16_8.x = u_xlat16_8.x * _SpecCube4_HDR.y;
        u_xlat16_8.x = exp2(u_xlat16_8.x);
        u_xlat16_8.x = u_xlat16_8.x * _SpecCube4_HDR.x;
        u_xlat16_8.xyz = u_xlat10_1.xyz * u_xlat16_8.xxx;
        u_xlat16_7.xyz = u_xlat10_3.xxx * u_xlat10_0.xyz + u_xlat10_3.yyy;
        u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_8.xyz;
        u_xlat33 = (-u_xlat45) + 1.0;
        u_xlat33 = min(u_xlat47, u_xlat33);
        u_xlat4.xzw = u_xlat16_7.xyz * vec3(u_xlat33) + u_xlat4.xzw;
        u_xlat45 = u_xlat45 + u_xlat47;
    //ENDIF
    }
    u_xlat7.x = sin(_SpecCube5_BoxMin.w);
    u_xlat9.x = cos(_SpecCube5_BoxMin.w);
    u_xlat10.x = (-u_xlat7.x);
    u_xlat16_8.xy = u_xlat2.xz + (-_SpecCube5_ProbePosition.xz);
    u_xlat10.y = u_xlat9.x;
    u_xlat9.x = dot(u_xlat10.yx, u_xlat16_8.xy);
    u_xlat10.z = u_xlat7.x;
    u_xlat9.z = dot(u_xlat10.zy, u_xlat16_8.xy);
    u_xlat6.xz = u_xlat9.xz + _SpecCube5_ProbePosition.xz;
    u_xlat16_8.xyz = u_xlat6.xyz + (-_SpecCube5_BoxMax.xyz);
    u_xlat16_13.xyz = (-u_xlat6.xyz) + _SpecCube5_BoxMin.xyz;
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, u_xlat16_13.xyz);
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_47 = dot(u_xlat16_8.xyz, u_xlat16_8.xyz);
    u_xlat16_47 = sqrt(u_xlat16_47);
    u_xlat47 = u_xlat16_47 / _SpecCube5_BoxMax.w;
    u_xlat47 = (-u_xlat47) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat47 = min(max(u_xlat47, 0.0), 1.0);
#else
    u_xlat47 = clamp(u_xlat47, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(0.0>=u_xlat47);
#else
    u_xlatb33 = 0.0>=u_xlat47;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb48 = !!(u_xlat45>=1.0);
#else
    u_xlatb48 = u_xlat45>=1.0;
#endif
    u_xlatb33 = u_xlatb48 || u_xlatb33;
    if(!u_xlatb33){
        u_xlat33 = u_xlat4.y * 6.0;
#ifdef UNITY_ADRENO_ES3
        u_xlatb48 = !!(0.0<_SpecCube5_ProbePosition.w);
#else
        u_xlatb48 = 0.0<_SpecCube5_ProbePosition.w;
#endif
        if(u_xlatb48){
            u_xlat7.xyz = _SpecCube5_BoxMin.xyz + (-_SpecCube5_BoxMax.www);
            u_xlat9.xyz = _SpecCube5_BoxMax.www + _SpecCube5_BoxMax.xyz;
            u_xlat48 = dot(u_xlat5.xyz, u_xlat5.xyz);
            u_xlat48 = inversesqrt(u_xlat48);
            u_xlat11.xyz = vec3(u_xlat48) * u_xlat5.xyz;
            u_xlat12.xyz = u_xlat2.xyz + (-_SpecCube5_ProbePosition.xyz);
            u_xlat14.x = dot(u_xlat10.yx, u_xlat12.xz);
            u_xlat14.z = dot(u_xlat10.zy, u_xlat12.xz);
            u_xlat6.xz = u_xlat14.xz + _SpecCube5_ProbePosition.xz;
            u_xlat14.x = dot(u_xlat10.yx, u_xlat11.xz);
            u_xlat14.z = dot(u_xlat10.zy, u_xlat11.xz);
            u_xlat9.xyz = (-u_xlat6.xyz) + u_xlat9.xyz;
            u_xlat14.y = u_xlat11.y;
            u_xlat9.xyz = u_xlat9.xyz / u_xlat14.xyz;
            u_xlat7.xyz = (-u_xlat6.xyz) + u_xlat7.xyz;
            u_xlat7.xyz = u_xlat7.xyz / u_xlat14.xyz;
            u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat14.xyzx).xyz;
            u_xlat7.x = (u_xlatb10.x) ? u_xlat9.x : u_xlat7.x;
            u_xlat7.y = (u_xlatb10.y) ? u_xlat9.y : u_xlat7.y;
            u_xlat7.z = (u_xlatb10.z) ? u_xlat9.z : u_xlat7.z;
            u_xlat48 = min(u_xlat7.y, u_xlat7.x);
            u_xlat48 = min(u_xlat7.z, u_xlat48);
            u_xlat7.xyz = u_xlat11.xyz * vec3(u_xlat48) + u_xlat12.xyz;
        } else {
            u_xlat7.xyz = u_xlat5.xyz;
        //ENDIF
        }
        u_xlat10_1 = textureLod(_SpecCube5, u_xlat7.xyz, u_xlat33);
        u_xlat16_8.x = u_xlat10_1.w + -1.0;
        u_xlat16_8.x = _SpecCube5_HDR.w * u_xlat16_8.x + 1.0;
        u_xlat16_8.x = log2(u_xlat16_8.x);
        u_xlat16_8.x = u_xlat16_8.x * _SpecCube5_HDR.y;
        u_xlat16_8.x = exp2(u_xlat16_8.x);
        u_xlat16_8.x = u_xlat16_8.x * _SpecCube5_HDR.x;
        u_xlat16_8.xyz = u_xlat10_1.xyz * u_xlat16_8.xxx;
        u_xlat16_7.xyz = u_xlat10_3.xxx * u_xlat10_0.xyz + u_xlat10_3.yyy;
        u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_8.xyz;
        u_xlat33 = (-u_xlat45) + 1.0;
        u_xlat33 = min(u_xlat47, u_xlat33);
        u_xlat4.xzw = u_xlat16_7.xyz * vec3(u_xlat33) + u_xlat4.xzw;
        u_xlat45 = u_xlat45 + u_xlat47;
    //ENDIF
    }
    u_xlat7.x = sin(_SpecCube6_BoxMin.w);
    u_xlat9.x = cos(_SpecCube6_BoxMin.w);
    u_xlat10.x = (-u_xlat7.x);
    u_xlat16_8.xy = u_xlat2.xz + (-_SpecCube6_ProbePosition.xz);
    u_xlat10.y = u_xlat9.x;
    u_xlat9.x = dot(u_xlat10.yx, u_xlat16_8.xy);
    u_xlat10.z = u_xlat7.x;
    u_xlat9.z = dot(u_xlat10.zy, u_xlat16_8.xy);
    u_xlat6.xz = u_xlat9.xz + _SpecCube6_ProbePosition.xz;
    u_xlat16_8.xyz = u_xlat6.xyz + (-_SpecCube6_BoxMax.xyz);
    u_xlat16_13.xyz = (-u_xlat6.xyz) + _SpecCube6_BoxMin.xyz;
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, u_xlat16_13.xyz);
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_47 = dot(u_xlat16_8.xyz, u_xlat16_8.xyz);
    u_xlat16_47 = sqrt(u_xlat16_47);
    u_xlat47 = u_xlat16_47 / _SpecCube6_BoxMax.w;
    u_xlat47 = (-u_xlat47) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat47 = min(max(u_xlat47, 0.0), 1.0);
#else
    u_xlat47 = clamp(u_xlat47, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(0.0>=u_xlat47);
#else
    u_xlatb33 = 0.0>=u_xlat47;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb48 = !!(u_xlat45>=1.0);
#else
    u_xlatb48 = u_xlat45>=1.0;
#endif
    u_xlatb33 = u_xlatb48 || u_xlatb33;
    if(!u_xlatb33){
        u_xlat33 = u_xlat4.y * 6.0;
#ifdef UNITY_ADRENO_ES3
        u_xlatb48 = !!(0.0<_SpecCube6_ProbePosition.w);
#else
        u_xlatb48 = 0.0<_SpecCube6_ProbePosition.w;
#endif
        if(u_xlatb48){
            u_xlat7.xyz = _SpecCube6_BoxMin.xyz + (-_SpecCube6_BoxMax.www);
            u_xlat9.xyz = _SpecCube6_BoxMax.www + _SpecCube6_BoxMax.xyz;
            u_xlat48 = dot(u_xlat5.xyz, u_xlat5.xyz);
            u_xlat48 = inversesqrt(u_xlat48);
            u_xlat11.xyz = vec3(u_xlat48) * u_xlat5.xyz;
            u_xlat12.xyz = u_xlat2.xyz + (-_SpecCube6_ProbePosition.xyz);
            u_xlat14.x = dot(u_xlat10.yx, u_xlat12.xz);
            u_xlat14.z = dot(u_xlat10.zy, u_xlat12.xz);
            u_xlat6.xz = u_xlat14.xz + _SpecCube6_ProbePosition.xz;
            u_xlat14.x = dot(u_xlat10.yx, u_xlat11.xz);
            u_xlat14.z = dot(u_xlat10.zy, u_xlat11.xz);
            u_xlat9.xyz = (-u_xlat6.xyz) + u_xlat9.xyz;
            u_xlat14.y = u_xlat11.y;
            u_xlat9.xyz = u_xlat9.xyz / u_xlat14.xyz;
            u_xlat7.xyz = (-u_xlat6.xyz) + u_xlat7.xyz;
            u_xlat7.xyz = u_xlat7.xyz / u_xlat14.xyz;
            u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat14.xyzx).xyz;
            u_xlat7.x = (u_xlatb10.x) ? u_xlat9.x : u_xlat7.x;
            u_xlat7.y = (u_xlatb10.y) ? u_xlat9.y : u_xlat7.y;
            u_xlat7.z = (u_xlatb10.z) ? u_xlat9.z : u_xlat7.z;
            u_xlat48 = min(u_xlat7.y, u_xlat7.x);
            u_xlat48 = min(u_xlat7.z, u_xlat48);
            u_xlat7.xyz = u_xlat11.xyz * vec3(u_xlat48) + u_xlat12.xyz;
        } else {
            u_xlat7.xyz = u_xlat5.xyz;
        //ENDIF
        }
        u_xlat10_1 = textureLod(_SpecCube6, u_xlat7.xyz, u_xlat33);
        u_xlat16_8.x = u_xlat10_1.w + -1.0;
        u_xlat16_8.x = _SpecCube6_HDR.w * u_xlat16_8.x + 1.0;
        u_xlat16_8.x = log2(u_xlat16_8.x);
        u_xlat16_8.x = u_xlat16_8.x * _SpecCube6_HDR.y;
        u_xlat16_8.x = exp2(u_xlat16_8.x);
        u_xlat16_8.x = u_xlat16_8.x * _SpecCube6_HDR.x;
        u_xlat16_8.xyz = u_xlat10_1.xyz * u_xlat16_8.xxx;
        u_xlat16_7.xyz = u_xlat10_3.xxx * u_xlat10_0.xyz + u_xlat10_3.yyy;
        u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_8.xyz;
        u_xlat33 = (-u_xlat45) + 1.0;
        u_xlat33 = min(u_xlat47, u_xlat33);
        u_xlat4.xzw = u_xlat16_7.xyz * vec3(u_xlat33) + u_xlat4.xzw;
        u_xlat45 = u_xlat45 + u_xlat47;
    //ENDIF
    }
    u_xlat7.x = sin(_SpecCube7_BoxMin.w);
    u_xlat9.x = cos(_SpecCube7_BoxMin.w);
    u_xlat10.x = (-u_xlat7.x);
    u_xlat16_8.xy = u_xlat2.xz + (-_SpecCube7_ProbePosition.xz);
    u_xlat10.y = u_xlat9.x;
    u_xlat9.x = dot(u_xlat10.yx, u_xlat16_8.xy);
    u_xlat10.z = u_xlat7.x;
    u_xlat9.z = dot(u_xlat10.zy, u_xlat16_8.xy);
    u_xlat6.xz = u_xlat9.xz + _SpecCube7_ProbePosition.xz;
    u_xlat16_8.xyz = u_xlat6.xyz + (-_SpecCube7_BoxMax.xyz);
    u_xlat16_13.xyz = (-u_xlat6.xyz) + _SpecCube7_BoxMin.xyz;
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, u_xlat16_13.xyz);
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_47 = dot(u_xlat16_8.xyz, u_xlat16_8.xyz);
    u_xlat16_47 = sqrt(u_xlat16_47);
    u_xlat47 = u_xlat16_47 / _SpecCube7_BoxMax.w;
    u_xlat47 = (-u_xlat47) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat47 = min(max(u_xlat47, 0.0), 1.0);
#else
    u_xlat47 = clamp(u_xlat47, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(0.0>=u_xlat47);
#else
    u_xlatb33 = 0.0>=u_xlat47;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb48 = !!(u_xlat45>=1.0);
#else
    u_xlatb48 = u_xlat45>=1.0;
#endif
    u_xlatb33 = u_xlatb48 || u_xlatb33;
    if(!u_xlatb33){
        u_xlat33 = u_xlat4.y * 6.0;
#ifdef UNITY_ADRENO_ES3
        u_xlatb48 = !!(0.0<_SpecCube7_ProbePosition.w);
#else
        u_xlatb48 = 0.0<_SpecCube7_ProbePosition.w;
#endif
        if(u_xlatb48){
            u_xlat7.xyz = _SpecCube7_BoxMin.xyz + (-_SpecCube7_BoxMax.www);
            u_xlat9.xyz = _SpecCube7_BoxMax.www + _SpecCube7_BoxMax.xyz;
            u_xlat48 = dot(u_xlat5.xyz, u_xlat5.xyz);
            u_xlat48 = inversesqrt(u_xlat48);
            u_xlat11.xyz = vec3(u_xlat48) * u_xlat5.xyz;
            u_xlat2.xyz = u_xlat2.xyz + (-_SpecCube7_ProbePosition.xyz);
            u_xlat12.x = dot(u_xlat10.yx, u_xlat2.xz);
            u_xlat12.z = dot(u_xlat10.zy, u_xlat2.xz);
            u_xlat6.xz = u_xlat12.xz + _SpecCube7_ProbePosition.xz;
            u_xlat12.x = dot(u_xlat10.yx, u_xlat11.xz);
            u_xlat12.z = dot(u_xlat10.zy, u_xlat11.xz);
            u_xlat9.xyz = (-u_xlat6.xyz) + u_xlat9.xyz;
            u_xlat12.y = u_xlat11.y;
            u_xlat9.xyz = u_xlat9.xyz / u_xlat12.xyz;
            u_xlat6.xyz = (-u_xlat6.xyz) + u_xlat7.xyz;
            u_xlat6.xyz = u_xlat6.xyz / u_xlat12.xyz;
            u_xlatb7.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat12.xyzx).xyz;
            u_xlat6.x = (u_xlatb7.x) ? u_xlat9.x : u_xlat6.x;
            u_xlat6.y = (u_xlatb7.y) ? u_xlat9.y : u_xlat6.y;
            u_xlat6.z = (u_xlatb7.z) ? u_xlat9.z : u_xlat6.z;
            u_xlat48 = min(u_xlat6.y, u_xlat6.x);
            u_xlat48 = min(u_xlat6.z, u_xlat48);
            u_xlat2.xyz = u_xlat11.xyz * vec3(u_xlat48) + u_xlat2.xyz;
        } else {
            u_xlat2.xyz = u_xlat5.xyz;
        //ENDIF
        }
        u_xlat10_1 = textureLod(_SpecCube7, u_xlat2.xyz, u_xlat33);
        u_xlat16_8.x = u_xlat10_1.w + -1.0;
        u_xlat16_8.x = _SpecCube7_HDR.w * u_xlat16_8.x + 1.0;
        u_xlat16_8.x = log2(u_xlat16_8.x);
        u_xlat16_8.x = u_xlat16_8.x * _SpecCube7_HDR.y;
        u_xlat16_8.x = exp2(u_xlat16_8.x);
        u_xlat16_8.x = u_xlat16_8.x * _SpecCube7_HDR.x;
        u_xlat16_8.xyz = u_xlat10_1.xyz * u_xlat16_8.xxx;
        u_xlat16_2.xyz = u_xlat10_3.xxx * u_xlat10_0.xyz + u_xlat10_3.yyy;
        u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_8.xyz;
        u_xlat33 = (-u_xlat45) + 1.0;
        u_xlat33 = min(u_xlat47, u_xlat33);
        u_xlat4.xzw = u_xlat16_2.xyz * vec3(u_xlat33) + u_xlat4.xzw;
        u_xlat45 = u_xlat45 + u_xlat47;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat45<1.0);
#else
    u_xlatb2 = u_xlat45<1.0;
#endif
    if(u_xlatb2){
        u_xlat2.x = u_xlat4.y * 6.0;
        u_xlat10_1 = textureLod(_ReflectionSkyCubeMap, u_xlat5.xyz, u_xlat2.x);
        u_xlat16_8.x = u_xlat10_1.w + -1.0;
        u_xlat16_8.x = _ReflectionSkyCubeMap_HDR.w * u_xlat16_8.x + 1.0;
        u_xlat16_8.x = log2(u_xlat16_8.x);
        u_xlat16_8.x = u_xlat16_8.x * _ReflectionSkyCubeMap_HDR.y;
        u_xlat16_8.x = exp2(u_xlat16_8.x);
        u_xlat16_8.x = u_xlat16_8.x * _ReflectionSkyCubeMap_HDR.x;
        u_xlat16_8.xyz = u_xlat10_1.xyz * u_xlat16_8.xxx;
        u_xlat16_0.xyz = u_xlat10_3.xxx * u_xlat10_0.xyz + u_xlat10_3.yyy;
        u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_8.xyz;
        u_xlat45 = (-u_xlat45) + 1.0;
        u_xlat4.xzw = u_xlat16_0.xyz * vec3(u_xlat45) + u_xlat4.xzw;
    //ENDIF
    }
    SV_Target0.xyz = u_xlat4.xzw;
    SV_Target0.w = 1.0;
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
Keywords { "SSR_DISABLED" }
""
}
}
}
}
}