Shader "Custom/Decal/Unlit"
{
    Properties
    {
        [HDR]_BaseColor                 ("BaseColor", Color) = (1,1,1,1)
        [NoScaleOffset]_BaseMap         ("BaseMap", 2D) = "white" {}
        _DistanceFadeRange              ("Distance Fade Range", Range(5, 10)) = 10
        _DistanceFadeStart              ("Distance Fade Start", Range(5, 10)) = 10
    }

    SubShader
    {
        Tags { "RenderPipeline" = "UniversalPipeline" "Queue" = "Transparent-200"}

        Pass
        {
            Name "Decal Unlit"
            Tags {"LightMode" = "UniversalForward"}
            Blend SrcAlpha OneMinusSrcAlpha, Zero Zero
            Cull Front ZTest Always ZWrite Off

            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fog
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"

            CBUFFER_START(UnityPerMaterial)
                half4 _BaseColor;
                float _DistanceFadeRange;
                float _DistanceFadeStart;
            CBUFFER_END
            TEXTURE2D(_BaseMap); SAMPLER(sampler_BaseMap);

            #if defined(SHADER_API_GLES)
                TEXTURE2D(_CameraDepthTexture); SAMPLER(sampler_CameraDepthTexture);
            #else
                TEXTURE2D_X_FLOAT(_CameraDepthTexture);
                float4 _CameraDepthTexture_TexelSize;
            #endif

            struct VertexInput
            {
                float3 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct VertexOutput
            {
                float4 positionCS : SV_POSITION;
                float4 viewRayOS : TEXCOORD0;
                float3 camPosOS : TEXCOORD1;
                float4 screenUV : TEXCOORD2;
            };

            VertexOutput vert (VertexInput v)
            {
                VertexOutput output = (VertexOutput)0;
                output.positionCS = TransformObjectToHClip(v.vertex);
                float3 positionVS = mul(UNITY_MATRIX_MV, float4(v.vertex, 1.0)).xyz; //观察向量：观察空间从顶点到相机的向量
                output.viewRayOS.w = positionVS.z; //观察空间的观察向量长度(负值)
                float4x4 ViewToObjectMatrix = mul(GetWorldToObjectMatrix(), UNITY_MATRIX_I_V);
                output.viewRayOS.xyz = mul((float3x3)ViewToObjectMatrix, -positionVS.xyz).xyz; //模型空间的观察向量(指向相机)
                output.camPosOS = ViewToObjectMatrix._m03_m13_m23; //模型空间的相机坐标
                output.screenUV = ComputeScreenPos(output.positionCS);
                return output;
            }

            half4 frag (VertexOutput input ) : SV_Target
            {
                float2 uv = input.screenUV.xy / input.screenUV.w;
                #if defined(SHADER_API_GLES)
                    float rawDepth = SAMPLE_DEPTH_TEXTURE_LOD(_CameraDepthTexture, sampler_CameraDepthTexture, uv, 0);
                #else
                    //textureName.Load(int3(unCoord2, 0)) Point过滤用Load更快
                    float rawDepth = LOAD_TEXTURE2D_X(_CameraDepthTexture, _CameraDepthTexture_TexelSize.zw * uv).x;
                #endif
                float depth = LinearEyeDepth(rawDepth, _ZBufferParams); //Decal的表面深度是背景的深度

                //在模型空间沿着观察方向前进一定距离并与场景发生碰撞
                //碰撞点 = 相机坐标 + NormalisedForward * ForwardDistance
                //斜率 = 观察空间观察向量长度 / 观察空间观察点线性深度
                //NormalisedForward = -(viewRayOS.xyz / 长度)
                //                  = -(viewRayOS.xyz / (ViewDirScale_VStoOS * 观察空间观察向量长度))
                //                  = (viewRayOS.xyz / (ViewDirScale_VStoOS * viewRayOS.w * 斜率))
                //ForwardDistance = ViewDirScale_VStoOS * depth * 斜率
                //碰撞点 = 相机坐标 + viewRayOS.xyz * depth / viewRayOS.w
                input.viewRayOS.xyz *= rcp(input.viewRayOS.w);
                float3 positionOS = input.camPosOS + input.viewRayOS.xyz * depth;

                //由于我们使用Box 碰撞点不应超过模型空间边界
                clip(float3(0.5, 0.5, 0.5) - abs(positionOS.xyz));

                //以模型空间XY轴值为UV坐标 所以旋转模型改变顶部朝向可改变UV布局
                float2 texUV = positionOS.xz + float2(0.5, 0.5);
                half4 _BaseMapValue = SAMPLE_TEXTURE2D(_BaseMap, sampler_BaseMap, texUV) * _BaseColor;
                float3 positionWS = mul(GetObjectToWorldMatrix(), float4(positionOS, 1.0)).xyz;

                //pixel ->2x2 quad -> simd -> 同步
                //ddx/ddy：求相邻像素的输入值的差值
                float3 normalWS = normalize(cross(ddy(positionWS), ddx(positionWS)));

                //简单光照
                Light mainLight = GetMainLight();
				float NdotL = max(0, dot(normalWS, mainLight.direction));
                float3 finalColor = _BaseMapValue.rgb * (NdotL * 0.5 + 0.5) * mainLight.color;

                //片元shader中计算雾效
                #if (defined(FOG_LINEAR) || defined(FOG_EXP) || defined(FOG_EXP2))
                    float nearToFarZ = max(depth - _ProjectionParams.y, 0);
                    half fogFactor = ComputeFogFactorZ0ToFar(nearToFarZ);
                    finalColor.rgb = MixFog(finalColor.rgb, fogFactor);
                #endif

                //基于线性深度的渐隐
                _BaseMapValue.a *= smoothstep(_DistanceFadeRange + _DistanceFadeStart, _DistanceFadeStart, depth);

                return float4(finalColor.rgb, _BaseMapValue.a);
            }
            ENDHLSL
        }
    }
}