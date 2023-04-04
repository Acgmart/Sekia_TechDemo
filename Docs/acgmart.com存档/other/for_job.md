---
title: 个人作品展示
categories:
- [其他]
date: 2018-07-29 18:08:31
---

\[toc\]本篇内容为我的个人作品展示。 主要知识体系都在博客的文章中； 部分文章因为理解的更深入了更新过；更多的写的早的文章有点旧； 我个人不精通原画，主要的知识体系都是代码，shader、渲染管线； 审美方面，只能用程序员的色调、程序化，或者二次元用户的观点来描述。

# 渲染基础

个人认为，只要管线知识扎实，做效果都好说。 整理了管线、shader函数、图形数学方面的知识，长期更新； 参考博客目录：渲染-渲染基础

# ET demo

[https://github.com/Acgmart/ET-MultiplyDemos](https://github.com/Acgmart/ET-MultiplyDemos "https://github.com/Acgmart/ET-MultiplyDemos") 这是2018年底初学ET，跟着斗地主demo做的前后端。 参考博客目录：服务端、客户端 ET是一个开源的ECS构架双端C#框架，我的博客也作为ET学习笔记分享给网友； 参考ET主页：[https://github.com/egametang/ET](https://github.com/egametang/ET "https://github.com/egametang/ET")

# 动画Clip压缩

![](https://img.acgmart.com/uploads/article/other/for_job/1.jpg) 有时候模型带动画体积太大了，传不上Github，就做了这个关键帧优化插件； 根据关键帧贡献的实例变动比例，删除一些多余的关键帧，使动画Clip文件变小。

# 表格导出工具

![](https://img.acgmart.com/uploads/article/other/for_job/2.png) ![](https://img.acgmart.com/uploads/article/other/for_job/3.png) 使用NPOI包，将表格打包工具独立在Unity之外，避免Unity报错的时候不能导出表格； 这样方便自定义字段+程序化生成部分代码，大量读取时可以考虑Lazyload，待优化。

# 捏人换装demo

![](https://img.acgmart.com/uploads/article/other/for_job/4.png) ![](https://img.acgmart.com/uploads/article/other/for_job/5.gif) 19年上半年做的捏人demo，仿的Illusion，没有打磨细节。 ![](https://img.acgmart.com/uploads/article/other/for_job/6.jpg) 人物细节都是靠部件拼凑的，这是一个微调材质后的效果。 ![](https://img.acgmart.com/uploads/article/other/for_job/7.png) 这些是网上的玩家用Illusion的编辑器捏出来的一些优秀效果，仅供参考。

# 图形编程进阶知识

19年下半年翻译/整理UGP这本书，了解GPU instancing、Compute Shader、流体、喷涂，等知识点； 这部分的核心都是代码和流程理解，参考博客目录：渲染-UGP UGP系列的书有4册，还有3册没空看，很多GPU效果能利用在移动端的可能性小。

# SRP、URP

关于SRP和URP，2019年下半年就阅读过LWRP的代码，最近2019.4LTS，更新了相机栈工作流程，博客更新了下； 这部分的核心还是代码，主要是对CommandBuffer的熟练运用，参考博客目录：渲染-URP

# DCC工具相关

Max、Blender、MMD等接触过，练习过一周的Blender，主要是为了了解制作流程和mesh数据； SP(Substance painter)看过manual，SP的shader编程简单了解了一下；不确定会用到什么，没下力气学。 ![](https://img.acgmart.com/uploads/article/other/for_job/8.jpg) ![](https://img.acgmart.com/uploads/article/other/for_job/9.jpg) 一些练习作品。

# 自定义卡通shader

![](https://img.acgmart.com/uploads/article/other/for_job/10.png) 这个应该是2019年年中，做的卡通shader+GUI，把shader功能用shader关键字，做成开关模式。 能直观看到开启了哪些功能，未开启的功能隐藏掉，感觉这样更便利。

# 卡通渲染常用概念

总结了下卡通渲染、粒子、后处理效果； 参考博客目录：渲染-shader库

# 知乎、CSDN、Unite大会、Q群、插件等，网上流传的学习资料

![](https://img.acgmart.com/uploads/article/other/for_job/11.png) ![](https://img.acgmart.com/uploads/article/other/for_job/12.png) 米哈游的等高线阴影强度遮罩，网上有很多卡通渲染的演讲、文章，会借鉴一些。

# Houdini-开发工具

![](https://img.acgmart.com/uploads/article/other/for_job/13.png) 2020年7月份开始接触Houdini，这是烘焙出来爆炸帧动画，可用来做粒子效果。

# 使用FairyGUI制作的复杂动效

![](https://img.acgmart.com/uploads/article/other/for_job/14.gif)