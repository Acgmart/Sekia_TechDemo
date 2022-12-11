//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "UI/ColorWheel" {
Properties {
_MainTex ("Dummy", 2D) = "white" { }
_Color ("Color", Color) = (1,1,1,1)
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  GpuProgramID 24016
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump vec4 _Color;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
bvec2 u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_5;
bool u_xlatb5;
bool u_xlatb6;
mediump float u_xlat16_7;
mediump vec2 u_xlat16_8;
vec2 u_xlat10;
mediump vec2 u_xlat16_10;
bool u_xlatb10;
vec2 u_xlat11;
mediump vec2 u_xlat16_11;
mediump float u_xlat16_12;
float u_xlat15;
mediump float u_xlat16_15;
bool u_xlatb15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = (-vs_TEXCOORD0.xy) + vec2(0.5, 0.5);
    u_xlat10.x = max(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat10.x = float(1.0) / u_xlat10.x;
    u_xlat15 = min(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat10.x = u_xlat10.x * u_xlat15;
    u_xlat15 = u_xlat10.x * u_xlat10.x;
    u_xlat1.x = u_xlat15 * 0.0208350997 + -0.0851330012;
    u_xlat1.x = u_xlat15 * u_xlat1.x + 0.180141002;
    u_xlat1.x = u_xlat15 * u_xlat1.x + -0.330299497;
    u_xlat15 = u_xlat15 * u_xlat1.x + 0.999866009;
    u_xlat1.x = u_xlat15 * u_xlat10.x;
    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(abs(u_xlat0.y)<abs(u_xlat0.x));
#else
    u_xlatb6 = abs(u_xlat0.y)<abs(u_xlat0.x);
#endif
    u_xlat1.x = u_xlatb6 ? u_xlat1.x : float(0.0);
    u_xlat10.x = u_xlat10.x * u_xlat15 + u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat0.y<(-u_xlat0.y));
#else
    u_xlatb15 = u_xlat0.y<(-u_xlat0.y);
#endif
    u_xlat15 = u_xlatb15 ? -3.14159274 : float(0.0);
    u_xlat10.x = u_xlat15 + u_xlat10.x;
    u_xlat15 = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb0 = u_xlat0.x>=(-u_xlat0.x);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat15<(-u_xlat15));
#else
    u_xlatb5 = u_xlat15<(-u_xlat15);
#endif
    u_xlatb0 = u_xlatb0 && u_xlatb5;
    u_xlat0.x = (u_xlatb0) ? (-u_xlat10.x) : u_xlat10.x;
    u_xlat0.x = u_xlat0.x + 3.14159274;
    u_xlat16_2.xy = (-u_xlat0.xx) + vec2(2.09439516, 4.18879032);
    u_xlat16_12 = cos(u_xlat0.x);
    u_xlat16_2.z = max(u_xlat16_12, -0.99000001);
    u_xlat16_2.xy = cos(u_xlat16_2.xy);
    u_xlat16_2.xy = max(u_xlat16_2.xy, vec2(-0.99000001, -0.99000001));
    u_xlat16_2.xyz = min(u_xlat16_2.xyz, vec3(0.99000001, 0.99000001, 0.99000001));
    u_xlat16_0.xy = abs(u_xlat16_2.xy) * vec2(-0.0187292993, -0.0187292993) + vec2(0.0742610022, 0.0742610022);
    u_xlat16_0.xy = u_xlat16_0.xy * abs(u_xlat16_2.xy) + vec2(-0.212114394, -0.212114394);
    u_xlat16_0.xy = u_xlat16_0.xy * abs(u_xlat16_2.xy) + vec2(1.57072878, 1.57072878);
    u_xlat16_10.xy = -abs(u_xlat16_2.xy) + vec2(1.0, 1.0);
    u_xlatb1.xy = lessThan(u_xlat16_2.xyxx, (-u_xlat16_2.xyxx)).xy;
    u_xlat16_10.xy = sqrt(u_xlat16_10.xy);
    u_xlat16_11.xy = u_xlat16_10.xy * u_xlat16_0.xy;
    u_xlat11.xy = u_xlat16_11.xy * vec2(-2.0, -2.0) + vec2(3.14159274, 3.14159274);
    u_xlat1.xy = mix(vec2(0.0, 0.0), u_xlat11.xy, vec2(u_xlatb1.xy));
    u_xlat0.xy = u_xlat16_0.xy * u_xlat16_10.xy + u_xlat1.xy;
    u_xlat0.xy = (-u_xlat0.xy) + vec2(1.57079637, 1.57079637);
    u_xlat16_3.yz = u_xlat0.xy * vec2(0.95492965, 0.95492965) + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.yz = min(max(u_xlat16_3.yz, 0.0), 1.0);
#else
    u_xlat16_3.yz = clamp(u_xlat16_3.yz, 0.0, 1.0);
#endif
    u_xlat16_0.x = abs(u_xlat16_2.z) * -0.0187292993 + 0.0742610022;
    u_xlat16_0.x = u_xlat16_0.x * abs(u_xlat16_2.z) + -0.212114394;
    u_xlat16_0.x = u_xlat16_0.x * abs(u_xlat16_2.z) + 1.57072878;
    u_xlat16_5 = -abs(u_xlat16_2.z) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat16_2.z<(-u_xlat16_2.z));
