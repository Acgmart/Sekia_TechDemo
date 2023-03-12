---
title: UGP1-1 程序化建模
tags:
- UGP
categories:
- [渲染, 效果表现, UGP]
date: 2019-12-11 10:29:25
---

\[toc\]本系列主要讨论书籍《Unity Graphics Programming》中提到的知识点。 书籍相关主页：[《Unity Graphics Programming》](https://indievisuallab.github.io/ "《Unity Graphics Programming》") ▲前言 本书主要解说关于Unity图形编程相关的技术。用图形编程一句带过则范围过宽，有很多出版书籍只专注于Shader技术。本书也一样，发表了根据执笔者们的兴趣撰写的各种主题的文章，但是可以轻松预览到结果，对自己独立制作效果有帮助的内容应该很多。同时各文章的相关源代码可以在[IndieVisualLab的Github](https://github.com/IndieVisualLab "IndieVisualLab的Github")中找到，可以边运行工程边阅读本书。 根据不同文章，对读者来说难易度会有差别，根据读者的知识量，内容可能不足或过于难的情况。建议根据自身知识量，阅读感兴趣的文章即可。对于工作中进行图形编程的人，如果能提供创作效果的灵感的话感到很荣幸；对图形编程感兴趣的学生，接触过Processing或openFrameworks等，但是依然对3DCG感到有很高的门槛，如果能获得Unity并开发高表现力的3DCG的机会的话，我会很开心。 IndieVisualLab是公司的同事们(还有前同事)创建的社团。公司内部使用Unity，为开发媒体艺术类展示作品进行编程，和游戏方向的开发相比别具一格的Unity活用方式。本书中展示的各个作品可能散布着对Unity的活用有帮助的知识。 ▲1.1 程序化建模(Procedural Modeling) 程序化建模区别于3D建模工具中的手工操作的建模方式。通过描述规律、自动化处理后，得到最终形状的研究称为程序化建模。程序化建模利用与各种领域，例如游戏开发中生成地形和植物、构建都市等。使用此技术可以实现在运行时变化场景构造的内容设计。 程序化建模的优点 1.可定义参数(如半径、平滑度)对模型进行调整 2.可灵活运用(实时生成、动画、控制美术资源体积) ▲1.2 Mesh Unity中将模型数据保存在Mesh类中，包括顶点、三角形、UV、法线等，以数组的形式保存。 本节内容参考示例demo：ProceduralModeling/Scemes/Quad.unity 相关C#脚本有Quad.cs、ProceduralModelingBase.cs、ProceduralModelingEditor.cs 在本例中，我们使用MeshFilter、MeshRenderer组件渲染物体，通过对Filter.sharedMesh和Renderer.sharedMaterial进行赋值，替换mesh和材质达成常规渲染条件。 除了sharedMesh和sharedMaterial属性，还有类似的mesh和material属性。 以shared形式赋值(set)为变量A时，获取(get)到的值也是变量A，非shadred的形式赋值时会拷贝数据新建实例。 ▲在本篇中倾向于圈出知识重点，相关代码应仔细阅读书籍附带源代码。 ▲Mesh实例的参数 mesh.vertices ：构成mesh的基础外形 mesh.uv ：蒙皮着色的位置映射 mesh.normals ：法线方向需要正对相机，才能有正确的着色计算。 mesh.triangles ：面有方向性，顶点顺时针排列为正面，背面会被剔除。 mesh.RecalculateBounds() ：mesh体积更改时重置包围盒。 mesh.RecalculateNormals() ：mesh表面修改时重置法线方向。 除了本篇中提到的参数外，还有顶点颜色、顶点权重、bindposes、tangents、uv2等参数在不同的场合均有用途，这取决于shader计算中是否需要指定的数据。 ▲运行时修改mesh 在ProceduralModelingEditor.cs中，通过检测编辑器UI面板操作(EditorGUI.BeginChangeCheck)执行实例的Rebuild方法，所以我们在UI面板调整脚本参数时能实时反映到场景中mesh的外观上。 这种方法只能在Editor模式生效，如果是Runtime模式，则需要根据用户操作触发Rebuild方法，实现类似效果。 在编辑器UI面板会显示MonoBehaviour脚本中public或带有SerializeField标签的私有变量。 ▲Shader 决定每个像素最终显示的是shader，本节中用到了标准shader、UV.shader、Normal.shader。本篇中将不讨论shader基础知识。 ▲1.3 平面Plane 参考demo：Plane.unity，在Plane.cs中声明的mesh是对上一节的扩展，现在mesh用于更多可调节参数，Plane的顶点数可以任意调节。 ParametricPlaneBase.cs则是对Plane的扩展，尝试增加深度属性，使Plane的表面变的凹凸，凹凸强度(也就是顶点位置的y轴值)由UV位置决定。 在MountainPlane.cs和TerrainPlane.cs中则用不同的方式重写了Depth方法，使Plane根据不同的规则更改顶点的高度值。 ▲圆柱体Cylinder 从Quad到Plane，再到Cylinder，再到更复杂的形状，核心思想都是把握对应物体的特征，在代码中将mesh数据参数化、规则化。本例Cylinder.cs中描述的圆柱体有上下两个相同盖子，侧面则是围绕着中心的长方形，整体围绕原点(0,0,0)对称。 侧面和上下盖有重叠的顶点，这些顶点所处的面不同，需要分别添加，所以圆柱体的总顶点数为：上下盖子正多边形的顶点数x2+2(盖子的中心)。 如果侧面和上下盖共有顶点，则法线方向只能存在一个，满足不了光照计算需求。 ▲管状物Tubular 管状物可以看做是由很多圆柱体上下盖首尾相连组成： tubularSegments表示整个管状物被切成了多少份圆柱体； radialSegments表示单个圆柱体侧面有多少个长方形； radius表示单个圆柱体的半径； closed表示管状物是否为一个收尾相连的密封物体； Curve中可以指定用于描述管状物轮廓的3D曲线的顶点列表。 当closed为true时，Curve中最后一个顶点失效并被第一个顶点取代，曲线闭合。 ▲法线normal、切线tangent、副法线binormal 法线表示表面朝向，是光照计算(漫反射、镜面反射)的重要参数。 3D软件中，切线和副法线代表了UV流动的方向； 切线是UV的U轴，副法线是UV的V轴(OpenGL中向上，DirectX中向下)； 当手动计算这些值的时候，shader中对UV值进行差值；需注意参数的实际计算用途。 ▲3D曲线 在计算3D曲线相关时，我们需要选取合适的3D曲线函数，这类似于2D曲线。 1.这个3D曲线必须经过我们指定的顶点；就像在2D曲线中我们需要指定2个顶点，以及顶点的切线角度；在3D模式下我们需要提供4个顶点，连接4个顶点后得到3个段落，第1、3个段落是第2个段落的两端的延长线。一个由4个点构成的3D曲线，实际上被分成了3段，也就是3个小3D曲线。 2.3D曲线的核心作用是计算曲线上顶点的位置；在2D曲线中，输入x轴即可得到y轴值；因为曲线在3D空间内可以根据一定规则弯曲，比如赛车轨道，有明确的起点和终点，需要计算出赛道全长、某赛车的当前位置、以及赛车当前跑圈进度进行排名。所以，输入某个百分比进度得到一个空间坐标，或者输入一个空间坐标得到相应的百分比进度会是我们想要的功能。 3.在本节中，管状物被沿着3D曲线方向均匀平分，求每个平分后节点的空间坐标，如果能计算出整个3D曲线的长度，就可以轻松得到每一节的长度，并实现精准的平均分，这取决于采用哪种3D曲线公式。 本节中使用到的3D曲线公式：

```
public class CubicPoly3D
{
Vector3 c0, c1, c2, c3;

public CubicPoly3D(Vector3 v0, Vector3 v1, Vector3 v2, Vector3 v3, float tension = 0.5f)
{
var t0 = tension * (v2 - v0);
var t1 = tension * (v3 - v1);

c0 = v1;
c1 = t0;
c2 = -3f * v1 + 3f * v2 - 2f * t0 - t1;
c3 = 2f * v1 - 2f * v2 + t0 + t1; //使用顶点构建一元三次方程 保存方程中的系数
}

public Vector3 Calculate(float t)
{
var t2 = t * t;
var t3 = t2 * t;
return c0 + c1 * t + c2 * t2 + c3 * t3; //一元三次方程
}
}
```

使用了4个顶点构筑3D曲线，输入某0~1的进度值，可以返回坐标位置。 这套公式的优点在于运算量低，可根据进度值返回空间位置，但是没有曲线距离计算方面的支持。 理论上来说，如果把曲线分成很多段，计算点与点之间的直线距离并累计起来，可以近似的看做为曲线距离，随着切分的段数提高精确度也会提高。 例如：将总共4个段落构成的3D曲线切分为200段(也就是每个段落均被切分为50段)；将200个微小段落的直线长度求和后得出曲线的全长；这200个小段落中长短差异可能非常大，因为构成4个段落的顶点位置是人为设置的，所以这样被200段切分的过程不满足平均分的特点。 ▲进度值映射实现平均分 管状物有明显的进度值属性，比如我们可以设置3D曲线被均等切割的段数，段数越高则mesh的表面越细节。如果切成20段，第1段的末端的进度值为1/20，这样理想模式下精确的进度值可以转化为上述非均等切割200段中的某一段，只有这样我们才能使用3D曲线公式输出空间坐标。 GetUtoTmapping方法根据累积的直线距离判断进度值应如何在3D曲线上落点。 ▲建立3D曲线的方向感 如果只是一根曲线，不足以描述实物的方向感，管状物可以通过扭动使表面扭曲。 GetTangentAt方法直接获取进度值对应的切线方向，值为曲线延伸方向。 初始位置的法线：只要这个方向满足垂直于切线的基础要求即可 初始位置的切线：具体朝向会受到坐标系影响 初始的tangent、normal、binormal用于构成参考坐标系，当切线的方向变化后，需要将法线和副法线一起旋转。 `var axis = Vector3.Cross(tangents[i - 1], tangents[i]);` 上一个tangent和当前tangent的Cross计算，用左/右手坐标系做参考，axis为大拇指方向，将`tangents[i - 1]`往`tangents[i]`的方向旋转。 只需要对法线和副法线也执行同样的操作就实现了“矩阵X矩阵=新矩阵”的效果。 `float dot = Vector3.Dot(tangents[i - 1], tangents[i]);` `float theta = Mathf.Acos(Mathf.Clamp(dot, -1f, 1f)) * Mathf.Rad2Deg;` 使用Dot运算得到cos值，结果会是一个标量，并转换为角度值。 `normals[i] = Quaternion.AngleAxis(theta, axis) * normals[i];` 将normal围绕axis旋转固定角度，这个旋转类似于tangent的Cross操作，如果是左手坐标系，相当于大拇指朝向axis进行顺时针旋转。实际上具有坐标系无关性：

```
Vector3 test = Quaternion.AngleAxis(60f, new Vector3(0, 1f, 0)) * new Vector3(1, 0f, 0);
Debug.Log("x:" + test.x + " y:" + test.y + " z:" + test.z);
```

▲修正法线方向 当3D曲线首尾相连，则需要额外解决法线平滑过渡的问题，初始顶点、切线、法线将与末端完全相同。 我们可以使用前面类似的方法，通过围绕tangent旋转normal来实现。 虽然并没有强制指定初始tangent和末端tangent一致，但是想让首尾自然相连对3D曲线的顶点构成是有要求的，如果3D曲线很直，那么整个模型会皱起来。 `Vector3.Dot(normals[0], normals[segments])`表明初始法线和末端法线之间存在的角度差，为了消除这个角度差我们要执行正向或者反向旋转操作，当角度差大于180°时旋转轴会反转。 `Vector3.Dot(tangents[0], Vector3.Cross(normals[0], normals[segments])) &gt; 0f` 如果法线的旋转轴和初始切线是同方向的(旋转角度小于180°)，那么反方向旋转抵消角度差。 ▲顶点构筑 我们确定了3D曲线的某个点的切线、法线以后，就可以尝试做一个垂直于3D曲线的圆，类似于圆柱体的上下盖，对圆进行均等分。

```
float rad = 1f * j / radialSegments * PI2;
float cos = Mathf.Cos(rad), sin = Mathf.Sin(rad);
var normal = (sin * B + cos * N).normalized;
```

sin \* B + cos \* N可以理解为从normal旋转向binormal旋转0-360°。 这样的旋转方式决定了顶点序列号，并影响三角形排序时的顶点顺序。

```
int a = (radialSegments + 1) * (j - 1) + (i - 1);
int b = (radialSegments + 1) * j + (i - 1);
int c = (radialSegments + 1) * j + i;
int d = (radialSegments + 1) * (j - 1) + i;

triangles.Add(a); triangles.Add(d); triangles.Add(b);
triangles.Add(b); triangles.Add(d); triangles.Add(c);
```

radialSegments + 1表示圆上的顶点数； (j-1)和j表示顶点所在段数； (i-1)和i表示顶点在当前圆上的序列； a表示前一段的圆上的稍早加入队列的点，b是下一段上a对应的点； c是b的下一个点，d是c上一段上的点。 a→d→b，b→d→c是顺时针的三角形(左手坐标系)。 ▲1.4.2 L-System 本节中提供了一个分支系统的数学模型： 初期文字序列：a 每次迭代规则：a⇒ab;b⇒a 迭代效果：a⇒ab⇒aba⇒abaab⇒abaababa⇒... 利用类似的系统可以实现像树的分枝一样的效果。 ▲1.4.3 程序化树 如果仔细阅读了前面管状物的代码，那么看本节的代码ProceduralTree.cs会轻松很多。 本节中，每个树枝的范围是从根部到分支点，每个树枝相当于一个变形的圆柱体，这样做出来的树主枝干可能很歪，感觉很不真实，在加上没有叶子等，改进的空间还有很多。 `public TreeBranch(int generations, float length, float radius, TreeData data)` 在使用C#代码抽象化树的过程中，树枝的主要属性被简化到了3个：迭代次数、长度、宽度。 非主要属性被存储在TreeData中，在需要时进行随机化处理，如树枝半径衰减、树枝角度系数、最大分枝数、树枝弯曲程度、树枝均等分段数等。 ▲程序化建模的应用案例 程序化植物参考：http://algorithmicbotany.org/papers/#abop Unity手绘建模插件Teddy：http://uniteddy.info/ja/ 本章作者个人主页：http://mattatz.org/ 本章作者个人推特：https://twitter.com/mattatz 本章作者个人github：https://github.com/mattatz