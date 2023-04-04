---
title: 从0开始的Unity3D游戏开发 v0.1.15 斗地主DEMO
categories:
- [Unity, ET]
date: 2018-08-24 01:03:56
---

\[toc\]本篇将使用ET4.0重构3.2版本的斗地主DEMO 斗地主DEMO是我目前手头上唯一的ET框架写的游戏源代码，作为学习资料来说意义重大。 虽然斗地主是纯2D的，而且逻辑都在服务端，有很大局限性，但是也没有办法，先把斗地主吃透了再拓展到其他分野吧。 本篇中的任务会很繁重，重新制作Prefab/重写消息结构会很耗时，所以文中的内容会主要以通信顺序来讲解斗地主游戏的实现思路。

# 运行斗地主DEMO

斗地主DEMO的github下载可以在ET的github介绍中查看。 [百度盘备份](https://pan.baidu.com/s/1_NlF36XHBb6Lx8OoRZPL2A "百度盘备份")。 客户端使用Unit2017.3-2018.2之间的版本可以平滑打开，运行Landlords/Scenes/Main这个场景文件。 我个人的话，使用2018.2.11f1，打开工程后Main.scene，开启Unsafe Code，重新编译后即可运行。 服务端使用Visual Studio打开即可。 在尝试发布到云端时发现，貌似不能简单的修改OuterConfig达成，所以先本地调试。 在调试初期的时候，会先运行斗地主服务端，然后修改ET4.0客户端来达到适配目的。 当客户端升级完毕后，再用4.0的客户端来调试修改4.0的服务端，实现斗地主DEMO的版本升级。

# Scene

斗地主的Scene多了一个Canvas：RoomCanvas 这个Canvas设置上的区别是Reference Pixels Per Unit为500，每单位的像素数更多。 新增了大量的Bundle,可以在Bundles/UI/Landlords下查看。

## ClientComponent

斗地主客户端的第一个自定义组件ClientComponent 定义了静态唯一实例Instance和User成员LocalPlayer 在登陆成功后设置改实例为当前玩家： `ClientComponent.Instance.LocalPlayer = user;`

## User

User继承于Entity，Entity在ECS概念中充当实体，可以理解为有Id属性的组件，可以向其添加/移除组件。 User的Awake方法需要一个long参数作为UserID。

## ETHotfix.Init

`Game.Hotfix.LoadHotfixAssembly();` 在ETModel.Int中，加载Hotfix.dll的程序集，指定的开始函数为ETHotfix.Init.Start方法。

## Start

注册热更层回调：使Model层可以处理热更层的Update任务； 热更层和Model层分别运行着一个场景，只有向场景中添加组件才能实现对应的功能。 Component包含数据和自身的功能。 Entity之间互相没有直接联系，作为场景中的实体存在。 UIComponent：使热更层能新建/移除/管理UI OpcodeTypeComponent：使热更层能管理/获取opcode和对应的type MessageDispatherComponent：使热更层能管理消息处理方法 为热更层添加了这些组件，则可以在热更层新建UI/新建opcode/新建消息句柄 ConfigComponent：加载资源服下载的配置，可以用Get方法找到对应的配置 Game.EventSystem.Run(string）：运行指定Event事件 需要事先注册带有使用有参方法实例化特性的类，如： `[Event(EventIdType.LandlordsInitSceneStart)]` 表明该类具有Event特性，并使用字符串作为EventAttribute实例化的参数。 程序就能通过词典allEvents，以string为key找到type，并执行type.Handle方法。 使用注册方式的函数和单独执行效果一样，好处在于便于管理大量同类型的行为。 该方法会维护一个词典，在其组件初始化时添加全部本特性的type进词典，并找出程序要执行的那一个。

## LandlordsInitSceneStart

`UI ui = Game.Scene.GetComponent<UIComponent>().Create(UIType.LandlordsLogin);` 创建登陆UI,和上一节描述的一样，这里是从词典中找到LandlordsLogin对应的IUIFactory子类。 然后使用LandlordsLoginFactory的Create方法创建UI对象/gameobject对象。 `(GameObject)resourcesComponent.GetAsset($"{type}.unity3d", $"{type}");` 因为代码中直接用bundle名实例化gameobject，所以设置bundle标签时也要一一对应。 最终得到场景中的gameobject实例，默认会显示在场景的最上级。 在UIComponent.Create方法中，会为gameobject设置指定的transform父级。 如果指定的父级不存在/没有添加进ReferenceCollector会报错。 `UI ui = ComponentFactory.Create<UI, GameObject>(login);` 使用gameobject创建UI类型的component，将游戏类实物转化为ET中的组件。 这里的UI是ET中的Entity，只具有数据。 `ui.AddComponent<LandlordsLoginComponent>();` 为UI添加组件，使其具备对应的功能。

## LandlordsLoginComponent

`ReferenceCollector rc = this.GetParent<UI>().GameObject.GetComponent<ReferenceCollector>();` `rc.Get<GameObject>("LoginButton").GetComponent<Button>().onClick.Add(OnLogin);` `rc.Get<GameObject>("RegisterButton").GetComponent<Button>().onClick.Add(OnRegister);` 通过ReferenceCollector来找到指定名称的gameobject，子级物体一定要添加进ReferenceCollector。 这里使用`onClick.Add(OnLogin);`为Button组件添加事件。

## OnRegster

```
连接到127.0.0.1:10002
发送消息 flag0 opcode10013 message{"Parser":{},"RpcId":1,"Account":"nnnnjvvb","Password":"ubub"}
收到热更 flag1 opcode10014  消息{"Parser":{},"RpcId":1,"Error":0,"Message":""}
```

创建Session，发出注册请求，收到的消息中ErrorCode为0则注册成功。 finally sessionWrap?.Dispose(); isRegistering = false; 完成注册后销毁Session。

## OnLogin

```
连接到127.0.0.1:10002
发送消息 flag0 opcode10011 message{"Parser":{},"RpcId":2,"Account":"nnnnjvvb","Password":"ubub"}
收到热更 flag1 opcode10012  消息{"Parser":{},"RpcId":2,"Error":0,"Message":"","Key":1655428447942988025,"Address":"127.0.0.1:10002"}
连接到127.0.0.1:10002
发送消息 flag0 opcode10015 message{"Parser":{},"RpcId":3,"Key":1655428447942988025}
收到热更 flag1 opcode10016  消息{"Parser":{},"RpcId":3,"Error":0,"Message":"","PlayerID":382320565892101,"UserID":382320565892075}
登录成功
```

Realm服务器用于处理注册/帐号登陆验证/登陆Key/转发Gate服务器端口 客户端使用Key向网关服务器请求登陆， `CreateWithId<T, A>(long id, A a)` g2C\_LoginGate\_Ack.PlayerID：long ComponentWithId.Id g2C\_LoginGate\_Ack.UserID：long User.UserID 客户端创建User组件，并设置User的Id和UserID `Game.Scene.GetComponent<UIComponent>().Create(UIType.LandlordsLobby);` `Game.Scene.GetComponent<UIComponent>().Remove(UIType.LandlordsLogin);` 登陆界面的任务完成，创建大厅界面并移除登陆界面。

## SessionOfflineComponent

重写了Dispose方法用于处理Session断开后的下线任务。

## Version.txt

新增Bundle时，应在Version.txt中新增文件： "landlordslogin.unity3d":{"File":"landlordslogin.unity3d","MD5":"","Size":0}, "landlordslogin.unity3d.manifest":{"File":"landlordslogin.unity3d.manifest","MD5":"","Size":0}, "landlordslobby.unity3d":{"File":"landlordslobby.unity3d","MD5":"","Size":0}, "landlordslobby.unity3d.manifest":{"File":"landlordslobby.unity3d.manifest","MD5":"","Size":0},

# LandlordsLobby

在UI工厂中以prefab创建gameobject，所有的UI都是如此。 不同之处在于添加的Component不同，这里被添加的是：LandlordsLobbyComponent。 LandlordsLobbyComponent在初始化时，发送C2G\_GetUserInfo\_Req消息获取UserInfo，添加匹配事件。 `发送消息 flag0 opcode10017 message{"Parser":{},"RpcId":3,"UserID":382317591528245}` `收到热更 flag1 opcode10018 消息{"Parser":{},"RpcId":3,"Error":0,"Message":"","NickName":"用户bidll","Wins":0,"Loses":0,"Money":9800}`

## OnStartMatch

发送C2G\_StartMatch\_Req消息请求匹配，满足匹配条件时，直接切换到房间界面。 设置LandlordsRoomComponent状态为Matching。 `发送消息 flag0 opcode10019 message{"Parser":{},"RpcId":4}` `收到热更 flag1 opcode10020 消息{"Parser":{},"RpcId":4,"Error":0,"Message":""}` ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/postunity15_1.png)

# LandlordsRoom

LandlordsRoomFactory创建UI实例； 除了LandlordsRoom.unity3d外，还加载了Atlas.unity3d/HandCard.unity3d/PlayCard.unity3d。 添加了GamerComponent/LandlordsRoomComponent GamerComponent：使room具有管理座位的能力，gamers是由3个Gamer组成的数组容器。 LandlordsRoomComponent：使room具有房间管理能力。

## LandlordsRoomComponent

实例化LandlordsRoom，绑定退出/准备事件，隐藏倍率/准备按钮/牌桌（地主3张牌）。 `User localPlayer = ClientComponent.Instance.LocalPlayer;` `Gamer localGamer = GamerFactory.Create(localPlayer.UserID, false);` 使用本地玩家创建Gamer实例。 `GetParent<UI>().GetComponent<GamerComponent>().Add(gamer, index);` 在UI的A组件中调用UI的B组件中的方法。 本地玩家Loacl在容器中的序列为1。 `gamer.GetComponent<GamerUIComponent>().SetPanel(this.GamersPanel[index]);` 将LandlordsRoom/Gamers下面的3个gameobject作为玩家面板，设置本地玩家的初始属性。 GamerUIComponent用于保存玩家在房间中的属性数据。

## OnQuit

`发送消息 flag0 opcode10021 message{"Parser":{}}` 切换到大厅界面。

## OnReady

发送Actor\_GamerReady\_Ntt消息。 玩家加入匹配队列/退出匹配队列的逻辑均在服务端完成，客户端在不需要具体动作时都不会有变化。

# Actor消息

如果有3个客户端同时排队，则满足创建房间的条件。 但是如果客户端没有对应的消息处理方法时，程序无法执行下去。 ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/postunity15_2.png) 这里以op10032进行说明。 因为opcode大于10000，所以由热更层Session处理。 flag不等于1，不是请求/回复消息，由热更层的MessageDispatherComponent处理。 在[之前的文章](https://acgmart.com/unity/unity11/ "之前的文章")中提到过如何创建消息处理类。 对于Actor消息来说，由于其收信无阻塞-消息排队等待的特性，消息处理方法中并不直接回复信源。 客户端主要的工作量就在于UI/消息结构/消息处理，这部分可以说是最后一部分任务。 本篇中有15个消息处理类。 `收到热更 flag0 opcode10032 消息{"RpcId":73,"ActorId":0,"Gamers":[{"UserID":382317591528245,"IsReady":false},{"UserID":382317613945136,"IsReady":false},{"UserID":382329017931968,"IsReady":false}]}` op10032完成匹配消息：Actor\_GamerEnterRoom\_Ntt `收到热更 flag0 opcode10022 消息{"RpcId":62,"ActorId":0,"UserID":382317613945136}` op10022单个玩家进入准备状态：Actor\_GamerReady\_Ntt `收到热更 flag0 opcode10038 消息{"RpcId":106,"ActorId":0,"UserID":382329017931968}` op10038指定玩家有抢地主权：Actor\_AuthorityGrabLandlord\_Ntt `收到热更 flag0 opcode10040 消息{"RpcId":118,"ActorId":0,"Multiples":2}` op10040倍率调整：Actor\_SetMultiples\_Ntt `收到热更 flag0 opcode10023 消息{"RpcId":119,"ActorId":0,"UserID":382329017931968,"IsGrab":true}` op10023单个玩家选择抢地主：Actor\_GamerGrabLandlordSelect\_Ntt `收到热更 flag0 opcode10039 消息{"RpcId":156,"ActorId":0,"UserID":382317591528245,"IsFirst":true}` op10039指定玩家有出牌权Actor\_AuthorityPlayCard\_Ntt

## Actor\_GamerEnterRoom\_NttHandler

进入房间消息，见斗地主Actor\_GamerEnterRoom\_NttHandler.cs。 先获取UI和UI身上的组件。 此时服务端凑齐了3个人，可以拼一桌，将此消息通知给这3个人。 客户端从匹配状态中退出，“准备”按钮变为激活状态。 从Actor\_GamerEnterRoom\_Ntt消息中获得玩家列表Gamers，并将玩家消息同步到界面。 如果没有消息处理类，则会报错： ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/postunity15_3.png) ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/postunity15_4.png) 处理代码：

