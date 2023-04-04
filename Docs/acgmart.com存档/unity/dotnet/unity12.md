---
title: 从0开始的Unity3D游戏开发 v0.1.12 客户端登陆
categories:
- [Unity, ET]
date: 2018-08-24 01:03:41
---

\[toc\]本篇将使用ET框架完成登陆操作 本篇使用环境： ET 4.0 Unity 2018.2.10f1 斗地主Demo(ET 3.2)

# 连接服务端

客户端通过登陆按钮来激活连接服务端的操作。 在UILoginComponent.cs中OnLogin方法主动连接服务器并完成UI变化。 `ETModel.Session session = ETModel.Game.Scene.GetComponent<NetOuterComponent>().Create(GlobalConfigComponent.Instance.GlobalProto.Address);` 使用NetOuterComponent组件创建一个新的Session。 GlobalProto.txt中的Address被从string类型转化为IPEndPoint类型； 在tcp模式下，TService.cs中用IPEndPoint实例化TChannel，并加入到idChannels词典； 以Tchannel为父级创建子Session，并添加到NetworkComponent的sessions词典； Session的Start方法将触发TChannel的异步连接至IPEndPoint，开启异步循环收消息，并将TChannel的id添加到TService的needStartSendChannel表。 `Session realmSession = ComponentFactory.Create<Session, ETModel.Session>(session);` 根据ET中的注释：创建一个ETHotfix层的Session, ETHotfix的Session会通过ETModel层的Session发送消息； 也就是使用ETModel.Session的awake方法来初始化组件，返回一个ETHotfix.Session对象，可以理解为复制。

## 发送登陆请求

`R2C_Login r2CLogin = (R2C_Login) await realmSession.Call(new C2R_Login() { Account = text, Password = "111111" });` 使用Session发送登陆请求。 `new C2R_Login() { Account = text, Password = "111111" }` 类的自构方法，新建类的对象，并对其成员赋值。 `public Task<IResponse> Call(IRequest request)` `Task<T>`是异步方法，用于查看任务结果。 `realmSession.Dispose();` 释放Session，连带ETModel.Session也释放。 在异步方法中获得结果R2C\_Login； R2C\_Login的成员有：RpcId/Error/Message/Address/Key。 如果想知道这里收到的是什么消息很简单： `Log.Debug("收到R2C_Login：" + JsonHelper.ToJson(r2CLogin));` 使用反解析方法将收到的消息转化为string,输出： 收到R2C\_Login：{"Parser":{},"RpcId":1,"Error":0,"Message":"","Address":"127.0.0.1:10002","Key":-1115963093259365048} 同理G2C\_LoginGate消息： 收到G2C\_LoginGate：{"Parser":{},"RpcId":2,"Error":0,"Message":"","PlayerId":382283015389538}

## Send操作

Session.Call(IRequest)方法用于发送一条消息： `public void Send(byte flag, ushort opcode, object message)` 并由TChannel.cs中的Send(MemoryStream stream)方法将消息添加到needStartSendChannel表。 TService.cs中的Update方法执行TChannel的StartSend执行异步发送操作。

## Recv操作

Session同样也处理消息/分发消息，ETHotfix.Session处理热更层的消息。 唯一的消息入口依然在ETModel.TChannel。 客户端创建默认的NetOuterComponent，使用Session的Start方法开启异步接受。 服务端用带参数的自构方法创建NetOuterComponent，默认开启异步接受。 在ETModel.Session中，通过判断opcode是否大于10000来确定是否为热更消息： `if (OpcodeHelper.IsClientHotfixMessage(opcode))` 热更消息将被指定的ETHotfix.Session处理，具体调用方法与ILRuntime有关，暂不明。 `public void Run(ETModel.Session s, byte flag, ushort opcode, MemoryStream memoryStream)` 在ETHotfix.Session中，Run方法处理Session对象自身发出去的消息的回复。 ETHotfix也有自己的OpcodeTypeComponent，通过opcode值找到指定Type的实例，并从流中反解析出消息对象。 **flag** 当热更消息的flag为1时，消息类型为IResponse。 每个请求对应一个回复：`public Task<IResponse> Call(IRequest request)` Session从词典中以RpcId为key，查找对应的`Action<IResponse>`。 如果查找失败，则跳过本条消息的处理。 如果查找成功，则从词典中移出`Action<IResponse>`并执行。 这里的IRequest是逻辑部分代码中主动调用的，这里可以理解为用户主动行为。 当flag不为0时，寻找对应的消息处理方法，这里可以理解为游戏框架行为。

