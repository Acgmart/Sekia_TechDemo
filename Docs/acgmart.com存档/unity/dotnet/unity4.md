---
title: 服务端启蒙4 初试多线程
categories:
- [Unity, ET]
date: 2018-08-24 01:03:06
---

\[toc\]在本篇中,将继续对服务器和客户端进行优化,只有体验过真正的卡,才能知道对高性能服务器的追求. 本篇中将实现同时连接多个客户端,至于具体能连上多少个客户端到时候想办法测试一下就清楚了,我使用的测试服务器为linux 1核2G内存,应该可以说是最低配了,并没有指望能干多大事. 在[上一篇](https://acgmart.com/unity/unity3/ "上一篇")中还暴露了一些问题: 服务端是阻塞模式,无法输入命令对程序进行控制,只能强行关闭. 客户端中方块在运动时会因为要发送消息/等待回复而带来卡顿. ...都是单线程的祸,本篇中将实现服务端的多线程.

# 服务端

逻辑部分有相当大的改动,对Listen Read实行了异步操作,创建连接池类 服务端程序的整体情况可以通过折叠代码进行预览: ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/unity/dotnet/017.png) 包含了主要逻辑部分的Server类预览如下,可以看到还有很多可以扩展的地方: ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/unity/dotnet/018.png)

# 服务端代码

