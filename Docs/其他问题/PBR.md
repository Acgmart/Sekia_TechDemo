参考文章：
多篇关于PBR的综合性解释：https://blog.selfshadow.com/publications/s2013-shading-course/
OpenGL环境光照的实践：https://learnopengl.com/PBR/IBL/Specular-IBL
Unity PBR实践：https://zhuanlan.zhihu.com/p/272553650
彻底看懂PBR/BRDF方程：https://zhuanlan.zhihu.com/p/158025828

# 漫反射
出射亮度 = c/π
出射亮度的单位为辐亮度
    表示单位面积和单位立体角上的辐通量L 单位是W/(m² * sr)
    W单位时间传输的能量
    m²是单位面积 sr是立体角 描述了圆锥形三维观察角度张开的程度
    辐亮度对亮度的描述限制非常多 用于描述人眼感知亮度
    漫反射将辐照度转化为辐亮度 辐照度单位是W/m²

# 镜面反色
出射亮度 = 入射亮度 * BRDF(反射比例) * 入射角带来的入射光衰减(NdotL)
    这里的BDRF中D项类似于漫反射中的1/π 承担了将辐照度转换为辐亮度的职责

# F项
F(l, h)：光被镜面反射的比例 与光源和法线的角度有关(AngleNL)
    AngleNL在0~45°几乎不变化 45~75°缓慢变化 75~90°快速增长到1
    对于环境光镜面反射
        F_envir = lerp(_F0, 1, pow(1 - _NdotL, 5));
    对于直接光镜面反射的微表面BRDF H才是概念上的法线 仅H与N对齐时高光可见
        LdotH与VdotH数值相同 需要与整个BRDF公式一起调试
        F_direct = lerp(_F0, 1, pow(1 - _HdotL, 5));
        或
        F_direct = lerp(_F0, 1, pow(1 - _HdotV, 5));
# D项
D(h): 正态分布函数D 决定高光的形状和大小 N与H的对齐率
    粗糙度为1时高光完全平均分布返回值为1/π
    粗糙度为0时高光收束于一点 峰值为1/(π * a^2)
    不同的D方法在高光尾长上有区别 GTR1 GTR2
# G项
G(l, v, h)：微表面因为法线和粗糙度自我遮蔽现象
    入射和反射光线都可能被遮蔽
    如果省略G项
# 分母项
    分母项也就是BRDF中的分母部分：1 / (4 * NdotV * NdotL)
    这一项通常被合并在G项 表现为：
        ggx1 = k + (1.0 - k) * _NdotV;
        ggx2 = k + (1.0 - k) * _NdotL;
        _G = 0.25 / (ggx1 * ggx2);
    参考完整的BRDF推导：
        https://hal.inria.fr/hal-00942452v2/document
        3.3节 the Jacobian of reflection transformation
    可以简单理解为积分发生在一个圆锥体(微小的可见表面) 而FDG三项发生在理论平面
        分母项描述了光在圆锥体的可见性

# 环境光照
由于反射是通过积分完成的 对于一个点V和N是固定的 但是L和H有无数个
    直接光照和环境光照的区别是直接光照用的是理论光源
    环境的反射是复杂的 实时渲染无法无限模拟光源反弹

辐照度贴图与GI与反射探针
    辐照度贴图模拟环境漫反射光源
        反射角度均匀分布在以法线为中心的半球 通过大量离散采样入射光源取平均值
        类似于模糊后的反射探针
        辐照度贴图不支持角色移动 => 在环境中布置LightProbe使用球谐光照
