// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "beffio/Medieval_Kingdom/Shafts"
{
	Properties
	{
		_Shaftcolor("Shaft color", Color) = (1,0.8068966,0,0)
		_Opacity_shift("Opacity_shift", Range( 0.01 , 1)) = 0.66
		_Frequency("Frequency", Range( 0 , 3)) = 0
		_Frequency_scale("Frequency_scale", Range( 0 , 0.5)) = 0.25
		[Toggle(_MASKOFFON_ON)] _Maskoffon("Mask off/on", Float) = 0
		_Emmisionlevel("Emmision level", Range( 0.01 , 50)) = 0.01
		_Texture2blend("Texture 2 blend", Range( 0 , 1)) = 0.5
		_Texture3blend("Texture 3 blend", Range( 0 , 1)) = 0.5
		_Noise_level("Noise_level", Range( 0 , 1)) = 0.5
		_Texture1tiling("Texture1 tiling", Vector) = (1,1,0,0)
		_Texture2tiling("Texture2 tiling", Vector) = (1,1,0,0)
		_Texture3tiling("Texture3 tiling", Vector) = (1,1,0,0)
		_Noise_tilling("Noise_tilling", Vector) = (3,3,0,0)
		_Texture1speed("Texture1 speed", Vector) = (0.08,0,0,0)
		_Texture2speed("Texture2 speed", Vector) = (0.1,0,0,0)
		_Texture3speed("Texture3 speed", Vector) = (-0.1,0,0,0)
		_Noise_speed("Noise_speed", Vector) = (-0.02,0.01,0,0)
		_Texture1("Texture1", 2D) = "white" {}
		_Texture2("Texture2", 2D) = "white" {}
		_Texture3("Texture3", 2D) = "white" {}
		_Texture4("Texture4", 2D) = "white" {}
		_Ray_mask("Ray_mask", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.5
		#pragma shader_feature _MASKOFFON_ON
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _Texture1;
		uniform float2 _Texture1speed;
		uniform float2 _Texture1tiling;
		uniform sampler2D _Texture2;
		uniform float2 _Texture2speed;
		uniform float2 _Texture2tiling;
		uniform float _Texture2blend;
		uniform sampler2D _Texture3;
		uniform float2 _Texture3speed;
		uniform float2 _Texture3tiling;
		uniform float _Texture3blend;
		uniform sampler2D _Ray_mask;
		uniform float4 _Ray_mask_ST;
		uniform sampler2D _Texture4;
		uniform float2 _Noise_speed;
		uniform float2 _Noise_tilling;
		uniform float _Noise_level;
		uniform float4 _Shaftcolor;
		uniform float _Emmisionlevel;
		uniform float _Frequency;
		uniform float _Frequency_scale;
		uniform float _Opacity_shift;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_TexCoord32 = i.uv_texcoord * _Texture1tiling;
			float2 panner35 = ( _Time.y * _Texture1speed + uv_TexCoord32);
			float2 uv_TexCoord41 = i.uv_texcoord * _Texture2tiling;
			float2 panner42 = ( _Time.y * _Texture2speed + uv_TexCoord41);
			float4 lerpResult93 = lerp( tex2D( _Texture1, panner35 ) , tex2D( _Texture2, panner42 ) , _Texture2blend);
			float2 uv_TexCoord46 = i.uv_texcoord * _Texture3tiling;
			float2 panner48 = ( _Time.y * _Texture3speed + uv_TexCoord46);
			float4 lerpResult94 = lerp( lerpResult93 , tex2D( _Texture3, panner48 ) , _Texture3blend);
			float2 uv_Ray_mask = i.uv_texcoord * _Ray_mask_ST.xy + _Ray_mask_ST.zw;
			float4 blendOpSrc127 = lerpResult94;
			float4 blendOpDest127 = tex2D( _Ray_mask, uv_Ray_mask );
			#ifdef _MASKOFFON_ON
				float4 staticSwitch132 = ( saturate( (( blendOpSrc127 > 0.5 )? ( blendOpDest127 + 2.0 * blendOpSrc127 - 1.0 ) : ( blendOpDest127 + 2.0 * ( blendOpSrc127 - 0.5 ) ) ) ));
			#else
				float4 staticSwitch132 = lerpResult94;
			#endif
			float2 uv_TexCoord112 = i.uv_texcoord * _Noise_tilling;
			float2 panner114 = ( _Time.y * _Noise_speed + uv_TexCoord112);
			float4 lerpResult121 = lerp( float4( 0,0,0,0 ) , tex2D( _Texture4, panner114 ) , lerpResult94.r);
			float4 lerpResult120 = lerp( staticSwitch132 , lerpResult121 , _Noise_level);
			float4 blendOpSrc133 = staticSwitch132;
			float4 blendOpDest133 = lerpResult120;
			float4 _textures75 = ( saturate( 2.0f*blendOpDest133*blendOpSrc133 + blendOpDest133*blendOpDest133*(1.0f - 2.0f*blendOpSrc133) ));
			float4 blendOpSrc33 = _textures75;
			float4 blendOpDest33 = _Shaftcolor;
			float4 _shaft77 = ( saturate( ( blendOpSrc33 * blendOpDest33 ) ));
			o.Albedo = _shaft77.rgb;
			float4 _emmision79 = ( _shaft77 * _Emmisionlevel );
			o.Emission = _emmision79.rgb;
			float _frequency71 = (sin( ( _Time.y * _Frequency ) )*_Frequency_scale + _Frequency_scale);
			float4 lerpResult72 = lerp( _textures75 , float4( 0,0,0,0 ) , _frequency71);
			float4 _opacity84 = ( lerpResult72 * _Opacity_shift );
			o.Alpha = _opacity84.r;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard alpha:fade keepalpha fullforwardshadows 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.5
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
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
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
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.worldPos = worldPos;
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
				float3 worldPos = IN.worldPos;
				fixed3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15304
7;215;3426;901;6333.499;-300.7935;1.869992;True;False
Node;AmplifyShaderEditor.CommentaryNode;74;-4076.421,273.0932;Float;False;2111.358;1599.656;Textures and tiling;41;110;115;114;109;112;113;111;136;135;137;134;127;125;75;132;133;120;121;94;91;49;48;47;46;45;60;93;89;43;42;39;41;40;61;11;35;38;37;32;62;76;;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector2Node;62;-3994.881,337.0932;Float;False;Property;_Texture1tiling;Texture1 tiling;9;0;Create;True;0;0;False;0;1,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;61;-3994.881,657.0933;Float;False;Property;_Texture2tiling;Texture2 tiling;10;0;Create;True;0;0;False;0;1,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleTimeNode;37;-3722.882,577.0932;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;60;-3978.881,961.0933;Float;False;Property;_Texture3tiling;Texture3 tiling;11;0;Create;True;0;0;False;0;1,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;32;-3770.882,337.0932;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;39;-3722.882,881.0935;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;41;-3786.882,657.0933;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;38;-3754.882,465.0934;Float;False;Property;_Texture1speed;Texture1 speed;13;0;Create;True;0;0;False;0;0.08,0;0.08,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;40;-3738.882,769.0934;Float;False;Property;_Texture2speed;Texture2 speed;14;0;Create;True;0;0;False;0;0.1,0;0.1,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleTimeNode;45;-3722.882,1185.093;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;35;-3514.882,337.0932;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;42;-3530.882,657.0933;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;46;-3770.882,961.0933;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;47;-3738.882,1073.093;Float;False;Property;_Texture3speed;Texture3 speed;15;0;Create;True;0;0;False;0;-0.1,0;-0.1,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SamplerNode;11;-3322.882,337.0932;Float;True;Property;_Texture1;Texture1;17;0;Create;True;0;0;False;0;7fc46b1c5cc369044ac53a3db22654e2;7fc46b1c5cc369044ac53a3db22654e2;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;43;-3306.882,657.0933;Float;True;Property;_Texture2;Texture2;18;0;Create;True;0;0;False;0;6f69326335f7e8e41a551d0ce9c660a5;6f69326335f7e8e41a551d0ce9c660a5;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;89;-3274.882,849.0934;Float;False;Property;_Texture2blend;Texture 2 blend;6;0;Create;True;0;0;False;0;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;48;-3514.882,961.0933;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;91;-3306.882,1153.093;Float;False;Property;_Texture3blend;Texture 3 blend;7;0;Create;True;0;0;False;0;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;93;-2990.6,340.7771;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;49;-3322.882,961.0933;Float;True;Property;_Texture3;Texture3;19;0;Create;True;0;0;False;0;b34708c8228e4464481c9671664722a3;6f69326335f7e8e41a551d0ce9c660a5;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;94;-2967.31,991.3071;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;136;-2844.253,1148.032;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector2Node;111;-3962.881,1537.093;Float;False;Property;_Noise_tilling;Noise_tilling;12;0;Create;True;0;0;False;0;3,3;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.WireNode;135;-3051.18,1233.539;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;137;-3495.814,1243.799;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleTimeNode;109;-3690.882,1761.093;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;112;-3754.882,1537.093;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;113;-3722.882,1649.093;Float;False;Property;_Noise_speed;Noise_speed;16;0;Create;True;0;0;False;0;-0.02,0.01;-0.1,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SamplerNode;125;-3914.882,1281.093;Float;True;Property;_Ray_mask;Ray_mask;21;0;Create;True;0;0;False;0;193236c54182d934580246f8033ed582;193236c54182d934580246f8033ed582;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;114;-3482.882,1537.093;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;134;-3513.589,1279.525;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BlendOpsNode;127;-3434.882,1281.093;Float;False;LinearLight;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;64;-2698.078,1455.964;Float;False;1055.718;392.1562;Frequency;7;71;70;69;68;67;66;65;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;115;-3274.882,1537.093;Float;True;Property;_Texture4;Texture4;20;0;Create;True;0;0;False;0;384eca5df23515f4fa49ee5065513398;6f69326335f7e8e41a551d0ce9c660a5;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;121;-2729.882,609.0932;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;132;-2762.882,353.0932;Float;False;Property;_Maskoffon;Mask off/on;4;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;110;-3274.882,1729.093;Float;False;Property;_Noise_level;Noise_level;8;0;Create;True;0;0;False;0;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;66;-2666.078,1711.964;Float;False;Property;_Frequency;Frequency;2;0;Create;True;0;0;False;0;0;0;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.TimeNode;65;-2618.078,1551.964;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;67;-2378.078,1551.964;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;120;-2538.882,609.0932;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.BlendOpsNode;133;-2409.882,354.0932;Float;False;SoftLight;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;76;-2698.078,1087.964;Float;False;728.6025;324.8268;Color;4;77;33;86;34;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SinOpNode;68;-2234.078,1567.964;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;69;-2362.078,1727.964;Float;False;Property;_Frequency_scale;Frequency_scale;3;0;Create;True;0;0;False;0;0.25;0.5;0;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;75;-2183.123,351.214;Float;False;_textures;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;81;-1629.878,1532.11;Float;False;860.147;314.0981;Opacity;6;84;53;54;73;72;80;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;70;-2074.08,1567.964;Float;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;86;-2650.078,1311.964;Float;False;75;0;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;34;-2666.078,1135.964;Float;False;Property;_Shaftcolor;Shaft color;0;0;Create;True;0;0;False;0;1,0.8068966,0,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;78;-1937.695,1087.964;Float;False;616.2372;249.2833;Emmision;4;79;51;87;52;;1,1,1,1;0;0
Node;AmplifyShaderEditor.BlendOpsNode;33;-2426.078,1135.964;Float;False;Multiply;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;80;-1581.878,1580.11;Float;False;75;0;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;71;-1850.08,1551.964;Float;False;_frequency;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;73;-1581.878,1660.11;Float;False;71;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;77;-2186.078,1263.964;Float;False;_shaft;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;87;-1921.695,1151.964;Float;False;77;0;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;72;-1325.878,1580.11;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;54;-1581.878,1740.11;Float;False;Property;_Opacity_shift;Opacity_shift;1;0;Create;True;0;0;False;0;0.66;1;0.01;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;52;-1921.695,1263.964;Float;False;Property;_Emmisionlevel;Emmision level;5;0;Create;True;0;0;False;0;0.01;0;0.01;50;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;53;-1149.878,1580.11;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;51;-1713.695,1151.964;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;79;-1569.695,1247.964;Float;False;_emmision;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;84;-989.8768,1580.11;Float;False;_opacity;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;82;-1568,432;Float;False;79;0;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;85;-1568,544;Float;False;84;0;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;83;-1552,288;Float;False;77;0;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-1216,288;Float;False;True;3;Float;ASEMaterialInspector;0;0;Standard;beffio/Medieval_Kingdom/Shafts;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;True;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;-1;False;-1;-1;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;0;0;0;False;-1;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;32;0;62;0
WireConnection;41;0;61;0
WireConnection;35;0;32;0
WireConnection;35;2;38;0
WireConnection;35;1;37;0
WireConnection;42;0;41;0
WireConnection;42;2;40;0
WireConnection;42;1;39;0
WireConnection;46;0;60;0
WireConnection;11;1;35;0
WireConnection;43;1;42;0
WireConnection;48;0;46;0
WireConnection;48;2;47;0
WireConnection;48;1;45;0
WireConnection;93;0;11;0
WireConnection;93;1;43;0
WireConnection;93;2;89;0
WireConnection;49;1;48;0
WireConnection;94;0;93;0
WireConnection;94;1;49;0
WireConnection;94;2;91;0
WireConnection;136;0;94;0
WireConnection;135;0;136;0
WireConnection;137;0;135;0
WireConnection;112;0;111;0
WireConnection;114;0;112;0
WireConnection;114;2;113;0
WireConnection;114;1;109;0
WireConnection;134;0;137;0
WireConnection;127;0;134;0
WireConnection;127;1;125;0
WireConnection;115;1;114;0
WireConnection;121;1;115;0
WireConnection;121;2;94;0
WireConnection;132;1;94;0
WireConnection;132;0;127;0
WireConnection;67;0;65;2
WireConnection;67;1;66;0
WireConnection;120;0;132;0
WireConnection;120;1;121;0
WireConnection;120;2;110;0
WireConnection;133;0;132;0
WireConnection;133;1;120;0
WireConnection;68;0;67;0
WireConnection;75;0;133;0
WireConnection;70;0;68;0
WireConnection;70;1;69;0
WireConnection;70;2;69;0
WireConnection;33;0;86;0
WireConnection;33;1;34;0
WireConnection;71;0;70;0
WireConnection;77;0;33;0
WireConnection;72;0;80;0
WireConnection;72;2;73;0
WireConnection;53;0;72;0
WireConnection;53;1;54;0
WireConnection;51;0;87;0
WireConnection;51;1;52;0
WireConnection;79;0;51;0
WireConnection;84;0;53;0
WireConnection;0;0;83;0
WireConnection;0;2;82;0
WireConnection;0;9;85;0
ASEEND*/
//CHKSM=6CC0F8CE4498B72D22DC3C1F15EEFD1370775746