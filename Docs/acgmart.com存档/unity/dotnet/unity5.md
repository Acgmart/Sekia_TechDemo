---
title: 服务端启蒙5 多人同屏
categories:
- [Unity, ET]
date: 2018-08-24 01:03:11
---

\[toc\]在本篇中,将彻底改变单机的格局,同一个屏幕中可以登录复数玩家,描述如下: 1.存档/注册/登陆/下线 **客户端**:当玩家首次登陆的时,客户端和服务端确定连接,服务端返回客户端一个Int32 playerID,如"1". playerID是唯一的.作用是标记客户端,客户端将playerID通过客户端本地文件保存(**序列化**保存本地游戏数据)起来,之后不再发生变化. 初始坐标为0.0.0,移动时会更新坐标到服务端 服务端:当确立新的连接(注册)时,给客户端一个新的playerID 当收到一个有playerID的请求时(登陆),遍历所有连接找到匹配的playerID 2.**玩家名** 每个玩家都有自己的playerName,由玩家的外网IP和连接用端口组成的String.如"27.17.211.70:55944"的形式,每次登陆端口都会发生变化. 服务端:当完成连接时更新玩家的玩家名,并通知客户端新的玩家名 客户端:在初始化每个玩家(由方块扮演)时,设置玩家名,并用标签显示在方块上方. 3.**画面更新** 这里区分"当前玩家"和"其他玩家" **当前玩家**:游戏开始时,界面时并没有任何玩家(方块),通过实例化prefab的形式在画面中产生出一个"玩家形象",并让当前玩家拥有对该"玩家形象"的操控权. **其他玩家**:当前玩家初始化后,立刻检查一次全部玩家,当有其他玩家注册/登陆/下线时,由服务端更新玩家状态并通知所有在线的玩家.当前玩家不具有其他其他玩家的操控权,在当前玩家的画面中,其他玩家将平滑移动至其最新坐标. 4.客户端的异步读取 客户端的异步读取相对于服务端的一个连接,可以简化后照搬过来. 5.**消息列表** 由于Unity客户端中子线程无法操作组件,如子线程在设置transform.position时会发生报错,这里的应对方式是: 通过using System.Collections.Generic;开启List类,实现消息列表功能. 当读取到新的byte\[\]时,简单处理为字符串并添加到List中. 在void Update()中处理消息列表中一定数量的消息,并将处理掉的消息删除. 通过消息列表机制,可以让多线程回归单线程 6.整理通信**协议** 本次更新中出现了新的通信功能需求,应重新整理服务端和客户端之间的通信协议,将不同的协议单独作为函数执行. 每个协议都应包含收信人/格式/解释/后续操作 4个部分 收信人:当前程序 默认不写 格式:字符串的组成结构 解释:什么情况下谁会发送这个消息给当前程序 后续操作:收到这个消息后应执行什么 其他.Unity对应.NET Core版本落后 在使用Visual Studio自带的Unity开发组件时,发现Unity开发组件虽然也可以用.NET Core的函数,但是版本上离最新的.NET Core有差距. 经常同样一个函数在使用.NET Core跨平台开发组件时,有更多的函数重载,部分函数在Unity开发组件中不可用. 最重要的是使用.NET Core跨平台开发组件时可以看到函数的参数详细解释,而Unity开发组件中完全没有解释,待遇差别巨大! 这种情况下不确定能不能手动更新Unity开发组件的底层函数,两边本来可以复用的功能代码上会稍微有区别.

# 序列化测试

我们先做一个小测试,如何通过序列化来保存数据到本地磁盘,并读取/修改数据.

