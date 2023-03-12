---
title: UGP1-8 MCMC
categories:
- [渲染, 效果表现, UGP]
date: 2020-01-12 20:52:05
---

\[toc\]本篇讨论UnityGraphicsPrograming第一册第八章内容 MCMC。 ▲概率相关的基础知识 在理解MCMC理论之前，需要先掌握概率相关的基础内容。(可以考虑B站上随便看看视频) 本篇中，需要掌握的概念不多，以下4个，并不需要似然函数(likelihood function)和概率密度模型(probability density function)。 1.随机变量 2.概率过程 3.概率分布 4.平稳分布 ▲随机变量 例如骰子(tou zi)有6个面，出现点数5的概率为1/6。 此时，“出现点数5”是随机变量，1/6是概率。 概率变量X的所有可能性的集合为Ω(大写的omega)，其中某个成员为ω(小写的omega)。 如果所有的成员都满足概率公式X = P(ω)，那么概率公式就成立了。 ▲概率过程 概率过程需要概率公式同时满足时间条件。 X = P(ω, t) ▲概率分布 概率分布用于表示随机变量ω与概率P(ω)之间的对应关系。 根据随机变量所属类型的不同，概率分布取不同的表现形式。 通常用ω表示横轴，P(ω)表示纵轴。 ▲平稳分布 ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/render/present/ugp/003.png) 平稳是一种特殊的概率分布方式，要求满足随着时间的变化(转移概率矩阵)概率分布趋向固定值。 可参考“LDA数学八卦”中，关于收入阶层迭代的演算案例。 ▲Monte Carlo Monte Carlo法是在概率分布中，对随机概率变量采样。 例如，求圆周率，在1X1的正方形中，存在半径为0.5的圆。 float pi; float trial = 10000; float count = 0; for(int i = 0; i<trial; ++i) { float x = Random.value; float y = Random.value; if(x \* x + y \* y <= 1) count++; } pi = (count / trial) / 0.5²; // S = πr² 在本例中，x和y是0-1内的随机变量，通过增加实验次数，判断点落在圆内的概率，得到圆的面积。 当图形的形状变得非常不规律，比如蝙蝠型，也可以用类似的办法求形状的面积。 ▲Markov chain Markov chain也就是平稳分布，概率过程的将来状态只与现在的状态有关，与过去的状态无关。 ▲MCMC(Monte Carlo Markov chain) MCMC是在稳定分布中，对随机变量采样。 1.分布不能由多个分开的部分构成。概率分布上的点在迁移时不能有无法到达的点。 2.转移概率矩阵可逆 满足这2个条件时，从任意分布向指定的稳定分布收束。 ▲Metropolis ▲三次元采样

```
void Prepare()
{
    var sn = new SimplexNoiseGenerator();
    for (int x = 0; x < lEdge; x++)
        for (int y = 0; y < lEdge; y++)
            for (int z = 0; z < lEdge; z++)
            {
                var i = x + lEdge * y + lEdge * lEdge * z;
                var val = sn.noise(x, y, z);
                data[i] = new Vector4(x, y, z, val);
            }
}
```

这里，我们创建了一个概率分布，随机变量为x、y、z，一共有lEdge \* lEdge \* lEdge种可能性，每种可能性的对应值都保存在data里面。该分布使用SimplexNoise，这是一种3D标量场。 MCMC相关的方法定义在Metropolis3d类中。 ▲Metropolis3d自构 简单赋值了Data和Scale，构成了初始的任意分布。 ▲Chain 这里用到了Unity中的协程功能StartCoroutine和yield return。 在协程中需要明确逻辑的执行先后顺序，简单的说： yield return之前的句子立刻执行，yield return后面的内容根据线程等待关系顺序执行。 携程中开启新协程的yield return后面的内容会优先于上一级协程执行。

```csharp
IEnumerator Generate()
{
    for (int i = 0; i < loop; i++)
    {
        //同步部分
        int rand = (int)Mathf.Floor(Random.value * prefabArr.Length);
        var prefab = prefabArr[rand]; //随机取一个Cube
        yield return new WaitForSeconds(0.1f); //每过0.1秒开启一个新协程
        //异步部分
        foreach (var pos in metropolis.Chain(nInitialize, nlimit, threshold))
        {
            Instantiate(prefab, pos, Quaternion.identity); //在场景中指定位置添加Cube
        }
    }
}

public IEnumerable<Vector3> Chain(int nInitialize, int limit, float threshold)
{
    Reset();

    for (var i = 0; i < nInitialize; i++)
        Next(threshold);

    for (var i = 0; i < limit; i++)
    {
        yield return _curr; //每次调用返回一个值
        Next(threshold);
    }
}
```

下一个协程会等0.1秒才开始执行，足够上一个协程执行完全部逻辑了。 我们可以把等待时间延长至2秒，可以清晰观察到每一波都会刷新出limit个Cube。 Chain方法中，每次yield return都会提供一个坐标，用于生成Cube。 ▲Reset 在Chain方法的开头执行Reset，提供初始分布。 \_curr的初始值为三维空间内任意一点，其xyz值为浮点数。 \_currDensity为通过Density方法，求任意一点对应的3D标量场值。 ▲Next 一次迭代，GenerateRandomPointStandard提供一个随机方向用于\_curr位移。 如果新坐标处的3D标量场值满足条件则更换\_curr位置。 nInitialize表示协程已尝试进行nInitialize次迭代。 根据前面的解释，如果分布满足平稳分布，则结果将收束到固定值。 每次协程都Reset+迭代nInitialize次，再返回limit个稳定值。 总结： MCMC连锁的迭代中，每次迭代都小幅度随机移动的话，就可以实现3D空间相邻处连续采样。 可用于植物、花的群体生成。