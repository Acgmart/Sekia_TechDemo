// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "beffio/Medieval_Kingdom/Parallax"
{
	Properties
	{
		_Global_Tiling("Global_Tiling", Float) = 2
		_Base_Color("Base_Color", Color) = (0.3455882,0.3238225,0.2769788,0)
		_Detail_mask_color("Detail_mask_color", Color) = (0.9264706,0,0,0)
		_Detail_mask_level("Detail_mask_level", Range( 0 , 1)) = 1
		_Detail_mask_2_color("Detail_mask_2_color", Color) = (0.3466771,0.4411765,0.01297579,0)
		_Detail_mask_2_level("Detail_mask_2_level", Range( 0 , 1)) = 0
		_SmoothnessScale("Smoothness Scale", Range( 0 , 2)) = 1
		_NormalScale("Normal Scale", Range( 0 , 2)) = 1
		_Ambient_Occulsion_level("Ambient_Occulsion_level", Range( 0 , 2)) = 1
		_Parallax("Parallax", Range( 0 , 0.02)) = 0
		_Albedo_smoothness_map_input("Albedo_smoothness_map_input", 2D) = "white" {}
		_HeightMap("HeightMap", 2D) = "white" {}
		_Normal("Normal", 2D) = "bump" {}
		_Occlusion("Occlusion", 2D) = "white" {}
		_Detail_mask("Detail_mask", 2D) = "white" {}
		_Detail_mask_2("Detail_mask_2", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		ZTest LEqual
		CGINCLUDE
		#include "UnityStandardUtils.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) fixed3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			fixed2 uv_texcoord;
			float3 viewDir;
			INTERNAL_DATA
		};

		uniform fixed _NormalScale;
		uniform sampler2D _Normal;
		uniform fixed _Global_Tiling;
		uniform sampler2D _HeightMap;
		uniform float4 _HeightMap_ST;
		uniform fixed _Parallax;
		uniform fixed4 _Base_Color;
		uniform sampler2D _Albedo_smoothness_map_input;
		uniform sampler2D _Detail_mask;
		uniform fixed _Detail_mask_level;
		uniform fixed4 _Detail_mask_color;
		uniform fixed4 _Detail_mask_2_color;
		uniform sampler2D _Detail_mask_2;
		uniform fixed _Detail_mask_2_level;
		uniform sampler2D _Occlusion;
		uniform fixed _Ambient_Occulsion_level;
		uniform fixed _SmoothnessScale;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			fixed2 temp_cast_0 = (_Global_Tiling).xx;
			float2 uv_TexCoord117 = i.uv_texcoord * temp_cast_0 + float2( 0,0 );
			float2 uv_HeightMap = i.uv_texcoord * _HeightMap_ST.xy + _HeightMap_ST.zw;
			float2 Offset4 = ( ( tex2D( _HeightMap, uv_HeightMap ).r - 1 ) * i.viewDir.xy * _Parallax ) + uv_TexCoord117;
			float2 Offset49 = ( ( tex2D( _HeightMap, Offset4 ).r - 1 ) * i.viewDir.xy * _Parallax ) + Offset4;
			float2 Offset52 = ( ( tex2D( _HeightMap, Offset49 ).r - 1 ) * i.viewDir.xy * _Parallax ) + Offset49;
			float2 Offset54 = ( ( tex2D( _HeightMap, Offset52 ).r - 1 ) * i.viewDir.xy * _Parallax ) + Offset52;
			float2 _parallax_offset13 = Offset54;
			float3 _normal162 = UnpackScaleNormal( tex2D( _Normal, _parallax_offset13 ) ,_NormalScale );
			o.Normal = _normal162;
			fixed4 tex2DNode1 = tex2D( _Albedo_smoothness_map_input, _parallax_offset13 );
			fixed4 blendOpSrc122 = _Base_Color;
			fixed4 blendOpDest122 = tex2DNode1;
			float4 temp_output_135_0 = ( tex2D( _Detail_mask, _parallax_offset13 ) * _Detail_mask_level );
			fixed4 blendOpSrc138 = temp_output_135_0;
			fixed4 blendOpDest138 = _Detail_mask_color;
			float4 lerpResult141 = lerp( ( saturate( (( blendOpDest122 > 0.5 ) ? ( 1.0 - ( 1.0 - 2.0 * ( blendOpDest122 - 0.5 ) ) * ( 1.0 - blendOpSrc122 ) ) : ( 2.0 * blendOpDest122 * blendOpSrc122 ) ) )) , ( saturate( ( blendOpSrc138 * blendOpDest138 ) )) , temp_output_135_0.r);
			float4 lerpResult143 = lerp( lerpResult141 , _Detail_mask_2_color , ( tex2D( _Detail_mask_2, _parallax_offset13 ) * _Detail_mask_2_level ));
			fixed4 blendOpSrc144 = lerpResult141;
			fixed4 blendOpDest144 = lerpResult143;
			float4 temp_output_144_0 = ( saturate( (( blendOpSrc144 > 0.5 ) ? max( blendOpDest144, 2.0 * ( blendOpSrc144 - 0.5 ) ) : min( blendOpDest144, 2.0 * blendOpSrc144 ) ) ));
			float4 _AO154 = tex2D( _Occlusion, _parallax_offset13 );
			fixed4 blendOpSrc127 = fixed4(1,1,1,0);
			fixed4 blendOpDest127 = _AO154;
			float4 lerpResult130 = lerp( temp_output_144_0 , fixed4(0,0,0,0) , ( ( saturate( abs( blendOpSrc127 - blendOpDest127 ) )) * _Ambient_Occulsion_level ).r);
			fixed4 blendOpSrc131 = temp_output_144_0;
			fixed4 blendOpDest131 = lerpResult130;
			float4 _albedo_blending164 = ( saturate( min( blendOpSrc131 , blendOpDest131 ) ));
			o.Albedo = _albedo_blending164.rgb;
			float _smoothness169 = ( tex2DNode1.a * _SmoothnessScale );
			o.Smoothness = _smoothness169;
			o.Occlusion = _AO154.r;
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha fullforwardshadows 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float4 tSpace0 : TEXCOORD2;
				float4 tSpace1 : TEXCOORD3;
				float4 tSpace2 : TEXCOORD4;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				fixed3 worldNormal = UnityObjectToWorldNormal( v.normal );
				fixed3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				fixed3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			fixed4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				fixed3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.viewDir = IN.tSpace0.xyz * worldViewDir.x + IN.tSpace1.xyz * worldViewDir.y + IN.tSpace2.xyz * worldViewDir.z;
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=14201
0;92;1072;1046;3921.486;1153.729;2.121272;False;False
Node;AmplifyShaderEditor.CommentaryNode;152;-3826.721,-463.6295;Float;False;1450.578;1148.748;Parallax_effect;47;13;9;8;54;113;53;70;81;82;121;79;80;112;69;52;114;63;51;77;111;75;64;78;119;76;118;49;115;50;73;59;62;71;110;74;72;4;48;10;116;57;58;47;109;117;21;120;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-3743.412,-365.7693;Float;False;Property;_Global_Tiling;Global_Tiling;0;0;Create;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;117;-3567.413,-365.7693;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;9;-3807.412,-13.76923;Float;False;Property;_Parallax;Parallax;9;0;Create;0;0;0;0.02;0;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;8;-3727.413,98.23078;Float;False;Tangent;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WireNode;58;-3343.413,-173.7693;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;47;-3327.413,-413.7693;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;109;-3359.413,-189.7692;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;10;-3295.413,-397.7693;Float;True;Property;_HeightMap;HeightMap;11;0;Create;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;FLOAT2;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;48;-3023.413,-413.7693;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;57;-2991.413,-205.7692;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;116;-3007.413,-221.7692;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ParallaxMappingNode;4;-2911.413,-349.7693;Float;False;Normal;4;0;FLOAT2;0,0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;72;-2671.413,-157.7693;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;71;-3343.413,-141.7693;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;62;-3359.413,82.23079;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;74;-2639.413,-141.7693;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;110;-3359.413,66.23075;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;50;-3311.413,-109.7692;Float;True;Property;_TextureSample1;Texture Sample 1;11;0;Create;None;None;True;0;False;white;Auto;False;Instance;10;Auto;Texture2D;6;0;SAMPLER2D;FLOAT2;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;115;-3023.413,66.23075;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;59;-3023.413,82.23079;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;73;-2943.413,-125.7692;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ParallaxMappingNode;49;-2911.413,-77.76925;Float;False;Normal;4;0;FLOAT2;0,0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;119;-3423.413,306.2307;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;76;-2703.413,82.23079;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;118;-3407.413,290.2307;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;64;-3359.413,338.2307;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;78;-2671.413,114.2308;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;75;-3343.413,114.2308;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;111;-3359.413,322.2307;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;63;-3023.413,338.2307;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;114;-3023.413,306.2307;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;77;-2943.413,146.2308;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;51;-3327.413,146.2308;Float;True;Property;_TextureSample2;Texture Sample 2;11;0;Create;None;None;True;0;False;white;Auto;False;Instance;10;Auto;Texture2D;6;0;SAMPLER2D;FLOAT2;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ParallaxMappingNode;52;-2927.413,162.2308;Float;False;Normal;4;0;FLOAT2;0,0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;80;-2735.413,354.2307;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;112;-3391.413,562.2306;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;69;-3407.413,578.2306;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;82;-2703.413,386.2307;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;120;-3151.424,626.9708;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;79;-3359.413,386.2307;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;121;-3343.413,594.2306;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;70;-3023.413,610.2306;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;81;-2959.413,418.2307;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;113;-3023.413,594.2306;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;53;-3327.413,418.2307;Float;True;Property;_TextureSample3;Texture Sample 3;11;0;Create;None;None;True;0;False;white;Auto;False;Instance;10;Auto;Texture2D;6;0;SAMPLER2D;FLOAT2;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;149;-2017.631,-914.7146;Float;False;1043.135;403.0649;Detail_mask_2_map_input;14;144;143;176;178;177;175;174;173;142;140;172;139;158;137;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ParallaxMappingNode;54;-2927.413,434.2307;Float;False;Normal;4;0;FLOAT2;0,0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;158;-1960.365,-848.3581;Float;False;13;0;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;13;-2623.413,-29.76924;Float;False;_parallax_offset;1;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;167;-2334.049,133.9323;Float;False;825.9126;263;AO;3;154;7;161;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;150;-2987.805,-1025.44;Float;False;945.6262;519.4033;Detail_mask_1_map_input;7;141;138;135;133;136;134;157;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;137;-1728.771,-855.3891;Float;True;Property;_Detail_mask_2;Detail_mask_2;15;0;Create;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;157;-2967.372,-790.6313;Float;False;13;0;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;177;-1456.789,-814.6838;Float;False;1;0;COLOR;0.0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;151;-3841.523,-964.4448;Float;False;836.774;463.8892;Albedo_smoothness_map_input;5;171;122;1;153;123;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;161;-2311.049,190.125;Float;False;13;0;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;133;-2711.482,-615.3044;Float;False;Property;_Detail_mask_level;Detail_mask_level;3;0;Create;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;7;-2060.736,186.9323;Float;True;Property;_Occlusion;Occlusion;13;0;Create;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;FLOAT2;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;123;-3774.945,-909.4448;Float;False;Property;_Base_Color;Base_Color;1;0;Create;0.3455882,0.3238225,0.2769788,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;134;-2729.923,-806.0453;Float;True;Property;_Detail_mask;Detail_mask;14;0;Create;None;7a947e26d6355c94898b3bf52c6e07da;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;176;-1467.789,-688.684;Float;False;1;0;COLOR;0.0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;148;-933.6221,-907.5197;Float;False;1005.578;484.0745;AO_diffuse_blend;11;164;131;130;184;183;129;126;128;127;156;132;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;153;-3781.322,-710.0444;Float;False;13;0;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;154;-1750.136,189.051;Float;False;_AO;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;168;-2327.667,-449.1929;Float;False;486.0488;276.9768;Smoothness;7;169;182;181;180;179;38;100;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ColorNode;142;-1427.303,-849.3421;Float;False;Property;_Detail_mask_2_color;Detail_mask_2_color;4;0;Create;0.3466771,0.4411765,0.01297579,0;0.3466771,0.4411765,0.01297579,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;178;-1636.789,-669.6839;Float;False;1;0;COLOR;0.0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;171;-3287.793,-809.686;Float;False;1;0;COLOR;0.0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;1;-3543.988,-714.4156;Float;True;Property;_Albedo_smoothness_map_input;Albedo_smoothness_map_input;10;0;Create;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;FLOAT2;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;132;-883.6221,-857.5195;Float;False;Constant;_Color1;Color 1;17;0;Create;1,1,1,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;139;-1995.198,-770.9363;Float;False;Property;_Detail_mask_2_level;Detail_mask_2_level;5;0;Create;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;156;-883.6644,-682.8904;Float;False;154;0;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;136;-2643.073,-970.2709;Float;False;Property;_Detail_mask_color;Detail_mask_color;2;0;Create;0.9264706,0,0,0;0.1372547,0.3433941,0.4274508,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;135;-2425.909,-641.5312;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;38;-2298.667,-264.2162;Float;False;Property;_SmoothnessScale;Smoothness Scale;6;0;Create;1;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.BlendOpsNode;127;-683.0638,-850.6815;Float;False;Difference;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BlendOpsNode;138;-2409,-779.0435;Float;False;Multiply;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;172;-1787.789,-609.6838;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;173;-1172.789,-776.6839;Float;False;1;0;COLOR;0.0;False;1;COLOR;0
Node;AmplifyShaderEditor.BlendOpsNode;122;-3228.749,-629.4766;Float;False;Overlay;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;175;-1640.789,-628.6838;Float;False;1;0;COLOR;0.0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;182;-2037.498,-237.5243;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;183;-496.1315,-761.6124;Float;False;1;0;COLOR;0.0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;174;-1384.789,-655.6838;Float;False;1;0;COLOR;0.0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;141;-2206.897,-663.1088;Float;False;3;0;COLOR;0.0,0,0,0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;140;-1581.824,-649.1822;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;181;-2041.498,-300.5242;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;184;-649.1318,-725.6124;Float;False;1;0;COLOR;0.0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;143;-1334.845,-671.2673;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;2;COLOR;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;126;-878.8818,-583.7855;Float;False;Property;_Ambient_Occulsion_level;Ambient_Occulsion_level;8;0;Create;1;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;180;-2304.499,-310.5242;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;128;-439.4155,-847.8215;Float;False;Constant;_Color0;Color 0;1;0;Create;0,0,0,0;1,1,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;129;-617.5397,-695.9894;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;166;-2334.769,-156.4992;Float;False;821.313;264.2756;Normal_map_input;4;162;5;159;6;;1,1,1,1;0;0
Node;AmplifyShaderEditor.BlendOpsNode;144;-1177.226,-645.1133;Float;False;PinLight;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-2311.042,2.077228;Float;False;Property;_NormalScale;Normal Scale;7;0;Create;1;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;159;-2305.769,-110.4992;Float;False;13;0;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;179;-2315.499,-338.5241;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;130;-383.7516,-666.5485;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BlendOpsNode;131;-389.9216,-544.5025;Float;False;Darken;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;5;-2034.774,-107.2235;Float;True;Property;_Normal;Normal;12;0;Create;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;FLOAT2;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;100;-2273.618,-397.2425;Float;False;2;2;0;FLOAT;0,0,0,0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;155;-1376,-32;Float;False;154;0;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;165;-1440,-320;Float;False;164;0;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;163;-1376,-224;Float;False;162;0;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;170;-1408,-128;Float;False;169;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;169;-2064.968,-405.4427;Float;False;_smoothness;-1;True;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;164;-173.2323,-534.2883;Float;False;_albedo_blending;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;162;-1743.456,-105.2664;Float;False;_normal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-1152,-320;Fixed;False;True;2;Fixed;ASEMaterialInspector;0;0;Standard;beffio/Medieval_Kingdom/Parallax;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;3;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;False;0;4;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;Add;Add;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0,0,0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;117;0;21;0
WireConnection;58;0;8;0
WireConnection;47;0;117;0
WireConnection;109;0;9;0
WireConnection;48;0;47;0
WireConnection;57;0;58;0
WireConnection;116;0;109;0
WireConnection;4;0;48;0
WireConnection;4;1;10;1
WireConnection;4;2;116;0
WireConnection;4;3;57;0
WireConnection;72;0;4;0
WireConnection;71;0;72;0
WireConnection;62;0;8;0
WireConnection;74;0;4;0
WireConnection;110;0;9;0
WireConnection;50;1;71;0
WireConnection;115;0;110;0
WireConnection;59;0;62;0
WireConnection;73;0;74;0
WireConnection;49;0;73;0
WireConnection;49;1;50;1
WireConnection;49;2;115;0
WireConnection;49;3;59;0
WireConnection;119;0;8;0
WireConnection;76;0;49;0
WireConnection;118;0;9;0
WireConnection;64;0;119;0
WireConnection;78;0;49;0
WireConnection;75;0;76;0
WireConnection;111;0;118;0
WireConnection;63;0;64;0
WireConnection;114;0;111;0
WireConnection;77;0;78;0
WireConnection;51;1;75;0
WireConnection;52;0;77;0
WireConnection;52;1;51;1
WireConnection;52;2;114;0
WireConnection;52;3;63;0
WireConnection;80;0;52;0
WireConnection;112;0;9;0
WireConnection;69;0;8;0
WireConnection;82;0;52;0
WireConnection;120;0;69;0
WireConnection;79;0;80;0
WireConnection;121;0;112;0
WireConnection;70;0;120;0
WireConnection;81;0;82;0
WireConnection;113;0;121;0
WireConnection;53;1;79;0
WireConnection;54;0;81;0
WireConnection;54;1;53;1
WireConnection;54;2;113;0
WireConnection;54;3;70;0
WireConnection;13;0;54;0
WireConnection;137;1;158;0
WireConnection;177;0;137;0
WireConnection;7;1;161;0
WireConnection;134;1;157;0
WireConnection;176;0;177;0
WireConnection;154;0;7;0
WireConnection;178;0;176;0
WireConnection;171;0;123;0
WireConnection;1;1;153;0
WireConnection;135;0;134;0
WireConnection;135;1;133;0
WireConnection;127;0;132;0
WireConnection;127;1;156;0
WireConnection;138;0;135;0
WireConnection;138;1;136;0
WireConnection;172;0;139;0
WireConnection;173;0;142;0
WireConnection;122;0;171;0
WireConnection;122;1;1;0
WireConnection;175;0;178;0
WireConnection;182;0;38;0
WireConnection;183;0;127;0
WireConnection;174;0;173;0
WireConnection;141;0;122;0
WireConnection;141;1;138;0
WireConnection;141;2;135;0
WireConnection;140;0;175;0
WireConnection;140;1;172;0
WireConnection;181;0;182;0
WireConnection;184;0;183;0
WireConnection;143;0;141;0
WireConnection;143;1;174;0
WireConnection;143;2;140;0
WireConnection;180;0;181;0
WireConnection;129;0;184;0
WireConnection;129;1;126;0
WireConnection;144;0;141;0
WireConnection;144;1;143;0
WireConnection;179;0;180;0
WireConnection;130;0;144;0
WireConnection;130;1;128;0
WireConnection;130;2;129;0
WireConnection;131;0;144;0
WireConnection;131;1;130;0
WireConnection;5;1;159;0
WireConnection;5;5;6;0
WireConnection;100;0;1;4
WireConnection;100;1;179;0
WireConnection;169;0;100;0
WireConnection;164;0;131;0
WireConnection;162;0;5;0
WireConnection;0;0;165;0
WireConnection;0;1;163;0
WireConnection;0;4;170;0
WireConnection;0;5;155;0
ASEEND*/
//CHKSM=74736DAB0E8F0BFFEE8B6F57EADE33489D545DEC