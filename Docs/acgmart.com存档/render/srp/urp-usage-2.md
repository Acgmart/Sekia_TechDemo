---
title: URP数据与接口 - ForwardRenderer
categories:
- [渲染, SRP]
date: 2020-07-01 22:04:53
---

\[toc\]本篇继续讲URP中的数据与接口。 本篇从渲染方案讲起，也就是ForwardRenderer类型，遇到什么再说什么。

# ForwardRenderer概览

ForwardRenderer实例随着管线实例初始化时，批量初始化； 多个ForwardRenderer实例供相机选择，可切换渲染方案： 比如A场景有特殊的镜面效果，A场景的主相机需要用到镜面相机方案。 在代码方面，主要继承Setup方法，判断如何处理Pass队列。 方案中自带了很多Pass，改动需要修改源代码，而自定义Feature则可以灵活插入。

# Setup方法

Setup中决定了Pass队列和写入目标，是相当核心的逻辑代码；

## 分支 - 非相机栈+渲染深度到RT

如果设置相机的渲染目标为RT，且RT的格式为Depth，那么我们可以得到一张深度图； 为了实现这样的，特殊的相机渲染任务，可以简化流程，只渲染有深度值的步骤： RT的写目标就是BuiltinRenderTextureType.CameraTarget，表示用户指定的RT。

## 分支 - 创建中间RT

如果将写入目标处理为一个可以随时采样的临时RT，对自定义着色方案非常有意义； URP中会有很多判断，来决定最终是否创建这样的临时RT： 当前的相机是否需要？用户有没有主动要求？硬件是否支持？是否被其他环节需求？ 1.对于相机栈，栈长度大于1时，Base相机需要创建指定的颜色RT作为写目标； 后续的Overlay相机，则必须，使用Base相机创建的颜色RT作为写目标。 2.对于Scene相机，总是需要创建颜色RT。 3.对于非相机栈(设置了RT作为渲染目标、Base类型)，主要考虑环节需求因素。 4.缩放分辨率效果需要创建颜色RT，先写入到低分辨率RT，再拷贝到FrameBuffer。 5.HDR需要创建颜色RT，FrameBuffer只支持LDR。 6.录像模式需要创建颜色RT。 7.显示器要求使用颜色RT，执行Blit操作。 8.用户有自定义Feature，需要创建颜色RT。 9.预览相机(PreviewCamera)，不需要颜色RT。 是否创建临时的深度RT的规则与颜色RT类似，多了一个DepthPrepass设定： DepthPrepass如果被允许，将使用shader中的`DepthOnly` pass，单独渲染到\_CameraDepthTexture； 如果DepthPrepass不被允许，但是用户指定要求深度RT，则执行CopyDepthPass，复制一份深度RT。 可能是，URP为了兼顾用户采样\_CameraDepthTexture的习惯做出这样的选择。 指定的颜色RT名为：\_CameraColorTexture 指定的深度RT名为：\_CameraDepthTexture(可采样)或\_CameraDepthAttachment 这两个RT将作为全局纹理，可以在shader中采样，实现自定义效果。

# 创建深度图

在URP库的DeclareDepthTexture.hlsl中，声明了深度贴图：

```
//声明变量
TEXTURE2D(_CameraDepthTexture);
SAMPLER(sampler_Depth);
//采样操作：
float depth = SAMPLE_TEXTURE2D(_CameraDepthTexture, sampler_Depth, i.uv).r;
```

在FrameDebugger中，可以观察到\_CameraDepthTexture的描述： 精度是Tex2D，RT格式是Depth，只有A通道被写入了；最亮的地方为1，表示相机近截面； ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/render/present/029.png) 注：要正确获取深度值，需要采样时间在深度贴图生成之后： 添加Tag："Queue" = "Transparent" 能让透明度阶段采样到非透明阶段的深度 如果深度贴图是后处理专用的，其生成阶段就可能是透明阶段之后，这种情况下不能提前采样深度贴图。 不能使用tex2D方法(报错提示第一个参数不符合预期)，而是SAMPLE\_TEXTURE2D。