```Charp
using UnityEngine;
using ETModel;

namespace ETHotfix
{
    [MessageHandler]
    public class Actor_GamerEnterRoom_NttHandler : AMHandler<Actor_GamerEnterRoom_Ntt>
    {
        protected override void Run(ETModel.Session session, Actor_GamerEnterRoom_Ntt message)
        {
            UI uiRoom = Game.Scene.GetComponent<UIComponent>().Get(UIType.LandlordsRoom);
            LandlordsRoomComponent landlordsRoomComponent = uiRoom.GetComponent<LandlordsRoomComponent>();
            GamerComponent gamerComponent = uiRoom.GetComponent<GamerComponent>();

            //从匹配状态中切换为准备状态
            if (landlordsRoomComponent.Matching)
            {
                landlordsRoomComponent.Matching = false;
                GameObject matchPrompt = uiRoom.GameObject.Get<GameObject>("MatchPrompt");
                if (matchPrompt.activeSelf)
                {
                    matchPrompt.SetActive(false);
                    uiRoom.GameObject.Get<GameObject>("ReadyButton").SetActive(true);
                }
            }

            //服务端发过来3个GamerInfo 当前玩家为其中一个
            //{"Parser":{},"UserID":382339254124924,"IsReady":false}
            int localGamerIndex = -1;
            for (int i = 0; i < message.Gamers.Count; i++)
            {
                if(message.Gamers[i].UserID==gamerComponent.LocalGamer.UserID)
                {
                    localGamerIndex = i;
                }
            }

            if(localGamerIndex == -1)
            {
                Log.Error("难道是旁观模式？");
            }

            //添加未显示玩家
            for (int i = 0; i < message.Gamers.Count; i++)
            {
                //如果服务端发来了默认空GamerInfo 跳过
                //{"Parser":{},"UserID":0,"IsReady":false}]}
                GamerInfo gamerInfo = message.Gamers[i];
                if (gamerInfo.UserID == 0)
                    continue;
                //如果这个ID的玩家不在桌上
                if (gamerComponent.Get(gamerInfo.UserID) == null)
                {
                    Gamer gamer = GamerFactory.Create(gamerInfo.UserID, gamerInfo.IsReady);
                    //localGamerIndex % 3可以理解为当前玩家在3个玩家（Gamers）中的顺序
                    //localGamerIndex + 1指当前玩家的下一个玩家的相对顺序
                    //如果本地玩家序列为2 localGamerIndex + 1) % 3=0 序列为0的玩家显示在2号位
                    if ((localGamerIndex + 1) % 3 == i)
                    {
                    //玩家在本地玩家右边
                        landlordsRoomComponent.AddGamer(gamer, 2);
                    }
                    else
                    {
                    //玩家在本地玩家左边
                        landlordsRoomComponent.AddGamer(gamer, 0);
                    }
                }
            }
        }
    }
}
```

