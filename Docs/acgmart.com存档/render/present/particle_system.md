---
title: Unity粒子系统
categories:
- [渲染, 效果表现]
date: 2020-07-13 17:10:58
cover: https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/render/present/032.png
---

\[toc\]本篇总结Unity中的CPU特效。

# CPU特效和GPU特效

熟悉渲染管线后，我们会知道，在vertex阶段之前要传入表面数据； 在Vert方法里，可以移动顶点，制作顶点动画； 在Geometry方法里，可以基于代码逻辑重构顶点列表； 在Frag方法里，可以修改颜色输出，产生颜色外观变化。 什么是效果和特效(特殊效果) 一个可以描述的简单过程，游戏中由海量的效果组成。 特效则是所有效果中最吸睛的那些，山崩地裂、光影交加。 根据最基础的理论，可以拓展出很多效果实现思路： 思路一：2D序列帧 渲染长方形，通过高频率切换贴图，实现动画(主视图)； 比如：静态图片、2D人物行走序列帧。 思路二：3D序列帧 在3D渲染中，可使用自由视角观察物体； 制作`2D序列帧`的360度版本，每间隔5度就提供一帧图片； 可水平旋转任意角度观察，实现立体感。 思路三：全视角序列帧 有些游戏有地势差或飞行道具，可以实现俯视/仰视效果； 为了不露馅，只能根据垂直角度，每间隔5度，提供一组图片。 思路四：形态变化-模型 使用图片作为内容主体的时代渐渐过去了，人们开始追求更丰富的变化； 运行时需要随时更换装备、改变异常状态，需要通过shader进行实时计算。 但是，很多状态变化很小的游戏元素，依然广泛使用2D方式表现。 思路四扩展：轨迹变化-粒子 将大量的小mesh，以一定的轨迹射出去，持续一段时间后销毁； 在喷射的过程中，再附带大小、速度、颜色等变化，再附带碰撞检测； 粒子效果可以为技能提供很多细节，比如火球术、治愈术。 思路五：流体 很多物体都难以用固定的形态简单模拟，比如水、风、火、电、布... 如果这些元素，在场景中的的形态相对固定，可以从简实现； 但如果要大水漫灌、火灾现场、呼风唤雨、现场脱衣... CPU or GUP ? 严格上来说，CPU提交draw call，GPU进行绘制，少了谁都不行； 这里主要看计算量的分配，实现CPU/GPU的负载均衡； 如果CPU光是提交draw call都忙的要死，那么GPU就很闲； 如果CPU要等待GPU返回的计算结果，那么线程就卡顿。 比如说，Unity的Particle System，是CPU特效： CPU花了很多精力计算轨迹和表面参数，但是GPU不需要额外算什么； 与CPU相对的则是GPU特效，主要表现在用GPU完成成吨的计算。 本篇中将要介绍的就是CPU特效部分。

# 2019.4 粒子系统详解

Timeline很适合用于解说大型叙事结构，比如技能编辑器、粒子特效。 每个粒子组件可以理解为一个Timeline(简称TL)实例，那么就需要指定TL的长度，为TL添加随机数量的Track，每个Track上包含多个动画Clip用于记录粒子在每一帧中的参数，后续设置分别针对TL、Track、Clip。 lifetime PO的发射器的lifetime，也就是Duration参数，定义一次循环的长度； PO的lifetime，也就是Start Lifetime参数，定义PO出生后的剩余存在时间； 我们在表现粒子多样性时，会针对Duration周期、粒子生命周期添加随机性。 Clip代表粒子组件发射一次粒子，在Track上连续排列： 所有Clip字段结构都一样，共享运动逻辑，对于单个字段： A.字段值完全不统一，如起始播放时间和结束时间； B.字段值统一，且是固定值； C.字段值统一，使用曲线，横轴对应lifetime，纵轴对应固定值； D.字段值不统一，在两个固定值之间随机； E.字段值不统一，使用双曲线，横轴对应lifetime，纵轴在两个固定值之间随机； 粒子组件(Particle System Component，PSC) 附着在一个GameObject上，也就是我们常用的Prefab； 可能还包含着多个子级GameObjetc，上面也有粒子组件。 粒子物体(Particle Object，PO) 使用GPU instancing批量复制出来的mesh实例，用于作为粒子发射； 不出现在Hierarchy，但是需要计算o2w矩阵作为shader计算的输入； 发射器(发射点/线/面) 用PSC的Transform来表示这个抽象单位的位置； 模块(Modules) 一个粒子组件可以开启多个模块，每个模块表示一种功能；