```Csharp
using System;
using System.Net;
using System.Net.Sockets;

namespace v0._1._4_server
{
    //程序入口
    class Program
    {
        static void Main(string[] args)
        {
            Server server1 = new Server();
            server1.Start("0.0.0.0",4445);

            while(true)
            {
                String string1 = Console.ReadLine();
                switch(string1)
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
        public TcpListener tcpListener;
        public Connection[] tcpConnections;
        public int maxConnection = 100;  //最大连接数

        //box坐标
        float[] boxPosition = {0f,0f,0f};

        //开启服务器
        public void Start(String host,Int32 port)
        {
            tcpConnections = new Connection[maxConnection];

            //生成全部连接
            for(int i=1;i<maxConnection;i++)
            {
                tcpConnections[i] = new Connection();
            }

            //Tcplistener开始Listen
            tcpListener = new TcpListener(IPAddress.Parse(host), port);
            tcpListener.Start();
            //TcpListener首次Accept
            //BeginAcceptTcpClient:异步回调函数,在操作完成时执行IAsyncResult
            //state:用户自定义对象,在完成异步后传给回调函数
            //返回结果:一个IAsyncResult结果用于标记异步生成的TcpClient
            tcpListener.BeginAcceptTcpClient(new AsyncCallback(AcceptCallback), tcpListener);
            Console.WriteLine("[服务器]启动成功");
        }

        //返回一个可用连接的索引值 返回负数表示获取失败
        int NewIndex()
        {
            if (tcpConnections == null)
                return -1;
            for (int i = 0; i < tcpConnections.Length; i++)
            {
                if (tcpConnections[i] == null)
                {
                    tcpConnections[i] = new Connection();
                    return i;
                }
                else if (tcpConnections[i].isUsing == false)
                {
                    return i;
                }
            }
            return -1;

        }

        //分配连接和循环监听
        void AcceptCallback(IAsyncResult result)
        {
            try
            {
                //获取发起客户端请求TcpListener
                Console.WriteLine("Accept1次");
                TcpListener tcplistener = (TcpListener)result.AsyncState;
                //结束操作
                TcpClient tcpclient = tcplistener.EndAcceptTcpClient(result);
                Int32 index = NewIndex();

                if(index<0)
                {
                    tcpclient.Close();
                    Console.WriteLine("[服务器]连接已满");
                }
                else
                {
                    //初始化连接
                    Connection connect = tcpConnections[index];
                    //为TcpClient创建一个网络流
                    NetworkStream netstream = tcpclient.GetStream();
                    //设置connect的TcpClient/NetworkStream/Index
                    connect.Initialize(tcpclient,netstream,index);

                    Console.WriteLine("客户端连接 ["+ connect.GetAdress()+"] 分配连接ID: "+index);

                    //异步读取消息
                    connect.netStream.BeginRead(connect.readBuff, connect.buffCount, connect.BuffRemain(), 
                            new AsyncCallback(ReadCallback), connect);

                    //TcpListener再次Accept
                    tcpListener.BeginAcceptTcpClient(new AsyncCallback(AcceptCallback), tcpListener);
                }
            }
            catch(Exception e)
            {
                Console.WriteLine("监听异常: {0}",e);
            }
        }

        //异步循环读取消息
        void ReadCallback(IAsyncResult result)
        {
            //获取发起读取的stream
            Connection connect = (Connection)result.AsyncState;

            try
            {
                //结束操作 
                Int32 count = connect.netStream.EndRead(result);
                if(count<=0)
                {
                    //关闭网络流
                    connect.Close();
                    return;
                }
                else
                {
                    Task(connect, count);
                }

                //再次读取消息
                connect.netStream.BeginRead(connect.readBuff, connect.buffCount, connect.BuffRemain(),
                            new AsyncCallback(ReadCallback), connect);
            }
            catch(Exception e)
            {
                Console.WriteLine("连接异常: {0}", e);
            }
        }

        //消息处理
        void Task(Connection connect,Int32 count)
        {
            //数据处理

            /*
            String msg = System.Text.Encoding.ASCII.GetString(connect.readBuff, 0, count);
            //Console.WriteLine("收到 [" + connect.GetAdress() + "] 数据: " + msg);

            //广播
            msg = connect.GetAdress() + " " + msg;
            byte[] bytes = System.Text.Encoding.ASCII.GetBytes(msg);
            for (int i = 0; i < tcpConnections.Length; i++)
            {
                if (tcpConnections[i] == null)
                    continue;
                if (!tcpConnections[i].isUsing)
                    continue;
                if (i == connect.connectID)
                    continue;
                Console.WriteLine("将消息传播给 " + tcpConnections[i].GetAdress());
                tcpConnections[i].netStream.Write(bytes);
            }
            */


            // 转化数据为 ASCII string
            // 取data的前7个字母
            // 约定:客户端发送的消息格式为:move to XXX,XX,XXXX
            String data = System.Text.Encoding.ASCII.GetString(connect.readBuff, 0, 7);

            if (data == "move to")
            {
                Console.WriteLine("这是个移动消息");
                //遍历消息查找关键字",",执行的次数与bytes数组长度有关
                String word = null;
                Int32 lastpoint = 8;//已经读取了的部分的长度
                float[] position = new float[3];
                Int32 index = 1; //读到的坐标的顺序

                //i+1 代表当前读取到的位置
                for (int i = 8; i < connect.readBuff.Length - 8; i++)
                {
                    //从第9个字母开始遍历
                    word = System.Text.Encoding.ASCII.GetString(connect.readBuff, i, 1);
                    if (word == ",")
                    {
                        word = System.Text.Encoding.ASCII.GetString(connect.readBuff, lastpoint, i - lastpoint);
                        position[index - 1] = float.Parse(word);
                        index = index + 1;
                        lastpoint = i + 1;
                    }
                }
                // 第3位坐标
                word = System.Text.Encoding.ASCII.GetString(connect.readBuff, lastpoint, connect.readBuff.Length - lastpoint);
                position[index - 1] = float.Parse(word);

                if (position.Length == 3)
                {
                    boxPosition = position;
                    Console.WriteLine("消息解析为移动至{0},{1},{2}", boxPosition[0], boxPosition[1], boxPosition[2]);
                    data = "boxposition refreshed";
                    Byte[] msg1 = System.Text.Encoding.ASCII.GetBytes(data);
                    connect.netStream.Write(msg1);
                    Console.WriteLine("发送: {0}", data);
                }
                else
                {
                    data = "unkonwn boxposition!";
                    Byte[] msg1 = System.Text.Encoding.ASCII.GetBytes(data);
                    connect.netStream.Write(msg1);
                    Console.WriteLine("发送: {0}", data);
                }
            }
            else if (data == "whereis")
            {
                Console.WriteLine("客户端在请求box位置");
                data = "move to " + boxPosition[0].ToString() + "," + boxPosition[1].ToString() + "," + boxPosition[2].ToString();
                Byte[] msg1 = System.Text.Encoding.ASCII.GetBytes(data);
                connect.netStream.Write(msg1);
                Console.WriteLine("发送: {0}", data);
            }
            else
            {
                data = "unkown message!";
                Byte[] msg1 = System.Text.Encoding.ASCII.GetBytes(data);
                connect.netStream.Write(msg1);
                Console.WriteLine("发送: {0}", data);
            }

        }

        //异步写入消息
        //异步读取数据库
        //异步写入数据库
    }

    //连接池
    public class Connection
    {
        //常量  缓冲区可容纳字节数
        public const Int32 BUFFER_SIZE = 1024;
        //缓冲区
        public byte[] readBuff = new byte[BUFFER_SIZE];
        //已使用的长度
        public Int32 buffCount = 0;  

        //TcpClient
        public TcpClient tcpClient;
        //网络流
        public NetworkStream netStream;
        //连接ID
        public Int32 connectID;
        //是否使用中
        public bool isUsing = false;
        //绑定的客户IP
        public IPAddress customerIP;
        //绑定的客户端口
        public Int32 customerPort;

        //构造函数
        public Connection()
        {
            readBuff = new byte[BUFFER_SIZE];
        }

        //初始化 在开始使用一个连接时
        public void Initialize(TcpClient tcpclient,NetworkStream netstream,Int32 connnectid)
        {
            this.tcpClient = tcpclient;
            this.netStream = netstream;
            this.connectID = connnectid;
            isUsing = true;
            buffCount = 0;
            customerIP = ((IPEndPoint)tcpclient.Client.RemoteEndPoint).Address;
            customerPort = ((IPEndPoint)tcpclient.Client.RemoteEndPoint).Port;
        }

        //缓冲区剩余字节数
        public int BuffRemain()
        {
            return BUFFER_SIZE - buffCount;
        }

        //获取客户端地址
        public String GetAdress()
        {
            if (!isUsing)
                return "无法获取地址";
            return customerIP.ToString()+":"+customerPort.ToString();
        }

        //关闭连接
        public void Close()
        {
            if (!isUsing)
                return;
            Console.WriteLine("断开连接"+GetAdress());
            netStream.Close();
            tcpClient.Close();
            isUsing = false;
        }
    }
}
```