此时大厅UI中的matchPrompt子物体被关闭，“正在匹配中...”字样消失。 “准备”按钮激活为可以点击状态。

## 准备

点击准备按钮后触发LandlordsRoomComponent的OnReady事件。 `发送消息 flag0 opcode10022 message{"Parser":{},"RpcId":0,"ActorId":0,"UserID":0}` `收到热更 flag0 opcode10022 消息{"Parser":{},"RpcId":394,"ActorId":0,"UserID":382339257926695}` 热更层发送一个默认的Actor\_GamerReady\_Ntt消息。 收到服务端返回的Actor\_GamerReady\_Ntt消息,通知本房间中有玩家状态变更。 触发Gamer的SetReady事件，如果已准备的是当前玩家则隐藏准备按钮。

## 游戏开始

当连续收到3次opcode10022 已准备消息后，3个玩家均已进入准备状态。 此时收到服务端发来的游戏开始消息opcode10037 Actor\_GameStart\_Ntt和抢地主权消息opcode10038 Actor\_AuthorityGrabLandlord\_Ntt。 `收到热更 flag0 opcode10037 消息{"Parser":{},"RpcId":75,"ActorId":0,"HandCards":[{"Parser":{},"CardWeight":9,"CardSuits":2},{"Parser":{},"CardWeight":4,"CardSuits":3},{"Parser":{},"CardWeight":8,"CardSuits":3},{"Parser":{},"CardWeight":14,"CardSuits":4},{"Parser":{},"CardWeight":0,"CardSuits":1},{"Parser":{},"CardWeight":8,"CardSuits":0},{"Parser":{},"CardWeight":12,"CardSuits":2},{"Parser":{},"CardWeight":10,"CardSuits":0},{"Parser":{},"CardWeight":11,"CardSuits":1},{"Parser":{},"CardWeight":2,"CardSuits":0},{"Parser":{},"CardWeight":12,"CardSuits":0},{"Parser":{},"CardWeight":2,"CardSuits":3},{"Parser":{},"CardWeight":12,"CardSuits":1},{"Parser":{},"CardWeight":13,"CardSuits":4},{"Parser":{},"CardWeight":2,"CardSuits":2},{"Parser":{},"CardWeight":6,"CardSuits":0},{"Parser":{},"CardWeight":2,"CardSuits":1}],"GamersCardNum":[{"Parser":{},"UserID":382339254124924,"Num":17},{"Parser":{},"UserID":382339256484632,"Num":17},{"Parser":{},"UserID":382339257926695,"Num":17}]}` 本地玩家获得自己的17张手牌，只能获得本桌其他玩家的手牌数量。 `收到热更 flag0 opcode10038 消息{"Parser":{},"RpcId":78,"ActorId":0,"UserID":382339254124924}` 指定玩家拥有抢地主权。

