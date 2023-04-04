---
title: Blender工作流
categories:
- [渲染, 工具, Blender]
date: 2018-11-28 03:03:53
---

\[toc\]本篇中讨论Blender中的材质/物理等效果 以及Blender结合Unity的工作流 材质/动画等效果不仅要考虑实现，还需要能导入Unity进行新的组装。

# 布料

## 布料测试

导入承载物模型，选中承载物，工具栏-物理-选中刚体-设置刚体类型：被动-选中碰撞； 创建一个平面，移动到承载物上方，横竖切割+细分，工具栏-物理-选中布料； 打开时间线窗口-播放-在合适的帧暂停； 选中平面-应用Cloth（布料）修改器-右键-Smooth Shading-G+Z/S稍微调整位置和比例以实现更好的覆盖承载物效果-添加表面细分修改器-添加实体化修改器； ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/render/tool/003.png) 布料自身重叠时容易出现表面崩坏的情况,应看情况修改厚度。

# Principled着色器（资料不足）

使用Principled着色器可以实现玻璃/金属/布料 基础色：贴图颜色 表面细分：光穿透物体表面的程度，默认为0，1表示光线完全穿透物体表面. 次表面颜色：光穿透物体后显示的颜色。 Metallic：金属质感；默认为0，1代表完全金属。 高光：反光效果，开启后表面有亮亮的效果。 糙度：物体的粗糙度，提高粗糙度使物体表面出现朦胧/变脏的效果 各项异性过滤/Anisotropic Rotation：控制金属的特殊反光 Sheen/Sheen Tint：提供淡淡的弱光；常用于布料。 Clearcoat：镀膜/外漆效果 Clearcoat Roughness：镀膜的粗糙度 IOR折射率：光线穿过物体内部时的折射的角度，需要物体有透明属性； 投射：对外界光线的反射率，1代表完全反射外界光线。 传递（资料不足）

## 常用材质设置

纯金属： 透明玻璃： 磨砂金属： 磨砂玻璃 布料： 塑料： 木头：

# Unity中的材质

## 关于材质/Shader/纹理

在Unity的资源目录可以很方便的**在Unity中创建一个新的材质**文件xx.mat； 新创建的材质中，默认的Shader属性是"Standard"，点击后可以更改为项目中已加载的Shader； **在Unity中创建一个新的Shader**：和创建其他文件的方式一样创建Shader文件；有默认的几种Shader可以选择；Shader就像.cs文件一样，相当于编程脚本，有特定的编程语言，打开Shader默认会跳转到VS，用文本方式编辑代码后可以影响到材质的效果和整个材质编辑界面结构；已加载的Shader在列表中显示的名称并不是Shader的文件名，而是Shader文件中第一行中的字符串。 导出的FBX文件中也可能包含材质资源，比如在Blender内渲染的室内场景就可以导出为FBX文件，然后在Unity里面打开； **在Blender中创建一个新的Shader**：选择窗口模式-Scripting类别下的文本编辑器-模板-开放式着色语言（OSL）-Empty Shader; Blender中的Shader文件同样也是以文本方式进行编辑，也拥有自己的编程语言，实际编程上可能是基于一种着色语言的变种版本； 如果要学习Shader编程语言的话建议从看官方的文档开始，Blender/Unity中同理。

## 材质的导入和导出

Blender中有材质的物体导入到Unity中时，材质的Shader变为Standard类型； Unity中无法修改FBX文件，所以新建的材质和Shader只能以独立的文件存在，无法导入到其他3D软件； 即使是在同一个3D软件中，只要切换渲染引擎，材质的设置都会产生变化； 材质是基于渲染引擎的，除了模型本体可以互相导入/导出，想要在某个渲染引擎下实现更好的效果就需要分别为渲染引擎指定材质。 在Blender中为Cube创建金属风格材质，导入到Unity中后只有基础色参数被保留；

# 将模型从Blender导入Unity

