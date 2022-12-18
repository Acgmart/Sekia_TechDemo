
Shader "beffio/Medieval_Kingdom/SRP/Lightweight/Water"
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
	}
	SubShader
	{
		Tags { "RenderPipeline"="LightweightPipeline" "RenderType"="Transparent" "Queue"="Transparent" }
		Cull Back
		
		HLSLINCLUDE
		#pragma target 3.0
		ENDHLSL
		
		GrabPass{ }
		Pass
		{
			Tags { "LightMode"="LightweightForward" }
			Name "Base"
			Blend SrcAlpha OneMinusSrcAlpha , Zero Zero
			ZTest LEqual
			ZWrite On
		
		
			HLSLPROGRAM
		    // Required to compile gles 2.0 with standard srp library
		    #pragma prefer_hlslcc gles
			
			// -------------------------------------
			// Lightweight Pipeline keywords
			#pragma multi_compile _ _ADDITIONAL_LIGHTS
			#pragma multi_compile _ _VERTEX_LIGHTS
			#pragma multi_compile _ _MIXED_LIGHTING_SUBTRACTIVE
			#pragma multi_compile _ FOG_LINEAR FOG_EXP2
		
			// -------------------------------------
			// Unity defined keywords
			#pragma multi_compile _ DIRLIGHTMAP_COMBINED
			#pragma multi_compile _ LIGHTMAP_ON
		
			//--------------------------------------
			// GPU Instancing
			#pragma multi_compile_instancing
		
		    #pragma vertex vert
			#pragma fragment frag
		
			#include "LWRP/ShaderLibrary/Core.hlsl"
			#include "LWRP/ShaderLibrary/Lighting.hlsl"
			#include "CoreRP/ShaderLibrary/Color.hlsl"
			#include "CoreRP/ShaderLibrary/UnityInstancing.hlsl"
			#include "ShaderGraphLibrary/Functions.hlsl"
			#define _NORMALMAP 1

			uniform sampler2D _Normalmapinput;
			uniform float _Normal1_intensity;
			uniform float2 _UV1_speed;
			uniform float _UV1_tiling;
			uniform float _Normal2_intensity;
			uniform float2 _UV2_speed;
			uniform float _UV2_tiling;
			uniform float _Normal_blend;
			uniform float _Vertexdicplacementlevel;
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
			uniform sampler2D _PerlinNoise6;
			uniform float _Wavesnoisecutout;
			uniform float _Wavesintensity;
			uniform float4 _Fakereflectionscolor;
			uniform float _Smoothness_level;
			uniform float _Edge_fade;
			float3 HSVToRGB( float3 c )
			{
				float4 K = float4( 1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0 );
				float3 p = abs( frac( c.xxx + K.xyz ) * 6.0 - K.www );
				return c.z * lerp( K.xxx, saturate( p - K.xxx ), c.y );
			}
			
			float4 CalculateContrast( float contrastValue, float4 colorTarget )
			{
				float t = 0.5 * ( 1.0 - contrastValue );
				return mul( float4x4( contrastValue,0,0,t, 0,contrastValue,0,t, 0,0,contrastValue,t, 0,0,0,1 ), colorTarget );
			}
					
			struct GraphVertexInput
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float4 tangent : TANGENT;
				float4 texcoord1 : TEXCOORD1;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				float4 ase_texcoord : TEXCOORD0;
			};

			struct GraphVertexOutput
			{
				float4 clipPos					: SV_POSITION;
				float4 lightmapUVOrVertexSH		: TEXCOORD0;
				half4 fogFactorAndVertexLight	: TEXCOORD1; 
				float4 shadowCoord				: TEXCOORD2;
				float4 tSpace0					: TEXCOORD3;
				float4 tSpace1					: TEXCOORD4;
				float4 tSpace2					: TEXCOORD5;
				float3 WorldSpaceViewDirection	: TEXCOORD6;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				float4 ase_texcoord7 : TEXCOORD7;
				float4 ase_texcoord8 : TEXCOORD8;
			};

			GraphVertexOutput vert (GraphVertexInput v)
			{
		        GraphVertexOutput o = (GraphVertexOutput)0;
		
		        UNITY_SETUP_INSTANCE_ID(v);
		    	UNITY_TRANSFER_INSTANCE_ID(v, o);
		
				float3 lwWNormal = TransformObjectToWorldNormal(v.normal);
				float3 lwWorldPos = TransformObjectToWorld(v.vertex.xyz);
				float3 lwWTangent = mul((float3x3)UNITY_MATRIX_M,v.tangent.xyz);
				float3 lwWBinormal = normalize(cross(lwWNormal, lwWTangent) * v.tangent.w);
				o.tSpace0 = float4(lwWTangent.x, lwWBinormal.x, lwWNormal.x, lwWorldPos.x);
				o.tSpace1 = float4(lwWTangent.y, lwWBinormal.y, lwWNormal.y, lwWorldPos.y);
				o.tSpace2 = float4(lwWTangent.z, lwWBinormal.z, lwWNormal.z, lwWorldPos.z);
				float4 clipPos = TransformWorldToHClip(lwWorldPos);

				float2 appendResult579 = (float2(lwWorldPos.x , lwWorldPos.z));
				float2 _world_UV582 = ( appendResult579 / 1.0 );
				float2 panner565 = ( _Time.x * _UV1_speed + ( _world_UV582 * _UV1_tiling ));
				float2 UV1566 = panner565;
				float2 panner564 = ( _Time.y * _UV2_speed + ( _world_UV582 * _UV2_tiling ));
				float2 UV2567 = panner564;
				float3 lerpResult576 = lerp( UnpackNormalScale( tex2Dlod( _Normalmapinput, float4( UV1566, 0, 0.0) ) ,_Normal1_intensity ) , UnpackNormalScale( tex2Dlod( _Normalmapinput, float4( UV2567, 0, 0.0) ) ,_Normal2_intensity ) , _Normal_blend);
				float3 _Normal577 = lerpResult576;
				float4 transform514 = mul(unity_ObjectToWorld,float4( _Normal577 , 0.0 ));
				float _vector_displacement544 = ( transform514.y * _Vertexdicplacementlevel );
				float3 temp_cast_1 = (_vector_displacement544).xxx;
				
				float4 ase_clipPos = TransformObjectToHClip(v.vertex);
				float4 screenPos = ComputeScreenPos(ase_clipPos);
				o.ase_texcoord7 = screenPos;
				float3 objectToViewPos = TransformWorldToView(TransformObjectToWorld(v.vertex.xyz));
				float eyeDepth = -objectToViewPos.z;
				o.ase_texcoord8.x = eyeDepth;
				
				o.ase_texcoord8.yz = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord8.w = 0;
				v.vertex.xyz += temp_cast_1;
				clipPos = TransformWorldToHClip(TransformObjectToWorld(v.vertex.xyz));
				OUTPUT_LIGHTMAP_UV(v.texcoord1, unity_LightmapST, o.lightmapUVOrVertexSH);
				OUTPUT_SH(lwWNormal, o.lightmapUVOrVertexSH);

				half3 vertexLight = VertexLighting(lwWorldPos, lwWNormal);
				half fogFactor = ComputeFogFactor(clipPos.z);
				o.fogFactorAndVertexLight = half4(fogFactor, vertexLight);
				o.clipPos = clipPos;

				o.shadowCoord = ComputeShadowCoord(o.clipPos);
				return o;
			}
		
			half4 frag (GraphVertexOutput IN ) : SV_Target
		    {
		    	UNITY_SETUP_INSTANCE_ID(IN);
		
				float3 WorldSpaceNormal = normalize(float3(IN.tSpace0.z,IN.tSpace1.z,IN.tSpace2.z));
				float3 WorldSpaceTangent = float3(IN.tSpace0.x,IN.tSpace1.x,IN.tSpace2.x);
				float3 WorldSpaceBiTangent = float3(IN.tSpace0.y,IN.tSpace1.y,IN.tSpace2.y);
				float3 WorldSpacePosition = float3(IN.tSpace0.w,IN.tSpace1.w,IN.tSpace2.w);
				float3 WorldSpaceViewDirection = SafeNormalize( _WorldSpaceCameraPos.xyz  - WorldSpacePosition );

				float4 screenPos = IN.ase_texcoord7;
				float eyeDepth496 = LinearEyeDepth(tex2Dproj(_CameraDepthTexture,screenPos).r,_ZBufferParams);
				float4 temp_cast_0 = (abs( ( eyeDepth496 - ( screenPos.w * 1.0 ) ) )).xxxx;
				float4 blendOpSrc648 = float4(0.08235294,0.1647059,0.2117647,0);
				float4 blendOpDest648 = temp_cast_0;
				float4 lerpResult503 = lerp( _Depth_Top_Color , _Depth_bottom_color , ( ( saturate( 2.0f*blendOpDest648*blendOpSrc648 + blendOpDest648*blendOpDest648*(1.0f - 2.0f*blendOpSrc648) )) * _Depth_multiply ).r);
				float eyeDepth = IN.ase_texcoord8.x;
				float cameraDepthFade978 = (( eyeDepth -_ProjectionParams.y - 3.0 ) / 10.0);
				float clampResult981 = clamp( cameraDepthFade978 , 0.0 , 1.0 );
				float4 lerpResult979 = lerp( _Shorecolor , lerpResult503 , clampResult981);
				float4 ase_screenPosNorm = screenPos / screenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float screenDepth983 = LinearEyeDepth(tex2Dproj( _CameraDepthTexture,screenPos).r,_ZBufferParams);
				float distanceDepth983 = abs( ( screenDepth983 - LinearEyeDepth( ase_screenPosNorm.z,_ZBufferParams ) ) / ( 1.0 ) );
				float clampResult984 = clamp( distanceDepth983 , 0.9 , 1.0 );
				float4 lerpResult982 = lerp( _Shorecolor , lerpResult979 , clampResult984);
				float4 _depth635 = lerpResult982;
				float4 normalizeResult1071 = normalize( screenPos );
				float4 break1072 = normalizeResult1071;
				float2 appendResult660 = (float2(break1072.x , break1072.y));
				float2 appendResult579 = (float2(WorldSpacePosition.x , WorldSpacePosition.z));
				float2 _world_UV582 = ( appendResult579 / 1.0 );
				float2 panner565 = ( _Time.x * _UV1_speed + ( _world_UV582 * _UV1_tiling ));
				float2 UV1566 = panner565;
				float2 panner564 = ( _Time.y * _UV2_speed + ( _world_UV582 * _UV2_tiling ));
				float2 UV2567 = panner564;
				float3 lerpResult576 = lerp( UnpackNormalScale( tex2D( _Normalmapinput, UV1566 ) ,_Normal1_intensity ) , UnpackNormalScale( tex2D( _Normalmapinput, UV2567 ) ,_Normal2_intensity ) , _Normal_blend);
				float3 _Normal577 = lerpResult576;
				float3 temp_output_667_0 = ( float3( ( appendResult660 / break1072.w ) ,  0.0 ) + ( _Normal577 * _Underwater_Distortion ) );
				float4 lerpResult1048 = lerp( float4( 0,0,0,0 ) , tex2D( _TextureSnap, temp_output_667_0.xy ) , _Activated);
				float4 screenColor670 = tex2D( _GrabTexture, temp_output_667_0.xy );
				float4 lerpResult901 = lerp( lerpResult1048 , screenColor670 , WorldSpaceViewDirection.y);
				float4 lerpResult895 = lerp( lerpResult901 , lerpResult1048 , _Reflection_power);
				float screenDepth890 = LinearEyeDepth(tex2Dproj( _CameraDepthTexture,screenPos).r,_ZBufferParams);
				float distanceDepth890 = abs( ( screenDepth890 - LinearEyeDepth( ase_screenPosNorm.z,_ZBufferParams ) ) / ( 7.0 ) );
				float4 lerpResult889 = lerp( lerpResult895 , float4( 0.1218642,0,0,0 ) , distanceDepth890);
				float4 lerpResult891 = lerp( lerpResult895 , lerpResult889 , _Depth_Intensity);
				float3 normalizeResult669 = normalize( ( _MainLightPosition.xyz + WorldSpaceViewDirection ) );
				float4 lerpResult677 = lerp( lerpResult891 , float4( normalizeResult669 , 0.0 ) , 0.0);
				float4 lerpResult1073 = lerp( lerpResult677 , _MainLightColor , float4( 0.021,0.021,0.021,0 ));
				float4 _Underwater_distortion675 = lerpResult1073;
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
				float2 uv1015 = IN.ase_texcoord8.yz * temp_cast_10 + float2( 0,0 );
				float2 panner1016 = ( 1.0 * _Time.y * float2( 0.1,0 ) + uv1015);
				float2 temp_cast_11 = (_caustic_tilling).xx;
				float2 uv733 = IN.ase_texcoord8.yz * temp_cast_11 + float2( 0,0 );
				float2 panner746 = ( _Time.x * _Caustic_speed + uv733);
				float screenDepth784 = LinearEyeDepth(tex2Dproj( _CameraDepthTexture,screenPos).r,_ZBufferParams);
				float distanceDepth784 = abs( ( screenDepth784 - LinearEyeDepth( ase_screenPosNorm.z,_ZBufferParams ) ) / ( 2.0 ) );
				float4 lerpResult797 = lerp( float4(1,1,1,0) , float4( 0,0,0,0 ) , distanceDepth784);
				float3 hsvTorgb787 = HSVToRGB( float3(0.0,0.0,lerpResult797.r) );
				float3 tanToWorld0 = float3( WorldSpaceTangent.x, WorldSpaceBiTangent.x, WorldSpaceNormal.x );
				float3 tanToWorld1 = float3( WorldSpaceTangent.y, WorldSpaceBiTangent.y, WorldSpaceNormal.y );
				float3 tanToWorld2 = float3( WorldSpaceTangent.z, WorldSpaceBiTangent.z, WorldSpaceNormal.z );
				float3 ase_tanViewDir =  tanToWorld0 * WorldSpaceViewDirection.x + tanToWorld1 * WorldSpaceViewDirection.y  + tanToWorld2 * WorldSpaceViewDirection.z;
				ase_tanViewDir = normalize(ase_tanViewDir);
				float2 Offset725 = ( ( hsvTorgb787.x - 1 ) * ase_tanViewDir.xy * _Caustic_parallax ) + panner746;
				float grayscale753 = Luminance(tex2D( _water_caustic, ( UnpackNormalScale( tex2D( _PerlinNoise6, panner1016 ) ,0.05 ) + float3( Offset725 ,  0.0 ) ).xy ).rgb);
				float clampResult790 = clamp( pow( distanceDepth784 , 10.0 ) , 100.0 , 0.5 );
				float4 _caustic729 = ( ( grayscale753 * lerpResult982 ) * clampResult790 );
				float4 blendOpSrc730 = _Water_color_blend639;
				float4 blendOpDest730 = ( _caustic729 * _Caustic_intensity );
				float2 temp_cast_16 = (_Edge_Foam_Tiling).xx;
				float2 uv877 = IN.ase_texcoord8.yz * temp_cast_16 + float2( 0,0 );
				float screenDepth807 = LinearEyeDepth(tex2Dproj( _CameraDepthTexture,screenPos).r,_ZBufferParams);
				float distanceDepth807 = abs( ( screenDepth807 - LinearEyeDepth( ase_screenPosNorm.z,_ZBufferParams ) ) / ( _Foam_Amount ) );
				float4 temp_cast_17 = (distanceDepth807).xxxx;
				float4 lerpResult853 = lerp( CalculateContrast(_Foam_contrast,tex2D( _a710fa1f1165b699bccefec099930acf, uv877 )) , float4( 0,0,0,0 ) , CalculateContrast(( _Foam_contrast * 2.0 ),temp_cast_17).r);
				float4 Waves866 = lerpResult853;
				float4 clampResult884 = clamp( Waves866 , float4( 0,0,0,0 ) , float4( 1,0,0,0 ) );
				float4 lerpResult883 = lerp( ( saturate( max( blendOpSrc730, blendOpDest730 ) )) , _Foamcolor , clampResult884.r);
				float temp_output_1064_0 = ( ( 1.1 - _Waveswidth ) * 5.0 );
				float screenDepth902 = LinearEyeDepth(tex2Dproj( _CameraDepthTexture,screenPos).r,_ZBufferParams);
				float distanceDepth902 = abs( ( screenDepth902 - LinearEyeDepth( ase_screenPosNorm.z,_ZBufferParams ) ) / ( fmod( ( 0.0 - ( _Time.y / 3.0 ) ) , temp_output_1064_0 ) ) );
				float temp_output_1053_0 = ( 0.1 + _Waveswidth );
				float temp_output_1056_0 = ( temp_output_1053_0 + _Waveswidth );
				float temp_output_1057_0 = ( temp_output_1056_0 + _Waveswidth );
				float temp_output_1058_0 = ( temp_output_1057_0 + _Waveswidth );
				float temp_output_1059_0 = ( temp_output_1058_0 + _Waveswidth );
				float screenDepth933 = LinearEyeDepth(tex2Dproj( _CameraDepthTexture,screenPos).r,_ZBufferParams);
				float distanceDepth933 = abs( ( screenDepth933 - LinearEyeDepth( ase_screenPosNorm.z,_ZBufferParams ) ) / ( fmod( ( 0.0 - ( ( _Time.y + temp_output_1064_0 ) / 3.0 ) ) , temp_output_1064_0 ) ) );
				float screenDepth910 = LinearEyeDepth(tex2Dproj( _CameraDepthTexture,screenPos).r,_ZBufferParams);
				float distanceDepth910 = abs( ( screenDepth910 - LinearEyeDepth( ase_screenPosNorm.z,_ZBufferParams ) ) / ( 0.6 ) );
				float screenDepth966 = LinearEyeDepth(tex2Dproj( _CameraDepthTexture,screenPos).r,_ZBufferParams);
				float distanceDepth966 = abs( ( screenDepth966 - LinearEyeDepth( ase_screenPosNorm.z,_ZBufferParams ) ) / ( 0.4 ) );
				float smoothstepResult970 = smoothstep( 0.3 , 0.3 , distanceDepth966);
				float lerpResult967 = lerp( 0.0 , distanceDepth910 , smoothstepResult970);
				float lerpResult912 = lerp( ( ( ( step( distanceDepth902 , temp_output_1058_0 ) - step( distanceDepth902 , temp_output_1057_0 ) ) + ( step( distanceDepth902 , temp_output_1056_0 ) - step( distanceDepth902 , temp_output_1053_0 ) ) + ( step( distanceDepth902 , temp_output_1059_0 ) - step( distanceDepth902 , temp_output_1058_0 ) ) ) + ( ( step( distanceDepth933 , temp_output_1059_0 ) - step( distanceDepth933 , temp_output_1058_0 ) ) + ( step( distanceDepth933 , temp_output_1058_0 ) - step( distanceDepth933 , temp_output_1057_0 ) ) + ( step( distanceDepth933 , temp_output_1056_0 ) - step( distanceDepth933 , temp_output_1053_0 ) ) ) ) , 0.0 , lerpResult967);
				float2 uv953 = IN.ase_texcoord8.yz * float2( 5,5 ) + float2( 0,0 );
				float4 lerpResult1051 = lerp( step( tex2D( _PerlinNoise6, uv953 ) , float4( 0.191,0.191,0.191,0 ) ) , float4( 0,0,0,0 ) , _Wavesnoisecutout);
				float lerpResult956 = lerp( lerpResult912 , 0.0 , lerpResult1051.r);
				float clampResult963 = clamp( lerpResult956 , 0.0 , 1.0 );
				float Waves_pattern957 = clampResult963;
				float4 lerpResult960 = lerp( lerpResult883 , _Wavescolor , ( Waves_pattern957 * _Wavesintensity ));
				float2 uv1023 = IN.ase_texcoord8.yz * float2( 110,110 ) + float2( 0,0 );
				float4 tex2DNode1020 = tex2D( _PerlinNoise6, uv1023 );
				float dotResult1022 = dot( tex2DNode1020 , tex2DNode1020 );
				float dotResult1024 = dot( dotResult1022 , dotResult1022 );
				float dotResult1025 = dot( dotResult1024 , dotResult1024 );
				float dotResult1029 = dot( dotResult1025 , dotResult1025 );
				float dotResult1026 = dot( dotResult1029 , 0.01 );
				float2 uv1033 = IN.ase_texcoord8.yz * float2( 10,10 ) + float2( 0,0 );
				float4 clampResult1035 = clamp( tex2D( _PerlinNoise6, uv1033 ) , float4( 0,0,0,0 ) , float4( 1,1,1,0 ) );
				float dotResult1034 = dot( clampResult1035 , clampResult1035 );
				float dotResult1036 = dot( dotResult1034 , dotResult1034 );
				float lerpResult1032 = lerp( 0.0 , pow( dotResult1026 , 3.0 ) , pow( dotResult1036 , 3.0 ));
				float clampResult1028 = clamp( lerpResult1032 , 0.0 , 1.0 );
				float smoothstepResult1046 = smoothstep( 0.3 , 0.4 , WorldSpaceViewDirection.y);
				float lerpResult1039 = lerp( clampResult1028 , 0.0 , pow( smoothstepResult1046 , 1.0 ));
				float Fake_reflections1040 = lerpResult1039;
				float4 lerpResult1027 = lerp( lerpResult960 , _Fakereflectionscolor , Fake_reflections1040);
				
				float lerpResult1043 = lerp( 0.0 , 1.0 , Fake_reflections1040);
				float3 temp_cast_22 = (lerpResult1043).xxx;
				
				float screenDepth690 = LinearEyeDepth(tex2Dproj( _CameraDepthTexture,screenPos).r,_ZBufferParams);
				float distanceDepth690 = abs( ( screenDepth690 - LinearEyeDepth( ase_screenPosNorm.z,_ZBufferParams ) ) / ( 0.5 ) );
				float clampResult691 = clamp( pow( distanceDepth690 , _Edge_fade ) , 0.0 , 1.0 );
				float _edgeFade695 = clampResult691;
				
				
				float3 Specular = float3(0, 0, 0);
		        float3 Albedo = lerpResult1027.rgb;
				float3 Normal = _Normal577;
				float3 Emission = temp_cast_22;
				float Metallic = 0.0;
				float Smoothness = _Smoothness_level;
				float Occlusion = 1;
				float Alpha = _edgeFade695;
				float AlphaClipThreshold = 0;
		
				InputData inputData;
				inputData.positionWS = WorldSpacePosition;

				#ifdef _NORMALMAP
					inputData.normalWS = TangentToWorldNormal(Normal, WorldSpaceTangent, WorldSpaceBiTangent, WorldSpaceNormal);
				#else
					inputData.normalWS = WorldSpaceNormal;
				#endif

				#ifdef SHADER_API_MOBILE
					// viewDirection should be normalized here, but we avoid doing it as it's close enough and we save some ALU.
					inputData.viewDirectionWS = WorldSpaceViewDirection;
				#else
					inputData.viewDirectionWS = WorldSpaceViewDirection;
				#endif

				inputData.shadowCoord = IN.shadowCoord;

				inputData.fogCoord = IN.fogFactorAndVertexLight.x;
				inputData.vertexLighting = IN.fogFactorAndVertexLight.yzw;
				inputData.bakedGI = SAMPLE_GI(IN.lightmapUVOrVertexSH, IN.lightmapUVOrVertexSH, inputData.normalWS);

				half4 color = LightweightFragmentPBR(
					inputData, 
					Albedo, 
					Metallic, 
					Specular, 
					Smoothness, 
					Occlusion, 
					Emission, 
					Alpha);

				// Computes fog factor per-vertex
    			ApplyFog(color.rgb, IN.fogFactorAndVertexLight.x);

				#if _AlphaClip
					clip(Alpha - AlphaClipThreshold);
				#endif
				return color;
		    }
			ENDHLSL
		}

		Pass
		{
			
			Name "ShadowCaster"
			Tags { "LightMode"="ShadowCaster" }

			ZWrite On
			ZTest LEqual

			HLSLPROGRAM
		    #pragma prefer_hlslcc gles
		
			#pragma multi_compile_instancing
		
		    #pragma vertex vert
			#pragma fragment frag
		
			#include "LWRP/ShaderLibrary/Core.hlsl"
			#include "LWRP/ShaderLibrary/Lighting.hlsl"
			
			uniform float4 _ShadowBias;
			uniform float3 _LightDirection;
			uniform sampler2D _Normalmapinput;
			uniform float _Normal1_intensity;
			uniform float2 _UV1_speed;
			uniform float _UV1_tiling;
			uniform float _Normal2_intensity;
			uniform float2 _UV2_speed;
			uniform float _UV2_tiling;
			uniform float _Normal_blend;
			uniform float _Vertexdicplacementlevel;
			uniform sampler2D _CameraDepthTexture;
			uniform float _Edge_fade;
					
			struct GraphVertexInput
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				
			};

			struct GraphVertexOutput
			{
				float4 clipPos					: SV_POSITION;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				float4 ase_texcoord7 : TEXCOORD7;
			};

			GraphVertexOutput vert (GraphVertexInput v)
			{
				GraphVertexOutput o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				float3 ase_worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				float2 appendResult579 = (float2(ase_worldPos.x , ase_worldPos.z));
				float2 _world_UV582 = ( appendResult579 / 1.0 );
				float2 panner565 = ( _Time.x * _UV1_speed + ( _world_UV582 * _UV1_tiling ));
				float2 UV1566 = panner565;
				float2 panner564 = ( _Time.y * _UV2_speed + ( _world_UV582 * _UV2_tiling ));
				float2 UV2567 = panner564;
				float3 lerpResult576 = lerp( UnpackNormalScale( tex2Dlod( _Normalmapinput, float4( UV1566, 0, 0.0) ) ,_Normal1_intensity ) , UnpackNormalScale( tex2Dlod( _Normalmapinput, float4( UV2567, 0, 0.0) ) ,_Normal2_intensity ) , _Normal_blend);
				float3 _Normal577 = lerpResult576;
				float4 transform514 = mul(unity_ObjectToWorld,float4( _Normal577 , 0.0 ));
				float _vector_displacement544 = ( transform514.y * _Vertexdicplacementlevel );
				float3 temp_cast_1 = (_vector_displacement544).xxx;
				
				float4 ase_clipPos = TransformObjectToHClip(v.vertex);
				float4 screenPos = ComputeScreenPos(ase_clipPos);
				o.ase_texcoord7 = screenPos;
				

				v.vertex.xyz += temp_cast_1;

				float3 positionWS = TransformObjectToWorld(v.vertex.xyz);
				float3 normalWS = TransformObjectToWorldDir(v.normal);

				float invNdotL = 1.0 - saturate(dot(_LightDirection, normalWS));
				float scale = invNdotL * _ShadowBias.y;

				positionWS = normalWS * scale.xxx + positionWS;
				float4 clipPos = TransformWorldToHClip(positionWS);

				clipPos.z += _ShadowBias.x;
				#if UNITY_REVERSED_Z
					clipPos.z = min(clipPos.z, clipPos.w * UNITY_NEAR_CLIP_VALUE);
				#else
					clipPos.z = max(clipPos.z, clipPos.w * UNITY_NEAR_CLIP_VALUE);
				#endif
				o.clipPos = clipPos;
				return o;
			}
		
			half4 frag (GraphVertexOutput IN ) : SV_Target
		    {
		    	UNITY_SETUP_INSTANCE_ID(IN);

				float4 screenPos = IN.ase_texcoord7;
				float4 ase_screenPosNorm = screenPos / screenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float screenDepth690 = LinearEyeDepth(tex2Dproj( _CameraDepthTexture,screenPos).r,_ZBufferParams);
				float distanceDepth690 = abs( ( screenDepth690 - LinearEyeDepth( ase_screenPosNorm.z,_ZBufferParams ) ) / ( 0.5 ) );
				float clampResult691 = clamp( pow( distanceDepth690 , _Edge_fade ) , 0.0 , 1.0 );
				float _edgeFade695 = clampResult691;
				

				float Alpha = _edgeFade695;
				float AlphaClipThreshold = AlphaClipThreshold;
				
				#if _AlphaClip
					clip(Alpha - AlphaClipThreshold);
				#endif
				return Alpha;
				return 0;
		    }
			ENDHLSL
		}
		
		Pass
		{
			
			Name "DepthOnly"
			Tags { "LightMode"="DepthOnly" }

			ZWrite On
			ColorMask 0
			Cull Back

			HLSLPROGRAM
			#pragma prefer_hlslcc gles
    
			#pragma multi_compile_instancing

			#pragma vertex vert
			#pragma fragment frag

			#include "LWRP/ShaderLibrary/Core.hlsl"
			#include "LWRP/ShaderLibrary/Lighting.hlsl"
			
			uniform sampler2D _Normalmapinput;
			uniform float _Normal1_intensity;
			uniform float2 _UV1_speed;
			uniform float _UV1_tiling;
			uniform float _Normal2_intensity;
			uniform float2 _UV2_speed;
			uniform float _UV2_tiling;
			uniform float _Normal_blend;
			uniform float _Vertexdicplacementlevel;
			uniform sampler2D _CameraDepthTexture;
			uniform float _Edge_fade;

			struct GraphVertexInput
			{
				float4 vertex : POSITION;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				
			};

			struct GraphVertexOutput
			{
				float4 clipPos					: SV_POSITION;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				float4 ase_texcoord7 : TEXCOORD7;
			};

			GraphVertexOutput vert (GraphVertexInput v)
			{
				GraphVertexOutput o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				float3 ase_worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				float2 appendResult579 = (float2(ase_worldPos.x , ase_worldPos.z));
				float2 _world_UV582 = ( appendResult579 / 1.0 );
				float2 panner565 = ( _Time.x * _UV1_speed + ( _world_UV582 * _UV1_tiling ));
				float2 UV1566 = panner565;
				float2 panner564 = ( _Time.y * _UV2_speed + ( _world_UV582 * _UV2_tiling ));
				float2 UV2567 = panner564;
				float3 lerpResult576 = lerp( UnpackNormalScale( tex2Dlod( _Normalmapinput, float4( UV1566, 0, 0.0) ) ,_Normal1_intensity ) , UnpackNormalScale( tex2Dlod( _Normalmapinput, float4( UV2567, 0, 0.0) ) ,_Normal2_intensity ) , _Normal_blend);
				float3 _Normal577 = lerpResult576;
				float4 transform514 = mul(unity_ObjectToWorld,float4( _Normal577 , 0.0 ));
				float _vector_displacement544 = ( transform514.y * _Vertexdicplacementlevel );
				float3 temp_cast_1 = (_vector_displacement544).xxx;
				
				float4 ase_clipPos = TransformObjectToHClip(v.vertex);
				float4 screenPos = ComputeScreenPos(ase_clipPos);
				o.ase_texcoord7 = screenPos;
				

				v.vertex.xyz += temp_cast_1;
				o.clipPos = TransformObjectToHClip(v.vertex.xyz);
				return o;
			}

			half4 frag (GraphVertexOutput IN ) : SV_Target
		    {
		    	UNITY_SETUP_INSTANCE_ID(IN);

				float4 screenPos = IN.ase_texcoord7;
				float4 ase_screenPosNorm = screenPos / screenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float screenDepth690 = LinearEyeDepth(tex2Dproj( _CameraDepthTexture,screenPos).r,_ZBufferParams);
				float distanceDepth690 = abs( ( screenDepth690 - LinearEyeDepth( ase_screenPosNorm.z,_ZBufferParams ) ) / ( 0.5 ) );
				float clampResult691 = clamp( pow( distanceDepth690 , _Edge_fade ) , 0.0 , 1.0 );
				float _edgeFade695 = clampResult691;
				

				float Alpha = _edgeFade695;
				float AlphaClipThreshold = AlphaClipThreshold;
				
				#if _AlphaClip
					clip(Alpha - AlphaClipThreshold);
				#endif
				return Alpha;
				return 0;
		    }
			ENDHLSL
		}
		
		Pass
		{
			
			Name "Meta"
			Tags{"LightMode" = "Meta"}
		  
			Cull Off

				Cull Off

				HLSLPROGRAM
				// Required to compile gles 2.0 with standard srp library
				#pragma prefer_hlslcc gles

				#pragma vertex LightweightVertexMeta
				#pragma fragment LightweightFragmentMeta

				#pragma shader_feature _SPECULAR_SETUP
				#pragma shader_feature _EMISSION
				#pragma shader_feature _METALLICSPECGLOSSMAP
				#pragma shader_feature _ _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A
				#pragma shader_feature EDITOR_VISUALIZATION

				#pragma shader_feature _SPECGLOSSMAP

				#include "LWRP/ShaderLibrary/InputSurfacePBR.hlsl"
				#include "LWRP/ShaderLibrary/LightweightPassMetaPBR.hlsl"
				ENDHLSL
		}
	}
}
