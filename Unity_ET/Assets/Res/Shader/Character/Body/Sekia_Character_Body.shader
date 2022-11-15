Shader "Sekia/Character/Body"
{
    Properties
    {
        [GUI_NormalizedDir]_FakeLightDir("假光源", Vector) = (-0.81603, 0.08716, 0.57139, 0)
        _DirectLightingCof("直接光照系数", Range(0, 1.5)) = 1
        [ToggleUI]_IsInCoverShader ("是否被投影", Float) = 0
        [ToggleUI]_IsInNight ("是否在夜晚", Float) = 0
        _NightIntensity("夜晚光源强度", Range(0, 1)) = 1
        _WarmCoolCof("冷暖系数", Range(0, 1)) = 1

        _TextureBiasWhenDithering ("Texture Bias When Dithering", Float) = -1
        [NoScaleOffset]_BaseMap("BaseMap", 2D) = "white" {}
        [NoScaleOffset]_LightMap ("LightMap(RGBA)", 2D) = "gray" {}
        [NoScaleOffset]_ShadowRamp("ShadowRamp", 2D) = "grey" {}
        [NoScaleOffset]_MetalMap ("金属映射", 2D) = "white" { }
        _SpecularColor ("Specular Color", Color) = (1,1,1,1)

        _Color1 ("Tint Color 1", Color) = (1,1,1,1)
        _Color2 ("Tint Color 2", Color) = (1,1,1,1)
        _Color3 ("Tint Color 3", Color) = (1,1,1,1)
        _Color4 ("Tint Color 4", Color) = (1,1,1,1)
        _Color5 ("Tint Color 5", Color) = (1,1,1,1)
        _Shininess1 ("Specular Shininess 1", Range(0.1, 100)) = 10
        _Shininess2 ("Specular Shininess 2", Range(0.1, 100)) = 10
        _Shininess3 ("Specular Shininess 3", Range(0.1, 100)) = 10
        _Shininess4 ("Specular Shininess 4", Range(0.1, 100)) = 10
        _Shininess5 ("Specular Shininess 5", Range(0.1, 100)) = 10
        _SpecMulti1 ("Specular Multiply Factor 1", Range(0, 1)) = 0.1
        _SpecMulti2 ("Specular Multiply Factor 2", Range(0, 1)) = 0.1
        _SpecMulti3 ("Specular Multiply Factor 3", Range(0, 1)) = 0.1
        _SpecMulti4 ("Specular Multiply Factor 4", Range(0, 1)) = 0.1
        _SpecMulti5 ("Specular Multiply Factor 5", Range(0, 1)) = 0.1
        _SpecMulti5 ("Specular Multiply Factor 5", Range(0, 1)) = 0.1
        _OutlineColor1 ("OutlineColor1", Color) = (1,1,1,1)
        _OutlineColor2 ("OutlineColor2", Color) = (1,1,1,1)
        _OutlineColor3 ("OutlineColor3", Color) = (1,1,1,1)
        _OutlineColor4 ("OutlineColor4", Color) = (1,1,1,1)
        _OutlineColor5 ("OutlineColor5", Color) = (1,1,1,1)

        [Header(Shadow)]
        _LightArea ("LightArea", Range(0, 1)) = 0.5
        _ShadowRampWidth ("Shadow Ramp Width", Range(0.01, 10)) = 1

        [Header(Metal)]
        _MTMapBrightness ("MTMapBrightness", Float) = 1
        _MTMapTileScale ("MTMapTileScale", Float) = 1
        _MTMapLightColor ("Metal Map Light Color", Color) = (1,1,1,1)
        _MTMapDarkColor ("Metal Map Dark Color", Color) = (0,0,0,0)
        _MTShadowMultiColor ("MTShadowMultiColor", Color) = (0.8,0.8,0.8,0.8)
        _MTShininess ("Metal Shininess", Range(0.1, 20)) = 11
        _MTSpecularScale ("Metal Specular Scale", Range(1, 100)) = 60
        _MTSpecularAttenInShadow ("Metal Specular Attenuation in Shadow", Range(0, 1)) = 0.2
        _MTSpecularColor ("Metal Specular Color", Color) = (1,1,1,1)

        [Header(Emission)] 
        _EmissionScaler ("自发光强度", Range(0, 100)) = 1
        _EmissionColor ("自发光颜色", Color) = (1, 1, 1, 1)

        _OutlineWidthAdjustZs ("OutlineStart (near/middle/far)", Vector) = (0.01,2,6,0)
        _OutlineWidthAdjustScales ("OutlineScale(near/middle/far)", Vector) = (0.105,0.245,0.6,0)
        _OutlineWidth ("Outline Width", Range(0, 0.5)) = 0.04
        _MaxOutlineZOffset ("Max Outline Z Offset", Range(0, 100)) = 1
    }

    SubShader
    {
        Tags { "RenderPipeline"="UniversalRenderPipeline" "Queue"="Geometry" }

        pass
        {
            Name "Forward Lighting"
            Tags { "LightMode"="SRPDefaultUnlit" }
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile _ _MAIN_LIGHT_SHADOWS
            #pragma multi_compile _ _SHADOWS_SOFT
            #define _TWOFACE
            #include "_Input.hlsl"     
            #include "_Forward.hlsl"      
            ENDHLSL
        }

        pass
        {
            Name "ShadowCaster"
            Tags { "LightMode"="ShadowCaster" }
            ColorMask 0
            HLSLPROGRAM
            #pragma vertex Vert
            #pragma fragment Frag
            #define _ShadowCasterPass
            #include "_Input.hlsl"
            #include "_DepthOnly.hlsl"
            ENDHLSL
        }

        pass
        {
            Name "Outline"
            Tags { "LightMode"="UniversalForward" }
            Cull Front
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "_Input.hlsl"
            #include "_Outline.hlsl"
            ENDHLSL
        }
    }
}