```Csharp
using System.IO;
using System.Runtime.Serialization.Formatters.Binary;
using UnityEngine;

public class Test : MonoBehaviour
{
    string path= "playerData";
    Player playerOwner;

    void Awake ()
    {
        filetest();
        playerOwner = fileread();
    }

    void filetest()
    {
        if (!File.Exists(path))
        {
            Player player = new Player();
            player.coin = 1;
            player.money = 10;
            player.name = "XiaoMing";

            BinaryFormatter bf = new BinaryFormatter();
            FileStream filestream = new FileStream(path, FileMode.Create, FileAccess.Write, FileShare.None);
            bf.Serialize(filestream, player);
            filestream.Close();
        }
    }

    Player fileread()
    {
        BinaryFormatter bf = new BinaryFormatter();
        FileStream fileStream = new FileStream("playerData", FileMode.Open, FileAccess.Read, FileShare.Read);
        Player player = (Player)bf.Deserialize(fileStream);
        fileStream.Close();
        //输出验证
        Debug.Log("coin:"+player.coin);
        Debug.Log("money:" + player.money);
        Debug.Log("name:" + player.name);
        return player;
    }
}

[System.Serializable]
public class Player
{
    public int coin;
    public int money = 0;
    public string name = "";
}
```

将这个测试脚本添加到组件运行后,可以发现程序的根目录多了一个"playerData"文件,文件打开后里面字段可以看到,但是值是打码的. 根据log输出的信息判断,可以正常读写文件.

# 服务端调整

![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/unity/dotnet/020.png) 从类声明上可以看出,本篇的服务端多了一个Player类,作用于实现多玩家在线. 目前Player类的成员描述了一个玩家应具有的属性,然后在Server类中通过Player\[\] playerGroup来建立玩家数组.

```Csharp
//玩家
    public class Player
    {
        public int playerID;
        public string xPos;
        public string yPos;
        public string zPos;
    }
```

本篇中依然不会使用到数据库,所以玩家的信息都会储存在内存中,通过唯一关键值playerID来找到玩家. 对应的客户端有2种登陆方式,一种是注册获得新的playerID,另一种是提供已有ID登陆. ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/unity/dotnet/021.png) Server类也有相应变化 首先是玩家数组Player\[\] playerGroup和最大注册数maxPlayer,用于保存玩家列表. 其中3系坐标xPos,yPos,zPos是**字符串**属性的值,目前来说服务器对玩家的坐标没有计算需求,只有保存需求. 比如说有一个位移类技能,需要向某个向量移动,则需要一定的计算. 保存为浮点数可能会制造很多的BUG...特别是Windows里面调试运行没问题,丢进Linux里面却报错那种... int NewIndex(Connection connect) 返回一个可复用的连接,会优先使用ID更小的闲置连接,所以想要ID更大的连接就必须同时在线的连接足够多. int NewplayerID() 收到注册请求时会创建新的玩家对象和ID,这个ID也是playerGroup中的关键值. void AcceptCallback(IAsyncResult result) TcpListener的异步循环监听,但是TcpClient在接受消息时,对第一条消息要求必须为注册/登陆消息. 如果不是注册/登陆消息则会报错退出连接,没有完成登陆以前都不会绑定玩家ID和连接ID,实现了一层过滤. 当然这个部分最好得做排队系统,比如设置服务器最大连接数为5,第6个玩家连接时,就提示"前面还有0位玩家在等待". void ReadCallback(IAsyncResult result) 异步循环读取消息中,更新了指定的协议,对无法识别的协议全部报错并退出连接. void logoutsMsg(Connection connect) 在用户登录以后,所有的通信报错,在退出连接以前都执行此函数,通知其他玩家指定连接绑定的玩家掉线.

# 服务端代码

