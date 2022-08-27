管线材质：渲染管线运行或多或少都依赖于特定的shader和material
    我们可以称之为EngineShader和EngineMaterial 将他们与常规物体渲染区分下

对Unity中各种相机的描述
相机名称        Camera类型          是否有AdditionalCameraData    用途          CameraTarget是否存在
Game              Game                     是               绘制运行时场景             自定义
反射探针        Reflection                  否              绘制反射探针Cube             是
场景预览        SceneView                   是           绘制编辑模式场景/debug视图       是
Game预览          Game                      否               预览运行时场景              是
资源预览         Preview                    否                预览单个物体               是
不同种类相机的策略：
    1.非Game类型的相机如果没有AdditionalCameraData就假设其拥有默认的AdditionalCameraData
    2.非Game类型因为CameraTarget不为空 RT描述是基于目标RT设置的
    3.默认Renderer会承担渲染多种相机的职责 单个FeaturePass列表是不够的
    4.多相机之间会存在OverDraw问题 并不能简单的将被OverDraw的像素视为无效计算
        比如河水折射、SSR、SSAO等。
    5.Editor窗口不用太考虑性能

中间RT介绍：
Depending on the device and project settings,
Unity will render the game directly to backbuffer or
to an intermediate texture then blit to backbuffer.
This blit comes with a cost, mostly because of bandwidth. 
In some cases, when in linear colorspace we cannot render straight to backbuffer. 
It Depends on the device supporting sRGB framebuffers. 

中间RT模式判断：
    中间Color RT的作用：
        1.后处理中作为采样源Blit
        2.控制视口范围实现Stack叠加渲染
        3.延迟渲染 MRT
        4.需要拷贝一次颜色RT 用于制作扭曲特效等
        5.有分辨率缩放 需要Blit到正常分辨率的backBuffer
        6.要录屏 将中间RT保存为静态数据
    对于Game类型的相机来说 是否使用中间RT这个问题是很直观的：
        优化考虑：比如UI角色相机只渲染简单的背景和单个角色 完全不需要中间RT
        效果考虑：比如场景需要支持相机栈和后处理 肯定需要中间RT
    对于反射探针 需要降低开销倾向于不使用中间RT
    对于非运行时类型的相机 只要用了中间RT不会导致出错都可以使用

    中间Depth RT的作用：
        1.软粒子效果需要深度值判断粒子的透明度
        2.水效果需要深度值判断水深和可见度
        3.景深需要基于深度值的模糊
    和Color RT的情况类似 出于优化考虑可酌情不使用中间RT

requiresDepthPrepass：是否执行DepthOnly pass遍历一次深度
    预计算深度与_CameraDepthTexture的处理有关
        1.如果直接渲染DepthOnly pass到_CameraDepthTexture 则_CameraDepthTexture的format为Depth
        2.如果直接渲染DepthOnly pass到_CameraDepthAttachment 则需要Copy深度到_CameraDepthTexture
        3.DepthOnly pass仅在PC上性能优化意义
        4.不支持Copy深度且刚需深度图时强行计算：GLES3设备或者硬件不支持采样Depth format的RT
        5.如果硬件不支持Copy深度 建议考虑关闭依赖_CameraDepthTexture的后处理和特效
    在延迟渲染下完全不考虑执行DepthOnly pass
    在前向渲染下渲染完Opaque再Copy深度 也不考虑执行DepthOnly pass
useDepthPriming：也是在描述DepthOnly pass的执行问题
    当useDepthPriming为真时DepthOnlyPass的RenderTarget为_CameraDepthAttachment
    当useDepthPriming为假时RenderTarget变成了_CameraDepthTexture 利用DepthOnly pass的R通道输出深度
    注意DepthOnly pass有ColorMask R和透明裁剪等操作 需要根据项目情况优化下

