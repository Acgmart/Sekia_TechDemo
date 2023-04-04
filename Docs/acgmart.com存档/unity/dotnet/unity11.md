---
title: Demo 注册/登陆
categories:
- [Unity, ET]
date: 2018-08-24 01:03:37
---

\[toc\]本篇开始将记录个人学习ET框架的历程 和以前一样不是单纯讲理论 以完成一个小功能为目标稳步前进 看了2天ET服务端框架的源代码,认识到了很多工业级别的编程概念 如程序集/特性/组件等. 通过Log调试的方法从Main()函数开始往下调试了解程序运行的流程,打印输出所有操作的变量,方法简单原始,但是有效. ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/postunity11_1.png) 根据我个人的理解,ET服务端框架用"反射工厂"模式批量初始化了200多个类的对象,这些类都有BaseAttribute特性,构成了ECS框架(实体-组件-系统)的底层. 完善了底层之后,通过向Scene添加Component来完善服务端的功能概念. 因为底层太抽象,我现在还没能理解底层原理,以上的理解在今后可能有变化,我会再更新. 现在希望以完成一个作品为目标进行学习. 幸好,ET有群友的开源[斗地主DEMO](https://github.com/Viagi/LandlordsCore "斗地主DEMO"),简单运行之后可以跑的样子,那么开始正式学习吧. ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/postunity11_2.png)

# 服务端如何接收消息

在游戏的最开始,服务端要处理客户端的注册请求,查询数据库中是否有同名ID,并返回注册结果. 那么首先服务端需要有处理服务端-数据库的组件,也就是DBComponent. 在Server的代码中,默认DBComponent的Awake()函数内是被注释掉的,我们要先去掉注释,并正确连接数据库.

## 数据库配置

关于如何使用MongoDb,可以参考我之前写的[v0.1.6 MongoDB](https://acgmart.com/unity/unity6/ "v0.1.6 MongoDB"). LocalAllServer.txt中是Json格式字符串形式的配置,我将内容换行便于阅读. 这个文件默认是这样:

```
{
 "_t" : "StartConfig",
 "_id" : NumberLong("98547768819754"),
 "C" : [
 { "_t" : "OuterConfig", "Host" : "127.0.0.1", "Port" : 10002, "Host2" : "127.0.0.1" },
 { "_t" : "InnerConfig", "Host" : "127.0.0.1", "Port" : 20000 }, 
 { "_t" : "HttpConfig", "Url" : "http://*:8080/", "AppId" : 0, "AppKey" : "", "ManagerSystemUrl" : "" }, 
 { "_t" : "DBConfig", "ConnectionString" : null, "DBName" : null }
 ],
 "AppId" : 1, "AppType" : "AllServer", "ServerIP" : "*" 
 }
```

斗地主DEMO中是这样的:

```
{
 "_t" : "StartConfig",
 "_id" : NumberLong("98547768819754"), 
 "components" : [
 { "_t" : "OuterConfig", "Host" : "127.0.0.1", "Port" : 10002, "Host2" : "127.0.0.1" }, 
 { "_t" : "InnerConfig", "Host" : "127.0.0.1", "Port" : 20000 }, 
 { "_t" : "HttpConfig", "Url" : "", "AppId" : 0, "AppKey" : "", "ManagerSystemUrl" : "" }, 
 { "_t" : "DBConfig", "ConnectionString" : "mongodb://127.0.0.1:27017", "DBName" : "Landlords" }
 ],
 "AppId" : 1, "AppType" : "AllServer", "ServerIP" : "*" 
}
```

这样对比起来就可以很直观知道要改哪些部分了,修改那两个null的值即可. **将第一个null修改为数据库连接字符串,第二个null修改为database名.** 为了检测服务端是否真的连接上了数据库,我们可以让服务端在成功连接后做点什么,这里我选择让服务端记录登陆时间. 在DBComponent的Awake()方法下,**取消掉注释**,然后在后面追加调试代码内容,先使用using~: using MongoDB.Bson;

```
//测试是否连接上
var time = TimeHelper.Now();
var collection = database.GetCollection<BsonDocument>("bar");
var documentNew = new BsonDocument
{
    {"time",time }
};
collection.InsertOne(documentNew);
```

在"Landlords"数据库下新建叫"bar"的集合,并写入一个文档,启动服务端后可以在数据库中看到这条记录. ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/postunity11_3.png) 这只是一段调试代码,在确认没有问题以后可以选择删掉它,或者就这么留着. 就结果来说,我们应该正确连接上了数据库.

## DBConfig?

有一个疑问是DBConfig是在哪里添加的. 我们当然知道Program.cs中创建StartConfigComponent的动作,但是StartConfigComponent的成员StartConfig是在什么时候拥有子Component的却没有任何被add的痕迹.(在DBComponent中使用了`StartConfig.GetComponent<DBConfig>()方法`). 通过逐步调试也没有解决问题,我只好添加public方法然后去变量诞生的源头输出日志查找. 在Entity.cs中新建方法:

```
//返回Entity的词典长度
public int DicCount()
{
    return componentDict.Count;
}
```

因为StartConfig类继承于Entity,通过新方法可以外部查看StartConfig的长度变化. 我们来到StartConfig被创建的地方StartConfigComponent.cs的Awake()方法,在 `StartConfig startConfig = MongoHelper.FromJson<StartConfig>(s2);` 行下面输入调试代码: `Log.Debug($"临时变量startConfig词典长度{startConfig.DicCount()}");` 结果为4 也就是说startConfig被从字符串转化为StartConfig的时候,不仅完成了类的实例化,还能通过Json字符串将内部结构变成子成员.配置文件中的OuterConfig/InnerConfig/HttpConfig/DBConfig直接被实例化为StartConfig的子Component了.

# 消息的流转

在program.cs中添加的NetInnerComponent和NetOuterComponent是服务端网络收发的核心. 在对Component的父类构建方法/自身的构建方法/Awake方法等一系列设置和启动后,服务端成功完成了异步循环监听新连接和异步循环收消息的处理,并且所有消息都会同步到主线程进行处理. 在TCP模式中,每一个新连接都生成一个TChannel对象,每个channel对应一个Id. 主线程调用OnRecvComplete方法处理收到的消息. 通过逐步调试,可以观察到SocketAsyncEventArgs e的成员Buffer记录着receive到的字节流. ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/postunity11_4.png) e.Buffer是缓冲区,就是消息的第一站了 e.BytesTransferred是消息长度 e.Count是缓冲区长度 e.LastOperation是上次操作类型 如果这里尝试用System.Text.Encoding.ASCII.GetString方法将消息转化为字符串的话,会读出部分乱码,但是不会报错,这说明客户端和服务端之间会有相应的消息处理机制.也就是**协议**. 我们需要知道协议的具体内容是什么,然后根据协议去处理消息,或者修改协议. 我在学习本篇内容的时候,使用的是斗地主DEMO客户端-ET 3.2版本,服务端是ET 3.6. 我对比了下两边的代码,变化非常大,可能不适合跨版本学习. 我的想法是通过对3.6版本的服务端添加代码来配合3.2版本的客户端. 只要在通信协议上没有太大的变化应该都能兼容. 当然,斗地主DEMO ET客户端-服务端 3.2版本一起用的话可以正常跑游戏,这个是必须的. 所以我先用3.2的客户端来测试注册功能,服务端为3.6版本,看看消息处理到哪里会报错.

