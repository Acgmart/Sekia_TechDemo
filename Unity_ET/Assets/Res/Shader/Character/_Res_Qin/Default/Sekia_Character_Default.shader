Shader "Sekia/Character/Default"
{
    Properties
    {
        [GUI_NormalizedDir]_FakeLightDir("_FakeLightDir", Vector) = (-0.81603, 0.08716, 0.57139, 0)
        
        _TextureBiasWhenDithering ("Texture Bias When Dithering", Float) = -1
        [Enum(None, 0, AlphaTest, 1, Emission, 2, FaceBlush, 3)]
        _MainTexAlphaUse ("BaseMap A通道用途", Float) = 0
        _MainTexAlphaCutoff ("Cutoff", Range(0, 1)) = 0.5

        _BaseMap("BaseMap", 2D) = "white" {}
        _LightMap ("LightMap(RGBA)", 2D) = "gray" {}
        _ShadowRamp("ShadowRamp", 2D) = "grey" {}
        _Color1 ("Tint Color", Color) = (1,1,1,1)
        _Shininess1 ("Specular Shininess", Range(0.1, 100)) = 10
        _SpecMulti1 ("Specular Multiply Factor", Range(0, 1)) = 0.1
        _SpecularColor ("Specular Color", Color) = (1,1,1,1)

        [Header(Shadow)]
        [ToggleUI] _UseLightMapColorAO ("Use Light Map Color.g For AO", Float) = 1
        [ToggleUI] _UseVertexColorAO ("Use Vertex Color.r For AO", Float) = 1
        [ToggleUI] _UseCoolShadowColorOrTex ("Use Cool Shadow Color Or Tex", Float) = 0
        _LightArea ("Light Area Threshold", Range(0, 1)) = 0.5
        _FirstShadowMultColor ("Warm Shadow Color", Color) = (0.9,0.7,0.75,1)
        _CoolShadowMultColor ("Cool Shadow Color", Color) = (0.9,0.7,0.75,1)
        
        [Header(Shadow Ramp)] 
        [Toggle(SHADOW_RAMP_ON)] _UseShadowRamp ("Use Shadow Ramp", Float) = 0
        _ShadowRampWidth ("Shadow Ramp Width", Range(0.01, 10)) = 1
        [ToggleUI] _UseVertexRampWidth ("Use Vertex Shadow Ramp Width", Float) = 0

        [Header(Shadow Transition)] 
        [Toggle(SHADOW_TRANSITION_ON)] _UseShadowTransition ("Use Shadow Transition (only work when shadow ramp is off)", Float) = 0
        _ShadowTransitionRange ("Shadow Transition Range", Range(0.001, 0.2)) = 0.01
        _ShadowTransitionSoftness ("Shadow Transition Softness", Range(0, 2)) = 0.5
        

        [Header(Face Blush)]
        _FaceBlushStrength ("Face Blush Strength", Range(0, 1)) = 0
        _FaceBlushColor ("Face Blush Color", Color) = (1,0.8,0.7,1)

        [Header(Face Map New)] 
        [Toggle(FACE_MAP_NEW_ON)] _UseFaceMapNew ("Use Face Map", Float) = 0
        _FaceMapTex ("Face Map Tex (A Linear)", 2D) = "gray" { }
        _FaceMapRotateOffset ("Face Map Rotate Offset", Range(-1, 1)) = 0
        _FaceMapSoftness ("Face Map Softness", Range(0.0001, 1)) = 0.0001
        
        
        [Header(Outline)] 
        [Enum(None, 0, Normal, 1, Tangent, 2)] _OutlineType ("Outline Type", Float) = 2
        _OutlineWidth ("Outline Width", Range(0, 100)) = 0.04
        _OutlineColor ("Outline Color", Color) = (0,0,0,1)
        _MaxOutlineZOffset ("Max Outline Z Offset", Range(0, 100)) = 1
        _OutlineWidthAdjustZs ("Outline Width Adjust Dist Start (near, middle, far)", Vector) = (0.01,2,6,0)
        _OutlineWidthAdjustScales ("Outline Width Adjust Scale (near, middle, far)", Vector) = (0.105,0.245,0.6,0)
        
        [Header(Ambient Point Light)] 
        [ToggleUI] _UseAmbientPoint ("Use Ambient Point light", Float) = 0
        [Enum(Result, 0, Strength, 1, Color, 2)] _AmbientPointUtility ("Ambient Point light Utility", Float) = 0
        _AmbientPointStrength ("Ambient Point light Strength", Range(0, 1)) = 0.1
        _AmbientPointRange ("Ambient Point light Range", Range(0, 2)) = 0.85
        _AmbientPointSoftness ("Ambient Point light Softness", Range(0, 1)) = 0.3
        _AmbientPointFlatness ("Ambient Point light Flatness", Range(1, 10)) = 1
        _AmbientPointYOffset ("Ambient Point light Y Offset", Range(0, 2)) = 0.37
        _AmbientPointColorDensity ("Ambient Point light Color Density", Range(0, 1)) = 0.5

        [Header(Material 2)] 
        [ToggleUI] _UseMaterial2 ("Use Material 2", Float) = 0
        _Color2 ("Tint Color 2", Color) = (1,1,1,1)
        _FirstShadowMultColor2 ("Warm Shadow Color 2", Color) = (0.9,0.7,0.75,1)
        _CoolShadowMultColor2 ("Cool Shadow Color 2", Color) = (0.9,0.7,0.75,1)
        _Shininess2 ("Specular Shininess 2", Range(0.1, 100)) = 10
        _SpecMulti2 ("Specular Multiply Factor 2", Range(0, 1)) = 0.1
        _OutlineColor2 ("Outline Color 2", Color) = (0,0,0,1)

        [Header(Shadow Transition 2)] 
        _ShadowTransitionRange2 ("Shadow Transition Range 2", Range(0.001, 0.2)) = 0.01
        _ShadowTransitionSoftness2 ("Shadow Transition Softness 2", Range(0, 2)) = 0.5

        [Header(Material 3)]
        [ToggleUI] _UseMaterial3 ("Use Material 3", Float) = 0
        _Color3 ("Tint Color 3", Color) = (1,1,1,1)
        _FirstShadowMultColor3 ("Warm Shadow Multiply Color 3", Color) = (0.9,0.7,0.75,1)
        _CoolShadowMultColor3 ("Cool Shadow Multiply Color 3", Color) = (0.9,0.7,0.75,1)
        _Shininess3 ("Specular Shininess 3", Range(0.1, 100)) = 10
        _SpecMulti3 ("Specular Multiply Factor 3", Range(0, 1)) = 0.1
        _OutlineColor3 ("Outline Color 3", Color) = (0,0,0,1)

        [Header(Shadow Transition 3)] _ShadowTransitionRange3 ("Shadow Transition Range 3", Range(0.001, 0.2)) = 0.01
        _ShadowTransitionSoftness3 ("Shadow Transition Softness 3", Range(0, 2)) = 0.5

        [Header(Material 4)]
        [ToggleUI] _UseMaterial4 ("Use Material 4", Float) = 0
        _Color4 ("Tint Color 4", Color) = (1,1,1,1)
        _FirstShadowMultColor4 ("Warm Shadow Multiply Color 4", Color) = (0.9,0.7,0.75,1)
        _CoolShadowMultColor4 ("Cool Shadow Multiply Color 4", Color) = (0.9,0.7,0.75,1)
        _Shininess4 ("Specular Shininess 4", Range(0.1, 100)) = 10
        _SpecMulti4 ("Specular Multiply Factor 4", Range(0, 1)) = 0.1
        _OutlineColor4 ("Outline Color 4", Color) = (0,0,0,1)

        [Header(Shadow Transition 4)] _ShadowTransitionRange4 ("Shadow Transition Range 4", Range(0.001, 0.2)) = 0.01
        _ShadowTransitionSoftness4 ("Shadow Transition Softness 4", Range(0, 2)) = 0.5

        [Header(Material 5)]
        [ToggleUI] _UseMaterial5 ("Use Material 5", Float) = 0
        _Color5 ("Tint Color 5", Color) = (1,1,1,1)
        _FirstShadowMultColor5 ("Warm Shadow Multiply Color 5", Color) = (0.9,0.7,0.75,1)
        _CoolShadowMultColor5 ("Cool Shadow Multiply Color 5", Color) = (0.9,0.7,0.75,1)
        _Shininess5 ("Specular Shininess 5", Range(0.1, 100)) = 10
        _SpecMulti5 ("Specular Multiply Factor 5", Range(0, 1)) = 0.1
        _OutlineColor5 ("Outline Color 5", Color) = (0,0,0,1)

        [Header(Shadow Transition 5)] _ShadowTransitionRange5 ("Shadow Transition Range 5", Range(0.001, 0.2)) = 0.01
        _ShadowTransitionSoftness5 ("Shadow Transition Softness 5", Range(0, 2)) = 0.5

        [Header(Back Face)] [Toggle(BACK_FACE_ON)] _DrawBackFace ("Draw Back Face", Float) = 0
        [ToggleUI] _UseBackFaceUV2 ("Use Back Face UV 2", Float) = 1
        [Header(Dithering)] [ToggleUI] _UsingDitherAlpha ("UsingDitherAlpha", Float) = 0
        _DitherAlpha ("Dither Alpha Value", Range(0, 1)) = 1

        [Header(Plane Clipping)]
        [ToggleUI] _UseClipPlane ("Use Clip Plane", Float) = 0
        [ToggleUI] _ClipPlaneWorld ("Clip Plane In World Space", Float) = 1
        _ClipPlane ("Clip Plane", Vector) = (0,0,0,0)

        [Header(Metal)]
        [Toggle(METAL_MAT)] _MetalMaterial ("Metal Material", Float) = 0
        _MTMap ("Metal Map", 2D) = "white" { }
        _MTMapBrightness ("Metal Map Brightness", Float) = 1
        _MTMapTileScale ("Metal Map Tile Scale", Float) = 1
        _MTMapLightColor ("Metal Map Light Color", Color) = (1,1,1,1)
        _MTMapDarkColor ("Metal Map Dark Color", Color) = (0,0,0,0)
        _MTShadowMultiColor ("Metal Shadow Multiply Color", Color) = (0.8,0.8,0.8,0.8)
        _MTShininess ("Metal Shininess", Float) = 11
        _MTSpecularScale ("Metal Specular Scale", Float) = 60
        _MTSpecularAttenInShadow ("Metal Specular Attenuation in Shadow", Range(0, 1)) = 0.2
        _MTSpecularColor ("Metal Specular Color", Color) = (1,1,1,1)

        [InstancedGPUSkinning] _AnimTexture ("Animation Texture", 2D) = "white" { }
        _AnimBoneOffset ("Anim BoneOffset", Float) = 0
        _InstanceData ("", Float) = 0

        [Header(State)]
        [Enum(UnityEngine.Rendering.CullMode)] _CullMode ("Cull Mode", Float) = 2
        _PolygonOffsetFactor ("Polygon Offset Factor", Float) = 0
        _PolygonOffsetUnit ("Polygon Offset Unit", Float) = 0
        _OutlinePolygonOffsetFactor ("Outline Polygon Offset Factor", Float) = 0
        _OutlinePolygonOffsetUnit ("Outline Polygon Offset Unit", Float) = 0
        _CharacterAmbientSensorShadowOn ("", Float) = 0
        _CharacterAmbientSensorColorOn ("", Float) = 0

        [Header(Emission] 
        _EmissionScaler ("自发光强度", Range(0, 100)) = 1
        _EmissionColor ("自发光颜色", Color) = (1, 1, 1, 1)

        [Header(Dissolve)]
        _DissolveValue ("DissolveValue", Range(0, 1)) = 0
        _DissolveColor ("DissolveColor", Color) = (4.338235,10,9.29716,0)
    }

    SubShader
    {
        Tags { "RenderPipeline"="UniversalRenderPipeline" "Queue"="Geometry" }

        pass
        {
            Name "Forward Lighting"
            Tags { "LightMode"="UniversalForward" }
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

        Pass
        {
            Name "DepthOnly"
            Tags{"LightMode" = "DepthOnly"}
            ColorMask 0
            HLSLPROGRAM
            #pragma vertex Vert
            #pragma fragment Frag
            #define _DepthOnlyPass
            #include "_Input.hlsl"
            #include "_DepthOnly.hlsl"
            ENDHLSL
        }
    }
}