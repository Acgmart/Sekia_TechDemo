Shader "XCode/Sample0_1"
{
	Properties
	{
		_BaseColor("BaseColor", Color) = (1, 1, 1, 1)
		_BaseColor2("BaseColor2", Color) = (1, 1, 1, 1)
		_BaseColor3("BaseColor3", Color) = (1, 1, 1, 1)
		_BaseColor4("BaseColor4", Color) = (1, 1, 1, 1)
		_BaseMap("BaseMap", 2D) = "white" {}
		_BaseMap2("BaseMap2", 2D) = "white" {}
		_BaseMap3("BaseMap3", 2D) = "white" {}
		_BaseMap4("BaseMap4", 2D) = "white" {}
	}

	SubShader
	{
		Tags { "RenderPipeline"="UniversalPipeline" "Queue"="Transparent" }
		
		Pass
		{
			Name "Forward"
			Tags { "LightMode"="UniversalForward" }
			Blend SrcAlpha OneMinusSrcAlpha
			ColorMask RGB
			ZWrite Off

			HLSLPROGRAM
			#pragma vertex vert
			#pragma fragment frag_Sample0_1
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "_SampleLib.hlsl"
			ENDHLSL
		}
	}
}