## 第一次处理

第一次对消息的修改出现在TChannel.cs中的OnRecvComplete方法. 在while(true)循环中通过this.parser.Parse()方法对消息进行了初步的处理:解析字节流是否符合规范,并去掉头部长度标记. **注意**:这里使用了this.buffer.Read()方法,这个方法读取数据会修改buffer的长度. buffer是CircularBuffer类的对象,有当前消息的起始位置FirstIndex,使用其重载的Read方法以后FirstIndex会加上已读长度. 我们将最初收到的消息称之为版本1,容器是e.Buffer,e.Buffer的前面2个字节为包长度信息. 那么经过第一次处理后,容器是e.Buffer,但是现在少了2个字节,被Read了.

## 关于小包长度

this.parser.Parse()中有判断包的长度,这里说明下. 处理方法为读取e.Buffer的前2个字节并转换为ushort(无符号16进制整数). 如:读取到2个字节{23,0},先转换为16进制→1700→将两边调过来→0017→再转换为10进制→23 所以此时包长this.packetSize为23. 这样的转换并不常常都是进出都一致,待会算opcode的时候会再说,会更直观.

## 第二次处理

依然是this.parser.Parse()中 `byte[] bytes = this.memoryStream.GetBuffer();` 通过创建临时变量并取值的方式,访问了memoryStream的私有成员`blocks[0]`. `this.buffer.Read(bytes, 0, this.packetSize);` 又通过给临时变量赋值的方式,将`blocks[0]`的指定部分更改为读到的消息. Read()方式本质上是Copy字节到指定区间位置,所以理论上得到的新的byte数组在使用的时候也应该代入正确的起始位置和长度,不然不知道会读到什么东西. 处理到这里e.Buffer作为一个临时的容器算是完成了任务,可以继续异步receive获取新消息了. 而this.memoryStream将作为待处理消息的携带者继续传递消息. 执行`this.OnRead(stream);`跳到Session.cs的OnRead方法. 目前我这里也没看懂是怎么跳过去的,但是跟着VS逐步调试的确是走这边.