```Csharp
using System;
using System.Net;
using System.Net.Sockets;

namespace v0._1._4_server
{
    //入口
    class Program
    {
        static void Main(string[] args)
        {
            Server server1 = new Server();
            server1.Start("0.0.0.0", 4445);

            while (true)
            {
                String string1 = Console.ReadLine();
                switch (string1)
                {
                    case "quit":  //退出程序
                        return;
                }
            }
        }
    }

    //服务器
    public class Server
    {
        TcpListener tcpListener;
        Connection[] tcpConnections;
        int maxConnection = 100;  //最大连接数
        Player[] playerGroup;
        int maxPlayer = 1000;  //最多注册数

        //开启服务器
        public void Start(string host, int port)
        {
            tcpConnections = new Connection[maxConnection];
            playerGroup = new Player[maxPlayer];

            //Tcplistener开始Listen
            tcpListener = new TcpListener(IPAddress.Parse(host), port);
            tcpListener.Start();
            //TcpListener首次Accept
            //BeginAcceptTcpClient:异步回调函数,在操作完成时执行IAsyncResult
            //state:用户自定义对象,在完成异步后传给回调函数
            //返回结果:一个IAsyncResult结果用于标记异步生成的TcpClient
            tcpListener.BeginAcceptTcpClient(new AsyncCallback(AcceptCallback), null);
            Console.WriteLine("[服务器]启动成功");
        }

        //返回一个可用连接的索引值 返回负数表示获取失败
        int NewIndex(Connection connect)
        {
            if (tcpConnections == null)
                return -1;
            for (int i = 0; i < tcpConnections.Length; i++)
            {
                if (tcpConnections[i] == null)
                {
                    tcpConnections[i] = connect;
                    return i;
                }
                else if (tcpConnections[i].isUsing == false)
                {
                    tcpConnections[i] = connect;
                    return i;
                }
            }
            return -1;

        }

        //返回一个可用的玩家ID 同时生成对应玩家实例playerGroup[i]
        int NewplayerID()
        {
            if (playerGroup == null)
                return -1;
            for(int i=0;i<playerGroup.Length;i++)
            {
                if(playerGroup[i]==null)
                {
                    playerGroup[i] = new Player();
                    playerGroup[i].playerID = i;
                    return i;
                }
            }
            return -1;
        }

        //处理登陆请求 循环监听登陆消息
        void AcceptCallback(IAsyncResult result)
        {
            TcpClient tcpsigninclient = tcpListener.EndAcceptTcpClient(result);
            NetworkStream tcpsigninstream = tcpsigninclient.GetStream();
            //connect将作为主要传递值
            Connection connect = new Connection();
            connect.tcpClient = tcpsigninclient;
            connect.netStream = tcpsigninstream;
            try
            {
                //TcpListener再次Accept
                tcpListener.BeginAcceptTcpClient(new AsyncCallback(AcceptCallback), null);

                //TcpClient阻塞读取登陆消息
                int count = tcpsigninstream.Read(connect.readBuff, 0, connect.readBuff.Length);
                if (count < 0)
                {
                    Console.WriteLine("Mark 1");
                    connect.Close();
                    return;
                }

                //处理登陆消息
                string message = System.Text.Encoding.ASCII.GetString(connect.readBuff, 0, count);
                Console.WriteLine("收到注册/登陆消息: " + message);
                string[] args = message.Split(' ');

                if (args[0] == "registe")
                {
                    //协议:"registe"
                    //客户端发给服务端的注册请求
                    //后续操作:分配一个新的连接给客户端 初始化连接

                    //tcpConnections[i] = connect; ID有最小复用原则
                    int index = NewIndex(connect);
                    if (index < 0)  //连接数上限
                    {
                        Console.WriteLine("[服务器]连接已满");
                        //没有登陆排队系统
                        connect.Close();
                        return;
                    }

                    //玩家ID没有超出上限    生成playerID和playerGroup[playerID]
                    int playerid = NewplayerID();
                    if (playerid<0)
                    {
                        Console.WriteLine("玩家注册达到上限");
                        connect.Close();
                        return;
                    }
                    //初始化连接  玩家用playerID作为唯一凭据
                    connect.playerID = playerid;  //这个连接临时绑定的玩家ID
                    connect.connectPlayer = playerGroup[playerid];  //这个连接临时绑定的玩家
                    playerGroup[playerid].xPos = "0";
                    playerGroup[playerid].yPos = "0";
                    playerGroup[playerid].zPos = "0";
                    connect.isUsing = true;
                    connect.connectID = index;  //基于复用的连接ID 间接属性
                    connect.customerIP = ((IPEndPoint)connect.tcpClient.Client.RemoteEndPoint).Address;
                    connect.customerPort = ((IPEndPoint)connect.tcpClient.Client.RemoteEndPoint).Port;
                    connect.playerName = connect.customerIP.ToString() + ":" + connect.customerPort.ToString();

                    Console.WriteLine("客户端连接 [" + connect.playerName + "] 分配连接ID: " + index + " 玩家ID: " + playerid);

                    //回复客户端注册成功消息:"regsuccess playerid  xpos ypos zpos"
                    message = "regsuccess " + playerid + " 0 0 0";
                    byte[] msg = System.Text.Encoding.ASCII.GetBytes(message);
                    connect.netStream.Write(msg, 0, msg.Length);

                    //异步读取消息
                    connect.netStream.BeginRead(connect.readBuff, 0, connect.readBuff.Length, new AsyncCallback(ReadCallback), connect);
                }
                else if (args[0] == "signin")
                {
                    //协议:"sigin playerid"
                    //客户端发给服务端的登陆请求
                    //后续操作:分配一个新的连接给客户端 初始化连接

                    //tcpConnections[i] = connect; ID有最小复用原则
                    int index = NewIndex(connect);
                    if (index < 0)  //连接数上限
                    {
                        Console.WriteLine("[服务器]连接已满");
                        //没有登陆排队系统
                        connect.Close();
                        return;
                    }

                    connect.playerID = int.Parse(args[1]);  //这个连接临时绑定的玩家ID
                    connect.connectPlayer = playerGroup[int.Parse(args[1])];  //这个连接临时绑定的玩家
                    connect.isUsing = true;
                    connect.connectID = index;  //基于复用的连接ID 间接属性
                    connect.customerIP = ((IPEndPoint)connect.tcpClient.Client.RemoteEndPoint).Address;
                    connect.customerPort = ((IPEndPoint)connect.tcpClient.Client.RemoteEndPoint).Port;
                    connect.playerName = connect.customerIP.ToString() + ":" + connect.customerPort.ToString();

                    Console.WriteLine("客户端连接 [" + connect.playerName + "] 分配连接ID: " + index + " 玩家ID: " + int.Parse(args[1]));

                    //回复客户端登陆成功消息:"sigsuccess playerid  xpos ypos zpos"
                    message = "sigsuccess " + int.Parse(args[1]) + " "+ playerGroup[int.Parse(args[1])].xPos+" "+ playerGroup[int.Parse(args[1])].yPos+" "+ playerGroup[int.Parse(args[1])].zPos;
                    byte[] msg = System.Text.Encoding.ASCII.GetBytes(message);
                    connect.netStream.Write(msg, 0, msg.Length);

                    //异步读取消息
                    connect.netStream.BeginRead(connect.readBuff, 0, connect.readBuff.Length, new AsyncCallback(ReadCallback), connect);
                }
                else
                {
                    message = "signinmsgerror";
                    byte[] msg = System.Text.Encoding.ASCII.GetBytes(message);
                    connect.netStream.Write(msg, 0, msg.Length);
                    Console.WriteLine("未知首次通信消息");
                    connect.Close();
                }

            }
            catch (Exception e)
            {
                connect.Close();
                Console.WriteLine("监听异常: {0}", e);
            }
        }

        //异步循环读取消息
        void ReadCallback(IAsyncResult result)
        {
            Connection connect = (Connection)result.AsyncState;
            int count = connect.netStream.EndRead(result);

            try
            {
                if (count < 0)
                {
                    //关闭连接
                    logoutsMsg(connect);
                    connect.Close();
                    Console.WriteLine("连接被关闭");
                }

                string message = System.Text.Encoding.ASCII.GetString(connect.readBuff, 0, count);
                //Console.WriteLine("收到 [" + connect.playerID + "] 数据: " + message);
                string[] args = message.Split(' ');
                if (args[0] == "moveto")
                {
                    //协议:"moveto xpos ypos zpos"
                    //客户端发来的移动消息
                    //后续操作:保存并广播该消息给其他玩家 "players playerid xpos ypos zpos"
                    connect.connectPlayer.xPos = args[1];
                    connect.connectPlayer.yPos = args[2];
                    connect.connectPlayer.zPos = args[3];
                    message = "players "+ connect.playerID + " " + args[1]+" "+args[2]+" "+args[3];
                    byte[] msg = System.Text.Encoding.ASCII.GetBytes(message);
                    for (int i = 0; i < maxConnection; i++)
                    {
                        if (tcpConnections[i] == null)
                            continue;
                        if (!tcpConnections[i].isUsing)
                            continue;
                        if (i == connect.connectID)
                            continue;
                        Console.WriteLine("将消息传播给玩家ID" + tcpConnections[i].playerID);
                        tcpConnections[i].netStream.Write(msg, 0, msg.Length);
                    }

                    //再次异步读取消息
                    connect.netStream.BeginRead(connect.readBuff, 0, connect.readBuff.Length, new AsyncCallback(ReadCallback), connect);
                }
                else
                {
                    logoutsMsg(connect);
                    connect.Close();
                    Console.WriteLine("不能识别的消息");
                }


            }
            catch (Exception e)
            {
                logoutsMsg(connect);
                connect.Close();
                Console.WriteLine("连接异常: {0}", e);
            }
        }

        //掉线群发
        void logoutsMsg(Connection connect)
        {
            //群发玩家掉线消息
            string message = "logouts " + connect.playerID;
            byte[] msg = System.Text.Encoding.ASCII.GetBytes(message);
            for (int i = 0; i < maxConnection; i++)
            {
                if (tcpConnections[i] == null)
                    continue;
                if (!tcpConnections[i].isUsing)
                    continue;
                if (i == connect.connectID)
                    continue;
                Console.WriteLine("将消息传播给玩家ID" + tcpConnections[i].playerID);
                tcpConnections[i].netStream.Write(msg, 0, msg.Length);
            }
        }
    }

    //连接池
    public class Connection
    {
        //常量  缓冲区可容纳字节数
        public const int BUFFER_SIZE = 1024;
        //缓冲区
        public byte[] readBuff = new byte[BUFFER_SIZE];
        //已使用的长度
        public int buffCount = 0;

        //TcpClient
        public TcpClient tcpClient;
        //网络流
        public NetworkStream netStream;
        //连接ID
        public int connectID;
        //玩家ID
        public int playerID;
        //玩家
        public Player connectPlayer;
        //玩家名
        public string playerName;
        //是否使用中
        public bool isUsing = false;
        //绑定的客户IP
        public IPAddress customerIP;
        //绑定的客户端口
        public int customerPort;

        //关闭连接
        public void Close()
        {
            if (!isUsing)
                return;
            Console.WriteLine("断开连接" + playerID);
            netStream.Close();
            tcpClient.Close();
            isUsing = false;
        }
    }

    //玩家
    public class Player
    {
        public int playerID;
        public string xPos;
        public string yPos;
        public string zPos;
    }
}
```