## Particle Effect面板

在Scene视图，可以看到Particle Effect面板； Play/Restart/Stop： Playback Speed：TL的实时播放速度 受到TimeScale影响 Playback Time(PT)：TL的实时播放进度 Particles:当前TL中的Track数量 Speed Range：不同粒子之间的速度波动范围 Simulate Layers：显示哪些Layer的粒子效果(包含选中项) Resimulate：修改后重新播放 Show Bounds：显示粒子的包围盒 Show Only Selected：仅显示选中项的包围盒

## 主模块(Main)

在GameObject的Inspector上可以观察Particle System组件面板； Duration：TL的播放长度，超时后不再向Track添加新的Clip； Looping：PT持续前进，每经过Duration时间重置部分逻辑； Prewarm：PT快进到PO上限，避免粒子从无到有的初期过程； StartDelay：B/D，TL的初始播放延迟； StartLifetime：B/C/D/E，Clip的长度； StartSpeed：B/C/D/E，初始速度(会受到速度组件提供的xyz增量)； 初始方向(不可设置)：本地Z轴方向； 3DStartSize：B/C/D/E，初始xyz缩放； StartSize：B/C/D/E，初始统一缩放； 3DStartRotation：B/C/D/E，初始xyz旋转(绕正轴逆时针)； StartRotation：B/C/D/E，初始z旋转； Flip Rotation：C，顺时针旋转的比例(0-1)； StartColor：B/C/D/E，顶点颜色； GravityModifier：重力系数，0表示关闭重力； SimulationSpace：设置PO的Transform父级，World(无)/Local/Custom； SimulationSpeed：PT的移动速度系数； DeltaTime：是否受到Time Scale影响； ScalingMode：PO的缩放因素(Transform链)，Local(仅自身)/Hierarchy/Shape(无)； PlayOnAwake：PSC是否在Awake时播放TL； **EmitterVelocity**：如何计算PO的实时速度，Rigidbody/Transform； MaxParticles：Track数量； AutonRandomSeed：播放时重置随机种子，生成不重复的粒子效果； Stop Action：TL被停止或播放结束时的行为，Disable/Destroy/Callback; Culling Mode：被相机不可见时的更新行为； RingBufferMode：Clip播放结束后，PO的回收方式；

## 发射模块(Emission)

控制发射粒子的时机与发射数量。 RateOverTime：B/C，每秒自动发射多少粒子； RateOverDistance：B/C，每移动一个Unit，发射多少粒子； **Bursts-爆发** 在Duration时间，按照一定周期发射数波粒子，开启Looping会不断重置Duration； Time：B，从第几秒开始。 Count：B/C，每波的发射量； Cycles：在Duration时间内尝试多少次爆发； Interval：Cycle之间的时间间隔，秒； Probability：每次Cycle时，成功发射粒子的概率；失败不发射，成功发射Count个；

## 形状模块(Shape)

自定义PO的生成范围(发射面)和初始角度； 生成范围可以是点、线、面的组合(程序化mesh)，有一定的规律； 将PO的发射速率、总发射量、发射位置规律协调控制，形成一定美感。 测试这部分参数时，应关闭速度模块。 Shape：发射面的基础形状，后续有很多选项细调生成范围； - Sphere：球体 - HemiSphere：半球体 - Cone：圆锥体，有发射角度变化的椭圆面； - Donut：由4个单环构成环状体； - Box：长方体，可用边、面、体积进行发射； - Mesh：网格发射器，可用顶点、边、三角面进行发射； - Circle：单个环形； - Edge：线段； - Rectangle：长方形 - 遮罩纹理专用，比如图片上散发出来的气味； ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/render/present/024.png) Angle：修正初始方向(Z轴)，提供发射角度的xy轴分量； Radius：发射面的半径，PO在面上随机点生成； Rdius Thinkness：发射面的半径的有效比例，0表示仅外边缘有效； Arc：以发射面的一定弧度范围作为指挥棒的移动范围，圆的外圈的一截； 指挥棒：抽象单位，用于表现有效半径。 - Mode：定义每一帧中范围的移动和选择规律 - - Random：PO以随机多个半径为有效范围； - - Loop：PO以指挥棒为半径，指挥棒沿着Arc逆时针旋转； - - Ping-Pong：Loop的来回运动形式； - - Burst Spread：？？ - Spread：提供半径数组，0表示不切割(全半径)；非0则将Arc按比例切割； - Speed：指挥棒围绕弧度转一圈所需的秒数。 Texture：将发射面上的坐标转化为UV采样贴图，设置为顶点色并进行剔除； Clip Channel/Clip Threshold：用贴图的某个通道进行剔除，形成遮罩； Color/Alpha affect particle：顶点色如何应用采样结果； Bilinear Filtering：采样贴图的方式是单线性还是双线性； Position/Rotation/Sacle：为发射面提供位移、旋转、缩放； Align To Direction：Angle提供的方向是否影响PO的旋转； Randomize Direction：PO使用随机初始方向的概率(效果不明)； Spherize Direction：使PO的初始方向朝向发射面的中心(半径的角度)； Randomize Position：PO的Z初始坐标提供随机加值；

