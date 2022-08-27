# SetupNativeRenderPassFrameData方法
在pass执行了Config后分析pass列表中可以生成哪些可以合并的NativeRenderPass小组
比如：pass列表的index分别为0至9 其中3~5可以合并为小组 7~8可以合并小组

CreateRenderPassHash：
生成一个hash码用于描述可以合并的pass的特征
1.RT的分辨率需要一致
2.msaa等级需要一致
3.深度目标必须一致

额外注意pass的连续性：
index为3和7的pass的hash码可能一致 需要做连续性判断
7号pass需要检查以3号pass对应的组的最后一个pass是否为6 如果不是6则表示pass不连续

m_MergeableRenderPassesMap：
key为hash码
value为小组内全部pass的index
根据合并规则 很多pass就不适合合并
如主阴影pass：RT的分辨率非全屏、使用深度目标渲染ShadowMap

FrameBuffer Fetch限制：
FrameBuffer Fetch只能获取当前片元的数据 这意味着不能访问周围的像素
比如SSAO：在当前世界坐标沿随机方向前进后判断深度遮挡关系 需要采样周围像素的深度
这个类型的限制需要配合代码规范 不易于自动检测 需要使用者主动规避

# URP默认版本延迟渲染相关代码执行思路
## 初始化时执行一次
UniversalRenderer的自构：
根据延迟渲染状态创建DeferredLights对象、GBuffer pass、Deferred pass

## 每帧按顺序执行一次
ScriptableRenderer.ResetNativeRenderPassFrameData()：
    初始化m_MergeableRenderPassesMapArrays => 以后每帧结束时执行
ScriptableRenderer.Clear()：
    初始化默认RT目标和RT清理状态
UniversalRenderer.Setup：
    CreateGbufferAttachments() 根据扩展功能和NativeRenderPass是否开启判断颜色RT数量
ScriptableRenderer.Execute：
    Pass.OnCameraSetup
    Pass.Configure
    ScriptableRenderer.SetupNativeRenderPassFrameData
    ScriptableRenderer.SetupLights
ScriptableRenderer.ExecuteRenderPass：
    ScriptableRenderer.SetRenderPassAttachments
    ExecuteNativeRenderPass或Pass.Execute
context.Submit

## 每帧完成后清理
Pass.OnCameraCleanup
Pass.OnFinishCameraStackRendering
UniversalRenderer.FinishRendering
Pass.m_ColorAttachmentIndices.Dispose();
Pass.m_InputAttachmentIndices.Dispose();

## 退出游戏时清理
Feature.Dispose()            
UniversalRenderer.Setup.Dispose


## DeferredLights.CreateGbufferAttachments()
m_DeferredLights下的 GbufferAttachments 和 GbufferFormats 都有GBufferSliceCout长度
    开启NativeRenderPass后GBufferSliceCout的长度为4+1=5
    GbufferAttachments中的RT初始值为未分配的RTHandle 只有名字

## DeferredLights.Setup
设置index为3的GBufferRT为颜色目标 
DeferredInputAttachments长度为4 对应index为0至3的4个RT
DeferredInputIsTransient长度为4 表示index为0至2的3个RT不需要Flush to Memory(Memoryless)

## GBufferPass.Configure
分配GbufferAttachments中的非Memoryless的RT
    index为0至2的3个RT都是临时RT不需要分配
    index为4的RT为R32_SFloat格式的深度图 也是临时的不需要分配
        使用R32_SFloat格式的深度图是为了加速访问深度 ？
        关闭NativeRenderPass时就不能Memoryless了
    index为3的RT是主颜色目标 在相机栈的Base相机渲染前已分配

m_DeferredLights.UpdateDeferredInputAttachments()
重新赋值DeferredInputAttachments 避免引用发生变化

ConfigureTarget(rt[], rt, format[])
这个泛型是GBufferPass独有的 额外赋值给pass.renderTargetFormat[]
属性变动：m_ColorAttachments|m_DepthAttachment|m_ColorAttachmentIds|m_DepthAttachmentId
    注意RenderTargetIdentifier的声明方式
    new RenderTargetIdentifier(colorAttachments[i].nameID, 0, CubemapFace.Unknown, -1)
    colorAttachments[i].nameID表示由颜色类型RT名生成的hash值对应的RT
    new RenderTargetIdentifier表示缩小RT范围到mip0 ？
深度目标是主深度RT

ConfigureClear
设置m_ClearFlag 和 m_ClearColor 不清理 清理颜色为黑色

## DeferredPass.Configure
颜色目标是主颜色RT
深度目标是主深度RT
ConfigureInputAttachments(rt[], bool[])
    赋值pass.m_InputAttachments 和 pass.m_InputAttachmentIsTransient
    长度为4

## ScriptableRenderer.SetupNativeRenderPassFrameData
根据pass合并为小组的简单规则寻找可能的合并机会
InitializeRenderPassDescriptor(cameraData, renderPass)
    根据pass的目标RT情况生成hash值 hash值一样的多个pass有机会合并
    GetFirstAllocatedRTHandle可以排除Memoryless的RT

## m_DeferredLights.SetupLights
基于动态缩放赋值m_DeferredLights.RenderWidth 和 RenderHeight ？
PrecomputeLights 将光源根据类型排序
设置全局属性和关键字

## ScriptableRenderer.SetRenderPassAttachments
对于GBufferPass来说走MRT路径 对于DeferredPass来说走非MRT路径
MRT路径：
    判断是否有统一的颜色和深度清理设置
    GBufferPass的颜色和深度清理的值与默认值不一样
        pass.m_ClearFlag用于设置非主颜色RT的清理

