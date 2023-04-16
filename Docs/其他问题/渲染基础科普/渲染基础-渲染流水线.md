---
title: 渲染基础-Pipeline
categories:
- [渲染, 渲染基础]
date: 2020-06-01 00:00:59
description: 渲染流水线包括可配置部分和可编程部分...
cover: https://img.acgmart.com/uploads/article/render/base/render_pipeline/cover.png
sticky: 99
---
本篇记录一些零散的基于Unity使用经验的渲染管线理解；
限于篇幅不便于写的大而全，挑些常用的讲讲。

# 前言
**参考资料**
[《Shader入门精要》](https://github.com/candycat1992/Unity_Shaders_Book)
[Unity手册](https://docs.unity3d.com/Manual/SL-ShaderPrograms.html)

**为什么要学ShaderLab呢**
图形化工具制作shader虽然能快速实现效果，但是难以优化。
需要开发人员/技术美术有能力对Shader进行功能分析、效率评估、优化、Debug。
所以这个学习过程一般都是根据需求写代码 - 根据表现判断最精简的代码量。

# 渲染流水线解释

![](https://img.acgmart.com/uploads/article/render/base/render_pipeline/1.png) 
这里面包括很多个小阶段，有些是可配置的，有些是可编程的。 
对应可配置的部分，需要了解这些流程都干了啥、可用的选项/开关的具体效果；
对应可编程的部分，需要了解对应的语法，也就是声明变量、计算、读写过程。

## 应用阶段 
应用阶段是指几何阶段之前的阶段，CPU通过向GPU提交Draw Call(DC)来发起一次渲染；
加载所有数据到内存→网格和纹理到显存→设置RenderState→提交DC；
这些操作在Unity中通常都是Renderer组件或者CommandBuffer中完成的。

**渲染相关的数据**
Camera：相机位置，V矩阵、P矩阵； 
光源：光源位置，光源空间矩阵、环境光； 
逐顶点数据：POSITION、NORMAL、TANGENT、TEXCOORD0~5、COLOR； 
渲染状态：材质属性、贴图、shader变体、相关光源/Probe； 

粗粒度剔除
提交DC之前，粗略判断是否在相机视椎体内，减少不必要的渲染任务；
在Animator、Particle System等组件中还有关于物体不可见时的逻辑设置； 

描述一次DC
一次DC，绘制的内容最少到一个“后处理Quad”，最多到大量mesh； 
这次DC所依赖的数据和渲染状态都在提交DC时设置好了，计算过程中不会改变； 
GPU很擅长做这种重复枯燥的任务，高并行运算，任务之间互相独立。 

## 几何阶段 
几何阶段用于描述一次DC的逐顶点计算过程。

顶点着色器-可编程
Vertex Shader：每个顶点执行一次，顶点之间相对孤立。
从这里开始，就需要接触到多种**几何空间**，用于3D计算：
模型空间(逐顶点数据)→世界空间→观察空间→裁剪空间-->(齐次去除)； 
齐次去除由后续硬件负责，得到归一化的设备坐标(NDC，Normalized Device Coordinates)； 

曲面细分着色器-可编程/可选 
Tessellation Shader：细分图元，SM5.0以上。 通过对表面的细分，增加表面细节，用的少。

几何着色器\-可编程/可选
Geometry Shader：通过编程生成自定义mesh数据。 
图元：点/线段/面，有这3种拓扑方式可以构成mesh。
举例：使用几何做色器生成草、果冻等组织相对稳定的软体。

裁剪-可配置
Clipping，在NDC空间中判断顶点是否在视椎体内的可见；截断处产生新的顶点。

屏幕映射-无法控制
Screen Mapping：将图元坐标转换到屏幕空间。 
屏幕映射后决定了每个顶点对应屏幕上的哪个像素、深度。

## 光栅化阶段
光栅化阶段用于一次DC的逐像素计算过程。

三角形设置-无法控制
Triangle Setup，通过三角面片的三个顶点计算出三角形边界的表示方式。

三角形遍历\-无法控制
Triangle Traversal，检查逐像素是否被一个**三角面片**覆盖，被覆盖的像素生成一个片元。
![](https://img.acgmart.com/uploads/article/render/base/render_pipeline/2.png) 
片元：一个待定的像素，如果所有测试通过，就执行对应片元计算、写入buffer操作；
逐片元数据：从逐顶点数据差值继承过来的数据、深度值。 

片元着色器\-可编程 
Fragment Shader，使用逐片元数据计算逐片元的颜色。 

逐片元操作-可配置 
[Per-Fragment Operations](https://en.wikibooks.org/wiki/GLSL_Programming/Per-Fragment_Operations)，输出合并阶段。
![](https://img.acgmart.com/uploads/article/render/base/render_pipeline/3.png) 
可见测试→透明度测试→(模板测试+深度测试)→混合操作→Mask→写入；
任务1：决定每个片元的可见性，也就是抛弃一些片元； 
任务2：对通过了测试的片元与颜色缓冲区的颜色值进行**混合操作**；
Fragment+Associated Data：逐片元数据； 
Pixel Ownership Test：如果当前窗口被其他窗口遮挡住了，就不会通过测试； 
Scissor Test：裁剪测试，超出视口的范围不会通过测试； 
Alpha Test：透明度测试，也就是clip、discard方法，用户在代码中可选调用；
Stencil Test：模板测试，提供逐像素的遮罩，用于标记/限制区域；
Depth Test：深度测试，与深度RT中的深度值进行对比；
Blending：片元再写入颜色时与旧颜色值之间的互动选项；
ColorMask：可控制对哪些通道进行写入；
RenderTexture(RT)：GPU中表示一张图片、二维数组，可进行颜色读写；
FrameBuffer：表示显示器的RT，将渲染结果提交到这里可完成一帧的渲染。

**关于Early Z** 
Early Z表示Stencil Test和Depth Test两个操作，提前进行深度测试+写入； 
提前的好处在于，可避免大量多余的frag计算；
如果用户在frag方法中使用了clip，就不会Early Z，效率下降。
Early Z能不能做的核心在于必须所有测试都成功才能执行写入操作； 
作为硬件功能，Early Z无需开启，按照Queue渲染可最大化利用这个特性。

# URP管线下的Shader语法
SRP的出现提供了很多效果工具、更规范的代码格式、更强大的扩展；
可使用ShaderGraph或VisualEffectGraph生成对应的shader文件版本；
将Unity官方工具中用到的代码集成到自己的库中是很棒的体验。
可在官方库中搜索对应语法、函数的使用细节；
使用HLSL语法编程时，系统底层的暗操作很少，对编程人员友好。

## 属性
**Propertie**
这里声明的属性主要是用来生成**shader GUI**，便于美术人员调整效果。
浮点数类型：颜色、4元数、整形、浮点数、Range
\_Color("颜色", Color)= (1,1,1,1) 
\_Vector("四元数", Vector)= (1,2,3,4)
\_int("整形", int) = 100
\_Scale("缩放", float) = 3.14
\_Range("Range", Range(1,10)) = 6

贴图类型：2D、Cube
\_2D("Texture", 2D) = "white" {}
\_NormalMap("NormalMap", 2D) = "bump" {}
\_Cube("Cube", Cube) = "Skybox"{}

**HLSLPROGRAM内的属性声明**
这里声明的属性决定变量的存储位置、数据结构等。
浮点数类型：
float4 \_Color;
float \_Scale;
贴图类型：
TEXTURE2D(\_BaseMap); SAMPLER(sampler_BaseMap);
Buffer类型：
StructuredBuffer\<float3> \_PositionBuffer;
RWStructuredBuffer\<int> \_intBuffer;

## 标签与渲染状态
**SubShader**
LOD：默认值0，用于选择运行时使用哪个SubShader。
通常LOD值越大，代表对应的SubShader的效果更好但是计算更复杂。 
脚本中设置全局的LOD的最大值: Shader.globalMaximumLOD；
脚本中设置单个shader的LOD的最大值 \_shader.maximumLOD；
SubShader下的渲染状态设置适用于后续的所有Pass。

**SubShader Tags**
每个标签对应一个功能，在URP下用到的机会变少了。
举例：Tags { "Queue" = "Geometry+1" "RenderType" = "Opaque" } 
等号两边是一个键值对，可以像查字典一样的搜索Key查对应的Value。
Queue：指明渲染顺序。 
RenderType：着色器替换功能中的标签。
PreviewType：指明材质预览使用的mesh。 

Queue的使用
在一个批次的多个物体中排序，序列越小的先渲染。 
Geometry、AlphaTest、Transparent分别对应2000、2450、3000。
这是一个经常与我们打交道的标签，严格的Queue值能保证渲染先后的正确性；
而不同Queue的物体会被强制不合批，所以只有透明物体才特别设置这个。

**Pass**
每个Pass代表一个DC，如着色Pass、投影Pass、深度Pass。
声明Pass：一般名称是UniversalForward、ShadowCaster、DepthOnly
UsePass： 引用其他shader文件中的指定Name值的Pass，Pass的Name大写。
   例：UsePass "Test/Test1/SHADOWCASTER"
GrabPass：旧管线才有的，相当于拷贝一次颜色RT。

**Pass Name和Pass Tags**
Name：用于UsePass或FrameDebug调试时显示的名称。
LightMode：可用于开关材质的特点Pass、提交批量渲染指令时过滤Pass。

**渲染状态**
如果不设置渲染状态，那么渲染状态就是默认值，可按需开启不同的状态。
Stencil测试：默认Off
深度测试：Cull默认Back；ZTest默认LEqual；ZWrite默认On
混合模式：Blend默认值为One Zero, One Zero
ColorMask：默认值为RGBA，对所有颜色通道都写入。可指定目标RT的index。
Offset：可以对斜面物体造成深度值的偏移，用的少。

透明物体
常规不透明物体没有必要设置渲染状态，透明物体会麻烦很多。
开启透明混合：Blend SrcAlpha OneMinusSrcAlpha, Zero Zero
关闭深度写入：ZWrite Off
特效粒子因为到处飞，需要关闭Cull：Cull Off
透明物体必须从后往前渲染才能保证混合出最终正确的效果。
通常会用多Pass处理描边、头发、渐隐等复杂的透明效果。
像树叶、溶解特效这种形状复杂的表现，需要用**透明裁剪**实现。

模板测试
例：Stencil { Ref 64 ReadMask 64 WriteMask 64 Comp NotEqual Pass Keep Fail Keep } 
Ref值：用来做或与非判断，所以最好是2的整数幂。
ReadMask/WriteMask：在读写stencil buffer时做或与非计算，最好和Ref值一致。
comparisonFunction：等于或者不等于。
StencilOp：测试成功就写入或者测试失败就写入。

## 业务代码
**HLSLPROGRAM内的pragma声明**
pragma vertex vert：指定名称为vert的函数为顶点着色器代码
#pragma fragment frag：指定名称为frag的函数为片元做色器代码
#pragma geometry geom：指定名称为geom的函数为Geometry shader代码
#pragma target 4.0：指定shader编译目标级别，默认为2.5。
#multi_compile_fog：声明雾相关的关键字
#pragma multi_compile_local：声明逐材质的关键字
#pragma multi_compile：声明全局的关键词
#pragma shader_feature：声明全局的关键字，未使用时不参与打包，可用于调试。
例：#pragma multi_compile _ \_SPHEREMAP_ON
   下划线表示默认状态，是一个名称缺省的关键字，比如\_SPHEREMAP_OFF。
   添加这一行会使shader变体数量翻倍，分别为效果的开启和关闭2种情况。
   代码中通过#ifdef~#endif等宏定义方式做逻辑分支。
材质关键词查看：在debug模式看材质属性或者FrameDebug中看DC的关键字。
全局关键字的开关：代码调用Shader.EnableKeyword
本地关键字的开关：代码调用Material.EnableKeyword
注：shader关键字应按需声明，过多变体导致打包时间边长。

**属性ShaderGUI与Shader关键字**
A-1：[Toggle]\_Invert("Invert color?", Int) = 0
A-2：[Toggle(\_INVERT\_ON)] \_Invert("Invert color?", Int) = 0
   当Toggle为开启状态时会为材质添加\_INVERT\_ON关键字。
B：[KeywordEnum(OFF, ON)]\_Invert("Invert color?", Int) = 0
   KeywordEnum可声明数量更多的关键字。
C：[ToggleUI]\_Invert("Invert color?", Int) = 0
   纯UI版本，不会激活关键字。
D：[Enum(Off, 0, On, 1)]\_Invert("Invert color?", Int) = 0
   纯UI版本，不会激活关键字。

**其他常用属性ShaderGUI**
[NoScaleOffset]：让贴图属性不显示UV偏移变量。
[HideInInspector]：属性不显示在面板上，通常用于程序化赋值的材质 。
[HDR]：使用HDR调色板，使颜色值超过1，并且不执行Gamma矫正。 
[NonModifiableTextureData]：不允许在Inspector编辑。

**HLSLPROGRAM内的代码声明**
从这里开始就是编写shader代码的主要业务了，编译从上到下执行，风格类似C++。
SubShader下的HLSLINCLUDE/ENDHLSL：对全部Pass都有效的公共代码。
#define：自定义宏和函数
   例：#define FOG_LINEAR：直接用宏替代雾关键字减少变体数
#include：包含库，效果相当于把目标文件整个复制粘贴进来。
声明输入输出结构体、vert/frag方法、自定义代码等...
简单总结就是利用各种数据实现对目标RT的写入操作。
   Shader是效果表现得核心层，串联管线代码、逻辑代码、美术资产。

# 美术资产管理
不同部门的美术人员生产特定资源，由需求驱动的分工模式来实现功能开发。
3D部门：模型、贴图、材质球
动作部门：绑骨与动作、动画控制器、碰撞器、动态骨骼、相关脚本
特效部门：技能特效、UI特效、相关脚本

## 贴图导入设置
![](https://img.acgmart.com/uploads/article/render/base/render_pipeline/4.png)
纹理类型
默认为Texture，常用的还有NormalMap、Sprite。
   这些纹理类型都可以用于shader采样，本质区别是通道和浮点精度不同。
   NormalMap可为PBR物体添加光照细节；
   Sprite可为UI元件支持九宫格、图集等功能。

Texture Shape：默认为2D，Cube模式常用于反射采样。
Alpha Source：指定透明通道的值如何生成，透明通道默认值为1。
   From Gray Scale：指定A通道由RGB通道的intensity与计算生成。
Alphpa Is Transparency：将完全透明区域的RGB值预计算为0。

MipMap
shader中采样纹理时会自动访问对应层级的mip。
mip相当于多层高斯模糊，可解决3D物体贴图分辨率过高时的像素抖动问题。
对于UI层的物体完全不需要开启mip。

Wrap Mode
指定纹理坐标超过[0,1]后的平铺模式。 
   Repeat：舍弃整数部分
   Clamp：取边界值
   3D模型可以统一平铺模式，特效纹理通常有多层流动UV需要Repeat模式。
Filter Mode
滤波模式，针对不同的场合有专用的过滤模式。
Point模式：采样返回最近的像素值，适合UI。
Bilinear模式：采样返回附近4个像素的混合值，适合3D物体。
Trilnear模式：在Bilinear的基础上混合多层mip，适合远近变化多的3D物体。

纹理的最大尺寸与纹理模式
通常我们的原则是保证效果的同时尽量优化，而且也不是分辨率越大越好。
针对不同平台应寻找压缩格式的最优解。

## 模型导入设置
模型文件主要用于3D表现，问题主要出现在制作环节而不是导出环节。
LightmapUV：对应shader里的TEXCOORD1，仅烘培物体需要开启。
Read/Write Enabled：仅少数程序化控制的模型需要开启。
Material Creation Mode：推荐None，在预制体中赋值材质球，避免丢失材质球。
