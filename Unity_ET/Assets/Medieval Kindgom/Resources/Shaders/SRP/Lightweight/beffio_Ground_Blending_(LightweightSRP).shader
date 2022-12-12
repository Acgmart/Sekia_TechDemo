// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "beffio/Medieval_Kingdom/SRP/Lightweight/GroundBlending"
{
	Properties
	{
		_ColorshiftBlackChannel("Color shift(Black Channel)", Color) = (1,1,1,0)
		_ColorshiftRedChannel("Color shift(Red Channel)", Color) = (1,1,1,0)
		_ColorshiftGreenChannel0("Color shift(Green Channel) 0", Color) = (1,1,1,0)
		_ColorshiftAlphaChannel("Color shift (Alpha Channel)", Color) = (1,1,1,0)
		_SmoothnessshiftBlackchannel("Smoothness shift (Black channel)", Range( 0 , 4)) = 1
		_SmoothnessshiftRedChannel("Smoothness shift (Red Channel)", Range( 0 , 4)) = 1
		_SmoothnessshiftGreenChannel("Smoothness shift (Green Channel)", Range( 0 , 4)) = 1
		_SmoothnessshiftAlphaChannel("Smoothness shift (Alpha Channel)", Range( 0 , 4)) = 1
		_Wetness_color("Wetness_color", Color) = (1,1,1,0)
		_TilingBlack("Tiling Black", Range( 1 , 100)) = 10
		_TilingRed("Tiling Red", Range( 1 , 100)) = 10
		_TilingGreen("Tiling Green", Range( 1 , 100)) = 10
		_TilingAlpha("Tiling Alpha", Range( 1 , 100)) = 10
		_ParallaxStrength("Parallax Strength", Range( 0 , 0.2)) = 0
		_BlendingstrengthRed("Blending strength (Red)", Range( 0 , 10)) = 5
		_BlendingStrengthGreen("Blending Strength (Green)", Range( 0 , 10)) = 5
		_BlendingStrengthAlpha("Blending Strength (Alpha)", Range( 0 , 10)) = 5
		_NormalmapstrengthBlack("Normal map strength (Black)", Range( 0 , 10)) = 1
		_NormalmapstrengthRed("Normal map strength (Red)", Range( 0 , 10)) = 1
		_NormalmapstrengthGreen("Normal map strength (Green)", Range( 0 , 10)) = 1
		_NormalmapstrengthAlpha("Normal map strength (Alpha)", Range( 0 , 10)) = 1
		_DiffuseBlackChannel("Diffuse (Black Channel)", 2D) = "white" {}
		_NormalBlackChannel("Normal (Black Channel)", 2D) = "bump" {}
		_HeightBlackChannel("Height (Black Channel)", 2D) = "white" {}
		_DiffuseRedChannel("Diffuse (Red Channel)", 2D) = "white" {}
		_NormalRedChannel("Normal (Red Channel)", 2D) = "bump" {}
		_HeightRedChannel("Height (Red Channel)", 2D) = "white" {}
		_DiffuseGreenChannel("Diffuse (Green Channel)", 2D) = "white" {}
		_NormalGreenChannel("Normal (Green Channel)", 2D) = "bump" {}
		_HeightGreenchannel("Height (Green channel)", 2D) = "white" {}
		_DiffuseAlphaChannel("Diffuse (Alpha Channel)", 2D) = "white" {}
		_NormalAlphaChannel("Normal (Alpha Channel)", 2D) = "bump" {}
		_HeightAlphachannel("Height (Alpha channel)", 2D) = "white" {}
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

			uniform sampler2D _DiffuseBlackChannel;
			uniform float _TilingBlack;
			uniform sampler2D _HeightBlackChannel;
			uniform float _ParallaxStrength;
			uniform float4 _ColorshiftBlackChannel;
			uniform sampler2D _DiffuseRedChannel;
			uniform float _TilingRed;
			uniform sampler2D _HeightRedChannel;
			uniform float4 _ColorshiftRedChannel;
			uniform float _BlendingstrengthRed;
			uniform sampler2D _DiffuseGreenChannel;
			uniform float _TilingGreen;
			uniform sampler2D _HeightGreenchannel;
			uniform float4 _ColorshiftGreenChannel0;
			uniform float _BlendingStrengthGreen;
			uniform sampler2D _DiffuseAlphaChannel;
			uniform float _TilingAlpha;
			uniform sampler2D _HeightAlphachannel;
			uniform float4 _ColorshiftAlphaChannel;
			uniform float _BlendingStrengthAlpha;
			uniform float4 _Wetness_color;
			uniform float _NormalmapstrengthBlack;
			uniform sampler2D _NormalBlackChannel;
			uniform float _NormalmapstrengthRed;
			uniform sampler2D _NormalRedChannel;
			uniform float _NormalmapstrengthGreen;
			uniform sampler2D _NormalGreenChannel;
			uniform float _NormalmapstrengthAlpha;
			uniform sampler2D _NormalAlphaChannel;
			uniform float _SmoothnessshiftBlackchannel;
			uniform float _SmoothnessshiftRedChannel;
			uniform float _SmoothnessshiftGreenChannel;
			uniform float _SmoothnessshiftAlphaChannel;
					
			struct GraphVertexInput
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float4 tangent : TANGENT;
				float4 texcoord1 : TEXCOORD1;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_color : COLOR;
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
				float4 ase_color : COLOR;
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
				o.ase_color = v.ase_color;
				
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

				float2 temp_cast_0 = (_TilingBlack).xx;
				float2 uv215 = IN.ase_texcoord7.xy * temp_cast_0 + float2( 0,0 );
				float2 _tiling_black274 = uv215;
				float2 Offset223 = ( ( tex2D( _HeightBlackChannel, _tiling_black274 ).r - 1 ) * WorldSpaceViewDirection.xy * _ParallaxStrength ) + _tiling_black274;
				float2 _parallax_Black294 = Offset223;
				float4 tex2DNode211 = tex2D( _DiffuseBlackChannel, _parallax_Black294 );
				float2 temp_cast_2 = (_TilingRed).xx;
				float2 uv325 = IN.ase_texcoord7.xy * temp_cast_2 + float2( 0,0 );
				float2 _tiling_red324 = uv325;
				float4 tex2DNode216 = tex2D( _HeightRedChannel, _tiling_red324 );
				float2 Offset321 = ( ( tex2DNode216.r - 1 ) * WorldSpaceViewDirection.xy * _ParallaxStrength ) + _tiling_red324;
				float2 _parallax_Red319 = Offset321;
				float4 tex2DNode210 = tex2D( _DiffuseRedChannel, _parallax_Red319 );
				float _vertex_color_red281 = IN.ase_color.r;
				float HeightMask228 = saturate(pow(((tex2DNode216.r*_vertex_color_red281)*4)+(_vertex_color_red281*2),_BlendingstrengthRed));
				float4 lerpResult212 = lerp( ( tex2DNode211 * _ColorshiftBlackChannel ) , ( tex2DNode210 * _ColorshiftRedChannel ) , HeightMask228);
				float2 temp_cast_5 = (_TilingGreen).xx;
				float2 uv328 = IN.ase_texcoord7.xy * temp_cast_5 + float2( 0,0 );
				float2 _tiling_green327 = uv328;
				float4 tex2DNode242 = tex2D( _HeightGreenchannel, _tiling_green327 );
				float2 Offset322 = ( ( tex2DNode242.r - 1 ) * WorldSpaceViewDirection.xy * _ParallaxStrength ) + _tiling_green327;
				float2 _parallax_Green320 = Offset322;
				float4 tex2DNode243 = tex2D( _DiffuseGreenChannel, _parallax_Green320 );
				float _vertex_color_green282 = IN.ase_color.g;
				float HeightMask241 = saturate(pow(((tex2DNode242.r*_vertex_color_green282)*4)+(_vertex_color_green282*2),_BlendingStrengthGreen));
				float4 lerpResult240 = lerp( lerpResult212 , ( tex2DNode243 * _ColorshiftGreenChannel0 ) , HeightMask241);
				float2 temp_cast_8 = (_TilingAlpha).xx;
				float2 uv334 = IN.ase_texcoord7.xy * temp_cast_8 + float2( 0,0 );
				float2 _tiling_alpha335 = uv334;
				float4 tex2DNode337 = tex2D( _HeightAlphachannel, _tiling_alpha335 );
				float2 Offset336 = ( ( tex2DNode337.r - 1 ) * WorldSpaceViewDirection.xy * _ParallaxStrength ) + _tiling_alpha335;
				float2 _parallax_alpha340 = Offset336;
				float4 tex2DNode349 = tex2D( _DiffuseAlphaChannel, _parallax_alpha340 );
				float _vertex_color_alpha332 = IN.ase_color.a;
				float HeightMask342 = saturate(pow(((tex2DNode337.r*_vertex_color_alpha332)*4)+(_vertex_color_alpha332*2),_BlendingStrengthAlpha));
				float4 lerpResult345 = lerp( lerpResult240 , ( tex2DNode349 * _ColorshiftAlphaChannel ) , HeightMask342);
				float4 lerpResult273 = lerp( lerpResult345 , ( lerpResult345 * _Wetness_color ) , _vertex_color_green282);
				float4 _albedo306 = lerpResult273;
				
				float3 lerpResult233 = lerp( UnpackNormalScale( tex2D( _NormalBlackChannel, _parallax_Black294 ) ,_NormalmapstrengthBlack ) , UnpackNormalScale( tex2D( _NormalRedChannel, _parallax_Red319 ) ,_NormalmapstrengthRed ) , HeightMask228);
				float3 lerpResult247 = lerp( lerpResult233 , UnpackNormalScale( tex2D( _NormalGreenChannel, _parallax_Green320 ) ,_NormalmapstrengthGreen ) , HeightMask241);
				float3 lerpResult353 = lerp( lerpResult247 , UnpackNormalScale( tex2D( _NormalAlphaChannel, _parallax_alpha340 ) ,_NormalmapstrengthAlpha ) , HeightMask342);
				float3 _normal308 = lerpResult353;
				
				float lerpResult237 = lerp( ( tex2DNode211.a * _SmoothnessshiftBlackchannel ) , ( tex2DNode210.a * _SmoothnessshiftRedChannel ) , HeightMask228);
				float lerpResult249 = lerp( lerpResult237 , ( tex2DNode243.a * _SmoothnessshiftGreenChannel ) , HeightMask241);
				float lerpResult354 = lerp( lerpResult249 , ( tex2DNode349.a * _SmoothnessshiftAlphaChannel ) , HeightMask342);
				float _vertex_color_blue283 = IN.ase_color.b;
				float lerpResult263 = lerp( lerpResult354 , ( lerpResult354 * 4.0 ) , _vertex_color_blue283);
				float _smoothness312 = lerpResult263;
				
				
		        float3 Albedo = _albedo306.rgb;
				float3 Normal = _normal308;
				float3 Emission = 0;
				float3 Specular = float3(0.5, 0.5, 0.5);
				float Metallic = 0.0;
				float Smoothness = _smoothness312;
				float Occlusion = 1;
				float Alpha = 1;
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
				
			};

			GraphVertexOutput vert (GraphVertexInput v)
			{
				GraphVertexOutput o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				

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

				

				float Alpha = 1;
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
			
			
			struct GraphVertexInput
			{
				float4 vertex : POSITION;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				
			};

			struct GraphVertexOutput
			{
				float4 clipPos					: SV_POSITION;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				
			};

			GraphVertexOutput vert (GraphVertexInput v)
			{
				GraphVertexOutput o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				

				v.vertex.xyz +=  float3(0,0,0) ;
				o.clipPos = TransformObjectToHClip(v.vertex.xyz);
				return o;
			}

			half4 frag (GraphVertexOutput IN ) : SV_Target
		    {
		    	UNITY_SETUP_INSTANCE_ID(IN);

				

				float Alpha = 1;
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
88;320;3426;901;4241.328;131.3629;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;280;-4146.523,393.1316;Float;False;883.3745;741.9128;Tiling;12;335;327;334;324;333;274;328;329;215;325;326;214;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;326;-4120.145,566.8835;Float;False;Property;_TilingRed;Tiling Red;10;0;Create;True;0;0;False;0;10;10;1;100;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;214;-4126.329,436.2444;Float;False;Property;_TilingBlack;Tiling Black;9;0;Create;True;0;0;False;0;10;31.7;1;100;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;329;-4123.817,694.3703;Float;False;Property;_TilingGreen;Tiling Green;11;0;Create;True;0;0;False;0;10;10;1;100;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;215;-3834.08,437.7425;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;325;-3827.895,568.3816;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;324;-3575.845,608.7705;Float;False;_tiling_red;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;276;-6397.225,-268.355;Float;False;324;0;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;275;-6381.44,-448.0555;Float;False;274;0;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;328;-3831.567,695.8683;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;274;-3582.03,478.1316;Float;False;_tiling_black;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;333;-4112.358,824.7565;Float;False;Property;_TilingAlpha;Tiling Alpha;12;0;Create;True;0;0;False;0;10;56.3;1;100;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;277;-6371.082,-124.0335;Float;False;327;0;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;327;-3579.519,736.2575;Float;False;_tiling_green;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;330;-6384.526,530.7731;Float;False;324;0;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;224;-6417.963,806.458;Float;False;Property;_ParallaxStrength;Parallax Strength;13;0;Create;True;0;0;False;0;0;0;0;0.2;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;278;-6393.082,463.0326;Float;False;274;0;1;FLOAT2;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;221;-6382.186,897.3663;Float;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SamplerNode;230;-6134,-517;Float;True;Property;_HeightBlackChannel;Height (Black Channel);23;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;334;-3820.107,826.2543;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;216;-6134,-326.6326;Float;True;Property;_HeightRedChannel;Height (Red Channel);26;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;331;-6387.826,606.973;Float;False;327;0;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;242;-6131.654,-135.0512;Float;True;Property;_HeightGreenchannel;Height (Green channel);29;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;290;-4895.489,392.3851;Float;False;692.8662;358.6274;Vertex_colors;5;283;332;282;281;213;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;338;-6393.79,68.94284;Float;False;335;0;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;335;-3568.061,866.6435;Float;False;_tiling_alpha;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ParallaxMappingNode;321;-5996.79,611.626;Float;False;Normal;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ParallaxMappingNode;223;-5998.207,462.058;Float;False;Normal;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;337;-6122.342,77.22849;Float;True;Property;_HeightAlphachannel;Height (Alpha channel);32;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;295;-6244.361,-1045.11;Float;False;294;0;1;FLOAT2;0
Node;AmplifyShaderEditor.VertexColorNode;213;-4815.809,482.161;Float;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;294;-5666.381,499.6059;Float;False;_parallax_Black;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ParallaxMappingNode;322;-6000.84,754.6259;Float;False;Normal;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;339;-6392.217,679.4591;Float;False;335;0;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;297;-5190.836,-1079.773;Float;False;319;0;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;319;-5655.2,594.0861;Float;False;_parallax_Red;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;261;-5258.026,443.8908;Float;False;Property;_BlendingstrengthRed;Blending strength (Red);14;0;Create;True;0;0;False;0;5;0.7;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;361;-4843.476,-776.6769;Float;False;Property;_SmoothnessshiftRedChannel;Smoothness shift (Red Channel);5;0;Create;True;0;0;False;0;1;0.7;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;320;-5658.2,695.0861;Float;False;_parallax_Green;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;281;-4490.809,432.1602;Float;False;_vertex_color_red;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;285;-5257.669,-327.4401;Float;False;281;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;296;-4160.767,-1047.208;Float;False;320;0;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;211;-5944.099,-1247.403;Float;True;Property;_DiffuseBlackChannel;Diffuse (Black Channel);21;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;269;-4783.433,-1450.403;Float;False;Property;_ColorshiftRedChannel;Color shift(Red Channel);1;0;Create;True;0;0;False;0;1,1,1,0;1,0.894929,0.4558824,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ParallaxMappingNode;336;-5994.404,904.7668;Float;False;Normal;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;363;-5935.46,-745.9168;Float;False;Property;_SmoothnessshiftBlackchannel;Smoothness shift (Black channel);4;0;Create;True;0;0;False;0;1;0.7;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;266;-5931.094,-1452.043;Float;False;Property;_ColorshiftBlackChannel;Color shift(Black Channel);0;0;Create;True;0;0;False;0;1,1,1,0;0.5441177,0.5441177,0.5441177,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;210;-4815.165,-1284.718;Float;True;Property;_DiffuseRedChannel;Diffuse (Red Channel);24;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.HeightMapBlendNode;228;-4941.374,-381.3669;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;262;-5258.092,526.9798;Float;False;Property;_BlendingStrengthGreen;Blending Strength (Green);15;0;Create;True;0;0;False;0;5;2.85;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;267;-3811.679,-1458.782;Float;False;Property;_ColorshiftGreenChannel0;Color shift(Green Channel) 0;2;0;Create;True;0;0;False;0;1,1,1,0;0.8382353,0.818172,0.8135813,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;282;-4490.809,512.1609;Float;False;_vertex_color_green;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;340;-5656.417,823.759;Float;False;_parallax_alpha;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;243;-3813.876,-1280.201;Float;True;Property;_DiffuseGreenChannel;Diffuse (Green Channel);27;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;351;-3163.434,-1238.479;Float;False;340;0;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;360;-4471.974,-914.2986;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;288;-5293.213,-111.9012;Float;False;282;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;265;-5523.86,-1311.432;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;270;-4473.326,-1312.693;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;362;-5563.958,-883.5385;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;359;-3855.907,-807.5541;Float;False;Property;_SmoothnessshiftGreenChannel;Smoothness shift (Green Channel);6;0;Create;True;0;0;False;0;1;0.82;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;349;-2792.434,-1256.479;Float;True;Property;_DiffuseAlphaChannel;Diffuse (Alpha Channel);30;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;343;-5275.024,106.8347;Float;False;332;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;332;-4495.539,661.151;Float;False;_vertex_color_alpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;268;-3430.218,-1331.747;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;341;-5255.151,618.3416;Float;False;Property;_BlendingStrengthAlpha;Blending Strength (Alpha);16;0;Create;True;0;0;False;0;5;1.23;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;239;-5211.627,-1381.341;Float;False;Property;_NormalmapstrengthRed;Normal map strength (Red);18;0;Create;True;0;0;False;0;1;2.41;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;348;-2777.292,-1441.06;Float;False;Property;_ColorshiftAlphaChannel;Color shift (Alpha Channel);3;0;Create;True;0;0;False;0;1,1,1,0;0.6617647,0.6617647,0.6617647,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.HeightMapBlendNode;241;-4862.06,-121.2252;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;237;-4345.405,28.24286;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;355;-2767.654,-782.1024;Float;False;Property;_SmoothnessshiftAlphaChannel;Smoothness shift (Alpha Channel);7;0;Create;True;0;0;False;0;1;1.47;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;358;-3484.405,-945.1758;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;212;-4304.905,-409.906;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;238;-6352.242,-1217.836;Float;False;Property;_NormalmapstrengthBlack;Normal map strength (Black);17;0;Create;True;0;0;False;0;1;4.42;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;231;-5945.622,-1033.704;Float;True;Property;_NormalBlackChannel;Normal (Black Channel);22;0;Create;True;0;0;False;0;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;249;-4069.596,-1.753241;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;357;-2396.152,-919.7242;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.HeightMapBlendNode;342;-4852.232,100.8295;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;240;-4073.619,-408.6736;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;232;-4812.372,-1086.174;Float;True;Property;_NormalRedChannel;Normal (Red Channel);25;0;Create;True;0;0;False;0;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;352;-2418.686,-1291.541;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;260;-4164.35,-1408.434;Float;False;Property;_NormalmapstrengthGreen;Normal map strength (Green);19;0;Create;True;0;0;False;0;1;1.5;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;271;-3079.031,-420.911;Float;False;Property;_Wetness_color;Wetness_color;8;0;Create;True;0;0;False;0;1,1,1,0;1,1,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;233;-4345.788,-180.8048;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;244;-3820.337,-1083.884;Float;True;Property;_NormalGreenChannel;Normal (Green Channel);28;0;Create;True;0;0;False;0;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;345;-3856.557,-414.9556;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;347;-3160.709,-1397.945;Float;False;Property;_NormalmapstrengthAlpha;Normal map strength (Alpha);20;0;Create;True;0;0;False;0;1;2.32;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;354;-3881.351,-0.4316788;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;283;-4489.809,586.161;Float;False;_vertex_color_blue;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;247;-4094.624,-205.1949;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;289;-3950.174,181.9675;Float;False;283;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;264;-3642.649,35.41486;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;272;-2807.431,-394.5111;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;287;-2951.431,-170.5111;Float;False;282;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;350;-2802.434,-1028.479;Float;True;Property;_NormalAlphaChannel;Normal (Alpha Channel);31;0;Create;True;0;0;False;0;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;353;-3847.735,-214.9976;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;263;-3479.896,-19.63053;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;273;-2615.431,-266.5111;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;307;-2736.994,21.86616;Float;False;306;0;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;356;-4112.092,-932.2358;Float;False;Constant;_Float0;Float 0;29;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;313;-2741.994,324.8662;Float;False;312;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;367;-2693.768,187.5928;Float;False;Constant;_Float1;Float 1;33;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;309;-2736.994,101.8662;Float;False;308;0;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;308;-3601.612,-205.9381;Float;False;_normal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;306;-2407.431,-250.5112;Float;False;_albedo;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;312;-3512.388,179.4866;Float;False;_smoothness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;365;-2416.994,37.86616;Float;False;False;2;Float;ASEMaterialInspector;0;1;ASETemplateShaders/LightWeight;1976390536c6c564abb90fe41f6ee334;0;1;ShadowCaster;0;False;False;True;0;False;-1;False;False;False;False;False;True;3;RenderPipeline=LightweightPipeline;RenderType=Opaque;Queue=Geometry;True;2;0;0;0;False;False;False;False;False;True;1;False;-1;True;3;False;-1;False;True;1;LightMode=ShadowCaster;False;0;0;0;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;364;-2416.994,37.86616;Float;False;True;2;Float;ASEMaterialInspector;0;1;beffio/Medieval_Kingdom/SRP/Lightweight/GroundBlending;1976390536c6c564abb90fe41f6ee334;0;0;Base;10;False;False;True;0;False;-1;False;False;False;False;False;True;3;RenderPipeline=LightweightPipeline;RenderType=Opaque;Queue=Geometry;True;2;0;0;0;True;1;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;False;True;0;False;-1;True;True;True;True;True;0;False;-1;False;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;1;LightMode=LightweightForward;False;0;0;0;10;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;9;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;366;-2416.994,37.86616;Float;False;False;2;Float;ASEMaterialInspector;0;1;ASETemplateShaders/LightWeight;1976390536c6c564abb90fe41f6ee334;0;2;DepthOnly;0;False;False;True;0;False;-1;False;False;False;False;False;True;3;RenderPipeline=LightweightPipeline;RenderType=Opaque;Queue=Geometry;True;2;0;0;0;False;False;True;0;False;-1;True;False;False;False;False;0;False;-1;False;True;1;False;-1;False;False;True;1;LightMode=DepthOnly;False;0;0;0;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;302;-5282.07,-424.9674;Float;False;619.2954;218.9266;Height_blend_red_channel;0;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;298;-5273.048,-1500.403;Float;False;1040.14;911.9171;Red_Channell_maps;0;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;344;-5325.024,50.82946;Float;False;725.792;206;Height_blend_alpha_channel;0;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;305;-5393.213,-481.3674;Float;False;872.3828;775.7572;Comment;0;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;300;-4219.769,-1500.654;Float;False;1024.551;912.9199;Green_channel_maps;0;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;301;-5346.413,-192.0253;Float;False;734.1523;206;Height_blend_green_channel;0;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;304;-4406.406,-533.5634;Float;False;1120.3;828.8843;Blending;0;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;293;-6459.642,420.6617;Float;False;1078.161;635.8715;Parallax;0;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;291;-5298.491,390.6918;Float;False;333;382.09;Height_blending;0;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;303;-3115.164,-458.5111;Float;False;917.035;395.8532;Wetness_color;0;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;286;-6422,-565;Float;False;955.8687;869.1481;Height_maps_input;0;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;346;-3177.096,-1498.882;Float;False;1024.551;912.9199;Alpha_channel_Maps;0;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;299;-6422.985,-1502.043;Float;False;1132.125;911.9425;Black_channel_maps;0;;1,1,1,1;0;0
WireConnection;215;0;214;0
WireConnection;325;0;326;0
WireConnection;324;0;325;0
WireConnection;328;0;329;0
WireConnection;274;0;215;0
WireConnection;327;0;328;0
WireConnection;230;1;275;0
WireConnection;334;0;333;0
WireConnection;216;1;276;0
WireConnection;242;1;277;0
WireConnection;335;0;334;0
WireConnection;321;0;330;0
WireConnection;321;1;216;0
WireConnection;321;2;224;0
WireConnection;321;3;221;0
WireConnection;223;0;278;0
WireConnection;223;1;230;0
WireConnection;223;2;224;0
WireConnection;223;3;221;0
WireConnection;337;1;338;0
WireConnection;294;0;223;0
WireConnection;322;0;331;0
WireConnection;322;1;242;0
WireConnection;322;2;224;0
WireConnection;322;3;221;0
WireConnection;319;0;321;0
WireConnection;320;0;322;0
WireConnection;281;0;213;1
WireConnection;211;1;295;0
WireConnection;336;0;339;0
WireConnection;336;1;337;0
WireConnection;336;2;224;0
WireConnection;336;3;221;0
WireConnection;210;1;297;0
WireConnection;228;0;216;0
WireConnection;228;1;285;0
WireConnection;228;2;261;0
WireConnection;282;0;213;2
WireConnection;340;0;336;0
WireConnection;243;1;296;0
WireConnection;360;0;210;4
WireConnection;360;1;361;0
WireConnection;265;0;211;0
WireConnection;265;1;266;0
WireConnection;270;0;210;0
WireConnection;270;1;269;0
WireConnection;362;0;211;4
WireConnection;362;1;363;0
WireConnection;349;1;351;0
WireConnection;332;0;213;4
WireConnection;268;0;243;0
WireConnection;268;1;267;0
WireConnection;241;0;242;0
WireConnection;241;1;288;0
WireConnection;241;2;262;0
WireConnection;237;0;362;0
WireConnection;237;1;360;0
WireConnection;237;2;228;0
WireConnection;358;0;243;4
WireConnection;358;1;359;0
WireConnection;212;0;265;0
WireConnection;212;1;270;0
WireConnection;212;2;228;0
WireConnection;231;1;295;0
WireConnection;231;5;238;0
WireConnection;249;0;237;0
WireConnection;249;1;358;0
WireConnection;249;2;241;0
WireConnection;357;0;349;4
WireConnection;357;1;355;0
WireConnection;342;0;337;0
WireConnection;342;1;343;0
WireConnection;342;2;341;0
WireConnection;240;0;212;0
WireConnection;240;1;268;0
WireConnection;240;2;241;0
WireConnection;232;1;297;0
WireConnection;232;5;239;0
WireConnection;352;0;349;0
WireConnection;352;1;348;0
WireConnection;233;0;231;0
WireConnection;233;1;232;0
WireConnection;233;2;228;0
WireConnection;244;1;296;0
WireConnection;244;5;260;0
WireConnection;345;0;240;0
WireConnection;345;1;352;0
WireConnection;345;2;342;0
WireConnection;354;0;249;0
WireConnection;354;1;357;0
WireConnection;354;2;342;0
WireConnection;283;0;213;3
WireConnection;247;0;233;0
WireConnection;247;1;244;0
WireConnection;247;2;241;0
WireConnection;264;0;354;0
WireConnection;272;0;345;0
WireConnection;272;1;271;0
WireConnection;350;1;351;0
WireConnection;350;5;347;0
WireConnection;353;0;247;0
WireConnection;353;1;350;0
WireConnection;353;2;342;0
WireConnection;263;0;354;0
WireConnection;263;1;264;0
WireConnection;263;2;289;0
WireConnection;273;0;345;0
WireConnection;273;1;272;0
WireConnection;273;2;287;0
WireConnection;308;0;353;0
WireConnection;306;0;273;0
WireConnection;312;0;263;0
WireConnection;364;0;307;0
WireConnection;364;1;309;0
WireConnection;364;3;367;0
WireConnection;364;4;313;0
ASEEND*/
//CHKSM=B69C103E94538CB0452D3414030AA52C34D657DA