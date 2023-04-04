---
title: 球谐光照与烘焙
categories:
- [渲染, 光照]
date: 2020-06-28 13:18:22
---

\[toc\]本篇描述Unity中的SampleSH函数。 参考资料： [球谐光照解析](https://gameinstitute.qq.com/community/detail/123183 "球谐光照解析") [Unity光照烘焙技术](https://connect.unity.com/p/unityde-guang-zhao-hong-bei-ji-zhu-shang "Unity光照烘焙技术") [\[Unity零基础入门\]8.全局光照GI](https://www.bilibili.com/video/BV1Mt411q7vN "[Unity零基础入门]8.全局光照GI") [陈嘉栋：编辑probe信息](https://www.cnblogs.com/murongxiaopifu/p/8997720.html "陈嘉栋：编辑probe信息") [LightProbes Manual](https://docs.unity3d.com/ScriptReference/LightProbes.html "LightProbes Manual") [特别棒的探针布置教学视频](https://www.bilibili.com/video/BV1mW411J77d "特别棒的探针布置教学视频")

# SH与间接光

我们偶尔能在shader代码里面看到SampleSH这样的引用： float3 color = SampleSH(float3(0, 1, 0)); //采样球体正上方的颜色 这里的SH，指的是光照探针，是Unity根据mesh最近的3个probe进行差值的结果。 如果我们关闭了自动烘焙导致没有烘焙probe，则采样结果是黑色； 如果场景中没有probe，则使用光照设置中的环境probe，通常是Sky Box； 动态物体通过采样probe获得静态物体的间接光贡献； probe中的记录了probe位置处多个角度采样的颜色，保存为SH系数； 采样probe的过程中通过SH系数快速计算出采样结果，相比Cubemap贴图来说节约性能。 probe仅作为保存颜色的方式，而这些颜色都是通过RayTracing离线计算的，不能实时变化。 probe中也无法判断物体距离，无法提供阴影。

# SphericalHarmonicsL2 API

关于球谐，网上有很多文章，我是个数学渣，就不献丑了； 简单的说就是计算球面随机平均方向光照贡献的积分； 在Unity中，烘焙GI的probe采用了L2（9个参数，每个参数3个通道）； Enligtrn的预计算实时GI中probe采用了L1（4个参数）；

```
//访问当前场景中的probe列表 第一帧就访问的话可能报nuLl
SphericalHarmonicsL2[] bakedProbes = LightmapSettings.lightProbes.bakedProbes;
//清理probe
bakedProbes[i].Clear();
//环境光增量
bakedProbes[i].AddAmbientLight(m_Ambient);
//光源增量 需要计算衰减值
bakedProbes[i].AddDirectionalLight(-l.transform.forward, l.color, l.intensity);
//根据四面体进行差值得到最终的SH系数
bakedProbes.GetInterpolatedProbe(position, renderer, out probe);
```

存在理论上，在运行时修改SH系数、添加动态probe的可能。