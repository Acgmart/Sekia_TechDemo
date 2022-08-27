# 解决纹理映射问题的Y反转
DX平台UV起点在左上角 GL平台UV起点在左下角
这意味着同样的贴图和UV值在不同平台采样的结果不一样
比如用UV值(0,0)在DX平台采样到左上角的像素 在GL平台采样到左下角的像素
Unity为了处理贴图采样问题在DX平台上对静态图片资源进行了Y反转
但是RenderTexture因为是运行时生成的 就需要处理Y反转问题

# Y反转与渲染到backBuffer
从渲染流程上可以直接渲染到backBuffer 或者
    先渲染到中间RT 再Blit到backBuffer 或者
    直接渲染到RenderTexture 可保存起来或作为材质参数
    但是最终都是要渲染到backBuffer的
        只有Game类型的相机会渲染到backBuffer

DX平台在部分情况下需要对P矩阵进行Y反转
    Blit采样用的全屏mesh可以自定义
    采样一个Y反转后的贴图时 mesh的左下角UV为(0, 0)
    采样一个未Y反转的贴图时 mesh的左下角UV为(0, 1)

1.如果正在对RenderTexture进行渲染 => 需要Y反转
    RenderTexture在数据保存形式上是Y反转的 但是不影响显示
2.如果正在对backBuffer进行渲染 => 不需要Y反转
    backBuffer在数据保存形式上是无反转的
3.例如Sceneview和Preview相机都是需要Y反转的
    只要目标不是backBuffer一律Y反转P矩阵
5.如果是使用了中间RT + Deferred MRT渲染
    GBufferPass的多个目标应用了Y反转
    DefferredPass采样反转后的GBuffer 颜色和深度目标都是Y反转的
6.如果无中间RT(直接用backBuffer当颜色目标) + Deferred MRT渲染
    这里出现了bug 因为多个目标中包含了backBuffer 强制不Y反转
    后续采样GBuffer都要采样未Y反转过的RT
    所以延迟渲染必须使用中间RT
