Shader "Sekia/Level/Terrain/Layer3"
{
    Properties
    {
		[NoScaleOffset]_Control("Control", 2D) = "black" {}
		[NoScaleOffset]_Splat1("Layer1", 2D) = "white" {}
		[NoScaleOffset]_NormalMap1("", 2D) = "bump"{}
		[NoScaleOffset]_Splat2("Layer2", 2D) = "white" {}
		[NoScaleOffset]_NormalMap2("", 2D) = "bump"{}
		[NoScaleOffset]_Splat3("Layer3", 2D) = "white" {}
		[NoScaleOffset]_NormalMap3("", 2D) = "bump"{}
		_Tiling("Tiling", Vector) = (1, 1, 1, 1)
		_SmoothnessCof("SmoothnessCof", Vector) = (1, 1, 1, 1)
    }

    SubShader
    {
        Tags{"RenderPipeline" = "UniversalPipeline" "Queue"="Geometry"}
        Pass
        {
            Name "Forward"
            Tags{"LightMode" = "UniversalForward"}
            Blend One Zero, Zero Zero
            HLSLPROGRAM
            #define _MAIN_LIGHT_SHADOWS
            #define _ADDITIONAL_LIGHTS
            #pragma multi_compile _ FOG_LINEAR
            #pragma multi_compile _ LIGHTMAP_ON
            #pragma vertex vert
            #pragma fragment frag
			#define _LAYER3

            #include "_Lib/_Layer_Input.hlsl"
            #include "_Lib/_Layer_Forward.hlsl"
            ENDHLSL
        }

        Pass
        {
            Name "Meta"
            Tags{"LightMode" = "Meta"}
            Cull Off
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "_Lib/_Layer_Input.hlsl"
            #include "_Lib/_Layer_Meta.hlsl"
            ENDHLSL
        }
    }
}
 