# Debug技巧

在网络相关的编程中，非底层逻辑的内容无非是注册协议和收发处理。 让收发消息透明化可以提高诊断效率，如果是自己不在意的消息屏蔽就好。

## 收消息

ETModel.Session中，**热更消息**`if (OpcodeHelper.IsClientHotfixMessage(opcode))`： 未解析的热更消息 `Log.Debug($"收到热更 flag{flag} opcode{opcode}");` 非热更消息： `Log.Debug($"收到 op{opcode}/flag{flag}: {JsonHelper.ToJson(message)}");` 直接这么用可能报错，因为message结构中如果有不支持的数据类型的话无法解析，可以添加if判断。

```
if(!(opcode == (ushort)12))
{
    Log.Debug($"收到     op{opcode}/flag{flag}: {JsonHelper.ToJson(message)}");
}
```

ETHotfix.Session.Run方法中： `Log.Debug($"收到热更 flag{flag} opcode{opcode} 消息{JsonHelper.ToJson(message)}");`

## 发消息

热更Session发消息：`public Task<IResponse> Call(IRequest request)` `int rpcId = ++RpcId;` RpcId是类的静态成员，在这里相当于计数器/编号，不会有response.RpcId相同的请求。 获得消息体的opcode： `ushort opcode = Game.Scene.GetComponent<OpcodeTypeComponent>().GetOpcode(message.GetType());` 每个热更Session都会绑定一个ETModel.Session用于发送消息。 发送方法：`public void Send(byte flag, ushort opcode, IMessage message)` 所以Log方法为，在ETModel.Session的Send方法中加入： `Log.Debug($"发送消息 flag{flag} opcode{opcode} message{JsonHelper.ToJson(message)}");` 因为opcode = 12的消息结构中包含 结果： `发送消息 flag0 opcode10001 message{"Parser":{},"RpcId":1,"Account":"das","Password":"111111"}`

## 连接消息

只有服务端会频繁处理连接请求 被动连接 在TService的自构方法中，网络组件完成了异步循环Accept，将结果保存于SocketAsyncEventArgs e中； 在OnAcceptComplete方法中，为新连接创建TChannel对象,并执行TChannel自构时用的this.OnAccept回调方法： OnAccept方法中创建了NetworkComponet的子组件Session，并用Session.Start方法开启异步连接/收。 在服务端收到新的客户端请求时输出日志的方法，在ETModel.Tservice.OnAcceptComplete方法中添加： `Log.Debug("新连接：" + channel.RemoteAddress.ToString());` 主动连接 此外TChannel还有4种Socket操作：OnConnectComplete/OnRecvComplete/OnSendComplete/OnDisconnectComplete； 对应Session的连接/收/发/断开事件的后续操作，Session.Create方法只会开启连接/收。 单个连接TChannel用OnConnectComplete方法来连接到指定的IPEndPoint,在ETModel.TChannel.Start方法中添加： `Log.Debug("连接到" + RemoteAddress.ToString());` OnRecvComplete方法会将消息交给Session自己处理/分发。

## 断开连接消息

被动断开：心跳机制 主动断开：Dispose方法

# 客户端登陆

