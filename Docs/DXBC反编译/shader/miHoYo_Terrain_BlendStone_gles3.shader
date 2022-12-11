//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Terrain/BlendStone" {
Properties {
_IndirectSpecular ("Indirect Specular", Range(0, 20)) = 1
[MHYToggle(_UseTintColor)] _UseTintColor ("Use Tint Color", Float) = 0
_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
_SSAO_Intensity ("SSAO Intensity", Range(0, 1)) = 0.3
_Terrain_Smoothness ("Terrain_Smoothness", Range(0, 2)) = 1
_Terrain_Specular ("Terrain_Specular", Range(0, 3)) = 1
_Shininess ("Shininess", Range(-1, 1)) = 0
[Header(Grass diffuse)] _GrassDiffuse ("Grass diffuse", 2D) = "white" { }
_GrassNormal ("Grass normal", 2D) = "bump" { }
[MHYToggle(_UseGrassSpecular)] _UseGrassSpecular ("Use Grass Normal Alpha as Specular", Float) = 0
_GrassNormalScale ("Grass normal scale", Range(0, 2)) = 1
[MHYToggle(_UseGrassHeightBlend)] _UseGrassHeightBlend ("Use Grass Height Blend", Range(0, 1)) = 0
_HeightSpread ("Grass Height Spread", Range(0, 10)) = 1
_HeightContrast ("Grass Height Contrast", Range(0, 1)) = 0
[Header(Diffuse one, normal lerp with veretx r channel)] _Diffuse1 ("Diffuse One", 2D) = "white" { }
[MHYToggle(_UseDiffuseOneHeight)] _UseDiffuseOneHeight ("Use Diffuse One Alpha as Height", Float) = 1
_Normal0 ("Normal map Zero", 2D) = "bump" { }
[MHYToggle(_UseSpecularOne)] _UseSpecularOne ("Use Normal Zero Alpha as Specular", Float) = 0
_Normal0Scale ("Normal map Zero Scale", Range(0, 2)) = 1
[Header(Diffuse two)] [Enum(UV0,0,UV1,1)] _UVDiffuse2 ("UV Set for diffuse2", Float) = 0
_Diffuse2 ("Diffuse Two", 2D) = "gray" { }
[MHYToggle(_UseDiffuseTwoHeight)] _UseDiffuseTwoHeight ("Use Diffuse Two Alpha as Height", Float) = 1
_Normal2 ("Normal map Two", 2D) = "bump" { }
[MHYToggle(_UseSpecularTwo)] _UseSpecularTwo ("Use Normal Two Alpha as Specular", Float) = 0
_Normal2Scale ("Normal map Two scale", Range(0, 2)) = 1
_Diffuse2Distance ("Diffuse Two Distance ", Range(0, 500)) = 80
_Diffuse2Fade ("Diffuse Two Fade", Range(0, 10)) = 3
[Header(Detail Diffuse)] [Enum(UV0,0,UV1,1)] _UVDetail ("UV Set for Detail", Float) = 0
_DetailDiffuse ("Diffuse Detail", 2D) = "gray" { }
[MHYToggle(_UseDetailDiffuseHeight)] _UseDetailDiffuseHeight ("Use Detail Diffuse Alpha as Height", Float) = 1
_DetailNormal ("Detail Normal map", 2D) = "bump" { }
[MHYToggle(_UseDetailSpecular)] _UseDetailSpecular ("Use Detail Normal Alpha as Specular", Float) = 0
_DetailNormalScale ("Detail Normal map scale", Float) = 1
_DetailNormalUVScale ("Detail Normal map uv scale", Float) = 1
_DetailBlendVal ("Detail Blend val", Range(0, 2)) = 1
_DetailDistance ("Detail Distance ", Range(0, 100)) = 30
_DetailFade ("Detail Fade", Range(0, 10)) = 2
[Header(Depth Blend)] _DepthBiasScaled ("Depth bias scaled", Range(0, 16)) = 0.6
_DepthBlendAO ("Depth blend AO factor", Range(0, 1)) = 1
[Header(Element View)] _ElementViewEleID ("Element ID", Float) = 0
}
SubShader {
 Tags { "QUEUE" = "Geometry-100" "RenderType" = "Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry-100" "RenderType" = "Opaque" }
  GpuProgramID 64225
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _Diffuse1_ST;
uniform 	float _UVDiffuse2;
uniform 	vec4 _Diffuse2_ST;
uniform 	float _UVDetail;
uniform 	vec4 _DetailDiffuse_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec2 u_xlat12;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat15 = u_xlat15 + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat15 = u_xlat15 + u_xlat2.x;
    u_xlat15 = u_xlat15 * 0.330000013;
    u_xlat2.xy = vec2(u_xlat15) * in_TEXCOORD0.xy;
    u_xlat12.xy = vec2(u_xlat15) * in_TEXCOORD1.xy;
    vs_TEXCOORD0.xy = u_xlat2.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Diffuse1_ST.xy + _Diffuse1_ST.zw;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat15 * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UVDiffuse2==0.0);
#else
    u_xlatb15 = _UVDiffuse2==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat2.xy : u_xlat12.xy;
    vs_TEXCOORD2.xy = u_xlat1.xy * _Diffuse2_ST.xy + _Diffuse2_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UVDetail==0.0);
#else
    u_xlatb15 = _UVDetail==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat2.xy : u_xlat12.xy;
    vs_TEXCOORD2.zw = u_xlat1.xy * _DetailDiffuse_ST.xy + _DetailDiffuse_ST.zw;
    vs_TEXCOORD3.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz;
    vs_TEXCOORD3.y = u_xlat16_4.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat0.y;
    vs_TEXCOORD5.w = u_xlat0.z;
    vs_TEXCOORD4.y = u_xlat16_4.y;
    vs_TEXCOORD5.y = u_xlat16_4.z;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _HeightSpread;
uniform 	mediump float _HeightContrast;
uniform 	mediump float _UseTintColor;
uniform 	mediump float _UseDiffuseOneHeight;
uniform 	mediump float _UseDiffuseTwoHeight;
uniform 	mediump float _UseDetailDiffuseHeight;
uniform 	mediump float _UseGrassHeightBlend;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _Diffuse2Distance;
uniform 	mediump float _Diffuse2Fade;
uniform 	mediump float _DetailNormalUVScale;
uniform 	mediump float _DetailBlendVal;
uniform 	mediump float _DetailDistance;
uniform 	mediump float _DetailFade;
uniform lowp sampler2D _GrassNormal;
uniform lowp sampler2D _GrassDiffuse;
uniform lowp sampler2D _Normal0;
uniform lowp sampler2D _Normal2;
uniform lowp sampler2D _Diffuse1;
uniform lowp sampler2D _DetailNormal;
uniform lowp sampler2D _Diffuse2;
uniform lowp sampler2D _DetailDiffuse;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_6;
lowp vec4 u_xlat10_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
mediump float u_xlat16_11;
vec2 u_xlat22;
mediump float u_xlat16_22;
lowp vec2 u_xlat10_22;
mediump vec2 u_xlat16_26;
mediump float u_xlat16_27;
float u_xlat33;
mediump float u_xlat16_34;
mediump float u_xlat16_35;
mediump float u_xlat16_38;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_COLOR0.w<0.99000001);
#else
    u_xlatb0 = vs_COLOR0.w<0.99000001;
#endif
    if(u_xlatb0){
        u_xlat10_0.xyz = texture(_GrassNormal, vs_TEXCOORD0.xy).xyz;
        u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat10_0.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.xy).xyz;
        u_xlat16_2.xyz = u_xlat10_0.xyz;
    } else {
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
        u_xlat16_1.x = float(0.0);
        u_xlat16_1.y = float(0.0);
        u_xlat16_1.z = float(1.0);
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.00999999978<vs_COLOR0.w);
#else
    u_xlatb0 = 0.00999999978<vs_COLOR0.w;
#endif
    if(u_xlatb0){
        u_xlat0.x = vs_TEXCOORD3.w;
        u_xlat0.y = vs_TEXCOORD4.w;
        u_xlat0.z = vs_TEXCOORD5.w;
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat11 = u_xlat0.x / _Diffuse2Distance;
#ifdef UNITY_ADRENO_ES3
        u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
        u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
        u_xlat11 = u_xlat11 + 9.99999975e-05;
        u_xlat11 = log2(u_xlat11);
        u_xlat11 = u_xlat11 * _Diffuse2Fade;
        u_xlat0.y = exp2(u_xlat11);
        u_xlat0.x = u_xlat0.x / _DetailDistance;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = u_xlat0.x + 9.99999975e-05;
        u_xlat0.x = log2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * _DetailFade;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat0.xy = min(u_xlat0.xy, vec2(1.0, 1.0));
        u_xlat10_22.xy = texture(_Normal0, vs_TEXCOORD0.zw).xy;
        u_xlat10_3.xy = texture(_Normal2, vs_TEXCOORD2.xy).xy;
        u_xlat16_4.xy = u_xlat10_22.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_26.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_34 = (-u_xlat0.y) + 1.0;
        u_xlat16_26.xy = vec2(u_xlat16_34) * u_xlat16_26.xy;
        u_xlat10_3 = texture(_Diffuse1, vs_TEXCOORD0.zw);
        u_xlat22.xy = vec2(vs_TEXCOORD2.z * float(_DetailNormalUVScale), vs_TEXCOORD2.w * float(_DetailNormalUVScale));
        u_xlat10_22.xy = texture(_DetailNormal, u_xlat22.xy).xy;
        u_xlat16_5.xy = u_xlat10_22.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_34 = (-u_xlat0.x) + 1.0;
        u_xlat16_5.xy = vec2(u_xlat16_34) * u_xlat16_5.xy;
        u_xlat10_6 = texture(_Diffuse2, vs_TEXCOORD2.xy);
        u_xlat10_7 = texture(_DetailDiffuse, vs_TEXCOORD2.zw);
        u_xlat16_34 = u_xlat10_6.w * _UseDiffuseTwoHeight;
        u_xlat16_35 = u_xlat10_7.w * _UseDetailDiffuseHeight;
        u_xlat16_8.xyz = u_xlat10_3.xyz + (-u_xlat10_6.xyz);
        u_xlat16_27 = u_xlat10_3.w * _UseDiffuseOneHeight + (-u_xlat16_34);
        u_xlat16_8.xyz = u_xlat0.yyy * u_xlat16_8.xyz + u_xlat10_6.xyz;
        u_xlat16_34 = u_xlat0.y * u_xlat16_27 + u_xlat16_34;
        u_xlat16_27 = u_xlat0.x * _DetailBlendVal;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
        u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
        u_xlat16_38 = (-u_xlat16_27) + 1.0;
        u_xlat16_35 = u_xlat16_35 * u_xlat16_38;
        u_xlat16_34 = max(u_xlat16_34, u_xlat16_35);
        u_xlat16_9.xyz = u_xlat10_7.xyz * u_xlat16_8.xyz;
        u_xlat16_10.xyz = u_xlat16_9.xyz * vec3(4.0, 4.0, 4.0);
        u_xlat16_8.xyz = (-u_xlat16_9.xyz) * vec3(4.0, 4.0, 4.0) + u_xlat16_8.xyz;
        u_xlat16_8.xyz = vec3(u_xlat16_27) * u_xlat16_8.xyz + u_xlat16_10.xyz;
        u_xlat16_8.xyz = min(u_xlat16_8.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_4.xy = u_xlat16_26.xy * vs_COLOR0.xx + u_xlat16_4.xy;
        u_xlat16_4.xy = u_xlat16_5.xy * vs_COLOR0.xx + u_xlat16_4.xy;
    } else {
        u_xlat16_8.x = float(0.0);
        u_xlat16_8.y = float(0.0);
        u_xlat16_8.z = float(0.0);
        u_xlat16_4.x = float(0.0);
        u_xlat16_4.y = float(0.0);
        u_xlat16_34 = 1.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor);
#endif
    u_xlat16_5.xyz = u_xlat16_8.xyz * _TintColor.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb0)) ? u_xlat16_5.xyz : u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend);
#endif
    u_xlat16_11 = u_xlat16_34;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
#else
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#endif
    u_xlat16_22 = vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat16_34 = _HeightContrast * 10.0;
    u_xlat16_11 = u_xlat16_11 + -1.0;
    u_xlat16_35 = _HeightSpread + 0.100000001;
    u_xlat16_22 = log2(u_xlat16_22);
    u_xlat16_22 = u_xlat16_22 * u_xlat16_35;
    u_xlat16_22 = exp2(u_xlat16_22);
    u_xlat16_11 = u_xlat16_22 * 2.0 + u_xlat16_11;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
#else
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#endif
    u_xlat16_22 = _HeightContrast * 10.0 + 1.0;
    u_xlat16_22 = _HeightContrast * 10.0 + u_xlat16_22;
    u_xlat11 = u_xlat16_11 * u_xlat16_22 + (-u_xlat16_34);
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_34 = (u_xlatb0) ? u_xlat11 : vs_COLOR0.w;
    u_xlat16_4.z = 1.0;
    u_xlat16_4.xyz = (-u_xlat16_1.xyz) + u_xlat16_4.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_34) * u_xlat16_4.xyz + u_xlat16_1.xyz;
    u_xlat16_4.xyz = (-u_xlat16_2.xyz) + u_xlat16_5.xyz;
    u_xlat16_2.xyz = vec3(u_xlat16_34) * u_xlat16_4.xyz + u_xlat16_2.xyz;
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD5.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat0.xyz * u_xlat16_1.xxx;
    u_xlat0.x = vs_TEXCOORD3.w;
    u_xlat0.y = vs_TEXCOORD4.w;
    u_xlat0.z = vs_TEXCOORD5.w;
    u_xlat0.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat16_1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _Diffuse1_ST;
uniform 	float _UVDiffuse2;
uniform 	vec4 _Diffuse2_ST;
uniform 	float _UVDetail;
uniform 	vec4 _DetailDiffuse_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat7;
float u_xlat16;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x;
    u_xlat2.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].x;
    u_xlat2.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].x;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].y;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].y;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].y;
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.xy = sqrt(u_xlat2.xy);
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].z;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].z;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].z;
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat2.x = u_xlat7.x + u_xlat2.x;
    u_xlat2.x = u_xlat2.x * 0.330000013;
    u_xlat7.xy = u_xlat2.xx * in_TEXCOORD0.xy;
    u_xlat2.xw = u_xlat2.xx * in_TEXCOORD1.xy;
    vs_TEXCOORD0.xy = u_xlat7.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Diffuse1_ST.xy + _Diffuse1_ST.zw;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UVDiffuse2==0.0);
#else
    u_xlatb1 = _UVDiffuse2==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb1)) ? u_xlat7.xy : u_xlat2.xw;
    vs_TEXCOORD2.xy = u_xlat1.xy * _Diffuse2_ST.xy + _Diffuse2_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UVDetail==0.0);
#else
    u_xlatb1 = _UVDetail==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb1)) ? u_xlat7.xy : u_xlat2.xw;
    vs_TEXCOORD2.zw = u_xlat1.xy * _DetailDiffuse_ST.xy + _DetailDiffuse_ST.zw;
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat2.xyz = vec3(u_xlat0) * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_4.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = vec3(u_xlat0) * u_xlat16_4.xyz;
    vs_TEXCOORD3.y = u_xlat16_4.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD3.w = u_xlat5.x;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat5.y;
    vs_TEXCOORD5.w = u_xlat5.z;
    vs_TEXCOORD4.y = u_xlat16_4.y;
    vs_TEXCOORD5.y = u_xlat16_4.z;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _HeightSpread;
uniform 	mediump float _HeightContrast;
uniform 	mediump float _UseTintColor;
uniform 	mediump float _UseDiffuseOneHeight;
uniform 	mediump float _UseDiffuseTwoHeight;
uniform 	mediump float _UseDetailDiffuseHeight;
uniform 	mediump float _UseGrassHeightBlend;
uniform 	mediump vec4 _TintColor;
uniform 	float _GrassNormalScale;
uniform 	float _Normal0Scale;
uniform 	mediump float _Normal2Scale;
uniform 	mediump float _Diffuse2Distance;
uniform 	mediump float _Diffuse2Fade;
uniform 	mediump float _DetailNormalScale;
uniform 	mediump float _DetailNormalUVScale;
uniform 	mediump float _DetailBlendVal;
uniform 	mediump float _DetailDistance;
uniform 	mediump float _DetailFade;
uniform lowp sampler2D _GrassNormal;
uniform lowp sampler2D _GrassDiffuse;
uniform lowp sampler2D _Normal0;
uniform lowp sampler2D _Normal2;
uniform lowp sampler2D _Diffuse1;
uniform lowp sampler2D _DetailNormal;
uniform lowp sampler2D _Diffuse2;
uniform lowp sampler2D _DetailDiffuse;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_6;
lowp vec4 u_xlat10_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
mediump float u_xlat16_11;
vec2 u_xlat22;
mediump float u_xlat16_22;
lowp vec2 u_xlat10_22;
mediump vec2 u_xlat16_26;
mediump float u_xlat16_27;
float u_xlat33;
mediump float u_xlat16_34;
mediump float u_xlat16_35;
mediump float u_xlat16_38;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_COLOR0.w<0.99000001);
#else
    u_xlatb0 = vs_COLOR0.w<0.99000001;
#endif
    if(u_xlatb0){
        u_xlat10_0.xyz = texture(_GrassNormal, vs_TEXCOORD0.xy).xyz;
        u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_1.xy = u_xlat16_1.xy * vec2(_GrassNormalScale);
        u_xlat10_0.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.xy).xyz;
        u_xlat16_2.xyz = u_xlat10_0.xyz;
    } else {
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
        u_xlat16_1.x = float(0.0);
        u_xlat16_1.y = float(0.0);
        u_xlat16_1.z = float(1.0);
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.00999999978<vs_COLOR0.w);
#else
    u_xlatb0 = 0.00999999978<vs_COLOR0.w;
#endif
    if(u_xlatb0){
        u_xlat0.x = vs_TEXCOORD3.w;
        u_xlat0.y = vs_TEXCOORD4.w;
        u_xlat0.z = vs_TEXCOORD5.w;
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat11 = u_xlat0.x / _Diffuse2Distance;
#ifdef UNITY_ADRENO_ES3
        u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
        u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
        u_xlat11 = u_xlat11 + 9.99999975e-05;
        u_xlat11 = log2(u_xlat11);
        u_xlat11 = u_xlat11 * _Diffuse2Fade;
        u_xlat0.y = exp2(u_xlat11);
        u_xlat0.x = u_xlat0.x / _DetailDistance;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = u_xlat0.x + 9.99999975e-05;
        u_xlat0.x = log2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * _DetailFade;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat0.xy = min(u_xlat0.xy, vec2(1.0, 1.0));
        u_xlat10_22.xy = texture(_Normal0, vs_TEXCOORD0.zw).xy;
        u_xlat10_3.xy = texture(_Normal2, vs_TEXCOORD2.xy).xy;
        u_xlat16_4.xy = u_xlat10_22.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_26.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_26.xy = u_xlat16_26.xy * vec2(_Normal2Scale);
        u_xlat16_34 = (-u_xlat0.y) + 1.0;
        u_xlat16_26.xy = vec2(u_xlat16_34) * u_xlat16_26.xy;
        u_xlat16_26.xy = u_xlat16_26.xy * vs_COLOR0.xx;
        u_xlat10_3 = texture(_Diffuse1, vs_TEXCOORD0.zw);
        u_xlat22.xy = vec2(vs_TEXCOORD2.z * float(_DetailNormalUVScale), vs_TEXCOORD2.w * float(_DetailNormalUVScale));
        u_xlat10_22.xy = texture(_DetailNormal, u_xlat22.xy).xy;
        u_xlat16_5.xy = u_xlat10_22.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_5.xy = u_xlat16_5.xy * vec2(_DetailNormalScale);
        u_xlat16_34 = (-u_xlat0.x) + 1.0;
        u_xlat16_5.xy = vec2(u_xlat16_34) * u_xlat16_5.xy;
        u_xlat10_6 = texture(_Diffuse2, vs_TEXCOORD2.xy);
        u_xlat10_7 = texture(_DetailDiffuse, vs_TEXCOORD2.zw);
        u_xlat16_34 = u_xlat10_6.w * _UseDiffuseTwoHeight;
        u_xlat16_35 = u_xlat10_7.w * _UseDetailDiffuseHeight;
        u_xlat16_8.xyz = u_xlat10_3.xyz + (-u_xlat10_6.xyz);
        u_xlat16_27 = u_xlat10_3.w * _UseDiffuseOneHeight + (-u_xlat16_34);
        u_xlat16_8.xyz = u_xlat0.yyy * u_xlat16_8.xyz + u_xlat10_6.xyz;
        u_xlat16_34 = u_xlat0.y * u_xlat16_27 + u_xlat16_34;
        u_xlat16_27 = u_xlat0.x * _DetailBlendVal;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
        u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
        u_xlat16_38 = (-u_xlat16_27) + 1.0;
        u_xlat16_35 = u_xlat16_35 * u_xlat16_38;
        u_xlat16_34 = max(u_xlat16_34, u_xlat16_35);
        u_xlat16_9.xyz = u_xlat10_7.xyz * u_xlat16_8.xyz;
        u_xlat16_10.xyz = u_xlat16_9.xyz * vec3(4.0, 4.0, 4.0);
        u_xlat16_8.xyz = (-u_xlat16_9.xyz) * vec3(4.0, 4.0, 4.0) + u_xlat16_8.xyz;
        u_xlat16_8.xyz = vec3(u_xlat16_27) * u_xlat16_8.xyz + u_xlat16_10.xyz;
        u_xlat16_8.xyz = min(u_xlat16_8.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_4.xy = u_xlat16_4.xy * vec2(_Normal0Scale) + u_xlat16_26.xy;
        u_xlat16_4.xy = u_xlat16_5.xy * vs_COLOR0.xx + u_xlat16_4.xy;
    } else {
        u_xlat16_8.x = float(0.0);
        u_xlat16_8.y = float(0.0);
        u_xlat16_8.z = float(0.0);
        u_xlat16_4.x = float(0.0);
        u_xlat16_4.y = float(0.0);
        u_xlat16_34 = 1.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor);
#endif
    u_xlat16_5.xyz = u_xlat16_8.xyz * _TintColor.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb0)) ? u_xlat16_5.xyz : u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend);
#endif
    u_xlat16_11 = u_xlat16_34;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
#else
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#endif
    u_xlat16_22 = vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat16_34 = _HeightContrast * 10.0;
    u_xlat16_11 = u_xlat16_11 + -1.0;
    u_xlat16_35 = _HeightSpread + 0.100000001;
    u_xlat16_22 = log2(u_xlat16_22);
    u_xlat16_22 = u_xlat16_22 * u_xlat16_35;
    u_xlat16_22 = exp2(u_xlat16_22);
    u_xlat16_11 = u_xlat16_22 * 2.0 + u_xlat16_11;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
#else
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#endif
    u_xlat16_22 = _HeightContrast * 10.0 + 1.0;
    u_xlat16_22 = _HeightContrast * 10.0 + u_xlat16_22;
    u_xlat11 = u_xlat16_11 * u_xlat16_22 + (-u_xlat16_34);
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_34 = (u_xlatb0) ? u_xlat11 : vs_COLOR0.w;
    u_xlat16_4.z = 1.0;
    u_xlat16_4.xyz = (-u_xlat16_1.xyz) + u_xlat16_4.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_34) * u_xlat16_4.xyz + u_xlat16_1.xyz;
    u_xlat16_4.xyz = (-u_xlat16_2.xyz) + u_xlat16_5.xyz;
    u_xlat16_2.xyz = vec3(u_xlat16_34) * u_xlat16_4.xyz + u_xlat16_2.xyz;
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD5.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat0.xyz * u_xlat16_1.xxx;
    u_xlat0.x = vs_TEXCOORD3.w;
    u_xlat0.y = vs_TEXCOORD4.w;
    u_xlat0.z = vs_TEXCOORD5.w;
    u_xlat0.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat16_1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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
Keywords { "INSTANCING_ON" }
""
}
}
}
 Pass {
  Name "DEPTHONLY"
  Tags { "LIGHTMODE" = "DepthOnly" "QUEUE" = "Geometry-100" "RenderType" = "Opaque" }
  GpuProgramID 81128
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
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
    vs_TEXCOORD0.xy = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
layout(location = 0) out mediump vec4 SV_TARGET0;
void main()
{
    SV_TARGET0 = vec4(0.0, 0.0, 0.0, 0.0);
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
out highp vec2 vs_TEXCOORD0;
flat out highp uint vs_SV_InstanceID0;
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
    vs_TEXCOORD0.xy = vec2(0.0, 0.0);
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
layout(location = 0) out mediump vec4 SV_TARGET0;
void main()
{
    SV_TARGET0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MSAA_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
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
    vs_TEXCOORD0.xy = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
layout(location = 0) out mediump vec4 SV_TARGET0;
void main()
{
    SV_TARGET0 = vec4(0.0, 0.0, 0.0, 0.0);
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
out highp vec2 vs_TEXCOORD0;
flat out highp uint vs_SV_InstanceID0;
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
    vs_TEXCOORD0.xy = vec2(0.0, 0.0);
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
layout(location = 0) out mediump vec4 SV_TARGET0;
void main()
{
    SV_TARGET0 = vec4(0.0, 0.0, 0.0, 0.0);
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
}
}
 Pass {
  Name "HYBRIDDEFERRED"
  Tags { "DebugView" = "On" "LIGHTMODE" = "HYBRIDDEFERRED" "QUEUE" = "Geometry-100" "RenderType" = "Opaque" }
  GpuProgramID 194121
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _Diffuse1_ST;
uniform 	float _UVDiffuse2;
uniform 	vec4 _Diffuse2_ST;
uniform 	float _UVDetail;
uniform 	vec4 _DetailDiffuse_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec2 u_xlat12;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat15 = u_xlat15 + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat15 = u_xlat15 + u_xlat2.x;
    u_xlat15 = u_xlat15 * 0.330000013;
    u_xlat2.xy = vec2(u_xlat15) * in_TEXCOORD0.xy;
    u_xlat12.xy = vec2(u_xlat15) * in_TEXCOORD1.xy;
    vs_TEXCOORD0.xy = u_xlat2.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Diffuse1_ST.xy + _Diffuse1_ST.zw;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat15 * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UVDiffuse2==0.0);
#else
    u_xlatb15 = _UVDiffuse2==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat2.xy : u_xlat12.xy;
    vs_TEXCOORD2.xy = u_xlat1.xy * _Diffuse2_ST.xy + _Diffuse2_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UVDetail==0.0);
#else
    u_xlatb15 = _UVDetail==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat2.xy : u_xlat12.xy;
    vs_TEXCOORD2.zw = u_xlat1.xy * _DetailDiffuse_ST.xy + _DetailDiffuse_ST.zw;
    vs_TEXCOORD3.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz;
    vs_TEXCOORD3.y = u_xlat16_4.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat0.y;
    vs_TEXCOORD5.w = u_xlat0.z;
    vs_TEXCOORD4.y = u_xlat16_4.y;
    vs_TEXCOORD5.y = u_xlat16_4.z;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump float _HeightSpread;
uniform 	mediump float _HeightContrast;
uniform 	mediump float _UseTintColor;
uniform 	mediump float _UseDiffuseOneHeight;
uniform 	mediump float _UseDiffuseTwoHeight;
uniform 	mediump float _UseDetailDiffuseHeight;
uniform 	mediump float _UseGrassHeightBlend;
uniform 	mediump float _UseGrassSpecular;
uniform 	mediump float _UseSpecularOne;
uniform 	mediump float _UseSpecularTwo;
uniform 	mediump float _UseDetailSpecular;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _SSAO_Intensity;
uniform 	mediump float _Terrain_Smoothness;
uniform 	mediump float _Terrain_Specular;
uniform 	mediump float _Shininess;
uniform 	mediump float _Diffuse2Distance;
uniform 	mediump float _Diffuse2Fade;
uniform 	mediump float _DetailNormalUVScale;
uniform 	mediump float _DetailBlendVal;
uniform 	mediump float _DetailDistance;
uniform 	mediump float _DetailFade;
uniform 	mediump float _DepthBiasScaled;
uniform 	mediump float _DepthBlendAO;
uniform lowp sampler2D _GrassNormal;
uniform lowp sampler2D _GrassDiffuse;
uniform lowp sampler2D _Normal0;
uniform lowp sampler2D _Normal2;
uniform lowp sampler2D _Diffuse1;
uniform lowp sampler2D _DetailNormal;
uniform lowp sampler2D _Diffuse2;
uniform lowp sampler2D _DetailDiffuse;
uniform highp sampler2D _CameraDepthBlendTexture;
uniform lowp sampler2D _CameraDepthBlendNormTexture;
uniform lowp sampler2D _CameraDepthBlendDiffTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_6;
mediump vec4 u_xlat16_7;
lowp vec4 u_xlat10_8;
lowp vec4 u_xlat10_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
mediump vec3 u_xlat16_12;
float u_xlat13;
mediump float u_xlat16_13;
vec2 u_xlat26;
mediump float u_xlat16_26;
mediump vec2 u_xlat16_31;
mediump float u_xlat16_33;
float u_xlat39;
bool u_xlatb39;
mediump float u_xlat16_40;
mediump float u_xlat16_41;
float u_xlat42;
mediump float u_xlat16_44;
mediump float u_xlat16_46;
mediump float u_xlat16_49;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_COLOR0.w<0.99000001);
#else
    u_xlatb0 = vs_COLOR0.w<0.99000001;
#endif
    if(u_xlatb0){
        u_xlat10_0 = texture(_GrassNormal, vs_TEXCOORD0.xy);
        u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_40 = u_xlat10_0.w * _UseGrassSpecular;
        u_xlat10_0.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.xy).xyz;
        u_xlat16_2.xyz = u_xlat10_0.xyz;
    } else {
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
        u_xlat16_1.x = float(0.0);
        u_xlat16_1.y = float(0.0);
        u_xlat16_1.z = float(1.0);
        u_xlat16_40 = float(0.0);
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.00999999978<vs_COLOR0.w);
#else
    u_xlatb0 = 0.00999999978<vs_COLOR0.w;
#endif
    if(u_xlatb0){
        u_xlat0.x = vs_TEXCOORD3.w;
        u_xlat0.y = vs_TEXCOORD4.w;
        u_xlat0.z = vs_TEXCOORD5.w;
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat13 = u_xlat0.x / _Diffuse2Distance;
#ifdef UNITY_ADRENO_ES3
        u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
        u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
        u_xlat13 = u_xlat13 + 9.99999975e-05;
        u_xlat13 = log2(u_xlat13);
        u_xlat13 = u_xlat13 * _Diffuse2Fade;
        u_xlat0.y = exp2(u_xlat13);
        u_xlat0.x = u_xlat0.x / _DetailDistance;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = u_xlat0.x + 9.99999975e-05;
        u_xlat0.x = log2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * _DetailFade;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat0.xy = min(u_xlat0.xy, vec2(1.0, 1.0));
        u_xlat10_3.xyz = texture(_Normal0, vs_TEXCOORD0.zw).xyw;
        u_xlat10_4.xyz = texture(_Normal2, vs_TEXCOORD2.xy).xyw;
        u_xlat16_5.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_31.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_41 = (-u_xlat0.y) + 1.0;
        u_xlat16_31.xy = vec2(u_xlat16_41) * u_xlat16_31.xy;
        u_xlat10_6 = texture(_Diffuse1, vs_TEXCOORD0.zw);
        u_xlat26.xy = vec2(vs_TEXCOORD2.z * float(_DetailNormalUVScale), vs_TEXCOORD2.w * float(_DetailNormalUVScale));
        u_xlat10_3.xyw = texture(_DetailNormal, u_xlat26.xy).xyw;
        u_xlat16_7.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_41 = (-u_xlat0.x) + 1.0;
        u_xlat16_7.xy = vec2(u_xlat16_41) * u_xlat16_7.xy;
        u_xlat10_8 = texture(_Diffuse2, vs_TEXCOORD2.xy);
        u_xlat10_9 = texture(_DetailDiffuse, vs_TEXCOORD2.zw);
        u_xlat16_41 = u_xlat10_8.w * _UseDiffuseTwoHeight;
        u_xlat16_33 = u_xlat10_9.w * _UseDetailDiffuseHeight;
        u_xlat16_10.xyz = u_xlat10_6.xyz + (-u_xlat10_8.xyz);
        u_xlat16_46 = u_xlat10_6.w * _UseDiffuseOneHeight + (-u_xlat16_41);
        u_xlat16_10.xyz = u_xlat0.yyy * u_xlat16_10.xyz + u_xlat10_8.xyz;
        u_xlat16_41 = u_xlat0.y * u_xlat16_46 + u_xlat16_41;
        u_xlat16_46 = u_xlat0.x * _DetailBlendVal;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_46 = min(max(u_xlat16_46, 0.0), 1.0);
#else
        u_xlat16_46 = clamp(u_xlat16_46, 0.0, 1.0);
#endif
        u_xlat16_49 = (-u_xlat16_46) + 1.0;
        u_xlat16_33 = u_xlat16_33 * u_xlat16_49;
        u_xlat16_41 = max(u_xlat16_41, u_xlat16_33);
        u_xlat16_11.xyz = u_xlat10_9.xyz * u_xlat16_10.xyz;
        u_xlat16_12.xyz = u_xlat16_11.xyz * vec3(4.0, 4.0, 4.0);
        u_xlat16_10.xyz = (-u_xlat16_11.xyz) * vec3(4.0, 4.0, 4.0) + u_xlat16_10.xyz;
        u_xlat16_10.xyz = vec3(u_xlat16_46) * u_xlat16_10.xyz + u_xlat16_12.xyz;
        u_xlat16_10.xyz = min(u_xlat16_10.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_33 = u_xlat10_4.z * _UseSpecularTwo;
        u_xlat16_46 = u_xlat10_3.w * _UseDetailSpecular;
        u_xlat16_11.x = _UseSpecularOne * u_xlat10_3.z + (-u_xlat16_33);
        u_xlat16_33 = u_xlat0.y * u_xlat16_11.x + u_xlat16_33;
        u_xlat16_46 = u_xlat16_49 * u_xlat16_46;
        u_xlat16_33 = max(u_xlat16_46, u_xlat16_33);
        u_xlat16_5.xy = u_xlat16_31.xy * vs_COLOR0.xx + u_xlat16_5.xy;
        u_xlat16_5.xy = u_xlat16_7.xy * vs_COLOR0.xx + u_xlat16_5.xy;
    } else {
        u_xlat16_10.x = float(0.0);
        u_xlat16_10.y = float(0.0);
        u_xlat16_10.z = float(0.0);
        u_xlat16_5.x = float(0.0);
        u_xlat16_5.y = float(0.0);
        u_xlat16_41 = 1.0;
        u_xlat16_33 = 0.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor);
#endif
    u_xlat16_7.xyw = u_xlat16_10.xyz * _TintColor.xyz;
    u_xlat16_7.xyw = (bool(u_xlatb0)) ? u_xlat16_7.xyw : u_xlat16_10.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend);
#endif
    u_xlat16_13 = u_xlat16_41;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_26 = vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_41 = _HeightContrast * 10.0;
    u_xlat16_13 = u_xlat16_13 + -1.0;
    u_xlat16_44 = _HeightSpread + 0.100000001;
    u_xlat16_26 = log2(u_xlat16_26);
    u_xlat16_26 = u_xlat16_26 * u_xlat16_44;
    u_xlat16_26 = exp2(u_xlat16_26);
    u_xlat16_13 = u_xlat16_26 * 2.0 + u_xlat16_13;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_26 = _HeightContrast * 10.0 + 1.0;
    u_xlat16_26 = _HeightContrast * 10.0 + u_xlat16_26;
    u_xlat13 = u_xlat16_13 * u_xlat16_26 + (-u_xlat16_41);
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat16_41 = (u_xlatb0) ? u_xlat13 : vs_COLOR0.w;
    u_xlat16_5.z = 1.0;
    u_xlat16_5.xyz = (-u_xlat16_1.xyz) + u_xlat16_5.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_41) * u_xlat16_5.xyz + u_xlat16_1.xyz;
    u_xlat16_5.x = (-u_xlat16_40) + u_xlat16_33;
    u_xlat16_40 = u_xlat16_41 * u_xlat16_5.x + u_xlat16_40;
    u_xlat16_5.xyz = (-u_xlat16_2.xyz) + u_xlat16_7.xyw;
    u_xlat16_2.xyz = vec3(u_xlat16_41) * u_xlat16_5.xyz + u_xlat16_2.xyz;
    u_xlat16_40 = u_xlat16_40 + _Shininess;
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD5.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!(vs_TEXCOORD1.w<100.0);
#else
    u_xlatb39 = vs_TEXCOORD1.w<100.0;
#endif
    if(u_xlatb39){
        u_xlat3.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
        u_xlat39 = texture(_CameraDepthBlendTexture, u_xlat3.xy).x;
        u_xlat39 = _ZBufferParams.z * u_xlat39 + _ZBufferParams.w;
        u_xlat39 = float(1.0) / u_xlat39;
        u_xlat39 = u_xlat39 + (-vs_TEXCOORD1.w);
        u_xlat39 = abs(u_xlat39) * _DepthBiasScaled;
        u_xlat39 = u_xlat39 * 0.600000024;
#ifdef UNITY_ADRENO_ES3
        u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
        u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
        u_xlat39 = sqrt(u_xlat39);
        u_xlat10_4.xyz = texture(_CameraDepthBlendNormTexture, u_xlat3.xy).xyz;
        u_xlat16_1.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat10_3.xyz = texture(_CameraDepthBlendDiffTexture, u_xlat3.xy).xyz;
        u_xlat16_41 = u_xlat0.y * _DepthBlendAO;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
        u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
        u_xlat42 = (-u_xlat39) + 1.0;
        u_xlat42 = u_xlat16_41 * u_xlat42 + u_xlat39;
        u_xlat42 = max(u_xlat42, 0.899999976);
        u_xlat4.xyz = u_xlat16_2.xyz * vec3(u_xlat42) + (-u_xlat10_3.xyz);
        u_xlat2.xyz = vec3(u_xlat39) * u_xlat4.xyz + u_xlat10_3.xyz;
        u_xlat3.xyz = u_xlat0.xyz + (-u_xlat16_1.xyz);
        u_xlat3.xyz = vec3(u_xlat39) * u_xlat3.xyz + u_xlat16_1.xyz;
        u_xlat16_2.xyz = u_xlat2.xyz;
        u_xlat16_3.xyz = u_xlat3.xyz;
    } else {
        u_xlat16_3.xyz = u_xlat0.xyz;
    //ENDIF
    }
    u_xlat16_1.x = u_xlat16_40 * _Terrain_Smoothness;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    SV_Target2.w = min(u_xlat16_1.x, 0.5);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(vec3(_Terrain_Specular, _Terrain_Specular, _Terrain_Specular));
    u_xlat16_0.x = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_40 = max(u_xlat16_1.z, u_xlat16_1.y);
    u_xlat16_40 = max(u_xlat16_40, u_xlat16_1.x);
    u_xlat16_40 = (-u_xlat16_40) + 1.0;
    SV_Target1.xyz = vec3(u_xlat16_40) * u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_40 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_40 : u_xlat16_1.z;
    SV_Target0.w = 0.0;
    SV_Target1.w = _SSAO_Intensity;
    SV_Target2.xy = u_xlat16_1.xy;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _Diffuse1_ST;
uniform 	float _UVDiffuse2;
uniform 	vec4 _Diffuse2_ST;
uniform 	float _UVDetail;
uniform 	vec4 _DetailDiffuse_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat7;
float u_xlat16;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x;
    u_xlat2.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].x;
    u_xlat2.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].x;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].y;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].y;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].y;
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.xy = sqrt(u_xlat2.xy);
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].z;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].z;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].z;
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat2.x = u_xlat7.x + u_xlat2.x;
    u_xlat2.x = u_xlat2.x * 0.330000013;
    u_xlat7.xy = u_xlat2.xx * in_TEXCOORD0.xy;
    u_xlat2.xw = u_xlat2.xx * in_TEXCOORD1.xy;
    vs_TEXCOORD0.xy = u_xlat7.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Diffuse1_ST.xy + _Diffuse1_ST.zw;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UVDiffuse2==0.0);
#else
    u_xlatb1 = _UVDiffuse2==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb1)) ? u_xlat7.xy : u_xlat2.xw;
    vs_TEXCOORD2.xy = u_xlat1.xy * _Diffuse2_ST.xy + _Diffuse2_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UVDetail==0.0);
#else
    u_xlatb1 = _UVDetail==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb1)) ? u_xlat7.xy : u_xlat2.xw;
    vs_TEXCOORD2.zw = u_xlat1.xy * _DetailDiffuse_ST.xy + _DetailDiffuse_ST.zw;
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat2.xyz = vec3(u_xlat0) * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_4.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = vec3(u_xlat0) * u_xlat16_4.xyz;
    vs_TEXCOORD3.y = u_xlat16_4.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD3.w = u_xlat5.x;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat5.y;
    vs_TEXCOORD5.w = u_xlat5.z;
    vs_TEXCOORD4.y = u_xlat16_4.y;
    vs_TEXCOORD5.y = u_xlat16_4.z;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump float _HeightSpread;
uniform 	mediump float _HeightContrast;
uniform 	mediump float _UseTintColor;
uniform 	mediump float _UseDiffuseOneHeight;
uniform 	mediump float _UseDiffuseTwoHeight;
uniform 	mediump float _UseDetailDiffuseHeight;
uniform 	mediump float _UseGrassHeightBlend;
uniform 	mediump float _UseGrassSpecular;
uniform 	mediump float _UseSpecularOne;
uniform 	mediump float _UseSpecularTwo;
uniform 	mediump float _UseDetailSpecular;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _SSAO_Intensity;
uniform 	mediump float _Terrain_Smoothness;
uniform 	mediump float _Terrain_Specular;
uniform 	mediump float _Shininess;
uniform 	float _GrassNormalScale;
uniform 	float _Normal0Scale;
uniform 	mediump float _Normal2Scale;
uniform 	mediump float _Diffuse2Distance;
uniform 	mediump float _Diffuse2Fade;
uniform 	mediump float _DetailNormalScale;
uniform 	mediump float _DetailNormalUVScale;
uniform 	mediump float _DetailBlendVal;
uniform 	mediump float _DetailDistance;
uniform 	mediump float _DetailFade;
uniform 	mediump float _DepthBiasScaled;
uniform 	mediump float _DepthBlendAO;
uniform lowp sampler2D _GrassNormal;
uniform lowp sampler2D _GrassDiffuse;
uniform lowp sampler2D _Normal0;
uniform lowp sampler2D _Normal2;
uniform lowp sampler2D _Diffuse1;
uniform lowp sampler2D _DetailNormal;
uniform lowp sampler2D _Diffuse2;
uniform lowp sampler2D _DetailDiffuse;
uniform highp sampler2D _CameraDepthBlendTexture;
uniform lowp sampler2D _CameraDepthBlendNormTexture;
uniform lowp sampler2D _CameraDepthBlendDiffTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_6;
mediump vec4 u_xlat16_7;
lowp vec4 u_xlat10_8;
lowp vec4 u_xlat10_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
mediump vec3 u_xlat16_12;
float u_xlat13;
mediump float u_xlat16_13;
vec2 u_xlat26;
mediump float u_xlat16_26;
mediump vec2 u_xlat16_31;
mediump float u_xlat16_33;
float u_xlat39;
bool u_xlatb39;
mediump float u_xlat16_40;
mediump float u_xlat16_41;
float u_xlat42;
mediump float u_xlat16_44;
mediump float u_xlat16_46;
mediump float u_xlat16_49;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_COLOR0.w<0.99000001);
#else
    u_xlatb0 = vs_COLOR0.w<0.99000001;
#endif
    if(u_xlatb0){
        u_xlat10_0 = texture(_GrassNormal, vs_TEXCOORD0.xy);
        u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_1.xy = u_xlat16_1.xy * vec2(_GrassNormalScale);
        u_xlat16_40 = u_xlat10_0.w * _UseGrassSpecular;
        u_xlat10_0.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.xy).xyz;
        u_xlat16_2.xyz = u_xlat10_0.xyz;
    } else {
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
        u_xlat16_1.x = float(0.0);
        u_xlat16_1.y = float(0.0);
        u_xlat16_1.z = float(1.0);
        u_xlat16_40 = float(0.0);
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.00999999978<vs_COLOR0.w);
#else
    u_xlatb0 = 0.00999999978<vs_COLOR0.w;
#endif
    if(u_xlatb0){
        u_xlat0.x = vs_TEXCOORD3.w;
        u_xlat0.y = vs_TEXCOORD4.w;
        u_xlat0.z = vs_TEXCOORD5.w;
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat13 = u_xlat0.x / _Diffuse2Distance;
#ifdef UNITY_ADRENO_ES3
        u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
        u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
        u_xlat13 = u_xlat13 + 9.99999975e-05;
        u_xlat13 = log2(u_xlat13);
        u_xlat13 = u_xlat13 * _Diffuse2Fade;
        u_xlat0.y = exp2(u_xlat13);
        u_xlat0.x = u_xlat0.x / _DetailDistance;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = u_xlat0.x + 9.99999975e-05;
        u_xlat0.x = log2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * _DetailFade;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat0.xy = min(u_xlat0.xy, vec2(1.0, 1.0));
        u_xlat10_3.xyz = texture(_Normal0, vs_TEXCOORD0.zw).xyw;
        u_xlat10_4.xyz = texture(_Normal2, vs_TEXCOORD2.xy).xyw;
        u_xlat16_5.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_31.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_31.xy = u_xlat16_31.xy * vec2(_Normal2Scale);
        u_xlat16_41 = (-u_xlat0.y) + 1.0;
        u_xlat16_31.xy = vec2(u_xlat16_41) * u_xlat16_31.xy;
        u_xlat16_31.xy = u_xlat16_31.xy * vs_COLOR0.xx;
        u_xlat10_6 = texture(_Diffuse1, vs_TEXCOORD0.zw);
        u_xlat26.xy = vec2(vs_TEXCOORD2.z * float(_DetailNormalUVScale), vs_TEXCOORD2.w * float(_DetailNormalUVScale));
        u_xlat10_3.xyw = texture(_DetailNormal, u_xlat26.xy).xyw;
        u_xlat16_7.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_7.xy = u_xlat16_7.xy * vec2(_DetailNormalScale);
        u_xlat16_41 = (-u_xlat0.x) + 1.0;
        u_xlat16_7.xy = vec2(u_xlat16_41) * u_xlat16_7.xy;
        u_xlat10_8 = texture(_Diffuse2, vs_TEXCOORD2.xy);
        u_xlat10_9 = texture(_DetailDiffuse, vs_TEXCOORD2.zw);
        u_xlat16_41 = u_xlat10_8.w * _UseDiffuseTwoHeight;
        u_xlat16_33 = u_xlat10_9.w * _UseDetailDiffuseHeight;
        u_xlat16_10.xyz = u_xlat10_6.xyz + (-u_xlat10_8.xyz);
        u_xlat16_46 = u_xlat10_6.w * _UseDiffuseOneHeight + (-u_xlat16_41);
        u_xlat16_10.xyz = u_xlat0.yyy * u_xlat16_10.xyz + u_xlat10_8.xyz;
        u_xlat16_41 = u_xlat0.y * u_xlat16_46 + u_xlat16_41;
        u_xlat16_46 = u_xlat0.x * _DetailBlendVal;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_46 = min(max(u_xlat16_46, 0.0), 1.0);
#else
        u_xlat16_46 = clamp(u_xlat16_46, 0.0, 1.0);
#endif
        u_xlat16_49 = (-u_xlat16_46) + 1.0;
        u_xlat16_33 = u_xlat16_33 * u_xlat16_49;
        u_xlat16_41 = max(u_xlat16_41, u_xlat16_33);
        u_xlat16_11.xyz = u_xlat10_9.xyz * u_xlat16_10.xyz;
        u_xlat16_12.xyz = u_xlat16_11.xyz * vec3(4.0, 4.0, 4.0);
        u_xlat16_10.xyz = (-u_xlat16_11.xyz) * vec3(4.0, 4.0, 4.0) + u_xlat16_10.xyz;
        u_xlat16_10.xyz = vec3(u_xlat16_46) * u_xlat16_10.xyz + u_xlat16_12.xyz;
        u_xlat16_10.xyz = min(u_xlat16_10.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_33 = u_xlat10_4.z * _UseSpecularTwo;
        u_xlat16_46 = u_xlat10_3.w * _UseDetailSpecular;
        u_xlat16_11.x = _UseSpecularOne * u_xlat10_3.z + (-u_xlat16_33);
        u_xlat16_33 = u_xlat0.y * u_xlat16_11.x + u_xlat16_33;
        u_xlat16_46 = u_xlat16_49 * u_xlat16_46;
        u_xlat16_33 = max(u_xlat16_46, u_xlat16_33);
        u_xlat16_5.xy = u_xlat16_5.xy * vec2(_Normal0Scale) + u_xlat16_31.xy;
        u_xlat16_5.xy = u_xlat16_7.xy * vs_COLOR0.xx + u_xlat16_5.xy;
    } else {
        u_xlat16_10.x = float(0.0);
        u_xlat16_10.y = float(0.0);
        u_xlat16_10.z = float(0.0);
        u_xlat16_5.x = float(0.0);
        u_xlat16_5.y = float(0.0);
        u_xlat16_41 = 1.0;
        u_xlat16_33 = 0.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor);
#endif
    u_xlat16_7.xyw = u_xlat16_10.xyz * _TintColor.xyz;
    u_xlat16_7.xyw = (bool(u_xlatb0)) ? u_xlat16_7.xyw : u_xlat16_10.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend);
#endif
    u_xlat16_13 = u_xlat16_41;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_26 = vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_41 = _HeightContrast * 10.0;
    u_xlat16_13 = u_xlat16_13 + -1.0;
    u_xlat16_44 = _HeightSpread + 0.100000001;
    u_xlat16_26 = log2(u_xlat16_26);
    u_xlat16_26 = u_xlat16_26 * u_xlat16_44;
    u_xlat16_26 = exp2(u_xlat16_26);
    u_xlat16_13 = u_xlat16_26 * 2.0 + u_xlat16_13;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_26 = _HeightContrast * 10.0 + 1.0;
    u_xlat16_26 = _HeightContrast * 10.0 + u_xlat16_26;
    u_xlat13 = u_xlat16_13 * u_xlat16_26 + (-u_xlat16_41);
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat16_41 = (u_xlatb0) ? u_xlat13 : vs_COLOR0.w;
    u_xlat16_5.z = 1.0;
    u_xlat16_5.xyz = (-u_xlat16_1.xyz) + u_xlat16_5.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_41) * u_xlat16_5.xyz + u_xlat16_1.xyz;
    u_xlat16_5.x = (-u_xlat16_40) + u_xlat16_33;
    u_xlat16_40 = u_xlat16_41 * u_xlat16_5.x + u_xlat16_40;
    u_xlat16_5.xyz = (-u_xlat16_2.xyz) + u_xlat16_7.xyw;
    u_xlat16_2.xyz = vec3(u_xlat16_41) * u_xlat16_5.xyz + u_xlat16_2.xyz;
    u_xlat16_40 = u_xlat16_40 + _Shininess;
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD5.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!(vs_TEXCOORD1.w<100.0);
#else
    u_xlatb39 = vs_TEXCOORD1.w<100.0;
#endif
    if(u_xlatb39){
        u_xlat3.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
        u_xlat39 = texture(_CameraDepthBlendTexture, u_xlat3.xy).x;
        u_xlat39 = _ZBufferParams.z * u_xlat39 + _ZBufferParams.w;
        u_xlat39 = float(1.0) / u_xlat39;
        u_xlat39 = u_xlat39 + (-vs_TEXCOORD1.w);
        u_xlat39 = abs(u_xlat39) * _DepthBiasScaled;
        u_xlat39 = u_xlat39 * 0.600000024;
#ifdef UNITY_ADRENO_ES3
        u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
        u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
        u_xlat39 = sqrt(u_xlat39);
        u_xlat10_4.xyz = texture(_CameraDepthBlendNormTexture, u_xlat3.xy).xyz;
        u_xlat16_1.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat10_3.xyz = texture(_CameraDepthBlendDiffTexture, u_xlat3.xy).xyz;
        u_xlat16_41 = u_xlat0.y * _DepthBlendAO;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
        u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
        u_xlat42 = (-u_xlat39) + 1.0;
        u_xlat42 = u_xlat16_41 * u_xlat42 + u_xlat39;
        u_xlat42 = max(u_xlat42, 0.899999976);
        u_xlat4.xyz = u_xlat16_2.xyz * vec3(u_xlat42) + (-u_xlat10_3.xyz);
        u_xlat2.xyz = vec3(u_xlat39) * u_xlat4.xyz + u_xlat10_3.xyz;
        u_xlat3.xyz = u_xlat0.xyz + (-u_xlat16_1.xyz);
        u_xlat3.xyz = vec3(u_xlat39) * u_xlat3.xyz + u_xlat16_1.xyz;
        u_xlat16_2.xyz = u_xlat2.xyz;
        u_xlat16_3.xyz = u_xlat3.xyz;
    } else {
        u_xlat16_3.xyz = u_xlat0.xyz;
    //ENDIF
    }
    u_xlat16_1.x = u_xlat16_40 * _Terrain_Smoothness;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    SV_Target2.w = min(u_xlat16_1.x, 0.5);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(vec3(_Terrain_Specular, _Terrain_Specular, _Terrain_Specular));
    u_xlat16_0.x = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_40 = max(u_xlat16_1.z, u_xlat16_1.y);
    u_xlat16_40 = max(u_xlat16_40, u_xlat16_1.x);
    u_xlat16_40 = (-u_xlat16_40) + 1.0;
    SV_Target1.xyz = vec3(u_xlat16_40) * u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_40 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_40 : u_xlat16_1.z;
    SV_Target0.w = 0.0;
    SV_Target1.w = _SSAO_Intensity;
    SV_Target2.xy = u_xlat16_1.xy;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _Diffuse1_ST;
uniform 	float _UVDiffuse2;
uniform 	vec4 _Diffuse2_ST;
uniform 	float _UVDetail;
uniform 	vec4 _DetailDiffuse_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec2 u_xlat12;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat15 = u_xlat15 + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat15 = u_xlat15 + u_xlat2.x;
    u_xlat15 = u_xlat15 * 0.330000013;
    u_xlat2.xy = vec2(u_xlat15) * in_TEXCOORD0.xy;
    u_xlat12.xy = vec2(u_xlat15) * in_TEXCOORD1.xy;
    vs_TEXCOORD0.xy = u_xlat2.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Diffuse1_ST.xy + _Diffuse1_ST.zw;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat15 * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UVDiffuse2==0.0);
#else
    u_xlatb15 = _UVDiffuse2==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat2.xy : u_xlat12.xy;
    vs_TEXCOORD2.xy = u_xlat1.xy * _Diffuse2_ST.xy + _Diffuse2_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UVDetail==0.0);
#else
    u_xlatb15 = _UVDetail==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat2.xy : u_xlat12.xy;
    vs_TEXCOORD2.zw = u_xlat1.xy * _DetailDiffuse_ST.xy + _DetailDiffuse_ST.zw;
    vs_TEXCOORD3.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz;
    vs_TEXCOORD3.y = u_xlat16_4.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat0.y;
    vs_TEXCOORD5.w = u_xlat0.z;
    vs_TEXCOORD4.y = u_xlat16_4.y;
    vs_TEXCOORD5.y = u_xlat16_4.z;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump float _HeightSpread;
uniform 	mediump float _HeightContrast;
uniform 	mediump float _UseTintColor;
uniform 	mediump float _UseDiffuseOneHeight;
uniform 	mediump float _UseDiffuseTwoHeight;
uniform 	mediump float _UseDetailDiffuseHeight;
uniform 	mediump float _UseGrassHeightBlend;
uniform 	mediump float _UseGrassSpecular;
uniform 	mediump float _UseSpecularOne;
uniform 	mediump float _UseSpecularTwo;
uniform 	mediump float _UseDetailSpecular;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _SSAO_Intensity;
uniform 	mediump float _Terrain_Smoothness;
uniform 	mediump float _Terrain_Specular;
uniform 	mediump float _Shininess;
uniform 	mediump float _Diffuse2Distance;
uniform 	mediump float _Diffuse2Fade;
uniform 	mediump float _DetailNormalUVScale;
uniform 	mediump float _DetailBlendVal;
uniform 	mediump float _DetailDistance;
uniform 	mediump float _DetailFade;
uniform 	mediump float _DepthBiasScaled;
uniform 	mediump float _DepthBlendAO;
uniform lowp sampler2D _GrassNormal;
uniform lowp sampler2D _GrassDiffuse;
uniform lowp sampler2D _Normal0;
uniform lowp sampler2D _Normal2;
uniform lowp sampler2D _Diffuse1;
uniform lowp sampler2D _DetailNormal;
uniform lowp sampler2D _Diffuse2;
uniform lowp sampler2D _DetailDiffuse;
uniform highp sampler2D _CameraDepthBlendTexture;
uniform lowp sampler2D _CameraDepthBlendNormTexture;
uniform lowp sampler2D _CameraDepthBlendDiffTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_6;
mediump vec4 u_xlat16_7;
lowp vec4 u_xlat10_8;
lowp vec4 u_xlat10_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
mediump vec3 u_xlat16_12;
float u_xlat13;
mediump float u_xlat16_13;
vec2 u_xlat26;
mediump float u_xlat16_26;
mediump vec2 u_xlat16_31;
mediump float u_xlat16_33;
float u_xlat39;
bool u_xlatb39;
mediump float u_xlat16_40;
mediump float u_xlat16_41;
float u_xlat42;
mediump float u_xlat16_44;
mediump float u_xlat16_46;
mediump float u_xlat16_49;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_COLOR0.w<0.99000001);
#else
    u_xlatb0 = vs_COLOR0.w<0.99000001;
#endif
    if(u_xlatb0){
        u_xlat10_0 = texture(_GrassNormal, vs_TEXCOORD0.xy, -1.0);
        u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_40 = u_xlat10_0.w * _UseGrassSpecular;
        u_xlat10_0.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.xy, -1.0).xyz;
        u_xlat16_2.xyz = u_xlat10_0.xyz;
    } else {
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
        u_xlat16_1.x = float(0.0);
        u_xlat16_1.y = float(0.0);
        u_xlat16_1.z = float(1.0);
        u_xlat16_40 = float(0.0);
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.00999999978<vs_COLOR0.w);
#else
    u_xlatb0 = 0.00999999978<vs_COLOR0.w;
#endif
    if(u_xlatb0){
        u_xlat0.x = vs_TEXCOORD3.w;
        u_xlat0.y = vs_TEXCOORD4.w;
        u_xlat0.z = vs_TEXCOORD5.w;
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat13 = u_xlat0.x / _Diffuse2Distance;
#ifdef UNITY_ADRENO_ES3
        u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
        u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
        u_xlat13 = u_xlat13 + 9.99999975e-05;
        u_xlat13 = log2(u_xlat13);
        u_xlat13 = u_xlat13 * _Diffuse2Fade;
        u_xlat0.y = exp2(u_xlat13);
        u_xlat0.x = u_xlat0.x / _DetailDistance;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = u_xlat0.x + 9.99999975e-05;
        u_xlat0.x = log2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * _DetailFade;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat0.xy = min(u_xlat0.xy, vec2(1.0, 1.0));
        u_xlat10_3.xyz = texture(_Normal0, vs_TEXCOORD0.zw, -1.0).xyw;
        u_xlat10_4.xyz = texture(_Normal2, vs_TEXCOORD2.xy, -1.0).xyw;
        u_xlat16_5.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_31.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_41 = (-u_xlat0.y) + 1.0;
        u_xlat16_31.xy = vec2(u_xlat16_41) * u_xlat16_31.xy;
        u_xlat10_6 = texture(_Diffuse1, vs_TEXCOORD0.zw, -1.0);
        u_xlat26.xy = vec2(vs_TEXCOORD2.z * float(_DetailNormalUVScale), vs_TEXCOORD2.w * float(_DetailNormalUVScale));
        u_xlat10_3.xyw = texture(_DetailNormal, u_xlat26.xy, -1.0).xyw;
        u_xlat16_7.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_41 = (-u_xlat0.x) + 1.0;
        u_xlat16_7.xy = vec2(u_xlat16_41) * u_xlat16_7.xy;
        u_xlat10_8 = texture(_Diffuse2, vs_TEXCOORD2.xy, -1.0);
        u_xlat10_9 = texture(_DetailDiffuse, vs_TEXCOORD2.zw, -1.0);
        u_xlat16_41 = u_xlat10_8.w * _UseDiffuseTwoHeight;
        u_xlat16_33 = u_xlat10_9.w * _UseDetailDiffuseHeight;
        u_xlat16_10.xyz = u_xlat10_6.xyz + (-u_xlat10_8.xyz);
        u_xlat16_46 = u_xlat10_6.w * _UseDiffuseOneHeight + (-u_xlat16_41);
        u_xlat16_10.xyz = u_xlat0.yyy * u_xlat16_10.xyz + u_xlat10_8.xyz;
        u_xlat16_41 = u_xlat0.y * u_xlat16_46 + u_xlat16_41;
        u_xlat16_46 = u_xlat0.x * _DetailBlendVal;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_46 = min(max(u_xlat16_46, 0.0), 1.0);
#else
        u_xlat16_46 = clamp(u_xlat16_46, 0.0, 1.0);
#endif
        u_xlat16_49 = (-u_xlat16_46) + 1.0;
        u_xlat16_33 = u_xlat16_33 * u_xlat16_49;
        u_xlat16_41 = max(u_xlat16_41, u_xlat16_33);
        u_xlat16_11.xyz = u_xlat10_9.xyz * u_xlat16_10.xyz;
        u_xlat16_12.xyz = u_xlat16_11.xyz * vec3(4.0, 4.0, 4.0);
        u_xlat16_10.xyz = (-u_xlat16_11.xyz) * vec3(4.0, 4.0, 4.0) + u_xlat16_10.xyz;
        u_xlat16_10.xyz = vec3(u_xlat16_46) * u_xlat16_10.xyz + u_xlat16_12.xyz;
        u_xlat16_10.xyz = min(u_xlat16_10.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_33 = u_xlat10_4.z * _UseSpecularTwo;
        u_xlat16_46 = u_xlat10_3.w * _UseDetailSpecular;
        u_xlat16_11.x = _UseSpecularOne * u_xlat10_3.z + (-u_xlat16_33);
        u_xlat16_33 = u_xlat0.y * u_xlat16_11.x + u_xlat16_33;
        u_xlat16_46 = u_xlat16_49 * u_xlat16_46;
        u_xlat16_33 = max(u_xlat16_46, u_xlat16_33);
        u_xlat16_5.xy = u_xlat16_31.xy * vs_COLOR0.xx + u_xlat16_5.xy;
        u_xlat16_5.xy = u_xlat16_7.xy * vs_COLOR0.xx + u_xlat16_5.xy;
    } else {
        u_xlat16_10.x = float(0.0);
        u_xlat16_10.y = float(0.0);
        u_xlat16_10.z = float(0.0);
        u_xlat16_5.x = float(0.0);
        u_xlat16_5.y = float(0.0);
        u_xlat16_41 = 1.0;
        u_xlat16_33 = 0.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor);
#endif
    u_xlat16_7.xyw = u_xlat16_10.xyz * _TintColor.xyz;
    u_xlat16_7.xyw = (bool(u_xlatb0)) ? u_xlat16_7.xyw : u_xlat16_10.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend);
#endif
    u_xlat16_13 = u_xlat16_41;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_26 = vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_41 = _HeightContrast * 10.0;
    u_xlat16_13 = u_xlat16_13 + -1.0;
    u_xlat16_44 = _HeightSpread + 0.100000001;
    u_xlat16_26 = log2(u_xlat16_26);
    u_xlat16_26 = u_xlat16_26 * u_xlat16_44;
    u_xlat16_26 = exp2(u_xlat16_26);
    u_xlat16_13 = u_xlat16_26 * 2.0 + u_xlat16_13;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_26 = _HeightContrast * 10.0 + 1.0;
    u_xlat16_26 = _HeightContrast * 10.0 + u_xlat16_26;
    u_xlat13 = u_xlat16_13 * u_xlat16_26 + (-u_xlat16_41);
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat16_41 = (u_xlatb0) ? u_xlat13 : vs_COLOR0.w;
    u_xlat16_5.z = 1.0;
    u_xlat16_5.xyz = (-u_xlat16_1.xyz) + u_xlat16_5.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_41) * u_xlat16_5.xyz + u_xlat16_1.xyz;
    u_xlat16_5.x = (-u_xlat16_40) + u_xlat16_33;
    u_xlat16_40 = u_xlat16_41 * u_xlat16_5.x + u_xlat16_40;
    u_xlat16_5.xyz = (-u_xlat16_2.xyz) + u_xlat16_7.xyw;
    u_xlat16_2.xyz = vec3(u_xlat16_41) * u_xlat16_5.xyz + u_xlat16_2.xyz;
    u_xlat16_40 = u_xlat16_40 + _Shininess;
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD5.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!(vs_TEXCOORD1.w<100.0);
#else
    u_xlatb39 = vs_TEXCOORD1.w<100.0;
#endif
    if(u_xlatb39){
        u_xlat3.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
        u_xlat39 = texture(_CameraDepthBlendTexture, u_xlat3.xy).x;
        u_xlat39 = _ZBufferParams.z * u_xlat39 + _ZBufferParams.w;
        u_xlat39 = float(1.0) / u_xlat39;
        u_xlat39 = u_xlat39 + (-vs_TEXCOORD1.w);
        u_xlat39 = abs(u_xlat39) * _DepthBiasScaled;
        u_xlat39 = u_xlat39 * 0.600000024;
#ifdef UNITY_ADRENO_ES3
        u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
        u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
        u_xlat39 = sqrt(u_xlat39);
        u_xlat10_4.xyz = texture(_CameraDepthBlendNormTexture, u_xlat3.xy).xyz;
        u_xlat16_1.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat10_3.xyz = texture(_CameraDepthBlendDiffTexture, u_xlat3.xy).xyz;
        u_xlat16_41 = u_xlat0.y * _DepthBlendAO;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
        u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
        u_xlat42 = (-u_xlat39) + 1.0;
        u_xlat42 = u_xlat16_41 * u_xlat42 + u_xlat39;
        u_xlat42 = max(u_xlat42, 0.899999976);
        u_xlat4.xyz = u_xlat16_2.xyz * vec3(u_xlat42) + (-u_xlat10_3.xyz);
        u_xlat2.xyz = vec3(u_xlat39) * u_xlat4.xyz + u_xlat10_3.xyz;
        u_xlat3.xyz = u_xlat0.xyz + (-u_xlat16_1.xyz);
        u_xlat3.xyz = vec3(u_xlat39) * u_xlat3.xyz + u_xlat16_1.xyz;
        u_xlat16_2.xyz = u_xlat2.xyz;
        u_xlat16_3.xyz = u_xlat3.xyz;
    } else {
        u_xlat16_3.xyz = u_xlat0.xyz;
    //ENDIF
    }
    u_xlat16_1.x = u_xlat16_40 * _Terrain_Smoothness;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    SV_Target2.w = min(u_xlat16_1.x, 0.5);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(vec3(_Terrain_Specular, _Terrain_Specular, _Terrain_Specular));
    u_xlat16_0.x = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_40 = max(u_xlat16_1.z, u_xlat16_1.y);
    u_xlat16_40 = max(u_xlat16_40, u_xlat16_1.x);
    u_xlat16_40 = (-u_xlat16_40) + 1.0;
    SV_Target1.xyz = vec3(u_xlat16_40) * u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_40 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_40 : u_xlat16_1.z;
    SV_Target0.w = 0.0;
    SV_Target1.w = _SSAO_Intensity;
    SV_Target2.xy = u_xlat16_1.xy;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _Diffuse1_ST;
uniform 	float _UVDiffuse2;
uniform 	vec4 _Diffuse2_ST;
uniform 	float _UVDetail;
uniform 	vec4 _DetailDiffuse_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat7;
float u_xlat16;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x;
    u_xlat2.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].x;
    u_xlat2.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].x;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].y;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].y;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].y;
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.xy = sqrt(u_xlat2.xy);
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].z;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].z;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].z;
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat2.x = u_xlat7.x + u_xlat2.x;
    u_xlat2.x = u_xlat2.x * 0.330000013;
    u_xlat7.xy = u_xlat2.xx * in_TEXCOORD0.xy;
    u_xlat2.xw = u_xlat2.xx * in_TEXCOORD1.xy;
    vs_TEXCOORD0.xy = u_xlat7.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Diffuse1_ST.xy + _Diffuse1_ST.zw;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UVDiffuse2==0.0);
#else
    u_xlatb1 = _UVDiffuse2==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb1)) ? u_xlat7.xy : u_xlat2.xw;
    vs_TEXCOORD2.xy = u_xlat1.xy * _Diffuse2_ST.xy + _Diffuse2_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UVDetail==0.0);
#else
    u_xlatb1 = _UVDetail==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb1)) ? u_xlat7.xy : u_xlat2.xw;
    vs_TEXCOORD2.zw = u_xlat1.xy * _DetailDiffuse_ST.xy + _DetailDiffuse_ST.zw;
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat2.xyz = vec3(u_xlat0) * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_4.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = vec3(u_xlat0) * u_xlat16_4.xyz;
    vs_TEXCOORD3.y = u_xlat16_4.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD3.w = u_xlat5.x;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat5.y;
    vs_TEXCOORD5.w = u_xlat5.z;
    vs_TEXCOORD4.y = u_xlat16_4.y;
    vs_TEXCOORD5.y = u_xlat16_4.z;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump float _HeightSpread;
uniform 	mediump float _HeightContrast;
uniform 	mediump float _UseTintColor;
uniform 	mediump float _UseDiffuseOneHeight;
uniform 	mediump float _UseDiffuseTwoHeight;
uniform 	mediump float _UseDetailDiffuseHeight;
uniform 	mediump float _UseGrassHeightBlend;
uniform 	mediump float _UseGrassSpecular;
uniform 	mediump float _UseSpecularOne;
uniform 	mediump float _UseSpecularTwo;
uniform 	mediump float _UseDetailSpecular;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _SSAO_Intensity;
uniform 	mediump float _Terrain_Smoothness;
uniform 	mediump float _Terrain_Specular;
uniform 	mediump float _Shininess;
uniform 	float _GrassNormalScale;
uniform 	float _Normal0Scale;
uniform 	mediump float _Normal2Scale;
uniform 	mediump float _Diffuse2Distance;
uniform 	mediump float _Diffuse2Fade;
uniform 	mediump float _DetailNormalScale;
uniform 	mediump float _DetailNormalUVScale;
uniform 	mediump float _DetailBlendVal;
uniform 	mediump float _DetailDistance;
uniform 	mediump float _DetailFade;
uniform 	mediump float _DepthBiasScaled;
uniform 	mediump float _DepthBlendAO;
uniform lowp sampler2D _GrassNormal;
uniform lowp sampler2D _GrassDiffuse;
uniform lowp sampler2D _Normal0;
uniform lowp sampler2D _Normal2;
uniform lowp sampler2D _Diffuse1;
uniform lowp sampler2D _DetailNormal;
uniform lowp sampler2D _Diffuse2;
uniform lowp sampler2D _DetailDiffuse;
uniform highp sampler2D _CameraDepthBlendTexture;
uniform lowp sampler2D _CameraDepthBlendNormTexture;
uniform lowp sampler2D _CameraDepthBlendDiffTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_6;
mediump vec4 u_xlat16_7;
lowp vec4 u_xlat10_8;
lowp vec4 u_xlat10_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
mediump vec3 u_xlat16_12;
float u_xlat13;
mediump float u_xlat16_13;
vec2 u_xlat26;
mediump float u_xlat16_26;
mediump vec2 u_xlat16_31;
mediump float u_xlat16_33;
float u_xlat39;
bool u_xlatb39;
mediump float u_xlat16_40;
mediump float u_xlat16_41;
float u_xlat42;
mediump float u_xlat16_44;
mediump float u_xlat16_46;
mediump float u_xlat16_49;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_COLOR0.w<0.99000001);
#else
    u_xlatb0 = vs_COLOR0.w<0.99000001;
#endif
    if(u_xlatb0){
        u_xlat10_0 = texture(_GrassNormal, vs_TEXCOORD0.xy, -1.0);
        u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_1.xy = u_xlat16_1.xy * vec2(_GrassNormalScale);
        u_xlat16_40 = u_xlat10_0.w * _UseGrassSpecular;
        u_xlat10_0.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.xy, -1.0).xyz;
        u_xlat16_2.xyz = u_xlat10_0.xyz;
    } else {
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
        u_xlat16_1.x = float(0.0);
        u_xlat16_1.y = float(0.0);
        u_xlat16_1.z = float(1.0);
        u_xlat16_40 = float(0.0);
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.00999999978<vs_COLOR0.w);
#else
    u_xlatb0 = 0.00999999978<vs_COLOR0.w;
#endif
    if(u_xlatb0){
        u_xlat0.x = vs_TEXCOORD3.w;
        u_xlat0.y = vs_TEXCOORD4.w;
        u_xlat0.z = vs_TEXCOORD5.w;
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat13 = u_xlat0.x / _Diffuse2Distance;
#ifdef UNITY_ADRENO_ES3
        u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
        u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
        u_xlat13 = u_xlat13 + 9.99999975e-05;
        u_xlat13 = log2(u_xlat13);
        u_xlat13 = u_xlat13 * _Diffuse2Fade;
        u_xlat0.y = exp2(u_xlat13);
        u_xlat0.x = u_xlat0.x / _DetailDistance;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = u_xlat0.x + 9.99999975e-05;
        u_xlat0.x = log2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * _DetailFade;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat0.xy = min(u_xlat0.xy, vec2(1.0, 1.0));
        u_xlat10_3.xyz = texture(_Normal0, vs_TEXCOORD0.zw, -1.0).xyw;
        u_xlat10_4.xyz = texture(_Normal2, vs_TEXCOORD2.xy, -1.0).xyw;
        u_xlat16_5.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_31.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_31.xy = u_xlat16_31.xy * vec2(_Normal2Scale);
        u_xlat16_41 = (-u_xlat0.y) + 1.0;
        u_xlat16_31.xy = vec2(u_xlat16_41) * u_xlat16_31.xy;
        u_xlat16_31.xy = u_xlat16_31.xy * vs_COLOR0.xx;
        u_xlat10_6 = texture(_Diffuse1, vs_TEXCOORD0.zw, -1.0);
        u_xlat26.xy = vec2(vs_TEXCOORD2.z * float(_DetailNormalUVScale), vs_TEXCOORD2.w * float(_DetailNormalUVScale));
        u_xlat10_3.xyw = texture(_DetailNormal, u_xlat26.xy, -1.0).xyw;
        u_xlat16_7.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_7.xy = u_xlat16_7.xy * vec2(_DetailNormalScale);
        u_xlat16_41 = (-u_xlat0.x) + 1.0;
        u_xlat16_7.xy = vec2(u_xlat16_41) * u_xlat16_7.xy;
        u_xlat10_8 = texture(_Diffuse2, vs_TEXCOORD2.xy, -1.0);
        u_xlat10_9 = texture(_DetailDiffuse, vs_TEXCOORD2.zw, -1.0);
        u_xlat16_41 = u_xlat10_8.w * _UseDiffuseTwoHeight;
        u_xlat16_33 = u_xlat10_9.w * _UseDetailDiffuseHeight;
        u_xlat16_10.xyz = u_xlat10_6.xyz + (-u_xlat10_8.xyz);
        u_xlat16_46 = u_xlat10_6.w * _UseDiffuseOneHeight + (-u_xlat16_41);
        u_xlat16_10.xyz = u_xlat0.yyy * u_xlat16_10.xyz + u_xlat10_8.xyz;
        u_xlat16_41 = u_xlat0.y * u_xlat16_46 + u_xlat16_41;
        u_xlat16_46 = u_xlat0.x * _DetailBlendVal;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_46 = min(max(u_xlat16_46, 0.0), 1.0);
#else
        u_xlat16_46 = clamp(u_xlat16_46, 0.0, 1.0);
#endif
        u_xlat16_49 = (-u_xlat16_46) + 1.0;
        u_xlat16_33 = u_xlat16_33 * u_xlat16_49;
        u_xlat16_41 = max(u_xlat16_41, u_xlat16_33);
        u_xlat16_11.xyz = u_xlat10_9.xyz * u_xlat16_10.xyz;
        u_xlat16_12.xyz = u_xlat16_11.xyz * vec3(4.0, 4.0, 4.0);
        u_xlat16_10.xyz = (-u_xlat16_11.xyz) * vec3(4.0, 4.0, 4.0) + u_xlat16_10.xyz;
        u_xlat16_10.xyz = vec3(u_xlat16_46) * u_xlat16_10.xyz + u_xlat16_12.xyz;
        u_xlat16_10.xyz = min(u_xlat16_10.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_33 = u_xlat10_4.z * _UseSpecularTwo;
        u_xlat16_46 = u_xlat10_3.w * _UseDetailSpecular;
        u_xlat16_11.x = _UseSpecularOne * u_xlat10_3.z + (-u_xlat16_33);
        u_xlat16_33 = u_xlat0.y * u_xlat16_11.x + u_xlat16_33;
        u_xlat16_46 = u_xlat16_49 * u_xlat16_46;
        u_xlat16_33 = max(u_xlat16_46, u_xlat16_33);
        u_xlat16_5.xy = u_xlat16_5.xy * vec2(_Normal0Scale) + u_xlat16_31.xy;
        u_xlat16_5.xy = u_xlat16_7.xy * vs_COLOR0.xx + u_xlat16_5.xy;
    } else {
        u_xlat16_10.x = float(0.0);
        u_xlat16_10.y = float(0.0);
        u_xlat16_10.z = float(0.0);
        u_xlat16_5.x = float(0.0);
        u_xlat16_5.y = float(0.0);
        u_xlat16_41 = 1.0;
        u_xlat16_33 = 0.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor);
#endif
    u_xlat16_7.xyw = u_xlat16_10.xyz * _TintColor.xyz;
    u_xlat16_7.xyw = (bool(u_xlatb0)) ? u_xlat16_7.xyw : u_xlat16_10.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend);
#endif
    u_xlat16_13 = u_xlat16_41;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_26 = vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_41 = _HeightContrast * 10.0;
    u_xlat16_13 = u_xlat16_13 + -1.0;
    u_xlat16_44 = _HeightSpread + 0.100000001;
    u_xlat16_26 = log2(u_xlat16_26);
    u_xlat16_26 = u_xlat16_26 * u_xlat16_44;
    u_xlat16_26 = exp2(u_xlat16_26);
    u_xlat16_13 = u_xlat16_26 * 2.0 + u_xlat16_13;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_26 = _HeightContrast * 10.0 + 1.0;
    u_xlat16_26 = _HeightContrast * 10.0 + u_xlat16_26;
    u_xlat13 = u_xlat16_13 * u_xlat16_26 + (-u_xlat16_41);
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat16_41 = (u_xlatb0) ? u_xlat13 : vs_COLOR0.w;
    u_xlat16_5.z = 1.0;
    u_xlat16_5.xyz = (-u_xlat16_1.xyz) + u_xlat16_5.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_41) * u_xlat16_5.xyz + u_xlat16_1.xyz;
    u_xlat16_5.x = (-u_xlat16_40) + u_xlat16_33;
    u_xlat16_40 = u_xlat16_41 * u_xlat16_5.x + u_xlat16_40;
    u_xlat16_5.xyz = (-u_xlat16_2.xyz) + u_xlat16_7.xyw;
    u_xlat16_2.xyz = vec3(u_xlat16_41) * u_xlat16_5.xyz + u_xlat16_2.xyz;
    u_xlat16_40 = u_xlat16_40 + _Shininess;
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD5.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!(vs_TEXCOORD1.w<100.0);
#else
    u_xlatb39 = vs_TEXCOORD1.w<100.0;
#endif
    if(u_xlatb39){
        u_xlat3.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
        u_xlat39 = texture(_CameraDepthBlendTexture, u_xlat3.xy).x;
        u_xlat39 = _ZBufferParams.z * u_xlat39 + _ZBufferParams.w;
        u_xlat39 = float(1.0) / u_xlat39;
        u_xlat39 = u_xlat39 + (-vs_TEXCOORD1.w);
        u_xlat39 = abs(u_xlat39) * _DepthBiasScaled;
        u_xlat39 = u_xlat39 * 0.600000024;
#ifdef UNITY_ADRENO_ES3
        u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
        u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
        u_xlat39 = sqrt(u_xlat39);
        u_xlat10_4.xyz = texture(_CameraDepthBlendNormTexture, u_xlat3.xy).xyz;
        u_xlat16_1.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat10_3.xyz = texture(_CameraDepthBlendDiffTexture, u_xlat3.xy).xyz;
        u_xlat16_41 = u_xlat0.y * _DepthBlendAO;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
        u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
        u_xlat42 = (-u_xlat39) + 1.0;
        u_xlat42 = u_xlat16_41 * u_xlat42 + u_xlat39;
        u_xlat42 = max(u_xlat42, 0.899999976);
        u_xlat4.xyz = u_xlat16_2.xyz * vec3(u_xlat42) + (-u_xlat10_3.xyz);
        u_xlat2.xyz = vec3(u_xlat39) * u_xlat4.xyz + u_xlat10_3.xyz;
        u_xlat3.xyz = u_xlat0.xyz + (-u_xlat16_1.xyz);
        u_xlat3.xyz = vec3(u_xlat39) * u_xlat3.xyz + u_xlat16_1.xyz;
        u_xlat16_2.xyz = u_xlat2.xyz;
        u_xlat16_3.xyz = u_xlat3.xyz;
    } else {
        u_xlat16_3.xyz = u_xlat0.xyz;
    //ENDIF
    }
    u_xlat16_1.x = u_xlat16_40 * _Terrain_Smoothness;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    SV_Target2.w = min(u_xlat16_1.x, 0.5);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(vec3(_Terrain_Specular, _Terrain_Specular, _Terrain_Specular));
    u_xlat16_0.x = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_40 = max(u_xlat16_1.z, u_xlat16_1.y);
    u_xlat16_40 = max(u_xlat16_40, u_xlat16_1.x);
    u_xlat16_40 = (-u_xlat16_40) + 1.0;
    SV_Target1.xyz = vec3(u_xlat16_40) * u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_40 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_40 : u_xlat16_1.z;
    SV_Target0.w = 0.0;
    SV_Target1.w = _SSAO_Intensity;
    SV_Target2.xy = u_xlat16_1.xy;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _Diffuse1_ST;
uniform 	float _UVDiffuse2;
uniform 	vec4 _Diffuse2_ST;
uniform 	float _UVDetail;
uniform 	vec4 _DetailDiffuse_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec2 u_xlat12;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat15 = u_xlat15 + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat15 = u_xlat15 + u_xlat2.x;
    u_xlat15 = u_xlat15 * 0.330000013;
    u_xlat2.xy = vec2(u_xlat15) * in_TEXCOORD0.xy;
    u_xlat12.xy = vec2(u_xlat15) * in_TEXCOORD1.xy;
    vs_TEXCOORD0.xy = u_xlat2.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Diffuse1_ST.xy + _Diffuse1_ST.zw;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat15 * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UVDiffuse2==0.0);
#else
    u_xlatb15 = _UVDiffuse2==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat2.xy : u_xlat12.xy;
    vs_TEXCOORD2.xy = u_xlat1.xy * _Diffuse2_ST.xy + _Diffuse2_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UVDetail==0.0);
#else
    u_xlatb15 = _UVDetail==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat2.xy : u_xlat12.xy;
    vs_TEXCOORD2.zw = u_xlat1.xy * _DetailDiffuse_ST.xy + _DetailDiffuse_ST.zw;
    vs_TEXCOORD3.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz;
    vs_TEXCOORD3.y = u_xlat16_4.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat0.y;
    vs_TEXCOORD5.w = u_xlat0.z;
    vs_TEXCOORD4.y = u_xlat16_4.y;
    vs_TEXCOORD5.y = u_xlat16_4.z;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump float _HeightSpread;
uniform 	mediump float _HeightContrast;
uniform 	mediump float _UseTintColor;
uniform 	mediump float _UseDiffuseOneHeight;
uniform 	mediump float _UseDiffuseTwoHeight;
uniform 	mediump float _UseDetailDiffuseHeight;
uniform 	mediump float _UseGrassHeightBlend;
uniform 	mediump float _UseGrassSpecular;
uniform 	mediump float _UseSpecularOne;
uniform 	mediump float _UseSpecularTwo;
uniform 	mediump float _UseDetailSpecular;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _SSAO_Intensity;
uniform 	mediump float _Terrain_Smoothness;
uniform 	mediump float _Terrain_Specular;
uniform 	mediump float _Shininess;
uniform 	mediump float _Diffuse2Distance;
uniform 	mediump float _Diffuse2Fade;
uniform 	mediump float _DetailNormalUVScale;
uniform 	mediump float _DetailBlendVal;
uniform 	mediump float _DetailDistance;
uniform 	mediump float _DetailFade;
uniform 	mediump float _DepthBiasScaled;
uniform 	mediump float _DepthBlendAO;
uniform lowp sampler2D _GrassNormal;
uniform lowp sampler2D _GrassDiffuse;
uniform lowp sampler2D _Normal0;
uniform lowp sampler2D _Normal2;
uniform lowp sampler2D _Diffuse1;
uniform lowp sampler2D _DetailNormal;
uniform lowp sampler2D _Diffuse2;
uniform lowp sampler2D _DetailDiffuse;
uniform highp sampler2D _CameraDepthBlendTexture;
uniform lowp sampler2D _CameraDepthBlendNormTexture;
uniform lowp sampler2D _CameraDepthBlendDiffTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_6;
mediump vec4 u_xlat16_7;
lowp vec4 u_xlat10_8;
lowp vec4 u_xlat10_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
mediump vec3 u_xlat16_12;
float u_xlat13;
mediump float u_xlat16_13;
vec2 u_xlat26;
mediump float u_xlat16_26;
mediump vec2 u_xlat16_31;
mediump float u_xlat16_33;
float u_xlat39;
bool u_xlatb39;
mediump float u_xlat16_40;
mediump float u_xlat16_41;
float u_xlat42;
mediump float u_xlat16_44;
mediump float u_xlat16_46;
mediump float u_xlat16_49;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_COLOR0.w<0.99000001);
#else
    u_xlatb0 = vs_COLOR0.w<0.99000001;
#endif
    if(u_xlatb0){
        u_xlat10_0 = texture(_GrassNormal, vs_TEXCOORD0.xy);
        u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_40 = u_xlat10_0.w * _UseGrassSpecular;
        u_xlat10_0.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.xy).xyz;
        u_xlat16_2.xyz = u_xlat10_0.xyz;
    } else {
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
        u_xlat16_1.x = float(0.0);
        u_xlat16_1.y = float(0.0);
        u_xlat16_1.z = float(1.0);
        u_xlat16_40 = float(0.0);
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.00999999978<vs_COLOR0.w);
#else
    u_xlatb0 = 0.00999999978<vs_COLOR0.w;
#endif
    if(u_xlatb0){
        u_xlat0.x = vs_TEXCOORD3.w;
        u_xlat0.y = vs_TEXCOORD4.w;
        u_xlat0.z = vs_TEXCOORD5.w;
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat13 = u_xlat0.x / _Diffuse2Distance;
#ifdef UNITY_ADRENO_ES3
        u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
        u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
        u_xlat13 = u_xlat13 + 9.99999975e-05;
        u_xlat13 = log2(u_xlat13);
        u_xlat13 = u_xlat13 * _Diffuse2Fade;
        u_xlat0.y = exp2(u_xlat13);
        u_xlat0.x = u_xlat0.x / _DetailDistance;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = u_xlat0.x + 9.99999975e-05;
        u_xlat0.x = log2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * _DetailFade;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat0.xy = min(u_xlat0.xy, vec2(1.0, 1.0));
        u_xlat10_3.xyz = texture(_Normal0, vs_TEXCOORD0.zw).xyw;
        u_xlat10_4.xyz = texture(_Normal2, vs_TEXCOORD2.xy).xyw;
        u_xlat16_5.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_31.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_41 = (-u_xlat0.y) + 1.0;
        u_xlat16_31.xy = vec2(u_xlat16_41) * u_xlat16_31.xy;
        u_xlat10_6 = texture(_Diffuse1, vs_TEXCOORD0.zw);
        u_xlat26.xy = vec2(vs_TEXCOORD2.z * float(_DetailNormalUVScale), vs_TEXCOORD2.w * float(_DetailNormalUVScale));
        u_xlat10_3.xyw = texture(_DetailNormal, u_xlat26.xy).xyw;
        u_xlat16_7.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_41 = (-u_xlat0.x) + 1.0;
        u_xlat16_7.xy = vec2(u_xlat16_41) * u_xlat16_7.xy;
        u_xlat10_8 = texture(_Diffuse2, vs_TEXCOORD2.xy);
        u_xlat10_9 = texture(_DetailDiffuse, vs_TEXCOORD2.zw);
        u_xlat16_41 = u_xlat10_8.w * _UseDiffuseTwoHeight;
        u_xlat16_33 = u_xlat10_9.w * _UseDetailDiffuseHeight;
        u_xlat16_10.xyz = u_xlat10_6.xyz + (-u_xlat10_8.xyz);
        u_xlat16_46 = u_xlat10_6.w * _UseDiffuseOneHeight + (-u_xlat16_41);
        u_xlat16_10.xyz = u_xlat0.yyy * u_xlat16_10.xyz + u_xlat10_8.xyz;
        u_xlat16_41 = u_xlat0.y * u_xlat16_46 + u_xlat16_41;
        u_xlat16_46 = u_xlat0.x * _DetailBlendVal;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_46 = min(max(u_xlat16_46, 0.0), 1.0);
#else
        u_xlat16_46 = clamp(u_xlat16_46, 0.0, 1.0);
#endif
        u_xlat16_49 = (-u_xlat16_46) + 1.0;
        u_xlat16_33 = u_xlat16_33 * u_xlat16_49;
        u_xlat16_41 = max(u_xlat16_41, u_xlat16_33);
        u_xlat16_11.xyz = u_xlat10_9.xyz * u_xlat16_10.xyz;
        u_xlat16_12.xyz = u_xlat16_11.xyz * vec3(4.0, 4.0, 4.0);
        u_xlat16_10.xyz = (-u_xlat16_11.xyz) * vec3(4.0, 4.0, 4.0) + u_xlat16_10.xyz;
        u_xlat16_10.xyz = vec3(u_xlat16_46) * u_xlat16_10.xyz + u_xlat16_12.xyz;
        u_xlat16_10.xyz = min(u_xlat16_10.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_33 = u_xlat10_4.z * _UseSpecularTwo;
        u_xlat16_46 = u_xlat10_3.w * _UseDetailSpecular;
        u_xlat16_11.x = _UseSpecularOne * u_xlat10_3.z + (-u_xlat16_33);
        u_xlat16_33 = u_xlat0.y * u_xlat16_11.x + u_xlat16_33;
        u_xlat16_46 = u_xlat16_49 * u_xlat16_46;
        u_xlat16_33 = max(u_xlat16_46, u_xlat16_33);
        u_xlat16_5.xy = u_xlat16_31.xy * vs_COLOR0.xx + u_xlat16_5.xy;
        u_xlat16_5.xy = u_xlat16_7.xy * vs_COLOR0.xx + u_xlat16_5.xy;
    } else {
        u_xlat16_10.x = float(0.0);
        u_xlat16_10.y = float(0.0);
        u_xlat16_10.z = float(0.0);
        u_xlat16_5.x = float(0.0);
        u_xlat16_5.y = float(0.0);
        u_xlat16_41 = 1.0;
        u_xlat16_33 = 0.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor);
#endif
    u_xlat16_7.xyw = u_xlat16_10.xyz * _TintColor.xyz;
    u_xlat16_7.xyw = (bool(u_xlatb0)) ? u_xlat16_7.xyw : u_xlat16_10.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend);
#endif
    u_xlat16_13 = u_xlat16_41;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_26 = vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_41 = _HeightContrast * 10.0;
    u_xlat16_13 = u_xlat16_13 + -1.0;
    u_xlat16_44 = _HeightSpread + 0.100000001;
    u_xlat16_26 = log2(u_xlat16_26);
    u_xlat16_26 = u_xlat16_26 * u_xlat16_44;
    u_xlat16_26 = exp2(u_xlat16_26);
    u_xlat16_13 = u_xlat16_26 * 2.0 + u_xlat16_13;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_26 = _HeightContrast * 10.0 + 1.0;
    u_xlat16_26 = _HeightContrast * 10.0 + u_xlat16_26;
    u_xlat13 = u_xlat16_13 * u_xlat16_26 + (-u_xlat16_41);
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat16_41 = (u_xlatb0) ? u_xlat13 : vs_COLOR0.w;
    u_xlat16_5.z = 1.0;
    u_xlat16_5.xyz = (-u_xlat16_1.xyz) + u_xlat16_5.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_41) * u_xlat16_5.xyz + u_xlat16_1.xyz;
    u_xlat16_5.x = (-u_xlat16_40) + u_xlat16_33;
    u_xlat16_40 = u_xlat16_41 * u_xlat16_5.x + u_xlat16_40;
    u_xlat16_5.xyz = (-u_xlat16_2.xyz) + u_xlat16_7.xyw;
    u_xlat16_2.xyz = vec3(u_xlat16_41) * u_xlat16_5.xyz + u_xlat16_2.xyz;
    u_xlat16_40 = u_xlat16_40 + _Shininess;
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD5.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!(vs_TEXCOORD1.w<100.0);
#else
    u_xlatb39 = vs_TEXCOORD1.w<100.0;
#endif
    if(u_xlatb39){
        u_xlat3.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
        u_xlat39 = texture(_CameraDepthBlendTexture, u_xlat3.xy).x;
        u_xlat39 = _ZBufferParams.z * u_xlat39 + _ZBufferParams.w;
        u_xlat39 = float(1.0) / u_xlat39;
        u_xlat39 = u_xlat39 + (-vs_TEXCOORD1.w);
        u_xlat39 = abs(u_xlat39) * _DepthBiasScaled;
        u_xlat39 = u_xlat39 * 0.600000024;
#ifdef UNITY_ADRENO_ES3
        u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
        u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
        u_xlat39 = sqrt(u_xlat39);
        u_xlat10_4.xyz = texture(_CameraDepthBlendNormTexture, u_xlat3.xy).xyz;
        u_xlat16_1.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat10_3.xyz = texture(_CameraDepthBlendDiffTexture, u_xlat3.xy).xyz;
        u_xlat16_41 = u_xlat0.y * _DepthBlendAO;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
        u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
        u_xlat42 = (-u_xlat39) + 1.0;
        u_xlat42 = u_xlat16_41 * u_xlat42 + u_xlat39;
        u_xlat42 = max(u_xlat42, 0.899999976);
        u_xlat4.xyz = u_xlat16_2.xyz * vec3(u_xlat42) + (-u_xlat10_3.xyz);
        u_xlat2.xyz = vec3(u_xlat39) * u_xlat4.xyz + u_xlat10_3.xyz;
        u_xlat3.xyz = u_xlat0.xyz + (-u_xlat16_1.xyz);
        u_xlat3.xyz = vec3(u_xlat39) * u_xlat3.xyz + u_xlat16_1.xyz;
        u_xlat16_2.xyz = u_xlat2.xyz;
        u_xlat16_3.xyz = u_xlat3.xyz;
    } else {
        u_xlat16_3.xyz = u_xlat0.xyz;
    //ENDIF
    }
    u_xlat16_1.x = u_xlat16_40 * _Terrain_Smoothness;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    SV_Target2.w = min(u_xlat16_1.x, 0.5);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(vec3(_Terrain_Specular, _Terrain_Specular, _Terrain_Specular));
    u_xlat16_0.x = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_40 = max(u_xlat16_1.z, u_xlat16_1.y);
    u_xlat16_40 = max(u_xlat16_40, u_xlat16_1.x);
    u_xlat16_40 = (-u_xlat16_40) + 1.0;
    SV_Target1.xyz = vec3(u_xlat16_40) * u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_40 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_40 : u_xlat16_1.z;
    SV_Target0.w = 0.0;
    SV_Target1.w = _SSAO_Intensity;
    SV_Target2.xy = u_xlat16_1.xy;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _Diffuse1_ST;
uniform 	float _UVDiffuse2;
uniform 	vec4 _Diffuse2_ST;
uniform 	float _UVDetail;
uniform 	vec4 _DetailDiffuse_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat7;
float u_xlat16;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x;
    u_xlat2.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].x;
    u_xlat2.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].x;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].y;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].y;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].y;
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.xy = sqrt(u_xlat2.xy);
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].z;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].z;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].z;
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat2.x = u_xlat7.x + u_xlat2.x;
    u_xlat2.x = u_xlat2.x * 0.330000013;
    u_xlat7.xy = u_xlat2.xx * in_TEXCOORD0.xy;
    u_xlat2.xw = u_xlat2.xx * in_TEXCOORD1.xy;
    vs_TEXCOORD0.xy = u_xlat7.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Diffuse1_ST.xy + _Diffuse1_ST.zw;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UVDiffuse2==0.0);
#else
    u_xlatb1 = _UVDiffuse2==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb1)) ? u_xlat7.xy : u_xlat2.xw;
    vs_TEXCOORD2.xy = u_xlat1.xy * _Diffuse2_ST.xy + _Diffuse2_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UVDetail==0.0);
#else
    u_xlatb1 = _UVDetail==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb1)) ? u_xlat7.xy : u_xlat2.xw;
    vs_TEXCOORD2.zw = u_xlat1.xy * _DetailDiffuse_ST.xy + _DetailDiffuse_ST.zw;
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat2.xyz = vec3(u_xlat0) * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_4.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = vec3(u_xlat0) * u_xlat16_4.xyz;
    vs_TEXCOORD3.y = u_xlat16_4.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD3.w = u_xlat5.x;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat5.y;
    vs_TEXCOORD5.w = u_xlat5.z;
    vs_TEXCOORD4.y = u_xlat16_4.y;
    vs_TEXCOORD5.y = u_xlat16_4.z;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump float _HeightSpread;
uniform 	mediump float _HeightContrast;
uniform 	mediump float _UseTintColor;
uniform 	mediump float _UseDiffuseOneHeight;
uniform 	mediump float _UseDiffuseTwoHeight;
uniform 	mediump float _UseDetailDiffuseHeight;
uniform 	mediump float _UseGrassHeightBlend;
uniform 	mediump float _UseGrassSpecular;
uniform 	mediump float _UseSpecularOne;
uniform 	mediump float _UseSpecularTwo;
uniform 	mediump float _UseDetailSpecular;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _SSAO_Intensity;
uniform 	mediump float _Terrain_Smoothness;
uniform 	mediump float _Terrain_Specular;
uniform 	mediump float _Shininess;
uniform 	float _GrassNormalScale;
uniform 	float _Normal0Scale;
uniform 	mediump float _Normal2Scale;
uniform 	mediump float _Diffuse2Distance;
uniform 	mediump float _Diffuse2Fade;
uniform 	mediump float _DetailNormalScale;
uniform 	mediump float _DetailNormalUVScale;
uniform 	mediump float _DetailBlendVal;
uniform 	mediump float _DetailDistance;
uniform 	mediump float _DetailFade;
uniform 	mediump float _DepthBiasScaled;
uniform 	mediump float _DepthBlendAO;
uniform lowp sampler2D _GrassNormal;
uniform lowp sampler2D _GrassDiffuse;
uniform lowp sampler2D _Normal0;
uniform lowp sampler2D _Normal2;
uniform lowp sampler2D _Diffuse1;
uniform lowp sampler2D _DetailNormal;
uniform lowp sampler2D _Diffuse2;
uniform lowp sampler2D _DetailDiffuse;
uniform highp sampler2D _CameraDepthBlendTexture;
uniform lowp sampler2D _CameraDepthBlendNormTexture;
uniform lowp sampler2D _CameraDepthBlendDiffTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_6;
mediump vec4 u_xlat16_7;
lowp vec4 u_xlat10_8;
lowp vec4 u_xlat10_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
mediump vec3 u_xlat16_12;
float u_xlat13;
mediump float u_xlat16_13;
vec2 u_xlat26;
mediump float u_xlat16_26;
mediump vec2 u_xlat16_31;
mediump float u_xlat16_33;
float u_xlat39;
bool u_xlatb39;
mediump float u_xlat16_40;
mediump float u_xlat16_41;
float u_xlat42;
mediump float u_xlat16_44;
mediump float u_xlat16_46;
mediump float u_xlat16_49;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_COLOR0.w<0.99000001);
#else
    u_xlatb0 = vs_COLOR0.w<0.99000001;
#endif
    if(u_xlatb0){
        u_xlat10_0 = texture(_GrassNormal, vs_TEXCOORD0.xy);
        u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_1.xy = u_xlat16_1.xy * vec2(_GrassNormalScale);
        u_xlat16_40 = u_xlat10_0.w * _UseGrassSpecular;
        u_xlat10_0.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.xy).xyz;
        u_xlat16_2.xyz = u_xlat10_0.xyz;
    } else {
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
        u_xlat16_1.x = float(0.0);
        u_xlat16_1.y = float(0.0);
        u_xlat16_1.z = float(1.0);
        u_xlat16_40 = float(0.0);
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.00999999978<vs_COLOR0.w);
#else
    u_xlatb0 = 0.00999999978<vs_COLOR0.w;
#endif
    if(u_xlatb0){
        u_xlat0.x = vs_TEXCOORD3.w;
        u_xlat0.y = vs_TEXCOORD4.w;
        u_xlat0.z = vs_TEXCOORD5.w;
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat13 = u_xlat0.x / _Diffuse2Distance;
#ifdef UNITY_ADRENO_ES3
        u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
        u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
        u_xlat13 = u_xlat13 + 9.99999975e-05;
        u_xlat13 = log2(u_xlat13);
        u_xlat13 = u_xlat13 * _Diffuse2Fade;
        u_xlat0.y = exp2(u_xlat13);
        u_xlat0.x = u_xlat0.x / _DetailDistance;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = u_xlat0.x + 9.99999975e-05;
        u_xlat0.x = log2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * _DetailFade;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat0.xy = min(u_xlat0.xy, vec2(1.0, 1.0));
        u_xlat10_3.xyz = texture(_Normal0, vs_TEXCOORD0.zw).xyw;
        u_xlat10_4.xyz = texture(_Normal2, vs_TEXCOORD2.xy).xyw;
        u_xlat16_5.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_31.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_31.xy = u_xlat16_31.xy * vec2(_Normal2Scale);
        u_xlat16_41 = (-u_xlat0.y) + 1.0;
        u_xlat16_31.xy = vec2(u_xlat16_41) * u_xlat16_31.xy;
        u_xlat16_31.xy = u_xlat16_31.xy * vs_COLOR0.xx;
        u_xlat10_6 = texture(_Diffuse1, vs_TEXCOORD0.zw);
        u_xlat26.xy = vec2(vs_TEXCOORD2.z * float(_DetailNormalUVScale), vs_TEXCOORD2.w * float(_DetailNormalUVScale));
        u_xlat10_3.xyw = texture(_DetailNormal, u_xlat26.xy).xyw;
        u_xlat16_7.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_7.xy = u_xlat16_7.xy * vec2(_DetailNormalScale);
        u_xlat16_41 = (-u_xlat0.x) + 1.0;
        u_xlat16_7.xy = vec2(u_xlat16_41) * u_xlat16_7.xy;
        u_xlat10_8 = texture(_Diffuse2, vs_TEXCOORD2.xy);
        u_xlat10_9 = texture(_DetailDiffuse, vs_TEXCOORD2.zw);
        u_xlat16_41 = u_xlat10_8.w * _UseDiffuseTwoHeight;
        u_xlat16_33 = u_xlat10_9.w * _UseDetailDiffuseHeight;
        u_xlat16_10.xyz = u_xlat10_6.xyz + (-u_xlat10_8.xyz);
        u_xlat16_46 = u_xlat10_6.w * _UseDiffuseOneHeight + (-u_xlat16_41);
        u_xlat16_10.xyz = u_xlat0.yyy * u_xlat16_10.xyz + u_xlat10_8.xyz;
        u_xlat16_41 = u_xlat0.y * u_xlat16_46 + u_xlat16_41;
        u_xlat16_46 = u_xlat0.x * _DetailBlendVal;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_46 = min(max(u_xlat16_46, 0.0), 1.0);
#else
        u_xlat16_46 = clamp(u_xlat16_46, 0.0, 1.0);
#endif
        u_xlat16_49 = (-u_xlat16_46) + 1.0;
        u_xlat16_33 = u_xlat16_33 * u_xlat16_49;
        u_xlat16_41 = max(u_xlat16_41, u_xlat16_33);
        u_xlat16_11.xyz = u_xlat10_9.xyz * u_xlat16_10.xyz;
        u_xlat16_12.xyz = u_xlat16_11.xyz * vec3(4.0, 4.0, 4.0);
        u_xlat16_10.xyz = (-u_xlat16_11.xyz) * vec3(4.0, 4.0, 4.0) + u_xlat16_10.xyz;
        u_xlat16_10.xyz = vec3(u_xlat16_46) * u_xlat16_10.xyz + u_xlat16_12.xyz;
        u_xlat16_10.xyz = min(u_xlat16_10.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_33 = u_xlat10_4.z * _UseSpecularTwo;
        u_xlat16_46 = u_xlat10_3.w * _UseDetailSpecular;
        u_xlat16_11.x = _UseSpecularOne * u_xlat10_3.z + (-u_xlat16_33);
        u_xlat16_33 = u_xlat0.y * u_xlat16_11.x + u_xlat16_33;
        u_xlat16_46 = u_xlat16_49 * u_xlat16_46;
        u_xlat16_33 = max(u_xlat16_46, u_xlat16_33);
        u_xlat16_5.xy = u_xlat16_5.xy * vec2(_Normal0Scale) + u_xlat16_31.xy;
        u_xlat16_5.xy = u_xlat16_7.xy * vs_COLOR0.xx + u_xlat16_5.xy;
    } else {
        u_xlat16_10.x = float(0.0);
        u_xlat16_10.y = float(0.0);
        u_xlat16_10.z = float(0.0);
        u_xlat16_5.x = float(0.0);
        u_xlat16_5.y = float(0.0);
        u_xlat16_41 = 1.0;
        u_xlat16_33 = 0.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor);
#endif
    u_xlat16_7.xyw = u_xlat16_10.xyz * _TintColor.xyz;
    u_xlat16_7.xyw = (bool(u_xlatb0)) ? u_xlat16_7.xyw : u_xlat16_10.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend);
#endif
    u_xlat16_13 = u_xlat16_41;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_26 = vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_41 = _HeightContrast * 10.0;
    u_xlat16_13 = u_xlat16_13 + -1.0;
    u_xlat16_44 = _HeightSpread + 0.100000001;
    u_xlat16_26 = log2(u_xlat16_26);
    u_xlat16_26 = u_xlat16_26 * u_xlat16_44;
    u_xlat16_26 = exp2(u_xlat16_26);
    u_xlat16_13 = u_xlat16_26 * 2.0 + u_xlat16_13;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_26 = _HeightContrast * 10.0 + 1.0;
    u_xlat16_26 = _HeightContrast * 10.0 + u_xlat16_26;
    u_xlat13 = u_xlat16_13 * u_xlat16_26 + (-u_xlat16_41);
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat16_41 = (u_xlatb0) ? u_xlat13 : vs_COLOR0.w;
    u_xlat16_5.z = 1.0;
    u_xlat16_5.xyz = (-u_xlat16_1.xyz) + u_xlat16_5.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_41) * u_xlat16_5.xyz + u_xlat16_1.xyz;
    u_xlat16_5.x = (-u_xlat16_40) + u_xlat16_33;
    u_xlat16_40 = u_xlat16_41 * u_xlat16_5.x + u_xlat16_40;
    u_xlat16_5.xyz = (-u_xlat16_2.xyz) + u_xlat16_7.xyw;
    u_xlat16_2.xyz = vec3(u_xlat16_41) * u_xlat16_5.xyz + u_xlat16_2.xyz;
    u_xlat16_40 = u_xlat16_40 + _Shininess;
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD5.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!(vs_TEXCOORD1.w<100.0);
#else
    u_xlatb39 = vs_TEXCOORD1.w<100.0;
#endif
    if(u_xlatb39){
        u_xlat3.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
        u_xlat39 = texture(_CameraDepthBlendTexture, u_xlat3.xy).x;
        u_xlat39 = _ZBufferParams.z * u_xlat39 + _ZBufferParams.w;
        u_xlat39 = float(1.0) / u_xlat39;
        u_xlat39 = u_xlat39 + (-vs_TEXCOORD1.w);
        u_xlat39 = abs(u_xlat39) * _DepthBiasScaled;
        u_xlat39 = u_xlat39 * 0.600000024;
#ifdef UNITY_ADRENO_ES3
        u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
        u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
        u_xlat39 = sqrt(u_xlat39);
        u_xlat10_4.xyz = texture(_CameraDepthBlendNormTexture, u_xlat3.xy).xyz;
        u_xlat16_1.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat10_3.xyz = texture(_CameraDepthBlendDiffTexture, u_xlat3.xy).xyz;
        u_xlat16_41 = u_xlat0.y * _DepthBlendAO;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
        u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
        u_xlat42 = (-u_xlat39) + 1.0;
        u_xlat42 = u_xlat16_41 * u_xlat42 + u_xlat39;
        u_xlat42 = max(u_xlat42, 0.899999976);
        u_xlat4.xyz = u_xlat16_2.xyz * vec3(u_xlat42) + (-u_xlat10_3.xyz);
        u_xlat2.xyz = vec3(u_xlat39) * u_xlat4.xyz + u_xlat10_3.xyz;
        u_xlat3.xyz = u_xlat0.xyz + (-u_xlat16_1.xyz);
        u_xlat3.xyz = vec3(u_xlat39) * u_xlat3.xyz + u_xlat16_1.xyz;
        u_xlat16_2.xyz = u_xlat2.xyz;
        u_xlat16_3.xyz = u_xlat3.xyz;
    } else {
        u_xlat16_3.xyz = u_xlat0.xyz;
    //ENDIF
    }
    u_xlat16_1.x = u_xlat16_40 * _Terrain_Smoothness;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    SV_Target2.w = min(u_xlat16_1.x, 0.5);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(vec3(_Terrain_Specular, _Terrain_Specular, _Terrain_Specular));
    u_xlat16_0.x = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_40 = max(u_xlat16_1.z, u_xlat16_1.y);
    u_xlat16_40 = max(u_xlat16_40, u_xlat16_1.x);
    u_xlat16_40 = (-u_xlat16_40) + 1.0;
    SV_Target1.xyz = vec3(u_xlat16_40) * u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_40 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_40 : u_xlat16_1.z;
    SV_Target0.w = 0.0;
    SV_Target1.w = _SSAO_Intensity;
    SV_Target2.xy = u_xlat16_1.xy;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "LINE_INTERPOLATION" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _Diffuse1_ST;
uniform 	float _UVDiffuse2;
uniform 	vec4 _Diffuse2_ST;
uniform 	float _UVDetail;
uniform 	vec4 _DetailDiffuse_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec2 u_xlat12;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat15 = u_xlat15 + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat15 = u_xlat15 + u_xlat2.x;
    u_xlat15 = u_xlat15 * 0.330000013;
    u_xlat2.xy = vec2(u_xlat15) * in_TEXCOORD0.xy;
    u_xlat12.xy = vec2(u_xlat15) * in_TEXCOORD1.xy;
    vs_TEXCOORD0.xy = u_xlat2.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Diffuse1_ST.xy + _Diffuse1_ST.zw;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat15 * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UVDiffuse2==0.0);
#else
    u_xlatb15 = _UVDiffuse2==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat2.xy : u_xlat12.xy;
    vs_TEXCOORD2.xy = u_xlat1.xy * _Diffuse2_ST.xy + _Diffuse2_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UVDetail==0.0);
#else
    u_xlatb15 = _UVDetail==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat2.xy : u_xlat12.xy;
    vs_TEXCOORD2.zw = u_xlat1.xy * _DetailDiffuse_ST.xy + _DetailDiffuse_ST.zw;
    vs_TEXCOORD3.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz;
    vs_TEXCOORD3.y = u_xlat16_4.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat0.y;
    vs_TEXCOORD5.w = u_xlat0.z;
    vs_TEXCOORD4.y = u_xlat16_4.y;
    vs_TEXCOORD5.y = u_xlat16_4.z;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump float _HeightSpread;
uniform 	mediump float _HeightContrast;
uniform 	mediump float _UseTintColor;
uniform 	mediump float _UseDiffuseOneHeight;
uniform 	mediump float _UseDiffuseTwoHeight;
uniform 	mediump float _UseDetailDiffuseHeight;
uniform 	mediump float _UseGrassHeightBlend;
uniform 	mediump float _UseGrassSpecular;
uniform 	mediump float _UseSpecularOne;
uniform 	mediump float _UseSpecularTwo;
uniform 	mediump float _UseDetailSpecular;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _SSAO_Intensity;
uniform 	mediump float _Terrain_Smoothness;
uniform 	mediump float _Terrain_Specular;
uniform 	mediump float _Shininess;
uniform 	mediump float _Diffuse2Distance;
uniform 	mediump float _Diffuse2Fade;
uniform 	mediump float _DetailNormalUVScale;
uniform 	mediump float _DetailBlendVal;
uniform 	mediump float _DetailDistance;
uniform 	mediump float _DetailFade;
uniform 	mediump float _DepthBiasScaled;
uniform 	mediump float _DepthBlendAO;
uniform lowp sampler2D _GrassNormal;
uniform lowp sampler2D _GrassDiffuse;
uniform lowp sampler2D _Normal0;
uniform lowp sampler2D _Normal2;
uniform lowp sampler2D _Diffuse1;
uniform lowp sampler2D _DetailNormal;
uniform lowp sampler2D _Diffuse2;
uniform lowp sampler2D _DetailDiffuse;
uniform highp sampler2D _CameraDepthBlendTexture;
uniform lowp sampler2D _CameraDepthBlendNormTexture;
uniform lowp sampler2D _CameraDepthBlendDiffTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_6;
mediump vec4 u_xlat16_7;
lowp vec4 u_xlat10_8;
lowp vec4 u_xlat10_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
mediump vec3 u_xlat16_12;
float u_xlat13;
mediump float u_xlat16_13;
vec2 u_xlat26;
mediump float u_xlat16_26;
mediump vec2 u_xlat16_31;
mediump float u_xlat16_33;
float u_xlat39;
bool u_xlatb39;
mediump float u_xlat16_40;
mediump float u_xlat16_41;
float u_xlat42;
mediump float u_xlat16_44;
mediump float u_xlat16_46;
mediump float u_xlat16_49;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_COLOR0.w<0.99000001);
#else
    u_xlatb0 = vs_COLOR0.w<0.99000001;
#endif
    if(u_xlatb0){
        u_xlat10_0 = texture(_GrassNormal, vs_TEXCOORD0.xy, -1.0);
        u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_40 = u_xlat10_0.w * _UseGrassSpecular;
        u_xlat10_0.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.xy, -1.0).xyz;
        u_xlat16_2.xyz = u_xlat10_0.xyz;
    } else {
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
        u_xlat16_1.x = float(0.0);
        u_xlat16_1.y = float(0.0);
        u_xlat16_1.z = float(1.0);
        u_xlat16_40 = float(0.0);
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.00999999978<vs_COLOR0.w);
#else
    u_xlatb0 = 0.00999999978<vs_COLOR0.w;
#endif
    if(u_xlatb0){
        u_xlat0.x = vs_TEXCOORD3.w;
        u_xlat0.y = vs_TEXCOORD4.w;
        u_xlat0.z = vs_TEXCOORD5.w;
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat13 = u_xlat0.x / _Diffuse2Distance;
#ifdef UNITY_ADRENO_ES3
        u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
        u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
        u_xlat13 = u_xlat13 + 9.99999975e-05;
        u_xlat13 = log2(u_xlat13);
        u_xlat13 = u_xlat13 * _Diffuse2Fade;
        u_xlat0.y = exp2(u_xlat13);
        u_xlat0.x = u_xlat0.x / _DetailDistance;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = u_xlat0.x + 9.99999975e-05;
        u_xlat0.x = log2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * _DetailFade;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat0.xy = min(u_xlat0.xy, vec2(1.0, 1.0));
        u_xlat10_3.xyz = texture(_Normal0, vs_TEXCOORD0.zw, -1.0).xyw;
        u_xlat10_4.xyz = texture(_Normal2, vs_TEXCOORD2.xy, -1.0).xyw;
        u_xlat16_5.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_31.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_41 = (-u_xlat0.y) + 1.0;
        u_xlat16_31.xy = vec2(u_xlat16_41) * u_xlat16_31.xy;
        u_xlat10_6 = texture(_Diffuse1, vs_TEXCOORD0.zw, -1.0);
        u_xlat26.xy = vec2(vs_TEXCOORD2.z * float(_DetailNormalUVScale), vs_TEXCOORD2.w * float(_DetailNormalUVScale));
        u_xlat10_3.xyw = texture(_DetailNormal, u_xlat26.xy, -1.0).xyw;
        u_xlat16_7.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_41 = (-u_xlat0.x) + 1.0;
        u_xlat16_7.xy = vec2(u_xlat16_41) * u_xlat16_7.xy;
        u_xlat10_8 = texture(_Diffuse2, vs_TEXCOORD2.xy, -1.0);
        u_xlat10_9 = texture(_DetailDiffuse, vs_TEXCOORD2.zw, -1.0);
        u_xlat16_41 = u_xlat10_8.w * _UseDiffuseTwoHeight;
        u_xlat16_33 = u_xlat10_9.w * _UseDetailDiffuseHeight;
        u_xlat16_10.xyz = u_xlat10_6.xyz + (-u_xlat10_8.xyz);
        u_xlat16_46 = u_xlat10_6.w * _UseDiffuseOneHeight + (-u_xlat16_41);
        u_xlat16_10.xyz = u_xlat0.yyy * u_xlat16_10.xyz + u_xlat10_8.xyz;
        u_xlat16_41 = u_xlat0.y * u_xlat16_46 + u_xlat16_41;
        u_xlat16_46 = u_xlat0.x * _DetailBlendVal;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_46 = min(max(u_xlat16_46, 0.0), 1.0);
#else
        u_xlat16_46 = clamp(u_xlat16_46, 0.0, 1.0);
#endif
        u_xlat16_49 = (-u_xlat16_46) + 1.0;
        u_xlat16_33 = u_xlat16_33 * u_xlat16_49;
        u_xlat16_41 = max(u_xlat16_41, u_xlat16_33);
        u_xlat16_11.xyz = u_xlat10_9.xyz * u_xlat16_10.xyz;
        u_xlat16_12.xyz = u_xlat16_11.xyz * vec3(4.0, 4.0, 4.0);
        u_xlat16_10.xyz = (-u_xlat16_11.xyz) * vec3(4.0, 4.0, 4.0) + u_xlat16_10.xyz;
        u_xlat16_10.xyz = vec3(u_xlat16_46) * u_xlat16_10.xyz + u_xlat16_12.xyz;
        u_xlat16_10.xyz = min(u_xlat16_10.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_33 = u_xlat10_4.z * _UseSpecularTwo;
        u_xlat16_46 = u_xlat10_3.w * _UseDetailSpecular;
        u_xlat16_11.x = _UseSpecularOne * u_xlat10_3.z + (-u_xlat16_33);
        u_xlat16_33 = u_xlat0.y * u_xlat16_11.x + u_xlat16_33;
        u_xlat16_46 = u_xlat16_49 * u_xlat16_46;
        u_xlat16_33 = max(u_xlat16_46, u_xlat16_33);
        u_xlat16_5.xy = u_xlat16_31.xy * vs_COLOR0.xx + u_xlat16_5.xy;
        u_xlat16_5.xy = u_xlat16_7.xy * vs_COLOR0.xx + u_xlat16_5.xy;
    } else {
        u_xlat16_10.x = float(0.0);
        u_xlat16_10.y = float(0.0);
        u_xlat16_10.z = float(0.0);
        u_xlat16_5.x = float(0.0);
        u_xlat16_5.y = float(0.0);
        u_xlat16_41 = 1.0;
        u_xlat16_33 = 0.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor);
#endif
    u_xlat16_7.xyw = u_xlat16_10.xyz * _TintColor.xyz;
    u_xlat16_7.xyw = (bool(u_xlatb0)) ? u_xlat16_7.xyw : u_xlat16_10.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend);
#endif
    u_xlat16_13 = u_xlat16_41;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_26 = vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_41 = _HeightContrast * 10.0;
    u_xlat16_13 = u_xlat16_13 + -1.0;
    u_xlat16_44 = _HeightSpread + 0.100000001;
    u_xlat16_26 = log2(u_xlat16_26);
    u_xlat16_26 = u_xlat16_26 * u_xlat16_44;
    u_xlat16_26 = exp2(u_xlat16_26);
    u_xlat16_13 = u_xlat16_26 * 2.0 + u_xlat16_13;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_26 = _HeightContrast * 10.0 + 1.0;
    u_xlat16_26 = _HeightContrast * 10.0 + u_xlat16_26;
    u_xlat13 = u_xlat16_13 * u_xlat16_26 + (-u_xlat16_41);
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat16_41 = (u_xlatb0) ? u_xlat13 : vs_COLOR0.w;
    u_xlat16_5.z = 1.0;
    u_xlat16_5.xyz = (-u_xlat16_1.xyz) + u_xlat16_5.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_41) * u_xlat16_5.xyz + u_xlat16_1.xyz;
    u_xlat16_5.x = (-u_xlat16_40) + u_xlat16_33;
    u_xlat16_40 = u_xlat16_41 * u_xlat16_5.x + u_xlat16_40;
    u_xlat16_5.xyz = (-u_xlat16_2.xyz) + u_xlat16_7.xyw;
    u_xlat16_2.xyz = vec3(u_xlat16_41) * u_xlat16_5.xyz + u_xlat16_2.xyz;
    u_xlat16_40 = u_xlat16_40 + _Shininess;
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD5.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!(vs_TEXCOORD1.w<100.0);
#else
    u_xlatb39 = vs_TEXCOORD1.w<100.0;
#endif
    if(u_xlatb39){
        u_xlat3.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
        u_xlat39 = texture(_CameraDepthBlendTexture, u_xlat3.xy).x;
        u_xlat39 = _ZBufferParams.z * u_xlat39 + _ZBufferParams.w;
        u_xlat39 = float(1.0) / u_xlat39;
        u_xlat39 = u_xlat39 + (-vs_TEXCOORD1.w);
        u_xlat39 = abs(u_xlat39) * _DepthBiasScaled;
        u_xlat39 = u_xlat39 * 0.600000024;
#ifdef UNITY_ADRENO_ES3
        u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
        u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
        u_xlat39 = sqrt(u_xlat39);
        u_xlat10_4.xyz = texture(_CameraDepthBlendNormTexture, u_xlat3.xy).xyz;
        u_xlat16_1.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat10_3.xyz = texture(_CameraDepthBlendDiffTexture, u_xlat3.xy).xyz;
        u_xlat16_41 = u_xlat0.y * _DepthBlendAO;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
        u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
        u_xlat42 = (-u_xlat39) + 1.0;
        u_xlat42 = u_xlat16_41 * u_xlat42 + u_xlat39;
        u_xlat42 = max(u_xlat42, 0.899999976);
        u_xlat4.xyz = u_xlat16_2.xyz * vec3(u_xlat42) + (-u_xlat10_3.xyz);
        u_xlat2.xyz = vec3(u_xlat39) * u_xlat4.xyz + u_xlat10_3.xyz;
        u_xlat3.xyz = u_xlat0.xyz + (-u_xlat16_1.xyz);
        u_xlat3.xyz = vec3(u_xlat39) * u_xlat3.xyz + u_xlat16_1.xyz;
        u_xlat16_2.xyz = u_xlat2.xyz;
        u_xlat16_3.xyz = u_xlat3.xyz;
    } else {
        u_xlat16_3.xyz = u_xlat0.xyz;
    //ENDIF
    }
    u_xlat16_1.x = u_xlat16_40 * _Terrain_Smoothness;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    SV_Target2.w = min(u_xlat16_1.x, 0.5);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(vec3(_Terrain_Specular, _Terrain_Specular, _Terrain_Specular));
    u_xlat16_0.x = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_40 = max(u_xlat16_1.z, u_xlat16_1.y);
    u_xlat16_40 = max(u_xlat16_40, u_xlat16_1.x);
    u_xlat16_40 = (-u_xlat16_40) + 1.0;
    SV_Target1.xyz = vec3(u_xlat16_40) * u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_40 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_40 : u_xlat16_1.z;
    SV_Target0.w = 0.0;
    SV_Target1.w = _SSAO_Intensity;
    SV_Target2.xy = u_xlat16_1.xy;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "LINE_INTERPOLATION" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _Diffuse1_ST;
uniform 	float _UVDiffuse2;
uniform 	vec4 _Diffuse2_ST;
uniform 	float _UVDetail;
uniform 	vec4 _DetailDiffuse_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat7;
float u_xlat16;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x;
    u_xlat2.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].x;
    u_xlat2.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].x;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].y;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].y;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].y;
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.xy = sqrt(u_xlat2.xy);
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].z;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].z;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].z;
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat2.x = u_xlat7.x + u_xlat2.x;
    u_xlat2.x = u_xlat2.x * 0.330000013;
    u_xlat7.xy = u_xlat2.xx * in_TEXCOORD0.xy;
    u_xlat2.xw = u_xlat2.xx * in_TEXCOORD1.xy;
    vs_TEXCOORD0.xy = u_xlat7.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Diffuse1_ST.xy + _Diffuse1_ST.zw;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UVDiffuse2==0.0);
#else
    u_xlatb1 = _UVDiffuse2==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb1)) ? u_xlat7.xy : u_xlat2.xw;
    vs_TEXCOORD2.xy = u_xlat1.xy * _Diffuse2_ST.xy + _Diffuse2_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UVDetail==0.0);
#else
    u_xlatb1 = _UVDetail==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb1)) ? u_xlat7.xy : u_xlat2.xw;
    vs_TEXCOORD2.zw = u_xlat1.xy * _DetailDiffuse_ST.xy + _DetailDiffuse_ST.zw;
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat2.xyz = vec3(u_xlat0) * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_4.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = vec3(u_xlat0) * u_xlat16_4.xyz;
    vs_TEXCOORD3.y = u_xlat16_4.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD3.w = u_xlat5.x;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat5.y;
    vs_TEXCOORD5.w = u_xlat5.z;
    vs_TEXCOORD4.y = u_xlat16_4.y;
    vs_TEXCOORD5.y = u_xlat16_4.z;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump float _HeightSpread;
uniform 	mediump float _HeightContrast;
uniform 	mediump float _UseTintColor;
uniform 	mediump float _UseDiffuseOneHeight;
uniform 	mediump float _UseDiffuseTwoHeight;
uniform 	mediump float _UseDetailDiffuseHeight;
uniform 	mediump float _UseGrassHeightBlend;
uniform 	mediump float _UseGrassSpecular;
uniform 	mediump float _UseSpecularOne;
uniform 	mediump float _UseSpecularTwo;
uniform 	mediump float _UseDetailSpecular;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _SSAO_Intensity;
uniform 	mediump float _Terrain_Smoothness;
uniform 	mediump float _Terrain_Specular;
uniform 	mediump float _Shininess;
uniform 	float _GrassNormalScale;
uniform 	float _Normal0Scale;
uniform 	mediump float _Normal2Scale;
uniform 	mediump float _Diffuse2Distance;
uniform 	mediump float _Diffuse2Fade;
uniform 	mediump float _DetailNormalScale;
uniform 	mediump float _DetailNormalUVScale;
uniform 	mediump float _DetailBlendVal;
uniform 	mediump float _DetailDistance;
uniform 	mediump float _DetailFade;
uniform 	mediump float _DepthBiasScaled;
uniform 	mediump float _DepthBlendAO;
uniform lowp sampler2D _GrassNormal;
uniform lowp sampler2D _GrassDiffuse;
uniform lowp sampler2D _Normal0;
uniform lowp sampler2D _Normal2;
uniform lowp sampler2D _Diffuse1;
uniform lowp sampler2D _DetailNormal;
uniform lowp sampler2D _Diffuse2;
uniform lowp sampler2D _DetailDiffuse;
uniform highp sampler2D _CameraDepthBlendTexture;
uniform lowp sampler2D _CameraDepthBlendNormTexture;
uniform lowp sampler2D _CameraDepthBlendDiffTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_6;
mediump vec4 u_xlat16_7;
lowp vec4 u_xlat10_8;
lowp vec4 u_xlat10_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
mediump vec3 u_xlat16_12;
float u_xlat13;
mediump float u_xlat16_13;
vec2 u_xlat26;
mediump float u_xlat16_26;
mediump vec2 u_xlat16_31;
mediump float u_xlat16_33;
float u_xlat39;
bool u_xlatb39;
mediump float u_xlat16_40;
mediump float u_xlat16_41;
float u_xlat42;
mediump float u_xlat16_44;
mediump float u_xlat16_46;
mediump float u_xlat16_49;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_COLOR0.w<0.99000001);
#else
    u_xlatb0 = vs_COLOR0.w<0.99000001;
#endif
    if(u_xlatb0){
        u_xlat10_0 = texture(_GrassNormal, vs_TEXCOORD0.xy, -1.0);
        u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_1.xy = u_xlat16_1.xy * vec2(_GrassNormalScale);
        u_xlat16_40 = u_xlat10_0.w * _UseGrassSpecular;
        u_xlat10_0.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.xy, -1.0).xyz;
        u_xlat16_2.xyz = u_xlat10_0.xyz;
    } else {
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
        u_xlat16_1.x = float(0.0);
        u_xlat16_1.y = float(0.0);
        u_xlat16_1.z = float(1.0);
        u_xlat16_40 = float(0.0);
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.00999999978<vs_COLOR0.w);
#else
    u_xlatb0 = 0.00999999978<vs_COLOR0.w;
#endif
    if(u_xlatb0){
        u_xlat0.x = vs_TEXCOORD3.w;
        u_xlat0.y = vs_TEXCOORD4.w;
        u_xlat0.z = vs_TEXCOORD5.w;
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat13 = u_xlat0.x / _Diffuse2Distance;
#ifdef UNITY_ADRENO_ES3
        u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
        u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
        u_xlat13 = u_xlat13 + 9.99999975e-05;
        u_xlat13 = log2(u_xlat13);
        u_xlat13 = u_xlat13 * _Diffuse2Fade;
        u_xlat0.y = exp2(u_xlat13);
        u_xlat0.x = u_xlat0.x / _DetailDistance;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = u_xlat0.x + 9.99999975e-05;
        u_xlat0.x = log2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * _DetailFade;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat0.xy = min(u_xlat0.xy, vec2(1.0, 1.0));
        u_xlat10_3.xyz = texture(_Normal0, vs_TEXCOORD0.zw, -1.0).xyw;
        u_xlat10_4.xyz = texture(_Normal2, vs_TEXCOORD2.xy, -1.0).xyw;
        u_xlat16_5.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_31.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_31.xy = u_xlat16_31.xy * vec2(_Normal2Scale);
        u_xlat16_41 = (-u_xlat0.y) + 1.0;
        u_xlat16_31.xy = vec2(u_xlat16_41) * u_xlat16_31.xy;
        u_xlat16_31.xy = u_xlat16_31.xy * vs_COLOR0.xx;
        u_xlat10_6 = texture(_Diffuse1, vs_TEXCOORD0.zw, -1.0);
        u_xlat26.xy = vec2(vs_TEXCOORD2.z * float(_DetailNormalUVScale), vs_TEXCOORD2.w * float(_DetailNormalUVScale));
        u_xlat10_3.xyw = texture(_DetailNormal, u_xlat26.xy, -1.0).xyw;
        u_xlat16_7.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_7.xy = u_xlat16_7.xy * vec2(_DetailNormalScale);
        u_xlat16_41 = (-u_xlat0.x) + 1.0;
        u_xlat16_7.xy = vec2(u_xlat16_41) * u_xlat16_7.xy;
        u_xlat10_8 = texture(_Diffuse2, vs_TEXCOORD2.xy, -1.0);
        u_xlat10_9 = texture(_DetailDiffuse, vs_TEXCOORD2.zw, -1.0);
        u_xlat16_41 = u_xlat10_8.w * _UseDiffuseTwoHeight;
        u_xlat16_33 = u_xlat10_9.w * _UseDetailDiffuseHeight;
        u_xlat16_10.xyz = u_xlat10_6.xyz + (-u_xlat10_8.xyz);
        u_xlat16_46 = u_xlat10_6.w * _UseDiffuseOneHeight + (-u_xlat16_41);
        u_xlat16_10.xyz = u_xlat0.yyy * u_xlat16_10.xyz + u_xlat10_8.xyz;
        u_xlat16_41 = u_xlat0.y * u_xlat16_46 + u_xlat16_41;
        u_xlat16_46 = u_xlat0.x * _DetailBlendVal;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_46 = min(max(u_xlat16_46, 0.0), 1.0);
#else
        u_xlat16_46 = clamp(u_xlat16_46, 0.0, 1.0);
#endif
        u_xlat16_49 = (-u_xlat16_46) + 1.0;
        u_xlat16_33 = u_xlat16_33 * u_xlat16_49;
        u_xlat16_41 = max(u_xlat16_41, u_xlat16_33);
        u_xlat16_11.xyz = u_xlat10_9.xyz * u_xlat16_10.xyz;
        u_xlat16_12.xyz = u_xlat16_11.xyz * vec3(4.0, 4.0, 4.0);
        u_xlat16_10.xyz = (-u_xlat16_11.xyz) * vec3(4.0, 4.0, 4.0) + u_xlat16_10.xyz;
        u_xlat16_10.xyz = vec3(u_xlat16_46) * u_xlat16_10.xyz + u_xlat16_12.xyz;
        u_xlat16_10.xyz = min(u_xlat16_10.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_33 = u_xlat10_4.z * _UseSpecularTwo;
        u_xlat16_46 = u_xlat10_3.w * _UseDetailSpecular;
        u_xlat16_11.x = _UseSpecularOne * u_xlat10_3.z + (-u_xlat16_33);
        u_xlat16_33 = u_xlat0.y * u_xlat16_11.x + u_xlat16_33;
        u_xlat16_46 = u_xlat16_49 * u_xlat16_46;
        u_xlat16_33 = max(u_xlat16_46, u_xlat16_33);
        u_xlat16_5.xy = u_xlat16_5.xy * vec2(_Normal0Scale) + u_xlat16_31.xy;
        u_xlat16_5.xy = u_xlat16_7.xy * vs_COLOR0.xx + u_xlat16_5.xy;
    } else {
        u_xlat16_10.x = float(0.0);
        u_xlat16_10.y = float(0.0);
        u_xlat16_10.z = float(0.0);
        u_xlat16_5.x = float(0.0);
        u_xlat16_5.y = float(0.0);
        u_xlat16_41 = 1.0;
        u_xlat16_33 = 0.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor);
#endif
    u_xlat16_7.xyw = u_xlat16_10.xyz * _TintColor.xyz;
    u_xlat16_7.xyw = (bool(u_xlatb0)) ? u_xlat16_7.xyw : u_xlat16_10.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend);
#endif
    u_xlat16_13 = u_xlat16_41;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_26 = vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_41 = _HeightContrast * 10.0;
    u_xlat16_13 = u_xlat16_13 + -1.0;
    u_xlat16_44 = _HeightSpread + 0.100000001;
    u_xlat16_26 = log2(u_xlat16_26);
    u_xlat16_26 = u_xlat16_26 * u_xlat16_44;
    u_xlat16_26 = exp2(u_xlat16_26);
    u_xlat16_13 = u_xlat16_26 * 2.0 + u_xlat16_13;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_26 = _HeightContrast * 10.0 + 1.0;
    u_xlat16_26 = _HeightContrast * 10.0 + u_xlat16_26;
    u_xlat13 = u_xlat16_13 * u_xlat16_26 + (-u_xlat16_41);
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat16_41 = (u_xlatb0) ? u_xlat13 : vs_COLOR0.w;
    u_xlat16_5.z = 1.0;
    u_xlat16_5.xyz = (-u_xlat16_1.xyz) + u_xlat16_5.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_41) * u_xlat16_5.xyz + u_xlat16_1.xyz;
    u_xlat16_5.x = (-u_xlat16_40) + u_xlat16_33;
    u_xlat16_40 = u_xlat16_41 * u_xlat16_5.x + u_xlat16_40;
    u_xlat16_5.xyz = (-u_xlat16_2.xyz) + u_xlat16_7.xyw;
    u_xlat16_2.xyz = vec3(u_xlat16_41) * u_xlat16_5.xyz + u_xlat16_2.xyz;
    u_xlat16_40 = u_xlat16_40 + _Shininess;
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD5.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!(vs_TEXCOORD1.w<100.0);
#else
    u_xlatb39 = vs_TEXCOORD1.w<100.0;
#endif
    if(u_xlatb39){
        u_xlat3.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
        u_xlat39 = texture(_CameraDepthBlendTexture, u_xlat3.xy).x;
        u_xlat39 = _ZBufferParams.z * u_xlat39 + _ZBufferParams.w;
        u_xlat39 = float(1.0) / u_xlat39;
        u_xlat39 = u_xlat39 + (-vs_TEXCOORD1.w);
        u_xlat39 = abs(u_xlat39) * _DepthBiasScaled;
        u_xlat39 = u_xlat39 * 0.600000024;
#ifdef UNITY_ADRENO_ES3
        u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
        u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
        u_xlat39 = sqrt(u_xlat39);
        u_xlat10_4.xyz = texture(_CameraDepthBlendNormTexture, u_xlat3.xy).xyz;
        u_xlat16_1.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat10_3.xyz = texture(_CameraDepthBlendDiffTexture, u_xlat3.xy).xyz;
        u_xlat16_41 = u_xlat0.y * _DepthBlendAO;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
        u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
        u_xlat42 = (-u_xlat39) + 1.0;
        u_xlat42 = u_xlat16_41 * u_xlat42 + u_xlat39;
        u_xlat42 = max(u_xlat42, 0.899999976);
        u_xlat4.xyz = u_xlat16_2.xyz * vec3(u_xlat42) + (-u_xlat10_3.xyz);
        u_xlat2.xyz = vec3(u_xlat39) * u_xlat4.xyz + u_xlat10_3.xyz;
        u_xlat3.xyz = u_xlat0.xyz + (-u_xlat16_1.xyz);
        u_xlat3.xyz = vec3(u_xlat39) * u_xlat3.xyz + u_xlat16_1.xyz;
        u_xlat16_2.xyz = u_xlat2.xyz;
        u_xlat16_3.xyz = u_xlat3.xyz;
    } else {
        u_xlat16_3.xyz = u_xlat0.xyz;
    //ENDIF
    }
    u_xlat16_1.x = u_xlat16_40 * _Terrain_Smoothness;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    SV_Target2.w = min(u_xlat16_1.x, 0.5);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(vec3(_Terrain_Specular, _Terrain_Specular, _Terrain_Specular));
    u_xlat16_0.x = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_40 = max(u_xlat16_1.z, u_xlat16_1.y);
    u_xlat16_40 = max(u_xlat16_40, u_xlat16_1.x);
    u_xlat16_40 = (-u_xlat16_40) + 1.0;
    SV_Target1.xyz = vec3(u_xlat16_40) * u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_40 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_40 : u_xlat16_1.z;
    SV_Target0.w = 0.0;
    SV_Target1.w = _SSAO_Intensity;
    SV_Target2.xy = u_xlat16_1.xy;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _Diffuse1_ST;
uniform 	float _UVDiffuse2;
uniform 	vec4 _Diffuse2_ST;
uniform 	float _UVDetail;
uniform 	vec4 _DetailDiffuse_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec2 u_xlat12;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat15 = u_xlat15 + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat15 = u_xlat15 + u_xlat2.x;
    u_xlat15 = u_xlat15 * 0.330000013;
    u_xlat2.xy = vec2(u_xlat15) * in_TEXCOORD0.xy;
    u_xlat12.xy = vec2(u_xlat15) * in_TEXCOORD1.xy;
    vs_TEXCOORD0.xy = u_xlat2.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Diffuse1_ST.xy + _Diffuse1_ST.zw;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat15 * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UVDiffuse2==0.0);
#else
    u_xlatb15 = _UVDiffuse2==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat2.xy : u_xlat12.xy;
    vs_TEXCOORD2.xy = u_xlat1.xy * _Diffuse2_ST.xy + _Diffuse2_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UVDetail==0.0);
#else
    u_xlatb15 = _UVDetail==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat2.xy : u_xlat12.xy;
    vs_TEXCOORD2.zw = u_xlat1.xy * _DetailDiffuse_ST.xy + _DetailDiffuse_ST.zw;
    vs_TEXCOORD3.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz;
    vs_TEXCOORD3.y = u_xlat16_4.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat0.y;
    vs_TEXCOORD5.w = u_xlat0.z;
    vs_TEXCOORD4.y = u_xlat16_4.y;
    vs_TEXCOORD5.y = u_xlat16_4.z;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	mediump float _HeightSpread;
uniform 	mediump float _HeightContrast;
uniform 	mediump float _UseTintColor;
uniform 	mediump float _UseDiffuseOneHeight;
uniform 	mediump float _UseDiffuseTwoHeight;
uniform 	mediump float _UseDetailDiffuseHeight;
uniform 	mediump float _UseGrassHeightBlend;
uniform 	mediump float _UseGrassSpecular;
uniform 	mediump float _UseSpecularOne;
uniform 	mediump float _UseSpecularTwo;
uniform 	mediump float _UseDetailSpecular;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _SSAO_Intensity;
uniform 	mediump float _Terrain_Smoothness;
uniform 	mediump float _Terrain_Specular;
uniform 	mediump float _Shininess;
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _GrassDiffuse_TexelSize;
uniform 	vec4 _GrassNormal_TexelSize;
uniform 	vec4 _Diffuse1_ST;
uniform 	vec4 _Diffuse1_TexelSize;
uniform 	vec4 _Normal0_TexelSize;
uniform 	vec4 _Diffuse2_ST;
uniform 	vec4 _Normal2_TexelSize;
uniform 	mediump float _Diffuse2Distance;
uniform 	mediump float _Diffuse2Fade;
uniform 	vec4 _DetailDiffuse_ST;
uniform 	vec4 _DetailDiffuse_TexelSize;
uniform 	vec4 _DetailNormal_TexelSize;
uniform 	mediump float _DetailNormalUVScale;
uniform 	mediump float _DetailBlendVal;
uniform 	mediump float _DetailDistance;
uniform 	mediump float _DetailFade;
uniform 	mediump float _DepthBiasScaled;
uniform 	mediump float _DepthBlendAO;
uniform lowp sampler2D _GrassDiffuse;
uniform lowp sampler2D _GrassNormal;
uniform lowp sampler2D _Normal0;
uniform lowp sampler2D _Normal2;
uniform lowp sampler2D _Diffuse1;
uniform lowp sampler2D _DetailNormal;
uniform lowp sampler2D _Diffuse2;
uniform lowp sampler2D _DetailDiffuse;
uniform highp sampler2D _CameraDepthBlendTexture;
uniform lowp sampler2D _CameraDepthBlendNormTexture;
uniform lowp sampler2D _CameraDepthBlendDiffTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec3 u_xlatb1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
bvec3 u_xlatb2;
vec4 u_xlat3;
lowp vec4 u_xlat10_3;
bvec3 u_xlatb3;
vec4 u_xlat4;
lowp vec4 u_xlat10_4;
bvec3 u_xlatb4;
vec3 u_xlat5;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec4 u_xlat16_11;
mediump vec3 u_xlat16_12;
mediump vec3 u_xlat16_13;
mediump vec3 u_xlat16_14;
float u_xlat15;
mediump float u_xlat16_15;
vec3 u_xlat16;
vec3 u_xlat17;
vec3 u_xlat18;
vec3 u_xlat19;
vec2 u_xlat30;
mediump float u_xlat16_30;
bvec2 u_xlatb30;
float u_xlat31;
float u_xlat32;
vec2 u_xlat33;
bvec2 u_xlatb33;
vec2 u_xlat34;
mediump vec2 u_xlat16_40;
mediump float u_xlat16_41;
float u_xlat45;
bool u_xlatb45;
float u_xlat46;
float u_xlat47;
float u_xlat48;
bool u_xlatb48;
float u_xlat49;
mediump float u_xlat16_53;
mediump float u_xlat16_54;
mediump float u_xlat16_55;
mediump float u_xlat16_56;
mediump float u_xlat16_57;
void main()
{
    u_xlat0.x = vs_TEXCOORD3.w;
    u_xlat0.y = vs_TEXCOORD4.w;
    u_xlat0.z = vs_TEXCOORD5.w;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x / _Diffuse2Distance;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat15 + 9.99999975e-05;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Diffuse2Fade;
    u_xlat0.y = exp2(u_xlat15);
    u_xlat0.x = u_xlat0.x / _DetailDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + 9.99999975e-05;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _DetailFade;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.xy = min(u_xlat0.xy, vec2(1.0, 1.0));
    u_xlat1.zw = vec2(vs_TEXCOORD0.z + (-_Diffuse1_ST.z), vs_TEXCOORD0.w + (-_Diffuse1_ST.w));
    u_xlat30.xy = vec2(_Diffuse1_ST.x * _Diffuse1_TexelSize.z, _Diffuse1_ST.y * _Diffuse1_TexelSize.w);
    u_xlatb30.xy = lessThan(vec4(1.0, 1.0, 1.0, 1.0), u_xlat30.xyxy).xy;
    u_xlatb30.x = u_xlatb30.y || u_xlatb30.x;
    u_xlat1.xy = _Diffuse1_TexelSize.zw;
    u_xlat2 = (u_xlatb30.x) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
    u_xlat3.xy = vec2(_Diffuse1_ST.x * _Normal0_TexelSize.z, _Diffuse1_ST.y * _Normal0_TexelSize.w);
    u_xlatb3.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat3.xyxx).xy;
    u_xlatb45 = u_xlatb3.y || u_xlatb3.x;
    u_xlat1.xy = _Normal0_TexelSize.zw;
    u_xlat1 = (bool(u_xlatb45)) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
    u_xlat3.xy = (bool(u_xlatb45)) ? _Diffuse1_ST.xy : vec2(1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb45 = !!(u_xlat0.y<0.800000012);
#else
    u_xlatb45 = u_xlat0.y<0.800000012;
#endif
    u_xlat4.zw = vec2(vs_TEXCOORD2.x + (-_Diffuse2_ST.z), vs_TEXCOORD2.y + (-_Diffuse2_ST.w));
    u_xlat33.xy = u_xlat1.xy * u_xlat3.xy;
    u_xlat5.xy = vec2(_Diffuse2_ST.x * _Normal2_TexelSize.z, _Diffuse2_ST.y * _Normal2_TexelSize.w);
    u_xlatb33.xy = lessThan(u_xlat33.xyxy, u_xlat5.xyxy).xy;
    u_xlatb33.x = u_xlatb33.y || u_xlatb33.x;
    u_xlat4.xy = _Normal2_TexelSize.zw;
    u_xlat4 = (u_xlatb33.x) ? u_xlat4 : u_xlat1;
    u_xlat1 = (bool(u_xlatb45)) ? u_xlat4 : u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb48 = !!(u_xlat0.x<0.800000012);
#else
    u_xlatb48 = u_xlat0.x<0.800000012;
#endif
    if(u_xlatb48){
        u_xlat4.xy = (u_xlatb30.x) ? _Diffuse1_ST.xy : vec2(1.0, 1.0);
        u_xlat33.xy = (u_xlatb33.x) ? _Diffuse2_ST.xy : u_xlat3.xy;
        u_xlat30.xy = (bool(u_xlatb45)) ? u_xlat33.xy : u_xlat3.xy;
        u_xlat3.zw = vec2(vs_TEXCOORD2.z + (-_DetailDiffuse_ST.z), vs_TEXCOORD2.w + (-_DetailDiffuse_ST.w));
        u_xlat4.xy = u_xlat2.xy * u_xlat4.xy;
        u_xlat34.xy = vec2(_DetailDiffuse_ST.x * _DetailDiffuse_TexelSize.z, _DetailDiffuse_ST.y * _DetailDiffuse_TexelSize.w);
        u_xlatb4.xy = lessThan(u_xlat4.xyxx, u_xlat34.xyxx).xy;
        u_xlatb4.x = u_xlatb4.y || u_xlatb4.x;
        u_xlat3.xy = _DetailDiffuse_TexelSize.zw;
        u_xlat2 = (u_xlatb4.x) ? u_xlat3 : u_xlat2;
        u_xlat30.xy = u_xlat30.xy * u_xlat1.xy;
        u_xlat4.xy = vec2(_DetailDiffuse_ST.x * _DetailNormal_TexelSize.z, _DetailDiffuse_ST.y * _DetailNormal_TexelSize.w);
        u_xlatb30.xy = lessThan(u_xlat30.xyxy, u_xlat4.xyxy).xy;
        u_xlatb30.x = u_xlatb30.y || u_xlatb30.x;
        u_xlat3.xy = _DetailNormal_TexelSize.zw;
        u_xlat1 = (u_xlatb30.x) ? u_xlat3 : u_xlat1;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30.x = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb30.x = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb30.x){
        u_xlatb3.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat4 = (u_xlatb3.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat4 = (u_xlatb3.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat4;
        u_xlat3 = (u_xlatb3.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat4;
        SV_Target0 = u_xlat3;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30.x = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb30.x = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb30.x){
        u_xlat10_3.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.xy).xyz;
        SV_Target0.xyz = u_xlat10_3.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30.x = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb30.x = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb30.x){
        u_xlat30.x = max(_GrassDiffuse_TexelSize.w, _GrassDiffuse_TexelSize.z);
        u_xlat30.x = max(u_xlat30.x, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb45 = !!(256.0<u_xlat30.x);
#else
        u_xlatb45 = 256.0<u_xlat30.x;
#endif
        u_xlatb3.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), u_xlat30.xxxx).xy;
        u_xlat4 = (u_xlatb3.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat3 = (u_xlatb3.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat4;
        u_xlat3 = (bool(u_xlatb45)) ? u_xlat3 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat3;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30.x = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb30.x = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb30.x){
        u_xlat30.xy = vec2(vs_TEXCOORD0.x * _GrassDiffuse_TexelSize.z, vs_TEXCOORD0.y * _GrassDiffuse_TexelSize.w);
        u_xlat3.xy = dFdx(u_xlat30.xy);
        u_xlat30.xy = dFdy(u_xlat30.xy);
        u_xlat3.x = dot(u_xlat3.xy, u_xlat3.xy);
        u_xlat30.x = dot(u_xlat30.xy, u_xlat30.xy);
        u_xlat30.x = max(u_xlat30.x, u_xlat3.x);
        u_xlat30.x = log2(u_xlat30.x);
        u_xlat30.x = u_xlat30.x * 0.5;
        u_xlat30.x = max(u_xlat30.x, 0.0);
        u_xlat30.x = u_xlat30.x + 1.0;
        u_xlat45 = max(_GrassDiffuse_TexelSize.w, _GrassDiffuse_TexelSize.z);
        u_xlat30.x = u_xlat45 / u_xlat30.x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb45 = !!(256.0<u_xlat30.x);
#else
        u_xlatb45 = 256.0<u_xlat30.x;
#endif
        u_xlatb3.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), u_xlat30.xxxx).xy;
        u_xlat4 = (u_xlatb3.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat3 = (u_xlatb3.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat4;
        u_xlat3 = (bool(u_xlatb45)) ? u_xlat3 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat3;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30.x = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb30.x = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb30.x){
        u_xlat3.zw = vec2(vs_TEXCOORD0.x + (-_GrassDiffuse_ST.z), vs_TEXCOORD0.y + (-_GrassDiffuse_ST.w));
        u_xlat30.xy = vec2(_GrassDiffuse_ST.x * _GrassDiffuse_TexelSize.z, _GrassDiffuse_ST.y * _GrassDiffuse_TexelSize.w);
        u_xlatb30.xy = lessThan(vec4(1.0, 1.0, 1.0, 1.0), u_xlat30.xyxy).xy;
        u_xlatb30.x = u_xlatb30.y || u_xlatb30.x;
        u_xlat3.xy = _GrassDiffuse_TexelSize.zw;
        u_xlat4 = (u_xlatb30.x) ? u_xlat3 : vec4(1.0, 1.0, 0.0, 0.0);
        u_xlat2 = u_xlat2 + (-u_xlat4);
        u_xlat2 = vs_COLOR0.wwww * u_xlat2 + u_xlat4;
#ifdef UNITY_ADRENO_ES3
        u_xlatb30.x = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb30.x = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb30.x){
            u_xlat30.xy = vec2(u_xlat2.x * u_xlat2.z, u_xlat2.y * u_xlat2.w);
            u_xlat4.xy = dFdx(u_xlat30.xy);
            u_xlat30.xy = dFdy(u_xlat30.xy);
            u_xlat34.x = dot(u_xlat4.xy, u_xlat4.xy);
            u_xlat49 = dot(u_xlat30.xy, u_xlat30.xy);
            u_xlat34.x = max(u_xlat49, u_xlat34.x);
            u_xlat34.x = log2(u_xlat34.x);
            u_xlat34.x = u_xlat34.x * 0.5;
            u_xlat34.x = max(u_xlat34.x, 0.0);
            u_xlat34.x = u_xlat34.x + 1.0;
            u_xlat49 = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat4.xy = vec2(u_xlat49) * u_xlat4.xy;
            u_xlat30.xy = u_xlat30.xy * vec2(u_xlat49);
            u_xlat4.xy = u_xlat4.xy / u_xlat34.xx;
            u_xlat30.xy = u_xlat30.xy / u_xlat34.xx;
            u_xlat19.x = dot(abs(u_xlat4.xy), abs(u_xlat4.xy));
            u_xlat45 = dot(abs(u_xlat30.xy), abs(u_xlat30.xy));
            u_xlat34.x = sqrt(u_xlat19.x);
            u_xlat49 = sqrt(u_xlat45);
            u_xlat19.x = inversesqrt(u_xlat19.x);
            u_xlat4.x = u_xlat19.x * abs(u_xlat4.x);
            u_xlat45 = inversesqrt(u_xlat45);
            u_xlat30.x = u_xlat45 * abs(u_xlat30.x);
            u_xlat30.x = u_xlat30.x * u_xlat4.x;
            u_xlat30.x = (-u_xlat30.x) * u_xlat30.x + 1.0;
            u_xlat30.x = sqrt(u_xlat30.x);
            u_xlat45 = u_xlat49 * u_xlat34.x;
            u_xlat4.x = u_xlat30.x * u_xlat45;
            u_xlat19.xy = vec2(u_xlat2.z * float(3.0), u_xlat2.w * float(3.0));
            u_xlat49 = fract((-u_xlat19.x));
            u_xlat19.z = u_xlat49 + 0.5;
            u_xlat19.xy = fract(u_xlat19.xy);
            u_xlat19.xy = u_xlat19.xy + vec2(0.5, 0.5);
            u_xlat19.xyz = floor(u_xlat19.xyz);
            u_xlat49 = (-u_xlat19.x) + u_xlat19.z;
            u_xlat19.x = u_xlat49 * u_xlat19.y + u_xlat19.x;
            u_xlat34.x = (-u_xlat45) * u_xlat30.x + 1.0;
            u_xlat5.xyz = (-u_xlat19.xxx) + vec3(0.5, 0.0, 1.0);
            u_xlat6.xyz = u_xlat34.xxx * u_xlat5.xyz + u_xlat19.xxx;
            u_xlatb4.xz = lessThan(u_xlat4.xxxx, vec4(1.0, 0.0, 2.0, 0.0)).xz;
            u_xlat7.xyz = u_xlat19.xxx * vec3(0.0, 1.0, 0.0);
            u_xlat30.x = u_xlat45 * u_xlat30.x + -4.0;
            u_xlat30.x = exp2(u_xlat30.x);
            u_xlat30.x = u_xlat30.x + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat30.x = min(max(u_xlat30.x, 0.0), 1.0);
#else
            u_xlat30.x = clamp(u_xlat30.x, 0.0, 1.0);
#endif
            u_xlat5.xyz = u_xlat30.xxx * u_xlat5.zyy + u_xlat19.xxx;
            u_xlat19.xyz = (u_xlatb4.z) ? u_xlat7.xyz : u_xlat5.xyz;
            u_xlat4.xyz = (u_xlatb4.x) ? u_xlat6.xyz : u_xlat19.xyz;
        } else {
            u_xlat30.xy = vec2(_GrassDiffuse_ST.x * _GrassNormal_TexelSize.z, _GrassDiffuse_ST.y * _GrassNormal_TexelSize.w);
            u_xlatb30.xy = lessThan(vec4(1.0, 1.0, 1.0, 1.0), u_xlat30.xyxy).xy;
            u_xlatb30.x = u_xlatb30.y || u_xlatb30.x;
            u_xlat3.xy = _GrassNormal_TexelSize.zw;
            u_xlat3 = (u_xlatb30.x) ? u_xlat3 : vec4(1.0, 1.0, 0.0, 0.0);
            u_xlat1 = u_xlat1 + (-u_xlat3);
            u_xlat1 = vs_COLOR0.wwww * u_xlat1 + u_xlat3;
#ifdef UNITY_ADRENO_ES3
            u_xlatb30.x = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb30.x = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb30.x){
                u_xlat30.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                u_xlat3.xy = dFdx(u_xlat30.xy);
                u_xlat30.xy = dFdy(u_xlat30.xy);
                u_xlat33.x = dot(u_xlat3.xy, u_xlat3.xy);
                u_xlat48 = dot(u_xlat30.xy, u_xlat30.xy);
                u_xlat33.x = max(u_xlat48, u_xlat33.x);
                u_xlat33.x = log2(u_xlat33.x);
                u_xlat33.x = u_xlat33.x * 0.5;
                u_xlat33.x = max(u_xlat33.x, 0.0);
                u_xlat33.x = u_xlat33.x + 1.0;
                u_xlat48 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                u_xlat3.xy = vec2(u_xlat48) * u_xlat3.xy;
                u_xlat30.xy = u_xlat30.xy * vec2(u_xlat48);
                u_xlat3.xy = u_xlat3.xy / u_xlat33.xx;
                u_xlat30.xy = u_xlat30.xy / u_xlat33.xx;
                u_xlat18.x = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                u_xlat45 = dot(abs(u_xlat30.xy), abs(u_xlat30.xy));
                u_xlat33.x = sqrt(u_xlat18.x);
                u_xlat48 = sqrt(u_xlat45);
                u_xlat18.x = inversesqrt(u_xlat18.x);
                u_xlat3.x = u_xlat18.x * abs(u_xlat3.x);
                u_xlat45 = inversesqrt(u_xlat45);
                u_xlat30.x = u_xlat45 * abs(u_xlat30.x);
                u_xlat30.x = u_xlat30.x * u_xlat3.x;
                u_xlat30.x = (-u_xlat30.x) * u_xlat30.x + 1.0;
                u_xlat30.x = sqrt(u_xlat30.x);
                u_xlat45 = u_xlat48 * u_xlat33.x;
                u_xlat3.x = u_xlat30.x * u_xlat45;
                u_xlat18.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                u_xlat48 = fract((-u_xlat18.x));
                u_xlat18.z = u_xlat48 + 0.5;
                u_xlat18.xy = fract(u_xlat18.xy);
                u_xlat18.xy = u_xlat18.xy + vec2(0.5, 0.5);
                u_xlat18.xyz = floor(u_xlat18.xyz);
                u_xlat48 = (-u_xlat18.x) + u_xlat18.z;
                u_xlat18.x = u_xlat48 * u_xlat18.y + u_xlat18.x;
                u_xlat33.x = (-u_xlat45) * u_xlat30.x + 1.0;
                u_xlat5.xyz = (-u_xlat18.xxx) + vec3(0.5, 0.0, 1.0);
                u_xlat6.xyz = u_xlat33.xxx * u_xlat5.xyz + u_xlat18.xxx;
                u_xlatb3.xz = lessThan(u_xlat3.xxxx, vec4(1.0, 0.0, 2.0, 0.0)).xz;
                u_xlat7.xyz = u_xlat18.xxx * vec3(0.0, 1.0, 0.0);
                u_xlat30.x = u_xlat45 * u_xlat30.x + -4.0;
                u_xlat30.x = exp2(u_xlat30.x);
                u_xlat30.x = u_xlat30.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                u_xlat30.x = min(max(u_xlat30.x, 0.0), 1.0);
#else
                u_xlat30.x = clamp(u_xlat30.x, 0.0, 1.0);
#endif
                u_xlat5.xyz = u_xlat30.xxx * u_xlat5.zyy + u_xlat18.xxx;
                u_xlat18.xyz = (u_xlatb3.z) ? u_xlat7.xyz : u_xlat5.xyz;
                u_xlat4.xyz = (u_xlatb3.x) ? u_xlat6.xyz : u_xlat18.xyz;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb30.x = !!(u_xlat2.x>=u_xlat1.x);
#else
                u_xlatb30.x = u_xlat2.x>=u_xlat1.x;
#endif
                if(u_xlatb30.x){
                    u_xlat30.xy = vec2(u_xlat2.x * u_xlat2.z, u_xlat2.y * u_xlat2.w);
                    u_xlat2.xy = dFdx(u_xlat30.xy);
                    u_xlat30.xy = dFdy(u_xlat30.xy);
                    u_xlat3.x = dot(u_xlat2.xy, u_xlat2.xy);
                    u_xlat18.x = dot(u_xlat30.xy, u_xlat30.xy);
                    u_xlat3.x = max(u_xlat18.x, u_xlat3.x);
                    u_xlat3.x = log2(u_xlat3.x);
                    u_xlat3.x = u_xlat3.x * 0.5;
                    u_xlat3.x = max(u_xlat3.x, 0.0);
                    u_xlat3.x = u_xlat3.x + 1.0;
                    u_xlat18.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat2.xy = u_xlat2.xy * u_xlat18.xx;
                    u_xlat30.xy = u_xlat30.xy * u_xlat18.xx;
                    u_xlat2.xy = u_xlat2.xy / u_xlat3.xx;
                    u_xlat30.xy = u_xlat30.xy / u_xlat3.xx;
                    u_xlat17.x = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
                    u_xlat45 = dot(abs(u_xlat30.xy), abs(u_xlat30.xy));
                    u_xlat3.x = sqrt(u_xlat17.x);
                    u_xlat18.x = sqrt(u_xlat45);
                    u_xlat17.x = inversesqrt(u_xlat17.x);
                    u_xlat2.x = u_xlat17.x * abs(u_xlat2.x);
                    u_xlat45 = inversesqrt(u_xlat45);
                    u_xlat30.x = u_xlat45 * abs(u_xlat30.x);
                    u_xlat30.x = u_xlat30.x * u_xlat2.x;
                    u_xlat30.x = (-u_xlat30.x) * u_xlat30.x + 1.0;
                    u_xlat30.x = sqrt(u_xlat30.x);
                    u_xlat45 = u_xlat18.x * u_xlat3.x;
                    u_xlat2.x = u_xlat30.x * u_xlat45;
                    u_xlat17.xy = vec2(u_xlat2.z * float(3.0), u_xlat2.w * float(3.0));
                    u_xlat47 = fract((-u_xlat17.x));
                    u_xlat17.z = u_xlat47 + 0.5;
                    u_xlat17.xy = fract(u_xlat17.xy);
                    u_xlat17.xy = u_xlat17.xy + vec2(0.5, 0.5);
                    u_xlat17.xyz = floor(u_xlat17.xyz);
                    u_xlat47 = (-u_xlat17.x) + u_xlat17.z;
                    u_xlat17.x = u_xlat47 * u_xlat17.y + u_xlat17.x;
                    u_xlat32 = (-u_xlat45) * u_xlat30.x + 1.0;
                    u_xlat3.xyz = (-u_xlat17.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat5.xyz = vec3(u_xlat32) * u_xlat3.xyz + u_xlat17.xxx;
                    u_xlatb2.xz = lessThan(u_xlat2.xxxx, vec4(1.0, 0.0, 2.0, 0.0)).xz;
                    u_xlat6.xyz = u_xlat17.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat30.x = u_xlat45 * u_xlat30.x + -4.0;
                    u_xlat30.x = exp2(u_xlat30.x);
                    u_xlat30.x = u_xlat30.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat30.x = min(max(u_xlat30.x, 0.0), 1.0);
#else
                    u_xlat30.x = clamp(u_xlat30.x, 0.0, 1.0);
#endif
                    u_xlat3.xyz = u_xlat30.xxx * u_xlat3.zyy + u_xlat17.xxx;
                    u_xlat17.xyz = (u_xlatb2.z) ? u_xlat6.xyz : u_xlat3.xyz;
                    u_xlat4.xyz = (u_xlatb2.x) ? u_xlat5.xyz : u_xlat17.xyz;
                } else {
                    u_xlat30.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat1.xy = dFdx(u_xlat30.xy);
                    u_xlat30.xy = dFdy(u_xlat30.xy);
                    u_xlat2.x = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat17.x = dot(u_xlat30.xy, u_xlat30.xy);
                    u_xlat2.x = max(u_xlat17.x, u_xlat2.x);
                    u_xlat2.x = log2(u_xlat2.x);
                    u_xlat2.x = u_xlat2.x * 0.5;
                    u_xlat2.x = max(u_xlat2.x, 0.0);
                    u_xlat2.x = u_xlat2.x + 1.0;
                    u_xlat17.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat1.xy = u_xlat1.xy * u_xlat17.xx;
                    u_xlat30.xy = u_xlat30.xy * u_xlat17.xx;
                    u_xlat1.xy = u_xlat1.xy / u_xlat2.xx;
                    u_xlat30.xy = u_xlat30.xy / u_xlat2.xx;
                    u_xlat16.x = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat45 = dot(abs(u_xlat30.xy), abs(u_xlat30.xy));
                    u_xlat2.x = sqrt(u_xlat16.x);
                    u_xlat17.x = sqrt(u_xlat45);
                    u_xlat16.x = inversesqrt(u_xlat16.x);
                    u_xlat1.x = u_xlat16.x * abs(u_xlat1.x);
                    u_xlat45 = inversesqrt(u_xlat45);
                    u_xlat30.x = u_xlat45 * abs(u_xlat30.x);
                    u_xlat30.x = u_xlat30.x * u_xlat1.x;
                    u_xlat30.x = (-u_xlat30.x) * u_xlat30.x + 1.0;
                    u_xlat30.x = sqrt(u_xlat30.x);
                    u_xlat45 = u_xlat17.x * u_xlat2.x;
                    u_xlat1.x = u_xlat30.x * u_xlat45;
                    u_xlat16.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat46 = fract((-u_xlat16.x));
                    u_xlat16.z = u_xlat46 + 0.5;
                    u_xlat16.xy = fract(u_xlat16.xy);
                    u_xlat16.xy = u_xlat16.xy + vec2(0.5, 0.5);
                    u_xlat16.xyz = floor(u_xlat16.xyz);
                    u_xlat46 = (-u_xlat16.x) + u_xlat16.z;
                    u_xlat16.x = u_xlat46 * u_xlat16.y + u_xlat16.x;
                    u_xlat31 = (-u_xlat45) * u_xlat30.x + 1.0;
                    u_xlat2.xyz = (-u_xlat16.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat3.xyz = vec3(u_xlat31) * u_xlat2.xyz + u_xlat16.xxx;
                    u_xlatb1.xz = lessThan(u_xlat1.xxxx, vec4(1.0, 0.0, 2.0, 0.0)).xz;
                    u_xlat5.xyz = u_xlat16.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat30.x = u_xlat45 * u_xlat30.x + -4.0;
                    u_xlat30.x = exp2(u_xlat30.x);
                    u_xlat30.x = u_xlat30.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat30.x = min(max(u_xlat30.x, 0.0), 1.0);
#else
                    u_xlat30.x = clamp(u_xlat30.x, 0.0, 1.0);
#endif
                    u_xlat2.xyz = u_xlat30.xxx * u_xlat2.zyy + u_xlat16.xxx;
                    u_xlat16.xyz = (u_xlatb1.z) ? u_xlat5.xyz : u_xlat2.xyz;
                    u_xlat4.xyz = (u_xlatb1.x) ? u_xlat3.xyz : u_xlat16.xyz;
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat4.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb30.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 100.0, 102.0)).xy;
    u_xlatb30.x = u_xlatb30.y || u_xlatb30.x;
    if(u_xlatb30.x){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb30.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 101.0, 103.0)).xy;
    u_xlatb30.x = u_xlatb30.y || u_xlatb30.x;
    if(u_xlatb30.x){
        SV_Target0 = vec4(0.400000006, 0.400000006, 0.400000006, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30.x = !!(vs_COLOR0.w<0.99000001);
#else
    u_xlatb30.x = vs_COLOR0.w<0.99000001;
#endif
    if(u_xlatb30.x){
        u_xlat10_1 = texture(_GrassNormal, vs_TEXCOORD0.xy);
        u_xlat16_8.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_53 = u_xlat10_1.w * _UseGrassSpecular;
        u_xlat10_1.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.xy).xyz;
        u_xlat16_9.xyz = u_xlat10_1.xyz;
    } else {
        u_xlat16_9.x = float(0.0);
        u_xlat16_9.y = float(0.0);
        u_xlat16_9.z = float(0.0);
        u_xlat16_8.x = float(0.0);
        u_xlat16_8.y = float(0.0);
        u_xlat16_8.z = float(1.0);
        u_xlat16_53 = float(0.0);
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30.x = !!(0.00999999978<vs_COLOR0.w);
#else
    u_xlatb30.x = 0.00999999978<vs_COLOR0.w;
#endif
    if(u_xlatb30.x){
        u_xlat10_1.xyz = texture(_Normal0, vs_TEXCOORD0.zw).xyw;
        u_xlat10_2.xyz = texture(_Normal2, vs_TEXCOORD2.xy).xyw;
        u_xlat16_10.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_40.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_54 = (-u_xlat0.y) + 1.0;
        u_xlat16_40.xy = vec2(u_xlat16_54) * u_xlat16_40.xy;
        u_xlat10_3 = texture(_Diffuse1, vs_TEXCOORD0.zw);
        u_xlat30.xy = vec2(vs_TEXCOORD2.z * float(_DetailNormalUVScale), vs_TEXCOORD2.w * float(_DetailNormalUVScale));
        u_xlat10_1.xyw = texture(_DetailNormal, u_xlat30.xy).xyw;
        u_xlat16_11.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_54 = (-u_xlat0.x) + 1.0;
        u_xlat16_11.xy = vec2(u_xlat16_54) * u_xlat16_11.xy;
        u_xlat10_4 = texture(_Diffuse2, vs_TEXCOORD2.xy);
        u_xlat10_5 = texture(_DetailDiffuse, vs_TEXCOORD2.zw);
        u_xlat16_54 = u_xlat10_4.w * _UseDiffuseTwoHeight;
        u_xlat16_41 = u_xlat10_5.w * _UseDetailDiffuseHeight;
        u_xlat16_12.xyz = u_xlat10_3.xyz + (-u_xlat10_4.xyz);
        u_xlat16_56 = u_xlat10_3.w * _UseDiffuseOneHeight + (-u_xlat16_54);
        u_xlat16_12.xyz = u_xlat0.yyy * u_xlat16_12.xyz + u_xlat10_4.xyz;
        u_xlat16_54 = u_xlat0.y * u_xlat16_56 + u_xlat16_54;
        u_xlat16_56 = u_xlat0.x * _DetailBlendVal;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_56 = min(max(u_xlat16_56, 0.0), 1.0);
#else
        u_xlat16_56 = clamp(u_xlat16_56, 0.0, 1.0);
#endif
        u_xlat16_57 = (-u_xlat16_56) + 1.0;
        u_xlat16_41 = u_xlat16_41 * u_xlat16_57;
        u_xlat16_54 = max(u_xlat16_54, u_xlat16_41);
        u_xlat16_13.xyz = u_xlat10_5.xyz * u_xlat16_12.xyz;
        u_xlat16_14.xyz = u_xlat16_13.xyz * vec3(4.0, 4.0, 4.0);
        u_xlat16_12.xyz = (-u_xlat16_13.xyz) * vec3(4.0, 4.0, 4.0) + u_xlat16_12.xyz;
        u_xlat16_12.xyz = vec3(u_xlat16_56) * u_xlat16_12.xyz + u_xlat16_14.xyz;
        u_xlat16_12.xyz = min(u_xlat16_12.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_41 = u_xlat10_2.z * _UseSpecularTwo;
        u_xlat16_56 = u_xlat10_1.w * _UseDetailSpecular;
        u_xlat16_13.x = _UseSpecularOne * u_xlat10_1.z + (-u_xlat16_41);
        u_xlat16_41 = u_xlat0.y * u_xlat16_13.x + u_xlat16_41;
        u_xlat16_56 = u_xlat16_57 * u_xlat16_56;
        u_xlat16_41 = max(u_xlat16_56, u_xlat16_41);
        u_xlat16_10.xy = u_xlat16_40.xy * vs_COLOR0.xx + u_xlat16_10.xy;
        u_xlat16_10.xy = u_xlat16_11.xy * vs_COLOR0.xx + u_xlat16_10.xy;
    } else {
        u_xlat16_12.x = float(0.0);
        u_xlat16_12.y = float(0.0);
        u_xlat16_12.z = float(0.0);
        u_xlat16_10.x = float(0.0);
        u_xlat16_10.y = float(0.0);
        u_xlat16_54 = 1.0;
        u_xlat16_41 = 0.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor);
#endif
    u_xlat16_11.xyw = u_xlat16_12.xyz * _TintColor.xyz;
    u_xlat16_11.xyw = (bool(u_xlatb0)) ? u_xlat16_11.xyw : u_xlat16_12.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend);
#endif
    u_xlat16_15 = u_xlat16_54;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_30 = vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_54 = _HeightContrast * 10.0;
    u_xlat16_15 = u_xlat16_15 + -1.0;
    u_xlat16_55 = _HeightSpread + 0.100000001;
    u_xlat16_30 = log2(u_xlat16_30);
    u_xlat16_30 = u_xlat16_30 * u_xlat16_55;
    u_xlat16_30 = exp2(u_xlat16_30);
    u_xlat16_15 = u_xlat16_30 * 2.0 + u_xlat16_15;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_30 = _HeightContrast * 10.0 + 1.0;
    u_xlat16_30 = _HeightContrast * 10.0 + u_xlat16_30;
    u_xlat15 = u_xlat16_15 * u_xlat16_30 + (-u_xlat16_54);
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_54 = (u_xlatb0) ? u_xlat15 : vs_COLOR0.w;
    u_xlat16_10.z = 1.0;
    u_xlat16_10.xyz = (-u_xlat16_8.xyz) + u_xlat16_10.xyz;
    u_xlat16_8.xyz = vec3(u_xlat16_54) * u_xlat16_10.xyz + u_xlat16_8.xyz;
    u_xlat16_10.x = (-u_xlat16_53) + u_xlat16_41;
    u_xlat16_53 = u_xlat16_54 * u_xlat16_10.x + u_xlat16_53;
    u_xlat16_10.xyz = (-u_xlat16_9.xyz) + u_xlat16_11.xyw;
    u_xlat16_9.xyz = vec3(u_xlat16_54) * u_xlat16_10.xyz + u_xlat16_9.xyz;
    u_xlat16_53 = u_xlat16_53 + _Shininess;
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, u_xlat16_8.xyz);
    u_xlat0.y = dot(vs_TEXCOORD4.xyz, u_xlat16_8.xyz);
    u_xlat0.z = dot(vs_TEXCOORD5.xyz, u_xlat16_8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb45 = !!(vs_TEXCOORD1.w<100.0);
#else
    u_xlatb45 = vs_TEXCOORD1.w<100.0;
#endif
    if(u_xlatb45){
        u_xlat1.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
        u_xlat45 = texture(_CameraDepthBlendTexture, u_xlat1.xy).x;
        u_xlat45 = _ZBufferParams.z * u_xlat45 + _ZBufferParams.w;
        u_xlat45 = float(1.0) / u_xlat45;
        u_xlat45 = u_xlat45 + (-vs_TEXCOORD1.w);
        u_xlat45 = abs(u_xlat45) * _DepthBiasScaled;
        u_xlat45 = u_xlat45 * 0.600000024;
#ifdef UNITY_ADRENO_ES3
        u_xlat45 = min(max(u_xlat45, 0.0), 1.0);
#else
        u_xlat45 = clamp(u_xlat45, 0.0, 1.0);
#endif
        u_xlat45 = sqrt(u_xlat45);
        u_xlat10_2.xyz = texture(_CameraDepthBlendNormTexture, u_xlat1.xy).xyz;
        u_xlat16_8.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat10_1.xyz = texture(_CameraDepthBlendDiffTexture, u_xlat1.xy).xyz;
        u_xlat16_54 = u_xlat0.y * _DepthBlendAO;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_54 = min(max(u_xlat16_54, 0.0), 1.0);
#else
        u_xlat16_54 = clamp(u_xlat16_54, 0.0, 1.0);
#endif
        u_xlat46 = (-u_xlat45) + 1.0;
        u_xlat46 = u_xlat16_54 * u_xlat46 + u_xlat45;
        u_xlat46 = max(u_xlat46, 0.899999976);
        u_xlat2.xyz = u_xlat16_9.xyz * vec3(u_xlat46) + (-u_xlat10_1.xyz);
        u_xlat9.xyz = vec3(u_xlat45) * u_xlat2.xyz + u_xlat10_1.xyz;
        u_xlat1.xyz = u_xlat0.xyz + (-u_xlat16_8.xyz);
        u_xlat1.xyz = vec3(u_xlat45) * u_xlat1.xyz + u_xlat16_8.xyz;
        u_xlat16_9.xyz = u_xlat9.xyz;
        u_xlat16_1.xyz = u_xlat1.xyz;
    } else {
        u_xlat16_1.xyz = u_xlat0.xyz;
    //ENDIF
    }
    u_xlat16_8.x = u_xlat16_53 * _Terrain_Smoothness;
    u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
    SV_Target2.w = min(u_xlat16_8.x, 0.5);
    u_xlat16_8.xyz = u_xlat16_9.xyz * vec3(vec3(_Terrain_Specular, _Terrain_Specular, _Terrain_Specular));
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat16_53 = max(u_xlat16_8.z, u_xlat16_8.y);
    u_xlat16_53 = max(u_xlat16_53, u_xlat16_8.x);
    u_xlat16_53 = (-u_xlat16_53) + 1.0;
    SV_Target1.xyz = vec3(u_xlat16_53) * u_xlat16_9.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_53 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_53 : u_xlat16_8.z;
    SV_Target0.w = 0.0;
    SV_Target1.w = _SSAO_Intensity;
    SV_Target2.xy = u_xlat16_8.xy;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _Diffuse1_ST;
uniform 	float _UVDiffuse2;
uniform 	vec4 _Diffuse2_ST;
uniform 	float _UVDetail;
uniform 	vec4 _DetailDiffuse_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat7;
float u_xlat16;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x;
    u_xlat2.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].x;
    u_xlat2.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].x;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].y;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].y;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].y;
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.xy = sqrt(u_xlat2.xy);
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].z;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].z;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].z;
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat2.x = u_xlat7.x + u_xlat2.x;
    u_xlat2.x = u_xlat2.x * 0.330000013;
    u_xlat7.xy = u_xlat2.xx * in_TEXCOORD0.xy;
    u_xlat2.xw = u_xlat2.xx * in_TEXCOORD1.xy;
    vs_TEXCOORD0.xy = u_xlat7.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Diffuse1_ST.xy + _Diffuse1_ST.zw;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UVDiffuse2==0.0);
#else
    u_xlatb1 = _UVDiffuse2==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb1)) ? u_xlat7.xy : u_xlat2.xw;
    vs_TEXCOORD2.xy = u_xlat1.xy * _Diffuse2_ST.xy + _Diffuse2_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UVDetail==0.0);
#else
    u_xlatb1 = _UVDetail==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb1)) ? u_xlat7.xy : u_xlat2.xw;
    vs_TEXCOORD2.zw = u_xlat1.xy * _DetailDiffuse_ST.xy + _DetailDiffuse_ST.zw;
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat2.xyz = vec3(u_xlat0) * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_4.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = vec3(u_xlat0) * u_xlat16_4.xyz;
    vs_TEXCOORD3.y = u_xlat16_4.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD3.w = u_xlat5.x;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat5.y;
    vs_TEXCOORD5.w = u_xlat5.z;
    vs_TEXCOORD4.y = u_xlat16_4.y;
    vs_TEXCOORD5.y = u_xlat16_4.z;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	mediump float _HeightSpread;
uniform 	mediump float _HeightContrast;
uniform 	mediump float _UseTintColor;
uniform 	mediump float _UseDiffuseOneHeight;
uniform 	mediump float _UseDiffuseTwoHeight;
uniform 	mediump float _UseDetailDiffuseHeight;
uniform 	mediump float _UseGrassHeightBlend;
uniform 	mediump float _UseGrassSpecular;
uniform 	mediump float _UseSpecularOne;
uniform 	mediump float _UseSpecularTwo;
uniform 	mediump float _UseDetailSpecular;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _SSAO_Intensity;
uniform 	mediump float _Terrain_Smoothness;
uniform 	mediump float _Terrain_Specular;
uniform 	mediump float _Shininess;
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _GrassDiffuse_TexelSize;
uniform 	vec4 _GrassNormal_TexelSize;
uniform 	float _GrassNormalScale;
uniform 	vec4 _Diffuse1_ST;
uniform 	vec4 _Diffuse1_TexelSize;
uniform 	vec4 _Normal0_TexelSize;
uniform 	float _Normal0Scale;
uniform 	vec4 _Diffuse2_ST;
uniform 	vec4 _Normal2_TexelSize;
uniform 	mediump float _Normal2Scale;
uniform 	mediump float _Diffuse2Distance;
uniform 	mediump float _Diffuse2Fade;
uniform 	vec4 _DetailDiffuse_ST;
uniform 	vec4 _DetailDiffuse_TexelSize;
uniform 	vec4 _DetailNormal_TexelSize;
uniform 	mediump float _DetailNormalScale;
uniform 	mediump float _DetailNormalUVScale;
uniform 	mediump float _DetailBlendVal;
uniform 	mediump float _DetailDistance;
uniform 	mediump float _DetailFade;
uniform 	mediump float _DepthBiasScaled;
uniform 	mediump float _DepthBlendAO;
uniform lowp sampler2D _GrassDiffuse;
uniform lowp sampler2D _GrassNormal;
uniform lowp sampler2D _Normal0;
uniform lowp sampler2D _Normal2;
uniform lowp sampler2D _Diffuse1;
uniform lowp sampler2D _DetailNormal;
uniform lowp sampler2D _Diffuse2;
uniform lowp sampler2D _DetailDiffuse;
uniform highp sampler2D _CameraDepthBlendTexture;
uniform lowp sampler2D _CameraDepthBlendNormTexture;
uniform lowp sampler2D _CameraDepthBlendDiffTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec3 u_xlatb1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
bvec3 u_xlatb2;
vec4 u_xlat3;
lowp vec4 u_xlat10_3;
bvec3 u_xlatb3;
vec4 u_xlat4;
lowp vec4 u_xlat10_4;
bvec3 u_xlatb4;
vec3 u_xlat5;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec4 u_xlat16_11;
mediump vec3 u_xlat16_12;
mediump vec3 u_xlat16_13;
mediump vec3 u_xlat16_14;
float u_xlat15;
mediump float u_xlat16_15;
vec3 u_xlat16;
vec3 u_xlat17;
vec3 u_xlat18;
vec3 u_xlat19;
vec2 u_xlat30;
mediump float u_xlat16_30;
bvec2 u_xlatb30;
float u_xlat31;
float u_xlat32;
vec2 u_xlat33;
bvec2 u_xlatb33;
vec2 u_xlat34;
mediump vec2 u_xlat16_40;
mediump float u_xlat16_41;
float u_xlat45;
bool u_xlatb45;
float u_xlat46;
float u_xlat47;
float u_xlat48;
bool u_xlatb48;
float u_xlat49;
mediump float u_xlat16_53;
mediump float u_xlat16_54;
mediump float u_xlat16_55;
mediump float u_xlat16_56;
mediump float u_xlat16_57;
void main()
{
    u_xlat0.x = vs_TEXCOORD3.w;
    u_xlat0.y = vs_TEXCOORD4.w;
    u_xlat0.z = vs_TEXCOORD5.w;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x / _Diffuse2Distance;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat15 + 9.99999975e-05;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Diffuse2Fade;
    u_xlat0.y = exp2(u_xlat15);
    u_xlat0.x = u_xlat0.x / _DetailDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + 9.99999975e-05;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _DetailFade;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.xy = min(u_xlat0.xy, vec2(1.0, 1.0));
    u_xlat1.zw = vec2(vs_TEXCOORD0.z + (-_Diffuse1_ST.z), vs_TEXCOORD0.w + (-_Diffuse1_ST.w));
    u_xlat30.xy = vec2(_Diffuse1_ST.x * _Diffuse1_TexelSize.z, _Diffuse1_ST.y * _Diffuse1_TexelSize.w);
    u_xlatb30.xy = lessThan(vec4(1.0, 1.0, 1.0, 1.0), u_xlat30.xyxy).xy;
    u_xlatb30.x = u_xlatb30.y || u_xlatb30.x;
    u_xlat1.xy = _Diffuse1_TexelSize.zw;
    u_xlat2 = (u_xlatb30.x) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
    u_xlat3.xy = vec2(_Diffuse1_ST.x * _Normal0_TexelSize.z, _Diffuse1_ST.y * _Normal0_TexelSize.w);
    u_xlatb3.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat3.xyxx).xy;
    u_xlatb45 = u_xlatb3.y || u_xlatb3.x;
    u_xlat1.xy = _Normal0_TexelSize.zw;
    u_xlat1 = (bool(u_xlatb45)) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
    u_xlat3.xy = (bool(u_xlatb45)) ? _Diffuse1_ST.xy : vec2(1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb45 = !!(u_xlat0.y<0.800000012);
#else
    u_xlatb45 = u_xlat0.y<0.800000012;
#endif
    u_xlat4.zw = vec2(vs_TEXCOORD2.x + (-_Diffuse2_ST.z), vs_TEXCOORD2.y + (-_Diffuse2_ST.w));
    u_xlat33.xy = u_xlat1.xy * u_xlat3.xy;
    u_xlat5.xy = vec2(_Diffuse2_ST.x * _Normal2_TexelSize.z, _Diffuse2_ST.y * _Normal2_TexelSize.w);
    u_xlatb33.xy = lessThan(u_xlat33.xyxy, u_xlat5.xyxy).xy;
    u_xlatb33.x = u_xlatb33.y || u_xlatb33.x;
    u_xlat4.xy = _Normal2_TexelSize.zw;
    u_xlat4 = (u_xlatb33.x) ? u_xlat4 : u_xlat1;
    u_xlat1 = (bool(u_xlatb45)) ? u_xlat4 : u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb48 = !!(u_xlat0.x<0.800000012);
#else
    u_xlatb48 = u_xlat0.x<0.800000012;
#endif
    if(u_xlatb48){
        u_xlat4.xy = (u_xlatb30.x) ? _Diffuse1_ST.xy : vec2(1.0, 1.0);
        u_xlat33.xy = (u_xlatb33.x) ? _Diffuse2_ST.xy : u_xlat3.xy;
        u_xlat30.xy = (bool(u_xlatb45)) ? u_xlat33.xy : u_xlat3.xy;
        u_xlat3.zw = vec2(vs_TEXCOORD2.z + (-_DetailDiffuse_ST.z), vs_TEXCOORD2.w + (-_DetailDiffuse_ST.w));
        u_xlat4.xy = u_xlat2.xy * u_xlat4.xy;
        u_xlat34.xy = vec2(_DetailDiffuse_ST.x * _DetailDiffuse_TexelSize.z, _DetailDiffuse_ST.y * _DetailDiffuse_TexelSize.w);
        u_xlatb4.xy = lessThan(u_xlat4.xyxx, u_xlat34.xyxx).xy;
        u_xlatb4.x = u_xlatb4.y || u_xlatb4.x;
        u_xlat3.xy = _DetailDiffuse_TexelSize.zw;
        u_xlat2 = (u_xlatb4.x) ? u_xlat3 : u_xlat2;
        u_xlat30.xy = u_xlat30.xy * u_xlat1.xy;
        u_xlat4.xy = vec2(_DetailDiffuse_ST.x * _DetailNormal_TexelSize.z, _DetailDiffuse_ST.y * _DetailNormal_TexelSize.w);
        u_xlatb30.xy = lessThan(u_xlat30.xyxy, u_xlat4.xyxy).xy;
        u_xlatb30.x = u_xlatb30.y || u_xlatb30.x;
        u_xlat3.xy = _DetailNormal_TexelSize.zw;
        u_xlat1 = (u_xlatb30.x) ? u_xlat3 : u_xlat1;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30.x = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb30.x = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb30.x){
        u_xlatb3.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat4 = (u_xlatb3.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat4 = (u_xlatb3.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat4;
        u_xlat3 = (u_xlatb3.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat4;
        SV_Target0 = u_xlat3;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30.x = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb30.x = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb30.x){
        u_xlat10_3.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.xy).xyz;
        SV_Target0.xyz = u_xlat10_3.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30.x = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb30.x = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb30.x){
        u_xlat30.x = max(_GrassDiffuse_TexelSize.w, _GrassDiffuse_TexelSize.z);
        u_xlat30.x = max(u_xlat30.x, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb45 = !!(256.0<u_xlat30.x);
#else
        u_xlatb45 = 256.0<u_xlat30.x;
#endif
        u_xlatb3.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), u_xlat30.xxxx).xy;
        u_xlat4 = (u_xlatb3.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat3 = (u_xlatb3.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat4;
        u_xlat3 = (bool(u_xlatb45)) ? u_xlat3 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat3;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30.x = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb30.x = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb30.x){
        u_xlat30.xy = vec2(vs_TEXCOORD0.x * _GrassDiffuse_TexelSize.z, vs_TEXCOORD0.y * _GrassDiffuse_TexelSize.w);
        u_xlat3.xy = dFdx(u_xlat30.xy);
        u_xlat30.xy = dFdy(u_xlat30.xy);
        u_xlat3.x = dot(u_xlat3.xy, u_xlat3.xy);
        u_xlat30.x = dot(u_xlat30.xy, u_xlat30.xy);
        u_xlat30.x = max(u_xlat30.x, u_xlat3.x);
        u_xlat30.x = log2(u_xlat30.x);
        u_xlat30.x = u_xlat30.x * 0.5;
        u_xlat30.x = max(u_xlat30.x, 0.0);
        u_xlat30.x = u_xlat30.x + 1.0;
        u_xlat45 = max(_GrassDiffuse_TexelSize.w, _GrassDiffuse_TexelSize.z);
        u_xlat30.x = u_xlat45 / u_xlat30.x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb45 = !!(256.0<u_xlat30.x);
#else
        u_xlatb45 = 256.0<u_xlat30.x;
#endif
        u_xlatb3.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), u_xlat30.xxxx).xy;
        u_xlat4 = (u_xlatb3.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat3 = (u_xlatb3.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat4;
        u_xlat3 = (bool(u_xlatb45)) ? u_xlat3 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat3;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30.x = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb30.x = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb30.x){
        u_xlat3.zw = vec2(vs_TEXCOORD0.x + (-_GrassDiffuse_ST.z), vs_TEXCOORD0.y + (-_GrassDiffuse_ST.w));
        u_xlat30.xy = vec2(_GrassDiffuse_ST.x * _GrassDiffuse_TexelSize.z, _GrassDiffuse_ST.y * _GrassDiffuse_TexelSize.w);
        u_xlatb30.xy = lessThan(vec4(1.0, 1.0, 1.0, 1.0), u_xlat30.xyxy).xy;
        u_xlatb30.x = u_xlatb30.y || u_xlatb30.x;
        u_xlat3.xy = _GrassDiffuse_TexelSize.zw;
        u_xlat4 = (u_xlatb30.x) ? u_xlat3 : vec4(1.0, 1.0, 0.0, 0.0);
        u_xlat2 = u_xlat2 + (-u_xlat4);
        u_xlat2 = vs_COLOR0.wwww * u_xlat2 + u_xlat4;
#ifdef UNITY_ADRENO_ES3
        u_xlatb30.x = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb30.x = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb30.x){
            u_xlat30.xy = vec2(u_xlat2.x * u_xlat2.z, u_xlat2.y * u_xlat2.w);
            u_xlat4.xy = dFdx(u_xlat30.xy);
            u_xlat30.xy = dFdy(u_xlat30.xy);
            u_xlat34.x = dot(u_xlat4.xy, u_xlat4.xy);
            u_xlat49 = dot(u_xlat30.xy, u_xlat30.xy);
            u_xlat34.x = max(u_xlat49, u_xlat34.x);
            u_xlat34.x = log2(u_xlat34.x);
            u_xlat34.x = u_xlat34.x * 0.5;
            u_xlat34.x = max(u_xlat34.x, 0.0);
            u_xlat34.x = u_xlat34.x + 1.0;
            u_xlat49 = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat4.xy = vec2(u_xlat49) * u_xlat4.xy;
            u_xlat30.xy = u_xlat30.xy * vec2(u_xlat49);
            u_xlat4.xy = u_xlat4.xy / u_xlat34.xx;
            u_xlat30.xy = u_xlat30.xy / u_xlat34.xx;
            u_xlat19.x = dot(abs(u_xlat4.xy), abs(u_xlat4.xy));
            u_xlat45 = dot(abs(u_xlat30.xy), abs(u_xlat30.xy));
            u_xlat34.x = sqrt(u_xlat19.x);
            u_xlat49 = sqrt(u_xlat45);
            u_xlat19.x = inversesqrt(u_xlat19.x);
            u_xlat4.x = u_xlat19.x * abs(u_xlat4.x);
            u_xlat45 = inversesqrt(u_xlat45);
            u_xlat30.x = u_xlat45 * abs(u_xlat30.x);
            u_xlat30.x = u_xlat30.x * u_xlat4.x;
            u_xlat30.x = (-u_xlat30.x) * u_xlat30.x + 1.0;
            u_xlat30.x = sqrt(u_xlat30.x);
            u_xlat45 = u_xlat49 * u_xlat34.x;
            u_xlat4.x = u_xlat30.x * u_xlat45;
            u_xlat19.xy = vec2(u_xlat2.z * float(3.0), u_xlat2.w * float(3.0));
            u_xlat49 = fract((-u_xlat19.x));
            u_xlat19.z = u_xlat49 + 0.5;
            u_xlat19.xy = fract(u_xlat19.xy);
            u_xlat19.xy = u_xlat19.xy + vec2(0.5, 0.5);
            u_xlat19.xyz = floor(u_xlat19.xyz);
            u_xlat49 = (-u_xlat19.x) + u_xlat19.z;
            u_xlat19.x = u_xlat49 * u_xlat19.y + u_xlat19.x;
            u_xlat34.x = (-u_xlat45) * u_xlat30.x + 1.0;
            u_xlat5.xyz = (-u_xlat19.xxx) + vec3(0.5, 0.0, 1.0);
            u_xlat6.xyz = u_xlat34.xxx * u_xlat5.xyz + u_xlat19.xxx;
            u_xlatb4.xz = lessThan(u_xlat4.xxxx, vec4(1.0, 0.0, 2.0, 0.0)).xz;
            u_xlat7.xyz = u_xlat19.xxx * vec3(0.0, 1.0, 0.0);
            u_xlat30.x = u_xlat45 * u_xlat30.x + -4.0;
            u_xlat30.x = exp2(u_xlat30.x);
            u_xlat30.x = u_xlat30.x + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat30.x = min(max(u_xlat30.x, 0.0), 1.0);
#else
            u_xlat30.x = clamp(u_xlat30.x, 0.0, 1.0);
#endif
            u_xlat5.xyz = u_xlat30.xxx * u_xlat5.zyy + u_xlat19.xxx;
            u_xlat19.xyz = (u_xlatb4.z) ? u_xlat7.xyz : u_xlat5.xyz;
            u_xlat4.xyz = (u_xlatb4.x) ? u_xlat6.xyz : u_xlat19.xyz;
        } else {
            u_xlat30.xy = vec2(_GrassDiffuse_ST.x * _GrassNormal_TexelSize.z, _GrassDiffuse_ST.y * _GrassNormal_TexelSize.w);
            u_xlatb30.xy = lessThan(vec4(1.0, 1.0, 1.0, 1.0), u_xlat30.xyxy).xy;
            u_xlatb30.x = u_xlatb30.y || u_xlatb30.x;
            u_xlat3.xy = _GrassNormal_TexelSize.zw;
            u_xlat3 = (u_xlatb30.x) ? u_xlat3 : vec4(1.0, 1.0, 0.0, 0.0);
            u_xlat1 = u_xlat1 + (-u_xlat3);
            u_xlat1 = vs_COLOR0.wwww * u_xlat1 + u_xlat3;
#ifdef UNITY_ADRENO_ES3
            u_xlatb30.x = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb30.x = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb30.x){
                u_xlat30.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                u_xlat3.xy = dFdx(u_xlat30.xy);
                u_xlat30.xy = dFdy(u_xlat30.xy);
                u_xlat33.x = dot(u_xlat3.xy, u_xlat3.xy);
                u_xlat48 = dot(u_xlat30.xy, u_xlat30.xy);
                u_xlat33.x = max(u_xlat48, u_xlat33.x);
                u_xlat33.x = log2(u_xlat33.x);
                u_xlat33.x = u_xlat33.x * 0.5;
                u_xlat33.x = max(u_xlat33.x, 0.0);
                u_xlat33.x = u_xlat33.x + 1.0;
                u_xlat48 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                u_xlat3.xy = vec2(u_xlat48) * u_xlat3.xy;
                u_xlat30.xy = u_xlat30.xy * vec2(u_xlat48);
                u_xlat3.xy = u_xlat3.xy / u_xlat33.xx;
                u_xlat30.xy = u_xlat30.xy / u_xlat33.xx;
                u_xlat18.x = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                u_xlat45 = dot(abs(u_xlat30.xy), abs(u_xlat30.xy));
                u_xlat33.x = sqrt(u_xlat18.x);
                u_xlat48 = sqrt(u_xlat45);
                u_xlat18.x = inversesqrt(u_xlat18.x);
                u_xlat3.x = u_xlat18.x * abs(u_xlat3.x);
                u_xlat45 = inversesqrt(u_xlat45);
                u_xlat30.x = u_xlat45 * abs(u_xlat30.x);
                u_xlat30.x = u_xlat30.x * u_xlat3.x;
                u_xlat30.x = (-u_xlat30.x) * u_xlat30.x + 1.0;
                u_xlat30.x = sqrt(u_xlat30.x);
                u_xlat45 = u_xlat48 * u_xlat33.x;
                u_xlat3.x = u_xlat30.x * u_xlat45;
                u_xlat18.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                u_xlat48 = fract((-u_xlat18.x));
                u_xlat18.z = u_xlat48 + 0.5;
                u_xlat18.xy = fract(u_xlat18.xy);
                u_xlat18.xy = u_xlat18.xy + vec2(0.5, 0.5);
                u_xlat18.xyz = floor(u_xlat18.xyz);
                u_xlat48 = (-u_xlat18.x) + u_xlat18.z;
                u_xlat18.x = u_xlat48 * u_xlat18.y + u_xlat18.x;
                u_xlat33.x = (-u_xlat45) * u_xlat30.x + 1.0;
                u_xlat5.xyz = (-u_xlat18.xxx) + vec3(0.5, 0.0, 1.0);
                u_xlat6.xyz = u_xlat33.xxx * u_xlat5.xyz + u_xlat18.xxx;
                u_xlatb3.xz = lessThan(u_xlat3.xxxx, vec4(1.0, 0.0, 2.0, 0.0)).xz;
                u_xlat7.xyz = u_xlat18.xxx * vec3(0.0, 1.0, 0.0);
                u_xlat30.x = u_xlat45 * u_xlat30.x + -4.0;
                u_xlat30.x = exp2(u_xlat30.x);
                u_xlat30.x = u_xlat30.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                u_xlat30.x = min(max(u_xlat30.x, 0.0), 1.0);
#else
                u_xlat30.x = clamp(u_xlat30.x, 0.0, 1.0);
#endif
                u_xlat5.xyz = u_xlat30.xxx * u_xlat5.zyy + u_xlat18.xxx;
                u_xlat18.xyz = (u_xlatb3.z) ? u_xlat7.xyz : u_xlat5.xyz;
                u_xlat4.xyz = (u_xlatb3.x) ? u_xlat6.xyz : u_xlat18.xyz;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb30.x = !!(u_xlat2.x>=u_xlat1.x);
#else
                u_xlatb30.x = u_xlat2.x>=u_xlat1.x;
#endif
                if(u_xlatb30.x){
                    u_xlat30.xy = vec2(u_xlat2.x * u_xlat2.z, u_xlat2.y * u_xlat2.w);
                    u_xlat2.xy = dFdx(u_xlat30.xy);
                    u_xlat30.xy = dFdy(u_xlat30.xy);
                    u_xlat3.x = dot(u_xlat2.xy, u_xlat2.xy);
                    u_xlat18.x = dot(u_xlat30.xy, u_xlat30.xy);
                    u_xlat3.x = max(u_xlat18.x, u_xlat3.x);
                    u_xlat3.x = log2(u_xlat3.x);
                    u_xlat3.x = u_xlat3.x * 0.5;
                    u_xlat3.x = max(u_xlat3.x, 0.0);
                    u_xlat3.x = u_xlat3.x + 1.0;
                    u_xlat18.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat2.xy = u_xlat2.xy * u_xlat18.xx;
                    u_xlat30.xy = u_xlat30.xy * u_xlat18.xx;
                    u_xlat2.xy = u_xlat2.xy / u_xlat3.xx;
                    u_xlat30.xy = u_xlat30.xy / u_xlat3.xx;
                    u_xlat17.x = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
                    u_xlat45 = dot(abs(u_xlat30.xy), abs(u_xlat30.xy));
                    u_xlat3.x = sqrt(u_xlat17.x);
                    u_xlat18.x = sqrt(u_xlat45);
                    u_xlat17.x = inversesqrt(u_xlat17.x);
                    u_xlat2.x = u_xlat17.x * abs(u_xlat2.x);
                    u_xlat45 = inversesqrt(u_xlat45);
                    u_xlat30.x = u_xlat45 * abs(u_xlat30.x);
                    u_xlat30.x = u_xlat30.x * u_xlat2.x;
                    u_xlat30.x = (-u_xlat30.x) * u_xlat30.x + 1.0;
                    u_xlat30.x = sqrt(u_xlat30.x);
                    u_xlat45 = u_xlat18.x * u_xlat3.x;
                    u_xlat2.x = u_xlat30.x * u_xlat45;
                    u_xlat17.xy = vec2(u_xlat2.z * float(3.0), u_xlat2.w * float(3.0));
                    u_xlat47 = fract((-u_xlat17.x));
                    u_xlat17.z = u_xlat47 + 0.5;
                    u_xlat17.xy = fract(u_xlat17.xy);
                    u_xlat17.xy = u_xlat17.xy + vec2(0.5, 0.5);
                    u_xlat17.xyz = floor(u_xlat17.xyz);
                    u_xlat47 = (-u_xlat17.x) + u_xlat17.z;
                    u_xlat17.x = u_xlat47 * u_xlat17.y + u_xlat17.x;
                    u_xlat32 = (-u_xlat45) * u_xlat30.x + 1.0;
                    u_xlat3.xyz = (-u_xlat17.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat5.xyz = vec3(u_xlat32) * u_xlat3.xyz + u_xlat17.xxx;
                    u_xlatb2.xz = lessThan(u_xlat2.xxxx, vec4(1.0, 0.0, 2.0, 0.0)).xz;
                    u_xlat6.xyz = u_xlat17.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat30.x = u_xlat45 * u_xlat30.x + -4.0;
                    u_xlat30.x = exp2(u_xlat30.x);
                    u_xlat30.x = u_xlat30.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat30.x = min(max(u_xlat30.x, 0.0), 1.0);
#else
                    u_xlat30.x = clamp(u_xlat30.x, 0.0, 1.0);
#endif
                    u_xlat3.xyz = u_xlat30.xxx * u_xlat3.zyy + u_xlat17.xxx;
                    u_xlat17.xyz = (u_xlatb2.z) ? u_xlat6.xyz : u_xlat3.xyz;
                    u_xlat4.xyz = (u_xlatb2.x) ? u_xlat5.xyz : u_xlat17.xyz;
                } else {
                    u_xlat30.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat1.xy = dFdx(u_xlat30.xy);
                    u_xlat30.xy = dFdy(u_xlat30.xy);
                    u_xlat2.x = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat17.x = dot(u_xlat30.xy, u_xlat30.xy);
                    u_xlat2.x = max(u_xlat17.x, u_xlat2.x);
                    u_xlat2.x = log2(u_xlat2.x);
                    u_xlat2.x = u_xlat2.x * 0.5;
                    u_xlat2.x = max(u_xlat2.x, 0.0);
                    u_xlat2.x = u_xlat2.x + 1.0;
                    u_xlat17.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat1.xy = u_xlat1.xy * u_xlat17.xx;
                    u_xlat30.xy = u_xlat30.xy * u_xlat17.xx;
                    u_xlat1.xy = u_xlat1.xy / u_xlat2.xx;
                    u_xlat30.xy = u_xlat30.xy / u_xlat2.xx;
                    u_xlat16.x = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat45 = dot(abs(u_xlat30.xy), abs(u_xlat30.xy));
                    u_xlat2.x = sqrt(u_xlat16.x);
                    u_xlat17.x = sqrt(u_xlat45);
                    u_xlat16.x = inversesqrt(u_xlat16.x);
                    u_xlat1.x = u_xlat16.x * abs(u_xlat1.x);
                    u_xlat45 = inversesqrt(u_xlat45);
                    u_xlat30.x = u_xlat45 * abs(u_xlat30.x);
                    u_xlat30.x = u_xlat30.x * u_xlat1.x;
                    u_xlat30.x = (-u_xlat30.x) * u_xlat30.x + 1.0;
                    u_xlat30.x = sqrt(u_xlat30.x);
                    u_xlat45 = u_xlat17.x * u_xlat2.x;
                    u_xlat1.x = u_xlat30.x * u_xlat45;
                    u_xlat16.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat46 = fract((-u_xlat16.x));
                    u_xlat16.z = u_xlat46 + 0.5;
                    u_xlat16.xy = fract(u_xlat16.xy);
                    u_xlat16.xy = u_xlat16.xy + vec2(0.5, 0.5);
                    u_xlat16.xyz = floor(u_xlat16.xyz);
                    u_xlat46 = (-u_xlat16.x) + u_xlat16.z;
                    u_xlat16.x = u_xlat46 * u_xlat16.y + u_xlat16.x;
                    u_xlat31 = (-u_xlat45) * u_xlat30.x + 1.0;
                    u_xlat2.xyz = (-u_xlat16.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat3.xyz = vec3(u_xlat31) * u_xlat2.xyz + u_xlat16.xxx;
                    u_xlatb1.xz = lessThan(u_xlat1.xxxx, vec4(1.0, 0.0, 2.0, 0.0)).xz;
                    u_xlat5.xyz = u_xlat16.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat30.x = u_xlat45 * u_xlat30.x + -4.0;
                    u_xlat30.x = exp2(u_xlat30.x);
                    u_xlat30.x = u_xlat30.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat30.x = min(max(u_xlat30.x, 0.0), 1.0);
#else
                    u_xlat30.x = clamp(u_xlat30.x, 0.0, 1.0);
#endif
                    u_xlat2.xyz = u_xlat30.xxx * u_xlat2.zyy + u_xlat16.xxx;
                    u_xlat16.xyz = (u_xlatb1.z) ? u_xlat5.xyz : u_xlat2.xyz;
                    u_xlat4.xyz = (u_xlatb1.x) ? u_xlat3.xyz : u_xlat16.xyz;
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat4.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb30.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 100.0, 102.0)).xy;
    u_xlatb30.x = u_xlatb30.y || u_xlatb30.x;
    if(u_xlatb30.x){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb30.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 101.0, 103.0)).xy;
    u_xlatb30.x = u_xlatb30.y || u_xlatb30.x;
    if(u_xlatb30.x){
        SV_Target0 = vec4(0.400000006, 0.400000006, 0.400000006, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30.x = !!(vs_COLOR0.w<0.99000001);
#else
    u_xlatb30.x = vs_COLOR0.w<0.99000001;
#endif
    if(u_xlatb30.x){
        u_xlat10_1 = texture(_GrassNormal, vs_TEXCOORD0.xy);
        u_xlat16_8.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_8.xy = u_xlat16_8.xy * vec2(_GrassNormalScale);
        u_xlat16_53 = u_xlat10_1.w * _UseGrassSpecular;
        u_xlat10_1.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.xy).xyz;
        u_xlat16_9.xyz = u_xlat10_1.xyz;
    } else {
        u_xlat16_9.x = float(0.0);
        u_xlat16_9.y = float(0.0);
        u_xlat16_9.z = float(0.0);
        u_xlat16_8.x = float(0.0);
        u_xlat16_8.y = float(0.0);
        u_xlat16_8.z = float(1.0);
        u_xlat16_53 = float(0.0);
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30.x = !!(0.00999999978<vs_COLOR0.w);
#else
    u_xlatb30.x = 0.00999999978<vs_COLOR0.w;
#endif
    if(u_xlatb30.x){
        u_xlat10_1.xyz = texture(_Normal0, vs_TEXCOORD0.zw).xyw;
        u_xlat10_2.xyz = texture(_Normal2, vs_TEXCOORD2.xy).xyw;
        u_xlat16_10.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_40.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_40.xy = u_xlat16_40.xy * vec2(_Normal2Scale);
        u_xlat16_54 = (-u_xlat0.y) + 1.0;
        u_xlat16_40.xy = vec2(u_xlat16_54) * u_xlat16_40.xy;
        u_xlat16_40.xy = u_xlat16_40.xy * vs_COLOR0.xx;
        u_xlat10_3 = texture(_Diffuse1, vs_TEXCOORD0.zw);
        u_xlat30.xy = vec2(vs_TEXCOORD2.z * float(_DetailNormalUVScale), vs_TEXCOORD2.w * float(_DetailNormalUVScale));
        u_xlat10_1.xyw = texture(_DetailNormal, u_xlat30.xy).xyw;
        u_xlat16_11.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_11.xy = u_xlat16_11.xy * vec2(_DetailNormalScale);
        u_xlat16_54 = (-u_xlat0.x) + 1.0;
        u_xlat16_11.xy = vec2(u_xlat16_54) * u_xlat16_11.xy;
        u_xlat10_4 = texture(_Diffuse2, vs_TEXCOORD2.xy);
        u_xlat10_5 = texture(_DetailDiffuse, vs_TEXCOORD2.zw);
        u_xlat16_54 = u_xlat10_4.w * _UseDiffuseTwoHeight;
        u_xlat16_41 = u_xlat10_5.w * _UseDetailDiffuseHeight;
        u_xlat16_12.xyz = u_xlat10_3.xyz + (-u_xlat10_4.xyz);
        u_xlat16_56 = u_xlat10_3.w * _UseDiffuseOneHeight + (-u_xlat16_54);
        u_xlat16_12.xyz = u_xlat0.yyy * u_xlat16_12.xyz + u_xlat10_4.xyz;
        u_xlat16_54 = u_xlat0.y * u_xlat16_56 + u_xlat16_54;
        u_xlat16_56 = u_xlat0.x * _DetailBlendVal;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_56 = min(max(u_xlat16_56, 0.0), 1.0);
#else
        u_xlat16_56 = clamp(u_xlat16_56, 0.0, 1.0);
#endif
        u_xlat16_57 = (-u_xlat16_56) + 1.0;
        u_xlat16_41 = u_xlat16_41 * u_xlat16_57;
        u_xlat16_54 = max(u_xlat16_54, u_xlat16_41);
        u_xlat16_13.xyz = u_xlat10_5.xyz * u_xlat16_12.xyz;
        u_xlat16_14.xyz = u_xlat16_13.xyz * vec3(4.0, 4.0, 4.0);
        u_xlat16_12.xyz = (-u_xlat16_13.xyz) * vec3(4.0, 4.0, 4.0) + u_xlat16_12.xyz;
        u_xlat16_12.xyz = vec3(u_xlat16_56) * u_xlat16_12.xyz + u_xlat16_14.xyz;
        u_xlat16_12.xyz = min(u_xlat16_12.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_41 = u_xlat10_2.z * _UseSpecularTwo;
        u_xlat16_56 = u_xlat10_1.w * _UseDetailSpecular;
        u_xlat16_13.x = _UseSpecularOne * u_xlat10_1.z + (-u_xlat16_41);
        u_xlat16_41 = u_xlat0.y * u_xlat16_13.x + u_xlat16_41;
        u_xlat16_56 = u_xlat16_57 * u_xlat16_56;
        u_xlat16_41 = max(u_xlat16_56, u_xlat16_41);
        u_xlat16_10.xy = u_xlat16_10.xy * vec2(_Normal0Scale) + u_xlat16_40.xy;
        u_xlat16_10.xy = u_xlat16_11.xy * vs_COLOR0.xx + u_xlat16_10.xy;
    } else {
        u_xlat16_12.x = float(0.0);
        u_xlat16_12.y = float(0.0);
        u_xlat16_12.z = float(0.0);
        u_xlat16_10.x = float(0.0);
        u_xlat16_10.y = float(0.0);
        u_xlat16_54 = 1.0;
        u_xlat16_41 = 0.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor);
#endif
    u_xlat16_11.xyw = u_xlat16_12.xyz * _TintColor.xyz;
    u_xlat16_11.xyw = (bool(u_xlatb0)) ? u_xlat16_11.xyw : u_xlat16_12.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend);
#endif
    u_xlat16_15 = u_xlat16_54;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_30 = vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_54 = _HeightContrast * 10.0;
    u_xlat16_15 = u_xlat16_15 + -1.0;
    u_xlat16_55 = _HeightSpread + 0.100000001;
    u_xlat16_30 = log2(u_xlat16_30);
    u_xlat16_30 = u_xlat16_30 * u_xlat16_55;
    u_xlat16_30 = exp2(u_xlat16_30);
    u_xlat16_15 = u_xlat16_30 * 2.0 + u_xlat16_15;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_30 = _HeightContrast * 10.0 + 1.0;
    u_xlat16_30 = _HeightContrast * 10.0 + u_xlat16_30;
    u_xlat15 = u_xlat16_15 * u_xlat16_30 + (-u_xlat16_54);
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_54 = (u_xlatb0) ? u_xlat15 : vs_COLOR0.w;
    u_xlat16_10.z = 1.0;
    u_xlat16_10.xyz = (-u_xlat16_8.xyz) + u_xlat16_10.xyz;
    u_xlat16_8.xyz = vec3(u_xlat16_54) * u_xlat16_10.xyz + u_xlat16_8.xyz;
    u_xlat16_10.x = (-u_xlat16_53) + u_xlat16_41;
    u_xlat16_53 = u_xlat16_54 * u_xlat16_10.x + u_xlat16_53;
    u_xlat16_10.xyz = (-u_xlat16_9.xyz) + u_xlat16_11.xyw;
    u_xlat16_9.xyz = vec3(u_xlat16_54) * u_xlat16_10.xyz + u_xlat16_9.xyz;
    u_xlat16_53 = u_xlat16_53 + _Shininess;
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, u_xlat16_8.xyz);
    u_xlat0.y = dot(vs_TEXCOORD4.xyz, u_xlat16_8.xyz);
    u_xlat0.z = dot(vs_TEXCOORD5.xyz, u_xlat16_8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb45 = !!(vs_TEXCOORD1.w<100.0);
#else
    u_xlatb45 = vs_TEXCOORD1.w<100.0;
#endif
    if(u_xlatb45){
        u_xlat1.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
        u_xlat45 = texture(_CameraDepthBlendTexture, u_xlat1.xy).x;
        u_xlat45 = _ZBufferParams.z * u_xlat45 + _ZBufferParams.w;
        u_xlat45 = float(1.0) / u_xlat45;
        u_xlat45 = u_xlat45 + (-vs_TEXCOORD1.w);
        u_xlat45 = abs(u_xlat45) * _DepthBiasScaled;
        u_xlat45 = u_xlat45 * 0.600000024;
#ifdef UNITY_ADRENO_ES3
        u_xlat45 = min(max(u_xlat45, 0.0), 1.0);
#else
        u_xlat45 = clamp(u_xlat45, 0.0, 1.0);
#endif
        u_xlat45 = sqrt(u_xlat45);
        u_xlat10_2.xyz = texture(_CameraDepthBlendNormTexture, u_xlat1.xy).xyz;
        u_xlat16_8.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat10_1.xyz = texture(_CameraDepthBlendDiffTexture, u_xlat1.xy).xyz;
        u_xlat16_54 = u_xlat0.y * _DepthBlendAO;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_54 = min(max(u_xlat16_54, 0.0), 1.0);
#else
        u_xlat16_54 = clamp(u_xlat16_54, 0.0, 1.0);
#endif
        u_xlat46 = (-u_xlat45) + 1.0;
        u_xlat46 = u_xlat16_54 * u_xlat46 + u_xlat45;
        u_xlat46 = max(u_xlat46, 0.899999976);
        u_xlat2.xyz = u_xlat16_9.xyz * vec3(u_xlat46) + (-u_xlat10_1.xyz);
        u_xlat9.xyz = vec3(u_xlat45) * u_xlat2.xyz + u_xlat10_1.xyz;
        u_xlat1.xyz = u_xlat0.xyz + (-u_xlat16_8.xyz);
        u_xlat1.xyz = vec3(u_xlat45) * u_xlat1.xyz + u_xlat16_8.xyz;
        u_xlat16_9.xyz = u_xlat9.xyz;
        u_xlat16_1.xyz = u_xlat1.xyz;
    } else {
        u_xlat16_1.xyz = u_xlat0.xyz;
    //ENDIF
    }
    u_xlat16_8.x = u_xlat16_53 * _Terrain_Smoothness;
    u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
    SV_Target2.w = min(u_xlat16_8.x, 0.5);
    u_xlat16_8.xyz = u_xlat16_9.xyz * vec3(vec3(_Terrain_Specular, _Terrain_Specular, _Terrain_Specular));
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat16_53 = max(u_xlat16_8.z, u_xlat16_8.y);
    u_xlat16_53 = max(u_xlat16_53, u_xlat16_8.x);
    u_xlat16_53 = (-u_xlat16_53) + 1.0;
    SV_Target1.xyz = vec3(u_xlat16_53) * u_xlat16_9.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_53 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_53 : u_xlat16_8.z;
    SV_Target0.w = 0.0;
    SV_Target1.w = _SSAO_Intensity;
    SV_Target2.xy = u_xlat16_8.xy;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _Diffuse1_ST;
uniform 	float _UVDiffuse2;
uniform 	vec4 _Diffuse2_ST;
uniform 	float _UVDetail;
uniform 	vec4 _DetailDiffuse_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec2 u_xlat12;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat15 = u_xlat15 + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat15 = u_xlat15 + u_xlat2.x;
    u_xlat15 = u_xlat15 * 0.330000013;
    u_xlat2.xy = vec2(u_xlat15) * in_TEXCOORD0.xy;
    u_xlat12.xy = vec2(u_xlat15) * in_TEXCOORD1.xy;
    vs_TEXCOORD0.xy = u_xlat2.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Diffuse1_ST.xy + _Diffuse1_ST.zw;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat15 * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UVDiffuse2==0.0);
#else
    u_xlatb15 = _UVDiffuse2==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat2.xy : u_xlat12.xy;
    vs_TEXCOORD2.xy = u_xlat1.xy * _Diffuse2_ST.xy + _Diffuse2_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UVDetail==0.0);
#else
    u_xlatb15 = _UVDetail==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat2.xy : u_xlat12.xy;
    vs_TEXCOORD2.zw = u_xlat1.xy * _DetailDiffuse_ST.xy + _DetailDiffuse_ST.zw;
    vs_TEXCOORD3.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz;
    vs_TEXCOORD3.y = u_xlat16_4.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat0.y;
    vs_TEXCOORD5.w = u_xlat0.z;
    vs_TEXCOORD4.y = u_xlat16_4.y;
    vs_TEXCOORD5.y = u_xlat16_4.z;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	mediump float _HeightSpread;
uniform 	mediump float _HeightContrast;
uniform 	mediump float _UseTintColor;
uniform 	mediump float _UseDiffuseOneHeight;
uniform 	mediump float _UseDiffuseTwoHeight;
uniform 	mediump float _UseDetailDiffuseHeight;
uniform 	mediump float _UseGrassHeightBlend;
uniform 	mediump float _UseGrassSpecular;
uniform 	mediump float _UseSpecularOne;
uniform 	mediump float _UseSpecularTwo;
uniform 	mediump float _UseDetailSpecular;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _SSAO_Intensity;
uniform 	mediump float _Terrain_Smoothness;
uniform 	mediump float _Terrain_Specular;
uniform 	mediump float _Shininess;
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _GrassDiffuse_TexelSize;
uniform 	vec4 _GrassNormal_TexelSize;
uniform 	vec4 _Diffuse1_ST;
uniform 	vec4 _Diffuse1_TexelSize;
uniform 	vec4 _Normal0_TexelSize;
uniform 	vec4 _Diffuse2_ST;
uniform 	vec4 _Normal2_TexelSize;
uniform 	mediump float _Diffuse2Distance;
uniform 	mediump float _Diffuse2Fade;
uniform 	vec4 _DetailDiffuse_ST;
uniform 	vec4 _DetailDiffuse_TexelSize;
uniform 	vec4 _DetailNormal_TexelSize;
uniform 	mediump float _DetailNormalUVScale;
uniform 	mediump float _DetailBlendVal;
uniform 	mediump float _DetailDistance;
uniform 	mediump float _DetailFade;
uniform 	mediump float _DepthBiasScaled;
uniform 	mediump float _DepthBlendAO;
uniform lowp sampler2D _GrassDiffuse;
uniform lowp sampler2D _GrassNormal;
uniform lowp sampler2D _Normal0;
uniform lowp sampler2D _Normal2;
uniform lowp sampler2D _Diffuse1;
uniform lowp sampler2D _DetailNormal;
uniform lowp sampler2D _Diffuse2;
uniform lowp sampler2D _DetailDiffuse;
uniform highp sampler2D _CameraDepthBlendTexture;
uniform lowp sampler2D _CameraDepthBlendNormTexture;
uniform lowp sampler2D _CameraDepthBlendDiffTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec3 u_xlatb1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
bvec3 u_xlatb2;
vec4 u_xlat3;
lowp vec4 u_xlat10_3;
bvec3 u_xlatb3;
vec4 u_xlat4;
lowp vec4 u_xlat10_4;
bvec3 u_xlatb4;
vec3 u_xlat5;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec4 u_xlat16_11;
mediump vec3 u_xlat16_12;
mediump vec3 u_xlat16_13;
mediump vec3 u_xlat16_14;
float u_xlat15;
mediump float u_xlat16_15;
vec3 u_xlat16;
vec3 u_xlat17;
vec3 u_xlat18;
vec3 u_xlat19;
vec2 u_xlat30;
mediump float u_xlat16_30;
bvec2 u_xlatb30;
float u_xlat31;
float u_xlat32;
vec2 u_xlat33;
bvec2 u_xlatb33;
vec2 u_xlat34;
mediump vec2 u_xlat16_40;
mediump float u_xlat16_41;
float u_xlat45;
bool u_xlatb45;
float u_xlat46;
float u_xlat47;
float u_xlat48;
bool u_xlatb48;
float u_xlat49;
mediump float u_xlat16_53;
mediump float u_xlat16_54;
mediump float u_xlat16_55;
mediump float u_xlat16_56;
mediump float u_xlat16_57;
void main()
{
    u_xlat0.x = vs_TEXCOORD3.w;
    u_xlat0.y = vs_TEXCOORD4.w;
    u_xlat0.z = vs_TEXCOORD5.w;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x / _Diffuse2Distance;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat15 + 9.99999975e-05;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Diffuse2Fade;
    u_xlat0.y = exp2(u_xlat15);
    u_xlat0.x = u_xlat0.x / _DetailDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + 9.99999975e-05;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _DetailFade;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.xy = min(u_xlat0.xy, vec2(1.0, 1.0));
    u_xlat1.zw = vec2(vs_TEXCOORD0.z + (-_Diffuse1_ST.z), vs_TEXCOORD0.w + (-_Diffuse1_ST.w));
    u_xlat30.xy = vec2(_Diffuse1_ST.x * _Diffuse1_TexelSize.z, _Diffuse1_ST.y * _Diffuse1_TexelSize.w);
    u_xlatb30.xy = lessThan(vec4(1.0, 1.0, 1.0, 1.0), u_xlat30.xyxy).xy;
    u_xlatb30.x = u_xlatb30.y || u_xlatb30.x;
    u_xlat1.xy = _Diffuse1_TexelSize.zw;
    u_xlat2 = (u_xlatb30.x) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
    u_xlat3.xy = vec2(_Diffuse1_ST.x * _Normal0_TexelSize.z, _Diffuse1_ST.y * _Normal0_TexelSize.w);
    u_xlatb3.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat3.xyxx).xy;
    u_xlatb45 = u_xlatb3.y || u_xlatb3.x;
    u_xlat1.xy = _Normal0_TexelSize.zw;
    u_xlat1 = (bool(u_xlatb45)) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
    u_xlat3.xy = (bool(u_xlatb45)) ? _Diffuse1_ST.xy : vec2(1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb45 = !!(u_xlat0.y<0.800000012);
#else
    u_xlatb45 = u_xlat0.y<0.800000012;
#endif
    u_xlat4.zw = vec2(vs_TEXCOORD2.x + (-_Diffuse2_ST.z), vs_TEXCOORD2.y + (-_Diffuse2_ST.w));
    u_xlat33.xy = u_xlat1.xy * u_xlat3.xy;
    u_xlat5.xy = vec2(_Diffuse2_ST.x * _Normal2_TexelSize.z, _Diffuse2_ST.y * _Normal2_TexelSize.w);
    u_xlatb33.xy = lessThan(u_xlat33.xyxy, u_xlat5.xyxy).xy;
    u_xlatb33.x = u_xlatb33.y || u_xlatb33.x;
    u_xlat4.xy = _Normal2_TexelSize.zw;
    u_xlat4 = (u_xlatb33.x) ? u_xlat4 : u_xlat1;
    u_xlat1 = (bool(u_xlatb45)) ? u_xlat4 : u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb48 = !!(u_xlat0.x<0.800000012);
#else
    u_xlatb48 = u_xlat0.x<0.800000012;
#endif
    if(u_xlatb48){
        u_xlat4.xy = (u_xlatb30.x) ? _Diffuse1_ST.xy : vec2(1.0, 1.0);
        u_xlat33.xy = (u_xlatb33.x) ? _Diffuse2_ST.xy : u_xlat3.xy;
        u_xlat30.xy = (bool(u_xlatb45)) ? u_xlat33.xy : u_xlat3.xy;
        u_xlat3.zw = vec2(vs_TEXCOORD2.z + (-_DetailDiffuse_ST.z), vs_TEXCOORD2.w + (-_DetailDiffuse_ST.w));
        u_xlat4.xy = u_xlat2.xy * u_xlat4.xy;
        u_xlat34.xy = vec2(_DetailDiffuse_ST.x * _DetailDiffuse_TexelSize.z, _DetailDiffuse_ST.y * _DetailDiffuse_TexelSize.w);
        u_xlatb4.xy = lessThan(u_xlat4.xyxx, u_xlat34.xyxx).xy;
        u_xlatb4.x = u_xlatb4.y || u_xlatb4.x;
        u_xlat3.xy = _DetailDiffuse_TexelSize.zw;
        u_xlat2 = (u_xlatb4.x) ? u_xlat3 : u_xlat2;
        u_xlat30.xy = u_xlat30.xy * u_xlat1.xy;
        u_xlat4.xy = vec2(_DetailDiffuse_ST.x * _DetailNormal_TexelSize.z, _DetailDiffuse_ST.y * _DetailNormal_TexelSize.w);
        u_xlatb30.xy = lessThan(u_xlat30.xyxy, u_xlat4.xyxy).xy;
        u_xlatb30.x = u_xlatb30.y || u_xlatb30.x;
        u_xlat3.xy = _DetailNormal_TexelSize.zw;
        u_xlat1 = (u_xlatb30.x) ? u_xlat3 : u_xlat1;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30.x = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb30.x = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb30.x){
        u_xlatb3.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat4 = (u_xlatb3.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat4 = (u_xlatb3.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat4;
        u_xlat3 = (u_xlatb3.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat4;
        SV_Target0 = u_xlat3;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30.x = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb30.x = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb30.x){
        u_xlat10_3.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.xy).xyz;
        SV_Target0.xyz = u_xlat10_3.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30.x = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb30.x = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb30.x){
        u_xlat30.x = max(_GrassDiffuse_TexelSize.w, _GrassDiffuse_TexelSize.z);
        u_xlat30.x = max(u_xlat30.x, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb45 = !!(256.0<u_xlat30.x);
#else
        u_xlatb45 = 256.0<u_xlat30.x;
#endif
        u_xlatb3.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), u_xlat30.xxxx).xy;
        u_xlat4 = (u_xlatb3.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat3 = (u_xlatb3.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat4;
        u_xlat3 = (bool(u_xlatb45)) ? u_xlat3 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat3;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30.x = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb30.x = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb30.x){
        u_xlat30.xy = vec2(vs_TEXCOORD0.x * _GrassDiffuse_TexelSize.z, vs_TEXCOORD0.y * _GrassDiffuse_TexelSize.w);
        u_xlat3.xy = dFdx(u_xlat30.xy);
        u_xlat30.xy = dFdy(u_xlat30.xy);
        u_xlat3.x = dot(u_xlat3.xy, u_xlat3.xy);
        u_xlat30.x = dot(u_xlat30.xy, u_xlat30.xy);
        u_xlat30.x = max(u_xlat30.x, u_xlat3.x);
        u_xlat30.x = log2(u_xlat30.x);
        u_xlat30.x = u_xlat30.x * 0.5;
        u_xlat30.x = max(u_xlat30.x, 0.0);
        u_xlat30.x = u_xlat30.x + 1.0;
        u_xlat45 = max(_GrassDiffuse_TexelSize.w, _GrassDiffuse_TexelSize.z);
        u_xlat30.x = u_xlat45 / u_xlat30.x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb45 = !!(256.0<u_xlat30.x);
#else
        u_xlatb45 = 256.0<u_xlat30.x;
#endif
        u_xlatb3.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), u_xlat30.xxxx).xy;
        u_xlat4 = (u_xlatb3.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat3 = (u_xlatb3.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat4;
        u_xlat3 = (bool(u_xlatb45)) ? u_xlat3 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat3;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30.x = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb30.x = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb30.x){
        u_xlat3.zw = vec2(vs_TEXCOORD0.x + (-_GrassDiffuse_ST.z), vs_TEXCOORD0.y + (-_GrassDiffuse_ST.w));
        u_xlat30.xy = vec2(_GrassDiffuse_ST.x * _GrassDiffuse_TexelSize.z, _GrassDiffuse_ST.y * _GrassDiffuse_TexelSize.w);
        u_xlatb30.xy = lessThan(vec4(1.0, 1.0, 1.0, 1.0), u_xlat30.xyxy).xy;
        u_xlatb30.x = u_xlatb30.y || u_xlatb30.x;
        u_xlat3.xy = _GrassDiffuse_TexelSize.zw;
        u_xlat4 = (u_xlatb30.x) ? u_xlat3 : vec4(1.0, 1.0, 0.0, 0.0);
        u_xlat2 = u_xlat2 + (-u_xlat4);
        u_xlat2 = vs_COLOR0.wwww * u_xlat2 + u_xlat4;
#ifdef UNITY_ADRENO_ES3
        u_xlatb30.x = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb30.x = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb30.x){
            u_xlat30.xy = vec2(u_xlat2.x * u_xlat2.z, u_xlat2.y * u_xlat2.w);
            u_xlat4.xy = dFdx(u_xlat30.xy);
            u_xlat30.xy = dFdy(u_xlat30.xy);
            u_xlat34.x = dot(u_xlat4.xy, u_xlat4.xy);
            u_xlat49 = dot(u_xlat30.xy, u_xlat30.xy);
            u_xlat34.x = max(u_xlat49, u_xlat34.x);
            u_xlat34.x = log2(u_xlat34.x);
            u_xlat34.x = u_xlat34.x * 0.5;
            u_xlat34.x = max(u_xlat34.x, 0.0);
            u_xlat34.x = u_xlat34.x + 1.0;
            u_xlat49 = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat4.xy = vec2(u_xlat49) * u_xlat4.xy;
            u_xlat30.xy = u_xlat30.xy * vec2(u_xlat49);
            u_xlat4.xy = u_xlat4.xy / u_xlat34.xx;
            u_xlat30.xy = u_xlat30.xy / u_xlat34.xx;
            u_xlat19.x = dot(abs(u_xlat4.xy), abs(u_xlat4.xy));
            u_xlat45 = dot(abs(u_xlat30.xy), abs(u_xlat30.xy));
            u_xlat34.x = sqrt(u_xlat19.x);
            u_xlat49 = sqrt(u_xlat45);
            u_xlat19.x = inversesqrt(u_xlat19.x);
            u_xlat4.x = u_xlat19.x * abs(u_xlat4.x);
            u_xlat45 = inversesqrt(u_xlat45);
            u_xlat30.x = u_xlat45 * abs(u_xlat30.x);
            u_xlat30.x = u_xlat30.x * u_xlat4.x;
            u_xlat30.x = (-u_xlat30.x) * u_xlat30.x + 1.0;
            u_xlat30.x = sqrt(u_xlat30.x);
            u_xlat45 = u_xlat49 * u_xlat34.x;
            u_xlat4.x = u_xlat30.x * u_xlat45;
            u_xlat19.xy = vec2(u_xlat2.z * float(3.0), u_xlat2.w * float(3.0));
            u_xlat49 = fract((-u_xlat19.x));
            u_xlat19.z = u_xlat49 + 0.5;
            u_xlat19.xy = fract(u_xlat19.xy);
            u_xlat19.xy = u_xlat19.xy + vec2(0.5, 0.5);
            u_xlat19.xyz = floor(u_xlat19.xyz);
            u_xlat49 = (-u_xlat19.x) + u_xlat19.z;
            u_xlat19.x = u_xlat49 * u_xlat19.y + u_xlat19.x;
            u_xlat34.x = (-u_xlat45) * u_xlat30.x + 1.0;
            u_xlat5.xyz = (-u_xlat19.xxx) + vec3(0.5, 0.0, 1.0);
            u_xlat6.xyz = u_xlat34.xxx * u_xlat5.xyz + u_xlat19.xxx;
            u_xlatb4.xz = lessThan(u_xlat4.xxxx, vec4(1.0, 0.0, 2.0, 0.0)).xz;
            u_xlat7.xyz = u_xlat19.xxx * vec3(0.0, 1.0, 0.0);
            u_xlat30.x = u_xlat45 * u_xlat30.x + -4.0;
            u_xlat30.x = exp2(u_xlat30.x);
            u_xlat30.x = u_xlat30.x + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat30.x = min(max(u_xlat30.x, 0.0), 1.0);
#else
            u_xlat30.x = clamp(u_xlat30.x, 0.0, 1.0);
#endif
            u_xlat5.xyz = u_xlat30.xxx * u_xlat5.zyy + u_xlat19.xxx;
            u_xlat19.xyz = (u_xlatb4.z) ? u_xlat7.xyz : u_xlat5.xyz;
            u_xlat4.xyz = (u_xlatb4.x) ? u_xlat6.xyz : u_xlat19.xyz;
        } else {
            u_xlat30.xy = vec2(_GrassDiffuse_ST.x * _GrassNormal_TexelSize.z, _GrassDiffuse_ST.y * _GrassNormal_TexelSize.w);
            u_xlatb30.xy = lessThan(vec4(1.0, 1.0, 1.0, 1.0), u_xlat30.xyxy).xy;
            u_xlatb30.x = u_xlatb30.y || u_xlatb30.x;
            u_xlat3.xy = _GrassNormal_TexelSize.zw;
            u_xlat3 = (u_xlatb30.x) ? u_xlat3 : vec4(1.0, 1.0, 0.0, 0.0);
            u_xlat1 = u_xlat1 + (-u_xlat3);
            u_xlat1 = vs_COLOR0.wwww * u_xlat1 + u_xlat3;
#ifdef UNITY_ADRENO_ES3
            u_xlatb30.x = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb30.x = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb30.x){
                u_xlat30.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                u_xlat3.xy = dFdx(u_xlat30.xy);
                u_xlat30.xy = dFdy(u_xlat30.xy);
                u_xlat33.x = dot(u_xlat3.xy, u_xlat3.xy);
                u_xlat48 = dot(u_xlat30.xy, u_xlat30.xy);
                u_xlat33.x = max(u_xlat48, u_xlat33.x);
                u_xlat33.x = log2(u_xlat33.x);
                u_xlat33.x = u_xlat33.x * 0.5;
                u_xlat33.x = max(u_xlat33.x, 0.0);
                u_xlat33.x = u_xlat33.x + 1.0;
                u_xlat48 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                u_xlat3.xy = vec2(u_xlat48) * u_xlat3.xy;
                u_xlat30.xy = u_xlat30.xy * vec2(u_xlat48);
                u_xlat3.xy = u_xlat3.xy / u_xlat33.xx;
                u_xlat30.xy = u_xlat30.xy / u_xlat33.xx;
                u_xlat18.x = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                u_xlat45 = dot(abs(u_xlat30.xy), abs(u_xlat30.xy));
                u_xlat33.x = sqrt(u_xlat18.x);
                u_xlat48 = sqrt(u_xlat45);
                u_xlat18.x = inversesqrt(u_xlat18.x);
                u_xlat3.x = u_xlat18.x * abs(u_xlat3.x);
                u_xlat45 = inversesqrt(u_xlat45);
                u_xlat30.x = u_xlat45 * abs(u_xlat30.x);
                u_xlat30.x = u_xlat30.x * u_xlat3.x;
                u_xlat30.x = (-u_xlat30.x) * u_xlat30.x + 1.0;
                u_xlat30.x = sqrt(u_xlat30.x);
                u_xlat45 = u_xlat48 * u_xlat33.x;
                u_xlat3.x = u_xlat30.x * u_xlat45;
                u_xlat18.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                u_xlat48 = fract((-u_xlat18.x));
                u_xlat18.z = u_xlat48 + 0.5;
                u_xlat18.xy = fract(u_xlat18.xy);
                u_xlat18.xy = u_xlat18.xy + vec2(0.5, 0.5);
                u_xlat18.xyz = floor(u_xlat18.xyz);
                u_xlat48 = (-u_xlat18.x) + u_xlat18.z;
                u_xlat18.x = u_xlat48 * u_xlat18.y + u_xlat18.x;
                u_xlat33.x = (-u_xlat45) * u_xlat30.x + 1.0;
                u_xlat5.xyz = (-u_xlat18.xxx) + vec3(0.5, 0.0, 1.0);
                u_xlat6.xyz = u_xlat33.xxx * u_xlat5.xyz + u_xlat18.xxx;
                u_xlatb3.xz = lessThan(u_xlat3.xxxx, vec4(1.0, 0.0, 2.0, 0.0)).xz;
                u_xlat7.xyz = u_xlat18.xxx * vec3(0.0, 1.0, 0.0);
                u_xlat30.x = u_xlat45 * u_xlat30.x + -4.0;
                u_xlat30.x = exp2(u_xlat30.x);
                u_xlat30.x = u_xlat30.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                u_xlat30.x = min(max(u_xlat30.x, 0.0), 1.0);
#else
                u_xlat30.x = clamp(u_xlat30.x, 0.0, 1.0);
#endif
                u_xlat5.xyz = u_xlat30.xxx * u_xlat5.zyy + u_xlat18.xxx;
                u_xlat18.xyz = (u_xlatb3.z) ? u_xlat7.xyz : u_xlat5.xyz;
                u_xlat4.xyz = (u_xlatb3.x) ? u_xlat6.xyz : u_xlat18.xyz;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb30.x = !!(u_xlat2.x>=u_xlat1.x);
#else
                u_xlatb30.x = u_xlat2.x>=u_xlat1.x;
#endif
                if(u_xlatb30.x){
                    u_xlat30.xy = vec2(u_xlat2.x * u_xlat2.z, u_xlat2.y * u_xlat2.w);
                    u_xlat2.xy = dFdx(u_xlat30.xy);
                    u_xlat30.xy = dFdy(u_xlat30.xy);
                    u_xlat3.x = dot(u_xlat2.xy, u_xlat2.xy);
                    u_xlat18.x = dot(u_xlat30.xy, u_xlat30.xy);
                    u_xlat3.x = max(u_xlat18.x, u_xlat3.x);
                    u_xlat3.x = log2(u_xlat3.x);
                    u_xlat3.x = u_xlat3.x * 0.5;
                    u_xlat3.x = max(u_xlat3.x, 0.0);
                    u_xlat3.x = u_xlat3.x + 1.0;
                    u_xlat18.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat2.xy = u_xlat2.xy * u_xlat18.xx;
                    u_xlat30.xy = u_xlat30.xy * u_xlat18.xx;
                    u_xlat2.xy = u_xlat2.xy / u_xlat3.xx;
                    u_xlat30.xy = u_xlat30.xy / u_xlat3.xx;
                    u_xlat17.x = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
                    u_xlat45 = dot(abs(u_xlat30.xy), abs(u_xlat30.xy));
                    u_xlat3.x = sqrt(u_xlat17.x);
                    u_xlat18.x = sqrt(u_xlat45);
                    u_xlat17.x = inversesqrt(u_xlat17.x);
                    u_xlat2.x = u_xlat17.x * abs(u_xlat2.x);
                    u_xlat45 = inversesqrt(u_xlat45);
                    u_xlat30.x = u_xlat45 * abs(u_xlat30.x);
                    u_xlat30.x = u_xlat30.x * u_xlat2.x;
                    u_xlat30.x = (-u_xlat30.x) * u_xlat30.x + 1.0;
                    u_xlat30.x = sqrt(u_xlat30.x);
                    u_xlat45 = u_xlat18.x * u_xlat3.x;
                    u_xlat2.x = u_xlat30.x * u_xlat45;
                    u_xlat17.xy = vec2(u_xlat2.z * float(3.0), u_xlat2.w * float(3.0));
                    u_xlat47 = fract((-u_xlat17.x));
                    u_xlat17.z = u_xlat47 + 0.5;
                    u_xlat17.xy = fract(u_xlat17.xy);
                    u_xlat17.xy = u_xlat17.xy + vec2(0.5, 0.5);
                    u_xlat17.xyz = floor(u_xlat17.xyz);
                    u_xlat47 = (-u_xlat17.x) + u_xlat17.z;
                    u_xlat17.x = u_xlat47 * u_xlat17.y + u_xlat17.x;
                    u_xlat32 = (-u_xlat45) * u_xlat30.x + 1.0;
                    u_xlat3.xyz = (-u_xlat17.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat5.xyz = vec3(u_xlat32) * u_xlat3.xyz + u_xlat17.xxx;
                    u_xlatb2.xz = lessThan(u_xlat2.xxxx, vec4(1.0, 0.0, 2.0, 0.0)).xz;
                    u_xlat6.xyz = u_xlat17.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat30.x = u_xlat45 * u_xlat30.x + -4.0;
                    u_xlat30.x = exp2(u_xlat30.x);
                    u_xlat30.x = u_xlat30.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat30.x = min(max(u_xlat30.x, 0.0), 1.0);
#else
                    u_xlat30.x = clamp(u_xlat30.x, 0.0, 1.0);
#endif
                    u_xlat3.xyz = u_xlat30.xxx * u_xlat3.zyy + u_xlat17.xxx;
                    u_xlat17.xyz = (u_xlatb2.z) ? u_xlat6.xyz : u_xlat3.xyz;
                    u_xlat4.xyz = (u_xlatb2.x) ? u_xlat5.xyz : u_xlat17.xyz;
                } else {
                    u_xlat30.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat1.xy = dFdx(u_xlat30.xy);
                    u_xlat30.xy = dFdy(u_xlat30.xy);
                    u_xlat2.x = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat17.x = dot(u_xlat30.xy, u_xlat30.xy);
                    u_xlat2.x = max(u_xlat17.x, u_xlat2.x);
                    u_xlat2.x = log2(u_xlat2.x);
                    u_xlat2.x = u_xlat2.x * 0.5;
                    u_xlat2.x = max(u_xlat2.x, 0.0);
                    u_xlat2.x = u_xlat2.x + 1.0;
                    u_xlat17.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat1.xy = u_xlat1.xy * u_xlat17.xx;
                    u_xlat30.xy = u_xlat30.xy * u_xlat17.xx;
                    u_xlat1.xy = u_xlat1.xy / u_xlat2.xx;
                    u_xlat30.xy = u_xlat30.xy / u_xlat2.xx;
                    u_xlat16.x = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat45 = dot(abs(u_xlat30.xy), abs(u_xlat30.xy));
                    u_xlat2.x = sqrt(u_xlat16.x);
                    u_xlat17.x = sqrt(u_xlat45);
                    u_xlat16.x = inversesqrt(u_xlat16.x);
                    u_xlat1.x = u_xlat16.x * abs(u_xlat1.x);
                    u_xlat45 = inversesqrt(u_xlat45);
                    u_xlat30.x = u_xlat45 * abs(u_xlat30.x);
                    u_xlat30.x = u_xlat30.x * u_xlat1.x;
                    u_xlat30.x = (-u_xlat30.x) * u_xlat30.x + 1.0;
                    u_xlat30.x = sqrt(u_xlat30.x);
                    u_xlat45 = u_xlat17.x * u_xlat2.x;
                    u_xlat1.x = u_xlat30.x * u_xlat45;
                    u_xlat16.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat46 = fract((-u_xlat16.x));
                    u_xlat16.z = u_xlat46 + 0.5;
                    u_xlat16.xy = fract(u_xlat16.xy);
                    u_xlat16.xy = u_xlat16.xy + vec2(0.5, 0.5);
                    u_xlat16.xyz = floor(u_xlat16.xyz);
                    u_xlat46 = (-u_xlat16.x) + u_xlat16.z;
                    u_xlat16.x = u_xlat46 * u_xlat16.y + u_xlat16.x;
                    u_xlat31 = (-u_xlat45) * u_xlat30.x + 1.0;
                    u_xlat2.xyz = (-u_xlat16.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat3.xyz = vec3(u_xlat31) * u_xlat2.xyz + u_xlat16.xxx;
                    u_xlatb1.xz = lessThan(u_xlat1.xxxx, vec4(1.0, 0.0, 2.0, 0.0)).xz;
                    u_xlat5.xyz = u_xlat16.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat30.x = u_xlat45 * u_xlat30.x + -4.0;
                    u_xlat30.x = exp2(u_xlat30.x);
                    u_xlat30.x = u_xlat30.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat30.x = min(max(u_xlat30.x, 0.0), 1.0);
#else
                    u_xlat30.x = clamp(u_xlat30.x, 0.0, 1.0);
#endif
                    u_xlat2.xyz = u_xlat30.xxx * u_xlat2.zyy + u_xlat16.xxx;
                    u_xlat16.xyz = (u_xlatb1.z) ? u_xlat5.xyz : u_xlat2.xyz;
                    u_xlat4.xyz = (u_xlatb1.x) ? u_xlat3.xyz : u_xlat16.xyz;
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat4.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb30.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 100.0, 102.0)).xy;
    u_xlatb30.x = u_xlatb30.y || u_xlatb30.x;
    if(u_xlatb30.x){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb30.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 101.0, 103.0)).xy;
    u_xlatb30.x = u_xlatb30.y || u_xlatb30.x;
    if(u_xlatb30.x){
        SV_Target0 = vec4(0.400000006, 0.400000006, 0.400000006, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30.x = !!(vs_COLOR0.w<0.99000001);
#else
    u_xlatb30.x = vs_COLOR0.w<0.99000001;
#endif
    if(u_xlatb30.x){
        u_xlat10_1 = texture(_GrassNormal, vs_TEXCOORD0.xy, -1.0);
        u_xlat16_8.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_53 = u_xlat10_1.w * _UseGrassSpecular;
        u_xlat10_1.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.xy, -1.0).xyz;
        u_xlat16_9.xyz = u_xlat10_1.xyz;
    } else {
        u_xlat16_9.x = float(0.0);
        u_xlat16_9.y = float(0.0);
        u_xlat16_9.z = float(0.0);
        u_xlat16_8.x = float(0.0);
        u_xlat16_8.y = float(0.0);
        u_xlat16_8.z = float(1.0);
        u_xlat16_53 = float(0.0);
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30.x = !!(0.00999999978<vs_COLOR0.w);
#else
    u_xlatb30.x = 0.00999999978<vs_COLOR0.w;
#endif
    if(u_xlatb30.x){
        u_xlat10_1.xyz = texture(_Normal0, vs_TEXCOORD0.zw, -1.0).xyw;
        u_xlat10_2.xyz = texture(_Normal2, vs_TEXCOORD2.xy, -1.0).xyw;
        u_xlat16_10.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_40.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_54 = (-u_xlat0.y) + 1.0;
        u_xlat16_40.xy = vec2(u_xlat16_54) * u_xlat16_40.xy;
        u_xlat10_3 = texture(_Diffuse1, vs_TEXCOORD0.zw, -1.0);
        u_xlat30.xy = vec2(vs_TEXCOORD2.z * float(_DetailNormalUVScale), vs_TEXCOORD2.w * float(_DetailNormalUVScale));
        u_xlat10_1.xyw = texture(_DetailNormal, u_xlat30.xy, -1.0).xyw;
        u_xlat16_11.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_54 = (-u_xlat0.x) + 1.0;
        u_xlat16_11.xy = vec2(u_xlat16_54) * u_xlat16_11.xy;
        u_xlat10_4 = texture(_Diffuse2, vs_TEXCOORD2.xy, -1.0);
        u_xlat10_5 = texture(_DetailDiffuse, vs_TEXCOORD2.zw, -1.0);
        u_xlat16_54 = u_xlat10_4.w * _UseDiffuseTwoHeight;
        u_xlat16_41 = u_xlat10_5.w * _UseDetailDiffuseHeight;
        u_xlat16_12.xyz = u_xlat10_3.xyz + (-u_xlat10_4.xyz);
        u_xlat16_56 = u_xlat10_3.w * _UseDiffuseOneHeight + (-u_xlat16_54);
        u_xlat16_12.xyz = u_xlat0.yyy * u_xlat16_12.xyz + u_xlat10_4.xyz;
        u_xlat16_54 = u_xlat0.y * u_xlat16_56 + u_xlat16_54;
        u_xlat16_56 = u_xlat0.x * _DetailBlendVal;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_56 = min(max(u_xlat16_56, 0.0), 1.0);
#else
        u_xlat16_56 = clamp(u_xlat16_56, 0.0, 1.0);
#endif
        u_xlat16_57 = (-u_xlat16_56) + 1.0;
        u_xlat16_41 = u_xlat16_41 * u_xlat16_57;
        u_xlat16_54 = max(u_xlat16_54, u_xlat16_41);
        u_xlat16_13.xyz = u_xlat10_5.xyz * u_xlat16_12.xyz;
        u_xlat16_14.xyz = u_xlat16_13.xyz * vec3(4.0, 4.0, 4.0);
        u_xlat16_12.xyz = (-u_xlat16_13.xyz) * vec3(4.0, 4.0, 4.0) + u_xlat16_12.xyz;
        u_xlat16_12.xyz = vec3(u_xlat16_56) * u_xlat16_12.xyz + u_xlat16_14.xyz;
        u_xlat16_12.xyz = min(u_xlat16_12.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_41 = u_xlat10_2.z * _UseSpecularTwo;
        u_xlat16_56 = u_xlat10_1.w * _UseDetailSpecular;
        u_xlat16_13.x = _UseSpecularOne * u_xlat10_1.z + (-u_xlat16_41);
        u_xlat16_41 = u_xlat0.y * u_xlat16_13.x + u_xlat16_41;
        u_xlat16_56 = u_xlat16_57 * u_xlat16_56;
        u_xlat16_41 = max(u_xlat16_56, u_xlat16_41);
        u_xlat16_10.xy = u_xlat16_40.xy * vs_COLOR0.xx + u_xlat16_10.xy;
        u_xlat16_10.xy = u_xlat16_11.xy * vs_COLOR0.xx + u_xlat16_10.xy;
    } else {
        u_xlat16_12.x = float(0.0);
        u_xlat16_12.y = float(0.0);
        u_xlat16_12.z = float(0.0);
        u_xlat16_10.x = float(0.0);
        u_xlat16_10.y = float(0.0);
        u_xlat16_54 = 1.0;
        u_xlat16_41 = 0.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor);
#endif
    u_xlat16_11.xyw = u_xlat16_12.xyz * _TintColor.xyz;
    u_xlat16_11.xyw = (bool(u_xlatb0)) ? u_xlat16_11.xyw : u_xlat16_12.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend);
#endif
    u_xlat16_15 = u_xlat16_54;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_30 = vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_54 = _HeightContrast * 10.0;
    u_xlat16_15 = u_xlat16_15 + -1.0;
    u_xlat16_55 = _HeightSpread + 0.100000001;
    u_xlat16_30 = log2(u_xlat16_30);
    u_xlat16_30 = u_xlat16_30 * u_xlat16_55;
    u_xlat16_30 = exp2(u_xlat16_30);
    u_xlat16_15 = u_xlat16_30 * 2.0 + u_xlat16_15;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_30 = _HeightContrast * 10.0 + 1.0;
    u_xlat16_30 = _HeightContrast * 10.0 + u_xlat16_30;
    u_xlat15 = u_xlat16_15 * u_xlat16_30 + (-u_xlat16_54);
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_54 = (u_xlatb0) ? u_xlat15 : vs_COLOR0.w;
    u_xlat16_10.z = 1.0;
    u_xlat16_10.xyz = (-u_xlat16_8.xyz) + u_xlat16_10.xyz;
    u_xlat16_8.xyz = vec3(u_xlat16_54) * u_xlat16_10.xyz + u_xlat16_8.xyz;
    u_xlat16_10.x = (-u_xlat16_53) + u_xlat16_41;
    u_xlat16_53 = u_xlat16_54 * u_xlat16_10.x + u_xlat16_53;
    u_xlat16_10.xyz = (-u_xlat16_9.xyz) + u_xlat16_11.xyw;
    u_xlat16_9.xyz = vec3(u_xlat16_54) * u_xlat16_10.xyz + u_xlat16_9.xyz;
    u_xlat16_53 = u_xlat16_53 + _Shininess;
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, u_xlat16_8.xyz);
    u_xlat0.y = dot(vs_TEXCOORD4.xyz, u_xlat16_8.xyz);
    u_xlat0.z = dot(vs_TEXCOORD5.xyz, u_xlat16_8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb45 = !!(vs_TEXCOORD1.w<100.0);
#else
    u_xlatb45 = vs_TEXCOORD1.w<100.0;
#endif
    if(u_xlatb45){
        u_xlat1.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
        u_xlat45 = texture(_CameraDepthBlendTexture, u_xlat1.xy).x;
        u_xlat45 = _ZBufferParams.z * u_xlat45 + _ZBufferParams.w;
        u_xlat45 = float(1.0) / u_xlat45;
        u_xlat45 = u_xlat45 + (-vs_TEXCOORD1.w);
        u_xlat45 = abs(u_xlat45) * _DepthBiasScaled;
        u_xlat45 = u_xlat45 * 0.600000024;
#ifdef UNITY_ADRENO_ES3
        u_xlat45 = min(max(u_xlat45, 0.0), 1.0);
#else
        u_xlat45 = clamp(u_xlat45, 0.0, 1.0);
#endif
        u_xlat45 = sqrt(u_xlat45);
        u_xlat10_2.xyz = texture(_CameraDepthBlendNormTexture, u_xlat1.xy).xyz;
        u_xlat16_8.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat10_1.xyz = texture(_CameraDepthBlendDiffTexture, u_xlat1.xy).xyz;
        u_xlat16_54 = u_xlat0.y * _DepthBlendAO;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_54 = min(max(u_xlat16_54, 0.0), 1.0);
#else
        u_xlat16_54 = clamp(u_xlat16_54, 0.0, 1.0);
#endif
        u_xlat46 = (-u_xlat45) + 1.0;
        u_xlat46 = u_xlat16_54 * u_xlat46 + u_xlat45;
        u_xlat46 = max(u_xlat46, 0.899999976);
        u_xlat2.xyz = u_xlat16_9.xyz * vec3(u_xlat46) + (-u_xlat10_1.xyz);
        u_xlat9.xyz = vec3(u_xlat45) * u_xlat2.xyz + u_xlat10_1.xyz;
        u_xlat1.xyz = u_xlat0.xyz + (-u_xlat16_8.xyz);
        u_xlat1.xyz = vec3(u_xlat45) * u_xlat1.xyz + u_xlat16_8.xyz;
        u_xlat16_9.xyz = u_xlat9.xyz;
        u_xlat16_1.xyz = u_xlat1.xyz;
    } else {
        u_xlat16_1.xyz = u_xlat0.xyz;
    //ENDIF
    }
    u_xlat16_8.x = u_xlat16_53 * _Terrain_Smoothness;
    u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
    SV_Target2.w = min(u_xlat16_8.x, 0.5);
    u_xlat16_8.xyz = u_xlat16_9.xyz * vec3(vec3(_Terrain_Specular, _Terrain_Specular, _Terrain_Specular));
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat16_53 = max(u_xlat16_8.z, u_xlat16_8.y);
    u_xlat16_53 = max(u_xlat16_53, u_xlat16_8.x);
    u_xlat16_53 = (-u_xlat16_53) + 1.0;
    SV_Target1.xyz = vec3(u_xlat16_53) * u_xlat16_9.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_53 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_53 : u_xlat16_8.z;
    SV_Target0.w = 0.0;
    SV_Target1.w = _SSAO_Intensity;
    SV_Target2.xy = u_xlat16_8.xy;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _Diffuse1_ST;
uniform 	float _UVDiffuse2;
uniform 	vec4 _Diffuse2_ST;
uniform 	float _UVDetail;
uniform 	vec4 _DetailDiffuse_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat7;
float u_xlat16;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x;
    u_xlat2.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].x;
    u_xlat2.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].x;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].y;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].y;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].y;
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.xy = sqrt(u_xlat2.xy);
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].z;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].z;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].z;
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat2.x = u_xlat7.x + u_xlat2.x;
    u_xlat2.x = u_xlat2.x * 0.330000013;
    u_xlat7.xy = u_xlat2.xx * in_TEXCOORD0.xy;
    u_xlat2.xw = u_xlat2.xx * in_TEXCOORD1.xy;
    vs_TEXCOORD0.xy = u_xlat7.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Diffuse1_ST.xy + _Diffuse1_ST.zw;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UVDiffuse2==0.0);
#else
    u_xlatb1 = _UVDiffuse2==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb1)) ? u_xlat7.xy : u_xlat2.xw;
    vs_TEXCOORD2.xy = u_xlat1.xy * _Diffuse2_ST.xy + _Diffuse2_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UVDetail==0.0);
#else
    u_xlatb1 = _UVDetail==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb1)) ? u_xlat7.xy : u_xlat2.xw;
    vs_TEXCOORD2.zw = u_xlat1.xy * _DetailDiffuse_ST.xy + _DetailDiffuse_ST.zw;
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat2.xyz = vec3(u_xlat0) * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_4.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = vec3(u_xlat0) * u_xlat16_4.xyz;
    vs_TEXCOORD3.y = u_xlat16_4.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD3.w = u_xlat5.x;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat5.y;
    vs_TEXCOORD5.w = u_xlat5.z;
    vs_TEXCOORD4.y = u_xlat16_4.y;
    vs_TEXCOORD5.y = u_xlat16_4.z;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	mediump float _HeightSpread;
uniform 	mediump float _HeightContrast;
uniform 	mediump float _UseTintColor;
uniform 	mediump float _UseDiffuseOneHeight;
uniform 	mediump float _UseDiffuseTwoHeight;
uniform 	mediump float _UseDetailDiffuseHeight;
uniform 	mediump float _UseGrassHeightBlend;
uniform 	mediump float _UseGrassSpecular;
uniform 	mediump float _UseSpecularOne;
uniform 	mediump float _UseSpecularTwo;
uniform 	mediump float _UseDetailSpecular;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _SSAO_Intensity;
uniform 	mediump float _Terrain_Smoothness;
uniform 	mediump float _Terrain_Specular;
uniform 	mediump float _Shininess;
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _GrassDiffuse_TexelSize;
uniform 	vec4 _GrassNormal_TexelSize;
uniform 	float _GrassNormalScale;
uniform 	vec4 _Diffuse1_ST;
uniform 	vec4 _Diffuse1_TexelSize;
uniform 	vec4 _Normal0_TexelSize;
uniform 	float _Normal0Scale;
uniform 	vec4 _Diffuse2_ST;
uniform 	vec4 _Normal2_TexelSize;
uniform 	mediump float _Normal2Scale;
uniform 	mediump float _Diffuse2Distance;
uniform 	mediump float _Diffuse2Fade;
uniform 	vec4 _DetailDiffuse_ST;
uniform 	vec4 _DetailDiffuse_TexelSize;
uniform 	vec4 _DetailNormal_TexelSize;
uniform 	mediump float _DetailNormalScale;
uniform 	mediump float _DetailNormalUVScale;
uniform 	mediump float _DetailBlendVal;
uniform 	mediump float _DetailDistance;
uniform 	mediump float _DetailFade;
uniform 	mediump float _DepthBiasScaled;
uniform 	mediump float _DepthBlendAO;
uniform lowp sampler2D _GrassDiffuse;
uniform lowp sampler2D _GrassNormal;
uniform lowp sampler2D _Normal0;
uniform lowp sampler2D _Normal2;
uniform lowp sampler2D _Diffuse1;
uniform lowp sampler2D _DetailNormal;
uniform lowp sampler2D _Diffuse2;
uniform lowp sampler2D _DetailDiffuse;
uniform highp sampler2D _CameraDepthBlendTexture;
uniform lowp sampler2D _CameraDepthBlendNormTexture;
uniform lowp sampler2D _CameraDepthBlendDiffTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec3 u_xlatb1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
bvec3 u_xlatb2;
vec4 u_xlat3;
lowp vec4 u_xlat10_3;
bvec3 u_xlatb3;
vec4 u_xlat4;
lowp vec4 u_xlat10_4;
bvec3 u_xlatb4;
vec3 u_xlat5;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec4 u_xlat16_11;
mediump vec3 u_xlat16_12;
mediump vec3 u_xlat16_13;
mediump vec3 u_xlat16_14;
float u_xlat15;
mediump float u_xlat16_15;
vec3 u_xlat16;
vec3 u_xlat17;
vec3 u_xlat18;
vec3 u_xlat19;
vec2 u_xlat30;
mediump float u_xlat16_30;
bvec2 u_xlatb30;
float u_xlat31;
float u_xlat32;
vec2 u_xlat33;
bvec2 u_xlatb33;
vec2 u_xlat34;
mediump vec2 u_xlat16_40;
mediump float u_xlat16_41;
float u_xlat45;
bool u_xlatb45;
float u_xlat46;
float u_xlat47;
float u_xlat48;
bool u_xlatb48;
float u_xlat49;
mediump float u_xlat16_53;
mediump float u_xlat16_54;
mediump float u_xlat16_55;
mediump float u_xlat16_56;
mediump float u_xlat16_57;
void main()
{
    u_xlat0.x = vs_TEXCOORD3.w;
    u_xlat0.y = vs_TEXCOORD4.w;
    u_xlat0.z = vs_TEXCOORD5.w;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x / _Diffuse2Distance;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat15 + 9.99999975e-05;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Diffuse2Fade;
    u_xlat0.y = exp2(u_xlat15);
    u_xlat0.x = u_xlat0.x / _DetailDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + 9.99999975e-05;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _DetailFade;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.xy = min(u_xlat0.xy, vec2(1.0, 1.0));
    u_xlat1.zw = vec2(vs_TEXCOORD0.z + (-_Diffuse1_ST.z), vs_TEXCOORD0.w + (-_Diffuse1_ST.w));
    u_xlat30.xy = vec2(_Diffuse1_ST.x * _Diffuse1_TexelSize.z, _Diffuse1_ST.y * _Diffuse1_TexelSize.w);
    u_xlatb30.xy = lessThan(vec4(1.0, 1.0, 1.0, 1.0), u_xlat30.xyxy).xy;
    u_xlatb30.x = u_xlatb30.y || u_xlatb30.x;
    u_xlat1.xy = _Diffuse1_TexelSize.zw;
    u_xlat2 = (u_xlatb30.x) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
    u_xlat3.xy = vec2(_Diffuse1_ST.x * _Normal0_TexelSize.z, _Diffuse1_ST.y * _Normal0_TexelSize.w);
    u_xlatb3.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat3.xyxx).xy;
    u_xlatb45 = u_xlatb3.y || u_xlatb3.x;
    u_xlat1.xy = _Normal0_TexelSize.zw;
    u_xlat1 = (bool(u_xlatb45)) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
    u_xlat3.xy = (bool(u_xlatb45)) ? _Diffuse1_ST.xy : vec2(1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb45 = !!(u_xlat0.y<0.800000012);
#else
    u_xlatb45 = u_xlat0.y<0.800000012;
#endif
    u_xlat4.zw = vec2(vs_TEXCOORD2.x + (-_Diffuse2_ST.z), vs_TEXCOORD2.y + (-_Diffuse2_ST.w));
    u_xlat33.xy = u_xlat1.xy * u_xlat3.xy;
    u_xlat5.xy = vec2(_Diffuse2_ST.x * _Normal2_TexelSize.z, _Diffuse2_ST.y * _Normal2_TexelSize.w);
    u_xlatb33.xy = lessThan(u_xlat33.xyxy, u_xlat5.xyxy).xy;
    u_xlatb33.x = u_xlatb33.y || u_xlatb33.x;
    u_xlat4.xy = _Normal2_TexelSize.zw;
    u_xlat4 = (u_xlatb33.x) ? u_xlat4 : u_xlat1;
    u_xlat1 = (bool(u_xlatb45)) ? u_xlat4 : u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb48 = !!(u_xlat0.x<0.800000012);
#else
    u_xlatb48 = u_xlat0.x<0.800000012;
#endif
    if(u_xlatb48){
        u_xlat4.xy = (u_xlatb30.x) ? _Diffuse1_ST.xy : vec2(1.0, 1.0);
        u_xlat33.xy = (u_xlatb33.x) ? _Diffuse2_ST.xy : u_xlat3.xy;
        u_xlat30.xy = (bool(u_xlatb45)) ? u_xlat33.xy : u_xlat3.xy;
        u_xlat3.zw = vec2(vs_TEXCOORD2.z + (-_DetailDiffuse_ST.z), vs_TEXCOORD2.w + (-_DetailDiffuse_ST.w));
        u_xlat4.xy = u_xlat2.xy * u_xlat4.xy;
        u_xlat34.xy = vec2(_DetailDiffuse_ST.x * _DetailDiffuse_TexelSize.z, _DetailDiffuse_ST.y * _DetailDiffuse_TexelSize.w);
        u_xlatb4.xy = lessThan(u_xlat4.xyxx, u_xlat34.xyxx).xy;
        u_xlatb4.x = u_xlatb4.y || u_xlatb4.x;
        u_xlat3.xy = _DetailDiffuse_TexelSize.zw;
        u_xlat2 = (u_xlatb4.x) ? u_xlat3 : u_xlat2;
        u_xlat30.xy = u_xlat30.xy * u_xlat1.xy;
        u_xlat4.xy = vec2(_DetailDiffuse_ST.x * _DetailNormal_TexelSize.z, _DetailDiffuse_ST.y * _DetailNormal_TexelSize.w);
        u_xlatb30.xy = lessThan(u_xlat30.xyxy, u_xlat4.xyxy).xy;
        u_xlatb30.x = u_xlatb30.y || u_xlatb30.x;
        u_xlat3.xy = _DetailNormal_TexelSize.zw;
        u_xlat1 = (u_xlatb30.x) ? u_xlat3 : u_xlat1;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30.x = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb30.x = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb30.x){
        u_xlatb3.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat4 = (u_xlatb3.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat4 = (u_xlatb3.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat4;
        u_xlat3 = (u_xlatb3.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat4;
        SV_Target0 = u_xlat3;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30.x = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb30.x = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb30.x){
        u_xlat10_3.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.xy).xyz;
        SV_Target0.xyz = u_xlat10_3.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30.x = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb30.x = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb30.x){
        u_xlat30.x = max(_GrassDiffuse_TexelSize.w, _GrassDiffuse_TexelSize.z);
        u_xlat30.x = max(u_xlat30.x, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb45 = !!(256.0<u_xlat30.x);
#else
        u_xlatb45 = 256.0<u_xlat30.x;
#endif
        u_xlatb3.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), u_xlat30.xxxx).xy;
        u_xlat4 = (u_xlatb3.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat3 = (u_xlatb3.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat4;
        u_xlat3 = (bool(u_xlatb45)) ? u_xlat3 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat3;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30.x = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb30.x = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb30.x){
        u_xlat30.xy = vec2(vs_TEXCOORD0.x * _GrassDiffuse_TexelSize.z, vs_TEXCOORD0.y * _GrassDiffuse_TexelSize.w);
        u_xlat3.xy = dFdx(u_xlat30.xy);
        u_xlat30.xy = dFdy(u_xlat30.xy);
        u_xlat3.x = dot(u_xlat3.xy, u_xlat3.xy);
        u_xlat30.x = dot(u_xlat30.xy, u_xlat30.xy);
        u_xlat30.x = max(u_xlat30.x, u_xlat3.x);
        u_xlat30.x = log2(u_xlat30.x);
        u_xlat30.x = u_xlat30.x * 0.5;
        u_xlat30.x = max(u_xlat30.x, 0.0);
        u_xlat30.x = u_xlat30.x + 1.0;
        u_xlat45 = max(_GrassDiffuse_TexelSize.w, _GrassDiffuse_TexelSize.z);
        u_xlat30.x = u_xlat45 / u_xlat30.x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb45 = !!(256.0<u_xlat30.x);
#else
        u_xlatb45 = 256.0<u_xlat30.x;
#endif
        u_xlatb3.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), u_xlat30.xxxx).xy;
        u_xlat4 = (u_xlatb3.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat3 = (u_xlatb3.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat4;
        u_xlat3 = (bool(u_xlatb45)) ? u_xlat3 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat3;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30.x = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb30.x = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb30.x){
        u_xlat3.zw = vec2(vs_TEXCOORD0.x + (-_GrassDiffuse_ST.z), vs_TEXCOORD0.y + (-_GrassDiffuse_ST.w));
        u_xlat30.xy = vec2(_GrassDiffuse_ST.x * _GrassDiffuse_TexelSize.z, _GrassDiffuse_ST.y * _GrassDiffuse_TexelSize.w);
        u_xlatb30.xy = lessThan(vec4(1.0, 1.0, 1.0, 1.0), u_xlat30.xyxy).xy;
        u_xlatb30.x = u_xlatb30.y || u_xlatb30.x;
        u_xlat3.xy = _GrassDiffuse_TexelSize.zw;
        u_xlat4 = (u_xlatb30.x) ? u_xlat3 : vec4(1.0, 1.0, 0.0, 0.0);
        u_xlat2 = u_xlat2 + (-u_xlat4);
        u_xlat2 = vs_COLOR0.wwww * u_xlat2 + u_xlat4;
#ifdef UNITY_ADRENO_ES3
        u_xlatb30.x = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb30.x = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb30.x){
            u_xlat30.xy = vec2(u_xlat2.x * u_xlat2.z, u_xlat2.y * u_xlat2.w);
            u_xlat4.xy = dFdx(u_xlat30.xy);
            u_xlat30.xy = dFdy(u_xlat30.xy);
            u_xlat34.x = dot(u_xlat4.xy, u_xlat4.xy);
            u_xlat49 = dot(u_xlat30.xy, u_xlat30.xy);
            u_xlat34.x = max(u_xlat49, u_xlat34.x);
            u_xlat34.x = log2(u_xlat34.x);
            u_xlat34.x = u_xlat34.x * 0.5;
            u_xlat34.x = max(u_xlat34.x, 0.0);
            u_xlat34.x = u_xlat34.x + 1.0;
            u_xlat49 = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat4.xy = vec2(u_xlat49) * u_xlat4.xy;
            u_xlat30.xy = u_xlat30.xy * vec2(u_xlat49);
            u_xlat4.xy = u_xlat4.xy / u_xlat34.xx;
            u_xlat30.xy = u_xlat30.xy / u_xlat34.xx;
            u_xlat19.x = dot(abs(u_xlat4.xy), abs(u_xlat4.xy));
            u_xlat45 = dot(abs(u_xlat30.xy), abs(u_xlat30.xy));
            u_xlat34.x = sqrt(u_xlat19.x);
            u_xlat49 = sqrt(u_xlat45);
            u_xlat19.x = inversesqrt(u_xlat19.x);
            u_xlat4.x = u_xlat19.x * abs(u_xlat4.x);
            u_xlat45 = inversesqrt(u_xlat45);
            u_xlat30.x = u_xlat45 * abs(u_xlat30.x);
            u_xlat30.x = u_xlat30.x * u_xlat4.x;
            u_xlat30.x = (-u_xlat30.x) * u_xlat30.x + 1.0;
            u_xlat30.x = sqrt(u_xlat30.x);
            u_xlat45 = u_xlat49 * u_xlat34.x;
            u_xlat4.x = u_xlat30.x * u_xlat45;
            u_xlat19.xy = vec2(u_xlat2.z * float(3.0), u_xlat2.w * float(3.0));
            u_xlat49 = fract((-u_xlat19.x));
            u_xlat19.z = u_xlat49 + 0.5;
            u_xlat19.xy = fract(u_xlat19.xy);
            u_xlat19.xy = u_xlat19.xy + vec2(0.5, 0.5);
            u_xlat19.xyz = floor(u_xlat19.xyz);
            u_xlat49 = (-u_xlat19.x) + u_xlat19.z;
            u_xlat19.x = u_xlat49 * u_xlat19.y + u_xlat19.x;
            u_xlat34.x = (-u_xlat45) * u_xlat30.x + 1.0;
            u_xlat5.xyz = (-u_xlat19.xxx) + vec3(0.5, 0.0, 1.0);
            u_xlat6.xyz = u_xlat34.xxx * u_xlat5.xyz + u_xlat19.xxx;
            u_xlatb4.xz = lessThan(u_xlat4.xxxx, vec4(1.0, 0.0, 2.0, 0.0)).xz;
            u_xlat7.xyz = u_xlat19.xxx * vec3(0.0, 1.0, 0.0);
            u_xlat30.x = u_xlat45 * u_xlat30.x + -4.0;
            u_xlat30.x = exp2(u_xlat30.x);
            u_xlat30.x = u_xlat30.x + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat30.x = min(max(u_xlat30.x, 0.0), 1.0);
#else
            u_xlat30.x = clamp(u_xlat30.x, 0.0, 1.0);
#endif
            u_xlat5.xyz = u_xlat30.xxx * u_xlat5.zyy + u_xlat19.xxx;
            u_xlat19.xyz = (u_xlatb4.z) ? u_xlat7.xyz : u_xlat5.xyz;
            u_xlat4.xyz = (u_xlatb4.x) ? u_xlat6.xyz : u_xlat19.xyz;
        } else {
            u_xlat30.xy = vec2(_GrassDiffuse_ST.x * _GrassNormal_TexelSize.z, _GrassDiffuse_ST.y * _GrassNormal_TexelSize.w);
            u_xlatb30.xy = lessThan(vec4(1.0, 1.0, 1.0, 1.0), u_xlat30.xyxy).xy;
            u_xlatb30.x = u_xlatb30.y || u_xlatb30.x;
            u_xlat3.xy = _GrassNormal_TexelSize.zw;
            u_xlat3 = (u_xlatb30.x) ? u_xlat3 : vec4(1.0, 1.0, 0.0, 0.0);
            u_xlat1 = u_xlat1 + (-u_xlat3);
            u_xlat1 = vs_COLOR0.wwww * u_xlat1 + u_xlat3;
#ifdef UNITY_ADRENO_ES3
            u_xlatb30.x = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb30.x = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb30.x){
                u_xlat30.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                u_xlat3.xy = dFdx(u_xlat30.xy);
                u_xlat30.xy = dFdy(u_xlat30.xy);
                u_xlat33.x = dot(u_xlat3.xy, u_xlat3.xy);
                u_xlat48 = dot(u_xlat30.xy, u_xlat30.xy);
                u_xlat33.x = max(u_xlat48, u_xlat33.x);
                u_xlat33.x = log2(u_xlat33.x);
                u_xlat33.x = u_xlat33.x * 0.5;
                u_xlat33.x = max(u_xlat33.x, 0.0);
                u_xlat33.x = u_xlat33.x + 1.0;
                u_xlat48 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                u_xlat3.xy = vec2(u_xlat48) * u_xlat3.xy;
                u_xlat30.xy = u_xlat30.xy * vec2(u_xlat48);
                u_xlat3.xy = u_xlat3.xy / u_xlat33.xx;
                u_xlat30.xy = u_xlat30.xy / u_xlat33.xx;
                u_xlat18.x = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                u_xlat45 = dot(abs(u_xlat30.xy), abs(u_xlat30.xy));
                u_xlat33.x = sqrt(u_xlat18.x);
                u_xlat48 = sqrt(u_xlat45);
                u_xlat18.x = inversesqrt(u_xlat18.x);
                u_xlat3.x = u_xlat18.x * abs(u_xlat3.x);
                u_xlat45 = inversesqrt(u_xlat45);
                u_xlat30.x = u_xlat45 * abs(u_xlat30.x);
                u_xlat30.x = u_xlat30.x * u_xlat3.x;
                u_xlat30.x = (-u_xlat30.x) * u_xlat30.x + 1.0;
                u_xlat30.x = sqrt(u_xlat30.x);
                u_xlat45 = u_xlat48 * u_xlat33.x;
                u_xlat3.x = u_xlat30.x * u_xlat45;
                u_xlat18.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                u_xlat48 = fract((-u_xlat18.x));
                u_xlat18.z = u_xlat48 + 0.5;
                u_xlat18.xy = fract(u_xlat18.xy);
                u_xlat18.xy = u_xlat18.xy + vec2(0.5, 0.5);
                u_xlat18.xyz = floor(u_xlat18.xyz);
                u_xlat48 = (-u_xlat18.x) + u_xlat18.z;
                u_xlat18.x = u_xlat48 * u_xlat18.y + u_xlat18.x;
                u_xlat33.x = (-u_xlat45) * u_xlat30.x + 1.0;
                u_xlat5.xyz = (-u_xlat18.xxx) + vec3(0.5, 0.0, 1.0);
                u_xlat6.xyz = u_xlat33.xxx * u_xlat5.xyz + u_xlat18.xxx;
                u_xlatb3.xz = lessThan(u_xlat3.xxxx, vec4(1.0, 0.0, 2.0, 0.0)).xz;
                u_xlat7.xyz = u_xlat18.xxx * vec3(0.0, 1.0, 0.0);
                u_xlat30.x = u_xlat45 * u_xlat30.x + -4.0;
                u_xlat30.x = exp2(u_xlat30.x);
                u_xlat30.x = u_xlat30.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                u_xlat30.x = min(max(u_xlat30.x, 0.0), 1.0);
#else
                u_xlat30.x = clamp(u_xlat30.x, 0.0, 1.0);
#endif
                u_xlat5.xyz = u_xlat30.xxx * u_xlat5.zyy + u_xlat18.xxx;
                u_xlat18.xyz = (u_xlatb3.z) ? u_xlat7.xyz : u_xlat5.xyz;
                u_xlat4.xyz = (u_xlatb3.x) ? u_xlat6.xyz : u_xlat18.xyz;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb30.x = !!(u_xlat2.x>=u_xlat1.x);
#else
                u_xlatb30.x = u_xlat2.x>=u_xlat1.x;
#endif
                if(u_xlatb30.x){
                    u_xlat30.xy = vec2(u_xlat2.x * u_xlat2.z, u_xlat2.y * u_xlat2.w);
                    u_xlat2.xy = dFdx(u_xlat30.xy);
                    u_xlat30.xy = dFdy(u_xlat30.xy);
                    u_xlat3.x = dot(u_xlat2.xy, u_xlat2.xy);
                    u_xlat18.x = dot(u_xlat30.xy, u_xlat30.xy);
                    u_xlat3.x = max(u_xlat18.x, u_xlat3.x);
                    u_xlat3.x = log2(u_xlat3.x);
                    u_xlat3.x = u_xlat3.x * 0.5;
                    u_xlat3.x = max(u_xlat3.x, 0.0);
                    u_xlat3.x = u_xlat3.x + 1.0;
                    u_xlat18.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat2.xy = u_xlat2.xy * u_xlat18.xx;
                    u_xlat30.xy = u_xlat30.xy * u_xlat18.xx;
                    u_xlat2.xy = u_xlat2.xy / u_xlat3.xx;
                    u_xlat30.xy = u_xlat30.xy / u_xlat3.xx;
                    u_xlat17.x = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
                    u_xlat45 = dot(abs(u_xlat30.xy), abs(u_xlat30.xy));
                    u_xlat3.x = sqrt(u_xlat17.x);
                    u_xlat18.x = sqrt(u_xlat45);
                    u_xlat17.x = inversesqrt(u_xlat17.x);
                    u_xlat2.x = u_xlat17.x * abs(u_xlat2.x);
                    u_xlat45 = inversesqrt(u_xlat45);
                    u_xlat30.x = u_xlat45 * abs(u_xlat30.x);
                    u_xlat30.x = u_xlat30.x * u_xlat2.x;
                    u_xlat30.x = (-u_xlat30.x) * u_xlat30.x + 1.0;
                    u_xlat30.x = sqrt(u_xlat30.x);
                    u_xlat45 = u_xlat18.x * u_xlat3.x;
                    u_xlat2.x = u_xlat30.x * u_xlat45;
                    u_xlat17.xy = vec2(u_xlat2.z * float(3.0), u_xlat2.w * float(3.0));
                    u_xlat47 = fract((-u_xlat17.x));
                    u_xlat17.z = u_xlat47 + 0.5;
                    u_xlat17.xy = fract(u_xlat17.xy);
                    u_xlat17.xy = u_xlat17.xy + vec2(0.5, 0.5);
                    u_xlat17.xyz = floor(u_xlat17.xyz);
                    u_xlat47 = (-u_xlat17.x) + u_xlat17.z;
                    u_xlat17.x = u_xlat47 * u_xlat17.y + u_xlat17.x;
                    u_xlat32 = (-u_xlat45) * u_xlat30.x + 1.0;
                    u_xlat3.xyz = (-u_xlat17.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat5.xyz = vec3(u_xlat32) * u_xlat3.xyz + u_xlat17.xxx;
                    u_xlatb2.xz = lessThan(u_xlat2.xxxx, vec4(1.0, 0.0, 2.0, 0.0)).xz;
                    u_xlat6.xyz = u_xlat17.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat30.x = u_xlat45 * u_xlat30.x + -4.0;
                    u_xlat30.x = exp2(u_xlat30.x);
                    u_xlat30.x = u_xlat30.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat30.x = min(max(u_xlat30.x, 0.0), 1.0);
#else
                    u_xlat30.x = clamp(u_xlat30.x, 0.0, 1.0);
#endif
                    u_xlat3.xyz = u_xlat30.xxx * u_xlat3.zyy + u_xlat17.xxx;
                    u_xlat17.xyz = (u_xlatb2.z) ? u_xlat6.xyz : u_xlat3.xyz;
                    u_xlat4.xyz = (u_xlatb2.x) ? u_xlat5.xyz : u_xlat17.xyz;
                } else {
                    u_xlat30.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat1.xy = dFdx(u_xlat30.xy);
                    u_xlat30.xy = dFdy(u_xlat30.xy);
                    u_xlat2.x = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat17.x = dot(u_xlat30.xy, u_xlat30.xy);
                    u_xlat2.x = max(u_xlat17.x, u_xlat2.x);
                    u_xlat2.x = log2(u_xlat2.x);
                    u_xlat2.x = u_xlat2.x * 0.5;
                    u_xlat2.x = max(u_xlat2.x, 0.0);
                    u_xlat2.x = u_xlat2.x + 1.0;
                    u_xlat17.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat1.xy = u_xlat1.xy * u_xlat17.xx;
                    u_xlat30.xy = u_xlat30.xy * u_xlat17.xx;
                    u_xlat1.xy = u_xlat1.xy / u_xlat2.xx;
                    u_xlat30.xy = u_xlat30.xy / u_xlat2.xx;
                    u_xlat16.x = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat45 = dot(abs(u_xlat30.xy), abs(u_xlat30.xy));
                    u_xlat2.x = sqrt(u_xlat16.x);
                    u_xlat17.x = sqrt(u_xlat45);
                    u_xlat16.x = inversesqrt(u_xlat16.x);
                    u_xlat1.x = u_xlat16.x * abs(u_xlat1.x);
                    u_xlat45 = inversesqrt(u_xlat45);
                    u_xlat30.x = u_xlat45 * abs(u_xlat30.x);
                    u_xlat30.x = u_xlat30.x * u_xlat1.x;
                    u_xlat30.x = (-u_xlat30.x) * u_xlat30.x + 1.0;
                    u_xlat30.x = sqrt(u_xlat30.x);
                    u_xlat45 = u_xlat17.x * u_xlat2.x;
                    u_xlat1.x = u_xlat30.x * u_xlat45;
                    u_xlat16.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat46 = fract((-u_xlat16.x));
                    u_xlat16.z = u_xlat46 + 0.5;
                    u_xlat16.xy = fract(u_xlat16.xy);
                    u_xlat16.xy = u_xlat16.xy + vec2(0.5, 0.5);
                    u_xlat16.xyz = floor(u_xlat16.xyz);
                    u_xlat46 = (-u_xlat16.x) + u_xlat16.z;
                    u_xlat16.x = u_xlat46 * u_xlat16.y + u_xlat16.x;
                    u_xlat31 = (-u_xlat45) * u_xlat30.x + 1.0;
                    u_xlat2.xyz = (-u_xlat16.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat3.xyz = vec3(u_xlat31) * u_xlat2.xyz + u_xlat16.xxx;
                    u_xlatb1.xz = lessThan(u_xlat1.xxxx, vec4(1.0, 0.0, 2.0, 0.0)).xz;
                    u_xlat5.xyz = u_xlat16.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat30.x = u_xlat45 * u_xlat30.x + -4.0;
                    u_xlat30.x = exp2(u_xlat30.x);
                    u_xlat30.x = u_xlat30.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat30.x = min(max(u_xlat30.x, 0.0), 1.0);
#else
                    u_xlat30.x = clamp(u_xlat30.x, 0.0, 1.0);
#endif
                    u_xlat2.xyz = u_xlat30.xxx * u_xlat2.zyy + u_xlat16.xxx;
                    u_xlat16.xyz = (u_xlatb1.z) ? u_xlat5.xyz : u_xlat2.xyz;
                    u_xlat4.xyz = (u_xlatb1.x) ? u_xlat3.xyz : u_xlat16.xyz;
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat4.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb30.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 100.0, 102.0)).xy;
    u_xlatb30.x = u_xlatb30.y || u_xlatb30.x;
    if(u_xlatb30.x){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb30.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 101.0, 103.0)).xy;
    u_xlatb30.x = u_xlatb30.y || u_xlatb30.x;
    if(u_xlatb30.x){
        SV_Target0 = vec4(0.400000006, 0.400000006, 0.400000006, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30.x = !!(vs_COLOR0.w<0.99000001);
#else
    u_xlatb30.x = vs_COLOR0.w<0.99000001;
#endif
    if(u_xlatb30.x){
        u_xlat10_1 = texture(_GrassNormal, vs_TEXCOORD0.xy, -1.0);
        u_xlat16_8.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_8.xy = u_xlat16_8.xy * vec2(_GrassNormalScale);
        u_xlat16_53 = u_xlat10_1.w * _UseGrassSpecular;
        u_xlat10_1.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.xy, -1.0).xyz;
        u_xlat16_9.xyz = u_xlat10_1.xyz;
    } else {
        u_xlat16_9.x = float(0.0);
        u_xlat16_9.y = float(0.0);
        u_xlat16_9.z = float(0.0);
        u_xlat16_8.x = float(0.0);
        u_xlat16_8.y = float(0.0);
        u_xlat16_8.z = float(1.0);
        u_xlat16_53 = float(0.0);
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30.x = !!(0.00999999978<vs_COLOR0.w);
#else
    u_xlatb30.x = 0.00999999978<vs_COLOR0.w;
#endif
    if(u_xlatb30.x){
        u_xlat10_1.xyz = texture(_Normal0, vs_TEXCOORD0.zw, -1.0).xyw;
        u_xlat10_2.xyz = texture(_Normal2, vs_TEXCOORD2.xy, -1.0).xyw;
        u_xlat16_10.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_40.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_40.xy = u_xlat16_40.xy * vec2(_Normal2Scale);
        u_xlat16_54 = (-u_xlat0.y) + 1.0;
        u_xlat16_40.xy = vec2(u_xlat16_54) * u_xlat16_40.xy;
        u_xlat16_40.xy = u_xlat16_40.xy * vs_COLOR0.xx;
        u_xlat10_3 = texture(_Diffuse1, vs_TEXCOORD0.zw, -1.0);
        u_xlat30.xy = vec2(vs_TEXCOORD2.z * float(_DetailNormalUVScale), vs_TEXCOORD2.w * float(_DetailNormalUVScale));
        u_xlat10_1.xyw = texture(_DetailNormal, u_xlat30.xy, -1.0).xyw;
        u_xlat16_11.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_11.xy = u_xlat16_11.xy * vec2(_DetailNormalScale);
        u_xlat16_54 = (-u_xlat0.x) + 1.0;
        u_xlat16_11.xy = vec2(u_xlat16_54) * u_xlat16_11.xy;
        u_xlat10_4 = texture(_Diffuse2, vs_TEXCOORD2.xy, -1.0);
        u_xlat10_5 = texture(_DetailDiffuse, vs_TEXCOORD2.zw, -1.0);
        u_xlat16_54 = u_xlat10_4.w * _UseDiffuseTwoHeight;
        u_xlat16_41 = u_xlat10_5.w * _UseDetailDiffuseHeight;
        u_xlat16_12.xyz = u_xlat10_3.xyz + (-u_xlat10_4.xyz);
        u_xlat16_56 = u_xlat10_3.w * _UseDiffuseOneHeight + (-u_xlat16_54);
        u_xlat16_12.xyz = u_xlat0.yyy * u_xlat16_12.xyz + u_xlat10_4.xyz;
        u_xlat16_54 = u_xlat0.y * u_xlat16_56 + u_xlat16_54;
        u_xlat16_56 = u_xlat0.x * _DetailBlendVal;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_56 = min(max(u_xlat16_56, 0.0), 1.0);
#else
        u_xlat16_56 = clamp(u_xlat16_56, 0.0, 1.0);
#endif
        u_xlat16_57 = (-u_xlat16_56) + 1.0;
        u_xlat16_41 = u_xlat16_41 * u_xlat16_57;
        u_xlat16_54 = max(u_xlat16_54, u_xlat16_41);
        u_xlat16_13.xyz = u_xlat10_5.xyz * u_xlat16_12.xyz;
        u_xlat16_14.xyz = u_xlat16_13.xyz * vec3(4.0, 4.0, 4.0);
        u_xlat16_12.xyz = (-u_xlat16_13.xyz) * vec3(4.0, 4.0, 4.0) + u_xlat16_12.xyz;
        u_xlat16_12.xyz = vec3(u_xlat16_56) * u_xlat16_12.xyz + u_xlat16_14.xyz;
        u_xlat16_12.xyz = min(u_xlat16_12.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_41 = u_xlat10_2.z * _UseSpecularTwo;
        u_xlat16_56 = u_xlat10_1.w * _UseDetailSpecular;
        u_xlat16_13.x = _UseSpecularOne * u_xlat10_1.z + (-u_xlat16_41);
        u_xlat16_41 = u_xlat0.y * u_xlat16_13.x + u_xlat16_41;
        u_xlat16_56 = u_xlat16_57 * u_xlat16_56;
        u_xlat16_41 = max(u_xlat16_56, u_xlat16_41);
        u_xlat16_10.xy = u_xlat16_10.xy * vec2(_Normal0Scale) + u_xlat16_40.xy;
        u_xlat16_10.xy = u_xlat16_11.xy * vs_COLOR0.xx + u_xlat16_10.xy;
    } else {
        u_xlat16_12.x = float(0.0);
        u_xlat16_12.y = float(0.0);
        u_xlat16_12.z = float(0.0);
        u_xlat16_10.x = float(0.0);
        u_xlat16_10.y = float(0.0);
        u_xlat16_54 = 1.0;
        u_xlat16_41 = 0.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor);
#endif
    u_xlat16_11.xyw = u_xlat16_12.xyz * _TintColor.xyz;
    u_xlat16_11.xyw = (bool(u_xlatb0)) ? u_xlat16_11.xyw : u_xlat16_12.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend);
#endif
    u_xlat16_15 = u_xlat16_54;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_30 = vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_54 = _HeightContrast * 10.0;
    u_xlat16_15 = u_xlat16_15 + -1.0;
    u_xlat16_55 = _HeightSpread + 0.100000001;
    u_xlat16_30 = log2(u_xlat16_30);
    u_xlat16_30 = u_xlat16_30 * u_xlat16_55;
    u_xlat16_30 = exp2(u_xlat16_30);
    u_xlat16_15 = u_xlat16_30 * 2.0 + u_xlat16_15;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_30 = _HeightContrast * 10.0 + 1.0;
    u_xlat16_30 = _HeightContrast * 10.0 + u_xlat16_30;
    u_xlat15 = u_xlat16_15 * u_xlat16_30 + (-u_xlat16_54);
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_54 = (u_xlatb0) ? u_xlat15 : vs_COLOR0.w;
    u_xlat16_10.z = 1.0;
    u_xlat16_10.xyz = (-u_xlat16_8.xyz) + u_xlat16_10.xyz;
    u_xlat16_8.xyz = vec3(u_xlat16_54) * u_xlat16_10.xyz + u_xlat16_8.xyz;
    u_xlat16_10.x = (-u_xlat16_53) + u_xlat16_41;
    u_xlat16_53 = u_xlat16_54 * u_xlat16_10.x + u_xlat16_53;
    u_xlat16_10.xyz = (-u_xlat16_9.xyz) + u_xlat16_11.xyw;
    u_xlat16_9.xyz = vec3(u_xlat16_54) * u_xlat16_10.xyz + u_xlat16_9.xyz;
    u_xlat16_53 = u_xlat16_53 + _Shininess;
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, u_xlat16_8.xyz);
    u_xlat0.y = dot(vs_TEXCOORD4.xyz, u_xlat16_8.xyz);
    u_xlat0.z = dot(vs_TEXCOORD5.xyz, u_xlat16_8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb45 = !!(vs_TEXCOORD1.w<100.0);
#else
    u_xlatb45 = vs_TEXCOORD1.w<100.0;
#endif
    if(u_xlatb45){
        u_xlat1.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
        u_xlat45 = texture(_CameraDepthBlendTexture, u_xlat1.xy).x;
        u_xlat45 = _ZBufferParams.z * u_xlat45 + _ZBufferParams.w;
        u_xlat45 = float(1.0) / u_xlat45;
        u_xlat45 = u_xlat45 + (-vs_TEXCOORD1.w);
        u_xlat45 = abs(u_xlat45) * _DepthBiasScaled;
        u_xlat45 = u_xlat45 * 0.600000024;
#ifdef UNITY_ADRENO_ES3
        u_xlat45 = min(max(u_xlat45, 0.0), 1.0);
#else
        u_xlat45 = clamp(u_xlat45, 0.0, 1.0);
#endif
        u_xlat45 = sqrt(u_xlat45);
        u_xlat10_2.xyz = texture(_CameraDepthBlendNormTexture, u_xlat1.xy).xyz;
        u_xlat16_8.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat10_1.xyz = texture(_CameraDepthBlendDiffTexture, u_xlat1.xy).xyz;
        u_xlat16_54 = u_xlat0.y * _DepthBlendAO;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_54 = min(max(u_xlat16_54, 0.0), 1.0);
#else
        u_xlat16_54 = clamp(u_xlat16_54, 0.0, 1.0);
#endif
        u_xlat46 = (-u_xlat45) + 1.0;
        u_xlat46 = u_xlat16_54 * u_xlat46 + u_xlat45;
        u_xlat46 = max(u_xlat46, 0.899999976);
        u_xlat2.xyz = u_xlat16_9.xyz * vec3(u_xlat46) + (-u_xlat10_1.xyz);
        u_xlat9.xyz = vec3(u_xlat45) * u_xlat2.xyz + u_xlat10_1.xyz;
        u_xlat1.xyz = u_xlat0.xyz + (-u_xlat16_8.xyz);
        u_xlat1.xyz = vec3(u_xlat45) * u_xlat1.xyz + u_xlat16_8.xyz;
        u_xlat16_9.xyz = u_xlat9.xyz;
        u_xlat16_1.xyz = u_xlat1.xyz;
    } else {
        u_xlat16_1.xyz = u_xlat0.xyz;
    //ENDIF
    }
    u_xlat16_8.x = u_xlat16_53 * _Terrain_Smoothness;
    u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
    SV_Target2.w = min(u_xlat16_8.x, 0.5);
    u_xlat16_8.xyz = u_xlat16_9.xyz * vec3(vec3(_Terrain_Specular, _Terrain_Specular, _Terrain_Specular));
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat16_53 = max(u_xlat16_8.z, u_xlat16_8.y);
    u_xlat16_53 = max(u_xlat16_53, u_xlat16_8.x);
    u_xlat16_53 = (-u_xlat16_53) + 1.0;
    SV_Target1.xyz = vec3(u_xlat16_53) * u_xlat16_9.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_53 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_53 : u_xlat16_8.z;
    SV_Target0.w = 0.0;
    SV_Target1.w = _SSAO_Intensity;
    SV_Target2.xy = u_xlat16_8.xy;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _Diffuse1_ST;
uniform 	float _UVDiffuse2;
uniform 	vec4 _Diffuse2_ST;
uniform 	float _UVDetail;
uniform 	vec4 _DetailDiffuse_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec2 u_xlat12;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat15 = u_xlat15 + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat15 = u_xlat15 + u_xlat2.x;
    u_xlat15 = u_xlat15 * 0.330000013;
    u_xlat2.xy = vec2(u_xlat15) * in_TEXCOORD0.xy;
    u_xlat12.xy = vec2(u_xlat15) * in_TEXCOORD1.xy;
    vs_TEXCOORD0.xy = u_xlat2.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Diffuse1_ST.xy + _Diffuse1_ST.zw;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat15 * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UVDiffuse2==0.0);
#else
    u_xlatb15 = _UVDiffuse2==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat2.xy : u_xlat12.xy;
    vs_TEXCOORD2.xy = u_xlat1.xy * _Diffuse2_ST.xy + _Diffuse2_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UVDetail==0.0);
#else
    u_xlatb15 = _UVDetail==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat2.xy : u_xlat12.xy;
    vs_TEXCOORD2.zw = u_xlat1.xy * _DetailDiffuse_ST.xy + _DetailDiffuse_ST.zw;
    vs_TEXCOORD3.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz;
    vs_TEXCOORD3.y = u_xlat16_4.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat0.y;
    vs_TEXCOORD5.w = u_xlat0.z;
    vs_TEXCOORD4.y = u_xlat16_4.y;
    vs_TEXCOORD5.y = u_xlat16_4.z;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _Diffuse1_ST;
uniform 	float _UVDiffuse2;
uniform 	vec4 _Diffuse2_ST;
uniform 	float _UVDetail;
uniform 	vec4 _DetailDiffuse_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat7;
float u_xlat16;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x;
    u_xlat2.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].x;
    u_xlat2.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].x;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].y;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].y;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].y;
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.xy = sqrt(u_xlat2.xy);
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].z;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].z;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].z;
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat2.x = u_xlat7.x + u_xlat2.x;
    u_xlat2.x = u_xlat2.x * 0.330000013;
    u_xlat7.xy = u_xlat2.xx * in_TEXCOORD0.xy;
    u_xlat2.xw = u_xlat2.xx * in_TEXCOORD1.xy;
    vs_TEXCOORD0.xy = u_xlat7.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Diffuse1_ST.xy + _Diffuse1_ST.zw;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UVDiffuse2==0.0);
#else
    u_xlatb1 = _UVDiffuse2==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb1)) ? u_xlat7.xy : u_xlat2.xw;
    vs_TEXCOORD2.xy = u_xlat1.xy * _Diffuse2_ST.xy + _Diffuse2_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UVDetail==0.0);
#else
    u_xlatb1 = _UVDetail==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb1)) ? u_xlat7.xy : u_xlat2.xw;
    vs_TEXCOORD2.zw = u_xlat1.xy * _DetailDiffuse_ST.xy + _DetailDiffuse_ST.zw;
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat2.xyz = vec3(u_xlat0) * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_4.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = vec3(u_xlat0) * u_xlat16_4.xyz;
    vs_TEXCOORD3.y = u_xlat16_4.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD3.w = u_xlat5.x;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat5.y;
    vs_TEXCOORD5.w = u_xlat5.z;
    vs_TEXCOORD4.y = u_xlat16_4.y;
    vs_TEXCOORD5.y = u_xlat16_4.z;
    vs_COLOR0 = in_COLOR0;
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
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "LINE_INTERPOLATION" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _Diffuse1_ST;
uniform 	float _UVDiffuse2;
uniform 	vec4 _Diffuse2_ST;
uniform 	float _UVDetail;
uniform 	vec4 _DetailDiffuse_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec2 u_xlat12;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat15 = u_xlat15 + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat15 = u_xlat15 + u_xlat2.x;
    u_xlat15 = u_xlat15 * 0.330000013;
    u_xlat2.xy = vec2(u_xlat15) * in_TEXCOORD0.xy;
    u_xlat12.xy = vec2(u_xlat15) * in_TEXCOORD1.xy;
    vs_TEXCOORD0.xy = u_xlat2.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Diffuse1_ST.xy + _Diffuse1_ST.zw;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat15 * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UVDiffuse2==0.0);
#else
    u_xlatb15 = _UVDiffuse2==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat2.xy : u_xlat12.xy;
    vs_TEXCOORD2.xy = u_xlat1.xy * _Diffuse2_ST.xy + _Diffuse2_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UVDetail==0.0);
#else
    u_xlatb15 = _UVDetail==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat2.xy : u_xlat12.xy;
    vs_TEXCOORD2.zw = u_xlat1.xy * _DetailDiffuse_ST.xy + _DetailDiffuse_ST.zw;
    vs_TEXCOORD3.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz;
    vs_TEXCOORD3.y = u_xlat16_4.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat0.y;
    vs_TEXCOORD5.w = u_xlat0.z;
    vs_TEXCOORD4.y = u_xlat16_4.y;
    vs_TEXCOORD5.y = u_xlat16_4.z;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "LINE_INTERPOLATION" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _Diffuse1_ST;
uniform 	float _UVDiffuse2;
uniform 	vec4 _Diffuse2_ST;
uniform 	float _UVDetail;
uniform 	vec4 _DetailDiffuse_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat7;
float u_xlat16;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x;
    u_xlat2.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].x;
    u_xlat2.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].x;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].y;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].y;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].y;
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.xy = sqrt(u_xlat2.xy);
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].z;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].z;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].z;
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat2.x = u_xlat7.x + u_xlat2.x;
    u_xlat2.x = u_xlat2.x * 0.330000013;
    u_xlat7.xy = u_xlat2.xx * in_TEXCOORD0.xy;
    u_xlat2.xw = u_xlat2.xx * in_TEXCOORD1.xy;
    vs_TEXCOORD0.xy = u_xlat7.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Diffuse1_ST.xy + _Diffuse1_ST.zw;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UVDiffuse2==0.0);
#else
    u_xlatb1 = _UVDiffuse2==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb1)) ? u_xlat7.xy : u_xlat2.xw;
    vs_TEXCOORD2.xy = u_xlat1.xy * _Diffuse2_ST.xy + _Diffuse2_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UVDetail==0.0);
#else
    u_xlatb1 = _UVDetail==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb1)) ? u_xlat7.xy : u_xlat2.xw;
    vs_TEXCOORD2.zw = u_xlat1.xy * _DetailDiffuse_ST.xy + _DetailDiffuse_ST.zw;
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat2.xyz = vec3(u_xlat0) * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_4.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = vec3(u_xlat0) * u_xlat16_4.xyz;
    vs_TEXCOORD3.y = u_xlat16_4.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD3.w = u_xlat5.x;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat5.y;
    vs_TEXCOORD5.w = u_xlat5.z;
    vs_TEXCOORD4.y = u_xlat16_4.y;
    vs_TEXCOORD5.y = u_xlat16_4.z;
    vs_COLOR0 = in_COLOR0;
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
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _Diffuse1_ST;
uniform 	float _UVDiffuse2;
uniform 	vec4 _Diffuse2_ST;
uniform 	float _UVDetail;
uniform 	vec4 _DetailDiffuse_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec2 u_xlat12;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat15 = u_xlat15 + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat15 = u_xlat15 + u_xlat2.x;
    u_xlat15 = u_xlat15 * 0.330000013;
    u_xlat2.xy = vec2(u_xlat15) * in_TEXCOORD0.xy;
    u_xlat12.xy = vec2(u_xlat15) * in_TEXCOORD1.xy;
    vs_TEXCOORD0.xy = u_xlat2.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Diffuse1_ST.xy + _Diffuse1_ST.zw;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat15 * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UVDiffuse2==0.0);
#else
    u_xlatb15 = _UVDiffuse2==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat2.xy : u_xlat12.xy;
    vs_TEXCOORD2.xy = u_xlat1.xy * _Diffuse2_ST.xy + _Diffuse2_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UVDetail==0.0);
#else
    u_xlatb15 = _UVDetail==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat2.xy : u_xlat12.xy;
    vs_TEXCOORD2.zw = u_xlat1.xy * _DetailDiffuse_ST.xy + _DetailDiffuse_ST.zw;
    vs_TEXCOORD3.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz;
    vs_TEXCOORD3.y = u_xlat16_4.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat0.y;
    vs_TEXCOORD5.w = u_xlat0.z;
    vs_TEXCOORD4.y = u_xlat16_4.y;
    vs_TEXCOORD5.y = u_xlat16_4.z;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump float _HeightSpread;
uniform 	mediump float _HeightContrast;
uniform 	mediump float _UseTintColor;
uniform 	mediump float _UseDiffuseOneHeight;
uniform 	mediump float _UseDiffuseTwoHeight;
uniform 	mediump float _UseDetailDiffuseHeight;
uniform 	mediump float _UseGrassHeightBlend;
uniform 	mediump float _UseGrassSpecular;
uniform 	mediump float _UseSpecularOne;
uniform 	mediump float _UseSpecularTwo;
uniform 	mediump float _UseDetailSpecular;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _SSAO_Intensity;
uniform 	mediump float _Terrain_Smoothness;
uniform 	mediump float _Terrain_Specular;
uniform 	mediump float _Shininess;
uniform 	mediump float _Diffuse2Distance;
uniform 	mediump float _Diffuse2Fade;
uniform 	mediump float _DetailNormalUVScale;
uniform 	mediump float _DetailBlendVal;
uniform 	mediump float _DetailDistance;
uniform 	mediump float _DetailFade;
uniform 	mediump float _DepthBiasScaled;
uniform 	mediump float _DepthBlendAO;
uniform lowp sampler2D _GrassNormal;
uniform lowp sampler2D _GrassDiffuse;
uniform lowp sampler2D _Normal0;
uniform lowp sampler2D _Normal2;
uniform lowp sampler2D _Diffuse1;
uniform lowp sampler2D _DetailNormal;
uniform lowp sampler2D _Diffuse2;
uniform lowp sampler2D _DetailDiffuse;
uniform highp sampler2D _CameraDepthBlendTexture;
uniform lowp sampler2D _CameraDepthBlendNormTexture;
uniform lowp sampler2D _CameraDepthBlendDiffTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_6;
mediump vec4 u_xlat16_7;
lowp vec4 u_xlat10_8;
lowp vec4 u_xlat10_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
mediump vec3 u_xlat16_12;
float u_xlat13;
mediump float u_xlat16_13;
vec2 u_xlat26;
mediump float u_xlat16_26;
mediump vec2 u_xlat16_31;
mediump float u_xlat16_33;
float u_xlat39;
bool u_xlatb39;
mediump float u_xlat16_40;
mediump float u_xlat16_41;
float u_xlat42;
mediump float u_xlat16_44;
mediump float u_xlat16_46;
mediump float u_xlat16_49;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_COLOR0.w<0.99000001);
#else
    u_xlatb0 = vs_COLOR0.w<0.99000001;
#endif
    if(u_xlatb0){
        u_xlat10_0 = texture(_GrassNormal, vs_TEXCOORD0.xy, -1.0);
        u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_40 = u_xlat10_0.w * _UseGrassSpecular;
        u_xlat10_0.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.xy, -1.0).xyz;
        u_xlat16_2.xyz = u_xlat10_0.xyz;
    } else {
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
        u_xlat16_1.x = float(0.0);
        u_xlat16_1.y = float(0.0);
        u_xlat16_1.z = float(1.0);
        u_xlat16_40 = float(0.0);
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.00999999978<vs_COLOR0.w);
#else
    u_xlatb0 = 0.00999999978<vs_COLOR0.w;
#endif
    if(u_xlatb0){
        u_xlat0.x = vs_TEXCOORD3.w;
        u_xlat0.y = vs_TEXCOORD4.w;
        u_xlat0.z = vs_TEXCOORD5.w;
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat13 = u_xlat0.x / _Diffuse2Distance;
#ifdef UNITY_ADRENO_ES3
        u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
        u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
        u_xlat13 = u_xlat13 + 9.99999975e-05;
        u_xlat13 = log2(u_xlat13);
        u_xlat13 = u_xlat13 * _Diffuse2Fade;
        u_xlat0.y = exp2(u_xlat13);
        u_xlat0.x = u_xlat0.x / _DetailDistance;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = u_xlat0.x + 9.99999975e-05;
        u_xlat0.x = log2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * _DetailFade;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat0.xy = min(u_xlat0.xy, vec2(1.0, 1.0));
        u_xlat10_3.xyz = texture(_Normal0, vs_TEXCOORD0.zw, -1.0).xyw;
        u_xlat10_4.xyz = texture(_Normal2, vs_TEXCOORD2.xy, -1.0).xyw;
        u_xlat16_5.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_31.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_41 = (-u_xlat0.y) + 1.0;
        u_xlat16_31.xy = vec2(u_xlat16_41) * u_xlat16_31.xy;
        u_xlat10_6 = texture(_Diffuse1, vs_TEXCOORD0.zw, -1.0);
        u_xlat26.xy = vec2(vs_TEXCOORD2.z * float(_DetailNormalUVScale), vs_TEXCOORD2.w * float(_DetailNormalUVScale));
        u_xlat10_3.xyw = texture(_DetailNormal, u_xlat26.xy, -1.0).xyw;
        u_xlat16_7.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_41 = (-u_xlat0.x) + 1.0;
        u_xlat16_7.xy = vec2(u_xlat16_41) * u_xlat16_7.xy;
        u_xlat10_8 = texture(_Diffuse2, vs_TEXCOORD2.xy, -1.0);
        u_xlat10_9 = texture(_DetailDiffuse, vs_TEXCOORD2.zw, -1.0);
        u_xlat16_41 = u_xlat10_8.w * _UseDiffuseTwoHeight;
        u_xlat16_33 = u_xlat10_9.w * _UseDetailDiffuseHeight;
        u_xlat16_10.xyz = u_xlat10_6.xyz + (-u_xlat10_8.xyz);
        u_xlat16_46 = u_xlat10_6.w * _UseDiffuseOneHeight + (-u_xlat16_41);
        u_xlat16_10.xyz = u_xlat0.yyy * u_xlat16_10.xyz + u_xlat10_8.xyz;
        u_xlat16_41 = u_xlat0.y * u_xlat16_46 + u_xlat16_41;
        u_xlat16_46 = u_xlat0.x * _DetailBlendVal;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_46 = min(max(u_xlat16_46, 0.0), 1.0);
#else
        u_xlat16_46 = clamp(u_xlat16_46, 0.0, 1.0);
#endif
        u_xlat16_49 = (-u_xlat16_46) + 1.0;
        u_xlat16_33 = u_xlat16_33 * u_xlat16_49;
        u_xlat16_41 = max(u_xlat16_41, u_xlat16_33);
        u_xlat16_11.xyz = u_xlat10_9.xyz * u_xlat16_10.xyz;
        u_xlat16_12.xyz = u_xlat16_11.xyz * vec3(4.0, 4.0, 4.0);
        u_xlat16_10.xyz = (-u_xlat16_11.xyz) * vec3(4.0, 4.0, 4.0) + u_xlat16_10.xyz;
        u_xlat16_10.xyz = vec3(u_xlat16_46) * u_xlat16_10.xyz + u_xlat16_12.xyz;
        u_xlat16_10.xyz = min(u_xlat16_10.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_33 = u_xlat10_4.z * _UseSpecularTwo;
        u_xlat16_46 = u_xlat10_3.w * _UseDetailSpecular;
        u_xlat16_11.x = _UseSpecularOne * u_xlat10_3.z + (-u_xlat16_33);
        u_xlat16_33 = u_xlat0.y * u_xlat16_11.x + u_xlat16_33;
        u_xlat16_46 = u_xlat16_49 * u_xlat16_46;
        u_xlat16_33 = max(u_xlat16_46, u_xlat16_33);
        u_xlat16_5.xy = u_xlat16_31.xy * vs_COLOR0.xx + u_xlat16_5.xy;
        u_xlat16_5.xy = u_xlat16_7.xy * vs_COLOR0.xx + u_xlat16_5.xy;
    } else {
        u_xlat16_10.x = float(0.0);
        u_xlat16_10.y = float(0.0);
        u_xlat16_10.z = float(0.0);
        u_xlat16_5.x = float(0.0);
        u_xlat16_5.y = float(0.0);
        u_xlat16_41 = 1.0;
        u_xlat16_33 = 0.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor);
#endif
    u_xlat16_7.xyw = u_xlat16_10.xyz * _TintColor.xyz;
    u_xlat16_7.xyw = (bool(u_xlatb0)) ? u_xlat16_7.xyw : u_xlat16_10.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend);
#endif
    u_xlat16_13 = u_xlat16_41;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_26 = vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_41 = _HeightContrast * 10.0;
    u_xlat16_13 = u_xlat16_13 + -1.0;
    u_xlat16_44 = _HeightSpread + 0.100000001;
    u_xlat16_26 = log2(u_xlat16_26);
    u_xlat16_26 = u_xlat16_26 * u_xlat16_44;
    u_xlat16_26 = exp2(u_xlat16_26);
    u_xlat16_13 = u_xlat16_26 * 2.0 + u_xlat16_13;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_26 = _HeightContrast * 10.0 + 1.0;
    u_xlat16_26 = _HeightContrast * 10.0 + u_xlat16_26;
    u_xlat13 = u_xlat16_13 * u_xlat16_26 + (-u_xlat16_41);
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat16_41 = (u_xlatb0) ? u_xlat13 : vs_COLOR0.w;
    u_xlat16_5.z = 1.0;
    u_xlat16_5.xyz = (-u_xlat16_1.xyz) + u_xlat16_5.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_41) * u_xlat16_5.xyz + u_xlat16_1.xyz;
    u_xlat16_5.x = (-u_xlat16_40) + u_xlat16_33;
    u_xlat16_40 = u_xlat16_41 * u_xlat16_5.x + u_xlat16_40;
    u_xlat16_5.xyz = (-u_xlat16_2.xyz) + u_xlat16_7.xyw;
    u_xlat16_2.xyz = vec3(u_xlat16_41) * u_xlat16_5.xyz + u_xlat16_2.xyz;
    u_xlat16_40 = u_xlat16_40 + _Shininess;
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD5.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!(vs_TEXCOORD1.w<100.0);
#else
    u_xlatb39 = vs_TEXCOORD1.w<100.0;
#endif
    if(u_xlatb39){
        u_xlat3.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
        u_xlat39 = texture(_CameraDepthBlendTexture, u_xlat3.xy).x;
        u_xlat39 = _ZBufferParams.z * u_xlat39 + _ZBufferParams.w;
        u_xlat39 = float(1.0) / u_xlat39;
        u_xlat39 = u_xlat39 + (-vs_TEXCOORD1.w);
        u_xlat39 = abs(u_xlat39) * _DepthBiasScaled;
        u_xlat39 = u_xlat39 * 0.600000024;
#ifdef UNITY_ADRENO_ES3
        u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
        u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
        u_xlat39 = sqrt(u_xlat39);
        u_xlat10_4.xyz = texture(_CameraDepthBlendNormTexture, u_xlat3.xy).xyz;
        u_xlat16_1.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat10_3.xyz = texture(_CameraDepthBlendDiffTexture, u_xlat3.xy).xyz;
        u_xlat16_41 = u_xlat0.y * _DepthBlendAO;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
        u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
        u_xlat42 = (-u_xlat39) + 1.0;
        u_xlat42 = u_xlat16_41 * u_xlat42 + u_xlat39;
        u_xlat42 = max(u_xlat42, 0.899999976);
        u_xlat4.xyz = u_xlat16_2.xyz * vec3(u_xlat42) + (-u_xlat10_3.xyz);
        u_xlat2.xyz = vec3(u_xlat39) * u_xlat4.xyz + u_xlat10_3.xyz;
        u_xlat3.xyz = u_xlat0.xyz + (-u_xlat16_1.xyz);
        u_xlat3.xyz = vec3(u_xlat39) * u_xlat3.xyz + u_xlat16_1.xyz;
        u_xlat16_2.xyz = u_xlat2.xyz;
        u_xlat16_3.xyz = u_xlat3.xyz;
    } else {
        u_xlat16_3.xyz = u_xlat0.xyz;
    //ENDIF
    }
    u_xlat16_1.x = u_xlat16_40 * _Terrain_Smoothness;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    SV_Target2.w = min(u_xlat16_1.x, 0.5);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(vec3(_Terrain_Specular, _Terrain_Specular, _Terrain_Specular));
    u_xlat16_0.x = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_40 = max(u_xlat16_1.z, u_xlat16_1.y);
    u_xlat16_40 = max(u_xlat16_40, u_xlat16_1.x);
    u_xlat16_40 = (-u_xlat16_40) + 1.0;
    SV_Target1.xyz = vec3(u_xlat16_40) * u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_40 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_40 : u_xlat16_1.z;
    SV_Target0.w = 0.0;
    SV_Target1.w = _SSAO_Intensity;
    SV_Target2.xy = u_xlat16_1.xy;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _Diffuse1_ST;
uniform 	float _UVDiffuse2;
uniform 	vec4 _Diffuse2_ST;
uniform 	float _UVDetail;
uniform 	vec4 _DetailDiffuse_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat7;
float u_xlat16;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x;
    u_xlat2.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].x;
    u_xlat2.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].x;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].y;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].y;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].y;
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.xy = sqrt(u_xlat2.xy);
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].z;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].z;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].z;
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat2.x = u_xlat7.x + u_xlat2.x;
    u_xlat2.x = u_xlat2.x * 0.330000013;
    u_xlat7.xy = u_xlat2.xx * in_TEXCOORD0.xy;
    u_xlat2.xw = u_xlat2.xx * in_TEXCOORD1.xy;
    vs_TEXCOORD0.xy = u_xlat7.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Diffuse1_ST.xy + _Diffuse1_ST.zw;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UVDiffuse2==0.0);
#else
    u_xlatb1 = _UVDiffuse2==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb1)) ? u_xlat7.xy : u_xlat2.xw;
    vs_TEXCOORD2.xy = u_xlat1.xy * _Diffuse2_ST.xy + _Diffuse2_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UVDetail==0.0);
#else
    u_xlatb1 = _UVDetail==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb1)) ? u_xlat7.xy : u_xlat2.xw;
    vs_TEXCOORD2.zw = u_xlat1.xy * _DetailDiffuse_ST.xy + _DetailDiffuse_ST.zw;
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat2.xyz = vec3(u_xlat0) * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_4.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = vec3(u_xlat0) * u_xlat16_4.xyz;
    vs_TEXCOORD3.y = u_xlat16_4.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD3.w = u_xlat5.x;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat5.y;
    vs_TEXCOORD5.w = u_xlat5.z;
    vs_TEXCOORD4.y = u_xlat16_4.y;
    vs_TEXCOORD5.y = u_xlat16_4.z;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump float _HeightSpread;
uniform 	mediump float _HeightContrast;
uniform 	mediump float _UseTintColor;
uniform 	mediump float _UseDiffuseOneHeight;
uniform 	mediump float _UseDiffuseTwoHeight;
uniform 	mediump float _UseDetailDiffuseHeight;
uniform 	mediump float _UseGrassHeightBlend;
uniform 	mediump float _UseGrassSpecular;
uniform 	mediump float _UseSpecularOne;
uniform 	mediump float _UseSpecularTwo;
uniform 	mediump float _UseDetailSpecular;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _SSAO_Intensity;
uniform 	mediump float _Terrain_Smoothness;
uniform 	mediump float _Terrain_Specular;
uniform 	mediump float _Shininess;
uniform 	float _GrassNormalScale;
uniform 	float _Normal0Scale;
uniform 	mediump float _Normal2Scale;
uniform 	mediump float _Diffuse2Distance;
uniform 	mediump float _Diffuse2Fade;
uniform 	mediump float _DetailNormalScale;
uniform 	mediump float _DetailNormalUVScale;
uniform 	mediump float _DetailBlendVal;
uniform 	mediump float _DetailDistance;
uniform 	mediump float _DetailFade;
uniform 	mediump float _DepthBiasScaled;
uniform 	mediump float _DepthBlendAO;
uniform lowp sampler2D _GrassNormal;
uniform lowp sampler2D _GrassDiffuse;
uniform lowp sampler2D _Normal0;
uniform lowp sampler2D _Normal2;
uniform lowp sampler2D _Diffuse1;
uniform lowp sampler2D _DetailNormal;
uniform lowp sampler2D _Diffuse2;
uniform lowp sampler2D _DetailDiffuse;
uniform highp sampler2D _CameraDepthBlendTexture;
uniform lowp sampler2D _CameraDepthBlendNormTexture;
uniform lowp sampler2D _CameraDepthBlendDiffTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_6;
mediump vec4 u_xlat16_7;
lowp vec4 u_xlat10_8;
lowp vec4 u_xlat10_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
mediump vec3 u_xlat16_12;
float u_xlat13;
mediump float u_xlat16_13;
vec2 u_xlat26;
mediump float u_xlat16_26;
mediump vec2 u_xlat16_31;
mediump float u_xlat16_33;
float u_xlat39;
bool u_xlatb39;
mediump float u_xlat16_40;
mediump float u_xlat16_41;
float u_xlat42;
mediump float u_xlat16_44;
mediump float u_xlat16_46;
mediump float u_xlat16_49;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_COLOR0.w<0.99000001);
#else
    u_xlatb0 = vs_COLOR0.w<0.99000001;
#endif
    if(u_xlatb0){
        u_xlat10_0 = texture(_GrassNormal, vs_TEXCOORD0.xy, -1.0);
        u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_1.xy = u_xlat16_1.xy * vec2(_GrassNormalScale);
        u_xlat16_40 = u_xlat10_0.w * _UseGrassSpecular;
        u_xlat10_0.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.xy, -1.0).xyz;
        u_xlat16_2.xyz = u_xlat10_0.xyz;
    } else {
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
        u_xlat16_1.x = float(0.0);
        u_xlat16_1.y = float(0.0);
        u_xlat16_1.z = float(1.0);
        u_xlat16_40 = float(0.0);
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.00999999978<vs_COLOR0.w);
#else
    u_xlatb0 = 0.00999999978<vs_COLOR0.w;
#endif
    if(u_xlatb0){
        u_xlat0.x = vs_TEXCOORD3.w;
        u_xlat0.y = vs_TEXCOORD4.w;
        u_xlat0.z = vs_TEXCOORD5.w;
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat13 = u_xlat0.x / _Diffuse2Distance;
#ifdef UNITY_ADRENO_ES3
        u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
        u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
        u_xlat13 = u_xlat13 + 9.99999975e-05;
        u_xlat13 = log2(u_xlat13);
        u_xlat13 = u_xlat13 * _Diffuse2Fade;
        u_xlat0.y = exp2(u_xlat13);
        u_xlat0.x = u_xlat0.x / _DetailDistance;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = u_xlat0.x + 9.99999975e-05;
        u_xlat0.x = log2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * _DetailFade;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat0.xy = min(u_xlat0.xy, vec2(1.0, 1.0));
        u_xlat10_3.xyz = texture(_Normal0, vs_TEXCOORD0.zw, -1.0).xyw;
        u_xlat10_4.xyz = texture(_Normal2, vs_TEXCOORD2.xy, -1.0).xyw;
        u_xlat16_5.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_31.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_31.xy = u_xlat16_31.xy * vec2(_Normal2Scale);
        u_xlat16_41 = (-u_xlat0.y) + 1.0;
        u_xlat16_31.xy = vec2(u_xlat16_41) * u_xlat16_31.xy;
        u_xlat16_31.xy = u_xlat16_31.xy * vs_COLOR0.xx;
        u_xlat10_6 = texture(_Diffuse1, vs_TEXCOORD0.zw, -1.0);
        u_xlat26.xy = vec2(vs_TEXCOORD2.z * float(_DetailNormalUVScale), vs_TEXCOORD2.w * float(_DetailNormalUVScale));
        u_xlat10_3.xyw = texture(_DetailNormal, u_xlat26.xy, -1.0).xyw;
        u_xlat16_7.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_7.xy = u_xlat16_7.xy * vec2(_DetailNormalScale);
        u_xlat16_41 = (-u_xlat0.x) + 1.0;
        u_xlat16_7.xy = vec2(u_xlat16_41) * u_xlat16_7.xy;
        u_xlat10_8 = texture(_Diffuse2, vs_TEXCOORD2.xy, -1.0);
        u_xlat10_9 = texture(_DetailDiffuse, vs_TEXCOORD2.zw, -1.0);
        u_xlat16_41 = u_xlat10_8.w * _UseDiffuseTwoHeight;
        u_xlat16_33 = u_xlat10_9.w * _UseDetailDiffuseHeight;
        u_xlat16_10.xyz = u_xlat10_6.xyz + (-u_xlat10_8.xyz);
        u_xlat16_46 = u_xlat10_6.w * _UseDiffuseOneHeight + (-u_xlat16_41);
        u_xlat16_10.xyz = u_xlat0.yyy * u_xlat16_10.xyz + u_xlat10_8.xyz;
        u_xlat16_41 = u_xlat0.y * u_xlat16_46 + u_xlat16_41;
        u_xlat16_46 = u_xlat0.x * _DetailBlendVal;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_46 = min(max(u_xlat16_46, 0.0), 1.0);
#else
        u_xlat16_46 = clamp(u_xlat16_46, 0.0, 1.0);
#endif
        u_xlat16_49 = (-u_xlat16_46) + 1.0;
        u_xlat16_33 = u_xlat16_33 * u_xlat16_49;
        u_xlat16_41 = max(u_xlat16_41, u_xlat16_33);
        u_xlat16_11.xyz = u_xlat10_9.xyz * u_xlat16_10.xyz;
        u_xlat16_12.xyz = u_xlat16_11.xyz * vec3(4.0, 4.0, 4.0);
        u_xlat16_10.xyz = (-u_xlat16_11.xyz) * vec3(4.0, 4.0, 4.0) + u_xlat16_10.xyz;
        u_xlat16_10.xyz = vec3(u_xlat16_46) * u_xlat16_10.xyz + u_xlat16_12.xyz;
        u_xlat16_10.xyz = min(u_xlat16_10.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_33 = u_xlat10_4.z * _UseSpecularTwo;
        u_xlat16_46 = u_xlat10_3.w * _UseDetailSpecular;
        u_xlat16_11.x = _UseSpecularOne * u_xlat10_3.z + (-u_xlat16_33);
        u_xlat16_33 = u_xlat0.y * u_xlat16_11.x + u_xlat16_33;
        u_xlat16_46 = u_xlat16_49 * u_xlat16_46;
        u_xlat16_33 = max(u_xlat16_46, u_xlat16_33);
        u_xlat16_5.xy = u_xlat16_5.xy * vec2(_Normal0Scale) + u_xlat16_31.xy;
        u_xlat16_5.xy = u_xlat16_7.xy * vs_COLOR0.xx + u_xlat16_5.xy;
    } else {
        u_xlat16_10.x = float(0.0);
        u_xlat16_10.y = float(0.0);
        u_xlat16_10.z = float(0.0);
        u_xlat16_5.x = float(0.0);
        u_xlat16_5.y = float(0.0);
        u_xlat16_41 = 1.0;
        u_xlat16_33 = 0.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor);
#endif
    u_xlat16_7.xyw = u_xlat16_10.xyz * _TintColor.xyz;
    u_xlat16_7.xyw = (bool(u_xlatb0)) ? u_xlat16_7.xyw : u_xlat16_10.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend);
#endif
    u_xlat16_13 = u_xlat16_41;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_26 = vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_41 = _HeightContrast * 10.0;
    u_xlat16_13 = u_xlat16_13 + -1.0;
    u_xlat16_44 = _HeightSpread + 0.100000001;
    u_xlat16_26 = log2(u_xlat16_26);
    u_xlat16_26 = u_xlat16_26 * u_xlat16_44;
    u_xlat16_26 = exp2(u_xlat16_26);
    u_xlat16_13 = u_xlat16_26 * 2.0 + u_xlat16_13;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_26 = _HeightContrast * 10.0 + 1.0;
    u_xlat16_26 = _HeightContrast * 10.0 + u_xlat16_26;
    u_xlat13 = u_xlat16_13 * u_xlat16_26 + (-u_xlat16_41);
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat16_41 = (u_xlatb0) ? u_xlat13 : vs_COLOR0.w;
    u_xlat16_5.z = 1.0;
    u_xlat16_5.xyz = (-u_xlat16_1.xyz) + u_xlat16_5.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_41) * u_xlat16_5.xyz + u_xlat16_1.xyz;
    u_xlat16_5.x = (-u_xlat16_40) + u_xlat16_33;
    u_xlat16_40 = u_xlat16_41 * u_xlat16_5.x + u_xlat16_40;
    u_xlat16_5.xyz = (-u_xlat16_2.xyz) + u_xlat16_7.xyw;
    u_xlat16_2.xyz = vec3(u_xlat16_41) * u_xlat16_5.xyz + u_xlat16_2.xyz;
    u_xlat16_40 = u_xlat16_40 + _Shininess;
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD5.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!(vs_TEXCOORD1.w<100.0);
#else
    u_xlatb39 = vs_TEXCOORD1.w<100.0;
#endif
    if(u_xlatb39){
        u_xlat3.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
        u_xlat39 = texture(_CameraDepthBlendTexture, u_xlat3.xy).x;
        u_xlat39 = _ZBufferParams.z * u_xlat39 + _ZBufferParams.w;
        u_xlat39 = float(1.0) / u_xlat39;
        u_xlat39 = u_xlat39 + (-vs_TEXCOORD1.w);
        u_xlat39 = abs(u_xlat39) * _DepthBiasScaled;
        u_xlat39 = u_xlat39 * 0.600000024;
#ifdef UNITY_ADRENO_ES3
        u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
        u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
        u_xlat39 = sqrt(u_xlat39);
        u_xlat10_4.xyz = texture(_CameraDepthBlendNormTexture, u_xlat3.xy).xyz;
        u_xlat16_1.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat10_3.xyz = texture(_CameraDepthBlendDiffTexture, u_xlat3.xy).xyz;
        u_xlat16_41 = u_xlat0.y * _DepthBlendAO;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
        u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
        u_xlat42 = (-u_xlat39) + 1.0;
        u_xlat42 = u_xlat16_41 * u_xlat42 + u_xlat39;
        u_xlat42 = max(u_xlat42, 0.899999976);
        u_xlat4.xyz = u_xlat16_2.xyz * vec3(u_xlat42) + (-u_xlat10_3.xyz);
        u_xlat2.xyz = vec3(u_xlat39) * u_xlat4.xyz + u_xlat10_3.xyz;
        u_xlat3.xyz = u_xlat0.xyz + (-u_xlat16_1.xyz);
        u_xlat3.xyz = vec3(u_xlat39) * u_xlat3.xyz + u_xlat16_1.xyz;
        u_xlat16_2.xyz = u_xlat2.xyz;
        u_xlat16_3.xyz = u_xlat3.xyz;
    } else {
        u_xlat16_3.xyz = u_xlat0.xyz;
    //ENDIF
    }
    u_xlat16_1.x = u_xlat16_40 * _Terrain_Smoothness;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    SV_Target2.w = min(u_xlat16_1.x, 0.5);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(vec3(_Terrain_Specular, _Terrain_Specular, _Terrain_Specular));
    u_xlat16_0.x = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_40 = max(u_xlat16_1.z, u_xlat16_1.y);
    u_xlat16_40 = max(u_xlat16_40, u_xlat16_1.x);
    u_xlat16_40 = (-u_xlat16_40) + 1.0;
    SV_Target1.xyz = vec3(u_xlat16_40) * u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_40 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_40 : u_xlat16_1.z;
    SV_Target0.w = 0.0;
    SV_Target1.w = _SSAO_Intensity;
    SV_Target2.xy = u_xlat16_1.xy;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MSAA_INTERPOLATION" "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _Diffuse1_ST;
uniform 	float _UVDiffuse2;
uniform 	vec4 _Diffuse2_ST;
uniform 	float _UVDetail;
uniform 	vec4 _DetailDiffuse_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec2 u_xlat12;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat15 = u_xlat15 + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat15 = u_xlat15 + u_xlat2.x;
    u_xlat15 = u_xlat15 * 0.330000013;
    u_xlat2.xy = vec2(u_xlat15) * in_TEXCOORD0.xy;
    u_xlat12.xy = vec2(u_xlat15) * in_TEXCOORD1.xy;
    vs_TEXCOORD0.xy = u_xlat2.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Diffuse1_ST.xy + _Diffuse1_ST.zw;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat15 * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UVDiffuse2==0.0);
#else
    u_xlatb15 = _UVDiffuse2==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat2.xy : u_xlat12.xy;
    vs_TEXCOORD2.xy = u_xlat1.xy * _Diffuse2_ST.xy + _Diffuse2_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UVDetail==0.0);
#else
    u_xlatb15 = _UVDetail==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat2.xy : u_xlat12.xy;
    vs_TEXCOORD2.zw = u_xlat1.xy * _DetailDiffuse_ST.xy + _DetailDiffuse_ST.zw;
    vs_TEXCOORD3.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz;
    vs_TEXCOORD3.y = u_xlat16_4.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat0.y;
    vs_TEXCOORD5.w = u_xlat0.z;
    vs_TEXCOORD4.y = u_xlat16_4.y;
    vs_TEXCOORD5.y = u_xlat16_4.z;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump float _HeightSpread;
uniform 	mediump float _HeightContrast;
uniform 	mediump float _UseTintColor;
uniform 	mediump float _UseDiffuseOneHeight;
uniform 	mediump float _UseDiffuseTwoHeight;
uniform 	mediump float _UseDetailDiffuseHeight;
uniform 	mediump float _UseGrassHeightBlend;
uniform 	mediump float _UseGrassSpecular;
uniform 	mediump float _UseSpecularOne;
uniform 	mediump float _UseSpecularTwo;
uniform 	mediump float _UseDetailSpecular;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _SSAO_Intensity;
uniform 	mediump float _Terrain_Smoothness;
uniform 	mediump float _Terrain_Specular;
uniform 	mediump float _Shininess;
uniform 	mediump float _Diffuse2Distance;
uniform 	mediump float _Diffuse2Fade;
uniform 	mediump float _DetailNormalUVScale;
uniform 	mediump float _DetailBlendVal;
uniform 	mediump float _DetailDistance;
uniform 	mediump float _DetailFade;
uniform 	mediump float _DepthBiasScaled;
uniform 	mediump float _DepthBlendAO;
uniform lowp sampler2D _GrassNormal;
uniform lowp sampler2D _GrassDiffuse;
uniform lowp sampler2D _Normal0;
uniform lowp sampler2D _Normal2;
uniform lowp sampler2D _Diffuse1;
uniform lowp sampler2D _DetailNormal;
uniform lowp sampler2D _Diffuse2;
uniform lowp sampler2D _DetailDiffuse;
uniform highp sampler2D _CameraDepthBlendTexture;
uniform lowp sampler2D _CameraDepthBlendNormTexture;
uniform lowp sampler2D _CameraDepthBlendDiffTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_6;
mediump vec4 u_xlat16_7;
lowp vec4 u_xlat10_8;
lowp vec4 u_xlat10_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
mediump vec3 u_xlat16_12;
float u_xlat13;
mediump float u_xlat16_13;
vec2 u_xlat26;
mediump float u_xlat16_26;
mediump vec2 u_xlat16_31;
mediump float u_xlat16_33;
float u_xlat39;
bool u_xlatb39;
mediump float u_xlat16_40;
mediump float u_xlat16_41;
float u_xlat42;
mediump float u_xlat16_44;
mediump float u_xlat16_46;
mediump float u_xlat16_49;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_COLOR0.w<0.99000001);
#else
    u_xlatb0 = vs_COLOR0.w<0.99000001;
#endif
    if(u_xlatb0){
        u_xlat10_0 = texture(_GrassNormal, vs_TEXCOORD0.xy, -1.0);
        u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_40 = u_xlat10_0.w * _UseGrassSpecular;
        u_xlat10_0.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.xy, -1.0).xyz;
        u_xlat16_2.xyz = u_xlat10_0.xyz;
    } else {
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
        u_xlat16_1.x = float(0.0);
        u_xlat16_1.y = float(0.0);
        u_xlat16_1.z = float(1.0);
        u_xlat16_40 = float(0.0);
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.00999999978<vs_COLOR0.w);
#else
    u_xlatb0 = 0.00999999978<vs_COLOR0.w;
#endif
    if(u_xlatb0){
        u_xlat0.x = vs_TEXCOORD3.w;
        u_xlat0.y = vs_TEXCOORD4.w;
        u_xlat0.z = vs_TEXCOORD5.w;
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat13 = u_xlat0.x / _Diffuse2Distance;
#ifdef UNITY_ADRENO_ES3
        u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
        u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
        u_xlat13 = u_xlat13 + 9.99999975e-05;
        u_xlat13 = log2(u_xlat13);
        u_xlat13 = u_xlat13 * _Diffuse2Fade;
        u_xlat0.y = exp2(u_xlat13);
        u_xlat0.x = u_xlat0.x / _DetailDistance;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = u_xlat0.x + 9.99999975e-05;
        u_xlat0.x = log2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * _DetailFade;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat0.xy = min(u_xlat0.xy, vec2(1.0, 1.0));
        u_xlat10_3.xyz = texture(_Normal0, vs_TEXCOORD0.zw, -1.0).xyw;
        u_xlat10_4.xyz = texture(_Normal2, vs_TEXCOORD2.xy, -1.0).xyw;
        u_xlat16_5.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_31.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_41 = (-u_xlat0.y) + 1.0;
        u_xlat16_31.xy = vec2(u_xlat16_41) * u_xlat16_31.xy;
        u_xlat10_6 = texture(_Diffuse1, vs_TEXCOORD0.zw, -1.0);
        u_xlat26.xy = vec2(vs_TEXCOORD2.z * float(_DetailNormalUVScale), vs_TEXCOORD2.w * float(_DetailNormalUVScale));
        u_xlat10_3.xyw = texture(_DetailNormal, u_xlat26.xy, -1.0).xyw;
        u_xlat16_7.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_41 = (-u_xlat0.x) + 1.0;
        u_xlat16_7.xy = vec2(u_xlat16_41) * u_xlat16_7.xy;
        u_xlat10_8 = texture(_Diffuse2, vs_TEXCOORD2.xy, -1.0);
        u_xlat10_9 = texture(_DetailDiffuse, vs_TEXCOORD2.zw, -1.0);
        u_xlat16_41 = u_xlat10_8.w * _UseDiffuseTwoHeight;
        u_xlat16_33 = u_xlat10_9.w * _UseDetailDiffuseHeight;
        u_xlat16_10.xyz = u_xlat10_6.xyz + (-u_xlat10_8.xyz);
        u_xlat16_46 = u_xlat10_6.w * _UseDiffuseOneHeight + (-u_xlat16_41);
        u_xlat16_10.xyz = u_xlat0.yyy * u_xlat16_10.xyz + u_xlat10_8.xyz;
        u_xlat16_41 = u_xlat0.y * u_xlat16_46 + u_xlat16_41;
        u_xlat16_46 = u_xlat0.x * _DetailBlendVal;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_46 = min(max(u_xlat16_46, 0.0), 1.0);
#else
        u_xlat16_46 = clamp(u_xlat16_46, 0.0, 1.0);
#endif
        u_xlat16_49 = (-u_xlat16_46) + 1.0;
        u_xlat16_33 = u_xlat16_33 * u_xlat16_49;
        u_xlat16_41 = max(u_xlat16_41, u_xlat16_33);
        u_xlat16_11.xyz = u_xlat10_9.xyz * u_xlat16_10.xyz;
        u_xlat16_12.xyz = u_xlat16_11.xyz * vec3(4.0, 4.0, 4.0);
        u_xlat16_10.xyz = (-u_xlat16_11.xyz) * vec3(4.0, 4.0, 4.0) + u_xlat16_10.xyz;
        u_xlat16_10.xyz = vec3(u_xlat16_46) * u_xlat16_10.xyz + u_xlat16_12.xyz;
        u_xlat16_10.xyz = min(u_xlat16_10.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_33 = u_xlat10_4.z * _UseSpecularTwo;
        u_xlat16_46 = u_xlat10_3.w * _UseDetailSpecular;
        u_xlat16_11.x = _UseSpecularOne * u_xlat10_3.z + (-u_xlat16_33);
        u_xlat16_33 = u_xlat0.y * u_xlat16_11.x + u_xlat16_33;
        u_xlat16_46 = u_xlat16_49 * u_xlat16_46;
        u_xlat16_33 = max(u_xlat16_46, u_xlat16_33);
        u_xlat16_5.xy = u_xlat16_31.xy * vs_COLOR0.xx + u_xlat16_5.xy;
        u_xlat16_5.xy = u_xlat16_7.xy * vs_COLOR0.xx + u_xlat16_5.xy;
    } else {
        u_xlat16_10.x = float(0.0);
        u_xlat16_10.y = float(0.0);
        u_xlat16_10.z = float(0.0);
        u_xlat16_5.x = float(0.0);
        u_xlat16_5.y = float(0.0);
        u_xlat16_41 = 1.0;
        u_xlat16_33 = 0.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor);
#endif
    u_xlat16_7.xyw = u_xlat16_10.xyz * _TintColor.xyz;
    u_xlat16_7.xyw = (bool(u_xlatb0)) ? u_xlat16_7.xyw : u_xlat16_10.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend);
#endif
    u_xlat16_13 = u_xlat16_41;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_26 = vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_41 = _HeightContrast * 10.0;
    u_xlat16_13 = u_xlat16_13 + -1.0;
    u_xlat16_44 = _HeightSpread + 0.100000001;
    u_xlat16_26 = log2(u_xlat16_26);
    u_xlat16_26 = u_xlat16_26 * u_xlat16_44;
    u_xlat16_26 = exp2(u_xlat16_26);
    u_xlat16_13 = u_xlat16_26 * 2.0 + u_xlat16_13;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_26 = _HeightContrast * 10.0 + 1.0;
    u_xlat16_26 = _HeightContrast * 10.0 + u_xlat16_26;
    u_xlat13 = u_xlat16_13 * u_xlat16_26 + (-u_xlat16_41);
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat16_41 = (u_xlatb0) ? u_xlat13 : vs_COLOR0.w;
    u_xlat16_5.z = 1.0;
    u_xlat16_5.xyz = (-u_xlat16_1.xyz) + u_xlat16_5.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_41) * u_xlat16_5.xyz + u_xlat16_1.xyz;
    u_xlat16_5.x = (-u_xlat16_40) + u_xlat16_33;
    u_xlat16_40 = u_xlat16_41 * u_xlat16_5.x + u_xlat16_40;
    u_xlat16_5.xyz = (-u_xlat16_2.xyz) + u_xlat16_7.xyw;
    u_xlat16_2.xyz = vec3(u_xlat16_41) * u_xlat16_5.xyz + u_xlat16_2.xyz;
    u_xlat16_40 = u_xlat16_40 + _Shininess;
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD5.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!(vs_TEXCOORD1.w<100.0);
#else
    u_xlatb39 = vs_TEXCOORD1.w<100.0;
#endif
    if(u_xlatb39){
        u_xlat3.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
        u_xlat39 = texture(_CameraDepthBlendTexture, u_xlat3.xy).x;
        u_xlat39 = _ZBufferParams.z * u_xlat39 + _ZBufferParams.w;
        u_xlat39 = float(1.0) / u_xlat39;
        u_xlat39 = u_xlat39 + (-vs_TEXCOORD1.w);
        u_xlat39 = abs(u_xlat39) * _DepthBiasScaled;
        u_xlat39 = u_xlat39 * 0.600000024;
#ifdef UNITY_ADRENO_ES3
        u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
        u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
        u_xlat39 = sqrt(u_xlat39);
        u_xlat10_4.xyz = texture(_CameraDepthBlendNormTexture, u_xlat3.xy).xyz;
        u_xlat16_1.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat10_3.xyz = texture(_CameraDepthBlendDiffTexture, u_xlat3.xy).xyz;
        u_xlat16_41 = u_xlat0.y * _DepthBlendAO;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
        u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
        u_xlat42 = (-u_xlat39) + 1.0;
        u_xlat42 = u_xlat16_41 * u_xlat42 + u_xlat39;
        u_xlat42 = max(u_xlat42, 0.899999976);
        u_xlat4.xyz = u_xlat16_2.xyz * vec3(u_xlat42) + (-u_xlat10_3.xyz);
        u_xlat2.xyz = vec3(u_xlat39) * u_xlat4.xyz + u_xlat10_3.xyz;
        u_xlat3.xyz = u_xlat0.xyz + (-u_xlat16_1.xyz);
        u_xlat3.xyz = vec3(u_xlat39) * u_xlat3.xyz + u_xlat16_1.xyz;
        u_xlat16_2.xyz = u_xlat2.xyz;
        u_xlat16_3.xyz = u_xlat3.xyz;
    } else {
        u_xlat16_3.xyz = u_xlat0.xyz;
    //ENDIF
    }
    u_xlat16_1.x = u_xlat16_40 * _Terrain_Smoothness;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    SV_Target2.w = min(u_xlat16_1.x, 0.5);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(vec3(_Terrain_Specular, _Terrain_Specular, _Terrain_Specular));
    u_xlat16_0.x = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_40 = max(u_xlat16_1.z, u_xlat16_1.y);
    u_xlat16_40 = max(u_xlat16_40, u_xlat16_1.x);
    u_xlat16_40 = (-u_xlat16_40) + 1.0;
    SV_Target1.xyz = vec3(u_xlat16_40) * u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_40 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_40 : u_xlat16_1.z;
    SV_Target0.w = 0.0;
    SV_Target1.w = _SSAO_Intensity;
    SV_Target2.xy = u_xlat16_1.xy;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MSAA_INTERPOLATION" "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _Diffuse1_ST;
uniform 	float _UVDiffuse2;
uniform 	vec4 _Diffuse2_ST;
uniform 	float _UVDetail;
uniform 	vec4 _DetailDiffuse_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat7;
float u_xlat16;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x;
    u_xlat2.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].x;
    u_xlat2.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].x;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].y;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].y;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].y;
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.xy = sqrt(u_xlat2.xy);
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].z;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].z;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].z;
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat2.x = u_xlat7.x + u_xlat2.x;
    u_xlat2.x = u_xlat2.x * 0.330000013;
    u_xlat7.xy = u_xlat2.xx * in_TEXCOORD0.xy;
    u_xlat2.xw = u_xlat2.xx * in_TEXCOORD1.xy;
    vs_TEXCOORD0.xy = u_xlat7.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Diffuse1_ST.xy + _Diffuse1_ST.zw;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UVDiffuse2==0.0);
#else
    u_xlatb1 = _UVDiffuse2==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb1)) ? u_xlat7.xy : u_xlat2.xw;
    vs_TEXCOORD2.xy = u_xlat1.xy * _Diffuse2_ST.xy + _Diffuse2_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UVDetail==0.0);
#else
    u_xlatb1 = _UVDetail==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb1)) ? u_xlat7.xy : u_xlat2.xw;
    vs_TEXCOORD2.zw = u_xlat1.xy * _DetailDiffuse_ST.xy + _DetailDiffuse_ST.zw;
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat2.xyz = vec3(u_xlat0) * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_4.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = vec3(u_xlat0) * u_xlat16_4.xyz;
    vs_TEXCOORD3.y = u_xlat16_4.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD3.w = u_xlat5.x;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat5.y;
    vs_TEXCOORD5.w = u_xlat5.z;
    vs_TEXCOORD4.y = u_xlat16_4.y;
    vs_TEXCOORD5.y = u_xlat16_4.z;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump float _HeightSpread;
uniform 	mediump float _HeightContrast;
uniform 	mediump float _UseTintColor;
uniform 	mediump float _UseDiffuseOneHeight;
uniform 	mediump float _UseDiffuseTwoHeight;
uniform 	mediump float _UseDetailDiffuseHeight;
uniform 	mediump float _UseGrassHeightBlend;
uniform 	mediump float _UseGrassSpecular;
uniform 	mediump float _UseSpecularOne;
uniform 	mediump float _UseSpecularTwo;
uniform 	mediump float _UseDetailSpecular;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _SSAO_Intensity;
uniform 	mediump float _Terrain_Smoothness;
uniform 	mediump float _Terrain_Specular;
uniform 	mediump float _Shininess;
uniform 	float _GrassNormalScale;
uniform 	float _Normal0Scale;
uniform 	mediump float _Normal2Scale;
uniform 	mediump float _Diffuse2Distance;
uniform 	mediump float _Diffuse2Fade;
uniform 	mediump float _DetailNormalScale;
uniform 	mediump float _DetailNormalUVScale;
uniform 	mediump float _DetailBlendVal;
uniform 	mediump float _DetailDistance;
uniform 	mediump float _DetailFade;
uniform 	mediump float _DepthBiasScaled;
uniform 	mediump float _DepthBlendAO;
uniform lowp sampler2D _GrassNormal;
uniform lowp sampler2D _GrassDiffuse;
uniform lowp sampler2D _Normal0;
uniform lowp sampler2D _Normal2;
uniform lowp sampler2D _Diffuse1;
uniform lowp sampler2D _DetailNormal;
uniform lowp sampler2D _Diffuse2;
uniform lowp sampler2D _DetailDiffuse;
uniform highp sampler2D _CameraDepthBlendTexture;
uniform lowp sampler2D _CameraDepthBlendNormTexture;
uniform lowp sampler2D _CameraDepthBlendDiffTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_6;
mediump vec4 u_xlat16_7;
lowp vec4 u_xlat10_8;
lowp vec4 u_xlat10_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
mediump vec3 u_xlat16_12;
float u_xlat13;
mediump float u_xlat16_13;
vec2 u_xlat26;
mediump float u_xlat16_26;
mediump vec2 u_xlat16_31;
mediump float u_xlat16_33;
float u_xlat39;
bool u_xlatb39;
mediump float u_xlat16_40;
mediump float u_xlat16_41;
float u_xlat42;
mediump float u_xlat16_44;
mediump float u_xlat16_46;
mediump float u_xlat16_49;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_COLOR0.w<0.99000001);
#else
    u_xlatb0 = vs_COLOR0.w<0.99000001;
#endif
    if(u_xlatb0){
        u_xlat10_0 = texture(_GrassNormal, vs_TEXCOORD0.xy, -1.0);
        u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_1.xy = u_xlat16_1.xy * vec2(_GrassNormalScale);
        u_xlat16_40 = u_xlat10_0.w * _UseGrassSpecular;
        u_xlat10_0.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.xy, -1.0).xyz;
        u_xlat16_2.xyz = u_xlat10_0.xyz;
    } else {
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
        u_xlat16_1.x = float(0.0);
        u_xlat16_1.y = float(0.0);
        u_xlat16_1.z = float(1.0);
        u_xlat16_40 = float(0.0);
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.00999999978<vs_COLOR0.w);
#else
    u_xlatb0 = 0.00999999978<vs_COLOR0.w;
#endif
    if(u_xlatb0){
        u_xlat0.x = vs_TEXCOORD3.w;
        u_xlat0.y = vs_TEXCOORD4.w;
        u_xlat0.z = vs_TEXCOORD5.w;
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat13 = u_xlat0.x / _Diffuse2Distance;
#ifdef UNITY_ADRENO_ES3
        u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
        u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
        u_xlat13 = u_xlat13 + 9.99999975e-05;
        u_xlat13 = log2(u_xlat13);
        u_xlat13 = u_xlat13 * _Diffuse2Fade;
        u_xlat0.y = exp2(u_xlat13);
        u_xlat0.x = u_xlat0.x / _DetailDistance;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = u_xlat0.x + 9.99999975e-05;
        u_xlat0.x = log2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * _DetailFade;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat0.xy = min(u_xlat0.xy, vec2(1.0, 1.0));
        u_xlat10_3.xyz = texture(_Normal0, vs_TEXCOORD0.zw, -1.0).xyw;
        u_xlat10_4.xyz = texture(_Normal2, vs_TEXCOORD2.xy, -1.0).xyw;
        u_xlat16_5.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_31.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_31.xy = u_xlat16_31.xy * vec2(_Normal2Scale);
        u_xlat16_41 = (-u_xlat0.y) + 1.0;
        u_xlat16_31.xy = vec2(u_xlat16_41) * u_xlat16_31.xy;
        u_xlat16_31.xy = u_xlat16_31.xy * vs_COLOR0.xx;
        u_xlat10_6 = texture(_Diffuse1, vs_TEXCOORD0.zw, -1.0);
        u_xlat26.xy = vec2(vs_TEXCOORD2.z * float(_DetailNormalUVScale), vs_TEXCOORD2.w * float(_DetailNormalUVScale));
        u_xlat10_3.xyw = texture(_DetailNormal, u_xlat26.xy, -1.0).xyw;
        u_xlat16_7.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_7.xy = u_xlat16_7.xy * vec2(_DetailNormalScale);
        u_xlat16_41 = (-u_xlat0.x) + 1.0;
        u_xlat16_7.xy = vec2(u_xlat16_41) * u_xlat16_7.xy;
        u_xlat10_8 = texture(_Diffuse2, vs_TEXCOORD2.xy, -1.0);
        u_xlat10_9 = texture(_DetailDiffuse, vs_TEXCOORD2.zw, -1.0);
        u_xlat16_41 = u_xlat10_8.w * _UseDiffuseTwoHeight;
        u_xlat16_33 = u_xlat10_9.w * _UseDetailDiffuseHeight;
        u_xlat16_10.xyz = u_xlat10_6.xyz + (-u_xlat10_8.xyz);
        u_xlat16_46 = u_xlat10_6.w * _UseDiffuseOneHeight + (-u_xlat16_41);
        u_xlat16_10.xyz = u_xlat0.yyy * u_xlat16_10.xyz + u_xlat10_8.xyz;
        u_xlat16_41 = u_xlat0.y * u_xlat16_46 + u_xlat16_41;
        u_xlat16_46 = u_xlat0.x * _DetailBlendVal;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_46 = min(max(u_xlat16_46, 0.0), 1.0);
#else
        u_xlat16_46 = clamp(u_xlat16_46, 0.0, 1.0);
#endif
        u_xlat16_49 = (-u_xlat16_46) + 1.0;
        u_xlat16_33 = u_xlat16_33 * u_xlat16_49;
        u_xlat16_41 = max(u_xlat16_41, u_xlat16_33);
        u_xlat16_11.xyz = u_xlat10_9.xyz * u_xlat16_10.xyz;
        u_xlat16_12.xyz = u_xlat16_11.xyz * vec3(4.0, 4.0, 4.0);
        u_xlat16_10.xyz = (-u_xlat16_11.xyz) * vec3(4.0, 4.0, 4.0) + u_xlat16_10.xyz;
        u_xlat16_10.xyz = vec3(u_xlat16_46) * u_xlat16_10.xyz + u_xlat16_12.xyz;
        u_xlat16_10.xyz = min(u_xlat16_10.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_33 = u_xlat10_4.z * _UseSpecularTwo;
        u_xlat16_46 = u_xlat10_3.w * _UseDetailSpecular;
        u_xlat16_11.x = _UseSpecularOne * u_xlat10_3.z + (-u_xlat16_33);
        u_xlat16_33 = u_xlat0.y * u_xlat16_11.x + u_xlat16_33;
        u_xlat16_46 = u_xlat16_49 * u_xlat16_46;
        u_xlat16_33 = max(u_xlat16_46, u_xlat16_33);
        u_xlat16_5.xy = u_xlat16_5.xy * vec2(_Normal0Scale) + u_xlat16_31.xy;
        u_xlat16_5.xy = u_xlat16_7.xy * vs_COLOR0.xx + u_xlat16_5.xy;
    } else {
        u_xlat16_10.x = float(0.0);
        u_xlat16_10.y = float(0.0);
        u_xlat16_10.z = float(0.0);
        u_xlat16_5.x = float(0.0);
        u_xlat16_5.y = float(0.0);
        u_xlat16_41 = 1.0;
        u_xlat16_33 = 0.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor);
#endif
    u_xlat16_7.xyw = u_xlat16_10.xyz * _TintColor.xyz;
    u_xlat16_7.xyw = (bool(u_xlatb0)) ? u_xlat16_7.xyw : u_xlat16_10.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend);
#endif
    u_xlat16_13 = u_xlat16_41;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_26 = vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_41 = _HeightContrast * 10.0;
    u_xlat16_13 = u_xlat16_13 + -1.0;
    u_xlat16_44 = _HeightSpread + 0.100000001;
    u_xlat16_26 = log2(u_xlat16_26);
    u_xlat16_26 = u_xlat16_26 * u_xlat16_44;
    u_xlat16_26 = exp2(u_xlat16_26);
    u_xlat16_13 = u_xlat16_26 * 2.0 + u_xlat16_13;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_26 = _HeightContrast * 10.0 + 1.0;
    u_xlat16_26 = _HeightContrast * 10.0 + u_xlat16_26;
    u_xlat13 = u_xlat16_13 * u_xlat16_26 + (-u_xlat16_41);
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat16_41 = (u_xlatb0) ? u_xlat13 : vs_COLOR0.w;
    u_xlat16_5.z = 1.0;
    u_xlat16_5.xyz = (-u_xlat16_1.xyz) + u_xlat16_5.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_41) * u_xlat16_5.xyz + u_xlat16_1.xyz;
    u_xlat16_5.x = (-u_xlat16_40) + u_xlat16_33;
    u_xlat16_40 = u_xlat16_41 * u_xlat16_5.x + u_xlat16_40;
    u_xlat16_5.xyz = (-u_xlat16_2.xyz) + u_xlat16_7.xyw;
    u_xlat16_2.xyz = vec3(u_xlat16_41) * u_xlat16_5.xyz + u_xlat16_2.xyz;
    u_xlat16_40 = u_xlat16_40 + _Shininess;
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD5.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!(vs_TEXCOORD1.w<100.0);
#else
    u_xlatb39 = vs_TEXCOORD1.w<100.0;
#endif
    if(u_xlatb39){
        u_xlat3.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
        u_xlat39 = texture(_CameraDepthBlendTexture, u_xlat3.xy).x;
        u_xlat39 = _ZBufferParams.z * u_xlat39 + _ZBufferParams.w;
        u_xlat39 = float(1.0) / u_xlat39;
        u_xlat39 = u_xlat39 + (-vs_TEXCOORD1.w);
        u_xlat39 = abs(u_xlat39) * _DepthBiasScaled;
        u_xlat39 = u_xlat39 * 0.600000024;
#ifdef UNITY_ADRENO_ES3
        u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
        u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
        u_xlat39 = sqrt(u_xlat39);
        u_xlat10_4.xyz = texture(_CameraDepthBlendNormTexture, u_xlat3.xy).xyz;
        u_xlat16_1.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat10_3.xyz = texture(_CameraDepthBlendDiffTexture, u_xlat3.xy).xyz;
        u_xlat16_41 = u_xlat0.y * _DepthBlendAO;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
        u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
        u_xlat42 = (-u_xlat39) + 1.0;
        u_xlat42 = u_xlat16_41 * u_xlat42 + u_xlat39;
        u_xlat42 = max(u_xlat42, 0.899999976);
        u_xlat4.xyz = u_xlat16_2.xyz * vec3(u_xlat42) + (-u_xlat10_3.xyz);
        u_xlat2.xyz = vec3(u_xlat39) * u_xlat4.xyz + u_xlat10_3.xyz;
        u_xlat3.xyz = u_xlat0.xyz + (-u_xlat16_1.xyz);
        u_xlat3.xyz = vec3(u_xlat39) * u_xlat3.xyz + u_xlat16_1.xyz;
        u_xlat16_2.xyz = u_xlat2.xyz;
        u_xlat16_3.xyz = u_xlat3.xyz;
    } else {
        u_xlat16_3.xyz = u_xlat0.xyz;
    //ENDIF
    }
    u_xlat16_1.x = u_xlat16_40 * _Terrain_Smoothness;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    SV_Target2.w = min(u_xlat16_1.x, 0.5);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(vec3(_Terrain_Specular, _Terrain_Specular, _Terrain_Specular));
    u_xlat16_0.x = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_40 = max(u_xlat16_1.z, u_xlat16_1.y);
    u_xlat16_40 = max(u_xlat16_40, u_xlat16_1.x);
    u_xlat16_40 = (-u_xlat16_40) + 1.0;
    SV_Target1.xyz = vec3(u_xlat16_40) * u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_40 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_40 : u_xlat16_1.z;
    SV_Target0.w = 0.0;
    SV_Target1.w = _SSAO_Intensity;
    SV_Target2.xy = u_xlat16_1.xy;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MSAA_INTERPOLATION" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _Diffuse1_ST;
uniform 	float _UVDiffuse2;
uniform 	vec4 _Diffuse2_ST;
uniform 	float _UVDetail;
uniform 	vec4 _DetailDiffuse_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec2 u_xlat12;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat15 = u_xlat15 + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat15 = u_xlat15 + u_xlat2.x;
    u_xlat15 = u_xlat15 * 0.330000013;
    u_xlat2.xy = vec2(u_xlat15) * in_TEXCOORD0.xy;
    u_xlat12.xy = vec2(u_xlat15) * in_TEXCOORD1.xy;
    vs_TEXCOORD0.xy = u_xlat2.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Diffuse1_ST.xy + _Diffuse1_ST.zw;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat15 * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UVDiffuse2==0.0);
#else
    u_xlatb15 = _UVDiffuse2==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat2.xy : u_xlat12.xy;
    vs_TEXCOORD2.xy = u_xlat1.xy * _Diffuse2_ST.xy + _Diffuse2_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UVDetail==0.0);
#else
    u_xlatb15 = _UVDetail==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat2.xy : u_xlat12.xy;
    vs_TEXCOORD2.zw = u_xlat1.xy * _DetailDiffuse_ST.xy + _DetailDiffuse_ST.zw;
    vs_TEXCOORD3.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz;
    vs_TEXCOORD3.y = u_xlat16_4.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat0.y;
    vs_TEXCOORD5.w = u_xlat0.z;
    vs_TEXCOORD4.y = u_xlat16_4.y;
    vs_TEXCOORD5.y = u_xlat16_4.z;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump float _HeightSpread;
uniform 	mediump float _HeightContrast;
uniform 	mediump float _UseTintColor;
uniform 	mediump float _UseDiffuseOneHeight;
uniform 	mediump float _UseDiffuseTwoHeight;
uniform 	mediump float _UseDetailDiffuseHeight;
uniform 	mediump float _UseGrassHeightBlend;
uniform 	mediump float _UseGrassSpecular;
uniform 	mediump float _UseSpecularOne;
uniform 	mediump float _UseSpecularTwo;
uniform 	mediump float _UseDetailSpecular;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _SSAO_Intensity;
uniform 	mediump float _Terrain_Smoothness;
uniform 	mediump float _Terrain_Specular;
uniform 	mediump float _Shininess;
uniform 	mediump float _Diffuse2Distance;
uniform 	mediump float _Diffuse2Fade;
uniform 	mediump float _DetailNormalUVScale;
uniform 	mediump float _DetailBlendVal;
uniform 	mediump float _DetailDistance;
uniform 	mediump float _DetailFade;
uniform 	mediump float _DepthBiasScaled;
uniform 	mediump float _DepthBlendAO;
uniform lowp sampler2D _GrassNormal;
uniform lowp sampler2D _GrassDiffuse;
uniform lowp sampler2D _Normal0;
uniform lowp sampler2D _Normal2;
uniform lowp sampler2D _Diffuse1;
uniform lowp sampler2D _DetailNormal;
uniform lowp sampler2D _Diffuse2;
uniform lowp sampler2D _DetailDiffuse;
uniform highp sampler2D _CameraDepthBlendTexture;
uniform lowp sampler2D _CameraDepthBlendNormTexture;
uniform lowp sampler2D _CameraDepthBlendDiffTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_6;
mediump vec4 u_xlat16_7;
lowp vec4 u_xlat10_8;
lowp vec4 u_xlat10_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
mediump vec3 u_xlat16_12;
float u_xlat13;
mediump float u_xlat16_13;
vec2 u_xlat26;
mediump float u_xlat16_26;
mediump vec2 u_xlat16_31;
mediump float u_xlat16_33;
float u_xlat39;
bool u_xlatb39;
mediump float u_xlat16_40;
mediump float u_xlat16_41;
float u_xlat42;
mediump float u_xlat16_44;
mediump float u_xlat16_46;
mediump float u_xlat16_49;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_COLOR0.w<0.99000001);
#else
    u_xlatb0 = vs_COLOR0.w<0.99000001;
#endif
    if(u_xlatb0){
        u_xlat10_0 = texture(_GrassNormal, vs_TEXCOORD0.xy, -1.0);
        u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_40 = u_xlat10_0.w * _UseGrassSpecular;
        u_xlat10_0.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.xy, -1.0).xyz;
        u_xlat16_2.xyz = u_xlat10_0.xyz;
    } else {
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
        u_xlat16_1.x = float(0.0);
        u_xlat16_1.y = float(0.0);
        u_xlat16_1.z = float(1.0);
        u_xlat16_40 = float(0.0);
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.00999999978<vs_COLOR0.w);
#else
    u_xlatb0 = 0.00999999978<vs_COLOR0.w;
#endif
    if(u_xlatb0){
        u_xlat0.x = vs_TEXCOORD3.w;
        u_xlat0.y = vs_TEXCOORD4.w;
        u_xlat0.z = vs_TEXCOORD5.w;
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat13 = u_xlat0.x / _Diffuse2Distance;
#ifdef UNITY_ADRENO_ES3
        u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
        u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
        u_xlat13 = u_xlat13 + 9.99999975e-05;
        u_xlat13 = log2(u_xlat13);
        u_xlat13 = u_xlat13 * _Diffuse2Fade;
        u_xlat0.y = exp2(u_xlat13);
        u_xlat0.x = u_xlat0.x / _DetailDistance;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = u_xlat0.x + 9.99999975e-05;
        u_xlat0.x = log2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * _DetailFade;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat0.xy = min(u_xlat0.xy, vec2(1.0, 1.0));
        u_xlat10_3.xyz = texture(_Normal0, vs_TEXCOORD0.zw, -1.0).xyw;
        u_xlat10_4.xyz = texture(_Normal2, vs_TEXCOORD2.xy, -1.0).xyw;
        u_xlat16_5.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_31.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_41 = (-u_xlat0.y) + 1.0;
        u_xlat16_31.xy = vec2(u_xlat16_41) * u_xlat16_31.xy;
        u_xlat10_6 = texture(_Diffuse1, vs_TEXCOORD0.zw, -1.0);
        u_xlat26.xy = vec2(vs_TEXCOORD2.z * float(_DetailNormalUVScale), vs_TEXCOORD2.w * float(_DetailNormalUVScale));
        u_xlat10_3.xyw = texture(_DetailNormal, u_xlat26.xy, -1.0).xyw;
        u_xlat16_7.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_41 = (-u_xlat0.x) + 1.0;
        u_xlat16_7.xy = vec2(u_xlat16_41) * u_xlat16_7.xy;
        u_xlat10_8 = texture(_Diffuse2, vs_TEXCOORD2.xy, -1.0);
        u_xlat10_9 = texture(_DetailDiffuse, vs_TEXCOORD2.zw, -1.0);
        u_xlat16_41 = u_xlat10_8.w * _UseDiffuseTwoHeight;
        u_xlat16_33 = u_xlat10_9.w * _UseDetailDiffuseHeight;
        u_xlat16_10.xyz = u_xlat10_6.xyz + (-u_xlat10_8.xyz);
        u_xlat16_46 = u_xlat10_6.w * _UseDiffuseOneHeight + (-u_xlat16_41);
        u_xlat16_10.xyz = u_xlat0.yyy * u_xlat16_10.xyz + u_xlat10_8.xyz;
        u_xlat16_41 = u_xlat0.y * u_xlat16_46 + u_xlat16_41;
        u_xlat16_46 = u_xlat0.x * _DetailBlendVal;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_46 = min(max(u_xlat16_46, 0.0), 1.0);
#else
        u_xlat16_46 = clamp(u_xlat16_46, 0.0, 1.0);
#endif
        u_xlat16_49 = (-u_xlat16_46) + 1.0;
        u_xlat16_33 = u_xlat16_33 * u_xlat16_49;
        u_xlat16_41 = max(u_xlat16_41, u_xlat16_33);
        u_xlat16_11.xyz = u_xlat10_9.xyz * u_xlat16_10.xyz;
        u_xlat16_12.xyz = u_xlat16_11.xyz * vec3(4.0, 4.0, 4.0);
        u_xlat16_10.xyz = (-u_xlat16_11.xyz) * vec3(4.0, 4.0, 4.0) + u_xlat16_10.xyz;
        u_xlat16_10.xyz = vec3(u_xlat16_46) * u_xlat16_10.xyz + u_xlat16_12.xyz;
        u_xlat16_10.xyz = min(u_xlat16_10.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_33 = u_xlat10_4.z * _UseSpecularTwo;
        u_xlat16_46 = u_xlat10_3.w * _UseDetailSpecular;
        u_xlat16_11.x = _UseSpecularOne * u_xlat10_3.z + (-u_xlat16_33);
        u_xlat16_33 = u_xlat0.y * u_xlat16_11.x + u_xlat16_33;
        u_xlat16_46 = u_xlat16_49 * u_xlat16_46;
        u_xlat16_33 = max(u_xlat16_46, u_xlat16_33);
        u_xlat16_5.xy = u_xlat16_31.xy * vs_COLOR0.xx + u_xlat16_5.xy;
        u_xlat16_5.xy = u_xlat16_7.xy * vs_COLOR0.xx + u_xlat16_5.xy;
    } else {
        u_xlat16_10.x = float(0.0);
        u_xlat16_10.y = float(0.0);
        u_xlat16_10.z = float(0.0);
        u_xlat16_5.x = float(0.0);
        u_xlat16_5.y = float(0.0);
        u_xlat16_41 = 1.0;
        u_xlat16_33 = 0.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor);
#endif
    u_xlat16_7.xyw = u_xlat16_10.xyz * _TintColor.xyz;
    u_xlat16_7.xyw = (bool(u_xlatb0)) ? u_xlat16_7.xyw : u_xlat16_10.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend);
#endif
    u_xlat16_13 = u_xlat16_41;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_26 = vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_41 = _HeightContrast * 10.0;
    u_xlat16_13 = u_xlat16_13 + -1.0;
    u_xlat16_44 = _HeightSpread + 0.100000001;
    u_xlat16_26 = log2(u_xlat16_26);
    u_xlat16_26 = u_xlat16_26 * u_xlat16_44;
    u_xlat16_26 = exp2(u_xlat16_26);
    u_xlat16_13 = u_xlat16_26 * 2.0 + u_xlat16_13;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_26 = _HeightContrast * 10.0 + 1.0;
    u_xlat16_26 = _HeightContrast * 10.0 + u_xlat16_26;
    u_xlat13 = u_xlat16_13 * u_xlat16_26 + (-u_xlat16_41);
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat16_41 = (u_xlatb0) ? u_xlat13 : vs_COLOR0.w;
    u_xlat16_5.z = 1.0;
    u_xlat16_5.xyz = (-u_xlat16_1.xyz) + u_xlat16_5.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_41) * u_xlat16_5.xyz + u_xlat16_1.xyz;
    u_xlat16_5.x = (-u_xlat16_40) + u_xlat16_33;
    u_xlat16_40 = u_xlat16_41 * u_xlat16_5.x + u_xlat16_40;
    u_xlat16_5.xyz = (-u_xlat16_2.xyz) + u_xlat16_7.xyw;
    u_xlat16_2.xyz = vec3(u_xlat16_41) * u_xlat16_5.xyz + u_xlat16_2.xyz;
    u_xlat16_40 = u_xlat16_40 + _Shininess;
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD5.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!(vs_TEXCOORD1.w<100.0);
#else
    u_xlatb39 = vs_TEXCOORD1.w<100.0;
#endif
    if(u_xlatb39){
        u_xlat3.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
        u_xlat39 = texture(_CameraDepthBlendTexture, u_xlat3.xy).x;
        u_xlat39 = _ZBufferParams.z * u_xlat39 + _ZBufferParams.w;
        u_xlat39 = float(1.0) / u_xlat39;
        u_xlat39 = u_xlat39 + (-vs_TEXCOORD1.w);
        u_xlat39 = abs(u_xlat39) * _DepthBiasScaled;
        u_xlat39 = u_xlat39 * 0.600000024;
#ifdef UNITY_ADRENO_ES3
        u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
        u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
        u_xlat39 = sqrt(u_xlat39);
        u_xlat10_4.xyz = texture(_CameraDepthBlendNormTexture, u_xlat3.xy).xyz;
        u_xlat16_1.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat10_3.xyz = texture(_CameraDepthBlendDiffTexture, u_xlat3.xy).xyz;
        u_xlat16_41 = u_xlat0.y * _DepthBlendAO;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
        u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
        u_xlat42 = (-u_xlat39) + 1.0;
        u_xlat42 = u_xlat16_41 * u_xlat42 + u_xlat39;
        u_xlat42 = max(u_xlat42, 0.899999976);
        u_xlat4.xyz = u_xlat16_2.xyz * vec3(u_xlat42) + (-u_xlat10_3.xyz);
        u_xlat2.xyz = vec3(u_xlat39) * u_xlat4.xyz + u_xlat10_3.xyz;
        u_xlat3.xyz = u_xlat0.xyz + (-u_xlat16_1.xyz);
        u_xlat3.xyz = vec3(u_xlat39) * u_xlat3.xyz + u_xlat16_1.xyz;
        u_xlat16_2.xyz = u_xlat2.xyz;
        u_xlat16_3.xyz = u_xlat3.xyz;
    } else {
        u_xlat16_3.xyz = u_xlat0.xyz;
    //ENDIF
    }
    u_xlat16_1.x = u_xlat16_40 * _Terrain_Smoothness;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    SV_Target2.w = min(u_xlat16_1.x, 0.5);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(vec3(_Terrain_Specular, _Terrain_Specular, _Terrain_Specular));
    u_xlat16_0.x = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_40 = max(u_xlat16_1.z, u_xlat16_1.y);
    u_xlat16_40 = max(u_xlat16_40, u_xlat16_1.x);
    u_xlat16_40 = (-u_xlat16_40) + 1.0;
    SV_Target1.xyz = vec3(u_xlat16_40) * u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_40 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_40 : u_xlat16_1.z;
    SV_Target0.w = 0.0;
    SV_Target1.w = _SSAO_Intensity;
    SV_Target2.xy = u_xlat16_1.xy;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MSAA_INTERPOLATION" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _Diffuse1_ST;
uniform 	float _UVDiffuse2;
uniform 	vec4 _Diffuse2_ST;
uniform 	float _UVDetail;
uniform 	vec4 _DetailDiffuse_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat7;
float u_xlat16;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x;
    u_xlat2.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].x;
    u_xlat2.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].x;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].y;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].y;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].y;
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.xy = sqrt(u_xlat2.xy);
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].z;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].z;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].z;
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat2.x = u_xlat7.x + u_xlat2.x;
    u_xlat2.x = u_xlat2.x * 0.330000013;
    u_xlat7.xy = u_xlat2.xx * in_TEXCOORD0.xy;
    u_xlat2.xw = u_xlat2.xx * in_TEXCOORD1.xy;
    vs_TEXCOORD0.xy = u_xlat7.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Diffuse1_ST.xy + _Diffuse1_ST.zw;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UVDiffuse2==0.0);
#else
    u_xlatb1 = _UVDiffuse2==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb1)) ? u_xlat7.xy : u_xlat2.xw;
    vs_TEXCOORD2.xy = u_xlat1.xy * _Diffuse2_ST.xy + _Diffuse2_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UVDetail==0.0);
#else
    u_xlatb1 = _UVDetail==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb1)) ? u_xlat7.xy : u_xlat2.xw;
    vs_TEXCOORD2.zw = u_xlat1.xy * _DetailDiffuse_ST.xy + _DetailDiffuse_ST.zw;
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat2.xyz = vec3(u_xlat0) * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_4.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = vec3(u_xlat0) * u_xlat16_4.xyz;
    vs_TEXCOORD3.y = u_xlat16_4.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD3.w = u_xlat5.x;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat5.y;
    vs_TEXCOORD5.w = u_xlat5.z;
    vs_TEXCOORD4.y = u_xlat16_4.y;
    vs_TEXCOORD5.y = u_xlat16_4.z;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump float _HeightSpread;
uniform 	mediump float _HeightContrast;
uniform 	mediump float _UseTintColor;
uniform 	mediump float _UseDiffuseOneHeight;
uniform 	mediump float _UseDiffuseTwoHeight;
uniform 	mediump float _UseDetailDiffuseHeight;
uniform 	mediump float _UseGrassHeightBlend;
uniform 	mediump float _UseGrassSpecular;
uniform 	mediump float _UseSpecularOne;
uniform 	mediump float _UseSpecularTwo;
uniform 	mediump float _UseDetailSpecular;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _SSAO_Intensity;
uniform 	mediump float _Terrain_Smoothness;
uniform 	mediump float _Terrain_Specular;
uniform 	mediump float _Shininess;
uniform 	float _GrassNormalScale;
uniform 	float _Normal0Scale;
uniform 	mediump float _Normal2Scale;
uniform 	mediump float _Diffuse2Distance;
uniform 	mediump float _Diffuse2Fade;
uniform 	mediump float _DetailNormalScale;
uniform 	mediump float _DetailNormalUVScale;
uniform 	mediump float _DetailBlendVal;
uniform 	mediump float _DetailDistance;
uniform 	mediump float _DetailFade;
uniform 	mediump float _DepthBiasScaled;
uniform 	mediump float _DepthBlendAO;
uniform lowp sampler2D _GrassNormal;
uniform lowp sampler2D _GrassDiffuse;
uniform lowp sampler2D _Normal0;
uniform lowp sampler2D _Normal2;
uniform lowp sampler2D _Diffuse1;
uniform lowp sampler2D _DetailNormal;
uniform lowp sampler2D _Diffuse2;
uniform lowp sampler2D _DetailDiffuse;
uniform highp sampler2D _CameraDepthBlendTexture;
uniform lowp sampler2D _CameraDepthBlendNormTexture;
uniform lowp sampler2D _CameraDepthBlendDiffTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_6;
mediump vec4 u_xlat16_7;
lowp vec4 u_xlat10_8;
lowp vec4 u_xlat10_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
mediump vec3 u_xlat16_12;
float u_xlat13;
mediump float u_xlat16_13;
vec2 u_xlat26;
mediump float u_xlat16_26;
mediump vec2 u_xlat16_31;
mediump float u_xlat16_33;
float u_xlat39;
bool u_xlatb39;
mediump float u_xlat16_40;
mediump float u_xlat16_41;
float u_xlat42;
mediump float u_xlat16_44;
mediump float u_xlat16_46;
mediump float u_xlat16_49;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_COLOR0.w<0.99000001);
#else
    u_xlatb0 = vs_COLOR0.w<0.99000001;
#endif
    if(u_xlatb0){
        u_xlat10_0 = texture(_GrassNormal, vs_TEXCOORD0.xy, -1.0);
        u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_1.xy = u_xlat16_1.xy * vec2(_GrassNormalScale);
        u_xlat16_40 = u_xlat10_0.w * _UseGrassSpecular;
        u_xlat10_0.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.xy, -1.0).xyz;
        u_xlat16_2.xyz = u_xlat10_0.xyz;
    } else {
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
        u_xlat16_1.x = float(0.0);
        u_xlat16_1.y = float(0.0);
        u_xlat16_1.z = float(1.0);
        u_xlat16_40 = float(0.0);
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.00999999978<vs_COLOR0.w);
#else
    u_xlatb0 = 0.00999999978<vs_COLOR0.w;
#endif
    if(u_xlatb0){
        u_xlat0.x = vs_TEXCOORD3.w;
        u_xlat0.y = vs_TEXCOORD4.w;
        u_xlat0.z = vs_TEXCOORD5.w;
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat13 = u_xlat0.x / _Diffuse2Distance;
#ifdef UNITY_ADRENO_ES3
        u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
        u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
        u_xlat13 = u_xlat13 + 9.99999975e-05;
        u_xlat13 = log2(u_xlat13);
        u_xlat13 = u_xlat13 * _Diffuse2Fade;
        u_xlat0.y = exp2(u_xlat13);
        u_xlat0.x = u_xlat0.x / _DetailDistance;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = u_xlat0.x + 9.99999975e-05;
        u_xlat0.x = log2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * _DetailFade;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat0.xy = min(u_xlat0.xy, vec2(1.0, 1.0));
        u_xlat10_3.xyz = texture(_Normal0, vs_TEXCOORD0.zw, -1.0).xyw;
        u_xlat10_4.xyz = texture(_Normal2, vs_TEXCOORD2.xy, -1.0).xyw;
        u_xlat16_5.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_31.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_31.xy = u_xlat16_31.xy * vec2(_Normal2Scale);
        u_xlat16_41 = (-u_xlat0.y) + 1.0;
        u_xlat16_31.xy = vec2(u_xlat16_41) * u_xlat16_31.xy;
        u_xlat16_31.xy = u_xlat16_31.xy * vs_COLOR0.xx;
        u_xlat10_6 = texture(_Diffuse1, vs_TEXCOORD0.zw, -1.0);
        u_xlat26.xy = vec2(vs_TEXCOORD2.z * float(_DetailNormalUVScale), vs_TEXCOORD2.w * float(_DetailNormalUVScale));
        u_xlat10_3.xyw = texture(_DetailNormal, u_xlat26.xy, -1.0).xyw;
        u_xlat16_7.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_7.xy = u_xlat16_7.xy * vec2(_DetailNormalScale);
        u_xlat16_41 = (-u_xlat0.x) + 1.0;
        u_xlat16_7.xy = vec2(u_xlat16_41) * u_xlat16_7.xy;
        u_xlat10_8 = texture(_Diffuse2, vs_TEXCOORD2.xy, -1.0);
        u_xlat10_9 = texture(_DetailDiffuse, vs_TEXCOORD2.zw, -1.0);
        u_xlat16_41 = u_xlat10_8.w * _UseDiffuseTwoHeight;
        u_xlat16_33 = u_xlat10_9.w * _UseDetailDiffuseHeight;
        u_xlat16_10.xyz = u_xlat10_6.xyz + (-u_xlat10_8.xyz);
        u_xlat16_46 = u_xlat10_6.w * _UseDiffuseOneHeight + (-u_xlat16_41);
        u_xlat16_10.xyz = u_xlat0.yyy * u_xlat16_10.xyz + u_xlat10_8.xyz;
        u_xlat16_41 = u_xlat0.y * u_xlat16_46 + u_xlat16_41;
        u_xlat16_46 = u_xlat0.x * _DetailBlendVal;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_46 = min(max(u_xlat16_46, 0.0), 1.0);
#else
        u_xlat16_46 = clamp(u_xlat16_46, 0.0, 1.0);
#endif
        u_xlat16_49 = (-u_xlat16_46) + 1.0;
        u_xlat16_33 = u_xlat16_33 * u_xlat16_49;
        u_xlat16_41 = max(u_xlat16_41, u_xlat16_33);
        u_xlat16_11.xyz = u_xlat10_9.xyz * u_xlat16_10.xyz;
        u_xlat16_12.xyz = u_xlat16_11.xyz * vec3(4.0, 4.0, 4.0);
        u_xlat16_10.xyz = (-u_xlat16_11.xyz) * vec3(4.0, 4.0, 4.0) + u_xlat16_10.xyz;
        u_xlat16_10.xyz = vec3(u_xlat16_46) * u_xlat16_10.xyz + u_xlat16_12.xyz;
        u_xlat16_10.xyz = min(u_xlat16_10.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_33 = u_xlat10_4.z * _UseSpecularTwo;
        u_xlat16_46 = u_xlat10_3.w * _UseDetailSpecular;
        u_xlat16_11.x = _UseSpecularOne * u_xlat10_3.z + (-u_xlat16_33);
        u_xlat16_33 = u_xlat0.y * u_xlat16_11.x + u_xlat16_33;
        u_xlat16_46 = u_xlat16_49 * u_xlat16_46;
        u_xlat16_33 = max(u_xlat16_46, u_xlat16_33);
        u_xlat16_5.xy = u_xlat16_5.xy * vec2(_Normal0Scale) + u_xlat16_31.xy;
        u_xlat16_5.xy = u_xlat16_7.xy * vs_COLOR0.xx + u_xlat16_5.xy;
    } else {
        u_xlat16_10.x = float(0.0);
        u_xlat16_10.y = float(0.0);
        u_xlat16_10.z = float(0.0);
        u_xlat16_5.x = float(0.0);
        u_xlat16_5.y = float(0.0);
        u_xlat16_41 = 1.0;
        u_xlat16_33 = 0.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor);
#endif
    u_xlat16_7.xyw = u_xlat16_10.xyz * _TintColor.xyz;
    u_xlat16_7.xyw = (bool(u_xlatb0)) ? u_xlat16_7.xyw : u_xlat16_10.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend);
#endif
    u_xlat16_13 = u_xlat16_41;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_26 = vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_41 = _HeightContrast * 10.0;
    u_xlat16_13 = u_xlat16_13 + -1.0;
    u_xlat16_44 = _HeightSpread + 0.100000001;
    u_xlat16_26 = log2(u_xlat16_26);
    u_xlat16_26 = u_xlat16_26 * u_xlat16_44;
    u_xlat16_26 = exp2(u_xlat16_26);
    u_xlat16_13 = u_xlat16_26 * 2.0 + u_xlat16_13;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_26 = _HeightContrast * 10.0 + 1.0;
    u_xlat16_26 = _HeightContrast * 10.0 + u_xlat16_26;
    u_xlat13 = u_xlat16_13 * u_xlat16_26 + (-u_xlat16_41);
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat16_41 = (u_xlatb0) ? u_xlat13 : vs_COLOR0.w;
    u_xlat16_5.z = 1.0;
    u_xlat16_5.xyz = (-u_xlat16_1.xyz) + u_xlat16_5.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_41) * u_xlat16_5.xyz + u_xlat16_1.xyz;
    u_xlat16_5.x = (-u_xlat16_40) + u_xlat16_33;
    u_xlat16_40 = u_xlat16_41 * u_xlat16_5.x + u_xlat16_40;
    u_xlat16_5.xyz = (-u_xlat16_2.xyz) + u_xlat16_7.xyw;
    u_xlat16_2.xyz = vec3(u_xlat16_41) * u_xlat16_5.xyz + u_xlat16_2.xyz;
    u_xlat16_40 = u_xlat16_40 + _Shininess;
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD5.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!(vs_TEXCOORD1.w<100.0);
#else
    u_xlatb39 = vs_TEXCOORD1.w<100.0;
#endif
    if(u_xlatb39){
        u_xlat3.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
        u_xlat39 = texture(_CameraDepthBlendTexture, u_xlat3.xy).x;
        u_xlat39 = _ZBufferParams.z * u_xlat39 + _ZBufferParams.w;
        u_xlat39 = float(1.0) / u_xlat39;
        u_xlat39 = u_xlat39 + (-vs_TEXCOORD1.w);
        u_xlat39 = abs(u_xlat39) * _DepthBiasScaled;
        u_xlat39 = u_xlat39 * 0.600000024;
#ifdef UNITY_ADRENO_ES3
        u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
        u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
        u_xlat39 = sqrt(u_xlat39);
        u_xlat10_4.xyz = texture(_CameraDepthBlendNormTexture, u_xlat3.xy).xyz;
        u_xlat16_1.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat10_3.xyz = texture(_CameraDepthBlendDiffTexture, u_xlat3.xy).xyz;
        u_xlat16_41 = u_xlat0.y * _DepthBlendAO;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
        u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
        u_xlat42 = (-u_xlat39) + 1.0;
        u_xlat42 = u_xlat16_41 * u_xlat42 + u_xlat39;
        u_xlat42 = max(u_xlat42, 0.899999976);
        u_xlat4.xyz = u_xlat16_2.xyz * vec3(u_xlat42) + (-u_xlat10_3.xyz);
        u_xlat2.xyz = vec3(u_xlat39) * u_xlat4.xyz + u_xlat10_3.xyz;
        u_xlat3.xyz = u_xlat0.xyz + (-u_xlat16_1.xyz);
        u_xlat3.xyz = vec3(u_xlat39) * u_xlat3.xyz + u_xlat16_1.xyz;
        u_xlat16_2.xyz = u_xlat2.xyz;
        u_xlat16_3.xyz = u_xlat3.xyz;
    } else {
        u_xlat16_3.xyz = u_xlat0.xyz;
    //ENDIF
    }
    u_xlat16_1.x = u_xlat16_40 * _Terrain_Smoothness;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    SV_Target2.w = min(u_xlat16_1.x, 0.5);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(vec3(_Terrain_Specular, _Terrain_Specular, _Terrain_Specular));
    u_xlat16_0.x = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_40 = max(u_xlat16_1.z, u_xlat16_1.y);
    u_xlat16_40 = max(u_xlat16_40, u_xlat16_1.x);
    u_xlat16_40 = (-u_xlat16_40) + 1.0;
    SV_Target1.xyz = vec3(u_xlat16_40) * u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_40 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_40 : u_xlat16_1.z;
    SV_Target0.w = 0.0;
    SV_Target1.w = _SSAO_Intensity;
    SV_Target2.xy = u_xlat16_1.xy;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MSAA_INTERPOLATION" "LINE_INTERPOLATION" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _Diffuse1_ST;
uniform 	float _UVDiffuse2;
uniform 	vec4 _Diffuse2_ST;
uniform 	float _UVDetail;
uniform 	vec4 _DetailDiffuse_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec2 u_xlat12;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat15 = u_xlat15 + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat15 = u_xlat15 + u_xlat2.x;
    u_xlat15 = u_xlat15 * 0.330000013;
    u_xlat2.xy = vec2(u_xlat15) * in_TEXCOORD0.xy;
    u_xlat12.xy = vec2(u_xlat15) * in_TEXCOORD1.xy;
    vs_TEXCOORD0.xy = u_xlat2.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Diffuse1_ST.xy + _Diffuse1_ST.zw;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat15 * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UVDiffuse2==0.0);
#else
    u_xlatb15 = _UVDiffuse2==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat2.xy : u_xlat12.xy;
    vs_TEXCOORD2.xy = u_xlat1.xy * _Diffuse2_ST.xy + _Diffuse2_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UVDetail==0.0);
#else
    u_xlatb15 = _UVDetail==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat2.xy : u_xlat12.xy;
    vs_TEXCOORD2.zw = u_xlat1.xy * _DetailDiffuse_ST.xy + _DetailDiffuse_ST.zw;
    vs_TEXCOORD3.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz;
    vs_TEXCOORD3.y = u_xlat16_4.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat0.y;
    vs_TEXCOORD5.w = u_xlat0.z;
    vs_TEXCOORD4.y = u_xlat16_4.y;
    vs_TEXCOORD5.y = u_xlat16_4.z;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump float _HeightSpread;
uniform 	mediump float _HeightContrast;
uniform 	mediump float _UseTintColor;
uniform 	mediump float _UseDiffuseOneHeight;
uniform 	mediump float _UseDiffuseTwoHeight;
uniform 	mediump float _UseDetailDiffuseHeight;
uniform 	mediump float _UseGrassHeightBlend;
uniform 	mediump float _UseGrassSpecular;
uniform 	mediump float _UseSpecularOne;
uniform 	mediump float _UseSpecularTwo;
uniform 	mediump float _UseDetailSpecular;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _SSAO_Intensity;
uniform 	mediump float _Terrain_Smoothness;
uniform 	mediump float _Terrain_Specular;
uniform 	mediump float _Shininess;
uniform 	mediump float _Diffuse2Distance;
uniform 	mediump float _Diffuse2Fade;
uniform 	mediump float _DetailNormalUVScale;
uniform 	mediump float _DetailBlendVal;
uniform 	mediump float _DetailDistance;
uniform 	mediump float _DetailFade;
uniform 	mediump float _DepthBiasScaled;
uniform 	mediump float _DepthBlendAO;
uniform lowp sampler2D _GrassNormal;
uniform lowp sampler2D _GrassDiffuse;
uniform lowp sampler2D _Normal0;
uniform lowp sampler2D _Normal2;
uniform lowp sampler2D _Diffuse1;
uniform lowp sampler2D _DetailNormal;
uniform lowp sampler2D _Diffuse2;
uniform lowp sampler2D _DetailDiffuse;
uniform highp sampler2D _CameraDepthBlendTexture;
uniform lowp sampler2D _CameraDepthBlendNormTexture;
uniform lowp sampler2D _CameraDepthBlendDiffTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_6;
mediump vec4 u_xlat16_7;
lowp vec4 u_xlat10_8;
lowp vec4 u_xlat10_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
mediump vec3 u_xlat16_12;
float u_xlat13;
mediump float u_xlat16_13;
vec2 u_xlat26;
mediump float u_xlat16_26;
mediump vec2 u_xlat16_31;
mediump float u_xlat16_33;
float u_xlat39;
bool u_xlatb39;
mediump float u_xlat16_40;
mediump float u_xlat16_41;
float u_xlat42;
mediump float u_xlat16_44;
mediump float u_xlat16_46;
mediump float u_xlat16_49;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_COLOR0.w<0.99000001);
#else
    u_xlatb0 = vs_COLOR0.w<0.99000001;
#endif
    if(u_xlatb0){
        u_xlat10_0 = texture(_GrassNormal, vs_TEXCOORD0.xy, -1.0);
        u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_40 = u_xlat10_0.w * _UseGrassSpecular;
        u_xlat10_0.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.xy, -1.0).xyz;
        u_xlat16_2.xyz = u_xlat10_0.xyz;
    } else {
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
        u_xlat16_1.x = float(0.0);
        u_xlat16_1.y = float(0.0);
        u_xlat16_1.z = float(1.0);
        u_xlat16_40 = float(0.0);
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.00999999978<vs_COLOR0.w);
#else
    u_xlatb0 = 0.00999999978<vs_COLOR0.w;
#endif
    if(u_xlatb0){
        u_xlat0.x = vs_TEXCOORD3.w;
        u_xlat0.y = vs_TEXCOORD4.w;
        u_xlat0.z = vs_TEXCOORD5.w;
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat13 = u_xlat0.x / _Diffuse2Distance;
#ifdef UNITY_ADRENO_ES3
        u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
        u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
        u_xlat13 = u_xlat13 + 9.99999975e-05;
        u_xlat13 = log2(u_xlat13);
        u_xlat13 = u_xlat13 * _Diffuse2Fade;
        u_xlat0.y = exp2(u_xlat13);
        u_xlat0.x = u_xlat0.x / _DetailDistance;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = u_xlat0.x + 9.99999975e-05;
        u_xlat0.x = log2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * _DetailFade;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat0.xy = min(u_xlat0.xy, vec2(1.0, 1.0));
        u_xlat10_3.xyz = texture(_Normal0, vs_TEXCOORD0.zw, -1.0).xyw;
        u_xlat10_4.xyz = texture(_Normal2, vs_TEXCOORD2.xy, -1.0).xyw;
        u_xlat16_5.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_31.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_41 = (-u_xlat0.y) + 1.0;
        u_xlat16_31.xy = vec2(u_xlat16_41) * u_xlat16_31.xy;
        u_xlat10_6 = texture(_Diffuse1, vs_TEXCOORD0.zw, -1.0);
        u_xlat26.xy = vec2(vs_TEXCOORD2.z * float(_DetailNormalUVScale), vs_TEXCOORD2.w * float(_DetailNormalUVScale));
        u_xlat10_3.xyw = texture(_DetailNormal, u_xlat26.xy, -1.0).xyw;
        u_xlat16_7.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_41 = (-u_xlat0.x) + 1.0;
        u_xlat16_7.xy = vec2(u_xlat16_41) * u_xlat16_7.xy;
        u_xlat10_8 = texture(_Diffuse2, vs_TEXCOORD2.xy, -1.0);
        u_xlat10_9 = texture(_DetailDiffuse, vs_TEXCOORD2.zw, -1.0);
        u_xlat16_41 = u_xlat10_8.w * _UseDiffuseTwoHeight;
        u_xlat16_33 = u_xlat10_9.w * _UseDetailDiffuseHeight;
        u_xlat16_10.xyz = u_xlat10_6.xyz + (-u_xlat10_8.xyz);
        u_xlat16_46 = u_xlat10_6.w * _UseDiffuseOneHeight + (-u_xlat16_41);
        u_xlat16_10.xyz = u_xlat0.yyy * u_xlat16_10.xyz + u_xlat10_8.xyz;
        u_xlat16_41 = u_xlat0.y * u_xlat16_46 + u_xlat16_41;
        u_xlat16_46 = u_xlat0.x * _DetailBlendVal;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_46 = min(max(u_xlat16_46, 0.0), 1.0);
#else
        u_xlat16_46 = clamp(u_xlat16_46, 0.0, 1.0);
#endif
        u_xlat16_49 = (-u_xlat16_46) + 1.0;
        u_xlat16_33 = u_xlat16_33 * u_xlat16_49;
        u_xlat16_41 = max(u_xlat16_41, u_xlat16_33);
        u_xlat16_11.xyz = u_xlat10_9.xyz * u_xlat16_10.xyz;
        u_xlat16_12.xyz = u_xlat16_11.xyz * vec3(4.0, 4.0, 4.0);
        u_xlat16_10.xyz = (-u_xlat16_11.xyz) * vec3(4.0, 4.0, 4.0) + u_xlat16_10.xyz;
        u_xlat16_10.xyz = vec3(u_xlat16_46) * u_xlat16_10.xyz + u_xlat16_12.xyz;
        u_xlat16_10.xyz = min(u_xlat16_10.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_33 = u_xlat10_4.z * _UseSpecularTwo;
        u_xlat16_46 = u_xlat10_3.w * _UseDetailSpecular;
        u_xlat16_11.x = _UseSpecularOne * u_xlat10_3.z + (-u_xlat16_33);
        u_xlat16_33 = u_xlat0.y * u_xlat16_11.x + u_xlat16_33;
        u_xlat16_46 = u_xlat16_49 * u_xlat16_46;
        u_xlat16_33 = max(u_xlat16_46, u_xlat16_33);
        u_xlat16_5.xy = u_xlat16_31.xy * vs_COLOR0.xx + u_xlat16_5.xy;
        u_xlat16_5.xy = u_xlat16_7.xy * vs_COLOR0.xx + u_xlat16_5.xy;
    } else {
        u_xlat16_10.x = float(0.0);
        u_xlat16_10.y = float(0.0);
        u_xlat16_10.z = float(0.0);
        u_xlat16_5.x = float(0.0);
        u_xlat16_5.y = float(0.0);
        u_xlat16_41 = 1.0;
        u_xlat16_33 = 0.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor);
#endif
    u_xlat16_7.xyw = u_xlat16_10.xyz * _TintColor.xyz;
    u_xlat16_7.xyw = (bool(u_xlatb0)) ? u_xlat16_7.xyw : u_xlat16_10.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend);
#endif
    u_xlat16_13 = u_xlat16_41;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_26 = vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_41 = _HeightContrast * 10.0;
    u_xlat16_13 = u_xlat16_13 + -1.0;
    u_xlat16_44 = _HeightSpread + 0.100000001;
    u_xlat16_26 = log2(u_xlat16_26);
    u_xlat16_26 = u_xlat16_26 * u_xlat16_44;
    u_xlat16_26 = exp2(u_xlat16_26);
    u_xlat16_13 = u_xlat16_26 * 2.0 + u_xlat16_13;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_26 = _HeightContrast * 10.0 + 1.0;
    u_xlat16_26 = _HeightContrast * 10.0 + u_xlat16_26;
    u_xlat13 = u_xlat16_13 * u_xlat16_26 + (-u_xlat16_41);
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat16_41 = (u_xlatb0) ? u_xlat13 : vs_COLOR0.w;
    u_xlat16_5.z = 1.0;
    u_xlat16_5.xyz = (-u_xlat16_1.xyz) + u_xlat16_5.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_41) * u_xlat16_5.xyz + u_xlat16_1.xyz;
    u_xlat16_5.x = (-u_xlat16_40) + u_xlat16_33;
    u_xlat16_40 = u_xlat16_41 * u_xlat16_5.x + u_xlat16_40;
    u_xlat16_5.xyz = (-u_xlat16_2.xyz) + u_xlat16_7.xyw;
    u_xlat16_2.xyz = vec3(u_xlat16_41) * u_xlat16_5.xyz + u_xlat16_2.xyz;
    u_xlat16_40 = u_xlat16_40 + _Shininess;
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD5.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!(vs_TEXCOORD1.w<100.0);
#else
    u_xlatb39 = vs_TEXCOORD1.w<100.0;
#endif
    if(u_xlatb39){
        u_xlat3.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
        u_xlat39 = texture(_CameraDepthBlendTexture, u_xlat3.xy).x;
        u_xlat39 = _ZBufferParams.z * u_xlat39 + _ZBufferParams.w;
        u_xlat39 = float(1.0) / u_xlat39;
        u_xlat39 = u_xlat39 + (-vs_TEXCOORD1.w);
        u_xlat39 = abs(u_xlat39) * _DepthBiasScaled;
        u_xlat39 = u_xlat39 * 0.600000024;
#ifdef UNITY_ADRENO_ES3
        u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
        u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
        u_xlat39 = sqrt(u_xlat39);
        u_xlat10_4.xyz = texture(_CameraDepthBlendNormTexture, u_xlat3.xy).xyz;
        u_xlat16_1.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat10_3.xyz = texture(_CameraDepthBlendDiffTexture, u_xlat3.xy).xyz;
        u_xlat16_41 = u_xlat0.y * _DepthBlendAO;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
        u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
        u_xlat42 = (-u_xlat39) + 1.0;
        u_xlat42 = u_xlat16_41 * u_xlat42 + u_xlat39;
        u_xlat42 = max(u_xlat42, 0.899999976);
        u_xlat4.xyz = u_xlat16_2.xyz * vec3(u_xlat42) + (-u_xlat10_3.xyz);
        u_xlat2.xyz = vec3(u_xlat39) * u_xlat4.xyz + u_xlat10_3.xyz;
        u_xlat3.xyz = u_xlat0.xyz + (-u_xlat16_1.xyz);
        u_xlat3.xyz = vec3(u_xlat39) * u_xlat3.xyz + u_xlat16_1.xyz;
        u_xlat16_2.xyz = u_xlat2.xyz;
        u_xlat16_3.xyz = u_xlat3.xyz;
    } else {
        u_xlat16_3.xyz = u_xlat0.xyz;
    //ENDIF
    }
    u_xlat16_1.x = u_xlat16_40 * _Terrain_Smoothness;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    SV_Target2.w = min(u_xlat16_1.x, 0.5);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(vec3(_Terrain_Specular, _Terrain_Specular, _Terrain_Specular));
    u_xlat16_0.x = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_40 = max(u_xlat16_1.z, u_xlat16_1.y);
    u_xlat16_40 = max(u_xlat16_40, u_xlat16_1.x);
    u_xlat16_40 = (-u_xlat16_40) + 1.0;
    SV_Target1.xyz = vec3(u_xlat16_40) * u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_40 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_40 : u_xlat16_1.z;
    SV_Target0.w = 0.0;
    SV_Target1.w = _SSAO_Intensity;
    SV_Target2.xy = u_xlat16_1.xy;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MSAA_INTERPOLATION" "LINE_INTERPOLATION" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _Diffuse1_ST;
uniform 	float _UVDiffuse2;
uniform 	vec4 _Diffuse2_ST;
uniform 	float _UVDetail;
uniform 	vec4 _DetailDiffuse_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat7;
float u_xlat16;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x;
    u_xlat2.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].x;
    u_xlat2.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].x;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].y;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].y;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].y;
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.xy = sqrt(u_xlat2.xy);
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].z;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].z;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].z;
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat2.x = u_xlat7.x + u_xlat2.x;
    u_xlat2.x = u_xlat2.x * 0.330000013;
    u_xlat7.xy = u_xlat2.xx * in_TEXCOORD0.xy;
    u_xlat2.xw = u_xlat2.xx * in_TEXCOORD1.xy;
    vs_TEXCOORD0.xy = u_xlat7.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Diffuse1_ST.xy + _Diffuse1_ST.zw;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UVDiffuse2==0.0);
#else
    u_xlatb1 = _UVDiffuse2==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb1)) ? u_xlat7.xy : u_xlat2.xw;
    vs_TEXCOORD2.xy = u_xlat1.xy * _Diffuse2_ST.xy + _Diffuse2_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UVDetail==0.0);
#else
    u_xlatb1 = _UVDetail==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb1)) ? u_xlat7.xy : u_xlat2.xw;
    vs_TEXCOORD2.zw = u_xlat1.xy * _DetailDiffuse_ST.xy + _DetailDiffuse_ST.zw;
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat2.xyz = vec3(u_xlat0) * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_4.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = vec3(u_xlat0) * u_xlat16_4.xyz;
    vs_TEXCOORD3.y = u_xlat16_4.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD3.w = u_xlat5.x;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat5.y;
    vs_TEXCOORD5.w = u_xlat5.z;
    vs_TEXCOORD4.y = u_xlat16_4.y;
    vs_TEXCOORD5.y = u_xlat16_4.z;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump float _HeightSpread;
uniform 	mediump float _HeightContrast;
uniform 	mediump float _UseTintColor;
uniform 	mediump float _UseDiffuseOneHeight;
uniform 	mediump float _UseDiffuseTwoHeight;
uniform 	mediump float _UseDetailDiffuseHeight;
uniform 	mediump float _UseGrassHeightBlend;
uniform 	mediump float _UseGrassSpecular;
uniform 	mediump float _UseSpecularOne;
uniform 	mediump float _UseSpecularTwo;
uniform 	mediump float _UseDetailSpecular;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _SSAO_Intensity;
uniform 	mediump float _Terrain_Smoothness;
uniform 	mediump float _Terrain_Specular;
uniform 	mediump float _Shininess;
uniform 	float _GrassNormalScale;
uniform 	float _Normal0Scale;
uniform 	mediump float _Normal2Scale;
uniform 	mediump float _Diffuse2Distance;
uniform 	mediump float _Diffuse2Fade;
uniform 	mediump float _DetailNormalScale;
uniform 	mediump float _DetailNormalUVScale;
uniform 	mediump float _DetailBlendVal;
uniform 	mediump float _DetailDistance;
uniform 	mediump float _DetailFade;
uniform 	mediump float _DepthBiasScaled;
uniform 	mediump float _DepthBlendAO;
uniform lowp sampler2D _GrassNormal;
uniform lowp sampler2D _GrassDiffuse;
uniform lowp sampler2D _Normal0;
uniform lowp sampler2D _Normal2;
uniform lowp sampler2D _Diffuse1;
uniform lowp sampler2D _DetailNormal;
uniform lowp sampler2D _Diffuse2;
uniform lowp sampler2D _DetailDiffuse;
uniform highp sampler2D _CameraDepthBlendTexture;
uniform lowp sampler2D _CameraDepthBlendNormTexture;
uniform lowp sampler2D _CameraDepthBlendDiffTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_6;
mediump vec4 u_xlat16_7;
lowp vec4 u_xlat10_8;
lowp vec4 u_xlat10_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
mediump vec3 u_xlat16_12;
float u_xlat13;
mediump float u_xlat16_13;
vec2 u_xlat26;
mediump float u_xlat16_26;
mediump vec2 u_xlat16_31;
mediump float u_xlat16_33;
float u_xlat39;
bool u_xlatb39;
mediump float u_xlat16_40;
mediump float u_xlat16_41;
float u_xlat42;
mediump float u_xlat16_44;
mediump float u_xlat16_46;
mediump float u_xlat16_49;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_COLOR0.w<0.99000001);
#else
    u_xlatb0 = vs_COLOR0.w<0.99000001;
#endif
    if(u_xlatb0){
        u_xlat10_0 = texture(_GrassNormal, vs_TEXCOORD0.xy, -1.0);
        u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_1.xy = u_xlat16_1.xy * vec2(_GrassNormalScale);
        u_xlat16_40 = u_xlat10_0.w * _UseGrassSpecular;
        u_xlat10_0.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.xy, -1.0).xyz;
        u_xlat16_2.xyz = u_xlat10_0.xyz;
    } else {
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
        u_xlat16_1.x = float(0.0);
        u_xlat16_1.y = float(0.0);
        u_xlat16_1.z = float(1.0);
        u_xlat16_40 = float(0.0);
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.00999999978<vs_COLOR0.w);
#else
    u_xlatb0 = 0.00999999978<vs_COLOR0.w;
#endif
    if(u_xlatb0){
        u_xlat0.x = vs_TEXCOORD3.w;
        u_xlat0.y = vs_TEXCOORD4.w;
        u_xlat0.z = vs_TEXCOORD5.w;
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat13 = u_xlat0.x / _Diffuse2Distance;
#ifdef UNITY_ADRENO_ES3
        u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
        u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
        u_xlat13 = u_xlat13 + 9.99999975e-05;
        u_xlat13 = log2(u_xlat13);
        u_xlat13 = u_xlat13 * _Diffuse2Fade;
        u_xlat0.y = exp2(u_xlat13);
        u_xlat0.x = u_xlat0.x / _DetailDistance;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = u_xlat0.x + 9.99999975e-05;
        u_xlat0.x = log2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * _DetailFade;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat0.xy = min(u_xlat0.xy, vec2(1.0, 1.0));
        u_xlat10_3.xyz = texture(_Normal0, vs_TEXCOORD0.zw, -1.0).xyw;
        u_xlat10_4.xyz = texture(_Normal2, vs_TEXCOORD2.xy, -1.0).xyw;
        u_xlat16_5.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_31.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_31.xy = u_xlat16_31.xy * vec2(_Normal2Scale);
        u_xlat16_41 = (-u_xlat0.y) + 1.0;
        u_xlat16_31.xy = vec2(u_xlat16_41) * u_xlat16_31.xy;
        u_xlat16_31.xy = u_xlat16_31.xy * vs_COLOR0.xx;
        u_xlat10_6 = texture(_Diffuse1, vs_TEXCOORD0.zw, -1.0);
        u_xlat26.xy = vec2(vs_TEXCOORD2.z * float(_DetailNormalUVScale), vs_TEXCOORD2.w * float(_DetailNormalUVScale));
        u_xlat10_3.xyw = texture(_DetailNormal, u_xlat26.xy, -1.0).xyw;
        u_xlat16_7.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_7.xy = u_xlat16_7.xy * vec2(_DetailNormalScale);
        u_xlat16_41 = (-u_xlat0.x) + 1.0;
        u_xlat16_7.xy = vec2(u_xlat16_41) * u_xlat16_7.xy;
        u_xlat10_8 = texture(_Diffuse2, vs_TEXCOORD2.xy, -1.0);
        u_xlat10_9 = texture(_DetailDiffuse, vs_TEXCOORD2.zw, -1.0);
        u_xlat16_41 = u_xlat10_8.w * _UseDiffuseTwoHeight;
        u_xlat16_33 = u_xlat10_9.w * _UseDetailDiffuseHeight;
        u_xlat16_10.xyz = u_xlat10_6.xyz + (-u_xlat10_8.xyz);
        u_xlat16_46 = u_xlat10_6.w * _UseDiffuseOneHeight + (-u_xlat16_41);
        u_xlat16_10.xyz = u_xlat0.yyy * u_xlat16_10.xyz + u_xlat10_8.xyz;
        u_xlat16_41 = u_xlat0.y * u_xlat16_46 + u_xlat16_41;
        u_xlat16_46 = u_xlat0.x * _DetailBlendVal;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_46 = min(max(u_xlat16_46, 0.0), 1.0);
#else
        u_xlat16_46 = clamp(u_xlat16_46, 0.0, 1.0);
#endif
        u_xlat16_49 = (-u_xlat16_46) + 1.0;
        u_xlat16_33 = u_xlat16_33 * u_xlat16_49;
        u_xlat16_41 = max(u_xlat16_41, u_xlat16_33);
        u_xlat16_11.xyz = u_xlat10_9.xyz * u_xlat16_10.xyz;
        u_xlat16_12.xyz = u_xlat16_11.xyz * vec3(4.0, 4.0, 4.0);
        u_xlat16_10.xyz = (-u_xlat16_11.xyz) * vec3(4.0, 4.0, 4.0) + u_xlat16_10.xyz;
        u_xlat16_10.xyz = vec3(u_xlat16_46) * u_xlat16_10.xyz + u_xlat16_12.xyz;
        u_xlat16_10.xyz = min(u_xlat16_10.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_33 = u_xlat10_4.z * _UseSpecularTwo;
        u_xlat16_46 = u_xlat10_3.w * _UseDetailSpecular;
        u_xlat16_11.x = _UseSpecularOne * u_xlat10_3.z + (-u_xlat16_33);
        u_xlat16_33 = u_xlat0.y * u_xlat16_11.x + u_xlat16_33;
        u_xlat16_46 = u_xlat16_49 * u_xlat16_46;
        u_xlat16_33 = max(u_xlat16_46, u_xlat16_33);
        u_xlat16_5.xy = u_xlat16_5.xy * vec2(_Normal0Scale) + u_xlat16_31.xy;
        u_xlat16_5.xy = u_xlat16_7.xy * vs_COLOR0.xx + u_xlat16_5.xy;
    } else {
        u_xlat16_10.x = float(0.0);
        u_xlat16_10.y = float(0.0);
        u_xlat16_10.z = float(0.0);
        u_xlat16_5.x = float(0.0);
        u_xlat16_5.y = float(0.0);
        u_xlat16_41 = 1.0;
        u_xlat16_33 = 0.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor);
#endif
    u_xlat16_7.xyw = u_xlat16_10.xyz * _TintColor.xyz;
    u_xlat16_7.xyw = (bool(u_xlatb0)) ? u_xlat16_7.xyw : u_xlat16_10.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend);
#endif
    u_xlat16_13 = u_xlat16_41;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_26 = vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_41 = _HeightContrast * 10.0;
    u_xlat16_13 = u_xlat16_13 + -1.0;
    u_xlat16_44 = _HeightSpread + 0.100000001;
    u_xlat16_26 = log2(u_xlat16_26);
    u_xlat16_26 = u_xlat16_26 * u_xlat16_44;
    u_xlat16_26 = exp2(u_xlat16_26);
    u_xlat16_13 = u_xlat16_26 * 2.0 + u_xlat16_13;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_26 = _HeightContrast * 10.0 + 1.0;
    u_xlat16_26 = _HeightContrast * 10.0 + u_xlat16_26;
    u_xlat13 = u_xlat16_13 * u_xlat16_26 + (-u_xlat16_41);
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat16_41 = (u_xlatb0) ? u_xlat13 : vs_COLOR0.w;
    u_xlat16_5.z = 1.0;
    u_xlat16_5.xyz = (-u_xlat16_1.xyz) + u_xlat16_5.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_41) * u_xlat16_5.xyz + u_xlat16_1.xyz;
    u_xlat16_5.x = (-u_xlat16_40) + u_xlat16_33;
    u_xlat16_40 = u_xlat16_41 * u_xlat16_5.x + u_xlat16_40;
    u_xlat16_5.xyz = (-u_xlat16_2.xyz) + u_xlat16_7.xyw;
    u_xlat16_2.xyz = vec3(u_xlat16_41) * u_xlat16_5.xyz + u_xlat16_2.xyz;
    u_xlat16_40 = u_xlat16_40 + _Shininess;
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD5.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!(vs_TEXCOORD1.w<100.0);
#else
    u_xlatb39 = vs_TEXCOORD1.w<100.0;
#endif
    if(u_xlatb39){
        u_xlat3.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
        u_xlat39 = texture(_CameraDepthBlendTexture, u_xlat3.xy).x;
        u_xlat39 = _ZBufferParams.z * u_xlat39 + _ZBufferParams.w;
        u_xlat39 = float(1.0) / u_xlat39;
        u_xlat39 = u_xlat39 + (-vs_TEXCOORD1.w);
        u_xlat39 = abs(u_xlat39) * _DepthBiasScaled;
        u_xlat39 = u_xlat39 * 0.600000024;
#ifdef UNITY_ADRENO_ES3
        u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
        u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
        u_xlat39 = sqrt(u_xlat39);
        u_xlat10_4.xyz = texture(_CameraDepthBlendNormTexture, u_xlat3.xy).xyz;
        u_xlat16_1.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat10_3.xyz = texture(_CameraDepthBlendDiffTexture, u_xlat3.xy).xyz;
        u_xlat16_41 = u_xlat0.y * _DepthBlendAO;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
        u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
        u_xlat42 = (-u_xlat39) + 1.0;
        u_xlat42 = u_xlat16_41 * u_xlat42 + u_xlat39;
        u_xlat42 = max(u_xlat42, 0.899999976);
        u_xlat4.xyz = u_xlat16_2.xyz * vec3(u_xlat42) + (-u_xlat10_3.xyz);
        u_xlat2.xyz = vec3(u_xlat39) * u_xlat4.xyz + u_xlat10_3.xyz;
        u_xlat3.xyz = u_xlat0.xyz + (-u_xlat16_1.xyz);
        u_xlat3.xyz = vec3(u_xlat39) * u_xlat3.xyz + u_xlat16_1.xyz;
        u_xlat16_2.xyz = u_xlat2.xyz;
        u_xlat16_3.xyz = u_xlat3.xyz;
    } else {
        u_xlat16_3.xyz = u_xlat0.xyz;
    //ENDIF
    }
    u_xlat16_1.x = u_xlat16_40 * _Terrain_Smoothness;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    SV_Target2.w = min(u_xlat16_1.x, 0.5);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(vec3(_Terrain_Specular, _Terrain_Specular, _Terrain_Specular));
    u_xlat16_0.x = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_40 = max(u_xlat16_1.z, u_xlat16_1.y);
    u_xlat16_40 = max(u_xlat16_40, u_xlat16_1.x);
    u_xlat16_40 = (-u_xlat16_40) + 1.0;
    SV_Target1.xyz = vec3(u_xlat16_40) * u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_40 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_40 : u_xlat16_1.z;
    SV_Target0.w = 0.0;
    SV_Target1.w = _SSAO_Intensity;
    SV_Target2.xy = u_xlat16_1.xy;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MSAA_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _Diffuse1_ST;
uniform 	float _UVDiffuse2;
uniform 	vec4 _Diffuse2_ST;
uniform 	float _UVDetail;
uniform 	vec4 _DetailDiffuse_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec2 u_xlat12;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat15 = u_xlat15 + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat15 = u_xlat15 + u_xlat2.x;
    u_xlat15 = u_xlat15 * 0.330000013;
    u_xlat2.xy = vec2(u_xlat15) * in_TEXCOORD0.xy;
    u_xlat12.xy = vec2(u_xlat15) * in_TEXCOORD1.xy;
    vs_TEXCOORD0.xy = u_xlat2.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Diffuse1_ST.xy + _Diffuse1_ST.zw;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat15 * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UVDiffuse2==0.0);
#else
    u_xlatb15 = _UVDiffuse2==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat2.xy : u_xlat12.xy;
    vs_TEXCOORD2.xy = u_xlat1.xy * _Diffuse2_ST.xy + _Diffuse2_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UVDetail==0.0);
#else
    u_xlatb15 = _UVDetail==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat2.xy : u_xlat12.xy;
    vs_TEXCOORD2.zw = u_xlat1.xy * _DetailDiffuse_ST.xy + _DetailDiffuse_ST.zw;
    vs_TEXCOORD3.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz;
    vs_TEXCOORD3.y = u_xlat16_4.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat0.y;
    vs_TEXCOORD5.w = u_xlat0.z;
    vs_TEXCOORD4.y = u_xlat16_4.y;
    vs_TEXCOORD5.y = u_xlat16_4.z;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	mediump float _HeightSpread;
uniform 	mediump float _HeightContrast;
uniform 	mediump float _UseTintColor;
uniform 	mediump float _UseDiffuseOneHeight;
uniform 	mediump float _UseDiffuseTwoHeight;
uniform 	mediump float _UseDetailDiffuseHeight;
uniform 	mediump float _UseGrassHeightBlend;
uniform 	mediump float _UseGrassSpecular;
uniform 	mediump float _UseSpecularOne;
uniform 	mediump float _UseSpecularTwo;
uniform 	mediump float _UseDetailSpecular;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _SSAO_Intensity;
uniform 	mediump float _Terrain_Smoothness;
uniform 	mediump float _Terrain_Specular;
uniform 	mediump float _Shininess;
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _GrassDiffuse_TexelSize;
uniform 	vec4 _GrassNormal_TexelSize;
uniform 	vec4 _Diffuse1_ST;
uniform 	vec4 _Diffuse1_TexelSize;
uniform 	vec4 _Normal0_TexelSize;
uniform 	vec4 _Diffuse2_ST;
uniform 	vec4 _Normal2_TexelSize;
uniform 	mediump float _Diffuse2Distance;
uniform 	mediump float _Diffuse2Fade;
uniform 	vec4 _DetailDiffuse_ST;
uniform 	vec4 _DetailDiffuse_TexelSize;
uniform 	vec4 _DetailNormal_TexelSize;
uniform 	mediump float _DetailNormalUVScale;
uniform 	mediump float _DetailBlendVal;
uniform 	mediump float _DetailDistance;
uniform 	mediump float _DetailFade;
uniform 	mediump float _DepthBiasScaled;
uniform 	mediump float _DepthBlendAO;
uniform lowp sampler2D _GrassDiffuse;
uniform lowp sampler2D _GrassNormal;
uniform lowp sampler2D _Normal0;
uniform lowp sampler2D _Normal2;
uniform lowp sampler2D _Diffuse1;
uniform lowp sampler2D _DetailNormal;
uniform lowp sampler2D _Diffuse2;
uniform lowp sampler2D _DetailDiffuse;
uniform highp sampler2D _CameraDepthBlendTexture;
uniform lowp sampler2D _CameraDepthBlendNormTexture;
uniform lowp sampler2D _CameraDepthBlendDiffTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec3 u_xlatb1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
bvec3 u_xlatb2;
vec4 u_xlat3;
lowp vec4 u_xlat10_3;
bvec3 u_xlatb3;
vec4 u_xlat4;
lowp vec4 u_xlat10_4;
bvec3 u_xlatb4;
vec3 u_xlat5;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec4 u_xlat16_11;
mediump vec3 u_xlat16_12;
mediump vec3 u_xlat16_13;
mediump vec3 u_xlat16_14;
float u_xlat15;
mediump float u_xlat16_15;
vec3 u_xlat16;
vec3 u_xlat17;
vec3 u_xlat18;
vec3 u_xlat19;
vec2 u_xlat30;
mediump float u_xlat16_30;
bvec2 u_xlatb30;
float u_xlat31;
float u_xlat32;
vec2 u_xlat33;
bvec2 u_xlatb33;
vec2 u_xlat34;
mediump vec2 u_xlat16_40;
mediump float u_xlat16_41;
float u_xlat45;
bool u_xlatb45;
float u_xlat46;
float u_xlat47;
float u_xlat48;
bool u_xlatb48;
float u_xlat49;
mediump float u_xlat16_53;
mediump float u_xlat16_54;
mediump float u_xlat16_55;
mediump float u_xlat16_56;
mediump float u_xlat16_57;
void main()
{
    u_xlat0.x = vs_TEXCOORD3.w;
    u_xlat0.y = vs_TEXCOORD4.w;
    u_xlat0.z = vs_TEXCOORD5.w;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x / _Diffuse2Distance;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat15 + 9.99999975e-05;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Diffuse2Fade;
    u_xlat0.y = exp2(u_xlat15);
    u_xlat0.x = u_xlat0.x / _DetailDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + 9.99999975e-05;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _DetailFade;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.xy = min(u_xlat0.xy, vec2(1.0, 1.0));
    u_xlat1.zw = vec2(vs_TEXCOORD0.z + (-_Diffuse1_ST.z), vs_TEXCOORD0.w + (-_Diffuse1_ST.w));
    u_xlat30.xy = vec2(_Diffuse1_ST.x * _Diffuse1_TexelSize.z, _Diffuse1_ST.y * _Diffuse1_TexelSize.w);
    u_xlatb30.xy = lessThan(vec4(1.0, 1.0, 1.0, 1.0), u_xlat30.xyxy).xy;
    u_xlatb30.x = u_xlatb30.y || u_xlatb30.x;
    u_xlat1.xy = _Diffuse1_TexelSize.zw;
    u_xlat2 = (u_xlatb30.x) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
    u_xlat3.xy = vec2(_Diffuse1_ST.x * _Normal0_TexelSize.z, _Diffuse1_ST.y * _Normal0_TexelSize.w);
    u_xlatb3.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat3.xyxx).xy;
    u_xlatb45 = u_xlatb3.y || u_xlatb3.x;
    u_xlat1.xy = _Normal0_TexelSize.zw;
    u_xlat1 = (bool(u_xlatb45)) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
    u_xlat3.xy = (bool(u_xlatb45)) ? _Diffuse1_ST.xy : vec2(1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb45 = !!(u_xlat0.y<0.800000012);
#else
    u_xlatb45 = u_xlat0.y<0.800000012;
#endif
    u_xlat4.zw = vec2(vs_TEXCOORD2.x + (-_Diffuse2_ST.z), vs_TEXCOORD2.y + (-_Diffuse2_ST.w));
    u_xlat33.xy = u_xlat1.xy * u_xlat3.xy;
    u_xlat5.xy = vec2(_Diffuse2_ST.x * _Normal2_TexelSize.z, _Diffuse2_ST.y * _Normal2_TexelSize.w);
    u_xlatb33.xy = lessThan(u_xlat33.xyxy, u_xlat5.xyxy).xy;
    u_xlatb33.x = u_xlatb33.y || u_xlatb33.x;
    u_xlat4.xy = _Normal2_TexelSize.zw;
    u_xlat4 = (u_xlatb33.x) ? u_xlat4 : u_xlat1;
    u_xlat1 = (bool(u_xlatb45)) ? u_xlat4 : u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb48 = !!(u_xlat0.x<0.800000012);
#else
    u_xlatb48 = u_xlat0.x<0.800000012;
#endif
    if(u_xlatb48){
        u_xlat4.xy = (u_xlatb30.x) ? _Diffuse1_ST.xy : vec2(1.0, 1.0);
        u_xlat33.xy = (u_xlatb33.x) ? _Diffuse2_ST.xy : u_xlat3.xy;
        u_xlat30.xy = (bool(u_xlatb45)) ? u_xlat33.xy : u_xlat3.xy;
        u_xlat3.zw = vec2(vs_TEXCOORD2.z + (-_DetailDiffuse_ST.z), vs_TEXCOORD2.w + (-_DetailDiffuse_ST.w));
        u_xlat4.xy = u_xlat2.xy * u_xlat4.xy;
        u_xlat34.xy = vec2(_DetailDiffuse_ST.x * _DetailDiffuse_TexelSize.z, _DetailDiffuse_ST.y * _DetailDiffuse_TexelSize.w);
        u_xlatb4.xy = lessThan(u_xlat4.xyxx, u_xlat34.xyxx).xy;
        u_xlatb4.x = u_xlatb4.y || u_xlatb4.x;
        u_xlat3.xy = _DetailDiffuse_TexelSize.zw;
        u_xlat2 = (u_xlatb4.x) ? u_xlat3 : u_xlat2;
        u_xlat30.xy = u_xlat30.xy * u_xlat1.xy;
        u_xlat4.xy = vec2(_DetailDiffuse_ST.x * _DetailNormal_TexelSize.z, _DetailDiffuse_ST.y * _DetailNormal_TexelSize.w);
        u_xlatb30.xy = lessThan(u_xlat30.xyxy, u_xlat4.xyxy).xy;
        u_xlatb30.x = u_xlatb30.y || u_xlatb30.x;
        u_xlat3.xy = _DetailNormal_TexelSize.zw;
        u_xlat1 = (u_xlatb30.x) ? u_xlat3 : u_xlat1;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30.x = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb30.x = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb30.x){
        u_xlatb3.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat4 = (u_xlatb3.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat4 = (u_xlatb3.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat4;
        u_xlat3 = (u_xlatb3.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat4;
        SV_Target0 = u_xlat3;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30.x = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb30.x = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb30.x){
        u_xlat10_3.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.xy).xyz;
        SV_Target0.xyz = u_xlat10_3.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30.x = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb30.x = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb30.x){
        u_xlat30.x = max(_GrassDiffuse_TexelSize.w, _GrassDiffuse_TexelSize.z);
        u_xlat30.x = max(u_xlat30.x, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb45 = !!(256.0<u_xlat30.x);
#else
        u_xlatb45 = 256.0<u_xlat30.x;
#endif
        u_xlatb3.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), u_xlat30.xxxx).xy;
        u_xlat4 = (u_xlatb3.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat3 = (u_xlatb3.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat4;
        u_xlat3 = (bool(u_xlatb45)) ? u_xlat3 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat3;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30.x = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb30.x = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb30.x){
        u_xlat30.xy = vec2(vs_TEXCOORD0.x * _GrassDiffuse_TexelSize.z, vs_TEXCOORD0.y * _GrassDiffuse_TexelSize.w);
        u_xlat3.xy = dFdx(u_xlat30.xy);
        u_xlat30.xy = dFdy(u_xlat30.xy);
        u_xlat3.x = dot(u_xlat3.xy, u_xlat3.xy);
        u_xlat30.x = dot(u_xlat30.xy, u_xlat30.xy);
        u_xlat30.x = max(u_xlat30.x, u_xlat3.x);
        u_xlat30.x = log2(u_xlat30.x);
        u_xlat30.x = u_xlat30.x * 0.5;
        u_xlat30.x = max(u_xlat30.x, 0.0);
        u_xlat30.x = u_xlat30.x + 1.0;
        u_xlat45 = max(_GrassDiffuse_TexelSize.w, _GrassDiffuse_TexelSize.z);
        u_xlat30.x = u_xlat45 / u_xlat30.x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb45 = !!(256.0<u_xlat30.x);
#else
        u_xlatb45 = 256.0<u_xlat30.x;
#endif
        u_xlatb3.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), u_xlat30.xxxx).xy;
        u_xlat4 = (u_xlatb3.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat3 = (u_xlatb3.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat4;
        u_xlat3 = (bool(u_xlatb45)) ? u_xlat3 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat3;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30.x = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb30.x = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb30.x){
        u_xlat3.zw = vec2(vs_TEXCOORD0.x + (-_GrassDiffuse_ST.z), vs_TEXCOORD0.y + (-_GrassDiffuse_ST.w));
        u_xlat30.xy = vec2(_GrassDiffuse_ST.x * _GrassDiffuse_TexelSize.z, _GrassDiffuse_ST.y * _GrassDiffuse_TexelSize.w);
        u_xlatb30.xy = lessThan(vec4(1.0, 1.0, 1.0, 1.0), u_xlat30.xyxy).xy;
        u_xlatb30.x = u_xlatb30.y || u_xlatb30.x;
        u_xlat3.xy = _GrassDiffuse_TexelSize.zw;
        u_xlat4 = (u_xlatb30.x) ? u_xlat3 : vec4(1.0, 1.0, 0.0, 0.0);
        u_xlat2 = u_xlat2 + (-u_xlat4);
        u_xlat2 = vs_COLOR0.wwww * u_xlat2 + u_xlat4;
#ifdef UNITY_ADRENO_ES3
        u_xlatb30.x = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb30.x = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb30.x){
            u_xlat30.xy = vec2(u_xlat2.x * u_xlat2.z, u_xlat2.y * u_xlat2.w);
            u_xlat4.xy = dFdx(u_xlat30.xy);
            u_xlat30.xy = dFdy(u_xlat30.xy);
            u_xlat34.x = dot(u_xlat4.xy, u_xlat4.xy);
            u_xlat49 = dot(u_xlat30.xy, u_xlat30.xy);
            u_xlat34.x = max(u_xlat49, u_xlat34.x);
            u_xlat34.x = log2(u_xlat34.x);
            u_xlat34.x = u_xlat34.x * 0.5;
            u_xlat34.x = max(u_xlat34.x, 0.0);
            u_xlat34.x = u_xlat34.x + 1.0;
            u_xlat49 = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat4.xy = vec2(u_xlat49) * u_xlat4.xy;
            u_xlat30.xy = u_xlat30.xy * vec2(u_xlat49);
            u_xlat4.xy = u_xlat4.xy / u_xlat34.xx;
            u_xlat30.xy = u_xlat30.xy / u_xlat34.xx;
            u_xlat19.x = dot(abs(u_xlat4.xy), abs(u_xlat4.xy));
            u_xlat45 = dot(abs(u_xlat30.xy), abs(u_xlat30.xy));
            u_xlat34.x = sqrt(u_xlat19.x);
            u_xlat49 = sqrt(u_xlat45);
            u_xlat19.x = inversesqrt(u_xlat19.x);
            u_xlat4.x = u_xlat19.x * abs(u_xlat4.x);
            u_xlat45 = inversesqrt(u_xlat45);
            u_xlat30.x = u_xlat45 * abs(u_xlat30.x);
            u_xlat30.x = u_xlat30.x * u_xlat4.x;
            u_xlat30.x = (-u_xlat30.x) * u_xlat30.x + 1.0;
            u_xlat30.x = sqrt(u_xlat30.x);
            u_xlat45 = u_xlat49 * u_xlat34.x;
            u_xlat4.x = u_xlat30.x * u_xlat45;
            u_xlat19.xy = vec2(u_xlat2.z * float(3.0), u_xlat2.w * float(3.0));
            u_xlat49 = fract((-u_xlat19.x));
            u_xlat19.z = u_xlat49 + 0.5;
            u_xlat19.xy = fract(u_xlat19.xy);
            u_xlat19.xy = u_xlat19.xy + vec2(0.5, 0.5);
            u_xlat19.xyz = floor(u_xlat19.xyz);
            u_xlat49 = (-u_xlat19.x) + u_xlat19.z;
            u_xlat19.x = u_xlat49 * u_xlat19.y + u_xlat19.x;
            u_xlat34.x = (-u_xlat45) * u_xlat30.x + 1.0;
            u_xlat5.xyz = (-u_xlat19.xxx) + vec3(0.5, 0.0, 1.0);
            u_xlat6.xyz = u_xlat34.xxx * u_xlat5.xyz + u_xlat19.xxx;
            u_xlatb4.xz = lessThan(u_xlat4.xxxx, vec4(1.0, 0.0, 2.0, 0.0)).xz;
            u_xlat7.xyz = u_xlat19.xxx * vec3(0.0, 1.0, 0.0);
            u_xlat30.x = u_xlat45 * u_xlat30.x + -4.0;
            u_xlat30.x = exp2(u_xlat30.x);
            u_xlat30.x = u_xlat30.x + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat30.x = min(max(u_xlat30.x, 0.0), 1.0);
#else
            u_xlat30.x = clamp(u_xlat30.x, 0.0, 1.0);
#endif
            u_xlat5.xyz = u_xlat30.xxx * u_xlat5.zyy + u_xlat19.xxx;
            u_xlat19.xyz = (u_xlatb4.z) ? u_xlat7.xyz : u_xlat5.xyz;
            u_xlat4.xyz = (u_xlatb4.x) ? u_xlat6.xyz : u_xlat19.xyz;
        } else {
            u_xlat30.xy = vec2(_GrassDiffuse_ST.x * _GrassNormal_TexelSize.z, _GrassDiffuse_ST.y * _GrassNormal_TexelSize.w);
            u_xlatb30.xy = lessThan(vec4(1.0, 1.0, 1.0, 1.0), u_xlat30.xyxy).xy;
            u_xlatb30.x = u_xlatb30.y || u_xlatb30.x;
            u_xlat3.xy = _GrassNormal_TexelSize.zw;
            u_xlat3 = (u_xlatb30.x) ? u_xlat3 : vec4(1.0, 1.0, 0.0, 0.0);
            u_xlat1 = u_xlat1 + (-u_xlat3);
            u_xlat1 = vs_COLOR0.wwww * u_xlat1 + u_xlat3;
#ifdef UNITY_ADRENO_ES3
            u_xlatb30.x = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb30.x = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb30.x){
                u_xlat30.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                u_xlat3.xy = dFdx(u_xlat30.xy);
                u_xlat30.xy = dFdy(u_xlat30.xy);
                u_xlat33.x = dot(u_xlat3.xy, u_xlat3.xy);
                u_xlat48 = dot(u_xlat30.xy, u_xlat30.xy);
                u_xlat33.x = max(u_xlat48, u_xlat33.x);
                u_xlat33.x = log2(u_xlat33.x);
                u_xlat33.x = u_xlat33.x * 0.5;
                u_xlat33.x = max(u_xlat33.x, 0.0);
                u_xlat33.x = u_xlat33.x + 1.0;
                u_xlat48 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                u_xlat3.xy = vec2(u_xlat48) * u_xlat3.xy;
                u_xlat30.xy = u_xlat30.xy * vec2(u_xlat48);
                u_xlat3.xy = u_xlat3.xy / u_xlat33.xx;
                u_xlat30.xy = u_xlat30.xy / u_xlat33.xx;
                u_xlat18.x = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                u_xlat45 = dot(abs(u_xlat30.xy), abs(u_xlat30.xy));
                u_xlat33.x = sqrt(u_xlat18.x);
                u_xlat48 = sqrt(u_xlat45);
                u_xlat18.x = inversesqrt(u_xlat18.x);
                u_xlat3.x = u_xlat18.x * abs(u_xlat3.x);
                u_xlat45 = inversesqrt(u_xlat45);
                u_xlat30.x = u_xlat45 * abs(u_xlat30.x);
                u_xlat30.x = u_xlat30.x * u_xlat3.x;
                u_xlat30.x = (-u_xlat30.x) * u_xlat30.x + 1.0;
                u_xlat30.x = sqrt(u_xlat30.x);
                u_xlat45 = u_xlat48 * u_xlat33.x;
                u_xlat3.x = u_xlat30.x * u_xlat45;
                u_xlat18.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                u_xlat48 = fract((-u_xlat18.x));
                u_xlat18.z = u_xlat48 + 0.5;
                u_xlat18.xy = fract(u_xlat18.xy);
                u_xlat18.xy = u_xlat18.xy + vec2(0.5, 0.5);
                u_xlat18.xyz = floor(u_xlat18.xyz);
                u_xlat48 = (-u_xlat18.x) + u_xlat18.z;
                u_xlat18.x = u_xlat48 * u_xlat18.y + u_xlat18.x;
                u_xlat33.x = (-u_xlat45) * u_xlat30.x + 1.0;
                u_xlat5.xyz = (-u_xlat18.xxx) + vec3(0.5, 0.0, 1.0);
                u_xlat6.xyz = u_xlat33.xxx * u_xlat5.xyz + u_xlat18.xxx;
                u_xlatb3.xz = lessThan(u_xlat3.xxxx, vec4(1.0, 0.0, 2.0, 0.0)).xz;
                u_xlat7.xyz = u_xlat18.xxx * vec3(0.0, 1.0, 0.0);
                u_xlat30.x = u_xlat45 * u_xlat30.x + -4.0;
                u_xlat30.x = exp2(u_xlat30.x);
                u_xlat30.x = u_xlat30.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                u_xlat30.x = min(max(u_xlat30.x, 0.0), 1.0);
#else
                u_xlat30.x = clamp(u_xlat30.x, 0.0, 1.0);
#endif
                u_xlat5.xyz = u_xlat30.xxx * u_xlat5.zyy + u_xlat18.xxx;
                u_xlat18.xyz = (u_xlatb3.z) ? u_xlat7.xyz : u_xlat5.xyz;
                u_xlat4.xyz = (u_xlatb3.x) ? u_xlat6.xyz : u_xlat18.xyz;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb30.x = !!(u_xlat2.x>=u_xlat1.x);
#else
                u_xlatb30.x = u_xlat2.x>=u_xlat1.x;
#endif
                if(u_xlatb30.x){
                    u_xlat30.xy = vec2(u_xlat2.x * u_xlat2.z, u_xlat2.y * u_xlat2.w);
                    u_xlat2.xy = dFdx(u_xlat30.xy);
                    u_xlat30.xy = dFdy(u_xlat30.xy);
                    u_xlat3.x = dot(u_xlat2.xy, u_xlat2.xy);
                    u_xlat18.x = dot(u_xlat30.xy, u_xlat30.xy);
                    u_xlat3.x = max(u_xlat18.x, u_xlat3.x);
                    u_xlat3.x = log2(u_xlat3.x);
                    u_xlat3.x = u_xlat3.x * 0.5;
                    u_xlat3.x = max(u_xlat3.x, 0.0);
                    u_xlat3.x = u_xlat3.x + 1.0;
                    u_xlat18.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat2.xy = u_xlat2.xy * u_xlat18.xx;
                    u_xlat30.xy = u_xlat30.xy * u_xlat18.xx;
                    u_xlat2.xy = u_xlat2.xy / u_xlat3.xx;
                    u_xlat30.xy = u_xlat30.xy / u_xlat3.xx;
                    u_xlat17.x = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
                    u_xlat45 = dot(abs(u_xlat30.xy), abs(u_xlat30.xy));
                    u_xlat3.x = sqrt(u_xlat17.x);
                    u_xlat18.x = sqrt(u_xlat45);
                    u_xlat17.x = inversesqrt(u_xlat17.x);
                    u_xlat2.x = u_xlat17.x * abs(u_xlat2.x);
                    u_xlat45 = inversesqrt(u_xlat45);
                    u_xlat30.x = u_xlat45 * abs(u_xlat30.x);
                    u_xlat30.x = u_xlat30.x * u_xlat2.x;
                    u_xlat30.x = (-u_xlat30.x) * u_xlat30.x + 1.0;
                    u_xlat30.x = sqrt(u_xlat30.x);
                    u_xlat45 = u_xlat18.x * u_xlat3.x;
                    u_xlat2.x = u_xlat30.x * u_xlat45;
                    u_xlat17.xy = vec2(u_xlat2.z * float(3.0), u_xlat2.w * float(3.0));
                    u_xlat47 = fract((-u_xlat17.x));
                    u_xlat17.z = u_xlat47 + 0.5;
                    u_xlat17.xy = fract(u_xlat17.xy);
                    u_xlat17.xy = u_xlat17.xy + vec2(0.5, 0.5);
                    u_xlat17.xyz = floor(u_xlat17.xyz);
                    u_xlat47 = (-u_xlat17.x) + u_xlat17.z;
                    u_xlat17.x = u_xlat47 * u_xlat17.y + u_xlat17.x;
                    u_xlat32 = (-u_xlat45) * u_xlat30.x + 1.0;
                    u_xlat3.xyz = (-u_xlat17.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat5.xyz = vec3(u_xlat32) * u_xlat3.xyz + u_xlat17.xxx;
                    u_xlatb2.xz = lessThan(u_xlat2.xxxx, vec4(1.0, 0.0, 2.0, 0.0)).xz;
                    u_xlat6.xyz = u_xlat17.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat30.x = u_xlat45 * u_xlat30.x + -4.0;
                    u_xlat30.x = exp2(u_xlat30.x);
                    u_xlat30.x = u_xlat30.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat30.x = min(max(u_xlat30.x, 0.0), 1.0);
#else
                    u_xlat30.x = clamp(u_xlat30.x, 0.0, 1.0);
#endif
                    u_xlat3.xyz = u_xlat30.xxx * u_xlat3.zyy + u_xlat17.xxx;
                    u_xlat17.xyz = (u_xlatb2.z) ? u_xlat6.xyz : u_xlat3.xyz;
                    u_xlat4.xyz = (u_xlatb2.x) ? u_xlat5.xyz : u_xlat17.xyz;
                } else {
                    u_xlat30.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat1.xy = dFdx(u_xlat30.xy);
                    u_xlat30.xy = dFdy(u_xlat30.xy);
                    u_xlat2.x = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat17.x = dot(u_xlat30.xy, u_xlat30.xy);
                    u_xlat2.x = max(u_xlat17.x, u_xlat2.x);
                    u_xlat2.x = log2(u_xlat2.x);
                    u_xlat2.x = u_xlat2.x * 0.5;
                    u_xlat2.x = max(u_xlat2.x, 0.0);
                    u_xlat2.x = u_xlat2.x + 1.0;
                    u_xlat17.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat1.xy = u_xlat1.xy * u_xlat17.xx;
                    u_xlat30.xy = u_xlat30.xy * u_xlat17.xx;
                    u_xlat1.xy = u_xlat1.xy / u_xlat2.xx;
                    u_xlat30.xy = u_xlat30.xy / u_xlat2.xx;
                    u_xlat16.x = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat45 = dot(abs(u_xlat30.xy), abs(u_xlat30.xy));
                    u_xlat2.x = sqrt(u_xlat16.x);
                    u_xlat17.x = sqrt(u_xlat45);
                    u_xlat16.x = inversesqrt(u_xlat16.x);
                    u_xlat1.x = u_xlat16.x * abs(u_xlat1.x);
                    u_xlat45 = inversesqrt(u_xlat45);
                    u_xlat30.x = u_xlat45 * abs(u_xlat30.x);
                    u_xlat30.x = u_xlat30.x * u_xlat1.x;
                    u_xlat30.x = (-u_xlat30.x) * u_xlat30.x + 1.0;
                    u_xlat30.x = sqrt(u_xlat30.x);
                    u_xlat45 = u_xlat17.x * u_xlat2.x;
                    u_xlat1.x = u_xlat30.x * u_xlat45;
                    u_xlat16.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat46 = fract((-u_xlat16.x));
                    u_xlat16.z = u_xlat46 + 0.5;
                    u_xlat16.xy = fract(u_xlat16.xy);
                    u_xlat16.xy = u_xlat16.xy + vec2(0.5, 0.5);
                    u_xlat16.xyz = floor(u_xlat16.xyz);
                    u_xlat46 = (-u_xlat16.x) + u_xlat16.z;
                    u_xlat16.x = u_xlat46 * u_xlat16.y + u_xlat16.x;
                    u_xlat31 = (-u_xlat45) * u_xlat30.x + 1.0;
                    u_xlat2.xyz = (-u_xlat16.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat3.xyz = vec3(u_xlat31) * u_xlat2.xyz + u_xlat16.xxx;
                    u_xlatb1.xz = lessThan(u_xlat1.xxxx, vec4(1.0, 0.0, 2.0, 0.0)).xz;
                    u_xlat5.xyz = u_xlat16.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat30.x = u_xlat45 * u_xlat30.x + -4.0;
                    u_xlat30.x = exp2(u_xlat30.x);
                    u_xlat30.x = u_xlat30.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat30.x = min(max(u_xlat30.x, 0.0), 1.0);
#else
                    u_xlat30.x = clamp(u_xlat30.x, 0.0, 1.0);
#endif
                    u_xlat2.xyz = u_xlat30.xxx * u_xlat2.zyy + u_xlat16.xxx;
                    u_xlat16.xyz = (u_xlatb1.z) ? u_xlat5.xyz : u_xlat2.xyz;
                    u_xlat4.xyz = (u_xlatb1.x) ? u_xlat3.xyz : u_xlat16.xyz;
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat4.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb30.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 100.0, 102.0)).xy;
    u_xlatb30.x = u_xlatb30.y || u_xlatb30.x;
    if(u_xlatb30.x){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb30.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 101.0, 103.0)).xy;
    u_xlatb30.x = u_xlatb30.y || u_xlatb30.x;
    if(u_xlatb30.x){
        SV_Target0 = vec4(0.400000006, 0.400000006, 0.400000006, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30.x = !!(vs_COLOR0.w<0.99000001);
#else
    u_xlatb30.x = vs_COLOR0.w<0.99000001;
#endif
    if(u_xlatb30.x){
        u_xlat10_1 = texture(_GrassNormal, vs_TEXCOORD0.xy, -1.0);
        u_xlat16_8.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_53 = u_xlat10_1.w * _UseGrassSpecular;
        u_xlat10_1.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.xy, -1.0).xyz;
        u_xlat16_9.xyz = u_xlat10_1.xyz;
    } else {
        u_xlat16_9.x = float(0.0);
        u_xlat16_9.y = float(0.0);
        u_xlat16_9.z = float(0.0);
        u_xlat16_8.x = float(0.0);
        u_xlat16_8.y = float(0.0);
        u_xlat16_8.z = float(1.0);
        u_xlat16_53 = float(0.0);
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30.x = !!(0.00999999978<vs_COLOR0.w);
#else
    u_xlatb30.x = 0.00999999978<vs_COLOR0.w;
#endif
    if(u_xlatb30.x){
        u_xlat10_1.xyz = texture(_Normal0, vs_TEXCOORD0.zw, -1.0).xyw;
        u_xlat10_2.xyz = texture(_Normal2, vs_TEXCOORD2.xy, -1.0).xyw;
        u_xlat16_10.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_40.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_54 = (-u_xlat0.y) + 1.0;
        u_xlat16_40.xy = vec2(u_xlat16_54) * u_xlat16_40.xy;
        u_xlat10_3 = texture(_Diffuse1, vs_TEXCOORD0.zw, -1.0);
        u_xlat30.xy = vec2(vs_TEXCOORD2.z * float(_DetailNormalUVScale), vs_TEXCOORD2.w * float(_DetailNormalUVScale));
        u_xlat10_1.xyw = texture(_DetailNormal, u_xlat30.xy, -1.0).xyw;
        u_xlat16_11.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_54 = (-u_xlat0.x) + 1.0;
        u_xlat16_11.xy = vec2(u_xlat16_54) * u_xlat16_11.xy;
        u_xlat10_4 = texture(_Diffuse2, vs_TEXCOORD2.xy, -1.0);
        u_xlat10_5 = texture(_DetailDiffuse, vs_TEXCOORD2.zw, -1.0);
        u_xlat16_54 = u_xlat10_4.w * _UseDiffuseTwoHeight;
        u_xlat16_41 = u_xlat10_5.w * _UseDetailDiffuseHeight;
        u_xlat16_12.xyz = u_xlat10_3.xyz + (-u_xlat10_4.xyz);
        u_xlat16_56 = u_xlat10_3.w * _UseDiffuseOneHeight + (-u_xlat16_54);
        u_xlat16_12.xyz = u_xlat0.yyy * u_xlat16_12.xyz + u_xlat10_4.xyz;
        u_xlat16_54 = u_xlat0.y * u_xlat16_56 + u_xlat16_54;
        u_xlat16_56 = u_xlat0.x * _DetailBlendVal;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_56 = min(max(u_xlat16_56, 0.0), 1.0);
#else
        u_xlat16_56 = clamp(u_xlat16_56, 0.0, 1.0);
#endif
        u_xlat16_57 = (-u_xlat16_56) + 1.0;
        u_xlat16_41 = u_xlat16_41 * u_xlat16_57;
        u_xlat16_54 = max(u_xlat16_54, u_xlat16_41);
        u_xlat16_13.xyz = u_xlat10_5.xyz * u_xlat16_12.xyz;
        u_xlat16_14.xyz = u_xlat16_13.xyz * vec3(4.0, 4.0, 4.0);
        u_xlat16_12.xyz = (-u_xlat16_13.xyz) * vec3(4.0, 4.0, 4.0) + u_xlat16_12.xyz;
        u_xlat16_12.xyz = vec3(u_xlat16_56) * u_xlat16_12.xyz + u_xlat16_14.xyz;
        u_xlat16_12.xyz = min(u_xlat16_12.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_41 = u_xlat10_2.z * _UseSpecularTwo;
        u_xlat16_56 = u_xlat10_1.w * _UseDetailSpecular;
        u_xlat16_13.x = _UseSpecularOne * u_xlat10_1.z + (-u_xlat16_41);
        u_xlat16_41 = u_xlat0.y * u_xlat16_13.x + u_xlat16_41;
        u_xlat16_56 = u_xlat16_57 * u_xlat16_56;
        u_xlat16_41 = max(u_xlat16_56, u_xlat16_41);
        u_xlat16_10.xy = u_xlat16_40.xy * vs_COLOR0.xx + u_xlat16_10.xy;
        u_xlat16_10.xy = u_xlat16_11.xy * vs_COLOR0.xx + u_xlat16_10.xy;
    } else {
        u_xlat16_12.x = float(0.0);
        u_xlat16_12.y = float(0.0);
        u_xlat16_12.z = float(0.0);
        u_xlat16_10.x = float(0.0);
        u_xlat16_10.y = float(0.0);
        u_xlat16_54 = 1.0;
        u_xlat16_41 = 0.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor);
#endif
    u_xlat16_11.xyw = u_xlat16_12.xyz * _TintColor.xyz;
    u_xlat16_11.xyw = (bool(u_xlatb0)) ? u_xlat16_11.xyw : u_xlat16_12.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend);
#endif
    u_xlat16_15 = u_xlat16_54;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_30 = vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_54 = _HeightContrast * 10.0;
    u_xlat16_15 = u_xlat16_15 + -1.0;
    u_xlat16_55 = _HeightSpread + 0.100000001;
    u_xlat16_30 = log2(u_xlat16_30);
    u_xlat16_30 = u_xlat16_30 * u_xlat16_55;
    u_xlat16_30 = exp2(u_xlat16_30);
    u_xlat16_15 = u_xlat16_30 * 2.0 + u_xlat16_15;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_30 = _HeightContrast * 10.0 + 1.0;
    u_xlat16_30 = _HeightContrast * 10.0 + u_xlat16_30;
    u_xlat15 = u_xlat16_15 * u_xlat16_30 + (-u_xlat16_54);
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_54 = (u_xlatb0) ? u_xlat15 : vs_COLOR0.w;
    u_xlat16_10.z = 1.0;
    u_xlat16_10.xyz = (-u_xlat16_8.xyz) + u_xlat16_10.xyz;
    u_xlat16_8.xyz = vec3(u_xlat16_54) * u_xlat16_10.xyz + u_xlat16_8.xyz;
    u_xlat16_10.x = (-u_xlat16_53) + u_xlat16_41;
    u_xlat16_53 = u_xlat16_54 * u_xlat16_10.x + u_xlat16_53;
    u_xlat16_10.xyz = (-u_xlat16_9.xyz) + u_xlat16_11.xyw;
    u_xlat16_9.xyz = vec3(u_xlat16_54) * u_xlat16_10.xyz + u_xlat16_9.xyz;
    u_xlat16_53 = u_xlat16_53 + _Shininess;
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, u_xlat16_8.xyz);
    u_xlat0.y = dot(vs_TEXCOORD4.xyz, u_xlat16_8.xyz);
    u_xlat0.z = dot(vs_TEXCOORD5.xyz, u_xlat16_8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb45 = !!(vs_TEXCOORD1.w<100.0);
#else
    u_xlatb45 = vs_TEXCOORD1.w<100.0;
#endif
    if(u_xlatb45){
        u_xlat1.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
        u_xlat45 = texture(_CameraDepthBlendTexture, u_xlat1.xy).x;
        u_xlat45 = _ZBufferParams.z * u_xlat45 + _ZBufferParams.w;
        u_xlat45 = float(1.0) / u_xlat45;
        u_xlat45 = u_xlat45 + (-vs_TEXCOORD1.w);
        u_xlat45 = abs(u_xlat45) * _DepthBiasScaled;
        u_xlat45 = u_xlat45 * 0.600000024;
#ifdef UNITY_ADRENO_ES3
        u_xlat45 = min(max(u_xlat45, 0.0), 1.0);
#else
        u_xlat45 = clamp(u_xlat45, 0.0, 1.0);
#endif
        u_xlat45 = sqrt(u_xlat45);
        u_xlat10_2.xyz = texture(_CameraDepthBlendNormTexture, u_xlat1.xy).xyz;
        u_xlat16_8.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat10_1.xyz = texture(_CameraDepthBlendDiffTexture, u_xlat1.xy).xyz;
        u_xlat16_54 = u_xlat0.y * _DepthBlendAO;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_54 = min(max(u_xlat16_54, 0.0), 1.0);
#else
        u_xlat16_54 = clamp(u_xlat16_54, 0.0, 1.0);
#endif
        u_xlat46 = (-u_xlat45) + 1.0;
        u_xlat46 = u_xlat16_54 * u_xlat46 + u_xlat45;
        u_xlat46 = max(u_xlat46, 0.899999976);
        u_xlat2.xyz = u_xlat16_9.xyz * vec3(u_xlat46) + (-u_xlat10_1.xyz);
        u_xlat9.xyz = vec3(u_xlat45) * u_xlat2.xyz + u_xlat10_1.xyz;
        u_xlat1.xyz = u_xlat0.xyz + (-u_xlat16_8.xyz);
        u_xlat1.xyz = vec3(u_xlat45) * u_xlat1.xyz + u_xlat16_8.xyz;
        u_xlat16_9.xyz = u_xlat9.xyz;
        u_xlat16_1.xyz = u_xlat1.xyz;
    } else {
        u_xlat16_1.xyz = u_xlat0.xyz;
    //ENDIF
    }
    u_xlat16_8.x = u_xlat16_53 * _Terrain_Smoothness;
    u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
    SV_Target2.w = min(u_xlat16_8.x, 0.5);
    u_xlat16_8.xyz = u_xlat16_9.xyz * vec3(vec3(_Terrain_Specular, _Terrain_Specular, _Terrain_Specular));
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat16_53 = max(u_xlat16_8.z, u_xlat16_8.y);
    u_xlat16_53 = max(u_xlat16_53, u_xlat16_8.x);
    u_xlat16_53 = (-u_xlat16_53) + 1.0;
    SV_Target1.xyz = vec3(u_xlat16_53) * u_xlat16_9.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_53 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_53 : u_xlat16_8.z;
    SV_Target0.w = 0.0;
    SV_Target1.w = _SSAO_Intensity;
    SV_Target2.xy = u_xlat16_8.xy;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MSAA_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _Diffuse1_ST;
uniform 	float _UVDiffuse2;
uniform 	vec4 _Diffuse2_ST;
uniform 	float _UVDetail;
uniform 	vec4 _DetailDiffuse_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat7;
float u_xlat16;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x;
    u_xlat2.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].x;
    u_xlat2.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].x;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].y;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].y;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].y;
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.xy = sqrt(u_xlat2.xy);
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].z;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].z;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].z;
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat2.x = u_xlat7.x + u_xlat2.x;
    u_xlat2.x = u_xlat2.x * 0.330000013;
    u_xlat7.xy = u_xlat2.xx * in_TEXCOORD0.xy;
    u_xlat2.xw = u_xlat2.xx * in_TEXCOORD1.xy;
    vs_TEXCOORD0.xy = u_xlat7.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Diffuse1_ST.xy + _Diffuse1_ST.zw;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UVDiffuse2==0.0);
#else
    u_xlatb1 = _UVDiffuse2==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb1)) ? u_xlat7.xy : u_xlat2.xw;
    vs_TEXCOORD2.xy = u_xlat1.xy * _Diffuse2_ST.xy + _Diffuse2_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UVDetail==0.0);
#else
    u_xlatb1 = _UVDetail==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb1)) ? u_xlat7.xy : u_xlat2.xw;
    vs_TEXCOORD2.zw = u_xlat1.xy * _DetailDiffuse_ST.xy + _DetailDiffuse_ST.zw;
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat2.xyz = vec3(u_xlat0) * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_4.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = vec3(u_xlat0) * u_xlat16_4.xyz;
    vs_TEXCOORD3.y = u_xlat16_4.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD3.w = u_xlat5.x;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat5.y;
    vs_TEXCOORD5.w = u_xlat5.z;
    vs_TEXCOORD4.y = u_xlat16_4.y;
    vs_TEXCOORD5.y = u_xlat16_4.z;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	mediump float _HeightSpread;
uniform 	mediump float _HeightContrast;
uniform 	mediump float _UseTintColor;
uniform 	mediump float _UseDiffuseOneHeight;
uniform 	mediump float _UseDiffuseTwoHeight;
uniform 	mediump float _UseDetailDiffuseHeight;
uniform 	mediump float _UseGrassHeightBlend;
uniform 	mediump float _UseGrassSpecular;
uniform 	mediump float _UseSpecularOne;
uniform 	mediump float _UseSpecularTwo;
uniform 	mediump float _UseDetailSpecular;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _SSAO_Intensity;
uniform 	mediump float _Terrain_Smoothness;
uniform 	mediump float _Terrain_Specular;
uniform 	mediump float _Shininess;
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _GrassDiffuse_TexelSize;
uniform 	vec4 _GrassNormal_TexelSize;
uniform 	float _GrassNormalScale;
uniform 	vec4 _Diffuse1_ST;
uniform 	vec4 _Diffuse1_TexelSize;
uniform 	vec4 _Normal0_TexelSize;
uniform 	float _Normal0Scale;
uniform 	vec4 _Diffuse2_ST;
uniform 	vec4 _Normal2_TexelSize;
uniform 	mediump float _Normal2Scale;
uniform 	mediump float _Diffuse2Distance;
uniform 	mediump float _Diffuse2Fade;
uniform 	vec4 _DetailDiffuse_ST;
uniform 	vec4 _DetailDiffuse_TexelSize;
uniform 	vec4 _DetailNormal_TexelSize;
uniform 	mediump float _DetailNormalScale;
uniform 	mediump float _DetailNormalUVScale;
uniform 	mediump float _DetailBlendVal;
uniform 	mediump float _DetailDistance;
uniform 	mediump float _DetailFade;
uniform 	mediump float _DepthBiasScaled;
uniform 	mediump float _DepthBlendAO;
uniform lowp sampler2D _GrassDiffuse;
uniform lowp sampler2D _GrassNormal;
uniform lowp sampler2D _Normal0;
uniform lowp sampler2D _Normal2;
uniform lowp sampler2D _Diffuse1;
uniform lowp sampler2D _DetailNormal;
uniform lowp sampler2D _Diffuse2;
uniform lowp sampler2D _DetailDiffuse;
uniform highp sampler2D _CameraDepthBlendTexture;
uniform lowp sampler2D _CameraDepthBlendNormTexture;
uniform lowp sampler2D _CameraDepthBlendDiffTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec3 u_xlatb1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
bvec3 u_xlatb2;
vec4 u_xlat3;
lowp vec4 u_xlat10_3;
bvec3 u_xlatb3;
vec4 u_xlat4;
lowp vec4 u_xlat10_4;
bvec3 u_xlatb4;
vec3 u_xlat5;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec4 u_xlat16_11;
mediump vec3 u_xlat16_12;
mediump vec3 u_xlat16_13;
mediump vec3 u_xlat16_14;
float u_xlat15;
mediump float u_xlat16_15;
vec3 u_xlat16;
vec3 u_xlat17;
vec3 u_xlat18;
vec3 u_xlat19;
vec2 u_xlat30;
mediump float u_xlat16_30;
bvec2 u_xlatb30;
float u_xlat31;
float u_xlat32;
vec2 u_xlat33;
bvec2 u_xlatb33;
vec2 u_xlat34;
mediump vec2 u_xlat16_40;
mediump float u_xlat16_41;
float u_xlat45;
bool u_xlatb45;
float u_xlat46;
float u_xlat47;
float u_xlat48;
bool u_xlatb48;
float u_xlat49;
mediump float u_xlat16_53;
mediump float u_xlat16_54;
mediump float u_xlat16_55;
mediump float u_xlat16_56;
mediump float u_xlat16_57;
void main()
{
    u_xlat0.x = vs_TEXCOORD3.w;
    u_xlat0.y = vs_TEXCOORD4.w;
    u_xlat0.z = vs_TEXCOORD5.w;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x / _Diffuse2Distance;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat15 + 9.99999975e-05;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Diffuse2Fade;
    u_xlat0.y = exp2(u_xlat15);
    u_xlat0.x = u_xlat0.x / _DetailDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + 9.99999975e-05;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _DetailFade;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.xy = min(u_xlat0.xy, vec2(1.0, 1.0));
    u_xlat1.zw = vec2(vs_TEXCOORD0.z + (-_Diffuse1_ST.z), vs_TEXCOORD0.w + (-_Diffuse1_ST.w));
    u_xlat30.xy = vec2(_Diffuse1_ST.x * _Diffuse1_TexelSize.z, _Diffuse1_ST.y * _Diffuse1_TexelSize.w);
    u_xlatb30.xy = lessThan(vec4(1.0, 1.0, 1.0, 1.0), u_xlat30.xyxy).xy;
    u_xlatb30.x = u_xlatb30.y || u_xlatb30.x;
    u_xlat1.xy = _Diffuse1_TexelSize.zw;
    u_xlat2 = (u_xlatb30.x) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
    u_xlat3.xy = vec2(_Diffuse1_ST.x * _Normal0_TexelSize.z, _Diffuse1_ST.y * _Normal0_TexelSize.w);
    u_xlatb3.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat3.xyxx).xy;
    u_xlatb45 = u_xlatb3.y || u_xlatb3.x;
    u_xlat1.xy = _Normal0_TexelSize.zw;
    u_xlat1 = (bool(u_xlatb45)) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
    u_xlat3.xy = (bool(u_xlatb45)) ? _Diffuse1_ST.xy : vec2(1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb45 = !!(u_xlat0.y<0.800000012);
#else
    u_xlatb45 = u_xlat0.y<0.800000012;
#endif
    u_xlat4.zw = vec2(vs_TEXCOORD2.x + (-_Diffuse2_ST.z), vs_TEXCOORD2.y + (-_Diffuse2_ST.w));
    u_xlat33.xy = u_xlat1.xy * u_xlat3.xy;
    u_xlat5.xy = vec2(_Diffuse2_ST.x * _Normal2_TexelSize.z, _Diffuse2_ST.y * _Normal2_TexelSize.w);
    u_xlatb33.xy = lessThan(u_xlat33.xyxy, u_xlat5.xyxy).xy;
    u_xlatb33.x = u_xlatb33.y || u_xlatb33.x;
    u_xlat4.xy = _Normal2_TexelSize.zw;
    u_xlat4 = (u_xlatb33.x) ? u_xlat4 : u_xlat1;
    u_xlat1 = (bool(u_xlatb45)) ? u_xlat4 : u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb48 = !!(u_xlat0.x<0.800000012);
#else
    u_xlatb48 = u_xlat0.x<0.800000012;
#endif
    if(u_xlatb48){
        u_xlat4.xy = (u_xlatb30.x) ? _Diffuse1_ST.xy : vec2(1.0, 1.0);
        u_xlat33.xy = (u_xlatb33.x) ? _Diffuse2_ST.xy : u_xlat3.xy;
        u_xlat30.xy = (bool(u_xlatb45)) ? u_xlat33.xy : u_xlat3.xy;
        u_xlat3.zw = vec2(vs_TEXCOORD2.z + (-_DetailDiffuse_ST.z), vs_TEXCOORD2.w + (-_DetailDiffuse_ST.w));
        u_xlat4.xy = u_xlat2.xy * u_xlat4.xy;
        u_xlat34.xy = vec2(_DetailDiffuse_ST.x * _DetailDiffuse_TexelSize.z, _DetailDiffuse_ST.y * _DetailDiffuse_TexelSize.w);
        u_xlatb4.xy = lessThan(u_xlat4.xyxx, u_xlat34.xyxx).xy;
        u_xlatb4.x = u_xlatb4.y || u_xlatb4.x;
        u_xlat3.xy = _DetailDiffuse_TexelSize.zw;
        u_xlat2 = (u_xlatb4.x) ? u_xlat3 : u_xlat2;
        u_xlat30.xy = u_xlat30.xy * u_xlat1.xy;
        u_xlat4.xy = vec2(_DetailDiffuse_ST.x * _DetailNormal_TexelSize.z, _DetailDiffuse_ST.y * _DetailNormal_TexelSize.w);
        u_xlatb30.xy = lessThan(u_xlat30.xyxy, u_xlat4.xyxy).xy;
        u_xlatb30.x = u_xlatb30.y || u_xlatb30.x;
        u_xlat3.xy = _DetailNormal_TexelSize.zw;
        u_xlat1 = (u_xlatb30.x) ? u_xlat3 : u_xlat1;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30.x = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb30.x = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb30.x){
        u_xlatb3.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat4 = (u_xlatb3.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat4 = (u_xlatb3.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat4;
        u_xlat3 = (u_xlatb3.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat4;
        SV_Target0 = u_xlat3;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30.x = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb30.x = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb30.x){
        u_xlat10_3.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.xy).xyz;
        SV_Target0.xyz = u_xlat10_3.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30.x = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb30.x = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb30.x){
        u_xlat30.x = max(_GrassDiffuse_TexelSize.w, _GrassDiffuse_TexelSize.z);
        u_xlat30.x = max(u_xlat30.x, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb45 = !!(256.0<u_xlat30.x);
#else
        u_xlatb45 = 256.0<u_xlat30.x;
#endif
        u_xlatb3.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), u_xlat30.xxxx).xy;
        u_xlat4 = (u_xlatb3.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat3 = (u_xlatb3.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat4;
        u_xlat3 = (bool(u_xlatb45)) ? u_xlat3 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat3;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30.x = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb30.x = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb30.x){
        u_xlat30.xy = vec2(vs_TEXCOORD0.x * _GrassDiffuse_TexelSize.z, vs_TEXCOORD0.y * _GrassDiffuse_TexelSize.w);
        u_xlat3.xy = dFdx(u_xlat30.xy);
        u_xlat30.xy = dFdy(u_xlat30.xy);
        u_xlat3.x = dot(u_xlat3.xy, u_xlat3.xy);
        u_xlat30.x = dot(u_xlat30.xy, u_xlat30.xy);
        u_xlat30.x = max(u_xlat30.x, u_xlat3.x);
        u_xlat30.x = log2(u_xlat30.x);
        u_xlat30.x = u_xlat30.x * 0.5;
        u_xlat30.x = max(u_xlat30.x, 0.0);
        u_xlat30.x = u_xlat30.x + 1.0;
        u_xlat45 = max(_GrassDiffuse_TexelSize.w, _GrassDiffuse_TexelSize.z);
        u_xlat30.x = u_xlat45 / u_xlat30.x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb45 = !!(256.0<u_xlat30.x);
#else
        u_xlatb45 = 256.0<u_xlat30.x;
#endif
        u_xlatb3.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), u_xlat30.xxxx).xy;
        u_xlat4 = (u_xlatb3.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat3 = (u_xlatb3.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat4;
        u_xlat3 = (bool(u_xlatb45)) ? u_xlat3 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat3;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30.x = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb30.x = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb30.x){
        u_xlat3.zw = vec2(vs_TEXCOORD0.x + (-_GrassDiffuse_ST.z), vs_TEXCOORD0.y + (-_GrassDiffuse_ST.w));
        u_xlat30.xy = vec2(_GrassDiffuse_ST.x * _GrassDiffuse_TexelSize.z, _GrassDiffuse_ST.y * _GrassDiffuse_TexelSize.w);
        u_xlatb30.xy = lessThan(vec4(1.0, 1.0, 1.0, 1.0), u_xlat30.xyxy).xy;
        u_xlatb30.x = u_xlatb30.y || u_xlatb30.x;
        u_xlat3.xy = _GrassDiffuse_TexelSize.zw;
        u_xlat4 = (u_xlatb30.x) ? u_xlat3 : vec4(1.0, 1.0, 0.0, 0.0);
        u_xlat2 = u_xlat2 + (-u_xlat4);
        u_xlat2 = vs_COLOR0.wwww * u_xlat2 + u_xlat4;
#ifdef UNITY_ADRENO_ES3
        u_xlatb30.x = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb30.x = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb30.x){
            u_xlat30.xy = vec2(u_xlat2.x * u_xlat2.z, u_xlat2.y * u_xlat2.w);
            u_xlat4.xy = dFdx(u_xlat30.xy);
            u_xlat30.xy = dFdy(u_xlat30.xy);
            u_xlat34.x = dot(u_xlat4.xy, u_xlat4.xy);
            u_xlat49 = dot(u_xlat30.xy, u_xlat30.xy);
            u_xlat34.x = max(u_xlat49, u_xlat34.x);
            u_xlat34.x = log2(u_xlat34.x);
            u_xlat34.x = u_xlat34.x * 0.5;
            u_xlat34.x = max(u_xlat34.x, 0.0);
            u_xlat34.x = u_xlat34.x + 1.0;
            u_xlat49 = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat4.xy = vec2(u_xlat49) * u_xlat4.xy;
            u_xlat30.xy = u_xlat30.xy * vec2(u_xlat49);
            u_xlat4.xy = u_xlat4.xy / u_xlat34.xx;
            u_xlat30.xy = u_xlat30.xy / u_xlat34.xx;
            u_xlat19.x = dot(abs(u_xlat4.xy), abs(u_xlat4.xy));
            u_xlat45 = dot(abs(u_xlat30.xy), abs(u_xlat30.xy));
            u_xlat34.x = sqrt(u_xlat19.x);
            u_xlat49 = sqrt(u_xlat45);
            u_xlat19.x = inversesqrt(u_xlat19.x);
            u_xlat4.x = u_xlat19.x * abs(u_xlat4.x);
            u_xlat45 = inversesqrt(u_xlat45);
            u_xlat30.x = u_xlat45 * abs(u_xlat30.x);
            u_xlat30.x = u_xlat30.x * u_xlat4.x;
            u_xlat30.x = (-u_xlat30.x) * u_xlat30.x + 1.0;
            u_xlat30.x = sqrt(u_xlat30.x);
            u_xlat45 = u_xlat49 * u_xlat34.x;
            u_xlat4.x = u_xlat30.x * u_xlat45;
            u_xlat19.xy = vec2(u_xlat2.z * float(3.0), u_xlat2.w * float(3.0));
            u_xlat49 = fract((-u_xlat19.x));
            u_xlat19.z = u_xlat49 + 0.5;
            u_xlat19.xy = fract(u_xlat19.xy);
            u_xlat19.xy = u_xlat19.xy + vec2(0.5, 0.5);
            u_xlat19.xyz = floor(u_xlat19.xyz);
            u_xlat49 = (-u_xlat19.x) + u_xlat19.z;
            u_xlat19.x = u_xlat49 * u_xlat19.y + u_xlat19.x;
            u_xlat34.x = (-u_xlat45) * u_xlat30.x + 1.0;
            u_xlat5.xyz = (-u_xlat19.xxx) + vec3(0.5, 0.0, 1.0);
            u_xlat6.xyz = u_xlat34.xxx * u_xlat5.xyz + u_xlat19.xxx;
            u_xlatb4.xz = lessThan(u_xlat4.xxxx, vec4(1.0, 0.0, 2.0, 0.0)).xz;
            u_xlat7.xyz = u_xlat19.xxx * vec3(0.0, 1.0, 0.0);
            u_xlat30.x = u_xlat45 * u_xlat30.x + -4.0;
            u_xlat30.x = exp2(u_xlat30.x);
            u_xlat30.x = u_xlat30.x + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat30.x = min(max(u_xlat30.x, 0.0), 1.0);
#else
            u_xlat30.x = clamp(u_xlat30.x, 0.0, 1.0);
#endif
            u_xlat5.xyz = u_xlat30.xxx * u_xlat5.zyy + u_xlat19.xxx;
            u_xlat19.xyz = (u_xlatb4.z) ? u_xlat7.xyz : u_xlat5.xyz;
            u_xlat4.xyz = (u_xlatb4.x) ? u_xlat6.xyz : u_xlat19.xyz;
        } else {
            u_xlat30.xy = vec2(_GrassDiffuse_ST.x * _GrassNormal_TexelSize.z, _GrassDiffuse_ST.y * _GrassNormal_TexelSize.w);
            u_xlatb30.xy = lessThan(vec4(1.0, 1.0, 1.0, 1.0), u_xlat30.xyxy).xy;
            u_xlatb30.x = u_xlatb30.y || u_xlatb30.x;
            u_xlat3.xy = _GrassNormal_TexelSize.zw;
            u_xlat3 = (u_xlatb30.x) ? u_xlat3 : vec4(1.0, 1.0, 0.0, 0.0);
            u_xlat1 = u_xlat1 + (-u_xlat3);
            u_xlat1 = vs_COLOR0.wwww * u_xlat1 + u_xlat3;
#ifdef UNITY_ADRENO_ES3
            u_xlatb30.x = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb30.x = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb30.x){
                u_xlat30.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                u_xlat3.xy = dFdx(u_xlat30.xy);
                u_xlat30.xy = dFdy(u_xlat30.xy);
                u_xlat33.x = dot(u_xlat3.xy, u_xlat3.xy);
                u_xlat48 = dot(u_xlat30.xy, u_xlat30.xy);
                u_xlat33.x = max(u_xlat48, u_xlat33.x);
                u_xlat33.x = log2(u_xlat33.x);
                u_xlat33.x = u_xlat33.x * 0.5;
                u_xlat33.x = max(u_xlat33.x, 0.0);
                u_xlat33.x = u_xlat33.x + 1.0;
                u_xlat48 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                u_xlat3.xy = vec2(u_xlat48) * u_xlat3.xy;
                u_xlat30.xy = u_xlat30.xy * vec2(u_xlat48);
                u_xlat3.xy = u_xlat3.xy / u_xlat33.xx;
                u_xlat30.xy = u_xlat30.xy / u_xlat33.xx;
                u_xlat18.x = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                u_xlat45 = dot(abs(u_xlat30.xy), abs(u_xlat30.xy));
                u_xlat33.x = sqrt(u_xlat18.x);
                u_xlat48 = sqrt(u_xlat45);
                u_xlat18.x = inversesqrt(u_xlat18.x);
                u_xlat3.x = u_xlat18.x * abs(u_xlat3.x);
                u_xlat45 = inversesqrt(u_xlat45);
                u_xlat30.x = u_xlat45 * abs(u_xlat30.x);
                u_xlat30.x = u_xlat30.x * u_xlat3.x;
                u_xlat30.x = (-u_xlat30.x) * u_xlat30.x + 1.0;
                u_xlat30.x = sqrt(u_xlat30.x);
                u_xlat45 = u_xlat48 * u_xlat33.x;
                u_xlat3.x = u_xlat30.x * u_xlat45;
                u_xlat18.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                u_xlat48 = fract((-u_xlat18.x));
                u_xlat18.z = u_xlat48 + 0.5;
                u_xlat18.xy = fract(u_xlat18.xy);
                u_xlat18.xy = u_xlat18.xy + vec2(0.5, 0.5);
                u_xlat18.xyz = floor(u_xlat18.xyz);
                u_xlat48 = (-u_xlat18.x) + u_xlat18.z;
                u_xlat18.x = u_xlat48 * u_xlat18.y + u_xlat18.x;
                u_xlat33.x = (-u_xlat45) * u_xlat30.x + 1.0;
                u_xlat5.xyz = (-u_xlat18.xxx) + vec3(0.5, 0.0, 1.0);
                u_xlat6.xyz = u_xlat33.xxx * u_xlat5.xyz + u_xlat18.xxx;
                u_xlatb3.xz = lessThan(u_xlat3.xxxx, vec4(1.0, 0.0, 2.0, 0.0)).xz;
                u_xlat7.xyz = u_xlat18.xxx * vec3(0.0, 1.0, 0.0);
                u_xlat30.x = u_xlat45 * u_xlat30.x + -4.0;
                u_xlat30.x = exp2(u_xlat30.x);
                u_xlat30.x = u_xlat30.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                u_xlat30.x = min(max(u_xlat30.x, 0.0), 1.0);
#else
                u_xlat30.x = clamp(u_xlat30.x, 0.0, 1.0);
#endif
                u_xlat5.xyz = u_xlat30.xxx * u_xlat5.zyy + u_xlat18.xxx;
                u_xlat18.xyz = (u_xlatb3.z) ? u_xlat7.xyz : u_xlat5.xyz;
                u_xlat4.xyz = (u_xlatb3.x) ? u_xlat6.xyz : u_xlat18.xyz;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb30.x = !!(u_xlat2.x>=u_xlat1.x);
#else
                u_xlatb30.x = u_xlat2.x>=u_xlat1.x;
#endif
                if(u_xlatb30.x){
                    u_xlat30.xy = vec2(u_xlat2.x * u_xlat2.z, u_xlat2.y * u_xlat2.w);
                    u_xlat2.xy = dFdx(u_xlat30.xy);
                    u_xlat30.xy = dFdy(u_xlat30.xy);
                    u_xlat3.x = dot(u_xlat2.xy, u_xlat2.xy);
                    u_xlat18.x = dot(u_xlat30.xy, u_xlat30.xy);
                    u_xlat3.x = max(u_xlat18.x, u_xlat3.x);
                    u_xlat3.x = log2(u_xlat3.x);
                    u_xlat3.x = u_xlat3.x * 0.5;
                    u_xlat3.x = max(u_xlat3.x, 0.0);
                    u_xlat3.x = u_xlat3.x + 1.0;
                    u_xlat18.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat2.xy = u_xlat2.xy * u_xlat18.xx;
                    u_xlat30.xy = u_xlat30.xy * u_xlat18.xx;
                    u_xlat2.xy = u_xlat2.xy / u_xlat3.xx;
                    u_xlat30.xy = u_xlat30.xy / u_xlat3.xx;
                    u_xlat17.x = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
                    u_xlat45 = dot(abs(u_xlat30.xy), abs(u_xlat30.xy));
                    u_xlat3.x = sqrt(u_xlat17.x);
                    u_xlat18.x = sqrt(u_xlat45);
                    u_xlat17.x = inversesqrt(u_xlat17.x);
                    u_xlat2.x = u_xlat17.x * abs(u_xlat2.x);
                    u_xlat45 = inversesqrt(u_xlat45);
                    u_xlat30.x = u_xlat45 * abs(u_xlat30.x);
                    u_xlat30.x = u_xlat30.x * u_xlat2.x;
                    u_xlat30.x = (-u_xlat30.x) * u_xlat30.x + 1.0;
                    u_xlat30.x = sqrt(u_xlat30.x);
                    u_xlat45 = u_xlat18.x * u_xlat3.x;
                    u_xlat2.x = u_xlat30.x * u_xlat45;
                    u_xlat17.xy = vec2(u_xlat2.z * float(3.0), u_xlat2.w * float(3.0));
                    u_xlat47 = fract((-u_xlat17.x));
                    u_xlat17.z = u_xlat47 + 0.5;
                    u_xlat17.xy = fract(u_xlat17.xy);
                    u_xlat17.xy = u_xlat17.xy + vec2(0.5, 0.5);
                    u_xlat17.xyz = floor(u_xlat17.xyz);
                    u_xlat47 = (-u_xlat17.x) + u_xlat17.z;
                    u_xlat17.x = u_xlat47 * u_xlat17.y + u_xlat17.x;
                    u_xlat32 = (-u_xlat45) * u_xlat30.x + 1.0;
                    u_xlat3.xyz = (-u_xlat17.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat5.xyz = vec3(u_xlat32) * u_xlat3.xyz + u_xlat17.xxx;
                    u_xlatb2.xz = lessThan(u_xlat2.xxxx, vec4(1.0, 0.0, 2.0, 0.0)).xz;
                    u_xlat6.xyz = u_xlat17.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat30.x = u_xlat45 * u_xlat30.x + -4.0;
                    u_xlat30.x = exp2(u_xlat30.x);
                    u_xlat30.x = u_xlat30.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat30.x = min(max(u_xlat30.x, 0.0), 1.0);
#else
                    u_xlat30.x = clamp(u_xlat30.x, 0.0, 1.0);
#endif
                    u_xlat3.xyz = u_xlat30.xxx * u_xlat3.zyy + u_xlat17.xxx;
                    u_xlat17.xyz = (u_xlatb2.z) ? u_xlat6.xyz : u_xlat3.xyz;
                    u_xlat4.xyz = (u_xlatb2.x) ? u_xlat5.xyz : u_xlat17.xyz;
                } else {
                    u_xlat30.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat1.xy = dFdx(u_xlat30.xy);
                    u_xlat30.xy = dFdy(u_xlat30.xy);
                    u_xlat2.x = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat17.x = dot(u_xlat30.xy, u_xlat30.xy);
                    u_xlat2.x = max(u_xlat17.x, u_xlat2.x);
                    u_xlat2.x = log2(u_xlat2.x);
                    u_xlat2.x = u_xlat2.x * 0.5;
                    u_xlat2.x = max(u_xlat2.x, 0.0);
                    u_xlat2.x = u_xlat2.x + 1.0;
                    u_xlat17.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat1.xy = u_xlat1.xy * u_xlat17.xx;
                    u_xlat30.xy = u_xlat30.xy * u_xlat17.xx;
                    u_xlat1.xy = u_xlat1.xy / u_xlat2.xx;
                    u_xlat30.xy = u_xlat30.xy / u_xlat2.xx;
                    u_xlat16.x = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat45 = dot(abs(u_xlat30.xy), abs(u_xlat30.xy));
                    u_xlat2.x = sqrt(u_xlat16.x);
                    u_xlat17.x = sqrt(u_xlat45);
                    u_xlat16.x = inversesqrt(u_xlat16.x);
                    u_xlat1.x = u_xlat16.x * abs(u_xlat1.x);
                    u_xlat45 = inversesqrt(u_xlat45);
                    u_xlat30.x = u_xlat45 * abs(u_xlat30.x);
                    u_xlat30.x = u_xlat30.x * u_xlat1.x;
                    u_xlat30.x = (-u_xlat30.x) * u_xlat30.x + 1.0;
                    u_xlat30.x = sqrt(u_xlat30.x);
                    u_xlat45 = u_xlat17.x * u_xlat2.x;
                    u_xlat1.x = u_xlat30.x * u_xlat45;
                    u_xlat16.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat46 = fract((-u_xlat16.x));
                    u_xlat16.z = u_xlat46 + 0.5;
                    u_xlat16.xy = fract(u_xlat16.xy);
                    u_xlat16.xy = u_xlat16.xy + vec2(0.5, 0.5);
                    u_xlat16.xyz = floor(u_xlat16.xyz);
                    u_xlat46 = (-u_xlat16.x) + u_xlat16.z;
                    u_xlat16.x = u_xlat46 * u_xlat16.y + u_xlat16.x;
                    u_xlat31 = (-u_xlat45) * u_xlat30.x + 1.0;
                    u_xlat2.xyz = (-u_xlat16.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat3.xyz = vec3(u_xlat31) * u_xlat2.xyz + u_xlat16.xxx;
                    u_xlatb1.xz = lessThan(u_xlat1.xxxx, vec4(1.0, 0.0, 2.0, 0.0)).xz;
                    u_xlat5.xyz = u_xlat16.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat30.x = u_xlat45 * u_xlat30.x + -4.0;
                    u_xlat30.x = exp2(u_xlat30.x);
                    u_xlat30.x = u_xlat30.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat30.x = min(max(u_xlat30.x, 0.0), 1.0);
#else
                    u_xlat30.x = clamp(u_xlat30.x, 0.0, 1.0);
#endif
                    u_xlat2.xyz = u_xlat30.xxx * u_xlat2.zyy + u_xlat16.xxx;
                    u_xlat16.xyz = (u_xlatb1.z) ? u_xlat5.xyz : u_xlat2.xyz;
                    u_xlat4.xyz = (u_xlatb1.x) ? u_xlat3.xyz : u_xlat16.xyz;
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat4.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb30.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 100.0, 102.0)).xy;
    u_xlatb30.x = u_xlatb30.y || u_xlatb30.x;
    if(u_xlatb30.x){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb30.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 101.0, 103.0)).xy;
    u_xlatb30.x = u_xlatb30.y || u_xlatb30.x;
    if(u_xlatb30.x){
        SV_Target0 = vec4(0.400000006, 0.400000006, 0.400000006, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30.x = !!(vs_COLOR0.w<0.99000001);
#else
    u_xlatb30.x = vs_COLOR0.w<0.99000001;
#endif
    if(u_xlatb30.x){
        u_xlat10_1 = texture(_GrassNormal, vs_TEXCOORD0.xy, -1.0);
        u_xlat16_8.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_8.xy = u_xlat16_8.xy * vec2(_GrassNormalScale);
        u_xlat16_53 = u_xlat10_1.w * _UseGrassSpecular;
        u_xlat10_1.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.xy, -1.0).xyz;
        u_xlat16_9.xyz = u_xlat10_1.xyz;
    } else {
        u_xlat16_9.x = float(0.0);
        u_xlat16_9.y = float(0.0);
        u_xlat16_9.z = float(0.0);
        u_xlat16_8.x = float(0.0);
        u_xlat16_8.y = float(0.0);
        u_xlat16_8.z = float(1.0);
        u_xlat16_53 = float(0.0);
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30.x = !!(0.00999999978<vs_COLOR0.w);
#else
    u_xlatb30.x = 0.00999999978<vs_COLOR0.w;
#endif
    if(u_xlatb30.x){
        u_xlat10_1.xyz = texture(_Normal0, vs_TEXCOORD0.zw, -1.0).xyw;
        u_xlat10_2.xyz = texture(_Normal2, vs_TEXCOORD2.xy, -1.0).xyw;
        u_xlat16_10.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_40.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_40.xy = u_xlat16_40.xy * vec2(_Normal2Scale);
        u_xlat16_54 = (-u_xlat0.y) + 1.0;
        u_xlat16_40.xy = vec2(u_xlat16_54) * u_xlat16_40.xy;
        u_xlat16_40.xy = u_xlat16_40.xy * vs_COLOR0.xx;
        u_xlat10_3 = texture(_Diffuse1, vs_TEXCOORD0.zw, -1.0);
        u_xlat30.xy = vec2(vs_TEXCOORD2.z * float(_DetailNormalUVScale), vs_TEXCOORD2.w * float(_DetailNormalUVScale));
        u_xlat10_1.xyw = texture(_DetailNormal, u_xlat30.xy, -1.0).xyw;
        u_xlat16_11.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_11.xy = u_xlat16_11.xy * vec2(_DetailNormalScale);
        u_xlat16_54 = (-u_xlat0.x) + 1.0;
        u_xlat16_11.xy = vec2(u_xlat16_54) * u_xlat16_11.xy;
        u_xlat10_4 = texture(_Diffuse2, vs_TEXCOORD2.xy, -1.0);
        u_xlat10_5 = texture(_DetailDiffuse, vs_TEXCOORD2.zw, -1.0);
        u_xlat16_54 = u_xlat10_4.w * _UseDiffuseTwoHeight;
        u_xlat16_41 = u_xlat10_5.w * _UseDetailDiffuseHeight;
        u_xlat16_12.xyz = u_xlat10_3.xyz + (-u_xlat10_4.xyz);
        u_xlat16_56 = u_xlat10_3.w * _UseDiffuseOneHeight + (-u_xlat16_54);
        u_xlat16_12.xyz = u_xlat0.yyy * u_xlat16_12.xyz + u_xlat10_4.xyz;
        u_xlat16_54 = u_xlat0.y * u_xlat16_56 + u_xlat16_54;
        u_xlat16_56 = u_xlat0.x * _DetailBlendVal;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_56 = min(max(u_xlat16_56, 0.0), 1.0);
#else
        u_xlat16_56 = clamp(u_xlat16_56, 0.0, 1.0);
#endif
        u_xlat16_57 = (-u_xlat16_56) + 1.0;
        u_xlat16_41 = u_xlat16_41 * u_xlat16_57;
        u_xlat16_54 = max(u_xlat16_54, u_xlat16_41);
        u_xlat16_13.xyz = u_xlat10_5.xyz * u_xlat16_12.xyz;
        u_xlat16_14.xyz = u_xlat16_13.xyz * vec3(4.0, 4.0, 4.0);
        u_xlat16_12.xyz = (-u_xlat16_13.xyz) * vec3(4.0, 4.0, 4.0) + u_xlat16_12.xyz;
        u_xlat16_12.xyz = vec3(u_xlat16_56) * u_xlat16_12.xyz + u_xlat16_14.xyz;
        u_xlat16_12.xyz = min(u_xlat16_12.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_41 = u_xlat10_2.z * _UseSpecularTwo;
        u_xlat16_56 = u_xlat10_1.w * _UseDetailSpecular;
        u_xlat16_13.x = _UseSpecularOne * u_xlat10_1.z + (-u_xlat16_41);
        u_xlat16_41 = u_xlat0.y * u_xlat16_13.x + u_xlat16_41;
        u_xlat16_56 = u_xlat16_57 * u_xlat16_56;
        u_xlat16_41 = max(u_xlat16_56, u_xlat16_41);
        u_xlat16_10.xy = u_xlat16_10.xy * vec2(_Normal0Scale) + u_xlat16_40.xy;
        u_xlat16_10.xy = u_xlat16_11.xy * vs_COLOR0.xx + u_xlat16_10.xy;
    } else {
        u_xlat16_12.x = float(0.0);
        u_xlat16_12.y = float(0.0);
        u_xlat16_12.z = float(0.0);
        u_xlat16_10.x = float(0.0);
        u_xlat16_10.y = float(0.0);
        u_xlat16_54 = 1.0;
        u_xlat16_41 = 0.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor);
#endif
    u_xlat16_11.xyw = u_xlat16_12.xyz * _TintColor.xyz;
    u_xlat16_11.xyw = (bool(u_xlatb0)) ? u_xlat16_11.xyw : u_xlat16_12.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend);
#endif
    u_xlat16_15 = u_xlat16_54;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_30 = vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_54 = _HeightContrast * 10.0;
    u_xlat16_15 = u_xlat16_15 + -1.0;
    u_xlat16_55 = _HeightSpread + 0.100000001;
    u_xlat16_30 = log2(u_xlat16_30);
    u_xlat16_30 = u_xlat16_30 * u_xlat16_55;
    u_xlat16_30 = exp2(u_xlat16_30);
    u_xlat16_15 = u_xlat16_30 * 2.0 + u_xlat16_15;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_30 = _HeightContrast * 10.0 + 1.0;
    u_xlat16_30 = _HeightContrast * 10.0 + u_xlat16_30;
    u_xlat15 = u_xlat16_15 * u_xlat16_30 + (-u_xlat16_54);
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_54 = (u_xlatb0) ? u_xlat15 : vs_COLOR0.w;
    u_xlat16_10.z = 1.0;
    u_xlat16_10.xyz = (-u_xlat16_8.xyz) + u_xlat16_10.xyz;
    u_xlat16_8.xyz = vec3(u_xlat16_54) * u_xlat16_10.xyz + u_xlat16_8.xyz;
    u_xlat16_10.x = (-u_xlat16_53) + u_xlat16_41;
    u_xlat16_53 = u_xlat16_54 * u_xlat16_10.x + u_xlat16_53;
    u_xlat16_10.xyz = (-u_xlat16_9.xyz) + u_xlat16_11.xyw;
    u_xlat16_9.xyz = vec3(u_xlat16_54) * u_xlat16_10.xyz + u_xlat16_9.xyz;
    u_xlat16_53 = u_xlat16_53 + _Shininess;
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, u_xlat16_8.xyz);
    u_xlat0.y = dot(vs_TEXCOORD4.xyz, u_xlat16_8.xyz);
    u_xlat0.z = dot(vs_TEXCOORD5.xyz, u_xlat16_8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb45 = !!(vs_TEXCOORD1.w<100.0);
#else
    u_xlatb45 = vs_TEXCOORD1.w<100.0;
#endif
    if(u_xlatb45){
        u_xlat1.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
        u_xlat45 = texture(_CameraDepthBlendTexture, u_xlat1.xy).x;
        u_xlat45 = _ZBufferParams.z * u_xlat45 + _ZBufferParams.w;
        u_xlat45 = float(1.0) / u_xlat45;
        u_xlat45 = u_xlat45 + (-vs_TEXCOORD1.w);
        u_xlat45 = abs(u_xlat45) * _DepthBiasScaled;
        u_xlat45 = u_xlat45 * 0.600000024;
#ifdef UNITY_ADRENO_ES3
        u_xlat45 = min(max(u_xlat45, 0.0), 1.0);
#else
        u_xlat45 = clamp(u_xlat45, 0.0, 1.0);
#endif
        u_xlat45 = sqrt(u_xlat45);
        u_xlat10_2.xyz = texture(_CameraDepthBlendNormTexture, u_xlat1.xy).xyz;
        u_xlat16_8.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat10_1.xyz = texture(_CameraDepthBlendDiffTexture, u_xlat1.xy).xyz;
        u_xlat16_54 = u_xlat0.y * _DepthBlendAO;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_54 = min(max(u_xlat16_54, 0.0), 1.0);
#else
        u_xlat16_54 = clamp(u_xlat16_54, 0.0, 1.0);
#endif
        u_xlat46 = (-u_xlat45) + 1.0;
        u_xlat46 = u_xlat16_54 * u_xlat46 + u_xlat45;
        u_xlat46 = max(u_xlat46, 0.899999976);
        u_xlat2.xyz = u_xlat16_9.xyz * vec3(u_xlat46) + (-u_xlat10_1.xyz);
        u_xlat9.xyz = vec3(u_xlat45) * u_xlat2.xyz + u_xlat10_1.xyz;
        u_xlat1.xyz = u_xlat0.xyz + (-u_xlat16_8.xyz);
        u_xlat1.xyz = vec3(u_xlat45) * u_xlat1.xyz + u_xlat16_8.xyz;
        u_xlat16_9.xyz = u_xlat9.xyz;
        u_xlat16_1.xyz = u_xlat1.xyz;
    } else {
        u_xlat16_1.xyz = u_xlat0.xyz;
    //ENDIF
    }
    u_xlat16_8.x = u_xlat16_53 * _Terrain_Smoothness;
    u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
    SV_Target2.w = min(u_xlat16_8.x, 0.5);
    u_xlat16_8.xyz = u_xlat16_9.xyz * vec3(vec3(_Terrain_Specular, _Terrain_Specular, _Terrain_Specular));
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat16_53 = max(u_xlat16_8.z, u_xlat16_8.y);
    u_xlat16_53 = max(u_xlat16_53, u_xlat16_8.x);
    u_xlat16_53 = (-u_xlat16_53) + 1.0;
    SV_Target1.xyz = vec3(u_xlat16_53) * u_xlat16_9.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_53 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_53 : u_xlat16_8.z;
    SV_Target0.w = 0.0;
    SV_Target1.w = _SSAO_Intensity;
    SV_Target2.xy = u_xlat16_8.xy;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MSAA_INTERPOLATION" "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _Diffuse1_ST;
uniform 	float _UVDiffuse2;
uniform 	vec4 _Diffuse2_ST;
uniform 	float _UVDetail;
uniform 	vec4 _DetailDiffuse_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec2 u_xlat12;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat15 = u_xlat15 + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat15 = u_xlat15 + u_xlat2.x;
    u_xlat15 = u_xlat15 * 0.330000013;
    u_xlat2.xy = vec2(u_xlat15) * in_TEXCOORD0.xy;
    u_xlat12.xy = vec2(u_xlat15) * in_TEXCOORD1.xy;
    vs_TEXCOORD0.xy = u_xlat2.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Diffuse1_ST.xy + _Diffuse1_ST.zw;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat15 * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UVDiffuse2==0.0);
#else
    u_xlatb15 = _UVDiffuse2==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat2.xy : u_xlat12.xy;
    vs_TEXCOORD2.xy = u_xlat1.xy * _Diffuse2_ST.xy + _Diffuse2_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UVDetail==0.0);
#else
    u_xlatb15 = _UVDetail==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat2.xy : u_xlat12.xy;
    vs_TEXCOORD2.zw = u_xlat1.xy * _DetailDiffuse_ST.xy + _DetailDiffuse_ST.zw;
    vs_TEXCOORD3.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz;
    vs_TEXCOORD3.y = u_xlat16_4.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat0.y;
    vs_TEXCOORD5.w = u_xlat0.z;
    vs_TEXCOORD4.y = u_xlat16_4.y;
    vs_TEXCOORD5.y = u_xlat16_4.z;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	mediump float _HeightSpread;
uniform 	mediump float _HeightContrast;
uniform 	mediump float _UseTintColor;
uniform 	mediump float _UseDiffuseOneHeight;
uniform 	mediump float _UseDiffuseTwoHeight;
uniform 	mediump float _UseDetailDiffuseHeight;
uniform 	mediump float _UseGrassHeightBlend;
uniform 	mediump float _UseGrassSpecular;
uniform 	mediump float _UseSpecularOne;
uniform 	mediump float _UseSpecularTwo;
uniform 	mediump float _UseDetailSpecular;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _SSAO_Intensity;
uniform 	mediump float _Terrain_Smoothness;
uniform 	mediump float _Terrain_Specular;
uniform 	mediump float _Shininess;
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _GrassDiffuse_TexelSize;
uniform 	vec4 _GrassNormal_TexelSize;
uniform 	vec4 _Diffuse1_ST;
uniform 	vec4 _Diffuse1_TexelSize;
uniform 	vec4 _Normal0_TexelSize;
uniform 	vec4 _Diffuse2_ST;
uniform 	vec4 _Normal2_TexelSize;
uniform 	mediump float _Diffuse2Distance;
uniform 	mediump float _Diffuse2Fade;
uniform 	vec4 _DetailDiffuse_ST;
uniform 	vec4 _DetailDiffuse_TexelSize;
uniform 	vec4 _DetailNormal_TexelSize;
uniform 	mediump float _DetailNormalUVScale;
uniform 	mediump float _DetailBlendVal;
uniform 	mediump float _DetailDistance;
uniform 	mediump float _DetailFade;
uniform 	mediump float _DepthBiasScaled;
uniform 	mediump float _DepthBlendAO;
uniform lowp sampler2D _GrassDiffuse;
uniform lowp sampler2D _GrassNormal;
uniform lowp sampler2D _Normal0;
uniform lowp sampler2D _Normal2;
uniform lowp sampler2D _Diffuse1;
uniform lowp sampler2D _DetailNormal;
uniform lowp sampler2D _Diffuse2;
uniform lowp sampler2D _DetailDiffuse;
uniform highp sampler2D _CameraDepthBlendTexture;
uniform lowp sampler2D _CameraDepthBlendNormTexture;
uniform lowp sampler2D _CameraDepthBlendDiffTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec3 u_xlatb1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
bvec3 u_xlatb2;
vec4 u_xlat3;
lowp vec4 u_xlat10_3;
bvec3 u_xlatb3;
vec4 u_xlat4;
lowp vec4 u_xlat10_4;
bvec3 u_xlatb4;
vec3 u_xlat5;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec4 u_xlat16_11;
mediump vec3 u_xlat16_12;
mediump vec3 u_xlat16_13;
mediump vec3 u_xlat16_14;
float u_xlat15;
mediump float u_xlat16_15;
vec3 u_xlat16;
vec3 u_xlat17;
vec3 u_xlat18;
vec3 u_xlat19;
vec2 u_xlat30;
mediump float u_xlat16_30;
bvec2 u_xlatb30;
float u_xlat31;
float u_xlat32;
vec2 u_xlat33;
bvec2 u_xlatb33;
vec2 u_xlat34;
mediump vec2 u_xlat16_40;
mediump float u_xlat16_41;
float u_xlat45;
bool u_xlatb45;
float u_xlat46;
float u_xlat47;
float u_xlat48;
bool u_xlatb48;
float u_xlat49;
mediump float u_xlat16_53;
mediump float u_xlat16_54;
mediump float u_xlat16_55;
mediump float u_xlat16_56;
mediump float u_xlat16_57;
void main()
{
    u_xlat0.x = vs_TEXCOORD3.w;
    u_xlat0.y = vs_TEXCOORD4.w;
    u_xlat0.z = vs_TEXCOORD5.w;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x / _Diffuse2Distance;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat15 + 9.99999975e-05;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Diffuse2Fade;
    u_xlat0.y = exp2(u_xlat15);
    u_xlat0.x = u_xlat0.x / _DetailDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + 9.99999975e-05;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _DetailFade;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.xy = min(u_xlat0.xy, vec2(1.0, 1.0));
    u_xlat1.zw = vec2(vs_TEXCOORD0.z + (-_Diffuse1_ST.z), vs_TEXCOORD0.w + (-_Diffuse1_ST.w));
    u_xlat30.xy = vec2(_Diffuse1_ST.x * _Diffuse1_TexelSize.z, _Diffuse1_ST.y * _Diffuse1_TexelSize.w);
    u_xlatb30.xy = lessThan(vec4(1.0, 1.0, 1.0, 1.0), u_xlat30.xyxy).xy;
    u_xlatb30.x = u_xlatb30.y || u_xlatb30.x;
    u_xlat1.xy = _Diffuse1_TexelSize.zw;
    u_xlat2 = (u_xlatb30.x) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
    u_xlat3.xy = vec2(_Diffuse1_ST.x * _Normal0_TexelSize.z, _Diffuse1_ST.y * _Normal0_TexelSize.w);
    u_xlatb3.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat3.xyxx).xy;
    u_xlatb45 = u_xlatb3.y || u_xlatb3.x;
    u_xlat1.xy = _Normal0_TexelSize.zw;
    u_xlat1 = (bool(u_xlatb45)) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
    u_xlat3.xy = (bool(u_xlatb45)) ? _Diffuse1_ST.xy : vec2(1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb45 = !!(u_xlat0.y<0.800000012);
#else
    u_xlatb45 = u_xlat0.y<0.800000012;
#endif
    u_xlat4.zw = vec2(vs_TEXCOORD2.x + (-_Diffuse2_ST.z), vs_TEXCOORD2.y + (-_Diffuse2_ST.w));
    u_xlat33.xy = u_xlat1.xy * u_xlat3.xy;
    u_xlat5.xy = vec2(_Diffuse2_ST.x * _Normal2_TexelSize.z, _Diffuse2_ST.y * _Normal2_TexelSize.w);
    u_xlatb33.xy = lessThan(u_xlat33.xyxy, u_xlat5.xyxy).xy;
    u_xlatb33.x = u_xlatb33.y || u_xlatb33.x;
    u_xlat4.xy = _Normal2_TexelSize.zw;
    u_xlat4 = (u_xlatb33.x) ? u_xlat4 : u_xlat1;
    u_xlat1 = (bool(u_xlatb45)) ? u_xlat4 : u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb48 = !!(u_xlat0.x<0.800000012);
#else
    u_xlatb48 = u_xlat0.x<0.800000012;
#endif
    if(u_xlatb48){
        u_xlat4.xy = (u_xlatb30.x) ? _Diffuse1_ST.xy : vec2(1.0, 1.0);
        u_xlat33.xy = (u_xlatb33.x) ? _Diffuse2_ST.xy : u_xlat3.xy;
        u_xlat30.xy = (bool(u_xlatb45)) ? u_xlat33.xy : u_xlat3.xy;
        u_xlat3.zw = vec2(vs_TEXCOORD2.z + (-_DetailDiffuse_ST.z), vs_TEXCOORD2.w + (-_DetailDiffuse_ST.w));
        u_xlat4.xy = u_xlat2.xy * u_xlat4.xy;
        u_xlat34.xy = vec2(_DetailDiffuse_ST.x * _DetailDiffuse_TexelSize.z, _DetailDiffuse_ST.y * _DetailDiffuse_TexelSize.w);
        u_xlatb4.xy = lessThan(u_xlat4.xyxx, u_xlat34.xyxx).xy;
        u_xlatb4.x = u_xlatb4.y || u_xlatb4.x;
        u_xlat3.xy = _DetailDiffuse_TexelSize.zw;
        u_xlat2 = (u_xlatb4.x) ? u_xlat3 : u_xlat2;
        u_xlat30.xy = u_xlat30.xy * u_xlat1.xy;
        u_xlat4.xy = vec2(_DetailDiffuse_ST.x * _DetailNormal_TexelSize.z, _DetailDiffuse_ST.y * _DetailNormal_TexelSize.w);
        u_xlatb30.xy = lessThan(u_xlat30.xyxy, u_xlat4.xyxy).xy;
        u_xlatb30.x = u_xlatb30.y || u_xlatb30.x;
        u_xlat3.xy = _DetailNormal_TexelSize.zw;
        u_xlat1 = (u_xlatb30.x) ? u_xlat3 : u_xlat1;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30.x = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb30.x = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb30.x){
        u_xlatb3.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat4 = (u_xlatb3.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat4 = (u_xlatb3.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat4;
        u_xlat3 = (u_xlatb3.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat4;
        SV_Target0 = u_xlat3;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30.x = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb30.x = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb30.x){
        u_xlat10_3.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.xy).xyz;
        SV_Target0.xyz = u_xlat10_3.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30.x = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb30.x = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb30.x){
        u_xlat30.x = max(_GrassDiffuse_TexelSize.w, _GrassDiffuse_TexelSize.z);
        u_xlat30.x = max(u_xlat30.x, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb45 = !!(256.0<u_xlat30.x);
#else
        u_xlatb45 = 256.0<u_xlat30.x;
#endif
        u_xlatb3.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), u_xlat30.xxxx).xy;
        u_xlat4 = (u_xlatb3.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat3 = (u_xlatb3.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat4;
        u_xlat3 = (bool(u_xlatb45)) ? u_xlat3 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat3;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30.x = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb30.x = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb30.x){
        u_xlat30.xy = vec2(vs_TEXCOORD0.x * _GrassDiffuse_TexelSize.z, vs_TEXCOORD0.y * _GrassDiffuse_TexelSize.w);
        u_xlat3.xy = dFdx(u_xlat30.xy);
        u_xlat30.xy = dFdy(u_xlat30.xy);
        u_xlat3.x = dot(u_xlat3.xy, u_xlat3.xy);
        u_xlat30.x = dot(u_xlat30.xy, u_xlat30.xy);
        u_xlat30.x = max(u_xlat30.x, u_xlat3.x);
        u_xlat30.x = log2(u_xlat30.x);
        u_xlat30.x = u_xlat30.x * 0.5;
        u_xlat30.x = max(u_xlat30.x, 0.0);
        u_xlat30.x = u_xlat30.x + 1.0;
        u_xlat45 = max(_GrassDiffuse_TexelSize.w, _GrassDiffuse_TexelSize.z);
        u_xlat30.x = u_xlat45 / u_xlat30.x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb45 = !!(256.0<u_xlat30.x);
#else
        u_xlatb45 = 256.0<u_xlat30.x;
#endif
        u_xlatb3.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), u_xlat30.xxxx).xy;
        u_xlat4 = (u_xlatb3.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat3 = (u_xlatb3.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat4;
        u_xlat3 = (bool(u_xlatb45)) ? u_xlat3 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat3;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30.x = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb30.x = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb30.x){
        u_xlat3.zw = vec2(vs_TEXCOORD0.x + (-_GrassDiffuse_ST.z), vs_TEXCOORD0.y + (-_GrassDiffuse_ST.w));
        u_xlat30.xy = vec2(_GrassDiffuse_ST.x * _GrassDiffuse_TexelSize.z, _GrassDiffuse_ST.y * _GrassDiffuse_TexelSize.w);
        u_xlatb30.xy = lessThan(vec4(1.0, 1.0, 1.0, 1.0), u_xlat30.xyxy).xy;
        u_xlatb30.x = u_xlatb30.y || u_xlatb30.x;
        u_xlat3.xy = _GrassDiffuse_TexelSize.zw;
        u_xlat4 = (u_xlatb30.x) ? u_xlat3 : vec4(1.0, 1.0, 0.0, 0.0);
        u_xlat2 = u_xlat2 + (-u_xlat4);
        u_xlat2 = vs_COLOR0.wwww * u_xlat2 + u_xlat4;
#ifdef UNITY_ADRENO_ES3
        u_xlatb30.x = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb30.x = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb30.x){
            u_xlat30.xy = vec2(u_xlat2.x * u_xlat2.z, u_xlat2.y * u_xlat2.w);
            u_xlat4.xy = dFdx(u_xlat30.xy);
            u_xlat30.xy = dFdy(u_xlat30.xy);
            u_xlat34.x = dot(u_xlat4.xy, u_xlat4.xy);
            u_xlat49 = dot(u_xlat30.xy, u_xlat30.xy);
            u_xlat34.x = max(u_xlat49, u_xlat34.x);
            u_xlat34.x = log2(u_xlat34.x);
            u_xlat34.x = u_xlat34.x * 0.5;
            u_xlat34.x = max(u_xlat34.x, 0.0);
            u_xlat34.x = u_xlat34.x + 1.0;
            u_xlat49 = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat4.xy = vec2(u_xlat49) * u_xlat4.xy;
            u_xlat30.xy = u_xlat30.xy * vec2(u_xlat49);
            u_xlat4.xy = u_xlat4.xy / u_xlat34.xx;
            u_xlat30.xy = u_xlat30.xy / u_xlat34.xx;
            u_xlat19.x = dot(abs(u_xlat4.xy), abs(u_xlat4.xy));
            u_xlat45 = dot(abs(u_xlat30.xy), abs(u_xlat30.xy));
            u_xlat34.x = sqrt(u_xlat19.x);
            u_xlat49 = sqrt(u_xlat45);
            u_xlat19.x = inversesqrt(u_xlat19.x);
            u_xlat4.x = u_xlat19.x * abs(u_xlat4.x);
            u_xlat45 = inversesqrt(u_xlat45);
            u_xlat30.x = u_xlat45 * abs(u_xlat30.x);
            u_xlat30.x = u_xlat30.x * u_xlat4.x;
            u_xlat30.x = (-u_xlat30.x) * u_xlat30.x + 1.0;
            u_xlat30.x = sqrt(u_xlat30.x);
            u_xlat45 = u_xlat49 * u_xlat34.x;
            u_xlat4.x = u_xlat30.x * u_xlat45;
            u_xlat19.xy = vec2(u_xlat2.z * float(3.0), u_xlat2.w * float(3.0));
            u_xlat49 = fract((-u_xlat19.x));
            u_xlat19.z = u_xlat49 + 0.5;
            u_xlat19.xy = fract(u_xlat19.xy);
            u_xlat19.xy = u_xlat19.xy + vec2(0.5, 0.5);
            u_xlat19.xyz = floor(u_xlat19.xyz);
            u_xlat49 = (-u_xlat19.x) + u_xlat19.z;
            u_xlat19.x = u_xlat49 * u_xlat19.y + u_xlat19.x;
            u_xlat34.x = (-u_xlat45) * u_xlat30.x + 1.0;
            u_xlat5.xyz = (-u_xlat19.xxx) + vec3(0.5, 0.0, 1.0);
            u_xlat6.xyz = u_xlat34.xxx * u_xlat5.xyz + u_xlat19.xxx;
            u_xlatb4.xz = lessThan(u_xlat4.xxxx, vec4(1.0, 0.0, 2.0, 0.0)).xz;
            u_xlat7.xyz = u_xlat19.xxx * vec3(0.0, 1.0, 0.0);
            u_xlat30.x = u_xlat45 * u_xlat30.x + -4.0;
            u_xlat30.x = exp2(u_xlat30.x);
            u_xlat30.x = u_xlat30.x + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat30.x = min(max(u_xlat30.x, 0.0), 1.0);
#else
            u_xlat30.x = clamp(u_xlat30.x, 0.0, 1.0);
#endif
            u_xlat5.xyz = u_xlat30.xxx * u_xlat5.zyy + u_xlat19.xxx;
            u_xlat19.xyz = (u_xlatb4.z) ? u_xlat7.xyz : u_xlat5.xyz;
            u_xlat4.xyz = (u_xlatb4.x) ? u_xlat6.xyz : u_xlat19.xyz;
        } else {
            u_xlat30.xy = vec2(_GrassDiffuse_ST.x * _GrassNormal_TexelSize.z, _GrassDiffuse_ST.y * _GrassNormal_TexelSize.w);
            u_xlatb30.xy = lessThan(vec4(1.0, 1.0, 1.0, 1.0), u_xlat30.xyxy).xy;
            u_xlatb30.x = u_xlatb30.y || u_xlatb30.x;
            u_xlat3.xy = _GrassNormal_TexelSize.zw;
            u_xlat3 = (u_xlatb30.x) ? u_xlat3 : vec4(1.0, 1.0, 0.0, 0.0);
            u_xlat1 = u_xlat1 + (-u_xlat3);
            u_xlat1 = vs_COLOR0.wwww * u_xlat1 + u_xlat3;
#ifdef UNITY_ADRENO_ES3
            u_xlatb30.x = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb30.x = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb30.x){
                u_xlat30.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                u_xlat3.xy = dFdx(u_xlat30.xy);
                u_xlat30.xy = dFdy(u_xlat30.xy);
                u_xlat33.x = dot(u_xlat3.xy, u_xlat3.xy);
                u_xlat48 = dot(u_xlat30.xy, u_xlat30.xy);
                u_xlat33.x = max(u_xlat48, u_xlat33.x);
                u_xlat33.x = log2(u_xlat33.x);
                u_xlat33.x = u_xlat33.x * 0.5;
                u_xlat33.x = max(u_xlat33.x, 0.0);
                u_xlat33.x = u_xlat33.x + 1.0;
                u_xlat48 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                u_xlat3.xy = vec2(u_xlat48) * u_xlat3.xy;
                u_xlat30.xy = u_xlat30.xy * vec2(u_xlat48);
                u_xlat3.xy = u_xlat3.xy / u_xlat33.xx;
                u_xlat30.xy = u_xlat30.xy / u_xlat33.xx;
                u_xlat18.x = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                u_xlat45 = dot(abs(u_xlat30.xy), abs(u_xlat30.xy));
                u_xlat33.x = sqrt(u_xlat18.x);
                u_xlat48 = sqrt(u_xlat45);
                u_xlat18.x = inversesqrt(u_xlat18.x);
                u_xlat3.x = u_xlat18.x * abs(u_xlat3.x);
                u_xlat45 = inversesqrt(u_xlat45);
                u_xlat30.x = u_xlat45 * abs(u_xlat30.x);
                u_xlat30.x = u_xlat30.x * u_xlat3.x;
                u_xlat30.x = (-u_xlat30.x) * u_xlat30.x + 1.0;
                u_xlat30.x = sqrt(u_xlat30.x);
                u_xlat45 = u_xlat48 * u_xlat33.x;
                u_xlat3.x = u_xlat30.x * u_xlat45;
                u_xlat18.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                u_xlat48 = fract((-u_xlat18.x));
                u_xlat18.z = u_xlat48 + 0.5;
                u_xlat18.xy = fract(u_xlat18.xy);
                u_xlat18.xy = u_xlat18.xy + vec2(0.5, 0.5);
                u_xlat18.xyz = floor(u_xlat18.xyz);
                u_xlat48 = (-u_xlat18.x) + u_xlat18.z;
                u_xlat18.x = u_xlat48 * u_xlat18.y + u_xlat18.x;
                u_xlat33.x = (-u_xlat45) * u_xlat30.x + 1.0;
                u_xlat5.xyz = (-u_xlat18.xxx) + vec3(0.5, 0.0, 1.0);
                u_xlat6.xyz = u_xlat33.xxx * u_xlat5.xyz + u_xlat18.xxx;
                u_xlatb3.xz = lessThan(u_xlat3.xxxx, vec4(1.0, 0.0, 2.0, 0.0)).xz;
                u_xlat7.xyz = u_xlat18.xxx * vec3(0.0, 1.0, 0.0);
                u_xlat30.x = u_xlat45 * u_xlat30.x + -4.0;
                u_xlat30.x = exp2(u_xlat30.x);
                u_xlat30.x = u_xlat30.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                u_xlat30.x = min(max(u_xlat30.x, 0.0), 1.0);
#else
                u_xlat30.x = clamp(u_xlat30.x, 0.0, 1.0);
#endif
                u_xlat5.xyz = u_xlat30.xxx * u_xlat5.zyy + u_xlat18.xxx;
                u_xlat18.xyz = (u_xlatb3.z) ? u_xlat7.xyz : u_xlat5.xyz;
                u_xlat4.xyz = (u_xlatb3.x) ? u_xlat6.xyz : u_xlat18.xyz;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb30.x = !!(u_xlat2.x>=u_xlat1.x);
#else
                u_xlatb30.x = u_xlat2.x>=u_xlat1.x;
#endif
                if(u_xlatb30.x){
                    u_xlat30.xy = vec2(u_xlat2.x * u_xlat2.z, u_xlat2.y * u_xlat2.w);
                    u_xlat2.xy = dFdx(u_xlat30.xy);
                    u_xlat30.xy = dFdy(u_xlat30.xy);
                    u_xlat3.x = dot(u_xlat2.xy, u_xlat2.xy);
                    u_xlat18.x = dot(u_xlat30.xy, u_xlat30.xy);
                    u_xlat3.x = max(u_xlat18.x, u_xlat3.x);
                    u_xlat3.x = log2(u_xlat3.x);
                    u_xlat3.x = u_xlat3.x * 0.5;
                    u_xlat3.x = max(u_xlat3.x, 0.0);
                    u_xlat3.x = u_xlat3.x + 1.0;
                    u_xlat18.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat2.xy = u_xlat2.xy * u_xlat18.xx;
                    u_xlat30.xy = u_xlat30.xy * u_xlat18.xx;
                    u_xlat2.xy = u_xlat2.xy / u_xlat3.xx;
                    u_xlat30.xy = u_xlat30.xy / u_xlat3.xx;
                    u_xlat17.x = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
                    u_xlat45 = dot(abs(u_xlat30.xy), abs(u_xlat30.xy));
                    u_xlat3.x = sqrt(u_xlat17.x);
                    u_xlat18.x = sqrt(u_xlat45);
                    u_xlat17.x = inversesqrt(u_xlat17.x);
                    u_xlat2.x = u_xlat17.x * abs(u_xlat2.x);
                    u_xlat45 = inversesqrt(u_xlat45);
                    u_xlat30.x = u_xlat45 * abs(u_xlat30.x);
                    u_xlat30.x = u_xlat30.x * u_xlat2.x;
                    u_xlat30.x = (-u_xlat30.x) * u_xlat30.x + 1.0;
                    u_xlat30.x = sqrt(u_xlat30.x);
                    u_xlat45 = u_xlat18.x * u_xlat3.x;
                    u_xlat2.x = u_xlat30.x * u_xlat45;
                    u_xlat17.xy = vec2(u_xlat2.z * float(3.0), u_xlat2.w * float(3.0));
                    u_xlat47 = fract((-u_xlat17.x));
                    u_xlat17.z = u_xlat47 + 0.5;
                    u_xlat17.xy = fract(u_xlat17.xy);
                    u_xlat17.xy = u_xlat17.xy + vec2(0.5, 0.5);
                    u_xlat17.xyz = floor(u_xlat17.xyz);
                    u_xlat47 = (-u_xlat17.x) + u_xlat17.z;
                    u_xlat17.x = u_xlat47 * u_xlat17.y + u_xlat17.x;
                    u_xlat32 = (-u_xlat45) * u_xlat30.x + 1.0;
                    u_xlat3.xyz = (-u_xlat17.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat5.xyz = vec3(u_xlat32) * u_xlat3.xyz + u_xlat17.xxx;
                    u_xlatb2.xz = lessThan(u_xlat2.xxxx, vec4(1.0, 0.0, 2.0, 0.0)).xz;
                    u_xlat6.xyz = u_xlat17.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat30.x = u_xlat45 * u_xlat30.x + -4.0;
                    u_xlat30.x = exp2(u_xlat30.x);
                    u_xlat30.x = u_xlat30.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat30.x = min(max(u_xlat30.x, 0.0), 1.0);
#else
                    u_xlat30.x = clamp(u_xlat30.x, 0.0, 1.0);
#endif
                    u_xlat3.xyz = u_xlat30.xxx * u_xlat3.zyy + u_xlat17.xxx;
                    u_xlat17.xyz = (u_xlatb2.z) ? u_xlat6.xyz : u_xlat3.xyz;
                    u_xlat4.xyz = (u_xlatb2.x) ? u_xlat5.xyz : u_xlat17.xyz;
                } else {
                    u_xlat30.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat1.xy = dFdx(u_xlat30.xy);
                    u_xlat30.xy = dFdy(u_xlat30.xy);
                    u_xlat2.x = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat17.x = dot(u_xlat30.xy, u_xlat30.xy);
                    u_xlat2.x = max(u_xlat17.x, u_xlat2.x);
                    u_xlat2.x = log2(u_xlat2.x);
                    u_xlat2.x = u_xlat2.x * 0.5;
                    u_xlat2.x = max(u_xlat2.x, 0.0);
                    u_xlat2.x = u_xlat2.x + 1.0;
                    u_xlat17.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat1.xy = u_xlat1.xy * u_xlat17.xx;
                    u_xlat30.xy = u_xlat30.xy * u_xlat17.xx;
                    u_xlat1.xy = u_xlat1.xy / u_xlat2.xx;
                    u_xlat30.xy = u_xlat30.xy / u_xlat2.xx;
                    u_xlat16.x = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat45 = dot(abs(u_xlat30.xy), abs(u_xlat30.xy));
                    u_xlat2.x = sqrt(u_xlat16.x);
                    u_xlat17.x = sqrt(u_xlat45);
                    u_xlat16.x = inversesqrt(u_xlat16.x);
                    u_xlat1.x = u_xlat16.x * abs(u_xlat1.x);
                    u_xlat45 = inversesqrt(u_xlat45);
                    u_xlat30.x = u_xlat45 * abs(u_xlat30.x);
                    u_xlat30.x = u_xlat30.x * u_xlat1.x;
                    u_xlat30.x = (-u_xlat30.x) * u_xlat30.x + 1.0;
                    u_xlat30.x = sqrt(u_xlat30.x);
                    u_xlat45 = u_xlat17.x * u_xlat2.x;
                    u_xlat1.x = u_xlat30.x * u_xlat45;
                    u_xlat16.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat46 = fract((-u_xlat16.x));
                    u_xlat16.z = u_xlat46 + 0.5;
                    u_xlat16.xy = fract(u_xlat16.xy);
                    u_xlat16.xy = u_xlat16.xy + vec2(0.5, 0.5);
                    u_xlat16.xyz = floor(u_xlat16.xyz);
                    u_xlat46 = (-u_xlat16.x) + u_xlat16.z;
                    u_xlat16.x = u_xlat46 * u_xlat16.y + u_xlat16.x;
                    u_xlat31 = (-u_xlat45) * u_xlat30.x + 1.0;
                    u_xlat2.xyz = (-u_xlat16.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat3.xyz = vec3(u_xlat31) * u_xlat2.xyz + u_xlat16.xxx;
                    u_xlatb1.xz = lessThan(u_xlat1.xxxx, vec4(1.0, 0.0, 2.0, 0.0)).xz;
                    u_xlat5.xyz = u_xlat16.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat30.x = u_xlat45 * u_xlat30.x + -4.0;
                    u_xlat30.x = exp2(u_xlat30.x);
                    u_xlat30.x = u_xlat30.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat30.x = min(max(u_xlat30.x, 0.0), 1.0);
#else
                    u_xlat30.x = clamp(u_xlat30.x, 0.0, 1.0);
#endif
                    u_xlat2.xyz = u_xlat30.xxx * u_xlat2.zyy + u_xlat16.xxx;
                    u_xlat16.xyz = (u_xlatb1.z) ? u_xlat5.xyz : u_xlat2.xyz;
                    u_xlat4.xyz = (u_xlatb1.x) ? u_xlat3.xyz : u_xlat16.xyz;
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat4.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb30.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 100.0, 102.0)).xy;
    u_xlatb30.x = u_xlatb30.y || u_xlatb30.x;
    if(u_xlatb30.x){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb30.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 101.0, 103.0)).xy;
    u_xlatb30.x = u_xlatb30.y || u_xlatb30.x;
    if(u_xlatb30.x){
        SV_Target0 = vec4(0.400000006, 0.400000006, 0.400000006, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30.x = !!(vs_COLOR0.w<0.99000001);
#else
    u_xlatb30.x = vs_COLOR0.w<0.99000001;
#endif
    if(u_xlatb30.x){
        u_xlat10_1 = texture(_GrassNormal, vs_TEXCOORD0.xy, -1.0);
        u_xlat16_8.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_53 = u_xlat10_1.w * _UseGrassSpecular;
        u_xlat10_1.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.xy, -1.0).xyz;
        u_xlat16_9.xyz = u_xlat10_1.xyz;
    } else {
        u_xlat16_9.x = float(0.0);
        u_xlat16_9.y = float(0.0);
        u_xlat16_9.z = float(0.0);
        u_xlat16_8.x = float(0.0);
        u_xlat16_8.y = float(0.0);
        u_xlat16_8.z = float(1.0);
        u_xlat16_53 = float(0.0);
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30.x = !!(0.00999999978<vs_COLOR0.w);
#else
    u_xlatb30.x = 0.00999999978<vs_COLOR0.w;
#endif
    if(u_xlatb30.x){
        u_xlat10_1.xyz = texture(_Normal0, vs_TEXCOORD0.zw, -1.0).xyw;
        u_xlat10_2.xyz = texture(_Normal2, vs_TEXCOORD2.xy, -1.0).xyw;
        u_xlat16_10.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_40.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_54 = (-u_xlat0.y) + 1.0;
        u_xlat16_40.xy = vec2(u_xlat16_54) * u_xlat16_40.xy;
        u_xlat10_3 = texture(_Diffuse1, vs_TEXCOORD0.zw, -1.0);
        u_xlat30.xy = vec2(vs_TEXCOORD2.z * float(_DetailNormalUVScale), vs_TEXCOORD2.w * float(_DetailNormalUVScale));
        u_xlat10_1.xyw = texture(_DetailNormal, u_xlat30.xy, -1.0).xyw;
        u_xlat16_11.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_54 = (-u_xlat0.x) + 1.0;
        u_xlat16_11.xy = vec2(u_xlat16_54) * u_xlat16_11.xy;
        u_xlat10_4 = texture(_Diffuse2, vs_TEXCOORD2.xy, -1.0);
        u_xlat10_5 = texture(_DetailDiffuse, vs_TEXCOORD2.zw, -1.0);
        u_xlat16_54 = u_xlat10_4.w * _UseDiffuseTwoHeight;
        u_xlat16_41 = u_xlat10_5.w * _UseDetailDiffuseHeight;
        u_xlat16_12.xyz = u_xlat10_3.xyz + (-u_xlat10_4.xyz);
        u_xlat16_56 = u_xlat10_3.w * _UseDiffuseOneHeight + (-u_xlat16_54);
        u_xlat16_12.xyz = u_xlat0.yyy * u_xlat16_12.xyz + u_xlat10_4.xyz;
        u_xlat16_54 = u_xlat0.y * u_xlat16_56 + u_xlat16_54;
        u_xlat16_56 = u_xlat0.x * _DetailBlendVal;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_56 = min(max(u_xlat16_56, 0.0), 1.0);
#else
        u_xlat16_56 = clamp(u_xlat16_56, 0.0, 1.0);
#endif
        u_xlat16_57 = (-u_xlat16_56) + 1.0;
        u_xlat16_41 = u_xlat16_41 * u_xlat16_57;
        u_xlat16_54 = max(u_xlat16_54, u_xlat16_41);
        u_xlat16_13.xyz = u_xlat10_5.xyz * u_xlat16_12.xyz;
        u_xlat16_14.xyz = u_xlat16_13.xyz * vec3(4.0, 4.0, 4.0);
        u_xlat16_12.xyz = (-u_xlat16_13.xyz) * vec3(4.0, 4.0, 4.0) + u_xlat16_12.xyz;
        u_xlat16_12.xyz = vec3(u_xlat16_56) * u_xlat16_12.xyz + u_xlat16_14.xyz;
        u_xlat16_12.xyz = min(u_xlat16_12.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_41 = u_xlat10_2.z * _UseSpecularTwo;
        u_xlat16_56 = u_xlat10_1.w * _UseDetailSpecular;
        u_xlat16_13.x = _UseSpecularOne * u_xlat10_1.z + (-u_xlat16_41);
        u_xlat16_41 = u_xlat0.y * u_xlat16_13.x + u_xlat16_41;
        u_xlat16_56 = u_xlat16_57 * u_xlat16_56;
        u_xlat16_41 = max(u_xlat16_56, u_xlat16_41);
        u_xlat16_10.xy = u_xlat16_40.xy * vs_COLOR0.xx + u_xlat16_10.xy;
        u_xlat16_10.xy = u_xlat16_11.xy * vs_COLOR0.xx + u_xlat16_10.xy;
    } else {
        u_xlat16_12.x = float(0.0);
        u_xlat16_12.y = float(0.0);
        u_xlat16_12.z = float(0.0);
        u_xlat16_10.x = float(0.0);
        u_xlat16_10.y = float(0.0);
        u_xlat16_54 = 1.0;
        u_xlat16_41 = 0.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor);
#endif
    u_xlat16_11.xyw = u_xlat16_12.xyz * _TintColor.xyz;
    u_xlat16_11.xyw = (bool(u_xlatb0)) ? u_xlat16_11.xyw : u_xlat16_12.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend);
#endif
    u_xlat16_15 = u_xlat16_54;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_30 = vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_54 = _HeightContrast * 10.0;
    u_xlat16_15 = u_xlat16_15 + -1.0;
    u_xlat16_55 = _HeightSpread + 0.100000001;
    u_xlat16_30 = log2(u_xlat16_30);
    u_xlat16_30 = u_xlat16_30 * u_xlat16_55;
    u_xlat16_30 = exp2(u_xlat16_30);
    u_xlat16_15 = u_xlat16_30 * 2.0 + u_xlat16_15;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_30 = _HeightContrast * 10.0 + 1.0;
    u_xlat16_30 = _HeightContrast * 10.0 + u_xlat16_30;
    u_xlat15 = u_xlat16_15 * u_xlat16_30 + (-u_xlat16_54);
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_54 = (u_xlatb0) ? u_xlat15 : vs_COLOR0.w;
    u_xlat16_10.z = 1.0;
    u_xlat16_10.xyz = (-u_xlat16_8.xyz) + u_xlat16_10.xyz;
    u_xlat16_8.xyz = vec3(u_xlat16_54) * u_xlat16_10.xyz + u_xlat16_8.xyz;
    u_xlat16_10.x = (-u_xlat16_53) + u_xlat16_41;
    u_xlat16_53 = u_xlat16_54 * u_xlat16_10.x + u_xlat16_53;
    u_xlat16_10.xyz = (-u_xlat16_9.xyz) + u_xlat16_11.xyw;
    u_xlat16_9.xyz = vec3(u_xlat16_54) * u_xlat16_10.xyz + u_xlat16_9.xyz;
    u_xlat16_53 = u_xlat16_53 + _Shininess;
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, u_xlat16_8.xyz);
    u_xlat0.y = dot(vs_TEXCOORD4.xyz, u_xlat16_8.xyz);
    u_xlat0.z = dot(vs_TEXCOORD5.xyz, u_xlat16_8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb45 = !!(vs_TEXCOORD1.w<100.0);
#else
    u_xlatb45 = vs_TEXCOORD1.w<100.0;
#endif
    if(u_xlatb45){
        u_xlat1.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
        u_xlat45 = texture(_CameraDepthBlendTexture, u_xlat1.xy).x;
        u_xlat45 = _ZBufferParams.z * u_xlat45 + _ZBufferParams.w;
        u_xlat45 = float(1.0) / u_xlat45;
        u_xlat45 = u_xlat45 + (-vs_TEXCOORD1.w);
        u_xlat45 = abs(u_xlat45) * _DepthBiasScaled;
        u_xlat45 = u_xlat45 * 0.600000024;
#ifdef UNITY_ADRENO_ES3
        u_xlat45 = min(max(u_xlat45, 0.0), 1.0);
#else
        u_xlat45 = clamp(u_xlat45, 0.0, 1.0);
#endif
        u_xlat45 = sqrt(u_xlat45);
        u_xlat10_2.xyz = texture(_CameraDepthBlendNormTexture, u_xlat1.xy).xyz;
        u_xlat16_8.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat10_1.xyz = texture(_CameraDepthBlendDiffTexture, u_xlat1.xy).xyz;
        u_xlat16_54 = u_xlat0.y * _DepthBlendAO;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_54 = min(max(u_xlat16_54, 0.0), 1.0);
#else
        u_xlat16_54 = clamp(u_xlat16_54, 0.0, 1.0);
#endif
        u_xlat46 = (-u_xlat45) + 1.0;
        u_xlat46 = u_xlat16_54 * u_xlat46 + u_xlat45;
        u_xlat46 = max(u_xlat46, 0.899999976);
        u_xlat2.xyz = u_xlat16_9.xyz * vec3(u_xlat46) + (-u_xlat10_1.xyz);
        u_xlat9.xyz = vec3(u_xlat45) * u_xlat2.xyz + u_xlat10_1.xyz;
        u_xlat1.xyz = u_xlat0.xyz + (-u_xlat16_8.xyz);
        u_xlat1.xyz = vec3(u_xlat45) * u_xlat1.xyz + u_xlat16_8.xyz;
        u_xlat16_9.xyz = u_xlat9.xyz;
        u_xlat16_1.xyz = u_xlat1.xyz;
    } else {
        u_xlat16_1.xyz = u_xlat0.xyz;
    //ENDIF
    }
    u_xlat16_8.x = u_xlat16_53 * _Terrain_Smoothness;
    u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
    SV_Target2.w = min(u_xlat16_8.x, 0.5);
    u_xlat16_8.xyz = u_xlat16_9.xyz * vec3(vec3(_Terrain_Specular, _Terrain_Specular, _Terrain_Specular));
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat16_53 = max(u_xlat16_8.z, u_xlat16_8.y);
    u_xlat16_53 = max(u_xlat16_53, u_xlat16_8.x);
    u_xlat16_53 = (-u_xlat16_53) + 1.0;
    SV_Target1.xyz = vec3(u_xlat16_53) * u_xlat16_9.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_53 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_53 : u_xlat16_8.z;
    SV_Target0.w = 0.0;
    SV_Target1.w = _SSAO_Intensity;
    SV_Target2.xy = u_xlat16_8.xy;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MSAA_INTERPOLATION" "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _Diffuse1_ST;
uniform 	float _UVDiffuse2;
uniform 	vec4 _Diffuse2_ST;
uniform 	float _UVDetail;
uniform 	vec4 _DetailDiffuse_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat7;
float u_xlat16;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x;
    u_xlat2.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].x;
    u_xlat2.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].x;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].y;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].y;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].y;
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.xy = sqrt(u_xlat2.xy);
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].z;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].z;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].z;
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat2.x = u_xlat7.x + u_xlat2.x;
    u_xlat2.x = u_xlat2.x * 0.330000013;
    u_xlat7.xy = u_xlat2.xx * in_TEXCOORD0.xy;
    u_xlat2.xw = u_xlat2.xx * in_TEXCOORD1.xy;
    vs_TEXCOORD0.xy = u_xlat7.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Diffuse1_ST.xy + _Diffuse1_ST.zw;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UVDiffuse2==0.0);
#else
    u_xlatb1 = _UVDiffuse2==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb1)) ? u_xlat7.xy : u_xlat2.xw;
    vs_TEXCOORD2.xy = u_xlat1.xy * _Diffuse2_ST.xy + _Diffuse2_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UVDetail==0.0);
#else
    u_xlatb1 = _UVDetail==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb1)) ? u_xlat7.xy : u_xlat2.xw;
    vs_TEXCOORD2.zw = u_xlat1.xy * _DetailDiffuse_ST.xy + _DetailDiffuse_ST.zw;
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat2.xyz = vec3(u_xlat0) * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_4.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = vec3(u_xlat0) * u_xlat16_4.xyz;
    vs_TEXCOORD3.y = u_xlat16_4.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD3.w = u_xlat5.x;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat5.y;
    vs_TEXCOORD5.w = u_xlat5.z;
    vs_TEXCOORD4.y = u_xlat16_4.y;
    vs_TEXCOORD5.y = u_xlat16_4.z;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	mediump float _HeightSpread;
uniform 	mediump float _HeightContrast;
uniform 	mediump float _UseTintColor;
uniform 	mediump float _UseDiffuseOneHeight;
uniform 	mediump float _UseDiffuseTwoHeight;
uniform 	mediump float _UseDetailDiffuseHeight;
uniform 	mediump float _UseGrassHeightBlend;
uniform 	mediump float _UseGrassSpecular;
uniform 	mediump float _UseSpecularOne;
uniform 	mediump float _UseSpecularTwo;
uniform 	mediump float _UseDetailSpecular;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _SSAO_Intensity;
uniform 	mediump float _Terrain_Smoothness;
uniform 	mediump float _Terrain_Specular;
uniform 	mediump float _Shininess;
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _GrassDiffuse_TexelSize;
uniform 	vec4 _GrassNormal_TexelSize;
uniform 	float _GrassNormalScale;
uniform 	vec4 _Diffuse1_ST;
uniform 	vec4 _Diffuse1_TexelSize;
uniform 	vec4 _Normal0_TexelSize;
uniform 	float _Normal0Scale;
uniform 	vec4 _Diffuse2_ST;
uniform 	vec4 _Normal2_TexelSize;
uniform 	mediump float _Normal2Scale;
uniform 	mediump float _Diffuse2Distance;
uniform 	mediump float _Diffuse2Fade;
uniform 	vec4 _DetailDiffuse_ST;
uniform 	vec4 _DetailDiffuse_TexelSize;
uniform 	vec4 _DetailNormal_TexelSize;
uniform 	mediump float _DetailNormalScale;
uniform 	mediump float _DetailNormalUVScale;
uniform 	mediump float _DetailBlendVal;
uniform 	mediump float _DetailDistance;
uniform 	mediump float _DetailFade;
uniform 	mediump float _DepthBiasScaled;
uniform 	mediump float _DepthBlendAO;
uniform lowp sampler2D _GrassDiffuse;
uniform lowp sampler2D _GrassNormal;
uniform lowp sampler2D _Normal0;
uniform lowp sampler2D _Normal2;
uniform lowp sampler2D _Diffuse1;
uniform lowp sampler2D _DetailNormal;
uniform lowp sampler2D _Diffuse2;
uniform lowp sampler2D _DetailDiffuse;
uniform highp sampler2D _CameraDepthBlendTexture;
uniform lowp sampler2D _CameraDepthBlendNormTexture;
uniform lowp sampler2D _CameraDepthBlendDiffTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec3 u_xlatb1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
bvec3 u_xlatb2;
vec4 u_xlat3;
lowp vec4 u_xlat10_3;
bvec3 u_xlatb3;
vec4 u_xlat4;
lowp vec4 u_xlat10_4;
bvec3 u_xlatb4;
vec3 u_xlat5;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec4 u_xlat16_11;
mediump vec3 u_xlat16_12;
mediump vec3 u_xlat16_13;
mediump vec3 u_xlat16_14;
float u_xlat15;
mediump float u_xlat16_15;
vec3 u_xlat16;
vec3 u_xlat17;
vec3 u_xlat18;
vec3 u_xlat19;
vec2 u_xlat30;
mediump float u_xlat16_30;
bvec2 u_xlatb30;
float u_xlat31;
float u_xlat32;
vec2 u_xlat33;
bvec2 u_xlatb33;
vec2 u_xlat34;
mediump vec2 u_xlat16_40;
mediump float u_xlat16_41;
float u_xlat45;
bool u_xlatb45;
float u_xlat46;
float u_xlat47;
float u_xlat48;
bool u_xlatb48;
float u_xlat49;
mediump float u_xlat16_53;
mediump float u_xlat16_54;
mediump float u_xlat16_55;
mediump float u_xlat16_56;
mediump float u_xlat16_57;
void main()
{
    u_xlat0.x = vs_TEXCOORD3.w;
    u_xlat0.y = vs_TEXCOORD4.w;
    u_xlat0.z = vs_TEXCOORD5.w;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x / _Diffuse2Distance;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat15 + 9.99999975e-05;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Diffuse2Fade;
    u_xlat0.y = exp2(u_xlat15);
    u_xlat0.x = u_xlat0.x / _DetailDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + 9.99999975e-05;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _DetailFade;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.xy = min(u_xlat0.xy, vec2(1.0, 1.0));
    u_xlat1.zw = vec2(vs_TEXCOORD0.z + (-_Diffuse1_ST.z), vs_TEXCOORD0.w + (-_Diffuse1_ST.w));
    u_xlat30.xy = vec2(_Diffuse1_ST.x * _Diffuse1_TexelSize.z, _Diffuse1_ST.y * _Diffuse1_TexelSize.w);
    u_xlatb30.xy = lessThan(vec4(1.0, 1.0, 1.0, 1.0), u_xlat30.xyxy).xy;
    u_xlatb30.x = u_xlatb30.y || u_xlatb30.x;
    u_xlat1.xy = _Diffuse1_TexelSize.zw;
    u_xlat2 = (u_xlatb30.x) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
    u_xlat3.xy = vec2(_Diffuse1_ST.x * _Normal0_TexelSize.z, _Diffuse1_ST.y * _Normal0_TexelSize.w);
    u_xlatb3.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat3.xyxx).xy;
    u_xlatb45 = u_xlatb3.y || u_xlatb3.x;
    u_xlat1.xy = _Normal0_TexelSize.zw;
    u_xlat1 = (bool(u_xlatb45)) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
    u_xlat3.xy = (bool(u_xlatb45)) ? _Diffuse1_ST.xy : vec2(1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb45 = !!(u_xlat0.y<0.800000012);
#else
    u_xlatb45 = u_xlat0.y<0.800000012;
#endif
    u_xlat4.zw = vec2(vs_TEXCOORD2.x + (-_Diffuse2_ST.z), vs_TEXCOORD2.y + (-_Diffuse2_ST.w));
    u_xlat33.xy = u_xlat1.xy * u_xlat3.xy;
    u_xlat5.xy = vec2(_Diffuse2_ST.x * _Normal2_TexelSize.z, _Diffuse2_ST.y * _Normal2_TexelSize.w);
    u_xlatb33.xy = lessThan(u_xlat33.xyxy, u_xlat5.xyxy).xy;
    u_xlatb33.x = u_xlatb33.y || u_xlatb33.x;
    u_xlat4.xy = _Normal2_TexelSize.zw;
    u_xlat4 = (u_xlatb33.x) ? u_xlat4 : u_xlat1;
    u_xlat1 = (bool(u_xlatb45)) ? u_xlat4 : u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb48 = !!(u_xlat0.x<0.800000012);
#else
    u_xlatb48 = u_xlat0.x<0.800000012;
#endif
    if(u_xlatb48){
        u_xlat4.xy = (u_xlatb30.x) ? _Diffuse1_ST.xy : vec2(1.0, 1.0);
        u_xlat33.xy = (u_xlatb33.x) ? _Diffuse2_ST.xy : u_xlat3.xy;
        u_xlat30.xy = (bool(u_xlatb45)) ? u_xlat33.xy : u_xlat3.xy;
        u_xlat3.zw = vec2(vs_TEXCOORD2.z + (-_DetailDiffuse_ST.z), vs_TEXCOORD2.w + (-_DetailDiffuse_ST.w));
        u_xlat4.xy = u_xlat2.xy * u_xlat4.xy;
        u_xlat34.xy = vec2(_DetailDiffuse_ST.x * _DetailDiffuse_TexelSize.z, _DetailDiffuse_ST.y * _DetailDiffuse_TexelSize.w);
        u_xlatb4.xy = lessThan(u_xlat4.xyxx, u_xlat34.xyxx).xy;
        u_xlatb4.x = u_xlatb4.y || u_xlatb4.x;
        u_xlat3.xy = _DetailDiffuse_TexelSize.zw;
        u_xlat2 = (u_xlatb4.x) ? u_xlat3 : u_xlat2;
        u_xlat30.xy = u_xlat30.xy * u_xlat1.xy;
        u_xlat4.xy = vec2(_DetailDiffuse_ST.x * _DetailNormal_TexelSize.z, _DetailDiffuse_ST.y * _DetailNormal_TexelSize.w);
        u_xlatb30.xy = lessThan(u_xlat30.xyxy, u_xlat4.xyxy).xy;
        u_xlatb30.x = u_xlatb30.y || u_xlatb30.x;
        u_xlat3.xy = _DetailNormal_TexelSize.zw;
        u_xlat1 = (u_xlatb30.x) ? u_xlat3 : u_xlat1;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30.x = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb30.x = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb30.x){
        u_xlatb3.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat4 = (u_xlatb3.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat4 = (u_xlatb3.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat4;
        u_xlat3 = (u_xlatb3.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat4;
        SV_Target0 = u_xlat3;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30.x = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb30.x = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb30.x){
        u_xlat10_3.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.xy).xyz;
        SV_Target0.xyz = u_xlat10_3.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30.x = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb30.x = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb30.x){
        u_xlat30.x = max(_GrassDiffuse_TexelSize.w, _GrassDiffuse_TexelSize.z);
        u_xlat30.x = max(u_xlat30.x, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb45 = !!(256.0<u_xlat30.x);
#else
        u_xlatb45 = 256.0<u_xlat30.x;
#endif
        u_xlatb3.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), u_xlat30.xxxx).xy;
        u_xlat4 = (u_xlatb3.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat3 = (u_xlatb3.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat4;
        u_xlat3 = (bool(u_xlatb45)) ? u_xlat3 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat3;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30.x = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb30.x = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb30.x){
        u_xlat30.xy = vec2(vs_TEXCOORD0.x * _GrassDiffuse_TexelSize.z, vs_TEXCOORD0.y * _GrassDiffuse_TexelSize.w);
        u_xlat3.xy = dFdx(u_xlat30.xy);
        u_xlat30.xy = dFdy(u_xlat30.xy);
        u_xlat3.x = dot(u_xlat3.xy, u_xlat3.xy);
        u_xlat30.x = dot(u_xlat30.xy, u_xlat30.xy);
        u_xlat30.x = max(u_xlat30.x, u_xlat3.x);
        u_xlat30.x = log2(u_xlat30.x);
        u_xlat30.x = u_xlat30.x * 0.5;
        u_xlat30.x = max(u_xlat30.x, 0.0);
        u_xlat30.x = u_xlat30.x + 1.0;
        u_xlat45 = max(_GrassDiffuse_TexelSize.w, _GrassDiffuse_TexelSize.z);
        u_xlat30.x = u_xlat45 / u_xlat30.x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb45 = !!(256.0<u_xlat30.x);
#else
        u_xlatb45 = 256.0<u_xlat30.x;
#endif
        u_xlatb3.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), u_xlat30.xxxx).xy;
        u_xlat4 = (u_xlatb3.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat3 = (u_xlatb3.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat4;
        u_xlat3 = (bool(u_xlatb45)) ? u_xlat3 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat3;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30.x = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb30.x = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb30.x){
        u_xlat3.zw = vec2(vs_TEXCOORD0.x + (-_GrassDiffuse_ST.z), vs_TEXCOORD0.y + (-_GrassDiffuse_ST.w));
        u_xlat30.xy = vec2(_GrassDiffuse_ST.x * _GrassDiffuse_TexelSize.z, _GrassDiffuse_ST.y * _GrassDiffuse_TexelSize.w);
        u_xlatb30.xy = lessThan(vec4(1.0, 1.0, 1.0, 1.0), u_xlat30.xyxy).xy;
        u_xlatb30.x = u_xlatb30.y || u_xlatb30.x;
        u_xlat3.xy = _GrassDiffuse_TexelSize.zw;
        u_xlat4 = (u_xlatb30.x) ? u_xlat3 : vec4(1.0, 1.0, 0.0, 0.0);
        u_xlat2 = u_xlat2 + (-u_xlat4);
        u_xlat2 = vs_COLOR0.wwww * u_xlat2 + u_xlat4;
#ifdef UNITY_ADRENO_ES3
        u_xlatb30.x = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb30.x = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb30.x){
            u_xlat30.xy = vec2(u_xlat2.x * u_xlat2.z, u_xlat2.y * u_xlat2.w);
            u_xlat4.xy = dFdx(u_xlat30.xy);
            u_xlat30.xy = dFdy(u_xlat30.xy);
            u_xlat34.x = dot(u_xlat4.xy, u_xlat4.xy);
            u_xlat49 = dot(u_xlat30.xy, u_xlat30.xy);
            u_xlat34.x = max(u_xlat49, u_xlat34.x);
            u_xlat34.x = log2(u_xlat34.x);
            u_xlat34.x = u_xlat34.x * 0.5;
            u_xlat34.x = max(u_xlat34.x, 0.0);
            u_xlat34.x = u_xlat34.x + 1.0;
            u_xlat49 = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat4.xy = vec2(u_xlat49) * u_xlat4.xy;
            u_xlat30.xy = u_xlat30.xy * vec2(u_xlat49);
            u_xlat4.xy = u_xlat4.xy / u_xlat34.xx;
            u_xlat30.xy = u_xlat30.xy / u_xlat34.xx;
            u_xlat19.x = dot(abs(u_xlat4.xy), abs(u_xlat4.xy));
            u_xlat45 = dot(abs(u_xlat30.xy), abs(u_xlat30.xy));
            u_xlat34.x = sqrt(u_xlat19.x);
            u_xlat49 = sqrt(u_xlat45);
            u_xlat19.x = inversesqrt(u_xlat19.x);
            u_xlat4.x = u_xlat19.x * abs(u_xlat4.x);
            u_xlat45 = inversesqrt(u_xlat45);
            u_xlat30.x = u_xlat45 * abs(u_xlat30.x);
            u_xlat30.x = u_xlat30.x * u_xlat4.x;
            u_xlat30.x = (-u_xlat30.x) * u_xlat30.x + 1.0;
            u_xlat30.x = sqrt(u_xlat30.x);
            u_xlat45 = u_xlat49 * u_xlat34.x;
            u_xlat4.x = u_xlat30.x * u_xlat45;
            u_xlat19.xy = vec2(u_xlat2.z * float(3.0), u_xlat2.w * float(3.0));
            u_xlat49 = fract((-u_xlat19.x));
            u_xlat19.z = u_xlat49 + 0.5;
            u_xlat19.xy = fract(u_xlat19.xy);
            u_xlat19.xy = u_xlat19.xy + vec2(0.5, 0.5);
            u_xlat19.xyz = floor(u_xlat19.xyz);
            u_xlat49 = (-u_xlat19.x) + u_xlat19.z;
            u_xlat19.x = u_xlat49 * u_xlat19.y + u_xlat19.x;
            u_xlat34.x = (-u_xlat45) * u_xlat30.x + 1.0;
            u_xlat5.xyz = (-u_xlat19.xxx) + vec3(0.5, 0.0, 1.0);
            u_xlat6.xyz = u_xlat34.xxx * u_xlat5.xyz + u_xlat19.xxx;
            u_xlatb4.xz = lessThan(u_xlat4.xxxx, vec4(1.0, 0.0, 2.0, 0.0)).xz;
            u_xlat7.xyz = u_xlat19.xxx * vec3(0.0, 1.0, 0.0);
            u_xlat30.x = u_xlat45 * u_xlat30.x + -4.0;
            u_xlat30.x = exp2(u_xlat30.x);
            u_xlat30.x = u_xlat30.x + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat30.x = min(max(u_xlat30.x, 0.0), 1.0);
#else
            u_xlat30.x = clamp(u_xlat30.x, 0.0, 1.0);
#endif
            u_xlat5.xyz = u_xlat30.xxx * u_xlat5.zyy + u_xlat19.xxx;
            u_xlat19.xyz = (u_xlatb4.z) ? u_xlat7.xyz : u_xlat5.xyz;
            u_xlat4.xyz = (u_xlatb4.x) ? u_xlat6.xyz : u_xlat19.xyz;
        } else {
            u_xlat30.xy = vec2(_GrassDiffuse_ST.x * _GrassNormal_TexelSize.z, _GrassDiffuse_ST.y * _GrassNormal_TexelSize.w);
            u_xlatb30.xy = lessThan(vec4(1.0, 1.0, 1.0, 1.0), u_xlat30.xyxy).xy;
            u_xlatb30.x = u_xlatb30.y || u_xlatb30.x;
            u_xlat3.xy = _GrassNormal_TexelSize.zw;
            u_xlat3 = (u_xlatb30.x) ? u_xlat3 : vec4(1.0, 1.0, 0.0, 0.0);
            u_xlat1 = u_xlat1 + (-u_xlat3);
            u_xlat1 = vs_COLOR0.wwww * u_xlat1 + u_xlat3;
#ifdef UNITY_ADRENO_ES3
            u_xlatb30.x = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb30.x = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb30.x){
                u_xlat30.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                u_xlat3.xy = dFdx(u_xlat30.xy);
                u_xlat30.xy = dFdy(u_xlat30.xy);
                u_xlat33.x = dot(u_xlat3.xy, u_xlat3.xy);
                u_xlat48 = dot(u_xlat30.xy, u_xlat30.xy);
                u_xlat33.x = max(u_xlat48, u_xlat33.x);
                u_xlat33.x = log2(u_xlat33.x);
                u_xlat33.x = u_xlat33.x * 0.5;
                u_xlat33.x = max(u_xlat33.x, 0.0);
                u_xlat33.x = u_xlat33.x + 1.0;
                u_xlat48 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                u_xlat3.xy = vec2(u_xlat48) * u_xlat3.xy;
                u_xlat30.xy = u_xlat30.xy * vec2(u_xlat48);
                u_xlat3.xy = u_xlat3.xy / u_xlat33.xx;
                u_xlat30.xy = u_xlat30.xy / u_xlat33.xx;
                u_xlat18.x = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                u_xlat45 = dot(abs(u_xlat30.xy), abs(u_xlat30.xy));
                u_xlat33.x = sqrt(u_xlat18.x);
                u_xlat48 = sqrt(u_xlat45);
                u_xlat18.x = inversesqrt(u_xlat18.x);
                u_xlat3.x = u_xlat18.x * abs(u_xlat3.x);
                u_xlat45 = inversesqrt(u_xlat45);
                u_xlat30.x = u_xlat45 * abs(u_xlat30.x);
                u_xlat30.x = u_xlat30.x * u_xlat3.x;
                u_xlat30.x = (-u_xlat30.x) * u_xlat30.x + 1.0;
                u_xlat30.x = sqrt(u_xlat30.x);
                u_xlat45 = u_xlat48 * u_xlat33.x;
                u_xlat3.x = u_xlat30.x * u_xlat45;
                u_xlat18.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                u_xlat48 = fract((-u_xlat18.x));
                u_xlat18.z = u_xlat48 + 0.5;
                u_xlat18.xy = fract(u_xlat18.xy);
                u_xlat18.xy = u_xlat18.xy + vec2(0.5, 0.5);
                u_xlat18.xyz = floor(u_xlat18.xyz);
                u_xlat48 = (-u_xlat18.x) + u_xlat18.z;
                u_xlat18.x = u_xlat48 * u_xlat18.y + u_xlat18.x;
                u_xlat33.x = (-u_xlat45) * u_xlat30.x + 1.0;
                u_xlat5.xyz = (-u_xlat18.xxx) + vec3(0.5, 0.0, 1.0);
                u_xlat6.xyz = u_xlat33.xxx * u_xlat5.xyz + u_xlat18.xxx;
                u_xlatb3.xz = lessThan(u_xlat3.xxxx, vec4(1.0, 0.0, 2.0, 0.0)).xz;
                u_xlat7.xyz = u_xlat18.xxx * vec3(0.0, 1.0, 0.0);
                u_xlat30.x = u_xlat45 * u_xlat30.x + -4.0;
                u_xlat30.x = exp2(u_xlat30.x);
                u_xlat30.x = u_xlat30.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                u_xlat30.x = min(max(u_xlat30.x, 0.0), 1.0);
#else
                u_xlat30.x = clamp(u_xlat30.x, 0.0, 1.0);
#endif
                u_xlat5.xyz = u_xlat30.xxx * u_xlat5.zyy + u_xlat18.xxx;
                u_xlat18.xyz = (u_xlatb3.z) ? u_xlat7.xyz : u_xlat5.xyz;
                u_xlat4.xyz = (u_xlatb3.x) ? u_xlat6.xyz : u_xlat18.xyz;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb30.x = !!(u_xlat2.x>=u_xlat1.x);
#else
                u_xlatb30.x = u_xlat2.x>=u_xlat1.x;
#endif
                if(u_xlatb30.x){
                    u_xlat30.xy = vec2(u_xlat2.x * u_xlat2.z, u_xlat2.y * u_xlat2.w);
                    u_xlat2.xy = dFdx(u_xlat30.xy);
                    u_xlat30.xy = dFdy(u_xlat30.xy);
                    u_xlat3.x = dot(u_xlat2.xy, u_xlat2.xy);
                    u_xlat18.x = dot(u_xlat30.xy, u_xlat30.xy);
                    u_xlat3.x = max(u_xlat18.x, u_xlat3.x);
                    u_xlat3.x = log2(u_xlat3.x);
                    u_xlat3.x = u_xlat3.x * 0.5;
                    u_xlat3.x = max(u_xlat3.x, 0.0);
                    u_xlat3.x = u_xlat3.x + 1.0;
                    u_xlat18.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat2.xy = u_xlat2.xy * u_xlat18.xx;
                    u_xlat30.xy = u_xlat30.xy * u_xlat18.xx;
                    u_xlat2.xy = u_xlat2.xy / u_xlat3.xx;
                    u_xlat30.xy = u_xlat30.xy / u_xlat3.xx;
                    u_xlat17.x = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
                    u_xlat45 = dot(abs(u_xlat30.xy), abs(u_xlat30.xy));
                    u_xlat3.x = sqrt(u_xlat17.x);
                    u_xlat18.x = sqrt(u_xlat45);
                    u_xlat17.x = inversesqrt(u_xlat17.x);
                    u_xlat2.x = u_xlat17.x * abs(u_xlat2.x);
                    u_xlat45 = inversesqrt(u_xlat45);
                    u_xlat30.x = u_xlat45 * abs(u_xlat30.x);
                    u_xlat30.x = u_xlat30.x * u_xlat2.x;
                    u_xlat30.x = (-u_xlat30.x) * u_xlat30.x + 1.0;
                    u_xlat30.x = sqrt(u_xlat30.x);
                    u_xlat45 = u_xlat18.x * u_xlat3.x;
                    u_xlat2.x = u_xlat30.x * u_xlat45;
                    u_xlat17.xy = vec2(u_xlat2.z * float(3.0), u_xlat2.w * float(3.0));
                    u_xlat47 = fract((-u_xlat17.x));
                    u_xlat17.z = u_xlat47 + 0.5;
                    u_xlat17.xy = fract(u_xlat17.xy);
                    u_xlat17.xy = u_xlat17.xy + vec2(0.5, 0.5);
                    u_xlat17.xyz = floor(u_xlat17.xyz);
                    u_xlat47 = (-u_xlat17.x) + u_xlat17.z;
                    u_xlat17.x = u_xlat47 * u_xlat17.y + u_xlat17.x;
                    u_xlat32 = (-u_xlat45) * u_xlat30.x + 1.0;
                    u_xlat3.xyz = (-u_xlat17.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat5.xyz = vec3(u_xlat32) * u_xlat3.xyz + u_xlat17.xxx;
                    u_xlatb2.xz = lessThan(u_xlat2.xxxx, vec4(1.0, 0.0, 2.0, 0.0)).xz;
                    u_xlat6.xyz = u_xlat17.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat30.x = u_xlat45 * u_xlat30.x + -4.0;
                    u_xlat30.x = exp2(u_xlat30.x);
                    u_xlat30.x = u_xlat30.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat30.x = min(max(u_xlat30.x, 0.0), 1.0);
#else
                    u_xlat30.x = clamp(u_xlat30.x, 0.0, 1.0);
#endif
                    u_xlat3.xyz = u_xlat30.xxx * u_xlat3.zyy + u_xlat17.xxx;
                    u_xlat17.xyz = (u_xlatb2.z) ? u_xlat6.xyz : u_xlat3.xyz;
                    u_xlat4.xyz = (u_xlatb2.x) ? u_xlat5.xyz : u_xlat17.xyz;
                } else {
                    u_xlat30.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat1.xy = dFdx(u_xlat30.xy);
                    u_xlat30.xy = dFdy(u_xlat30.xy);
                    u_xlat2.x = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat17.x = dot(u_xlat30.xy, u_xlat30.xy);
                    u_xlat2.x = max(u_xlat17.x, u_xlat2.x);
                    u_xlat2.x = log2(u_xlat2.x);
                    u_xlat2.x = u_xlat2.x * 0.5;
                    u_xlat2.x = max(u_xlat2.x, 0.0);
                    u_xlat2.x = u_xlat2.x + 1.0;
                    u_xlat17.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat1.xy = u_xlat1.xy * u_xlat17.xx;
                    u_xlat30.xy = u_xlat30.xy * u_xlat17.xx;
                    u_xlat1.xy = u_xlat1.xy / u_xlat2.xx;
                    u_xlat30.xy = u_xlat30.xy / u_xlat2.xx;
                    u_xlat16.x = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat45 = dot(abs(u_xlat30.xy), abs(u_xlat30.xy));
                    u_xlat2.x = sqrt(u_xlat16.x);
                    u_xlat17.x = sqrt(u_xlat45);
                    u_xlat16.x = inversesqrt(u_xlat16.x);
                    u_xlat1.x = u_xlat16.x * abs(u_xlat1.x);
                    u_xlat45 = inversesqrt(u_xlat45);
                    u_xlat30.x = u_xlat45 * abs(u_xlat30.x);
                    u_xlat30.x = u_xlat30.x * u_xlat1.x;
                    u_xlat30.x = (-u_xlat30.x) * u_xlat30.x + 1.0;
                    u_xlat30.x = sqrt(u_xlat30.x);
                    u_xlat45 = u_xlat17.x * u_xlat2.x;
                    u_xlat1.x = u_xlat30.x * u_xlat45;
                    u_xlat16.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat46 = fract((-u_xlat16.x));
                    u_xlat16.z = u_xlat46 + 0.5;
                    u_xlat16.xy = fract(u_xlat16.xy);
                    u_xlat16.xy = u_xlat16.xy + vec2(0.5, 0.5);
                    u_xlat16.xyz = floor(u_xlat16.xyz);
                    u_xlat46 = (-u_xlat16.x) + u_xlat16.z;
                    u_xlat16.x = u_xlat46 * u_xlat16.y + u_xlat16.x;
                    u_xlat31 = (-u_xlat45) * u_xlat30.x + 1.0;
                    u_xlat2.xyz = (-u_xlat16.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat3.xyz = vec3(u_xlat31) * u_xlat2.xyz + u_xlat16.xxx;
                    u_xlatb1.xz = lessThan(u_xlat1.xxxx, vec4(1.0, 0.0, 2.0, 0.0)).xz;
                    u_xlat5.xyz = u_xlat16.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat30.x = u_xlat45 * u_xlat30.x + -4.0;
                    u_xlat30.x = exp2(u_xlat30.x);
                    u_xlat30.x = u_xlat30.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat30.x = min(max(u_xlat30.x, 0.0), 1.0);
#else
                    u_xlat30.x = clamp(u_xlat30.x, 0.0, 1.0);
#endif
                    u_xlat2.xyz = u_xlat30.xxx * u_xlat2.zyy + u_xlat16.xxx;
                    u_xlat16.xyz = (u_xlatb1.z) ? u_xlat5.xyz : u_xlat2.xyz;
                    u_xlat4.xyz = (u_xlatb1.x) ? u_xlat3.xyz : u_xlat16.xyz;
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat4.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb30.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 100.0, 102.0)).xy;
    u_xlatb30.x = u_xlatb30.y || u_xlatb30.x;
    if(u_xlatb30.x){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb30.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 101.0, 103.0)).xy;
    u_xlatb30.x = u_xlatb30.y || u_xlatb30.x;
    if(u_xlatb30.x){
        SV_Target0 = vec4(0.400000006, 0.400000006, 0.400000006, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30.x = !!(vs_COLOR0.w<0.99000001);
#else
    u_xlatb30.x = vs_COLOR0.w<0.99000001;
#endif
    if(u_xlatb30.x){
        u_xlat10_1 = texture(_GrassNormal, vs_TEXCOORD0.xy, -1.0);
        u_xlat16_8.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_8.xy = u_xlat16_8.xy * vec2(_GrassNormalScale);
        u_xlat16_53 = u_xlat10_1.w * _UseGrassSpecular;
        u_xlat10_1.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.xy, -1.0).xyz;
        u_xlat16_9.xyz = u_xlat10_1.xyz;
    } else {
        u_xlat16_9.x = float(0.0);
        u_xlat16_9.y = float(0.0);
        u_xlat16_9.z = float(0.0);
        u_xlat16_8.x = float(0.0);
        u_xlat16_8.y = float(0.0);
        u_xlat16_8.z = float(1.0);
        u_xlat16_53 = float(0.0);
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30.x = !!(0.00999999978<vs_COLOR0.w);
#else
    u_xlatb30.x = 0.00999999978<vs_COLOR0.w;
#endif
    if(u_xlatb30.x){
        u_xlat10_1.xyz = texture(_Normal0, vs_TEXCOORD0.zw, -1.0).xyw;
        u_xlat10_2.xyz = texture(_Normal2, vs_TEXCOORD2.xy, -1.0).xyw;
        u_xlat16_10.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_40.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_40.xy = u_xlat16_40.xy * vec2(_Normal2Scale);
        u_xlat16_54 = (-u_xlat0.y) + 1.0;
        u_xlat16_40.xy = vec2(u_xlat16_54) * u_xlat16_40.xy;
        u_xlat16_40.xy = u_xlat16_40.xy * vs_COLOR0.xx;
        u_xlat10_3 = texture(_Diffuse1, vs_TEXCOORD0.zw, -1.0);
        u_xlat30.xy = vec2(vs_TEXCOORD2.z * float(_DetailNormalUVScale), vs_TEXCOORD2.w * float(_DetailNormalUVScale));
        u_xlat10_1.xyw = texture(_DetailNormal, u_xlat30.xy, -1.0).xyw;
        u_xlat16_11.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_11.xy = u_xlat16_11.xy * vec2(_DetailNormalScale);
        u_xlat16_54 = (-u_xlat0.x) + 1.0;
        u_xlat16_11.xy = vec2(u_xlat16_54) * u_xlat16_11.xy;
        u_xlat10_4 = texture(_Diffuse2, vs_TEXCOORD2.xy, -1.0);
        u_xlat10_5 = texture(_DetailDiffuse, vs_TEXCOORD2.zw, -1.0);
        u_xlat16_54 = u_xlat10_4.w * _UseDiffuseTwoHeight;
        u_xlat16_41 = u_xlat10_5.w * _UseDetailDiffuseHeight;
        u_xlat16_12.xyz = u_xlat10_3.xyz + (-u_xlat10_4.xyz);
        u_xlat16_56 = u_xlat10_3.w * _UseDiffuseOneHeight + (-u_xlat16_54);
        u_xlat16_12.xyz = u_xlat0.yyy * u_xlat16_12.xyz + u_xlat10_4.xyz;
        u_xlat16_54 = u_xlat0.y * u_xlat16_56 + u_xlat16_54;
        u_xlat16_56 = u_xlat0.x * _DetailBlendVal;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_56 = min(max(u_xlat16_56, 0.0), 1.0);
#else
        u_xlat16_56 = clamp(u_xlat16_56, 0.0, 1.0);
#endif
        u_xlat16_57 = (-u_xlat16_56) + 1.0;
        u_xlat16_41 = u_xlat16_41 * u_xlat16_57;
        u_xlat16_54 = max(u_xlat16_54, u_xlat16_41);
        u_xlat16_13.xyz = u_xlat10_5.xyz * u_xlat16_12.xyz;
        u_xlat16_14.xyz = u_xlat16_13.xyz * vec3(4.0, 4.0, 4.0);
        u_xlat16_12.xyz = (-u_xlat16_13.xyz) * vec3(4.0, 4.0, 4.0) + u_xlat16_12.xyz;
        u_xlat16_12.xyz = vec3(u_xlat16_56) * u_xlat16_12.xyz + u_xlat16_14.xyz;
        u_xlat16_12.xyz = min(u_xlat16_12.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_41 = u_xlat10_2.z * _UseSpecularTwo;
        u_xlat16_56 = u_xlat10_1.w * _UseDetailSpecular;
        u_xlat16_13.x = _UseSpecularOne * u_xlat10_1.z + (-u_xlat16_41);
        u_xlat16_41 = u_xlat0.y * u_xlat16_13.x + u_xlat16_41;
        u_xlat16_56 = u_xlat16_57 * u_xlat16_56;
        u_xlat16_41 = max(u_xlat16_56, u_xlat16_41);
        u_xlat16_10.xy = u_xlat16_10.xy * vec2(_Normal0Scale) + u_xlat16_40.xy;
        u_xlat16_10.xy = u_xlat16_11.xy * vs_COLOR0.xx + u_xlat16_10.xy;
    } else {
        u_xlat16_12.x = float(0.0);
        u_xlat16_12.y = float(0.0);
        u_xlat16_12.z = float(0.0);
        u_xlat16_10.x = float(0.0);
        u_xlat16_10.y = float(0.0);
        u_xlat16_54 = 1.0;
        u_xlat16_41 = 0.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor);
#endif
    u_xlat16_11.xyw = u_xlat16_12.xyz * _TintColor.xyz;
    u_xlat16_11.xyw = (bool(u_xlatb0)) ? u_xlat16_11.xyw : u_xlat16_12.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend);
#endif
    u_xlat16_15 = u_xlat16_54;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_30 = vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_54 = _HeightContrast * 10.0;
    u_xlat16_15 = u_xlat16_15 + -1.0;
    u_xlat16_55 = _HeightSpread + 0.100000001;
    u_xlat16_30 = log2(u_xlat16_30);
    u_xlat16_30 = u_xlat16_30 * u_xlat16_55;
    u_xlat16_30 = exp2(u_xlat16_30);
    u_xlat16_15 = u_xlat16_30 * 2.0 + u_xlat16_15;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_30 = _HeightContrast * 10.0 + 1.0;
    u_xlat16_30 = _HeightContrast * 10.0 + u_xlat16_30;
    u_xlat15 = u_xlat16_15 * u_xlat16_30 + (-u_xlat16_54);
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_54 = (u_xlatb0) ? u_xlat15 : vs_COLOR0.w;
    u_xlat16_10.z = 1.0;
    u_xlat16_10.xyz = (-u_xlat16_8.xyz) + u_xlat16_10.xyz;
    u_xlat16_8.xyz = vec3(u_xlat16_54) * u_xlat16_10.xyz + u_xlat16_8.xyz;
    u_xlat16_10.x = (-u_xlat16_53) + u_xlat16_41;
    u_xlat16_53 = u_xlat16_54 * u_xlat16_10.x + u_xlat16_53;
    u_xlat16_10.xyz = (-u_xlat16_9.xyz) + u_xlat16_11.xyw;
    u_xlat16_9.xyz = vec3(u_xlat16_54) * u_xlat16_10.xyz + u_xlat16_9.xyz;
    u_xlat16_53 = u_xlat16_53 + _Shininess;
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, u_xlat16_8.xyz);
    u_xlat0.y = dot(vs_TEXCOORD4.xyz, u_xlat16_8.xyz);
    u_xlat0.z = dot(vs_TEXCOORD5.xyz, u_xlat16_8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb45 = !!(vs_TEXCOORD1.w<100.0);
#else
    u_xlatb45 = vs_TEXCOORD1.w<100.0;
#endif
    if(u_xlatb45){
        u_xlat1.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
        u_xlat45 = texture(_CameraDepthBlendTexture, u_xlat1.xy).x;
        u_xlat45 = _ZBufferParams.z * u_xlat45 + _ZBufferParams.w;
        u_xlat45 = float(1.0) / u_xlat45;
        u_xlat45 = u_xlat45 + (-vs_TEXCOORD1.w);
        u_xlat45 = abs(u_xlat45) * _DepthBiasScaled;
        u_xlat45 = u_xlat45 * 0.600000024;
#ifdef UNITY_ADRENO_ES3
        u_xlat45 = min(max(u_xlat45, 0.0), 1.0);
#else
        u_xlat45 = clamp(u_xlat45, 0.0, 1.0);
#endif
        u_xlat45 = sqrt(u_xlat45);
        u_xlat10_2.xyz = texture(_CameraDepthBlendNormTexture, u_xlat1.xy).xyz;
        u_xlat16_8.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat10_1.xyz = texture(_CameraDepthBlendDiffTexture, u_xlat1.xy).xyz;
        u_xlat16_54 = u_xlat0.y * _DepthBlendAO;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_54 = min(max(u_xlat16_54, 0.0), 1.0);
#else
        u_xlat16_54 = clamp(u_xlat16_54, 0.0, 1.0);
#endif
        u_xlat46 = (-u_xlat45) + 1.0;
        u_xlat46 = u_xlat16_54 * u_xlat46 + u_xlat45;
        u_xlat46 = max(u_xlat46, 0.899999976);
        u_xlat2.xyz = u_xlat16_9.xyz * vec3(u_xlat46) + (-u_xlat10_1.xyz);
        u_xlat9.xyz = vec3(u_xlat45) * u_xlat2.xyz + u_xlat10_1.xyz;
        u_xlat1.xyz = u_xlat0.xyz + (-u_xlat16_8.xyz);
        u_xlat1.xyz = vec3(u_xlat45) * u_xlat1.xyz + u_xlat16_8.xyz;
        u_xlat16_9.xyz = u_xlat9.xyz;
        u_xlat16_1.xyz = u_xlat1.xyz;
    } else {
        u_xlat16_1.xyz = u_xlat0.xyz;
    //ENDIF
    }
    u_xlat16_8.x = u_xlat16_53 * _Terrain_Smoothness;
    u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
    SV_Target2.w = min(u_xlat16_8.x, 0.5);
    u_xlat16_8.xyz = u_xlat16_9.xyz * vec3(vec3(_Terrain_Specular, _Terrain_Specular, _Terrain_Specular));
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat16_53 = max(u_xlat16_8.z, u_xlat16_8.y);
    u_xlat16_53 = max(u_xlat16_53, u_xlat16_8.x);
    u_xlat16_53 = (-u_xlat16_53) + 1.0;
    SV_Target1.xyz = vec3(u_xlat16_53) * u_xlat16_9.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_53 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_53 : u_xlat16_8.z;
    SV_Target0.w = 0.0;
    SV_Target1.w = _SSAO_Intensity;
    SV_Target2.xy = u_xlat16_8.xy;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MSAA_INTERPOLATION" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _Diffuse1_ST;
uniform 	float _UVDiffuse2;
uniform 	vec4 _Diffuse2_ST;
uniform 	float _UVDetail;
uniform 	vec4 _DetailDiffuse_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec2 u_xlat12;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat15 = u_xlat15 + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat15 = u_xlat15 + u_xlat2.x;
    u_xlat15 = u_xlat15 * 0.330000013;
    u_xlat2.xy = vec2(u_xlat15) * in_TEXCOORD0.xy;
    u_xlat12.xy = vec2(u_xlat15) * in_TEXCOORD1.xy;
    vs_TEXCOORD0.xy = u_xlat2.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Diffuse1_ST.xy + _Diffuse1_ST.zw;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat15 * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UVDiffuse2==0.0);
#else
    u_xlatb15 = _UVDiffuse2==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat2.xy : u_xlat12.xy;
    vs_TEXCOORD2.xy = u_xlat1.xy * _Diffuse2_ST.xy + _Diffuse2_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UVDetail==0.0);
#else
    u_xlatb15 = _UVDetail==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat2.xy : u_xlat12.xy;
    vs_TEXCOORD2.zw = u_xlat1.xy * _DetailDiffuse_ST.xy + _DetailDiffuse_ST.zw;
    vs_TEXCOORD3.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz;
    vs_TEXCOORD3.y = u_xlat16_4.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat0.y;
    vs_TEXCOORD5.w = u_xlat0.z;
    vs_TEXCOORD4.y = u_xlat16_4.y;
    vs_TEXCOORD5.y = u_xlat16_4.z;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MSAA_INTERPOLATION" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _Diffuse1_ST;
uniform 	float _UVDiffuse2;
uniform 	vec4 _Diffuse2_ST;
uniform 	float _UVDetail;
uniform 	vec4 _DetailDiffuse_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat7;
float u_xlat16;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x;
    u_xlat2.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].x;
    u_xlat2.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].x;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].y;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].y;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].y;
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.xy = sqrt(u_xlat2.xy);
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].z;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].z;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].z;
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat2.x = u_xlat7.x + u_xlat2.x;
    u_xlat2.x = u_xlat2.x * 0.330000013;
    u_xlat7.xy = u_xlat2.xx * in_TEXCOORD0.xy;
    u_xlat2.xw = u_xlat2.xx * in_TEXCOORD1.xy;
    vs_TEXCOORD0.xy = u_xlat7.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Diffuse1_ST.xy + _Diffuse1_ST.zw;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UVDiffuse2==0.0);
#else
    u_xlatb1 = _UVDiffuse2==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb1)) ? u_xlat7.xy : u_xlat2.xw;
    vs_TEXCOORD2.xy = u_xlat1.xy * _Diffuse2_ST.xy + _Diffuse2_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UVDetail==0.0);
#else
    u_xlatb1 = _UVDetail==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb1)) ? u_xlat7.xy : u_xlat2.xw;
    vs_TEXCOORD2.zw = u_xlat1.xy * _DetailDiffuse_ST.xy + _DetailDiffuse_ST.zw;
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat2.xyz = vec3(u_xlat0) * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_4.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = vec3(u_xlat0) * u_xlat16_4.xyz;
    vs_TEXCOORD3.y = u_xlat16_4.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD3.w = u_xlat5.x;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat5.y;
    vs_TEXCOORD5.w = u_xlat5.z;
    vs_TEXCOORD4.y = u_xlat16_4.y;
    vs_TEXCOORD5.y = u_xlat16_4.z;
    vs_COLOR0 = in_COLOR0;
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
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MSAA_INTERPOLATION" "LINE_INTERPOLATION" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _Diffuse1_ST;
uniform 	float _UVDiffuse2;
uniform 	vec4 _Diffuse2_ST;
uniform 	float _UVDetail;
uniform 	vec4 _DetailDiffuse_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec2 u_xlat12;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat15 = u_xlat15 + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat15 = u_xlat15 + u_xlat2.x;
    u_xlat15 = u_xlat15 * 0.330000013;
    u_xlat2.xy = vec2(u_xlat15) * in_TEXCOORD0.xy;
    u_xlat12.xy = vec2(u_xlat15) * in_TEXCOORD1.xy;
    vs_TEXCOORD0.xy = u_xlat2.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Diffuse1_ST.xy + _Diffuse1_ST.zw;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat15 * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UVDiffuse2==0.0);
#else
    u_xlatb15 = _UVDiffuse2==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat2.xy : u_xlat12.xy;
    vs_TEXCOORD2.xy = u_xlat1.xy * _Diffuse2_ST.xy + _Diffuse2_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UVDetail==0.0);
#else
    u_xlatb15 = _UVDetail==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat2.xy : u_xlat12.xy;
    vs_TEXCOORD2.zw = u_xlat1.xy * _DetailDiffuse_ST.xy + _DetailDiffuse_ST.zw;
    vs_TEXCOORD3.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz;
    vs_TEXCOORD3.y = u_xlat16_4.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat0.y;
    vs_TEXCOORD5.w = u_xlat0.z;
    vs_TEXCOORD4.y = u_xlat16_4.y;
    vs_TEXCOORD5.y = u_xlat16_4.z;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MSAA_INTERPOLATION" "LINE_INTERPOLATION" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _Diffuse1_ST;
uniform 	float _UVDiffuse2;
uniform 	vec4 _Diffuse2_ST;
uniform 	float _UVDetail;
uniform 	vec4 _DetailDiffuse_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat7;
float u_xlat16;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x;
    u_xlat2.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].x;
    u_xlat2.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].x;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].y;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].y;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].y;
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.xy = sqrt(u_xlat2.xy);
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].z;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].z;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].z;
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat2.x = u_xlat7.x + u_xlat2.x;
    u_xlat2.x = u_xlat2.x * 0.330000013;
    u_xlat7.xy = u_xlat2.xx * in_TEXCOORD0.xy;
    u_xlat2.xw = u_xlat2.xx * in_TEXCOORD1.xy;
    vs_TEXCOORD0.xy = u_xlat7.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Diffuse1_ST.xy + _Diffuse1_ST.zw;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UVDiffuse2==0.0);
#else
    u_xlatb1 = _UVDiffuse2==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb1)) ? u_xlat7.xy : u_xlat2.xw;
    vs_TEXCOORD2.xy = u_xlat1.xy * _Diffuse2_ST.xy + _Diffuse2_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UVDetail==0.0);
#else
    u_xlatb1 = _UVDetail==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb1)) ? u_xlat7.xy : u_xlat2.xw;
    vs_TEXCOORD2.zw = u_xlat1.xy * _DetailDiffuse_ST.xy + _DetailDiffuse_ST.zw;
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat2.xyz = vec3(u_xlat0) * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_4.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = vec3(u_xlat0) * u_xlat16_4.xyz;
    vs_TEXCOORD3.y = u_xlat16_4.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD3.w = u_xlat5.x;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat5.y;
    vs_TEXCOORD5.w = u_xlat5.z;
    vs_TEXCOORD4.y = u_xlat16_4.y;
    vs_TEXCOORD5.y = u_xlat16_4.z;
    vs_COLOR0 = in_COLOR0;
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
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
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
Keywords { "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "LINE_INTERPOLATION" }
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
Keywords { "LINE_INTERPOLATION" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "LINE_INTERPOLATION" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
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
Keywords { "UNITY_DEBUG_VIEW_ON" "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "LINE_INTERPOLATION" }
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
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "LINE_INTERPOLATION" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "LINE_INTERPOLATION" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
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
Keywords { "MSAA_INTERPOLATION" "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MSAA_INTERPOLATION" "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "MSAA_INTERPOLATION" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MSAA_INTERPOLATION" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles3 " {
Keywords { "MSAA_INTERPOLATION" "LINE_INTERPOLATION" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MSAA_INTERPOLATION" "LINE_INTERPOLATION" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MSAA_INTERPOLATION" "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MSAA_INTERPOLATION" "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MSAA_INTERPOLATION" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MSAA_INTERPOLATION" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MSAA_INTERPOLATION" "LINE_INTERPOLATION" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MSAA_INTERPOLATION" "LINE_INTERPOLATION" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
}
}
 Pass {
  Name "HYBRIDDEFERRED"
  Tags { "DebugView" = "On" "LIGHTMODE" = "HYBRIDDEFERRED" "QUEUE" = "Geometry-100" "RenderType" = "Opaque" "ShaderLod" = "true" }
  GpuProgramID 234103
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _Diffuse1_ST;
uniform 	float _UVDiffuse2;
uniform 	vec4 _Diffuse2_ST;
uniform 	float _UVDetail;
uniform 	vec4 _DetailDiffuse_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec2 u_xlat12;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat15 = u_xlat15 + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat15 = u_xlat15 + u_xlat2.x;
    u_xlat15 = u_xlat15 * 0.330000013;
    u_xlat2.xy = vec2(u_xlat15) * in_TEXCOORD0.xy;
    u_xlat12.xy = vec2(u_xlat15) * in_TEXCOORD1.xy;
    vs_TEXCOORD0.xy = u_xlat2.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Diffuse1_ST.xy + _Diffuse1_ST.zw;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat15 * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UVDiffuse2==0.0);
#else
    u_xlatb15 = _UVDiffuse2==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat2.xy : u_xlat12.xy;
    vs_TEXCOORD2.xy = u_xlat1.xy * _Diffuse2_ST.xy + _Diffuse2_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UVDetail==0.0);
#else
    u_xlatb15 = _UVDetail==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat2.xy : u_xlat12.xy;
    vs_TEXCOORD2.zw = u_xlat1.xy * _DetailDiffuse_ST.xy + _DetailDiffuse_ST.zw;
    vs_TEXCOORD3.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz;
    vs_TEXCOORD3.y = u_xlat16_4.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat0.y;
    vs_TEXCOORD5.w = u_xlat0.z;
    vs_TEXCOORD4.y = u_xlat16_4.y;
    vs_TEXCOORD5.y = u_xlat16_4.z;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump float _HeightSpread;
uniform 	mediump float _HeightContrast;
uniform 	mediump float _UseTintColor;
uniform 	mediump float _UseDiffuseOneHeight;
uniform 	mediump float _UseGrassHeightBlend;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _SSAO_Intensity;
uniform 	mediump float _Terrain_Smoothness;
uniform 	mediump float _Terrain_Specular;
uniform 	mediump float _Shininess;
uniform 	mediump float _Diffuse2Distance;
uniform 	mediump float _Diffuse2Fade;
uniform lowp sampler2D _GrassNormal;
uniform lowp sampler2D _GrassDiffuse;
uniform lowp sampler2D _Normal0;
uniform lowp sampler2D _Normal2;
uniform lowp sampler2D _Diffuse1;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
mediump float u_xlat16_7;
lowp vec3 u_xlat10_7;
mediump float u_xlat16_14;
float u_xlat21;
mediump float u_xlat16_22;
mediump float u_xlat16_23;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_COLOR0.w<0.99000001);
#else
    u_xlatb0 = vs_COLOR0.w<0.99000001;
#endif
    if(u_xlatb0){
        u_xlat10_0.xyz = texture(_GrassNormal, vs_TEXCOORD0.xy).xyz;
        u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat10_0.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.xy).xyz;
        u_xlat16_2.xyz = u_xlat10_0.xyz;
    } else {
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
        u_xlat16_1.x = float(0.0);
        u_xlat16_1.y = float(0.0);
        u_xlat16_1.z = float(1.0);
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.00999999978<vs_COLOR0.w);
#else
    u_xlatb0 = 0.00999999978<vs_COLOR0.w;
#endif
    if(u_xlatb0){
        u_xlat0.x = vs_TEXCOORD3.w;
        u_xlat0.y = vs_TEXCOORD4.w;
        u_xlat0.z = vs_TEXCOORD5.w;
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = u_xlat0.x / _Diffuse2Distance;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = u_xlat0.x + 9.99999975e-05;
        u_xlat0.x = log2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * _Diffuse2Fade;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat0.x = min(u_xlat0.x, 1.0);
        u_xlat10_7.xyz = texture(_Normal0, vs_TEXCOORD0.zw).xyz;
        u_xlat10_3.xy = texture(_Normal2, vs_TEXCOORD2.xy).xy;
        u_xlat16_4.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_22 = (-u_xlat0.x) + 1.0;
        u_xlat16_4.xy = vec2(u_xlat16_22) * u_xlat16_4.xy;
        u_xlat16_4.xy = u_xlat16_4.xy * vs_COLOR0.xx;
        u_xlat10_3 = texture(_Diffuse1, vs_TEXCOORD0.zw);
        u_xlat16_22 = u_xlat10_3.w * _UseDiffuseOneHeight;
        u_xlat16_5.xyz = u_xlat10_7.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, 0.0);
        u_xlat16_4.z = -1.0;
        u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
        u_xlat16_5.xyz = u_xlat10_3.xyz;
    } else {
        u_xlat16_5.x = float(0.0);
        u_xlat16_5.y = float(0.0);
        u_xlat16_5.z = float(0.0);
        u_xlat16_4.x = float(0.0);
        u_xlat16_4.y = float(0.0);
        u_xlat16_4.z = float(1.0);
        u_xlat16_22 = 1.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor);
#endif
    u_xlat16_6.xyz = u_xlat16_5.xyz * _TintColor.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb0)) ? u_xlat16_6.xyz : u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend);
#endif
    u_xlat16_7 = u_xlat16_22;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
    u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
    u_xlat16_14 = vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_22 = _HeightContrast * 10.0;
    u_xlat16_7 = u_xlat16_7 + -1.0;
    u_xlat16_23 = _HeightSpread + 0.100000001;
    u_xlat16_14 = log2(u_xlat16_14);
    u_xlat16_14 = u_xlat16_14 * u_xlat16_23;
    u_xlat16_14 = exp2(u_xlat16_14);
    u_xlat16_7 = u_xlat16_14 * 2.0 + u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
    u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
    u_xlat16_14 = _HeightContrast * 10.0 + 1.0;
    u_xlat16_14 = _HeightContrast * 10.0 + u_xlat16_14;
    u_xlat7 = u_xlat16_7 * u_xlat16_14 + (-u_xlat16_22);
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat16_22 = (u_xlatb0) ? u_xlat7 : vs_COLOR0.w;
    u_xlat16_4.xyz = (-u_xlat16_1.xyz) + u_xlat16_4.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_22) * u_xlat16_4.xyz + u_xlat16_1.xyz;
    u_xlat16_4.xyz = (-u_xlat16_2.xyz) + u_xlat16_5.xyz;
    u_xlat16_2.xyz = vec3(u_xlat16_22) * u_xlat16_4.xyz + u_xlat16_2.xyz;
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD5.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = _Terrain_Smoothness * _Shininess;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    SV_Target2.w = min(u_xlat16_1.x, 0.5);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(vec3(_Terrain_Specular, _Terrain_Specular, _Terrain_Specular));
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_22 = max(u_xlat16_1.z, u_xlat16_1.y);
    u_xlat16_22 = max(u_xlat16_22, u_xlat16_1.x);
    u_xlat16_22 = (-u_xlat16_22) + 1.0;
    SV_Target1.xyz = vec3(u_xlat16_22) * u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_22 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_22 : u_xlat16_1.z;
    SV_Target0.w = 0.0;
    SV_Target1.w = _SSAO_Intensity;
    SV_Target2.xy = u_xlat16_1.xy;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _Diffuse1_ST;
uniform 	float _UVDiffuse2;
uniform 	vec4 _Diffuse2_ST;
uniform 	float _UVDetail;
uniform 	vec4 _DetailDiffuse_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat7;
float u_xlat16;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x;
    u_xlat2.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].x;
    u_xlat2.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].x;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].y;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].y;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].y;
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.xy = sqrt(u_xlat2.xy);
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].z;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].z;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].z;
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat2.x = u_xlat7.x + u_xlat2.x;
    u_xlat2.x = u_xlat2.x * 0.330000013;
    u_xlat7.xy = u_xlat2.xx * in_TEXCOORD0.xy;
    u_xlat2.xw = u_xlat2.xx * in_TEXCOORD1.xy;
    vs_TEXCOORD0.xy = u_xlat7.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Diffuse1_ST.xy + _Diffuse1_ST.zw;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UVDiffuse2==0.0);
#else
    u_xlatb1 = _UVDiffuse2==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb1)) ? u_xlat7.xy : u_xlat2.xw;
    vs_TEXCOORD2.xy = u_xlat1.xy * _Diffuse2_ST.xy + _Diffuse2_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UVDetail==0.0);
#else
    u_xlatb1 = _UVDetail==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb1)) ? u_xlat7.xy : u_xlat2.xw;
    vs_TEXCOORD2.zw = u_xlat1.xy * _DetailDiffuse_ST.xy + _DetailDiffuse_ST.zw;
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat2.xyz = vec3(u_xlat0) * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_4.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = vec3(u_xlat0) * u_xlat16_4.xyz;
    vs_TEXCOORD3.y = u_xlat16_4.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD3.w = u_xlat5.x;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat5.y;
    vs_TEXCOORD5.w = u_xlat5.z;
    vs_TEXCOORD4.y = u_xlat16_4.y;
    vs_TEXCOORD5.y = u_xlat16_4.z;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump float _HeightSpread;
uniform 	mediump float _HeightContrast;
uniform 	mediump float _UseTintColor;
uniform 	mediump float _UseDiffuseOneHeight;
uniform 	mediump float _UseGrassHeightBlend;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _SSAO_Intensity;
uniform 	mediump float _Terrain_Smoothness;
uniform 	mediump float _Terrain_Specular;
uniform 	mediump float _Shininess;
uniform 	float _GrassNormalScale;
uniform 	float _Normal0Scale;
uniform 	mediump float _Normal2Scale;
uniform 	mediump float _Diffuse2Distance;
uniform 	mediump float _Diffuse2Fade;
uniform lowp sampler2D _GrassNormal;
uniform lowp sampler2D _GrassDiffuse;
uniform lowp sampler2D _Normal0;
uniform lowp sampler2D _Normal2;
uniform lowp sampler2D _Diffuse1;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec2 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
mediump float u_xlat16_7;
lowp vec3 u_xlat10_7;
mediump float u_xlat16_14;
float u_xlat21;
mediump float u_xlat16_22;
mediump float u_xlat16_23;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_COLOR0.w<0.99000001);
#else
    u_xlatb0 = vs_COLOR0.w<0.99000001;
#endif
    if(u_xlatb0){
        u_xlat10_0.xyz = texture(_GrassNormal, vs_TEXCOORD0.xy).xyz;
        u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_1.xy = u_xlat16_1.xy * vec2(_GrassNormalScale);
        u_xlat10_0.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.xy).xyz;
        u_xlat16_2.xyz = u_xlat10_0.xyz;
    } else {
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
        u_xlat16_1.x = float(0.0);
        u_xlat16_1.y = float(0.0);
        u_xlat16_1.z = float(1.0);
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.00999999978<vs_COLOR0.w);
#else
    u_xlatb0 = 0.00999999978<vs_COLOR0.w;
#endif
    if(u_xlatb0){
        u_xlat0.x = vs_TEXCOORD3.w;
        u_xlat0.y = vs_TEXCOORD4.w;
        u_xlat0.z = vs_TEXCOORD5.w;
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = u_xlat0.x / _Diffuse2Distance;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = u_xlat0.x + 9.99999975e-05;
        u_xlat0.x = log2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * _Diffuse2Fade;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat0.x = min(u_xlat0.x, 1.0);
        u_xlat10_7.xyz = texture(_Normal0, vs_TEXCOORD0.zw).xyz;
        u_xlat10_3.xy = texture(_Normal2, vs_TEXCOORD2.xy).xy;
        u_xlat16_4.z = u_xlat10_7.z + u_xlat10_7.z;
        u_xlat16_5.xy = u_xlat10_7.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_4.xy = u_xlat16_5.xy * vec2(_Normal0Scale);
        u_xlat16_5.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_5.xy = u_xlat16_5.xy * vec2(_Normal2Scale);
        u_xlat16_22 = (-u_xlat0.x) + 1.0;
        u_xlat16_5.xy = vec2(u_xlat16_22) * u_xlat16_5.xy;
        u_xlat16_5.xy = u_xlat16_5.xy * vs_COLOR0.xx;
        u_xlat10_0 = texture(_Diffuse1, vs_TEXCOORD0.zw);
        u_xlat16_22 = u_xlat10_0.w * _UseDiffuseOneHeight;
        u_xlat16_5.z = -1.0;
        u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
        u_xlat16_5.xyz = u_xlat10_0.xyz;
    } else {
        u_xlat16_5.x = float(0.0);
        u_xlat16_5.y = float(0.0);
        u_xlat16_5.z = float(0.0);
        u_xlat16_4.x = float(0.0);
        u_xlat16_4.y = float(0.0);
        u_xlat16_4.z = float(1.0);
        u_xlat16_22 = 1.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor);
#endif
    u_xlat16_6.xyz = u_xlat16_5.xyz * _TintColor.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb0)) ? u_xlat16_6.xyz : u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend);
#endif
    u_xlat16_7 = u_xlat16_22;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
    u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
    u_xlat16_14 = vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_22 = _HeightContrast * 10.0;
    u_xlat16_7 = u_xlat16_7 + -1.0;
    u_xlat16_23 = _HeightSpread + 0.100000001;
    u_xlat16_14 = log2(u_xlat16_14);
    u_xlat16_14 = u_xlat16_14 * u_xlat16_23;
    u_xlat16_14 = exp2(u_xlat16_14);
    u_xlat16_7 = u_xlat16_14 * 2.0 + u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
    u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
    u_xlat16_14 = _HeightContrast * 10.0 + 1.0;
    u_xlat16_14 = _HeightContrast * 10.0 + u_xlat16_14;
    u_xlat7 = u_xlat16_7 * u_xlat16_14 + (-u_xlat16_22);
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat16_22 = (u_xlatb0) ? u_xlat7 : vs_COLOR0.w;
    u_xlat16_4.xyz = (-u_xlat16_1.xyz) + u_xlat16_4.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_22) * u_xlat16_4.xyz + u_xlat16_1.xyz;
    u_xlat16_4.xyz = (-u_xlat16_2.xyz) + u_xlat16_5.xyz;
    u_xlat16_2.xyz = vec3(u_xlat16_22) * u_xlat16_4.xyz + u_xlat16_2.xyz;
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD5.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = _Terrain_Smoothness * _Shininess;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    SV_Target2.w = min(u_xlat16_1.x, 0.5);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(vec3(_Terrain_Specular, _Terrain_Specular, _Terrain_Specular));
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_22 = max(u_xlat16_1.z, u_xlat16_1.y);
    u_xlat16_22 = max(u_xlat16_22, u_xlat16_1.x);
    u_xlat16_22 = (-u_xlat16_22) + 1.0;
    SV_Target1.xyz = vec3(u_xlat16_22) * u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_22 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_22 : u_xlat16_1.z;
    SV_Target0.w = 0.0;
    SV_Target1.w = _SSAO_Intensity;
    SV_Target2.xy = u_xlat16_1.xy;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _Diffuse1_ST;
uniform 	float _UVDiffuse2;
uniform 	vec4 _Diffuse2_ST;
uniform 	float _UVDetail;
uniform 	vec4 _DetailDiffuse_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec2 u_xlat12;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat15 = u_xlat15 + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat15 = u_xlat15 + u_xlat2.x;
    u_xlat15 = u_xlat15 * 0.330000013;
    u_xlat2.xy = vec2(u_xlat15) * in_TEXCOORD0.xy;
    u_xlat12.xy = vec2(u_xlat15) * in_TEXCOORD1.xy;
    vs_TEXCOORD0.xy = u_xlat2.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Diffuse1_ST.xy + _Diffuse1_ST.zw;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat15 * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UVDiffuse2==0.0);
#else
    u_xlatb15 = _UVDiffuse2==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat2.xy : u_xlat12.xy;
    vs_TEXCOORD2.xy = u_xlat1.xy * _Diffuse2_ST.xy + _Diffuse2_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UVDetail==0.0);
#else
    u_xlatb15 = _UVDetail==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat2.xy : u_xlat12.xy;
    vs_TEXCOORD2.zw = u_xlat1.xy * _DetailDiffuse_ST.xy + _DetailDiffuse_ST.zw;
    vs_TEXCOORD3.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz;
    vs_TEXCOORD3.y = u_xlat16_4.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat0.y;
    vs_TEXCOORD5.w = u_xlat0.z;
    vs_TEXCOORD4.y = u_xlat16_4.y;
    vs_TEXCOORD5.y = u_xlat16_4.z;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump float _HeightSpread;
uniform 	mediump float _HeightContrast;
uniform 	mediump float _UseTintColor;
uniform 	mediump float _UseDiffuseOneHeight;
uniform 	mediump float _UseGrassHeightBlend;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _SSAO_Intensity;
uniform 	mediump float _Terrain_Smoothness;
uniform 	mediump float _Terrain_Specular;
uniform 	mediump float _Shininess;
uniform 	mediump float _Diffuse2Distance;
uniform 	mediump float _Diffuse2Fade;
uniform lowp sampler2D _GrassNormal;
uniform lowp sampler2D _GrassDiffuse;
uniform lowp sampler2D _Normal0;
uniform lowp sampler2D _Normal2;
uniform lowp sampler2D _Diffuse1;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
mediump float u_xlat16_7;
lowp vec3 u_xlat10_7;
mediump float u_xlat16_14;
float u_xlat21;
mediump float u_xlat16_22;
mediump float u_xlat16_23;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_COLOR0.w<0.99000001);
#else
    u_xlatb0 = vs_COLOR0.w<0.99000001;
#endif
    if(u_xlatb0){
        u_xlat10_0.xyz = texture(_GrassNormal, vs_TEXCOORD0.xy, -1.0).xyz;
        u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat10_0.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.xy, -1.0).xyz;
        u_xlat16_2.xyz = u_xlat10_0.xyz;
    } else {
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
        u_xlat16_1.x = float(0.0);
        u_xlat16_1.y = float(0.0);
        u_xlat16_1.z = float(1.0);
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.00999999978<vs_COLOR0.w);
#else
    u_xlatb0 = 0.00999999978<vs_COLOR0.w;
#endif
    if(u_xlatb0){
        u_xlat0.x = vs_TEXCOORD3.w;
        u_xlat0.y = vs_TEXCOORD4.w;
        u_xlat0.z = vs_TEXCOORD5.w;
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = u_xlat0.x / _Diffuse2Distance;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = u_xlat0.x + 9.99999975e-05;
        u_xlat0.x = log2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * _Diffuse2Fade;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat0.x = min(u_xlat0.x, 1.0);
        u_xlat10_7.xyz = texture(_Normal0, vs_TEXCOORD0.zw, -1.0).xyz;
        u_xlat10_3.xy = texture(_Normal2, vs_TEXCOORD2.xy, -1.0).xy;
        u_xlat16_4.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_22 = (-u_xlat0.x) + 1.0;
        u_xlat16_4.xy = vec2(u_xlat16_22) * u_xlat16_4.xy;
        u_xlat16_4.xy = u_xlat16_4.xy * vs_COLOR0.xx;
        u_xlat10_3 = texture(_Diffuse1, vs_TEXCOORD0.zw, -1.0);
        u_xlat16_22 = u_xlat10_3.w * _UseDiffuseOneHeight;
        u_xlat16_5.xyz = u_xlat10_7.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, 0.0);
        u_xlat16_4.z = -1.0;
        u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
        u_xlat16_5.xyz = u_xlat10_3.xyz;
    } else {
        u_xlat16_5.x = float(0.0);
        u_xlat16_5.y = float(0.0);
        u_xlat16_5.z = float(0.0);
        u_xlat16_4.x = float(0.0);
        u_xlat16_4.y = float(0.0);
        u_xlat16_4.z = float(1.0);
        u_xlat16_22 = 1.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor);
#endif
    u_xlat16_6.xyz = u_xlat16_5.xyz * _TintColor.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb0)) ? u_xlat16_6.xyz : u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend);
#endif
    u_xlat16_7 = u_xlat16_22;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
    u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
    u_xlat16_14 = vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_22 = _HeightContrast * 10.0;
    u_xlat16_7 = u_xlat16_7 + -1.0;
    u_xlat16_23 = _HeightSpread + 0.100000001;
    u_xlat16_14 = log2(u_xlat16_14);
    u_xlat16_14 = u_xlat16_14 * u_xlat16_23;
    u_xlat16_14 = exp2(u_xlat16_14);
    u_xlat16_7 = u_xlat16_14 * 2.0 + u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
    u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
    u_xlat16_14 = _HeightContrast * 10.0 + 1.0;
    u_xlat16_14 = _HeightContrast * 10.0 + u_xlat16_14;
    u_xlat7 = u_xlat16_7 * u_xlat16_14 + (-u_xlat16_22);
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat16_22 = (u_xlatb0) ? u_xlat7 : vs_COLOR0.w;
    u_xlat16_4.xyz = (-u_xlat16_1.xyz) + u_xlat16_4.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_22) * u_xlat16_4.xyz + u_xlat16_1.xyz;
    u_xlat16_4.xyz = (-u_xlat16_2.xyz) + u_xlat16_5.xyz;
    u_xlat16_2.xyz = vec3(u_xlat16_22) * u_xlat16_4.xyz + u_xlat16_2.xyz;
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD5.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = _Terrain_Smoothness * _Shininess;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    SV_Target2.w = min(u_xlat16_1.x, 0.5);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(vec3(_Terrain_Specular, _Terrain_Specular, _Terrain_Specular));
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_22 = max(u_xlat16_1.z, u_xlat16_1.y);
    u_xlat16_22 = max(u_xlat16_22, u_xlat16_1.x);
    u_xlat16_22 = (-u_xlat16_22) + 1.0;
    SV_Target1.xyz = vec3(u_xlat16_22) * u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_22 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_22 : u_xlat16_1.z;
    SV_Target0.w = 0.0;
    SV_Target1.w = _SSAO_Intensity;
    SV_Target2.xy = u_xlat16_1.xy;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _Diffuse1_ST;
uniform 	float _UVDiffuse2;
uniform 	vec4 _Diffuse2_ST;
uniform 	float _UVDetail;
uniform 	vec4 _DetailDiffuse_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat7;
float u_xlat16;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x;
    u_xlat2.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].x;
    u_xlat2.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].x;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].y;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].y;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].y;
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.xy = sqrt(u_xlat2.xy);
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].z;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].z;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].z;
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat2.x = u_xlat7.x + u_xlat2.x;
    u_xlat2.x = u_xlat2.x * 0.330000013;
    u_xlat7.xy = u_xlat2.xx * in_TEXCOORD0.xy;
    u_xlat2.xw = u_xlat2.xx * in_TEXCOORD1.xy;
    vs_TEXCOORD0.xy = u_xlat7.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Diffuse1_ST.xy + _Diffuse1_ST.zw;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UVDiffuse2==0.0);
#else
    u_xlatb1 = _UVDiffuse2==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb1)) ? u_xlat7.xy : u_xlat2.xw;
    vs_TEXCOORD2.xy = u_xlat1.xy * _Diffuse2_ST.xy + _Diffuse2_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UVDetail==0.0);
#else
    u_xlatb1 = _UVDetail==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb1)) ? u_xlat7.xy : u_xlat2.xw;
    vs_TEXCOORD2.zw = u_xlat1.xy * _DetailDiffuse_ST.xy + _DetailDiffuse_ST.zw;
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat2.xyz = vec3(u_xlat0) * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_4.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = vec3(u_xlat0) * u_xlat16_4.xyz;
    vs_TEXCOORD3.y = u_xlat16_4.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD3.w = u_xlat5.x;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat5.y;
    vs_TEXCOORD5.w = u_xlat5.z;
    vs_TEXCOORD4.y = u_xlat16_4.y;
    vs_TEXCOORD5.y = u_xlat16_4.z;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump float _HeightSpread;
uniform 	mediump float _HeightContrast;
uniform 	mediump float _UseTintColor;
uniform 	mediump float _UseDiffuseOneHeight;
uniform 	mediump float _UseGrassHeightBlend;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _SSAO_Intensity;
uniform 	mediump float _Terrain_Smoothness;
uniform 	mediump float _Terrain_Specular;
uniform 	mediump float _Shininess;
uniform 	float _GrassNormalScale;
uniform 	float _Normal0Scale;
uniform 	mediump float _Normal2Scale;
uniform 	mediump float _Diffuse2Distance;
uniform 	mediump float _Diffuse2Fade;
uniform lowp sampler2D _GrassNormal;
uniform lowp sampler2D _GrassDiffuse;
uniform lowp sampler2D _Normal0;
uniform lowp sampler2D _Normal2;
uniform lowp sampler2D _Diffuse1;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec2 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
mediump float u_xlat16_7;
lowp vec3 u_xlat10_7;
mediump float u_xlat16_14;
float u_xlat21;
mediump float u_xlat16_22;
mediump float u_xlat16_23;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_COLOR0.w<0.99000001);
#else
    u_xlatb0 = vs_COLOR0.w<0.99000001;
#endif
    if(u_xlatb0){
        u_xlat10_0.xyz = texture(_GrassNormal, vs_TEXCOORD0.xy, -1.0).xyz;
        u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_1.xy = u_xlat16_1.xy * vec2(_GrassNormalScale);
        u_xlat10_0.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.xy, -1.0).xyz;
        u_xlat16_2.xyz = u_xlat10_0.xyz;
    } else {
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
        u_xlat16_1.x = float(0.0);
        u_xlat16_1.y = float(0.0);
        u_xlat16_1.z = float(1.0);
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.00999999978<vs_COLOR0.w);
#else
    u_xlatb0 = 0.00999999978<vs_COLOR0.w;
#endif
    if(u_xlatb0){
        u_xlat0.x = vs_TEXCOORD3.w;
        u_xlat0.y = vs_TEXCOORD4.w;
        u_xlat0.z = vs_TEXCOORD5.w;
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = u_xlat0.x / _Diffuse2Distance;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = u_xlat0.x + 9.99999975e-05;
        u_xlat0.x = log2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * _Diffuse2Fade;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat0.x = min(u_xlat0.x, 1.0);
        u_xlat10_7.xyz = texture(_Normal0, vs_TEXCOORD0.zw, -1.0).xyz;
        u_xlat10_3.xy = texture(_Normal2, vs_TEXCOORD2.xy, -1.0).xy;
        u_xlat16_4.z = u_xlat10_7.z + u_xlat10_7.z;
        u_xlat16_5.xy = u_xlat10_7.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_4.xy = u_xlat16_5.xy * vec2(_Normal0Scale);
        u_xlat16_5.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_5.xy = u_xlat16_5.xy * vec2(_Normal2Scale);
        u_xlat16_22 = (-u_xlat0.x) + 1.0;
        u_xlat16_5.xy = vec2(u_xlat16_22) * u_xlat16_5.xy;
        u_xlat16_5.xy = u_xlat16_5.xy * vs_COLOR0.xx;
        u_xlat10_0 = texture(_Diffuse1, vs_TEXCOORD0.zw, -1.0);
        u_xlat16_22 = u_xlat10_0.w * _UseDiffuseOneHeight;
        u_xlat16_5.z = -1.0;
        u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
        u_xlat16_5.xyz = u_xlat10_0.xyz;
    } else {
        u_xlat16_5.x = float(0.0);
        u_xlat16_5.y = float(0.0);
        u_xlat16_5.z = float(0.0);
        u_xlat16_4.x = float(0.0);
        u_xlat16_4.y = float(0.0);
        u_xlat16_4.z = float(1.0);
        u_xlat16_22 = 1.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor);
#endif
    u_xlat16_6.xyz = u_xlat16_5.xyz * _TintColor.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb0)) ? u_xlat16_6.xyz : u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend);
#endif
    u_xlat16_7 = u_xlat16_22;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
    u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
    u_xlat16_14 = vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_22 = _HeightContrast * 10.0;
    u_xlat16_7 = u_xlat16_7 + -1.0;
    u_xlat16_23 = _HeightSpread + 0.100000001;
    u_xlat16_14 = log2(u_xlat16_14);
    u_xlat16_14 = u_xlat16_14 * u_xlat16_23;
    u_xlat16_14 = exp2(u_xlat16_14);
    u_xlat16_7 = u_xlat16_14 * 2.0 + u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
    u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
    u_xlat16_14 = _HeightContrast * 10.0 + 1.0;
    u_xlat16_14 = _HeightContrast * 10.0 + u_xlat16_14;
    u_xlat7 = u_xlat16_7 * u_xlat16_14 + (-u_xlat16_22);
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat16_22 = (u_xlatb0) ? u_xlat7 : vs_COLOR0.w;
    u_xlat16_4.xyz = (-u_xlat16_1.xyz) + u_xlat16_4.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_22) * u_xlat16_4.xyz + u_xlat16_1.xyz;
    u_xlat16_4.xyz = (-u_xlat16_2.xyz) + u_xlat16_5.xyz;
    u_xlat16_2.xyz = vec3(u_xlat16_22) * u_xlat16_4.xyz + u_xlat16_2.xyz;
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD5.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = _Terrain_Smoothness * _Shininess;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    SV_Target2.w = min(u_xlat16_1.x, 0.5);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(vec3(_Terrain_Specular, _Terrain_Specular, _Terrain_Specular));
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_22 = max(u_xlat16_1.z, u_xlat16_1.y);
    u_xlat16_22 = max(u_xlat16_22, u_xlat16_1.x);
    u_xlat16_22 = (-u_xlat16_22) + 1.0;
    SV_Target1.xyz = vec3(u_xlat16_22) * u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_22 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_22 : u_xlat16_1.z;
    SV_Target0.w = 0.0;
    SV_Target1.w = _SSAO_Intensity;
    SV_Target2.xy = u_xlat16_1.xy;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _Diffuse1_ST;
uniform 	float _UVDiffuse2;
uniform 	vec4 _Diffuse2_ST;
uniform 	float _UVDetail;
uniform 	vec4 _DetailDiffuse_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec2 u_xlat12;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat15 = u_xlat15 + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat15 = u_xlat15 + u_xlat2.x;
    u_xlat15 = u_xlat15 * 0.330000013;
    u_xlat2.xy = vec2(u_xlat15) * in_TEXCOORD0.xy;
    u_xlat12.xy = vec2(u_xlat15) * in_TEXCOORD1.xy;
    vs_TEXCOORD0.xy = u_xlat2.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Diffuse1_ST.xy + _Diffuse1_ST.zw;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat15 * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UVDiffuse2==0.0);
#else
    u_xlatb15 = _UVDiffuse2==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat2.xy : u_xlat12.xy;
    vs_TEXCOORD2.xy = u_xlat1.xy * _Diffuse2_ST.xy + _Diffuse2_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UVDetail==0.0);
#else
    u_xlatb15 = _UVDetail==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat2.xy : u_xlat12.xy;
    vs_TEXCOORD2.zw = u_xlat1.xy * _DetailDiffuse_ST.xy + _DetailDiffuse_ST.zw;
    vs_TEXCOORD3.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz;
    vs_TEXCOORD3.y = u_xlat16_4.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat0.y;
    vs_TEXCOORD5.w = u_xlat0.z;
    vs_TEXCOORD4.y = u_xlat16_4.y;
    vs_TEXCOORD5.y = u_xlat16_4.z;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump float _HeightSpread;
uniform 	mediump float _HeightContrast;
uniform 	mediump float _UseTintColor;
uniform 	mediump float _UseDiffuseOneHeight;
uniform 	mediump float _UseGrassHeightBlend;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _SSAO_Intensity;
uniform 	mediump float _Terrain_Smoothness;
uniform 	mediump float _Terrain_Specular;
uniform 	mediump float _Shininess;
uniform 	mediump float _Diffuse2Distance;
uniform 	mediump float _Diffuse2Fade;
uniform lowp sampler2D _GrassNormal;
uniform lowp sampler2D _GrassDiffuse;
uniform lowp sampler2D _Normal0;
uniform lowp sampler2D _Normal2;
uniform lowp sampler2D _Diffuse1;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
mediump float u_xlat16_7;
lowp vec3 u_xlat10_7;
mediump float u_xlat16_14;
float u_xlat21;
mediump float u_xlat16_22;
mediump float u_xlat16_23;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_COLOR0.w<0.99000001);
#else
    u_xlatb0 = vs_COLOR0.w<0.99000001;
#endif
    if(u_xlatb0){
        u_xlat10_0.xyz = texture(_GrassNormal, vs_TEXCOORD0.xy).xyz;
        u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat10_0.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.xy).xyz;
        u_xlat16_2.xyz = u_xlat10_0.xyz;
    } else {
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
        u_xlat16_1.x = float(0.0);
        u_xlat16_1.y = float(0.0);
        u_xlat16_1.z = float(1.0);
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.00999999978<vs_COLOR0.w);
#else
    u_xlatb0 = 0.00999999978<vs_COLOR0.w;
#endif
    if(u_xlatb0){
        u_xlat0.x = vs_TEXCOORD3.w;
        u_xlat0.y = vs_TEXCOORD4.w;
        u_xlat0.z = vs_TEXCOORD5.w;
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = u_xlat0.x / _Diffuse2Distance;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = u_xlat0.x + 9.99999975e-05;
        u_xlat0.x = log2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * _Diffuse2Fade;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat0.x = min(u_xlat0.x, 1.0);
        u_xlat10_7.xyz = texture(_Normal0, vs_TEXCOORD0.zw).xyz;
        u_xlat10_3.xy = texture(_Normal2, vs_TEXCOORD2.xy).xy;
        u_xlat16_4.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_22 = (-u_xlat0.x) + 1.0;
        u_xlat16_4.xy = vec2(u_xlat16_22) * u_xlat16_4.xy;
        u_xlat16_4.xy = u_xlat16_4.xy * vs_COLOR0.xx;
        u_xlat10_3 = texture(_Diffuse1, vs_TEXCOORD0.zw);
        u_xlat16_22 = u_xlat10_3.w * _UseDiffuseOneHeight;
        u_xlat16_5.xyz = u_xlat10_7.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, 0.0);
        u_xlat16_4.z = -1.0;
        u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
        u_xlat16_5.xyz = u_xlat10_3.xyz;
    } else {
        u_xlat16_5.x = float(0.0);
        u_xlat16_5.y = float(0.0);
        u_xlat16_5.z = float(0.0);
        u_xlat16_4.x = float(0.0);
        u_xlat16_4.y = float(0.0);
        u_xlat16_4.z = float(1.0);
        u_xlat16_22 = 1.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor);
#endif
    u_xlat16_6.xyz = u_xlat16_5.xyz * _TintColor.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb0)) ? u_xlat16_6.xyz : u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend);
#endif
    u_xlat16_7 = u_xlat16_22;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
    u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
    u_xlat16_14 = vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_22 = _HeightContrast * 10.0;
    u_xlat16_7 = u_xlat16_7 + -1.0;
    u_xlat16_23 = _HeightSpread + 0.100000001;
    u_xlat16_14 = log2(u_xlat16_14);
    u_xlat16_14 = u_xlat16_14 * u_xlat16_23;
    u_xlat16_14 = exp2(u_xlat16_14);
    u_xlat16_7 = u_xlat16_14 * 2.0 + u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
    u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
    u_xlat16_14 = _HeightContrast * 10.0 + 1.0;
    u_xlat16_14 = _HeightContrast * 10.0 + u_xlat16_14;
    u_xlat7 = u_xlat16_7 * u_xlat16_14 + (-u_xlat16_22);
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat16_22 = (u_xlatb0) ? u_xlat7 : vs_COLOR0.w;
    u_xlat16_4.xyz = (-u_xlat16_1.xyz) + u_xlat16_4.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_22) * u_xlat16_4.xyz + u_xlat16_1.xyz;
    u_xlat16_4.xyz = (-u_xlat16_2.xyz) + u_xlat16_5.xyz;
    u_xlat16_2.xyz = vec3(u_xlat16_22) * u_xlat16_4.xyz + u_xlat16_2.xyz;
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD5.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = _Terrain_Smoothness * _Shininess;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    SV_Target2.w = min(u_xlat16_1.x, 0.5);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(vec3(_Terrain_Specular, _Terrain_Specular, _Terrain_Specular));
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_22 = max(u_xlat16_1.z, u_xlat16_1.y);
    u_xlat16_22 = max(u_xlat16_22, u_xlat16_1.x);
    u_xlat16_22 = (-u_xlat16_22) + 1.0;
    SV_Target1.xyz = vec3(u_xlat16_22) * u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_22 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_22 : u_xlat16_1.z;
    SV_Target0.w = 0.0;
    SV_Target1.w = _SSAO_Intensity;
    SV_Target2.xy = u_xlat16_1.xy;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _Diffuse1_ST;
uniform 	float _UVDiffuse2;
uniform 	vec4 _Diffuse2_ST;
uniform 	float _UVDetail;
uniform 	vec4 _DetailDiffuse_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat7;
float u_xlat16;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x;
    u_xlat2.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].x;
    u_xlat2.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].x;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].y;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].y;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].y;
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.xy = sqrt(u_xlat2.xy);
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].z;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].z;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].z;
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat2.x = u_xlat7.x + u_xlat2.x;
    u_xlat2.x = u_xlat2.x * 0.330000013;
    u_xlat7.xy = u_xlat2.xx * in_TEXCOORD0.xy;
    u_xlat2.xw = u_xlat2.xx * in_TEXCOORD1.xy;
    vs_TEXCOORD0.xy = u_xlat7.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Diffuse1_ST.xy + _Diffuse1_ST.zw;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UVDiffuse2==0.0);
#else
    u_xlatb1 = _UVDiffuse2==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb1)) ? u_xlat7.xy : u_xlat2.xw;
    vs_TEXCOORD2.xy = u_xlat1.xy * _Diffuse2_ST.xy + _Diffuse2_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UVDetail==0.0);
#else
    u_xlatb1 = _UVDetail==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb1)) ? u_xlat7.xy : u_xlat2.xw;
    vs_TEXCOORD2.zw = u_xlat1.xy * _DetailDiffuse_ST.xy + _DetailDiffuse_ST.zw;
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat2.xyz = vec3(u_xlat0) * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_4.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = vec3(u_xlat0) * u_xlat16_4.xyz;
    vs_TEXCOORD3.y = u_xlat16_4.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD3.w = u_xlat5.x;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat5.y;
    vs_TEXCOORD5.w = u_xlat5.z;
    vs_TEXCOORD4.y = u_xlat16_4.y;
    vs_TEXCOORD5.y = u_xlat16_4.z;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump float _HeightSpread;
uniform 	mediump float _HeightContrast;
uniform 	mediump float _UseTintColor;
uniform 	mediump float _UseDiffuseOneHeight;
uniform 	mediump float _UseGrassHeightBlend;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _SSAO_Intensity;
uniform 	mediump float _Terrain_Smoothness;
uniform 	mediump float _Terrain_Specular;
uniform 	mediump float _Shininess;
uniform 	float _GrassNormalScale;
uniform 	float _Normal0Scale;
uniform 	mediump float _Normal2Scale;
uniform 	mediump float _Diffuse2Distance;
uniform 	mediump float _Diffuse2Fade;
uniform lowp sampler2D _GrassNormal;
uniform lowp sampler2D _GrassDiffuse;
uniform lowp sampler2D _Normal0;
uniform lowp sampler2D _Normal2;
uniform lowp sampler2D _Diffuse1;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec2 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
mediump float u_xlat16_7;
lowp vec3 u_xlat10_7;
mediump float u_xlat16_14;
float u_xlat21;
mediump float u_xlat16_22;
mediump float u_xlat16_23;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_COLOR0.w<0.99000001);
#else
    u_xlatb0 = vs_COLOR0.w<0.99000001;
#endif
    if(u_xlatb0){
        u_xlat10_0.xyz = texture(_GrassNormal, vs_TEXCOORD0.xy).xyz;
        u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_1.xy = u_xlat16_1.xy * vec2(_GrassNormalScale);
        u_xlat10_0.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.xy).xyz;
        u_xlat16_2.xyz = u_xlat10_0.xyz;
    } else {
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
        u_xlat16_1.x = float(0.0);
        u_xlat16_1.y = float(0.0);
        u_xlat16_1.z = float(1.0);
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.00999999978<vs_COLOR0.w);
#else
    u_xlatb0 = 0.00999999978<vs_COLOR0.w;
#endif
    if(u_xlatb0){
        u_xlat0.x = vs_TEXCOORD3.w;
        u_xlat0.y = vs_TEXCOORD4.w;
        u_xlat0.z = vs_TEXCOORD5.w;
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = u_xlat0.x / _Diffuse2Distance;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = u_xlat0.x + 9.99999975e-05;
        u_xlat0.x = log2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * _Diffuse2Fade;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat0.x = min(u_xlat0.x, 1.0);
        u_xlat10_7.xyz = texture(_Normal0, vs_TEXCOORD0.zw).xyz;
        u_xlat10_3.xy = texture(_Normal2, vs_TEXCOORD2.xy).xy;
        u_xlat16_4.z = u_xlat10_7.z + u_xlat10_7.z;
        u_xlat16_5.xy = u_xlat10_7.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_4.xy = u_xlat16_5.xy * vec2(_Normal0Scale);
        u_xlat16_5.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_5.xy = u_xlat16_5.xy * vec2(_Normal2Scale);
        u_xlat16_22 = (-u_xlat0.x) + 1.0;
        u_xlat16_5.xy = vec2(u_xlat16_22) * u_xlat16_5.xy;
        u_xlat16_5.xy = u_xlat16_5.xy * vs_COLOR0.xx;
        u_xlat10_0 = texture(_Diffuse1, vs_TEXCOORD0.zw);
        u_xlat16_22 = u_xlat10_0.w * _UseDiffuseOneHeight;
        u_xlat16_5.z = -1.0;
        u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
        u_xlat16_5.xyz = u_xlat10_0.xyz;
    } else {
        u_xlat16_5.x = float(0.0);
        u_xlat16_5.y = float(0.0);
        u_xlat16_5.z = float(0.0);
        u_xlat16_4.x = float(0.0);
        u_xlat16_4.y = float(0.0);
        u_xlat16_4.z = float(1.0);
        u_xlat16_22 = 1.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor);
#endif
    u_xlat16_6.xyz = u_xlat16_5.xyz * _TintColor.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb0)) ? u_xlat16_6.xyz : u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend);
#endif
    u_xlat16_7 = u_xlat16_22;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
    u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
    u_xlat16_14 = vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_22 = _HeightContrast * 10.0;
    u_xlat16_7 = u_xlat16_7 + -1.0;
    u_xlat16_23 = _HeightSpread + 0.100000001;
    u_xlat16_14 = log2(u_xlat16_14);
    u_xlat16_14 = u_xlat16_14 * u_xlat16_23;
    u_xlat16_14 = exp2(u_xlat16_14);
    u_xlat16_7 = u_xlat16_14 * 2.0 + u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
    u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
    u_xlat16_14 = _HeightContrast * 10.0 + 1.0;
    u_xlat16_14 = _HeightContrast * 10.0 + u_xlat16_14;
    u_xlat7 = u_xlat16_7 * u_xlat16_14 + (-u_xlat16_22);
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat16_22 = (u_xlatb0) ? u_xlat7 : vs_COLOR0.w;
    u_xlat16_4.xyz = (-u_xlat16_1.xyz) + u_xlat16_4.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_22) * u_xlat16_4.xyz + u_xlat16_1.xyz;
    u_xlat16_4.xyz = (-u_xlat16_2.xyz) + u_xlat16_5.xyz;
    u_xlat16_2.xyz = vec3(u_xlat16_22) * u_xlat16_4.xyz + u_xlat16_2.xyz;
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD5.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = _Terrain_Smoothness * _Shininess;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    SV_Target2.w = min(u_xlat16_1.x, 0.5);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(vec3(_Terrain_Specular, _Terrain_Specular, _Terrain_Specular));
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_22 = max(u_xlat16_1.z, u_xlat16_1.y);
    u_xlat16_22 = max(u_xlat16_22, u_xlat16_1.x);
    u_xlat16_22 = (-u_xlat16_22) + 1.0;
    SV_Target1.xyz = vec3(u_xlat16_22) * u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_22 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_22 : u_xlat16_1.z;
    SV_Target0.w = 0.0;
    SV_Target1.w = _SSAO_Intensity;
    SV_Target2.xy = u_xlat16_1.xy;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "LINE_INTERPOLATION" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _Diffuse1_ST;
uniform 	float _UVDiffuse2;
uniform 	vec4 _Diffuse2_ST;
uniform 	float _UVDetail;
uniform 	vec4 _DetailDiffuse_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec2 u_xlat12;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat15 = u_xlat15 + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat15 = u_xlat15 + u_xlat2.x;
    u_xlat15 = u_xlat15 * 0.330000013;
    u_xlat2.xy = vec2(u_xlat15) * in_TEXCOORD0.xy;
    u_xlat12.xy = vec2(u_xlat15) * in_TEXCOORD1.xy;
    vs_TEXCOORD0.xy = u_xlat2.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Diffuse1_ST.xy + _Diffuse1_ST.zw;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat15 * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UVDiffuse2==0.0);
#else
    u_xlatb15 = _UVDiffuse2==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat2.xy : u_xlat12.xy;
    vs_TEXCOORD2.xy = u_xlat1.xy * _Diffuse2_ST.xy + _Diffuse2_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UVDetail==0.0);
#else
    u_xlatb15 = _UVDetail==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat2.xy : u_xlat12.xy;
    vs_TEXCOORD2.zw = u_xlat1.xy * _DetailDiffuse_ST.xy + _DetailDiffuse_ST.zw;
    vs_TEXCOORD3.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz;
    vs_TEXCOORD3.y = u_xlat16_4.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat0.y;
    vs_TEXCOORD5.w = u_xlat0.z;
    vs_TEXCOORD4.y = u_xlat16_4.y;
    vs_TEXCOORD5.y = u_xlat16_4.z;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump float _HeightSpread;
uniform 	mediump float _HeightContrast;
uniform 	mediump float _UseTintColor;
uniform 	mediump float _UseDiffuseOneHeight;
uniform 	mediump float _UseGrassHeightBlend;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _SSAO_Intensity;
uniform 	mediump float _Terrain_Smoothness;
uniform 	mediump float _Terrain_Specular;
uniform 	mediump float _Shininess;
uniform 	mediump float _Diffuse2Distance;
uniform 	mediump float _Diffuse2Fade;
uniform lowp sampler2D _GrassNormal;
uniform lowp sampler2D _GrassDiffuse;
uniform lowp sampler2D _Normal0;
uniform lowp sampler2D _Normal2;
uniform lowp sampler2D _Diffuse1;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
mediump float u_xlat16_7;
lowp vec3 u_xlat10_7;
mediump float u_xlat16_14;
float u_xlat21;
mediump float u_xlat16_22;
mediump float u_xlat16_23;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_COLOR0.w<0.99000001);
#else
    u_xlatb0 = vs_COLOR0.w<0.99000001;
#endif
    if(u_xlatb0){
        u_xlat10_0.xyz = texture(_GrassNormal, vs_TEXCOORD0.xy, -1.0).xyz;
        u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat10_0.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.xy, -1.0).xyz;
        u_xlat16_2.xyz = u_xlat10_0.xyz;
    } else {
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
        u_xlat16_1.x = float(0.0);
        u_xlat16_1.y = float(0.0);
        u_xlat16_1.z = float(1.0);
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.00999999978<vs_COLOR0.w);
#else
    u_xlatb0 = 0.00999999978<vs_COLOR0.w;
#endif
    if(u_xlatb0){
        u_xlat0.x = vs_TEXCOORD3.w;
        u_xlat0.y = vs_TEXCOORD4.w;
        u_xlat0.z = vs_TEXCOORD5.w;
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = u_xlat0.x / _Diffuse2Distance;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = u_xlat0.x + 9.99999975e-05;
        u_xlat0.x = log2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * _Diffuse2Fade;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat0.x = min(u_xlat0.x, 1.0);
        u_xlat10_7.xyz = texture(_Normal0, vs_TEXCOORD0.zw, -1.0).xyz;
        u_xlat10_3.xy = texture(_Normal2, vs_TEXCOORD2.xy, -1.0).xy;
        u_xlat16_4.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_22 = (-u_xlat0.x) + 1.0;
        u_xlat16_4.xy = vec2(u_xlat16_22) * u_xlat16_4.xy;
        u_xlat16_4.xy = u_xlat16_4.xy * vs_COLOR0.xx;
        u_xlat10_3 = texture(_Diffuse1, vs_TEXCOORD0.zw, -1.0);
        u_xlat16_22 = u_xlat10_3.w * _UseDiffuseOneHeight;
        u_xlat16_5.xyz = u_xlat10_7.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, 0.0);
        u_xlat16_4.z = -1.0;
        u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
        u_xlat16_5.xyz = u_xlat10_3.xyz;
    } else {
        u_xlat16_5.x = float(0.0);
        u_xlat16_5.y = float(0.0);
        u_xlat16_5.z = float(0.0);
        u_xlat16_4.x = float(0.0);
        u_xlat16_4.y = float(0.0);
        u_xlat16_4.z = float(1.0);
        u_xlat16_22 = 1.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor);
#endif
    u_xlat16_6.xyz = u_xlat16_5.xyz * _TintColor.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb0)) ? u_xlat16_6.xyz : u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend);
#endif
    u_xlat16_7 = u_xlat16_22;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
    u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
    u_xlat16_14 = vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_22 = _HeightContrast * 10.0;
    u_xlat16_7 = u_xlat16_7 + -1.0;
    u_xlat16_23 = _HeightSpread + 0.100000001;
    u_xlat16_14 = log2(u_xlat16_14);
    u_xlat16_14 = u_xlat16_14 * u_xlat16_23;
    u_xlat16_14 = exp2(u_xlat16_14);
    u_xlat16_7 = u_xlat16_14 * 2.0 + u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
    u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
    u_xlat16_14 = _HeightContrast * 10.0 + 1.0;
    u_xlat16_14 = _HeightContrast * 10.0 + u_xlat16_14;
    u_xlat7 = u_xlat16_7 * u_xlat16_14 + (-u_xlat16_22);
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat16_22 = (u_xlatb0) ? u_xlat7 : vs_COLOR0.w;
    u_xlat16_4.xyz = (-u_xlat16_1.xyz) + u_xlat16_4.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_22) * u_xlat16_4.xyz + u_xlat16_1.xyz;
    u_xlat16_4.xyz = (-u_xlat16_2.xyz) + u_xlat16_5.xyz;
    u_xlat16_2.xyz = vec3(u_xlat16_22) * u_xlat16_4.xyz + u_xlat16_2.xyz;
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD5.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = _Terrain_Smoothness * _Shininess;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    SV_Target2.w = min(u_xlat16_1.x, 0.5);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(vec3(_Terrain_Specular, _Terrain_Specular, _Terrain_Specular));
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_22 = max(u_xlat16_1.z, u_xlat16_1.y);
    u_xlat16_22 = max(u_xlat16_22, u_xlat16_1.x);
    u_xlat16_22 = (-u_xlat16_22) + 1.0;
    SV_Target1.xyz = vec3(u_xlat16_22) * u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_22 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_22 : u_xlat16_1.z;
    SV_Target0.w = 0.0;
    SV_Target1.w = _SSAO_Intensity;
    SV_Target2.xy = u_xlat16_1.xy;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "LINE_INTERPOLATION" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _Diffuse1_ST;
uniform 	float _UVDiffuse2;
uniform 	vec4 _Diffuse2_ST;
uniform 	float _UVDetail;
uniform 	vec4 _DetailDiffuse_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat7;
float u_xlat16;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x;
    u_xlat2.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].x;
    u_xlat2.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].x;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].y;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].y;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].y;
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.xy = sqrt(u_xlat2.xy);
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].z;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].z;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].z;
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat2.x = u_xlat7.x + u_xlat2.x;
    u_xlat2.x = u_xlat2.x * 0.330000013;
    u_xlat7.xy = u_xlat2.xx * in_TEXCOORD0.xy;
    u_xlat2.xw = u_xlat2.xx * in_TEXCOORD1.xy;
    vs_TEXCOORD0.xy = u_xlat7.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Diffuse1_ST.xy + _Diffuse1_ST.zw;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UVDiffuse2==0.0);
#else
    u_xlatb1 = _UVDiffuse2==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb1)) ? u_xlat7.xy : u_xlat2.xw;
    vs_TEXCOORD2.xy = u_xlat1.xy * _Diffuse2_ST.xy + _Diffuse2_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UVDetail==0.0);
#else
    u_xlatb1 = _UVDetail==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb1)) ? u_xlat7.xy : u_xlat2.xw;
    vs_TEXCOORD2.zw = u_xlat1.xy * _DetailDiffuse_ST.xy + _DetailDiffuse_ST.zw;
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat2.xyz = vec3(u_xlat0) * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_4.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = vec3(u_xlat0) * u_xlat16_4.xyz;
    vs_TEXCOORD3.y = u_xlat16_4.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD3.w = u_xlat5.x;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat5.y;
    vs_TEXCOORD5.w = u_xlat5.z;
    vs_TEXCOORD4.y = u_xlat16_4.y;
    vs_TEXCOORD5.y = u_xlat16_4.z;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump float _HeightSpread;
uniform 	mediump float _HeightContrast;
uniform 	mediump float _UseTintColor;
uniform 	mediump float _UseDiffuseOneHeight;
uniform 	mediump float _UseGrassHeightBlend;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _SSAO_Intensity;
uniform 	mediump float _Terrain_Smoothness;
uniform 	mediump float _Terrain_Specular;
uniform 	mediump float _Shininess;
uniform 	float _GrassNormalScale;
uniform 	float _Normal0Scale;
uniform 	mediump float _Normal2Scale;
uniform 	mediump float _Diffuse2Distance;
uniform 	mediump float _Diffuse2Fade;
uniform lowp sampler2D _GrassNormal;
uniform lowp sampler2D _GrassDiffuse;
uniform lowp sampler2D _Normal0;
uniform lowp sampler2D _Normal2;
uniform lowp sampler2D _Diffuse1;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec2 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
mediump float u_xlat16_7;
lowp vec3 u_xlat10_7;
mediump float u_xlat16_14;
float u_xlat21;
mediump float u_xlat16_22;
mediump float u_xlat16_23;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_COLOR0.w<0.99000001);
#else
    u_xlatb0 = vs_COLOR0.w<0.99000001;
#endif
    if(u_xlatb0){
        u_xlat10_0.xyz = texture(_GrassNormal, vs_TEXCOORD0.xy, -1.0).xyz;
        u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_1.xy = u_xlat16_1.xy * vec2(_GrassNormalScale);
        u_xlat10_0.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.xy, -1.0).xyz;
        u_xlat16_2.xyz = u_xlat10_0.xyz;
    } else {
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
        u_xlat16_1.x = float(0.0);
        u_xlat16_1.y = float(0.0);
        u_xlat16_1.z = float(1.0);
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.00999999978<vs_COLOR0.w);
#else
    u_xlatb0 = 0.00999999978<vs_COLOR0.w;
#endif
    if(u_xlatb0){
        u_xlat0.x = vs_TEXCOORD3.w;
        u_xlat0.y = vs_TEXCOORD4.w;
        u_xlat0.z = vs_TEXCOORD5.w;
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = u_xlat0.x / _Diffuse2Distance;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = u_xlat0.x + 9.99999975e-05;
        u_xlat0.x = log2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * _Diffuse2Fade;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat0.x = min(u_xlat0.x, 1.0);
        u_xlat10_7.xyz = texture(_Normal0, vs_TEXCOORD0.zw, -1.0).xyz;
        u_xlat10_3.xy = texture(_Normal2, vs_TEXCOORD2.xy, -1.0).xy;
        u_xlat16_4.z = u_xlat10_7.z + u_xlat10_7.z;
        u_xlat16_5.xy = u_xlat10_7.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_4.xy = u_xlat16_5.xy * vec2(_Normal0Scale);
        u_xlat16_5.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_5.xy = u_xlat16_5.xy * vec2(_Normal2Scale);
        u_xlat16_22 = (-u_xlat0.x) + 1.0;
        u_xlat16_5.xy = vec2(u_xlat16_22) * u_xlat16_5.xy;
        u_xlat16_5.xy = u_xlat16_5.xy * vs_COLOR0.xx;
        u_xlat10_0 = texture(_Diffuse1, vs_TEXCOORD0.zw, -1.0);
        u_xlat16_22 = u_xlat10_0.w * _UseDiffuseOneHeight;
        u_xlat16_5.z = -1.0;
        u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
        u_xlat16_5.xyz = u_xlat10_0.xyz;
    } else {
        u_xlat16_5.x = float(0.0);
        u_xlat16_5.y = float(0.0);
        u_xlat16_5.z = float(0.0);
        u_xlat16_4.x = float(0.0);
        u_xlat16_4.y = float(0.0);
        u_xlat16_4.z = float(1.0);
        u_xlat16_22 = 1.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor);
#endif
    u_xlat16_6.xyz = u_xlat16_5.xyz * _TintColor.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb0)) ? u_xlat16_6.xyz : u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend);
#endif
    u_xlat16_7 = u_xlat16_22;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
    u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
    u_xlat16_14 = vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_22 = _HeightContrast * 10.0;
    u_xlat16_7 = u_xlat16_7 + -1.0;
    u_xlat16_23 = _HeightSpread + 0.100000001;
    u_xlat16_14 = log2(u_xlat16_14);
    u_xlat16_14 = u_xlat16_14 * u_xlat16_23;
    u_xlat16_14 = exp2(u_xlat16_14);
    u_xlat16_7 = u_xlat16_14 * 2.0 + u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
    u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
    u_xlat16_14 = _HeightContrast * 10.0 + 1.0;
    u_xlat16_14 = _HeightContrast * 10.0 + u_xlat16_14;
    u_xlat7 = u_xlat16_7 * u_xlat16_14 + (-u_xlat16_22);
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat16_22 = (u_xlatb0) ? u_xlat7 : vs_COLOR0.w;
    u_xlat16_4.xyz = (-u_xlat16_1.xyz) + u_xlat16_4.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_22) * u_xlat16_4.xyz + u_xlat16_1.xyz;
    u_xlat16_4.xyz = (-u_xlat16_2.xyz) + u_xlat16_5.xyz;
    u_xlat16_2.xyz = vec3(u_xlat16_22) * u_xlat16_4.xyz + u_xlat16_2.xyz;
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD5.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = _Terrain_Smoothness * _Shininess;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    SV_Target2.w = min(u_xlat16_1.x, 0.5);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(vec3(_Terrain_Specular, _Terrain_Specular, _Terrain_Specular));
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_22 = max(u_xlat16_1.z, u_xlat16_1.y);
    u_xlat16_22 = max(u_xlat16_22, u_xlat16_1.x);
    u_xlat16_22 = (-u_xlat16_22) + 1.0;
    SV_Target1.xyz = vec3(u_xlat16_22) * u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_22 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_22 : u_xlat16_1.z;
    SV_Target0.w = 0.0;
    SV_Target1.w = _SSAO_Intensity;
    SV_Target2.xy = u_xlat16_1.xy;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _Diffuse1_ST;
uniform 	float _UVDiffuse2;
uniform 	vec4 _Diffuse2_ST;
uniform 	float _UVDetail;
uniform 	vec4 _DetailDiffuse_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec2 u_xlat12;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat15 = u_xlat15 + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat15 = u_xlat15 + u_xlat2.x;
    u_xlat15 = u_xlat15 * 0.330000013;
    u_xlat2.xy = vec2(u_xlat15) * in_TEXCOORD0.xy;
    u_xlat12.xy = vec2(u_xlat15) * in_TEXCOORD1.xy;
    vs_TEXCOORD0.xy = u_xlat2.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Diffuse1_ST.xy + _Diffuse1_ST.zw;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat15 * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UVDiffuse2==0.0);
#else
    u_xlatb15 = _UVDiffuse2==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat2.xy : u_xlat12.xy;
    vs_TEXCOORD2.xy = u_xlat1.xy * _Diffuse2_ST.xy + _Diffuse2_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UVDetail==0.0);
#else
    u_xlatb15 = _UVDetail==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat2.xy : u_xlat12.xy;
    vs_TEXCOORD2.zw = u_xlat1.xy * _DetailDiffuse_ST.xy + _DetailDiffuse_ST.zw;
    vs_TEXCOORD3.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz;
    vs_TEXCOORD3.y = u_xlat16_4.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat0.y;
    vs_TEXCOORD5.w = u_xlat0.z;
    vs_TEXCOORD4.y = u_xlat16_4.y;
    vs_TEXCOORD5.y = u_xlat16_4.z;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _ScreenParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	mediump float _HeightSpread;
uniform 	mediump float _HeightContrast;
uniform 	mediump float _UseTintColor;
uniform 	mediump float _UseDiffuseOneHeight;
uniform 	mediump float _UseGrassHeightBlend;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _SSAO_Intensity;
uniform 	mediump float _Terrain_Smoothness;
uniform 	mediump float _Terrain_Specular;
uniform 	mediump float _Shininess;
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _GrassDiffuse_TexelSize;
uniform 	vec4 _GrassNormal_TexelSize;
uniform 	vec4 _Diffuse1_ST;
uniform 	vec4 _Diffuse1_TexelSize;
uniform 	vec4 _Normal0_TexelSize;
uniform 	vec4 _Diffuse2_ST;
uniform 	vec4 _Diffuse2_TexelSize;
uniform 	vec4 _Normal2_TexelSize;
uniform 	mediump float _Diffuse2Distance;
uniform 	mediump float _Diffuse2Fade;
uniform lowp sampler2D _GrassDiffuse;
uniform lowp sampler2D _GrassNormal;
uniform lowp sampler2D _Normal0;
uniform lowp sampler2D _Normal2;
uniform lowp sampler2D _Diffuse1;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
bvec2 u_xlatb2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
bvec2 u_xlatb4;
vec3 u_xlat5;
bvec4 u_xlatb5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
mediump float u_xlat16_12;
lowp vec3 u_xlat10_12;
bvec3 u_xlatb12;
float u_xlat13;
vec3 u_xlat14;
vec3 u_xlat15;
vec3 u_xlat16;
vec2 u_xlat24;
mediump float u_xlat16_24;
bvec2 u_xlatb24;
vec2 u_xlat25;
vec2 u_xlat26;
vec2 u_xlat27;
float u_xlat28;
float u_xlat36;
bool u_xlatb36;
float u_xlat37;
float u_xlat38;
float u_xlat39;
mediump float u_xlat16_43;
mediump float u_xlat16_44;
void main()
{
    u_xlat0.x = vs_TEXCOORD3.w;
    u_xlat0.y = vs_TEXCOORD4.w;
    u_xlat0.z = vs_TEXCOORD5.w;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x / _Diffuse2Distance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + 9.99999975e-05;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Diffuse2Fade;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat1.zw = vec2(vs_TEXCOORD0.z + (-_Diffuse1_ST.z), vs_TEXCOORD0.w + (-_Diffuse1_ST.w));
    u_xlat12.xy = vec2(_Diffuse1_ST.x * _Diffuse1_TexelSize.z, _Diffuse1_ST.y * _Diffuse1_TexelSize.w);
    u_xlatb12.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat12.xyxx).xy;
    u_xlatb12.x = u_xlatb12.y || u_xlatb12.x;
    u_xlat1.xy = _Diffuse1_TexelSize.zw;
    u_xlat2 = (u_xlatb12.x) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
    u_xlat24.xy = vec2(_Diffuse1_ST.x * _Normal0_TexelSize.z, _Diffuse1_ST.y * _Normal0_TexelSize.w);
    u_xlatb24.xy = lessThan(vec4(1.0, 1.0, 1.0, 1.0), u_xlat24.xyxy).xy;
    u_xlatb24.x = u_xlatb24.y || u_xlatb24.x;
    u_xlat1.xy = _Normal0_TexelSize.zw;
    u_xlat1 = (u_xlatb24.x) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb36 = !!(u_xlat0.x<0.800000012);
#else
    u_xlatb36 = u_xlat0.x<0.800000012;
#endif
    if(u_xlatb36){
        u_xlat12.xz = (u_xlatb12.x) ? _Diffuse1_ST.xy : vec2(1.0, 1.0);
        u_xlat3.xy = (u_xlatb24.x) ? _Diffuse1_ST.xy : vec2(1.0, 1.0);
        u_xlat4.zw = vec2(vs_TEXCOORD2.x + (-_Diffuse2_ST.z), vs_TEXCOORD2.y + (-_Diffuse2_ST.w));
        u_xlat12.xy = u_xlat12.xz * u_xlat2.xy;
        u_xlat27.xy = vec2(_Diffuse2_ST.x * _Diffuse2_TexelSize.z, _Diffuse2_ST.y * _Diffuse2_TexelSize.w);
        u_xlatb12.xy = lessThan(u_xlat12.xyxx, u_xlat27.xyxx).xy;
        u_xlatb12.x = u_xlatb12.y || u_xlatb12.x;
        u_xlat4.xy = _Diffuse2_TexelSize.zw;
        u_xlat2 = (u_xlatb12.x) ? u_xlat4 : u_xlat2;
        u_xlat12.xy = u_xlat1.xy * u_xlat3.xy;
        u_xlat3.xy = vec2(_Diffuse2_ST.x * _Normal2_TexelSize.z, _Diffuse2_ST.y * _Normal2_TexelSize.w);
        u_xlatb12.xy = lessThan(u_xlat12.xyxx, u_xlat3.xyxx).xy;
        u_xlatb12.x = u_xlatb12.y || u_xlatb12.x;
        u_xlat4.xy = _Normal2_TexelSize.zw;
        u_xlat1 = (u_xlatb12.x) ? u_xlat4 : u_xlat1;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb12.x = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb12.x = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb12.x){
        u_xlatb12.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.899999976), vec4(_LODIndex)).xyz;
        u_xlat3 = (u_xlatb12.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat3 = (u_xlatb12.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat3;
        u_xlat3 = (u_xlatb12.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat3;
        SV_Target0 = u_xlat3;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb12.x = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb12.x = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb12.x){
        u_xlat10_12.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.xy).xyz;
        SV_Target0.xyz = u_xlat10_12.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb12.x = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb12.x = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb12.x){
        u_xlat12.x = max(_GrassDiffuse_TexelSize.w, _GrassDiffuse_TexelSize.z);
        u_xlat12.x = max(u_xlat12.x, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb24.x = !!(256.0<u_xlat12.x);
#else
        u_xlatb24.x = 256.0<u_xlat12.x;
#endif
        u_xlatb12.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 1024.0), u_xlat12.xxxx).xz;
        u_xlat3 = (u_xlatb12.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat3 = (u_xlatb12.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat3;
        u_xlat3 = (u_xlatb24.x) ? u_xlat3 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat3;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb12.x = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb12.x = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb12.x){
        u_xlat12.xy = vec2(vs_TEXCOORD0.x * _GrassDiffuse_TexelSize.z, vs_TEXCOORD0.y * _GrassDiffuse_TexelSize.w);
        u_xlat3.xy = dFdx(u_xlat12.xy);
        u_xlat12.xy = dFdy(u_xlat12.xy);
        u_xlat36 = dot(u_xlat3.xy, u_xlat3.xy);
        u_xlat12.x = dot(u_xlat12.xy, u_xlat12.xy);
        u_xlat12.x = max(u_xlat12.x, u_xlat36);
        u_xlat12.x = log2(u_xlat12.x);
        u_xlat12.x = u_xlat12.x * 0.5;
        u_xlat12.x = max(u_xlat12.x, 0.0);
        u_xlat12.x = u_xlat12.x + 1.0;
        u_xlat24.x = max(_GrassDiffuse_TexelSize.w, _GrassDiffuse_TexelSize.z);
        u_xlat12.x = u_xlat24.x / u_xlat12.x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb24.x = !!(256.0<u_xlat12.x);
#else
        u_xlatb24.x = 256.0<u_xlat12.x;
#endif
        u_xlatb12.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 1024.0), u_xlat12.xxxx).xz;
        u_xlat3 = (u_xlatb12.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat3 = (u_xlatb12.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat3;
        u_xlat3 = (u_xlatb24.x) ? u_xlat3 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat3;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb12.x = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb12.x = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb12.x){
        u_xlat3.zw = vec2(vs_TEXCOORD0.x + (-_GrassDiffuse_ST.z), vs_TEXCOORD0.y + (-_GrassDiffuse_ST.w));
        u_xlat12.xy = vec2(_GrassDiffuse_ST.x * _GrassDiffuse_TexelSize.z, _GrassDiffuse_ST.y * _GrassDiffuse_TexelSize.w);
        u_xlatb12.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat12.xyxx).xy;
        u_xlatb12.x = u_xlatb12.y || u_xlatb12.x;
        u_xlat3.xy = _GrassDiffuse_TexelSize.zw;
        u_xlat4 = (u_xlatb12.x) ? u_xlat3 : vec4(1.0, 1.0, 0.0, 0.0);
        u_xlat2 = u_xlat2 + (-u_xlat4);
        u_xlat2 = vs_COLOR0.wwww * u_xlat2 + u_xlat4;
#ifdef UNITY_ADRENO_ES3
        u_xlatb12.x = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb12.x = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb12.x){
            u_xlat12.xy = vec2(u_xlat2.x * u_xlat2.z, u_xlat2.y * u_xlat2.w);
            u_xlat4.xy = dFdx(u_xlat12.xy);
            u_xlat12.xy = dFdy(u_xlat12.xy);
            u_xlat36 = dot(u_xlat4.xy, u_xlat4.xy);
            u_xlat28 = dot(u_xlat12.xy, u_xlat12.xy);
            u_xlat36 = max(u_xlat36, u_xlat28);
            u_xlat36 = log2(u_xlat36);
            u_xlat36 = u_xlat36 * 0.5;
            u_xlat36 = max(u_xlat36, 0.0);
            u_xlat36 = u_xlat36 + 1.0;
            u_xlat28 = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat4.xy = vec2(u_xlat28) * u_xlat4.xy;
            u_xlat12.xy = u_xlat12.xy * vec2(u_xlat28);
            u_xlat4.xy = u_xlat4.xy / vec2(u_xlat36);
            u_xlat12.xy = u_xlat12.xy / vec2(u_xlat36);
            u_xlat24.y = dot(abs(u_xlat4.xy), abs(u_xlat4.xy));
            u_xlat24.x = dot(abs(u_xlat12.xy), abs(u_xlat12.xy));
            u_xlat16.xy = sqrt(u_xlat24.yx);
            u_xlat36 = inversesqrt(u_xlat24.y);
            u_xlat36 = u_xlat36 * abs(u_xlat4.x);
            u_xlat24.x = inversesqrt(u_xlat24.x);
            u_xlat12.x = u_xlat24.x * abs(u_xlat12.x);
            u_xlat12.x = u_xlat12.x * u_xlat36;
            u_xlat12.x = (-u_xlat12.x) * u_xlat12.x + 1.0;
            u_xlat12.x = sqrt(u_xlat12.x);
            u_xlat24.x = u_xlat16.y * u_xlat16.x;
            u_xlat36 = u_xlat12.x * u_xlat24.x;
            u_xlat4.xy = vec2(u_xlat2.z * float(3.0), u_xlat2.w * float(3.0));
            u_xlat28 = fract((-u_xlat4.x));
            u_xlat4.z = u_xlat28 + 0.5;
            u_xlat4.xy = fract(u_xlat4.xy);
            u_xlat4.xy = u_xlat4.xy + vec2(0.5, 0.5);
            u_xlat4.xyz = floor(u_xlat4.xyz);
            u_xlat28 = (-u_xlat4.x) + u_xlat4.z;
            u_xlat4.x = u_xlat28 * u_xlat4.y + u_xlat4.x;
            u_xlat16.x = (-u_xlat24.x) * u_xlat12.x + 1.0;
            u_xlat5.xyz = (-u_xlat4.xxx) + vec3(0.5, 0.0, 1.0);
            u_xlat16.xyz = u_xlat16.xxx * u_xlat5.xyz + u_xlat4.xxx;
            u_xlatb5.xw = lessThan(vec4(u_xlat36), vec4(1.0, 0.0, 0.0, 2.0)).xw;
            u_xlat6.xyz = u_xlat4.xxx * vec3(0.0, 1.0, 0.0);
            u_xlat12.x = u_xlat24.x * u_xlat12.x + -4.0;
            u_xlat12.x = exp2(u_xlat12.x);
            u_xlat12.x = u_xlat12.x + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
            u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
            u_xlat12.xyz = u_xlat12.xxx * u_xlat5.zyy + u_xlat4.xxx;
            u_xlat12.xyz = (u_xlatb5.w) ? u_xlat6.xyz : u_xlat12.xyz;
            u_xlat12.xyz = (u_xlatb5.x) ? u_xlat16.xyz : u_xlat12.xyz;
        } else {
            u_xlat4.xy = vec2(_GrassDiffuse_ST.x * _GrassNormal_TexelSize.z, _GrassDiffuse_ST.y * _GrassNormal_TexelSize.w);
            u_xlatb4.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat4.xyxx).xy;
            u_xlatb4.x = u_xlatb4.y || u_xlatb4.x;
            u_xlat3.xy = _GrassNormal_TexelSize.zw;
            u_xlat3 = (u_xlatb4.x) ? u_xlat3 : vec4(1.0, 1.0, 0.0, 0.0);
            u_xlat1 = u_xlat1 + (-u_xlat3);
            u_xlat1 = vs_COLOR0.wwww * u_xlat1 + u_xlat3;
#ifdef UNITY_ADRENO_ES3
            u_xlatb3.x = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb3.x = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb3.x){
                u_xlat3.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                u_xlat3.zw = dFdx(u_xlat3.xy);
                u_xlat3.xy = dFdy(u_xlat3.xy);
                u_xlat4.x = dot(u_xlat3.zw, u_xlat3.zw);
                u_xlat16.x = dot(u_xlat3.xy, u_xlat3.xy);
                u_xlat4.x = max(u_xlat16.x, u_xlat4.x);
                u_xlat4.x = log2(u_xlat4.x);
                u_xlat4.x = u_xlat4.x * 0.5;
                u_xlat4.x = max(u_xlat4.x, 0.0);
                u_xlat4.x = u_xlat4.x + 1.0;
                u_xlat16.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                u_xlat3 = u_xlat3 * u_xlat16.xxxx;
                u_xlat3 = u_xlat3 / u_xlat4.xxxx;
                u_xlat15.z = dot(abs(u_xlat3.zw), abs(u_xlat3.zw));
                u_xlat15.x = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                u_xlat4.xy = sqrt(u_xlat15.zx);
                u_xlat15.z = inversesqrt(u_xlat15.z);
                u_xlat15.x = inversesqrt(u_xlat15.x);
                u_xlat3.xz = u_xlat15.xz * abs(u_xlat3.xz);
                u_xlat3.x = u_xlat3.x * u_xlat3.z;
                u_xlat3.x = (-u_xlat3.x) * u_xlat3.x + 1.0;
                u_xlat3.x = sqrt(u_xlat3.x);
                u_xlat15.x = u_xlat4.y * u_xlat4.x;
                u_xlat27.x = u_xlat3.x * u_xlat15.x;
                u_xlat4.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                u_xlat39 = fract((-u_xlat4.x));
                u_xlat39 = u_xlat39 + 0.5;
                u_xlat39 = floor(u_xlat39);
                u_xlat4.xy = fract(u_xlat4.xy);
                u_xlat4.xy = u_xlat4.xy + vec2(0.5, 0.5);
                u_xlat4.xy = floor(u_xlat4.xy);
                u_xlat39 = u_xlat39 + (-u_xlat4.x);
                u_xlat39 = u_xlat39 * u_xlat4.y + u_xlat4.x;
                u_xlat4.x = (-u_xlat15.x) * u_xlat3.x + 1.0;
                u_xlat16.xyz = (-vec3(u_xlat39)) + vec3(0.5, 0.0, 1.0);
                u_xlat5.xyz = u_xlat4.xxx * u_xlat16.xyz + vec3(u_xlat39);
                u_xlatb4.xy = lessThan(u_xlat27.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                u_xlat6.xyz = vec3(u_xlat39) * vec3(0.0, 1.0, 0.0);
                u_xlat3.x = u_xlat15.x * u_xlat3.x + -4.0;
                u_xlat3.x = exp2(u_xlat3.x);
                u_xlat3.x = u_xlat3.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
                u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
                u_xlat3.xyz = u_xlat3.xxx * u_xlat16.zyy + vec3(u_xlat39);
                u_xlat3.xyz = (u_xlatb4.y) ? u_xlat6.xyz : u_xlat3.xyz;
                u_xlat12.xyz = (u_xlatb4.x) ? u_xlat5.xyz : u_xlat3.xyz;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb3.x = !!(u_xlat2.x>=u_xlat1.x);
#else
                u_xlatb3.x = u_xlat2.x>=u_xlat1.x;
#endif
                if(u_xlatb3.x){
                    u_xlat2.xy = vec2(u_xlat2.x * u_xlat2.z, u_xlat2.y * u_xlat2.w);
                    u_xlat3.xy = dFdx(u_xlat2.xy);
                    u_xlat2.xy = dFdy(u_xlat2.xy);
                    u_xlat27.x = dot(u_xlat3.xy, u_xlat3.xy);
                    u_xlat39 = dot(u_xlat2.xy, u_xlat2.xy);
                    u_xlat27.x = max(u_xlat39, u_xlat27.x);
                    u_xlat27.x = log2(u_xlat27.x);
                    u_xlat27.x = u_xlat27.x * 0.5;
                    u_xlat27.x = max(u_xlat27.x, 0.0);
                    u_xlat27.x = u_xlat27.x + 1.0;
                    u_xlat39 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat3.xy = vec2(u_xlat39) * u_xlat3.xy;
                    u_xlat2.xy = u_xlat2.xy * vec2(u_xlat39);
                    u_xlat3.xy = u_xlat3.xy / u_xlat27.xx;
                    u_xlat2.xy = u_xlat2.xy / u_xlat27.xx;
                    u_xlat15.x = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                    u_xlat14.x = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
                    u_xlat27.x = sqrt(u_xlat15.x);
                    u_xlat39 = sqrt(u_xlat14.x);
                    u_xlat15.x = inversesqrt(u_xlat15.x);
                    u_xlat3.x = u_xlat15.x * abs(u_xlat3.x);
                    u_xlat14.x = inversesqrt(u_xlat14.x);
                    u_xlat2.x = u_xlat14.x * abs(u_xlat2.x);
                    u_xlat2.x = u_xlat2.x * u_xlat3.x;
                    u_xlat2.x = (-u_xlat2.x) * u_xlat2.x + 1.0;
                    u_xlat2.x = sqrt(u_xlat2.x);
                    u_xlat14.x = u_xlat39 * u_xlat27.x;
                    u_xlat3.x = u_xlat2.x * u_xlat14.x;
                    u_xlat26.xy = vec2(u_xlat2.z * float(3.0), u_xlat2.w * float(3.0));
                    u_xlat15.x = fract((-u_xlat26.x));
                    u_xlat15.x = u_xlat15.x + 0.5;
                    u_xlat15.x = floor(u_xlat15.x);
                    u_xlat26.xy = fract(u_xlat26.xy);
                    u_xlat26.xy = u_xlat26.xy + vec2(0.5, 0.5);
                    u_xlat26.xy = floor(u_xlat26.xy);
                    u_xlat15.x = (-u_xlat26.x) + u_xlat15.x;
                    u_xlat26.x = u_xlat15.x * u_xlat26.y + u_xlat26.x;
                    u_xlat38 = (-u_xlat14.x) * u_xlat2.x + 1.0;
                    u_xlat15.xyz = (-u_xlat26.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat38) * u_xlat15.xyz + u_xlat26.xxx;
                    u_xlatb3.xy = lessThan(u_xlat3.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                    u_xlat5.xyz = u_xlat26.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat2.x = u_xlat14.x * u_xlat2.x + -4.0;
                    u_xlat2.x = exp2(u_xlat2.x);
                    u_xlat2.x = u_xlat2.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
                    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
                    u_xlat2.xyz = u_xlat2.xxx * u_xlat15.zyy + u_xlat26.xxx;
                    u_xlat2.xyz = (u_xlatb3.y) ? u_xlat5.xyz : u_xlat2.xyz;
                    u_xlat12.xyz = (u_xlatb3.x) ? u_xlat4.xyz : u_xlat2.xyz;
                } else {
                    u_xlat1.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat2.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat26.x = dot(u_xlat2.xy, u_xlat2.xy);
                    u_xlat38 = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat26.x = max(u_xlat38, u_xlat26.x);
                    u_xlat26.x = log2(u_xlat26.x);
                    u_xlat26.x = u_xlat26.x * 0.5;
                    u_xlat26.x = max(u_xlat26.x, 0.0);
                    u_xlat26.x = u_xlat26.x + 1.0;
                    u_xlat38 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat2.xy = vec2(u_xlat38) * u_xlat2.xy;
                    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat38);
                    u_xlat2.xy = u_xlat2.xy / u_xlat26.xx;
                    u_xlat1.xy = u_xlat1.xy / u_xlat26.xx;
                    u_xlat14.x = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
                    u_xlat13 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat26.x = sqrt(u_xlat14.x);
                    u_xlat38 = sqrt(u_xlat13);
                    u_xlat14.x = inversesqrt(u_xlat14.x);
                    u_xlat2.x = u_xlat14.x * abs(u_xlat2.x);
                    u_xlat13 = inversesqrt(u_xlat13);
                    u_xlat1.x = u_xlat13 * abs(u_xlat1.x);
                    u_xlat1.x = u_xlat1.x * u_xlat2.x;
                    u_xlat1.x = (-u_xlat1.x) * u_xlat1.x + 1.0;
                    u_xlat1.x = sqrt(u_xlat1.x);
                    u_xlat13 = u_xlat38 * u_xlat26.x;
                    u_xlat2.x = u_xlat1.x * u_xlat13;
                    u_xlat25.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat14.x = fract((-u_xlat25.x));
                    u_xlat14.x = u_xlat14.x + 0.5;
                    u_xlat14.x = floor(u_xlat14.x);
                    u_xlat25.xy = fract(u_xlat25.xy);
                    u_xlat25.xy = u_xlat25.xy + vec2(0.5, 0.5);
                    u_xlat25.xy = floor(u_xlat25.xy);
                    u_xlat14.x = (-u_xlat25.x) + u_xlat14.x;
                    u_xlat25.x = u_xlat14.x * u_xlat25.y + u_xlat25.x;
                    u_xlat37 = (-u_xlat13) * u_xlat1.x + 1.0;
                    u_xlat14.xyz = (-u_xlat25.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat3.xyz = vec3(u_xlat37) * u_xlat14.xyz + u_xlat25.xxx;
                    u_xlatb2.xy = lessThan(u_xlat2.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                    u_xlat4.xyz = u_xlat25.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat1.x = u_xlat13 * u_xlat1.x + -4.0;
                    u_xlat1.x = exp2(u_xlat1.x);
                    u_xlat1.x = u_xlat1.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
                    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
                    u_xlat1.xyz = u_xlat1.xxx * u_xlat14.zyy + u_xlat25.xxx;
                    u_xlat1.xyz = (u_xlatb2.y) ? u_xlat4.xyz : u_xlat1.xyz;
                    u_xlat12.xyz = (u_xlatb2.x) ? u_xlat3.xyz : u_xlat1.xyz;
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat12.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb12.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb12.x = u_xlatb12.y || u_xlatb12.x;
    if(u_xlatb12.x){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb12.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb12.x = u_xlatb12.y || u_xlatb12.x;
    if(u_xlatb12.x){
        SV_Target0 = vec4(0.400000006, 0.400000006, 0.400000006, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb12.x = !!(vs_COLOR0.w<0.99000001);
#else
    u_xlatb12.x = vs_COLOR0.w<0.99000001;
#endif
    if(u_xlatb12.x){
        u_xlat10_12.xyz = texture(_GrassNormal, vs_TEXCOORD0.xy).xyz;
        u_xlat16_7.xyz = u_xlat10_12.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat10_12.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.xy).xyz;
        u_xlat16_8.xyz = u_xlat10_12.xyz;
    } else {
        u_xlat16_8.x = float(0.0);
        u_xlat16_8.y = float(0.0);
        u_xlat16_8.z = float(0.0);
        u_xlat16_7.x = float(0.0);
        u_xlat16_7.y = float(0.0);
        u_xlat16_7.z = float(1.0);
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb12.x = !!(0.00999999978<vs_COLOR0.w);
#else
    u_xlatb12.x = 0.00999999978<vs_COLOR0.w;
#endif
    if(u_xlatb12.x){
        u_xlat10_12.xyz = texture(_Normal0, vs_TEXCOORD0.zw).xyz;
        u_xlat10_1.xy = texture(_Normal2, vs_TEXCOORD2.xy).xy;
        u_xlat16_9.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_43 = (-u_xlat0.x) + 1.0;
        u_xlat16_9.xy = vec2(u_xlat16_43) * u_xlat16_9.xy;
        u_xlat16_9.xy = u_xlat16_9.xy * vs_COLOR0.xx;
        u_xlat10_1 = texture(_Diffuse1, vs_TEXCOORD0.zw);
        u_xlat16_43 = u_xlat10_1.w * _UseDiffuseOneHeight;
        u_xlat16_10.xyz = u_xlat10_12.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, 0.0);
        u_xlat16_9.z = -1.0;
        u_xlat16_9.xyz = u_xlat16_9.xyz + u_xlat16_10.xyz;
        u_xlat16_10.xyz = u_xlat10_1.xyz;
    } else {
        u_xlat16_10.x = float(0.0);
        u_xlat16_10.y = float(0.0);
        u_xlat16_10.z = float(0.0);
        u_xlat16_9.x = float(0.0);
        u_xlat16_9.y = float(0.0);
        u_xlat16_9.z = float(1.0);
        u_xlat16_43 = 1.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor);
#endif
    u_xlat16_11.xyz = u_xlat16_10.xyz * _TintColor.xyz;
    u_xlat16_10.xyz = (bool(u_xlatb0)) ? u_xlat16_11.xyz : u_xlat16_10.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend);
#endif
    u_xlat16_12 = u_xlat16_43;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12 = min(max(u_xlat16_12, 0.0), 1.0);
#else
    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
#endif
    u_xlat16_24 = vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_43 = _HeightContrast * 10.0;
    u_xlat16_12 = u_xlat16_12 + -1.0;
    u_xlat16_44 = _HeightSpread + 0.100000001;
    u_xlat16_24 = log2(u_xlat16_24);
    u_xlat16_24 = u_xlat16_24 * u_xlat16_44;
    u_xlat16_24 = exp2(u_xlat16_24);
    u_xlat16_12 = u_xlat16_24 * 2.0 + u_xlat16_12;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12 = min(max(u_xlat16_12, 0.0), 1.0);
#else
    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
#endif
    u_xlat16_24 = _HeightContrast * 10.0 + 1.0;
    u_xlat16_24 = _HeightContrast * 10.0 + u_xlat16_24;
    u_xlat12.x = u_xlat16_12 * u_xlat16_24 + (-u_xlat16_43);
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat16_43 = (u_xlatb0) ? u_xlat12.x : vs_COLOR0.w;
    u_xlat16_9.xyz = (-u_xlat16_7.xyz) + u_xlat16_9.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_43) * u_xlat16_9.xyz + u_xlat16_7.xyz;
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + u_xlat16_10.xyz;
    u_xlat16_8.xyz = vec3(u_xlat16_43) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, u_xlat16_7.xyz);
    u_xlat0.y = dot(vs_TEXCOORD4.xyz, u_xlat16_7.xyz);
    u_xlat0.z = dot(vs_TEXCOORD5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = _Terrain_Smoothness * _Shininess;
    u_xlat16_7.x = max(u_xlat16_7.x, 0.0);
    SV_Target2.w = min(u_xlat16_7.x, 0.5);
    u_xlat16_7.xyz = u_xlat16_8.xyz * vec3(vec3(_Terrain_Specular, _Terrain_Specular, _Terrain_Specular));
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz;
    u_xlat16_43 = max(u_xlat16_7.z, u_xlat16_7.y);
    u_xlat16_43 = max(u_xlat16_43, u_xlat16_7.x);
    u_xlat16_43 = (-u_xlat16_43) + 1.0;
    SV_Target1.xyz = vec3(u_xlat16_43) * u_xlat16_8.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_43 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_43 : u_xlat16_7.z;
    SV_Target0.w = 0.0;
    SV_Target1.w = _SSAO_Intensity;
    SV_Target2.xy = u_xlat16_7.xy;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _Diffuse1_ST;
uniform 	float _UVDiffuse2;
uniform 	vec4 _Diffuse2_ST;
uniform 	float _UVDetail;
uniform 	vec4 _DetailDiffuse_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat7;
float u_xlat16;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x;
    u_xlat2.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].x;
    u_xlat2.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].x;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].y;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].y;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].y;
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.xy = sqrt(u_xlat2.xy);
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].z;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].z;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].z;
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat2.x = u_xlat7.x + u_xlat2.x;
    u_xlat2.x = u_xlat2.x * 0.330000013;
    u_xlat7.xy = u_xlat2.xx * in_TEXCOORD0.xy;
    u_xlat2.xw = u_xlat2.xx * in_TEXCOORD1.xy;
    vs_TEXCOORD0.xy = u_xlat7.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Diffuse1_ST.xy + _Diffuse1_ST.zw;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UVDiffuse2==0.0);
#else
    u_xlatb1 = _UVDiffuse2==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb1)) ? u_xlat7.xy : u_xlat2.xw;
    vs_TEXCOORD2.xy = u_xlat1.xy * _Diffuse2_ST.xy + _Diffuse2_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UVDetail==0.0);
#else
    u_xlatb1 = _UVDetail==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb1)) ? u_xlat7.xy : u_xlat2.xw;
    vs_TEXCOORD2.zw = u_xlat1.xy * _DetailDiffuse_ST.xy + _DetailDiffuse_ST.zw;
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat2.xyz = vec3(u_xlat0) * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_4.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = vec3(u_xlat0) * u_xlat16_4.xyz;
    vs_TEXCOORD3.y = u_xlat16_4.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD3.w = u_xlat5.x;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat5.y;
    vs_TEXCOORD5.w = u_xlat5.z;
    vs_TEXCOORD4.y = u_xlat16_4.y;
    vs_TEXCOORD5.y = u_xlat16_4.z;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	mediump float _HeightSpread;
uniform 	mediump float _HeightContrast;
uniform 	mediump float _UseTintColor;
uniform 	mediump float _UseDiffuseOneHeight;
uniform 	mediump float _UseGrassHeightBlend;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _SSAO_Intensity;
uniform 	mediump float _Terrain_Smoothness;
uniform 	mediump float _Terrain_Specular;
uniform 	mediump float _Shininess;
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _GrassDiffuse_TexelSize;
uniform 	vec4 _GrassNormal_TexelSize;
uniform 	float _GrassNormalScale;
uniform 	vec4 _Diffuse1_ST;
uniform 	vec4 _Diffuse1_TexelSize;
uniform 	vec4 _Normal0_TexelSize;
uniform 	float _Normal0Scale;
uniform 	vec4 _Diffuse2_ST;
uniform 	vec4 _Diffuse2_TexelSize;
uniform 	vec4 _Normal2_TexelSize;
uniform 	mediump float _Normal2Scale;
uniform 	mediump float _Diffuse2Distance;
uniform 	mediump float _Diffuse2Fade;
uniform lowp sampler2D _GrassDiffuse;
uniform lowp sampler2D _GrassNormal;
uniform lowp sampler2D _Normal0;
uniform lowp sampler2D _Normal2;
uniform lowp sampler2D _Diffuse1;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec2 u_xlat10_1;
vec4 u_xlat2;
bvec2 u_xlatb2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
bvec2 u_xlatb4;
vec3 u_xlat5;
bvec4 u_xlatb5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
mediump float u_xlat16_12;
lowp vec3 u_xlat10_12;
bvec3 u_xlatb12;
float u_xlat13;
vec3 u_xlat14;
vec3 u_xlat15;
vec3 u_xlat16;
vec2 u_xlat24;
mediump float u_xlat16_24;
bvec2 u_xlatb24;
vec2 u_xlat25;
vec2 u_xlat26;
vec2 u_xlat27;
float u_xlat28;
float u_xlat36;
bool u_xlatb36;
float u_xlat37;
float u_xlat38;
float u_xlat39;
mediump float u_xlat16_43;
mediump float u_xlat16_44;
void main()
{
    u_xlat0.x = vs_TEXCOORD3.w;
    u_xlat0.y = vs_TEXCOORD4.w;
    u_xlat0.z = vs_TEXCOORD5.w;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x / _Diffuse2Distance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + 9.99999975e-05;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Diffuse2Fade;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat1.zw = vec2(vs_TEXCOORD0.z + (-_Diffuse1_ST.z), vs_TEXCOORD0.w + (-_Diffuse1_ST.w));
    u_xlat12.xy = vec2(_Diffuse1_ST.x * _Diffuse1_TexelSize.z, _Diffuse1_ST.y * _Diffuse1_TexelSize.w);
    u_xlatb12.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat12.xyxx).xy;
    u_xlatb12.x = u_xlatb12.y || u_xlatb12.x;
    u_xlat1.xy = _Diffuse1_TexelSize.zw;
    u_xlat2 = (u_xlatb12.x) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
    u_xlat24.xy = vec2(_Diffuse1_ST.x * _Normal0_TexelSize.z, _Diffuse1_ST.y * _Normal0_TexelSize.w);
    u_xlatb24.xy = lessThan(vec4(1.0, 1.0, 1.0, 1.0), u_xlat24.xyxy).xy;
    u_xlatb24.x = u_xlatb24.y || u_xlatb24.x;
    u_xlat1.xy = _Normal0_TexelSize.zw;
    u_xlat1 = (u_xlatb24.x) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb36 = !!(u_xlat0.x<0.800000012);
#else
    u_xlatb36 = u_xlat0.x<0.800000012;
#endif
    if(u_xlatb36){
        u_xlat12.xz = (u_xlatb12.x) ? _Diffuse1_ST.xy : vec2(1.0, 1.0);
        u_xlat3.xy = (u_xlatb24.x) ? _Diffuse1_ST.xy : vec2(1.0, 1.0);
        u_xlat4.zw = vec2(vs_TEXCOORD2.x + (-_Diffuse2_ST.z), vs_TEXCOORD2.y + (-_Diffuse2_ST.w));
        u_xlat12.xy = u_xlat12.xz * u_xlat2.xy;
        u_xlat27.xy = vec2(_Diffuse2_ST.x * _Diffuse2_TexelSize.z, _Diffuse2_ST.y * _Diffuse2_TexelSize.w);
        u_xlatb12.xy = lessThan(u_xlat12.xyxx, u_xlat27.xyxx).xy;
        u_xlatb12.x = u_xlatb12.y || u_xlatb12.x;
        u_xlat4.xy = _Diffuse2_TexelSize.zw;
        u_xlat2 = (u_xlatb12.x) ? u_xlat4 : u_xlat2;
        u_xlat12.xy = u_xlat1.xy * u_xlat3.xy;
        u_xlat3.xy = vec2(_Diffuse2_ST.x * _Normal2_TexelSize.z, _Diffuse2_ST.y * _Normal2_TexelSize.w);
        u_xlatb12.xy = lessThan(u_xlat12.xyxx, u_xlat3.xyxx).xy;
        u_xlatb12.x = u_xlatb12.y || u_xlatb12.x;
        u_xlat4.xy = _Normal2_TexelSize.zw;
        u_xlat1 = (u_xlatb12.x) ? u_xlat4 : u_xlat1;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb12.x = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb12.x = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb12.x){
        u_xlatb12.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.899999976), vec4(_LODIndex)).xyz;
        u_xlat3 = (u_xlatb12.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat3 = (u_xlatb12.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat3;
        u_xlat3 = (u_xlatb12.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat3;
        SV_Target0 = u_xlat3;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb12.x = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb12.x = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb12.x){
        u_xlat10_12.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.xy).xyz;
        SV_Target0.xyz = u_xlat10_12.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb12.x = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb12.x = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb12.x){
        u_xlat12.x = max(_GrassDiffuse_TexelSize.w, _GrassDiffuse_TexelSize.z);
        u_xlat12.x = max(u_xlat12.x, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb24.x = !!(256.0<u_xlat12.x);
#else
        u_xlatb24.x = 256.0<u_xlat12.x;
#endif
        u_xlatb12.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 1024.0), u_xlat12.xxxx).xz;
        u_xlat3 = (u_xlatb12.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat3 = (u_xlatb12.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat3;
        u_xlat3 = (u_xlatb24.x) ? u_xlat3 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat3;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb12.x = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb12.x = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb12.x){
        u_xlat12.xy = vec2(vs_TEXCOORD0.x * _GrassDiffuse_TexelSize.z, vs_TEXCOORD0.y * _GrassDiffuse_TexelSize.w);
        u_xlat3.xy = dFdx(u_xlat12.xy);
        u_xlat12.xy = dFdy(u_xlat12.xy);
        u_xlat36 = dot(u_xlat3.xy, u_xlat3.xy);
        u_xlat12.x = dot(u_xlat12.xy, u_xlat12.xy);
        u_xlat12.x = max(u_xlat12.x, u_xlat36);
        u_xlat12.x = log2(u_xlat12.x);
        u_xlat12.x = u_xlat12.x * 0.5;
        u_xlat12.x = max(u_xlat12.x, 0.0);
        u_xlat12.x = u_xlat12.x + 1.0;
        u_xlat24.x = max(_GrassDiffuse_TexelSize.w, _GrassDiffuse_TexelSize.z);
        u_xlat12.x = u_xlat24.x / u_xlat12.x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb24.x = !!(256.0<u_xlat12.x);
#else
        u_xlatb24.x = 256.0<u_xlat12.x;
#endif
        u_xlatb12.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 1024.0), u_xlat12.xxxx).xz;
        u_xlat3 = (u_xlatb12.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat3 = (u_xlatb12.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat3;
        u_xlat3 = (u_xlatb24.x) ? u_xlat3 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat3;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb12.x = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb12.x = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb12.x){
        u_xlat3.zw = vec2(vs_TEXCOORD0.x + (-_GrassDiffuse_ST.z), vs_TEXCOORD0.y + (-_GrassDiffuse_ST.w));
        u_xlat12.xy = vec2(_GrassDiffuse_ST.x * _GrassDiffuse_TexelSize.z, _GrassDiffuse_ST.y * _GrassDiffuse_TexelSize.w);
        u_xlatb12.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat12.xyxx).xy;
        u_xlatb12.x = u_xlatb12.y || u_xlatb12.x;
        u_xlat3.xy = _GrassDiffuse_TexelSize.zw;
        u_xlat4 = (u_xlatb12.x) ? u_xlat3 : vec4(1.0, 1.0, 0.0, 0.0);
        u_xlat2 = u_xlat2 + (-u_xlat4);
        u_xlat2 = vs_COLOR0.wwww * u_xlat2 + u_xlat4;
#ifdef UNITY_ADRENO_ES3
        u_xlatb12.x = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb12.x = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb12.x){
            u_xlat12.xy = vec2(u_xlat2.x * u_xlat2.z, u_xlat2.y * u_xlat2.w);
            u_xlat4.xy = dFdx(u_xlat12.xy);
            u_xlat12.xy = dFdy(u_xlat12.xy);
            u_xlat36 = dot(u_xlat4.xy, u_xlat4.xy);
            u_xlat28 = dot(u_xlat12.xy, u_xlat12.xy);
            u_xlat36 = max(u_xlat36, u_xlat28);
            u_xlat36 = log2(u_xlat36);
            u_xlat36 = u_xlat36 * 0.5;
            u_xlat36 = max(u_xlat36, 0.0);
            u_xlat36 = u_xlat36 + 1.0;
            u_xlat28 = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat4.xy = vec2(u_xlat28) * u_xlat4.xy;
            u_xlat12.xy = u_xlat12.xy * vec2(u_xlat28);
            u_xlat4.xy = u_xlat4.xy / vec2(u_xlat36);
            u_xlat12.xy = u_xlat12.xy / vec2(u_xlat36);
            u_xlat24.y = dot(abs(u_xlat4.xy), abs(u_xlat4.xy));
            u_xlat24.x = dot(abs(u_xlat12.xy), abs(u_xlat12.xy));
            u_xlat16.xy = sqrt(u_xlat24.yx);
            u_xlat36 = inversesqrt(u_xlat24.y);
            u_xlat36 = u_xlat36 * abs(u_xlat4.x);
            u_xlat24.x = inversesqrt(u_xlat24.x);
            u_xlat12.x = u_xlat24.x * abs(u_xlat12.x);
            u_xlat12.x = u_xlat12.x * u_xlat36;
            u_xlat12.x = (-u_xlat12.x) * u_xlat12.x + 1.0;
            u_xlat12.x = sqrt(u_xlat12.x);
            u_xlat24.x = u_xlat16.y * u_xlat16.x;
            u_xlat36 = u_xlat12.x * u_xlat24.x;
            u_xlat4.xy = vec2(u_xlat2.z * float(3.0), u_xlat2.w * float(3.0));
            u_xlat28 = fract((-u_xlat4.x));
            u_xlat4.z = u_xlat28 + 0.5;
            u_xlat4.xy = fract(u_xlat4.xy);
            u_xlat4.xy = u_xlat4.xy + vec2(0.5, 0.5);
            u_xlat4.xyz = floor(u_xlat4.xyz);
            u_xlat28 = (-u_xlat4.x) + u_xlat4.z;
            u_xlat4.x = u_xlat28 * u_xlat4.y + u_xlat4.x;
            u_xlat16.x = (-u_xlat24.x) * u_xlat12.x + 1.0;
            u_xlat5.xyz = (-u_xlat4.xxx) + vec3(0.5, 0.0, 1.0);
            u_xlat16.xyz = u_xlat16.xxx * u_xlat5.xyz + u_xlat4.xxx;
            u_xlatb5.xw = lessThan(vec4(u_xlat36), vec4(1.0, 0.0, 0.0, 2.0)).xw;
            u_xlat6.xyz = u_xlat4.xxx * vec3(0.0, 1.0, 0.0);
            u_xlat12.x = u_xlat24.x * u_xlat12.x + -4.0;
            u_xlat12.x = exp2(u_xlat12.x);
            u_xlat12.x = u_xlat12.x + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
            u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
            u_xlat12.xyz = u_xlat12.xxx * u_xlat5.zyy + u_xlat4.xxx;
            u_xlat12.xyz = (u_xlatb5.w) ? u_xlat6.xyz : u_xlat12.xyz;
            u_xlat12.xyz = (u_xlatb5.x) ? u_xlat16.xyz : u_xlat12.xyz;
        } else {
            u_xlat4.xy = vec2(_GrassDiffuse_ST.x * _GrassNormal_TexelSize.z, _GrassDiffuse_ST.y * _GrassNormal_TexelSize.w);
            u_xlatb4.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat4.xyxx).xy;
            u_xlatb4.x = u_xlatb4.y || u_xlatb4.x;
            u_xlat3.xy = _GrassNormal_TexelSize.zw;
            u_xlat3 = (u_xlatb4.x) ? u_xlat3 : vec4(1.0, 1.0, 0.0, 0.0);
            u_xlat1 = u_xlat1 + (-u_xlat3);
            u_xlat1 = vs_COLOR0.wwww * u_xlat1 + u_xlat3;
#ifdef UNITY_ADRENO_ES3
            u_xlatb3.x = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb3.x = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb3.x){
                u_xlat3.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                u_xlat3.zw = dFdx(u_xlat3.xy);
                u_xlat3.xy = dFdy(u_xlat3.xy);
                u_xlat4.x = dot(u_xlat3.zw, u_xlat3.zw);
                u_xlat16.x = dot(u_xlat3.xy, u_xlat3.xy);
                u_xlat4.x = max(u_xlat16.x, u_xlat4.x);
                u_xlat4.x = log2(u_xlat4.x);
                u_xlat4.x = u_xlat4.x * 0.5;
                u_xlat4.x = max(u_xlat4.x, 0.0);
                u_xlat4.x = u_xlat4.x + 1.0;
                u_xlat16.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                u_xlat3 = u_xlat3 * u_xlat16.xxxx;
                u_xlat3 = u_xlat3 / u_xlat4.xxxx;
                u_xlat15.z = dot(abs(u_xlat3.zw), abs(u_xlat3.zw));
                u_xlat15.x = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                u_xlat4.xy = sqrt(u_xlat15.zx);
                u_xlat15.z = inversesqrt(u_xlat15.z);
                u_xlat15.x = inversesqrt(u_xlat15.x);
                u_xlat3.xz = u_xlat15.xz * abs(u_xlat3.xz);
                u_xlat3.x = u_xlat3.x * u_xlat3.z;
                u_xlat3.x = (-u_xlat3.x) * u_xlat3.x + 1.0;
                u_xlat3.x = sqrt(u_xlat3.x);
                u_xlat15.x = u_xlat4.y * u_xlat4.x;
                u_xlat27.x = u_xlat3.x * u_xlat15.x;
                u_xlat4.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                u_xlat39 = fract((-u_xlat4.x));
                u_xlat39 = u_xlat39 + 0.5;
                u_xlat39 = floor(u_xlat39);
                u_xlat4.xy = fract(u_xlat4.xy);
                u_xlat4.xy = u_xlat4.xy + vec2(0.5, 0.5);
                u_xlat4.xy = floor(u_xlat4.xy);
                u_xlat39 = u_xlat39 + (-u_xlat4.x);
                u_xlat39 = u_xlat39 * u_xlat4.y + u_xlat4.x;
                u_xlat4.x = (-u_xlat15.x) * u_xlat3.x + 1.0;
                u_xlat16.xyz = (-vec3(u_xlat39)) + vec3(0.5, 0.0, 1.0);
                u_xlat5.xyz = u_xlat4.xxx * u_xlat16.xyz + vec3(u_xlat39);
                u_xlatb4.xy = lessThan(u_xlat27.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                u_xlat6.xyz = vec3(u_xlat39) * vec3(0.0, 1.0, 0.0);
                u_xlat3.x = u_xlat15.x * u_xlat3.x + -4.0;
                u_xlat3.x = exp2(u_xlat3.x);
                u_xlat3.x = u_xlat3.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
                u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
                u_xlat3.xyz = u_xlat3.xxx * u_xlat16.zyy + vec3(u_xlat39);
                u_xlat3.xyz = (u_xlatb4.y) ? u_xlat6.xyz : u_xlat3.xyz;
                u_xlat12.xyz = (u_xlatb4.x) ? u_xlat5.xyz : u_xlat3.xyz;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb3.x = !!(u_xlat2.x>=u_xlat1.x);
#else
                u_xlatb3.x = u_xlat2.x>=u_xlat1.x;
#endif
                if(u_xlatb3.x){
                    u_xlat2.xy = vec2(u_xlat2.x * u_xlat2.z, u_xlat2.y * u_xlat2.w);
                    u_xlat3.xy = dFdx(u_xlat2.xy);
                    u_xlat2.xy = dFdy(u_xlat2.xy);
                    u_xlat27.x = dot(u_xlat3.xy, u_xlat3.xy);
                    u_xlat39 = dot(u_xlat2.xy, u_xlat2.xy);
                    u_xlat27.x = max(u_xlat39, u_xlat27.x);
                    u_xlat27.x = log2(u_xlat27.x);
                    u_xlat27.x = u_xlat27.x * 0.5;
                    u_xlat27.x = max(u_xlat27.x, 0.0);
                    u_xlat27.x = u_xlat27.x + 1.0;
                    u_xlat39 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat3.xy = vec2(u_xlat39) * u_xlat3.xy;
                    u_xlat2.xy = u_xlat2.xy * vec2(u_xlat39);
                    u_xlat3.xy = u_xlat3.xy / u_xlat27.xx;
                    u_xlat2.xy = u_xlat2.xy / u_xlat27.xx;
                    u_xlat15.x = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                    u_xlat14.x = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
                    u_xlat27.x = sqrt(u_xlat15.x);
                    u_xlat39 = sqrt(u_xlat14.x);
                    u_xlat15.x = inversesqrt(u_xlat15.x);
                    u_xlat3.x = u_xlat15.x * abs(u_xlat3.x);
                    u_xlat14.x = inversesqrt(u_xlat14.x);
                    u_xlat2.x = u_xlat14.x * abs(u_xlat2.x);
                    u_xlat2.x = u_xlat2.x * u_xlat3.x;
                    u_xlat2.x = (-u_xlat2.x) * u_xlat2.x + 1.0;
                    u_xlat2.x = sqrt(u_xlat2.x);
                    u_xlat14.x = u_xlat39 * u_xlat27.x;
                    u_xlat3.x = u_xlat2.x * u_xlat14.x;
                    u_xlat26.xy = vec2(u_xlat2.z * float(3.0), u_xlat2.w * float(3.0));
                    u_xlat15.x = fract((-u_xlat26.x));
                    u_xlat15.x = u_xlat15.x + 0.5;
                    u_xlat15.x = floor(u_xlat15.x);
                    u_xlat26.xy = fract(u_xlat26.xy);
                    u_xlat26.xy = u_xlat26.xy + vec2(0.5, 0.5);
                    u_xlat26.xy = floor(u_xlat26.xy);
                    u_xlat15.x = (-u_xlat26.x) + u_xlat15.x;
                    u_xlat26.x = u_xlat15.x * u_xlat26.y + u_xlat26.x;
                    u_xlat38 = (-u_xlat14.x) * u_xlat2.x + 1.0;
                    u_xlat15.xyz = (-u_xlat26.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat38) * u_xlat15.xyz + u_xlat26.xxx;
                    u_xlatb3.xy = lessThan(u_xlat3.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                    u_xlat5.xyz = u_xlat26.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat2.x = u_xlat14.x * u_xlat2.x + -4.0;
                    u_xlat2.x = exp2(u_xlat2.x);
                    u_xlat2.x = u_xlat2.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
                    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
                    u_xlat2.xyz = u_xlat2.xxx * u_xlat15.zyy + u_xlat26.xxx;
                    u_xlat2.xyz = (u_xlatb3.y) ? u_xlat5.xyz : u_xlat2.xyz;
                    u_xlat12.xyz = (u_xlatb3.x) ? u_xlat4.xyz : u_xlat2.xyz;
                } else {
                    u_xlat1.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat2.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat26.x = dot(u_xlat2.xy, u_xlat2.xy);
                    u_xlat38 = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat26.x = max(u_xlat38, u_xlat26.x);
                    u_xlat26.x = log2(u_xlat26.x);
                    u_xlat26.x = u_xlat26.x * 0.5;
                    u_xlat26.x = max(u_xlat26.x, 0.0);
                    u_xlat26.x = u_xlat26.x + 1.0;
                    u_xlat38 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat2.xy = vec2(u_xlat38) * u_xlat2.xy;
                    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat38);
                    u_xlat2.xy = u_xlat2.xy / u_xlat26.xx;
                    u_xlat1.xy = u_xlat1.xy / u_xlat26.xx;
                    u_xlat14.x = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
                    u_xlat13 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat26.x = sqrt(u_xlat14.x);
                    u_xlat38 = sqrt(u_xlat13);
                    u_xlat14.x = inversesqrt(u_xlat14.x);
                    u_xlat2.x = u_xlat14.x * abs(u_xlat2.x);
                    u_xlat13 = inversesqrt(u_xlat13);
                    u_xlat1.x = u_xlat13 * abs(u_xlat1.x);
                    u_xlat1.x = u_xlat1.x * u_xlat2.x;
                    u_xlat1.x = (-u_xlat1.x) * u_xlat1.x + 1.0;
                    u_xlat1.x = sqrt(u_xlat1.x);
                    u_xlat13 = u_xlat38 * u_xlat26.x;
                    u_xlat2.x = u_xlat1.x * u_xlat13;
                    u_xlat25.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat14.x = fract((-u_xlat25.x));
                    u_xlat14.x = u_xlat14.x + 0.5;
                    u_xlat14.x = floor(u_xlat14.x);
                    u_xlat25.xy = fract(u_xlat25.xy);
                    u_xlat25.xy = u_xlat25.xy + vec2(0.5, 0.5);
                    u_xlat25.xy = floor(u_xlat25.xy);
                    u_xlat14.x = (-u_xlat25.x) + u_xlat14.x;
                    u_xlat25.x = u_xlat14.x * u_xlat25.y + u_xlat25.x;
                    u_xlat37 = (-u_xlat13) * u_xlat1.x + 1.0;
                    u_xlat14.xyz = (-u_xlat25.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat3.xyz = vec3(u_xlat37) * u_xlat14.xyz + u_xlat25.xxx;
                    u_xlatb2.xy = lessThan(u_xlat2.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                    u_xlat4.xyz = u_xlat25.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat1.x = u_xlat13 * u_xlat1.x + -4.0;
                    u_xlat1.x = exp2(u_xlat1.x);
                    u_xlat1.x = u_xlat1.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
                    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
                    u_xlat1.xyz = u_xlat1.xxx * u_xlat14.zyy + u_xlat25.xxx;
                    u_xlat1.xyz = (u_xlatb2.y) ? u_xlat4.xyz : u_xlat1.xyz;
                    u_xlat12.xyz = (u_xlatb2.x) ? u_xlat3.xyz : u_xlat1.xyz;
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat12.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb12.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb12.x = u_xlatb12.y || u_xlatb12.x;
    if(u_xlatb12.x){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb12.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb12.x = u_xlatb12.y || u_xlatb12.x;
    if(u_xlatb12.x){
        SV_Target0 = vec4(0.400000006, 0.400000006, 0.400000006, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb12.x = !!(vs_COLOR0.w<0.99000001);
#else
    u_xlatb12.x = vs_COLOR0.w<0.99000001;
#endif
    if(u_xlatb12.x){
        u_xlat10_12.xyz = texture(_GrassNormal, vs_TEXCOORD0.xy).xyz;
        u_xlat16_7.xyz = u_xlat10_12.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_7.xy = u_xlat16_7.xy * vec2(_GrassNormalScale);
        u_xlat10_12.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.xy).xyz;
        u_xlat16_8.xyz = u_xlat10_12.xyz;
    } else {
        u_xlat16_8.x = float(0.0);
        u_xlat16_8.y = float(0.0);
        u_xlat16_8.z = float(0.0);
        u_xlat16_7.x = float(0.0);
        u_xlat16_7.y = float(0.0);
        u_xlat16_7.z = float(1.0);
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb12.x = !!(0.00999999978<vs_COLOR0.w);
#else
    u_xlatb12.x = 0.00999999978<vs_COLOR0.w;
#endif
    if(u_xlatb12.x){
        u_xlat10_12.xyz = texture(_Normal0, vs_TEXCOORD0.zw).xyz;
        u_xlat10_1.xy = texture(_Normal2, vs_TEXCOORD2.xy).xy;
        u_xlat16_9.z = u_xlat10_12.z + u_xlat10_12.z;
        u_xlat16_10.xy = u_xlat10_12.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_9.xy = u_xlat16_10.xy * vec2(_Normal0Scale);
        u_xlat16_10.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_10.xy = u_xlat16_10.xy * vec2(_Normal2Scale);
        u_xlat16_43 = (-u_xlat0.x) + 1.0;
        u_xlat16_10.xy = vec2(u_xlat16_43) * u_xlat16_10.xy;
        u_xlat16_10.xy = u_xlat16_10.xy * vs_COLOR0.xx;
        u_xlat10_0 = texture(_Diffuse1, vs_TEXCOORD0.zw);
        u_xlat16_43 = u_xlat10_0.w * _UseDiffuseOneHeight;
        u_xlat16_10.z = -1.0;
        u_xlat16_9.xyz = u_xlat16_9.xyz + u_xlat16_10.xyz;
        u_xlat16_10.xyz = u_xlat10_0.xyz;
    } else {
        u_xlat16_10.x = float(0.0);
        u_xlat16_10.y = float(0.0);
        u_xlat16_10.z = float(0.0);
        u_xlat16_9.x = float(0.0);
        u_xlat16_9.y = float(0.0);
        u_xlat16_9.z = float(1.0);
        u_xlat16_43 = 1.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor);
#endif
    u_xlat16_11.xyz = u_xlat16_10.xyz * _TintColor.xyz;
    u_xlat16_10.xyz = (bool(u_xlatb0)) ? u_xlat16_11.xyz : u_xlat16_10.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend);
#endif
    u_xlat16_12 = u_xlat16_43;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12 = min(max(u_xlat16_12, 0.0), 1.0);
#else
    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
#endif
    u_xlat16_24 = vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_43 = _HeightContrast * 10.0;
    u_xlat16_12 = u_xlat16_12 + -1.0;
    u_xlat16_44 = _HeightSpread + 0.100000001;
    u_xlat16_24 = log2(u_xlat16_24);
    u_xlat16_24 = u_xlat16_24 * u_xlat16_44;
    u_xlat16_24 = exp2(u_xlat16_24);
    u_xlat16_12 = u_xlat16_24 * 2.0 + u_xlat16_12;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12 = min(max(u_xlat16_12, 0.0), 1.0);
#else
    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
#endif
    u_xlat16_24 = _HeightContrast * 10.0 + 1.0;
    u_xlat16_24 = _HeightContrast * 10.0 + u_xlat16_24;
    u_xlat12.x = u_xlat16_12 * u_xlat16_24 + (-u_xlat16_43);
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat16_43 = (u_xlatb0) ? u_xlat12.x : vs_COLOR0.w;
    u_xlat16_9.xyz = (-u_xlat16_7.xyz) + u_xlat16_9.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_43) * u_xlat16_9.xyz + u_xlat16_7.xyz;
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + u_xlat16_10.xyz;
    u_xlat16_8.xyz = vec3(u_xlat16_43) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, u_xlat16_7.xyz);
    u_xlat0.y = dot(vs_TEXCOORD4.xyz, u_xlat16_7.xyz);
    u_xlat0.z = dot(vs_TEXCOORD5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = _Terrain_Smoothness * _Shininess;
    u_xlat16_7.x = max(u_xlat16_7.x, 0.0);
    SV_Target2.w = min(u_xlat16_7.x, 0.5);
    u_xlat16_7.xyz = u_xlat16_8.xyz * vec3(vec3(_Terrain_Specular, _Terrain_Specular, _Terrain_Specular));
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz;
    u_xlat16_43 = max(u_xlat16_7.z, u_xlat16_7.y);
    u_xlat16_43 = max(u_xlat16_43, u_xlat16_7.x);
    u_xlat16_43 = (-u_xlat16_43) + 1.0;
    SV_Target1.xyz = vec3(u_xlat16_43) * u_xlat16_8.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_43 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_43 : u_xlat16_7.z;
    SV_Target0.w = 0.0;
    SV_Target1.w = _SSAO_Intensity;
    SV_Target2.xy = u_xlat16_7.xy;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _Diffuse1_ST;
uniform 	float _UVDiffuse2;
uniform 	vec4 _Diffuse2_ST;
uniform 	float _UVDetail;
uniform 	vec4 _DetailDiffuse_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec2 u_xlat12;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat15 = u_xlat15 + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat15 = u_xlat15 + u_xlat2.x;
    u_xlat15 = u_xlat15 * 0.330000013;
    u_xlat2.xy = vec2(u_xlat15) * in_TEXCOORD0.xy;
    u_xlat12.xy = vec2(u_xlat15) * in_TEXCOORD1.xy;
    vs_TEXCOORD0.xy = u_xlat2.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Diffuse1_ST.xy + _Diffuse1_ST.zw;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat15 * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UVDiffuse2==0.0);
#else
    u_xlatb15 = _UVDiffuse2==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat2.xy : u_xlat12.xy;
    vs_TEXCOORD2.xy = u_xlat1.xy * _Diffuse2_ST.xy + _Diffuse2_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UVDetail==0.0);
#else
    u_xlatb15 = _UVDetail==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat2.xy : u_xlat12.xy;
    vs_TEXCOORD2.zw = u_xlat1.xy * _DetailDiffuse_ST.xy + _DetailDiffuse_ST.zw;
    vs_TEXCOORD3.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz;
    vs_TEXCOORD3.y = u_xlat16_4.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat0.y;
    vs_TEXCOORD5.w = u_xlat0.z;
    vs_TEXCOORD4.y = u_xlat16_4.y;
    vs_TEXCOORD5.y = u_xlat16_4.z;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _ScreenParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	mediump float _HeightSpread;
uniform 	mediump float _HeightContrast;
uniform 	mediump float _UseTintColor;
uniform 	mediump float _UseDiffuseOneHeight;
uniform 	mediump float _UseGrassHeightBlend;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _SSAO_Intensity;
uniform 	mediump float _Terrain_Smoothness;
uniform 	mediump float _Terrain_Specular;
uniform 	mediump float _Shininess;
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _GrassDiffuse_TexelSize;
uniform 	vec4 _GrassNormal_TexelSize;
uniform 	vec4 _Diffuse1_ST;
uniform 	vec4 _Diffuse1_TexelSize;
uniform 	vec4 _Normal0_TexelSize;
uniform 	vec4 _Diffuse2_ST;
uniform 	vec4 _Diffuse2_TexelSize;
uniform 	vec4 _Normal2_TexelSize;
uniform 	mediump float _Diffuse2Distance;
uniform 	mediump float _Diffuse2Fade;
uniform lowp sampler2D _GrassDiffuse;
uniform lowp sampler2D _GrassNormal;
uniform lowp sampler2D _Normal0;
uniform lowp sampler2D _Normal2;
uniform lowp sampler2D _Diffuse1;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
bvec2 u_xlatb2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
bvec2 u_xlatb4;
vec3 u_xlat5;
bvec4 u_xlatb5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
mediump float u_xlat16_12;
lowp vec3 u_xlat10_12;
bvec3 u_xlatb12;
float u_xlat13;
vec3 u_xlat14;
vec3 u_xlat15;
vec3 u_xlat16;
vec2 u_xlat24;
mediump float u_xlat16_24;
bvec2 u_xlatb24;
vec2 u_xlat25;
vec2 u_xlat26;
vec2 u_xlat27;
float u_xlat28;
float u_xlat36;
bool u_xlatb36;
float u_xlat37;
float u_xlat38;
float u_xlat39;
mediump float u_xlat16_43;
mediump float u_xlat16_44;
void main()
{
    u_xlat0.x = vs_TEXCOORD3.w;
    u_xlat0.y = vs_TEXCOORD4.w;
    u_xlat0.z = vs_TEXCOORD5.w;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x / _Diffuse2Distance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + 9.99999975e-05;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Diffuse2Fade;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat1.zw = vec2(vs_TEXCOORD0.z + (-_Diffuse1_ST.z), vs_TEXCOORD0.w + (-_Diffuse1_ST.w));
    u_xlat12.xy = vec2(_Diffuse1_ST.x * _Diffuse1_TexelSize.z, _Diffuse1_ST.y * _Diffuse1_TexelSize.w);
    u_xlatb12.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat12.xyxx).xy;
    u_xlatb12.x = u_xlatb12.y || u_xlatb12.x;
    u_xlat1.xy = _Diffuse1_TexelSize.zw;
    u_xlat2 = (u_xlatb12.x) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
    u_xlat24.xy = vec2(_Diffuse1_ST.x * _Normal0_TexelSize.z, _Diffuse1_ST.y * _Normal0_TexelSize.w);
    u_xlatb24.xy = lessThan(vec4(1.0, 1.0, 1.0, 1.0), u_xlat24.xyxy).xy;
    u_xlatb24.x = u_xlatb24.y || u_xlatb24.x;
    u_xlat1.xy = _Normal0_TexelSize.zw;
    u_xlat1 = (u_xlatb24.x) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb36 = !!(u_xlat0.x<0.800000012);
#else
    u_xlatb36 = u_xlat0.x<0.800000012;
#endif
    if(u_xlatb36){
        u_xlat12.xz = (u_xlatb12.x) ? _Diffuse1_ST.xy : vec2(1.0, 1.0);
        u_xlat3.xy = (u_xlatb24.x) ? _Diffuse1_ST.xy : vec2(1.0, 1.0);
        u_xlat4.zw = vec2(vs_TEXCOORD2.x + (-_Diffuse2_ST.z), vs_TEXCOORD2.y + (-_Diffuse2_ST.w));
        u_xlat12.xy = u_xlat12.xz * u_xlat2.xy;
        u_xlat27.xy = vec2(_Diffuse2_ST.x * _Diffuse2_TexelSize.z, _Diffuse2_ST.y * _Diffuse2_TexelSize.w);
        u_xlatb12.xy = lessThan(u_xlat12.xyxx, u_xlat27.xyxx).xy;
        u_xlatb12.x = u_xlatb12.y || u_xlatb12.x;
        u_xlat4.xy = _Diffuse2_TexelSize.zw;
        u_xlat2 = (u_xlatb12.x) ? u_xlat4 : u_xlat2;
        u_xlat12.xy = u_xlat1.xy * u_xlat3.xy;
        u_xlat3.xy = vec2(_Diffuse2_ST.x * _Normal2_TexelSize.z, _Diffuse2_ST.y * _Normal2_TexelSize.w);
        u_xlatb12.xy = lessThan(u_xlat12.xyxx, u_xlat3.xyxx).xy;
        u_xlatb12.x = u_xlatb12.y || u_xlatb12.x;
        u_xlat4.xy = _Normal2_TexelSize.zw;
        u_xlat1 = (u_xlatb12.x) ? u_xlat4 : u_xlat1;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb12.x = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb12.x = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb12.x){
        u_xlatb12.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.899999976), vec4(_LODIndex)).xyz;
        u_xlat3 = (u_xlatb12.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat3 = (u_xlatb12.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat3;
        u_xlat3 = (u_xlatb12.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat3;
        SV_Target0 = u_xlat3;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb12.x = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb12.x = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb12.x){
        u_xlat10_12.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.xy).xyz;
        SV_Target0.xyz = u_xlat10_12.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb12.x = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb12.x = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb12.x){
        u_xlat12.x = max(_GrassDiffuse_TexelSize.w, _GrassDiffuse_TexelSize.z);
        u_xlat12.x = max(u_xlat12.x, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb24.x = !!(256.0<u_xlat12.x);
#else
        u_xlatb24.x = 256.0<u_xlat12.x;
#endif
        u_xlatb12.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 1024.0), u_xlat12.xxxx).xz;
        u_xlat3 = (u_xlatb12.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat3 = (u_xlatb12.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat3;
        u_xlat3 = (u_xlatb24.x) ? u_xlat3 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat3;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb12.x = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb12.x = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb12.x){
        u_xlat12.xy = vec2(vs_TEXCOORD0.x * _GrassDiffuse_TexelSize.z, vs_TEXCOORD0.y * _GrassDiffuse_TexelSize.w);
        u_xlat3.xy = dFdx(u_xlat12.xy);
        u_xlat12.xy = dFdy(u_xlat12.xy);
        u_xlat36 = dot(u_xlat3.xy, u_xlat3.xy);
        u_xlat12.x = dot(u_xlat12.xy, u_xlat12.xy);
        u_xlat12.x = max(u_xlat12.x, u_xlat36);
        u_xlat12.x = log2(u_xlat12.x);
        u_xlat12.x = u_xlat12.x * 0.5;
        u_xlat12.x = max(u_xlat12.x, 0.0);
        u_xlat12.x = u_xlat12.x + 1.0;
        u_xlat24.x = max(_GrassDiffuse_TexelSize.w, _GrassDiffuse_TexelSize.z);
        u_xlat12.x = u_xlat24.x / u_xlat12.x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb24.x = !!(256.0<u_xlat12.x);
#else
        u_xlatb24.x = 256.0<u_xlat12.x;
#endif
        u_xlatb12.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 1024.0), u_xlat12.xxxx).xz;
        u_xlat3 = (u_xlatb12.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat3 = (u_xlatb12.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat3;
        u_xlat3 = (u_xlatb24.x) ? u_xlat3 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat3;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb12.x = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb12.x = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb12.x){
        u_xlat3.zw = vec2(vs_TEXCOORD0.x + (-_GrassDiffuse_ST.z), vs_TEXCOORD0.y + (-_GrassDiffuse_ST.w));
        u_xlat12.xy = vec2(_GrassDiffuse_ST.x * _GrassDiffuse_TexelSize.z, _GrassDiffuse_ST.y * _GrassDiffuse_TexelSize.w);
        u_xlatb12.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat12.xyxx).xy;
        u_xlatb12.x = u_xlatb12.y || u_xlatb12.x;
        u_xlat3.xy = _GrassDiffuse_TexelSize.zw;
        u_xlat4 = (u_xlatb12.x) ? u_xlat3 : vec4(1.0, 1.0, 0.0, 0.0);
        u_xlat2 = u_xlat2 + (-u_xlat4);
        u_xlat2 = vs_COLOR0.wwww * u_xlat2 + u_xlat4;
#ifdef UNITY_ADRENO_ES3
        u_xlatb12.x = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb12.x = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb12.x){
            u_xlat12.xy = vec2(u_xlat2.x * u_xlat2.z, u_xlat2.y * u_xlat2.w);
            u_xlat4.xy = dFdx(u_xlat12.xy);
            u_xlat12.xy = dFdy(u_xlat12.xy);
            u_xlat36 = dot(u_xlat4.xy, u_xlat4.xy);
            u_xlat28 = dot(u_xlat12.xy, u_xlat12.xy);
            u_xlat36 = max(u_xlat36, u_xlat28);
            u_xlat36 = log2(u_xlat36);
            u_xlat36 = u_xlat36 * 0.5;
            u_xlat36 = max(u_xlat36, 0.0);
            u_xlat36 = u_xlat36 + 1.0;
            u_xlat28 = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat4.xy = vec2(u_xlat28) * u_xlat4.xy;
            u_xlat12.xy = u_xlat12.xy * vec2(u_xlat28);
            u_xlat4.xy = u_xlat4.xy / vec2(u_xlat36);
            u_xlat12.xy = u_xlat12.xy / vec2(u_xlat36);
            u_xlat24.y = dot(abs(u_xlat4.xy), abs(u_xlat4.xy));
            u_xlat24.x = dot(abs(u_xlat12.xy), abs(u_xlat12.xy));
            u_xlat16.xy = sqrt(u_xlat24.yx);
            u_xlat36 = inversesqrt(u_xlat24.y);
            u_xlat36 = u_xlat36 * abs(u_xlat4.x);
            u_xlat24.x = inversesqrt(u_xlat24.x);
            u_xlat12.x = u_xlat24.x * abs(u_xlat12.x);
            u_xlat12.x = u_xlat12.x * u_xlat36;
            u_xlat12.x = (-u_xlat12.x) * u_xlat12.x + 1.0;
            u_xlat12.x = sqrt(u_xlat12.x);
            u_xlat24.x = u_xlat16.y * u_xlat16.x;
            u_xlat36 = u_xlat12.x * u_xlat24.x;
            u_xlat4.xy = vec2(u_xlat2.z * float(3.0), u_xlat2.w * float(3.0));
            u_xlat28 = fract((-u_xlat4.x));
            u_xlat4.z = u_xlat28 + 0.5;
            u_xlat4.xy = fract(u_xlat4.xy);
            u_xlat4.xy = u_xlat4.xy + vec2(0.5, 0.5);
            u_xlat4.xyz = floor(u_xlat4.xyz);
            u_xlat28 = (-u_xlat4.x) + u_xlat4.z;
            u_xlat4.x = u_xlat28 * u_xlat4.y + u_xlat4.x;
            u_xlat16.x = (-u_xlat24.x) * u_xlat12.x + 1.0;
            u_xlat5.xyz = (-u_xlat4.xxx) + vec3(0.5, 0.0, 1.0);
            u_xlat16.xyz = u_xlat16.xxx * u_xlat5.xyz + u_xlat4.xxx;
            u_xlatb5.xw = lessThan(vec4(u_xlat36), vec4(1.0, 0.0, 0.0, 2.0)).xw;
            u_xlat6.xyz = u_xlat4.xxx * vec3(0.0, 1.0, 0.0);
            u_xlat12.x = u_xlat24.x * u_xlat12.x + -4.0;
            u_xlat12.x = exp2(u_xlat12.x);
            u_xlat12.x = u_xlat12.x + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
            u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
            u_xlat12.xyz = u_xlat12.xxx * u_xlat5.zyy + u_xlat4.xxx;
            u_xlat12.xyz = (u_xlatb5.w) ? u_xlat6.xyz : u_xlat12.xyz;
            u_xlat12.xyz = (u_xlatb5.x) ? u_xlat16.xyz : u_xlat12.xyz;
        } else {
            u_xlat4.xy = vec2(_GrassDiffuse_ST.x * _GrassNormal_TexelSize.z, _GrassDiffuse_ST.y * _GrassNormal_TexelSize.w);
            u_xlatb4.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat4.xyxx).xy;
            u_xlatb4.x = u_xlatb4.y || u_xlatb4.x;
            u_xlat3.xy = _GrassNormal_TexelSize.zw;
            u_xlat3 = (u_xlatb4.x) ? u_xlat3 : vec4(1.0, 1.0, 0.0, 0.0);
            u_xlat1 = u_xlat1 + (-u_xlat3);
            u_xlat1 = vs_COLOR0.wwww * u_xlat1 + u_xlat3;
#ifdef UNITY_ADRENO_ES3
            u_xlatb3.x = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb3.x = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb3.x){
                u_xlat3.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                u_xlat3.zw = dFdx(u_xlat3.xy);
                u_xlat3.xy = dFdy(u_xlat3.xy);
                u_xlat4.x = dot(u_xlat3.zw, u_xlat3.zw);
                u_xlat16.x = dot(u_xlat3.xy, u_xlat3.xy);
                u_xlat4.x = max(u_xlat16.x, u_xlat4.x);
                u_xlat4.x = log2(u_xlat4.x);
                u_xlat4.x = u_xlat4.x * 0.5;
                u_xlat4.x = max(u_xlat4.x, 0.0);
                u_xlat4.x = u_xlat4.x + 1.0;
                u_xlat16.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                u_xlat3 = u_xlat3 * u_xlat16.xxxx;
                u_xlat3 = u_xlat3 / u_xlat4.xxxx;
                u_xlat15.z = dot(abs(u_xlat3.zw), abs(u_xlat3.zw));
                u_xlat15.x = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                u_xlat4.xy = sqrt(u_xlat15.zx);
                u_xlat15.z = inversesqrt(u_xlat15.z);
                u_xlat15.x = inversesqrt(u_xlat15.x);
                u_xlat3.xz = u_xlat15.xz * abs(u_xlat3.xz);
                u_xlat3.x = u_xlat3.x * u_xlat3.z;
                u_xlat3.x = (-u_xlat3.x) * u_xlat3.x + 1.0;
                u_xlat3.x = sqrt(u_xlat3.x);
                u_xlat15.x = u_xlat4.y * u_xlat4.x;
                u_xlat27.x = u_xlat3.x * u_xlat15.x;
                u_xlat4.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                u_xlat39 = fract((-u_xlat4.x));
                u_xlat39 = u_xlat39 + 0.5;
                u_xlat39 = floor(u_xlat39);
                u_xlat4.xy = fract(u_xlat4.xy);
                u_xlat4.xy = u_xlat4.xy + vec2(0.5, 0.5);
                u_xlat4.xy = floor(u_xlat4.xy);
                u_xlat39 = u_xlat39 + (-u_xlat4.x);
                u_xlat39 = u_xlat39 * u_xlat4.y + u_xlat4.x;
                u_xlat4.x = (-u_xlat15.x) * u_xlat3.x + 1.0;
                u_xlat16.xyz = (-vec3(u_xlat39)) + vec3(0.5, 0.0, 1.0);
                u_xlat5.xyz = u_xlat4.xxx * u_xlat16.xyz + vec3(u_xlat39);
                u_xlatb4.xy = lessThan(u_xlat27.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                u_xlat6.xyz = vec3(u_xlat39) * vec3(0.0, 1.0, 0.0);
                u_xlat3.x = u_xlat15.x * u_xlat3.x + -4.0;
                u_xlat3.x = exp2(u_xlat3.x);
                u_xlat3.x = u_xlat3.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
                u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
                u_xlat3.xyz = u_xlat3.xxx * u_xlat16.zyy + vec3(u_xlat39);
                u_xlat3.xyz = (u_xlatb4.y) ? u_xlat6.xyz : u_xlat3.xyz;
                u_xlat12.xyz = (u_xlatb4.x) ? u_xlat5.xyz : u_xlat3.xyz;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb3.x = !!(u_xlat2.x>=u_xlat1.x);
#else
                u_xlatb3.x = u_xlat2.x>=u_xlat1.x;
#endif
                if(u_xlatb3.x){
                    u_xlat2.xy = vec2(u_xlat2.x * u_xlat2.z, u_xlat2.y * u_xlat2.w);
                    u_xlat3.xy = dFdx(u_xlat2.xy);
                    u_xlat2.xy = dFdy(u_xlat2.xy);
                    u_xlat27.x = dot(u_xlat3.xy, u_xlat3.xy);
                    u_xlat39 = dot(u_xlat2.xy, u_xlat2.xy);
                    u_xlat27.x = max(u_xlat39, u_xlat27.x);
                    u_xlat27.x = log2(u_xlat27.x);
                    u_xlat27.x = u_xlat27.x * 0.5;
                    u_xlat27.x = max(u_xlat27.x, 0.0);
                    u_xlat27.x = u_xlat27.x + 1.0;
                    u_xlat39 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat3.xy = vec2(u_xlat39) * u_xlat3.xy;
                    u_xlat2.xy = u_xlat2.xy * vec2(u_xlat39);
                    u_xlat3.xy = u_xlat3.xy / u_xlat27.xx;
                    u_xlat2.xy = u_xlat2.xy / u_xlat27.xx;
                    u_xlat15.x = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                    u_xlat14.x = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
                    u_xlat27.x = sqrt(u_xlat15.x);
                    u_xlat39 = sqrt(u_xlat14.x);
                    u_xlat15.x = inversesqrt(u_xlat15.x);
                    u_xlat3.x = u_xlat15.x * abs(u_xlat3.x);
                    u_xlat14.x = inversesqrt(u_xlat14.x);
                    u_xlat2.x = u_xlat14.x * abs(u_xlat2.x);
                    u_xlat2.x = u_xlat2.x * u_xlat3.x;
                    u_xlat2.x = (-u_xlat2.x) * u_xlat2.x + 1.0;
                    u_xlat2.x = sqrt(u_xlat2.x);
                    u_xlat14.x = u_xlat39 * u_xlat27.x;
                    u_xlat3.x = u_xlat2.x * u_xlat14.x;
                    u_xlat26.xy = vec2(u_xlat2.z * float(3.0), u_xlat2.w * float(3.0));
                    u_xlat15.x = fract((-u_xlat26.x));
                    u_xlat15.x = u_xlat15.x + 0.5;
                    u_xlat15.x = floor(u_xlat15.x);
                    u_xlat26.xy = fract(u_xlat26.xy);
                    u_xlat26.xy = u_xlat26.xy + vec2(0.5, 0.5);
                    u_xlat26.xy = floor(u_xlat26.xy);
                    u_xlat15.x = (-u_xlat26.x) + u_xlat15.x;
                    u_xlat26.x = u_xlat15.x * u_xlat26.y + u_xlat26.x;
                    u_xlat38 = (-u_xlat14.x) * u_xlat2.x + 1.0;
                    u_xlat15.xyz = (-u_xlat26.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat38) * u_xlat15.xyz + u_xlat26.xxx;
                    u_xlatb3.xy = lessThan(u_xlat3.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                    u_xlat5.xyz = u_xlat26.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat2.x = u_xlat14.x * u_xlat2.x + -4.0;
                    u_xlat2.x = exp2(u_xlat2.x);
                    u_xlat2.x = u_xlat2.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
                    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
                    u_xlat2.xyz = u_xlat2.xxx * u_xlat15.zyy + u_xlat26.xxx;
                    u_xlat2.xyz = (u_xlatb3.y) ? u_xlat5.xyz : u_xlat2.xyz;
                    u_xlat12.xyz = (u_xlatb3.x) ? u_xlat4.xyz : u_xlat2.xyz;
                } else {
                    u_xlat1.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat2.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat26.x = dot(u_xlat2.xy, u_xlat2.xy);
                    u_xlat38 = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat26.x = max(u_xlat38, u_xlat26.x);
                    u_xlat26.x = log2(u_xlat26.x);
                    u_xlat26.x = u_xlat26.x * 0.5;
                    u_xlat26.x = max(u_xlat26.x, 0.0);
                    u_xlat26.x = u_xlat26.x + 1.0;
                    u_xlat38 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat2.xy = vec2(u_xlat38) * u_xlat2.xy;
                    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat38);
                    u_xlat2.xy = u_xlat2.xy / u_xlat26.xx;
                    u_xlat1.xy = u_xlat1.xy / u_xlat26.xx;
                    u_xlat14.x = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
                    u_xlat13 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat26.x = sqrt(u_xlat14.x);
                    u_xlat38 = sqrt(u_xlat13);
                    u_xlat14.x = inversesqrt(u_xlat14.x);
                    u_xlat2.x = u_xlat14.x * abs(u_xlat2.x);
                    u_xlat13 = inversesqrt(u_xlat13);
                    u_xlat1.x = u_xlat13 * abs(u_xlat1.x);
                    u_xlat1.x = u_xlat1.x * u_xlat2.x;
                    u_xlat1.x = (-u_xlat1.x) * u_xlat1.x + 1.0;
                    u_xlat1.x = sqrt(u_xlat1.x);
                    u_xlat13 = u_xlat38 * u_xlat26.x;
                    u_xlat2.x = u_xlat1.x * u_xlat13;
                    u_xlat25.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat14.x = fract((-u_xlat25.x));
                    u_xlat14.x = u_xlat14.x + 0.5;
                    u_xlat14.x = floor(u_xlat14.x);
                    u_xlat25.xy = fract(u_xlat25.xy);
                    u_xlat25.xy = u_xlat25.xy + vec2(0.5, 0.5);
                    u_xlat25.xy = floor(u_xlat25.xy);
                    u_xlat14.x = (-u_xlat25.x) + u_xlat14.x;
                    u_xlat25.x = u_xlat14.x * u_xlat25.y + u_xlat25.x;
                    u_xlat37 = (-u_xlat13) * u_xlat1.x + 1.0;
                    u_xlat14.xyz = (-u_xlat25.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat3.xyz = vec3(u_xlat37) * u_xlat14.xyz + u_xlat25.xxx;
                    u_xlatb2.xy = lessThan(u_xlat2.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                    u_xlat4.xyz = u_xlat25.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat1.x = u_xlat13 * u_xlat1.x + -4.0;
                    u_xlat1.x = exp2(u_xlat1.x);
                    u_xlat1.x = u_xlat1.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
                    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
                    u_xlat1.xyz = u_xlat1.xxx * u_xlat14.zyy + u_xlat25.xxx;
                    u_xlat1.xyz = (u_xlatb2.y) ? u_xlat4.xyz : u_xlat1.xyz;
                    u_xlat12.xyz = (u_xlatb2.x) ? u_xlat3.xyz : u_xlat1.xyz;
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat12.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb12.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb12.x = u_xlatb12.y || u_xlatb12.x;
    if(u_xlatb12.x){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb12.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb12.x = u_xlatb12.y || u_xlatb12.x;
    if(u_xlatb12.x){
        SV_Target0 = vec4(0.400000006, 0.400000006, 0.400000006, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb12.x = !!(vs_COLOR0.w<0.99000001);
#else
    u_xlatb12.x = vs_COLOR0.w<0.99000001;
#endif
    if(u_xlatb12.x){
        u_xlat10_12.xyz = texture(_GrassNormal, vs_TEXCOORD0.xy, -1.0).xyz;
        u_xlat16_7.xyz = u_xlat10_12.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat10_12.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.xy, -1.0).xyz;
        u_xlat16_8.xyz = u_xlat10_12.xyz;
    } else {
        u_xlat16_8.x = float(0.0);
        u_xlat16_8.y = float(0.0);
        u_xlat16_8.z = float(0.0);
        u_xlat16_7.x = float(0.0);
        u_xlat16_7.y = float(0.0);
        u_xlat16_7.z = float(1.0);
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb12.x = !!(0.00999999978<vs_COLOR0.w);
#else
    u_xlatb12.x = 0.00999999978<vs_COLOR0.w;
#endif
    if(u_xlatb12.x){
        u_xlat10_12.xyz = texture(_Normal0, vs_TEXCOORD0.zw, -1.0).xyz;
        u_xlat10_1.xy = texture(_Normal2, vs_TEXCOORD2.xy, -1.0).xy;
        u_xlat16_9.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_43 = (-u_xlat0.x) + 1.0;
        u_xlat16_9.xy = vec2(u_xlat16_43) * u_xlat16_9.xy;
        u_xlat16_9.xy = u_xlat16_9.xy * vs_COLOR0.xx;
        u_xlat10_1 = texture(_Diffuse1, vs_TEXCOORD0.zw, -1.0);
        u_xlat16_43 = u_xlat10_1.w * _UseDiffuseOneHeight;
        u_xlat16_10.xyz = u_xlat10_12.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, 0.0);
        u_xlat16_9.z = -1.0;
        u_xlat16_9.xyz = u_xlat16_9.xyz + u_xlat16_10.xyz;
        u_xlat16_10.xyz = u_xlat10_1.xyz;
    } else {
        u_xlat16_10.x = float(0.0);
        u_xlat16_10.y = float(0.0);
        u_xlat16_10.z = float(0.0);
        u_xlat16_9.x = float(0.0);
        u_xlat16_9.y = float(0.0);
        u_xlat16_9.z = float(1.0);
        u_xlat16_43 = 1.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor);
#endif
    u_xlat16_11.xyz = u_xlat16_10.xyz * _TintColor.xyz;
    u_xlat16_10.xyz = (bool(u_xlatb0)) ? u_xlat16_11.xyz : u_xlat16_10.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend);
#endif
    u_xlat16_12 = u_xlat16_43;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12 = min(max(u_xlat16_12, 0.0), 1.0);
#else
    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
#endif
    u_xlat16_24 = vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_43 = _HeightContrast * 10.0;
    u_xlat16_12 = u_xlat16_12 + -1.0;
    u_xlat16_44 = _HeightSpread + 0.100000001;
    u_xlat16_24 = log2(u_xlat16_24);
    u_xlat16_24 = u_xlat16_24 * u_xlat16_44;
    u_xlat16_24 = exp2(u_xlat16_24);
    u_xlat16_12 = u_xlat16_24 * 2.0 + u_xlat16_12;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12 = min(max(u_xlat16_12, 0.0), 1.0);
#else
    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
#endif
    u_xlat16_24 = _HeightContrast * 10.0 + 1.0;
    u_xlat16_24 = _HeightContrast * 10.0 + u_xlat16_24;
    u_xlat12.x = u_xlat16_12 * u_xlat16_24 + (-u_xlat16_43);
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat16_43 = (u_xlatb0) ? u_xlat12.x : vs_COLOR0.w;
    u_xlat16_9.xyz = (-u_xlat16_7.xyz) + u_xlat16_9.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_43) * u_xlat16_9.xyz + u_xlat16_7.xyz;
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + u_xlat16_10.xyz;
    u_xlat16_8.xyz = vec3(u_xlat16_43) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, u_xlat16_7.xyz);
    u_xlat0.y = dot(vs_TEXCOORD4.xyz, u_xlat16_7.xyz);
    u_xlat0.z = dot(vs_TEXCOORD5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = _Terrain_Smoothness * _Shininess;
    u_xlat16_7.x = max(u_xlat16_7.x, 0.0);
    SV_Target2.w = min(u_xlat16_7.x, 0.5);
    u_xlat16_7.xyz = u_xlat16_8.xyz * vec3(vec3(_Terrain_Specular, _Terrain_Specular, _Terrain_Specular));
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz;
    u_xlat16_43 = max(u_xlat16_7.z, u_xlat16_7.y);
    u_xlat16_43 = max(u_xlat16_43, u_xlat16_7.x);
    u_xlat16_43 = (-u_xlat16_43) + 1.0;
    SV_Target1.xyz = vec3(u_xlat16_43) * u_xlat16_8.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_43 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_43 : u_xlat16_7.z;
    SV_Target0.w = 0.0;
    SV_Target1.w = _SSAO_Intensity;
    SV_Target2.xy = u_xlat16_7.xy;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _Diffuse1_ST;
uniform 	float _UVDiffuse2;
uniform 	vec4 _Diffuse2_ST;
uniform 	float _UVDetail;
uniform 	vec4 _DetailDiffuse_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat7;
float u_xlat16;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x;
    u_xlat2.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].x;
    u_xlat2.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].x;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].y;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].y;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].y;
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.xy = sqrt(u_xlat2.xy);
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].z;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].z;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].z;
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat2.x = u_xlat7.x + u_xlat2.x;
    u_xlat2.x = u_xlat2.x * 0.330000013;
    u_xlat7.xy = u_xlat2.xx * in_TEXCOORD0.xy;
    u_xlat2.xw = u_xlat2.xx * in_TEXCOORD1.xy;
    vs_TEXCOORD0.xy = u_xlat7.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Diffuse1_ST.xy + _Diffuse1_ST.zw;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UVDiffuse2==0.0);
#else
    u_xlatb1 = _UVDiffuse2==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb1)) ? u_xlat7.xy : u_xlat2.xw;
    vs_TEXCOORD2.xy = u_xlat1.xy * _Diffuse2_ST.xy + _Diffuse2_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UVDetail==0.0);
#else
    u_xlatb1 = _UVDetail==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb1)) ? u_xlat7.xy : u_xlat2.xw;
    vs_TEXCOORD2.zw = u_xlat1.xy * _DetailDiffuse_ST.xy + _DetailDiffuse_ST.zw;
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat2.xyz = vec3(u_xlat0) * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_4.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = vec3(u_xlat0) * u_xlat16_4.xyz;
    vs_TEXCOORD3.y = u_xlat16_4.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD3.w = u_xlat5.x;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat5.y;
    vs_TEXCOORD5.w = u_xlat5.z;
    vs_TEXCOORD4.y = u_xlat16_4.y;
    vs_TEXCOORD5.y = u_xlat16_4.z;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	mediump float _HeightSpread;
uniform 	mediump float _HeightContrast;
uniform 	mediump float _UseTintColor;
uniform 	mediump float _UseDiffuseOneHeight;
uniform 	mediump float _UseGrassHeightBlend;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _SSAO_Intensity;
uniform 	mediump float _Terrain_Smoothness;
uniform 	mediump float _Terrain_Specular;
uniform 	mediump float _Shininess;
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _GrassDiffuse_TexelSize;
uniform 	vec4 _GrassNormal_TexelSize;
uniform 	float _GrassNormalScale;
uniform 	vec4 _Diffuse1_ST;
uniform 	vec4 _Diffuse1_TexelSize;
uniform 	vec4 _Normal0_TexelSize;
uniform 	float _Normal0Scale;
uniform 	vec4 _Diffuse2_ST;
uniform 	vec4 _Diffuse2_TexelSize;
uniform 	vec4 _Normal2_TexelSize;
uniform 	mediump float _Normal2Scale;
uniform 	mediump float _Diffuse2Distance;
uniform 	mediump float _Diffuse2Fade;
uniform lowp sampler2D _GrassDiffuse;
uniform lowp sampler2D _GrassNormal;
uniform lowp sampler2D _Normal0;
uniform lowp sampler2D _Normal2;
uniform lowp sampler2D _Diffuse1;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec2 u_xlat10_1;
vec4 u_xlat2;
bvec2 u_xlatb2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
bvec2 u_xlatb4;
vec3 u_xlat5;
bvec4 u_xlatb5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
mediump float u_xlat16_12;
lowp vec3 u_xlat10_12;
bvec3 u_xlatb12;
float u_xlat13;
vec3 u_xlat14;
vec3 u_xlat15;
vec3 u_xlat16;
vec2 u_xlat24;
mediump float u_xlat16_24;
bvec2 u_xlatb24;
vec2 u_xlat25;
vec2 u_xlat26;
vec2 u_xlat27;
float u_xlat28;
float u_xlat36;
bool u_xlatb36;
float u_xlat37;
float u_xlat38;
float u_xlat39;
mediump float u_xlat16_43;
mediump float u_xlat16_44;
void main()
{
    u_xlat0.x = vs_TEXCOORD3.w;
    u_xlat0.y = vs_TEXCOORD4.w;
    u_xlat0.z = vs_TEXCOORD5.w;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x / _Diffuse2Distance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + 9.99999975e-05;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Diffuse2Fade;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat1.zw = vec2(vs_TEXCOORD0.z + (-_Diffuse1_ST.z), vs_TEXCOORD0.w + (-_Diffuse1_ST.w));
    u_xlat12.xy = vec2(_Diffuse1_ST.x * _Diffuse1_TexelSize.z, _Diffuse1_ST.y * _Diffuse1_TexelSize.w);
    u_xlatb12.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat12.xyxx).xy;
    u_xlatb12.x = u_xlatb12.y || u_xlatb12.x;
    u_xlat1.xy = _Diffuse1_TexelSize.zw;
    u_xlat2 = (u_xlatb12.x) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
    u_xlat24.xy = vec2(_Diffuse1_ST.x * _Normal0_TexelSize.z, _Diffuse1_ST.y * _Normal0_TexelSize.w);
    u_xlatb24.xy = lessThan(vec4(1.0, 1.0, 1.0, 1.0), u_xlat24.xyxy).xy;
    u_xlatb24.x = u_xlatb24.y || u_xlatb24.x;
    u_xlat1.xy = _Normal0_TexelSize.zw;
    u_xlat1 = (u_xlatb24.x) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb36 = !!(u_xlat0.x<0.800000012);
#else
    u_xlatb36 = u_xlat0.x<0.800000012;
#endif
    if(u_xlatb36){
        u_xlat12.xz = (u_xlatb12.x) ? _Diffuse1_ST.xy : vec2(1.0, 1.0);
        u_xlat3.xy = (u_xlatb24.x) ? _Diffuse1_ST.xy : vec2(1.0, 1.0);
        u_xlat4.zw = vec2(vs_TEXCOORD2.x + (-_Diffuse2_ST.z), vs_TEXCOORD2.y + (-_Diffuse2_ST.w));
        u_xlat12.xy = u_xlat12.xz * u_xlat2.xy;
        u_xlat27.xy = vec2(_Diffuse2_ST.x * _Diffuse2_TexelSize.z, _Diffuse2_ST.y * _Diffuse2_TexelSize.w);
        u_xlatb12.xy = lessThan(u_xlat12.xyxx, u_xlat27.xyxx).xy;
        u_xlatb12.x = u_xlatb12.y || u_xlatb12.x;
        u_xlat4.xy = _Diffuse2_TexelSize.zw;
        u_xlat2 = (u_xlatb12.x) ? u_xlat4 : u_xlat2;
        u_xlat12.xy = u_xlat1.xy * u_xlat3.xy;
        u_xlat3.xy = vec2(_Diffuse2_ST.x * _Normal2_TexelSize.z, _Diffuse2_ST.y * _Normal2_TexelSize.w);
        u_xlatb12.xy = lessThan(u_xlat12.xyxx, u_xlat3.xyxx).xy;
        u_xlatb12.x = u_xlatb12.y || u_xlatb12.x;
        u_xlat4.xy = _Normal2_TexelSize.zw;
        u_xlat1 = (u_xlatb12.x) ? u_xlat4 : u_xlat1;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb12.x = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb12.x = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb12.x){
        u_xlatb12.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.899999976), vec4(_LODIndex)).xyz;
        u_xlat3 = (u_xlatb12.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat3 = (u_xlatb12.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat3;
        u_xlat3 = (u_xlatb12.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat3;
        SV_Target0 = u_xlat3;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb12.x = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb12.x = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb12.x){
        u_xlat10_12.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.xy).xyz;
        SV_Target0.xyz = u_xlat10_12.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb12.x = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb12.x = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb12.x){
        u_xlat12.x = max(_GrassDiffuse_TexelSize.w, _GrassDiffuse_TexelSize.z);
        u_xlat12.x = max(u_xlat12.x, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb24.x = !!(256.0<u_xlat12.x);
#else
        u_xlatb24.x = 256.0<u_xlat12.x;
#endif
        u_xlatb12.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 1024.0), u_xlat12.xxxx).xz;
        u_xlat3 = (u_xlatb12.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat3 = (u_xlatb12.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat3;
        u_xlat3 = (u_xlatb24.x) ? u_xlat3 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat3;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb12.x = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb12.x = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb12.x){
        u_xlat12.xy = vec2(vs_TEXCOORD0.x * _GrassDiffuse_TexelSize.z, vs_TEXCOORD0.y * _GrassDiffuse_TexelSize.w);
        u_xlat3.xy = dFdx(u_xlat12.xy);
        u_xlat12.xy = dFdy(u_xlat12.xy);
        u_xlat36 = dot(u_xlat3.xy, u_xlat3.xy);
        u_xlat12.x = dot(u_xlat12.xy, u_xlat12.xy);
        u_xlat12.x = max(u_xlat12.x, u_xlat36);
        u_xlat12.x = log2(u_xlat12.x);
        u_xlat12.x = u_xlat12.x * 0.5;
        u_xlat12.x = max(u_xlat12.x, 0.0);
        u_xlat12.x = u_xlat12.x + 1.0;
        u_xlat24.x = max(_GrassDiffuse_TexelSize.w, _GrassDiffuse_TexelSize.z);
        u_xlat12.x = u_xlat24.x / u_xlat12.x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb24.x = !!(256.0<u_xlat12.x);
#else
        u_xlatb24.x = 256.0<u_xlat12.x;
#endif
        u_xlatb12.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 1024.0), u_xlat12.xxxx).xz;
        u_xlat3 = (u_xlatb12.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat3 = (u_xlatb12.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat3;
        u_xlat3 = (u_xlatb24.x) ? u_xlat3 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat3;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb12.x = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb12.x = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb12.x){
        u_xlat3.zw = vec2(vs_TEXCOORD0.x + (-_GrassDiffuse_ST.z), vs_TEXCOORD0.y + (-_GrassDiffuse_ST.w));
        u_xlat12.xy = vec2(_GrassDiffuse_ST.x * _GrassDiffuse_TexelSize.z, _GrassDiffuse_ST.y * _GrassDiffuse_TexelSize.w);
        u_xlatb12.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat12.xyxx).xy;
        u_xlatb12.x = u_xlatb12.y || u_xlatb12.x;
        u_xlat3.xy = _GrassDiffuse_TexelSize.zw;
        u_xlat4 = (u_xlatb12.x) ? u_xlat3 : vec4(1.0, 1.0, 0.0, 0.0);
        u_xlat2 = u_xlat2 + (-u_xlat4);
        u_xlat2 = vs_COLOR0.wwww * u_xlat2 + u_xlat4;
#ifdef UNITY_ADRENO_ES3
        u_xlatb12.x = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb12.x = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb12.x){
            u_xlat12.xy = vec2(u_xlat2.x * u_xlat2.z, u_xlat2.y * u_xlat2.w);
            u_xlat4.xy = dFdx(u_xlat12.xy);
            u_xlat12.xy = dFdy(u_xlat12.xy);
            u_xlat36 = dot(u_xlat4.xy, u_xlat4.xy);
            u_xlat28 = dot(u_xlat12.xy, u_xlat12.xy);
            u_xlat36 = max(u_xlat36, u_xlat28);
            u_xlat36 = log2(u_xlat36);
            u_xlat36 = u_xlat36 * 0.5;
            u_xlat36 = max(u_xlat36, 0.0);
            u_xlat36 = u_xlat36 + 1.0;
            u_xlat28 = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat4.xy = vec2(u_xlat28) * u_xlat4.xy;
            u_xlat12.xy = u_xlat12.xy * vec2(u_xlat28);
            u_xlat4.xy = u_xlat4.xy / vec2(u_xlat36);
            u_xlat12.xy = u_xlat12.xy / vec2(u_xlat36);
            u_xlat24.y = dot(abs(u_xlat4.xy), abs(u_xlat4.xy));
            u_xlat24.x = dot(abs(u_xlat12.xy), abs(u_xlat12.xy));
            u_xlat16.xy = sqrt(u_xlat24.yx);
            u_xlat36 = inversesqrt(u_xlat24.y);
            u_xlat36 = u_xlat36 * abs(u_xlat4.x);
            u_xlat24.x = inversesqrt(u_xlat24.x);
            u_xlat12.x = u_xlat24.x * abs(u_xlat12.x);
            u_xlat12.x = u_xlat12.x * u_xlat36;
            u_xlat12.x = (-u_xlat12.x) * u_xlat12.x + 1.0;
            u_xlat12.x = sqrt(u_xlat12.x);
            u_xlat24.x = u_xlat16.y * u_xlat16.x;
            u_xlat36 = u_xlat12.x * u_xlat24.x;
            u_xlat4.xy = vec2(u_xlat2.z * float(3.0), u_xlat2.w * float(3.0));
            u_xlat28 = fract((-u_xlat4.x));
            u_xlat4.z = u_xlat28 + 0.5;
            u_xlat4.xy = fract(u_xlat4.xy);
            u_xlat4.xy = u_xlat4.xy + vec2(0.5, 0.5);
            u_xlat4.xyz = floor(u_xlat4.xyz);
            u_xlat28 = (-u_xlat4.x) + u_xlat4.z;
            u_xlat4.x = u_xlat28 * u_xlat4.y + u_xlat4.x;
            u_xlat16.x = (-u_xlat24.x) * u_xlat12.x + 1.0;
            u_xlat5.xyz = (-u_xlat4.xxx) + vec3(0.5, 0.0, 1.0);
            u_xlat16.xyz = u_xlat16.xxx * u_xlat5.xyz + u_xlat4.xxx;
            u_xlatb5.xw = lessThan(vec4(u_xlat36), vec4(1.0, 0.0, 0.0, 2.0)).xw;
            u_xlat6.xyz = u_xlat4.xxx * vec3(0.0, 1.0, 0.0);
            u_xlat12.x = u_xlat24.x * u_xlat12.x + -4.0;
            u_xlat12.x = exp2(u_xlat12.x);
            u_xlat12.x = u_xlat12.x + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
            u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
            u_xlat12.xyz = u_xlat12.xxx * u_xlat5.zyy + u_xlat4.xxx;
            u_xlat12.xyz = (u_xlatb5.w) ? u_xlat6.xyz : u_xlat12.xyz;
            u_xlat12.xyz = (u_xlatb5.x) ? u_xlat16.xyz : u_xlat12.xyz;
        } else {
            u_xlat4.xy = vec2(_GrassDiffuse_ST.x * _GrassNormal_TexelSize.z, _GrassDiffuse_ST.y * _GrassNormal_TexelSize.w);
            u_xlatb4.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat4.xyxx).xy;
            u_xlatb4.x = u_xlatb4.y || u_xlatb4.x;
            u_xlat3.xy = _GrassNormal_TexelSize.zw;
            u_xlat3 = (u_xlatb4.x) ? u_xlat3 : vec4(1.0, 1.0, 0.0, 0.0);
            u_xlat1 = u_xlat1 + (-u_xlat3);
            u_xlat1 = vs_COLOR0.wwww * u_xlat1 + u_xlat3;
#ifdef UNITY_ADRENO_ES3
            u_xlatb3.x = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb3.x = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb3.x){
                u_xlat3.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                u_xlat3.zw = dFdx(u_xlat3.xy);
                u_xlat3.xy = dFdy(u_xlat3.xy);
                u_xlat4.x = dot(u_xlat3.zw, u_xlat3.zw);
                u_xlat16.x = dot(u_xlat3.xy, u_xlat3.xy);
                u_xlat4.x = max(u_xlat16.x, u_xlat4.x);
                u_xlat4.x = log2(u_xlat4.x);
                u_xlat4.x = u_xlat4.x * 0.5;
                u_xlat4.x = max(u_xlat4.x, 0.0);
                u_xlat4.x = u_xlat4.x + 1.0;
                u_xlat16.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                u_xlat3 = u_xlat3 * u_xlat16.xxxx;
                u_xlat3 = u_xlat3 / u_xlat4.xxxx;
                u_xlat15.z = dot(abs(u_xlat3.zw), abs(u_xlat3.zw));
                u_xlat15.x = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                u_xlat4.xy = sqrt(u_xlat15.zx);
                u_xlat15.z = inversesqrt(u_xlat15.z);
                u_xlat15.x = inversesqrt(u_xlat15.x);
                u_xlat3.xz = u_xlat15.xz * abs(u_xlat3.xz);
                u_xlat3.x = u_xlat3.x * u_xlat3.z;
                u_xlat3.x = (-u_xlat3.x) * u_xlat3.x + 1.0;
                u_xlat3.x = sqrt(u_xlat3.x);
                u_xlat15.x = u_xlat4.y * u_xlat4.x;
                u_xlat27.x = u_xlat3.x * u_xlat15.x;
                u_xlat4.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                u_xlat39 = fract((-u_xlat4.x));
                u_xlat39 = u_xlat39 + 0.5;
                u_xlat39 = floor(u_xlat39);
                u_xlat4.xy = fract(u_xlat4.xy);
                u_xlat4.xy = u_xlat4.xy + vec2(0.5, 0.5);
                u_xlat4.xy = floor(u_xlat4.xy);
                u_xlat39 = u_xlat39 + (-u_xlat4.x);
                u_xlat39 = u_xlat39 * u_xlat4.y + u_xlat4.x;
                u_xlat4.x = (-u_xlat15.x) * u_xlat3.x + 1.0;
                u_xlat16.xyz = (-vec3(u_xlat39)) + vec3(0.5, 0.0, 1.0);
                u_xlat5.xyz = u_xlat4.xxx * u_xlat16.xyz + vec3(u_xlat39);
                u_xlatb4.xy = lessThan(u_xlat27.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                u_xlat6.xyz = vec3(u_xlat39) * vec3(0.0, 1.0, 0.0);
                u_xlat3.x = u_xlat15.x * u_xlat3.x + -4.0;
                u_xlat3.x = exp2(u_xlat3.x);
                u_xlat3.x = u_xlat3.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
                u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
                u_xlat3.xyz = u_xlat3.xxx * u_xlat16.zyy + vec3(u_xlat39);
                u_xlat3.xyz = (u_xlatb4.y) ? u_xlat6.xyz : u_xlat3.xyz;
                u_xlat12.xyz = (u_xlatb4.x) ? u_xlat5.xyz : u_xlat3.xyz;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb3.x = !!(u_xlat2.x>=u_xlat1.x);
#else
                u_xlatb3.x = u_xlat2.x>=u_xlat1.x;
#endif
                if(u_xlatb3.x){
                    u_xlat2.xy = vec2(u_xlat2.x * u_xlat2.z, u_xlat2.y * u_xlat2.w);
                    u_xlat3.xy = dFdx(u_xlat2.xy);
                    u_xlat2.xy = dFdy(u_xlat2.xy);
                    u_xlat27.x = dot(u_xlat3.xy, u_xlat3.xy);
                    u_xlat39 = dot(u_xlat2.xy, u_xlat2.xy);
                    u_xlat27.x = max(u_xlat39, u_xlat27.x);
                    u_xlat27.x = log2(u_xlat27.x);
                    u_xlat27.x = u_xlat27.x * 0.5;
                    u_xlat27.x = max(u_xlat27.x, 0.0);
                    u_xlat27.x = u_xlat27.x + 1.0;
                    u_xlat39 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat3.xy = vec2(u_xlat39) * u_xlat3.xy;
                    u_xlat2.xy = u_xlat2.xy * vec2(u_xlat39);
                    u_xlat3.xy = u_xlat3.xy / u_xlat27.xx;
                    u_xlat2.xy = u_xlat2.xy / u_xlat27.xx;
                    u_xlat15.x = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                    u_xlat14.x = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
                    u_xlat27.x = sqrt(u_xlat15.x);
                    u_xlat39 = sqrt(u_xlat14.x);
                    u_xlat15.x = inversesqrt(u_xlat15.x);
                    u_xlat3.x = u_xlat15.x * abs(u_xlat3.x);
                    u_xlat14.x = inversesqrt(u_xlat14.x);
                    u_xlat2.x = u_xlat14.x * abs(u_xlat2.x);
                    u_xlat2.x = u_xlat2.x * u_xlat3.x;
                    u_xlat2.x = (-u_xlat2.x) * u_xlat2.x + 1.0;
                    u_xlat2.x = sqrt(u_xlat2.x);
                    u_xlat14.x = u_xlat39 * u_xlat27.x;
                    u_xlat3.x = u_xlat2.x * u_xlat14.x;
                    u_xlat26.xy = vec2(u_xlat2.z * float(3.0), u_xlat2.w * float(3.0));
                    u_xlat15.x = fract((-u_xlat26.x));
                    u_xlat15.x = u_xlat15.x + 0.5;
                    u_xlat15.x = floor(u_xlat15.x);
                    u_xlat26.xy = fract(u_xlat26.xy);
                    u_xlat26.xy = u_xlat26.xy + vec2(0.5, 0.5);
                    u_xlat26.xy = floor(u_xlat26.xy);
                    u_xlat15.x = (-u_xlat26.x) + u_xlat15.x;
                    u_xlat26.x = u_xlat15.x * u_xlat26.y + u_xlat26.x;
                    u_xlat38 = (-u_xlat14.x) * u_xlat2.x + 1.0;
                    u_xlat15.xyz = (-u_xlat26.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat38) * u_xlat15.xyz + u_xlat26.xxx;
                    u_xlatb3.xy = lessThan(u_xlat3.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                    u_xlat5.xyz = u_xlat26.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat2.x = u_xlat14.x * u_xlat2.x + -4.0;
                    u_xlat2.x = exp2(u_xlat2.x);
                    u_xlat2.x = u_xlat2.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
                    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
                    u_xlat2.xyz = u_xlat2.xxx * u_xlat15.zyy + u_xlat26.xxx;
                    u_xlat2.xyz = (u_xlatb3.y) ? u_xlat5.xyz : u_xlat2.xyz;
                    u_xlat12.xyz = (u_xlatb3.x) ? u_xlat4.xyz : u_xlat2.xyz;
                } else {
                    u_xlat1.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat2.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat26.x = dot(u_xlat2.xy, u_xlat2.xy);
                    u_xlat38 = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat26.x = max(u_xlat38, u_xlat26.x);
                    u_xlat26.x = log2(u_xlat26.x);
                    u_xlat26.x = u_xlat26.x * 0.5;
                    u_xlat26.x = max(u_xlat26.x, 0.0);
                    u_xlat26.x = u_xlat26.x + 1.0;
                    u_xlat38 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat2.xy = vec2(u_xlat38) * u_xlat2.xy;
                    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat38);
                    u_xlat2.xy = u_xlat2.xy / u_xlat26.xx;
                    u_xlat1.xy = u_xlat1.xy / u_xlat26.xx;
                    u_xlat14.x = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
                    u_xlat13 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat26.x = sqrt(u_xlat14.x);
                    u_xlat38 = sqrt(u_xlat13);
                    u_xlat14.x = inversesqrt(u_xlat14.x);
                    u_xlat2.x = u_xlat14.x * abs(u_xlat2.x);
                    u_xlat13 = inversesqrt(u_xlat13);
                    u_xlat1.x = u_xlat13 * abs(u_xlat1.x);
                    u_xlat1.x = u_xlat1.x * u_xlat2.x;
                    u_xlat1.x = (-u_xlat1.x) * u_xlat1.x + 1.0;
                    u_xlat1.x = sqrt(u_xlat1.x);
                    u_xlat13 = u_xlat38 * u_xlat26.x;
                    u_xlat2.x = u_xlat1.x * u_xlat13;
                    u_xlat25.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat14.x = fract((-u_xlat25.x));
                    u_xlat14.x = u_xlat14.x + 0.5;
                    u_xlat14.x = floor(u_xlat14.x);
                    u_xlat25.xy = fract(u_xlat25.xy);
                    u_xlat25.xy = u_xlat25.xy + vec2(0.5, 0.5);
                    u_xlat25.xy = floor(u_xlat25.xy);
                    u_xlat14.x = (-u_xlat25.x) + u_xlat14.x;
                    u_xlat25.x = u_xlat14.x * u_xlat25.y + u_xlat25.x;
                    u_xlat37 = (-u_xlat13) * u_xlat1.x + 1.0;
                    u_xlat14.xyz = (-u_xlat25.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat3.xyz = vec3(u_xlat37) * u_xlat14.xyz + u_xlat25.xxx;
                    u_xlatb2.xy = lessThan(u_xlat2.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                    u_xlat4.xyz = u_xlat25.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat1.x = u_xlat13 * u_xlat1.x + -4.0;
                    u_xlat1.x = exp2(u_xlat1.x);
                    u_xlat1.x = u_xlat1.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
                    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
                    u_xlat1.xyz = u_xlat1.xxx * u_xlat14.zyy + u_xlat25.xxx;
                    u_xlat1.xyz = (u_xlatb2.y) ? u_xlat4.xyz : u_xlat1.xyz;
                    u_xlat12.xyz = (u_xlatb2.x) ? u_xlat3.xyz : u_xlat1.xyz;
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat12.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb12.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb12.x = u_xlatb12.y || u_xlatb12.x;
    if(u_xlatb12.x){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb12.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb12.x = u_xlatb12.y || u_xlatb12.x;
    if(u_xlatb12.x){
        SV_Target0 = vec4(0.400000006, 0.400000006, 0.400000006, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb12.x = !!(vs_COLOR0.w<0.99000001);
#else
    u_xlatb12.x = vs_COLOR0.w<0.99000001;
#endif
    if(u_xlatb12.x){
        u_xlat10_12.xyz = texture(_GrassNormal, vs_TEXCOORD0.xy, -1.0).xyz;
        u_xlat16_7.xyz = u_xlat10_12.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_7.xy = u_xlat16_7.xy * vec2(_GrassNormalScale);
        u_xlat10_12.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.xy, -1.0).xyz;
        u_xlat16_8.xyz = u_xlat10_12.xyz;
    } else {
        u_xlat16_8.x = float(0.0);
        u_xlat16_8.y = float(0.0);
        u_xlat16_8.z = float(0.0);
        u_xlat16_7.x = float(0.0);
        u_xlat16_7.y = float(0.0);
        u_xlat16_7.z = float(1.0);
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb12.x = !!(0.00999999978<vs_COLOR0.w);
#else
    u_xlatb12.x = 0.00999999978<vs_COLOR0.w;
#endif
    if(u_xlatb12.x){
        u_xlat10_12.xyz = texture(_Normal0, vs_TEXCOORD0.zw, -1.0).xyz;
        u_xlat10_1.xy = texture(_Normal2, vs_TEXCOORD2.xy, -1.0).xy;
        u_xlat16_9.z = u_xlat10_12.z + u_xlat10_12.z;
        u_xlat16_10.xy = u_xlat10_12.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_9.xy = u_xlat16_10.xy * vec2(_Normal0Scale);
        u_xlat16_10.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_10.xy = u_xlat16_10.xy * vec2(_Normal2Scale);
        u_xlat16_43 = (-u_xlat0.x) + 1.0;
        u_xlat16_10.xy = vec2(u_xlat16_43) * u_xlat16_10.xy;
        u_xlat16_10.xy = u_xlat16_10.xy * vs_COLOR0.xx;
        u_xlat10_0 = texture(_Diffuse1, vs_TEXCOORD0.zw, -1.0);
        u_xlat16_43 = u_xlat10_0.w * _UseDiffuseOneHeight;
        u_xlat16_10.z = -1.0;
        u_xlat16_9.xyz = u_xlat16_9.xyz + u_xlat16_10.xyz;
        u_xlat16_10.xyz = u_xlat10_0.xyz;
    } else {
        u_xlat16_10.x = float(0.0);
        u_xlat16_10.y = float(0.0);
        u_xlat16_10.z = float(0.0);
        u_xlat16_9.x = float(0.0);
        u_xlat16_9.y = float(0.0);
        u_xlat16_9.z = float(1.0);
        u_xlat16_43 = 1.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor);
#endif
    u_xlat16_11.xyz = u_xlat16_10.xyz * _TintColor.xyz;
    u_xlat16_10.xyz = (bool(u_xlatb0)) ? u_xlat16_11.xyz : u_xlat16_10.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseGrassHeightBlend);
#endif
    u_xlat16_12 = u_xlat16_43;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12 = min(max(u_xlat16_12, 0.0), 1.0);
#else
    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
#endif
    u_xlat16_24 = vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_43 = _HeightContrast * 10.0;
    u_xlat16_12 = u_xlat16_12 + -1.0;
    u_xlat16_44 = _HeightSpread + 0.100000001;
    u_xlat16_24 = log2(u_xlat16_24);
    u_xlat16_24 = u_xlat16_24 * u_xlat16_44;
    u_xlat16_24 = exp2(u_xlat16_24);
    u_xlat16_12 = u_xlat16_24 * 2.0 + u_xlat16_12;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12 = min(max(u_xlat16_12, 0.0), 1.0);
#else
    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
#endif
    u_xlat16_24 = _HeightContrast * 10.0 + 1.0;
    u_xlat16_24 = _HeightContrast * 10.0 + u_xlat16_24;
    u_xlat12.x = u_xlat16_12 * u_xlat16_24 + (-u_xlat16_43);
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat16_43 = (u_xlatb0) ? u_xlat12.x : vs_COLOR0.w;
    u_xlat16_9.xyz = (-u_xlat16_7.xyz) + u_xlat16_9.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_43) * u_xlat16_9.xyz + u_xlat16_7.xyz;
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + u_xlat16_10.xyz;
    u_xlat16_8.xyz = vec3(u_xlat16_43) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, u_xlat16_7.xyz);
    u_xlat0.y = dot(vs_TEXCOORD4.xyz, u_xlat16_7.xyz);
    u_xlat0.z = dot(vs_TEXCOORD5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = _Terrain_Smoothness * _Shininess;
    u_xlat16_7.x = max(u_xlat16_7.x, 0.0);
    SV_Target2.w = min(u_xlat16_7.x, 0.5);
    u_xlat16_7.xyz = u_xlat16_8.xyz * vec3(vec3(_Terrain_Specular, _Terrain_Specular, _Terrain_Specular));
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz;
    u_xlat16_43 = max(u_xlat16_7.z, u_xlat16_7.y);
    u_xlat16_43 = max(u_xlat16_43, u_xlat16_7.x);
    u_xlat16_43 = (-u_xlat16_43) + 1.0;
    SV_Target1.xyz = vec3(u_xlat16_43) * u_xlat16_8.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_43 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_43 : u_xlat16_7.z;
    SV_Target0.w = 0.0;
    SV_Target1.w = _SSAO_Intensity;
    SV_Target2.xy = u_xlat16_7.xy;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _Diffuse1_ST;
uniform 	float _UVDiffuse2;
uniform 	vec4 _Diffuse2_ST;
uniform 	float _UVDetail;
uniform 	vec4 _DetailDiffuse_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec2 u_xlat12;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat15 = u_xlat15 + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat15 = u_xlat15 + u_xlat2.x;
    u_xlat15 = u_xlat15 * 0.330000013;
    u_xlat2.xy = vec2(u_xlat15) * in_TEXCOORD0.xy;
    u_xlat12.xy = vec2(u_xlat15) * in_TEXCOORD1.xy;
    vs_TEXCOORD0.xy = u_xlat2.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Diffuse1_ST.xy + _Diffuse1_ST.zw;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat15 * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UVDiffuse2==0.0);
#else
    u_xlatb15 = _UVDiffuse2==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat2.xy : u_xlat12.xy;
    vs_TEXCOORD2.xy = u_xlat1.xy * _Diffuse2_ST.xy + _Diffuse2_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UVDetail==0.0);
#else
    u_xlatb15 = _UVDetail==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat2.xy : u_xlat12.xy;
    vs_TEXCOORD2.zw = u_xlat1.xy * _DetailDiffuse_ST.xy + _DetailDiffuse_ST.zw;
    vs_TEXCOORD3.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz;
    vs_TEXCOORD3.y = u_xlat16_4.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat0.y;
    vs_TEXCOORD5.w = u_xlat0.z;
    vs_TEXCOORD4.y = u_xlat16_4.y;
    vs_TEXCOORD5.y = u_xlat16_4.z;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _Diffuse1_ST;
uniform 	float _UVDiffuse2;
uniform 	vec4 _Diffuse2_ST;
uniform 	float _UVDetail;
uniform 	vec4 _DetailDiffuse_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat7;
float u_xlat16;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x;
    u_xlat2.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].x;
    u_xlat2.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].x;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].y;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].y;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].y;
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.xy = sqrt(u_xlat2.xy);
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].z;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].z;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].z;
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat2.x = u_xlat7.x + u_xlat2.x;
    u_xlat2.x = u_xlat2.x * 0.330000013;
    u_xlat7.xy = u_xlat2.xx * in_TEXCOORD0.xy;
    u_xlat2.xw = u_xlat2.xx * in_TEXCOORD1.xy;
    vs_TEXCOORD0.xy = u_xlat7.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Diffuse1_ST.xy + _Diffuse1_ST.zw;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UVDiffuse2==0.0);
#else
    u_xlatb1 = _UVDiffuse2==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb1)) ? u_xlat7.xy : u_xlat2.xw;
    vs_TEXCOORD2.xy = u_xlat1.xy * _Diffuse2_ST.xy + _Diffuse2_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UVDetail==0.0);
#else
    u_xlatb1 = _UVDetail==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb1)) ? u_xlat7.xy : u_xlat2.xw;
    vs_TEXCOORD2.zw = u_xlat1.xy * _DetailDiffuse_ST.xy + _DetailDiffuse_ST.zw;
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat2.xyz = vec3(u_xlat0) * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_4.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = vec3(u_xlat0) * u_xlat16_4.xyz;
    vs_TEXCOORD3.y = u_xlat16_4.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD3.w = u_xlat5.x;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat5.y;
    vs_TEXCOORD5.w = u_xlat5.z;
    vs_TEXCOORD4.y = u_xlat16_4.y;
    vs_TEXCOORD5.y = u_xlat16_4.z;
    vs_COLOR0 = in_COLOR0;
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
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "LINE_INTERPOLATION" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _Diffuse1_ST;
uniform 	float _UVDiffuse2;
uniform 	vec4 _Diffuse2_ST;
uniform 	float _UVDetail;
uniform 	vec4 _DetailDiffuse_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec2 u_xlat12;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat15 = u_xlat15 + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat15 = u_xlat15 + u_xlat2.x;
    u_xlat15 = u_xlat15 * 0.330000013;
    u_xlat2.xy = vec2(u_xlat15) * in_TEXCOORD0.xy;
    u_xlat12.xy = vec2(u_xlat15) * in_TEXCOORD1.xy;
    vs_TEXCOORD0.xy = u_xlat2.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Diffuse1_ST.xy + _Diffuse1_ST.zw;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat15 * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UVDiffuse2==0.0);
#else
    u_xlatb15 = _UVDiffuse2==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat2.xy : u_xlat12.xy;
    vs_TEXCOORD2.xy = u_xlat1.xy * _Diffuse2_ST.xy + _Diffuse2_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UVDetail==0.0);
#else
    u_xlatb15 = _UVDetail==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat2.xy : u_xlat12.xy;
    vs_TEXCOORD2.zw = u_xlat1.xy * _DetailDiffuse_ST.xy + _DetailDiffuse_ST.zw;
    vs_TEXCOORD3.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz;
    vs_TEXCOORD3.y = u_xlat16_4.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat0.y;
    vs_TEXCOORD5.w = u_xlat0.z;
    vs_TEXCOORD4.y = u_xlat16_4.y;
    vs_TEXCOORD5.y = u_xlat16_4.z;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "LINE_INTERPOLATION" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _Diffuse1_ST;
uniform 	float _UVDiffuse2;
uniform 	vec4 _Diffuse2_ST;
uniform 	float _UVDetail;
uniform 	vec4 _DetailDiffuse_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat7;
float u_xlat16;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x;
    u_xlat2.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].x;
    u_xlat2.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].x;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].y;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].y;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].y;
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.xy = sqrt(u_xlat2.xy);
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].z;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].z;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].z;
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat2.x = u_xlat7.x + u_xlat2.x;
    u_xlat2.x = u_xlat2.x * 0.330000013;
    u_xlat7.xy = u_xlat2.xx * in_TEXCOORD0.xy;
    u_xlat2.xw = u_xlat2.xx * in_TEXCOORD1.xy;
    vs_TEXCOORD0.xy = u_xlat7.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Diffuse1_ST.xy + _Diffuse1_ST.zw;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UVDiffuse2==0.0);
#else
    u_xlatb1 = _UVDiffuse2==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb1)) ? u_xlat7.xy : u_xlat2.xw;
    vs_TEXCOORD2.xy = u_xlat1.xy * _Diffuse2_ST.xy + _Diffuse2_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_UVDetail==0.0);
#else
    u_xlatb1 = _UVDetail==0.0;
#endif
    u_xlat1.xy = (bool(u_xlatb1)) ? u_xlat7.xy : u_xlat2.xw;
    vs_TEXCOORD2.zw = u_xlat1.xy * _DetailDiffuse_ST.xy + _DetailDiffuse_ST.zw;
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat2.xyz = vec3(u_xlat0) * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_4.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = vec3(u_xlat0) * u_xlat16_4.xyz;
    vs_TEXCOORD3.y = u_xlat16_4.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD3.w = u_xlat5.x;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat5.y;
    vs_TEXCOORD5.w = u_xlat5.z;
    vs_TEXCOORD4.y = u_xlat16_4.y;
    vs_TEXCOORD5.y = u_xlat16_4.z;
    vs_COLOR0 = in_COLOR0;
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
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
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
Keywords { "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "LINE_INTERPOLATION" }
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
Keywords { "LINE_INTERPOLATION" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "LINE_INTERPOLATION" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
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
Keywords { "UNITY_DEBUG_VIEW_ON" "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "LINE_INTERPOLATION" }
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
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "LINE_INTERPOLATION" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "LINE_INTERPOLATION" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
}
}
 UsePass "miHoYo/Shadow/ShadowMapPass/LSPSMCULLNONE"
}
Fallback "Nature/Terrain/Diffuse"
}