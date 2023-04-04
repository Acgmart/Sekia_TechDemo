---
title: URP应用 - 0 - 镜面反射
categories:
- [渲染, 效果表现]
date: 2020-07-02 21:46:04
---

\[toc\]本篇描述在URP中使用镜面反射。 参考资料： [多云转晴的基于距离的平面反射](https://www.bilibili.com/read/cv2738849 "多云转晴的基于距离的平面反射")。 https://github.com/mxrhyx233/Unity\_PlanarReflection-based-on-distance

# 简单运行参考工程

Plane可以反射天空盒子和Cube。 ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/render/present/025.png)

# 简单描述

这个工程是基于built in管线的，在代码中，使用了如下渲染接口： GL.invertCulling = true; //反转GPU背面判定规则 new RenderTexture(1024, 1024, 24); //声明RT [OnWillRenderObject](https://docs.unity3d.com/ScriptReference/MonoBehaviour.OnWillRenderObject.html "OnWillRenderObject")(); //相机渲染次物体前调用一次 Camera.Render(); //相机执行一遍渲染循环 Camera.RenderWithShader(shader, tag); //相机使用替换shader执行一遍渲染循环 //查找tag的值相同的Pass执行，没有找到则不执行 //tag为空时表示无需查找 直接用指定shader中的Pass执行 脚本的参数： Plane Offset：可以调节镜面与Plane的前后位置 Reflection Layermask：会出现在镜面中的物体分类 Downsample：模糊版RT的降采样级别 BlurSpread：模糊指数 物体的材质：Shader中应包含的Pass有： 镜子Pass、高斯模糊(包含2个Pass)、测量深度用的Pass

# 镜子Pass

镜子被理解为，将物体转换到“反射空间”，也就是镜子的另一面空间； 我们的观察位置有一个虚拟的镜子相机，和往常一样，需要求V矩阵和P矩阵。 新的V矩阵相当于：世界空间(W)⇒反射空间(F)⇒观察空间(V) 这种变化适用于矩阵的连乘，Vnew = V \* F； 至于求证标准正交基被镜面反射的矩阵，这是一个数学问题。 新的P矩阵有一点和平常不同，近截面是镜子； 只有在被反射到镜子另一面空间的物体才有可能被反射相机看到； Unity提供了求倾斜P矩阵的方法，我们也可以自己求； 搞定了V矩阵和P矩阵后，镜子相机就可以正常观察反射空间了； 没有对内容做任何处理时，渲染结果会非常清晰，显得不真实； 镜面的平滑程度和反射率都会影响到结果，比如大理石、木质涂漆地板； 被反射的物体离得越近，就能看得越清晰； 所以我们还需要模糊处理、和测量深度。 深度 = (世界坐标 - 镜子坐标) \* 镜子朝向，实际深度可能有多个Unit； 可以假设超过X个单位长度后不会变的更模糊，存在镜子相机输出的A通道。

# 镜面Shader

```
fixed4 frag (v2f i) : SV_Target
{
    i.normal=normalize(i.normal);
    fixed3 col=tex2Dproj(_MainTex, i.uv);
    fixed3 blurCol=tex2Dproj(_blurTex, i.uv);
    float d=tex2Dproj(_depthTex, i.uv).r;
    col=lerp(col, blurCol, d);
    #if _USEFADE_ON
        float3 coll=texCUBE(_Cube, i.rDir);
        return fixed4(coll + saturate(_Fade - d) * col, 1.0);
    #endif
    return fixed4(col, 1.0);
}
```

col在开启Fade之前，等于反射贴图和反射贴图模糊版之间的混合； 可以考虑将d改为0-1之间固定值，用于描述镜子自身的物理性质； Fade效果，采样天空盒子与col混合： 前面我们提到被反射的点与镜面距离不同，所以被反射物的清晰度有差别； 所以，严格上来说应该是，反射贴图的模糊操作应该根据距离操作； 但是为了图方便，我们通常给了一个统一的模糊强度，控制局部清晰度困难； 所以，我们应该添加一些参数，比如最大清晰反射距离，Dclear： 这个系数和镜面的光滑度一样，能描述材质的物理性质； 当反射距离d大于Dclear时，模糊程度最大化； 当反射距离d小于Dclear时，提供平滑差值； 也就是说，我们还需要指定一个d为0时的反射贴图模糊版，用于作为下限。 我们可以参考一下Bloom是如何实现控制模糊范围的。