# 客户端改动

客户端为了配合实现多人同屏效果也应做出对应改变. ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/unity/dotnet/022.png) 首先是用于序列化后本地保存数据的Player类,目前来说需要保存的数据只有playerID; void Signin() 判断本地是否有数据文件,没有就是未注册,有就是已注册. 根据判断结果分别执行注册和ID登陆函数,并在其中完成登陆后才执行异步循环读取. void ShowPosition() 实时更新当前玩家坐标并通知服务器 void ReadmessageTask() 消息列表模式读取异步模式下收到的服务器消息

# 客户端代码NetWork.cs代码

```Csharp
using System.IO;
using System.Runtime.Serialization.Formatters.Binary;
using UnityEngine;
using UnityEngine.UI;
using System;
using System.Net.Sockets;
using System.Collections.Generic;

public class NetWork : MonoBehaviour
{
    //实例化玩家
    public GameObject player;  //玩家模型 用于实例化
    public GameObject mainCamera;  //相机跟随脚本
    CameraFollow cameraFollow;
    GameObject playerOwner;  //当前玩家
    PlayerMove playerMove;   //当前玩家的移动脚本

    public Text playerPos;  //显示和发送当前玩家坐标
    GameObject[] playerGroup;  //玩家数组
    int[] playerIDGroup;  //玩家ID数组
    int maxPlayer = 100;  //最大玩家数

    string path= "playerData";
    //string host = "127.0.0.1";
    string host = "118.89.50.112";
    int port = 4445;
    TcpClient tcpClient;  //唯一的TcpClient
    NetworkStream netStream;  //唯一的NetworkStream
    const int BUFFER_SIZE = 1024;
    byte[] readBuff = new byte[BUFFER_SIZE];
    List<string> messageList = new List<string>();  //消息列表
    bool sigsuccess = false;

    void Awake ()
    {
        playerGroup = new GameObject[maxPlayer];
        playerIDGroup = new int[maxPlayer];
        for (int i=0; i < maxPlayer; i++)
            playerIDGroup[i] = 0;
        Signin();  //登陆
    }

    void Update()
    {

        //处理消息列表
        for (int i = 0; i < messageList.Count; i++)
            ReadmessageTask();
        if(sigsuccess==true)
            ShowPosition();
    }

    //登陆
    void Signin()
    {
        if(File.Exists(path))
        {
            //已注册
            BinaryFormatter bf = new BinaryFormatter();
            FileStream fileStream = new FileStream("playerData", FileMode.Open, FileAccess.Read, FileShare.Read);
            Player player = (Player)bf.Deserialize(fileStream);
            fileStream.Close();

            //用player.playerID连接
            Debug.Log("已注册 ID: "+ player.playerID);
            SigninbyID(player.playerID);
        }
        else
        {
            //未注册
            Debug.Log("未注册");
            Registe();
        }
    }

    //写入玩家ID
    void FileWrite(int playerid)
    {
        if (File.Exists(path))
        {
            Debug.Log("客户端文件损坏");
        }
        else
        {
            Player player = new Player();
            player.playerID = playerid;

            BinaryFormatter bf = new BinaryFormatter();
            FileStream filestream = new FileStream(path, FileMode.Create, FileAccess.Write, FileShare.None);
            bf.Serialize(filestream, player);
            filestream.Close();
        }
    }

    //注册 连接服务器并请求新ID
    void Registe()
    {
        try
        {
            // 连接到服务器外网IP的指定端口
            tcpClient = new TcpClient(host, port);

            //发送字符串:"registe"
            string message = "registe";
            byte[] msg = System.Text.Encoding.ASCII.GetBytes(message);

            netStream = tcpClient.GetStream();
            netStream.Write(msg, 0, msg.Length);
            Debug.Log("发送: " + message);
            int count = netStream.Read(readBuff, 0, readBuff.Length);
            //阻塞等待回复
            if (count>0)
            {
                message= System.Text.Encoding.ASCII.GetString(readBuff, 0, count);
                Debug.Log("收到: " + message);
            }
            else
            {
                Debug.Log("3.注册通信失败");
                tcpClient.Close();
                netStream.Close();
                return;
            }

            //消息处理
            string[] args = message.Split(' ');
            if (args[0] == "regsuccess")
            {
                //协议:"regsuccess playerid  xpos ypos zpos"
                //服务端返回客户端注册成功消息
                //后续操作:返回玩家新ID/载入玩家模型/设置玩家位置/开启组件/设置摄像机/写入玩家ID
                Debug.Log("注册成功 ID: " + args[1]);
                playerOwner = Instantiate(player,new Vector3(float.Parse(args[2]), float.Parse(args[3]), float.Parse(args[4])), player.transform.rotation);
                playerMove = playerOwner.GetComponent<PlayerMove>();  //获得其他Object的类的实例
                playerMove.enabled = true;
                cameraFollow = mainCamera.GetComponent<CameraFollow>();
                cameraFollow.target = playerOwner.transform;
                cameraFollow.enabled = true;
                FileWrite(int.Parse(args[1]));

                sigsuccess = true;
                //首次异步读取消息
                netStream.BeginRead(readBuff, 0, readBuff.Length, new AsyncCallback(ReadCallback), null);
            }
            else if(args[0] == "regfailed")
            {
                //协议:"regfaild reason"
                //服务端返回客户端注册失败消息
                Debug.Log("2.注册失败: ");
                tcpClient.Close();
                netStream.Close();
            }
            else
            {
                Debug.Log("1.未知消息");
                tcpClient.Close();
                netStream.Close();
            } 
        }
        catch (Exception e)
        {
            tcpClient.Close();
            netStream.Close();
            Debug.Log("注册登陆异常:" + e);
        }
    }

    //登陆 使用playerID登陆
    void SigninbyID(Int32 playerid)
    {
        try
        {
            // 连接到服务器外网IP的指定端口
            tcpClient = new TcpClient(host, port);

            //发送字符串:"registe"
            String message = "signin "+playerid;
            Byte[] msg = System.Text.Encoding.ASCII.GetBytes(message);

            netStream = tcpClient.GetStream();
            netStream.Write(msg, 0, msg.Length);
            Debug.Log("发送: " + message);
            int count = netStream.Read(readBuff, 0, readBuff.Length);
            //阻塞等待回复
            if (count > 0)
            {
                message = System.Text.Encoding.ASCII.GetString(readBuff, 0, count);
                Debug.Log("收到: " + message);
            }
            else
            {
                Debug.Log("注册通信失败");
                tcpClient.Close();
                netStream.Close();
                return;
            }

            //消息处理
            String[] args = message.Split(' ');
            if (args[0] == "sigsuccess")
            {
                //协议:"sigsuccess playerid  xpos ypos zpos"
                //服务端返回客户端登陆成功消息
                //后续操作:载入玩家模型/设置玩家位置/开启组件/设置摄像机/写入玩家ID
                Debug.Log("ID登录成功 ID: " + args[1]);
                playerOwner = Instantiate(player, new Vector3(float.Parse(args[2]), float.Parse(args[3]), float.Parse(args[4])), player.transform.rotation);
                playerMove = playerOwner.GetComponent<PlayerMove>();  //获得其他Object的类的实例
                playerMove.enabled = true;
                cameraFollow = mainCamera.GetComponent<CameraFollow>();
                cameraFollow.target = playerOwner.transform;
                cameraFollow.enabled = true;

                //首次异步读取消息
                netStream.BeginRead(readBuff, 0, readBuff.Length, new AsyncCallback(ReadCallback), null);
            }
            else if (args[0] == "regfailed")
            {
                //协议:"regfaild reason"
                //服务端返回客户端注册失败消息
                tcpClient.Close();
                netStream.Close();
                Debug.Log("注册失败");
            }
            else
            {
                tcpClient.Close();
                netStream.Close();
                Debug.Log("未知消息");
            }
        }
        catch (Exception e)
        {
            tcpClient.Close();
            netStream.Close();
            Debug.Log("登陆异常:" + e);
        }
    }

    //异步循环读取消息
    void ReadCallback(IAsyncResult result)
    {
        try
        {
            Int32 count = netStream.EndRead(result);
            //count<0时读取失败,对方Socket已关闭
            //约定客户端与服务端之间通信时字节长度最短为7
            //如:"sign in" "whereis" "move to" 
            if (count < 0)
            {
                tcpClient.Close();
                netStream.Close();
                Debug.Log("连接被关闭");
            }
            else
            {
                //添加到消息列表messageList 不作处理
                String message = System.Text.Encoding.ASCII.GetString(readBuff, 0, count);
                messageList.Add(message);

                //再次读取消息
                netStream.BeginRead(readBuff, 0, readBuff.Length, new AsyncCallback(ReadCallback), null);
            }
        }
        catch (Exception e)
        {
            tcpClient.Close();
            netStream.Close();
            Debug.Log("连接异常: " + e);
        }
    }

    //显示和更新坐标
    void ShowPosition()
    {
        playerPos.text = "当前坐标:" + playerOwner.transform.localPosition;
        string message = playerPos.text;
        message = message.Replace("当前坐标:(", "moveto ");
        message = message.Replace(")", "");
        message = message.Replace(",", "");
        Debug.Log("发送:" + message);
        byte[] msg = System.Text.Encoding.ASCII.GetBytes(message);
        netStream = tcpClient.GetStream();
        netStream.Write(msg, 0, msg.Length);
    }

    //读取消息列表中的一条消息
    void ReadmessageTask()
    {
        //获取一条消息
        if (messageList.Count <= 0)
            return;
        String message = messageList[0];
        messageList.RemoveAt(0);  //删除已读取的消息
        Debug.Log("收到:" + message);

        //根据协议对消息进行分类处理
        //协议:"signin" "whereis" "moveto"
        String[] args = message.Split(' ');  //参数:分隔器
        if (args[0] == "players")
        {
            //协议:"players playerid xpos ypos zpos" 将玩家移动到坐标(1,2,3)
            //玩家不存在时新建玩家并初始化
            if(playerIDGroup[int.Parse(args[1])] == 0)
            {
                //初始化其他玩家
                playerGroup[int.Parse(args[1])] = Instantiate(player, new Vector3(float.Parse(args[2]), float.Parse(args[3]), float.Parse(args[4])), player.transform.rotation);
                playerGroup[int.Parse(args[1])].GetComponent<PlayersMove>().enabled = true;
                playerIDGroup[int.Parse(args[1])] = 1;
                playerGroup[int.Parse(args[1])].GetComponent<PlayersMove>().targetPos = new Vector3(float.Parse(args[2]), float.Parse(args[3]), float.Parse(args[4]));
            }
            else
            {
                playerGroup[int.Parse(args[1])].GetComponent<PlayersMove>().targetPos = new Vector3(float.Parse(args[2]), float.Parse(args[3]), float.Parse(args[4]));
            }

        }
        else if (args[0] == "logouts")
        {
            //协议:"logouts playerid"
            //玩家下线时服务器通知全部玩家
            //客户端收到此消息时删除掉object
            Destroy(playerGroup[int.Parse(args[1])], 1f);
            playerIDGroup[int.Parse(args[1])] = 0;
        }
        else
        {
            tcpClient.Close();
            netStream.Close();
            Debug.Log("未知消息");
        }
    }
}

[System.Serializable]
public class Player
{
    public int playerID;
}
```

