---
title: 从0开始的Unity3D游戏开发 v0.1.16 斗地主4.0服务端
categories:
- [Unity, ET]
date: 2018-08-24 01:04:00
---

\[toc\]本篇内容为介绍ET4.0版本 斗地主服务端 上一篇因为已经有2万多字，编辑变得困难，故再开一篇。

# 移植ET项目

比如说，我以前用的ET3.6 或者4.0，我想要升级到更新的版本，比如ET5.0之类的，有哪些文件是我需要更改的吗。 又或者，我以前用的是Unity2017.4版本，现在我想升级到Unity2018.4版本，有哪些需要注意的吗。 为了方便迁移项目，这个问题是值得讨论的。

## Unity迁移

ET的github新版本会带有一个指定的Unity版本，比如目前我使用的Unity2017.4.11f1，建议使用ET推荐的版本。 迁移到2018.2版本也可以平滑打开，2018.3版本以上脚本api变化比较大可能出现问题，但是依然可以手动解决。 这里使用下载的ET-master文件夹中的Unity项目作为迁移目标； 有必要迁移的自定义文件夹一般为App名，比如Landlord： Assets/Hotfix/Landlord/ (迁移到新项目) Assets/Model/Landlord/ （迁移到新项目） Assets/Bundles/Landlord/ (我个人会把这个文件夹丢到Editor里面) Assets/Res/Code/ （这文件夹是给工具用来指定复制目的地的） Assets/Res/Config/GlobalProto.txt （我个人会把这个文件迁移到Resources） Assets/Res/Config/ （我个人会把这个文件夹丢到Editor/Bundles里面） Assets/Res/Unit/ （我个人会把这个文件夹丢到Editor/Bundles里面） Assets/Resources/ (迁移到新项目) Assets/Editor/ （如果有自己写的工具的话迁移到新项目） 更改新项目中的Assets/Modle/Int.cs，加载自定义组件。 更改新项目中的Assets/Hotfix/Int.cs，加载自定义登陆界面。 经过以上的操作，项目就迁移完成了。 这样的迁移一般是不会产生什么代码BUG的，资源路径需要再统一下： 资源服务器上路径需完全按照：相对路径/版本名/StreamingAssets/文件名 如果路径不一致，要么修改资源服务器目录，要么修改ET中下载Bundle部分代码。 GlobalProto.txt 客户端通过Assets/Resources/KV.prefab上的资源收集器读取全局配置。 资源收集器 客户端上资源通过Reference Collector脚本工具收集资源，但是在版本迁移时收集器可能被清空。 重新检查Hierarchy和Project目录中收集器内容是否完整。 如果是使用Unity创建新工程进行迁移的话，需要注意： Layer层级中添加自定义层级，比如8：Map； 设置预定义符号：NET45;ILRuntime;ASYNC； 脚本运行时：.NET 4.X

## Server迁移

Server部分需要迁移的文件不多。 有必要迁移的自定义文件夹一般为App名，比如Landlord： Model/Landlord/ （迁移到新项目） Hotfix/Landlord/ （迁移到新项目） 更改新项目中的App/Program.cs，加载自定义组件。 编辑Server.Model.csproj，添加客户端/服务端共享代码。 通过以上步骤，完成了ET版本的升级。 升级后的版本需要测试下**工具/客户端/服务端**，实际上这里也是一个困难点。 如果ET的ILRuntime工具不支持Unity2018的话，那么在解决工具使用问题之前，新的版本依然不能使用。

# Card类

有时候物体需要被当作消息进行传递，我们当然可以声明一个新的message，但是也需要为其添加自定义方法。 Card表示斗地主中的一张牌，由于ET4.0中不像ET3.2支持丰富的类型，可用的类型有： int32(int);int64(long);string;bool; 在当前.protoc或引用文件中已定义的消息类型; Repeated字段; 所以要： 将enum类型改写为int32，额外判定值范围; 将自定义数组（所有容器类型）改写为Repeated字段; 版本迁移带来的代码变动： 消息结构的改动带来了一定量的代码变动，创建消息/发送消息/函数参数发生变化。 另一部分代码变动的原因是：ET的API变化。 ET中的各API由其组件提供，在发生变化的情况下检查类似的API进行替代。 新Card类 消息结构在OuterMessage.proto中： //----斗地主 message Card { int32 CardWeight = 1; int32 CardSuits = 2; } 额外创建Card.cs为消息添加自定义方法。 这里为了使OpcodeTypeComponent在遍历消息结构时不报错使用静态方法创建自定义Card: public static Card Create(int weight, int suits)

