Shader "beffio/Medieval_Kingdom/Water"
{
	Properties
	{
		_Depth_Top_Color("Depth_Top_Color", Color) = (0.5019608,0.7215686,0.7019608,0)
		_Shorecolor("Shore color", Color) = (0.5019608,0.7215686,0.7019608,0)
		_Depth_bottom_color("Depth_bottom_color", Color) = (0.1394896,0.2357535,0.3161765,0)
		_Depth_multiply("Depth_multiply", Range( 0 , 1)) = 0.1
		_Top_mask_color_shift("Top_mask_color_shift", Color) = (1,1,1,0)
		_Watertopmasklevel("Water top mask level", Range( 0 , 1)) = 1
		_Smoothness_level("Smoothness_level", Range( 0 , 1)) = 0.92
		_Vertexdicplacementlevel("Vertex dicplacement level", Range( 0.001 , 2)) = 0.15
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
		[HideInInspector]_water_caustic("water_caustic", 2D) = "white" {}
		_Caustic_intensity("Caustic_intensity", Range( 0 , 2)) = 1
		_Caustic_speed("Caustic_speed", Vector) = (-0.5,-0.15,0,0)
		_Caustic_parallax("Caustic_parallax", Range( 0 , 1)) = 1
		_caustic_tilling("caustic_tilling", Range( 1 , 50)) = 1
		[HideInInspector]_a710fa1f1165b699bccefec099930acf("a710fa1f1165b699bccefec099930acf", 2D) = "white" {}
		_Edge_Foam_Tiling("Edge_Foam_Tiling", Range( 0 , 50)) = 10
		_Foam_Amount("Foam_Amount", Range( 0 , 2)) = 0
		_Foam_contrast("Foam_contrast", Range( 0 , 1.4)) = 0
		_Foamcolor("Foam color", Color) = (0,0,0,0)
		_Depth_Intensity("Depth_Intensity", Range( 0 , 1)) = 0
		_Reflection_power("Reflection_power", Range( 0 , 1)) = 0.5
		[HideInInspector]_PerlinNoise6("PerlinNoise6", 2D) = "white" {}
		_Wavescolor("Waves color", Color) = (0,0,0,0)
		_Wavesintensity("Waves intensity", Range( 0 , 1)) = 0
		_Fakereflectionscolor("Fake reflections color", Color) = (0,0,0,0)
		_Wavesnoisecutout("Waves noise cutout", Range( 0 , 1)) = 0
		_Waveswidth("Waves width", Range( 0.001 , 0.1)) = 0.2
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		GrabPass{ }
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#pragma target 4.6
		#pragma surface surf Standard alpha:fade keepalpha noshadow exclude_path:deferred vertex:vertexDataFunc 
		struct Input
		{
			float3 worldPos;
			float4 screenPos;
			float eyeDepth;
			float2 uv_texcoord;
			float3 viewDir;
			INTERNAL_DATA
		};

		uniform sampler2D _Normalmapinput;
		uniform float _Normal1_intensity;
		uniform float2 _UV1_speed;
		uniform float _UV1_tiling;
		uniform float _Normal2_intensity;
		uniform float2 _UV2_speed;
		uniform float _UV2_tiling;
		uniform float _Normal_blend;
		uniform float4 _Shorecolor;
		uniform float4 _Depth_Top_Color;
		uniform float4 _Depth_bottom_color;
		uniform sampler2D _CameraDepthTexture;
		uniform float _Depth_multiply;
		uniform sampler2D _TextureSnap;
		uniform float _Underwater_Distortion;
		uniform float _Activated;
		uniform sampler2D _GrabTexture;
		uniform float _Reflection_power;
		uniform float _Depth_Intensity;
		uniform float4 _Top_mask_color_shift;
		uniform float _Watertopmasklevel;
		uniform sampler2D _water_caustic;
		uniform sampler2D _PerlinNoise6;
		uniform float _caustic_tilling;
		uniform float2 _Caustic_speed;
		uniform float _Caustic_parallax;
		uniform float _Caustic_intensity;
		uniform float4 _Foamcolor;
		uniform float _Foam_contrast;
		uniform sampler2D _a710fa1f1165b699bccefec099930acf;
		uniform float _Edge_Foam_Tiling;
		uniform float _Foam_Amount;
		uniform float4 _Wavescolor;
		uniform float _Waveswidth;
		uniform float _Wavesnoisecutout;
		uniform float _Wavesintensity;
		uniform float4 _Fakereflectionscolor;
		uniform float _Smoothness_level;
		uniform float _Edge_fade;
		uniform float _Vertexdicplacementlevel;


		float3 HSVToRGB( float3 c )
		{
			float4 K = float4( 1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0 );
			float3 p = abs( frac( c.xxx + K.xyz ) * 6.0 - K.www );
			return c.z * lerp( K.xxx, clamp( p - K.xxx, 0.0, 1.0 ), c.y );
		}


		float4 CalculateContrast( float contrastValue, float4 colorTarget )
		{
			float t = 0.5 * ( 1.0 - contrastValue );
			return mul( float4x4( contrastValue,0,0,t, 0,contrastValue,0,t, 0,0,contrastValue,t, 0,0,0,1 ), colorTarget );
		}

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			o.eyeDepth = -UnityObjectToViewPos( v.vertex.xyz ).z;
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float2 appendResult579 = (float2(ase_worldPos.x , ase_worldPos.z));
			float2 _world_UV582 = ( appendResult579 / 1.0 );
			float2 panner565 = ( ( _world_UV582 * _UV1_tiling ) + _Time.x * _UV1_speed);
			float2 UV1566 = panner565;
			float2 panner564 = ( ( _world_UV582 * _UV2_tiling ) + _Time.y * _UV2_speed);
			float2 UV2567 = panner564;
			float3 lerpResult576 = lerp( UnpackScaleNormal( tex2Dlod( _Normalmapinput, float4( UV1566, 0, 0.0) ) ,_Normal1_intensity ) , UnpackScaleNormal( tex2Dlod( _Normalmapinput, float4( UV2567, 0, 0.0) ) ,_Normal2_intensity ) , _Normal_blend);
			float3 _Normal577 = lerpResult576;
			float4 transform514 = mul(unity_ObjectToWorld,float4( _Normal577 , 0.0 ));
			float _vector_displacement544 = ( transform514.y * _Vertexdicplacementlevel );
			float3 temp_cast_1 = (_vector_displacement544).xxx;
			v.vertex.xyz += temp_cast_1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 ase_worldPos = i.worldPos;
			float2 appendResult579 = (float2(ase_worldPos.x , ase_worldPos.z));
			float2 _world_UV582 = ( appendResult579 / 1.0 );
			float2 panner565 = ( ( _world_UV582 * _UV1_tiling ) + _Time.x * _UV1_speed);
			float2 UV1566 = panner565;
			float2 panner564 = ( ( _world_UV582 * _UV2_tiling ) + _Time.y * _UV2_speed);
			float2 UV2567 = panner564;
			float3 lerpResult576 = lerp( UnpackScaleNormal( tex2D( _Normalmapinput, UV1566 ) ,_Normal1_intensity ) , UnpackScaleNormal( tex2D( _Normalmapinput, UV2567 ) ,_Normal2_intensity ) , _Normal_blend);
			float3 _Normal577 = lerpResult576;
			o.Normal = _Normal577;
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float eyeDepth496 = LinearEyeDepth(UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture,UNITY_PROJ_COORD(ase_screenPos))));
			float4 temp_cast_0 = (abs( ( eyeDepth496 - ( ase_screenPos.w * 1.0 ) ) )).xxxx;
			float4 blendOpSrc648 = float4(0.08235294,0.1647059,0.2117647,0);
			float4 blendOpDest648 = temp_cast_0;
			float4 lerpResult503 = lerp( _Depth_Top_Color , _Depth_bottom_color , ( ( saturate( 2.0f*blendOpDest648*blendOpSrc648 + blendOpDest648*blendOpDest648*(1.0f - 2.0f*blendOpSrc648) )) * _Depth_multiply ).r);
			float cameraDepthFade978 = (( i.eyeDepth -_ProjectionParams.y - 3.0 ) / 10.0);
			float clampResult981 = clamp( cameraDepthFade978 , 0.0 , 1.0 );
			float4 lerpResult979 = lerp( _Shorecolor , lerpResult503 , clampResult981);
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float screenDepth983 = LinearEyeDepth(UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture,UNITY_PROJ_COORD(ase_screenPos))));
			float distanceDepth983 = abs( ( screenDepth983 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( 1.0 ) );
			float clampResult984 = clamp( distanceDepth983 , 0.9 , 1.0 );
			float4 lerpResult982 = lerp( _Shorecolor , lerpResult979 , clampResult984);
			float4 _depth635 = lerpResult982;
			float2 appendResult660 = (float2(ase_screenPosNorm.x , ase_screenPosNorm.y));
			float3 temp_output_667_0 = ( float3( ( appendResult660 / ase_screenPosNorm.w ) ,  0.0 ) + ( _Normal577 * _Underwater_Distortion ) );
			float4 lerpResult1048 = lerp( float4( 0.0,0,0,0 ) , tex2D( _TextureSnap, temp_output_667_0.xy ) , _Activated);
			float4 screenColor670 = tex2D( _GrabTexture, temp_output_667_0.xy );
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float4 lerpResult901 = lerp( lerpResult1048 , screenColor670 , ase_worldViewDir.y);
			float4 lerpResult895 = lerp( lerpResult901 , lerpResult1048 , _Reflection_power);
			float screenDepth890 = LinearEyeDepth(UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture,UNITY_PROJ_COORD(ase_screenPos))));
			float distanceDepth890 = abs( ( screenDepth890 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( 7.0 ) );
			float4 lerpResult889 = lerp( lerpResult895 , float4( 0.1218642,0.139788,0.1691176,0 ) , distanceDepth890);
			float4 lerpResult891 = lerp( lerpResult895 , lerpResult889 , _Depth_Intensity);
			float3 ase_worldlightDir = normalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			float3 normalizeResult669 = normalize( ( ase_worldlightDir + ase_worldViewDir ) );
			float4 lerpResult677 = lerp( lerpResult891 , float4( normalizeResult669 , 0.0 ) , 0);
			float4 _Underwater_distortion675 = ( lerpResult677 * _LightColor0 );
			float4 blendOpSrc507 = _depth635;
			float4 blendOpDest507 = _Underwater_distortion675;
			float4 lerpResult517 = lerp( ( saturate( 2.0f*blendOpDest507*blendOpSrc507 + blendOpDest507*blendOpDest507*(1.0f - 2.0f*blendOpSrc507) )) , 0 , 0.0);
			float4 transform514 = mul(unity_ObjectToWorld,float4( _Normal577 , 0.0 ));
			float4 temp_cast_8 = (transform514.y).xxxx;
			float4 blendOpSrc598 = _Top_mask_color_shift;
			float4 blendOpDest598 = temp_cast_8;
			float4 temp_cast_9 = (transform514.y).xxxx;
			float4 blendOpSrc593 = temp_cast_9;
			float4 blendOpDest593 = float4(1,1,1,0);
			float4 blendOpSrc606 = ( saturate( 2.0f*blendOpDest598*blendOpSrc598 + blendOpDest598*blendOpDest598*(1.0f - 2.0f*blendOpSrc598) ));
			float4 blendOpDest606 = ( saturate( 2.0f*blendOpDest593*blendOpSrc593 + blendOpDest593*blendOpDest593*(1.0f - 2.0f*blendOpSrc593) ));
			float4 blendOpSrc607 = ( ( saturate( ( blendOpSrc606 + blendOpDest606 - 1.0 ) )) * _Watertopmasklevel );
			float4 blendOpDest607 = float4( 0,0,0,0 );
			float4 Water_top_mask621 = ( saturate( ( 1.0 - ( 1.0 - blendOpSrc607 ) * ( 1.0 - blendOpDest607 ) ) ));
			float4 blendOpSrc623 = lerpResult517;
			float4 blendOpDest623 = Water_top_mask621;
			float4 _Water_color_blend639 = ( saturate( ( blendOpSrc623 + blendOpDest623 ) ));
			float2 temp_cast_10 = (_caustic_tilling).xx;
			float2 uv_TexCoord1015 = i.uv_texcoord * temp_cast_10 + float2( 0,0 );
			float2 panner1016 = ( uv_TexCoord1015 + 1.0 * _Time.y * float2( 0.1,0 ));
			float2 temp_cast_11 = (_caustic_tilling).xx;
			float2 uv_TexCoord733 = i.uv_texcoord * temp_cast_11 + float2( 0,0 );
			float2 panner746 = ( uv_TexCoord733 + _Time.x * _Caustic_speed);
			float screenDepth784 = LinearEyeDepth(UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture,UNITY_PROJ_COORD(ase_screenPos))));
			float distanceDepth784 = abs( ( screenDepth784 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( 2.0 ) );
			float4 lerpResult797 = lerp( float4(1,1,1,0) , float4( 0,0,0,0 ) , distanceDepth784);
			float3 hsvTorgb787 = HSVToRGB( float3(0.0,0.0,lerpResult797.r) );
			float2 Offset725 = ( ( hsvTorgb787.x - 1 ) * i.viewDir.xy * _Caustic_parallax ) + panner746;
			float clampResult790 = clamp( pow( distanceDepth784 , 10.0 ) , 100.0 , 0.5 );
			float4 _caustic729 = ( ( Luminance(tex2D( _water_caustic, ( UnpackScaleNormal( tex2D( _PerlinNoise6, panner1016 ) ,0.05 ) + float3( Offset725 ,  0.0 ) ).xy ).rgb) * lerpResult982 ) * clampResult790 );
			float4 blendOpSrc730 = _Water_color_blend639;
			float4 blendOpDest730 = ( _caustic729 * _Caustic_intensity );
			float2 temp_cast_16 = (_Edge_Foam_Tiling).xx;
			float2 uv_TexCoord877 = i.uv_texcoord * temp_cast_16 + float2( 0,0 );
			float screenDepth807 = LinearEyeDepth(UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture,UNITY_PROJ_COORD(ase_screenPos))));
			float distanceDepth807 = abs( ( screenDepth807 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _Foam_Amount ) );
			float4 temp_cast_17 = (distanceDepth807).xxxx;
			float4 lerpResult853 = lerp( CalculateContrast(_Foam_contrast,tex2D( _a710fa1f1165b699bccefec099930acf, uv_TexCoord877 )) , float4( 0,0,0,0 ) , CalculateContrast(( _Foam_contrast * 2.0 ),temp_cast_17).r);
			float4 Waves866 = lerpResult853;
			float4 clampResult884 = clamp( Waves866 , float4( 0,0,0,0 ) , float4( 1,0,0,0 ) );
			float4 lerpResult883 = lerp( ( saturate( 	max( blendOpSrc730, blendOpDest730 ) )) , _Foamcolor , clampResult884.r);
			float temp_output_1064_0 = ( ( 1.1 - _Waveswidth ) * 5.0 );
			float screenDepth902 = LinearEyeDepth(UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture,UNITY_PROJ_COORD(ase_screenPos))));
			float distanceDepth902 = abs( ( screenDepth902 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( fmod( ( 0.0 - ( _Time.y / 3.0 ) ) , temp_output_1064_0 ) ) );
			float temp_output_1053_0 = ( 0.1 + _Waveswidth );
			float temp_output_1056_0 = ( temp_output_1053_0 + _Waveswidth );
			float temp_output_1057_0 = ( temp_output_1056_0 + _Waveswidth );
			float temp_output_1058_0 = ( temp_output_1057_0 + _Waveswidth );
			float temp_output_1059_0 = ( temp_output_1058_0 + _Waveswidth );
			float screenDepth933 = LinearEyeDepth(UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture,UNITY_PROJ_COORD(ase_screenPos))));
			float distanceDepth933 = abs( ( screenDepth933 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( fmod( ( 0.0 - ( ( _Time.y + temp_output_1064_0 ) / 3.0 ) ) , temp_output_1064_0 ) ) );
			float screenDepth910 = LinearEyeDepth(UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture,UNITY_PROJ_COORD(ase_screenPos))));
			float distanceDepth910 = abs( ( screenDepth910 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( 0.6 ) );
			float screenDepth966 = LinearEyeDepth(UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture,UNITY_PROJ_COORD(ase_screenPos))));
			float distanceDepth966 = abs( ( screenDepth966 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( 0.4 ) );
			float smoothstepResult970 = smoothstep( 0.3 , 0.3 , distanceDepth966);
			float lerpResult967 = lerp( 0.0 , distanceDepth910 , smoothstepResult970);
			float lerpResult912 = lerp( ( ( ( step( distanceDepth902 , temp_output_1058_0 ) - step( distanceDepth902 , temp_output_1057_0 ) ) + ( step( distanceDepth902 , temp_output_1056_0 ) - step( distanceDepth902 , temp_output_1053_0 ) ) + ( step( distanceDepth902 , temp_output_1059_0 ) - step( distanceDepth902 , temp_output_1058_0 ) ) ) + ( ( step( distanceDepth933 , temp_output_1059_0 ) - step( distanceDepth933 , temp_output_1058_0 ) ) + ( step( distanceDepth933 , temp_output_1058_0 ) - step( distanceDepth933 , temp_output_1057_0 ) ) + ( step( distanceDepth933 , temp_output_1056_0 ) - step( distanceDepth933 , temp_output_1053_0 ) ) ) ) , 0.0 , lerpResult967);
			float2 uv_TexCoord953 = i.uv_texcoord * float2( 5,5 ) + float2( 0,0 );
			float4 lerpResult1051 = lerp( step( tex2D( _PerlinNoise6, uv_TexCoord953 ) , float4( 0.191,0.191,0.191,0 ) ) , float4( 0.0,0,0,0 ) , _Wavesnoisecutout);
			float lerpResult956 = lerp( lerpResult912 , 0.0 , lerpResult1051.r);
			float clampResult963 = clamp( lerpResult956 , 0.0 , 1.0 );
			float Waves_pattern957 = clampResult963;
			float4 lerpResult960 = lerp( lerpResult883 , _Wavescolor , ( Waves_pattern957 * _Wavesintensity ));
			float2 uv_TexCoord1023 = i.uv_texcoord * float2( 110,110 ) + float2( 0,0 );
			float4 tex2DNode1020 = tex2D( _PerlinNoise6, uv_TexCoord1023 );
			float dotResult1022 = dot( tex2DNode1020 , tex2DNode1020 );
			float dotResult1024 = dot( dotResult1022 , dotResult1022 );
			float dotResult1025 = dot( dotResult1024 , dotResult1024 );
			float dotResult1029 = dot( dotResult1025 , dotResult1025 );
			float dotResult1026 = dot( dotResult1029 , 0.01 );
			float2 uv_TexCoord1033 = i.uv_texcoord * float2( 10,10 ) + float2( 0,0 );
			float4 clampResult1035 = clamp( tex2D( _PerlinNoise6, uv_TexCoord1033 ) , float4( 0,0,0,0 ) , float4( 1,1,1,0 ) );
			float dotResult1034 = dot( clampResult1035 , clampResult1035 );
			float dotResult1036 = dot( dotResult1034 , dotResult1034 );
			float lerpResult1032 = lerp( 0.0 , pow( dotResult1026 , 3.0 ) , pow( dotResult1036 , 3.0 ));
			float clampResult1028 = clamp( lerpResult1032 , 0.0 , 1.0 );
			float smoothstepResult1046 = smoothstep( 0.3 , 0.4 , ase_worldViewDir.y);
			float lerpResult1039 = lerp( clampResult1028 , 0.0 , pow( smoothstepResult1046 , 1.0 ));
			float Fake_reflections1040 = lerpResult1039;
			float4 lerpResult1027 = lerp( lerpResult960 , _Fakereflectionscolor , Fake_reflections1040);
			o.Albedo = lerpResult1027.rgb;
			float lerpResult1043 = lerp( 0.0 , 1.0 , Fake_reflections1040);
			float3 temp_cast_22 = (lerpResult1043).xxx;
			o.Emission = temp_cast_22;
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

//CHKSM=D681EF3F074E9C2BAD8B02B0809917906C9E0C03