## 速度模块(Velovity over Lifetime)

对于效果整体来说，要表达一个相对移动的概念； 比如PSC在人物的手腕上，发射器随手腕移动，PO使用世界坐标系； 如果PO需要与手腕保持相对距离，那么PO使用本地坐标系。 使用本组件后，单个粒子依然保持匀速运动，可实现相对位移和旋转效果。 Linear：B/C/D/E，初始速度的xyz速度增量； Space：这部分速度增量对应的空间，Local/World； Orbital：B/C/D/E，PO绕本地的xyz轴的旋转速度； Offset：B/C/D/E，旋转中心点，默认xyz轴(0, 0, 0)； radial：B/C/D/E，离心力，向旋转中心点的反方向移动一段距离； Speed Modifier：B/C/D/E，实时速度修正系数

## 速度限制模块(Limit Velocity over Lifetime)

这个模块控制PO在何种情况下会减速； 适合用于模拟空气阻力，如爆炸、烟花。 Separate Axes：速度限制将根据xyz轴分量差别对待 - Space：分轴的限制针对是是哪个空间的速度，Local/World。 Speed：设置速度阀值； - Dampen：超过阀值的量需要每帧衰减多少比例； Drag：速度的自动衰减系数，每帧衰减多少比例速度，直到0； - Multiply by size：自动衰减量与尺寸有关，变大时加速衰减； - Multiply by Velocity：自动衰减量与实时速度有关；

## 速度继承模块(Inherit Velocity)

这个组件用于模拟从一个移动的物体发射粒子； 比如用手抛花，花的初始速度是由手提供的(而不是固定速度)； 要求模拟空间设置为World。 Mode：发射器实时速度对PO速度的影响； - Initial：初始速度得到增量，值为发射器的实时速度； - Current：每一帧的速度都得到增量，值为发射器的实时速度； Multiple：PO速度在接受本增量时的系数。

## 动能模块(Force over Lifetime)

XYZ：每帧在各分量上提供的加速度； Space：加速度将被应用于哪个空间，Local/World； Randomize：开启后，所有PO每帧接收统一的随机加速度；

## 颜色模块(Color over Lifetime)

随着时间的推移，粒子的颜色会发生变化。 当粒子(火花、烟火和烟尘)达到使用寿命时消散是非常普遍的。

## 颜色-速度模块(Color by speed)

根据实时速度改变颜色衰减，比如让跑的快的PO更亮； 用于模拟在空气中燃烧的粒子，速度越快燃烧越剧烈。

## 大小模块(Size over Lifetime)

使Clip在播放过程中，根据线性时间改变缩放率； 比如刚生成时很小，之后急剧变大。

## 大小-速度模块(Size by Speed)

大小与实时速度建立映射关系。 在爆炸中，小的物体初始速度更快 - 初始速度更快的PO更小； 要注意其他影响实时速度的因素，如加速度/阻力。

## 旋转模块(Rotation over Lifetime)

粒子获得固定的角速度，围绕自身模型空间xyz轴旋转。 比如爆炸碎片、落叶； 旋转有助于破坏粒子之间的相似性。

## 旋转-速度模块(Rotation by speed)

旋转速度与实时速度建立映射关系； 比如模拟粒子在地面滚动。

## 风场(External Forces)

影响场景中部分的Particle System Force Field组件； 风场定义一个空间范围，进入的粒子会受到额外的加速度影响； 加速度足够时，可以把粒子吹走。 Multiplier：受到的额外力的系数； Influence Filter：指定会受到哪些风场的影响；

## 噪音(Noise)