# 处理消息

服务端消息处理类都放在Hotfix/Sekia\_LL/文件夹下。 Client表示客户端； Realm可以理解为登陆请求列表，给符合要求玩家发登陆Gate用的Key； Gate可以理解为登陆游戏； Map可以理解为游戏逻辑； Match处理匹配相关内容，类似Map类型，本篇中当作Map处理； 下面的消息按照Realm/Gate/Match/Map依次进行解释，可以根据VS中的目录按顺序查看。

# Client-Realm

## C2R\_Register\_Req

本消息用于处理客户端发来的注册请求，包含假定的帐号和密码。

```
//数据库操作对象
DBProxyComponent dbProxy = Game.Scene.GetComponent<DBProxyComponent>();
//查询账号是否存在
List<ComponentWithId> result = await dbProxy.Query<AccountInfo>($"{{Account:'{message.Account}'}}");
```

数据库查询语句，ET中支持json字符串查询/Id查询/表达式查询，表达式查询会转换为Json字符串进行查询。 Id查询： `UserInfo userInfo = await dbProxyComponent.Query<UserInfo>(message.UserID, false);` 返回的结果都是`List<ComponentWithId>`类型的。 User.UserID将会被记录在数据库上，所以这个值会变成唯一不变的值。 每种消息类型都会有自己的Collection，可以在MongoDB图形化工具里面查看。 新建Bson消息类型：AccountInfo

```
[BsonIgnoreExtraElements]
public class AccountInfo : Entity
{
    public string Account { get; set; }
    public string Password { get; set; }
}
```

创建Bson消息实例 `AccountInfo newAccount = ComponentFactory.CreateWithId<AccountInfo>(IdGenerater.GenerateId());` 写入Bson消息到数据库 `await dbProxy.Save(newAccount);` reply(response); reply是个带1个参数的匿名委托方法，response是R2C\_Register\_Ack类型消息。 MongoHelper 类似于JsonHelper，可以反序列化Bson消息。

## C2R\_Login\_Req

验证假定的帐号密码，并获得AccountInfo； 将已在线的玩家踢下线，再为其分配一个Gate服务器，获取Gate服务器的Key，返回消息。

## 踢人下线

踢人下线这个操作使用了OnlineComponent，其可以说是第一个在ET中被使用的斗地主全局组件。 `int gateAppId = Game.Scene.GetComponent<OnlineComponent>().Get(userId);`

## OnlineComponent

OnlineComponent是斗地主全局组件之一，Realm服务器可以使用。 这个组件特简单，只有一个词典容器： ComponentWithId.Id为key，网关服务器appid为value。 这里AccountInfo的Id是处理注册消息时的世界时间。 获取Gate服务器的AppId,见配置文件（AllServer.txt）中的参数。

```
StartConfig userGateConfig = Game.Scene.GetComponent<StartConfigComponent>().Get(gateAppId);
IPEndPoint userGateIPEndPoint = userGateConfig.GetComponent<InnerConfig>().IPEndPoint;
Session userGateSession = Game.Scene.GetComponent<NetInnerComponent>().Get(userGateIPEndPoint);
await userGateSession.Call(new R2G_PlayerKickOut_Req() { UserID = userId });
```

