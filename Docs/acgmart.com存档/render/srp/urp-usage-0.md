---
title: URP数据与接口 - 管线实例
categories:
- [渲染, SRP]
date: 2020-06-28 13:14:44
---

\[toc\]本篇描述URP中的数据与接口 从UniversalRenderPipeline.cs看起，遇到什么讲什么，跳过了XR/VR设置。

# PerFrameBuffer

这个类型存储了一组静态int，都是全局shader变量，下面判断变量用途。 1.`_GlossyEnvironmentColor` 环境反射光 在取值上：获取环境探针的L0的3个系数，也就是平均环境光色： `new Color(ambientSH[0, 0], ambientSH[1, 0], ambientSH[2, 0])` 得到的是线性空间(linear)的颜色，如果需要转换到gamma空间： color = color.gamma; //0.5变成0.735左右 在使用上：Lighting.hlsl中GlossyEnvironmentReflection方法： 判断材质上是否关闭了环境反射，默认使用unity\_SpecCube0(最近的反射探针)采样；关闭后使用本值，从环境光采样反射值。 2.`_SubtractiveShadowColor` 静态物体-烘焙处的阴影色的下限 在Baked Indirect模式下，只烘焙间接光(采样光照探针)，直接光照依赖于光照计算，阴影色由代码定义。 在Subtractive模式下，烘焙间接光和直接光(采样光照探针、Lightmap)，在静态物体被动态物体遮挡时，计算阴影色，参考Lighting.hlsl中SubtractDirectMainLightFromLightmap方法，使用了简单的兰伯特光照，根据阴影强度决定和默认颜色(bakedGI)决定最终的阴影色；本值用于解决阴影色过暗的问题，提供下限。 在取值上：在Lighting Settings中手动设置。 3.`_Time _SinTime _CosTime unity_DeltaTime _TimeParameters` 时间变量 时间变量在动画shader中频繁的使用。 `_Time`：用于随时间线性变化的设计。 `time * new Vector4(1f / 20f, 1f, 2f, 3f);` 游戏开始后的秒数(float)，我们通常使用1倍系数，也就是\_Time.y。 `_SinTime`和\_CosTime：两个曲线，用于随时间周期变化的设计。 float timeEights = time / 8f; float timeFourth = time / 4f; float timeHalf = time / 2f; new Vector4(Mathf.Sin(timeEights), Mathf.Sin(timeFourth), Mathf.Sin(timeHalf), Mathf.Sin(time)); new Vector4(Mathf.Cos(timeEights), Mathf.Cos(timeFourth), Mathf.Cos(timeHalf), Mathf.Cos(time)); 曲线的的底数变化的越快时，曲线单个周期耗时越长，一般根据实际效果调整。 unity\_DeltaTime：逻辑帧周期 和\_Time差不多 new Vector4(deltaTime, 1f / deltaTime, smoothDeltaTime, 1f / smoothDeltaTime); `_TimeParameters`：时间变量 xyz分量分别是Time、Sin、Cos new Vector4(time, Mathf.Sin(time), Mathf.Cos(time), 0.0f); 小结： 光照设置基本是不会变的，可能切换场景的时候要变。 时间变量每一帧都要设置；主要是标准时间，其他值我们可以手动算。

# \_CameraProfilingSampler

性能分析器，在遍历相机执行渲染任务时，在任务的开始和结束时留下标签。 标签用于在Frame Debugger中留下层级目录，将渲染命令括起来；如果不这样做，渲染命令会排成很长一条；需要分类整理，多个相机时为了方便调试应该取不同的名称。

# maxShadowBias

关联属性：m\_ShadowDepthBias、m\_ShadowNormalBias 阴影的深度偏移和法线偏移的最大值。 因为shadowmap的分辨率有限(2048x2048左右)，在屏幕上多个像素对应shadowmap上一个像素时，就会出现阴影错误，使多个像素中的一半区域被判定为阴影区域；解决方法是移动“阴影体积”，使物体表面全部通过阴影强度判定。 在出现阴影错误时，**根据实际效果调整**，尽量使用最小的偏移值；偏移值过大时导致阴影脱离物体，所以shadowmap的分辨率不能过低。

