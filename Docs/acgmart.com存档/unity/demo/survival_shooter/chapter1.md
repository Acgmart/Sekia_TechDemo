---
title: Unity官方教程-生存射击 Survival Shooter 第一章 玩家
categories:
- [Unity, Demo, Survival Shooter]
date: 2018-08-19 19:19:06
cover: https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/unity/demo/survival_shooter/cover.png
---

\[toc\]本篇为Unity官方教程-生存射击 Survival Shooter的第一章。 本教程参考资料： [B站up上传的中文翻译版本（2018.1）](https://www.bilibili.com/video/av18791296 "B站up上传的中文翻译版本（2018.1）") [视频网盘下载地址](https://pan.baidu.com/s/1dYvP3714RKT0xStGozxepg "视频网盘下载地址") [官方教程(2014.10)](https://www.youtube.com/watch?v=_lP6epjupJs "官方教程(2014.10)") [个人练习的打包](https://pan.baidu.com/s/1tmXu1lNgv1QKb3gxohCq-Q "个人练习的打包") 视频共10p，完整描述了一个3D射击游戏的制作过程，适合新手学习。本篇中也将创建一个全新的3D项目并跟着本教程进行学习和探讨。内容完整且开源，网上也有相关资料，是本教程的优势。**新建项目导入Unity包的时候应先创建好Layer中的Floor和Shootable层**。

# 准备

## 获取源代码

Unity2018的安装非常简单，在[官方网站](https://store.unity.com/cn "官方网站")上下载最新版本即可，由于是很初级的项目，不必过于在意Unity的版本。 本教程可以看做是官方教程的文字版，会对原内容进行复原和深究。 成功安装Unity以后，打开Unity，在Learn-Tutorial Projects里面可以找到Survival shooter，也就是我们即将学习的生存射击。 ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/post8_1.png) 成功打开项目以后，可以在资源目录中看到项目的结构。 ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/post8_2.png) 我们会使用官方的资源重新构建游戏。在构建之前，可以先玩一玩已完成的项目，了解一下我们即将做的是一个什么样的游戏。

## 体验游戏+总结

在资源目录-Asserts-\_Complete-Game，有一个后缀为.unity，名称为\_Complete-Game的文件，双击一下该文件可以激活官方准备的完整版场景，然后按Unity上部的播放按钮▶体验游戏。在体验游戏的过程中，要注意观察画面中存在的模型、UI、特效、互动等，游戏中的任何表现我们在今后的学习中都将亲手实现。 ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/post8_3.png) 我这边简单的总结如下 模型类： 1. 兜帽射手 2. 黑紫兔子 3. 黑蓝兔子 4. 黑黄大象 UI类： 1. 计分UI 2. 生命条UI 3. 暂停界面 4. 失败界面 特效类： 1. 受到攻击时的屏幕泛红 2. 开枪时，枪口的光线和灯罩 3. 敌人被攻击时冒烟（棉絮飘出） 互动类： 1. 可以控制射手在地板上移动 2. 敌人会自动追踪射手 3. 可以控制射手朝鼠标位置射击 4. 被击中的敌人会减少生命值 5. 射手被攻击会减少生命值 6. 射手生命值为0时会重新开始游戏 7. 按ESC键可以暂停游戏 音乐类： 1. 战斗背景音乐 2. 射手被攻击时的音效 3. 游戏结束音效 以上为个人简单体验后所记录下来的内容，可能不是最全面的，甚至可能不是那么正确，但是作为初次观察的结果来说已经足够我们利用。下面我们将从0开始这个项目。

# 创建新的项目

打开Unity，Projects-On Disk-New project,新建项目。 ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/post8_4.png) 项目名可自取。 本游戏为3D游戏所以模版选择3D。 可以指定存贮位置。 添加资源包添加资源包选项中可以勾选我们刚才下载的“Survival Shooter Tutorial”。 ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/post8_5.png) 开启Unity分析的话需就需要选择组织，Unity分析主要用于收集游戏的数据，可以在My Account-Manage orgnizations-Dashboard中查看已布游戏的数据表现，在本篇教程中可以关闭Unity分析功能。

## 调整Unity界面

