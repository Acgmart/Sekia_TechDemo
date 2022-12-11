// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "beffio/Medieval_Kingdom/Fire"
{
	Properties
	{
		_BaseColor("Base Color", Color) = (0.1617647,0.1549069,0.1486808,0)
		_Emmisive_color("Emmisive_color", Color) = (1,0.3529412,0,0)
		_Emmisive_Frequency("Emmisive_Frequency", Range( 0 , 3)) = 0.5366361
		_Emmisivemultiply("Emmisive multiply", Range( 0 , 40)) = 19.7
		_Base_Texture("Base_Texture", 2D) = "white" {}
		_Cracksmapcolor("Cracks map color", Color) = (1,0.3517241,0,0)
		_Cracksmapintensity("Cracks map intensity", Range( 0 , 15)) = 4.235294
		_Overallermmisiveintensity("Overall ermmisive intensity", Range( 0 , 15)) = 5
		_Vertex_offset_speed("Vertex_offset_speed", Range( 0 , 1)) = 0.5
		_Vertex_offset_intensity("Vertex_offset_intensity", Range( 0 , 1)) = 0.15
		_Smallnoisecolor("Small noise color", Color) = (1,0.3517241,0,0)
		_Smallnoiseshift("Small noise shift", Range( 0 , 15)) = 1
		_Cracks_map("Cracks_map", 2D) = "white" {}
		_Small_noise_map("Small_noise_map", 2D) = "white" {}
		_Fire_glow_map("Fire_glow_map", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 4.6
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _Base_Texture;
		uniform float4 _Base_Texture_ST;
		uniform float4 _BaseColor;
		uniform float4 _Cracksmapcolor;
		uniform sampler2D _Cracks_map;
		uniform float4 _Cracks_map_ST;
		uniform float _Cracksmapintensity;
		uniform float4 _Smallnoisecolor;
		uniform sampler2D _Small_noise_map;
		uniform float _Smallnoiseshift;
		uniform sampler2D _Fire_glow_map;
		uniform float _Vertex_offset_speed;
		uniform float _Vertex_offset_intensity;
		uniform float4 _Emmisive_color;
		uniform float _Emmisivemultiply;
		uniform float _Emmisive_Frequency;
		uniform float _Overallermmisiveintensity;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float2 uv_TexCoord486 = v.texcoord.xy * float2( 1,1 ) + float2( 0,0 );
			float2 panner488 = ( uv_TexCoord486 + ( _Time.x * _Vertex_offset_speed ) * float2( 0.5,0.5 ));
			float4 _vertex_offset492 = ( tex2Dlod( _Base_Texture, float4( panner488, 0, 0.0) ) * _Vertex_offset_intensity );
			v.vertex.xyz += _vertex_offset492.rgb;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Base_Texture = i.uv_texcoord * _Base_Texture_ST.xy + _Base_Texture_ST.zw;
			float4 blendOpSrc95 = tex2D( _Base_Texture, uv_Base_Texture );
			float4 blendOpDest95 = _BaseColor;
			float4 temp_output_95_0 = ( saturate( ( blendOpSrc95 * blendOpDest95 ) ));
			float2 uv_Cracks_map = i.uv_texcoord * _Cracks_map_ST.xy + _Cracks_map_ST.zw;
			float4 lerpResult356 = lerp( temp_output_95_0 , _Cracksmapcolor , ( tex2D( _Cracks_map, uv_Cracks_map ) * ( float4(1,1,1,0) * _Cracksmapintensity ) ));
			float4 blendOpSrc357 = temp_output_95_0;
			float4 blendOpDest357 = lerpResult356;
			float4 temp_output_357_0 = ( saturate( ( 1.0 - ( 1.0 - blendOpSrc357 ) * ( 1.0 - blendOpDest357 ) ) ));
			float2 uv_TexCoord476 = i.uv_texcoord * float2( 1,1 ) + float2( 0,0 );
			float2 panner479 = ( uv_TexCoord476 + ( _Time.x * 0.01 ) * float2( 0.5,0.5 ));
			float2 _time2480 = panner479;
			float4 lerpResult365 = lerp( temp_output_357_0 , _Smallnoisecolor , ( tex2D( _Small_noise_map, _time2480 ) * ( float4(1,1,1,0) * _Smallnoiseshift ) ).r);
			float4 blendOpSrc366 = temp_output_357_0;
			float4 blendOpDest366 = lerpResult365;
			float4 temp_output_366_0 = ( saturate( ( 1.0 - ( 1.0 - blendOpSrc366 ) * ( 1.0 - blendOpDest366 ) ) ));
			float2 uv_TexCoord313 = i.uv_texcoord * float2( 1,1 ) + float2( 0,0 );
			float2 panner315 = ( uv_TexCoord313 + ( _Time.x * 0.02 ) * float2( 0.5,0.5 ));
			float2 _time436 = panner315;
			float4 tex2DNode319 = tex2D( _Fire_glow_map, _time436 );
			float4 lerpResult241 = lerp( temp_output_366_0 , float4(1,0.3517241,0,0) , tex2DNode319.r);
			float4 blendOpSrc243 = temp_output_366_0;
			float4 blendOpDest243 = lerpResult241;
			float4 _fire_color442 = ( saturate( (( blendOpDest243 > 0.5 ) ? ( 1.0 - ( 1.0 - 2.0 * ( blendOpDest243 - 0.5 ) ) * ( 1.0 - blendOpSrc243 ) ) : ( 2.0 * blendOpDest243 * blendOpSrc243 ) ) ));
			float2 uv_TexCoord486 = i.uv_texcoord * float2( 1,1 ) + float2( 0,0 );
			float2 panner488 = ( uv_TexCoord486 + ( _Time.x * _Vertex_offset_speed ) * float2( 0.5,0.5 ));
			float4 _vertex_offset492 = ( tex2D( _Base_Texture, panner488 ) * _Vertex_offset_intensity );
			float4 blendOpSrc500 = _fire_color442;
			float4 blendOpDest500 = _vertex_offset492;
			o.Albedo = ( saturate(  (( blendOpSrc500 > 0.5 ) ? ( 1.0 - ( 1.0 - 2.0 * ( blendOpSrc500 - 0.5 ) ) * ( 1.0 - blendOpDest500 ) ) : ( 2.0 * blendOpSrc500 * blendOpDest500 ) ) )).rgb;
			float _frequency433 = (sin( ( _Time.y * _Emmisive_Frequency ) )*0.5 + 0.5);
			float4 blendOpSrc395 = lerpResult356;
			float4 blendOpDest395 = ( ( ( _Emmisive_color * _Emmisivemultiply ) * _frequency433 ) * ( tex2DNode319 * ( float4(1,1,1,0) * 10.0 ) ) );
			float4 blendOpSrc396 = lerpResult365;
			float4 blendOpDest396 = ( saturate( ( 1.0 - ( 1.0 - blendOpSrc395 ) * ( 1.0 - blendOpDest395 ) ) ));
			float4 _emmisive445 = ( ( saturate( ( 1.0 - ( 1.0 - blendOpSrc396 ) * ( 1.0 - blendOpDest396 ) ) )) * _Overallermmisiveintensity );
			o.Emission = _emmisive445.rgb;
			o.Smoothness = 0.0;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=14201
0;90;1920;1046;3130.857;529.1966;2.280832;False;False
Node;AmplifyShaderEditor.CommentaryNode;432;-2836.373,630.4619;Float;False;936.4611;320.9958;Frequency;7;433;392;373;372;370;368;369;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;424;-2224.688,-200.1115;Float;False;867.2271;560.5134;Cracks_color;11;357;356;354;355;353;352;350;351;503;504;505;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;473;-1023.179,870.5314;Float;False;832.4;549.9;Time2;7;480;479;477;478;476;475;474;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;368;-2821.373,829.4615;Float;False;Property;_Emmisive_Frequency;Emmisive_Frequency;2;0;Create;0.5366361;0;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;474;-927.1786,1318.532;Float;False;Constant;_Float0;Float 0;8;0;Create;0.01;0.02;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TimeNode;475;-975.1786,1174.532;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;350;-2176.688,215.8885;Float;False;Property;_Cracksmapintensity;Cracks map intensity;6;0;Create;4.235294;1.5;0;15;0;1;FLOAT;0
Node;AmplifyShaderEditor.TimeNode;369;-2804.373,686.4619;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;351;-2112.688,39.8885;Float;False;Constant;_Color2;Color 2;8;0;Create;1,1,1,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;435;-1858.568,867.0204;Float;False;823.9779;552.0555;Time;7;436;315;313;314;312;321;311;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;370;-2585.374,690.4619;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;476;-975.1786,918.5313;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;499;-3073.795,372.2325;Float;True;Property;_Base_Texture;Base_Texture;4;0;Create;e22a11ad522d7d2488a749b3df99fd58;e22a11ad522d7d2488a749b3df99fd58;False;white;Auto;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.Vector2Node;477;-943.1786,1046.532;Float;False;Constant;_Vector1;Vector 1;10;0;Create;0.5,0.5;0.5,0.5;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;478;-751.1788,1190.532;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;321;-1762.568,1315.021;Float;False;Constant;_Speed;Speed;8;0;Create;0.02;0.015;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;352;-2175.688,-152.1115;Float;True;Property;_Cracks_map;Cracks_map;13;0;Create;c7d2837421252d6409ca92e28f209238;c7d2837421252d6409ca92e28f209238;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TimeNode;311;-1810.568,1171.021;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;353;-1888.688,23.88852;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;423;-2770.386,-59.51146;Float;False;525.9409;428.0712;Base color;3;95;273;89;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ColorNode;355;-1840.688,-152.1115;Float;False;Property;_Cracksmapcolor;Cracks map color;5;0;Create;1,0.3517241,0,0;1,0,0,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;314;-1778.568,1043.021;Float;False;Constant;_Vector0;Vector 0;10;0;Create;0.5,0.5;0.5,0.5;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;312;-1586.568,1187.021;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;425;-1339.489,-195.9114;Float;False;1001.37;547;Small_noise_color;9;366;365;363;362;364;481;361;360;359;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;373;-2551.374,840.4614;Float;False;Constant;_Float2;Float 2;-1;0;Create;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;313;-1810.568,915.0203;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;479;-591.179,1062.532;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1.0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SinOpNode;372;-2437.374,690.4619;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;273;-2742.386,162.4885;Float;True;Property;_Base_shape;Base_shape;12;0;Create;e22a11ad522d7d2488a749b3df99fd58;e22a11ad522d7d2488a749b3df99fd58;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;89;-2741.386,-10.51149;Float;False;Property;_BaseColor;Base Color;0;0;Create;0.1617647,0.1549069,0.1486808,0;0.1617647,0.1549069,0.1486808,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;354;-1760.689,7.888494;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;504;-1858.469,217.9336;Float;False;1;0;COLOR;0.0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;503;-1873.469,261.9336;Float;False;1;0;COLOR;0.0;False;1;COLOR;0
Node;AmplifyShaderEditor.PannerNode;315;-1426.568,1059.021;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1.0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BlendOpsNode;95;-2460.387,-0.5115051;Float;False;Multiply;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;359;-1317.489,234.0885;Float;False;Property;_Smallnoiseshift;Small noise shift;12;0;Create;1;1.5;0;15;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;360;-1322.489,69.08853;Float;False;Constant;_Color4;Color 4;8;0;Create;1,1,1,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;440;-240.7019,-190.8318;Float;False;715.9122;523.1075;Fire_glow_maps;6;267;268;266;319;265;437;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;422;-1862.103,407.0243;Float;False;583.7731;420.6872;Emmisive_color;6;502;434;379;385;374;375;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;392;-2309.373,689.4619;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;1.0;False;2;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;481;-1319.231,-125.5841;Float;False;480;0;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;480;-399.179,1046.532;Float;False;_time2;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;505;-1644.469,131.9336;Float;False;1;0;COLOR;0.0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;482;-67.3502,356.1261;Float;False;1001.92;538.0011;Vertex_movement;10;492;491;489;490;488;487;484;483;485;486;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;267;-210.1193,186.9417;Float;False;Constant;_Fire_Glow_intensity;Fire_Glow_intensity;10;0;Create;10;1.5;0;25;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;437;-213.7154,-142.8318;Float;False;436;0;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;436;-1240.884,1065.765;Float;False;_time;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;362;-1043.488,77.08853;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;433;-2113.373,691.4618;Float;False;_frequency;-1;True;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;361;-1116.489,-122.9115;Float;True;Property;_Small_noise_map;Small_noise_map;14;0;Create;ef11cdaa9fb31f2489c4359977149e7b;ef11cdaa9fb31f2489c4359977149e7b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;374;-1830.103,635.0244;Float;False;Property;_Emmisivemultiply;Emmisive multiply;3;0;Create;19.7;0;0;40;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;375;-1828.103,460.0242;Float;False;Property;_Emmisive_color;Emmisive_color;1;0;Create;1,0.3529412,0,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;356;-1802.689,192.8885;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;2;COLOR;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;265;-221.3619,-17.14897;Float;False;Constant;_Color1;Color 1;8;0;Create;1,1,1,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;434;-1815.103,726.0244;Float;False;433;0;1;FLOAT;0
Node;AmplifyShaderEditor.TimeNode;483;-49.35019,656.1267;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;484;-45.35019,801.127;Float;False;Property;_Vertex_offset_speed;Vertex_offset_speed;8;0;Create;0.5;2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;502;-1499.732,726.9092;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BlendOpsNode;357;-1589.689,111.8885;Float;False;Screen;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;363;-862.4887,168.0885;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;385;-1587.102,468.0241;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;364;-799.4886,-123.9115;Float;False;Property;_Smallnoisecolor;Small noise color;10;0;Create;1,0.3517241,0,0;1,0,0,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;319;-10.72741,-107.6887;Float;True;Property;_Fire_glow_map;Fire_glow_map;16;0;Create;e22a11ad522d7d2488a749b3df99fd58;e22a11ad522d7d2488a749b3df99fd58;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;268;107.9262,102.1843;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector2Node;485;-49.35025,527.1267;Float;False;Constant;_Vector2;Vector 2;10;0;Create;0.5,0.5;0.5,0.5;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.LerpOp;365;-684.4887,140.0885;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;441;493.5889,-61.05412;Float;False;448.2759;398.4449;Glow color;3;241;243;242;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;266;313.8164,21.38821;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;379;-1429.102,469.0241;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;486;-55.56077,409.9802;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;487;225.6495,689.1267;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;439;-1245.237,417.4629;Float;False;981.2113;317.309;Overall_emmisive;6;445;420;421;396;395;380;;1,1,1,1;0;0
Node;AmplifyShaderEditor.PannerNode;488;205.6496,415.1262;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1.0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;242;541.5891,-13.05411;Float;False;Constant;_Fire_glow_color;Fire_glow_color;10;0;Create;1,0.3517241,0,0;1,0,0,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;380;-1197.237,465.4628;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BlendOpsNode;366;-582.4883,12.08844;Float;False;Screen;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;489;165.6496,613.1266;Float;False;Property;_Vertex_offset_intensity;Vertex_offset_intensity;9;0;Create;0.15;0.15;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;241;560.5889,186.946;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;490;390.6374,418.7522;Float;True;Property;_Fire_move_map;Fire_move_map;14;0;Create;c9975cd677f4eb0458b87fe80af7373e;4ee6590d155bdcb4db3ce5ff5f0f13ec;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BlendOpsNode;395;-1054.295,464.8811;Float;False;Screen;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;420;-1198.605,578.7731;Float;False;Property;_Overallermmisiveintensity;Overall ermmisive intensity;7;0;Create;5;0;0;15;0;1;FLOAT;0
Node;AmplifyShaderEditor.BlendOpsNode;396;-842.0558,461.328;Float;False;Screen;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;491;459.1457,627.0586;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BlendOpsNode;243;731.5892,180.9459;Float;False;Overlay;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;492;706.6494,570.1267;Float;False;_vertex_offset;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;448;-2760.783,390.0221;Float;False;856.3848;215.2771;Tiling;3;451;450;452;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;443;196.3879,1014.326;Float;False;442;0;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;501;164.3879,1094.326;Float;False;492;0;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;421;-626.3042,463.6968;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;442;970.551,194.0001;Float;False;_fire_color;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;446;420.3879,1142.326;Float;False;445;0;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;450;-2438.824,440.0221;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;493;388.3879,1334.326;Float;False;492;0;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;444;404.3879,1238.326;Float;False;Constant;_Smoothness_Shift;Smoothness_Shift;7;0;Create;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;445;-485.1495,461.3279;Float;False;_emmisive;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;452;-2734.127,441.2437;Float;False;Property;_Fire_tiling;Fire_tiling;15;0;Create;1;1;0.1;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;451;-2147.403,468.6469;Float;False;_tiling;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BlendOpsNode;500;420.3879,1014.326;Float;False;HardLight;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;692.388,982.3256;Float;False;True;6;Float;ASEMaterialInspector;0;0;Standard;beffio/Medieval_Kingdom/Fire;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Custom;0;True;True;0;True;TransparentCutout;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;False;2;15;10;25;True;0.5;True;0;Zero;Zero;0;Zero;Zero;OFF;OFF;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;11;-1;-1;-1;0;0;0;False;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;370;0;369;2
WireConnection;370;1;368;0
WireConnection;478;0;475;1
WireConnection;478;1;474;0
WireConnection;353;0;351;0
WireConnection;353;1;350;0
WireConnection;312;0;311;1
WireConnection;312;1;321;0
WireConnection;479;0;476;0
WireConnection;479;2;477;0
WireConnection;479;1;478;0
WireConnection;372;0;370;0
WireConnection;273;0;499;0
WireConnection;354;0;352;0
WireConnection;354;1;353;0
WireConnection;504;0;355;0
WireConnection;503;0;354;0
WireConnection;315;0;313;0
WireConnection;315;2;314;0
WireConnection;315;1;312;0
WireConnection;95;0;273;0
WireConnection;95;1;89;0
WireConnection;392;0;372;0
WireConnection;392;1;373;0
WireConnection;392;2;373;0
WireConnection;480;0;479;0
WireConnection;505;0;95;0
WireConnection;436;0;315;0
WireConnection;362;0;360;0
WireConnection;362;1;359;0
WireConnection;433;0;392;0
WireConnection;361;1;481;0
WireConnection;356;0;95;0
WireConnection;356;1;504;0
WireConnection;356;2;503;0
WireConnection;502;0;434;0
WireConnection;357;0;505;0
WireConnection;357;1;356;0
WireConnection;363;0;361;0
WireConnection;363;1;362;0
WireConnection;385;0;375;0
WireConnection;385;1;374;0
WireConnection;319;1;437;0
WireConnection;268;0;265;0
WireConnection;268;1;267;0
WireConnection;365;0;357;0
WireConnection;365;1;364;0
WireConnection;365;2;363;0
WireConnection;266;0;319;0
WireConnection;266;1;268;0
WireConnection;379;0;385;0
WireConnection;379;1;502;0
WireConnection;487;0;483;1
WireConnection;487;1;484;0
WireConnection;488;0;486;0
WireConnection;488;2;485;0
WireConnection;488;1;487;0
WireConnection;380;0;379;0
WireConnection;380;1;266;0
WireConnection;366;0;357;0
WireConnection;366;1;365;0
WireConnection;241;0;366;0
WireConnection;241;1;242;0
WireConnection;241;2;319;0
WireConnection;490;0;499;0
WireConnection;490;1;488;0
WireConnection;395;0;356;0
WireConnection;395;1;380;0
WireConnection;396;0;365;0
WireConnection;396;1;395;0
WireConnection;491;0;490;0
WireConnection;491;1;489;0
WireConnection;243;0;366;0
WireConnection;243;1;241;0
WireConnection;492;0;491;0
WireConnection;421;0;396;0
WireConnection;421;1;420;0
WireConnection;442;0;243;0
WireConnection;450;0;452;0
WireConnection;445;0;421;0
WireConnection;451;0;450;0
WireConnection;500;0;443;0
WireConnection;500;1;501;0
WireConnection;0;0;500;0
WireConnection;0;2;446;0
WireConnection;0;4;444;0
WireConnection;0;11;493;0
ASEEND*/
//CHKSM=EE31D5CE4863A3D9AB33D93144ABC969EF07C1B9