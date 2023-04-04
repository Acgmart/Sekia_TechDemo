---
title: Unity官方教程-生存射击 Survival Shooter 第六章 终结
categories:
- [Unity, Demo, Survival Shooter]
date: 2018-08-21 21:04:22
cover: https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/unity/demo/survival_shooter/cover.png
---

\[toc\]本篇为Unity官方教程-生存射击 Survival Shooter的第六章。 本系列教程面对刚接触Unity的新手，并尝试帮助新手创建自己的第一个游戏。 从第一章开始看可以跳转至：[https://acgmart.com/unity/8/](https://acgmart.com/unity/8/ "https://acgmart.com/unity/8/") 在第五章中，我们终于不用再将敌人拖入场景资源目录中，而是通过敌人管理器自动生成敌人。 核心的功能已经完成，最后我来给游戏添加计分UI和游戏结束功能。

# 计分板

为HUDCanvas添加Text子对象并重命名为ScoreText； 设置ScoreText： Anchor：0.5，1；0.5，1；0.5，0.5； Width：300；Height：60； PosX：0；PosY：-50； Text：Score：0； Font：LuckiesGuy； Font Size：50； Alignment：居中；居中 Horizontal OverFlow：Overflow Color为255，255，255，255；

## 添加Shadow

为ScoreText添加Shadow组件； 设置Shadow： Effecct Distance：2，-2；

## 分数管理器

新建C#脚本ScoreManager，并添加为ScoreText的组件； 编辑ScoreManager.cs

```csharp
using UnityEngine;
using UnityEngine.UI;
using System.Collections;

public class ScoreManager : MonoBehaviour
{
    public static int score;


    Text text;


    void Awake ()
    {
        text = GetComponent <Text> ();
        score = 0;
    }


    void Update ()
    {
        text.text = "Score: " + score;
    }
}
```

## 敌人死亡时增加分数

打开EnemyHealth.cs，取消掉关于score的注释。 取消该注释的前提是我们已经创建好了分数功能。 每个怪物死亡时，都会计分。我们可以在怪物prefab中设定不同的分值。

# 关卡结算

通常来说，在游戏输了时，都应该提示“Game Over！” 我们也来做一个。

## 结束背景

为HUDCanvas创建一个Image子对象并重命名为ScreenFader； 设置ScreenFader： Anchor：0，0；1，1；0.5，0.5； 上下左右;0,0,0,0; Color：81,171,246,0；

## 结束文字

为HUDCanvas创建一个Text子对象并重命名为GameOverText； 设置GameOverText： Anchor：0.5，0.5；0.5，0.5；0.5，0.5； Width：300；Height：50； Pos：0，0，0； Text：Game Over！； Font：LuckiesGuy； Font Size：50； Alignment：居中，居中； Horizontal Overflow：Overflow Color：255，255，255，0； 为GameOverText添加Shadow组件； 设置Shadow： Effect Distance：2，-2；

## 调整UI顺序

上面的UI会先渲染，从而被下面的UI遮住。 调整UI的顺序，从上到下依次是： HealthUI DamageImage ScreenFader GameOverText ScoreText

# 创建UI动画

选中HUDCanvas； Window→Animation→Animation，为HUDCanvas创建动画。 初次打开的时候会提示我们创建新的剪辑，跟随提示点击创建，选择保存位置和文件名。 这里将创建GameOverClip.anim。 Add Property创建对象，这里将创建4个对象： GameOverText：Scale； GameOverText：Text.Color； ScoreText：Scale； ScreenFader：Image.Color； 将最后一帧设置统一设置为0:30，也就是第30帧； 设置初始值： GameOverText：Scale第0帧：0，0，0； 设置中间帧： GameOverText：Scale第20帧：1，1，1； 设置结束帧： GameOverText：Scale第30帧：1，1，1； GameOverText：Text.Color第30帧：1，1，1，1； ScoreText：Scale第30帧：0.8，0.8，0.8； ScreenFader：Image.Color第30帧：0.31765，0.67059，0.96471，1；

## GameOver动画延后

为了让玩家死亡动画播放完毕后才开始播放GameOver动画，将全部帧后移90帧。 操作方法为框选全部帧，并向后拖放至初帧为第90帧。

## 关闭GameOver动画重播

在项目资源目录中选择GameOverClip.anim，属性栏中取消掉Loop Time。

## 设置HUDCanvas动画控制器

在项目资源目录中选中双击HUDCanvas.controller，打开编辑页面。 创建一个空的状态Empty，并设置为默认； 创建一个Trigger变量GameOver； 连接Empty和GameOverClip，并设置条件为GameOver； 关闭Has Exit Time；

## 游戏结束管理器

创建C#脚本GameOverManager并添加到HUDCanvas作为组件； 编辑GameOverManager.cs

```csharp
using UnityEngine;

public class GameOverManager : MonoBehaviour
{
    public PlayerHealth playerHealth;


    Animator anim;


    void Awake()
    {
        anim = GetComponent<Animator>();
    }


    void Update()
    {
        if (playerHealth.currentHealth <= 0)
        {
            anim.SetTrigger("GameOver");
        }
    }
}
```

## 设置Game Over Manager组件

Player Health：Player；

# 尾声

到此整个游戏已经完成，开心的体验这款游戏吧。 有任何问题欢迎留言！