# Bloom模糊

说道高斯模糊，Bloom效果也用到这个知识点： 1个点先进行预过滤，他的亮度可能有几种情况： 低于Threshold：不发光 在Threshold与Threshold + ThresholdKnee之间：过渡 亮度受限制 等于Threshold + ThresholdKnee：根据超过阀值的比例计算亮度 两步走高斯模糊(降采样)，Pass 1： 因为是降采样，RT的宽高变成了一半，1个像素的宽度就翻倍了： `float texelSize = _MainTex_TexelSize.x * 2.0;` 接着在当前UV位置，额外采集横向相邻的8个像素的颜色，一共9个颜色； 把这些值按比例混合起来，作为横向模糊效果。 注：为了使采样不超出边界，要使用特殊的采样器：sampler\_LinearClamp 两步骤高斯模糊，Pass 2： 这次RT的宽高没有发生变化，采集纵向的5个像素颜色； 但是这5个像素间距不等于单位像素宽度，效果和前面的9次采样类似； 混合后作为某个级别(mip)的模糊效果。 高斯模糊可以反复进行，每进行一轮RT的宽高减半，模糊范围越接近全屏。 在最后一步，我们要选择最终的模糊效果，这里用到了scatter参数： lerp(highMip, lowMip, Scatter); //默认值0.7 如果Scatter = 0，最终使用mip0，相当于光只扩散了5个像素； 如果Scatter = 1，最终使用mipN，相当于把光扩散到了全屏范围； 通过条件Scatter参数，可以控制光扩散的最大范围； 如果光的强度不够的话，扩散到一定程度就已经消耗完强度了。

# 高斯模糊

多云转晴的高斯模糊shader，Pass 1： 纵向连续5个单位的像素采样，按照不同权重进行混合； 这里像素间距使用了系数\_BlurSpread，值越大时模糊程度变高。 多云转晴的高斯模糊shader，Pass 2： 和Pass 1类似，横向混合了5个像素。

# Reflect矩阵

```csharp
void CalculateReflectionMatrix(ref Matrix4x4 reflectionMat, Vector4 plane)
{
    reflectionMat.m00 = (1F - 2F * plane[0] * plane[0]);
    reflectionMat.m01 = (-2F * plane[0] * plane[1]);
    reflectionMat.m02 = (-2F * plane[0] * plane[2]);
    reflectionMat.m03 = (-2F * plane[3] * plane[0]);

    reflectionMat.m10 = (-2F * plane[1] * plane[0]);
    reflectionMat.m11 = (1F - 2F * plane[1] * plane[1]);
    reflectionMat.m12 = (-2F * plane[1] * plane[2]);
    reflectionMat.m13 = (-2F * plane[3] * plane[1]);

    reflectionMat.m20 = (-2F * plane[2] * plane[0]);
    reflectionMat.m21 = (-2F * plane[2] * plane[1]);
    reflectionMat.m22 = (1F - 2F * plane[2] * plane[2]);
    reflectionMat.m23 = (-2F * plane[3] * plane[2]);
}
```

plane用于描述三维坐标系中的一个面，xyz分量为面的法线，w分量为法线方向偏移量。 设平面为(nx,ny,nz,d)，则以此平面为镜面的列主序反射矩阵如下： ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/render/present/026.png) Reflect矩阵的几何意义是，将坐标转移到镜面的另一侧： ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/render/present/027.png)

# Clip空间倾斜(ObliqueMatrix)

reflection\_cam.projectionMatrix = reflection\_cam.CalculateObliqueMatrix(viewplane); viewplane也用于描述三维坐标系中的一个面，xyz分量为面的法线，w分量为法线方向偏移量。 CalculateObliqueMatrix方法用于修正Camera的视椎体范围，使near平面倾斜(作为镜面，使镜子后面的物体被剔除)，使视椎体变形为类平行四边形。