# minRenderScale maxRenderScale

关联属性：m\_RenderScale 渲染分辨率的缩放，默认的比例通常都是1(使用设备分辨率)； 如果缩放到小于1，图像会变模糊-出现像素化； 如果缩放大于1，效果变化不明显。

# maxPerObjectLights

关联属性：m\_AdditionalLightsPerObjectLimit 一个物体最多可以受到多少额外光源的影响，默认8个，这关联到shader中遍历多光源的计算。

# maxVisibleAdditionalLights

场景中额外光源的最大数量，移动平台32个，非移动平台256个；不包括主光源。 根据性能设置阀值，每个光源都得填充光照数据，避免额外光源数量超过阀值。 使用点： ForwardLights.cs中，填充光照数据时； ForwardRender.cs中，设置相机粗粒度剔除时，底层使用； AdditionalLightsShadowCasterPass.cs中，绘制额外光源的shadowmap，准备光源参数； 逐相机渲染前配置**逐相机光照数据**时(renderingData.lightData)。

# maxScriptableRenderers

在编辑模式下，阻止用户手动添加RendererData到达上限，最多8个。

# UniversalRenderPipeline(asset)

根据SRP的接口，声明管线实例，供底层调用，这部分都是oop编程内容；URP中类型的继承关系并不算复杂，代码阅读难度较小，主要是判断渲染业务逻辑。 作为使用者，我们心里需要清楚，哪些数据应该属于RenderPipeline实例，那些数据应该属于RenderPipelineAsset实例，如何初始化资源，如何初始化管线，要override哪些方法-这些接口都是干啥的。

## SetSupportedRenderingFeatures

