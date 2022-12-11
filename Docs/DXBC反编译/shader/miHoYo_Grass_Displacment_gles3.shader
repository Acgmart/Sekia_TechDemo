//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Grass/Displacment" {
Properties {
}
SubShader {
 LOD 100
 Tags { "RenderType" = "Opaque" }
 Pass {
  LOD 100
  Tags { "RenderType" = "Opaque" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 43883
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4_GrassDisplacementVP[4];
uniform 	vec4 _Dir;
uniform 	vec4 hlslcc_mtx4x4_Matrix[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_NORMAL0;
out highp float vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD3;
out highp vec2 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat6;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
void main()
{
    u_xlat0.xy = _Time.yy * vec2(1.14999998, 1.75);
    u_xlat0.z = in_POSITION0.x * in_POSITION0.z + u_xlat0.x;
    u_xlat0.xy = vec2(u_xlat0.y + float(0.5), u_xlat0.z + float(0.5));
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat8.xy = abs(u_xlat0.xy) * abs(u_xlat0.xy);
    u_xlat0.xy = -abs(u_xlat0.xy) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat0.xy = u_xlat0.xy * u_xlat8.xy;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4_Matrix[1];
    u_xlat1 = hlslcc_mtx4x4_Matrix[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_Matrix[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_Matrix[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat8.xy = u_xlat1.xz + (-hlslcc_mtx4x4_Matrix[3].xz);
    u_xlat2.x = dot(u_xlat8.xy, u_xlat8.xy);
    u_xlat6 = inversesqrt(u_xlat2.x);
    u_xlat8.xy = u_xlat8.xy * vec2(u_xlat6);
    u_xlat8.x = dot(u_xlat8.xy, _Dir.xz);
    u_xlat12 = u_xlat0.x * u_xlat8.x;
    vs_TEXCOORD5.xy = u_xlat0.xy;
    u_xlat0.x = u_xlat8.x * 10.0;
    u_xlat4.xyz = vec3(u_xlat12) * vec3(0.25, 0.25, 0.25) + u_xlat1.xyz;
    u_xlat3 = u_xlat4.yyyy * hlslcc_mtx4x4_GrassDisplacementVP[1];
    u_xlat3 = hlslcc_mtx4x4_GrassDisplacementVP[0] * u_xlat4.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4_GrassDisplacementVP[2] * u_xlat4.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4_GrassDisplacementVP[3] * u_xlat1.wwww + u_xlat3;
    vs_TEXCOORD0.w = u_xlat1.w;
    gl_Position = u_xlat3;
    vs_TEXCOORD1 = u_xlat3;
    vs_TEXCOORD0.xyz = u_xlat4.xyz;
    vs_TEXCOORD3.xy = u_xlat4.xz * vec2(0.25, 0.25);
    u_xlat4.x = min(u_xlat2.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat2.x<0.0250000004);
#else
    u_xlatb8 = u_xlat2.x<0.0250000004;
#endif
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat0.x + 0.349999994;
    vs_TEXCOORD2 = u_xlat0.x;
    u_xlat0.x = min(u_xlat4.x, 1.0);
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4_Matrix[1].xzy;
    u_xlat1.xyz = hlslcc_mtx4x4_Matrix[0].xzy * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_Matrix[2].xzy * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.xyz + vec3(-0.0, -0.0, -1.0);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat2.xyz + vec3(0.0, 0.0, 1.0);
    vs_NORMAL0.xyz = (bool(u_xlatb8)) ? u_xlat0.xyw : u_xlat1.xyz;
    u_xlat0.xy = hlslcc_mtx4x4_Matrix[3].xz * vec2(0.00499999989, 0.00499999989);
    vs_TEXCOORD4.xy = in_POSITION0.xz * vec2(8.0, 8.0) + u_xlat0.xy;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _Params;
uniform lowp sampler2D _GrassDisplacementNoiseTex;
in highp vec3 vs_NORMAL0;
in highp float vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD3;
in highp vec2 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
lowp float u_xlat10_0;
float u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec2 u_xlat10_1;
vec3 u_xlat2;
vec2 u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, vs_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_NORMAL0.xyz;
    u_xlat10_1.xy = texture(_GrassDisplacementNoiseTex, vs_TEXCOORD3.xy).xy;
    u_xlat16_1.xy = u_xlat10_1.yx * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat9 = u_xlat0.y * u_xlat16_1.x;
    u_xlat2.x = u_xlat0.x * u_xlat16_1.y + (-u_xlat9);
    u_xlat2.y = dot(u_xlat0.xy, u_xlat16_1.xy);
    u_xlat10_0 = texture(_GrassDisplacementNoiseTex, vs_TEXCOORD4.xy).z;
    u_xlat0.x = u_xlat10_0 * vs_TEXCOORD2;
    u_xlat3.x = u_xlat0.x * 0.0599999987 + 1.0;
    u_xlat0.x = u_xlat0.x * 0.0700000003;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.z) + u_xlat0.z;
    u_xlat0.x = u_xlat0.x + -1.0;
    u_xlat3.xy = u_xlat3.xx * u_xlat2.xy;
    u_xlat9 = (-vs_TEXCOORD5.y) + -0.550000012;
    u_xlat9 = u_xlat9 * vs_TEXCOORD2;
    u_xlat9 = u_xlat9 * 0.300000012 + _Params.x;
    u_xlat1 = u_xlat9 * _Params.y;
    u_xlat2.z = u_xlat9 * u_xlat0.x + 1.0;
    u_xlat2.xy = u_xlat3.xy * vec2(u_xlat1);
    SV_Target0.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = _Params.y;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4_GrassDisplacementVP[4];
uniform 	vec4 _Dir;
uniform 	vec4 hlslcc_mtx4x4_Matrix[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_NORMAL0;
out highp float vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD3;
out highp vec2 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat6;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
void main()
{
    u_xlat0.xy = _Time.yy * vec2(1.14999998, 1.75);
    u_xlat0.z = in_POSITION0.x * in_POSITION0.z + u_xlat0.x;
    u_xlat0.xy = vec2(u_xlat0.y + float(0.5), u_xlat0.z + float(0.5));
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat8.xy = abs(u_xlat0.xy) * abs(u_xlat0.xy);
    u_xlat0.xy = -abs(u_xlat0.xy) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat0.xy = u_xlat0.xy * u_xlat8.xy;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4_Matrix[1];
    u_xlat1 = hlslcc_mtx4x4_Matrix[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_Matrix[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_Matrix[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat8.xy = u_xlat1.xz + (-hlslcc_mtx4x4_Matrix[3].xz);
    u_xlat2.x = dot(u_xlat8.xy, u_xlat8.xy);
    u_xlat6 = inversesqrt(u_xlat2.x);
    u_xlat8.xy = u_xlat8.xy * vec2(u_xlat6);
    u_xlat8.x = dot(u_xlat8.xy, _Dir.xz);
    u_xlat12 = u_xlat0.x * u_xlat8.x;
    vs_TEXCOORD5.xy = u_xlat0.xy;
    u_xlat0.x = u_xlat8.x * 10.0;
    u_xlat4.xyz = vec3(u_xlat12) * vec3(0.25, 0.25, 0.25) + u_xlat1.xyz;
    u_xlat3 = u_xlat4.yyyy * hlslcc_mtx4x4_GrassDisplacementVP[1];
    u_xlat3 = hlslcc_mtx4x4_GrassDisplacementVP[0] * u_xlat4.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4_GrassDisplacementVP[2] * u_xlat4.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4_GrassDisplacementVP[3] * u_xlat1.wwww + u_xlat3;
    vs_TEXCOORD0.w = u_xlat1.w;
    gl_Position = u_xlat3;
    vs_TEXCOORD1 = u_xlat3;
    vs_TEXCOORD0.xyz = u_xlat4.xyz;
    vs_TEXCOORD3.xy = u_xlat4.xz * vec2(0.25, 0.25);
    u_xlat4.x = min(u_xlat2.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat2.x<0.0250000004);
#else
    u_xlatb8 = u_xlat2.x<0.0250000004;
#endif
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat0.x + 0.349999994;
    vs_TEXCOORD2 = u_xlat0.x;
    u_xlat0.x = min(u_xlat4.x, 1.0);
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4_Matrix[1].xzy;
    u_xlat1.xyz = hlslcc_mtx4x4_Matrix[0].xzy * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_Matrix[2].xzy * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.xyz + vec3(-0.0, -0.0, -1.0);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat2.xyz + vec3(0.0, 0.0, 1.0);
    vs_NORMAL0.xyz = (bool(u_xlatb8)) ? u_xlat0.xyw : u_xlat1.xyz;
    u_xlat0.xy = hlslcc_mtx4x4_Matrix[3].xz * vec2(0.00499999989, 0.00499999989);
    vs_TEXCOORD4.xy = in_POSITION0.xz * vec2(8.0, 8.0) + u_xlat0.xy;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _Params;
uniform lowp sampler2D _GrassDisplacementNoiseTex;
in highp vec3 vs_NORMAL0;
in highp float vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD3;
in highp vec2 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
lowp float u_xlat10_0;
float u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec2 u_xlat10_1;
vec3 u_xlat2;
vec2 u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, vs_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_NORMAL0.xyz;
    u_xlat10_1.xy = texture(_GrassDisplacementNoiseTex, vs_TEXCOORD3.xy).xy;
    u_xlat16_1.xy = u_xlat10_1.yx * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat9 = u_xlat0.y * u_xlat16_1.x;
    u_xlat2.x = u_xlat0.x * u_xlat16_1.y + (-u_xlat9);
    u_xlat2.y = dot(u_xlat0.xy, u_xlat16_1.xy);
    u_xlat10_0 = texture(_GrassDisplacementNoiseTex, vs_TEXCOORD4.xy).z;
    u_xlat0.x = u_xlat10_0 * vs_TEXCOORD2;
    u_xlat3.x = u_xlat0.x * 0.0599999987 + 1.0;
    u_xlat0.x = u_xlat0.x * 0.0700000003;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.z) + u_xlat0.z;
    u_xlat0.x = u_xlat0.x + -1.0;
    u_xlat3.xy = u_xlat3.xx * u_xlat2.xy;
    u_xlat9 = (-vs_TEXCOORD5.y) + -0.550000012;
    u_xlat9 = u_xlat9 * vs_TEXCOORD2;
    u_xlat9 = u_xlat9 * 0.300000012 + _Params.x;
    u_xlat1 = u_xlat9 * _Params.y;
    u_xlat2.z = u_xlat9 * u_xlat0.x + 1.0;
    u_xlat2.xy = u_xlat3.xy * vec2(u_xlat1);
    SV_Target0.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = _Params.y;
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
  LOD 100
  Tags { "RenderType" = "Opaque" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 117080
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Dir;
uniform 	vec4 hlslcc_mtx4x4_Matrix[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_NORMAL0;
out highp float vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD3;
out highp vec2 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat6;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
void main()
{
    u_xlat0.xy = _Time.yy * vec2(1.14999998, 1.75);
    u_xlat0.z = in_POSITION0.x * in_POSITION0.z + u_xlat0.x;
    u_xlat0.xy = vec2(u_xlat0.y + float(0.5), u_xlat0.z + float(0.5));
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat8.xy = abs(u_xlat0.xy) * abs(u_xlat0.xy);
    u_xlat0.xy = -abs(u_xlat0.xy) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat0.xy = u_xlat0.xy * u_xlat8.xy;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4_Matrix[1];
    u_xlat1 = hlslcc_mtx4x4_Matrix[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_Matrix[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_Matrix[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat8.xy = u_xlat1.xz + (-hlslcc_mtx4x4_Matrix[3].xz);
    u_xlat2.x = dot(u_xlat8.xy, u_xlat8.xy);
    u_xlat6 = inversesqrt(u_xlat2.x);
    u_xlat8.xy = u_xlat8.xy * vec2(u_xlat6);
    u_xlat8.x = dot(u_xlat8.xy, _Dir.xz);
    u_xlat12 = u_xlat0.x * u_xlat8.x;
    vs_TEXCOORD5.xy = u_xlat0.xy;
    u_xlat0.x = u_xlat8.x * 10.0;
    u_xlat4.xyz = vec3(u_xlat12) * vec3(0.25, 0.25, 0.25) + u_xlat1.xyz;
    u_xlat3 = u_xlat4.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat4.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat4.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat3;
    vs_TEXCOORD0.w = u_xlat1.w;
    gl_Position = u_xlat3;
    vs_TEXCOORD1 = u_xlat3;
    vs_TEXCOORD0.xyz = u_xlat4.xyz;
    vs_TEXCOORD3.xy = u_xlat4.xz * vec2(0.25, 0.25);
    u_xlat4.x = min(u_xlat2.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat2.x<0.0250000004);
#else
    u_xlatb8 = u_xlat2.x<0.0250000004;
#endif
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat0.x + 0.349999994;
    vs_TEXCOORD2 = u_xlat0.x;
    u_xlat0.x = min(u_xlat4.x, 1.0);
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4_Matrix[1].xzy;
    u_xlat1.xyz = hlslcc_mtx4x4_Matrix[0].xzy * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_Matrix[2].xzy * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.xyz + vec3(-0.0, -0.0, -1.0);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat2.xyz + vec3(0.0, 0.0, 1.0);
    vs_NORMAL0.xyz = (bool(u_xlatb8)) ? u_xlat0.xyw : u_xlat1.xyz;
    u_xlat0.xy = hlslcc_mtx4x4_Matrix[3].xz * vec2(0.00499999989, 0.00499999989);
    vs_TEXCOORD4.xy = in_POSITION0.xz * vec2(8.0, 8.0) + u_xlat0.xy;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _Params;
uniform lowp sampler2D _GrassDisplacementNoiseTex;
in highp vec3 vs_NORMAL0;
in highp float vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD3;
in highp vec2 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
lowp float u_xlat10_0;
float u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec2 u_xlat10_1;
vec3 u_xlat2;
vec2 u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, vs_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_NORMAL0.xyz;
    u_xlat10_1.xy = texture(_GrassDisplacementNoiseTex, vs_TEXCOORD3.xy).xy;
    u_xlat16_1.xy = u_xlat10_1.yx * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat9 = u_xlat0.y * u_xlat16_1.x;
    u_xlat2.x = u_xlat0.x * u_xlat16_1.y + (-u_xlat9);
    u_xlat2.y = dot(u_xlat0.xy, u_xlat16_1.xy);
    u_xlat10_0 = texture(_GrassDisplacementNoiseTex, vs_TEXCOORD4.xy).z;
    u_xlat0.x = u_xlat10_0 * vs_TEXCOORD2;
    u_xlat3.x = u_xlat0.x * 0.0599999987 + 1.0;
    u_xlat0.x = u_xlat0.x * 0.0700000003;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.z) + u_xlat0.z;
    u_xlat0.x = u_xlat0.x + -1.0;
    u_xlat3.xy = u_xlat3.xx * u_xlat2.xy;
    u_xlat9 = (-vs_TEXCOORD5.y) + -0.550000012;
    u_xlat9 = u_xlat9 * vs_TEXCOORD2;
    u_xlat9 = u_xlat9 * 0.300000012 + _Params.x;
    u_xlat1 = u_xlat9 * _Params.y;
    u_xlat2.z = u_xlat9 * u_xlat0.x + 1.0;
    u_xlat2.xy = u_xlat3.xy * vec2(u_xlat1);
    SV_Target0.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.200000003;
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