## 游戏开始消息处理

Actor\_GameStart\_NttHandler中处理游戏开始消息。 初始化玩家UI，游戏中的表现形式为： 玩家的提示信息重置，牌堆激活，上面显示数字表示牌的张数。 为每个玩家添加HandCardsComponent，用来控制牌面的显示。 HandCardsComponent中包含了手牌列表（Local/HandCards）/出牌列表(PlayCards) 为本地玩家添加手牌，为其他玩家显示手牌数。

```
//本地玩家添加手牌
Card[] Tcards = new Card[message.HandCards.Count];
for (int i = 0; i < message.HandCards.Count; i++)
{
    Tcards[i] = message.HandCards[i];
}
handCards.AddCards(Tcards);
```

将集合形式的HandCards转换为数组形式。 AddCards将遍历Card成员，使用HandCard这个prefab实例化gameobject，并添加到玩家面板。 词典cardsSprite以牌名为key，以牌的gameobject为value保存实例，因为在同一局中每一张扑克牌的名字都是唯一的，所以理论上查找结果过程是一一对应的。 handCards列表为玩家手牌的容器。 到这里**Card/HandCard/HandCards/Gamers/LandlordsRoom**之间的联系已经确立。 激活Desk，重置地主3张牌，设置Image子组件中的图片。 清空选中牌/设置初始倍率为1。

## interaction

房间组件有一个LandlordsInteractionComponent成员interaction。 就名字来说是使房间在对局情况下具有和用户互动的功能。 `uiRoomComponent.Interaction.Clear();` 在收到Actor\_GameStart\_Ntt消息时，会调用工厂类实例化/初始化interaction。 在Hieraichy（场景）中，Canvas下面的一级的gameobject都对应着一个(ET)Component。 `UI ui = ComponentFactory.Create<UI, GameObject>(room);` 使用（Unity）gameobject创造（ET）UI对象,向UI添加Component时也可以达到场景中添加子物体的效果，需要额外设置gameobject.tranform的父级。 使用UI.GameObject/UI.GetComponent可以直接访问gameobject； 使用`Component.GetParent<UI>()`可以获取Component的UI。 如果有gameobject（如HandCard），想获得对应的Card对象，则可以通过词典查询的方式查找。 前提是注册了这个词典，本例中handCards词典只能通过Card查找gameobject。 有了互动组件后，本地玩家就可以抢地主/不抢地主/请求提示/选牌/取消选牌/出牌/不出牌/进入托管/退出托管。 而LandlordsRoom组件包含的互动功能只有准备游戏/退出房间。

## 抢地主

