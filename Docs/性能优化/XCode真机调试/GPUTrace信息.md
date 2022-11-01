苹果官方文档：https://developer.apple.com/documentation/metal/
    主要看开发工具下的调试工具和性能调优
部分文档有中文版：https://developer.apple.com/cn/documentation/
由于我主要是Unity的使用者 学习Metal主要是将知识点和Unity进行对接

# Metal(MTL)文档
MSL：Metal Shading Language，与Unity shader大同小异
device address space：GPU可以读和写的持久内存
MTLDevice：对GPU设备的抽象
GPU-related entities：shaders、memoryBuffers、textures
MTLFunction：Metal Function，public的，无法被其他shader方法调用，作为接口
MTLLibrary：Metal Function的集合
MTLComputePipelineState(PSO)：Metal Function的状态集合
    Metal Function不能直接执行 需要通过创建一个pipeline转换为可执行代码
    pipeline指定了GPU完成特定任务的多个步骤 通过PSO的形式表现出来
    最简单的 compute pipeline只包含一个Metal Function，GPU传回数据给CPU
    创建PSO时，以同步的方式针对GPU编译shader，应注意耗时。
MTLBuffer：类似于ComputeBuffer，需要声明并指定长度，填充数据，绑定PSO
    MTLResourceOptions：可指定Buffer的的保存形式 比如CPU/GPU访问权和读写权
MTLCommandQueue/MTLCommandBuffer/MTLComputeCommandEncoder：规划渲染命令列表
    添加compute pass时使用MTLComputeCommandEncoder
    光栅shader使用MTLRenderCommandEncoder
MTKView：类似于SRP，对渲染流程进行包装
    enableSetNeedsDisplay：是否为静帧，如果是则只在view变化时update画面
    delegate：类似于URP的Renderer，当需要update画面时或分辨率变化时调用
    currentDrawable：backBUffer
MTLRenderPassDescriptor：描述渲染目标(RT) load和store行为
renderEncoder drawPrimitives：相当于Unity中的cmd.DrawMesh
MTLRenderPipelineDescriptor：描述光栅shader的一次DrawCall 用于创建PSO
MTLStorageMode.memoryless：用于存储临时texture资源 可用于节省带宽
    texture资源作为render target
    在render pass的开始 texture未被加载
    在render pass的结束 texture未被保存

# XCode调试相关设置
    选中Target(Unity-iPhone)-Edit Scheme-Run-Diagnostics
        开启API Validation/Shader Validation/Show Graphics Overview
        开启后可在手机屏幕右上角和XCode性能分析中看到FPS/CPU/GPU等总览
# Captured GPU Workload
截帧成功后得到的调试信息，相当于RenderDoc的.rdc文件
右侧有最终渲染画面 鼠标放在像素上可显示颜色值
# Summary
Export：导出为.gputrace文件
Overview：性能消耗总览
    Draw Calls：DC数 核心指标
Performance：性能
    GPU Time：GPU侧的浮点运算延迟 核心指标
    Vertices：顶点数
Memory：内存
    Textures：纹理
    Buffers：
    Other：
# 查看DrawCall
通过添加lable来管理当前关注的渲染任务 这类似于Unity的CommandBuffer性能打点
点击drawPrimitives任务查看光栅化后的几何体 这类似于RenderDoc的MeshViewer
# Geometry Viewer和Shader Debugger
在DrawCall信息中点击Geometry项查看 可查看顶点信息
选中一个顶点后 点击Debug可调试顶点shader
    这个功能是Unity里没有的 类似于C#的逐行调试
    可以用于判断错误来源于输入数据还是shader代码
    展开调试信息后获得更多调试信息
    可观察一个变量的数值的变化过程
选中一个像素后 点击Debug按钮可调试片元shader
# Memory Viewer
寻找资源分配中可以优化的点
易失性/非易失性 私有的/共享的 未使用的 未绑定的 绑定了但是无GPU访问的
# 帧性能分析
渲染命令支持有两种排序方式 在旧的XCode版本排序方式名称有差别
在Group by API Call模式下检查管线流程和渲染逻辑
在Group by Pipeline State模式下根据GPU Time排序DrawCall
    DrawCall、方法、代码行 都会有性能分析帮助定位性能热点
    以代码行为优化着手点-代码行的性能分析饼图提供性能指标
        ALU：逻辑计算耗时 积热指标
            使用half精度或避免使用复杂指令 节约ALU
        Memory：buffer或texture的访问延迟
            可通过改变分辨率调整延迟
        Control flow：逻辑分支耗时
        Synchronization：同步延迟 异步计算中需要等待同步
# 在真机非调试环境生成截帧数据
    Capture GPU Traces Without Xcode
    但是输出的文件需要匹配的真机运行？
# 进阶学习资源
WWDC：Delivering Optimized Metal Apps and Games
    Optimizing performance, memory, and bandwidth
https://developer.apple.com/videos/play/wwdc2019/606/