Unity手册中有关于[如何导入FBX](https://docs.unity3d.com/Manual/HOWTO-exportFBX.html)的指导； 但是我尝试以后发现没法导入贴图，需要先将.blender文件和texture另存为到指定的位置，再手动选择材质进行赋值一次。 关闭Blender的自动保存备份：Blender会自动保存一个.blender1的文件备份上一次保存的工程，在Unity中会造成多余文件，所以在个人设置中关闭这个功能或者每次**保存时使用Ctrl+Alt+S（另存为）覆盖掉文件**； 关于Unity中的导入设置（文件名 Import Settings）：

## Model

这部分控制模型在实例化后的表现，**不用刻意设置**。

### Scene

Scale Facter:缩放因素，默认为1；在模型极端小的情况下可能会导致实例化后看不到，镜头拉近后因为太小从摄像机里消失；不需要修改这里的参数，在Prefab里面设置比例即可。 Covert Units：Blender中-属性-场景-单位-选择单位，需要精确的长度可以使用3D量尺和量角器。 Import BlendShapes：是否导入形态键，默认导入；形态键可以对模型中的点的位置进行修改；Unity形态键支持顶点/法线/切线。 Import Visibility：(可能是Blender中对物体的可视性设定) Imoprt Cameras/Import Lights：Blender中的摄像机和灯光导入到Unity会变成mesh，一般不会将这些不需要的东西存在模型里面；建议关闭。 Preserve Hierarchy：保持（Blender中的）层次结构

### Meshes

Mesh Compression：设置网格压缩程度，默认不压缩； Read/Write Enabled：是否可从脚本读写网格； Optimize Mesh：网格优化； Generate Collliders：自动生成Mesh Collider组件；

### Geometry(几何)

Keep Quads： Weld Vertices： Index Format： Normals：法线 Blender Shape Normals：形态帧法线 Normals Mode： Smoothness Source： Smoothing Angle： Tangents： Swap UVs： Generate Lightmap UVs：

## Rig

Animation Type：动画设置类型，老版本/通用/人形；在Blender中创作的动作选择通用即可； Avatar Definition：骨架设置，默认使用当前模型中的骨架； Root node：骨骼根； Optimize Game Objects：优化实例；

## Animation

Import Constrains：导入约束；在Blender中，骨骼可能带有旋转角度约束，模型动作变形时可以尝试一下； Import Animation：导入动画； Resample Curves：重采样曲线；关于曲线编辑有问题时可以尝试一下； Anim. Compression：动画压缩，压缩后动画摄影表中的关键帧数量变少，不压缩时每一帧都是关键帧，造成数据量庞大； Rotation Error/Position Error/Scale Error：误差，越小越精确； Animated Custom Properties：是否导入自定义动画属性，默认关闭；

### 动画编辑

可以选择需要保留的动画片段，支持复数的动画片段； 为每个动画片段指定帧数，精确到0.1秒； 可设置动画是否循环播放； Additive Reference Pose：参考帧？ Curves：添加曲线 Events：设置动画相关的函数 Mask:遮罩 Motion：表情 Import Message：

## Materials

材质对模型的外观影响非常大，但是从Blender中导出的材质只有基础色可以被读取到，所以读取了也跟没读取差不多； 建议是关闭掉Import Materials，在Blender中依然可以使用原来的材质进行测试，而Unity中使用新建的独立材质文件。

## 测试导入

### 测试1：骨骼的位移/旋转

测试流程：创建一个Cube，为其制作2个动画片段 分别是1个移动的关键帧和一个旋转的关键帧；导入Unity 移动动画帧数：1-29帧；旋转动画帧数0-40帧；Frame Rate：24 fps 导入后获得: 移动动画帧数：0-28帧 时长：1.04秒；旋转动画帧数0-40帧；Samples：24 时长1.16秒 结论： 将动画从Blender导入Unity后，动画帧数和帧率没有发生变化； 导入的动画在Unity中**无法编辑**，需要在Blender中编辑； 在Unity动画编辑器中，**动画时长为为帧数/帧率**； 导入后的动画关键帧与Blender中的关键帧不同，多了很多帧； 解释：Unity对FBX文件进行了烘焙；

### 测试2：IK骨/FK骨

### 测试3：权重

在顶点组中，一个顶点被标记了0-1的权重，那么在复数的骨骼中，是否所以骨骼对一个点的权重之和不大于1呢； 流程：创建1个Cube；创建2个骨骼；将某个点权重给骨骼A分配为1，再将这个点权重给骨骼B分配为0.5； 结果：骨骼A的权重并没有被骨骼B影响；

### 测试4：关节处的权重

关节处想要做到合理的弯曲依赖于对权重的细节处理 流程1：同一个物体内，关节处无重合的权重，上肢和下肢的全部点均为1的权重 结果1：下肢部分整体按指令移动 结论1：权重1可以使顶点完全应用骨骼的旋转调整 流程2：同一个物体内，关节处无重合的权重，上肢全部点为1的权重，下肢与上肢结合处为0.5权重，下肢剩余部分为1的权重 结果2：下肢部分整体按指令移动 结论2：在不存在竞争的情况下，任意权重就可以完全驱使一个顶点 流程3：在同一个物体内，关节处有一排顶点重合，重合处的上肢和下肢权重均为0.5，上肢和下肢剩余部分为1的权重 在侧视图中，旋转下肢90°。 ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/render/tool/004.png) ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/render/tool/005.png) 结果3：结合处的顶点同时受到了2根骨骼的影响 流程4：修改流程3中关节处上肢的权重为1 ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/render/tool/006.png) 流程5：修改流程3中关节处上肢和下肢的权重为0.1 结果：与流程3一致 结论：结合处的顶点在存在竞争约束关系时，通过计算所有约束的优先级来判断最终效果 流程6：修改流程3中关节处上肢的权重为0.8，下肢的权重为0.4 结果：与流程4一致 结论：结合处的顶点存在竞争约束关系时，竞争结果（受影响比例）与权重值比例一致 通过观察发现，绕X轴旋转骨骼90°后，下肢的底部有一个基于关节处为中心的90°旋转，这为研究网格如何受影响提供了信息。 流程7：在编辑模式下移动上肢骨骼，使其脱离网格范围，旋转骨骼 结果：网格以上肢骨骼原点为中心进行旋转 总结：顶点围绕多个骨骼的原点旋转，根据其对多根骨骼的**权重比例**计算最终位置。 所以，在绘制权重时，权重大小本身意义不大，关键在于**是否有权重**和权重比例。 因为手臂在绘制模型时类似于圆筒状，有2圈以上的权重重合区域，关节弯曲时折痕处可能会向内扭曲变形，使上肢处因为顶点位移而末端变细；关节向外使用1：1权重表现正常，那么关节向内折痕处的权重就需要额外处理了。 流程8：上肢和下肢有2圈权重重合区域，上肢和下肢的顶点组的全部权重均为1，将折痕内部的点从上肢中移除。 结果：下肢的表皮会覆盖上肢的折痕，实现更好的关节弯曲效果。 结论：**在折痕处减少重合区域圈数**，非折痕处的重合区域圈数越多（有权重1-0过度）折痕外侧弯曲的效果越平滑。