## 创建2个RT还是1个RT

上一步，我们判断了是否需要独立的颜色/深度作为写目标； 接下来就需要创建RT，渲染时则设置为渲染目标。 如果仅创建颜色RT，那么深度RT被设置为BuiltinRenderTextureType.CameraTarget； 单独的颜色RT不需要有深度缓冲。 如果将颜色缓冲和深度缓冲合并在1个RT里面，那么在配置目标时，深度应与颜色相同： ConfigureCameraTarget(color.Identifier(), color.Identifier()); 这样一来，我们在自定义Feature中，可以做如下判断： if (renderer.cameraDepth == renderer.cameraColorTarget) 返回真，说明颜色和深度缓冲在相同RT，符合预期。 一个RT里面同时具有颜色和深度，导致深度缓冲无法被采样，采样时默认返回颜色缓冲的值； 这种情况下，不影响正常的模板测试和深度测试，但是无法将深度值提取出来用于自定义计算。

## 深度copy Pass

CopyDepthPass的执行位置： m\_CopyDepthPass.renderPassEvent = 不透明之后？透明之后？ 这种调整可能没有实际意义，这与透明的实现有关。 我们约定透明物体，进行深度测试，但是不写入深度值(所以深度没有变化)； 通过alpha混合，实现透明的假象； 这种做法，在物体的形状奇特的情况下，可能出现效果BUG； 我们只能根据物体位置，粗略决定渲染顺序，而不能决定每个像素的渲染顺序； 所以我们先约定不处理复杂的透明物体(比如带把的透明杯子)。 为\_CameraDepthTexture申请RT：

```
var descriptor = cameraTextureDescriptor;
descriptor.colorFormat = RenderTextureFormat.Depth;
descriptor.depthBufferBits = 32;
descriptor.msaaSamples = 1;
cmd.GetTemporaryRT(destination.id, descriptor, FilterMode.Point);
```

和\_CameraDepthAttachment的申请语法一致。 执行逻辑： 根据深度采样源RT的msaa级别，判断如何设置关键词； 设置采样源\_CameraDepthAttachment为全局Texture变量； 判断深度是否需要翻转(DX平台需要翻转，z = 1 - z)； 使用专用后处理shader绘制到深度RT； cmd.DrawMesh(RenderingUtils.fullscreenMesh, Matrix4x4.identity, m\_CopyDepthMaterial); 注：如果vert方法中直接将世界坐标作为裁剪空间坐标，可以省去重置相机矩阵的步骤。 复制深度用shader 路径：Hidden/Universal Render Pipeline/CopyDepth ZTest Always ZWrite On：frag阶段的深度测试全部通过，写入到\_CameraDepthTexture的深度缓冲。 ColorMask 0：不进行任何颜色的输出 Cull Off：不检测正面反 后处理shader常用 float frag(...) : **SV\_Depth**：frag方法输出指定到深度RT

```
//vert阶段：
output.positionCS = float4(input.positionHCS.xyz, 1.0); //直接使用Object空间作为Clip空间
//frag阶段(MSAA为0时 等同于采样R通道)：
return SAMPLE_DEPTH_TEXTURE(_CameraDepthAttachment, sampler_CameraDepthAttachment, uv)
```

那么，如果采样源开启了MSAA，应如何采样呢？ 操作比较复杂，不过多介绍，下面是采样MS中的某一层： `LOAD_TEXTURE2D_MSAA(_CameraDepthAttachment, uv, sampleIndex)`

# 主阴影绘制

