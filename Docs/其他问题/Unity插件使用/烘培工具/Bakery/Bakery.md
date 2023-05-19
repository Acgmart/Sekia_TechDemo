# Bakery烘培工具
商店链接：https://assetstore.unity.com/packages/tools/level-design/bakery-gpu-lightmapper-122218  
市面上有很多烘培工具如Enlighten、渐进式烘培、Bakery等。  
我希望对比这些工具，来了解他们的限制、优点等差别。  

# BakeryManual
先从官方自带的文档开始，也就是插件包自带的pdf文档中的内容。  
1.显卡方面，Bakery只支持N卡。  
2.烘培步骤：标记静态物体、展UV2、挂Bakery光源组件、添加Skylight、Render  
3.渲染设置：  
渲染设置是逐场景保存的，且全部在Bakery -> Render Lightmap菜单中。  
有Simple/Advanced/Experimental三种复杂度的设置界面，主要是面向初学者的。  
Render Mode选择：Full Lighting/Indirect/Shadowmask...  
    我们需要结合业务需求来选择Render Mode(烘培模式)。  
    如果是pbr光照，需要用直接光呈现细腻的法线和高光效果，则不需要烘培直接光。  
    如果是无光照，使用Full Lighting模式烘培出完整光照结果也非常棒。  
    实际业务可能非常复杂，比如场景中只存在1栈实时光其余都是烘培光。  
        实时光用于交互、烘培光用于环境氛围。  
    Shadowmask模式则是出于性能考虑，可以减少需要实时绘制的阴影物体数量。  
        静态物体采样自身的烘培阴影。会出现与实时物体交互时阴影遮挡问题。  
    Subtractive模式基于优化阴影渲染的考量，静态物体受到实时物体投影。  
        在Lightmap里减去实时阴影衰减，复原出来的阴影着色会有问题。  
    AmbientOcclutionOnly：逐物体高精度AO，做实时光照时突出轮廓。  
        实时后处理AO的清晰度太低了，只能简单满足多物体之间的遮蔽交互。  
        间接光照需要AO解决暗部漏光的问题。  
        BentNormal

# 问题
1.UV出现overlapping  
理论非连续平滑的三角形不连续UV，整个模型将被划分为很多个UV孤岛。  
UV重叠是因为自动展UV时出错，可调整展UV的参数重新展UV。  