# Unity中模型性能优化

参考Unity手册中[模型角色优化性能](https://docs.unity3d.com/2018.2/Documentation/Manual/ModelingOptimizedCharacters.html) 1：每个角色只使用1个Skinned Mesh Renderer

## 编辑动画

动画拆离：选中FBX模型中的动画片段，Ctrl+D 删除关键帧：动画摄影表中选中关键帧-Delete Kyes；**将.anim文件用文本方式打开**，脚本删除多余关键帧。

# Blender结合Unity的工作流

在Blender中进行3D建模/绑骨/动画-导出到Unity-获得初稿； 模型拆分-骨架/动画/部件-Unity中实现重新拼装； 进行贴图/动作优化；

# Blender中的数据

Blender中的核心数据包括：mesh/骨骼/关键帧/顶点组 其中对mesh的编辑可以在编辑模式和雕刻模式下进行 对骨骼的编辑可以在物体模式和编辑模式下进行 对动作的编辑在姿态模式下进行 选择物体和骨架后Ctrl+P-选择一种绑定骨骼方式-自动创建顶点组 修改器Armature：添加了这个修改器后设置物体的父级骨架，所有部件的骨架应该都是一样的； 如果部件（mesh）中需求骨架中没有的骨骼，比如头部，不同的发型会有额外的骨骼，这些骨骼需要使用代码进行合成/添加物理效果，如果不这样处理的话部件只会和部件的根目录一起移动； **部件的骨架目录**：部件应包含主骨架和本部件的专属骨骼； 顶点组：当在权重绘制模式为骨骼添加权重后，物体会获得顶点组，顶点组以受影响的骨骼名为组名排列成列表； 动画摄影表 时间线：显示当前物体/当前骨骼的当前动画片段的关键帧 动画摄影表：可以同时编辑多个动作 动作编辑器：只能编辑1个物体的动作（包括骨架） 两帧之间参数没有变化的部分全选后高亮 **编辑动作方式**：选中一个骨骼-确认时间线上的帧数-确认动作编辑器中的绿色高亮内容 顶点组：标记多个顶点，用于指定权重值，快速选择和反选；顶点组名会保持与对应的骨骼名相同； 关于骨骼： 删除骨骼的影响：删除骨骼会同时删除对应的顶点组，与顶点组对应的Mesh的部分（顶点）将不受控制； 断开骨骼连接：Alt+P，这样可以使骨骼的方向更灵活，可以移动骨骼末端位置，移动原点位置可能会使动画变形。

# Blender工程文件

Blender保存项目后得到.blend文件，无法观察到里面包含了什么，无法直接解压； 打开一个文件a.blend，使用文件-Append（附加）-打开另一个文件b.blend，可以查看并部分导入资源； 在高级过滤中可以筛选需要导入的类型；类型包括： ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/render/tool/007.png)