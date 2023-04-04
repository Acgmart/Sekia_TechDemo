---
title: Unity官方教程-生存射击 Survival Shooter 第四章 射击
categories:
- [Unity, Demo, Survival Shooter]
date: 2018-08-21 21:04:11
cover: https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/unity/demo/survival_shooter/cover.png
---

\[toc\]本篇为Unity官方教程-生存射击 Survival Shooter的第四章。 本系列教程面对刚接触Unity的新手，并尝试帮助新手创建自己的第一个游戏。 从第一章开始看可以跳转至：[https://acgmart.com/unity/8/](https://acgmart.com/unity/8/ "https://acgmart.com/unity/8/") 在第三章中，敌人已经可以自动追踪并攻击我们。 但是我们还不能还击，因为敌人还没有生命值，我们还不会攻击。 本章中也将复制第三章中的做法。

# 为敌人赋予生命值

新建C#脚本EnemyHealth，并添加为Zombunny的组件；

## 编辑EnemyHealth.cs

```csharp
using UnityEngine;

public class EnemyHealth : MonoBehaviour
{
    public int startingHealth = 100;
    public int currentHealth;
    public float sinkSpeed = 2.5f;
    public int scoreValue = 10;
    public AudioClip deathClip;

    Animator anim;
    AudioSource enemyAudio;
    ParticleSystem hitParticles;
    CapsuleCollider capsuleCollider;
    bool isDead;
    bool isSinking;


    void Awake ()
    {
        anim = GetComponent <Animator> ();
        enemyAudio = GetComponent <AudioSource> ();
        hitParticles = GetComponentInChildren <ParticleSystem> ();
        capsuleCollider = GetComponent <CapsuleCollider> ();

        currentHealth = startingHealth;
    }


    void Update ()
    {
        if(isSinking)
        {
            transform.Translate (-Vector3.up * sinkSpeed * Time.deltaTime);
        }
    }


    public void TakeDamage (int amount, Vector3 hitPoint)
    {
        if(isDead)
            return;

        enemyAudio.Play ();

        currentHealth -= amount;

        hitParticles.transform.position = hitPoint;
        hitParticles.Play();

        if(currentHealth <= 0)
        {
            Death ();
        }
    }


    void Death ()
    {
        isDead = true;

        capsuleCollider.isTrigger = true;

        anim.SetTrigger ("Dead");

        enemyAudio.clip = deathClip;
        enemyAudio.Play ();
    }


    public void StartSinking ()  //在Zombunny.fbx→Animation→Death→Events可以找到该函数引用
    {
        GetComponent <UnityEngine.AI.NavMeshAgent> ().enabled = false;
        GetComponent <Rigidbody> ().isKinematic = true;
        isSinking = true;
        //ScoreManager.score += scoreValue;
        Destroy (gameObject, 2f);
    }
}
```

## 设置Enemy Health组件

DeathClip：ZomBunny Death；

## 禁止敌人死亡后继续攻击

编辑Zombunny的脚本EnemyAttack.cs： 取消掉EnemyAttack.cs中的3处注释，当敌人生命值不大于0时将停止攻击；

# 开枪效果

找到GunParticles.prefab，复制(Copy Component)其Particle System； 粘贴到Player的子对象GunBarrelEnd，可以预览到枪口的火光效果;

## 添加枪的射线

为GunBarrelEnd添加组件Line Renderer； 设置Line Renderer： 取消Line Renderer默认开启； Cast Shadows：Off； Receive Shadows：取消； Materials-Element0:LineRenderMaterial Width：0.05 Reflection Probes：Blend Probes；

## 添加光源

为GunBarrelEnd添加组件Light； 设置Light： 取消Light默认开启； Type：Spot； Spot Angle：75； Color：255，221，81，255； Intensity：3.5； Indirect Multiplier：5； Shadow Type：Hard Shadows;

## 添加枪声

为GunBarrelEnd添加组件Audio Source； 设置Audio Source: Audio Clip：Player GunShot； 取消Play On Awake；

# 让玩家可以开枪

创建C#脚本PlayerShooting,并拖拽到GunBarrelEnd；

## 编辑PlayerShooting.cs

```csharp
using UnityEngine;

public class PlayerShooting : MonoBehaviour
{
    public int damagePerShot = 20;
    public float timeBetweenBullets = 0.15f;
    public float range = 100f;


    float timer;
    Ray shootRay = new Ray();
    RaycastHit shootHit;
    int shootableMask;
    ParticleSystem gunParticles;
    LineRenderer gunLine;
    AudioSource gunAudio;
    Light gunLight;
    float effectsDisplayTime = 0.2f;


    void Awake ()
    {
        shootableMask = LayerMask.GetMask ("Shootable");
        gunParticles = GetComponent<ParticleSystem> ();
        gunLine = GetComponent <LineRenderer> ();
        gunAudio = GetComponent<AudioSource> ();
        gunLight = GetComponent<Light> ();
    }


    void Update ()
    {
        timer += Time.deltaTime;

        if(Input.GetButton ("Fire1") && timer >= timeBetweenBullets && Time.timeScale != 0)
        {
            Shoot ();
        }

        if(timer >= timeBetweenBullets * effectsDisplayTime)
        {
            DisableEffects ();
        }
    }


    public void DisableEffects ()
    {
        gunLine.enabled = false;
        gunLight.enabled = false;
    }


    void Shoot ()
    {
        timer = 0f;

        gunAudio.Play ();

        gunLight.enabled = true;

        gunParticles.Stop ();
        gunParticles.Play ();

        gunLine.enabled = true;
        gunLine.SetPosition (0, transform.position);

        shootRay.origin = transform.position;
        shootRay.direction = transform.forward;

        if(Physics.Raycast (shootRay, out shootHit, range, shootableMask))
        {
            EnemyHealth enemyHealth = shootHit.collider.GetComponent <EnemyHealth> ();
            if(enemyHealth != null)
            {
                enemyHealth.TakeDamage (damagePerShot, shootHit.point);
            }
            gunLine.SetPosition (1, shootHit.point);
        }
        else
        {
            gunLine.SetPosition (1, shootRay.origin + shootRay.direction * range);
        }
    }
}
```

# 处理怪物死亡

为了防止怪物死亡或者玩家死亡后，怪物的自动追踪功能继续运行而报错，在角色死亡时应关闭自动导航。 处理方法为取消EnemyMovement.cs中代码的注释。 取消注释的前提是我们已经建立好了怪物和玩家的生命系统。

# 处理玩家死亡

我们可以发现玩家死亡后依然可以开枪，现在我们需要在玩家开枪时判断玩家是否死亡。 处理方法为取消PlayerHealth.cs中的2处代码的注释。 取消注释的前提是我们已经建立好了射击功能。

# 总结

确认无误后，再次运行游戏，我们已经可以正确的杀死怪物，怪物也可以杀死我们。