获取了appid就能找到对应的StartConfig，每个服务器都对应一个StartConfig，AllServer的配置中所有类型的服务器都共享一份配置。 userGateIPEndPoint是单个服务器的内网IP，这个IP供服务器之间内部通信用，有多少个服务器就会有多少个内网IP，比如说Realm服务器在杭州的阿里云，Gate服务器在广州的腾讯云。 创建一个NetInnerComponent的Session，这个Session将连接到指定的内网服务器IP，这样的Session会每个内网服务器存在对应一个。 发送R2G\_PlayerKickOut\_Req消息让指定的Gate服务器处理。 R表示Realm，此时C2R\_Login\_ReqHandler的特性MessageHandler(AppType.Realm)也表明这段消息是在Realm服务器上处理的。 Realm服务器是玩家接触的第一个服务器，这个只能让客户端自己来选，比如客户端ping多个Realm服务器并连接其中速度最快的那一个，用于处理国内外IP访问的问题，Realm服务器再根据ping结果推荐一个负荷未满的Gate服务器； Gate服务器在有多个Gate服务器的情况下是可以做选择的。

## 分配Gate服务器

斗地主使用了ET的RealmGateAddressComponent来分配Gate服务器。 RealmGateAddressComponent是全局组件之一，Real类型的服务器会加载这个组件，其功能很简单，维护一个StartConfig类型的列表。 GetAddress会随机返回列表中的一个配置。 获取到网关服务器配置后，取其IP创建Session即可连接。 发送R2G\_GetLoginKey\_Req消息获取登陆Key。 客户端凭借Key就能连接到指定Gate服务器。 BUG ET3.2中有个错误导致不能将服务端假设在外网： `response.Address = gateConfig.GetComponent<OuterConfig>().Address2;` 这里应取地址2，地址1应为0.0.0.0：端口。

# Gate-Realm

## G2R\_PlayerOnline\_Req

这是一个Gate服务器发给Realm服务器的请求消息。 将玩家从其他Gate服务器上踢下线，添加玩家到OnlineComponent的词典中。

## G2R\_PlayerOffline\_Req

将玩家从OnlineComponent的词典中移除。

# Realm-Gate

## R2G\_PlayerKickOut\_Req

Gate服务器收到Realm服务器“踢当前服务器玩家下线”的请求。 处理内容是删除掉指定玩家的Session，玩家的Session被保存在NetOuterComponent的sessions词典中。 sessions以ComponentWithId.Id为key，以Session为value保存玩家的Session。

## UserComponent

Gate服务器上的全局组件之一，管理所有在线玩家，维护一个以Id为Key，User为value的词典。

## UnitGateComponent

UnitGateComponent组件是被挂载在User上的，用途是保存其Session的ComponentWithId.Id。 当需要创建一个新的Entity的时候，使用其工厂创建方法，在工厂创建方法中为其添加组件/设置父级。 比如有一个Entity为A,A不具有任何功能，但是添加一个容器组件后就可以容纳Entity B。 整个目录结构是（脑补一下）： Scene（Entity）UserComponent（User容器） User（Entity） UnitGateComponent（SessionId容器（long型）） SessionId（long）

## NetOuterComponent

外网组件，也就是负责跟玩家沟通的组件，继承于NetworkComponent，唯一的属性决定使用哪一种网络协议。 设置NetworkComponent的protocol属性可以将协议在KCP/TCP/WebSocket之间更改。 这个组件的主要功能为管理Session，包括Session容器的增/删/查，以及协作的Channel的连接/Update。

## R2G\_GetLoginKey\_Req

Gate服务器收到Realm服务器请求玩家登陆Key。 Key的生成方式为： long key = RandomHelper.RandInt64(); Ket的保存方式为; `Game.Scene.GetComponent<LandlordsGateSessionKeyComponent>().Add(key, message.UserID);` 在这里并没有对Key有特别的限制，比如Key是否唯一，是否有激活时限等。

## LandlordsGateSessionKeyComponent

LandlordsGateSessionKeyComponent是斗地主全局组件之一，Gate服务器可以使用。 其作用为维护一个以Gate登陆Key为key，以UserID为value的词典，供玩家登陆使用。

# Client-Gate

## C2G\_GetUserInfo\_Req

Gate服务器收到来自客户端的“请求指定id玩家的信息”请求。 先验证Session的合法性，获取消息Entity，将信息返回给客户端。

## 验证Session是否合法

