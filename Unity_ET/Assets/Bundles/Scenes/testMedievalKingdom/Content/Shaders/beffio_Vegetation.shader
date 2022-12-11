// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "beffio/Medieval_Kingdom/Vegetation"
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
		_Cutoff( "Mask Clip Value", Float ) = 0
		_Albedo_map_input("Albedo_map_input", 2D) = "white" {}
		_2nd_color_mask_input("2nd_color_mask_input", 2D) = "white" {}
		_Ambient_Occlusion_map_input("Ambient_Occlusion_map_input", 2D) = "white" {}
		_Alpha_cutout_mask_map_input("Alpha_cutout_mask_map_input", 2D) = "white" {}
		_Wind_noise("Wind_noise", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Geometry+0" }
		Cull Off
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float2 uv_texcoord;
		};

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
		uniform sampler2D _Wind_noise;
		uniform float _Wind_speed;
		uniform float _Wind_power_multiply;
		uniform float _Cutoff = 0;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float2 uv_TexCoord313 = v.texcoord.xy * float2( 1,1 ) + float2( 0,0 );
			float2 panner315 = ( uv_TexCoord313 + ( _Time.x * _Wind_speed ) * float2( 0.5,0.5 ));
			float4 _wind343 = ( tex2Dlod( _Wind_noise, float4( panner315, 0, 0.0) ) * _Wind_power_multiply );
			v.vertex.xyz += _wind343.rgb;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Albedo_map_input = i.uv_texcoord * _Albedo_map_input_ST.xy + _Albedo_map_input_ST.zw;
			float4 tex2DNode273 = tex2D( _Albedo_map_input, uv_Albedo_map_input );
			float4 blendOpSrc95 = tex2DNode273;
			float4 blendOpDest95 = _Base_Color;
			float4 temp_output_95_0 = ( saturate( ( blendOpSrc95 * blendOpDest95 ) ));
			float2 uv_2nd_color_mask_input = i.uv_texcoord * _2nd_color_mask_input_ST.xy + _2nd_color_mask_input_ST.zw;
			float4 lerpResult241 = lerp( temp_output_95_0 , _2nd_color , ( tex2D( _2nd_color_mask_input, uv_2nd_color_mask_input ) * ( float4(1,1,1,0) * _2nd_color_intensity ) ).r);
			float4 blendOpSrc243 = temp_output_95_0;
			float4 blendOpDest243 = lerpResult241;
			float4 temp_output_243_0 = ( saturate( (( blendOpDest243 > 0.5 ) ? ( 1.0 - ( 1.0 - 2.0 * ( blendOpDest243 - 0.5 ) ) * ( 1.0 - blendOpSrc243 ) ) : ( 2.0 * blendOpDest243 * blendOpSrc243 ) ) ));
			float2 uv_Ambient_Occlusion_map_input = i.uv_texcoord * _Ambient_Occlusion_map_input_ST.xy + _Ambient_Occlusion_map_input_ST.zw;
			float4 _AO336 = tex2D( _Ambient_Occlusion_map_input, uv_Ambient_Occlusion_map_input );
			float4 blendOpSrc327 = float4(1,1,1,0);
			float4 blendOpDest327 = _AO336;
			float4 lerpResult324 = lerp( temp_output_243_0 , float4(0,0,0,0) , ( ( saturate( abs( blendOpSrc327 - blendOpDest327 ) )) * _AO_Intensity ).r);
			float4 blendOpSrc325 = temp_output_243_0;
			float4 blendOpDest325 = lerpResult324;
			float4 _albedo345 = ( saturate( min( blendOpSrc325 , blendOpDest325 ) ));
			o.Albedo = _albedo345.rgb;
			float4 _smoothness339 = ( tex2DNode273 * _Smoothness_Shift );
			o.Smoothness = _smoothness339.r;
			o.Occlusion = _AO336.r;
			o.Alpha = 1;
			float2 uv_Alpha_cutout_mask_map_input = i.uv_texcoord * _Alpha_cutout_mask_map_input_ST.xy + _Alpha_cutout_mask_map_input_ST.zw;
			float4 _alpha341 = tex2D( _Alpha_cutout_mask_map_input, uv_Alpha_cutout_mask_map_input );
			clip( _alpha341.r - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=14201
0;90;1920;1046;1789.19;248.8679;1.773723;False;False
Node;AmplifyShaderEditor.CommentaryNode;334;-993,383;Float;False;910.1047;648.5859;2nd_color_mask_input;8;242;243;266;277;268;241;265;267;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;267;-968,934;Float;False;Property;_2nd_color_intensity;2nd_color_intensity;3;0;Create;1.5;1.5;0;1.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;265;-952,774;Float;False;Constant;_Color1;Color 1;8;0;Create;1,1,1,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;333;-1568,304;Float;False;541.0299;442.3094;Albedo_map_input;3;95;273;89;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;330;-639.8638,93.2566;Float;False;624;285;Ambient_Occlusion_map_input;2;336;278;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;277;-967,593;Float;True;Property;_2nd_color_mask_input;2nd_color_mask_input;9;0;Create;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;268;-656,916;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;273;-1520,528;Float;True;Property;_Albedo_map_input;Albedo_map_input;8;0;Create;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;89;-1520,368;Float;False;Property;_Base_Color;Base_Color;0;0;Create;0.3529412,0.5450981,0.2235294,0;0.850876,1,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;335;27,517;Float;False;1043.48;517.0767;AO_diff_blend;9;345;325;324;323;322;327;326;338;328;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;278;-607.8638,157.2565;Float;True;Property;_Ambient_Occlusion_map_input;Ambient_Occlusion_map_input;10;0;Create;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;332;41.82613,0.6857758;Float;False;1073.92;491.0011;Wind;10;343;318;316;319;321;312;315;311;314;313;;1,1,1,1;0;0
Node;AmplifyShaderEditor.BlendOpsNode;95;-1264,368;Float;False;Multiply;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;266;-625.3877,656;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;321;57.82614,416.6859;Float;False;Property;_Wind_speed;Wind_speed;5;0;Create;1;2;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.TimeNode;311;57.82614,272.6859;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;336;-239.8634,205.2565;Float;False;_AO;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;338;75,773;Float;False;336;0;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;328;75,565;Float;False;Constant;_Color2;Color 2;17;0;Create;1,1,1,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;242;-967,434;Float;False;Property;_2nd_color;2nd_color;2;0;Create;1,1,1,0;1,0,0,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;313;57.82614,48.68583;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;241;-483,906;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector2Node;314;57.82614,160.6858;Float;False;Constant;_Vector0;Vector 0;10;0;Create;0.5,0.5;0.5,0.5;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;312;297.8262,240.6859;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;326;59,885;Float;False;Property;_AO_Intensity;AO_Intensity;4;0;Create;1;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.BlendOpsNode;327;331,741;Float;False;Difference;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.PannerNode;315;297.8262,48.68583;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1.0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;323;403,890;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;322;337,574;Float;False;Constant;_Color0;Color 0;1;0;Create;0,0,0,0;1,1,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BlendOpsNode;243;-299,910;Float;False;Overlay;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;329;-1375.243,73.33742;Float;False;688.797;183;Smoothness;3;339;281;282;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;316;345.8262,352.6859;Float;False;Property;_Wind_power_multiply;Wind_power_multiply;6;0;Create;0.15;0.15;0;0.2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;319;473.8262,48.68583;Float;True;Property;_Wind_noise;Wind_noise;12;0;Create;4ee6590d155bdcb4db3ce5ff5f0f13ec;4ee6590d155bdcb4db3ce5ff5f0f13ec;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;282;-1362.243,136.3375;Float;False;Property;_Smoothness_Shift;Smoothness_Shift;1;0;Create;1;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;331;-1712,800;Float;False;684.9999;300;Alpha_cutout_mask_map_input;2;341;276;;1,1,1,1;0;0
Node;AmplifyShaderEditor.LerpOp;324;569,674;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;281;-1062.243,119.3375;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BlendOpsNode;325;608,888;Float;False;Darken;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;276;-1664,848;Float;True;Property;_Alpha_cutout_mask_map_input;Alpha_cutout_mask_map_input;11;0;Create;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;318;745.8261,240.6859;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;337;1119.425,767.4858;Float;False;336;0;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;342;1119.425,863.4857;Float;False;341;0;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;344;1119.425,959.4856;Float;False;343;0;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;346;1119.425,543.4857;Float;False;345;0;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;340;1087.425,671.4858;Float;False;339;0;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;339;-916.2421,128.3375;Float;False;_smoothness;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;343;889.8261,256.6859;Float;False;_wind;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;341;-1280,960;Float;False;_alpha;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;345;848.6379,903.9327;Float;False;_albedo;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1344,576;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;beffio/Medieval_Kingdom/Vegetation;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;0;False;0;0;Custom;0;True;True;0;True;TransparentCutout;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;False;2;15;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;OFF;OFF;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;7;-1;-1;-1;0;0;0;False;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
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
WireConnection;0;0;346;0
WireConnection;0;4;340;0
WireConnection;0;5;337;0
WireConnection;0;10;342;0
WireConnection;0;11;344;0
ASEEND*/
//CHKSM=03E1059F6A6F91B90E841F25682DAC233C711D97