## flg标志

接着来看Session.cs的Run方法. `byte flag = memoryStream.GetBuffer()[Packet.FlagIndex];` 取字节流的第1个字节,用做标记,使用默认的AllServer配置的话,这里flag=0. 如果falg=1,表示这是rpc返回消息.

## opcode标志

继续. `ushort opcode = BitConverter.ToUInt16(memoryStream.GetBuffer(), Packet.OpcodeIndex);` 取字节流的第2-第3个字节,用于标记opcode,每一个opcode都代表着一个Type,如果指定Type的实例不存在则创建实例,如果opcode不存在则Type为null,创建实例时报错被Exception e捕获.

## opcode值算法

和前面小包长度一样,都是2个10进制数-转16进制-换位置合并-转10进制 比如我这里用一个注册消息测试,memoryStream.GetBuffer()返回值的第2-第3位分别是29 39 转16进制:29/16=1余13=1D 39/16=2余7=27 也就是1D 27 换位置合并:271D 转10进制:13+1X16+7X16X16+2X16X16X16=10013 也就是说OpcodeTypeComponent会以opcode为key搜索是否有对应的Type,如果想了解具体词典里面装了哪些**opcode和对应的Type组成的一对**可以在调试信息中观察. ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/postunity11_5.png) 我们需要创建对应的类,来让服务端可以识别这个opcode.

# 注册opcode

我们可以注意到,在服务端初次接收消息之前,服务端已经注册好了很多的opcode. 这里opcode,可以称为**数据包操作码**,Operate Code,每个操作码对应一个请求(request)或者回复(response). 管理opcode的组件是OpcodeTypeComponent,创建于Program.cs `Game.Scene.AddComponent<OpcodeTypeComponent>();` 前面我也提过,看一个Component有什么功能,就看它的类的继承关系/自构方法/Awake方法. OpcodeTypeComponent的父级是Component,没有什么特殊背景,跳过. ET中,一个空的Component和Unity中的空的Component是一个概念,只是因为服务端没有可视化,所以有个明显的Id来区别一下不同Component. OpcodeTypeComponent没有自己的自构方法,跳过. 那么就看Awake方法了. 在OpcodeTypeComponent的Awake方法中,遍历了所有带**MessageAttribute**的Type. 将每个Type的opcode作为key,Type作为value存入opcodeTypes词典. 将每个Type的opcode作为key,Type对应的默认实例存入typeMessages词典.

## MessageAttribute

MessageAttribute类继承于BaseAttribute 带有MessageAttribute特征的类将在初始化程序集阶段(`Game.EventSystem.Add`)被加载. 在MessageAttribute.cs中,MessageAttribute有带参数自构方法: `public MessageAttribute(ushort opcode)` public的,也就是说,在外部被调用了自构方法,并初始化了opcode,究竟是谁调用的呢? 这里以ET 3.6的ETHotfix.C2R\_Login类为例进行说明,其opcode为10001.

## ETHotfix.C2R\_Login

在HotFixOpcode.cs中,有C2R\_Login类的部分定义:

```
[Message(HotfixOpcode.C2R_Login)]
public partial class C2R_Login : IRequest {}
```

