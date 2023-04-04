---
title: Unity官方教程-生存射击 Survival Shooter 第二章 敌人
categories:
- [Unity, Demo, Survival Shooter]
date: 2018-08-21 21:03:47
cover: https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/unity/demo/survival_shooter/cover.png
---

\[toc\]本篇为Unity官方教程-生存射击 Survival Shooter的第二章。 本系列教程面对刚接触Unity的新手，并尝试帮助新手创建自己的第一个游戏。 从第一章开始看可以跳转至：[https://acgmart.com/unity/8/](https://acgmart.com/unity/8/ "https://acgmart.com/unity/8/")

# 使镜头跟随玩家移动

创建一个C#脚本并重命名为CameraFollow；

## 编辑CameraFollow.cs

```csharp
using UnityEngine;
using System.Collections;

public class CameraFollow : MonoBehaviour
{
    public Transform target;  //相机将跟随的目标
    public float smoothing = 5f;  //相机移动速度，略低于玩家移动速度
    Vector3 offset;  //存储从相机到目标的位移差的初始值

    void Start ()
    {
    offset = transform.position - target.position;  //从角色指向相机的向量
    }

    void FixedUpdate ()
    {
    Vector3 targetCamPos = target.position + offset;   //相机的移动目标
    transform.position = Vector3.Lerp (transform.position, targetCamPos, smoothing * Time.deltaTime);  //平滑移动相机
    }
}
```

默认情况下FixedUpdate每0.02秒执行一次，相机会稍有延迟的跟随角色移动。

## 设置CameraFollow.cs

拖拽CameraFollow.cs到Main Camera上； 拖拽资源Player到Main Camera的CameraFollow脚本组件的Target值域中； ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/post9_1.png)

# 创建敌人Zombunny

将Zombunny.fbx拖拽到场景中，不用在意具体位置；

## 让Zombunny可被射击

设置Zombunny的图层为Shootable；

## 添加被击特效

将HitParticles.prefab拖拽到场景资源目录中的Zombunny上，将为Zombunny添加一个子对象； 展开Zombunny，选择HitParticles，可以在场景中看到喷出棉絮的特效。

# 编辑Zombunny

## 添加Rigidbody

Rigidbody设置： Drag：Infinity； Angular Drag：Infinity； Constraints-Freeze Position：Y； Constraints-Freeze Rotation：X、Z；

## 添加Capsule Collider

设置Capsule Collider： Center：Y=0.8； Height：1.5

## 添加Sphere Collider

设置Sphere Collider： 开启Is Trigger； Center：Y=0.8； Radius：0.8；

## 添加Audio Source；

设置Audio Source； Audio Clip：ZomBunny Hurt； Play On Awake：取消；

# 自动追踪系统

为Zombunny添加Nav Mesh Agent组件。

## 设置Nav Mesh Agent

Spreed：3； Stopping Distance：1； Radius：0.3； Height：1.1；

## 设置Navigation

Window→AI→Navigation打开面板，选择Bake选项； Agent Radius：0.75； Agent Height：1.2； Step Height：0.6； Advanced-Manual Voxel Size：开启； Advanced-Voxel Size：0.38； Advanced-Min Region Area：0.1； 设置好有按Bake按钮开始烘焙Vav Mesh，所有开启了Navigation Static的Mesh都会被烘焙进去。

# 创建动画

新建Animator Controller重命名为EnemyAC； 将EnemyAC.controller拖拽到场景资源目录中的Zombunny，实现自动赋值；

## 编辑EnemyAC

将Zombunny的3个状态Idle、Move、Death添加到EnemyAC； 添加Trigger变量PlayerDead； 添加Trigger变量Dead； 设置Move状态为默认状态； 连接Move状态到Idle状态，并进行设置： 取消Has Exit Time； 设置条件为PlayerDead； 连接AnyState状态到Death状态，并进行设置： 设置条件为Dead；

## 创建C#脚本EnemyMovement

将EnemyMovement.cs拖拽到场景资源目录中的Zombunny，实现添加组件； 编辑EnemyMovement.cs：

```csharp
using UnityEngine;
using System.Collections;

public class EnemyMovement : MonoBehaviour
{
    Transform player;  //抓取玩家
    //PlayerHealth playerHealth;  //抓取玩家生命值
    //EnemyHealth enemyHealth;  //抓取当前enemy生命值
    UnityEngine.AI.NavMeshAgent nav;  //抓取enemy的nav组件

    void Awake ()
    {
        player = GameObject.FindGameObjectWithTag ("Player").transform;  //绑定玩家
        //playerHealth = player.GetComponent <PlayerHealth> ();  //绑定玩家生命值
        //enemyHealth = GetComponent <EnemyHealth> ();  //绑定当前enemy生命值
        nav = GetComponent <UnityEngine.AI.NavMeshAgent> ();  //绑定nav组件
    }


    void Update ()
    {
        //if(enemyHealth.currentHealth > 0 && playerHealth.currentHealth > 0)  //如果当前enemy和玩家生命值都大于0
        //{
            nav.SetDestination (player.position);  //enemy自动跟踪玩家
        //}
        //else
        //{
        //    nav.enabled = false;  //禁止nav组件
        //}
    }
}
```

代码中有部分被注释，等稍后我们会启用这些内容。 保存并测试运行后，Zombunny就会自动寻路追踪玩家了。