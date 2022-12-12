// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "beffio/Medieval_Kingdom/SRP/Lightweight/Vegetation"
{
	Properties
	{
		_Base_Color("Base_Color", Color) = (0.3529412,0.5450981,0.2235294,0)
		_Smoothness_Shift("Smoothness_Shift", Range( 0 , 2)) = 1
		_2nd_color("2nd_color", Color) = (1,1,1,0)
		_2nd_color_intensity("2nd_color_intensity", Range( 0 , 1.5)) = 1.5
		_AO_Intensity("AO_Intensity", Range( 0 , 2)) = 1
		_Wind_speed("Wind_speed", Range( 0 , 10)) = 1
		_Wind_power_multiply("Wind_power_multiply", Range( 0 , 0.2)) = 0.15
		_Albedo_map_input("Albedo_map_input", 2D) = "white" {}
		_2nd_color_mask_input("2nd_color_mask_input", 2D) = "white" {}
		_Ambient_Occlusion_map_input("Ambient_Occlusion_map_input", 2D) = "white" {}
		_Alpha_cutout_mask_map_input("Alpha_cutout_mask_map_input", 2D) = "white" {}
		_Wind_noise("Wind_noise", 2D) = "white" {}
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
			#define _AlphaClip 1

			uniform sampler2D _Wind_noise;
			uniform float _Wind_speed;
			uniform float _Wind_power_multiply;
			uniform sampler2D _Albedo_map_input;
			uniform float4 _Albedo_map_input_ST;
			uniform float4 _Base_Color;
			uniform float4 _2nd_color;
			uniform sampler2D _2nd_color_mask_input;
			uniform float4 _2nd_color_mask_input_ST;
			uniform float _2nd_color_intensity;
			uniform sampler2D _Ambient_Occlusion_map_input;
			uniform float4 _Ambient_Occlusion_map_input_ST;
			uniform float _AO_Intensity;
			uniform float _Smoothness_Shift;
			uniform sampler2D _Alpha_cutout_mask_map_input;
			uniform float4 _Alpha_cutout_mask_map_input_ST;
					
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

				float2 uv313 = v.ase_texcoord * float2( 1,1 ) + float2( 0,0 );
				float2 panner315 = ( ( _Time.x * _Wind_speed ) * float2( 0.5,0.5 ) + uv313);
				float4 _wind343 = ( tex2Dlod( _Wind_noise, float4( panner315, 0, 0.0) ) * _Wind_power_multiply );
				
				o.ase_texcoord7.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord7.zw = 0;
				v.vertex.xyz += _wind343.rgb;
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

				float2 uv_Albedo_map_input = IN.ase_texcoord7.xy * _Albedo_map_input_ST.xy + _Albedo_map_input_ST.zw;
				float4 tex2DNode273 = tex2D( _Albedo_map_input, uv_Albedo_map_input );
				float4 blendOpSrc95 = tex2DNode273;
				float4 blendOpDest95 = _Base_Color;
				float4 temp_output_95_0 = ( saturate( ( blendOpSrc95 * blendOpDest95 ) ));
				float2 uv_2nd_color_mask_input = IN.ase_texcoord7.xy * _2nd_color_mask_input_ST.xy + _2nd_color_mask_input_ST.zw;
				float4 lerpResult241 = lerp( temp_output_95_0 , _2nd_color , ( tex2D( _2nd_color_mask_input, uv_2nd_color_mask_input ) * ( float4(1,1,1,0) * _2nd_color_intensity ) ).r);
				float4 blendOpSrc243 = temp_output_95_0;
				float4 blendOpDest243 = lerpResult241;
				float4 temp_output_243_0 = ( saturate( (( blendOpDest243 > 0.5 ) ? ( 1.0 - ( 1.0 - 2.0 * ( blendOpDest243 - 0.5 ) ) * ( 1.0 - blendOpSrc243 ) ) : ( 2.0 * blendOpDest243 * blendOpSrc243 ) ) ));
				float2 uv_Ambient_Occlusion_map_input = IN.ase_texcoord7.xy * _Ambient_Occlusion_map_input_ST.xy + _Ambient_Occlusion_map_input_ST.zw;
				float4 _AO336 = tex2D( _Ambient_Occlusion_map_input, uv_Ambient_Occlusion_map_input );
				float4 blendOpSrc327 = float4(1,1,1,0);
				float4 blendOpDest327 = _AO336;
				float4 lerpResult324 = lerp( temp_output_243_0 , float4(0,0,0,0) , ( ( saturate( abs( blendOpSrc327 - blendOpDest327 ) )) * _AO_Intensity ).r);
				float4 blendOpSrc325 = temp_output_243_0;
				float4 blendOpDest325 = lerpResult324;
				float4 _albedo345 = ( saturate( min( blendOpSrc325 , blendOpDest325 ) ));
				
				float4 _smoothness339 = ( tex2DNode273 * _Smoothness_Shift );
				
				float2 uv_Alpha_cutout_mask_map_input = IN.ase_texcoord7.xy * _Alpha_cutout_mask_map_input_ST.xy + _Alpha_cutout_mask_map_input_ST.zw;
				float4 _alpha341 = tex2D( _Alpha_cutout_mask_map_input, uv_Alpha_cutout_mask_map_input );
				
				
		        float3 Albedo = _albedo345.rgb;
				float3 Normal = float3(0, 0, 1);
				float3 Emission = 0;
				float3 Specular = float3(0.5, 0.5, 0.5);
				float Metallic = 0.0;
				float Smoothness = _smoothness339.r;
				float Occlusion = _AO336.r;
				float Alpha = _alpha341.r;
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
			uniform sampler2D _Wind_noise;
			uniform float _Wind_speed;
			uniform float _Wind_power_multiply;
			uniform sampler2D _Alpha_cutout_mask_map_input;
			uniform float4 _Alpha_cutout_mask_map_input_ST;
					
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

				float2 uv313 = v.ase_texcoord * float2( 1,1 ) + float2( 0,0 );
				float2 panner315 = ( ( _Time.x * _Wind_speed ) * float2( 0.5,0.5 ) + uv313);
				float4 _wind343 = ( tex2Dlod( _Wind_noise, float4( panner315, 0, 0.0) ) * _Wind_power_multiply );
				
				o.ase_texcoord7.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord7.zw = 0;

				v.vertex.xyz += _wind343.rgb;

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
				float4 _alpha341 = tex2D( _Alpha_cutout_mask_map_input, uv_Alpha_cutout_mask_map_input );
				

				float Alpha = _alpha341.r;
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

			uniform sampler2D _Wind_noise;
			uniform float _Wind_speed;
			uniform float _Wind_power_multiply;
			uniform sampler2D _Alpha_cutout_mask_map_input;
			uniform float4 _Alpha_cutout_mask_map_input_ST;

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

				float2 uv313 = v.ase_texcoord * float2( 1,1 ) + float2( 0,0 );
				float2 panner315 = ( ( _Time.x * _Wind_speed ) * float2( 0.5,0.5 ) + uv313);
				float4 _wind343 = ( tex2Dlod( _Wind_noise, float4( panner315, 0, 0.0) ) * _Wind_power_multiply );
				
				o.ase_texcoord7.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord7.zw = 0;

				v.vertex.xyz += _wind343.rgb;
				o.clipPos = TransformObjectToHClip(v.vertex.xyz);
				return o;
			}

			half4 frag (GraphVertexOutput IN ) : SV_Target
		    {
		    	UNITY_SETUP_INSTANCE_ID(IN);

				float2 uv_Alpha_cutout_mask_map_input = IN.ase_texcoord7.xy * _Alpha_cutout_mask_map_input_ST.xy + _Alpha_cutout_mask_map_input_ST.zw;
				float4 _alpha341 = tex2D( _Alpha_cutout_mask_map_input, uv_Alpha_cutout_mask_map_input );
				

				float Alpha = _alpha341.r;
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
7;364;3426;901;316.5162;-80.07986;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;334;-993,383;Float;False;910.1047;648.5859;2nd_color_mask_input;8;242;243;266;277;268;241;265;267;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;267;-968,934;Float;False;Property;_2nd_color_intensity;2nd_color_intensity;3;0;Create;True;0;0;False;0;1.5;1.5;0;1.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;265;-952,774;Float;False;Constant;_Color1;Color 1;8;0;Create;True;0;0;False;0;1,1,1,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;333;-1568,304;Float;False;541.0299;442.3094;Albedo_map_input;3;95;273;89;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;330;-639.8638,93.2566;Float;False;624;285;Ambient_Occlusion_map_input;2;336;278;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;277;-967,593;Float;True;Property;_2nd_color_mask_input;2nd_color_mask_input;8;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;268;-656,916;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;273;-1520,528;Float;True;Property;_Albedo_map_input;Albedo_map_input;7;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;89;-1520,368;Float;False;Property;_Base_Color;Base_Color;0;0;Create;True;0;0;False;0;0.3529412,0.5450981,0.2235294,0;0.850876,1,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;335;27,517;Float;False;1043.48;517.0767;AO_diff_blend;9;345;325;324;323;322;327;326;338;328;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;278;-607.8638,157.2565;Float;True;Property;_Ambient_Occlusion_map_input;Ambient_Occlusion_map_input;9;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;332;41.82613,0.6857758;Float;False;1073.92;491.0011;Wind;10;343;318;316;319;321;312;315;311;314;313;;1,1,1,1;0;0
Node;AmplifyShaderEditor.BlendOpsNode;95;-1264,368;Float;False;Multiply;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;266;-625.3877,656;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;321;57.82614,416.6859;Float;False;Property;_Wind_speed;Wind_speed;5;0;Create;True;0;0;False;0;1;2;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.TimeNode;311;57.82614,272.6859;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;336;-239.8634,205.2565;Float;False;_AO;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;338;75,773;Float;False;336;0;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;328;75,565;Float;False;Constant;_Color2;Color 2;17;0;Create;True;0;0;False;0;1,1,1,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;242;-967,434;Float;False;Property;_2nd_color;2nd_color;2;0;Create;True;0;0;False;0;1,1,1,0;1,0,0,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;313;57.82614,48.68583;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;241;-483,906;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector2Node;314;57.82614,160.6858;Float;False;Constant;_Vector0;Vector 0;10;0;Create;True;0;0;False;0;0.5,0.5;0.5,0.5;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;312;297.8262,240.6859;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;326;59,885;Float;False;Property;_AO_Intensity;AO_Intensity;4;0;Create;True;0;0;False;0;1;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.BlendOpsNode;327;331,741;Float;False;Difference;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.PannerNode;315;297.8262,48.68583;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;323;403,890;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;322;337,574;Float;False;Constant;_Color0;Color 0;1;0;Create;True;0;0;False;0;0,0,0,0;1,1,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BlendOpsNode;243;-299,910;Float;False;Overlay;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;329;-1375.243,73.33742;Float;False;688.797;183;Smoothness;3;339;281;282;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;316;345.8262,352.6859;Float;False;Property;_Wind_power_multiply;Wind_power_multiply;6;0;Create;True;0;0;False;0;0.15;0.15;0;0.2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;319;473.8262,48.68583;Float;True;Property;_Wind_noise;Wind_noise;11;0;Create;True;0;0;False;0;4ee6590d155bdcb4db3ce5ff5f0f13ec;4ee6590d155bdcb4db3ce5ff5f0f13ec;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;282;-1362.243,136.3375;Float;False;Property;_Smoothness_Shift;Smoothness_Shift;1;0;Create;True;0;0;False;0;1;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;331;-1712,800;Float;False;684.9999;300;Alpha_cutout_mask_map_input;2;341;276;;1,1,1,1;0;0
Node;AmplifyShaderEditor.LerpOp;324;569,674;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;281;-1062.243,119.3375;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.BlendOpsNode;325;608,888;Float;False;Darken;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;276;-1664,848;Float;True;Property;_Alpha_cutout_mask_map_input;Alpha_cutout_mask_map_input;10;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;318;745.8261,240.6859;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;340;1087.425,671.4858;Float;False;339;0;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;344;1119.425,959.4856;Float;False;343;0;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;346;1119.425,543.4857;Float;False;345;0;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;351;1373.865,517.7511;Float;False;Constant;_Float1;Float 1;13;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;350;1109.425,1063.741;Float;False;Constant;_Float0;Float 0;13;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;337;1119.425,767.4858;Float;False;336;0;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;339;-916.2421,128.3375;Float;False;_smoothness;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;343;889.8261,256.6859;Float;False;_wind;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;341;-1280,960;Float;False;_alpha;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;342;1119.425,863.4857;Float;False;341;0;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;345;848.6379,903.9327;Float;False;_albedo;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;348;1697,586;Float;False;False;2;Float;ASEMaterialInspector;0;1;ASETemplateShaders/LightWeight;1976390536c6c564abb90fe41f6ee334;0;1;ShadowCaster;0;False;False;True;0;False;-1;False;False;False;False;False;True;3;RenderPipeline=LightweightPipeline;RenderType=Opaque;Queue=Geometry;True;2;0;0;0;False;False;False;False;False;True;1;False;-1;True;3;False;-1;False;True;1;LightMode=ShadowCaster;False;0;0;0;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;347;1697,586;Float;False;True;2;Float;ASEMaterialInspector;0;1;beffio/Medieval_Kingdom/SRP/Lightweight/Vegetation;1976390536c6c564abb90fe41f6ee334;0;0;Base;10;False;False;True;0;False;-1;False;False;False;False;False;True;3;RenderPipeline=LightweightPipeline;RenderType=Opaque;Queue=Geometry;True;2;0;0;0;True;1;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;False;True;0;False;-1;True;True;True;True;True;0;False;-1;False;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;1;LightMode=LightweightForward;False;0;0;0;10;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;9;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;349;1697,586;Float;False;False;2;Float;ASEMaterialInspector;0;1;ASETemplateShaders/LightWeight;1976390536c6c564abb90fe41f6ee334;0;2;DepthOnly;0;False;False;True;0;False;-1;False;False;False;False;False;True;3;RenderPipeline=LightweightPipeline;RenderType=Opaque;Queue=Geometry;True;2;0;0;0;False;False;True;0;False;-1;True;False;False;False;False;0;False;-1;False;True;1;False;-1;False;False;True;1;LightMode=DepthOnly;False;0;0;0;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;0
WireConnection;268;0;265;0
WireConnection;268;1;267;0
WireConnection;95;0;273;0
WireConnection;95;1;89;0
WireConnection;266;0;277;0
WireConnection;266;1;268;0
WireConnection;336;0;278;0
WireConnection;241;0;95;0
WireConnection;241;1;242;0
WireConnection;241;2;266;0
WireConnection;312;0;311;1
WireConnection;312;1;321;0
WireConnection;327;0;328;0
WireConnection;327;1;338;0
WireConnection;315;0;313;0
WireConnection;315;2;314;0
WireConnection;315;1;312;0
WireConnection;323;0;327;0
WireConnection;323;1;326;0
WireConnection;243;0;95;0
WireConnection;243;1;241;0
WireConnection;319;1;315;0
WireConnection;324;0;243;0
WireConnection;324;1;322;0
WireConnection;324;2;323;0
WireConnection;281;0;273;0
WireConnection;281;1;282;0
WireConnection;325;0;243;0
WireConnection;325;1;324;0
WireConnection;318;0;319;0
WireConnection;318;1;316;0
WireConnection;339;0;281;0
WireConnection;343;0;318;0
WireConnection;341;0;276;0
WireConnection;345;0;325;0
WireConnection;347;0;346;0
WireConnection;347;3;351;0
WireConnection;347;4;340;0
WireConnection;347;5;337;0
WireConnection;347;6;342;0
WireConnection;347;7;350;0
WireConnection;347;8;344;0
ASEEND*/
//CHKSM=C4A89E78510ACECA0705E4FC26F55FC0EFC87F0F