# 性能拆解
如果要通过抓帧评估性能指标 那么就必须详细了解XCode中各项参数的意义
    就必须深入了解指令的性能因素
    为了平衡掉误差 每个DrawCall都复制10遍 多次检测耗时
为了方便测试 这里定制了很多测试用shader和对应的测试环境
Sample0是简单透明混合 + 直接返回颜色的shader
Sample1是简单透明混合 + 采样1次的shader
Sample2是简单透明混合 + 采样2次后相乘的shader(并行连续采样)
    Sample2_1和Sample2_2增加并行采样次数
Sample3是简单透明混合 + 采样1次作为UV偏移 + 采样1次的shader(串行连续采样)
    Sample3_1和Sample3_2增加串行采样次数
因为都是全屏透明材质 所以OverDraw都是实打实的 片元计算比重非常大
因为vert计算都一样 光栅化差值的计算理论上是一样的
    假设ALU input Interpolation(frag输入插值)性能积分为100
    修改功率(Profile with induced GPU performance State)反复测试

耗时概念
在XCode中显示的GPU Time默认为同类计算的总时间
以下时间单位都用微秒来算 如果要达到30帧 那么每一帧耗时是33333微秒
如果单个DrawCall耗时400微秒 那么同负载的DrawCall承载上限是
    33333 / 400 = 83个
相同内容的多个DrawCall在同一帧中的耗时偏差上下10%左右 
参考：https://developer.apple.com/documentation/metal/optimizing_performance_with_the_shader_profiler
ALU half/float：浮点运算
ALU input Interpolation：光栅化插值
ALU Bloolean：逻辑运算
Memory Store/Sample/Load：内存访问
Control flow：逻辑分支
Synchronization (wait memory)：等待采样/访问buffer
Synchronization (wait pixel)：frag开始和结束时的等待
Synchronization (barrier)：compute shader等待组内线程同步
Synchronization (atomics)：原子锁 没见过GPU上这样处理多线程写入

耗时因素
显示器：手机屏幕分辨率
模型：顶点数-片元数(屏占比)
GPU：功率上限和稼动率
贴图：分辨率-过滤模式-mipmap-采样uv

# 性能分析(GPU最小功率下)
采样相同时 Sample1的耗时居然比Sample2高 所以代码中稍微差异化了下uv
shader性能积分 = 100 / frag输入差值比例
    Sample0  积分：100 / 31.61% = 316
    Sample1  积分：100 / 15.13% = 661
    Sample2  积分：100 / 12.66% = 790
    Sample2_1积分：100 / 12.59% = 794
    Sample2_2积分：100 / 8.52%  = 1173
        每增加一次并行采样少量增加耗时 Sample_2_2突发性接近Sample3
        通过frag输入差值比例推测总任务积分并不准确 仅用于粗略估算
    Sample3  积分：100 / 8.97% = 1226
    Sample3_1积分：100 / 6.68% = 1564
    Sample3_2积分：100 / 5.20% = 1992
        每增加一次串行采样大量增加耗时 大约增加400性能积分
        随着GPU功率增加串形连续采样耗时占比减少

# 乘法性能分析
在前面的基础上 可以得知基于frag差值任务比重估算任务总量的方法勉强比较靠谱
    单个shader的任务指标中没有相比差值在反复调试中更稳定的
    差值指标在多个shader里是等价的 计算量多寡与光栅化过程挂钩
新增4个shader Sample0_1/Sample0_2/Sample0_3/Sample0_4 分别做1-4次half精度的浮点运算
    Sample0  积分：100 / 30.94% = 332
    Sample0_1积分：100 / 27.07% = 369
    Sample0_2积分：100 / 25.77% = 388
    Sample0_3积分：100 / 23.45% = 426
    Sample0_4积分：100 / 21.10% = 474
    每次乘算 约等于35积分

# 更复杂的shader
一般shader都有复杂的光照 差值运算关联的属性也更多
如何对PBR或者NPR shader进行性能分析是接下来的问题
1.差值运算的性能消耗依据是什么 是不是只与差值寄存器数量挂钩
    我在测试PBR shader时发现 高复杂度的PBR shader会使打乱Sample0的插值占比
    为了使Sample0的插值稳定在31%左右需要维持平均shader复杂度
    我的处理方式是在很多个简单shader中混入一个PBR shader
    得到Test_PBR2_NoACES积分：100 / 7.06% = 1416
    与串形连续采样3次相近
2.观察PBR复杂代码在IOS上的指令 深入了解性能消耗构成
    使用shader Inspector上的Compile and show code功能快速查看编译后的代码
    部分参数需要改URP的库 如法线解压、distanceAttenuation和_MainLightPosition
        只有平行光参与的pbr可以做到全half计算
3.其他疑问
    frag方法的饼图合计不是100% XCode调试器并没有把消耗说的很清楚
    float和half转换会影响性能 看起来不是那么免费
    half3和half运算有性能差异
    所有片元用统一值进行运算或者UV(每个片元数值有差异)进行运算有性能差异

# 总结
通过本篇实践可以得到一个粗糙的性能估算模型 来评估我们优化手段的有效性