#else
    u_xlatb10 = u_xlat16_2.z<(-u_xlat16_2.z);
#endif
    u_xlat16_5 = sqrt(u_xlat16_5);
    u_xlat16_15 = u_xlat16_5 * u_xlat16_0.x;
    u_xlat15 = u_xlat16_15 * -2.0 + 3.14159274;
    u_xlat10.x = u_xlatb10 ? u_xlat15 : float(0.0);
    u_xlat0.x = u_xlat16_0.x * u_xlat16_5 + u_xlat10.x;
    u_xlat0.x = (-u_xlat0.x) + 1.57079637;
    u_xlat16_3.x = u_xlat0.x * 0.95492965 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat16_3.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat0 = vs_TEXCOORD0.xyxy + vec4(-0.25, -0.25, -0.5, -0.5);
    u_xlat10.x = dot(u_xlat0.zw, u_xlat0.zw);
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat10.x = sqrt(u_xlat10.x);
    u_xlat16_3.xyz = (-u_xlat10.xxx) * vec3(1.01999998, 1.35000002, 1.39999998) + vec3(0.502550006, 0.503374994, 0.503499985);
    u_xlat16_17 = (-u_xlat10.x) + 0.502499998;
    u_xlat16_17 = u_xlat16_17 * 200.000198;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_17 = min(max(u_xlat16_17, 0.0), 1.0);
#else
    u_xlat16_17 = clamp(u_xlat16_17, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(196.077972, 148.148422, 142.857162);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(-2.0, -2.0, -2.0) + vec3(3.0, 3.0, 3.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_3.xyz;
    u_xlat16_8.xy = vec2(u_xlat16_3.y * u_xlat16_4.y, u_xlat16_3.z * u_xlat16_4.z);
    u_xlat16_3.x = u_xlat16_4.x * u_xlat16_3.x + (-u_xlat16_8.x);
    u_xlat16_2.xyz = u_xlat16_3.xxx * u_xlat16_2.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10.xy = u_xlat0.xy * vec2(-2.0, -2.0) + vec2(3.0, 3.0);
    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * u_xlat10.xy;
    u_xlat16_3.xyw = _Color.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xyw = u_xlat0.xxx * u_xlat16_3.xyw + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyw = u_xlat16_3.xyw * u_xlat0.yyy + (-u_xlat16_2.xyz);
    u_xlat16_0 = vs_TEXCOORD0.xyxy + vec4(-0.254999995, -0.254999995, -0.245000005, -0.245000005);
    u_xlat16_0 = ceil(u_xlat16_0);
    u_xlat16_1 = (-vs_TEXCOORD0.xyxy) + vec4(0.745000005, 0.745000005, 0.754999995, 0.754999995);
    u_xlat16_1 = ceil(u_xlat16_1);
    u_xlat16_4.xy = u_xlat16_0.xz * u_xlat16_1.xz;
    u_xlat16_4.xy = vec2(u_xlat16_0.y * u_xlat16_4.x, u_xlat16_0.w * u_xlat16_4.y);
    u_xlat16_4.x = u_xlat16_1.y * u_xlat16_4.x;
    SV_Target0.xyz = u_xlat16_4.xxx * u_xlat16_3.xyw + u_xlat16_2.xyz;
    u_xlat16_2.x = u_xlat16_17 * -2.0 + 3.0;
    u_xlat16_7 = u_xlat16_17 * u_xlat16_17;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_7 + (-u_xlat16_8.y);
    SV_Target0.w = u_xlat16_4.y * u_xlat16_1.w + u_xlat16_2.x;
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