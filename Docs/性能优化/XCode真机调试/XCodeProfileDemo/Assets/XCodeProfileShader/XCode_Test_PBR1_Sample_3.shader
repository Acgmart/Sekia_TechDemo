Shader "XCode/Test_PBR1_Sample_3"
{
	Properties
	{
		[NoScaleOffset]_BaseMap("BaseMap", 2D) = "white" {}
        [HDR]_BaseColor("BaseColor", Color) = (1, 1, 1, 1)
        [NoScaleOffset]_MaskMap("PBR遮罩", 2D) = "white" {}
        [NoScaleOffset]_NormalMap("法线贴图", 2D) = "bump" {}

        _MetallicCof("金属度系数", Range(0, 1)) = 0
        _RoughnessCof("粗糙度系数", Range(0, 1)) = 0.8
        _OcclusionCof("AO强度", Range(0, 1)) = 1
        [HDR]_EmissionColor("自发光", Color) = (0, 0, 0, 0)

        _PositionWS_P("世界坐标", Vector) = (0, 0, 0, 0)
        _NormalWS_P("法线", Vector) = (0, 1, 0, 0)
        _TangentWS_P("切线", Vector) = (1, 0, 0, 0)
        _ViewDirWS_P("观察方向", Vector) = (0, -1, 0, 0)
        [NoScaleOffset]_LightMap("Lightmap", 2D) = "black" {}

        [NoScaleOffset]_EnvirMap("EnvCube", Cube) = "black"{}
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
			#pragma fragment frag_Sample_3
			#define LIGHTMAP_ON
			#include "_Lib/_Core.hlsl"
			#include "_Lib/_Lighting.hlsl"
			#include "_Lib/_Test_PBR.hlsl"
			ENDHLSL
		}
	}
}