我们可以从网上的很多文章中了解到阴影成像的原理(Shadow Mapping)： 将相机位置移动到光源位置，绘制阴影视椎体的深度图； 也就是说，要计算主光源的V矩阵和P矩阵，使用阴影Pass，绘制到ShadowMap纹理。 光源空间是无限宽广的，但是ShadowMap尺寸有限； 好在我们只需要绘制光源空间中，被相机可见的部分。 阴影空间(光源空间中的阴影长方体)： 正交相机和透视相机有着不同的视椎体，长方体或锥体； 在光源空间，使用一个更大的长方体，使之正好包裹视椎体(长宽高确定)； 这样，我们就得到了一个关于阴影范围的裁剪矩阵(和P矩阵类似)： 如果世界空间中的某点，转换到阴影空间，出现在长方体之外，表示相机看不到该点。 如果出现在长方体内，则将`深度值`记录在ShadowMap上； 如果ShadowMap上已经有记录，则使用深度测试，重写深度值。 这样一来，就能判断物体的某个位置，是否在阴影内。 Cascade： 如果按照上述的方法绘制ShadowMap，会导致透视相机下，阴影面积被缩放： 对于ShadowMap来说，它看到的物体比例不会发生变化； 对于透视相机来说，它看到的物体，近大远小； 比如，远近各有2个球形阴影，近的边缘清晰，远的边缘锯齿。 解决方案是Cascade ShadowMap，级联阴影。 在默认方案中，整个阴影长方体都在对一个深度值进行深度测试； 在Cascade方案中，将空间分成了多个区域(多个VP矩阵)，分别进行深度测试； 这样一来，阴影长方体中，不同区域之间的物体比例产生了差异。 Cascade ShadowMap： 可能存在多个级联，但是只绘制一个RT，所以根据级联数切割； 级联数可能为1、2、4；当为2时shadowmap的高度为宽度的一半；其余时候是正方形； 级联级别设置：管线设置-shadows-Cascades选项 相关的关键词、变量： 软阴影：\_SHADOWS\_SOFT 级联阴影：\_MAIN\_LIGHT\_SHADOWS\_CASCADE 主光源阴影：\_MAIN\_LIGHT\_SHADOWS world2shadow矩阵数组(序列为cascade层，0-3)：\_MainLightWorldToShadow ShadowMap：\_MainLightShadowmapTexture 阴影参数Vect4：\_MainLightShadowParams x：光源的阴影强度 y：是否开启软阴影 采样阴影方式(参考Shadows.hlsl)： 获取阴影强度：half MainLightRealtimeShadow(float4 shadowCoord) 计算shadowCoord：o.shadowCoord = TransformWorldToShadowCoord(o.posWorld); 自定义ShadowMap： 有时候，我们想表现人物身体上细节部位的阴影，比如裙子投射给大腿的阴影； 我们对阴影的品质要求很高，那么久不能将有限的ShadowMap分配给全局、自动划分级联。 1.单独对人物使用一张ShadowMap，使阴影长方体的长度变得最短，需要定制代码。 2.使用一层级联，并且限制阴影长方体长度，使远处阴影丢失。

# 其他要绘制的内容

## 反射探针

真实物体必然带有一定的反射属性，用反射方向采样反射探针(Cubemap)，场景中的每一个物体的默认反射探针为天空盒子，反射探针有6个面需要绘制；

## 光照探针

动态物体也需要受到静态物体的阴影和GI，每个光照探针抓取自身位置处的光照信息保存为27个浮点数；每个物体必须被四边体(4个光照探针)包围，受近处的光照探针影响大。

# 屏幕空间的阴影贴图

创建一个id为\_ScreenSpaceShadowmapTexture、同默认RT属性、格式为R8的单通道RT； 使用一个刚好笼罩屏幕的mesh，shader为ScreenSpaceShadows.shader。 将深度图\_CameraDepthTexture转换为屏幕空间的Shadowmap，类似于Blit。

# ColorGradingLutPass

本Pass的执行条件是开启了后处理，为后处理准备[用于ColorGrading的Lut贴图](https://zhuanlan.zhihu.com/p/84908168 "用于ColorGrading的Lut贴图")。 ToneMaping使图像能表现出更多细节，如高亮处和昏暗处。