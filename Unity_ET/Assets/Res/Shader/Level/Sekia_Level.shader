Shader "Sekia/Level"
{
    Properties
    {
        [NoScaleOffset]_BaseMap("BaseMap", 2D) = "white" {}
        [HDR]_BaseColor("BaseColor", Color) = (1, 1, 1, 1)
        [NoScaleOffset]_MaskMap("PBR遮罩", 2D) = "white" {}
        [NoScaleOffset]_NormalMap("法线贴图", 2D) = "bump" {}

        [Toggle(_ALPHATEST_ON)]_AlphaClip("透明裁剪", Int) = 0
        _Cutoff("Alpha Cutoff", Range(0, 1)) = 0.5

        _MetallicCof("金属度系数", Range(0, 1)) = 0
        _RoughnessCof("粗糙度系数", Range(0, 1)) = 0.8
        _OcclusionCof("AO强度", Range(0, 1)) = 1
        [HDR]_EmissionColor("自发光", Color) = (0, 0, 0, 0)

		[Enum(UnityEngine.Rendering.CullMode)]_CullMode("剔除模式", Int) = 2
    }

    SubShader
    {
        Tags{ "RenderPipeline" = "UniversalPipeline" }

        Pass
        {
            Name "ForwardLit"
            Tags{ "LightMode" = "UniversalForward"}
			Cull [_CullMode]
            HLSLPROGRAM
            #pragma multi_compile_local_fragment _ _ALPHATEST_ON
            #pragma multi_compile_local_fragment _ _SCREEN_SPACE_OCCLUSION
            #pragma multi_compile _ LIGHTMAP_ON
            //#define _ADDITIONAL_LIGHTS

            #pragma shader_feature _ _DEBUG_VERTEXCOLOR
            #pragma vertex vert
            #pragma fragment frag
            #include "_Lib/_Input.hlsl"
            #include "_Lib/_Forward.hlsl"
            ENDHLSL
        }

        Pass
        {
            Name "GBuffer"
            Tags{ "LightMode" = "UniversalGBuffer"}
            HLSLPROGRAM
            #pragma target 4.5
            #pragma multi_compile_local_fragment _ _ALPHATEST_ON
            #pragma multi_compile_local_fragment _ _SCREEN_SPACE_OCCLUSION
            #pragma multi_compile_fragment _ _GBUFFER_NORMALS_OCT
            #pragma multi_compile _ LIGHTMAP_ON
            #define _GBUFFER_PASS
            #pragma vertex vert
            #pragma fragment frag
            #include "_Lib/_Input.hlsl"
            #include "_Lib/_Forward.hlsl"
            ENDHLSL
        }

        Pass
        {
            Name "ShadowCaster"
            Tags{ "LightMode" = "ShadowCaster"}
            ColorMask 0
            HLSLPROGRAM
            #pragma multi_compile_local_fragment _ _ALPHATEST_ON
            #pragma vertex vert
            #pragma fragment frag
            #include "_Lib/_Input.hlsl"
            #include "_Lib/_ShadowCaster.hlsl"
            ENDHLSL
        }
    }
    CustomEditor "UnityEditor.CustomShaderGUI_PBR"
}
