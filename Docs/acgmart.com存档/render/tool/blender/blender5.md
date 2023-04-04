---
title: MMD导出至Blender
categories:
- [渲染, 工具, Blender]
date: 2018-11-28 11:04:17
---

\[toc\]本篇记录如何将MMD数据导入Blender

# 综述

将MMD（一种3D软件）数据导入Blender（一种3D软件）本质上和将fbx/obj导入Blender没差别； Blender2.80中，默认支持.dae .abc .fbx .bvh .ply .obj .stl .svg .glb .gltf； Blender的原生格式是.blend； 使用第三方插件将MMD的模型文件（.pmx）和动作文件（.vmd）导入Blender;

## MMD资源获取

MMD导入Blender第三方插件搜索方法：[github.com](https://github.com/) 关键词：mmd blender MMD素材英文搜索方法：[deviantart.com](https://www.deviantart.com/) 关键词：tda miku dl MMD素材日文搜索方法：[bowlroll.net](https://bowlroll.net/) 关键词：mmdモーション モデル 音乐素材搜索方法：QQ音乐

## 初次使用MMD

新手练习模型素材：[TDA Miku](https://www.deviantart.com/xoriu/art/TDA-Miku-Trio-DL-449399661) MMD动作素材获取方法：bowlroll.net搜索“mmdモーション”，排序方式设置为下载数降序“ダウンロード数降順”。 准备好了模型/动作/音乐 **pmx**模型直接拖放进界面 导入**vmd**动作 切换至摄像机模式（To camera） Play

# 安装Blender插件

根据github的搜索结果，有2个项目用的人比较多blender\_mmd\_tools、cats-blender-plugin 其中cats-blender-plugin的更新很频繁且支持最新的Blender2.80，推荐使用； 在遇到动作导入困难时可以考虑使用blender\_mmd\_tools并降低Blender版本到2.79； 根据cats-blender-plugin的教程安装插件后，按N呼出属性面板，在属性面板一侧就能看到MMD/Misc/CATS这3个新选项； 使用CATS菜单的Import Model功能导入pmx模型文件，其他功能如果有BUG的话可以考虑等作者更新； CATS菜单中还一些其他功能，比如翻译/整理，可以等版本更稳定的时候再探索这些功能；

## cats-blender-plugin特性

下面列出了这款插件所公开的特性，我这里测试的版本为0.2.1 Optimizing model with one click!：一键优化模型 Creating lip syncing：嘴型同步 Creating eye tracking：眨眼 Automatic decimation：自动销毁 Creating custom models easily：自定义模型 Creating texture atlas：创建纹理资源 Creating root bones for Dynamic Bones：为动态骨骼创建根骨骼 Optimizing materials：优化材质 Translating shape keys, bones, materials and meshes：翻译 Merging bone groups to reduce overall bone count：合并骨骼组以减少骨骼总数 Protecting your avatars from game cache ripping：防止模型被破解抄袭 Auto updater：自动更新

## cats-blender-plugin功能

Import/Export Model：导入和导出模型 导入中支持很多第三方的格式，这里会经常用到的是.pmx模型文件格式； 导出功能，首先是导出提示，使用插件的导出功能有额外的模型面超过数量/材质数量过多提示； 导出功能也提供一个导出FBX操作预设，默认勾选了打包图片、反勾选应用修改器/添加尾骨/烘焙动画/摄像机/灯光 这个导出FBX的方案可以借鉴一下； Fix Model：优化模型 这里面包含相当多的操作，导入一只miku后点击“Fix Model”会卡顿很久； Reparenting bones：重设骨骼父级关系 Removing unnecessary bones/objects/groups/constraints：移除非必须骨骼/物体/顶点组/骨骼约束 Renaming and translating objects and bones：重命名骨骼名为英文 Mixing weight paints：混合权重 Rotating the hips：矫正姿势 Joining meshes：合并网格 Converts morphs into shapes：转化表情为形态键 Using the correct shading：矫正shader 整个操作下来对模型的修改是不可控的，但是里面的一些想法是可以借鉴的，比如： 判断无用顶点组/无用骨骼； 指定骨骼的重命名方式； 动作数据的定义（包括MMD和Blender）； 因为这个项目是开源的，能看到源代码（python），如果打算批处理Blender中的任务，那么借鉴一下代码是非常不错的； Start Pose Mode：开始摆姿势；也就是切换到Blender的姿态模式 Pose to Shape Key：注册形态键；摆出一个姿势后点击此按钮就可以在形态键末尾新增一个形态键 Apply as Rest Pose：应用姿态模式下的缩放/旋转；用于修复因缩放而破损的形态键，操作需谨慎； Separate by：将mesh根据材质分割为更多的mesh，通常不需要； join Meshs：合并指定的mesh，通常不需要 Merge Weight：合并权重；删除当前骨骼，将骨骼的权重转移到指定骨骼； Translate：翻译日文到英文，包括形态键/骨骼/物体/材质；对日语苦手的人来说有用的； Show More Options：更多功能，删除无用骨骼/反转法线/移除重叠点/修复全身追踪/修复恋活形态键 Custom Model Creation：该功能在Blender2.80中未上线 Decimation：测试版，删除顶点，将高模变成低模 Eye Tracking：眨眼调试

# MMD中的数据

对MMD很感兴趣，但是只习惯使用Blender，那么需要了解一下MMD中的参数在Blender中意味着什么； 使用PmxEditor打开pmx模型后，可以在UI界面中观察到模型的顶点/面/材质/骨骼/表情/骨骼分类/刚体/Joint/SoftBody

## 建模篇

![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/render/tool/008.png) 顶点/面：组成模型的基本元素，有了顶点和面以后就可以计算顶点法线和展开UV获得**UV展开图**；所有的面都是三角形，对应**UV纹理贴图**中的一块区域； 位置：也就是坐标，相当于Unity中的Vect3，包含x/y/z轴的位置，float类型； 面法线：是一个长度为1的矢量（x²+y²+z²=1），用于光照计算，光线方向与法线方向的夹角越小表面就会看起来越亮； 顶点法线（Vertex Normal）：是一个过顶点的长度为1的矢量，用于过度多个面的显示效果，值为顶点贡献的多个面的法线和值格式化为1长度的向量；法线角度不均匀导致模型表面出现棱；顶点法线通常可以重新计算； UV：顶点在UV展开图中的位置 Bone Weight（ボーンウェイト、骨骼权重）:记录了骨骼编号和对应的权重值；有4排，所以最多支持1个点同时受4根骨骼的影响；BDEF/SDEF/QDEF等“变形方式”指得是权重计算方式和对应的模型扭曲修正，Unity中也有4根骨骼权重的设定； ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/render/tool/009.png) 参照顶点：构成每个三角形的三个顶点，是按顺时针计算的；渲染引擎默认只渲染正面； ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/render/tool/010.png) 面数：UV纹理贴图影响的面的个数 扩散色/反射色/环境色/反射强度/非透过度：基础色/反光颜色/环境光颜色/反射光的强度/透明度；通过控制光的反射效果来表现物体材质，很旧的技术； 轮廓：轮廓色/轮廓宽度/RGB值/透明度 Toon/Sphere:使用贴图来表现物体表面细节；Toon：本影贴图，本影下的部位从明到暗与该toon贴图从上到下的颜色叠加；Sphere：高光贴图，随着观察角度改变反光效果，基于镜头/法线的实时UV运算；在渲染引擎中会使用自带的材质着色器来表现材质，所以Toon/Sphere用不上；MMD中使用多种贴图的材质有很好的2D效果； ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/render/tool/011.png) 骨骼：用于表现模型的姿态；与动作数据关联，动作数据中的骨骼与模型中的骨骼存在名称上的对应关系；有位置和朝向的基础设定，Blender中可以断开骨骼连接，MMD中可以指定目标骨骼或者向量； 性能：回转/移动/表示/操作表示是否允许被旋转/移动/显示/操控；IK指反向动力学，需要指定目标骨骼和受影响的骨骼链长；IK在Blender中是被添加在一个骨骼上的约束，目标指向作为控制器的骨骼，在MMD中则表现为添加在控制器上的约束； ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/render/tool/012.png) 表情（モーフ）：分为顶点表情/骨骼表情/材质表情，可以做到区域性的改变人物的显示效果；相当于Blender中的形态键，键值范围0-1； Panel（パネル）：在MMD表情面板中的位置，被设计为眼/眉/嘴/其他4个区域； 表示枠：MMD中动画摄影表左侧的骨骼分类列表；类似于Blender的Armature，但是分类后更方便查看一些，常规操作如选择/旋转比Blender里面要方便些；