NativeRenderPass：
    API参考：https://docs.unity3d.com/ScriptReference/Rendering.ScriptableRenderContext.BeginRenderPass.html
    BeginRenderPass是一个新render pass的起点，同一时间只能运行一个render pass。
    当开启了NativeRenderPass后，在FrameDebug中可以观察到很多FeaturePass合并为了Renderpass 0|1|2...
    render pass提供了一种在可编程渲染管线中切换rendertarget的方式。
    相对于SetRenderTargets方法，render pass有明确的begine和end标志，以及对RT的显示的load/store操作。
    render pass还允许执行多个subpass，subspass中的片元shader可以访问当前像素值。
    render pass可以在tile-based GPU上高效地实现各种渲染模式，如延迟渲染。
    render pass在Metal和Vulkan上是原生实现的，其他平台则是通过模拟实现的。
    render pass有以下限制：
        1.所有渲染目标有相同的分辨率和MSAA等级
        2.仅能获取上一个subpass在相同屏幕像素坐标的结果 且渲染目标在render pass end前不能作为贴图访问
            shader语法：UNITY_READ_FRAMEBUFFER_INPUT(x)
        3.Metal不能读取Z buffer，需要一个额外的RenderTarget来处理？
        4.渲染目标最多允许8个颜色+深度，某些GPU或许有更严格的限制。
useRenderPassEnabled ：综合用户设置和设备兼容情况判断是否开启render pass
    明确GLES2不支持render pass
m_DeferredLights.UseRenderPass ：
requiresDepthCopyPass：是否从_CameraDepthAttachment Copy深度到 _CameraDepthTexture
    根据使用_CameraDepthTexture的时机和深度图绘制的方式执行时机有差异
    原则是尽量晚的时机执行Copy 减少FeaturePass的数量
    透明物体比如头发也会有部分深度写入 可以考虑把头发放在不透明队列最晚绘制
    用途：_CameraDepthTexture对于视差映射|扭曲|水下折射等效果是必要的 对于后处理来说不必要
    使用NativeRenderPass可以避免这个Pass 待测试
        比如软粒子效果 只采样当前像素的深度值 可以使用NativeRenderPass？
        比如水下折射 需要偏移采样别的像素 不能使用NativeRenderPass？
copyColorPass：是否从_CameraColorAttachment Copy颜色到 _CameraOpaqueTexture
    用途：_CameraOpaqueTexture对于扭曲|模糊类型的特效有用 限制是透明层级不能太复杂

RenderTargetBufferSystem m_ColorBufferSystem 主颜色RT：
    为Color RT定义了一个有2个RT交替的RT管理系统 用于后处理交换RT
    SetCameraSettings：根据desc初始化2个RT并设置全局属性

渲染目标：RenderTarget
    renderer.ConfigureCameraTarget -> 设置主目标

    renderer.Setup -> 配置内置的pass
            ↓
    renderPass.AddRenderPasses ->执行自定义pass的AddRenderPasses接口
            ↓
    renderer.Execute
            ↓
    renderPass.OnCameraSetup ->执行自定义pass的OnCameraSetup接口     
            ↓
    renderer.ExecuteBlock
    renderer.ExecuteRenderPass
            ↓
    renderPass.Configure -> 配置逐pass的渲染目标 renderPass.ConfigureTarget/ConfigureClear
            ↓
    renderer.SetRenderPassAttachments
            ↓
    renderer.SetRenderTarget
            ↓
    renderPass.Execute ->执行自定义pass的Execute接口
            ↓
    renderer.InternalFinishRendering
            ↓
    renderPass.OnCameraCleanup
    renderPass.OnFinishCameraStackRendering