```csharp
void CalculateObliqueMatrix(ref Matrix4x4 projection, Vector4 clipPlane)
{
    float sgn(float a)
    {
        if (a > 0.0F) return (1.0F);
        if (a < 0.0F) return (-1.0F);
        return (0.0F);
    }

    Vector4 q = projection.inverse * new Vector4(sgn(clipPlane.x), sgn(clipPlane.y), 1.0f, 1.0f);
    Vector4 c = clipPlane * (2.0F / (Vector4.Dot(clipPlane, q)));

    projection[2] = c.x - projection[3];
    projection[6] = c.y - projection[7];
    projection[10] = c.z - projection[11];
    projection[14] = c.w - projection[15];
}
```

参考资料：[problem-camera-calculateobliquematrix](https://forum.unity.com/threads/problem-camera-calculateobliquematrix.252916/ "problem-camera-calculateobliquematrix")

# URP中自定义镜面反射Pass

前面我提到了built in管线中实现这样效果的用到了的API； 由于工作流程不一样，所以不能直接用，最重要的是： 不能使用Camera作为渲染逻辑的入口 在SRP中，自定义Feature才是逻辑插入点，使用相机栈的工作模式。

## 关于构建一个相机的批量渲染任务

SRP中的相机的每一帧，通过收集一帧所需的全部数据，安排Pass队列。 对于相机来说，V、P矩阵确定了的情况下，可见范围(视椎体)就是确定的。 通过相机的粗粒度剔除，锁定可见物体列表(虽然是黑盒子操作)。 使用context.DrawRenderers命令提交一次批量渲染任务，可以参考URP代码构建任务； 批量渲染任务，将剔除结果绘制到指定RT，可调整drawSettings、filterSettings； 但是，每个镜面物体要求渲染到指定的RT，不能批量处理。

## 关于镜面物体的思考

场景中的镜面物体不能过多，会产生性能问题和套娃问题。 我们必须想清楚渲染任务一步步是怎么执行的： 镜子相机能看见的物体和主相机是一样的； 如果一个镜子里面照到了其他镜子？如果被照到的镜子先渲染就OK； 镜子之间互相套娃？解决不了，这样性能开销比光线追踪大的多。 所以场景中注定不可能有太多的镜面物体，通常只有一个，比如地板(参考崩坏3)； 我们可以设置一个镜面物体数量限制：最多1-10个，

## 获取镜面物体列表

为了单独设置镜面相机的属性，要先确定镜面物体列表： 1.主相机中能直接看到部分镜面物体，看不到就相当于被剔除了，可以节约性能； 2.物体上有我们自定义的标识，还是得挂上一个Mirror.cs脚本； 在自定义Feature中，管理所有的Mirror脚本； 遍历有效的镜面物体，生成对应的虚拟相机(镜面相机)，设置VP矩阵。 判断物体是否被看见： 由于cullResults的内部是不开源的，我们不能直接访问可见物体列表； 那么换一个思路，使用Unity的mono接口： OnBecameVisible //被任何相机可见 OnBecameInvisible //不被任何相机可见 这两个接口可用于优化性能：只在物体可见情况下执行的逻辑； 这2个接口没有传递具体被哪个相机可见，所以用户应自行处理好Layermask的问题；

## 安排相机栈

类似于设置相机状态为关闭，执行Camera.Render()方法，我们添加临时的Base相机； 设置镜面相机的渲染目标为RT，渲染完成后对RT进行模糊处理； 设置镜面相机的优先级高于主相机，这样镜面相机先渲染； 由于镜面相机的渲染逻辑与主相机没有差别，可以和主相机共用渲染方案； 场景中的镜面物体与镜面相机一一对应，在镜面物体不被显示时关闭对应镜面相机。

## 单个镜面物体的逻辑流程

逐镜面相机，重复执行一次渲染： 设置渲染目标 ⇒ 渲染不透明物体 ⇒ 渲染天空盒子 ⇒ 渲染透明物体 完成这3个任务之后，我们得到了反射贴图(深度存在Z分量) ⇒ 对反射贴图进行高速模糊，得到模糊贴图。 ⇒ 逐镜面物体渲染，使用镜面shader。