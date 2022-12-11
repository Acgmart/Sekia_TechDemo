Shader "beffio/Medieval_Kingdom/Water_Mobile"
{
	Properties
	{
		_Depth_Top_Color("Depth_Top_Color", Color) = (0.5019608,0.7215686,0.7019608,0)
		_Depth_bottom_color("Depth_bottom_color", Color) = (0.1394896,0.2357535,0.3161765,0)
		_Depth_multiply("Depth_multiply", Range( 0 , 1)) = 0.1
		_Smoothness_level("Smoothness_level", Range( 0 , 1)) = 0.92
		_Underwater_Distortion("Underwater_Distortion", Range( 0 , 1)) = 0.2
		_Normal2_intensity("Normal2_intensity", Range( 0 , 2)) = 1
		_Normal_blend("Normal_blend", Range( 0 , 1)) = 0.5
		_Normal1_intensity("Normal1_intensity", Range( 0 , 2)) = 1
		[HideInInspector]_Normalmapinput("Normal map input", 2D) = "bump" {}
		_UV1_speed("UV1_speed", Vector) = (0.03,0,0,0)
		_UV2_speed("UV2_speed", Vector) = (0.015,0,0,0)
		_UV1_tiling("UV1_tiling", Range( 0.01 , 2)) = 1
		_UV2_tiling("UV2_tiling", Range( 0.01 , 2)) = 1
		_Edge_fade("Edge_fade", Range( 0 , 3)) = 1
		[HideInInspector]_a710fa1f1165b699bccefec099930acf("a710fa1f1165b699bccefec099930acf", 2D) = "white" {}
		_Foam_Amount("Foam_Amount", Range( 0 , 2)) = 0
		_Foamcolor("Foam color", Color) = (0,0,0,0)
		_Depth_Intensity("Depth_Intensity", Range( 0 , 1)) = 0
		[HideInInspector]_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_Waves_Color("Waves_Color", Color) = (1,1,1,0)
		_Waves_Intensity("Waves_Intensity", Range( 0 , 1)) = 0.54
		_Waves_Width("Waves_Width", Range( 0.001 , 0.1)) = 0.1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" }
		Cull Off
		GrabPass{ }
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#pragma target 3.5
		#pragma surface surf Standard alpha:fade keepalpha noshadow exclude_path:deferred 
		struct Input
		{
			float3 worldPos;
			float4 screenPos;
			fixed2 uv_texcoord;
		};

		uniform sampler2D _Normalmapinput;
		uniform fixed _Normal1_intensity;
		uniform fixed2 _UV1_speed;
		uniform fixed _UV1_tiling;
		uniform fixed _Normal2_intensity;
		uniform fixed2 _UV2_speed;
		uniform fixed _UV2_tiling;
		uniform fixed _Normal_blend;
		uniform fixed4 _Depth_Top_Color;
		uniform fixed4 _Depth_bottom_color;
		uniform sampler2D _CameraDepthTexture;
		uniform fixed _Depth_multiply;
		uniform sampler2D _GrabTexture;
		uniform fixed _Underwater_Distortion;
		uniform fixed _Depth_Intensity;
		uniform fixed4 _Foamcolor;
		uniform sampler2D _a710fa1f1165b699bccefec099930acf;
		uniform float4 _a710fa1f1165b699bccefec099930acf_ST;
		uniform fixed _Foam_Amount;
		uniform fixed4 _Waves_Color;
		uniform fixed _Waves_Width;
		uniform sampler2D _TextureSample0;
		uniform fixed _Waves_Intensity;
		uniform fixed _Smoothness_level;
		uniform fixed _Edge_fade;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 ase_worldPos = i.worldPos;
			float2 appendResult579 = (fixed2(ase_worldPos.x , ase_worldPos.z));
			float2 _world_UV582 = ( appendResult579 / 1.0 );
			float2 panner565 = ( _Time.x * _UV1_speed + ( _world_UV582 * _UV1_tiling ));
			float2 UV1566 = panner565;
			float2 panner564 = ( _Time.y * _UV2_speed + ( _world_UV582 * _UV2_tiling ));
			float2 UV2567 = panner564;
			float3 lerpResult576 = lerp( UnpackScaleNormal( tex2D( _Normalmapinput, UV1566 ) ,_Normal1_intensity ) , UnpackScaleNormal( tex2D( _Normalmapinput, UV2567 ) ,_Normal2_intensity ) , _Normal_blend);
			float3 _Normal577 = lerpResult576;
			o.Normal = _Normal577;
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float eyeDepth496 = LinearEyeDepth(UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture,UNITY_PROJ_COORD(ase_screenPos))));
			float4 lerpResult503 = lerp( _Depth_Top_Color , _Depth_bottom_color , ( saturate( ( eyeDepth496 - ase_screenPos.w ) ) * _Depth_multiply ));
			float4 _depth635 = lerpResult503;
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float2 appendResult660 = (fixed2(ase_screenPosNorm.x , ase_screenPosNorm.y));
			float4 screenColor670 = tex2D( _GrabTexture, ( fixed3( ( appendResult660 / ase_screenPosNorm.w ) ,  0.0 ) + ( _Normal577 * _Underwater_Distortion ) ).xy );
			fixed3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float4 lerpResult901 = lerp( float4( 0,0,0,0 ) , screenColor670 , ase_worldViewDir.y);
			float screenDepth890 = LinearEyeDepth(UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture,UNITY_PROJ_COORD(ase_screenPos))));
			float distanceDepth890 = abs( ( screenDepth890 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( 7.0 ) );
			float4 lerpResult889 = lerp( lerpResult901 , float4( 0.1218642,0.139788,0.1691176,0 ) , distanceDepth890);
			float4 lerpResult891 = lerp( lerpResult901 , lerpResult889 , _Depth_Intensity);
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = normalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float3 normalizeResult669 = normalize( ( ase_worldlightDir + ase_worldViewDir ) );
			float4 lerpResult677 = lerp( lerpResult891 , fixed4( normalizeResult669 , 0.0 ) , 0.0);
			float4 _Underwater_distortion675 = lerpResult677;
			fixed4 blendOpSrc507 = _depth635;
			fixed4 blendOpDest507 = _Underwater_distortion675;
			float4 transform514 = mul(unity_ObjectToWorld,fixed4( _Normal577 , 0.0 ));
			float4 lerpResult1074 = lerp( float4( 0,0,0,0 ) , fixed4(0.7720588,0.9811359,1,0) , transform514.y);
			float4 Water_top_mask621 = ( lerpResult1074 * float4( 0.1985294,0.2058283,0.2058283,0 ) );
			fixed4 blendOpSrc623 = ( saturate( 2.0f*blendOpDest507*blendOpSrc507 + blendOpDest507*blendOpDest507*(1.0f - 2.0f*blendOpSrc507) ));
			fixed4 blendOpDest623 = Water_top_mask621;
			fixed4 _Water_color_blend639 = ( saturate( ( blendOpSrc623 + blendOpDest623 ) ));
			float2 uv_a710fa1f1165b699bccefec099930acf = i.uv_texcoord * _a710fa1f1165b699bccefec099930acf_ST.xy + _a710fa1f1165b699bccefec099930acf_ST.zw;
			float screenDepth807 = LinearEyeDepth(UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture,UNITY_PROJ_COORD(ase_screenPos))));
			float distanceDepth807 = abs( ( screenDepth807 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _Foam_Amount ) );
			float4 lerpResult853 = lerp( tex2D( _a710fa1f1165b699bccefec099930acf, uv_a710fa1f1165b699bccefec099930acf ) , float4( 0,0,0,0 ) , distanceDepth807);
			float4 Waves866 = lerpResult853;
			float4 clampResult884 = clamp( Waves866 , float4( 0,0,0,0 ) , float4( 1,0,0,0 ) );
			float4 lerpResult883 = lerp( _Water_color_blend639 , _Foamcolor , clampResult884.r);
			float4 Albedo1065 = lerpResult883;
			float temp_output_1080_0 = ( ( 1.1 - _Waves_Width ) * 5.0 );
			float screenDepth1093 = LinearEyeDepth(UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture,UNITY_PROJ_COORD(ase_screenPos))));
			float distanceDepth1093 = abs( ( screenDepth1093 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( fmod( ( 0.0 - ( _Time.y / 3.0 ) ) , temp_output_1080_0 ) ) );
			float temp_output_1082_0 = ( 0.1 + _Waves_Width );
			float temp_output_1083_0 = ( temp_output_1082_0 + _Waves_Width );
			float temp_output_1086_0 = ( temp_output_1083_0 + _Waves_Width );
			float temp_output_1091_0 = ( temp_output_1086_0 + _Waves_Width );
			float temp_output_1092_0 = ( temp_output_1091_0 + _Waves_Width );
			float screenDepth1094 = LinearEyeDepth(UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture,UNITY_PROJ_COORD(ase_screenPos))));
			float distanceDepth1094 = abs( ( screenDepth1094 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( fmod( ( 0.0 - ( ( _Time.y + temp_output_1080_0 ) / 3.0 ) ) , temp_output_1080_0 ) ) );
			float screenDepth1115 = LinearEyeDepth(UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture,UNITY_PROJ_COORD(ase_screenPos))));
			float distanceDepth1115 = abs( ( screenDepth1115 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( 0.6 ) );
			float screenDepth1113 = LinearEyeDepth(UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture,UNITY_PROJ_COORD(ase_screenPos))));
			float distanceDepth1113 = abs( ( screenDepth1113 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( 0.4 ) );
			float smoothstepResult1116 = smoothstep( 0.3 , 0.3 , distanceDepth1113);
			float lerpResult1123 = lerp( 0.0 , distanceDepth1115 , smoothstepResult1116);
			float lerpResult1125 = lerp( ( ( ( step( distanceDepth1093 , temp_output_1091_0 ) - step( distanceDepth1093 , temp_output_1086_0 ) ) + ( step( distanceDepth1093 , temp_output_1083_0 ) - step( distanceDepth1093 , temp_output_1082_0 ) ) + ( step( distanceDepth1093 , temp_output_1092_0 ) - step( distanceDepth1093 , temp_output_1091_0 ) ) ) + ( ( step( distanceDepth1094 , temp_output_1092_0 ) - step( distanceDepth1094 , temp_output_1091_0 ) ) + ( step( distanceDepth1094 , temp_output_1091_0 ) - step( distanceDepth1094 , temp_output_1086_0 ) ) + ( step( distanceDepth1094 , temp_output_1083_0 ) - step( distanceDepth1094 , temp_output_1082_0 ) ) ) ) , 0.0 , lerpResult1123);
			float2 uv_TexCoord1111 = i.uv_texcoord * float2( 5,5 );
			float lerpResult1126 = lerp( lerpResult1125 , 0.0 , step( tex2D( _TextureSample0, uv_TexCoord1111 ) , float4( 0.191,0.191,0.191,0 ) ).r);
			float clampResult1127 = clamp( lerpResult1126 , 0.0 , 1.0 );
			fixed Wave1128 = clampResult1127;
			float4 lerpResult1133 = lerp( Albedo1065 , _Waves_Color , ( Wave1128 * _Waves_Intensity ));
			o.Albedo = lerpResult1133.rgb;
			o.Smoothness = _Smoothness_level;
			float screenDepth690 = LinearEyeDepth(UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture,UNITY_PROJ_COORD(ase_screenPos))));
			float distanceDepth690 = abs( ( screenDepth690 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( 0.5 ) );
			float clampResult691 = clamp( pow( distanceDepth690 , _Edge_fade ) , 0.0 , 1.0 );
			float _edgeFade695 = clampResult691;
			o.Alpha = _edgeFade695;
		}

		ENDCG
	}
}
//CHKSM=5B6C01E945FCC3722A2D203B1EC6F9223FC71E16