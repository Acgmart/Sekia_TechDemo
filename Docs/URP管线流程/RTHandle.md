# 基于属性ID的RT标识
在过去的URP版本中RT的标识很多 都可以标识一个RT 如：
int/string/RenderTargetHandle/RenderTexture/RenderTargetIdentifier
将一个属性名称转换为属性ID： id = Shader.PropertyToID(shaderProperty);
属性ID的值动态生成但运行时不会变 作为字符串版本的快捷访问方式
RenderTargetHandle则可以认为是另外一种形式的属性ID
RenderTexture则保留了RT的引用 可以从GPU回传数据 但是没有属性ID
RenderTargetIdentifier用于CommandBuffer 可以兼容全部标识类型

# RT作为全局变量赋值
Shader.SetGlobalTexture("name", _Texture);
cmd.SetGlobalTexture("name", _Identifier);
cmd.GetTemporaryRT(nameID, _Descriptor);

# RTHandle
RTHandle除了作为RT标识还携带RT描述 如RenderTexture和RenderTextureDescriptor
RTHandle的底层用RenderTexture实现 相比过去的临时RT分配机制(GetTemporaryRT)更持久

## CameraTarget
RTHandle k_CameraTarget = RTHandles.Alloc(BuiltinRenderTextureType.CameraTarget);
BuiltinRenderTextureType.CameraTarget表示当前相机渲染的目标 backBuffer或者自定义RT
直接对CameraTarget渲染可节省很多带宽 但是无法使用后处理方式获得效果多样性


# RenderTargetBufferSystem
声明2个Buffer 名字分别添加后缀A和B 用于交换
m_ColorBufferSystem = new RenderTargetBufferSystem("_CameraColorAttachment");