SessionUserComponent的作用为保存对应的User，实现Session和User的一一对应关系。 检查Session是否绑定了玩家，以及其绑定的玩家是否在UserComponent（在线）中。

```
if (!GateHelper.SignSession(session))
{
    response.Error = ErrorCode.ERR_SignError;
    reply(response);
    return;
}
```

这个方法可以避免一些低端骚扰吧。。。 好像内网消息都没有对来源IP进行检查的，理论上来说内网消息应限制在配置列表中的IP。 消息来源的身份可靠性需要再考虑一下。

## C2G\_LoginGate\_Req

来自客户端的Gate登陆请求 消息结构中仅有一个Key，确认Key对应的玩家Id是否存在。 正确的Key只能使用一次，确认正确后从词典中移除。 根据UserId和SessionId工厂创建User。 `await user.AddComponent<MailBoxComponent>().AddLocation();` ET：挂上这个组件表示该Entity是一个Actor, 接收的消息将会队列处理。 这里使用了C#的扩展方法特性，扩展方法使你能够向现有类型“添加”方法，而无需创建新的派生类型、重新编译或以其他方式修改原始类型。扩展方法是一种特殊的静态方法，但可以像扩展类型上的实例方法一样进行调用。 通知Realm服务器 玩家上线 发送G2R\_PlayerOnline\_Req消息 回复玩家登陆成功消息 设置G2C\_LoginGate\_Ack中的PlayerID（临时ComponentWithId.Id）和UserID（永久ID），返还给玩家。

## MailBoxComponent

邮件盒子组件维护一个有序消息队列。 关于Task的代码我还没有看懂，看网上的介绍：基于事件的异步处理模式，当任务一旦完成,对应的事件结果也就被处理了... 勉强能理解吧，还不会实际操作。 创建Actor时，向Location服务器发送ObjectAddRequest请求。 Location服务器将邮件盒子的父级Entity的ComponentWithId和InstanceId添加到locations词典中。

## LocationComponent

LocationComponent是ET的全局组件之一，Location服务器专属。 用于注册Actor/上锁/添加任务。

## LocationProxyComponent

LocationProxyComponent是ET的全局组件之一，用上了这个组件的服务器有Realm/Gate/Map，唯一作用为存储Location服务器的IP。

## 添加消息转发组件

给Session也添加加邮件盒子，并设置拦截器类型，可以达到转发效果。 给玩家（User）发送的actor消息会由其绑定的Session转发给玩家对应的客户端。 `await session.AddComponent<MailBoxComponent, string>(ActorInterceptType.GateSession).AddLocation();` 这里为邮件盒子添加了一个字符串参数作为拦截器初始化邮件盒子。 在ActorMessageDispatherComponentSystem.cs中，由对应的拦截器处理actor消息： `await iActorInterceptTypeHandler.Handle(actorMessageInfo.Session, mailBoxComponent.Entity, actorMessageInfo.Message);` 其中actorMessageInfo.Session是携带消息的Session，mailBoxComponent.Entity是收到消息的Entity（玩家绑定的Session）。 关于Actor消息的具体流程今后再详细描述。 注：ET中自带Player/SessionPlayerComponent/PlayerComponent等类，和斗地主中的组件是一样的效果。

## C2G\_ReturnLobby\_Ntt

Gate服务器收到客户端的“返回大厅”消息。 通过Session获取其绑定的User； 根据玩家的状态不同，决定取消的操作不同： 如果玩家在匹配中，通知Map服务器（Match或者游戏逻辑服务器）退出匹配消息。 发送G2M\_PlayerExitMatch\_Req消息。 如果玩家正在游戏中，则向User发送退出房间的Actor消息。

```
ActorMessageSender actorProxy = actorProxyComponent.Get(user.ActorID);
await actorProxy.Call(new Actor_PlayerExitRoom_Req() { UserID = user.UserID });
```

## ActorMessageSenderComponent