partial关键字:表示这个类这里的代码只是一部分代码,在另外的.cs文件中还有另外一部分代码. 另外一部分代码在HotfixMessage.cs中,不过这是一个用Google.Protobuf自动生成的文件,如果不了解Google.Protobuf的同学可以参考我之前写的[v0.1.8 Google.Protobuf](https://acgmart.com/unity/unity8/ "v0.1.8 Google.Protobuf") `Message(HotfixOpcode.C2R_Login)`大概表示C2R\_Login有Message特性,在实例化C2R\_Login时会为其添加一个自定义特性(CustomAttributes,是Type的成员)MessageAttribute.这句话同样指定了MessageAttribute对象的自构方法,HotfixOpcode.C2R\_Login则为指定自构方法的参数. 为什么措辞用"大概"是因为,我只是意会而已,鼠标悬浮在Message上VS提示MessageAttribute的有参自构方法,具体对"特性"的定义/使用暂未了解. 到这里也就很清晰了: **如何生成带MessageAttribute的类** **如何指定类的opcode** **如何通过修改.protoc文件自动生成带有通信协议的.cs文件** 接下来可以考虑修改一下ET 3.6的消息协议列表了.

# 新建请求协议

本节开始,就需要亲自写点什么了. 预计将新建一个带MessageAttribute的类,名称为C2R\_Register\_Req,opcode为10013. 消息成员为int32 RpcId;string Account;string Password. 其中RpcId是"远程调用Id",用于不同类型的服务端之间远程调用,实现分布式服务端. Account是帐号,Password是密码... 编辑HotFixOpcode.cs 在class HotfixOpcode下新增: `public const ushort C2R_Register_Req = 10013;` 在namespace ETHotfix下新增: `[Message(HotfixOpcode.C2R_Register_Req)]` `public partial class C2R_Register_Req : IRequest {}` 这时候IRequest这里会红色下划线提示没有实现接口成员RpcId,需要重新编译HotfixMessage.proto. 在ET-master/Proto文件夹中找到HotfixMessage.proto,这里我使用Notepad++编辑它,添加:

```
message C2R_Register_Req // IRequest
{
    int32 RpcId = 90;
    string  Account  = 1;   // 帐号
    string  Password = 2;   // 密码
}
```

保存后,编译HotfixMessage.proto,编译方法见[v0.1.8 Google.Protobuf](https://acgmart.com/unity/unity8/ "v0.1.8 Google.Protobuf"),这里使用的编译命令应该如下: `protoc --csharp_out=./ HotfixMessage.proto` 得到了新的HotfixMessage.cs,如果直接替换旧HotfixMessage.cs会满页报错,为了解决问题这里对比了下ET的HotfixMessage.cs和protoc编译的HotfixMessage.cs. ET的HotfixMessage.cs文件中类的结构如下: 声明成员变量,每个参数一行,拥有方法WriteTo/CalculateSise/MergeFrom. ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/postunity11_6.png) 这里我为了避免操作繁琐,修改HotfixMessage.cs中新增的C2R\_Register\_Req部分使之与ET的规则一致,然后新增部分将加到旧的HotfixMessage.cs中. 新增部分代码如下:

```
    public partial class C2R_Register_Req : pb::IMessage
    {
        //删除IMessage的泛型
        //更改自构方法 减少垃圾回收
        //删除_unknownFields字段
        private static readonly pb::MessageParser<C2R_Register_Req> _parser
            = new pb::MessageParser<C2R_Register_Req>(()
                => (C2R_Register_Req)MessagePool.Instance.Fetch(typeof(C2R_Register_Req)));
        public static pb::MessageParser<C2R_Register_Req> Parser { get { return _parser; } }

        //去掉所有Attribute [xxx]
        //去掉除WriteTo/CalculateSize/MergeFrom以外的方法
        //去掉所有Field number参数
        private int rpcId_;
        public int RpcId
        {
            get { return rpcId_; }
            set
            {
                rpcId_ = value;
            }
        }

        private string account_ = "";
        /// <summary>
        /// 帐号
        /// </summary>
        public string Account
        {
            get { return account_; }
            set
            {
                account_ = pb::ProtoPreconditions.CheckNotNull(value, "value");
            }
        }

        private string password_ = "";
        /// <summary>
        /// 密码
        /// </summary>
        public string Password
        {
            get { return password_; }
            set
            {
                password_ = pb::ProtoPreconditions.CheckNotNull(value, "value");
            }
        }

        //去掉所有_unknownFields
        public void WriteTo(pb::CodedOutputStream output)
        {
            if (Account.Length != 0)
            {
                output.WriteRawTag(10);
                output.WriteString(Account);
            }
            if (Password.Length != 0)
            {
                output.WriteRawTag(18);
                output.WriteString(Password);
            }
            if (RpcId != 0)
            {
                output.WriteRawTag(208, 5);
                output.WriteInt32(RpcId);
            }
        }

        public int CalculateSize()
        {
            int size = 0;
            if (RpcId != 0)
            {
                size += 2 + pb::CodedOutputStream.ComputeInt32Size(RpcId);
            }
            if (Account.Length != 0)
            {
                size += 1 + pb::CodedOutputStream.ComputeStringSize(Account);
            }
            if (Password.Length != 0)
            {
                size += 1 + pb::CodedOutputStream.ComputeStringSize(Password);
            }
            return size;
        }

        //去掉MergeFrom(ClassName other)
        //添加默认值 数值类的为0 字符串为""
        //替换_unknownFields部分为input.SkipLastField();
        public void MergeFrom(pb::CodedInputStream input)
        {
            account_ = "";
            password_ = "";
            rpcId_ = 0;
            uint tag;
            while ((tag = input.ReadTag()) != 0)
            {
                switch (tag)
                {
                    default:
                        input.SkipLastField();
                        break;
                    case 10:
                        {
                            Account = input.ReadString();
                            break;
                        }
                    case 18:
                        {
                            Password = input.ReadString();
                            break;
                        }
                    case 720:
                        {
                            RpcId = input.ReadInt32();
                            break;
                        }
                }
            }
        }

    }
```

然后可以重新生成解决方案. 从上面的改动可以看出ET框架在尽量减少垃圾回收(GC,Garbage Collection),能复用的就复用,能不新建字段就不新建. 这样的处理的确高效务实的多,代码也变得简洁了,谷歌生成一个message至少200行左右,而删减后只剩100行左右.

## 消息解析

再次进行调试,我们可以发现刚才新写的协议opcode=10013已经被添加到了OpcodeTypeComponent中. ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/postunity11_7.png) `object instance = opcodeTypeComponent.GetInstance(opcode);` 回到Session.cs中Run方法处理消息,依旧是测试斗地主的注册功能,这里根据opcode创建实例instance将不会报错. `message = this.Network.MessagePacker.DeserializeFrom(instance, memoryStream);` 根据协议来反解析字节流,将结果返回给临时变量message. 操作方法是将memoryStream中的字节流反解析后赋值给instance,所以得到的message是ETHotfix.C2R\_Register\_Req的实例,可以在调试中清晰观察到该实例的3个值. 到此消息解析完成,我们已经知道了客户端的完整意图. 在本例中ETHotfix.C2R\_Register\_Req类型的消息表示一个新的用户在请求注册,并提供了假设的账号和密码. 服务端应该判断消息如何处理. 就像[v0.1.5 多人同屏](https://acgmart.com/unity/unity5/ "v0.1.5 多人同屏")中讲到的,一个完整的协议,在文字描述上应包括:收信人/格式/解释/后续操作 4个部分 收信人:当前程序 默认不写 格式:字符串的组成结构 解释:什么情况下谁会发送这个消息给当前程序 后续操作:收到这个消息后应执行什么

## Rpc或消息分发

Rpc是指远程调用,可以参考[来自知乎的解释](https://www.zhihu.com/question/25536695/answer/221638079 "来自知乎的解释"). 由于我本人也没有开发过分布式服务端(多台主机内网共同协作完成一个集群Server)的经验,目前学习ET也是使用的AllServer配置,短期内应该接触不到Rpc,所以不好下定论. 所以,关于Rpc的问题先跳过,这里用消息分发的机制. 等有条件可以尝试下用2个以上阿里云服务器内网操作一波,这个应该是上万人在线时才有的需求吧...

## 消息分发

`this.Network.MessageDispatcher.Dispatch(this, opcode, message)` 调用Session的父级NetOuterComponent的成员MessageDispatcher的Dispatch方法. 在OuterMessageDispatcher.cs中的Dispatch方法处理,这应该是在哪个步骤中把Dispatch方法重载过. 先switch判断消息类型,是不是帧消息/Actor请求/Actor消息,本例中这些都不是. 消息将由MessageDispatherComponent处理,位置是MessageDispatherComponentSystem.cs中的Handle方法. 在Handle方法中,程序将先判断是否存在消息对应的处理方法: `self.Handlers.TryGetValue(messageInfo.Opcode, out actions)` Handlers是MessageDispatherComponent维护的一个词典,以opcode为key进行查找,将value赋值给容器actions. 这里每个opcode可以支持多个处理操作,actions会遍历自己的成员依次执行指定消息处理任务. 由于目前没有注册opcode=10013的消息处理类,所以这里会报错:消息没有处理:opcode message.

# 处理消息

消息处理类,还有更专业的叫法,比如xxx句柄/xxxHandler,在本例中指继承了IMHandler接口的类. 通常来说,我想让描述更通俗易懂一些,这是一个类,创建它的目的是用来处理指定opcode的message. 现在我们需要让词典Handlers中出现我们想要的消息处理类.

## Handlers

MessageDispatherComponent的Awake方法和Load方法功能相同,都指向一个外部的public/static的Load方法,目测是为了实现热更吧. 被指向的Load方法中,先遍历程序集中带有MessageHandlerAttribute的类, MessageHandlerAttribute类指定了一个带参数AppType的自构方法,AppType需要与StartConfig中一致,也就是说针对每种服务端配置都可以新建对应的消息处理类. `Type messageType = iMHandler.GetMessageType();` 通过iMHandler接口继承下来的GetMessageType方法,获得Request(请求协议)的Type,并通过OpcodeTypeComponent以Type为key,查找到的value为opcode.这样就将Request和Handler捆绑在了一起,它们的opcode是相同的. 将**opcode和消息处理类**作为一对,存入词典Handlers中. 通过以上,可以知道一个消息处理类应满足以下条件: 继承IMHandler接口,并重载其所有方法,其中Handle方法处理消息. 带MessageHandler特性,且特性类使用带参数AppType的自构方法. 这里以ET 3.6的ETHotfix.C2R\_LoginHandler类为例进行说明,其opcode为10001.

## ETHotfix.C2R\_LoginHandler

我们来看看C2R\_LoginHandler类 `[MessageHandler(AppType.Realm)]` `public class C2R_LoginHandler : AMRpcHandler<C2R_Login, R2C_Login>` C2R\_LoginHandler满足MessageHandler特性,并且使用AppType.Realm为带参自构方法的参数. AllServer支持所有的服务端类型,所以Realm服务端也在其扮演范围内. C2R\_LoginHandler不是直接继承IMHandler接口,而是通过继承`AMRpcHandler<C2R_Login, R2C_Login>`类实现了继承链. C2R\_LoginHandler有一个protected override async void Run方法,override表示本方法重载了基类中的同名方法,async表示本方法中的特定操作将会异步执行. 但是实际上`AMRpcHandler<C2R_Login, R2C_Login>`是不直接存在的,这是一个使用了泛型的类,要带参数去构建. `public abstract class AMRpcHandler<Request, Response>: IMHandler where Request : class, IRequest where Response : class, IResponse` abstract表示这是一个抽象类,将不能被实例化,并提供参数和方法给子类继承. where表示对泛型类的约束,这里where出现了2次,分别是: where Request : class, IRequest where Response : class, IResponse Request是指请求协议,比如我们刚才创建的C2R\_Register\_Req类就是注册请求的协议,继承IRequest接口,opcode=10013. Response是指回复协议,这个我们还没有创建好,我们待会再创建一个**opcode=10014**的回复协议. 当程序运行到C2R\_LoginHandler类时,先尝试自构-发现有父级-尝试父级的构建-发现`AMRpcHandler<C2R_Login, R2C_Login>`还有父级-尝试父级IMHandler的构建.像这样,先构建父级再进行自构.所以**请求协议+回复协议**在消息处理类被加入词典时是必须的,不然因无法实例化而报错.

## AMRpcHandler

继续看AMRpcHandler的成员方法. `protected static void ReplyError` 这是个内部的静态方法,可以被其子类调用,用于报错. `protected abstract void Run` 这是个内部的抽象方法,仅用于被继承. `public void Handle` 这是个供外部调用,用于处理**请求协议**消息的方法. Handle方法简单判断了下消息是否类型正确,然后为Run方法准备参数,所以实际上Handel就是在执行AMRpcHandler子类中的Run方法. Run方法的第3个参数`Action<Response> reply`是一个指定的操作,所以其变量的形式是Lambda表达式:

```
response =>  //只有1个参数的Lambda表达式,多个参数需要使用(xxx,xxx)
{
    // 等回调回来,session已经可以断开了,所以需要判断session InstanceId是否一样
    if (session.InstanceId != instanceId)
    {
        return;
    }
    response.RpcId = rpcId;  //回复协议的RpcId与请求协议一致
    session.Reply(response);  //消息处理-回复
}
```

这个Lambda表达式对应的构造是:`public delegate void Action<in T>(T obj)`,指定1个参数的无返回方法. 然后是,需要了解下session在什么情况下会断开,session(会话)这个单词在程序语言中表达的意义非常广泛,可以指整个沟通过程(比如本例中的channel),也可以指收到一次请求协议并处理完的过程. 通过以上内容,我们可以知道接下来该怎么做了: 创建opcode=10014的回复协议R2C\_Register\_Ack 创建类消息处理类:ETHotfix.OP\_Register\_Handler : AMRpcHandler<C2R\_Register\_Req, R2C\_Register\_Ack> 还有对应的处理方法Run.

# 新建回复协议

因为上面有新建请求协议的经验,所以这里可以快一点进行了. HotfixOpcode.cs中,新建opcpde: `public const ushort R2C_Register_Ack = 10014;` HotfixOpcode.cs中,新建回复协议R2C\_Register\_Ack的声明部分: `[Message(HotfixOpcode.R2C_Register_Ack)]` `public partial class R2C_Register_Ack : IRequest {}` HotfixMessage.proto中添加回复协议R2C\_Register\_Ack的message结构,并生成.cs文件进行修改.

```
message R2C_Register_Ack // IResponse
{
    int32 RpcId = 90;
    int32 Error = 91;
    string Message = 92;
}
```

HotfixMessage.cs中,添加修改好了的回复协议R2C\_Register\_Ack的message部分.

```
   public partial class R2C_Register_Ack : pb::IMessage
    {
        private static readonly pb::MessageParser<R2C_Register_Ack> _parser
            = new pb::MessageParser<R2C_Register_Ack>(()
                => (R2C_Register_Ack)MessagePool.Instance.Fetch(typeof(R2C_Register_Ack)));
        public static pb::MessageParser<R2C_Register_Ack> Parser { get { return _parser; } }


        private int rpcId_;
        public int RpcId
        {
            get { return rpcId_; }
            set
            {
                rpcId_ = value;
            }
        }

        private int error_;
        public int Error
        {
            get { return error_; }
            set
            {
                error_ = value;
            }
        }

        private string message_ = "";
        public string Message
        {
            get { return message_; }
            set
            {
                message_ = pb::ProtoPreconditions.CheckNotNull(value, "value");
            }
        }

        public void WriteTo(pb::CodedOutputStream output)
        {
            if (RpcId != 0)
            {
                output.WriteRawTag(208, 5);
                output.WriteInt32(RpcId);
            }
            if (Error != 0)
            {
                output.WriteRawTag(216, 5);
                output.WriteInt32(Error);
            }
            if (Message.Length != 0)
            {
                output.WriteRawTag(226, 5);
                output.WriteString(Message);
            }
        }

        public int CalculateSize()
        {
            int size = 0;
            if (RpcId != 0)
            {
                size += 2 + pb::CodedOutputStream.ComputeInt32Size(RpcId);
            }
            if (Error != 0)
            {
                size += 2 + pb::CodedOutputStream.ComputeInt32Size(Error);
            }
            if (Message.Length != 0)
            {
                size += 2 + pb::CodedOutputStream.ComputeStringSize(Message);
            }
            return size;
        }

        public void MergeFrom(pb::CodedInputStream input)
        {
            rpcId_ = 0;
            error_ = 0;
            message_ = "";
            uint tag;
            while ((tag = input.ReadTag()) != 0)
            {
                switch (tag)
                {
                    default:
                        input.SkipLastField();
                        break;
                    case 720:
                        {
                            RpcId = input.ReadInt32();
                            break;
                        }
                    case 728:
                        {
                            Error = input.ReadInt32();
                            break;
                        }
                    case 738:
                        {
                            Message = input.ReadString();
                            break;
                        }
                }
            }
        }

    }
```

关于修改规则,参考请求消息的写法

# 如何处理消息

消息处理包含逻辑部分和代码部分,先说逻辑. 新用户发来了注册请求,消息中包含了假定的账号和密码. 因为账号密码有硬性的规则要求,如:长短要求,是否必须包含大小写和字母,不得包含特殊字符,如果有屏蔽字要求得接入屏蔽字库...在本例中为了简化问题,选择性跳过这个问题. 因为账号具有唯一性,我们先去和数据库确认一下是否有此账号,这里到涉及到数据库的查询功能. 那么就得使用数据库操作相关的组件DBProxyComponent,ET对它的解释是:用来与数据库操作的代理. 也就是说,我们使用DBProxyComponent的查询方法即可(如果没有方法???那肯定是ET的问题!). 就查询操作而言,我们提供一个账号,期望数据库返回所有符合条件的帐号信息,如果返回的帐号信息数=0,那么不存在此帐号.为此,我们需要创建一个消息类型-帐号信息-**AccountInfo**. 这里有2个分支,1是注册请求符合注册条件,2是注册请求不符合注册条件. 分支1:这个新用户符合注册条件,为其新建一个玩家信息-**PlayerInfo**.再为其新建一个AccountInfo. 我们还需要通知用户注册成功了,也就是将R2C\_Register\_Ack消息返回给玩家,这里可以编辑message的值,但是没有必要.客户端可以通过Error的值判断返回结果,比如Response.Error默认等于0,客户端目前只需要知道注册结果是成功还是失败. 分支2:这个新用户不符合注册条件,根据注册规则返回其遇到的错误,这里需要维护一份错误代码ErrorCode类.如:注册信息不符合要求,**ErrorCode.Registe\_Failed**,如果具体到失败原因的话可以用ErrorCode.AccountAlreadyRegisted等等,只要客户端能看得懂即可. 那么我们应该做的是: 新增数据库消息类:DB\_AccountInfo/DB\_PlayerInfo 新增ErrorCode:ERR\_Registe\_Failed DB\_AccountInfo:

```
[BsonIgnoreExtraElements]
public class DB_AccountInfo : Entity
{
    //用户名
    public string Account { get; set; }

    //密码
    public string Password { get; set; }
}
```

DB\_PlayerInfo:

```
[BsonIgnoreExtraElements]
public class DB_PlayerInfo : Entity
{
    //昵称
    public string NickName { get; set; }

    //胜场
    public int Wins { get; set; }

    //负场
    public int Loses { get; set; }

    //余额
    public long Money { get; set; }
}
```

这2个类放到namespace ETModel下即可,这些类只会在被使用前实例化,需要使用using~. using MongoDB.Bson.Serialization.Attributes; `[BsonIgnoreExtraElements]`是一个序列化相关的特性,你或许和我一样很在意IgnoreExtraElements是什么意思. 就是说:一开始你存入了一个PlayerInfo,后来你修改了他,特别是增加了额外的东西,当你再次检索的时候返回的对象在类型上已经和PlayerInfo不同了. 于是就会报错:xxx元素与PlayerInfo类的任何字段或属性都不匹配. 为了解决这个问题,可以使用BsonIgnoreExtraElements特性,它会忽略掉额外的元素. BsonIgnoreExtraElements的使用场景是:当你希望你的检索结果与对象匹配时. 增加自定义错误代码,ErrorCode.cs: `public const int ERR_Registe_Failed = 100001;`

## 新建消息处理类

其实对文件名没有具体要求的,这里我为了方便自己,在Server.Hotfix项目下面新建文件夹opcode,然后新建文件op100013.cs,完整内容如下.

```
using System;
using ETModel;
using System.Collections.Generic;

namespace ETHotfix
{
    [MessageHandler(AppType.Realm)]
    public class OP_Register_Handler : AMRpcHandler<C2R_Register_Req, R2C_Register_Ack>
    {
        protected override async void Run(Session session, C2R_Register_Req message, Action<R2C_Register_Ack> reply)
        {
            R2C_Register_Ack response = new R2C_Register_Ack();
            try
            {
                //数据库操作对象
                DBProxyComponent dbProxy = Game.Scene.GetComponent<DBProxyComponent>();

                //查询账号是否存在
                List<ComponentWithId> result = await dbProxy.Query<DB_AccountInfo>($"{{Account:'{message.Account}'}}");
                if (result.Count > 0)
                {
                    response.Error = ErrorCode.ERR_Registe_Failed;
                    reply(response);
                    return;
                }

                //新建账号
                DB_AccountInfo newAccount = ComponentFactory.CreateWithId<DB_AccountInfo>(IdGenerater.GenerateId());
                newAccount.Account = message.Account;
                newAccount.Password = message.Password;

                Log.Info($"注册新账号：{MongoHelper.ToJson(newAccount)}");

                //新建用户信息
                DB_PlayerInfo newUser = ComponentFactory.CreateWithId<DB_PlayerInfo>(newAccount.Id);
                newUser.NickName = $"用户{message.Account}";
                newUser.Money = 10000;

                //保存到数据库
                await dbProxy.Save(newAccount);
                await dbProxy.Save(newUser, false);

                reply(response);
            }
            catch (Exception e)
            {
                ReplyError(response, e, reply);
            }
        }
    }
}
```

接着开始调试,使用斗地主客户端进行注册操作. 控制台结果: ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/postunity11_8.png) 数据库结果: ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/postunity11_9.png) 可以看出,我们成功解析了客户端的一个注册请求,并注册对应的账号. 客户端后续又发来了一连串的消息,由于我们还没有安排消息处理,所以必定会报错. 本篇就到此结束了.

# 后记

在本篇中,我们实现了ET 3.6服务端的注册功能,至于登陆...操作和注册差不多. 有一点值得注意的是观察channel的全程变化,是否是1个在线的玩家对应1个channel呢,可以每秒钟打印当前在线的玩家看看哟~ 作为第一个功能,我尽量写的更详细一些,以后只会对某个模块进行分析. 我们将实现更多的功能,直到完成一个新的游戏.