https://www.cnblogs.com/ghl_carmack/p/10259270.html

# 描述光照需求
游戏中一个物体受A个光源影响
场景中共存在B个光源 每个光源的类型是C
当在片元Shader中进行光照计算需要访问光源的坐标|强度|方向|阴影衰减等信息

# 单Pass Forward Render
URP使用的方法 支持有限的多光源
对于每个光源都能遍历得到其影响的所有物体
在URP的Forward路径中支持1个平行光主光源 + 4个额外光源

主光源的情况比较简单 其强度|方向都是全局属性：
_MainLightPosition.xyz：主光源方向 已归一化
_MainLightColor：主光源强度

额外光源的情况复杂一些 UBO Uniform Buffer Object路径：
额外光源的计算要先获取逐物体受影响的额外光源数量
uint pixelLightCount = GetAdditionalLightsCount();
//return min(_AdditionalLightsCount.x, unity_LightData.y);
_AdditionalLightsCount.x：单个物体最多受到几个额外光源影响
unity_LightData.y：这个物体受到了多少个额外光源影响
unity_LightData声明在UnityPerDraw这个CBuffer里(PerObjectData.LightData)
接下来用逐物体额外光源index访问额外光源列表获得光源属性
Light light = GetAdditionalLight(lightIndex, _PositionWS);
首先是将逐物体的额外光源index转化为全场景额外光源列表的index
//return unity_LightIndices[index / 4][index % 4];
//unity_LightIndices是一个长度为2的float4[] 可保存8个光源的index

https://www.khronos.org/opengl/wiki/Shader_Storage_Buffer_Object
Structured Buffer路径 SSBO Shader Storage Buffer Object：
SM5.0支持StructuredBuffer 可用于定义ReadOnly的任意长度的Struct数组 如：
StructuredBuffer<LightData> _AdditionalLightsBuffer;
StructuredBuffer<int> _AdditionalLightsIndices;
相比float4[] 这为我们带来了很多便利
SSBO和UBO存储位置不一样 SSBO是全局内存 UBO是着色器本地内存
UBO容量小 SSBO容量大 SSBO访问速度略慢于UBO
不过要注意的是RenderingUtils.useStructuredBuffer直接返回了false

到这里前向渲染已经能访问有限数量的额外光源 通过叠加光照结果实现多光源光照
但是问题不少 如：Overdraw 多光源限制和性能问题
好处就是每个物体单独绘制互不干扰 较好的透明排序

# 延迟渲染Deferred Shading
延迟渲染将前向渲染的光照拆分为两步执行 先收集BRDF数据 再计算BRDF光照结果
这样一来避免了合批问题 在屏幕空间能利用大量技术提高画面品质
多光照模型支持：将每个像素的光照模型映射为Stencil值 多执行几遍光照Pass
这样一来BRDF数据会被读取很多次 有带宽压力

# Tiled Lighting
每个光源都遍历下整个屏幕像素的话 也会有很多无意义的光照计算
这里用for循环遍历单个像素有效的多个光源进行光照
需要计算单个Tile的有效光源个数和index 也就是Light Culling步骤
Light Culling 输入：Z bufer和Light buffer
Light Culling 输出：light list per tile
使用单个compute shader 单个group为tile

# Clustered Lighting
Cluster在Tile的基础上沿着相机深度的方向切了很多片
深度的切法并不是线性的 距离相机越近切的越细 比如切成N份
那么Cluster的数量就会是Tile的N倍 但是会有很多Cluster无深度或者被遮挡

# 主要诉求
拿到逐像素的光源index列表 减少Overdraw
https://developer.apple.com/videos/play/wwdc2021/10148/
