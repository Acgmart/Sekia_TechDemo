参考：
移动设备GPU架构知识汇总：https://zhuanlan.zhihu.com/p/112120206

# TBR IMR TBDR等GPU构架
Deferred机制：对RT的写入会以缓存的形式暂时停留在片上缓存
    当渲染管线切换目标RT或提交到BackBuffer时上传缓存到目标区域(上传：Flush To Memory)
    在URP中如果不开阴影和后处理等可以实现直接绘制到BackBuffer
        ScriptableRenderContext.Submit()：提交命令 强制上传
    Deferred的评价：延迟机制显著降低了带宽消耗 但是需要更多缓存

HSR(Hidden Surface Removal)：既然上传可以延迟 那么片元计算也可以延迟
    常规深度测试：深度测试失败的片元不需要计算片元Shader
    HSR深度测试：连续进行多个片元的深度测试 对最终幸存的片元计算片元Shader
    HSR的评价：减少了不必要的片元计算 实现片元级别无OverDraw

Tiled机制：对RT进行写入时 会将RT划分为以Tile为单位的小区域进行
    相对于Immediate模式，Immediate模式下GPU要等待DrawCall完成后才能进行下一个DrawCall
    Tiled机制是GPU侧的缓存策略 将RT拆分成足够小的的Tile存储在片上缓存
        对片上缓存的读写非常快 Blending操作消耗一次读和一次写
    如果不使用Tiled机制 那么由于RT体积过大将无法执行缓存策略
    Tiled机制的评价：Tiled是Deferred机制的数据存储模式

TBR or TBDR：有HSR功能的是TBDR TBDR延迟了片元计算
    TBR和TBDR在片上缓存使用策略、上传等机制都是一样的

Transient机制：在Deferred机制下 将部分片上缓存当做虚拟RT使用
    由于带宽消耗只在上传时发生 那么只要永远不上传就可以规避部分带宽消耗
        比如延迟渲染中的深度图和数据通道在延迟光照结束后可能就不需要了
    Transient机制的评价：进一步减少了非必要的带宽消耗