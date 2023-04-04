---
title: Unity官方教程-生存射击 Survival Shooter 第五章 敌潮
categories:
- [Unity, Demo, Survival Shooter]
date: 2018-08-21 21:04:16
cover: https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/unity/demo/survival_shooter/cover.png
---

\[toc\]本篇为Unity官方教程-生存射击 Survival Shooter的第五章。 本系列教程面对刚接触Unity的新手，并尝试帮助新手创建自己的第一个游戏。 从第一章开始看可以跳转至：[https://acgmart.com/unity/8/](https://acgmart.com/unity/8/ "https://acgmart.com/unity/8/") 在第四章中，场景中唯一的敌人可以杀死玩家，也可以被玩家杀死。 但是当唯一的敌人死亡后不会再产生新的敌人，玩家将变得无事可做。 在本章中，我们将自动克隆3种敌人，敌人会源源不断的产生并追着玩家而来。

# 创建敌人的预制

我们将新增2种敌人，ZomBear和Hellephant。 新的敌人和Zombunny拥有很多相似之处： 1.组件完全相同 2.模型动画的构成相同，都是Idle、Move、Death 3.Zombunny和ZomBear的模型只有部分不同

## 创建ZomBear

将ZomBear.fbx拖拽到场景中，不用在意具体位置； 设置资源ZomBear： 设置图层为Shootable； 将HitParticles.prefab拖拽至ZomBear，添加子对象； Animator组件-Controller:EnemyAC; 复制Zombunny的剩余8个组件到ZomBear； 设置Zombunny的组件： Audio Source-AudioClip：ZomBear Hurt； Enemy Health-Death Clip：ZomBear Death；

## 使Hellephant可以复用EnemyAC.controller

创建HellephantAOC.overrideController； 设置HellephantAOC： Controller：EnemyAC; Death：Hellephant.fbx的Death； Idle：Hellephant.fbx的Idle； Move：Hellephant.fbx的Move；

## 创建Hellephant

将Hellephant.fbx拖拽到场景中，不用在意具体位置； 设置资源Hellephant： 设置图层为Shootable； 将HitParticles.prefab拖拽至Hellephant，添加子对象； Animator组件-Controller:HellephantAOC; 复制Zombunny的剩余8个组件到Hellephant； 设置Hellephant的组件： Audio Source-AudioClip：Hellephant Hurt； Enemy Health-Death Clip：Hellephant Death；

## 生成敌人Prefab

将场景资源目录中的Zombunny、ZomBear、Hellephant拖拽到项目资源目录，得到3个prefab； 删除场景中的这3个资源。

# 敌人管理

在场景资源目录中创建空对象并重命名为EnemyManager； 创建C#脚本EnemyManager并添加为资源EnemyManager的脚本组件；

## 编辑EnemyManager.cs

```csharp
using UnityEngine;

public class EnemyManager : MonoBehaviour
{
    public PlayerHealth playerHealth;
    public GameObject enemy;
    public float spawnTime = 3f;
    public Transform[] spawnPoints;


    void Start ()
    {
        InvokeRepeating ("Spawn", spawnTime, spawnTime);
    }


    void Spawn ()
    {
        if(playerHealth.currentHealth <= 0f)
        {
            return;
        }

        int spawnPointIndex = Random.Range (0, spawnPoints.Length);

        Instantiate (enemy, spawnPoints[spawnPointIndex].position, spawnPoints[spawnPointIndex].rotation);
    }
}
```

## 创建Zombunny生成点

创建一个空对象并重命名为ZombunnySpawnPoint; 为ZombunnySpawnPoint添加蓝色标签； 设置ZombunnySpawnPoint位置为：-20.5，0，12.5； 设置ZombunnySpawnPoint角度为：0，130，0；

## 创建ZomeBearSpawnPoint

复制(Duplicate)ZombunnySpawnPoint，并重命名为ZomBearSpawnPoint； 为ZomBearSpawnPoint添加紫色标签； 设置ZomBearSpawnPoint位置为：22.5，0，15； 设置ZomBearSpawnPoint角度为：0，240，0；

## 创建HellephantSpawnPoint

复制(Duplicate)ZombunnySpawnPoint，并重命名为HellephantSpawnPoint； 为HellephantSpawnPoint添加黄色标签； 设置HellephantSpawnPoint位置为：0，0，32； 设置HellephantSpawnPoint角度为：0，230，0；

## 设置EnemyManager组件生成Zombunny

Player Health：Player； Enemy:Zombunny； 拖拽ZombunnySpawnPoint到Spawn Points添加生成点

## 设置EnemyManager组件生成ZomBear

拖拽EnemyManager到资源EnemyManager添加脚本组件； Player Health：Player； Enemy:ZomBear； 拖拽ZomBearSpawnPoint到Spawn Points添加生成点

## 设置EnemyManager组件生成Hellephant

拖拽EnemyManager到资源EnemyManager添加脚本组件； Player Health：Player； Enemy:Hellephant； 拖拽HellephantSpawnPoint到Spawn Points添加生成点

# 保存项目

测试运行后，场景中已经可以自动刷新3种敌人。 我们可以为每种敌人设置不同的刷新时间、血量等。