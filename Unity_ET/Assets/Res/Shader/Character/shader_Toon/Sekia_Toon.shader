Shader "Sekia/Toon"
{
    Properties
    {
        //法线
        [KeywordEnum(OFF, ON)] _NORMALMAP("NormalMapMode", int) = 0
        [NoScaleOffset]_NormalMap ("_NormalMap", 2D) = "bump" {}
        //漫反射
        [KeywordEnum(CELL, RAMP)] _DIFFUSE("DiffuseMode", int) = 0
        [NoScaleOffset]_MainTex ("_MainTex", 2D) = "white" {}
        _MainColor ("_MainColor", Color) = (1,1,1,1)
        _ShadowStep ("_ShadowStep", Range(-1, 1)) = 0 //值越小阴影区域越大
        _ShadowColor ("_ShadowColor", Color) = (0.8,0.6,0.6,1) //配合贴图表示阴影处的颜色
        _Feather ("_Feather", Range(0, 0.5)) = 0.1 //0表示阴影区域和明亮区域完全没有过渡
        _RampColor2 ("_RampColor2", Color) = (0,0,0,1) //光照暗处
        _RampColor3 ("_RampColor3", Color) = (1,0,0,1) //次表面颜色
        _RampColor4 ("_RampColor4", Color) = (1,1,0,1) //固有色
        //高光
        [KeywordEnum(OFF, STEP, ANISOTROPIC)] _SPECULAR("SpecularMode", int) = 0
        _SpecularColor ("_SpecularColor", Color) = (0.4,0.4,0.4,1)
        _SpecularStep ("_SpecularStep", Range(0, 0.5)) = 0.3
        [NoScaleOffset]_BiTangentShiftMap ("_BiTangentShiftMap", 2D) = "white" {}
        _AnisotropicOffset ("_AnisotropicOffset", Range(-10, 10)) = 0
        //Overlay
        [KeywordEnum(OFF, ON)] _OVERLAY("OverlayMode", int) = 0
        [NoScaleOffset]_OverlayMap ("_OverlayMap", 2D) = "black" {}
        _OverlayColor ("_OverlayColor", Color) = (0.5,0.5,0.5,1)
        _OverlayRotation ("_OverlayRotation", Range(-1, 1)) = 0
        //Rim
        [KeywordEnum(OFF, ON)] _RIM("RimMode", int) = 0
        _RimStep ("_RimStep", Range(0.5, 1)) = 0.9
        _RimColor ("_RimColor", Color) = (0.5,0.5,0.5,1)
        //Emission
        [NoScaleOffset]_EmissionMap ("_EmissionMap", 2D) = "black" {}
        _EmissionColor ("_EmissionColor", Color) = (1,1,1,1)
        //描边
        _OutlineWidth ("_OutlineWidth", Range(0, 100)) = 1 
        _OutlineColor ("_OutlineColor", Color) = (1,0,0,1)
        _OutlineFull ("_OutlineFull", Range(0, 100)) = 100 //描边宽度系数为1的世界空间中的观察距离
        _OutlineFeather ("_OutlineFeather", Range(0, 100)) = 100 //描边宽度系数在1~0渐变的世界空间中的距离
    }

    SubShader
    {
        HLSLINCLUDE
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        inline float4 Position_ObjectToClip(in float4 pos){return mul(UNITY_MATRIX_VP, mul(unity_ObjectToWorld, float4(pos.xyz, 1)));}
        #define pos_o2c Position_ObjectToClip //将顶点(四元数)从模型空间转换到裁剪空间
        inline float3 Normal_ObjectToWorld(in float3 normal){return mul(normal, (float3x3)unity_WorldToObject);}
        #define normal_o2w Normal_ObjectToWorld //将法线(三元数)从模型空间转换到世界空间
        inline float3 Position_ObjectToWorld(in float4 pos){return mul(unity_ObjectToWorld, float4(pos.xyz, 1)).xyz;}
        #define pos_o2w Position_ObjectToWorld //将顶点(四元数)从模型空间转换到世界空间 变成三元数
        inline float3 Position_WorldToView(in float3 pos){return mul(UNITY_MATRIX_V, float4(pos, 1)).xyz;}
        #define pos_w2v Position_WorldToView //将顶点从(三元数)世界空间转换到观察空间
        inline float3 Direction_ObjectToWorld(in float3 dir){return mul((float3x3)unity_ObjectToWorld, dir);}
        #define dir_o2w Direction_ObjectToWorld //将矢量(三元数)从模型空间转换到世界空间
        inline float3 Direction_WorldToView(in float3 dir){return mul((float3x3)UNITY_MATRIX_V, dir);}
        #define dir_w2v Direction_WorldToView //将矢量(三元数)从世界空间转换到观察空间

        CBUFFER_START(UnityPerMaterial)
        //描边
        float _OutlineWidth;
        float4 _OutlineColor;
        float _OutlineFull;
        float _OutlineFeather;

        //法线
        float4 _MainColor;
        float4 _ShadowColor;
        float _ShadowStep;
        float _Feather;
        float4 _RampColor2;
        float4 _RampColor3;
        float4 _RampColor4;

        //高光
        float _SpecularStep; //0~1 高光强度
        float4 _SpecularColor; //高光色衰减因子
        float _AnisotropicOffset; //高光位置偏移

        //Overlay
        float _OverlayRotation; //-180~180 UV旋转角度
        float4 _OverlayColor;
        
        //Rim
        float _RimStep; //0~1
        float4 _RimColor; //边缘光颜色

        //Emission
        float4 _EmissionColor;
        CBUFFER_END

        sampler2D _NormalMap;
        sampler2D _MainTex;
        sampler2D _OverlayMap; //rgb通道为颜色 a通道为透明度
        sampler2D _BiTangentShiftMap; //程序化生成的切线偏移映射
        sampler2D _EmissionMap;
        ENDHLSL

        Pass
        {
            Name "Outline"
            Tags { "LightMode" = "SRPDefaultUnlit" }
            Blend SrcAlpha OneMinusSrcAlpha Cull Front
            Stencil { Ref 10 Comp Always Pass Replace }

            HLSLPROGRAM
            #pragma only_renderers d3d11 metal
            #pragma target 3.0
            #pragma vertex vert
            #pragma fragment frag

            struct a2v
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 posClip : SV_POSITION;
            };

            v2f vert (a2v v)
            {
                v2f o = (v2f)0;
                o.posClip = pos_o2c(v.vertex);
                float3 normalClip = pos_o2c(float4(v.normal, 0)).xyz;
                float2 offset = normalize(normalClip.xy) / _ScreenParams.xy * _OutlineWidth * o.posClip.w * 2;
                float distanceCamera = length(pos_w2v(pos_o2w(float4(0, 0, 0, 1))));
                offset *= 1- smoothstep(_OutlineFull, _OutlineFull + _OutlineFeather, distanceCamera);
                o.posClip.xy += offset;
                return o;
            }

            float4 frag (v2f i) : SV_Target
            {   
                return _OutlineColor;
            }
            ENDHLSL
        }

        Pass
        {
            Name "FORWARD"
            Tags { "LightMode" = "UniversalForward" "Queue" = "Transparent" }
            Blend SrcAlpha OneMinusSrcAlpha Cull Off
            Stencil { Ref 10 Comp Always Pass Replace }

            HLSLPROGRAM
            #pragma only_renderers d3d11 metal
            #pragma target 3.0
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile _NORMALMAP_OFF _NORMALMAP_ON //法线贴图模式
            #pragma multi_compile _DIFFUSE_CELL _DIFFUSE_RAMP //漫反射模式
            #pragma multi_compile _SPECULAR_OFF _SPECULAR_STEP _SPECULAR_ANISOTROPIC//高光模式
            #pragma multi_compile _OVERLAY_OFF _OVERLAY_ON //Overlay模式
            #pragma multi_compile _RIM_OFF _RIM_ON //Rim模式

            struct a2v
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                #if _NORMALMAP_ON || _SPECULAR_ANISOTROPIC
                    float4 tangent : TANGENT;
                #endif
                float2 texcoord0 : TEXCOORD0;
            };

            struct v2f
            {
                float4 posClip : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float3 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                #if _NORMALMAP_ON || _SPECULAR_ANISOTROPIC
                    float3 tangentDir : TEXCOORD3;
                    float3 bitangentDir : TEXCOORD4;
                #endif
                float3 vertexLight : TEXCOORD5;
                float4 shadowCoord : TEXCOORD6;
            };

            v2f vert (a2v v)
            {
                v2f o = (v2f)0;
                o.posClip = pos_o2c(v.vertex);
                o.uv0 = v.texcoord0;
                o.posWorld = pos_o2w(v.vertex);
                o.normalDir = normal_o2w(v.normal);

                #if _NORMALMAP_ON || _SPECULAR_ANISOTROPIC
                    o.tangentDir = dir_o2w(v.tangent.xyz);
                    o.bitangentDir = cross(o.normalDir, o.tangentDir) * v.tangent.w;
                #endif

                o.vertexLight = VertexLighting(o.posWorld, o.normalDir);

                #if SHADOWS_SCREEN //默认转换到ScreenSpace
                    o.shadowCoord = ComputeScreenPos(o.posClip);
                #else //转换到对应cascade的LightSpace
                    o.shadowCoord = TransformWorldToShadowCoord(o.posWorld);
                #endif

                return o;
            }

            float4 frag (v2f i) : SV_Target
            {
                //法线
                float3 normalDir = normalize(i.normalDir);
                #if _NORMALMAP_ON
                    float3x3 tangentTransform = float3x3(normalize(i.tangentDir), normalize(i.bitangentDir), normalDir);
                    float3 normalMap_var = UnpackNormal(tex2D(_NormalMap, i.uv0));
                    normalDir = normalize(mul(normalMap_var, tangentTransform));
                #endif

                //光照
                float3 unLitColor = saturate(max(float3(0.05,0.05,0.05), SampleSH(float3(0, -1, 0))));
                float3 lightColor = max(unLitColor, saturate(_MainLightColor.rgb) * MainLightRealtimeShadow(i.shadowCoord));
                float3 lightDir = normalize(_MainLightPosition.xyz); //没有realtime光源时默认值为(0,0,1)
                float3 viewDir = normalize(_WorldSpaceCameraPos.xyz - i.posWorld);
                float3 finalColor = i.vertexLight;

                //漫反射
                #if _DIFFUSE_CELL //使用贴图+色块化表面 对光照有微弱衰减
                    float NdotL = dot(normalDir, lightDir);
                    float4 mainTex_var = tex2D(_MainTex, i.uv0) * _MainColor;
                    float alpha = mainTex_var.a;
                    float3 diffuseColor = mainTex_var.rgb * lightColor;
                    float3 shadowColor = diffuseColor * _ShadowColor.rgb * saturate(1 + (NdotL - _ShadowStep) * 0.4);
                    diffuseColor = diffuseColor * (NdotL * 0.2 + 0.8); //比阴影处衰减的慢一些
                    float lightLerp = smoothstep(_ShadowStep, _ShadowStep + _Feather, NdotL);
                    finalColor += lerp(shadowColor, diffuseColor, lightLerp);
                #endif

                #if _DIFFUSE_RAMP //使用程序性衰减表面 根据光照和观察方向衰减
                    float alpha = _MainColor.a;
                    float surface_x = saturate(dot(normalDir, viewDir) * 0.8); //调整次表面亮度
                    float surface_y = saturate(dot(normalDir, lightDir) * 0.3 +0.5); //调整明暗交界线
                    float2 surfaceUV = float2(surface_x, surface_y);
                    float rampAlpha = saturate(length(surfaceUV - float2(0, 0)));
                    float3 rampColor = _RampColor2.rgb * (1 - rampAlpha) + rampAlpha; 
                    rampAlpha = saturate(length(surfaceUV - float2(1, 0)));
                    rampColor = _RampColor3.rgb * (1 - rampAlpha) + rampColor * rampAlpha;
                    rampAlpha = saturate(length(surfaceUV - float2(1, 1)));
                    rampColor = _RampColor4.rgb * (1 - rampAlpha) + rampColor * rampAlpha;
                    finalColor += rampColor * _MainColor.rgb * lightColor;
                #endif
                
                //区域高光
                #if _SPECULAR_STEP
                    float NdotS = saturate(dot(normalDir, normalize(viewDir + lightDir)) * 0.5 + 0.5);
                    float specularMask = step((1 - pow(saturate(_SpecularStep), 5)), NdotS); //控制高光区域范围
                    finalColor += lightColor * _SpecularColor.rgb * specularMask;
                #endif

                //各向异性高光
                #if _SPECULAR_ANISOTROPIC
                    float3 NdotS = normalize(viewDir + lightDir); //高光角度随着观察方向变
                    float BitangentShiftMap_var = tex2D(_BiTangentShiftMap, i.uv0).r - 0.5 + _AnisotropicOffset; //UV需要纵向排列
                    float3 shiftedBiTangent = normalize(normalize(i.bitangentDir) + normalDir * BitangentShiftMap_var);
                    float BdotS = dot(shiftedBiTangent, NdotS);
                    float specularMask = sqrt(1 - BdotS * BdotS) * step(0, dot(normalDir, NdotS));
                    specularMask = step((1 - pow(saturate(_SpecularStep), 5)), specularMask);
                    finalColor += lightColor * _SpecularColor.rgb * specularMask;
                #endif

                //Overlay
                #if _OVERLAY_ON
                    float3 viewNormalDir = dir_w2v(normalDir);
                    float2 overlayUV = viewNormalDir.xy * 0.5 + 0.5;
                    float overlayCos = cos(_OverlayRotation * PI); //-1~1 正反旋转180度
                    float overlaySin = sin(_OverlayRotation * PI);
                    float2x2 overlayTransform = float2x2(overlayCos, -overlaySin, overlaySin, overlayCos);
                    overlayUV = mul(overlayUV - 0.5, overlayTransform) + 0.5;
                    float4 overlayMap_var = tex2D(_OverlayMap, overlayUV) * _OverlayColor;
                    finalColor += overlayMap_var.a * overlayMap_var.rgb * lightColor;
                #endif
                
                //Rim
                #if _RIM_ON
                    float rimStep = step(_RimStep, 1 - dot(normalDir, viewDir));
                    finalColor += _RimColor.rgb * lightColor * rimStep;
                #endif

                //Emission
                finalColor += tex2D(_EmissionMap, i.uv0).rgb * _EmissionColor.rgb;

                return float4(finalColor, alpha);
            }
            ENDHLSL
        }
    }

    CustomEditor "UnityEditor.CustomShaderGUI_Toon"
}