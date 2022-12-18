Shader "Hidden/SekiaPipeline/CoreBlit"
{
    HLSLINCLUDE
        #pragma editor_sync_compilation //编辑器下优先编译 而不是等待异步编译
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

        float4 Custom_GetFullScreenTriangleVertexPosition(uint vertexID, float z = UNITY_NEAR_CLIP_VALUE)
        {
            float2 uv = float2((vertexID << 1) & 2, vertexID & 2);
            return float4(uv * 2.0 - 1.0, z, 1.0);
            //v0：(-1, -1)  v1：(3, -1) v2：(-1, 3)
        }

        float2 Custom_GetFullScreenTriangleTexCoord(uint vertexID)
        {
            return float2((vertexID << 1) & 2, vertexID & 2);
            //v0：(0, 0) v2：(2, 0) v3：(0, 2)
        }

        TEXTURE2D_X(_BlitTexture); SamplerState sampler_PointClamp;

        struct a2v
        {
            #if SHADER_API_GLES
                float4 positionOS       : POSITION;
                float2 uv0              : TEXCOORD0;
            #else
                uint vertexID           : SV_VertexID;
            #endif
        };

        struct v2f
        {
            float4 positionCS           : SV_POSITION;
            float2 uv0                  : TEXCOORD0;
        };

        v2f Vert(a2v i)
        {
            v2f output = (v2f)0;
            #if SHADER_API_GLES
                float4 pos = i.positionOS;
                float2 uv0  = i.uv0;
            #else
                float4 pos = Custom_GetFullScreenTriangleVertexPosition(i.vertexID);
                float2 uv0  = Custom_GetFullScreenTriangleTexCoord(i.vertexID);
            #endif

            output.positionCS = pos;
            output.uv0 = uv0;
            return output;
        }

        float4 FragNearest(v2f i) : SV_Target
        {
            return SAMPLE_TEXTURE2D(_BlitTexture, sampler_PointClamp, i.uv0.xy);
        }
    ENDHLSL

    SubShader
    {
        Tags{ "RenderPipeline" = "UniversalPipeline" }

        //Point采样 中间RT与backBuffer一样大 不支持动态分辨率
        Pass
        {
            ZWrite Off ZTest Always Blend Off Cull Off

            HLSLPROGRAM
                #pragma vertex Vert
                #pragma fragment FragNearest
            ENDHLSL
        }
    }
}