客户端收到Actor\_AuthorityGrabLandlord\_Ntt消息后，如果抢地主权在本地玩家身上，则激活抢地主按钮。 在LandlordsInteractionComponent初始化时，grabButton/disgrabButton上绑定了事件。 OnGrab（抢地主） 向服务端发送`new Actor_GamerGrabLandlordSelect_Ntt() { IsGrab = true }` OnDisgrab（不抢地主） 向服务端发送`new Actor_GamerGrabLandlordSelect_Ntt() { IsGrab = false }` Actor\_GamerGrabLandlordSelect\_Ntt（服务端-抢地主消息） 服务端通知房间中的所有玩家，上一个抢斗地主权的操作结果。 如果是当前玩家则关闭抢地主按钮； 如果是其他玩家则设置其提示信息为“抢地主/不抢”

## 设置地主

Actor\_SetLandlord\_Ntt消息包含地主ID和地主3张（底牌）。 添加手牌： 如果是本地玩家，则将底牌添加到本地玩家的handCards； 如果是其他玩家，则直接设置手牌数为20。 设置头像 GamerUIComponent相当于玩家的UI面板，地主是LandlordsRoom/Gamers/(Left/Local/Right)。 遍历所有玩家，设置地主ID的玩家头像为地主，其他玩家为农民。 `Identity localGamerIdentity = gamerComponent.LocalGamer.GetComponent<HandCardsComponent>().AccessIdentity;` HandCardsComponent的AccessIdentity属性用于设置/获取玩家身份。 所以玩家身份并不在Gamer上，Gamer本体就只有UserID/IsReady这两个属性。 重置提示 在抢地主阶段可能留下“抢地主/不抢”等提示，完成抢地主后应重置。 显示地主3张牌 在抢地主阶段，底牌显示为背面，完成抢地主后应显示为地主获得的3张新牌。 `lordPokers.transform.GetChild(i).GetComponent<Image>()` 遍历gameobject下的所有子物体。 开始游戏 经过以上设定，本局游戏中玩家信息就彻底清晰了，接下来就是正式开始玩。 但是斗地主游戏不是rpg类型的游戏，并不是说游戏开始就可以移动/杀怪。 只有收到了“出牌权”的玩家才能出牌，没有出牌权的玩家只能等待。 互动组件Interaction决定了玩家可以做什么，此时只需要设置托管模式为“未托管”即可。 `收到热更 flag0 opcode10023 消息{"Parser":{},"RpcId":92,"ActorId":0,"UserID":382346015736589,"IsGrab":false}` Actor\_GamerGrabLandlordSelect\_Ntt：玩家抢地主的选择结果。 `收到热更 flag0 opcode10040 消息{"Parser":{},"RpcId":99,"ActorId":0,"Multiples":4}` Actor\_SetMultiples\_Ntt：有人被抢地主时，倍率翻倍。 `收到热更 flag0 opcode10041 消息{"Parser":{},"RpcId":115,"ActorId":0,"UserID":382346014097920,"LordCards":[{"Parser":{},"CardWeight":6,"CardSuits":0},{"Parser":{},"CardWeight":1,"CardSuits":1},{"Parser":{},"CardWeight":3,"CardSuits":1}]}` Actor\_SetLandlord\_Ntt：设置地主，宣布抢地主最终结果。 `收到热更 flag0 opcode10039 消息{"Parser":{},"RpcId":118,"ActorId":0,"UserID":382346014097920,"IsFirst":true}` Actor\_AuthorityPlayCard\_Ntt：指定一个玩家获得出牌权。 `收到热更 flag0 opcode10030 消息{"Parser":{},"RpcId":122,"ActorId":0,"UserID":382346015736589,"IsTrusteeship":true}` Actor\_Trusteeship\_Ntt：指定玩家进入托管模式。 `收到热更 flag0 opcode10026 消息{"Parser":{},"RpcId":126,"ActorId":0,"UserID":382346014097920,"Cards":[{"Parser":{},"CardWeight":0,"CardSuits":0},{"Parser":{},"CardWeight":0,"CardSuits":1}]}` Actor\_GamerPlayCard\_Ntt：指定玩家的出牌消息。 `发送消息 flag0 opcode10027 message{"Parser":{},"RpcId":8,"ActorId":0}` Actor\_GamerPrompt\_Req：客户端请求提示。 `收到热更 flag1 opcode10028 消息{"Parser":{},"RpcId":8,"Error":0,"Message":"","Cards":[{"Parser":{},"CardWeight":14,"CardSuits":4},{"Parser":{},"CardWeight":13,"CardSuits":4}]}` Actor\_GamerPrompt\_Ack：服务端回复提示。 `发送消息 flag0 opcode10030 message{"Parser":{},"RpcId":0,"ActorId":0,"UserID":0,"IsTrusteeship":true}` Actor\_Trusteeship\_Ntt：客户端通知服务端变更托管状态。 `收到热更 flag0 opcode10029 消息{"Parser":{},"RpcId":179,"ActorId":0,"UserID":382346015736589}` Actor\_GamerDontPlay\_Ntt：玩家不出。

## 出牌权

Actor\_AuthorityPlayCard\_Ntt消息指定一个玩家有出牌权。 客户端只需要针对被指定的玩家进行处理即可； 重置玩家提示信息：在上一轮可能在位置上留下“不出”的信息。 是否为先手 先手是斗地主游戏中玩家的一个状态。 先手的玩家必须出牌，出任意牌都可以，没有不出或者向服务端请求提示的选项。 在牌局中，地主的第一次出牌和每轮牌面最大的玩家的下一次出牌具是先手。 如果当前玩家获得出牌权，则显示出牌按钮。

