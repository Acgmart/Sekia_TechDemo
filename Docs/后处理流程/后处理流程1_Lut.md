# Lut总览
很多调试类型的效果本质都是颜色映射
如果建立一个颜色查找表 输入颜色查找到另一个颜色 就能实现快速映射
如色温、对比度、饱和度、Tonemapping等变化都可以归类为映射

在UberPost.shader中可查看颜色映射代码：
```
float4 _Lut_Params;
float4 _UserLut_Params;

#define LutParams               _Lut_Params.xyz
#define PostExposure            _Lut_Params.w
#define UserLutParams           _UserLut_Params.xyz
#define UserLutContribution     _UserLut_Params.w

color = ApplyColorGrading(color, PostExposure, TEXTURE2D_ARGS(_InternalLut, sampler_LinearClamp), LutParams,
    TEXTURE2D_ARGS(_UserLut, sampler_LinearClamp), UserLutParams, UserLutContribution);
```
Lut的映射模式分为两种：
A映射：LDR 低动态范围
B映射：HDR 高动态范围 必须使用float格式的RT保持精度
只是两种映射方式，与HDR功能是否开启无关，所以这里称为A/B映射模式。

曝光设置：
在进行颜色映射之前必须先乘以曝光值 而URP不支持自动曝光 所以需要手动设置曝光值
input *= postExposure;
float postExposureLinear = Mathf.Pow(2f, m_ColorAdjustments.postExposure.value);
postExposure值将是我们在ColorAdjustments上设置的值的，单位为EV。

采样Lut流程
输入和输出色有着映射关系，需要将输入色转换从UV来采样Lut RT。
```
// 2D LUT grading
// scaleOffset = (1 / lut_width, 1 / lut_height, lut_height - 1)
real3 ApplyLut2D(TEXTURE2D_PARAM(tex, samplerTex), float3 uvw, float3 scaleOffset)
{
    // Strip format where `height = sqrt(width)`
    uvw.z *= scaleOffset.z;
    float shift = floor(uvw.z);
    uvw.xy = uvw.xy * scaleOffset.z * scaleOffset.xy + scaleOffset.xy * 0.5;
    uvw.x += shift * scaleOffset.y;
    uvw.xyz = lerp(
        SAMPLE_TEXTURE2D_LOD(tex, samplerTex, uvw.xy, 0.0).rgb,
        SAMPLE_TEXTURE2D_LOD(tex, samplerTex, uvw.xy + float2(scaleOffset.y, 0.0), 0.0).rgb,
        uvw.z - shift
    );
    return uvw;
}
```
int lutHeight = postProcessingData.lutSize;
int lutWidth = lutHeight * lutHeight;
默认的lutSize为32，所以会生成宽度为1024高度为32的Lut RT。
在A映射模式下，Lut RT的格式为RGBA32，单个颜色8bit。
在B映射模式下，Lut RT的格式为RGBAHalf，单个颜色16bit。
假设uvw为(1, 1, 1) 可映射到UV (1023.5 / 1024, 31.5 /32)
假设uvw为(0, 0, 0) 可映射到UV (0.5 / 1024, 0.5 /32)
随着z值增加映射到不同的小片片，在同一个片片内差值采样2个点。

映射流程：
对于B映射来说，Lut RT有足够的精度且预处理了Tonemapping，直接采样Lut即可。
对于A流程来说，先做Tonemapping，再采样低精度的Lut RT。
unity_to_ACES 方法 ：将颜色从sRGB色域转换到AP0色域
AcesTonemap ：
