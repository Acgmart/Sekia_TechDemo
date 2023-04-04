---
title: 从0开始的Unity3D游戏开发 Astar寻路
categories:
- [Unity, ET]
date: 2018-08-24 01:04:14
---

\[toc\]在ET4.0中引入了Astar插件作为寻路组件，寻路组件使得服务端在计算交互的时候更为主动，毕竟所有单位的坐标都掌握在服务端这边，一切计算以服务端为准，同步到客户端。 可以百度“a star插件”获得更多资料，虽然说重复资料不少，干货还是2014年的。 [插件官方网址](https://www.arongranberg.com/astar/front)。

# 生成地图数据

在Unity中，在场景中创建名为A\* 的空物体，添加Pathfinder脚本； 在属性面板中出现Astar Path的脚本界面。 里面有Graphs/Settings/Save&Load/Optimization，看名字的话大概是物理/设置/存取/优化的意思。

## Graphs

Add New Graph可以新建Graph，可以重命名/隐藏辅助显示工具/查看信息/删除Graph。 bouding box：包围盒 gizmos：辅助线 voxels：三维像素 调试方法：开启Show surface和Show outline，修改参数后Generate cache； ▲Cell Size：一个三维素单位相对于Unity中的1个单位的尺寸，默认0.5； Use Tiles：是否使用瓷砖，及设置瓷砖的宽度，数值越小细节处的三角形； Min Region Size：在一堆物体中最小的范围尺寸，更小的区域会被忽略； Walkable Height：可以从底部到达顶部的最大距离； ▲Walkable Climb：玩家可以攀爬的高度，必须小于Walkable Height； ▲Character Radius：单位半径，障碍物周围的白色非路径区域，越小越细节； Max Slope：近似的最大误差； Max Border Edge Length：分割前最大边长; Max Edge Error：边缘简化； Rasterize Terrain：栅格化地形； Rasterize Messhes：栅格化网格； Rasterize Colliders：栅格化碰撞器； 包围盒尺寸设置：把地图元素包裹起来 图层和标签设置：添加需要被栅格化的图层和标签 Graph的设置可以在Scene中预览到效果，可以观察自己想要的路线是否可以走通。