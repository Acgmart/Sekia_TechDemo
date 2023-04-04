---
title: Unity官方教程-生存射击 Survival Shooter 第三章 生命
categories:
- [Unity, Demo, Survival Shooter]
date: 2018-08-21 21:04:04
cover: https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/unity/demo/survival_shooter/cover.png
---

\[toc\]本篇为Unity官方教程-生存射击 Survival Shooter的第三章。 本系列教程面对刚接触Unity的新手，并尝试帮助新手创建自己的第一个游戏。 从第一章开始看可以跳转至：[https://acgmart.com/unity/8/](https://acgmart.com/unity/8/ "https://acgmart.com/unity/8/") 在第二章中，我们已经让敌人可以自动追踪玩家。 但是敌人会一直追着玩家，却什么都不会发生，这是因为生命值和攻击的概念都没有做进入。 在本章中，我们将赋予玩家生命值，当敌人抓到玩家时对玩家产生伤害，直至玩家死亡。

# 玩家生命UI

在左上角切换Scene的模式为2D模式； 在场景资源目录创建一个Canvas(GameObject→UI→Canvas)； 重命名Canvas为HUDCanvas； Canvas的宽高会自动同步Scene视图，并不需要太多设置。

## 添加Canvas Group组件

Canvas Group使UI元素拥有透明度。 设置Canvas Group： 关闭交互(Interactable)； 关闭屏蔽射线(Blocks Raycasts)；

## 添加HealthUI子对象

为HUDCanvas创建一个空的子对象，并重命名为HealthUI； 设置HealthUI： Anchors：Min：0，0；Max：0，0；Pivot：0，0； Width：75；Height：60； PosX：0；PosY：0；

### 添加心形图片

为HealthUI添加一个Image子对象，重命名为Heart； 设置Heart： Width：30；Height：30； Source Image为Heart；

### 添加血条

为HealthUI添加一个Slider子对象，重命名为HealthSlider； 设置HealthSlider： Width为130；Height为20； PosX为95；PosX为0； 删除HealthSlider的子对象Handle Slide Area（滑动杆）； Slider-Transition：None； Min Value：0 Max Value：100； Value:100;

### 设置Background：

Anchors-Min：0，0； Anchors-Max：1，1； Top：0；Bottom：0； Image-Color-透明度：150

### 设置Fill Area

Left：10；Right：10

## 添加被击屏幕泛红效果

为HUDCanvas添加Image子对象并重命名为DamageImage； 设置DamageImage: Anchor：Min：0，0；Max：1，1； Pivot：0.5，0.5； Color：255，0，0，0； ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/unity/demo/survival_shooter/001.png) 到这里UI部分已经设置完成，可以在Game窗口左下角看到心形图标和满的血条。

# 玩家生命属性

我们已经有了UI显示效果，但是我们的玩家还不能被攻击，没有交互。 我们将通过C#脚本来实现玩家被攻击的效果。 创建一个C#脚本并重命名为PlayerHealth。

## 编辑PlayerHealth

```csharp
using UnityEngine;
using UnityEngine.UI;
using System.Collections;
using UnityEngine.SceneManagement;

public class PlayerHealth : MonoBehaviour
{
    public int startingHealth = 100;  //初始生命值
    public int currentHealth;  //当前生命值
    public Slider healthSlider;  //抓取生命条UI
    public Image damageImage;  //受伤效果图
    public AudioClip deathClip;  //死亡音效
    public float flashSpeed = 5f;   //
    public Color flashColour = new Color(1f, 0f, 0f, 0.1f);


    Animator anim;
    AudioSource playerAudio;
    PlayerMovement playerMovement;
    //PlayerShooting playerShooting;
    bool isDead;
    bool damaged;


    void Awake ()
    {
        anim = GetComponent <Animator> ();  //绑定动画
        playerAudio = GetComponent <AudioSource> ();  //绑定音效
        playerMovement = GetComponent <PlayerMovement> ();  //绑定自定义引动脚本
        //playerShooting = GetComponentInChildren <PlayerShooting> ();
        currentHealth = startingHealth;  //设置初始生命值
    }


    void Update ()
    {
        if(damaged)
        {
            damageImage.color = flashColour;  //受伤后从指定颜色开始变淡
        }
        else
        {
            damageImage.color = Color.Lerp (damageImage.color, Color.clear, flashSpeed * Time.deltaTime);
        }
        damaged = false;
    }


    public void TakeDamage (int amount)  //全局的，所以外部单元可以通过这个函数使玩家受伤
    {
        damaged = true;
        currentHealth -= amount;
        healthSlider.value = currentHealth;
        playerAudio.Play ();  //播放被击音乐
        if(currentHealth <= 0 && !isDead)
        {
            Death ();
        }
    }


    void Death ()
    {
        isDead = true;
        //playerShooting.DisableEffects ();
        anim.SetTrigger ("Die");
        playerAudio.clip = deathClip;
        playerAudio.Play ();
        playerMovement.enabled = false;
        //playerShooting.enabled = false;
    }

    public void RestartLevel ()  //在Player.fbx→Animation→Death→Events可以找到该函数引用
    {
        SceneManager.LoadScene (0);
    }
}
```

## 设置PlayerHealth脚本组件

将PlayerHealth拖放到资源Player上； Health Slider:HealthSlider; Damage Image:DamageImage; Death Clip:Player Death;

# 敌人会攻击

创建C#脚本EnemyAttack；

## 编辑EnemyAttack

```csharp
using UnityEngine;
using System.Collections;

public class EnemyAttack : MonoBehaviour
{
    public float timeBetweenAttacks = 0.5f;
    public int attackDamage = 10;


    Animator anim;
    GameObject player;
    PlayerHealth playerHealth;
    //EnemyHealth enemyHealth;
    bool playerInRange;
    float timer;


    void Awake ()
    {
        player = GameObject.FindGameObjectWithTag ("Player");
        playerHealth = player.GetComponent <PlayerHealth> ();
        //enemyHealth = GetComponent<EnemyHealth>();
        anim = GetComponent <Animator> ();
    }


    void OnTriggerEnter (Collider other)
    {
        if(other.gameObject == player)
        {
            playerInRange = true;
        }
    }


    void OnTriggerExit (Collider other)
    {
        if(other.gameObject == player)
        {
            playerInRange = false;
        }
    }


    void Update ()
    {
        timer += Time.deltaTime;

        if(timer >= timeBetweenAttacks && playerInRange/* && enemyHealth.currentHealth > 0*/)
        {
            Attack ();
        }

        if(playerHealth.currentHealth <= 0)
        {
            anim.SetTrigger ("PlayerDead");
        }
    }


    void Attack ()
    {
        timer = 0f;

        if(playerHealth.currentHealth > 0)
        {
            playerHealth.TakeDamage (attackDamage);
        }
    }
}
```

将EnemyAttack.cs拖拽到资源Zombunny上。 测试运行后我们可以观察到敌人靠近玩家时玩家生命值会减少。