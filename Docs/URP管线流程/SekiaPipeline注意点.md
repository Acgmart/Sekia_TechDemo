# SekiaPipeline与URP之间的依赖关系
为了避免牵扯过多的开发精力 SekiaPipeline只专注于渲染流程
尽量少直接使用URP的代码 便于与URP脱钩
对URP只改动以下文件
1.Runtime/AssemblyInfo.cs   利用友元程序集访问URP的公开和内部方法
2.Runtime/UniversalAdditionalCamera.cs 使部分字段公开
3.Editor/UniversalAdditionalCameraDataEditor.cs 禁用CustomEditor
这样做的好处是URP版本更新时不需要做太大的改动 专注于移植新的渲染特性
不改动UniversalAdditionalCamera 兼容URP管线 可一键切换管线
所以切换Unity版本后 只需要重新切出URP包 修改这少量文件就可以了

# 使用RenderTexture作为常驻的RT
保存中间RT时 老版本用RenderTargetIdentifier 新版本用RTHandle
RenderTargetIdentifier不保存引用 每一帧反复释放申请RT
RTHandle将RenderTexture包装了一遍 用于支持动态分辨率
    动态分辨率相对鸡肋 临时降低分辨率可减少片元计算量
    但是大多数游戏的GPU的渲染消耗相对稳定 每秒30-60帧 没有突发的性能瓶颈
    动态分辨率的发挥场景是赛车、FPS等全角度复杂场景
        峰值帧率与平均帧率之间要有显著差异
        动态分辨率可在性能突发时稳定帧率
使用RenderTexutre使buffer持久化

# 跨Unity版本收集新的渲染特性
新版本的Unity中新增加的很多功能是有机会移植到老版本中的
比如RTHanle作为Unity2022的新功能 在Unity2021以下都没有
但是RTHanle在理论上只是RenderTexture的一层包装
    所以经过一段时间的摸索以后 可以自己集成这个新的特性
其他功能也是类似 比如NativeRenderPass
    延迟渲染虽然是Unity2021的新特性 但是在Unity2019也有接口
    参见CommanBuffer的api 这种底层的集成风险会偏大