# 服务端运行结果

上面的服务端代码在消息处理逻辑上和 [上一篇](https://acgmart.com/unity/unity3/ "上一篇") 中没有任何变化,所以可以直接运行客户端测试,结果如下. ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/unity/dotnet/019.png) 可以直观的感受到操作方块时...依旧很卡 客户端连接一直被分配的连接ID为0,因为客户端每个物理帧都会发送并中断一次TCP连接请求,所以客户端的连接请求到达服务器时,上一个连接应该已经被关闭了. 客户端的端口也每次都不同,这里可以理解为客户端在取任意空闲的端口用于与服务器通信.

# 广播

可以注意到代码中Task()函数还有一段被注释的地方,这里的功能是将消息转发给其他用户. 但是我们现在还没准备好处理其他用户的转发消息,客户端需要进行对应的解析来更新屏幕中的其他玩家.

# 改进方向

在下一篇中,将彻底改变单机的格局,同一个屏幕中可以登录复数玩家,描述如下: 当玩家首次登陆的时,客户端和服务端确定连接,服务端返回客户端一个playerID,playerID的作用是标记客户端,客户端将playerID通过文本保存起来,之后不再发生变化. 其次每个玩家还有自己的playerName,是由玩家的外网IP和连接用端口组成的String.如"127.0.0.1:55944"的形式,每次登陆都会发生变化. 当其他玩家登陆/移动/下线时,服务端会广播给全部玩家playerID和坐标信息,并在客户端上更新其他玩家的坐标,实现观察其他玩家移动的效果. 由于Unity中非主线程不能进行组件相关操作(会报错),所以对客户端代码将引入新的"(字符串)消息列表"的处理方式,而服务端目前改不改影响不大. 在下下篇中将使用数据库记录玩家的信息 以上