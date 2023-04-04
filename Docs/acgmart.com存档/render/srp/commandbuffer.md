---
title: SRP CommandBuffer
tags: []
id: '2106'
categories:
- [渲染, SRP]
date: 2020-06-01 21:08:12
---

\[toc\]本篇讨论Unity中的CommandBuffer 学习本篇需要有一定的渲染管线基础，可参考渲染基础系列文章，能做出简单的shader效果以上。

# 什么是SRP？ URP、HDRP？

ScriptableRenderPipeline是全称，如果谷歌搜索很快就能定位到Unity的[SRP github](https://github.com/Unity-Technologies/ScriptableRenderPipeline/releases "SRP github")； 如果搜索可编程渲染管线可能会看到一些2016年前的资料，还有固定管线的说法； 所以负责与硬件沟通的着色语言一直存在，部分可编程和高度可配置是这些语言的特征； 而Unity提供的SRP，是一个C#脚本封装版本的可编程渲染管线，本质上是不开源的，高度可配置；

# SRP做了什么

如果下载URP或者HDRP工程，可以观察其中定义的Pipeline类型； 如果管线实例的Render方法如果直接return，那么屏幕就是全黑的，没有任何渲染事件发生。 有个老教程“[SRP demo](https://github.com/stramit/SRPBlog/tree/master/SRP-Demo/Assets/SRP-Demo "SRP demo")”示例了3个简单效果，单一颜色、不透明物体、透明物体； 代码虽已过时，但是具有启发意义。 **清理RT**： cmd.ClearRenderTarget(...); //使用CommandBuffer实例添加渲染命令 context.ExecuteCommandBuffer(cmd) //执行渲染名 注：CommandBuffer实例在被执行后需要“Clear后继续使用”或者“Release”，context在执行多次绘制方法后“Submit”提交任务队列。 **不透明物体**： context.DrawRenderers(...); //剔除掉不显示的物体、指定shader pass、渲染排序方式； **天空盒子**： context.DrawSkybox **透明物体**： context.DrawRenderers(...); //和不透明物体类似，在物体的队列值上有差别； 还有阴影、后处理等更复杂的渲染效果。 SRP暴露出来的接口来自于C++底层，一方面是黑盒子闭源，另一方面是由C#更高效的去沟通硬件。

# RT与CommandBuffer

RenderTexture：类似于图片，可以利用通道存储各种各样的数据，可被采样； CommandBuffer是一个容器，保存要执行的渲染命令； CommandBuffer并不是一个新概念，很久以前就是自定义Unity渲染流程的主要手段了； 在Render方法中可以插入自己写的代码并提前return，可用此学习commanderbuffer的用法

## 不主动声明任何RT时，也存在一个默认RT。

```
var cmd = new CommandBuffer();
cmd.ClearRenderTarget(true, true, Color.red);
cmd.name = "test";
renderContext.ExecuteCommandBuffer(cmd);
cmd.Release();
renderContext.Submit();
return;
```

在性能分析器中可以看到当前RT名字是“No Name”。

## 设置渲染目标

`cmd.SetRenderTarget(BuiltinRenderTextureType.CameraTarget);` 设置“[active render target](https://docs.unity3d.com/ScriptReference/Graphics.SetRenderTarget.html "active render target")”操作，涉及到RT的加载和释放，会产生一定的带宽消耗。 Unity在SRP的Core库中重写了十来种SetRenderTarget方法，对应不同的场景。 如果要使用MRT(多个颜色写目标)，则应提供colorBuffer阵列作为参数，每个RT对应片元做色器输出； URP也支持MRT，但是我们很难见到MRT相关的代码，这里展示一个shader参考：

```
struct PSOutput
{
    float4 position : SV_TARGET0; //颜色写目标 序列0
    float4 normal : SV_TARGET1; //颜色写目标 序列1
    float4 albedo : SV_TARGET2; //颜色写目标 序列2
}

PSOutput frag(v2f i)
{
    PSOutput o = (PSOutput)0;
    o.position = float4(0, 0, 0, 0);
    o.normal = float4(0, 0, 0, 0);
    o.albedo = float4(0, 0, 0, 0);
    return o;
}
```

## 其他RT、renderbuffer的访问方法

Display.main.colorBuffer Display.main.depthBuffer RenderTexture.active BuiltinRenderTextureType.CameraTarget

## 遍历相机执行渲染任务

场景中有很多个相机，这里给一个相机循环的例子：

```
foreach (var camera in cameras)
{
   if (!camera.TryGetCullingParameters(out var cullingParameters))
        return;
    CullingResults cullResults = renderContext.Cull(ref cullingParameters);
    renderContext.SetupCameraProperties(camera);

    var cmd = new CommandBuffer();
    cmd.ClearRenderTarget(true, true, Color.black);
    renderContext.ExecuteCommandBuffer(cmd);
    cmd.Release();

    SortingSettings sortingSettings = new SortingSettings(camera) { criteria = SortingCriteria.CommonOpaque };
    DrawingSettings settings = new DrawingSettings(new ShaderTagId("UniversalForward"), sortingSettings);
    FilteringSettings filterSettings = new FilteringSettings(RenderQueueRange.opaque, -1);
    renderContext.DrawRenderers(cullResults, ref settings, ref filterSettings);

    renderContext.DrawSkybox(camera);
    renderContext.Submit();
}
return;
```

这里没有设置目标，所以多个相机渲染到同一个RT，是一个错误示范。 了解正确示范可以参考URP中的相机栈工作模式。 会被渲染的物体需要满足以下条件： 1.layer在相机的Culling Mask内； 2.Shader的Queue值在2500以内； 3.ShaderTagId("LightMode" = "UniversalForward") 4.Shader中不写LightMode时默认ShaderTagId值为“SRPDefaultUnlit”

## 后处理方法

图片后处理，相当于采样图源，经过shader计算，写入当前RT； 任何的绘制行为，都需要有顶点数据，来自于mesh或者geometry阶段； 相当于要绘制一个不在场景中的mesh，这个mesh刚好能包围屏幕范围； 这种方法经常用于后处理效果，可以往当前RT中绘制Overlay效果：

```
var cmd = new CommandBuffer();
cmd.SetViewProjectionMatrices(Matrix4x4.identity, Matrix4x4.identity);
cmd.DrawMesh(RenderingUtils.fullscreenMesh, Matrix4x4.identity, material, 0, 0);
cmd.SetViewProjectionMatrices(camera.worldToCameraMatrix, camera.projectionMatrix);
renderContext.ExecuteCommandBuffer(cmd);
cmd.Release();
renderContext.Submit();
```

修改VP矩阵后，保证mesh可以覆盖到全屏，屏幕空间的位置=世界空间位置。 这里我使用的是Core库中提供的全屏mesh，在后处理效果中很常用。 这里的material，可以随便写点什么，UnlitTexture或者返回固定颜色都行。

## 深度读写与Stencil测试

能在屏幕上绘制三角形，说明我们具有了对colorBuffer的写入能力； 相应的，对depthBuffer的写入，需要有深度读写目标，并且开启深度测试； Stencil测试在深度测试之前进行，任何测试失败都会停止写入： Stencil { Ref 10 Comp Always Pass Replace } Stencil { Ref 10 Comp Equal}