如何SetRenderTarget：
    Unity有几个接口：
    1.renderer.SetRenderPassAttachments
    2.renderer.SetRenderTarget
        针对depth buffer和color buffer在同一个RT 以及 分离于两个RT的情况分别调用底层
        针对是否开启了NativeRenderPass分别处理
        针对MRT分别处理
    3.CoreUtils.SetRenderTarget
        CoreUtils内的包装的主要意图是处理mip|cubemapFace|depthSlice等 顺带ClearRenderTarget
        封装的非常繁琐 缺少解释
        mip|cubemapFace|depthSlice：除了最简单的2D纹理形式 mip|Cubemap|3D 等纹理形式也存在
        可以渲染到不同的mip 不同的face 不同的深度index
        RenderTargetIdentifier可用于精确的描述buffer的范围
        默认值：mipLevel = 0   cubeFace = CubemapFace.Unknown   depthSlice = 0

    4.CommandBuffer.SetRenderTarget
    在过去CommandBuffer的扩展太多又没有注释 api的意图全靠猜
    现在Unity2022 + VS2022可以看到一些底层逻辑 可以观察到所有非MRT的SetRenderTarget都指向：
    SetRenderTargetSingle_Internal_Injected
        SetRenderTarget(rt)：单RT双buffer Load+Store缺省设置
        SetRenderTarget(rt, load, store)：单RT双buffer Load+Store设置在depth复用
        ▲ SetRenderTarget(rt, load, store, load, store)：单RT双buffer Load+Store主动设置
        SetRenderTarget(rt, mipLevel)：单RT双buffer 指定mip
            用new RenderTargetIdentifier(rt, mipLevel)缩小RT的范围
        SetRenderTarget(rt, mipLevel, cubemapFace)：...
        SetRenderTarget(rt, mipLevel, cubemapFace, depthSlice)：...
    SetRenderTargetColorDepth_Internal_Injected
        SetRenderTarget(color, depth)：RT分离 Load+Store缺省设置
        SetRenderTarget(color, depth, mipLevel)：...
        ▲ SetRenderTarget(color, depth, load, store, load, store)：RT分离 Load+Store主动设置

    从优化角度看需要仔细设置load和store操作
        1.如果目标RT的原内容是可以舍弃的 那么load就可以设置为DontCare
        2.如果对目标RT的写入不需要保存 那么store就可以设置为DontCare
    
    当pass的目标RT设置与管线的目标设置不一致的时候重置渲染目标
    CommandBuffer.SetRenderTarget在整个渲染流程里没有明确的开始和结束概念
    用户在执行这个命令后 管线并不知道渲染目标已经发生了变化 所以需要额外的封装
    renderer.SetRenderTarget则是在设置渲染目标之前保存一下RT的索引
    有了索引之后就可以通过封装判断新的渲染目标是不是和上一次不一样 避免无效设置
    总结下来就是 所有设置渲染目标的操作都必须通过renderer.SetRenderTarget完成

    URP对renderPass又有一层渲染目标的封装：
    renderPass自带colorAttachmentHandles|depthAttachmentHandle等属性
    renderPass.overrideCameraTarget为真表示renderpass设置过自定义渲染目标
        为假表示使用由renderer.SetRenderTarget设置的默认渲染目标
    renderPass.depthAttachmentHandle默认值为backBuffer
    renderPass.OnCameraSetup
            ↓
    renderPass.Configure:
            ↓
    renderPass.ConfigureTarget




CameraType.Game 通常实时相机 或 选中相机时在Scene界面右下角出现的Game预览
CameraType.SceneView 渲染Scene界面
CameraType.Preview 材质预览 相机预览
CameraType.Reflection 反射探针

1 是否需要中间颜色RT
    能不能直接渲染到backBuffer或targetRenderTexture => 能 但有诸多功能限制
        => 显示器的backBuffer同时包含了颜色和深度 不便于分离
        => 使用中间RT合成多个相机的效果 这对于非栈模式的多个独立相机并不是强制要求
        => 延迟渲染需要中间RT Gbuffer pass深度RT不执行Y反转 但是Deferred pass对颜色和深度buffer要执行Y反转
        => SceneView相机需要中间RT SceneView相机的目标RT需要输入深度值 用于debug渲染
        => Preview相机不需要中间RT 相当于极简模式 唯一明确不需要中间颜色RT的情况
        => 需要CopyColor时 
        => 需要后处理时(或者录屏) 可能极简情况下可关闭后处理/CopyColor
        => 非默认视口时 根据视口偏移Blit到目标RT
        => 渲染精度放大或缩小 RT分辨率自定义 需要Blit
        => HDR开启时 RT格式自定义 需要Blit
        => 目标显示器backBuffer不支持自动的sRGB转换 需要用户手动将Linear转换为Gamma

