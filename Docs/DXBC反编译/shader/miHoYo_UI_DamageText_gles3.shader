//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/UI/DamageText" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
}
SubShader {
 LOD 100
 Tags { "QUEUE" = "AfterPostProcess" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "QUEUE" = "AfterPostProcess" "RenderType" = "Transparent" }
  ZTest Off
  Cull Off
  GpuProgramID 17700
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

vec4 ImmCB_0_0_0[4];
uniform 	vec4 hlslcc_mtx4x4_TextParticleCanvasToClip[4];
uniform 	vec2 _TextParticleOutlineDistance;
uniform 	vec4 hlslcc_mtx4x4_TextParticleUVOffsetsArray[4];
uniform 	mediump vec4 _MeshParticleColorArray;
uniform 	mediump vec4 _TextParticleOutlineColorArray;
uniform 	mediump vec4 _TextParticlePositionArray;
in highp vec4 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
ivec2 u_xlati0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec2 u_xlat2;
ivec2 u_xlati2;
bool u_xlatb4;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlati0.xy = ivec2(in_POSITION0.xz);
    vs_TEXCOORD0.x = dot(hlslcc_mtx4x4_TextParticleUVOffsetsArray[0], ImmCB_0_0_0[u_xlati0.x]);
    vs_TEXCOORD0.y = dot(hlslcc_mtx4x4_TextParticleUVOffsetsArray[1], ImmCB_0_0_0[u_xlati0.x]);
    u_xlati2.y = int(uint(u_xlati0.y) & 1u);
    u_xlati2.x = u_xlati0.y >> 1;
    u_xlat1.xy = vec2(u_xlati2.yx);
    u_xlat2.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = dot(hlslcc_mtx4x4_TextParticleUVOffsetsArray[2], ImmCB_0_0_0[u_xlati0.x]);
    u_xlat1.y = dot(hlslcc_mtx4x4_TextParticleUVOffsetsArray[3], ImmCB_0_0_0[u_xlati0.x]);
    u_xlat0.xy = u_xlat2.xy * _TextParticleOutlineDistance.xy + u_xlat1.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(in_POSITION0.y));
#else
    u_xlatb4 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(in_POSITION0.y);
#endif
    u_xlat0.xy = (bool(u_xlatb4)) ? u_xlat0.xy : u_xlat1.xy;
    u_xlat1.xy = u_xlat0.xy * _TextParticlePositionArray.ww;
    u_xlat1.z = 0.0;
    u_xlat0.xyw = u_xlat1.xyz + _TextParticlePositionArray.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_TextParticleCanvasToClip[1];
    u_xlat1 = hlslcc_mtx4x4_TextParticleCanvasToClip[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_TextParticleCanvasToClip[2] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1 + hlslcc_mtx4x4_TextParticleCanvasToClip[3];
    u_xlat16_1 = _MeshParticleColorArray.wwww * _TextParticleOutlineColorArray;
    vs_COLOR0 = (bool(u_xlatb4)) ? u_xlat16_1 : _MeshParticleColorArray;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_0 = u_xlat10_0 * vs_COLOR0.w;
    SV_Target0.w = u_xlat16_0;
    SV_Target0.xyz = vs_COLOR0.xyz;
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

vec4 ImmCB_0_0_0[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 hlslcc_mtx4x4_TextParticleCanvasToClip[4];
uniform 	vec2 _TextParticleOutlineDistance;
struct miHoYoParticlesTextArray_Type {
	vec4 hlslcc_mtx4x4_TextParticleUVOffsetsArray[4];
	mediump vec4 _MeshParticleColorArray;
	mediump vec4 _TextParticleOutlineColorArray;
	mediump vec4 _TextParticlePositionArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesText {
	miHoYoParticlesTextArray_Type miHoYoParticlesTextArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec2 u_xlat2;
vec2 u_xlat3;
ivec2 u_xlati3;
bool u_xlatb3;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati3.x = int(in_POSITION0.x);
    u_xlati0 = u_xlati0 * 7;
    vs_TEXCOORD0.x = dot(miHoYoParticlesTextArray[u_xlati0 / 7].hlslcc_mtx4x4_TextParticleUVOffsetsArray[0], ImmCB_0_0_0[u_xlati3.x]);
    vs_TEXCOORD0.y = dot(miHoYoParticlesTextArray[u_xlati0 / 7].hlslcc_mtx4x4_TextParticleUVOffsetsArray[1], ImmCB_0_0_0[u_xlati3.x]);
    u_xlat1.x = dot(miHoYoParticlesTextArray[u_xlati0 / 7].hlslcc_mtx4x4_TextParticleUVOffsetsArray[2], ImmCB_0_0_0[u_xlati3.x]);
    u_xlat1.y = dot(miHoYoParticlesTextArray[u_xlati0 / 7].hlslcc_mtx4x4_TextParticleUVOffsetsArray[3], ImmCB_0_0_0[u_xlati3.x]);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(in_POSITION0.y));
#else
    u_xlatb3 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(in_POSITION0.y);
#endif
    if(u_xlatb3){
        vs_COLOR0 = miHoYoParticlesTextArray[u_xlati0 / 7]._MeshParticleColorArray.wwww * miHoYoParticlesTextArray[u_xlati0 / 7]._TextParticleOutlineColorArray;
        u_xlati3.x = int(in_POSITION0.z);
        u_xlati3.y = int(uint(u_xlati3.x) & 1u);
        u_xlati3.x = u_xlati3.x >> 1;
        u_xlat2.xy = vec2(u_xlati3.yx);
        u_xlat3.xy = u_xlat2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat1.xy = u_xlat3.xy * _TextParticleOutlineDistance.xy + u_xlat1.xy;
    } else {
        vs_COLOR0 = miHoYoParticlesTextArray[u_xlati0 / 7]._MeshParticleColorArray;
    //ENDIF
    }
    u_xlat1.xy = u_xlat1.xy * miHoYoParticlesTextArray[u_xlati0 / 7]._TextParticlePositionArray.ww;
    u_xlat1.z = 0.0;
    u_xlat0.xyz = u_xlat1.xyz + miHoYoParticlesTextArray[u_xlati0 / 7]._TextParticlePositionArray.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_TextParticleCanvasToClip[1];
    u_xlat1 = hlslcc_mtx4x4_TextParticleCanvasToClip[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4_TextParticleCanvasToClip[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = u_xlat0 + hlslcc_mtx4x4_TextParticleCanvasToClip[3];
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
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_0 = u_xlat10_0 * vs_COLOR0.w;
    SV_Target0.w = u_xlat16_0;
    SV_Target0.xyz = vs_COLOR0.xyz;
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
}