这个组件是ET的全局组件之一，作用只有一个： 根据actorId获取内网服务器的Ip，生成ActorMessageSender实例。 而ActorMessageSender是一个由ActorId和Address组成的struct。 使用ActorMessageSender的扩展方法Call（Requesr）/Send（Message）就可以发送消息。 发送原理为，在session的Call/Send基础上添加了message.ActorId参数。 每个User都有一个ActorID属性，默认为0，用于发送actor消息，可以理解为订阅。 当退出房间时，设置ActorID为0，取消订阅。

## C2G\_StartMatch\_Req

客户端向Gate服务端发起的进入匹配请求。 Gate服务器先验证玩家是否符合进入房间的要求。 RoomConfig 用于保存房间设置和进入门槛的struct `RoomConfig roomConfig = RoomHelper.GetConfig(RoomLevel.Lv100);` 使用一个enum参数实例化配置，这样做的好处是可以扩展。 因为每个副本/关卡都是相对固定存在的，适合用enum来标识。 为message中添加副本的标志，则可以安排玩家匹配指定的副本。 先回复消息 只要客户端满足房间的进入要求都先返回消息，这样客户端（用户）就能及时得到一个明确的响应。 再处理匹配任务 向游戏逻辑服务器发送G2M\_PlayerEnterMatch\_Req消息

# Match-Gate

## Actor\_MatchSucess\_Ntt

Gate服务器收到来自游戏逻辑服务的“玩家已匹配成功”消息。 消息的接受者为User； 更改User的IsMatching属性为false，ActorID为GamerID。

# Gate-Match

## G2M\_PlayerEnterMatch\_Req

游戏逻辑服务器收到Gate服务器的“玩家请求进入匹配队列”消息。 消息中包含： User的PlayerID/UserID/SessionID； 其中UserID（User.UserID）是数据库中的记录的唯一恒定Id； PlayerID是User的临时ComponentWithId.Id； 如果该玩家已经在游戏中，那么对其进行重连操作。 如果是新匹配的玩家则创建匹配玩家对象。

## 重新连接

MatchComponent是斗地主的全局组件之一，其维护着匹配相关的玩家列表。 Playing词典是所有已经在房间有座位的玩家的容器，key为UserID，value为roomId。 MatchSuccessQueue是所有匹配中的玩家的容器，完成匹配的玩家会被移除队列。 如果玩家已经在游戏中的话，此时收到匹配消息则需要重连房间，需要找到玩家所绑定的房间。 MatchRoomComponent是斗地主的全局匹配组件之一，其维护着房间容器。 `Room room = matchRoomComponent.Get(roomId);` 通过房间Id可以找到房间的Entity。 `Gamer gamer = room.Get(message.UserID);` 通过UserID可以找到Gamer的Entity。

```
ActorMessageSender actorProxy = actorProxyComponent.Get(roomId);
await actorProxy.Call(new Actor_PlayerEnterRoom_Req()
```

向玩家所在房间（Room/游戏逻辑服务器）发送进入房间请求。 向玩家（User/Gate服务器）发送匹配成功消息，设置User的ActorID为gamer的ComponentWithId。

## 创建匹配玩家

Matcher对象表示一个匹配中的玩家，其参数记录着与自身关联的User/Session信息。 MatcherComponent维护着一个可匹配的玩家的词典，需要新增可匹配玩家时，用工厂方法创建Matcher对象并添加到matchers词典。

## G2M\_PlayerExitMatch\_Req

Gate服务器通知游戏逻辑服务器“让指定UserID的匹配者退出队列”。 将匹配者从matchers词典中移出，销毁Matcher的Entity。

## MH2MP\_PlayerExitRoom\_Ack

Map服务器在处理“移出玩家”时，同步通知匹配服务器/房间“玩家退出事件”。 Gamer对象同时被销毁 当房间中没有玩家时，还会回收房间。

## MP2MH\_SyncRoomState\_Ntt

Match服务器改变指定Id房间状态为准备/游戏。

# Map游戏逻辑

## OrderControllerComponent

room的游戏逻辑控制组件，用于判断当前的先手权/抢地主状态/本轮牌型最大的玩家/当前抢地主玩家，相当于记载了游戏的进度。

## Actor\_GamerDontPlay\_Ntt