SetNativeRenderPassMRTAttachmentList 收集小组内公共颜色RT
m_ActiveColorAttachmentDescriptors的生命周期的起点在这个方法
    终点在ExecuteNativeRenderPass结尾
    在执行一个小组的连续多个pass期间不会发生变化
    小组执行完毕后重置 等待执行后续的小组
UpdateFinalStoreActions的声明周期也是围绕小组的
    pass没有设置过Load/Store时默认值为Store
遍历小组内的多个pass收集不同的颜色RT
    GBufferPass颜色RT有5个 DeferredPass有1个
    currentAttachmentDescriptor用于描述一个新RT的加载状态
        对于GBuffer来说5个颜色RT都指定了format
        对于没有指定format的RT都使用管线默认颜色format
        m_LoadStoreTarget：目标RT
        m_LoadAction/m_StoreAction：加载和保存操作
        m_ClearColor/m_ClearDepth/m_ClearStencil：清理操作
非MRT版本的SetNativeRenderPassAttachmentList和MRT版本的差不多
    只有小组的第一个pass会执行 通常就是GBufferPass

PassHasInputAttachments(pass)
    仅DeferredPass会触发该条件
    SetupInputAttachmentIndices(pass)
    赋值给DeferredPass.m_InputAttachmentIndices
        长度为4的validInputBufferCount
        保存GBuffer中index为0至3的4个RT在m_ActiveColorAttachmentDescriptors中的index
        赋值m_IsActiveColorAttachmentTransient 标记GBufferPass的前3个RT为Memoryless

SetupTransientInputAttachments
    修改 m_ActiveColorAttachmentDescriptors
        Memoryless无需Load/Store 目标ID为空

SetRenderTarget(rt[], rt...)
    与上一次SetRenderTarget产生的记录对比判断RT差异
    MRT需要统一的清理 需要看不清理非主颜色RT是否有影响
    在NativeRenderPass模式下是不会调用cmd.SetRenderTarget的
        NativeRenderPass模式下有明确的起点和终点标志
        仅小组的首个pass设置小组公共RT 其他pass只输入index映射
        
## ScriptableRenderer.ExecuteNativeRenderPass
BeginRenderPass的输入：attachments
    长度为小组颜色RT数量+深度RT数量 所有RT的宽高msaa要一致
BeginSubPass的输入：attachmentIndices
    长度为单个pass的颜色RT目标长度
        GBufferPass颜色RT有5个 DeferredPass有1个
    m_InputAttachmentIndices可作为BeginSubPass的第二个参数
        index为0至3的4个个GBuffer RT对应小组颜色RT的index
        仅DeferredPass有m_InputAttachmentIndices
            猜测：用于标记这些RT为输入RT 可读
在BeginSubPass和EndSubPass之间可以正常使用CommanBuffer进行绘制了

## Pass.Execute

# Stencil多光源支持
5号bit用于描述光源覆盖区域
6和7号bit用于描述像素使用的光照模型 不同光照模型是互斥的
Deferred Punctual Light (Lit)：
    测试目标值不等于6号bit 使用读取遮罩6和7号bit
        这个方法约定6和7号bit定义光照模型
        测试通过表示光照模型符合Lit 之后进行光照计算

Stencil Volume：
    绘制Spot或Point光源的几何体
    测试目标值不等于0 读取遮罩为6和7号bit
        测试通过表示像素受到某个光照模型影响
    测试通过无操作
    深度测试失败反转目标值 使用写入遮罩为5号bit
        这个方法可以用于写入值和测试值不一样的情况
        写入值后表示该区域被光源覆盖 之后进行光照计算

Deferred Directional Light (Lit)：
    绘制Spot或Point光源的几何体
    测试值等于5和6号bit 读取遮罩为5、6、7号bit
        5号bit表示必须被光源覆盖 
        6号bit表示必须使用指定的光照模型
    测试通过写入值0 使用写入遮罩5号遮罩
        写入操作不改变光照模型
        写入操作清除掉了光源覆盖区域 不影响后续光源的渲染
    ZTest GEqual ZClip false Cull Front
        使用光源模型的背面与场景深度进行测试 测试模式为GEqual
            光源可能被埋在地地下 避免光源与场景没有实际交互
        测试成功表示光源与场景有交互
        为了避免模型被视椎体裁剪 关闭ZClip
            超出near和far的片元会被clamp到near和far 进行片元计算

# 法线通道压缩
参考文章：https://new.qq.com/rain/a/20220507A02IK100
    使用八面体编码压缩法线
        不压缩时 移动端 光滑区域出现色带瑕疵
    苹果A11芯片的Compute shader计算性能瓶颈
    光源数量不多(10个以下)时 不必急于使用Tiled Culling
        等有巨量光源需求时再做支持

八面体编码
    参考文章：https://blog.csdn.net/noahzuo/article/details/60757793
    https://knarkowicz.wordpress.com/2014/04/16/octahedron-normal-vector-encoding/
        http://jcgt.org/published/0003/02/01/
    将球面映射为正八面体 然后展开八面体为类似2D的UV
    矢量在八面体上基本平均分布 误差较小
    在Unity种开启八面体编码需要激活关键字 _GBUFFER_NORMALS_OCT
    https://aras-p.info/texts/CompactNormalStorage.html
    在ViewSpace做光照？
        https://blog.csdn.net/xoyojank/article/details/5294575
        使用视锥体的四个角插值得到顶点坐标 可节约一个指令
        vPositionView = vViewRayDir * fLinearDepth;

    https://twitter.com/Stubbesaurus/status/937994790553227264
        算法优化

    https://johnwhite3d.blogspot.com/2017/10/signed-octahedron-normal-encoding.html
        10：10 格式的优化