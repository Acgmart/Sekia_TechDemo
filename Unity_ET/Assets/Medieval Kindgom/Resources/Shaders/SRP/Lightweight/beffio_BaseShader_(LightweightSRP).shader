// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "beffio/Medieval_Kingdom/SRP/Lightweight/BaseShader"
{
	Properties
	{
		_Material_Tiling("Material_Tiling", Vector) = (1,1,0,0)
		_Base_color("Base_color", Color) = (0.427451,0.227451,0.1372549,0)
		_Detail_color("Detail_color", Color) = (0,0.9779412,0.7756083,0)
		_Detail_level("Detail_level", Range( 0 , 1)) = 0
		_Detail_2_color("Detail_2_color", Color) = (0,0.9779412,0.7756083,0)
		_Detail_2_level("Detail_2_level", Range( 0 , 1)) = 0
		_Normal_intensity("Normal_intensity", Range( 0 , 2)) = 1
		_Material_Smoothness_shift("Material_Smoothness_shift", Range( 0 , 2)) = 1
		_Detail_Smoothness_shift("Detail_Smoothness_shift", Range( 0 , 1)) = 0
		_AO_shift("AO_shift", Range( 0 , 2)) = 0
		_Edge_wear("Edge_wear", Range( 0 , 1)) = 0
		_Mettallic_shift("Mettallic_shift", Range( 0 , 3)) = 0
		_Emmsivie_color("Emmsivie_color", Color) = (0.9779412,0.9210103,0.6831207,0)
		_Emmisive_intensity("Emmisive_intensity", Range( 0 , 50)) = 0
		_Alpha_cutout_level("Alpha_cutout_level", Range( 0 , 1)) = 1
		[Toggle(_METALOBJECTUSESMETTALICSMOOTHNESMAP_ON)] _Metalobjectusesmettalicsmoothnesmap("Metal object uses mettalic smoothnes map?", Float) = 0
		_Albedo_smoothness_map_input("Albedo_smoothness_map_input", 2D) = "white" {}
		_Normal_map_input("Normal_map_input", 2D) = "bump" {}
		_Metallic_Smoothness_map_input("Metallic_Smoothness_map_input", 2D) = "white" {}
		_Ambient_Occlusion_map_input("Ambient_Occlusion_map_input", 2D) = "white" {}
		_Detail_mask_1_map_input("Detail_mask_1_map_input", 2D) = "white" {}
		_Detail_mask_2_map_input("Detail_mask_2_map_input", 2D) = "white" {}
		_Edge_mask_map_input("Edge_mask_map_input", 2D) = "white" {}
		_Emmisive_mask_map_input("Emmisive_mask_map_input", 2D) = "white" {}
		_Alpha_cutout_mask_map_input("Alpha_cutout_mask_map_input", 2D) = "white" {}
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
			#define _AlphaClip 1
			#pragma shader_feature _METALOBJECTUSESMETTALICSMOOTHNESMAP_ON

			uniform sampler2D _Albedo_smoothness_map_input;
			uniform float2 _Material_Tiling;
			uniform float4 _Base_color;
			uniform sampler2D _Detail_mask_1_map_input;
			uniform float4 _Detail_mask_1_map_input_ST;
			uniform float _Detail_level;
			uniform float4 _Detail_color;
			uniform sampler2D _Detail_mask_2_map_input;
			uniform float4 _Detail_mask_2_map_input_ST;
			uniform float _Detail_2_level;
			uniform float4 _Detail_2_color;
			uniform sampler2D _Edge_mask_map_input;
			uniform float4 _Edge_mask_map_input_ST;
			uniform float _Edge_wear;
			uniform sampler2D _Ambient_Occlusion_map_input;
			uniform float4 _Ambient_Occlusion_map_input_ST;
			uniform float _AO_shift;
			uniform float _Normal_intensity;
			uniform sampler2D _Normal_map_input;
			uniform sampler2D _Emmisive_mask_map_input;
			uniform float4 _Emmisive_mask_map_input_ST;
			uniform float4 _Emmsivie_color;
			uniform float _Emmisive_intensity;
			uniform sampler2D _Metallic_Smoothness_map_input;
			uniform float _Mettallic_shift;
			uniform float _Material_Smoothness_shift;
			uniform float _Detail_Smoothness_shift;
			uniform sampler2D _Alpha_cutout_mask_map_input;
			uniform float4 _Alpha_cutout_mask_map_input_ST;
			uniform float _Alpha_cutout_level;
					
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

				float2 uv73 = IN.ase_texcoord7.xy * _Material_Tiling + float2( 0,0 );
				float2 _tiling100 = uv73;
				float4 tex2DNode11 = tex2D( _Albedo_smoothness_map_input, _tiling100 );
				float4 blendOpSrc12 = tex2DNode11;
				float4 blendOpDest12 = _Base_color;
				float2 uv_Detail_mask_1_map_input = IN.ase_texcoord7.xy * _Detail_mask_1_map_input_ST.xy + _Detail_mask_1_map_input_ST.zw;
				float4 temp_output_36_0 = ( tex2D( _Detail_mask_1_map_input, uv_Detail_mask_1_map_input ) * _Detail_level );
				float4 blendOpSrc35 = temp_output_36_0;
				float4 blendOpDest35 = _Detail_color;
				float4 lerpResult46 = lerp( ( saturate( (( blendOpDest12 > 0.5 ) ? ( 1.0 - ( 1.0 - 2.0 * ( blendOpDest12 - 0.5 ) ) * ( 1.0 - blendOpSrc12 ) ) : ( 2.0 * blendOpDest12 * blendOpSrc12 ) ) )) , ( saturate( ( blendOpSrc35 + blendOpDest35 - 1.0 ) )) , temp_output_36_0.r);
				float2 uv_Detail_mask_2_map_input = IN.ase_texcoord7.xy * _Detail_mask_2_map_input_ST.xy + _Detail_mask_2_map_input_ST.zw;
				float4 temp_output_97_0 = ( tex2D( _Detail_mask_2_map_input, uv_Detail_mask_2_map_input ) * _Detail_2_level );
				float4 blendOpSrc98 = temp_output_97_0;
				float4 blendOpDest98 = _Detail_2_color;
				float4 lerpResult99 = lerp( lerpResult46 , ( saturate( ( blendOpSrc98 + blendOpDest98 - 1.0 ) )) , temp_output_97_0.r);
				float2 uv_Edge_mask_map_input = IN.ase_texcoord7.xy * _Edge_mask_map_input_ST.xy + _Edge_mask_map_input_ST.zw;
				float4 lerpResult70 = lerp( lerpResult99 , float4(1,1,1,0) , ( tex2D( _Edge_mask_map_input, uv_Edge_mask_map_input ) * _Edge_wear ).r);
				float4 blendOpSrc71 = lerpResult99;
				float4 blendOpDest71 = lerpResult70;
				float4 temp_output_71_0 = ( saturate( (( blendOpSrc71 > 0.5 ) ? max( blendOpDest71, 2.0 * ( blendOpSrc71 - 0.5 ) ) : min( blendOpDest71, 2.0 * blendOpSrc71 ) ) ));
				float2 uv_Ambient_Occlusion_map_input = IN.ase_texcoord7.xy * _Ambient_Occlusion_map_input_ST.xy + _Ambient_Occlusion_map_input_ST.zw;
				float4 _AO118 = tex2D( _Ambient_Occlusion_map_input, uv_Ambient_Occlusion_map_input );
				float4 blendOpSrc80 = float4(1,1,1,0);
				float4 blendOpDest80 = _AO118;
				float4 lerpResult78 = lerp( temp_output_71_0 , float4(0,0,0,0) , ( ( saturate( abs( blendOpSrc80 - blendOpDest80 ) )) * _AO_shift ).r);
				float4 blendOpSrc79 = temp_output_71_0;
				float4 blendOpDest79 = lerpResult78;
				float4 _albedo122 = ( saturate( min( blendOpSrc79 , blendOpDest79 ) ));
				
				float3 _normalmap124 = UnpackNormalScale( tex2D( _Normal_map_input, _tiling100 ) ,_Normal_intensity );
				
				float2 uv_Emmisive_mask_map_input = IN.ase_texcoord7.xy * _Emmisive_mask_map_input_ST.xy + _Emmisive_mask_map_input_ST.zw;
				float4 _emmisive116 = ( ( tex2D( _Emmisive_mask_map_input, uv_Emmisive_mask_map_input ) * _Emmsivie_color ) * _Emmisive_intensity );
				
				float4 tex2DNode9 = tex2D( _Metallic_Smoothness_map_input, _tiling100 );
				float4 _metallic126 = ( tex2DNode9 * _Mettallic_shift );
				
				#ifdef _METALOBJECTUSESMETTALICSMOOTHNESMAP_ON
				float staticSwitch132 = ( tex2DNode9.a * _Material_Smoothness_shift );
				#else
				float staticSwitch132 = ( tex2DNode11.a * _Material_Smoothness_shift );
				#endif
				float4 temp_cast_7 = (staticSwitch132).xxxx;
				float4 blendOpSrc43 = temp_cast_7;
				float4 blendOpDest43 = ( temp_output_36_0 * _Detail_Smoothness_shift );
				float4 _smoothness127 = ( saturate( ( 1.0 - ( 1.0 - blendOpSrc43 ) * ( 1.0 - blendOpDest43 ) ) ));
				
				float2 uv_Alpha_cutout_mask_map_input = IN.ase_texcoord7.xy * _Alpha_cutout_mask_map_input_ST.xy + _Alpha_cutout_mask_map_input_ST.zw;
				float4 _alpha114 = ( tex2D( _Alpha_cutout_mask_map_input, uv_Alpha_cutout_mask_map_input ) * _Alpha_cutout_level );
				
				
		        float3 Albedo = _albedo122.rgb;
				float3 Normal = _normalmap124;
				float3 Emission = _emmisive116.rgb;
				float3 Specular = float3(0.5, 0.5, 0.5);
				float Metallic = _metallic126.r;
				float Smoothness = _smoothness127.r;
				float Occlusion = _AO118.r;
				float Alpha = _alpha114.r;
				float AlphaClipThreshold = 0.5;
		
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
			#define _AlphaClip 1

			uniform float4 _ShadowBias;
			uniform float3 _LightDirection;
			uniform sampler2D _Alpha_cutout_mask_map_input;
			uniform float4 _Alpha_cutout_mask_map_input_ST;
			uniform float _Alpha_cutout_level;
					
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

				float2 uv_Alpha_cutout_mask_map_input = IN.ase_texcoord7.xy * _Alpha_cutout_mask_map_input_ST.xy + _Alpha_cutout_mask_map_input_ST.zw;
				float4 _alpha114 = ( tex2D( _Alpha_cutout_mask_map_input, uv_Alpha_cutout_mask_map_input ) * _Alpha_cutout_level );
				

				float Alpha = _alpha114.r;
				float AlphaClipThreshold = 0.5;
				
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
			#define _AlphaClip 1

			uniform sampler2D _Alpha_cutout_mask_map_input;
			uniform float4 _Alpha_cutout_mask_map_input_ST;
			uniform float _Alpha_cutout_level;

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

				float2 uv_Alpha_cutout_mask_map_input = IN.ase_texcoord7.xy * _Alpha_cutout_mask_map_input_ST.xy + _Alpha_cutout_mask_map_input_ST.zw;
				float4 _alpha114 = ( tex2D( _Alpha_cutout_mask_map_input, uv_Alpha_cutout_mask_map_input ) * _Alpha_cutout_level );
				

				float Alpha = _alpha114.r;
				float AlphaClipThreshold = 0.5;
				
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
7;492;3426;901;14779.95;2917.46;3.15593;True;False
Node;AmplifyShaderEditor.CommentaryNode;104;-9648,-720;Float;False;856.3848;215.2771;Tiling;3;72;73;100;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;121;-9656.987,-1411.493;Float;False;4041.403;649.948;Albedo;5;112;111;106;105;107;;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector2Node;72;-9600,-672;Float;False;Property;_Material_Tiling;Material_Tiling;0;0;Create;True;0;0;False;0;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.CommentaryNode;105;-8893.155,-1361.493;Float;False;660.3844;558.4139;Detail_mask_1_map_input;6;46;35;36;34;37;5;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;73;-9328,-672;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;107;-9634.667,-1347.452;Float;False;712.6123;438.0623;Albedo_smoothness_map_input;4;4;12;11;101;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;101;-9615.265,-1100.868;Float;False;100;0;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;5;-8863.625,-1127.299;Float;True;Property;_Detail_mask_1_map_input;Detail_mask_1_map_input;20;0;Create;True;0;0;False;0;7a947e26d6355c94898b3bf52c6e07da;7a947e26d6355c94898b3bf52c6e07da;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;37;-8850.457,-920.043;Float;False;Property;_Detail_level;Detail_level;3;0;Create;True;0;0;False;0;0;0.66;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;106;-8205.706,-1360;Float;False;683.9615;522.174;Detail_mask_2_map_input;6;99;98;97;96;94;95;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;100;-9024,-640;Float;False;_tiling;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;95;-8189.706,-928;Float;False;Property;_Detail_2_level;Detail_2_level;5;0;Create;True;0;0;False;0;0;0.533;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;94;-8189.706,-1120;Float;True;Property;_Detail_mask_2_map_input;Detail_mask_2_map_input;21;0;Create;True;0;0;False;0;7a947e26d6355c94898b3bf52c6e07da;7a947e26d6355c94898b3bf52c6e07da;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;4;-9432.391,-1294.665;Float;False;Property;_Base_color;Base_color;1;0;Create;True;0;0;False;0;0.427451,0.227451,0.1372549,0;0.1985294,0.1985294,0.1985294,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;11;-9431.746,-1125.389;Float;True;Property;_Albedo_smoothness_map_input;Albedo_smoothness_map_input;16;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;36;-8561.967,-936.894;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;34;-8863.43,-1304.329;Float;False;Property;_Detail_color;Detail_color;2;0;Create;True;0;0;False;0;0,0.9779412,0.7756083,0;0.4307958,0.4617438,0.6102941,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BlendOpsNode;12;-9134.426,-1039.457;Float;False;Overlay;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;109;-9346.158,-466.3856;Float;False;546.7891;281.7903;Ambient_Occlusion_map_input;2;118;62;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ColorNode;96;-8173.706,-1312;Float;False;Property;_Detail_2_color;Detail_2_color;4;0;Create;True;0;0;False;0;0,0.9779412,0.7756083,0;0.397221,0.5889483,0.6838235,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;111;-7501.667,-1355.676;Float;False;712.2814;519.3632;Edge_mask_map_input;6;71;70;69;68;83;67;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;97;-7885.706,-944;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.BlendOpsNode;35;-8557.744,-1105.125;Float;False;LinearBurn;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;46;-8388.368,-962.2592;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;83;-7485.29,-1133.286;Float;True;Property;_Edge_mask_map_input;Edge_mask_map_input;22;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BlendOpsNode;98;-7869.706,-1136;Float;False;LinearBurn;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;62;-9317.159,-414.6369;Float;True;Property;_Ambient_Occlusion_map_input;Ambient_Occlusion_map_input;19;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;112;-6768,-1344;Float;False;933.3077;489.781;Albedo and AO blend;8;79;78;77;76;74;80;119;81;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;67;-7486.667,-930.1621;Float;False;Property;_Edge_wear;Edge_wear;10;0;Create;True;0;0;False;0;0;0.937;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;110;-8768,-720;Float;False;1322.75;524.5823;Metallic_Smoothness_map input;13;127;43;132;22;20;133;9;103;84;126;85;44;45;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;103;-8736,-432;Float;False;100;0;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;118;-9020.878,-409.1205;Float;False;_AO;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;81;-6720,-1264;Float;False;Constant;_Color0;Color 0;17;0;Create;True;0;0;False;0;1,1,1,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;119;-6720,-1088;Float;False;118;0;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;69;-7170.376,-947.4511;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;68;-7480.142,-1308.676;Float;False;Constant;_Color3;Color 3;1;0;Create;True;0;0;False;0;1,1,1,0;1,1,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;99;-7677.706,-976;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;74;-6704,-1008;Float;False;Property;_AO_shift;AO_shift;9;0;Create;True;0;0;False;0;0;2;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;22;-8416,-336;Float;False;Property;_Material_Smoothness_shift;Material_Smoothness_shift;7;0;Create;True;0;0;False;0;1;0.298;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;9;-8432,-544;Float;True;Property;_Metallic_Smoothness_map_input;Metallic_Smoothness_map_input;18;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;70;-7172.663,-1142.538;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;130;-7424.159,-711.7689;Float;False;754.9919;518.6198;Emmisive_mask_map_input;6;88;89;116;90;86;87;;1,1,1,1;0;0
Node;AmplifyShaderEditor.BlendOpsNode;80;-6512,-1248;Float;False;Difference;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;133;-8048,-544;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;45;-8736,-512;Float;False;Property;_Detail_Smoothness_shift;Detail_Smoothness_shift;8;0;Create;True;0;0;False;0;0;0.503;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;113;-7724.674,-153.3696;Float;False;730.368;344.2644;Alpha_cutout_mask_map_input;4;114;91;92;93;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ColorNode;86;-7397.535,-660.7678;Float;False;Property;_Emmsivie_color;Emmsivie_color;12;0;Create;True;0;0;False;0;0.9779412,0.9210103,0.6831207,0;0.9779412,0.6892203,0.6831207,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;108;-8768,-160;Float;False;998.8794;334;Normal_map_input;4;124;8;134;102;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;-8048,-432;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;87;-7404.159,-495.386;Float;True;Property;_Emmisive_mask_map_input;Emmisive_mask_map_input;23;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;77;-6288,-1264;Float;False;Constant;_Color4;Color 4;1;0;Create;True;0;0;False;0;0,0,0,0;1,1,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;76;-6448,-1136;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.BlendOpsNode;71;-7002.857,-956.7018;Float;False;PinLight;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;132;-7888,-544;Float;False;Property;_Metalobjectusesmettalicsmoothnesmap;Metal object uses mettalic smoothnes map?;15;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;102;-8608,-80;Float;False;100;0;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;89;-7403.807,-296.1508;Float;False;Property;_Emmisive_intensity;Emmisive_intensity;13;0;Create;True;0;0;False;0;0;0;0;50;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;134;-8704,48;Float;False;Property;_Normal_intensity;Normal_intensity;6;0;Create;True;0;0;False;0;1;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;93;-7674.674,-103.3696;Float;True;Property;_Alpha_cutout_mask_map_input;Alpha_cutout_mask_map_input;24;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;85;-8320,-656;Float;False;Property;_Mettallic_shift;Mettallic_shift;11;0;Create;True;0;0;False;0;0;0.12;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;88;-7112.653,-630.3919;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;92;-7652.717,90.9576;Float;False;Property;_Alpha_cutout_level;Alpha_cutout_level;14;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;44;-8464,-656;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;78;-6240,-1056;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;91;-7362.286,-99.98066;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;90;-7039.796,-464.702;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;8;-8400,-112;Float;True;Property;_Normal_map_input;Normal_map_input;17;0;Create;True;0;0;False;0;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BlendOpsNode;79;-6048,-1024;Float;False;Darken;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;84;-8048,-656;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.BlendOpsNode;43;-7888,-400;Float;False;Screen;True;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;128;-6528,-384;Float;False;126;0;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;117;-6528,-448;Float;False;116;0;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;123;-6528,-576;Float;False;122;0;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;129;-6528,-320;Float;False;127;0;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;138;-6560.448,-66.51318;Float;False;Constant;_Float0;Float 0;26;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;120;-6528,-256;Float;False;118;0;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;115;-6528,-192;Float;False;114;0;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;126;-7872,-656;Float;False;_metallic;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;116;-6875.167,-455.3629;Float;False;_emmisive;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;127;-7659.666,-384.8863;Float;False;_smoothness;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;114;-7215.665,-104.6926;Float;False;_alpha;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;125;-6528,-512;Float;False;124;0;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;122;-5804.7,-1015.408;Float;False;_albedo;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;124;-7984,32;Float;False;_normalmap;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;137;-6272,-576;Float;False;False;2;Float;ASEMaterialInspector;0;1;ASETemplateShaders/LightWeight;1976390536c6c564abb90fe41f6ee334;0;2;DepthOnly;0;False;False;True;0;False;-1;False;False;False;False;False;True;3;RenderPipeline=LightweightPipeline;RenderType=Opaque;Queue=Geometry;True;2;0;0;0;False;False;True;0;False;-1;True;False;False;False;False;0;False;-1;False;True;1;False;-1;False;False;True;1;LightMode=DepthOnly;False;0;0;0;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;135;-6272,-576;Float;False;True;2;Float;ASEMaterialInspector;0;1;beffio/Medieval_Kingdom/SRP/Lightweight/BaseShader;1976390536c6c564abb90fe41f6ee334;0;0;Base;10;False;False;True;0;False;-1;False;False;False;False;False;True;3;RenderPipeline=LightweightPipeline;RenderType=Opaque;Queue=Geometry;True;2;0;0;0;True;1;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;False;True;0;False;-1;True;True;True;True;True;0;False;-1;False;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;1;LightMode=LightweightForward;False;0;0;0;10;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;9;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;136;-6272,-576;Float;False;False;2;Float;ASEMaterialInspector;0;1;ASETemplateShaders/LightWeight;1976390536c6c564abb90fe41f6ee334;0;1;ShadowCaster;0;False;False;True;0;False;-1;False;False;False;False;False;True;3;RenderPipeline=LightweightPipeline;RenderType=Opaque;Queue=Geometry;True;2;0;0;0;False;False;False;False;False;True;1;False;-1;True;3;False;-1;False;True;1;LightMode=ShadowCaster;False;0;0;0;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;0
WireConnection;73;0;72;0
WireConnection;100;0;73;0
WireConnection;11;1;101;0
WireConnection;36;0;5;0
WireConnection;36;1;37;0
WireConnection;12;0;11;0
WireConnection;12;1;4;0
WireConnection;97;0;94;0
WireConnection;97;1;95;0
WireConnection;35;0;36;0
WireConnection;35;1;34;0
WireConnection;46;0;12;0
WireConnection;46;1;35;0
WireConnection;46;2;36;0
WireConnection;98;0;97;0
WireConnection;98;1;96;0
WireConnection;118;0;62;0
WireConnection;69;0;83;0
WireConnection;69;1;67;0
WireConnection;99;0;46;0
WireConnection;99;1;98;0
WireConnection;99;2;97;0
WireConnection;9;1;103;0
WireConnection;70;0;99;0
WireConnection;70;1;68;0
WireConnection;70;2;69;0
WireConnection;80;0;81;0
WireConnection;80;1;119;0
WireConnection;133;0;11;4
WireConnection;133;1;22;0
WireConnection;20;0;9;4
WireConnection;20;1;22;0
WireConnection;76;0;80;0
WireConnection;76;1;74;0
WireConnection;71;0;99;0
WireConnection;71;1;70;0
WireConnection;132;1;133;0
WireConnection;132;0;20;0
WireConnection;88;0;87;0
WireConnection;88;1;86;0
WireConnection;44;0;36;0
WireConnection;44;1;45;0
WireConnection;78;0;71;0
WireConnection;78;1;77;0
WireConnection;78;2;76;0
WireConnection;91;0;93;0
WireConnection;91;1;92;0
WireConnection;90;0;88;0
WireConnection;90;1;89;0
WireConnection;8;1;102;0
WireConnection;8;5;134;0
WireConnection;79;0;71;0
WireConnection;79;1;78;0
WireConnection;84;0;9;0
WireConnection;84;1;85;0
WireConnection;43;0;132;0
WireConnection;43;1;44;0
WireConnection;126;0;84;0
WireConnection;116;0;90;0
WireConnection;127;0;43;0
WireConnection;114;0;91;0
WireConnection;122;0;79;0
WireConnection;124;0;8;0
WireConnection;135;0;123;0
WireConnection;135;1;125;0
WireConnection;135;2;117;0
WireConnection;135;3;128;0
WireConnection;135;4;129;0
WireConnection;135;5;120;0
WireConnection;135;6;115;0
WireConnection;135;7;138;0
ASEEND*/
//CHKSM=F274C32121433845066CE8988354C3D76F5F401B