## 物理篇

刚体：物理学上指受力不发生形变的物体；MMD中使用刚体关联骨骼实现物理效果（头发/裙子）；MMD中同一个组内的刚体不会发生碰撞，所以需要把头发的所有刚体和身体的所有刚体分别放在一个组； Joint：连接2个刚体并保持这2个刚体之间的运动关系； SoftBody：软体，PMX2.1中的新功能； **注**：每个3D软件的渲染引擎和物理引擎都差别巨大；模型文件转格式可以考虑互导，材质实现方式可以参考和试验，物理实现方式只能依赖于引擎自身了。

## MMD操作

阴影：地面影：光线被模型拦截后在背景物体上留下的阴暗区域；本影：模型自身的部位在其他部位留下的阴影； 轮廓：轮廓色/轮廓线宽度； 关键帧：在MMD中叫做“注册”，在Blender中叫做关键帧，在Unity中叫做“key”；MMD中，模型操作/骨骼操作/表情操作/相机操作/照明操作/本影操作/附件操作都可以作为关键帧，每种操作类型都涉及到选中目标-设置参数-添加关键帧的操作，MMD中自带骨骼分类/形态键； 场景/特效：通过添加.x附件完成

# PMXeditor中的操作

常用设置： 设置显示类型过滤：模型显示窗口下面那一排；表顶：只选择表面目标； 设置选择目标类型：顶点/面/骨骼/刚体/J点 设置选择方式：点选/框选/自由 设置显示方式：PmxView-子窓-表-表示设定；这里可以设置环境/显示内容/辅助显示内容； 设置显示目标过滤：PmxView-子窓-絞‐絞込み表示（マスキング/遮罩）；用于控制要显示的物体 对选定目标的操作类型：移动/旋转/缩放；按Shit加选 对选定物体/顶点/面/骨骼的操作：PmxView-编辑-选择物体/顶点/面/骨骼 对选定目标进行精确的操作：PmxView-子窓-動 常用视图： PmxView视图：相当于Blender中的物体/编辑模式， TransformView视图：相当于Blender中的姿态模式，不会对模型产生实际的影响，可以用于测试绑骨/表情； 添加操作： PmxView-编辑-简易多边形追加（簡易プリミティブ追加） 注：在已经有UV展开图的部位新增顶点后会破坏贴图的效果，类似于Blender中开启动态拓扑； 注：编辑UV贴图明显是在Blender中可以3D描绘更方便