镜面反射拆解： part1 为入射亮度 part2 为BRDF与NdotL
    将part1预计算为环境贴图
        Cube有多层mip模拟粗糙度 Trilinear过滤
        反射角度主要围绕V的反射角(R)分布 越平滑分布越集中
            基于D项(参考D项的定义) 随机扰动H得到随机的反射角度 进行重要性采样
    将part2使用Lut或拟合曲线替代
        part2与N、L、V、粗糙度、F0等有关 L通过重要性采样解决
            因子太多 需要继续简化变量
        重要性采样
            类似于与part1的重要性采样 生成随机H和入射光源L
            用NdotV和粗糙度作为输入 分别计算scaleFactor和offsetFactor的均值
            环境G和直接光G的k值不一样 这里的a是指近似粗糙度
                k_direct = (_PerceptualRoughness + 1)^2 / 8;
                k_envir = _PerceptualRoughness^2 / 2;
            pdf 概率密度函数 特定样本在整个样本集中出现的概率
            在重要性采样中pdf可以抵消很多BRDF计算 _LightColor固定为1
                IncidentLight = _LightColor * _NdotL;
                MicrofacetSpecular = _D * _G * _F / (4 * _NdotL * _NdotV);
                pdf = _D * _NdotH / (4 * _HdotV);
                part2 = IncidentLight * MicrofacetSpecular / pdf;
                                = _G * _F * _HdotV / (_NdotH * NdotV);
                SpecularLighting = {part2 + part2 + part2....} / NumSamples;
        将F0移出BRDF 并生成Lut：
            part2 = _G * _F * _HdotV / (_NdotH * NdotV);
            part2 = (_F0 + (1- _F0)(1 - _HdotV)^5) * _G * _HdotV / (_NdotH * NdotV);
            将(1 - _HdotV)^5简化为α  将公式转换为 _F0 * scaleFactor + offsetFactor 的形式
            part2 = (_F0 * (1 - α) + α) * _G * _HdotV / (_NdotH * NdotV);
            scaleFactor = (1 - α) * _G * _HdotV / (_NdotH * NdotV);
            offsetFactor = α * _G * _HdotV / (_NdotH * NdotV);
            随机采样用的H和L都是通过指定_NdotV和粗糙度得到的 并且part2可以表示为F0的缩放偏移
            将scaleFactor和offsetFactor的平均值写入Lut贴图后：
            part2 = _F0 * Lut.x + Lut.y;
            SpecularLighting = part1 * part2;
        使用拟合曲线替代part2的Lut
            part2 = EnvBRDFApprox(_F0, _PerceptualRoughness, _NdotV);

# 在直接光镜面反射中使用环境光镜面反射的part2
直接光和环境光的镜面反射差距有点大
1.环境光镜面反射是积分的 而直接光镜面反射是理论光源无需积分
2.F项定义差异 环境光用_NdotL 直接光用_HdotV
3.G项定义差异 系数k不同
那么环境光镜面反射part2能否在实时渲染中用于直接光镜面反射呢
    参考预制体testBRDF 结合多种BRDF对比效果差异
    有D项在时可控制高光半点大小和高光尾长
    FG项控制边缘光和高光不可见处的衰减
    builtin Lit、URP Lit、Disney BRDF差异不大 效果都能接受
    直接使用_D * part2时：
        粗糙的物体相对前面3种BRDF太暗需要补亮度
        高光衰减加快 无法完全平衡整体亮度-光斑大小-衰减曲线 但是可以近似
        从经验角度可以使用系数：b = _PerceptualRoughness * 0.25 + 0.25;
            粗糙度系数为0.25时可以保持光斑大小 但是因为衰减太快 越粗糙的物体越暗
            将粗糙度系数提升至0.5 虽然可以提升粗糙物体亮度 但是光斑大小明显变化

# 移动端特殊处理
近似粗糙度的最小值 参考UE4移动端为0.12：
    _PerceptualRoughness = clamp(_PerceptualRoughness, 0.12, 1.0);
    当_NdotH等于1 高光强度最大 _D = a2 / (a2 * a2);
    为了防止_D的数值溢出half的最大值 1 / a2 应小于65504
        理论近似粗糙度应大于0.0625
    PBR数值参考
        https://docs.unrealengine.com/5.0/en-US/physically-based-materials-in-unreal-engine/#roughness

移动端GGX：
    解决移动端精度不足：1- _NdotH * _NdotH
        https://zhuanlan.zhihu.com/p/146705815
        https://google.github.io/filament/Filament.md.html#listing_speculard
        half精度下产生floating point cancellation
        大数相减后差值过小 与float下产生20%以上的精度偏差
        或者大数求导数 使结果非常接近0 偏差与float下过大