2 是否需要中间深度RT
    深度RT用于Copy、深度测试减少OverDraw等 不管是预计算深度还是逐DrawCall累积深度都可以确定要深度RT
    深度RT可以创建中间深度RT或直接使用backBuffer的深度Buffer
        => 如果没预计算深度 又需要copy 那么数据来源肯定是中间深度RT
        => NativeRenderPass + 延迟渲染可以省略中间深度RT
        => //Scene filtering redraws the objects on top of the resulting frame. It has to draw directly to the sceneview buffer.
            => camera.sceneViewFilterMode == Camera.SceneViewFilterMode.ShowFiltered;

3 是否需要CopyDepth
    CopyDepth RT经常用于重建世界坐标 在特效中使用
    因为要同时进行深度读和深度写操作 所以需要除了深度目标以外的深度RT作为采样源
    如果确实有需要可以在渲染不透明物体后Copy一次深度
    延迟渲染+NativeRenderPass可以省略CopyDepth
        如果延迟渲染没有开启NativeRenderPass => 退回到Forwar+
    Depth RT格式问题：如果RT需要作为深度目标被写入 则format需要为Depth 其他情况则为单通道浮点数
    默认值：Shader.SetGlobalTexture("_CameraDepthTexture", SystemInfo.usesReversedZBuffer ? Texture2D.blackTexture : Texture2D.whiteTexture);

4 是否需要预计算深度(DepthOnly Pass)
    需要用到CopyDepth RT 但是无法通过采样深度buffer复制深度值 如GLES平台复制深度值有性能问题
    开启了MSAA时且硬件不支持MSAA Resolve时
    预计算深度是需要避免的 应充分利用EarlyZ减少OverDraw
    SceneView/Preview/Gizmos等模式下不需要考虑性能
    延迟渲染下无需预计算深度

5 DepthNormal prepass在什么情况下渲染:
    延迟渲染下：在Gbuffer Pass之后为ForwardOnly物体执行DepthNormal prepass补充深度值和法线值
    前向渲染下：渲染全部几何体生成深度Buffer和Normal Buffer

6 NativeRenderPass在什么情况下关闭
    NativeRenderPass用于移动端延迟渲染
    https://docs.unity3d.com/Packages/com.unity.render-pipelines.universal@14.0/manual/rendering/deferred-rendering-path.html
    https://community.arm.com/arm-community-blogs/b/graphics-gaming-and-vr-blog/posts/deferred-shading-on-mobile
        Write GBuffer (albedo, normal, pbr, depth) => on-chip
        Read GBuffer       => on-chip
        Write Color/Depth  => Flush to memory
    利用Tile内存/MRT/FrameBuffer Fetch 让GBuffer的写和读都发生在on-chip 不消耗额外的带宽
        
    延迟渲染下：GBuffer pass和Deferred pass应该是一个连续Pass(合并)
        SSAO：在Deferred pass中需要采样由SSAO产生的AO遮罩 基于随机采样深度获得近似AO
        GBuffer pass → SSAO(不是基于Tiled) → Deferred pass这样会打断NativeRenderPass
            改进：SSAO (depth previous frame) → [GBuffer → Lighting]
    保持像素数据在Tile内存 不Flush to memory
    GBuffer布局限制在128bit
        Gbuffer布局：

7 ShadowMap的生成
    主阴影和额外阴影如果初始化判断失败也会分别生成1x1的默认ShadowMap
    可以设置透明pass是否采样阴影 但是没必要 比如半透明的布或草

8 渲染目标store操作优化
    如果放弃保存对渲染目标的写入信息可以节约带宽 比如后面不需要深度RT时放弃保存深度














