// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "beffio/Medieval_Kingdom/SRP/Lightweight/Trees"
{
	Properties
	{
		_Base_Color("Base_Color", Color) = (0.282353,0.1411765,0.01960784,0)
		_Base_Smoothness("Base_Smoothness", Range( 0 , 2)) = 1
		_Base_normal_intensity("Base_normal_intensity", Range( 0 , 1)) = 1
		_Moss_Color("Moss_Color", Color) = (0.4138201,0.5607843,0,0)
		_Moss_mask_intensity("Moss_mask_intensity", Range( 0 , 5)) = 4.659523
		_Moss_tiling("Moss_tiling", Range( 0.5 , 10)) = 4
		_Moss_smoothness("Moss_smoothness", Range( 0 , 2)) = 0.3422558
		_Moss_normal_intensity("Moss_normal_intensity", Range( 0 , 2)) = 0
		_Edge_wear_level("Edge_wear_level", Range( 0 , 1)) = 0.5
		_Ambient_occlusion_shift("Ambient_occlusion_shift", Range( 0 , 2)) = 0.5
		_Albedo_smoothness_map_input("Albedo_smoothness_map_input", 2D) = "white" {}
		_Normal_map_input("Normal_map_input", 2D) = "bump" {}
		_World_space_normals_input("World_space_normals_input", 2D) = "white" {}
		_Ambient_Occlusion_map_input("Ambient_Occlusion_map_input", 2D) = "white" {}
		_Edge_mask_map_input("Edge_mask_map_input", 2D) = "white" {}
		_Moss_texture_grayscale("Moss_texture_grayscale", 2D) = "white" {}
		_Moss_Normal("Moss_Normal", 2D) = "bump" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
	}
	SubShader
	{
		Tags { "RenderPipeline"="LightweightPipeline" "RenderType"="Opaque" "Queue"="Geometry" }
		
		Cull Back
		HLSLINCLUDE
		#pragma target 3.0
		ENDHLSL
		
		Pass
		{
			Tags { "LightMode"="LightweightForward" }
			Name "Base"
			Cull Back
			Blend One Zero
			ZWrite On
			ZTest LEqual
			Offset 0 , 0
			ColorMask RGBA
		
			HLSLPROGRAM
		    // Required to compile gles 2.0 with standard srp library
		    #pragma prefer_hlslcc gles
			
			// -------------------------------------
			// Lightweight Pipeline keywords
			#pragma multi_compile _ _ADDITIONAL_LIGHTS
			#pragma multi_compile _ _VERTEX_LIGHTS
			#pragma multi_compile _ _MIXED_LIGHTING_SUBTRACTIVE
			#pragma multi_compile _ _SHADOWS_ENABLED
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

			uniform float4 _Base_Color;
			uniform sampler2D _Albedo_smoothness_map_input;
			uniform float4 _Albedo_smoothness_map_input_ST;
			uniform float4 _Moss_Color;
			uniform sampler2D _Moss_texture_grayscale;
			uniform float _Moss_tiling;
			uniform sampler2D _World_space_normals_input;
			uniform float4 _World_space_normals_input_ST;
			uniform float _Moss_mask_intensity;
			uniform sampler2D _Edge_mask_map_input;
			uniform float4 _Edge_mask_map_input_ST;
			uniform float _Edge_wear_level;
			uniform sampler2D _Ambient_Occlusion_map_input;
			uniform float4 _Ambient_Occlusion_map_input_ST;
			uniform float _Ambient_occlusion_shift;
			uniform float _Base_normal_intensity;
			uniform sampler2D _Normal_map_input;
			uniform float4 _Normal_map_input_ST;
			uniform float _Moss_normal_intensity;
			uniform sampler2D _Moss_Normal;
			uniform float _Base_Smoothness;
			uniform float _Moss_smoothness;
					
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
			};

			GraphVertexOutput vert (GraphVertexInput v)
			{
		        GraphVertexOutput o = (GraphVertexOutput)0;
		
		        UNITY_SETUP_INSTANCE_ID(v);
		    	UNITY_TRANSFER_INSTANCE_ID(v, o);
		
				float3 lwWNormal = TransformObjectToWorldNormal(v.normal);
				float3 lwWorldPos = TransformObjectToWorld(v.vertex.xyz);
				float3 lwWTangent = TransformObjectToWorldDir(v.tangent.xyz);
				float3 lwWBinormal = normalize(cross(lwWNormal, lwWTangent) * v.tangent.w);
				o.tSpace0 = float4(lwWTangent.x, lwWBinormal.x, lwWNormal.x, lwWorldPos.x);
				o.tSpace1 = float4(lwWTangent.y, lwWBinormal.y, lwWNormal.y, lwWorldPos.y);
				o.tSpace2 = float4(lwWTangent.z, lwWBinormal.z, lwWNormal.z, lwWorldPos.z);
				float4 clipPos = TransformWorldToHClip(lwWorldPos);

				o.ase_texcoord7.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord7.zw = 0;
				v.vertex.xyz +=  float3(0,0,0) ;
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

				float2 uv_Albedo_smoothness_map_input = IN.ase_texcoord7.xy * _Albedo_smoothness_map_input_ST.xy + _Albedo_smoothness_map_input_ST.zw;
				float4 tex2DNode279 = tex2D( _Albedo_smoothness_map_input, uv_Albedo_smoothness_map_input );
				float4 blendOpSrc95 = _Base_Color;
				float4 blendOpDest95 = tex2DNode279;
				float4 _base_tree_color334 = ( saturate( (( blendOpDest95 > 0.5 ) ? ( 1.0 - ( 1.0 - 2.0 * ( blendOpDest95 - 0.5 ) ) * ( 1.0 - blendOpSrc95 ) ) : ( 2.0 * blendOpDest95 * blendOpSrc95 ) ) ));
				float2 temp_cast_0 = (_Moss_tiling).xx;
				float2 uv316 = IN.ase_texcoord7.xy * temp_cast_0 + float2( 0,0 );
				float2 _moss_tiling329 = uv316;
				float4 tex2DNode311 = tex2D( _Moss_texture_grayscale, _moss_tiling329 );
				float4 lerpResult312 = lerp( _Moss_Color , _base_tree_color334 , tex2DNode311.r);
				float2 uv_World_space_normals_input = IN.ase_texcoord7.xy * _World_space_normals_input_ST.xy + _World_space_normals_input_ST.zw;
				float3 tanToWorld0 = float3( WorldSpaceTangent.x, WorldSpaceBiTangent.x, WorldSpaceNormal.x );
				float3 tanToWorld1 = float3( WorldSpaceTangent.y, WorldSpaceBiTangent.y, WorldSpaceNormal.y );
				float3 tanToWorld2 = float3( WorldSpaceTangent.z, WorldSpaceBiTangent.z, WorldSpaceNormal.z );
				float3 tanNormal307 = tex2D( _World_space_normals_input, uv_World_space_normals_input ).rgb;
				float3 worldNormal307 = float3(dot(tanToWorld0,tanNormal307), dot(tanToWorld1,tanNormal307), dot(tanToWorld2,tanNormal307));
				float _side_mask_alpha338 = ( ( worldNormal307.x * saturate( WorldSpaceNormal.x ) ) * _Moss_mask_intensity );
				float4 lerpResult314 = lerp( _base_tree_color334 , lerpResult312 , _side_mask_alpha338);
				float4 blendOpSrc291 = _base_tree_color334;
				float4 blendOpDest291 = lerpResult314;
				float4 temp_output_291_0 = ( saturate( max( blendOpSrc291, blendOpDest291 ) ));
				float2 uv_Edge_mask_map_input = IN.ase_texcoord7.xy * _Edge_mask_map_input_ST.xy + _Edge_mask_map_input_ST.zw;
				float4 lerpResult275 = lerp( temp_output_291_0 , float4(1,1,1,0) , ( tex2D( _Edge_mask_map_input, uv_Edge_mask_map_input ) * _Edge_wear_level ).r);
				float4 blendOpSrc276 = temp_output_291_0;
				float4 blendOpDest276 = lerpResult275;
				float4 temp_output_276_0 = ( saturate( (( blendOpSrc276 > 0.5 ) ? max( blendOpDest276, 2.0 * ( blendOpSrc276 - 0.5 ) ) : min( blendOpDest276, 2.0 * blendOpSrc276 ) ) ));
				float2 uv_Ambient_Occlusion_map_input = IN.ase_texcoord7.xy * _Ambient_Occlusion_map_input_ST.xy + _Ambient_Occlusion_map_input_ST.zw;
				float4 _AO317 = tex2D( _Ambient_Occlusion_map_input, uv_Ambient_Occlusion_map_input );
				float4 blendOpSrc285 = float4(1,1,1,0);
				float4 blendOpDest285 = _AO317;
				float4 lerpResult289 = lerp( temp_output_276_0 , float4(0,0,0,0) , ( ( saturate( abs( blendOpSrc285 - blendOpDest285 ) )) * _Ambient_occlusion_shift ).r);
				float4 blendOpSrc290 = temp_output_276_0;
				float4 blendOpDest290 = lerpResult289;
				float4 _albedo345 = ( saturate( min( blendOpSrc290 , blendOpDest290 ) ));
				
				float2 uv_Normal_map_input = IN.ase_texcoord7.xy * _Normal_map_input_ST.xy + _Normal_map_input_ST.zw;
				float3 lerpResult303 = lerp( UnpackNormalScale( tex2D( _Normal_map_input, uv_Normal_map_input ) ,_Base_normal_intensity ) , UnpackNormalScale( tex2D( _Moss_Normal, _moss_tiling329 ) ,_Moss_normal_intensity ) , _side_mask_alpha338);
				float3 _normals_blend335 = lerpResult303;
				
				float4 temp_cast_6 = (( tex2DNode279.a * _Base_Smoothness )).xxxx;
				float4 lerpResult302 = lerp( temp_cast_6 , ( tex2DNode311 * _Moss_smoothness ) , _side_mask_alpha338);
				float4 _smoothness347 = lerpResult302;
				
				
		        float3 Albedo = _albedo345.rgb;
				float3 Normal = _normals_blend335;
				float3 Emission = 0;
				float3 Specular = float3(0.5, 0.5, 0.5);
				float Metallic = 0.0;
				float Smoothness = _smoothness347.r;
				float Occlusion = 1;
				float Alpha = _AO317.r;
				float AlphaClipThreshold = 0;
		
				InputData inputData;
				inputData.positionWS = WorldSpacePosition;

				#ifdef _NORMALMAP
					inputData.normalWS = TangentToWorldNormal(Normal, WorldSpaceTangent, WorldSpaceBiTangent, WorldSpaceNormal);
				#else
					inputData.normalWS = WorldSpaceNormal;
				#endif
				inputData.normalWS = normalize(inputData.normalWS);
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
			uniform sampler2D _Ambient_Occlusion_map_input;
			uniform float4 _Ambient_Occlusion_map_input_ST;
					
			struct GraphVertexInput
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				float4 ase_texcoord : TEXCOORD0;
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

				o.ase_texcoord7.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord7.zw = 0;

				v.vertex.xyz +=  float3(0,0,0) ;

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

				float2 uv_Ambient_Occlusion_map_input = IN.ase_texcoord7.xy * _Ambient_Occlusion_map_input_ST.xy + _Ambient_Occlusion_map_input_ST.zw;
				float4 _AO317 = tex2D( _Ambient_Occlusion_map_input, uv_Ambient_Occlusion_map_input );
				

				float Alpha = _AO317.r;
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
			
			uniform sampler2D _Ambient_Occlusion_map_input;
			uniform float4 _Ambient_Occlusion_map_input_ST;

			struct GraphVertexInput
			{
				float4 vertex : POSITION;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				float4 ase_texcoord : TEXCOORD0;
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

				o.ase_texcoord7.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord7.zw = 0;

				v.vertex.xyz +=  float3(0,0,0) ;
				o.clipPos = TransformObjectToHClip(v.vertex.xyz);
				return o;
			}

			half4 frag (GraphVertexOutput IN ) : SV_Target
		    {
		    	UNITY_SETUP_INSTANCE_ID(IN);

				float2 uv_Ambient_Occlusion_map_input = IN.ase_texcoord7.xy * _Ambient_Occlusion_map_input_ST.xy + _Ambient_Occlusion_map_input_ST.zw;
				float4 _AO317 = tex2D( _Ambient_Occlusion_map_input, uv_Ambient_Occlusion_map_input );
				

				float Alpha = _AO317.r;
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
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15304
7;492;3426;901;1262.357;627.1353;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;324;-972.9929,-315.2026;Float;False;1048;548;Side_mask_World_space_normals_input;8;338;308;313;309;306;307;304;305;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;330;-678.9425,758.5562;Float;False;812.4897;206;Moss_tiling;3;316;321;329;;1,1,1,1;0;0
Node;AmplifyShaderEditor.WorldNormalVector;305;-844.9921,-59.20279;Float;False;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SamplerNode;304;-924.993,-251.2026;Float;True;Property;_World_space_normals_input;World_space_normals_input;12;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;322;-1657.836,-178.6518;Float;False;642.2996;420.8188;Albedo_smoothness_map_input;5;334;95;279;89;351;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;321;-628.9416,838.9883;Float;False;Property;_Moss_tiling;Moss_tiling;5;0;Create;True;0;0;False;0;4;0;0.5;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;89;-1609.836,-130.6519;Float;False;Property;_Base_Color;Base_Color;0;0;Create;True;0;0;False;0;0.282353,0.1411765,0.01960784,0;1,1,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldNormalVector;307;-629.9928,-241.2027;Float;False;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TextureCoordinatesNode;316;-358.5511,808.5563;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;323;-1662.179,256.8806;Float;False;840.1489;470.1416;Moss_color;6;333;312;310;311;349;350;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SaturateNode;306;-629.9938,-56.2028;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;279;-1611.683,31.19457;Float;True;Property;_Albedo_smoothness_map_input;Albedo_smoothness_map_input;10;0;Create;True;0;0;False;0;39c3a989f5e653145a8682c1c3898b03;39c3a989f5e653145a8682c1c3898b03;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;329;-92.84798,830.4513;Float;False;_moss_tiling;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BlendOpsNode;95;-1331.838,-119.6519;Float;False;Overlay;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;309;-460.9937,-111.2028;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;308;-872.993,85.79707;Float;False;Property;_Moss_mask_intensity;Moss_mask_intensity;4;0;Create;True;0;0;False;0;4.659523;2;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;333;-1630.486,466.0239;Float;False;329;0;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;310;-1374.178,288.8805;Float;False;Property;_Moss_Color;Moss_Color;3;0;Create;True;0;0;False;0;0.4138201,0.5607843,0,0;0.654902,0.7058823,0.1490187,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;344;-802.5353,360.3241;Float;False;537.5459;367.6658;Moss_side_mask_blend;4;291;337;314;339;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;313;-310.9933,-105.2028;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;349;-1639.334,372.3528;Float;False;334;0;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;311;-1390.178,464.8804;Float;True;Property;_Moss_texture_grayscale;Moss_texture_grayscale;15;0;Create;True;0;0;False;0;ddf6344e26e0f7e44a9a606e40d2f832;ddf6344e26e0f7e44a9a606e40d2f832;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;334;-1270.838,30.34789;Float;False;_base_tree_color;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;339;-767.9218,430.0266;Float;False;338;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;312;-1042.375,395.7318;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;318;-675.1283,976.3992;Float;False;682.6891;271;Ambient_Occlusion_map_input;2;317;272;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;338;-166.9929,-94.20279;Float;False;_side_mask_alpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;325;-217.7758,248.6613;Float;False;793.0044;480.3531;Edge_mask_map_input;6;276;275;274;277;273;278;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;337;-771.2527,539.8026;Float;False;334;0;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;272;-625.1284,1026.399;Float;True;Property;_Ambient_Occlusion_map_input;Ambient_Occlusion_map_input;13;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;314;-508.9975,432.0082;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;326;642.9226,253.0178;Float;False;1178.832;466;AO_albedo_blend;9;345;290;289;287;288;286;285;320;284;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;278;-169.7758,328.661;Float;True;Property;_Edge_mask_map_input;Edge_mask_map_input;14;0;Create;True;0;0;False;0;ceb848ff79e29094fa213b7a9e09f625;ceb848ff79e29094fa213b7a9e09f625;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;273;-153.7759,552.6608;Float;False;Property;_Edge_wear_level;Edge_wear_level;8;0;Create;True;0;0;False;0;0.5;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;284;722.9236,317.018;Float;False;Constant;_Color2;Color 2;17;0;Create;True;0;0;False;0;1,1,1,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;277;126.142,333.7317;Float;False;Constant;_Color0;Color 0;1;0;Create;True;0;0;False;0;1,1,1,0;1,1,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;342;161.2098,759.3782;Float;False;1405.639;654.8245;Normal_map_input_blend;5;335;303;340;328;327;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;274;141.0342,527.3153;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;317;-222.44,1049.198;Float;False;_AO;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;320;750.9236,504.0181;Float;False;317;0;1;COLOR;0
Node;AmplifyShaderEditor.BlendOpsNode;291;-491.976,568.0038;Float;False;Lighten;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;343;-1678.821,808.588;Float;False;964.321;339;Smoothness;9;347;302;341;300;292;298;296;352;353;;1,1,1,1;0;0
Node;AmplifyShaderEditor.WireNode;351;-1302.921,183.6284;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;328;212.4547,1095.171;Float;False;709.147;271;Normal_map_input;2;301;294;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;286;702.9236,597.0178;Float;False;Property;_Ambient_occlusion_shift;Ambient_occlusion_shift;9;0;Create;True;0;0;False;0;0.5;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.BlendOpsNode;285;972.9234,319.018;Float;False;Difference;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;275;333.1122,422.6793;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;353;-1561.964,851.2319;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;327;215.3428,809.3783;Float;False;702.5469;280;Moss_Normal;3;299;297;331;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;331;259.4917,846.9293;Float;False;329;0;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;297;265.3438,931.3872;float;False;Property;_Moss_normal_intensity;Moss_normal_intensity;7;0;Create;True;0;0;False;0;0;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;288;1222.922,334.018;Float;False;Constant;_Color3;Color 3;1;0;Create;True;0;0;False;0;0,0,0,0;1,1,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BlendOpsNode;276;326.6062,564.1433;Float;False;PinLight;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;287;1050.922,455.018;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;350;-1124.409,657.9437;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;296;-1645.42,898.7827;Float;False;Property;_Moss_smoothness;Moss_smoothness;6;0;Create;True;0;0;False;0;0.3422558;0.283;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;292;-1642.959,990.106;Float;False;Property;_Base_Smoothness;Base_Smoothness;1;0;Create;True;0;0;False;0;1;0.568;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;294;249.4547,1178.101;float;False;Property;_Base_normal_intensity;Base_normal_intensity;2;0;Create;True;0;0;False;0;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;352;-1470.921,865.6284;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;299;597.8915,859.3782;Float;True;Property;_Moss_Normal;Moss_Normal;16;0;Create;True;0;0;False;0;a10e98907b5cb784aa93e62c73c60b1a;a10e98907b5cb784aa93e62c73c60b1a;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;300;-1362.057,986.8571;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;340;926.583,1191.844;Float;False;338;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;289;1434.922,349.0181;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;298;-1370.567,882.3057;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;341;-1207.044,871.067;Float;False;338;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;301;601.6025,1142.171;Float;True;Property;_Normal_map_input;Normal_map_input;11;0;Create;True;0;0;False;0;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BlendOpsNode;290;1399.922,538.0178;Float;False;Darken;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;302;-1113.414,961.533;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;303;1164.279,967.9;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;347;-927.029,952.745;Float;False;_smoothness;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;319;539.3289,11.24084;Float;False;317;0;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;345;1609.789,544.6995;Float;False;_albedo;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;335;1342.237,1055.683;Float;False;_normals_blend;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;357;388.1434,-103.6353;Float;False;Constant;_Float0;Float 0;17;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;348;507.3288,-84.75906;Float;False;347;0;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;346;539.3289,-308.7591;Float;False;345;0;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;336;491.3288,-196.759;Float;False;335;0;1;FLOAT3;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;355;908.9245,-254.9679;Float;False;False;2;Float;ASEMaterialInspector;0;1;ASETemplateShaders/LightWeight;1976390536c6c564abb90fe41f6ee334;0;1;ShadowCaster;0;False;False;True;0;False;-1;False;False;False;False;False;True;3;RenderPipeline=LightweightPipeline;RenderType=Opaque;Queue=Geometry;True;2;0;0;0;False;False;False;False;False;True;1;False;-1;True;3;False;-1;False;True;1;LightMode=ShadowCaster;False;0;0;0;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;356;908.9245,-254.9679;Float;False;False;2;Float;ASEMaterialInspector;0;1;ASETemplateShaders/LightWeight;1976390536c6c564abb90fe41f6ee334;0;2;DepthOnly;0;False;False;True;0;False;-1;False;False;False;False;False;True;3;RenderPipeline=LightweightPipeline;RenderType=Opaque;Queue=Geometry;True;2;0;0;0;False;False;True;0;False;-1;True;False;False;False;False;0;False;-1;False;True;1;False;-1;False;False;True;1;LightMode=DepthOnly;False;0;0;0;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;354;908.9245,-254.9679;Float;False;True;2;Float;ASEMaterialInspector;0;1;beffio/Medieval_Kingdom/SRP/Lightweight/Trees;1976390536c6c564abb90fe41f6ee334;0;0;Base;10;False;False;True;0;False;-1;False;False;False;False;False;True;3;RenderPipeline=LightweightPipeline;RenderType=Opaque;Queue=Geometry;True;2;0;0;0;True;1;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;False;True;0;False;-1;True;True;True;True;True;0;False;-1;False;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;1;LightMode=LightweightForward;False;0;0;0;10;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;9;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT3;0,0,0;False;0
WireConnection;307;0;304;0
WireConnection;316;0;321;0
WireConnection;306;0;305;1
WireConnection;329;0;316;0
WireConnection;95;0;89;0
WireConnection;95;1;279;0
WireConnection;309;0;307;1
WireConnection;309;1;306;0
WireConnection;313;0;309;0
WireConnection;313;1;308;0
WireConnection;311;1;333;0
WireConnection;334;0;95;0
WireConnection;312;0;310;0
WireConnection;312;1;349;0
WireConnection;312;2;311;0
WireConnection;338;0;313;0
WireConnection;314;0;337;0
WireConnection;314;1;312;0
WireConnection;314;2;339;0
WireConnection;274;0;278;0
WireConnection;274;1;273;0
WireConnection;317;0;272;0
WireConnection;291;0;337;0
WireConnection;291;1;314;0
WireConnection;351;0;279;4
WireConnection;285;0;284;0
WireConnection;285;1;320;0
WireConnection;275;0;291;0
WireConnection;275;1;277;0
WireConnection;275;2;274;0
WireConnection;353;0;351;0
WireConnection;276;0;291;0
WireConnection;276;1;275;0
WireConnection;287;0;285;0
WireConnection;287;1;286;0
WireConnection;350;0;311;0
WireConnection;352;0;353;0
WireConnection;299;1;331;0
WireConnection;299;5;297;0
WireConnection;300;0;352;0
WireConnection;300;1;292;0
WireConnection;289;0;276;0
WireConnection;289;1;288;0
WireConnection;289;2;287;0
WireConnection;298;0;350;0
WireConnection;298;1;296;0
WireConnection;301;5;294;0
WireConnection;290;0;276;0
WireConnection;290;1;289;0
WireConnection;302;0;300;0
WireConnection;302;1;298;0
WireConnection;302;2;341;0
WireConnection;303;0;301;0
WireConnection;303;1;299;0
WireConnection;303;2;340;0
WireConnection;347;0;302;0
WireConnection;345;0;290;0
WireConnection;335;0;303;0
WireConnection;354;0;346;0
WireConnection;354;1;336;0
WireConnection;354;3;357;0
WireConnection;354;4;348;0
WireConnection;354;6;319;0
ASEEND*/
//CHKSM=DA4B988513C416E27E23C2C22D5223C276E9F686