采样Perlin噪声，为粒子添加实时变化的随机位移/旋转； float back = Mathf.PerlinNoise(x, y); 输入值xy和返回值back都在0至1范围内，可能有浮点数误差； 高度：噪声图表面的采样值，理解为0至1范围内的高度图； 偏移量：将采样值转换到-1至1范围，低于0意味着负向移动。 Separate Axes：xyz分别计算； Strength：偏移量的系数，定义飘动的速度(Unit/s)； Frequency：噪声图的xy缩放系数，定义飘动的频率； 注：缩放为1时噪声图表面有多个波峰，调至0.01左右才比较平缓； Scroll speed：对噪声图的表面高度进行周期性偏移，指定偏移速度； 注：每秒损失一定高度，低于0后+1，形成循环；使结果不可预测。 Damping：Preview窗口中，是否显示强度对贴图的影响； Octaves：最终噪声？？由多个layer的噪声图叠加而成； Octave multiplier：额外layer的Strength； Octave scale：额外layer的Frequency。 Quality：噪声的维度，1D/2D/3D; Remap：噪声值在0至1范围内重映射； 控制noise对位置、旋转、缩放的影响： Position Amount：坐标影响系数； Rotation Amount：旋转影响系数(degree/s)； Size Amount：缩放影响系数；

## 碰撞模块(Collision)

Type：如何进行碰撞检测，Planes/World。 - Planes：在场景中创建用于反弹的面，不需要Colider组件； - Visualization：编辑模式下碰撞体的显示方式，不影响检测； - Scale plane：plane的缩放率，不影响检测； - Dampen：反弹后，将速度的反弹方向的分量进行反向并衰减，1表示完全衰减； - Bounce：面的弹力系数，乘以Dampen之后得到速度系数，0表示不反弹，2表示弹力很强； - LifetimeLose：碰撞后损失剩余的存在时间比例； - Min Kill Speed：PO实时速度低于阀值时，触发碰撞后直接消失； - Max Kill Speed：PO实时速度高于阀值时，触发碰撞后直接消失； - Radius Scale：缩放PO的bounds - Send Collision Message:发送碰撞信息 - VisualizeBounds：显示PO的bounds线框；

*   World：和世界空间中的碰撞体进行检测；
*   Mode：基于3D空间还是2D空间，一般是3D；
*   Collision Quality：碰撞精度，高/中/低；
*   Max Collision Shapes：最大与多少个Collider进行测试；
*   Enable Dynamic Colliders：是否与非static的Collider进行测试；
*   Collider Force：向Collider施加力，用于推走Collider；

## 触发器模块(Triggers)

类似于碰撞模块，但是并不反弹PO，中处理检测逻辑； Colliders：指定有效的Collider列表； Inside/Outside：根据位置状态触发逻辑 Enter/Exit：根据进出Collider事件触发逻辑；