## 出牌消息

客户端——出牌消息 按下出牌按钮就会出发OnPlay事件 currentSelectCards是互动组件的一个Card容器，将这个容器作为Actor\_GamerPlayCard\_Req请求消息发给服务端。 `List<Card>`与`RepeatedField<Card>`的转换。

```
Actor_GamerPlayCard_Req request = new Actor_GamerPlayCard_Req();
foreach(var a in currentSelectCards)
{
    request.Cards.Add(a);
}
```

请求发出后就会收到回复Actor\_GamerPlayCard\_Ack。 因为客户端上没有写出牌检查的逻辑，所以出牌检查是由服务端完成的。 通过Actor\_GamerPlayCard\_Ack消息判断出牌是否成功。 收到错误代码ERR\_PlayCardError则提示"您出的牌不符合规则！"。 服务端——出牌消息 客户端上的Onplay事件只能发请求消息，没有更多的操作，通知“有玩家出牌了”是服务端操作的。 Actor\_GamerPlayCard\_Ntt消息包含出牌玩家的ID和所出牌。 移除一张牌 从cardsSprite词典中移除 从handCards词典中移除 从Unity中移除 向cardsSprite词典添加牌 向playCards词典添加牌 卡牌的显示 HandCardsComponent的CardsSpriteUpdate方法处理了牌的排列顺序/间隔 HandCardsComponent 每个玩家（Gamer）都有HandCardsComponent 但是只有本地玩家的UI中才有HandCards； 只有其他玩家的UI中才有Poker； 所以本地玩家的\_poker为null，其他玩家的\_handCards为null。 gameobject为null，对应的`List<Card>`为空。 在Unity中每个玩家的出牌区PlayCards位置不一样，所以出牌时显示的位置不同。 `CreateCardSprite(PLAYCARD_NAME, card.GetName(), this.Panel.Get<GameObject>("PlayCards").transform);` 将使用PlayCard的prefab，以卡片名对应图片，在PlayCards下面创建子gameobject。 显示剩余牌数 因为本地玩家的\_poker为null，所以不会执行这部分代码。 其他玩家的手牌数量会更新。

## 选牌事件

就像热更层的消息处理类一样，Model层收到了消息时可以转交给热更层处理。 这里我们也希望，用户在点击牌面后，牌面会变更为“已选择状态”，也需要将事件转交给热更层处理。 但是，Model层和Hotfix层在不同的程序集，消息是如何传递给热更层的呢。 为gameobject添加点击事件 gameobject，比如Cube/地面等，一般情况下就算被点击也不会有行动，需要添加事件。

```
EventTrigger eventTrigger = gameObject.AddComponent<EventTrigger>();
eventTrigger.triggers = new List<EventTrigger.Entry>();
EventTrigger.Entry clickEntry = new EventTrigger.Entry();
clickEntry.eventID = EventTriggerType.PointerClick;
clickEntry.callback = new EventTrigger.TriggerEvent();
clickEntry.callback.AddListener(new UnityAction<BaseEventData>(OnClick));
eventTrigger.triggers.Add(clickEntry);
```

在HandCard上附着的HandCardSprite脚本通过以上代码为其gameobject添加了OnClick事件。 HandCardSprite的bool成员isSelect默认为非真，所以初次点击执行非真条件内容。 `Game.EventSystem.Run(EventIdType.SelectHandCard, Poker);` EventSystem会从allEvents词典中找到已注册的事件类，转交其处理，和消息处理的方式类似。 在Model层已经加载过了Hotfix的程序集，见ETModel.Hotfix.LoadHotfixAssembly方法。 移动gameobject（牌） 这里的gameobject是UI,我们要做竖向移动： `rectTransform.anchoredPosition += Vector2.up * move;`

## AEvent

热更层有2个事件，分别是选择牌和取消选择牌。 分别调用Interaction的SelectCard方法和CancelCard方法就好。

## 不出