玩家的“不出”消息（这位玩家肯定不具有先手），先转发给房间，再给下一位玩家出牌权，如果下一个出牌的玩家是先手，则清除掉上一轮的出牌缓存。 Actor\_AuthorityPlayCard\_Ntt消息指定一个玩家有出牌权和是否先手。

## DeskCardsCacheComponent

房间的出牌缓存，记录了牌桌上已经公开的牌/王3张/最大牌型。

## DeckComponent

牌库，游戏刚开始还没开始发牌时，牌的容器，所有的牌都从这个容器里拿出来。

## GameControllerComponent

房间的游戏控制器组件，记录了房间配置（初始）/当前倍率。

## Actor\_GamerGrabLandlordSelect\_Ntt

玩家发给游戏逻辑服务器的“斗地主权选择结果”。 将玩家的选择IsGrab保存在游戏逻辑控制组件中； 如果IsGrab为真，倍率x2，广播倍率变更消息，转发“斗地主权选择结果”。 当3位玩家都做出了“斗地主权选择”后，需要判断“地主”归属，地主依然还没有归属的情况： 没人抢地主（重新发牌）/3个人都抢了地主（先手玩家还有额外一次机会）。 地主已经有归属的情况（有人抢过地主）： 抢地主序列大于房间人数（第四次抢地主）/第三次抢地主且最后抢地主的玩家不是先手且先手玩家没有抢地主/第三次抢地主且最后抢地主的玩家是先手玩家 orderController.Biggest：最后一个抢地主的玩家的UserID。 orderController.FirstAuthority.Key：先手抢斗地主的玩家的UserID。 先手抢地主的玩家拥有地主权的主动权，其次是农民2，农民1可以选择抢地主但是可以被农民2和地主再抢走。 决定地主人选后，执行更新身份和发地主3张牌等事件。

## Actor\_GamerPlayCard\_Req

游戏逻辑服务器收到客户端的出牌消息。 因为出牌验证需要服务端处理，所以这里要列举出所有可能的牌型。 个子/对子/三个/三带一/三带二/四个（炸）/顺子/王炸 需要判断玩家是否是先手（上一局最大出牌者）/当前牌局类型/是否是炸弹/是否是更大的同类型 不符合规则的消息返回错误消息，符合则将牌从手牌区移动到缓存区/广播出牌消息/继续游戏逻辑。

## Actor\_GamerPrompt\_Req

客户端请求服务端“出牌提示”，在牌局中先手者已经出牌（确定了牌型），后面的玩家可以选择该功能，虽然绝对必要的功能，也是很常见的功能。在托管功能中会更多用到自动出牌的底层逻辑。 先取请求者（Gamer）手上的全部牌/当前牌局的牌型/当前牌局的最大牌，可以得出能出牌的可能性。

## Actor\_GamerReady\_Ntt

客户端按“准备”按钮时通知服务端的消息，服务端将消息广播一遍，检查是否符合游戏开始条件。

## Actor\_PlayerEnterRoom\_Req

匹配组件（ETHotfix.MatchComponentSystem.JoinRoom）发给房间的“玩家进入房间消息”请求。 新玩家将使用工厂方法创建Gamer的Entity，绑定邮件盒子/Session，广播进入房间消息。 重新连接的Gamer需要更新PlayerID/Session/isOffline等属性的状态，为了帮助重连的玩家恢复游戏状态，还得补发游戏开始消息（手牌）/先手权消息（当前游戏执行顺序）/重连消息（身份/王3张）。

## Actor\_PlayerExitRoom\_Req

当玩家的Session断开/踢玩家出房间/用户按“退出”按钮返回大厅，Map服务器收到此消息。 游戏中玩家离线后，给玩家添加托管组件，游戏可以继续进行，其他玩家不会受到影响。 房间状态为非游戏状态时，直接移除Gamer对象/房间广播。

## Actor\_Trusteeship\_Ntt

