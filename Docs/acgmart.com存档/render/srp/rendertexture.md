---
title: SRP RenderTexture
categories:
- [渲染, SRP]
date: 2020-06-01 11:04:23
---

\[toc\]本篇讨论SRP中的RenderTexture

# RT的用途

我们在很多地方都用到了RT，RT是主要的存储渲染数据的手段，下面是一些例举： cmd.SetRenderTarget(...); //作为颜色和深度的写入目标 float4 color = tex2D(MainTex, i.uv0); //作为颜色读取目标 采样 将RT保存为图片 序列化 cmd.GetTemporaryRT(...); //申请一个临时RT 作为读写目标 RenderTexture：用于引用一个RT实例 RenderTextureDescriptor：用于描述一个RT，可用来准确创建一个RT。

属性名

RenderTexture

RenderTextureDescriptor

像素宽度

width

width

像素高度

height

height

保存在Gamma空间

sRGB

sRGB

动态分辨率

useDynamicScale

useDynamicScale

MSAA级别

antiAliasing

msaaSamples

?

volumeDepth

volumeDepth

mipmap数量

自构时指定

mipCount

直接采样MS贴图

bindTextureMS

bindMS

颜色缓冲格式

format

graphicsFormat/colorFormat

深度缓冲格式

depth

depthBufferBits

stencil data格式

stencilFormat

stencilFormat

纹理类型

dimension

dimension

?

?

shadowSamplingMode

?

vrUsage

vrUsage

?

?

flags

不保存到RAM

memorylessMode

memoryless

标记为拥有mipmap

useMipMap

useMipMap

自动生成mipmap

autoGenerateMips

autoGenerateMips

(SM4.5)随机读写

enableRandomWrite

enableRandomWrite

是否为当前读写目标

active

?

转化为描述

descriptor

?

采样时过滤方式

Bilear??Point??

\-

重复模式

repeat?clamp?

\-

## 动态分辨率

当GPU繁忙时，降低RT分辨率，提高渲染速度，需要开启性能分析。 参考：[动态分辨率](https://docs.unity3d.com/Manual/DynamicResolution.html "动态分辨率")系统允许根据GPU的负载动态缩放RT的分辨率，在相机组件开启；

## stencilFormat

设置stencil data的格式 设置stencilFormat将导致stencil data可以作为Texture采样(在受支持的平台)； 受支持的格式有：R8\_UInt(dx11/dx12)，R8\_UNorm(PS4) 并不设置stencil buffer的格式，stencil buffer由RenderTexture.depth决定

## 纹理类型(TextureDimension) 默认值Tex2D

一般我们使用的都是Tex2D类型，其他类型可能用于特殊情况(VR/探针)； 参考：[dimension](https://docs.unity3d.com/ScriptReference/RenderTexture-dimension.html "dimension")

## mipmap相关

autoGenerateMips 默认值true 当开启了mipmap(useMipMap = true)，此RT结束被绘制(更换active RT)时自动生成mipmap。 useMipMap 默认值false 是否生成mipmap，要求RT宽高为2的指数。

## MSAA

开启MSAA会导致贴图的格式产生变化，需要转化为正常纹理，或者使用MSAA贴图的采样语法： `LOAD_TEXTURE2D_MSAA(_CameraDepthAttachment, uv, sampleIndex)`