在经过一段时间加载后，我们成功创建了一个新的项目。 ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/post8_6.png) 场景SampleScene的.unity文件在Assets-Scenes文件夹，场景中目前除了默认摄像机和默认光源什么都没有。 在Unity界面的右上角，Layout下拉菜单中选择“2 by 3”。 将项目资源目录拖至场景资源目录下方，并最小化项目文件的显示方式，使界面更整洁。 如果需要开启控制台以便于观察程序的运行情况，可以通过Window-General-Console调用控制台窗口，我这里将控制台吸附到工作场景的旁边，这样可以在调试程序时，同时观察效果演示和控制台输出。

## 删除不要的文件夹

删除\_Complete-Game和Scripts这2个文件夹，我们将会用自己新建的脚本，而这些原有的脚本如果没有重命名可能造成冲突。 如果需要观看原项目的内容，可以再新建一个项目或者直接打开官方教程包。

## 关键词

### 预设（Prefab）

预设是我们在项目中，提供或保存一个游戏对象的方式。 在项目资源目录中，用蓝色方块图标表示预设，场景资源目录中用蓝色字体表示预设资源。 它可以被置入多个场景中，也可以在一个场景中多次置入，在需要重复使用某资源时使用预设。 编辑了Prefab以后，所有关联的场景资源都会发生相同变化。 对场景资源目录中的某个Prefab进行编辑后，不会影响到项目资源中的Prefab。

### 可视化编辑

场景资源目录（Hierarchy）和场景（Scene）中的物体的关系是一一对应的，对场景资源的编辑可以在场景中同步进行观察。

### 场景观察操作

Hand Tool手型图标模式下，鼠标默认为手型，左键按下拖动界面时界面根据当前视角垂直移动。 按下Alt键后再按下鼠标左键，鼠标变为眼睛形，左键按下拖动界面时改变视角。 滑动鼠标滑轮中键，可以放大缩小画面。

### 导入导出资源

右键项目资源目录中的文件夹，Export Package..-Export..保存为.unitypackage文件，即可在其他项目中使用。

# 构建游戏

## 创建图层

在右上角Layer下拉列表中选择Add Layer..改名/创建以下图层： User Layer 8:Floor User Layer 9:Shootable

## 创建环境

(先操作问题解决1) 在本篇教程中有已经搭建好了的环境，在Assets-Prefabs，Environment.prefab就是一个环境的预设。 将Environment.prefab拖放入场景资源目录中。

### 问题解决1

当我们将Environment.prefab放入SampleScene的场景资源目录时，控制台会提示有15个物体带有“overlapping UV's”。 ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/post8_7.png) 而将Environment.prefab放入\_Complete-Game的场景时不会出现这样的问题。 解决方案：在Window→Rendering→Lighting Settings中关闭Auto Generate。

## 确认Environment的位置

如果不在(0,0,0)，可通过Reset重置位置

## 创建光源

删除默认光源Directional Light，将Lights.prefab放入SampleScene的场景资源目录。 设置Lights位置为(0,10,0)； 设置光源Scene Lighting的角度为(50,-30,0) 设置光源Scene Lighting的Intensity为1

## 设置主相机

设置主相机位置为(0,15,-22)； 设置主相机角度为(30,0,0)； 设置主相机Tag为：MianCamera; 设置主相机Clear Flags为Solid Color； 设置主相机Projection为Orthographic； 设置主相机Size为4.5； 设置主相机Clipping Planes-Far为60；

## 创建地板

创建一个Quad，进行以下设置： 重命名为Floor； 坐标(Position)设置为(0,0,0)； 角度(Rotation)设置为(90,0,0)； 缩放(Scale)设置为(100,100,0)； 删除组件(Remove Component)Mesh Renderer； 将资源Floor的图层设置为Floor；

## 创建背景音乐

创建新资源：Game Object-Create Empty； 重命名为:BackgroundMusic； 为BackgroundMusic添加组件Audio Source； 设置Audio Clip为Background Music； 关闭Play On Awake； 开启Loop； 设置Volume为0.1；

## 创建玩家角色

将Player.fbx放入SampleScene的场景资源目录。 我们可以在Models-Characters文件夹找到这个fbx模型文件。 确认Player的位置在(0,0,0)； 设置Player的Tag为Player；

## 创建玩家动画

创建文件夹Animation； 创建动画控制器：Create-Animator Controller； 重命名New Animator Controller为PlayerAC； 拖拽PlayerAC至场景资源目录中的Player； 确认资源Player的Animator组件Controller的值为PlayerAC； 双击Controller的值PlayerAC跳转至玩家动画控制器编辑界面；

