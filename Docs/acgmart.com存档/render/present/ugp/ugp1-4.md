---
title: UGP1-4 格子法流体
categories:
- [渲染, 效果表现, UGP]
date: 2019-12-30 12:42:54
---

\[toc\]本篇讨论UnityGraphicsPrograming第一册第四章内容 Stable Fluid(格子法流体)。 ▲工程整体运行思路 工程运行后整体效果是纯白的背景，鼠标在屏幕上按下左键并移动后，得到一个不断消散的墨迹。 与用户进行鼠标交互的脚本是MouseSourceProvider.cs 用户按下鼠标左键时，对addSourceTex进行写入，使用的参数为： 1.鼠标当前在viewport space的位置(uv，0-1) 2.鼠标位置相比上一帧的移动方向(单位2D向量) 3.一个用户指定的值作为墨迹强度(宽度) addSourceTex上记录了当前帧每一个像素受到墨迹(加速衰减曲线)的影响： XY通道记录了速度和墨迹强度的共同影响；Z通道记录了墨迹强度的影响。 当有鼠标左键点击事件时，将addSourceTex传递给Solver2D的**SourceTex**。 Solver2D继承于SolverBase，根据isDensityOnly值有两个分支，均是ComputeShader计算。 而ComputeShader Solver2D中包含的kernel数量高达13个，每个kernel的功能需要仔细阅读。 在SolverBase.cs的Update逻辑最后，将处理结果保存在全局RT **SolverTex**中。 在Camera下的RenderEffect.cs则做了个简单的后处理，简化后相当于： `Graphics.Blit(source, destination, material);` 对应shader代码则是对SolverTex的采样，并输出最终颜色。 总结：本篇重点为从SourceTex到SolverTex之间的ComputeShader计算过程。 ▲流体力学的处理方法 流体力学将自然界中的流进行数学公式化处理，“在某一刻的流速”引导数值的变化，将时间微分后解析流速向量的变化量。有两种流的解析方法可供参考： 1.格子法，Stable Fluid，将洗澡水分成格子状(像素块)，计算每个格子的流速变化。 2.粒子法，SPH，洗澡水上浮着鸭子，解析鸭子的位置/速度变化。 3.格子法+粒子法，FLIP。 格子法擅长计算压力、粘性、扩散，粒子法擅长计算根据压力方向的移动。 ▲本篇中的公式原则 流体公式参考[Navier–Stokes公式](https://ja.wikipedia.org/wiki/%E3%83%8A%E3%83%93%E3%82%A8%E2%80%93%E3%82%B9%E3%83%88%E3%83%BC%E3%82%AF%E3%82%B9%E6%96%B9%E7%A8%8B%E5%BC%8F "Navier–Stokes公式")，这里不展开讨论。 作者提出了速度场、密度场、质量守恒原则等概念。 质量守恒原则：模拟流体时，需要明确对象会不会被压缩。例如，气体根据压力密度产生变化，属于压缩性流体；水等，在所有场合都有一定密度的物体，属于非压缩性流体。 本章中采用的是非压缩性流体，速度场的流入速度=流出速度。 下面就具体的kernel进行展开：

# isDensityOnly = true

勾选isDensityOnly后，墨迹涂在背景上不会移动，计算过程变得很简单。 ▲AddSourceDensity 密度场写入 当isDensityOnly = true，且SorceTex != null时，AddSourceDensity是第一个执行的kernel。

```
[numthreads(THREAD_X, THREAD_Y, THREAD_Z)]
void AddSourceDensity(uint2 id : SV_DispatchThreadID)
{
    uint w, h;
    density.GetDimensions(w, h);

    if (id.x < w && id.y < h) //后面的代码都去掉上面这重复的一段
    {
        density[id] += source[id].z * densityCoef * dt;
        prev[id] = float3(prev[id].xy, source[id].z * densityCoef * dt);
    }
}
```

在本篇的C#脚本中，一共出现了5个RenderTexture变量： SorceTex、solverTex、densityTex(密度场-一维)、velocityTex(速度场-二维) prevTex(上一帧数据-三维)：xy保存速度，z保存密度 这5个RT的分辨率默认都是屏幕分辨率，id.x和id.y可以表示RT上的单位像素。 AddSourceDensity中，对density和prevTex的Z通道写入了墨迹强度(逐帧叠加)。 ▲DiffuseDensity 密度场扩散计算(模糊)

```
float a = dt * diff * w * h;
[unroll]
for (int k = 0; k < GS_ITERATE; k++) {
float t =density[int2(id.x - 1, id.y)] + density[int2(id.x + 1, id.y)] + density[int2(id.x, id.y - 1)] + density[int2(id.x, id.y + 1)];
density[id] = (prev[id].z + a * t) / (1 + 4 * a);
SetBoundaryDensity(id, w, h);
}
```

a应该是一个相当大，比如1000X1000，这样的系数。 t表示某一个像素周围上下左右4个像素的密度值之和，值来自于AddSourceDensity计算； `prev[id].z`的值也来自于AddSourceDensity计算； `density[id]`的值会同时受到这5个值的影响，如果分子分母同时除以4a： `(prev[id].z / 4a + t / 4) / (1 / 4a + 1)` 由于1 / 4a几乎可以忽略，分母部分近似于1了，我们再看分子部分： `density[id]`等于强度的一点微分量，加上周围强度的平均值，**这是一个模糊的过程**。 通过观察可知，墨迹的宽度通常有20个像素左右，每次赋值，墨迹边际外拓一个像素并变淡。 这个过程中存在的问题： 1.单个线程中同时对density进行了读和写，异步操作对计算结果可能有干扰； 2.这个模糊算法的计算效率并不高，如果设置GS\_ITERATE为更高值需耗费计算力，参考Bloom。 3.id.x -/+ 1的过程中，肯定会超过采样的边界值，如-1，不确定是Clamp还是Repeat处理。 SetBoundaryDensity：当像素的位置在density的边缘一圈，则取临近像素的值。 ▲SwapDensity 为prevTex的Z通道赋值

```
float temp = density[id];
prev[id] = float3(prev[id].xy, temp);
```

▲AdvectDensity 当isDensityOnly = true，这个kernel的RT参数并没有被赋值，作者的C#脚本里有误。 ▲Draw 绘制 `solver[id] = float4(velocity[id].xy, density[id], 1);` 只有SolverTex的Z通道会对最终效果产生影响。 当isDensityOnly = true，只有一次有效的操作：DiffuseDensity(模糊)。 在DiffuseDensity的效率非常差的模糊下，强度会缓慢降低。

# isDensityOnly = false

isDensityOnly未勾选时，墨迹具有流动属性，向浓度高的地方速度递减并变淡。 ▲AddSourceVelocity 当isDensityOnly = false，SorceTex != null时，这是第一个kernel。

```
velocity[id] += source[id].xy * velocityCoef * dt;
prev[id] = float3(source[id].xy * velocityCoef * dt, prev[id].z);
```

向velocityTex的XY通道和prevTex的Z通道中写入速度强度。 ▲DiffuseVelocity 类似于DiffuseDensity，对velocityTex的XY通道分别进行模糊。 diff和visc作为这部分计算中的一个系数，作用并不明显。 没有对速度场进行模糊的必要性，可关闭这个kernel。 ▲ProjectStep1 `velocity[int2(id.x + 1, id.y)].x - velocity[int2(id.x - 1, id.y)].x` `velocity[int2(id.x, id.y + 1)].y - velocity[int2(id.x, id.y - 1)].y` 分别计算了像素位置上，X轴和Y轴流入-流出速度差，两者分别除以RT宽高，再相加，乘以-0.5。 速度向量的XY分量可能为负，上述2个计算结果可能正负相反，不确定代码逻辑正确性。 将结果保存在prevTex的Y通道，不能完整表示流体的压强；prevTex的X通道强制为0。 ▲ProjectStep2 `prev[id].y + prev[uint2(id.x - 1, id.y)].x + prev[uint2(id.x + 1, id.y)].x + prev[uint2(id.x, id.y - 1)].x + prev[uint2(id.x, id.y + 1)].x` 将一个像素周围4个点的X值和自身的Y值相加，由于ProjectStep1可知X通道值为0； velocity没有赋值，所以这个kernel的代码运行应该有误。 ▲ProjectStep3 看代码意图可能是：通过prevTex上的入口/出口速度差设置当前像素的速度值。 不过，这部分代码似乎没有正常工作，完全注释这3个Project kernel也看不出变化。 ▲SwapVelocity 设置prevTex的XY通道保存velocityTex的值 这个设置看似是为下一步AdvectVelocity准备的。 ▲AdvectVelocity 速度场流动 贴图变量没有正确设置，运行有误，可忽略执行。 看代码似乎是想根据prevTex的XY通道来修正velocityTex的值。 ▲AdvectDensity 密度场流动

```
int ddx0, ddx1, ddy0, ddy1;
float x, y, s0, t0, s1, t1, dfdt;

dfdt = dt * (w + h) * 0.5;

x = (float)id.x - dfdt * velocity[id].x;
y = (float)id.y - dfdt * velocity[id].y;
clamp(x, 0.5, w + 0.5);
clamp(y, 0.5, h + 0.5);

ddx0 = floor(x);
ddx1 = ddx0 + 1;
ddy0 = floor(y);
ddy1 = ddy0 + 1;

s1 = x - ddx0;
s0 = 1.0 - s1;
t1 = y - ddy0;
t0 = 1.0 - t1;

density[id] = s0 * (t0 * prev[int2(ddx0, ddy0)].z + t1 * prev[int2(ddx0, ddy1)].z) +
              s1 * (t0 * prev[int2(ddx1, ddy0)].z + t1 * prev[int2(ddx1, ddy1)].z);
```

velocityTex的初始值来源于单位速度向量与0-1之间的强度相乘，所以其XY分量都在-1~1之间； 且XY分量的正负对应着移动方向； Time.deltaTime默认是1/60；对于1136X640的屏幕，**dfdt**的值相当于14.8； x和y描述一个特殊的位置P，其与当前像素在XY轴上相距在14.8个像素内； 假设，鼠标位置为O，当鼠标在屏幕上往上滑时，速度为(0，1)，速度值根据衰减公式在O点周围递减。 当前计算的像素为K点，K点与O点重合时，O点与P点之间的距离最大化，**P总是在鼠标方向的反方向上**； 在速度值已经递减到为0的区域(超过了墨迹宽度)，速度衰减为0，那就有： x = (float)id.x，y = (float)id.y； ddx0、ddx1、ddy0、ddy1这4个值搭配得到的4个坐标，对应着4个组成品字形的像素。 这4个像素的相对位置可参考上述的P点，实际运行工程时我们可以发现： 鼠标前进方向上总是以前出现一块黑色区域，这个区域的宽度差不多就是14.8像素。 s1、s0、t1、t0作为四个像素的系数这一点不太好理解； 虽然s1 + s0 = 1， t1 + t0 = 1； 但是实际上这样混合起来会把某一个像素的影响放大很多倍。 比如速度为(0, 1)，K点与0点重合时： s1 = 0， s0 = 1, t1 = 14.8, t0 = -13.8； 最终的强度值的计算就变得不好理解起来了，可能会造成意外的效果。 为什么可以形成流动的效果： 因为速度值依然残留在每个像素上(velocityTex)，即使临时放开了鼠标，墨迹也会向残留速度方向移动。 ▲总结 到此本篇内容解说完毕。 作者的代码似乎不是最终版本，不过并不妨碍我们理解主要思路。 核心代码是DiffuseDensity(模糊)和AdvectDensity(流动)这两个kernel。 欢迎加入我的图形编程QQ群：779257833