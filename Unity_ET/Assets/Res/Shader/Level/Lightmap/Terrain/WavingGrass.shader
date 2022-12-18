Shader "Sekia/Level/Terrain/WavingGrass"
{
    Properties
    {
        _MainTex ("Base(RGB) Alpha(A)", 2D) = "white" {}
        [HDR]_MainColor ("Color", Color) = (1, 1, 1, 0)
        _WindDirection ("WindDirection(XY)", Vector) = (0, 1, 0, 0)
        _WindSpeed("WindSpeed", Float) = 1
        _WindOffset("WindOffset", Range(0, 1)) = 0
        _ShadowStrength("ShadowStrength", Range(0, 1)) = 0.5
        _Cutoff ("Cutoff", Range(0, 1)) = 0.5
    }
    SubShader
    {
        Tags {"RenderPipeline" = "UniversalPipeline" "Queue" = "Geometry+450"}
        Cull Off
        ColorMask RGB

        Pass
        {
            HLSLPROGRAM
            #define _MAIN_LIGHT_SHADOWS
            #define _ADDITIONAL_LIGHTS
            //#define _SHADOWS_SOFT
            #pragma multi_compile_fog
            #pragma vertex WavingGrassVert
            #pragma fragment LitPassFragmentGrass
            #include "_Lib/_WavingGrass_Forward.hlsl"
            ENDHLSL
        }
    }
}