玩家发给Map服务器的托管状态变更消息。 先检查玩家的托管状态判断是否添加/移除托管组件，进行房间广播。 如果玩家在自己获得出牌权的情况下按了托管按钮，那么其无法履行自己的出牌任务，需要重新向其发送一次出牌权消息，之后出牌任务会被托管执行。

## MH2MP\_CreateRoom\_Req

由匹配组件系统（Match服务器）发给Map服务器的“创建房间”请求。 将使用工厂方法创建Room的Entity，并添加DeckComponent/DeskCardsCacheComponent/OrderControllerComponent/GameControllerComponent/MailBoxComponent等组件，父级Entity为Scene，容器为斗地主的全局组件RoomComponent。 以上的消息为斗地主中的全局消息功能描述，游戏的的运行可以说大部分靠消息的“事件驱动”，明白了有哪些消息也就知道游戏大概是怎么运转的，剩余的就是游戏的系统驱动的，也就是附加在Entity上的Component的Awake/Update方法，在本篇斗地主中，匹配组件系统的Update方法尤为亮眼，可以重点关注一下。 然后是建议脑补结构图的概念。Scene是所有Entity的最上级，其组件称之为“全局组件”，Scene通过添加全局组件可以管理Session/User/Gamer/Room等Entity，每个Entity都需要一个管理组件便于添加移除查找（存储Entity），非管理组件也可以用存储Entity的ComponentWithId.Id（long型）的容器管理自己关心的对象。 其实ET是有潜力做成图形化模式的，这样一来“工厂创建方法”变成了在指定的“gameobject”上右键-添加XXX...

# System

接下来看斗地主的系统部分，也就是ECS框架的逻辑部分。 在ET的服务端中，Entity和Component的声明在Model层，Entity只有少量数据，Component只有数据和管理容器。 System位于Hotfix层，通过为Component添加扩展方法达到扩展组件功能的目的（参数中包含this T self），通过带有ObjectSystem特性的类来实现Awake/Start/Update（组件的唤醒/初次启动/循环执行）。

## 先整理了解下System的情况

斗地主DEMO的System目录下一共有11个文件，其中有6个类带有ObjectSystem： SessionUserComponentDestroySystem TrusteeshipComponentStartSystem Start DeckComponentAwakeSystem Awake GameControllerComponentAwakeSystem Awake AllotMapComponentStartSystem Start MatchComponentUpdateSystem Update Awake 带ObjectSystem的类会在加载程序集阶段就被实例化，可以理解为“游戏还没有开始以前就在运行的程序”。 和Unity中的组件一样，这里的Awake会使用必要的参数在创建Entity（factorycreate）/Component时执行一遍，Awake方法可以说是刚需，被第一时间执行，是Entity/Component的默认设置。 Start Start方法在EventSystem.Start方法中执行（被Program.cs中的无限循环检测到），在加载程序集时，Start方法的Component的Type和实例被存储在startSystems词典中用来与starts词典中的待处理Component做对比。当创建新的组件时，Component.IsFromPool就会把Component添加到事件系统。也就是说：来自Component池的Component/Entity都会被第二时间执行Start方法，被事件系统唤醒。 无限循环-App.Program.cs `Game.EventSystem.Update();` 无限循环的执行顺序：Sleep 0.001秒/其他线程的同步任务/Start/Update 托管组件TrusteeshipComponent Gamer类型Entity的专属组件，按需添加。 全局-配置管理组件AllotMapComponent 用于读取所有游戏逻辑服务器配置，初始加载。 桌子组件DeckComponent 创建Room类型Entity时添加的组件，适合交给工厂类处理。 游戏逻辑管理器组件GameControllerComponent 创建Room类型Entiry时添加的组件，适合交给工厂类处理。 全局-匹配组件MatchComponent 用于管理游戏逻辑的组件，无限Update。

## MatchComponent-Update

将所有排队中的玩家Matcher组成一个有序队列matchers； 获取一个当前为“准备”状态的房间，没有创建过房间的话，那么得到null； 没有玩家排队直接退出本次循环； 当匹配玩家数量足够/房间为空时，尝试在空房间列表（idleRooms）中找一个Room，没有空房间的话，那么得到的也是null； 没有可用房间时，CreateRoom创建新的房间； 有可用房间时，JoinRoom从有序队列中出列3个玩家添加到房间；

