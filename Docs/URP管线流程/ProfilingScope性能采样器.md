URP中可以经常看到性能采样器声明 例如：
using var profScope = new ProfilingScope(null, 
    ProfilingSampler.Get(URPProfileId.UniversalRenderTotal));
using (new ProfilingScope(null, Profiling.Pipeline.Context.submit));
using (new ProfilingScope(cmd, m_ProfilingSampler))
在Profile中可查看CPU耗时 在FrameDebug中可查看DrawCall状态
所以这是两种类型的性能分析打点混在了一起用 使用错误会导致分析面板排序混乱

如果指定ProfilingScope自构参数中的CommandBuffer对象为null 那么只进行CPU端性能分析
如果指定CommandBuffer对象 那么同时进行CPU和GPU端性能分析

CPU端的性能分析打点：
使用值域作为范围 有明显的起点和终点
using()样式的值域通过 大括号标注 或 仅有一行代码省略大括号
using var profScope =样式的值域的终点在方法结束处 省略大括号

GPU端的性能分析打点
GPU端通过CommandBuffer命令进行打点
虽然和CPU端打点的起点和终点一样 但是要提交命令才能生效
视代码内容的不同要多次提交 例如：
using (new ProfilingScope(cmd, m_ProfilingSampler))
{
    context.ExecuteCommandBuffer(cmd); //提交采样开始命令
    cmd.Clear();

    context.DrawRenderers(...);
}
context.ExecuteCommandBuffer(cmd); //提交采样结束命令
cmd.Clear();
所以GPU端的打点除了确认终点 还需要确认命令提交的位置

可以考虑手动Dispose 例如
using var profScope = new ProfilingScope(cmd, m_ProfilingSampler);

context.ExecuteCommandBuffer(cmd); //提交采样开始命令
cmd.Clear();

context.DrawRenderers(...);

profScope.Dispose();
context.ExecuteCommandBuffer(cmd); //提交采样结束命令
cmd.Clear();