//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Fog/GodRay" {
Properties {
}
SubShader {
 Pass {
  Name "GODRAYGENERATE"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 18742
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 unity_ShadowPos[4];
uniform 	float _GodRayExponent;
uniform highp sampler2D _CameraSSAODepthTextureScaled;
uniform lowp sampler2DShadow hlslcc_zcmp_CascadeShadowMapTexture;
uniform lowp sampler2D _CascadeShadowMapTexture;
uniform lowp sampler2D _BlueNoiseTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
float u_xlat0;
float u_xlat1;
ivec4 u_xlati1;
uvec4 u_xlatu1;
vec4 u_xlat2;
uvec4 u_xlatu2;
vec3 u_xlat3;
uvec4 u_xlatu3;
vec3 u_xlat4;
float u_xlat5;
float u_xlat8;
ivec2 u_xlati8;
float u_xlat12;
lowp float u_xlat10_12;
int u_xlati12;
uint u_xlatu12;
bool u_xlatb12;
void main()
{
    u_xlat0 = texture(_CameraSSAODepthTextureScaled, vs_TEXCOORD0.xy).x;
    u_xlat0 = u_xlat0 * _ProjectionParams.z;
    u_xlat0 = min(u_xlat0, 64.0);
    u_xlat4.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
    u_xlat4.x = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
    u_xlat4.x = u_xlat4.x * 0.499900013 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _GodRayExponent;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlati8.xy = ivec2(gl_FragCoord.xy);
    u_xlati1.xy = ivec2(uvec2(u_xlati8.xy) & uvec2(2147483648u, 2147483648u));
    u_xlati1.z = int(0);
    u_xlati1.w = int(0);
    u_xlati8.xy = max(u_xlati8.xy, (-u_xlati8.xy));
    u_xlatu2.xy = uvec2(u_xlati8.xy) & uvec2(63u, 63u);
    u_xlatu2.z = uint(uint(0u));
    u_xlatu2.w = uint(uint(0u));
    u_xlatu3 = uvec4(0 - ivec4(u_xlatu2.xyww));
    u_xlatu1.x = (u_xlati1.x != 0) ? u_xlatu3.x : u_xlatu2.x;
    u_xlatu1.y = (u_xlati1.y != 0) ? u_xlatu3.y : u_xlatu2.y;
    u_xlatu1.z = (u_xlati1.z != 0) ? u_xlatu3.z : u_xlatu2.z;
    u_xlatu1.w = (u_xlati1.w != 0) ? u_xlatu3.w : u_xlatu2.w;
    u_xlat8 = texelFetch(_BlueNoiseTex, ivec2(u_xlatu1.xy), 0).x;
    u_xlat8 = u_xlat8 * 4.0;
    u_xlat1 = 0.0;
    u_xlat5 = u_xlat8;
    while(true){
#ifdef UNITY_ADRENO_ES3
        u_xlatb12 = !!(u_xlat5>=u_xlat0);
#else
        u_xlatb12 = u_xlat5>=u_xlat0;
#endif
        if(u_xlatb12){break;}
        u_xlat2.xyz = vs_TEXCOORD1.xyz * vec3(u_xlat5) + _WorldSpaceCameraPos.xyz;
        u_xlat12 = u_xlat5 * 0.319999993;
        u_xlat12 = log2(u_xlat12);
        u_xlat12 = u_xlat12 + 0.400000006;
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlatu12 = uint(u_xlat12);
        u_xlat2.xyz = u_xlat2.xyz + (-unity_ShadowPos[int(u_xlatu12)].xyz);
        u_xlati12 = int(u_xlatu12) << 2;
        u_xlat3.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati12 + 1)].xyz;
        u_xlat2.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati12].xyz * u_xlat2.xxx + u_xlat3.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati12 + 2)].xyz * u_xlat2.zzz + u_xlat2.xyw;
        u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati12 + 3)].xyz;
        vec3 txVec0 = vec3(u_xlat2.xy,u_xlat2.z);
        u_xlat10_12 = textureLod(hlslcc_zcmp_CascadeShadowMapTexture, txVec0, 0.0);
        u_xlat1 = u_xlat10_12 + u_xlat1;
        u_xlat5 = u_xlat5 + 4.0;
    }
    u_xlat0 = u_xlat4.x * u_xlat1;
    SV_Target0.x = u_xlat0 * 0.0625;
    SV_Target0.yzw = vec3(0.0, 0.0, 1.0);
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
}