## CreateRoom

Match服务器向（随机找一个）Map服务器发送创建房间消息； Map服务器和Match服务器分别创建一个Room对象，两个Room的ComponentWithId.Id属性一样但是组件不同； Match服务器将自己的Room添加到MatchRoomComponent的空房间列表中。 Map服务器给自己的Room添加了全套游戏逻辑组件后，将其添加到全局组件RoomComponent的rooms词典中。

## JoinRoom

因为Map服务器在创建Room时，注册了Actor： `await room.AddComponent<MailBoxComponent>().AddLocation();` 所以可以给Room（ComponentWithId.Id）发acor消息了：

```
ActorMessageSender actorProxy = Game.Scene.GetComponent<ActorMessageSenderComponent>().Get(room.Id);
Actor_PlayerEnterRoom_Ack actor_PlayerEnterRoom_Ack = await actorProxy.Call(new Actor_PlayerEnterRoom_Req();
```

ActorMessageSender Get方法 从actorId中获得一个Actor对象所在的（Map）内网服务器IP的序列号： `IdGenerater.GetAppIdFromId(actorId);` 使用了移位运算：(id >> 48)，将二进制的actorId舍去小数点前的48位； 输入382379283251341的运算结果为1； Room和Gamer应在同一个Map服务器中。 Mpa服务器中的Room收到了来自Match服务器的Actor\_PlayerEnterRoom\_Req请求,创建Gamer对象： `gamer = GamerFactory.Create(message.PlayerID, message.UserID);` Mpa服务器为Gamer注册Actor/绑定Session/添加座位/广播消息； Match服务器用返回消息中的GamerID实例化Gamer，并添加到自己创建的房间中，两边的Gamer拥有同样的ComponentWithId.Id，但是拥有的组件不同； Match服务器给Gate服务器上的User发送匹配成功消息Actor\_MatchSucess\_Ntt； 到此玩家入座完成了，在Gate/Match/Map，这3台服务器上的Entity均已生成。

# 准备按钮

在旧的斗地主中，客户端按下“准备”按钮，向服务器发送Actor\_GamerReady\_Ntt消息： `发送消息 flag0 opcode10022 message{"Parser":{},"RpcId":0,"ActorId":0,"UserID":0}` 服务端收到消息，因为flag==0，消息由Session的网络组件（NetOuterComponent/所在容器）的消息分发器成员来处理： `this.Network.MessageDispatcher.Dispatch(this, opcode, message);` 这里可以脑补一下Entity/Component的结构： Scene(Entity) NetInnerComponent（...） NetOuterComponent sessions(词典) MessageDispatcher(消息分发器) 对应代码位置为OuterMessageDispatcher.cs 新的ET不再处理来自客户端的Actor（iActorRequest/iActorMessage）消息，所有消息均由Gate服务器处理，如果是Gate服务器不识别的opcode那么就会出现“消息没有被处理”的情况。 在旧的ET中，实现Actor消息转发的代码是： `iActorRequest/ long actorId = session.GetComponent<SessionUserComponent>().User.ActorID; ActorMessageSender actorMessageSender = Game.Scene.GetComponent<ActorMessageSenderComponent>().Get(actorId); actorMessageSender.Send(iActorMessage);` 这段代码依然可以用，但是会报错找不到Actor； 原因是Gamer的ActorID使用了其ComponentWithId.Id，而allComponents词典的key现在是Component.InstanceId担当。 与ActorID相关的参数传递和参数命名建议重新调整。 命名：名称建议写ActorIDofUser这种形式，能表达清楚作用和Actor对应的Entity。 接下来，要么是对变量的简单修改，达到“能用就好”的目的，或者大大的改一番。 将Actor\_PlayerEnterRoom\_ReqHandler.cs最后返回的message.GamerID修改为gamer.InstanceId就可以勉强可以跑了。 不过依然有找不到Actor的BUG。 在下一篇中将描述关于分布式服务器的理解和对斗地主的改造。