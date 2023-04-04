---
title: Unity中实现MMD效果
categories:
- [渲染, 工具, Blender]
date: 2018-12-12 03:04:11
---

\[toc\]本篇讨论如何在Unity中实现MMD效果 其实在Blender中也可以实现MMD效果，为什么需要使用Unity呢？ 在Unity中可以编程呀，界面UI/模型合成/场景特效都可以自己处理； 使用Blender实现MMD效果也很简单，4000多帧的动作播放起来，画布/特效加起来； 资料搜索方法：Github搜索“Unity MMD”；B站搜索“Unity MMD”；可以用的插件或者开源资料还是有一些的；

# MMD4Mecanim

注：MMD4Mecanim来自于日本的开发者，作者提供的插件中包含了封装逻辑的.dll文件，并不是完全开源的； 如果要在Unity中实现播放动画的效果，就需要使用到Unity中的Mecanim系统； 模型/动作/材质都必须是Unity所支持的格式才能起到作用，为了使用.pmx格式的模型就必须引用插件，这里使用MMD4Mecanim插件进行举例说明； [MMD4Mecanim插件的主页](http://stereoarts.jp/)；这个网站中包含了作者制作的多个插件，MMD4Mecanim (Beta)就是我们要找的；

## 创建新的工程

为测试MMD插件，创建新的Unity工程，这里我使用Unity2018.3.0f1； 导入在MMD4Mecanim主页下载的zip压缩包中的MMD4Mecanim.unitypackage;另一个包中包含新的shader文件，也一并导入； 找一个Miku的模型文件，解压后整个文件夹（包括模型和贴图文件夹）拖入到Unity中； 找一个适配Miku的.vmd动作文件，丢进Unity中Miku的文件夹里面；

## pmx转fbx

Miku文件夹下出现了一个新的文件，模型名为文件名，.MMD4Mecanim结尾，里面有一些关于不能商用的注意事项，勾选后Agree即可； 同意注意事项后属性界面的面板刷新，变成了PMX转FBX界面； 将上一步准备好的.vmd动作拖入到窗口中VMD下面的位置；这里可以指定多个动作文件，用于生成Unity中的.anim文件；点Process后执行工具程序转换模型文件，这会消耗时间；因为Unity中不支持IK，所以转FBX处理应烘焙动画，.anim中应详细记录了每一帧中骨骼的位置； 生成好了FBX后，插件的使命差不多就完成了，接下来需要使用Unity的动画/物理/渲染系统； 关于Unity中实现头发/裙子的物理效果，添加特效，在将来的文章中详细描述；

## MMD4Mecanim插件执行流程

在插件自带的PDF中有流程运行图，第一步是pmx转fbx，在转fbx的过程中调整骨骼、使用自带的物理引擎（Bullet Physics）计算出动态骨骼的运动路径并烘焙进FBX里的动画摄影表；得到FBX后，设置材质和Shader，添加表情脚本，应用物理学；最后是用户的自由调整； MMD4MecanimAssignMaterialModel.cs这个文件继承了AssetPostprocessor；根据AssetPostprocessor的介绍，这个类可以监听导入流，从而可以在加载前或加载后执行一段脚本； OnAssignMaterialModel：监听导入FBX文件事件，返回指定材质为renderer赋值材质； 整个项目代码公开的部分极少，要么就使用它的FBX导出功能；

## pmx2fbx

在插件的目录下面有一个文件夹叫pmx2fbx，里面有一个同名的.exe文件，这个exe封装了将pmx转换为fbx的方法； 百度/谷歌搜索pmx转fbx或者pmx导入Maya的话，很多项目的底层都用到了这个工具； 使用方法1：直接将pmx文件拖放到pmx2fbx.exe上，会自动转换 使用方法2：运行cmd，将pmx2fbx.exe丢进cmd里面运行，命令行输入pmx文件地址 vmd文件地址；vmd文件地址可以包含多个； 得到的FBX格式是ASCII编码的，没有发现如何设置为使用二进制编码；

# mmd-for-unity

Github上关于MMD转Unity最热门也最近更新的一个项目； 安装插件、导入模型资源后模型有比较好的还原；因为没有添加物理，IK动作表现不好（腿抖），头发完全没物理； 转换方式来看，没有转换为fbx，而是使用了Unity自带的零部件，如mesh、anim等；材质表现没有MMD4Mecanim的还原度高； 不过既然是开源的，而且是C#的，非常有学习价值；MMD4Mecanim中用到的技术包括FBX的SDK、子弹物理引擎等，就算反编译出来了学习也很困难，不是C#语言写的可能性很大（C++/Python）； 如果是不懂代码的玩家还是建议使用MMD4Mecanim，更自动化，效果也更出色；

## mmd-for-unity代码阅读

### 读取配置

当点击一个.pmx文件，或者使用工具栏“MMD for Unity/PMD Loader”就会执行; `MMD.Config.LoadAndCreate()` 这个方法返回全局配置的单例； 如果配置不存在时，找到Config.asset，读取数据： `config_ = AssetDatabase.LoadAssetAtPath<Config>(path);` 这个Config.asset是一个资源型Object，被序列化后生成文件； Config.asset中的默认参数则是几个配置类的默认实例，其面板属性中显示所有公开的值（而不是代码中写的内容）；

### PMDImportConfig

PMDImportConfig也就是导入.pmd/.pmx文件时需要利用的配置了； 它继承了一个ConfigBase类，这个类提供了标题/是否折叠/UI功能模板； PMDImportConfig类有序列化特性，所以会被保存在全局配置中； 被序列化后的属性会显示在Config.asset的属性面板上； 读取配置会使用object.MemberwiseClone方法，深层复制所有字段，保证每次打开窗口都是默认配置； 当点击“Convert”按钮后，执行LoadModel方法转换pmx； 转换结束后弹出一个文本窗，文本窗用不上注册快捷方式，可以设置窗体宽高；

### MMD.ModelAgent

LoadModel方法中实例化一个ModelAgent对象： `MMD.ModelAgent model_agent = new MMD.ModelAgent(file_path);` 这个类用于识别pmx文件，定义了文件名和pmx文件头部信息； 如果用pmx的方式读取头部信息失败的话（捕获到FormatException），换pmd的方式读取并转换为pmx的头部信息； CreatePrefab： is\_pmx\_base\_import参数决定如何格式化pmx/pmd文件，格式化失败后会尝试换一种方式加载； 在场景中实例化GameObject，并生成Prefab文件；

### PMX.PMXFormat

读取.pmx文件的两个关键点：将.pmx文件对象化（序列化）；反序列化.pmx文件 PMX.PMXFormat类就实现了.pmx文件的对象化，在MMD域名中同样也有.pmd/.vmd的支持； MetaHeader：文件属性 Header：pmx文件属性 VertexList：顶点列表；包含顶点、法线向量、UV、追加UV、多种权重类型、边缘放大率； FaceVertexList：面的点序列 TextureList：纹理贴图文件名列表 MaterialList：材质列表；包括名称、扩散色、高光色、高光度、环境色、边缘、纹理、高光贴图、自影贴图 BoneList：骨骼列表；包括名称、位置、父级编号、变形阶层、目标、轴限制 MorphList；表情列表；不同的表情数据的偏移类不同 DisplayFramelist：表示栏 RigidbodyList：刚体列表 RigidbodyJoinList：J点列表 .pmx文件和普通的fbx文件相比，包含了复杂的材质、骨骼限制、物理等；缺少动作文件，但是可以用.vmd文件来弥补； .vmd相比fbx中烘焙过的动画相比多了一些其他数据，如表情帧、IK帧、摄像机数据、自影数据；

### PMXLoaderScript.Import

PMXLoaderScript.Import方法将.pmx文件反序列化； PMXLoaderScript类有4个私有成员和一大堆读取不同类型数据的方法； 使用二进制读来获取数据； ReadBytes(4)：指定数量的字节；string ReadSingle()：4个字节；float ReadByte()：1个字节；enum ReadInt32()：2个字节；字符串长度/层级 ReadUInt32()：4个字节；顶点数/面数/贴图数/材质数/骨骼数 ReadUInt16()：2个字节；enum（移位运算） 而用二进制方式读取文件需要文件中的数据符合规则，序列化/反序列化操作应一致； .pmx文件中相当于有规律的存储着大量的值； 完成Import方法后，我们就得到了一个PMXFormat对象的实例；

### CreateGameObject

这个方法将一个自定义的类转换为了GameObject，功能性上也很神奇； PMXConverter类有6个私有成员和一大堆的角色部件处理方法，从无到有的堆建起一个角色GameObject； 创建一个空物体作为根目录： `root_game_object_ = new GameObject(format_.meta_header.name);` 为根目录添加一个MMDEngine脚本； MMDEngine脚本：具有管理描边/刚体/IK骨/Shader/渲染队列的功能；其Start()和LateUpdate()会延迟启动，不会干扰到PMXConverter.CreateGameObject进程； MeshCreationInfo：Mesh信息，Unity中支持的mesh最多顶点数为65536，很多Miku有10万顶点，所以需要拆分为更多的Mesh； Enumerable.Range(0, format\_.vertex\_list.vertex.Length)：生成指定范围的`List<int>`，参数1：初始值；参数2：容器长度；{0,1,2,3...} `List<int>.Select(x => x * x)`：遍历列表成员，执行Lambda操作； 单个mesh的情况下：只有1个MeshCreationInfo实例，其中包含1个顶点列表，每个材质都对应一个Pack形成Pack数组； Pack.material\_index：材质编号； Pack.plane\_indices：面-点数组（3个点作为一个面）中，跳过开始阶段，指定长度的一段数组； Pack.vertices：顶点；通过排除面-点数组中的重复点得出； all\_vertices：单个mesh的全部顶点编号，从小到大排序； reassign\_dictionary：关于单个mesh全部顶点，key为顶点编号，value为顶点序列号 多个mesh的情况下：单个Pack上的顶点数超过Unity最大顶点数还会被继续细分；根据顶点数多少重新排序Pack； `List<int>.Where<int>(System.Func<int,bool> preficate)`：筛选序列成员，Lambda函数的右侧指定的是筛选条件（true）； `List<int>.Select<int,Pack>(System.Func<int,Pack> selector)`：替换int序列为Pack序列； 每个MeshCreationInfo在定点数不超过Unity最大顶点数的前提下，被指定了尽可能多的材质；Pack根据材质编号再次重新排序，小的靠前； `List<int>.SelectMany(x => x.vertices)`：返回孙集 `System.Array.Sort(info.all_vertices);`：使用默认比较器排列数组，字母序列小/数字小在前； `List<int>.Any(x=>null!=x)`：返回bool；lambda公式右侧为bool判断条件； 通过以上步骤，实现了对PMXFormat实例的材质/顶点整理，为创建mesh提供了参数；

### CreateMesh

CreateMesh方法基于MeshCreationInfo创建mesh； new Mesh()→指定顶点坐标/法线/UV（可以指定多套UV）/权重/颜色 →指定submesh（每个子mesh对应一个材质；每个子mesh有自己的面-点数组（顶点序列号构成）/mesh编号） →创建mesh文件

### CreateMaterials

PMXFormat里面的材质列表存储方式就是Material类型，也就是说事先就已经根据材质ID顺序准备好了材质； 创建材质的步骤处理的内容是将材质分配给多个mesh，比如10万顶点的模型大概会被分割为2个mesh； ConvertMaterial方法中将PMXFormat.Material类型的材质转换为了Unity中的材质； 在转化材质的过程中，为输出结果result设置Shader/扩散色/环境色/透明度/高光色/亮度/轮廓宽/轮廓色/渲染顺序/高光贴图/自影贴图/主贴图 转化为Unity中的材质对象后就可以实行实例化了；

### CreateBones

Unity中的骨骼就是空物体的transform，这里设置好世界坐标/设置父级后即可完成任务；

### BuildingBindpose

绑骨则是将骨骼的世界坐标映射到Mesh中有权重的顶点；