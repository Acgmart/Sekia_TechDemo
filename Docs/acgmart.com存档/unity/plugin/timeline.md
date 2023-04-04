---
title: Timeline入门
categories:
- [Unity, 插件]
date: 2020-05-29 12:11:27
---

\[toc\]本篇描述使用Timeline工具进行逻辑互动。 首先是前人的总结： -- Timeline是很好的序列管理工具 -- Timeline可以很好的与游戏玩法无缝整合 -- Timeline能运用成不错的策划工具 Timeline介绍： 使用Unity都Timeline工具制作剧情内容、game-play序列，音乐序列和复杂的粒子效果。 比如说： 我们场景中有个人物GameObject，当用户按下技能按钮时，动作/音效/特效/物理检测+逻辑等**并行事件**。 如果是固定的剧情，我们可以将编辑好了的内容保存为.playable文件 ⇒ 执行播放。 在更复杂的情况下，我们需要有一个技能系统，能动态控制Timeline的流程：这个过程中不确定用户释放了哪个技能，但是可以通过查找策划表获得技能的类型、参数。 安装Timeline： 在Unity的包管理系统中，添加本包。 创建Timeline资源和打开对应的编辑器窗口： 文件夹内右键，Timeline。双击文件打开窗口。 官方资料： [Manual，比如我使用的1.3.2版本，对应1.3版本的文档。](https://docs.unity3d.com/Packages/com.unity.timeline@1.3/manual/index.html "Manual，比如我使用的1.3.2版本，对应1.3版本的文档。") Timeline 1.3版本配合Unity 2019.1或以上版本。

# Overview

每个Timeline由资源(Asset，序列化保存数据)和实例(Instance，C#)构成。 通过Timeline窗口，我们可以编辑资源和模拟实例的效果。 Asset：保存音乐/动作的动画序列，但是不与具体的GameObject关联 Instance：通过**Bindings**，保存于GameObject关联，用于在场景中播放动画。 资源决定了最终效果的播放形式，GameObject关联决定了播放的主体。 因为资源和实例的分离，我们可以复用资源，实现多个类似的实例效果。 举例： 可以创建一个叫做“Victory”的Timeline资源，里面包含动作、音乐、特效。 当玩家胜利时播放这个效果，不同的角色胜利时，关联不同的玩家模型。 注：复用资源时，对资源的修改将作用于所有使用该资源的实例。

# 使用Timeline窗口

使用Timeline窗口，编辑资源，实现录制/排期动画，创建剧情内容。

## 创建资源和实例

通过Playable Director组件关联资源，指定要驱动的目标(Bindings)，创建实例。 如果是一个人物模型，GameObject上必须要有Animator组件才可以播放动画。 创建资源与实例的步骤： 选择一个GameObject ⇒ 添加Playable Director组件 ⇒ 为组件关联资源 或者 在打开的Timeline窗口中点击Create按钮创建并关联该资源 关于资源的文件名：名称应完整代表该剧情的内容，比如，游戏有12个剧情章节，每个章节有不等的剧情Timeline，剧情可以是拜师、遇袭等。一看就懂的文件夹和命名，便于项目的扩展。

## 录制简易动画

在资源中新建一个Animation track，这表示一个并行的骨骼动画任务。 绑定目标：Animation track需要绑定一个GameObject，比如一个Cube。 开始录制：点击红色圆形“录制”按钮 在录制模式下，track对应的轨道区域变红，并被标记为“Recording”，录制按钮闪烁。GameObject的任何可动画属性都可以在轨道上Playhead(控制时间线的滑动条的滑柄)对应的当前位置添加关键帧。 添加动画属性：右键GameObject的属性名 ⇒ Add Key 设置时间刻度：拖动Playhead 在当前时间添加关键帧：在GameObject面板或Scene场景中，修改对应属性值。 关闭录制：再次点击录制按钮。 重新编辑生成的Clip：双击轨道区域，在Animation窗口中进行编辑。 保存资源：ctrl+S 注：Animation track需要一个GameObject作为驱动目标，transform、Animator组件、或者其他组件暴露的接口都可以作为动画属性。 同时，一个轨道同一时间只能控制一个物体播放一个动画，当多个动画相接的时候，可产生过渡效果。

## 将录制的Clip导出

录制的Clip作为关键帧列表显示在轨道上，无法拖动、剪辑，因为没有给它定义持续周期。 点击track的菜单按钮(录制按钮后面) ⇒　Convert to Clip Track

## 播放人形动画

Timeline窗口有3个Animation clip的编辑模式。 这里我们使用第一个模式，Mix mode，这个模式允许我们拖动、剪辑动画。 为一个人形GameObject创建资源和实例，拖动Animation clip到Animation track的轨道上。 **解决2个连续动画之间的终点位置和起点位置不一致**： 右键第二个Clip，Match Offsets to Previous Clip，将同步root骨骼的参数。 **解决2个连续动画之间过渡不自然**： 拖动2个动画的位置，使之间产生相交的部分，在Mix mode下，会产生过渡效果。 **解决动作之间脚位置不一致**： 手动控制偏移(offset)，在Timeline窗口中选中Animation clip，在对应的面板中设置Clip Transform Offsets。 这里的值并不为0表示，之前同步root骨骼修改了Offsets参数，现在是继续调整的过程。

## 动画的重写与遮罩

在编辑动画Controller(使用状态机播放动画)时，可以使用多个layer，混合多个layer来实现全身的动作，通过Avatar Mask实现遮罩。比如UnityChan的demo中第二个layer中包含大量上半身动作。 在Timeline中通过Animation Override track实现这个功能。 **创建Animation Override track**： 首先，使用Animation track正常播放动画，比如奔跑的动画。 右键Animation track，添加Animation Override track，向这个轨道添加Animation clip覆盖其父级中的对应帧。 **为Override添加遮罩**： 不添加遮罩的话，父级的动作将被完全重写。 选中Onimation Override track，在对应的Inspector中指定**Avatar Mask**。

## 镶嵌实例

Timeline界面锁：在Timeline界面右上角，可避免切换GameObjetc时丢失目标。 Timeline支持镶嵌实例，当团队与框架很大的时候，这样便于协作。 创建一个Control Track，将另一个Timeline拖放到轨道上，子级Timeine指向一个有Playable Director组件的GameObject。 子级的轨道长度受到父级中Control Track的Clip宽度设置限制(灰色区域不可用)。 也就是说： 主Timeline可以将部分逻辑，交给子Timeline完成。

# Timeline窗口相关

左上角的Preview按钮： 开启Scene中预览模拟效果。 轨道区上方左边的下箭头菜单： 当前场景中的Timeline实例列表。 每个选项对应Timeline资源+场景中的GameObject。 Timeline播放控制： 几个按钮分别是：返回初始帧、返回上一帧、播放/暂停、下一帧、末帧、指定播放范围、指定帧。 注：不支持音频倒放。 注：默认是60帧/秒。 Local/Global：对于镶嵌在其他Timeline的子级来说，可以切换时间刻度显示规则。

## Track(轨道)的两个区域：

标题区域：展现Tirack列表，每个Track有一个标题，包含GameObject关联信息。 剪辑区域：展现每个Track的动画构成。 Track标题区域左侧的颜色标记： 绿色:Activation Track 蓝色：Animation track + 动画Clip文件的图标 + Transform字段 橙色：Audio track 蓝绿色：Control track 白色：Playable track 灰色：Signal track 比较特殊的：Track Group Track常见操作： 多选、右键按住拖动、复制粘贴、删除、加锁防止被修改、禁用。 Track渲染顺序： 渲染顺序是从上往下处理。

## Track组

在游戏里，或者UI编辑，我们把很多单位划分为一个组，便于统一行动。 比如多个track与同一个GameObejct互动时。 一个组还可以拥有子级组：右键组，Track Sub-Group。 组可以展开/收拢、加锁防止被修改。

## Clip编辑模式 - 剪辑

调整clip的宽度，拖动位置，拖动左端或右端，实现去头/去尾，实现简单的剪辑操作。 右键，Match Content，还原clip的长度。 调整clip的宽度时，不同的编辑模式，影响周围的clip的行为。 Mix mode：不影响相邻的clip，与相邻clip重叠时产生过渡效果。 Ripple mode：影响移动方向上所有其他clip的位置，统一靠左/靠右。 Replace mode：影响移动的目标范围中的其他clip，其他clip相交的部分被裁剪。 紧凑(tile) 选择一个轨道上的多个clip，右键tile，使多个clip无过渡紧凑相邻。 **Clip的Inspector**： Start/End/Duration：clip的持续范围，对应Timeline的时间刻度。 Clip in：动作剪辑后的播放起点，对应clip内的时间刻度。 **去除循环播放的Clip的多余部分**： 将一个Clip文件设置为循环播放，或者在Timeline中选择Clip，开启Loop。 右键，Editing，Trim Last Loop。 **使用Playhead的Clip剪辑操作**： 移动Playhead，以时间客户为分界线切割Trim Start/Trim End/Clip。 右键，Editing，Trim Start/Trim End/Clip。 **Clip之间的间隙对应GameObject的状态**： 我们知道clip的本质就是很多帧，没一帧是GameObject的一种状态；外加上GameObject在Scene的原状态。当2个Timeline的一个轨道中，两个Clip之间有空隙，空隙时间范围内GameObject状态/行为选择是可以指定的。 None：保持在Scene的原状态(或者Override的目标Clip) Hold(双环标记)：保持前一个Clip的最终状态/保持后一个Clip的初始状态。 **缓动效果**： 区别于两个Clip之间的过渡效果，缓动解决了Clip与Scene的原状态之间的过渡。 选中Clip，在Inspector中设置Ease In/Ease Out。 注：如音乐的淡入淡出效果。 **混合曲线**： 两个Clip之间的混合效果、缓动效果，默认都是线性的，可以设置为自定义曲线。 选中Clip，在Inspector中设置Blend Curves。 注：有很多关于剪辑的操作，简单理解为：如何精确控制Clip的开始和结束时间。 在播放动画这一点，Timeline可实现动画状态机的效果，且有更多拓展。 Timeline的特点是，处理多个Clip之间的联系。

## 曲线视图

录制的Clip可以打开对应的曲线模式，便于观察值的变化。 编辑操作类似于Animation界面。 快捷键：F，Focus，集中于某一个属性/物体。

## Timeline Settings

界面右上角的齿轮菜单。 时间刻度：秒/帧 Timeline实例的长度：基于轨道上的clip/固定长度 帧率：默认是60帧/秒 播放指定范围模式：需要按Play Range button开启，Loop/Hold。仅用于模拟。 显示音乐的波形图：开启/关闭 Enable Audio Scrubbing：拖动Playhead时，是否播放音乐。 Snap to Frame：以帧为单位，拖动Playhead时，移动到相近的帧的位置。 Edge Snap：移动clip时，吸附到Playhead或其他clip。

# Timeline Inspector

可以多选Clip，进行多选编辑，只有公共的属性会暴露在Inspector。 track面板：可更改轨道名称和属性。 Activation track： Post-playback state(Timeline实例播放后对资源绑定/GameObject的处理)： Active：保持GameObject enable。 Inactive：关闭GameObject。 Revert：恢复播放前GameObject的状态。 Leave As Is：保持播放结束时的状态。 Transform Offsets： 关于Transform的设置，核心是为了解决clip播放前后位置不统一的问题。 可以选择暴露那些参数供“自动对齐功能”调整，自动对齐后可以继续手动对齐。 Clip： Clip可以改写自身所在track的部分设置，也可以改写自身的播放内容(音乐、动作)的部分设置。 所以这里应理解为剪辑，在不修改源文件的情况下，通过可修改的参数实现自己的剪辑目的。 Playable Director： Update方法：主要是“是否接受时间缩放”。 Play On Awake/Initial Time：初始唤醒、延迟播放。 Warp Mode：播放完后如何处理： None(仅播放一次，然后恢复到Scene的原状态)； Loop(循环播放，直到被打断)； Hold(仅播放一次，然后保持最终帧，直到被打断)。