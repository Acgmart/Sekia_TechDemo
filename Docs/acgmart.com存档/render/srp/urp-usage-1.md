---
title: URP数据与接口 - 相机栈
categories:
- [渲染, SRP]
date: 2020-06-30 09:32:10
---

\[toc\]本篇继续讲URP中的数据与接口。 本篇从相机栈渲染讲起，也就是RenderCameraStack方法，遇到什么再说什么。

# 编辑相机栈

选择一个Base相机，在Stack栏中用+号按钮添加Overlay相机，组成相机栈； 没有Overlay相机，就新建一个Camera，设置RenderType为Overlay。

# 渲染管线中出现的几种常见类型

PipelineAsset：就是我们创建的管线配置文件，全局独一份； Pipeline：被Asset的CreatePipeline方法实例化，也是全局独一份； RendererData：Asset的m\_RendererDataList参数，指定一个渲染方案列表，长度至少为1； 注：Data列表中有一个被标记为默认值；Camera从列表中选择一个Data执行渲染任务； Renderer：与Data一一对应，包含渲染逻辑，比如Renderer2D、ForwardRenderer。 Feature：Data的m\_RendererFeatures参数，是一个Feature列表，这些Feature可以插入Renderer逻辑中的某一个环节，比如透明队列后-后处理前，是用户自定义管线的重要手段。

# RenderCameraStack(上下文、baseCamera)

只有Base相机能作为相机栈渲染任务的开始，没有被分配的Overlay相机不生效。 一个栈的任务包括Base任务和多个Overlay任务。 每个任务都是一样的形式： BeginCameraRendering(context, camera); VFX.VFXManager.PrepareCamera(camera); UpdateVolumeFramework(camera, data); InitializeCameraData(camera, data, !isOverlay, out var cameraData); //对于Overlay相机：InitializeAdditionalCameraData RenderSingleCamera(context, cameraData, anyPostProcessingEnabled); EndCameraRendering(context, camera); Begin和End方法，Unity约定的单个相机的渲染开始前和结束后执行，； VFX，也就是VEG的底层，预处理GPU特效，可能需要引用相机(黑盒子)； 前文提到了关于Volume的混合机制，相机要先提交自己的身份； cameraData表示相机渲染一帧需要的全部数据，struct类型； 我们可以从InitializeCameraData方法中了解具体收集了那些数据； 根据这些数据的收集和使用，我们可以知道，编辑器中的调整如何影响渲染结果； RenderSingleCamera表示一个独立的相机渲染任务，剔除、规划Pass队列、执行等； 对于Scene视图来说，使用独立的Scene视图预览用相机，区别于相机栈的工作模式。 注：Scene相机默认没有UniversalAdditionalCameraData组件； 视图在显示内容上和Game视图也有差别： 可以显示参考线、轨迹、碰撞盒子、UPBR的某个层、UV(替换shader)； Scene视图的开发对策划、美术也很重要，能显著提高开发效率； 开发者在对实时渲染流程熟悉之后，可以尝试开发编辑器工具，辅助团队。

# UpdateVolumeFramework

VolumeManager.instance.Update(trigger, layerMask); 默认trigger是相机的transform，默认layer是1。 Scene视图相机虽然没有data组件，默认使用main相机的data；

# VolumeManager类型

