// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "beffio/Medieval_Kingdom/Stones"
{
	Properties
	{
		_Base_color("Base_color", Color) = (0.3919766,0.4150519,0.4264706,0)
		_Material_Smoothness_shift("Material_Smoothness_shift", Range( 0 , 2)) = 1
		_Base_Normal_Intensity("Base_Normal_Intensity", Range( 0 , 2)) = 1
		_Edge_color("Edge_color", Color) = (1,1,1,0)
		_Edge_wear("Edge_wear", Range( 0 , 1)) = 0.9960846
		_Detail_1_level("Detail_1_level", Range( 0 , 2)) = 1
		_Detail_color("Detail_color", Color) = (1,1,1,0)
		_Top_mask_level("Top_mask_level", Range( 0 , 1)) = 1
		_Top_Color("Top_Color", Color) = (0.6654717,0.6985294,0.07704367,0)
		_Top_mask_tiling("Top_mask_tiling", Range( 0 , 8)) = 4
		_Top_mask_smoothness_shift("Top_mask_smoothness_shift", Range( 0 , 1)) = 1
		_Top_mask_normal_intensity("Top_mask_normal_intensity", Range( 0 , 2)) = 0.25
		_AO_shift("AO_shift", Range( 0 , 2)) = 1
		_Albedo_smoothness_map_input("Albedo_smoothness_map_input", 2D) = "white" {}
		_Normal_map_input("Normal_map_input", 2D) = "bump" {}
		_Ambient_Occlusion_map_input("Ambient_Occlusion_map_input", 2D) = "white" {}
		_Top_mask_texture("Top_mask_texture", 2D) = "white" {}
		_Top_mask_normal("Top_mask_normal", 2D) = "bump" {}
		_Edge_mask_map_input("Edge_mask_map_input", 2D) = "white" {}
		_Detail_mask_1_map_input("Detail_mask_1_map_input", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
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
			float2 uv_texcoord;
			float3 worldNormal;
			INTERNAL_DATA
		};

		uniform fixed _Base_Normal_Intensity;
		uniform sampler2D _Normal_map_input;
		uniform float4 _Normal_map_input_ST;
		uniform fixed _Top_mask_normal_intensity;
		uniform sampler2D _Top_mask_normal;
		uniform float _Top_mask_tiling;
		uniform fixed _Top_mask_level;
		uniform sampler2D _Top_mask_texture;
		uniform sampler2D _Albedo_smoothness_map_input;
		uniform float4 _Albedo_smoothness_map_input_ST;
		uniform float4 _Base_color;
		uniform float4 _Detail_color;
		uniform sampler2D _Detail_mask_1_map_input;
		uniform float4 _Detail_mask_1_map_input_ST;
		uniform float _Detail_1_level;
		uniform sampler2D _Ambient_Occlusion_map_input;
		uniform float4 _Ambient_Occlusion_map_input_ST;
		uniform float _AO_shift;
		uniform float4 _Edge_color;
		uniform sampler2D _Edge_mask_map_input;
		uniform float4 _Edge_mask_map_input_ST;
		uniform float _Edge_wear;
		uniform float4 _Top_Color;
		uniform float _Material_Smoothness_shift;
		uniform float _Top_mask_smoothness_shift;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Normal_map_input = i.uv_texcoord * _Normal_map_input_ST.xy + _Normal_map_input_ST.zw;
			float3 tex2DNode8 = UnpackScaleNormal( tex2D( _Normal_map_input, uv_Normal_map_input ) ,_Base_Normal_Intensity );
			float2 temp_cast_0 = (_Top_mask_tiling).xx;
			float2 uv_TexCoord186 = i.uv_texcoord * temp_cast_0 + float2( 0,0 );
			float2 _tiling256 = uv_TexCoord186;
			float3 _normal265 = tex2DNode8;
			float3 newWorldNormal224 = WorldNormalVector( i , _normal265 );
			float4 temp_cast_1 = (saturate( ( pow( ( saturate( newWorldNormal224.y ) + 0.12 ) , (1.0 + (0.7 - 0.0) * (20.0 - 1.0) / (1.0 - 0.0)) ) * _Top_mask_level ) )).xxxx;
			float4 tex2DNode161 = tex2D( _Top_mask_texture, _tiling256 );
			float4 blendOpSrc235 = temp_cast_1;
			float4 blendOpDest235 = tex2DNode161;
			float4 _top_mask276 = ( saturate( (( blendOpSrc235 > 0.5 ) ? max( blendOpDest235, 2.0 * ( blendOpSrc235 - 0.5 ) ) : min( blendOpDest235, 2.0 * blendOpSrc235 ) ) ));
			float3 lerpResult173 = lerp( tex2DNode8 , UnpackScaleNormal( tex2D( _Top_mask_normal, _tiling256 ) ,_Top_mask_normal_intensity ) , _top_mask276.r);
			float3 _normal_blend263 = lerpResult173;
			o.Normal = _normal_blend263;
			float2 uv_Albedo_smoothness_map_input = i.uv_texcoord * _Albedo_smoothness_map_input_ST.xy + _Albedo_smoothness_map_input_ST.zw;
			float4 tex2DNode11 = tex2D( _Albedo_smoothness_map_input, uv_Albedo_smoothness_map_input );
			float4 blendOpSrc12 = tex2DNode11;
			float4 blendOpDest12 = _Base_color;
			float4 temp_output_12_0 = ( saturate( (( blendOpDest12 > 0.5 ) ? ( 1.0 - ( 1.0 - 2.0 * ( blendOpDest12 - 0.5 ) ) * ( 1.0 - blendOpSrc12 ) ) : ( 2.0 * blendOpDest12 * blendOpSrc12 ) ) ));
			float2 uv_Detail_mask_1_map_input = i.uv_texcoord * _Detail_mask_1_map_input_ST.xy + _Detail_mask_1_map_input_ST.zw;
			float4 lerpResult221 = lerp( temp_output_12_0 , _Detail_color , ( tex2D( _Detail_mask_1_map_input, uv_Detail_mask_1_map_input ) * _Detail_1_level ).r);
			float4 blendOpSrc222 = temp_output_12_0;
			float4 blendOpDest222 = lerpResult221;
			float4 temp_output_222_0 = ( saturate( ( 1.0 - ( 1.0 - blendOpSrc222 ) * ( 1.0 - blendOpDest222 ) ) ));
			float4 lerpResult241 = lerp( temp_output_222_0 , float4(1,1,1,0) , ( (_normal265.r + _normal265.g + _normal265.b) / 3 * 1.0 ));
			float4 blendOpSrc242 = temp_output_222_0;
			float4 blendOpDest242 = lerpResult241;
			float4 temp_output_242_0 = ( saturate( (( blendOpDest242 > 0.5 ) ? ( 1.0 - ( 1.0 - 2.0 * ( blendOpDest242 - 0.5 ) ) * ( 1.0 - blendOpSrc242 ) ) : ( 2.0 * blendOpDest242 * blendOpSrc242 ) ) ));
			float2 uv_Ambient_Occlusion_map_input = i.uv_texcoord * _Ambient_Occlusion_map_input_ST.xy + _Ambient_Occlusion_map_input_ST.zw;
			float4 _AO262 = tex2D( _Ambient_Occlusion_map_input, uv_Ambient_Occlusion_map_input );
			float4 blendOpSrc80 = float4(1,1,1,1);
			float4 blendOpDest80 = _AO262;
			float4 lerpResult78 = lerp( temp_output_242_0 , float4(0,0,0,0) , ( ( saturate( abs( blendOpSrc80 - blendOpDest80 ) )) * _AO_shift ).r);
			float4 blendOpSrc79 = temp_output_242_0;
			float4 blendOpDest79 = lerpResult78;
			float4 temp_output_79_0 = ( saturate( min( blendOpSrc79 , blendOpDest79 ) ));
			float2 uv_Edge_mask_map_input = i.uv_texcoord * _Edge_mask_map_input_ST.xy + _Edge_mask_map_input_ST.zw;
			float4 lerpResult70 = lerp( temp_output_79_0 , _Edge_color , ( tex2D( _Edge_mask_map_input, uv_Edge_mask_map_input ) * _Edge_wear ).r);
			float4 blendOpSrc71 = temp_output_79_0;
			float4 blendOpDest71 = lerpResult70;
			float4 _base_stone_color270 = ( saturate( (( blendOpSrc71 > 0.5 ) ? max( blendOpDest71, 2.0 * ( blendOpSrc71 - 0.5 ) ) : min( blendOpDest71, 2.0 * blendOpSrc71 ) ) ));
			float4 lerpResult112 = lerp( _Top_Color , float4( 0,0,0,0 ) , tex2DNode161.r);
			float4 _top_color274 = lerpResult112;
			float4 lerpResult113 = lerp( _base_stone_color270 , _top_color274 , _top_mask276.r);
			float4 blendOpSrc114 = _base_stone_color270;
			float4 blendOpDest114 = lerpResult113;
			float4 _albedo_top_blend282 = ( saturate( ( 0.5 - 2.0 * ( blendOpSrc114 - 0.5 ) * ( blendOpDest114 - 0.5 ) ) ));
			o.Albedo = _albedo_top_blend282.rgb;
			float lerpResult172 = lerp( ( tex2DNode11.a * _Material_Smoothness_shift ) , ( tex2DNode161.a * _Top_mask_smoothness_shift ) , _top_mask276.r);
			float _smoothness284 = lerpResult172;
			o.Smoothness = _smoothness284;
			o.Occlusion = _AO262.r;
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
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
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
0;92;1072;1046;7108.541;2793.512;2.625807;False;False
Node;AmplifyShaderEditor.CommentaryNode;258;-5192.303,-1397.621;Float;False;1205.53;543.2808;Normal_map_input_and_blending;9;265;286;168;263;173;163;269;174;8;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;252;-6609.689,-2327.934;Float;False;498.8076;432.2169;Albedo_smoothness_map_input;3;12;11;4;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;251;-6094.689,-2320.934;Float;False;804.868;385.1859;Detail_mask_1_map_input;6;222;221;220;219;217;218;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;168;-5127.303,-1141.621;Fixed;False;Property;_Base_Normal_Intensity;Base_Normal_Intensity;2;0;Create;1;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;218;-6046.689,-2272.934;Float;True;Property;_Detail_mask_1_map_input;Detail_mask_1_map_input;19;0;Create;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;260;-6082.986,-1900.72;Float;False;1649.861;455.9243;Top_mask;13;276;230;226;229;225;235;233;232;231;228;227;264;224;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;8;-4796.303,-1149.621;Float;True;Property;_Normal_map_input;Normal_map_input;14;0;Create;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;253;-5273.689,-2319.934;Float;False;904;393.9612;Detail_mask2;7;242;241;243;240;244;237;272;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;11;-6587.689,-2107.934;Float;True;Property;_Albedo_smoothness_map_input;Albedo_smoothness_map_input;13;0;Create;eb85a9f6ec8895a488b0a9fae9639feb;67df9d307172fe8489b5cb797279daa4;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;4;-6586.689,-2276.934;Float;False;Property;_Base_color;Base_color;0;0;Create;0.3919766,0.4150519,0.4264706,0;0.4274509,0.2274509,0.1372548,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;217;-6059.689,-2060.934;Float;False;Property;_Detail_1_level;Detail_1_level;5;0;Create;1;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;220;-5677.689,-2077.934;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;261;-6742.108,-1622.609;Float;False;627.7625;328.6404;Ambient_Occlusion_map_input;2;262;62;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;265;-4436.305,-1031.621;Float;False;_normal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;219;-5746.689,-2267.934;Float;False;Property;_Detail_color;Detail_color;6;0;Create;1,1,1,0;1,1,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BlendOpsNode;12;-6323.689,-2273.934;Float;False;Overlay;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;272;-5252.689,-2187.934;Float;False;265;0;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;264;-6070.013,-1827.968;Float;False;265;0;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldNormalVector;224;-5838.477,-1842.72;Float;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SamplerNode;62;-6725.108,-1560.138;Float;True;Property;_Ambient_Occlusion_map_input;Ambient_Occlusion_map_input;15;0;Create;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;221;-5517.689,-2258.934;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;254;-4342.766,-2367.913;Float;False;882.1279;439.7641;diff_AO_blend;8;79;78;77;76;74;80;271;81;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TFHCGrayscale;237;-5050.689,-2185.934;Float;False;2;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;240;-5250.689,-2078.934;Float;False;Constant;_Normal_Detail_level;Normal_Detail_level;13;0;Create;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;226;-5831.796,-1600.472;Fixed;False;Constant;_top3;top3;13;0;Create;0.7;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.BlendOpsNode;222;-5497.689,-2078.934;Float;False;Screen;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;244;-4828.689,-2261.934;Float;False;Constant;_Detail_2_color;Detail_2_color;4;0;Create;1,1,1,0;1,1,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;243;-4935.689,-2082.934;Float;False;2;2;0;FLOAT;0,0,0,0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;225;-5836.668,-1687.55;Fixed;False;Constant;_top2;top2;11;0;Create;0.12;0.3;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;81;-4298.24,-2315.954;Float;False;Constant;_Color0;Color 0;17;0;Create;1,1,1,1;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;271;-4292.963,-2132.388;Float;False;262;0;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;227;-5636.644,-1836.366;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;257;-7047.027,-1875.761;Float;False;932.7964;227.2341;Tiling;3;186;256;287;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;262;-6311.108,-1536.609;Float;False;_AO;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;241;-4765.689,-2066.934;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;74;-4283.756,-2034.748;Float;False;Property;_AO_shift;AO_shift;12;0;Create;1;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.BlendOpsNode;80;-4068.641,-2305.263;Float;False;Difference;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCRemapNode;229;-5517.668,-1728.549;Float;False;5;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;3;FLOAT;1.0;False;4;FLOAT;20.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;228;-5474.278,-1840.403;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;287;-6999.027,-1827.761;Float;False;Property;_Top_mask_tiling;Top_mask_tiling;9;0;Create;4;1;0;8;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;259;-6078.384,-1412.659;Float;False;844.2686;465.2896;Top_mask_color;5;274;112;280;161;110;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;255;-3407.615,-2442.051;Float;False;1038.109;501.1104;Edge_mask_map_input;6;71;70;69;67;124;68;;1,1,1,1;0;0
Node;AmplifyShaderEditor.PowerNode;231;-5345.656,-1842.037;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BlendOpsNode;242;-4586.689,-2068.934;Float;False;Overlay;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;186;-6663.027,-1811.761;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;77;-3850.952,-2294.061;Float;False;Constant;_Color4;Color 4;1;0;Create;0,0,0,0;1,1,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;230;-5524.865,-1550.318;Fixed;False;Property;_Top_mask_level;Top_mask_level;7;0;Create;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;76;-4002.872,-2185.023;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;256;-6359.027,-1795.761;Float;False;_tiling;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;78;-3626.631,-2288.685;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;124;-3359.615,-2362.051;Float;True;Property;_Edge_mask_map_input;Edge_mask_map_input;18;0;Create;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;280;-6031.908,-1195.652;Float;False;256;0;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;67;-3311.615,-2138.051;Float;False;Property;_Edge_wear;Edge_wear;4;0;Create;0.9960846;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;232;-5186.732,-1841.403;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;161;-5821.813,-1196.488;Float;True;Property;_Top_mask_texture;Top_mask_texture;16;0;Create;ddf6344e26e0f7e44a9a606e40d2f832;ddf6344e26e0f7e44a9a606e40d2f832;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;69;-2975.615,-2154.051;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BlendOpsNode;79;-3667.173,-2053.459;Float;False;Darken;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;68;-3007.615,-2378.051;Float;False;Property;_Edge_color;Edge_color;3;0;Create;1,1,1,0;1,1,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;233;-5039.826,-1838.122;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;70;-2767.615,-2170.051;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BlendOpsNode;235;-4891.584,-1839.067;Float;False;PinLight;True;2;0;FLOAT;0,0,0,0;False;1;COLOR;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;267;-4399.145,-1879.132;Float;False;912.7186;354.2639;Smoothness;9;284;289;288;278;172;22;20;170;169;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ColorNode;110;-6040.307,-1364.381;Float;False;Property;_Top_Color;Top_Color;8;0;Create;0.6654717,0.6985294,0.07704367,0;0.654902,0.7058823,0.1490187,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BlendOpsNode;71;-2607.615,-2074.051;Float;False;PinLight;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;276;-4652.612,-1840.73;Float;False;_top_mask;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;281;-3398.188,-1898.772;Float;False;836.6172;391.7167;Albedo_top_mask_blending;6;282;114;113;273;277;275;;1,1,1,1;0;0
Node;AmplifyShaderEditor.LerpOp;112;-5597.958,-1354.816;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;278;-4254.145,-1631.132;Float;False;276;0;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;273;-3356.188,-1654.772;Float;False;270;0;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;277;-3350.188,-1822.772;Float;False;276;0;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;289;-4040.213,-1597.612;Float;False;1;0;COLOR;0.0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;270;-2319.615,-2074.051;Float;False;_base_stone_color;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;274;-5465.781,-1086.372;Float;False;_top_color;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;174;-5148.303,-1229.621;Fixed;False;Property;_Top_mask_normal_intensity;Top_mask_normal_intensity;11;0;Create;0.25;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;269;-5100.303,-1341.621;Float;False;256;0;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;169;-4363.145,-1821.132;Float;False;Property;_Top_mask_smoothness_shift;Top_mask_smoothness_shift;10;0;Create;1;0.283;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;275;-3347.199,-1737.093;Float;False;274;0;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;22;-4344.145,-1718.132;Float;False;Property;_Material_Smoothness_shift;Material_Smoothness_shift;1;0;Create;1;0.568;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;163;-4796.303,-1341.621;Float;True;Property;_Top_mask_normal;Top_mask_normal;17;0;Create;a10e98907b5cb784aa93e62c73c60b1a;a10e98907b5cb784aa93e62c73c60b1a;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;286;-4702.304,-953.6213;Float;False;276;0;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;113;-3075.295,-1819.772;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;288;-3903.211,-1611.612;Float;False;1;0;COLOR;0.0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;170;-4039.144,-1811.132;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;-4047.144,-1687.132;Float;False;2;2;0;FLOAT;0,0,0,0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;173;-4428.305,-1213.621;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0.0,0,0;False;2;FLOAT;0.0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BlendOpsNode;114;-3038.672,-1672.16;Float;False;Exclusion;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;172;-3879.142,-1804.132;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;263;-4225.306,-1184.621;Float;False;_normal_blend;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;282;-2802.188,-1647.772;Float;False;_albedo_top_blend;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;284;-3712.061,-1804.62;Float;False;_smoothness;-1;True;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;285;-3836.587,-1120.751;Float;False;284;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;279;-3804.587,-1024.751;Float;False;262;0;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;283;-3868.587,-1312.751;Float;False;282;0;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;266;-3852.587,-1216.751;Float;False;263;0;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-3580.587,-1344.751;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;beffio/Medieval_Kingdom/Stones;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;False;2;15;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;OFF;OFF;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;8;5;168;0
WireConnection;220;0;218;0
WireConnection;220;1;217;0
WireConnection;265;0;8;0
WireConnection;12;0;11;0
WireConnection;12;1;4;0
WireConnection;224;0;264;0
WireConnection;221;0;12;0
WireConnection;221;1;219;0
WireConnection;221;2;220;0
WireConnection;237;0;272;0
WireConnection;222;0;12;0
WireConnection;222;1;221;0
WireConnection;243;0;237;0
WireConnection;243;1;240;0
WireConnection;227;0;224;2
WireConnection;262;0;62;0
WireConnection;241;0;222;0
WireConnection;241;1;244;0
WireConnection;241;2;243;0
WireConnection;80;0;81;0
WireConnection;80;1;271;0
WireConnection;229;0;226;0
WireConnection;228;0;227;0
WireConnection;228;1;225;0
WireConnection;231;0;228;0
WireConnection;231;1;229;0
WireConnection;242;0;222;0
WireConnection;242;1;241;0
WireConnection;186;0;287;0
WireConnection;76;0;80;0
WireConnection;76;1;74;0
WireConnection;256;0;186;0
WireConnection;78;0;242;0
WireConnection;78;1;77;0
WireConnection;78;2;76;0
WireConnection;232;0;231;0
WireConnection;232;1;230;0
WireConnection;161;1;280;0
WireConnection;69;0;124;0
WireConnection;69;1;67;0
WireConnection;79;0;242;0
WireConnection;79;1;78;0
WireConnection;233;0;232;0
WireConnection;70;0;79;0
WireConnection;70;1;68;0
WireConnection;70;2;69;0
WireConnection;235;0;233;0
WireConnection;235;1;161;0
WireConnection;71;0;79;0
WireConnection;71;1;70;0
WireConnection;276;0;235;0
WireConnection;112;0;110;0
WireConnection;112;2;161;0
WireConnection;289;0;278;0
WireConnection;270;0;71;0
WireConnection;274;0;112;0
WireConnection;163;1;269;0
WireConnection;163;5;174;0
WireConnection;113;0;273;0
WireConnection;113;1;275;0
WireConnection;113;2;277;0
WireConnection;288;0;289;0
WireConnection;170;0;161;4
WireConnection;170;1;169;0
WireConnection;20;0;11;4
WireConnection;20;1;22;0
WireConnection;173;0;8;0
WireConnection;173;1;163;0
WireConnection;173;2;286;0
WireConnection;114;0;273;0
WireConnection;114;1;113;0
WireConnection;172;0;20;0
WireConnection;172;1;170;0
WireConnection;172;2;288;0
WireConnection;263;0;173;0
WireConnection;282;0;114;0
WireConnection;284;0;172;0
WireConnection;0;0;283;0
WireConnection;0;1;266;0
WireConnection;0;4;285;0
WireConnection;0;5;279;0
ASEEND*/
//CHKSM=6FBE482931A5FD0190E54E3BCB1E0CF799608F7A