设置了一些编辑器特性，这些特性是相比Builtin管线而来的。 参见[URP支持特性对照表](https://docs.unity3d.com/Packages/com.unity.render-pipelines.universal@7.4/manual/universalrp-builtin-feature-comparison.html "URP支持特性对照表")： 反射探针：不支持旋转？(我不确定有要旋转反射探针的必要性 混合光源默认模式：Subtractive 可选的混合光源模式：IndirectOnly 或 Subtractive 注：Subtractive模式下，静态物体不接受直接混合光源的属性变化 关联关键词：\_MIXED\_LIGHTING\_SUBTRACTIVE LIGHTMAP\_ON 可选的光源的烘焙类型：Baked 或 Mixed 可选的烘焙模式：CombinedDirectional(保存直接光) 或 NonDirectional(只保存间接光) 注：不影响阴影计算，参考shader代码： inputData.bakedGI = SAMPLE\_GI(input.lightmapUV, input.vertexSH, inputData.normalWS); #ifdef LIGHTMAP\_ON //如果物体开启了烘焙则采样Lightmap获得GI #define SAMPLE\_GI(lmName, shName, normalWSName) SampleLightmap(lmName, normalWSName) #else //如果没有开启烘焙 则采样环境光和探针(使实时渲染物体获得GI补偿) #define SAMPLE\_GI(lmName, shName, normalWSName) SampleSHPixel(shName, normalWSName) #endif //和SampleSHVertex相对 将L0+L1和L2分布在vert和frag阶段执行 关联关键词：DIRLIGHTMAP\_COMBINED LIGHTMAP\_ON 关联shader方法：SampleDirectionalLightmap、SampleSingleLightmap lightProbeProxyVolumes：不支持(不清楚这个选项和BlendProbes之间的差别 注：参考Renderer组件的Light Probes属性 motionVectors：相机的深度贴图模式是否支持motionVectors-否 参考资料： https://docs.unity3d.com/ScriptReference/DepthTextureMode.MotionVectors.html https://zhuanlan.zhihu.com/p/64993622 定义：当开启本选项，相机会额外执行一个pass，将指定物体的屏幕空间的运动向量保存到\_CameraMotionVectorsTexture(RGHalf格式、需要硬件支持)，再由后处理阶段采样。 运动模糊的关键是把握某个像素前一帧与后一帧之间的相对位置关系，生成位移向量； 所以需要有一个参照物，假设相机静止或者物体静止； 如果相机静止，可使用UV建立映射关系，当前像素的UV位置，算出上一帧像素的位置； 如果物体静止，使用世界坐标建立映射关系(当前像素乘以VP的逆)，再算出上一帧像素的位置。 参考代码： Camera.main.depthTextureMode = DepthTextureMode.MotionVectors; receiveShadows：renderer组件选项-receiving shadows：不可用 如果可以设置物体为不接受投影，但是可以对其他物体造成阴影，那么渲染结果会失去逻辑。 也许会有透明物体不接受投影的说法，使光照强度不受阴影衰减影响。 reflectionProbes：支持反射探针：是 SceneViewDrawMode.SetupDrawMode()：设置Scene视图中的可选观察模式。 这部分属于编辑器扩展，我们可以自定义一个UV模式之类的。

# QualitySettings.antiAliasing

设置MSAA等级，需要硬件支持，设置后硬件做MSAA的前期准备； 具体使用到MSAA backbuffer，与RenderTexture开启msaa为准；

# Shader.globalRenderPipeline：全局设置-shader管线标签

对应shader中Pipeline tag，如果shader中注明了tag，且与全局设置不同，则该Subshader无效，判断下一个Subshader。

# Lightmapping.SetDelegate(lightsDelegate)

运行时GI生成委托，将光源信息描述为LightDataGI-URP不支持实时GI； URP中不支持运行时GI，光照探针中的GI信息不会变化。 没有任何注释，不确定Lightmapping的业务逻辑，似乎Unity不希望我们学会。

# CameraCaptureBridge.enabled：开启录制功能

使用反射捕获到UnityEditor.Recorder程序集，在后处理执行后执行录制Pass。 如果没有安装Recorder插件，则获取程序集失败，关闭录制。

# RenderingUtils.ClearSystemInfoCache()：

m\_RenderTextureFormatSupport：缓存硬件对RT的支持情况 m\_GraphicsFormatSupport：缓存硬件对RT操作(FormatUsage)的支持情况

# Dispose(disposing)：释放管线实例

运行时切线管线后，旧的管线实例需要被释放。 包括特性支持设置、Scene观察模式设置、GPU辅助计算声明的ComputeBuffer、烘焙GI委托、自定义Pass开关取消(避免新的管线实例继续执行自定义Pass，比如录制Pass)； 逐变量检查是否有垃圾残留。 Shader的属性ID(Shader.PropertyToID)不需要特殊操作，对应int值由系统在启动时随机编号生成，保持全局唯一，与变量名一一对应。

# Render(上下文, 相机列表)：逐帧渲染逻辑

Render方法和上下文(ScriptableRenderContext-结构类型)都是Unity准备好的接口，没有源代码的情况下是有很多黑盒子的，在C#层我们只能看到主要的渲染逻辑。 上下文是结构类型的，不用担心产生垃圾。 在阅读渲染逻辑代码的过程中需要注意，获取渲染相关数据的来源，比如光照、要渲染的GameObject列表，每个小步骤分辨完成什么任务。

## BeginFrameRendering和EndFrameRendering

渲染逻辑的开始和结束时执行，黑盒子。

## GraphicsSettings.lightsUseLinearIntensity

颜色空间设置，Linear表示颜色计算在线性空间中进行。 Linear模式下： ⇒　采样(SampleTextrue2D) 8位图片(开启sRGB标签)中的0.5，转换到linear空间后为0.2　⇒　shader在线性空间计算 png图片有A通道，不参与转换，(0.5, 0.5, 0.5, 0.5)　⇒　(0.2, 0.2, 0.2, 0.5) 32位图片(HDR、关闭sRGB标签)-采样时获取原值　⇒　shader在线性空间计算 开始shader计算：使用0.2进行光照模型计算... ⇒　将shader计算结果保存到RenderTarget(是一个用户声明的RenderTexture，简称RT) ⇒ 1.(默认)如果临时RT支持HDR，直接保存线性值 2.RT不支持HDR，标记为sRGB，执行color.gamma操作(取值时再还原) ⇒　完成最终计算，结果输出到frame buffer(显示器、也是个RT) encoding gamma矫正：执行color.gamma操作 ⇒　显示器display gamma矫正：执行color.linear操作 用户最终看到的是线性空间的值 Gamma模式下(很多年前这样用、节约性能) ⇒　采样(不考虑HDR图片) 8位图片中的0.5，直接使用　⇒　shader在Gamma空间计算 ⇒　保存计算结果到RenderTarget：直接保存 ⇒　输出到frame buffer：直接保存 ⇒　显示器display gamma矫正：执行color.linear操作 用户最终看到的是线性空间的值

# GraphicsSettings.useScriptableRenderPipelineBatching

SRP batcher功能，同shader的材质，且没有使用MaterialPropertyBlock，可以合批。 根据URP特性表，URP中支持4种合批处理（静态是指物体被标记为 Batching static的物体）： Static Batching (By Shader) Static Batching (By Material) Dynamic Batching GPU Instancing Unity会自动使用符合条件的合批方式减少draw call，参考[UGP第三章 GPU instancing](https://acgmart.com/render/ugp1-3/ "UGP第三章 GPU instancing")。

# SetupPerFrameShaderConstants

逐帧全局变量，\_GlossyEnvironmentColor和\_SubtractiveShadowColor。

# SortCameras

相机渲染任务排序，根据相机深度值从小到大顺序排列，小的先绘制被大的遮盖。 多相机渲染需要解决内容叠加的问题，后面的相机不能完全情空前面相机绘制的内容。

# IsGameCamera

判断相机类型，Game窗口和Scene窗口提供的相机类型不同，用于区分游戏模式与编辑模式。 下面将跳过编辑模式分支。

# UniversalAdditionalCameraData组件

在URP中，相机必定带有UniversalAdditionalCameraData组件，用于扩展相机组件的功能。 如果用户不打算通过脚本控制和自定义URP，则不需要动这个组件；反之，我们使用代码： var cameraData = camera.GetUniversalAdditionalCameraData(); 注：获取已有的data组件，没有时新建一个。 注：data组件的属性通过GUI脚本，都暴露在Camera上了。 整体上来说，这个组件保存了逐相机的渲染配置，也是用户实时设置管线的入口。

## CameraOverrideOption 可重写管线设置类型参数

每个相机都可以重写部分管线设置，参考Camera面板中的选项。 可以选择继承管线设置(UsePipelineSettings)，或者重写(Off/On)。

## AntialiasingMode：可选的后处理抗锯齿方法

可选FXAA或SMAA后处理抗锯齿，不与硬件抗锯齿(MSAA)冲突； SMAA选项还有复选项可以设置质量，Low/Medium/High。 按照我的经验，开一个SMAA-High即可，不需要其他抗锯齿；根据画面进行调整。

## CameraRenderType：相机渲染类型

关联属性：m\_CameraType renderType Base：可绘制到屏幕或RT Overlay：渲染到前一个相机的输出，混合结果。

## CameraTypeUtility.GetName

这个方法是用来帮GUI做一个相机渲染类型的下拉选项，enum转string数组。

## UniversalAdditionalCameraData的字段

挺多SerializeField，都是私有的，我们要么在编辑模式下设置GUI，要么运行时通过set/get方法访问参数。 下面逐一看每个属性的用处，需要注意的是这里的设置是针对整个相机渲染任务的。

## m\_RenderShadows

关联属性：renderShadows 使相机可以关闭shadowmap pass，比如UI相机就完全不需要对谁造成阴影。 关闭后，逐帧的CameraData结构的maxShadowDistance值为0，已经不可能绘制阴影体积了。

## m\_RequiresDepthTextureOption

关联属性：requiresDepthOption shader变量：\_CameraDepthTexture 是否生成深度贴图，用一个RT保存，可以采样深度； 是否生成贴图的区别是直接绘制到frame buffer还是绘制到某个RT，等计算完毕后再绘制到frame buffer，当我们没有使用到后处理时，URP使用这种方式，少声明一个RT。 考虑到游戏开发的专业性，生成专用RT还是很有必要的； [深度数据对很多效果都有用](https://www.jianshu.com/p/178f3a065187 "深度数据对很多效果都有用")，多使用RT才是学习URP的价值体现。

## m\_RequiresOpaqueTextureOption

关联属性：requiresColorOption shader变量：\_CameraOpaqueTexture 不同于我们的常规颜色渲染目标是\_CameraColorTexture，这里保存的是不透明物体队列渲染完后的颜色RT备份，我不确定有什么效果是必须要用到不透明物体Pass阶段的颜色RT的，可能声明这个RT的必要性不高。

## m\_Cameras

关联属性：cameraStack 相机栈是2019.4左右出的新功能的样子，以前只能使用单个相机，深受诟病。 比如当游戏很复杂的时候，小地图、多人联机，还是需要多相机的小窗功能的。 但是与Built in中添加多个相机，设置层级控制渲染顺序不同，URP使用Overlay机制； 只有Base类型的相机才能最先渲染，后面的相机的渲染都是覆盖在Base上； 相机栈的逻辑在RenderCameraStack方法，使Overlay相机不等价于Base相机。

## m\_RendererIndex

关联方法：SetRender(index) 在设置Pipeline Asset时，本文前面讲到最多可以添加8个RendererData，但是我找遍了PipelineAsset、Pipeline、Renderer、RendererData类型，都没有发现如何切换RendererData，当时我就在想，怎么才能运行时更换Pass列表呢； 原来，接口在这里，我们可以访问逐相机数据，运行时更换RendererData。 这样就避免了直接设置一个新的PipelineAsset-生成新的Pipeline实例，可以一个实例用完整个游戏生命周期。 比如，A场景使用A队列，B场景使用B队列，手动添加任意自定义Pass排列组合，运行时调整。

## m\_VolumeLayerMask：后处理效果的生效机制

关联属性：volumeLayerMask SRP使用内置的后处理代码后，将后处理文件改名为VolumeProfile(GUI改过好多版); 添加后处理效果的步骤是：添加Volume组件、设置Layer、指定Profile； 新脚本传达了一个体积的概念，可以效果混合，但是我想象不出来应用场景； 我通常只用一个全局Volume，混合的细节效果还需要测试。 相机的m\_VolumeLayerMask值，需要包含Volume的Layer，才能使Volume生效。

## m\_VolumeTrigger：用于Volume混合的触发器

等待Volume混合相关的效果案例。

## m\_RenderPostProcessing：开启后处理

这个开关，默认关闭的，一般都要开启。

## m\_Antialiasing：后处理抗锯齿模式

关联属性：m\_AntialiasingQuality

## m\_StopNaN：后处理执行前解决RT数值异常

使用StipNaNs材质做后处理，解决NaN异常；没见过这种异常。

## Dithering：弥补颜色范围过少、抖动色域增加颜色丰富性

在后处理之后执行，可选，一般(高清向)没必要使用。

## clearDepth：执行Overlay相机渲染任务前 清除深度信息

对于UI相机，继续使用Base的深度是没有意义的，必须清除深度，覆盖Base。

# RenderCameraStack(上下文, baseCamera)

限于篇幅 下一篇文章再写。