## 玩家动画控制器

可以在Scene的旁边看到Animator窗口标题。 展开项目资源目录中的Player.fbx； 将扩展目录下的Death、Idle、Move这3个状态拖放进动画控制器编辑界面；

### 创建变量

创建一个Bool变量IsWalking； 创建一个Trigger变量Die；

### 设置状态机

设置Idle为默认状态； 将Idle连接到Move，并点击新连线进行设置； 关闭Has Exit Time； 设置条件为：IsWalking为true； 将Move连接到Idle，并点击新连线进行设置； 关闭Has Exit Time； 设置条件为：IsWalking为false； 将Any State连接到Death，并点击新连线进行设置； 设置条件为：Die；

## 为玩家角色添加物理形体

Rigidbody能使Unity的物理引擎应用在对象上，套上这个组件的物体会受到重力、推力等影响。 在场景资源目录中选中Player； 为Player添加一个刚体(Rigidbody)； 设置Player刚体属性 设置阻力（Drag）为infinity； 设置角阻力（Angular Drag）为infinity； 设置Constraints-冻结方向Y，使人物不能跳跃或下沉； 设置Constraints-冻结角度X、Z；

## 为玩家角色添加碰撞器

为Player添加一个胶囊碰撞器(Capsule Collider)； 设置胶囊碰撞器 Center：0.2，0.6，0； Height：1.2；

## 为玩家角色添加受击音乐

为Player添加一个Audio Source； 设置Audio Source 设置Audio Clip为Player Hurt； 关闭Play On Awake；

## 为玩家角色添加移动功能

新建一个C#脚本，重命名为PlayerMovement； 将PlayerMovement拖放至场景资源目录中的Player；

## 编辑PlayerMovement.cs

```csharp
using UnityEngine;

public class PlayerMovement : MonoBehaviour
{
    public float speed = 6f;  //玩家移动速度
    Vector3 movement;  //存储玩家位移
    Animator anim;     //绑定动画组件
    Rigidbody playerRigidbody;   //绑定刚体组件
    int floorMask;  //floor图层
    float camRayLength = 100f;    // 相机射线长度

    void Awake ()  //不论脚本是否可用都会在初始化时执行一次
    {
    floorMask = LayerMask.GetMask ("Floor");  //获取Floor层
    anim = GetComponent <Animator> ();  //获取动画
    playerRigidbody = GetComponent <Rigidbody> ();  //获取刚体
    }

    void FixedUpdate ()  //物理更新时运行 跟随物理系统
    {
    float h = Input.GetAxisRaw("Horizontal");  //取横轴输入值，按A键时为-1，按D键时为1。
    float v = Input.GetAxisRaw("Vertical");  //取纵轴输入值，按S键时为-1，按W键时为1。
    Move (h, v);  //位移
    Turning ();  //转向
    Animating (h, v);  //根据状态播放动画
    }

    void Move (float h, float v)
    {
    movement.Set (h, 0f, v);  //设置位移
    movement = movement.normalized * speed * Time.deltaTime;  //格式化向量并得到每物理帧位移
    playerRigidbody.MovePosition (transform.position + movement);  //移动角色
    }

    void Turning ()
    {
    Ray camRay = Camera.main.ScreenPointToRay (Input.mousePosition);  //从鼠标位置发出与摄像机射线平行的射线。
    RaycastHit floorHit;  //存储射线与Floor的交点
    if(Physics.Raycast (camRay, out floorHit, camRayLength, floorMask))  //如果射线击中了Floor层上的物体
    {
    Vector3 playerToMouse = floorHit.point - transform.position;  //交点与玩家位置的位移差
    playerToMouse.y = 0f;  //确保玩家不会被颠倒
    Quaternion newRotatation = Quaternion.LookRotation (playerToMouse);  //用Quaternion存储旋转信息
    playerRigidbody.MoveRotation (newRotatation);  //旋转角色
    }
    }

    void Animating (float h, float v)
    {
    bool walking = h != 0f  v != 0f;  //h或v不为0时，walking为真，其余状态为假。
    anim.SetBool ("IsWalking", walking);  //设置状态机
    }
}
```

现在测试运行后，应该可以体验到人物移动和随鼠标位置转向了。 ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/post8_8.png) 在后面的章节中将继续添加更多的功能。