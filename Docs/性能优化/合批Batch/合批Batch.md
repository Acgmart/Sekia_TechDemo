参考：
https://blog.csdn.net/victor_li_/article/details/122614924
https://blog.csdn.net/Victor_Li_/article/details/122621657
https://zhuanlan.zhihu.com/p/356211912

# 静态合批 Static batching
用于处理场景中不移动的，重复度不高的物体
勾选物体为Static后，合并多个静态mesh。
1.mesh的通道需要一致才能合并
2.单个静态合批最多64000顶点
3.合并后的顶点数据在世界空间下(负缩放物体效果存在异常)
4.使用相同材质实例

# GPU instancing
参考：https://docs.unity3d.com/Manual/GPUInstancing.html
用于处理高度重复的物体
mesh必须相同，材质必须相同，材质开启Enable GPU Instancing。
一般来说顶点数少于256是不合适的。
差异属性：材质部分浮点数类型参数可以不同
    通过MaterialPropertyBlock指定
    如Color/Scale。
FrameDebug显示：Draw Mesh (instanced) ObjName

GPU instancing的合批优先级低于SRP Batcher，如果想实现GPU instancing：
1.让shader不支持SRP Batcher，调整shader的合批优先级
    需要额外使用脚本赋值差异化参数
    仅差异属性才需要声明在UNITY_INSTANCING_BUFFER
2.代码执行，修改URP管线使用DrawMeshInstancedIndirect命令
    由于需要指定mesh和材质不便于美术使用