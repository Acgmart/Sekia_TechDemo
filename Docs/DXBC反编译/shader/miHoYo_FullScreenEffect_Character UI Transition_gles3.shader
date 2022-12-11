//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/FullScreenEffect/Character UI Transition" {
Properties {
[Header(ASE Properties)] _Color ("Color", Color) = (1,0,0,0)
_BaseTexture ("BaseTexture", 2D) = "white" { }
[Header(CharacterUINoise)] _noiseTexTilling ("noiseTexTilling", Float) = 1
_noiseOffset ("noiseOffset", Range(0, 1)) = 0
_noiseTex ("noiseTex", 2D) = "white" { }
_BaseTexTilling ("BaseTexTilling", Float) = 1
_BaseTexFadeOffset ("BaseTexFadeOffset", Float) = 0
_BaseTexFadeDistance ("BaseTexFadeDistance", Float) = 0
_PropagateTexFadeOffset ("PropagateTexFadeOffset", Float) = 0
_PropagateTexFadeDistance ("PropagateTexFadeDistance", Float) = 0
_Center ("Center", Vector) = (0,0,0,0)
_Angle ("Angle", Float) = 0
_Propagate ("Propagate", Range(0, 1)) = 0
_timeExp ("timeExp", Float) = 0
_BlockRange ("BlockRange", Float) = 50
_rimWidth ("rimWidth", Float) = 0
_distFieldScale ("distFieldScale", Float) = 0
_Falloff ("Falloff", Float) = 1
_ASEHeader ("", Float) = 0
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 163
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
in highp vec3 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
vec3 u_xlat0;
void main()
{
    gl_Position.xy = in_POSITION0.xy;
    gl_Position.zw = vec2(1.0, 1.0);
    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_CameraInvProjection[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraInvProjection[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz * vec3(-1.0, 1.0, 1.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	float _Angle;
uniform 	float _Falloff;
uniform 	vec3 _Center;
uniform 	float _BaseTexTilling;
uniform 	float _BaseTexFadeOffset;
uniform 	float _BaseTexFadeDistance;
uniform 	float _BlockRange;
uniform 	float _Propagate;
uniform 	float _timeExp;
uniform 	float _rimWidth;
uniform 	float _noiseTexTilling;
uniform 	float _distFieldScale;
uniform 	float _noiseOffset;
uniform 	float _PropagateTexFadeOffset;
uniform 	float _PropagateTexFadeDistance;
uniform 	vec4 _Color;
uniform lowp sampler2D _CameraNormalsTexture;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BaseTexture;
uniform lowp sampler2D _noiseTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
ivec3 u_xlati2;
vec2 u_xlat3;
lowp vec4 u_xlat10_3;
ivec3 u_xlati3;
vec3 u_xlat4;
lowp vec4 u_xlat10_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat9;
bool u_xlatb9;
float u_xlat10;
vec2 u_xlat13;
float u_xlat14;
vec2 u_xlat17;
bool u_xlatb17;
float u_xlat21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlat0.x = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat7.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat7.xyz = u_xlat7.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat7.xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyw = u_xlat0.xyw + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    u_xlat0.xyw = u_xlat0.xyw + (-_Center.xyz);
    u_xlat1.y = u_xlat0.y;
    u_xlat2.x = sin(_Angle);
    u_xlat3.x = cos(_Angle);
    u_xlat4.z = u_xlat2.x;
    u_xlat4.y = u_xlat3.x;
    u_xlat4.x = (-u_xlat2.x);
    u_xlat1.x = dot(u_xlat4.yz, u_xlat0.xw);
    u_xlat1.z = dot(u_xlat4.xy, u_xlat0.xw);
    u_xlat0.xyw = u_xlat1.xyz * vec3(vec3(_BaseTexTilling, _BaseTexTilling, _BaseTexTilling));
    u_xlat10_1.xyz = texture(_CameraNormalsTexture, vs_TEXCOORD0.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(u_xlat4.yz, u_xlat16_5.xz);
    u_xlat1.y = dot(u_xlat4.xy, u_xlat16_5.xz);
    u_xlati2.xz = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat1.xxyx).xz) * 0xFFFFFFFFu);
    u_xlati3.xz = ivec2(uvec2(lessThan(u_xlat1.xxyx, vec4(0.0, 0.0, 0.0, 0.0)).xz) * 0xFFFFFFFFu);
    u_xlat4.xz = abs(u_xlat1.xy);
#ifdef UNITY_ADRENO_ES3
    { bool cond = 0.0<u_xlat16_5.y; u_xlati2.y = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
#else
    u_xlati2.y = int((0.0<u_xlat16_5.y) ? 0xFFFFFFFFu : uint(0u));
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = u_xlat16_5.y<0.0; u_xlati3.y = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
#else
    u_xlati3.y = int((u_xlat16_5.y<0.0) ? 0xFFFFFFFFu : uint(0u));
#endif
    u_xlat4.y = abs(u_xlat16_5.y);
    u_xlat1.xyz = max(u_xlat4.xyz, vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat1.xyz = log2(u_xlat1.xyz);
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_Falloff, _Falloff, _Falloff));
    u_xlat1.xyz = exp2(u_xlat1.xyz);
    u_xlati2.xyz = (-u_xlati2.xyz) + u_xlati3.xyz;
    u_xlat2.xyz = vec3(u_xlati2.xyz);
    u_xlat3.x = u_xlat2.y;
    u_xlat3.y = -1.0;
    u_xlat17.xy = u_xlat0.xw * u_xlat3.xy;
    u_xlat4.xy = roundEven(u_xlat17.xy);
    u_xlat3.xy = u_xlat3.xy * u_xlat0.xw + (-u_xlat4.xy);
    u_xlat22 = dot(u_xlat4.xy, u_xlat4.xy);
    u_xlat22 = sqrt(u_xlat22);
    u_xlat3.xy = -abs(u_xlat3.xy) + vec2(1.0, 1.0);
    u_xlat9.x = min(u_xlat3.y, u_xlat3.x);
    u_xlat9.x = u_xlat9.x + -0.5;
    u_xlat9.x = u_xlat9.x * 5.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat9.x = u_xlat9.x * _distFieldScale + _noiseOffset;
    u_xlat3.xy = u_xlat17.xy * vec2(vec2(_noiseTexTilling, _noiseTexTilling));
    u_xlat10_4 = texture(_BaseTexture, u_xlat17.xy);
    u_xlat3.x = texture(_noiseTex, u_xlat3.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9.x>=u_xlat3.x);
#else
    u_xlatb9 = u_xlat9.x>=u_xlat3.x;
#endif
    u_xlat9.x = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = _rimWidth * 3.0;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat10 = max(_Propagate, 9.99999975e-05);
    u_xlat10 = log2(u_xlat10);
    u_xlat10 = u_xlat10 * _timeExp;
    u_xlat10 = exp2(u_xlat10);
    u_xlat17.x = u_xlat10 * _BlockRange;
    u_xlat3.x = u_xlat3.x * u_xlat17.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat17.x = u_xlat3.x * -2.0 + 3.0;
    u_xlat3.x = u_xlat3.x * u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat17.x;
    u_xlat3.x = u_xlat3.x * _rimWidth;
    u_xlat17.x = _BlockRange * u_xlat10 + -0.5;
    u_xlat3.x = min(u_xlat17.x, u_xlat3.x);
    u_xlat17.x = (-_BlockRange) * u_xlat10 + u_xlat22;
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(u_xlat3.x>=abs(u_xlat17.x));
#else
    u_xlatb17 = u_xlat3.x>=abs(u_xlat17.x);
#endif
    u_xlat17.x = u_xlatb17 ? 1.0 : float(0.0);
    u_xlat9.x = u_xlat9.x * u_xlat17.x;
    u_xlat17.x = u_xlat1.y + u_xlat1.x;
    u_xlat17.x = u_xlat1.z + u_xlat17.x;
    u_xlat1.xyz = u_xlat1.xyz / u_xlat17.xxx;
    u_xlat9.x = u_xlat1.y * u_xlat9.x;
    u_xlat2.w = 1.0;
    u_xlat17.xy = vec2(u_xlat0.w * u_xlat2.x, u_xlat0.y * u_xlat2.w);
    u_xlat6.xyz = roundEven(u_xlat17.yxy);
    u_xlat13.xy = u_xlat2.xw * u_xlat0.wy + (-u_xlat6.yz);
    u_xlat2.xz = vec2(u_xlat2.z * float(-1.0), u_xlat2.w * float(1.0));
    u_xlat21 = max(u_xlat6.x, 0.0);
    u_xlat21 = u_xlat21 + u_xlat22;
    u_xlat21 = (-_BlockRange) * u_xlat10 + u_xlat21;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(u_xlat3.x>=abs(u_xlat21));
#else
    u_xlatb21 = u_xlat3.x>=abs(u_xlat21);
#endif
    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
    u_xlat3.xy = -abs(u_xlat13.xy) + vec2(1.0, 1.0);
    u_xlat22 = min(u_xlat3.y, u_xlat3.x);
    u_xlat22 = u_xlat22 + -0.5;
    u_xlat22 = u_xlat22 * 5.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat22 = u_xlat22 * _distFieldScale + _noiseOffset;
    u_xlat3.xy = u_xlat17.xy * vec2(vec2(_noiseTexTilling, _noiseTexTilling));
    u_xlat10_5 = texture(_BaseTexture, u_xlat17.xy);
    u_xlat23 = texture(_noiseTex, u_xlat3.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(u_xlat22>=u_xlat23);
#else
    u_xlatb22 = u_xlat22>=u_xlat23;
#endif
    u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
    u_xlat22 = u_xlat21 * u_xlat22;
    u_xlat22 = u_xlat22 * u_xlat1.x + u_xlat9.x;
    u_xlat9.xz = u_xlat0.xy * u_xlat2.xz;
    u_xlat3.xy = roundEven(u_xlat9.xz);
    u_xlat0.xy = u_xlat2.xz * u_xlat0.xy + (-u_xlat3.xy);
    u_xlat0.xy = -abs(u_xlat0.xy) + vec2(1.0, 1.0);
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = u_xlat0.x + -0.5;
    u_xlat0.x = u_xlat0.x * 5.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _distFieldScale + _noiseOffset;
    u_xlat2.xz = u_xlat9.xz * vec2(vec2(_noiseTexTilling, _noiseTexTilling));
    u_xlat10_3 = texture(_BaseTexture, u_xlat9.xz);
    u_xlat7.x = texture(_noiseTex, u_xlat2.xz).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat7.x);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat7.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat21;
    u_xlat0.x = u_xlat0.x * u_xlat1.z + u_xlat22;
    u_xlat7.x = abs(u_xlat0.z) + (-_PropagateTexFadeOffset);
    u_xlat14 = abs(u_xlat0.z) + (-_BaseTexFadeOffset);
    u_xlat21 = (-_PropagateTexFadeOffset) + _PropagateTexFadeDistance;
    u_xlat21 = float(1.0) / u_xlat21;
    u_xlat7.x = u_xlat21 * u_xlat7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat21 = u_xlat7.x * -2.0 + 3.0;
    u_xlat7.x = u_xlat7.x * u_xlat7.x;
    u_xlat7.x = u_xlat7.x * u_xlat21;
    u_xlat7.x = min(u_xlat7.x, 1.0);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat0.x = u_xlat7.x * u_xlat0.x;
    u_xlat7.x = (-_BaseTexFadeOffset) + _BaseTexFadeDistance;
    u_xlat7.x = float(1.0) / u_xlat7.x;
    u_xlat7.x = u_xlat7.x * u_xlat14;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat14 = u_xlat7.x * -2.0 + 3.0;
    u_xlat7.x = u_xlat7.x * u_xlat7.x;
    u_xlat7.x = u_xlat7.x * u_xlat14;
    u_xlat7.x = min(u_xlat7.x, 1.0);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat2 = u_xlat10_4 * u_xlat1.yyyy;
    u_xlat2 = u_xlat1.xxxx * u_xlat10_5 + u_xlat2;
    u_xlat1 = u_xlat1.zzzz * u_xlat10_3 + u_xlat2;
    u_xlat0 = u_xlat1 * u_xlat7.xxxx + u_xlat0.xxxx;
    u_xlat0 = (-u_xlat0) * _Color + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = (-u_xlat10_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = (-u_xlat16_1) * u_xlat0 + vec4(1.0, 1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MSAA_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
in highp vec3 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
vec3 u_xlat0;
void main()
{
    gl_Position.xy = in_POSITION0.xy;
    gl_Position.zw = vec2(1.0, 1.0);
    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_CameraInvProjection[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraInvProjection[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz * vec3(-1.0, 1.0, 1.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	float _Angle;
uniform 	float _Falloff;
uniform 	vec3 _Center;
uniform 	float _BaseTexTilling;
uniform 	float _BaseTexFadeOffset;
uniform 	float _BaseTexFadeDistance;
uniform 	float _BlockRange;
uniform 	float _Propagate;
uniform 	float _timeExp;
uniform 	float _rimWidth;
uniform 	float _noiseTexTilling;
uniform 	float _distFieldScale;
uniform 	float _noiseOffset;
uniform 	float _PropagateTexFadeOffset;
uniform 	float _PropagateTexFadeDistance;
uniform 	vec4 _Color;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BaseTexture;
uniform lowp sampler2D _noiseTex;
uniform lowp sampler2DMS _CameraNormalsTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
ivec3 u_xlati0;
uvec4 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
ivec3 u_xlati2;
bvec4 u_xlatb2;
vec3 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat5;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
bvec3 u_xlatb7;
vec2 u_xlat9;
float u_xlat14;
vec2 u_xlat16;
vec2 u_xlat19;
float u_xlat21;
float u_xlat23;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _ScreenParams.xy;
    u_xlat0.xy = floor(u_xlat0.xy);
    u_xlatu0.xy = uvec2(ivec2(u_xlat0.xy));
    u_xlatu0.z = uint(uint(0u));
    u_xlatu0.w = uint(uint(0u));
    u_xlat0.xyz = texelFetch(_CameraNormalsTexture, ivec2(u_xlatu0.xy), 0).xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
#ifdef UNITY_ADRENO_ES3
    { bool cond = 0.0<u_xlat16_1.y; u_xlati0.y = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
#else
    u_xlati0.y = int((0.0<u_xlat16_1.y) ? 0xFFFFFFFFu : uint(0u));
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = u_xlat16_1.y<0.0; u_xlati2.y = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
#else
    u_xlati2.y = int((u_xlat16_1.y<0.0) ? 0xFFFFFFFFu : uint(0u));
#endif
    u_xlat3.x = sin(_Angle);
    u_xlat4.x = cos(_Angle);
    u_xlat5.z = u_xlat3.x;
    u_xlat5.y = u_xlat4.x;
    u_xlat5.x = (-u_xlat3.x);
    u_xlat21 = dot(u_xlat5.yz, u_xlat16_1.xz);
#ifdef UNITY_ADRENO_ES3
    { bool cond = 0.0<u_xlat21; u_xlati0.x = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
#else
    u_xlati0.x = int((0.0<u_xlat21) ? 0xFFFFFFFFu : uint(0u));
#endif
    u_xlat23 = dot(u_xlat5.xy, u_xlat16_1.xz);
    u_xlat3.y = abs(u_xlat16_1.y);
#ifdef UNITY_ADRENO_ES3
    { bool cond = 0.0<u_xlat23; u_xlati0.z = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
#else
    u_xlati0.z = int((0.0<u_xlat23) ? 0xFFFFFFFFu : uint(0u));
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = u_xlat21<0.0; u_xlati2.x = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
#else
    u_xlati2.x = int((u_xlat21<0.0) ? 0xFFFFFFFFu : uint(0u));
#endif
    u_xlat3.x = abs(u_xlat21);
#ifdef UNITY_ADRENO_ES3
    { bool cond = u_xlat23<0.0; u_xlati2.z = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
#else
    u_xlati2.z = int((u_xlat23<0.0) ? 0xFFFFFFFFu : uint(0u));
#endif
    u_xlat3.z = abs(u_xlat23);
    u_xlat3.xyz = max(u_xlat3.xyz, vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat3.xyz = log2(u_xlat3.xyz);
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_Falloff, _Falloff, _Falloff));
    u_xlat3.xyz = exp2(u_xlat3.xyz);
    u_xlati0.xyz = (-u_xlati0.xyz) + u_xlati2.xyz;
    u_xlat0.xyz = vec3(u_xlati0.xyz);
    u_xlat2.x = u_xlat0.y;
    u_xlat7.x = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat7.x = _ZBufferParams.x * u_xlat7.x + _ZBufferParams.y;
    u_xlat7.x = float(1.0) / u_xlat7.x;
    u_xlat16.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat4.xyz = u_xlat16.xxx * vs_TEXCOORD1.xyz;
    u_xlat4.xyz = u_xlat7.xxx * u_xlat4.xyz;
    u_xlat6.xyz = u_xlat4.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat4.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat4.xxx + u_xlat6.xyz;
    u_xlat4.xyw = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * u_xlat4.zzz + u_xlat4.xyw;
    u_xlat4.xyw = u_xlat4.xyw + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    u_xlat4.xyw = u_xlat4.xyw + (-_Center.xyz);
    u_xlat6.x = dot(u_xlat5.yz, u_xlat4.xw);
    u_xlat6.z = dot(u_xlat5.xy, u_xlat4.xw);
    u_xlat6.y = u_xlat4.y;
    u_xlat4.xyw = u_xlat6.xyz * vec3(vec3(_BaseTexTilling, _BaseTexTilling, _BaseTexTilling));
    u_xlat2.y = -1.0;
    u_xlat16.xy = u_xlat2.xy * u_xlat4.xw;
    u_xlat5.xy = roundEven(u_xlat16.xy);
    u_xlat2.xy = u_xlat2.xy * u_xlat4.xw + (-u_xlat5.xy);
    u_xlat7.x = dot(u_xlat5.xy, u_xlat5.xy);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat2.xy = -abs(u_xlat2.xy) + vec2(1.0, 1.0);
    u_xlat2.x = min(u_xlat2.y, u_xlat2.x);
    u_xlat2.x = u_xlat2.x + -0.5;
    u_xlat2.x = u_xlat2.x * 5.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x * _distFieldScale + _noiseOffset;
    u_xlat5.xy = u_xlat16.xy * vec2(vec2(_noiseTexTilling, _noiseTexTilling));
    u_xlat10_1 = texture(_BaseTexture, u_xlat16.xy);
    u_xlat9.x = texture(_noiseTex, u_xlat5.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(u_xlat2.x>=u_xlat9.x);
#else
    u_xlatb2.x = u_xlat2.x>=u_xlat9.x;
#endif
    u_xlat9.x = _rimWidth * 3.0;
    u_xlat9.x = float(1.0) / u_xlat9.x;
    u_xlat16.x = max(_Propagate, 9.99999975e-05);
    u_xlat16.x = log2(u_xlat16.x);
    u_xlat16.x = u_xlat16.x * _timeExp;
    u_xlat16.x = exp2(u_xlat16.x);
    u_xlat23 = u_xlat16.x * _BlockRange;
    u_xlat9.x = u_xlat9.x * u_xlat23;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat23 = u_xlat9.x * -2.0 + 3.0;
    u_xlat9.x = u_xlat9.x * u_xlat9.x;
    u_xlat9.x = u_xlat9.x * u_xlat23;
    u_xlat9.x = u_xlat9.x * _rimWidth;
    u_xlat23 = _BlockRange * u_xlat16.x + -0.5;
    u_xlat9.x = min(u_xlat23, u_xlat9.x);
    u_xlat23 = (-_BlockRange) * u_xlat16.x + u_xlat7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.w = !!(u_xlat9.x>=abs(u_xlat23));
#else
    u_xlatb2.w = u_xlat9.x>=abs(u_xlat23);
#endif
    u_xlat2.xw = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb2.xw));
    u_xlat2.x = u_xlat2.x * u_xlat2.w;
    u_xlat23 = u_xlat3.y + u_xlat3.x;
    u_xlat23 = u_xlat3.z + u_xlat23;
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat23);
    u_xlat2.x = u_xlat2.x * u_xlat3.y;
    u_xlat0.w = 1.0;
    u_xlat5.xy = vec2(u_xlat0.x * u_xlat4.w, u_xlat0.w * u_xlat4.y);
    u_xlat6.xyz = roundEven(u_xlat5.yxy);
    u_xlat19.xy = u_xlat0.xw * u_xlat4.wy + (-u_xlat6.yz);
    u_xlat0.xz = vec2(u_xlat0.z * float(-1.0), u_xlat0.w * float(1.0));
    u_xlat21 = max(u_xlat6.x, 0.0);
    u_xlat7.x = u_xlat21 + u_xlat7.x;
    u_xlat7.x = (-_BlockRange) * u_xlat16.x + u_xlat7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7.x = !!(u_xlat9.x>=abs(u_xlat7.x));
#else
    u_xlatb7.x = u_xlat9.x>=abs(u_xlat7.x);
#endif
    u_xlat9.xy = -abs(u_xlat19.xy) + vec2(1.0, 1.0);
    u_xlat21 = min(u_xlat9.y, u_xlat9.x);
    u_xlat21 = u_xlat21 + -0.5;
    u_xlat21 = u_xlat21 * 5.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat21 = u_xlat21 * _distFieldScale + _noiseOffset;
    u_xlat9.xy = u_xlat5.xy * vec2(vec2(_noiseTexTilling, _noiseTexTilling));
    u_xlat10_5 = texture(_BaseTexture, u_xlat5.xy);
    u_xlat9.x = texture(_noiseTex, u_xlat9.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7.z = !!(u_xlat21>=u_xlat9.x);
#else
    u_xlatb7.z = u_xlat21>=u_xlat9.x;
#endif
    u_xlat7.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb7.xz));
    u_xlat21 = u_xlat7.z * u_xlat7.x;
    u_xlat21 = u_xlat21 * u_xlat3.x + u_xlat2.x;
    u_xlat2.xy = u_xlat4.xy * u_xlat0.xz;
    u_xlat16.xy = roundEven(u_xlat2.xy);
    u_xlat0.xz = u_xlat0.xz * u_xlat4.xy + (-u_xlat16.xy);
    u_xlat0.xz = -abs(u_xlat0.xz) + vec2(1.0, 1.0);
    u_xlat0.x = min(u_xlat0.z, u_xlat0.x);
    u_xlat0.x = u_xlat0.x + -0.5;
    u_xlat0.x = u_xlat0.x * 5.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _distFieldScale + _noiseOffset;
    u_xlat16.xy = u_xlat2.xy * vec2(vec2(_noiseTexTilling, _noiseTexTilling));
    u_xlat10_6 = texture(_BaseTexture, u_xlat2.xy);
    u_xlat14 = texture(_noiseTex, u_xlat16.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat14);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat14;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat7.x;
    u_xlat0.x = u_xlat0.x * u_xlat3.z + u_xlat21;
    u_xlat7.x = abs(u_xlat4.z) + (-_PropagateTexFadeOffset);
    u_xlat14 = abs(u_xlat4.z) + (-_BaseTexFadeOffset);
    u_xlat21 = (-_PropagateTexFadeOffset) + _PropagateTexFadeDistance;
    u_xlat21 = float(1.0) / u_xlat21;
    u_xlat7.x = u_xlat21 * u_xlat7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat21 = u_xlat7.x * -2.0 + 3.0;
    u_xlat7.x = u_xlat7.x * u_xlat7.x;
    u_xlat7.x = u_xlat7.x * u_xlat21;
    u_xlat7.x = min(u_xlat7.x, 1.0);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat0.x = u_xlat7.x * u_xlat0.x;
    u_xlat7.x = (-_BaseTexFadeOffset) + _BaseTexFadeDistance;
    u_xlat7.x = float(1.0) / u_xlat7.x;
    u_xlat7.x = u_xlat7.x * u_xlat14;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat14 = u_xlat7.x * -2.0 + 3.0;
    u_xlat7.x = u_xlat7.x * u_xlat7.x;
    u_xlat7.x = u_xlat7.x * u_xlat14;
    u_xlat7.x = min(u_xlat7.x, 1.0);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat1 = u_xlat10_1 * u_xlat3.yyyy;
    u_xlat1 = u_xlat3.xxxx * u_xlat10_5 + u_xlat1;
    u_xlat1 = u_xlat3.zzzz * u_xlat10_6 + u_xlat1;
    u_xlat0 = u_xlat1 * u_xlat7.xxxx + u_xlat0.xxxx;
    u_xlat0 = (-u_xlat0) * _Color + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = (-u_xlat10_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = (-u_xlat16_1) * u_xlat0 + vec4(1.0, 1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat0;
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
Keywords { "MSAA_INTERPOLATION" }
""
}
}
}
}
}