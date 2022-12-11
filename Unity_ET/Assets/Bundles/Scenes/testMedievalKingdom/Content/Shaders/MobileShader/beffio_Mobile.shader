// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "beffio/Medieval_Kingdom/Mobile"
{
	Properties
	{
		_Base_color("Base_color", Color) = (0.427451,0.227451,0.1372549,0)
		_Cutoff( "Mask Clip Value", Float ) = 0
		_Detail_color("Detail_color", Color) = (0.2720588,0.2720588,0.2720588,0)
		_Detail_level("Detail_level", Range( 0 , 1)) = 1
		_Alpha_cutout_level("Alpha_cutout_level", Range( 0 , 1)) = 1
		_Smoothness_shift("Smoothness_shift", Range( 0 , 5)) = 0.1
		_Normal_intensity("Normal_intensity", Range( 0 , 2)) = 1
		_Emmisive_color("Emmisive_color", Color) = (0.9779412,0.9210103,0.6831207,0)
		_Emmisive_intensity("Emmisive_intensity", Range( 0 , 100)) = 0
		_Albedo_smoothness_map_input("Albedo_smoothness_map_input", 2D) = "white" {}
		_Detail_mask_1_map_input("Detail_mask_1_map_input", 2D) = "white" {}
		_Alpha_cutout_mask_map_input("Alpha_cutout_mask_map_input", 2D) = "white" {}
		_Emmisvie_map_input("Emmisvie_map_input", 2D) = "white" {}
		_Tilling("Tilling", Range( 0.1 , 20)) = 1
		_Normal_map_input("Normal_map_input", 2D) = "bump" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			fixed2 uv_texcoord;
		};

		uniform fixed _Normal_intensity;
		uniform sampler2D _Normal_map_input;
		uniform fixed _Tilling;
		uniform sampler2D _Albedo_smoothness_map_input;
		uniform fixed4 _Base_color;
		uniform fixed4 _Detail_color;
		uniform sampler2D _Detail_mask_1_map_input;
		uniform fixed _Detail_level;
		uniform sampler2D _Emmisvie_map_input;
		uniform float4 _Emmisvie_map_input_ST;
		uniform fixed4 _Emmisive_color;
		uniform fixed _Emmisive_intensity;
		uniform fixed _Smoothness_shift;
		uniform sampler2D _Alpha_cutout_mask_map_input;
		uniform float4 _Alpha_cutout_mask_map_input_ST;
		uniform fixed _Alpha_cutout_level;
		uniform float _Cutoff = 0;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			fixed2 temp_cast_0 = (_Tilling).xx;
			float2 uv_TexCoord73 = i.uv_texcoord * temp_cast_0;
			float2 _tiling100 = uv_TexCoord73;
			float3 _normal169 = UnpackScaleNormal( tex2D( _Normal_map_input, _tiling100 ) ,_Normal_intensity );
			o.Normal = _normal169;
			fixed4 tex2DNode11 = tex2D( _Albedo_smoothness_map_input, _tiling100 );
			fixed4 blendOpSrc12 = tex2DNode11;
			fixed4 blendOpDest12 = _Base_color;
			float4 lerpResult46 = lerp( ( saturate( (( blendOpDest12 > 0.5 ) ? ( 1.0 - ( 1.0 - 2.0 * ( blendOpDest12 - 0.5 ) ) * ( 1.0 - blendOpSrc12 ) ) : ( 2.0 * blendOpDest12 * blendOpSrc12 ) ) )) , _Detail_color , ( tex2D( _Detail_mask_1_map_input, _tiling100 ) * _Detail_level ).r);
			float4 _albedo122 = lerpResult46;
			o.Albedo = _albedo122.rgb;
			float2 uv_Emmisvie_map_input = i.uv_texcoord * _Emmisvie_map_input_ST.xy + _Emmisvie_map_input_ST.zw;
			float4 _emmision162 = ( ( tex2D( _Emmisvie_map_input, uv_Emmisvie_map_input ) * _Emmisive_color ) * _Emmisive_intensity );
			o.Emission = _emmision162.rgb;
			o.Smoothness = ( tex2DNode11.a * _Smoothness_shift );
			o.Alpha = 1;
			float2 uv_Alpha_cutout_mask_map_input = i.uv_texcoord * _Alpha_cutout_mask_map_input_ST.xy + _Alpha_cutout_mask_map_input_ST.zw;
			float4 _alpha114 = ( tex2D( _Alpha_cutout_mask_map_input, uv_Alpha_cutout_mask_map_input ) * _Alpha_cutout_level );
			clip( _alpha114.r - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15304
345;198;2198;1235;7861.713;896.9497;1;True;True
Node;AmplifyShaderEditor.RangedFloatNode;154;-8625.493,-629.0788;Float;False;Property;_Tilling;Tilling;16;0;Create;True;0;0;False;0;1;1;0.1;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;121;-8704.349,-1397.8;Float;False;1869.635;647.6763;Albedo;2;101;164;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;73;-8346.129,-644.7358;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;164;-8215.453,-852.7983;Float;False;100;0;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;100;-8042.128,-612.7358;Float;False;_tiling;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;101;-8680.926,-1087.175;Float;False;100;0;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;11;-8493.98,-1108.265;Float;True;Property;_Albedo_smoothness_map_input;Albedo_smoothness_map_input;11;0;Create;True;0;0;False;0;3320889b6ffef344396a6dc6a830a0d5;7aeb2f3236f5c0849b30392dae134dd4;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;4;-8479.752,-1280.972;Float;False;Property;_Base_color;Base_color;0;0;Create;True;0;0;False;0;0.427451,0.227451,0.1372549,0;0.5441177,0.5401169,0.5401169,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;5;-7883.596,-1116.606;Float;True;Property;_Detail_mask_1_map_input;Detail_mask_1_map_input;12;0;Create;True;0;0;False;0;7a947e26d6355c94898b3bf52c6e07da;68d61436495dbb14f9522dd544319815;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;165;-8648.863,524.1825;Float;False;998.8794;334;Normal_map_input;4;169;168;167;166;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;37;-7897.817,-906.3498;Float;False;Property;_Detail_level;Detail_level;3;0;Create;True;0;0;False;0;1;0.651;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;157;-7272.222,583.3845;Float;True;Property;_Emmisvie_map_input;Emmisvie_map_input;14;0;Create;True;0;0;False;0;None;bf4f316643266a343872b8dc3a4e2e89;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;158;-7265.598,418.0027;Float;False;Property;_Emmisive_color;Emmisive_color;9;0;Create;True;0;0;False;0;0.9779412,0.9210103,0.6831207,0;0.2438365,0.8088235,0.7493508,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;93;-8483.574,-407.2286;Float;True;Property;_Alpha_cutout_mask_map_input;Alpha_cutout_mask_map_input;13;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;36;-7562.018,-929.4117;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;159;-6980.715,448.3786;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;34;-7910.79,-1290.636;Float;False;Property;_Detail_color;Detail_color;2;0;Create;True;0;0;False;0;0.2720588,0.2720588,0.2720588,0;1,1,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BlendOpsNode;12;-8128.436,-1121.944;Float;False;Overlay;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;167;-8584.863,732.1825;Float;False;Property;_Normal_intensity;Normal_intensity;8;0;Create;True;0;0;False;0;1;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;166;-8488.863,604.1825;Float;False;100;0;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;92;-8461.617,-212.9014;Float;False;Property;_Alpha_cutout_level;Alpha_cutout_level;5;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;160;-7271.87,782.6198;Float;False;Property;_Emmisive_intensity;Emmisive_intensity;10;0;Create;True;0;0;False;0;0;8.1;0;100;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;46;-7383.564,-1026.689;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;168;-8280.863,572.1825;Float;True;Property;_Normal_map_input;Normal_map_input;17;0;Create;True;0;0;False;0;None;3471f84fbdc9ec541a70bff97f2d5035;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;91;-8171.186,-403.8396;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;161;-6907.858,614.0685;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;137;-6903.896,-346.9337;Float;False;Property;_Smoothness_shift;Smoothness_shift;6;0;Create;True;0;0;False;0;0.1;1;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;170;-6582.221,-590.8319;Float;False;169;0;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;115;-6569.208,-281.3063;Float;False;114;0;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;122;-7048.171,-1093.116;Float;True;_albedo;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;150;-8009.298,326.3601;Float;False;_win;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;163;-6599.275,-520.2581;Float;False;162;0;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;151;-6549.985,-150.8784;Float;False;150;0;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;123;-6588,-690;Float;False;122;0;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;155;-6562.242,-399.4301;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;162;-6743.229,623.4076;Float;False;_emmision;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;114;-8024.565,-408.5516;Float;False;_alpha;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;169;-7864.863,716.1825;Float;False;_normal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;143;-8607.942,158.0806;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;145;-8559.942,270.0806;Float;False;Property;_Wind_power_multiply;Wind_power_multiply;7;0;Create;True;0;0;False;0;0;0;0;0.2;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;142;-8847.942,78.08057;Float;False;Constant;_Vector0;Vector 0;10;0;Create;True;0;0;False;0;0.5,0.5;0.5,0.5;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TexturePropertyNode;152;-8442.545,59.94793;Float;True;Property;_Windnoisemap;Wind noise map;15;0;Create;True;0;0;False;0;4ee6590d155bdcb4db3ce5ff5f0f13ec;4ee6590d155bdcb4db3ce5ff5f0f13ec;False;white;Auto;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.PannerNode;144;-8607.942,-33.91957;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;139;-8847.942,334.0805;Float;False;Property;_Wind_speed;Wind_speed;4;0;Create;True;0;0;False;0;0;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;147;-8221.65,291.1365;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;146;-8166.808,-22.13046;Float;True;Property;_wind_noise;wind_noise;14;0;Create;True;0;0;False;0;4ee6590d155bdcb4db3ce5ff5f0f13ec;4ee6590d155bdcb4db3ce5ff5f0f13ec;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;141;-8847.942,-33.91957;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TimeNode;140;-8847.942,190.0807;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-6023.619,-576;Fixed;False;True;2;Fixed;ASEMaterialInspector;0;0;Standard;beffio/Medieval_Kingdom/Mobile;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0;True;True;0;True;TransparentCutout;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;-1;False;-1;-1;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;1;-1;-1;-1;0;0;0;False;0;0;0;False;-1;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;113;-8533.574,-457.2286;Float;False;730.368;344.2644;Alpha_cutout_mask_map_input;0;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;156;-7292.222,367.0016;Float;False;754.9919;518.6198;Emmisive_mask_map_input;0;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;104;-8666.129,-692.7358;Float;False;856.3848;215.2771;Tiling;0;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;107;-8682.028,-1333.759;Float;False;712.6123;438.0623;Albedo_smoothness_map_input;0;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;105;-7940.515,-1347.8;Float;False;660.3844;558.4139;Detail_mask_1_map_input;0;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;138;-8863.942,-81.91955;Float;False;1073.92;491.0011;Wind;0;;1,1,1,1;0;0
WireConnection;73;0;154;0
WireConnection;100;0;73;0
WireConnection;11;1;101;0
WireConnection;5;1;164;0
WireConnection;36;0;5;0
WireConnection;36;1;37;0
WireConnection;159;0;157;0
WireConnection;159;1;158;0
WireConnection;12;0;11;0
WireConnection;12;1;4;0
WireConnection;46;0;12;0
WireConnection;46;1;34;0
WireConnection;46;2;36;0
WireConnection;168;1;166;0
WireConnection;168;5;167;0
WireConnection;91;0;93;0
WireConnection;91;1;92;0
WireConnection;161;0;159;0
WireConnection;161;1;160;0
WireConnection;122;0;46;0
WireConnection;150;0;147;0
WireConnection;155;0;11;4
WireConnection;155;1;137;0
WireConnection;162;0;161;0
WireConnection;114;0;91;0
WireConnection;169;0;168;0
WireConnection;143;0;140;1
WireConnection;143;1;139;0
WireConnection;144;0;141;0
WireConnection;144;2;142;0
WireConnection;144;1;143;0
WireConnection;147;0;146;0
WireConnection;147;1;145;0
WireConnection;146;0;152;0
WireConnection;146;1;144;0
WireConnection;0;0;123;0
WireConnection;0;1;170;0
WireConnection;0;2;163;0
WireConnection;0;4;155;0
WireConnection;0;10;115;0
ASEEND*/
//CHKSM=8B75B097B57342A0C2FAB8057DCBF905B76F3E6E