服务端-不出消息 和出牌消息一样，客户端就算不出牌也得关闭出牌按钮。 其他玩家则清空出牌和更新提示信息为“不出”。 `发送消息 flag0 opcode10024 message{"Parser":{},"RpcId":14,"ActorId":0,"Cards":[{"Parser":{},"CardWeight":1,"CardSuits":1},{"Parser":{},"CardWeight":1,"CardSuits":2},{"Parser":{},"CardWeight":1,"CardSuits":3},{"Parser":{},"CardWeight":0,"CardSuits":1}]}` Actor\_GamerPlayCard\_Req：出牌请求。 `收到热更 flag1 opcode10025 消息{"Parser":{},"RpcId":14,"Error":0,"Message":""}` Actor\_GamerPlayCard\_Ack：出牌请求回复。 `收到热更 flag0 opcode10026 消息{"Parser":{},"RpcId":371,"ActorId":0,"UserID":382350069270036,"Cards":[{"Parser":{},"CardWeight":10,"CardSuits":1}]}` Actor\_GamerPlayCard\_Ntt：牌局结束时，会收到3条连续的出牌消息，3个玩家同时摊牌。 `收到热更 flag0 opcode10043 消息{"Parser":{},"RpcId":386,"ActorId":0,"Winner":"2","BasePointPerMatch":100,"Multiples":4,"GamersScore":[{"Parser":{},"UserID":382346015736589,"Score":400},{"Parser":{},"UserID":382346018292973,"Score":-800},{"Parser":{},"UserID":382350069270036,"Score":400}]}` Actor\_Gameover\_Ntt：游戏结束消息。 `收到热更 flag0 opcode10035 消息{"Parser":{},"RpcId":748,"ActorId":0,"Multiples":2,"GamersState":[{"Parser":{},"UserID":382346015736589,"Identity":1,"GrabLandlordState":false},{"Parser":{},"UserID":382346018292973,"Identity":1,"GrabLandlordState":false},{"Parser":{},"UserID":382350069270036,"Identity":2,"GrabLandlordState":true}],"LordCards":[{"Parser":{},"CardWeight":10,"CardSuits":2},{"Parser":{},"CardWeight":13,"CardSuits":4},{"Parser":{},"CardWeight":12,"CardSuits":3}],"DeskCards":"������V"}` Actor\_GamerReconnect\_Ntt：本地玩家掉线重连后会收到本条消息，DeskCards原为词条类型，这里强制转换为string类型，所以没有读出来。 在旧斗地主DEMO中，DeskCards包含一个Key和一个Value，Key是玩家ID,Value是手牌。 3.2版本的ET中使用的是Protobuf-net，4.0版本的ET使用的修改过的版本，在数据结构支持上有差别。 4.0版本的ET目前支持int32/int64/string/bool/bytes(IMessage)。 在测试阶段，遇到了无法处理的数据类型，我会先用一个值来代替。

## 游戏结束

斗地主Demo的内容很精简，没有报警阶段。 消息中，Winner原指enum类型参数，这个参数在使用工厂类生成LandlordsEnd的gameobject时，会传送给LandlordsEndComponent。 根据本地玩家是否胜利isWin判断是否显示Lose/Wind子gameobject。 玩家结算信息 ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/postunity15_5.png) ETHotfix.LandlordsEndComponent.CreateGamerContent方法虽然有winnerIdentity参数，但是没有使用过。 玩家结算信息面板间隔 如果没有设置过UI的坐标，其默认坐标为基于父级的0,0。 3个玩家结算信息之间需要有间隔，比如这里的100。 斗地主使用的方法为在GamerContent上添加Vertical Layout Group（垂直列表）组件。 gameobject使用了垂直列表组件后，其子物体不能设置Rect Transform。 可以设置padding/子物体间距/对齐方式等参数。

## LandlordsEndComponent

这个组件的作用单纯是制作统计面板，设置参数。

## 余额不足

服务端发给客户端的Actor\_GamerMoneyLess\_Ntt消息，直接触发退出房间事件。

## 玩家重连

当玩家掉线时，玩家的本地游戏数据会全部消失，所以只能靠服务器帮助恢复链接。 但是客户端无法确定自己自否是掉线玩家，所以只能在玩家加入匹配时，由服务端来判断。 `收到热更 flag0 opcode10032 消息{"Parser":{},"RpcId":230,"ActorId":0,"Gamers":[{"Parser":{},"UserID":382346015736589,"IsReady":false},{"Parser":{},"UserID":382346018292973,"IsReady":false},{"Parser":{},"UserID":382350069270036,"IsReady":false}]}` Actor\_GamerEnterRoom\_Ntt：进入房间消息，获得房间中原有玩家的ID，根据ID复原玩家基础信息。 `收到热更 flag0 opcode10037 消息{"Parser":{},"RpcId":231,"ActorId":0,"HandCards":[{"Parser":{},"CardWeight":8,"CardSuits":2},{"Parser":{},"CardWeight":11,"CardSuits":1},{"Parser":{},"CardWeight":10,"CardSuits":2},{"Parser":{},"CardWeight":8,"CardSuits":1},{"Parser":{},"CardWeight":2,"CardSuits":2},{"Parser":{},"CardWeight":1,"CardSuits":1},{"Parser":{},"CardWeight":6,"CardSuits":0},{"Parser":{},"CardWeight":8,"CardSuits":3},{"Parser":{},"CardWeight":9,"CardSuits":2},{"Parser":{},"CardWeight":3,"CardSuits":3},{"Parser":{},"CardWeight":6,"CardSuits":1},{"Parser":{},"CardWeight":11,"CardSuits":3},{"Parser":{},"CardWeight":9,"CardSuits":1},{"Parser":{},"CardWeight":3,"CardSuits":0},{"Parser":{},"CardWeight":12,"CardSuits":1},{"Parser":{},"CardWeight":7,"CardSuits":1}],"GamersCardNum":[{"Parser":{},"UserID":382346015736589,"Num":13},{"Parser":{},"UserID":382346018292973,"Num":14},{"Parser":{},"UserID":382350069270036,"Num":16}]}` Actor\_GameStart\_Ntt:开始游戏消息，但是这里获得的是服务端上最新牌局中玩家的手牌情况，根据此消息还原3个玩家的手牌状态。 `收到热更 flag0 opcode10039 消息{"Parser":{},"RpcId":232,"ActorId":0,"UserID":382350069270036,"IsFirst":false}` Actor\_AuthorityPlayCard\_Ntt：给予指定玩家出牌权，游戏可以继续进行。 `收到热更 flag0 opcode10035 消息{"Parser":{},"RpcId":233,"ActorId":0,"Multiples":8,"GamersState":[{"Parser":{},"UserID":382346015736589,"Identity":1,"GrabLandlordState":true},{"Parser":{},"UserID":382346018292973,"Identity":1,"GrabLandlordState":false},{"Parser":{},"UserID":382350069270036,"Identity":2,"GrabLandlordState":true}],"LordCards":[{"Parser":{},"CardWeight":12,"CardSuits":2},{"Parser":{},"CardWeight":7,"CardSuits":1},{"Parser":{},"CardWeight":12,"CardSuits":1}],"DeskCards":[{"Parser":{},"CardWeight":-560331539,"CardSuits":0}]}` Actor\_GamerReconnect\_Ntt：重连消息，根据此消息可以设置倍率/还原3个玩家的身份/是否抢过地主，地主3张牌，。 因为牌局在进行中，可以分为抢地主阶段和出牌阶段。 抢地主阶段有抢地主状态/倍率等因素，只要地主没有归属，抢地主阶段都不会停止。 出牌阶段3个玩家的手牌/出牌/提示区域都会有数据，可以看情况复原。手牌区域是最重要的，必须复原。 到此，ET4.0 斗地主客户端上的功能已经还原完成。

