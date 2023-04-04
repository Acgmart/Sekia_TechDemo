---
title: SRP后处理 Lut贴图与常见效果
categories:
- [渲染, 效果表现]
date: 2020-07-01 21:55:37
cover: https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/render/present/030.png
---

\[toc\]本篇描述SRP中的color LUT，即颜色查找表。 在URP中定义了一个m\_ColorGradingLutPass，用来绘制color LUT贴图； 这个贴图被传递给后处理阶段使用，与色调映射相关。 参考资料：[Unity后处理wiki](https://github.com/Unity-Technologies/PostProcessing/wiki "Unity后处理wiki")

# RT的声明

Shader属性名：\_InternalGradingLut 采样过滤方式：Bilinear 高度：在管线设置-后处理-`LUT size`参数 默认是32像素宽 宽度：等于高度的平方 默认是32x32 = 1024像素宽 是否开启HDR模式： 1.在管线设置-质量-`HDR`选项 默认不开启HDR 2.在管线设置-后处理-`Grading Mode`选项 默认不开启HDR 纹理格式： 1.HDR模式优先使用R16G16B16A16\_SFloat 2.LDR模式使用R8G8B8A8\_UNorm //在不支持浮点纹理的平台

# 影响Lut的后处理效果参数

相关专有名词： 色相：Hue 用色环表示 饱和度：Saturation 亮度：Luminance 很多后处理效果(色调调整类型)的参数都参与了Lut贴图的计算； 在运行时这些效果直接从Lut贴图采样，而不是实时计算效果。 所以，如果我们直接指定了Lut贴图，就可以直接得到最终效果。 HDRP和URP中的选项可能有微小不同。

## White Balance

LMS色彩空间系数-参数：whiteBalance效果的temperature和tint 白平衡：让白色的物体呈现同样的白色； temperature：设置白平衡为一个自定义的颜色温度，即产生色调。 tint：为白平衡补充绿色和酒红色色调。

## Color Adjustments

hueShift：色相的改变程度，-180°至180°，绕着色环替换颜色值； saturation：调整颜色的强度(饱和度)，灰白-正常-艳丽； contrast：对比度，同一张图内，最亮和最暗之间的差的范围。

## Channel Mixer

颜色通道混合-色源的RGB三个通道可分别作为系数影响RGB输出

## Shadows Midtones Highlights

定义线性颜色分量：判断颜色在3个区域的系数 合计为1 ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/render/present/028.png) shadows:暗部区域的颜色系数 midtones：中间区域的颜色系数 highlights：亮部区域的颜色系数 shadowsStart/shadowsEnd：定义暗部区域的边界 highlightsStart/highlightsEnd：定义亮部区域的边界

## LiftGammaGain 调色

lift：线性颜色的加值 默认0 -1至1之间 gamma：线性颜色的指数 默认1 1000至0.5之间 gain：线性颜色的系数 默认1 0至2之间

## SplitToning 色调分离

进行一次暗部暗色混合和一次亮部颜色混合 shadows：色相的颜色系数 默认0.5 昏暗区域受到的影响更大 highlights：色相的颜色系数 默认0.5 明亮区域受到的影响更大 balance：-1至1之间 低于0时阴影色调增加 高于0时亮部色调增加

## ColorCurves曲线映射

使用自定义曲线调整颜色的映射关系 Master：默认为0-1的直线 控制RGB3个通道 强度映射关系 R/G/B：默认为0-1的直线 只控制一个通道 强度映射关系 HueVsHue：默认为0.5的直线 色相偏移量(色环上偏移一定角度) HueVsSat/SatVsSat/LuaVsSat：默认为0.5的直线

## Tonemapping

Neutral模式：变化不明显-尽量不改变Hue和Sat ACES模式：对比度比Neutral更强

# 非Lut后处理效果

分类为后处理，但是性质上与颜色空间、色调调整不同。

## Bloom

自发光、光晕。

## Chromatic Aberration

色差，是相机镜头光学上的误差，导致白光分散成彩虹状光边。 参考：Inside中的Chromatic Aberration效果 表现相机冲击或陶醉效果。

## Depth of Field

景深，模拟镜头的聚焦特性。 在现实生活中，镜头只能在特定距离上清晰对焦。 距离相机较近或较远的物体会有些失去焦点。 模糊可以提供关于物体距离的视觉线索。 好的焦外仅仅是陪衬，不抢镜头。

## Film Grain

使画面带有颗粒感。

## Lens Distortion

镜头畸变，用于模拟镜头的形状。

## Ambient Occlusion

环境光遮挡，近似于实时AO(取决于场景的复杂性)。 在两个物体互相靠近的地方变暗，如折痕、孔。 比较消耗性能，成本取决于屏幕分辨率和效果参数。

## Anti-aliasing

后处理抗锯齿，有FXAA、SMAA、TAA等算法。 由于图形输出设备的分辨率不足以显示直线，导致线条出现锯齿状效果。 抗锯齿功能将锯齿状线条着色为两侧的中间色，用模糊，减少锯齿突出程度。

## Auto-Exposure

自动曝光。 人眼有适应昏暗环境和明亮环境的能力，自动曝光模拟这种能力。 通过判断场景的平均亮度值(需要Compute Shader支持)，找到一个合适的HDR范围。

## Deferred Fog

屏幕空间的雾，基于深度贴图。 有线性、指数、指数平方，等效果类型，对视野深处物体有遮掩效果。

## Motion Blur

运动模糊，当拍摄对象的移动速度大于相机的曝光时间时，相机模拟图形的模糊。 在多数类型游戏中有微妙的效果，在赛车游戏中被夸大。

## Screen-space reflections

屏幕空间的反射，使物体表面能反射到当前屏幕内的内容。 将镜面物体上的空间转换到镜面下，混合，无法获得视椎体外的信息。 利用在水面、地板，镜面与视野夹角很小的时候，被反射物离开屏幕时出现bug。 想要完美平滑的反射，应使用反射探针或平面反射。

## Vignette

渐晕，图像边缘系统颜色系数和过渡效果。 常用于艺术效果，锁定注意力、场景转换。 可考虑使用自定义动效硬边缘，做花式的场景转换效果。

## Panini Projection

修复透视相机在高FOV下(100度)存在的几何扭曲(墙变斜了)。

# HDRP专有效果

虚拟环境Visual Environment -Gradient Sky -HDRI Sky -Physically Based Sky 材质 Diffusion Profile Override 光照 Indirect Lighting Controller Screen Space Refraction 屏幕空间的折射 阴影分类 Contact Shadows -Micro Shadows 法线贴图产生的细微阴影 -Shadows 调整Shadowmap的细节参数 光线追踪分类 -Global Illumination -Light Cluster -Path Tracing -Recursive Rendering -Ray Tracing Settings -Sub Surface Scattering