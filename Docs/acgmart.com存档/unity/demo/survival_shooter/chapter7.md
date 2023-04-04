---
title: Unity官方教程-生存射击 Survival Shooter 第七章 暂停
categories:
- [Unity, Demo, Survival Shooter]
date: 2018-08-21 21:04:26
cover: https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/unity/demo/survival_shooter/cover.png
---

\[toc\]本篇为Unity官方教程-生存射击 Survival Shooter的第七章。 本系列教程面对刚接触Unity的新手，并尝试帮助新手创建自己的第一个游戏。 从第一章开始看可以跳转至：[https://acgmart.com/unity/8/](https://acgmart.com/unity/8/ "https://acgmart.com/unity/8/") 在第六章中，我们实现了计分板功能和游戏结束时的UI动画。 但是我们的游戏还不能暂停，一旦开始它就必须持续到玩家死亡。 现在我们来创建一个暂停功能，游戏过程中可以随时按ESC键暂停，还可以调整音量。 与前面6章不同的是，本章目前没有中日字幕，但是依旧可以在asset包中找到资源以及官网上看2段新的视频。

# 菜单

菜单可以在游戏中途按ESC键呼出，暂停游戏，和调整音量。 在场景资源列表中创建Canvas并重命名为MenuCanvas； 设置MenuCanvas的Canvas组件默认关闭； 创建C#脚本PauseManager.cs，并添加为MenuCanvas组件； 创建C#脚本MixLevels.cs，并添加为MenuCanvas组件；

## 编辑PauseManager.cs

```csharp
using UnityEngine;
using System.Collections;
using UnityEngine.UI;
using UnityEngine.Audio;
#if UNITY_EDITOR
using UnityEditor;
#endif

public class PauseManager : MonoBehaviour {

    public AudioMixerSnapshot paused;
    public AudioMixerSnapshot unpaused;

    Canvas canvas;

    void Start()
    {
        canvas = GetComponent<Canvas>();
    }

    void Update()
    {
        if (Input.GetKeyDown(KeyCode.Escape))
        {
            canvas.enabled = !canvas.enabled;
            Pause();
        }
    }

    public void Pause()
    {
        Time.timeScale = Time.timeScale == 0 ? 1 : 0;
        Lowpass ();

    }

    void Lowpass()
    {
        if (Time.timeScale == 0)
        {
            paused.TransitionTo(.01f);
        }

        else

        {
            unpaused.TransitionTo(.01f);
        }
    }

    public void Quit()
    {
        #if UNITY_EDITOR 
        EditorApplication.isPlaying = false;
        #else 
        Application.Quit();
        #endif
    }
}
```

## 设置Pause Manager组件

Paused：Paused； Unpaused：Unpaused；

## 编辑MixLevels.cs

```csharp
using UnityEngine;
using System.Collections;
using UnityEngine.Audio;

public class MixLevels : MonoBehaviour {

    public AudioMixer masterMixer;

    public void SetSfxLvl(float sfxLvl)
    {
        masterMixer.SetFloat("sfxVol", sfxLvl);
    }

    public void SetMusicLvl (float musicLvl)
    {
        masterMixer.SetFloat ("musicVol", musicLvl);
    }
}
```

## 设置Mix Levels组件

Master Mixer：MasterMixer；

# 创建暂停面板

就如同本节目录一样，我们将创建许多的按钮、开关、滑块，这些都属于UI知识的一部分。 我们需要在正确的位置放置我们期望的UI，再为其设置参数。 创建MenuCanvas的Panel子对象并重命名为PausePanel； 设置PausePanel： Anchor： Min：0，0； Max：1，1; 左上右下：150，80，150，60 Source Image：GUIPanel\_0； Color：179，167，223，201；

## 创建面板标题

创建PausePanel的Text子对象PausedText； 设置PausedText： Anchor： Min：0.5，1； Max：0.5，1; Pivot：0.5，1； PosX:0；PosY:-30; Width:130;Height：30； Text：PAUSED； Font：LuckiestGuy； Font Size：50； Alignment：居中，居中； Horizontal Overflow：Overflow； Vertical Overflow：Overflow； Color：255，255，255，255 为Text添加Shadow组件，并进行设置： Effect Distance：2，-2；

## 创建退出按钮

创建PausePanel的ButtoN子对象QuitButton； 设置QuitButton： Anchor： Min：0，0； Max：0，0; Pivot：0，0； PosX:50;PosY:22.5; Width:130;Height：60； Souce Image：GUIButtonDefault\_0； Transition：Sprite Swap； Transition-Highlighted Sprite：GUIButtonHighlighted\_0； Transition-Pressed Sprite：GUIButtonPressed\_0；

## 设置QuitButton的触发事件

在Button脚本下部，添加On Clik()事件： 类型：Editor And Runtime； 目标：场景资源MenuCanvas； 动作：PauseManager→Quit()；

## 设置QuitButton的Text子对象：

Text：QUIT GAME Font：LuckiestGuy； Font Size：20； Alignment：居中，居中； Color：255，255，255，255； 为Text添加Shadow组件，并进行设置： Effect Distance：2，-2；

## 创建继续按钮

创建PausePanel的ButtoN子对象ResumeButton； 设置ResumeButton： Anchor： Min：1，0； Max：1，0; Pivot：1，0； PosX:-50;PosY:22.5; Width:130;Height：60； Souce Image：GUIButtonDefault\_0； Transition：Sprite Swap； Transition-Highlighted Sprite：GUIButtonHighlighted\_0； Transition-Pressed Sprite：GUIButtonPressed\_0；

## 设置ResumeButton的触发事件

在Button脚本下部，添加On Clik()事件： 类型：Editor And Runtime； 目标：场景资源MenuCanvas； 动作：Canvas→bool enabled； 继续在Button脚本下部，添加On Clik()事件： 类型：Editor And Runtime； 目标：场景资源MenuCanvas； 动作：PauseManager→Pause()；

## 设置QuitButton的Text子对象：

Text：RESUME Font：LuckiestGuy； Font Size：20； Alignment：居中，居中； Color：255，255，255，255； 为Text添加Shadow组件，并进行设置： Effect Distance：2，-2；

## 创建声音开关

创建PausePanel的Toggle子对象AudioToggle； 设置AudioToggle： Anchor：Min:0.5，0；Max：0.5，0； Pivot：0.5，0； Width：150；Height：30； PosX：-5；PosY:100； Normal Color：128，128，128，128； Highlighted Color：128，128，128，178； Pressed Color；88，88，88，178； Disabled Color：64，64，64，128； Color Multiplier：2；

## 设置AudioToggle的子对象Lable

Anchor：Min:1，0.5；Max：1，0.5； Pivot：1，0.5； Width：121；Height：30； PosX：9；PosY:-3； Text：SOUD ON/OF； Font：LuckiestGuy； Font Size：19； Alignment：居中，居中； Horizontal Overflow：Overflow； Color：255，255，255，255； 为Text添加Shadow组件，并进行设置： Effect Distance：2，-2；

## 设置AudioToggle的子对象Background

Anchor：Min:0，0.5；Max：0，0.5； Pivot：0.5，0.5； Width：28；Height：28； PosX：15；PosY:0； Source Image：UIToggleBG； 设置Background的子对象Checkmark Anchor：Min:0.5，0.5；Max：0.5，0.5； Pivot：0.5，0.5； Width：25；Height：25； PosX：0；PosY:0； Source Image：UIToggleButton；

## 创建效果音调节

创建PausePanel的Slider子对象EffectsSlider； 设置EffectsSlider： Anchor：Min:0.5，0.5；Max：0.5，0.5； Pivot：0.5，0.5； Width：300；Height：20； PosX：0；PosY:-17； Normal Color：128，128，128，128； Highlighted Color：128，128，128，178； Pressed Color；88，88，88，178； Disabled Color：64，64，64，128； Color Multiplier：2； Min Value：-80 Max Value：-10 Value：-10

### 在Slider脚本下部，添加On Clik()事件：

类型：Editor And Runtime； 目标：场景资源MenuCanvas； 动作：MixLevels→SetSfxLvl；

### 删除EffectsSlider的Background子对象：

### 选中EffectsSlider，为其添加Image组件

设置Image： Source Image：GUISliderBG\_0；

### 设置Fill Area

Anchor：Min:0，0；Max：1，1； Pivot：0.5，0.5； 右下左上：7，2，7，2；

### 设置Fill Area的子对象Fill：

Source Image：GUISliderFill\_0；

### 设置Handle Slide Area

Anchor：Min:0，0；Max：1，1； Pivot：0.5，0.5； 右下左上：10，10，10，10；

### 设置Handle Slide Area的子对象Handle：

Pivot：0.5，0.5； Width：30；Bottom：-15 PosX:0;Top:-15； Source Image：UISliderHandle；

### 创建EffectsSlider的Text子对象，并进行编辑

Anchor：Min：0.5，1；Max：0.5，1; Pivot：0.5，1； Width:130;Height：30； PosX:0；PosY:30; Text：EFFECTS VOLUME； Font：LuckiestGuy； Font Size：20； Alignment：居中，居中； Horizontal Overflow：Overflow； Vertical Overflow：Overflow； Color：255，255，255，255

### 为Text添加Shadow组件，并进行设置：

Effect Distance：2，-2；

## 创建背景音乐调节

创建PausePanel的Slider子对象MusicSlider； 设置MusicSlider： Anchor：Min:0.5，0.5；Max：0.5，0.5； Pivot：0.5，0.5； Width：300；Height：20； PosX：0；PosY:45； Normal Color：128，128，128，128； Highlighted Color：128，128，128，178； Pressed Color；88，88，88，178； Disabled Color：64，64，64，128； Color Multiplier：2； Min Value：-80 Max Value：-10 Value：-10

### 在Slider脚本下部，添加On Clik()事件：

类型：Editor And Runtime； 目标：场景资源MenuCanvas； 动作：MixLevels→SetMusicLvl；

### 为MusicSlider添加Image组件

设置Image： Source Image：GUISliderBG\_0；

### 删除MusicSlider的Background子对象

### 设置Fill Area

Anchor：Min:0，0；Max：1，1； Pivot：0.5，0.5； 右下左上：7，2，7，2；

### 设置Fill Area的子对象Fill：

Source Image：GUISliderFill\_0；

### 设置Handle Slide Area

Anchor：Min:0，0；Max：1，1； Pivot：0.5，0.5； 右下左上：10，10，10，10；

### 设置Handle Slide Area的子对象Handle：

Pivot：0.5，0.5； Width：30；Bottom：-15 PosX:0;Top:-15； Source Image：UISliderHandle；

## 创建MusicSlider的Text子对象，并进行编辑

Anchor：Min：0.5，1；Max：0.5，1; Pivot：0.5，1； Width:130;Height：30； PosX:0；PosY:30; Text：MUSIC VOLUME； Font：LuckiestGuy； Font Size：20； Alignment：居中，居中； Horizontal Overflow：Overflow； Vertical Overflow：Overflow； Color：255，255，255，255

### 为Text添加Shadow组件，并进行设置：

Effect Distance：2，-2；

# 为游戏音效输出赋值

找到Player、GunBarrelEnd、BackgroundMusic、Hellephant、ZomBear、Zombunny，并为其Audio Source-Output分别赋值为Player、Gunshots、Music、Enemies、Enemies、Enemies。

# 后记

关闭游戏音效的开关没有生效，事实上是否启用Audio Listener都无法起到暂停音乐的效果。 这个地方的实现思路可以是这样的：创建声音管理器，比如AudioManager.cs；项目中所有代码在播放音乐时都先判断音效管理器的设置，而音量调节/音效调节改变的是AudioManager中的参数，达到所有音效由AudioManager统一管理的目的。 下面是我自己对照本教程打包出来的练习作，仅供参考。 [个人练习的打包](https://pan.baidu.com/s/1tmXu1lNgv1QKb3gxohCq-Q "个人练习的打包")