# 服务端

在处理服务端的时候稍微遇到了点麻烦。 我原本使用的是Unity2018.2.11版本，和3.2版本的ET服务端通信时是正常的，但是用Unity2018时ILRuntime会报错。 切换到Unity2017.4.11版本时与3.2版本的ET服务端通信出现不兼容。 这里为了避免出现无端的不兼容的问题（ILRuntime/Protobuf），客户端服务端统一使用了Unity2017.4.11版本。 出现不兼容时表现为找到不到关联（创建的克隆体transform挂不到指定目标上）/消息无法识别等等，还是少掉点头发为好。

## 创建一个新的服务端版本

步骤就是，在github下载最新的ET-master，将自定义的.protoc中的消息复制到新的文件中即可。 ET的版本升级后，默认文件.protoc中的消息结构可能发生变化，数量可能增多，使原有的opcode值发生变动，请注意。 这样一来我们就获得了一个可以成为版本0的服务端，如果用斗地主客户端来访问这个服务端，发过来消息会提示“XX消息没有处理”

## 服务端自启动（可选）

在服务端创建一个.sh文件，添加到开机启动脚本中。 我使用的Centos7.4 是/etc/rc.d/rc.local文件，添加一行命令即可后台运行/root/Test/start.sh程序。 nohup /root/Test/start.sh &

```
#! /bin/sh
sleep 10
cd /root/Server/publish
dotnet App.dll --appId=1 --appType=AllServer --config=../AllServer.txt
```

配合远程同步工具Rsync和ssh远程命令（免密码）可以实现一键同步/重启服务器/运行服务端的操作。

## 斗地主服务端组件

以下是斗地主服务端自定义全局组件

```
//GateGlobalComponent
Game.Scene.AddComponent<UserComponent>();
Game.Scene.AddComponent<LandlordsGateSessionKeyComponent>();

//MapGlobalComponent
Game.Scene.AddComponent<RoomComponent>();

//MatchGlobalComponent
Game.Scene.AddComponent<AllotMapComponent>();
Game.Scene.AddComponent<MatchComponent>();
Game.Scene.AddComponent<MatcherComponent>();
Game.Scene.AddComponent<MatchRoomComponent>();

//RealmGlobalComponent
Game.Scene.AddComponent<OnlineComponent>();
```

斗地主DEMO有8个自定义组件，组件在接下来一个个进行说明。 需要额外开启数据库组件的初始化。 不用急着看每个组件具体功能，可以先处理消息，服务端收到消息时会引用对应的组件。

## Entity.AddComponent

Entity是概念上的实体，与其他“物体”没有直接联系的物体都可以称为Entity。 比如一张卡牌，一个人；一个人可以拿着几张卡牌，也可以把卡牌丢弃。 这里可以理解为这个人有一个容器组件（背包），容器中可以容纳复数的Entity。 这个人可以将容器组件的内容清空（丢弃卡牌），也可以卸载掉容器组件（删除背包）。 Entity的添加组件方法会有什么不同呢。 在AddComponent方法中，先寻找词典中是否包含同类型的Component，有的话会报错。 也就是说在全局范围内被添加的Component只能存在一次。 ISerializeToEntity 有部分继承了ISerializeToEntity接口的类会被保存进哈希表components里面。 和AddComponent方法一样，哈希表中保存的对象不会重复。 components容器在平时不会产生作用，调用Entity.EndInit方法可以重新添加components里的组件。 可能是服务端热更新用的吧~

## 处理注册/登陆消息

在处理任何消息之前，需要开启数据库。 本段落内容，可以参考我之前写的文章[ET注册登陆](https://acgmart.com/unity/unity11/)。 有一些不同的是，这里不需要自己写消息结构了，直接贴上消息处理方法即可。

## 迁移工程

把旧地主在Hotfix/Landlord和Model/Landlord文件夹中的内容迁移到新工程即可，有报错的话再解决。

## InnerMessage

InnerMessage供服务端内部传递消息使用，opcode从1001开始计算。 InnerMessage.proto的语法稍微有点不一样，结尾有一个括号。 编译方法和普通proto一样，会自动生成Server\\Model\\Module\\Message\\InnerMessage.cs 在下一篇中，将具体说明[斗地主4.0服务端](https://acgmart.com/unity/unity16/)。