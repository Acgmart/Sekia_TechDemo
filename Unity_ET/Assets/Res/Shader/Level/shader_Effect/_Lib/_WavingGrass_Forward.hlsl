
#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"

CBUFFER_START(UnityPerMaterial)
    half4 _MainColor;
    half4 _WindDirection;
    half _WindSpeed;
    half _WindOffset;
    half _ShadowStrength;
    half _Cutoff;
CBUFFER_END
TEXTURE2D(_MainTex); SAMPLER(sampler_MainTex);

struct GrassVertexInput
{
    float3 position       : POSITION;
    half4 color         : COLOR;
    float2 uv     : TEXCOORD0;
};

struct GrassVertexOutput
{
    float2 uv                       : TEXCOORD0;
    float3 posWS                    : TEXCOORD2; // xyz: posWS, w: Shininess * 128
    half3 viewDir                   : TEXCOORD4;
    half fogFactor                  : TEXCOORD5; // x: fogFactor, yzw: vertex light
    half4 color                     : TEXCOORD7;
    float4 clipPos                  : SV_POSITION;
};

float sineWave(float T, float a, float phase) 
{
  return a * sin(T * 0.0174532924  + phase);
}

float wind()
{
    float wave1 = sineWave(200.0f, 1.2f, 1.0f * _Time.y);
    float wave2 = sineWave( 70.0f, 0.8f, 2.0f * _Time.y);
    float wave3 = sineWave(  0.0f, 1.0f, 1.5f * _Time.y);
    return (wave1 + wave2  + wave3) * 0.3333f;
}
//https://www.desmos.com/calculator?lang=zh-CN
//(1.5 * sin(200 * 0.0174532924 + x) + 0.5 * sin(70 * 0.0174532924 + 2 * x) + sin(1.5 * x)) / 3 + 1

GrassVertexOutput WavingGrassVert(GrassVertexInput v)
{
    GrassVertexOutput o = (GrassVertexOutput)0;
    o.color= v.color;
    o.uv = v.uv;
    //顶点空间的顶点动画
    float3 windDir = float3(_WindDirection.x, 0.0, _WindDirection.y);
    windDir = TransformWorldToObjectDir(windDir, true);
    float3 moveMent = windDir * v.uv.y * _WindSpeed * (wind() + _WindOffset);
    //.........
    o.posWS = TransformObjectToWorld(v.position + moveMent);
    o.clipPos = TransformWorldToHClip(o.posWS);
    o.viewDir = SafeNormalize(GetCameraPositionWS() - o.posWS);
    o.fogFactor = ComputeFogFactor(o.clipPos.z);
    return o;
}

//片元数据
void InitializeInputData(GrassVertexOutput input, out InputData inputData)
{
    inputData = (InputData)0;
    inputData.positionWS = input.posWS;
    inputData.normalWS = half3(0.0, 1.0, 0.0);
    inputData.viewDirectionWS = input.viewDir;
    inputData.shadowCoord = TransformWorldToShadowCoord(inputData.positionWS);
    inputData.fogCoord = input.fogFactor;
    inputData.vertexLighting = 0.0;
    inputData.bakedGI = 0.0; //SampleSH(inputData.normalWS);
}

//BlinnPhong光照
half4 UniversalFragmentBlinnPhongCustom(InputData inputData, half3 diffuse, half4 specularGloss, half alpha)
{
    Light mainLight = GetMainLight(inputData.shadowCoord);
    mainLight.shadowAttenuation = 1.0 - (1.0 - mainLight.shadowAttenuation) * _ShadowStrength;
    //Lambert直接光漫反射 无环境光 无直接光镜面反射
    half3 attenuatedLightColor = mainLight.color * (mainLight.distanceAttenuation * mainLight.shadowAttenuation);
    half3 diffuseColor = /*inputData.bakedGI + */LightingLambert(attenuatedLightColor, mainLight.direction, inputData.normalWS);

    #ifdef _ADDITIONAL_LIGHTS
    uint pixelLightCount = GetAdditionalLightsCount();
    for (uint lightIndex = 0u; lightIndex < pixelLightCount; ++lightIndex)
    {
        Light light = GetAdditionalLight(lightIndex, inputData.positionWS);
        half3 attenuatedLightColor = light.color * (light.distanceAttenuation * light.shadowAttenuation);
        diffuseColor += LightingLambert(attenuatedLightColor, light.direction, inputData.normalWS);
    }
    #endif

    half3 finalColor = diffuseColor * diffuse;
    return half4(finalColor, alpha);
}

half4 LitPassFragmentGrass(GrassVertexOutput input) : SV_Target
{
    float2 uv = input.uv;
    half4 diffuse = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, uv);
    clip(diffuse.a - _Cutoff);
    diffuse.rgb *= _MainColor.rgb;
    InputData inputData;
    InitializeInputData(input, inputData);
    half4 color = UniversalFragmentBlinnPhongCustom(inputData, diffuse.rgb, 0.1, 1.0);
    color *= saturate(uv.y + 0.2); //草根模拟AO
    color.rgb = MixFog(color.rgb, inputData.fogCoord);
    return color;
};

struct VertexInput
{
    float3 position     : POSITION;
    float2 uv     : TEXCOORD0;
};

struct VertexOutput
{
    float2 uv           : TEXCOORD0;
    float4 clipPos      : SV_POSITION;
};

VertexOutput DepthOnlyVertex(VertexInput v)
{
    VertexOutput o = (VertexOutput)0;
    o.uv = v.uv;
    //顶点空间的顶点动画
    float3 windDir = float3(_WindDirection.x, 0.0, _WindDirection.y);
    windDir = TransformWorldToObjectDir(windDir, true);
    float3 moveMent = windDir * v.uv.y * _WindSpeed * (wind() + _WindOffset);
    //.........
    float3 posWS = TransformObjectToWorld(v.position + moveMent);
    o.clipPos = TransformWorldToHClip(posWS);
    return o;
}