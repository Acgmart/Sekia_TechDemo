Shader "SekiaPipeline/Test/DrawMeshInstancedIndirect"
{
    Properties
    {
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
            #include "_Lib/_LitInput.hlsl"
            #include "_Lib/_LitForwardPass.hlsl"
            ENDHLSL
        }
    }
}
