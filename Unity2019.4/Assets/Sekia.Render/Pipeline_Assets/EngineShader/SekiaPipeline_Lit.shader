Shader "SekiaPipeline/Lit"
{
    Properties
    {
        [NoScaleOffset]_BaseMap("BaseMap", 2D) = "white" {}
        _BaseColor("BaseColor", Color) = (1, 1, 1, 1)
        [NoScaleOffset]_MaskMap("PBR遮罩", 2D) = "white" {}
        [NoScaleOffset]_NormalMap("法线贴图", 2D) = "bump" {}

        [Toggle(_ALPHATEST_ON)] _AlphaClip("透明裁剪", Int) = 0
        _Cutoff("Alpha Cutoff", Range(0, 1)) = 0.5

        _MetallicCof("金属度系数", Range(0, 1)) = 0
        _OcclusionCof("AO强度", Range(0, 1)) = 0
        _RoughnessCof("粗糙度系数", Range(0, 1)) = 0.5
        [HDR]_EmissionColor("自发光", Color) = (0, 0, 0, 0)

        [GUI_GlobalKeyword]_Test("测试Disney", Int) = 0
        [GUI_GlobalKeyword]_Test1("测试Builtin", Int) = 0
        [GUI_GlobalKeyword]_Test2("测试URP", Int) = 0
        [GUI_GlobalKeyword]_Test3("环境光写入模式", Int) = 0
    }

    SubShader
    {
        Tags{ "RenderPipeline" = "UniversalPipeline" }

        Pass
        {
            Name "ForwardLit"
            Tags{ "LightMode" = "UniversalForward"}
            HLSLPROGRAM
            #pragma multi_compile_local_fragment _ _ALPHATEST_ON
            #pragma multi_compile_local_fragment _ _SCREEN_SPACE_OCCLUSION
            #pragma multi_compile _ DYNAMICLIGHTMAP_ON
            #pragma multi_compile _ _TEST
            #pragma multi_compile _ _TEST1
            #pragma multi_compile _ _TEST2
            #pragma vertex vert
            #pragma fragment frag
            #include "_Lib/_LitInput.hlsl"
            #include "_Lib/_SharedBrdfFunctions.hlsl"
            #include "_Lib/_LitForwardPass.hlsl"
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
            #pragma multi_compile _ DYNAMICLIGHTMAP_ON
            #pragma multi_compile _ _TEST3
            #define _GBUFFER_PASS
            #pragma vertex vert
            #pragma fragment frag
            #include "_Lib/_LitInput.hlsl"
            #include "_Lib/_SharedBrdfFunctions.hlsl"
            #include "_Lib/_LitForwardPass.hlsl"
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
            #include "_Lib/_LitInput.hlsl"
            #include "_Lib/_ShadowCasterPass.hlsl"
            ENDHLSL
        }
    }
}