介绍：管理场景中的全部Volume，处理插值工作，单例。 我注意到这里的Instance实例，有点特殊： `new Lazy<VolumeManager>(() => new VolumeManager());` 这样创建的实例是[延迟初始化](https://docs.microsoft.com/zh-cn/dotnet/framework/performance/lazy-initialization "延迟初始化")的，首次访问迟缓变量的Value属性前不会实例化； URP演示的这个例子并不好，首次访问变量就直接触发了初始化； 延迟初始化的功能，我们可以利用在大量读取表格上，避免一张表上几百条配置读很久，但是又不一定用得上； 比如记录下每条配置在字节流中的地址，触发初始化时再实例化配置。

## VolumeManager自构

创建容器，用于存储Volume信息，包括Volume的优先级、碰撞器、Profile。 参考Core库/Runtime/Volume/目录下的其他几个类型： Volume.cs：挂载在场景中的组件，触发器，携带sharedProfile； VolumeComponent.cs： VolumeParameter.cs： VolumeProfile.cs：后处理效果配置； VolumeStack.cs： Volume类型需要实时通知(Start/Update方法)VolumeManager优先级、layer变化，创建/释放； 类似于Renderer的mesh/sharedMesh属性，Volume根据访问方式判断是否缓存Profile； 一个VolumeProfile可以定义多种效果，这些效果都是VolumeComponent，效果不能重复； 每个效果又有很多属性，这些属性都是VolumeParameter，我们可以重写部分属性；

## VolumeManager.instance

初始化VolumeManager时，收集所有效果类型实例； 存储类型到baseComponentTypes，存储实例到m\_ComponentsDefaultState(备份、模板)； 我们可以根据Unity的继承规则(继承VolumeComponent)，创建新的后处理效果。 VolumeStack：定义了一个效果列表，以type为key； VolumeManager.stack：包含全部继承了VolumeComponent的type ⇒ 全局效果列表 VolumeManager.**Update**方法：单个相机的注册事件，重新计算混合效果 ReplaceData(stack, tigger, layerMask)：重置全局效果列表 OverrideData(stack, volume.profileRef.components, Mathf.Clamp01(volume.weight)); 使用有效的Volume重写全局效果列表； 对于Local Volume来说，插值为权重 \* (1-触发器离碰撞器的距离的平方/混合距离的平方)； 这里我们可以发现，Volume的生效机制是针对全局特效列表的，对应着Camera； 对于单个相机来说，Volume的混合不使碰撞器内的物体被区别对待； 比如，有一个碰撞器内在刮风下雨 + 移动，进入/离开相机触发范围内时，实时计算混合插值。

## 后处理动画

到这里，VolumeManager就说完了；我还需要考虑下运行时修改后处理效果参数； 比如我的人物死了，我希望全屏慢慢变灰，或者被攻击的时候屏幕周围冒血光； 玩家在复活点复活，或者离开战斗状态时，就得取消这些状态，得符合GamePlay逻辑； 可以播放插值动画，比如用Timeline来做，可以录制，便于调试(手动找变量很麻烦)。

# InitializeCameraData

相机栈的Base相机相比Overlay相机多一步程序： cameraData = new CameraData(); //使用字段默认值初始化 字段值为0或null InitializeStackedCameraData(camera, data, ref cameraData) InitializeAdditionalCameraData(...) 而且后面的Overlay相机全都拷贝一次cameraData，作为初始数据。

# CameraData结构

## 私有成员 get访问

m\_ViewMatrix：V矩阵 关联方法：GetViewMatrix m\_ProjectionMatrix：P矩阵 关联方法：GetProjectionMatrix

## GetGPUProjectionMatrix方法：获取P矩阵的GPU版本

根据不同设备(OpenGL/DX)，反转y(-y)和z(0.5-z/2)； DX平台，UV起点在左上角，绘制到RT时，需要反转； OpenGL平台，UV起点在左下角，绘制到RT时，不需要反转； Y轴的反转使图像上下颠倒，这关系到采样： Unity自动帮我们处理了DX平台的UV反转，使我们采样贴图时不会出错； 这里renderIntoTexture参数判断渲染目标是否为自定义RT正是用于上下翻转图像； 当renderIntoTexture为false时，不会反转Y。 如果RT是用于Compute Shader中按像素序列访问，不需要反转，从左下角开始。 DX的Z范围是（1,0） GL是（-1,1） 是否反转Z与平台有关，与是否绘制到RT无关； 当前平台为GL时，z=mul(P, posWS).z，即裁剪空间中的Z值； 而在shader中，深度测试使用GL规则，默认LessEqual(深度更小才能通过测试); 当前平台为DX时，z = 0.5 - z/2； 比如在Win10，Frame Debugger中观察深度图，越靠近相机的地方越亮(接近1)； IsCameraProjectionMatrixFlipped方法：判断绘制目标是否是RT SystemInfo.graphicsUVStartsAtTop：判断渲染平台 renderer.cameraColorTarget != BuiltinRenderTextureType.CameraTarget： 判断渲染目标；注意，等式两边类型不同，底层实现了特殊的对比逻辑(黑盒子)：

## SortingCriteria defaultOpaqueSortFlags：默认渲染顺序

我们在场景中拼命的添加GameObject，但是不一定关心他们的渲染顺序，不管也行； 这个渲染顺序可以综合多种因素，可供用户调整渲染先后顺序： None：不排序，将任务队列直接丢给GPU； SortingLayer：一个相机可能兼顾多个Layer； RenderQueue：材质参数，2000是不透明物体、3000是透明物体这样； BackToFront：GameObject位置，从后往前排序； QuantizedFrontToBack：GameObject位置，粗粒度，从前往后排序； OptimizeStateChanges：尽可能合批，减少渲染状态变化次数； CommonTransparent： CanvasOrder： CommonOpaque： RendererPriority：

## 相机总览设置

targetTexture：渲染目标，用户可以将渲染结果保存到指定RT； cameraType：相机的工作场景：Game/Scene/Preview/VR/Reflection isSceneViewCamera： defaultOpaqueSortFlags：排序方式，如果GPU支持排序则可以优化一下；

## 后处理设置：主要是在相机面板设置

volumeLayerMask volumeTrigger isStopNaNEnabled isDitheringEnabled antialiasing antialiasingQuality

## 输出设置

isHdrEnabled pixelRect：Camera.rect(百分比版)的像素版矩形，(x起点, y起点, x宽度, y宽度)； pixelWidth：x宽度，左上角的x值为0，右下角的x值为1； pixelHeight：y宽度，左上角的x值为0，右下角的y值为1； aspectRatio：x宽度/y宽度 isDefaultViewport：rect要包含整个屏则为true； renderScale：只在Game视图缩放

## VR模式相关参数

isStereoEnabled：双眼渲染 numberOfXRPasses：对于常规渲染，相当于单眼，Pass数量为1； isXRMultipass：

## 编辑器模式相关参数

isSceneViewCamera：Scene视图相机； captureActions：返一个委托，作为录制行为的逻辑入口；

## cameraTargetDescriptor：创建渲染目标的RT描述

使用CreateRenderTextureDescriptor方法创建RT描述； Unity中，RT的底层是黑盒子，所以我们其实不方便直接获得RT的指针、修改RT； 黑盒子的问题，有利也有弊，给用户全部操作权限，反倒是增加了不稳定性； 所以，只能通过有限的接口创建RT、对比、设置，RT描述(值类型)就是其中一种； 通过RT描述(RenderTextureDescriptor)，我们可以准确的初始化一个RT； 目标相机设置了渲染目标为自定义的RT，则描述由用户在RT资产面板设置； 如果相机没有设置渲染目标，则渲染到颜色RT和深度RT； **width**和**height**：取相机的屏幕范围，受到renderScale的影响； **graphicsFormat**：选择RT的图形格式，我们自然希望使用HDR格式，精度更高； 如果不需要A颜色通道：B10G11R11\_UFloatPack32，32位都分配给RGB三个通道； 如果需要A通道：R16G16B16A16\_SFloat，64位分配给RGBA四个通道； 不支持指定格式时：DefaultFormat.HDR，根据平台返回HDR或者LDR格式； LDR模式：DefaultFormat.LDR，根据平台返回LDR格式； depthBufferBits：深度缓冲的位数； sRGB：比如，我们在PS中创建的图片，需要标记为sRGB； enableRandomWrite：随机读写，默认关闭，用于SM4.5以上的GPU计算； bindMS：不自动处理MSAA缓冲，默认关闭； useDynamicScale：动态分辨率，一种性能优化，当GPU负载很高时智能降低分辨率； 注：我们平常采样贴图都是SampleTexture2D，但是MASS缓冲不是Texture2D格式； 所以，开启MSAA后，要对MSAA缓冲进行转换，或者采样multisampled texture； 我没有见过直接采样multisampled texture的代码，一般都是先转换再采样； 注：图形格式(GraphicsFormat)区别于RT格式(RenderTextureFormat)，区别待定； 图形格式：只能指定浮点精度和通道 RT格式：可以指定通道和大致精度(half/float)、还包括用途(Depth/hadowmap) 注：现代GPU支持分离颜色缓冲和深度缓冲目标，两者不一定在一个RT； 那么也就不确定，指定了深度缓冲位数之后，是否同时生成颜色缓冲和深度缓冲； 有可能，一个RT包括颜色+深度两个buffer； 也可能是指定RT的RT格式为Depth后，生成指定位数的深度buffer，不包含颜色buffer； 在实际读写的过程中，渲染目标的读和写目标必须相同： 比如，使用A(深度buffer)进行深度测试，测试通过的写入必须保存到A；颜色读写同理；

# InitializeAdditionalCameraData：栈内相机的重写数据操作

包括Base相机，也会执行这部分逻辑； camera：保存相机引用 maxShadowDistance：结合管线阴影开启状态、管线阴影距离设置、相机远截面距离判断； 相机面板中，关闭renderShadows选项，可以使阴影距离为0； renderType：相机在栈中的类型，Base/Overlay； clearDepth：只有Overlay相机能可选设置是否清理深度buffer； postProcessEnabled：一般都开启后处理；Scene视图下不开启后处理； requiresDepthTexture：一般都会创建深度RT；Overlay清理后继续使用； requiresOpaqueTexture：可选复制颜色RT；Overlay不使用； renderer：使用相机指定的Renderer，或者管线默认Renderer； resolveFinalTarget：相机栈中最后一个相机提交渲染结果；非栈模式时直接提交； Overlay相机如果是正交的，直接使用自己的P矩阵； Overlay相机如果是透视的，则与Base相机共用FOV，避免出现显示BUG； 相机数据收集任务到这里就结束了，多数属性都是我们能在编辑面板上直接看到的； 剩下的则是与相机栈的工作模式密切关联的，为混合多个角度的视觉效果做准备；

## 总结Base和Overlay相机的差别

1.Overlay相机没有渲染到RT的选项，他的渲染目标被Base捆绑了； 相关的输出设置上，Overlay相机都没有自主权(毕竟是用的人家的地)； 2.没有限制Overlay相机的投影(占显示器的)范围，用户自己手动调； 3.在渲染逻辑任务上，Overlay与Base相机有相同的可自定义权限；

# RenderSingleCamera

这个方法处理Scene/Base/Overlay等相机的渲染任务； ProfilingSampler sampler：指定性能分析采样器，建议根据相机名采样，便于调试； 整体任务流程是： ⇒ camera.TryGetCullingParameters：获得默认剔除属性cullingParameters(黑盒子)； ⇒ ScriptableRenderer.current = renderer;：切换当前渲染方案，供逻辑引用； ⇒ 开始性能采样：cmd.BeginSample(m\_Name)，添加开始采样命令到CommandBuffer； ⇒ renderer.Clear：根据渲染方案(Forward/2D)重置数据为准备渲染状态； ⇒ renderer.SetupCullingParameters：根据渲染方案(Forward/2D)修改剔除属性； ⇒ context.ExecuteCommandBuffer：第一次提交已有命令(开始采样)给上下文； ⇒ cmd.Clear：清空CommandBuffer； ⇒ EmitWorldGeometryForSceneView：编辑模式下，Scene视图物体额外描边； ⇒ context.Cull：底层执行粗粒度剔除(黑盒子)； ⇒ InitializeRenderingData：获取全部渲染一帧所需的数据； ⇒ renderer.Setup：根据渲染方案(Forward/2D)配置Pass队列； ⇒ renderer.Execute：执行Pass队列； ⇒ context.ExecuteCommandBuffer：第二次提交已有命令(结束采样)给上下文； ⇒ CommandBufferPool.Release：回收CommandBuffer； ⇒ context.Submit()：提交渲染任务给GPU； ⇒ ScriptableRenderer.current = null;：取消当前渲染方案引用；

# Renderer的重写与使用

Unity给我们提供了接口，重写ScriptableRenderer类型，来自定义渲染方案； URP中已经定义好了ForwardRenderer和Renderer2D，分别对应前向渲染和2D渲染； 这两种方案已经可以面对大多数的情况，比如： 场景中有主相机作为Base，使用前向渲染，渲染主要场景； UI相机作为Overlay，使用2D渲染，渲染UI(包括小地图等交互原件)； 所以，通常来说，2个相机、2种Renderer可以满足简单的移动游戏需求。 渲染过程的多样性可以通过自定义Pass来完成，切换使用多个Renderer实例。

# ScriptableRenderer的初始化

在Asset的CreatePipeline方法中，创建管线实例前执行了CreateRenderers方法； 如果用户配置了渲染方案列表，那么m\_RendererDataList不为空； 使用ScriptableRendererData的InternalCreateRenderer方法实例化渲染方案； ScriptableRendererData的子类中保存了渲染方案所需的数据，用于方案的实例化： public ForwardRenderer(ForwardRendererData data) : base(data) public Renderer2D(Renderer2DData data) : base(data) 从自构方法中可以看出，有部分数据是属于父级-ScriptableRenderer类型的： public ScriptableRenderer(ScriptableRendererData data) 数据中包含自定义Pass(ScriptableRendererFeature)列表：rendererFeatures 自定义Pass，是URP提供的主要的自定义管线方式，可以定义一个渲染阶段逻辑； 在初始化Renderer时，初始化Feature(对应着一个Pass)，并添加到自身的容器。 相关类型： ScriptableRendererData ScriptableRendererFeature ScriptableRenderPass

# ScriptableRendererFeature.Create：自定义Pass初始化接口

这个接口用于定义Feature实例的初始化行为(类似于Awake/Start)； 如果在这里声明了变量，基本上是全局缓存的； 比如创建Pass实例，准备Pass需要的必要变量；

# ScriptableRendererFeature.AddRenderPasses：自定义Pass执行前接口

这个借口用于定义Feature实例，在执行前的调整(类似于Upadte)； 接口中提供了Renderer和RenderingDta，用于判断在本帧中如何预设值Pass； 所以我们需要充分了解这2个类型中的数据结构，便于灵活使用； 执行renderer.EnqueuePass方法，添加到待执行队列；

# ScriptableRenderPass的自构

对于一个Pass，需要指定在队列中插入的时机，等待前面的Pass执行完； 同时，Pass对颜色和深度等自定义RT的写入也会影响到后面的Pass； URP使用RenderPassEvent类型排序，比如： 不透明队列声明在RenderPassEvent.BeforeRenderingOpaques； 我们要定义一个事件，紧跟着不透明队列，可以声明Pass在： RenderPassEvent.AfterRenderingOpaques Pass并不是可序列化的类型，所以数据由关联的Featrue实例提供； 在自构时，引用必要的数据，主要是渲染命令需要的RT引用和材质；

# ScriptableRenderPass的属性和方法

⇒ 自构方法 renderPassEvent：Pass队列的优先级，自定义Pass插队到指定位置； colorAttachments：颜色写目标，用于多RenderTarget(MRT)渲染； colorAttachment：颜色写目标，用于单RenderTarget渲染； depthAttachment：深度读写目标； clearFlag：设置RT时，对RT的清理行为； clearColor：设置RT时，对RT的颜色缓冲清理时指定的颜色值； eyeIndex：眼睛序列，用于在VR中区分左右眼，默认为0； overrideCameraTarget：标记Pass是否有特殊的写目标； ConfigureTarget：提供给Pass外部，用于修改写目标的接口； ConfigureClear：提供给Pass外部，用于修改设置目标的清理行为； ⇒ Configure：每帧在执行Pass前会调用的接口，可初始化写目标RT； ⇒ FrameCleanup：全部Pass执行完成后，统一调用的清理接口； OnFinishCameraStackRendering：相机栈渲染执行完成后的清理接口； ⇒ Execute：Pass的主要逻辑，提交CommandBuffer命令； Blit：一个工具方法，用于复制贴图，同时改变了写入目标； CreateDrawingSettings：创建批量渲染任务设置；

# RenderTargetIdentifier：RT标识符

标识一个RT，可与int(shader变量ID)进行对比； identifier == 0; //判断RT是否为null identifier == someInt; //判断两边是否代指同一个RT RenderTargetIdentifier由Unity底层提供，支持多种自构方式： 1.RenderTexture实例 2.BuiltinRenderTextureType 3.shader id(GetTemporayRT)

# RenderTargetHandle：URP中定义的 也是一种RT标识符

RenderTargetHandle.CameraTarget：-1，代表FrameBuffer 非-1值对应shader变量ID，用前先声明： handle.Init("TemporaryColorTexture") 进行读写前，要先请求临时RT： cmd.GetTemporaryRT(handle.id, rtDesc, FilterMode.Point); 用完了，记得释放临时RT： cmd.ReleaseTemporaryRT(handle.id);

# BuiltinRenderTextureType：Unity中标记的特殊RT

比如：BuiltinRenderTextureType.CameraTarget 相机目标为null时，代表FrameBuffer； 相机目标为指定RT时，代表指定RT。

# 关于自定义Feature

URP提供了一个模板，我们可以在资源目录里面右键创建； 在CustomRenderPassFeature.cs中观察Feature的各种接口和说明； 怎么开始写自定义Feature是一个比较头疼的问题，但是不要心急； 在URP中，所有的渲染业务，都可以用Feature表示，先看看主干代码。