1.开启Windows的开发者模式

2.找到目标RT 双击RT查看RT参与的Resource History
    RT可能扮演Input或者Output

3.找到RT作为Output的DrawCall 查看细节
    比如186 DrawIndexed
    Input中的数据：
        B：9530(IBV)：三角面列表 index buffer
        B：9600(2views)：模型通道数据
        B：10306(CBV)：存放一些逐物体变量 如矩阵和材质参数 constant buffer
        Geometry:186:几何体
        T:155(SRV)：输入贴图
    Excution中的数据：
        计算参数-shader指令-渲染状态
    Output：
        顶点shader输出的mesh和RT读写输出