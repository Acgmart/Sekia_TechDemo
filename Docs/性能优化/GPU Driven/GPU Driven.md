# Indirect类型的DrawCall
使用Indirect类型渲染命令：cmd.DrawMeshInstancedIndirect
    或者cmd.DrawProceduralIndirect()
    参考：https://www.zhihu.com/question/427803115/answer/1548993170
不同之处在于原来几个参数都直接放在了indirect指针指向的显存Buffer中，这样API执行时会直接在显存里面拿。因为参数直接从显存拿，非直接传输的关系，所以命名为indirect。好处是可以通过compute shader直接在GPU端直接修改Buffer内容
需要硬件支持compute shader 可以用小型项目验证下

应用范围限制在地形和草 期望是美术感觉不到的

凯丁：
    1.Vulkan，Metal跑是没问题的
        平台的差别
    2.有IndirectDraw就够了，不需要MultiIndirectDraw，详见刺客信条大革命的方案
        各种api的差别 数据的传递读写差异
    3.VirtualTexture支持好不好我没测过，就不回答了；但是用不用VT本来就是个问题，这个要看项目类型，现在想到GPU Driven Pipeline就觉得必须一起解决VT的问题 , 这个想法是被限制死了。GPU Driven Pipeline 核心是 场景Drawcall内容由GPU来决定，对应的就要解决两大问题，一个是不同的Mesh怎么能合并，一个是相同Shader类型下不同贴图怎么合并。Virtual Texture只是用来解决了第二个问题，而第二个问题是可以根据不同游戏类型选择其他替代方案的，比如Texture2DArray，这个我想大部分手机支持都很好；

GPU裁剪原理：

API:
使用GraphicsBuffer或者ComputeBuffer的bufferWithArgs
DrawMeshInstancedIndirect(Mesh mesh, int submeshIndex, Material material, int shaderPass, 
    GraphicsBuffer bufferWithArgs, int argsOffset, MaterialPropertyBlock properties)

DrawMeshInstanced：将实例的transform信息存储在列表里用index索引
    这个存储操作我们可以自己来
    matrices是矩阵列表 colors是VectorArray
    block.SetVectorArray("_Colors", colors);
    Graphics.DrawMeshInstanced(mesh, 0, material, matrices, population, block);
    每一帧都上传矩阵数据到GPU

drawmeshinstance()其实是对drawmeshinstanceindirect()的一种包装。
    在后者中实现与前者相同的一切(反之亦然，不过相对复杂一些)。 
DrawMeshInstancedIndirect()没有实例数量1023限制(MaterialPropertyBlock)
    使用ComputeBuufer存储数据