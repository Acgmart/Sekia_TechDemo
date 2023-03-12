Shader "SekiaPipeline/Test/TestDrawMeshInstanced"
{
    Properties
    {
        //_Color ("Color", Color) = (1, 1, 1, 1) //通过C#脚本赋值
    }

    SubShader
    {
        Tags{ "RenderType"="Opaque" "RenderPipeline" = "UniversalPipeline" }

        Pass
        {
            Name "ForwardLit"
            Tags{ "LightMode" = "UniversalForward"}
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            //#define INSTANCING_ON
            #pragma multi_compile_instancing
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

            UNITY_INSTANCING_BUFFER_START(Props)
                UNITY_DEFINE_INSTANCED_PROP(float4, _Color)
            UNITY_INSTANCING_BUFFER_END(Props)

            struct a2v
            {
                float4 vertex : POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID //unity_InstanceID
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID //unity_InstanceID
            };

            v2f vert(a2v input)
            {
                v2f output = (v2f)0;

                UNITY_SETUP_INSTANCE_ID(input); //为unity_InstanceID赋值 unity_InstanceID = instanceID + unity_BaseInstanceID
                UNITY_TRANSFER_INSTANCE_ID(input, output); //将input的instanceID属性传递给output

                output.vertex = TransformObjectToHClip(input.vertex.xyz);
                return output;
            }

            float4 frag(v2f input) : SV_Target
            {
                UNITY_SETUP_INSTANCE_ID(input); //为unity_InstanceID赋值 unity_InstanceID = instanceID + unity_BaseInstanceID
                return UNITY_ACCESS_INSTANCED_PROP(Props, _Color); //通过unity_InstanceID在数组中获取值
            }
            ENDHLSL
        }
    }
}