*   Ignore：忽略
*   Kill：销毁粒子
*   Callback：触发Mono脚本中的[OnParticleTrigger](https://docs.unity3d.com/Manual/PartSysTriggersModule.html#Example "OnParticleTrigger")方法；

## 子发射器模块(Sub Emitters)

在PO的某个阶段的实时位置生成另一个PO； 比如子弹离开枪管时可能伴随着一团烟雾，火球在撞击时会爆炸； 子发射器是场景中普通的PSC或者Prefab，可以有独立的发射器； Sub Emitters：子PO发射器列表，设置触发条件与子PO继承的属性； - Brith：父PO生成时，生成一个子PO发射器； 子PO发射器的位置：与父PO的实时位置相同，即跟随运动； 子PO发射器与正常PO的差异：子PO的发射器的position不受控制； 子PO发射器的死亡：父PO死亡时，强制终结子PO发射器； - Collision：根据爆发模式生成子PO，父PO发生碰撞时，重置子PO发射器的Duration； - Death：根据爆发模式生成子PO，父PO的Lifetime结束时，播放一次子PO发射器； - Trigger：根据爆发模式生成子PO，PO与标记为Trigger的Collider互动时； - Mannel：根据爆发模式生成子PO，通过脚本触发[ParticleSystem.TriggerSubEmitter](https://docs.unity3d.com/ScriptReference/ParticleSystem.TriggerSubEmitter.html "ParticleSystem.TriggerSubEmitter")； **关于使用Emission组件的爆发模式发射子PO**： 子PO发射器的爆发模式作为条件触发的发射机制，相当于父PO借用发射器-发射一波粒子； Bursts中的仅Count、Probability参数生效，无法延迟； Looping、StartDelay强制无效； Inherit：子PO可以继承父级的部分属性； Emit Probability：生成子PO的概率，0至1；

## 帧动画模块(TextureSheetAnimation)

在PO形成单个连续实体的情况下，帧动画使PO增加运动的印象。 Mode: 用序列帧/图片列表实现帧动画，Grid/Sprites(图集)； - Tiles：Grid的行列数； Animation：如何定义一个动画Clip； - WholeSheet：整个Grid是一个Clip，从左到右-从上到下播放； - SingleRow：每一行是一个Clip，从左到右播放； - - Row Mode：指定如何切换Clip，使用脚本/随机/根据submesh； Time Mode：播放模式，Lifetime/Speed/FPS； - FrameOverTime：根据经过Lifetime比例播放，匀速(N帧/s)或指定时间； - Speed Range：根据实时速度映射到0至1，用于切换帧播放； - FPS：每秒固定播放指定帧数； StartFrame：定义开始帧的index，非0时表示调整了Clip的帧序列； Cycles：PO生命周期内播放多少次； Affected UV Channels：指定哪些UV通道用于播放动画？？；

## 光源模块(Light)

PO生成时伴有光源组件，可向场景提供实时光照/阴影，有性能顾虑； 比如烟花、闪电，可以大范围低亮度的照亮周围环境。 Light：指定作为灯光模板的prefab； Ratio：PO在生成时，带有光源的比例； Random Distribution：光源的分布模式； - true：每次生成PO时根据Ratio随机给予； - flase：每间隔多少个PO，会有一个PO携带光源； Use Particle Color：使用粒子的实时顶点色作为光源颜色； Size Affects Intensity：光源的Range是否受到PO的缩放影响； RangeMultiplier：光源的Range系数； Maximum Lights：同时存在的实时光源的数量上限；

## 轨迹模块(Trailer)

为PO添加轨迹效果；与Trail Render组件类似，可以轻松附加到PO上并继承PO的部分属性； 如果使用Trails模块的话，必须在Renderer中给TrailMaterial赋值。 Mode：轨迹的生成模式； Particle：轨迹代表PO的移动路径； - Ratio：PO生成时带有轨迹的比例； - Lifetime：轨迹mesh上的顶点的存活时间，用PO的lifetime的系数表示； - MinimumVertexDistance：最短顶点距离； 轨迹紧跟着PO，且长度为PO的轨迹长度的一定比例(lifetime)； 当PO刚刚出生时，有一段时间轨迹是在变长的(逐帧更新)； 当轨迹达到最大长度，理论上应该每一帧更新mesh； 也就是说同一个PO，同一时间只存在一个轨迹在跟随运动； 实际上是轨迹mesh上的顶点有独立的生存时间； 当轨迹mesh更新频率不足时，轨迹开始出现闪烁BUG； 最短顶点距离 = 粒子生命 \* 粒子速度 \* 轨迹生命 - WorldSpace：轨迹mesh是否基于世界空间独立运动？？； - DieWithParticle：轨迹mesh随PO的销毁而销毁； Ribbon：轨迹链接下一个PO； - Ribbon Count：所有的PO按index顺序分成多个组用于组成Ribbon链； - Split Sub Emitter Ribbon：如果当前PO来自子发射器，仅链接同父级PO； - Attach Ribbons to Transform： TextureMode：轨迹mesh的uv模式； - Strtech：整个轨迹都在一个UV空间； - Tile：每次添加新顶点时，形成2个三角面； - DistributePerSegment：？？ - RepeatPerSegment；？？ 注：2个三角形(4个顶点)构成一个Segment；单位Segment长度作为Tile； SizeAffectsWidth：轨迹mesh的宽度是否受PO的缩放影响； SizeAffectsLifetime：PO的缩放影响轨迹的lifetime； InheritParticleColor：轨迹mesh的顶点颜色继承PO的顶点颜色； Color over Lifetime：轨迹mesh的顶点色变化映射到lifetime； WidthOverTrail：轨迹mesh的宽度系数； ColorOverTrail：轨迹mesh的顶点； Generate Lighting Data：生成法线和切线； Shadow Bias：？？

## 自定义数据模块(Custom Data)

为PO定义shader自定义数据，参考[Particle System vertex streams](https://docs.unity3d.com/Manual/PartSysCustomDataModule.html "Particle System vertex streams")； 可选的数据类型有Vector4、HDR Color； Custom1： Custom2：

## 渲染器模块(Renderer)

RenderMode：定义PO的渲染方式 Billboard：用Quad作为mesh； - Normal Direction：Quad表面法线的朝向，朝向相机/朝向Screen中间空间； - Min Particle Size：PO面积占视口比例低于阀值时，缩放到阀值； - Max Particle Size：PO面积占视口比例高于阀值时，缩放到阀值； - Allow Roll：是否跟随相机的Z旋转； StretchedBillboard：类似于Billboard，朝向相机，根据多种因素缩放； - Camera Scale：长度受相机速度的影响比例，0表示关闭效果； - Speed Scale：长度受PO速度的影响比例，0表示关闭效果； - Length Scale：长度是宽度(高度)的多少比例，0表示消失； HorizontalBillboard：类似于Billboard，面平行于世界空间xz平面且无旋转； VerticalBillboard：类似于Billboard，面平行于世界空间Y轴且面向相机； Mesh：用自定义mesh作为PO形态，需要mesh可读写； None：不渲染PO，仅轨迹； Material：用于渲染PO的mesh的材质； TrailMaterial：用于渲染轨迹mesh的材质，需要开启轨迹模块； SortMode：PO的渲染队列排序方式； SortingFudge：PO的渲染队列值偏移(透明队列)，值越小Queue越大 RenderAlignment：PO的朝向，o2w矩阵： - View：朝向Camera平面； - World：朝向世界空间的xyz轴 - Local：朝向PSC的transform - Facing：朝向Camera的GameObject？？； Flip：0至1比例，翻转x/y/z值； Enable Mesh GPU Instancing：批量渲染； https://docs.unity3d.com/Manual/PartSysInstancing.html Pivot：根据PO缩放？？偏移模型空间原点指定unit，影响旋转效果； Visualize Pivot：编辑器模式下显示锚点； Masking：定义PO如何与图片遮罩进行互动； Apply Active Color Space： Custom VertexStreams：是否[传递自定义数据给shader](https://docs.unity3d.com/Manual/PartSysCustomDataModule.html "传递自定义数据给shader")； Cast Shadows：投影模式，开/关/双面绘制阴影/仅渲染阴影； Receive Shadows：根据shader代码决定； Motion Vectors：关于运动模糊？ Sorting Layer ID：指定PO的layer； Order in Layer：PO在自身所在layer的优先级； Light Probes：探针混合模式； Reflection Probes：在shader中可访问反射贴图； Anchor Override：用于采样光照探针和反射探针的transform；

# Shader

# 描述图形元素：

近/远 疏/密 力的方向-丧失动能 高光点 额外细节：点/线 节奏：间隔 重复 节拍 对比(大小、色相、温度) 溶解：棱角变圆润 使用图片烘焙非实时角色：全角度/水平 云/爆炸 使用Houdini生成序列帧 写对应的动画Shader 竖向的UV偏移-映射到球形俯视图中的扩散效果

# 官方效果拆解

粒子束的速度，1个Unit是1米： 音速：340m/s 高速公路：25m/s 市内公路：15m/s 人平均跑步速度：5m/s 人平均行走速度：1.5m/s 粒子束的角度，以z轴为中心向周围倾斜一定角度： 小角度：0-30度 中角度：0-60度 广角度：0-90度 全角度：0-180度

## 火花 - Effects/Misc/SparksEffect

1.主要效果，向一个方向高速喷射大量细短的光线； lifetime：单个粒子生存时间较短，0.5秒左右随机； 速度：Z轴5m/s，相当于总共能跑2.5米左右； scale：使用轨迹来表现光线，缩放很小，参考值0.01； shader：材质中使用一个类似于子弹的透明贴图模拟光线； 光线有一定亮度，需要Bloom效果-控制shader输出； 轨迹：生命周期短，PO的0.1-0.2； 2.次要效果，有少量粒子发射失败-落向周围； shape：使用很小的半球形发射器，产生广泛的角度 由于角度分量由发射器提供，本次使用固定速度发射； 碰撞：可以与世界中的墙壁发生碰撞，反弹； 3.次要效果，有少量的粒子发射后会爆炸； 子粒子：PO死亡时一定概率播放子粒子-爆炸效果； 4.爆炸效果； 生存时间极短，0.1秒左右，非Loop，Burst发射一次10个； shape：使用很小的半球形发射器，产生广泛的角度； 控制轨迹长度：轨迹占生命周期的比例偏大，0.6-1；

## 悬浮的尘埃 - Effects/Misc/DustMotesEffect

1.主要效果，空间内随机大量点状PO，变淡消逝； lifetime：初始能见度不高，在生命结束前衰减变暗，存在5秒左右； 发射：粒子有相对固定的活动空间，使用Box发射器的体积； 根据空间大小发射PO，保持一定的PO密度； 缩放：PO的缩放很小，在远处几乎不可见，0.01-0.05随机缩放； 移动：尘埃在出生点附近随机缓慢平滑移动，使用Noise实现； 贴图：白色圆形的透明图片，由于不在意形态，使用Billboard实现；

## 熔岩化溶解 - Effects/Misc/Dissolve

1.主要效果，物体mesh表面熔岩化-燃烧-消失； shader：基于UV的消失效果使表面镂空，初始为正常双面渲染； 使用2D噪声贴图得到一个熔岩扩散的路径，Cutoff与时间形成映射； 燃烧：移动Cutoff，使表面分离为熔岩区和正常区；两个区域之间应该有一段高亮区域表示正在燃烧，有一定过渡效果；熔岩区内部使用透明测试剔除掉； 2.主要效果，物体脱落的碎片随风飘逝； 形状：形态各异的小碎片，使用和物体一样的渲染逻辑； 发射：以物体表面为起点向周围发射，提供全角度、离心运动； lifetime：1.5秒左右，TL为4秒，PO发射速率有曲线变化； 随机性：Noise随机移动，固定角速度，多个mesh多样化形态； 贴图：使用帧动画，随机播放某一帧，丰富外观样式； 3.次要效果，燃烧火星； 渲染方面类似于尘埃，在发射和运动方向上，类似于碎片； 使用Stretched Billboard，根据移动速度拉伸长度； 4.次要效果，燃烧烟雾； 渲染：使用Billboard，播放36帧的动画，模拟烟雾； 发射：类似于碎片，逐PO朝固定方向缓慢移动，缓慢放大；

## 能量重生 - Effects/Misc/Respawn

1.主要效果，纵轴滤波-逐渐显现出物体mesh； 使用特殊的noise贴图、UV缩放，使采样结果为花色横向纹路； 注：用(o, y \* 3)采样贴图的最左侧一列像素； Cutoff为UV的y值提供线性递增，使纹路向下移动； 类似于熔岩化溶解，使用1-Cutoff作为透明区和不透明区的分界线； 当Cutoff变大时，分界线值变低，露出更多表面范围直到正常显示； 过渡区域的划分：要求为纵向有差异的单色，不跟随Cutoff直接变化；如果使用noise贴图的R通道同时进行clip和用于过渡区的渐变，结果的区域划分会非常有规律：正常-过渡-透明-过渡-正常；如果使用RGB通道进行剔除，因为noise贴图的颜色丰富性，导致有更多的随机的剔除区域，不容易被看穿规律。 过渡区域颜色：当过渡区域因为Cutoff的变大，达到临界值时，采样值小于Cutoff，Edge为1，边界颜色增量，接着必定被剔除，所以边界在消失前会闪烁一下。 2.主要效果，龙卷风包裹物体，随着角色的生成而消散； 发射：使用和物体形状类似的发射器，在体积的外边界附近发射； 速度：环绕Y轴高速旋转，有一点点向内的离心力表示能量衰减； 轨迹：使用很长的的轨迹来模拟龙卷风的外观，lifetime为0.5，轨迹会跟随者角速度环绕两圈左右；移速太快的话轨迹mesh顶点间隔太大开始失真；宽度递增到上限后衰减。 贴图：带状，使轨迹表现为很长的一段；继承PO颜色，逐PO随机颜色差异； 3.次要效果，能量汇聚； 发射：使用和物体形状类似，放大后的发射器，从体积边缘发射； 速度：为了使PO向中心汇聚，仅使用递增的向心速度和Noise控制移动； 渲染：使用拉伸广告板表现能量，速度快时拉长。 4.次要效果，能量烟雾 设计思路：能量汇聚，形成烟雾，烟雾转化为物体的实体； 渲染：和普通烟雾类似，使用广告板，这里为烟雾染上能量的颜色； 发射：数量变化参考能量汇聚的趋势，在体积外围附近发射； 贴图：逐渐变得透明；烟雾由大变小，帧序列顺序颠倒；

## 萤火虫 - Effects/Misc/FireFlies

1.主要效果，萤火虫漫天飞舞； 发射：萤火虫的活动范围很广，并不在意发射器形状； 碰撞：萤火虫不应该穿入墙壁内，放大碰撞体积； 缩放：出生和死亡时缩小，起到淡入淡出效果； 移动：作为生物，萤火虫可以移动的非常远，使用noise； 动画：9帧动画，循环播放，写入UV到UV1； 物体shader：本例中使用顶点A通道为遮罩，分别着色萤火虫身体和翅膀，使翅膀区域能播放帧动画，使身体区域能随机颜色。 轨迹：表示萤火虫移动时，尾巴留下的残影，较短； 2.次要效果，聚光； 思路：萤火虫大量聚集的地方，微弱的光也能照亮环境； 光源：PO携带Point光源，有较大的范围和低亮度，继承萤火虫颜色； 移动：在出生点附近移动，使用noise；

## 蜡烛 - Effects/Misc/Candles

1.主要效果，火苗； 动画：使用Billboard播放128帧的动画，随机起始帧； 发射：蜡烛模型顶部固定位置发射，仅存在1个PO，循环5秒播放； 火苗抖动：x/y轴使用noise随机缩放，表现火苗的上串和缩小；

## 漏水 - Effects/Water/WaterLeak

1.主要效果，瀑布； 发射：水流量非常不稳定，但又要连续变化，手动调整Curve； 速度：初始速度+重力，模拟自由落体，加速运动； lifetime：理应碰撞地面后消失，这里只渲染轨迹，要手动控制速度； 渲染：使用轨迹表现水流，瀑布表面的白色表现出水流的厚度； shader：使用法线贴图和光照计算，实现白色波纹和非正面视角的不透明； 折射：由于水是有一定厚度的透明液体，需要折射效果看到水底； 2.主要效果，水花； 发射：表现水面受到瀑布冲击，发射点为瀑布的落点，水面中角度发射； 渲染：使用Billboard播放一轮49帧动画，描述水花从有到无的过程； 随机性：使用法线贴图，使表面有快速变化的光照纹路；出生时随机大小； 3.主要效果，水纹； 渲染：使用水平广告板表示一轮水纹，水纹的扩散过程用缩放模拟； shader：使用法线贴图模拟水纹的波浪形表面，与背景进行折射/透明混合； 4.次要效果，溅射； 发射：类似于水花，颗粒状，水面广角度发射； 渲染：使用拉伸广告板和瀑布用的shader，表现出水珠的速度；

## 浴霸喷水 - Effects/Water/Shower

1.主要效果，水束； 发射：喷头的出水的特点是有一定初始速度，在小角度内非常密集； 渲染：使用拉伸广告板，表现大量的长短不一的线段； 碰撞：碰撞地面后消失，触发子粒子效果； 2.主要效果，子粒子-水花； 渲染：使用倒立的锥形mesh，控制缩放，播放32帧动画；

## 云 - Effects/Smoke-Steam/Ground

思路：使用大量有深度差距的广告板，形成云层。 发射：椭圆形，0初始速度，延x轴缓慢飘动； 随机性：Noise随机缓慢移动，36帧动画随机起始帧；

## 沙尘暴 - Effects/Smoke-Steam/DustStorm

1.主要效果，烟雾-土色的云； 2.主要效果：飞石； 速度：随lifetime变化，手动调整Curve，时而静止，时而滚动； 3.主要效果，沙尘-单帧多外观动画；

## 其他总结：

父子PO联动 子PO与父PO的相对位置：Birth模式下，跟随父PO相对移动； 复杂的位置相关的效果：父PO决定实时位置，多个子PO表示一次效果； lifetime映射 颜色的lifetime渐变：配合移动，做出物体的状态变化效果； 自定义固定路径：初始速度配合lifetime中手动设置速度Curve的xyz分量； PO随lifetime有大小变化：使用Start Size的某个Curve模式，新生成的PO按指定规律变化； 发射 仅发射Collider：没有Renderer组件，但是有Collision组件，可触发子PO； 与发射面紧贴的Billboard效果：Renderer组件中使用Billboard的Velocity模式； 碰撞后物体插入表面：损失全部速度，损失部分lifetime； 调试问题 调试子PO：断开父PO的Sub Emitters设置，重新设置Emission组件中的发射方式；