## CameraFollow.cs

相机跟随脚本,默认关闭,在生成当前玩家后设置跟随目标target后激活.

```Csharp
using UnityEngine;

public class CameraFollow : MonoBehaviour
{
    public Transform target;  //相机将跟随的目标
    public float smoothing = 5f;  //相机移动速度，略低于玩家移动速度
    public Vector3 offset;  //存储从相机到目标的位移差的初始值

    void Start()
    {
        offset = transform.position;   //从(0,0,0)指向相机的向量
    }

    //相机平稳向方块相对移动
    void FixedUpdate()
    {
        Vector3 targetCamPos = target.position + offset;   //相机的移动目标
        transform.position = Vector3.Lerp(transform.position, targetCamPos, smoothing * Time.deltaTime);  //平滑移动相机
    }
}
```

## PlayerMove.cs

当前玩家的移动脚本,默认关闭,在生成当前玩家实例后激活.

```Csharp
using UnityEngine;

public class PlayerMove : MonoBehaviour
{
    public float speed = 8f;  //移动速度
    Vector3 movement;  //位移向量
    Rigidbody cubeRigidbody;

    void Awake()
    {
        cubeRigidbody = GetComponent<Rigidbody>(); //获取Cube刚体
    }

    private void FixedUpdate()
    {
        float h = Input.GetAxisRaw("Horizontal");
        float v = Input.GetAxisRaw("Vertical");
        movement.Set(h, 0f, v);  //FiexdMove
        movement = movement.normalized * speed * Time.deltaTime;
        cubeRigidbody.MovePosition(transform.position + movement);
    }
}
```

## PlayersMove.cs

其他玩家的移动脚本,默认关闭,在生成其他玩家实例后激活.

```Csharp
using UnityEngine;

public class PlayersMove : MonoBehaviour
{
    public float speed = 8f;  //移动速度
    public Vector3 targetPos;   //相机的移动目标

    void FixedUpdate()
    {
        //平滑移动至目标
        transform.position = Vector3.Lerp(transform.position, targetPos, speed * Time.deltaTime);
    }
}
```

# 运行结果

![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/unity/dotnet/023.png) (玩家ID1掉线了)

# 个人感觉

客户端更新坐标太频繁了吧,把坐标更新函数丢进Update()里面,每秒钟就会发送40次以上了. 所以这个版本的设计其实是不符合游戏设计需求的. 服务器的配置为1核2G 下行流量120kb/s 感觉能稳定接待10-100名网游玩家的样子

# 改进方向

客户端:游戏性方向的改进,如模型/地形/血条(姓名板)/UI/可操作性内容/道具内容 服务端:数据库存储/登陆排队系统/定时器(玩家心跳检测)