---
title: UGP1-3 GPU instancing
tags:
- UGP
categories:
- [渲染, 效果表现, UGP]
date: 2019-12-20 19:59:13
cover: https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/render/present/ugp/007.png
---

\[toc\]本篇讨论UnityGraphicsPrograming第一册第三章内容 Boids Simulation On GPU 本篇有很多前置的知识点，基于常规shader、compute shader内容，在“[大规模渲染相同(Unity GPU instancing)](https://docs.unity3d.com/Manual/GPUInstancing.html "大规模渲染相同(Unity GPU instancing)")”物体方面进行解说。 GPU Instancing用于绘制同一个mesh的多个副本，只使用少量的draw call。在绘制如建筑、树、草等反复出现的物体时很有用，可以显著提高项目的渲染性能。 GPU Instancing在每个draw call只渲染单个mesh，但是每个实例可以具有不同的参数，如颜色、缩放，以增加变化和减少重复外观。 ▲开启材质的GPU Instancing 在材质面板可以勾选“Enable GPU Instancing”。(URP中新建材质) 仅当材质的shader支持GPU Instancing时，材质上才会出现这个选项，很多默认标准材质都支持GPU Instancing。 当使用GPU Instancing时，存在以下限制： 1.Unity自动选择MeshRenderer组件和Graphics.DrawMesh调用，不支持SkinnedMeshRenderer。 2.在单个GPU Instancing draw call中，被批处理的GameObjects共享相同的mesh和material。为了制造变化性，应在shader中添加逐实例(per-instance)数据。 在C#端可以通过Graphics.DrawMeshInstanced和[Graphics.DrawMeshInstancedIndirect](https://docs.unity3d.com/ScriptReference/Graphics.DrawMeshInstancedIndirect.html "Graphics.DrawMeshInstancedIndirect")方法执行GPU Instancing。 ▲添加逐实例数据 默认情况下Unity在批处理GameObjects实例时，仅使用到GameObjects不同的transform，如果要添加更多变化，则需要为每个实例设置逐实例属性、修改shader。 下面演示在C#脚本中修改per-instance属性：

```
public class per_instance_Data : MonoBehaviour
{
    public GameObject[] objects;
    MaterialPropertyBlock props;

    void Start()
    {
        props = new MaterialPropertyBlock();

        foreach (GameObject obj in objects)
        {
            float r = Random.Range(0.0f, 1.0f);
            float g = Random.Range(0.0f, 1.0f);
            float b = Random.Range(0.0f, 1.0f);
            props.SetColor("_Color", new Color(r, g, b));

            obj.GetComponent<MeshRenderer>().SetPropertyBlock(props);
        }
    }
}
```

这里，我们希望每个实例拥有不同的颜色，所以通过MeshRenderer组件对颜色属性进行了单独赋值。 这里要注意的是，我们只对per-instance属性进行了**renderer.SetPropertyBlock**操作，如果我们对其他属性也进行了修改，就会破坏GPU Instancing的条件。 在shader中也需要体现per-instance属性：

```
Shader "Sekia/Instancing"
{
    Properties
    {
        //_Color ("Color", Color) = (1, 1, 1, 1) //通过C#脚本赋值
    }

    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

            UNITY_INSTANCING_BUFFER_START(Props)
            UNITY_DEFINE_INSTANCED_PROP(float4, _Color)
            UNITY_INSTANCING_BUFFER_END(Props)

            struct a2v
            {
                float4 vertex : POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID //instanceID
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID //instanceID
            };

            v2f vert(a2v input)
            {
                v2f output = (v2f)0;

                UNITY_SETUP_INSTANCE_ID(input); //为unity_InstanceID赋值 unity_InstanceID = instanceID + unity_BaseInstanceID
                UNITY_TRANSFER_INSTANCE_ID(input, output); //将input的instanceID属性传递给output

                output.vertex = TransformObjectToHClip(input.vertex.xyz);
                return output;
            }

            float4 frag(v2f input) : SV_Target
            {
                UNITY_SETUP_INSTANCE_ID(input); //为unity_InstanceID赋值 unity_InstanceID = instanceID + unity_BaseInstanceID
                return UNITY_ACCESS_INSTANCED_PROP(Props, _Color); //通过unity_InstanceID在数组中获取值
            }
            ENDHLSL
        }
    }
}
```

在上面的例子中，展示了一个简单的返回纯色的例子。 对于GPU Instancing来说，多GameObject的per-instance属性只有转换矩阵、用户自定义属性等。将per-instance数据以Array形式保存在Buffer中就可以实现单draw call连续绘制啦。 关于SRP中的[SRP Batcher定义参考Unity官方博客](https://blogs.unity3d.com/2019/02/28/srp-batcher-speed-up-your-rendering/ "SRP Batcher定义参考Unity官方博客")。shader符合SRP Batcher条件时，GameObject优先被SRP Batcher，如果SRP Batcher的条件被打破了，比如使用了MeshRenderer的MaterialPropertyBlock，才会判断是否用GPU Instancing。 在URP中，材质参数(非Texture部分)均保存在UnityPerMaterial这个Buffer，UnityPerDraw中保存逐帧数据，per-instance数据保存在用户声明的cbuffer中。 ▲正确使用per-instance数据 在使用空间转换矩阵时，应使用Unity包装过的宏，才能正确使用到per-instance数据，例如UNITY\_MATRIX\_MVP需要改为TransformObjectToHClip。 用户自定义per-instance数据并不是必须的，但是**每个实例都必须有自己的转换矩阵**。 所以需要instanceID，因此在vertex开始阶段必须要`UNITY_SETUP_INSTANCE_ID(input);`；如果fragment中也需要使用到per-instance数据，也必须做此操作。 Instancing相关的宏可以参考： `Packages/com.unity.render-pipelines.core/ShaderLibrary/UnityInstancing.hlsl` ▲“UnityPerDraw”中包含的属性block ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/render/present/ugp/008.png) ▲Procedural Instancing GPU Instancing可以表现为两种形似(区别于Procedural Instancing)： 1.场景中大量存在的相同mesh的GameObject(只有第一个Pass会被实例化) 2.使用**Graphics.DrawMeshInstanced**命令(指定instance次数，mesh不剔除、烘焙、Z排序) 这两种方式都需要在Material面板上enable GPU Instancing。 **multi\_compile\_instancing**的工作模式类似于shader\_feature，如果没有enable，Unity会剔除掉instancing变体；在Frame Debugger中的draw call表现为“Draw Mesh (instanced) ObjectName”。 **instancing\_options procedural:FunctionName**不需要在材质上enable GPU Instancing。 **Procedural Instancing**：Graphics.DrawMeshInstancedIndirect 类似于Graphics.DrawMeshInstanced，这个方法也能绘制同一个submesh很多次，不同点在于声明绘制次数的参数声明在Buffer中(输入参数中的bufferWithArgs)。 bufferWithArgs中必须包含5个int值，分别表示： ▲index count per instance：用于表现粒子效果的submesh的顶点数 ▲instance count：Instancing制造的实例数量 ▲start index location：(mesh中的复数submesh分别存储数据时)在Indices的起始值 ▲base vertex location：(mesh中的复数submesh分别存储数据时)在vertices的起始值 ▲start instance location：实例ID的的偏移量 而这5个值需要我们对submesh的结构有所了解。 ▲submesh Unity中并没有直接的submesh实例，我们只能通过[Mesh](https://docs.unity3d.com/ScriptReference/Mesh.html "Mesh")来了解和操作它。 这里的submesh就好比我们在Blender中，将多个mesh合并为一个大的mesh。 每一个submesh都必须配一个Material。 mesh.subMeshCount：返回mesh中包含的submesh数量 mesh.GetIndexCount：返回指定submesh的顶点数量 mesh.GetTopology：返回拓扑形式 mesh.GetIndices/SetIndices：将submesh设置为点/线/三角面等拓扑(submesh's index buffer) mesh.GetTriangles/SetTriangles：将submesh设置为三角面拓扑 mesh.GetIndexStart：返回submesh's index buffer在mesh's index buffer中的starting index mesh.GetBaseVertex：顶点在mesh中的index = baseVertex + 顶点在submesh中的index(来自于submesh's index buffer) 有了这些理论知识，我们就可以通过C#脚本控制submesh的构造、合并(mesh.CombineMeshes)与分离。 逐顶点数据需要合并设置，如：vertices、uv、normals、tangents、colors。 ▲3.1 用GPU实现群模拟 这个章节通过在ComputeShader中使用Boids算法，实现群模拟。 鸟、鱼、或者其他的陆地上的动物会经常组成群体，群体的移动有规则性和复杂性，其拥有某种美的特性，非常吸引人。 计算机图形中，逐一设置群中的每一个个体是无法实现的，所以我们考虑到了用于制作群的Boids算法。在这个模拟算法中，只需要建立各种简单的规则就能轻松实现。在这个简单的实现中，必须协调每个个体之间的位置关系，个体数的增加会带来计算量的成倍增加。在个体数很多的情况下CPU难以胜任。在这里我们利用GPU强大的并行运算能力。 Unity中，GPU可以参与常规计算(GPGPU)，使用的是ComputeShader。GPU的构成中有共享缓存作为存储空间，使用ComputeShader时可以活用这些缓存。 另外，Unity的GPU Instancing是非常高效的渲染功能，将任意mesh大量绘制。将这些Unity的GPU的计算能力活用，控制并绘制大量群物体，就是本章的内容。 ▲3.2 Boids算法 Boids算法由Craig Reynolds在1986年提出，在群中的个体会根据视觉、听觉等感官，判断周围其他个体的位置和方向修正自身的行为。群中的个体有以下3个简单的行为规则： 1.离群：个体与**在一定范围内的其他个体**过于密集时避开 2.整列：个体倾向于向**在一定范围内的其他个体的平均方向**移动 3.结合：个体倾向于向**在一定范围内的其他个体的平均位置**移动 ▲3.3.2运行条件 本篇中运行的程序使用到了ComputeShader和GPU Instancing，两者对运行环境有一些要求。 ComputeShader对大部分游戏泛用/专用设备都支持，需要留意老旧的安卓手机。 GPU Instancing的支持范围和ComputeShader类似，需要Unity5.6以后。 ▲3.4.4 BoidsRender.shader 这个shader用于处理Graphics.DrawMeshInstancedIndrect。 #pragma multi\_compile\_instancing：用于生成instancing变体，其影响范围包括INSTANCING\_ON、PROCEDURAL\_INSTANCING\_ON、STEREO\_INSTANCING\_ON等关键词 #pragma instancing\_options procedural:setup：特指PROCEDURAL\_INSTANCING\_ON关键词 这两个命令的主要作用是声明关键词，以启用函数库中的不同分支，如果我们对使用per-instance数据很熟练的话，可以直接在a2f结构中声明SV\_InstanceID，就可以省去那些关键词，直接暴露逻辑： `uint instanceID : SV_InstanceID` 我们通过查看UnityInstancing.hlsl可以看到： `unity_InstanceID = inputInstanceID + unity_BaseInstanceID` 使用了Unity封装的宏以后，我们只能通过unity\_InstanceID来访问per-instance数据，inputInstanceID来自于SV\_InstanceID，那么[unity\_BaseInstanceID是什么](https://forum.unity.com/threads/instance-id-in-shader.501821/ "unity_BaseInstanceID是什么")呢？ **unity\_BaseInstanceID** 仅用于在(**同material的**)多个instanced draw call之间共享instancing array。 假设场景中有100个Cube和100个Sphere，他们共享一个material，在渲染循环自动处理的情况下，一次upload 200个实例数据到GPU，用2个draw call分别绘制Cube和Sphere。第1个draw call中unity\_BaseInstanceID为0，第二个draw call中unity\_BaseInstanceID为100。 通常情况下unity\_BaseInstanceID在每次draw call都会重置，因此它不会随帧或时间积累。 ▲再谈Procedural Instancing 相比起对GameObject的实例化(GPU Instancing)，Procedural Instancing描绘的目标并没有出现在Scene里面，也就没有transform数据，所有的实例都共享一套Object Space，而我们在调用Graphics.DrawMeshInstancedIndrect命令时，bufferWithArgs中包含的数据将submesh描述的非常完整，每个实例拥有相同的Object Space下的数据，我们需要**创造性的计算出ObjectToWorld**矩阵、颜色等来为实例添加多样性。 ▲3.4.1 GPUBoids.cs **ComputeBuffer初始化** ComputeBuffer对应着GPU上的一块缓存，可供CPU或GPU进行读写，或CPU与GPU交换数据。ComputeBuffer中只能存储Array形式的结构体，在声明时必须注明Array的长度以及单个结构体所占的byte数。 使用Marshal.SizeOF()方法可以获取结构体的长度，SetData()用于分配数据。 GPUBoids.cs中还有很多Dispatch相关的操作，参考上一章[ComputeShader语法](https://acgmart.com/unity/ugp1-2/ "ComputeShader语法")。 ▲instance\_vert\_setup 在本章提供的shader中，重点内容在vert函数部分：

```
void instance_vert_setup(inout a2v input) //在vert初始化后执行
{
  #ifdef UNITY_PROCEDURAL_INSTANCING_ENABLED
    BoidData boidData = _BoidDataBuffer[unity_InstanceID]; 

    float3 pos = boidData.position.xyz; //位置
    float3 scl = _ObjectScale;          //Objcet Space缩放

    float4x4 object2world = (float4x4)0;
    object2world._11_22_33_44 = float4(scl.xyz, 1.0);
    float rotY = atan2(boidData.velocity.x, boidData.velocity.z); //向量→矩阵
    float rotX = -asin(boidData.velocity.y / (length(boidData.velocity.xyz) + 1e-8));
    float4x4 rotMatrix = eulerAnglesToRotationMatrix(float3(rotX, rotY, 0));
    object2world = mul(rotMatrix, object2world); //缩放→旋转Z→旋转X→旋转Y→平移
    object2world._14_24_34 += pos.xyz;
    input.positionOS = mul(object2world, input.positionOS);
    input.normalOS = normalize(mul((float3x3)object2world, input.normalOS));
  #endif
}
```

由于作者使用了surface shader，我们可以用Unity的编译功能将其转换为常规的vertex-fragment shader。 instance\_vert\_setup的作用相当于在vertex开始阶段对a2v结构进行了处理，我们直观的看到被修改的值是顶点位置和法线。 标准shader的后续逻辑会使用Unity包装的方法将参数转换到各种空间，从per-instace数据中找到转换矩阵，**这些矩阵我猜测是默认值**，这是因为作者用surface shader带来的特殊性，我们可以自己新写一个shader。 这里我们已知每个实例的位置(position)和速度(velocity)，求ObjectToWorld矩阵。 ▲向量转矩阵(这里很需要作图) ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/render/present/ugp/009.png) atan2(对边，底边) = 角度(根据轴向有正负区别) 左手坐标系中，围绕Y轴旋转的方向是将Z轴旋转到X轴的位置； **围绕Y轴旋转的角度** = atan2(velocity.x, velocity.z) 围绕Y轴旋转可以理解为鱼在水中水平游动。 如果鱼开始向上/下游动，也就是围绕X轴或者Z轴旋转，那么就形成了一个倾斜的角度。 因为本篇中我们计划用一个Cube来假设是一条鱼，有固定的旋转轴，这里设X轴为旋转轴。 所以这条鱼的初始状态相当于(0, 0 ,1)，即Z正轴。 asin(对边，斜边) = 角度(根据轴向有正负区别) 左手坐标系中，围绕X轴旋转的方向是将Z轴旋转到-Y轴的位置； **围绕X轴的旋转角度** = asin(-velocity.y, length(velocity.xyz)) 因为鱼围绕Z轴旋转意味着鱼在翻肚子，所以Z轴旋转角度为0，理论上可以轻微旋转。 根据Unity的矩阵转换顺序，[缩放→旋转Z→旋转X→旋转Y→平移](https://acgmart.com/3d/lwrp7/ "缩放→旋转Z→旋转X→旋转Y→平移")我们可以得到对应的转换矩阵。 缩放和平移比较好理解，旋转要注意旋转顺序，不同的旋转顺序会影响到结果： posWorldSpace = My·Mx·Mz·posObjectSpace = mul(Myxz, posObjectSpace) 根据矩阵相乘的性质，我们可以先计算出**My·Mx·Mz**等效的矩阵，随后再与坐标相乘。 ![](https://img.acgmart.com/uploads/TIM截图20190322142346.png) ![](https://img.acgmart.com/uploads/TIM截图20190322140045.png) ![](https://img.acgmart.com/uploads/TIM截图20190322141638.png) 对于Mz：float cz = cos(angles.z); float sz = sin(angles.z)； 对于Mx：float cx = cos(angles.x); float sx = sin(angles.x); 对应My：float cy = cos(angles.y); float sy = sin(angles.y); 将这6个值带入3个矩阵，进行复杂的矩阵相乘运算后： float4x4( //横着填充 cy \* cz + sy \* sx \* sz, -cy \* sz + sy \* sx \* cz, sy \* cx, 0, //第一排末端 cx \* sz, cx \* cz, -sx, 0, //第二排末端 -sy \* cz + cy \* sx \* sz, sy \* sz + cy \* sx \* cz, cy \* cx, 0, //第三排末端 0, 0, 0, 1 //第四排 ); ▲3.4.2 Boids.compute `groupshared BoidData boid_data[SIMULATION_BLOCK_SIZE];` SM将在GPU芯片上的shared memory区域分配一片区域给group，这片区域由group内的所有thread之间共享。 shared memory区域离register很近，访问速度极快，有容量限制。 `GroupMemoryBarrierWithGroupSync()` 同一时间可能有数千的线程在运行，group内线程对groupshared区域均有读写权利，一方面要避免线程之间重复读写，比如A线程修改了B线程保存的值，另一方面也要有同步机制，所有的线程都完成了一个步骤，开始准备下一轮计算。 [GroupMemoryBarrierWithGroupSync()](https://docs.microsoft.com/en-us/windows/win32/direct3dhlsl/dx-graphics-hlsl-intrinsic-functions "GroupMemoryBarrierWithGroupSync()")使group内的thread在逻辑节点处同步一次，SM 5.0+。 ▲[for循环](https://docs.microsoft.com/en-us/windows/win32/direct3dhlsl/dx-graphics-hlsl-for "for循环") `[Attribute] for ( Initializer; Conditional; Iterator ) { Statement Block; }` Attribute：可选参数，用于[控制语句的编译方式，以优化程序的执行速度](https://en.wikipedia.org/wiki/Loop_unrolling "控制语句的编译方式，以优化程序的执行速度")。 ▲for循环+同步 我们可以注意到for循环中有2次同步指令。 如果是普通同步指令就很好理解了，当同步指令在for循环中时会是什么效果呢。 **假设总归有5000个thread，100个group，每个group有50个thread。** 同步指令并不会影响到单个thread的执行过程。 `boid_data[GI] = _BoidDataBufferRead[N_block_ID + GI];` 对于单个thread来说，第一次执行完boid\_data的赋值操作时等待同步，等待同group内的其他49个thread执行到这个节点，因为boid\_data的长度等于group长度，同组内的50个thread在同步时恰好将boid\_data整个填满； 接下来是一些计算操作，有对boid\_data的读取操作，然后退出本次循环时同步一次。此时的同步可以保证group内的50个thread都完成了对boid\_data的读取操作，而不会出现某个thread已经进入了下一个循环修改了boid\_data中的数据并影响同group内其他thread的计算结果。 所以两次同步指令是很有必要的。 for循环的每一次执行，boid\_data中的数据都会切换为不同group的位置和速度数据数组，for循环执行结束后，boid\_data总共被赋值过5000次，遍历了所有的thread。 而boid\_data这样的存储空间是每一个group都分配了一个的，总共会有100个boid\_data，所有缓存累计被赋值的次数就是500000次，随着总thread的增加计算量变得庞大。 groupshared缓存的访问速度非常快，适合用于做此类密集型计算。 ▲limit方法(限高) limit(a, b)： if(a < b)return a; else return b; ▲位置与速度修正 通过第一个kernel，我们计算出了新的一帧中，鱼将受到基于多个规则的作用力。 我们需要计算鱼在下一帧中的位置和朝向，这些数据会提供给shader。 `BoidData b = _BoidDataBufferWrite[P_ID];` 取出上一帧中的位置和速度； `float3 force = _BoidForceBufferRead[P_ID];` 取出下一帧鱼将要受到的作用力； `force += avoidWall(b.position) * _AvoidWallWeight;` 如果位置超出了bounds，则会受到墙壁的正面反推； `b.velocity += force * _DeltaTime;` `b.velocity = limit(b.velocity, _MaxSpeed);` `b.position += b.velocity * _DeltaTime;` 将速度转化为下一帧的位移增量。 到此主要逻辑验证完毕。 ▲总结 本章中模拟的Boids只是最低限度的算法，在规则和计算效率方面可以优化。 通过调整参数生成大小各异的不同群，应该能看到不同的行为特征。 除了这里展示的基础行动规则，还存在其他应该考虑的规则，比如鱼类的天敌出现时鱼会逃跑。不同物观察周围的视野范围和精度不同，水、陆、空环境不，运动器官不同，个体差等。 虽然利用GPU的并行计算能力，相比CPU可以计算更多的个体，但是每个个体都要在循环中遍历计算所有其他个体这种方式并不效率。 根据个体的位置进行区域化细分，只计算相邻区域的个体，可以抑制计算量。