通过以上的Debug，我们可以将客户端的通信做成明文模式。 在处理坐标（浮点数）时报错的话，可以把这部分的message先不解析。

## ET4.0登陆

在ET4.0的默认demo中演示了一个登陆效果，其用到的消息流程如下：

```
连接到118.89.50.112:10002
发送消息 flag0 opcode10001 message{"Parser":{},"RpcId":1,"Account":"dadfdasd","Password":"111111"}
收到热更 flag1 opcode10002  消息{"Parser":{},"RpcId":1,"Error":0,"Message":"","Address":"118.89.50.112:10002","Key":-6423596861941487080}
连接到118.89.50.112:10002
发送消息 flag0 opcode10003 message{"Parser":{},"RpcId":2,"Key":-6423596861941487080}
收到热更 flag1 opcode10004  消息{"Parser":{},"RpcId":2,"Error":0,"Message":"","PlayerId":382297392158675}
登陆gate成功!
发送消息 flag0 opcode10009 message{"Parser":{},"RpcId":3}
收到热更 flag0 opcode10005  消息{"Parser":{},"Info":"recv hotfix message success"}
收到热更 flag1 opcode10010  消息{"Parser":{},"RpcId":3,"Error":0,"Message":"","PlayerInfo":{"Parser":{},"RpcId":0},"PlayerInfos":[{"Parser":{},"RpcId":0},{"Parser":{},"RpcId":0},{"Parser":{},"RpcId":0}],"TestRepeatedString":[],"TestRepeatedInt32":[],"TestRepeatedInt64":[]}

发送消息 flag0 opcode106 message{"Parser":{},"RpcId":1}
收到     flag0 opcode109
收到     flag1 opcode107
收到     flag0 opcode12
发送消息 flag0 opcode110 message{"Parser":{},"RpcId":0,"Id":0,"X":-351,"Z":1241}
发送消息 flag0 opcode10006 message{"Parser":{},"RpcId":4,"ActorId":0,"Info":"actor rpc request"}
收到热更 flag1 opcode10007  消息{"Parser":{},"RpcId":4,"Error":0,"Message":"","Info":"actor rpc response"}
```

每次创建Session都会有一个连接操作。 opcode10001为登陆请求，10002为登陆回复，创建了客户端与服务端之间通信用的Session。 opcode10003为登陆gate请求，10004为登陆gate回复，在服务端创建了玩家实例并返回客户端。 客户端收到G2C\_LoginGate消息后也实例化MyPlayer，添加到PlayerComponent中，还没有实例化prefab。 opcode10005是热更底层消息，这里用于测试，在G2C\_TestHotfixHandler.cs中进行了处理。 opcode10009/10010为测试消息，falg为1（主动请求），但是没有处理内容。 在UILobby界面中，只有登陆按钮是激活的。 opcode106/107为EnterMap请求，返回UnitId和Count，但是没有处理内容。 opcode109为Actor\_CreateUnits消息，包含ActorId和UnitInfo内容重复字段Units； 在Actor\_CreateUnitsHandler.cs中处理，加载资源Unity.unity3d，遍历Units在游戏中实例化； UnitInfo消息只有UnitId/X/Z参数，坐标用int类型表示，处理方法为x坐标：unitInfo.X / 1000f； opcode12为FrameMessage,Gate服务端收到EnterMap消息后向Map服务端发送CreateUnit请求。 Map服务端创建Unit/添加MailBoxComponent，并将其添加到UnitComponent。 在ET中，挂上MailBoxComponent表示该Entity是一个Actor, 接收的消息将会队列处理。 opcode110向服务端发送一个点击Map的消息。 opcode10006/10007为测试actor rpc消息，是挂载在OperaComponent的Update方法上的内容； 而OperaComponent是按下登陆按钮后，由Actor\_CreateUnits消息处理方法激活的。 actor模型：客户端可以不受阻塞向服务端发送actor消息，服务端会将消息按顺序排列，有空时处理。