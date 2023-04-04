---
title: 服务端启蒙3 两个会动的方块
categories:
- [Unity, ET]
date: 2018-08-24 01:02:18
---

\[toc\]本篇将编写一个简单的服务端和客户端，用来测试Unity中资源的移动。描述如下: 运行客户端后屏幕上出现一个方块,左上角显示了当前方块的坐标,按方向键可以移动方块,摄像机追踪方块但稍微有点延迟可以表现出方块在移动的样子. 运行客户端时,客户端自动连接服务端并读取方块位置. 客户端中移动了方块位置时,服务端自动更新方块位置. 感兴趣的话你也可以看看上一篇:[从0开始的Unity3D游戏开发 v0.1.2 单线程通信示例](https://acgmart.com/unity/unity2/ "从0开始的Unity3D游戏开发 v0.1.2 单线程通信示例")

# 服务端

服务端的设计一方面是用户与服务器之间数据的交互,另一方面则是体现在服务器的性能上,目前的情况相当于我们在开一家餐饮店,只有一名服务员,服务员. 本篇中,我们将安排服务端的服务员一个特定的任务Task,当有客户联系它时,它会返回指定位置. void Task(NetworkStream stream, byte\[\] recbytes) { ... } 这个位置是唯一的,任何人对这个位置进行了修改都将生效,而且他是一个坐标,在Unity中我们可以取物体x/y/z轴的坐标,那么这个位置应该是一个数组,且长度为3,同时我们设置它的初始位置为(0,0,0).我们计划x/z轴平面移动,所以意料之内的情况是y轴值将等于0,不过我们也可以给它添加跳跃功能. Int32\[\] boxposition=new Int32\[3\]; boxposition\[0\]=0;boxposition\[1\]=0;boxposition\[2\]=0;

# 服务端代码

```Csharp
using System;
using System.Net;
using System.Net.Sockets;

namespace v0._1._3_server
{
    class Program
    {
        static void Main(string[] args)
        {
            // 监听4445端口
            Int32 port = 4445;
            IPAddress localAddr = IPAddress.Parse("0.0.0.0");

            TcpListener server = null;
            // 读取缓冲区
            String data = null;
            Byte[] bytes = new Byte[256];

            int i;

            Int32[] boxposition = new Int32[3];
            boxposition[0] = 0; boxposition[1] = 0; boxposition[2] = 0; 

            try
            {
                // 创建Tcplistener实例
                server = new TcpListener(localAddr, port);

                // 开始Listen
                server.Start();

                // 进入监听循环
                while (true)
                {
                    // 这里使用英文命令行输出,避免乱码.
                    Console.Write("等待新连接... ");

                    // 使用阻塞命令,接受请求.
                    TcpClient client = server.AcceptTcpClient();
                    Console.WriteLine("已连接!");

                    // 取TcpClient的网络流,用于读和写
                    NetworkStream stream = client.GetStream();

                    // 循环读取/保存/发送,处理从客户端发送的全部数据
                    // 返回读取到的字节长度,当socket已关闭时返回0
                    // 使用Read()后程序将阻塞在这里
                    while ((i = stream.Read(bytes, 0, bytes.Length)) != 0)
                    {
                        Task(stream,bytes);
                    }

                    // 关闭连接
                    client.Close();
                }
            }
            catch (SocketException e)
            {
                Console.WriteLine("SocketException: {0}", e);
            }
            finally
            {
                // 停止Listen
                server.Stop();
            }


            Console.WriteLine("\nHit enter to continue...");
            Console.Read();

            void Task(NetworkStream stream,byte[] recbytes)
            {
                data = System.Text.Encoding.ASCII.GetString(recbytes, 0, i);
                Console.WriteLine("收到: {0}", data);

                // 转化数据为 ASCII string
                // 取data的前7个字母
                // 约定:客户端发送的消息格式为:move to XXX,XX,XXXX
                data = System.Text.Encoding.ASCII.GetString(recbytes, 0, 7);

                if (data == "move to")
                {
                    Console.WriteLine("这是个移动消息");
                    //遍历消息查找关键字",",执行的次数与bytes数组长度有关
                    String word = null;
                    Int32 lastpoint = 8;//已经读取了的部分的长度
                    Int32[] position = new Int32[3];
                    Int32 index = 1; //读到的坐标的顺序

                    //i+1 代表当前读取到的位置
                    for (i=8; i<recbytes.Length-8; i++)
                    {
                        //从第9个字母开始遍历
                        word = System.Text.Encoding.ASCII.GetString(recbytes, i, 1);
                        if(word == ",")
                        {
                            word = System.Text.Encoding.ASCII.GetString(recbytes, lastpoint, i-lastpoint);
                            position[index-1] = Int32.Parse(word);
                            index = index + 1;
                            lastpoint = i+1;
                        }
                    }
                    word = System.Text.Encoding.ASCII.GetString(recbytes, lastpoint, recbytes.Length-lastpoint);
                    position[index - 1] = Int32.Parse(word);

                    if(position.Length == 3)
                    {
                        boxposition = position;
                        Console.WriteLine("消息解析为移动至{0},{1},{2}", boxposition[0], boxposition[1], boxposition[2]);
                        data = "boxposition refreshed";
                        Byte[] msg = System.Text.Encoding.ASCII.GetBytes(data);
                        stream.Write(msg, 0, msg.Length);
                        Console.WriteLine("发送: {0}", data);
                    }
                    else
                    {
                        data = "unkonwn boxposition!";
                        Byte[] msg = System.Text.Encoding.ASCII.GetBytes(data);
                        stream.Write(msg, 0, msg.Length);
                        Console.WriteLine("发送: {0}", data);
                    }
                }
                else if(data == "whereis")
                {
                    Console.WriteLine("客户端在请求box位置");
                    data = "move to " + boxposition[0].ToString()+","+ boxposition[1].ToString() + ","+boxposition[2].ToString();
                    Byte[] msg = System.Text.Encoding.ASCII.GetBytes(data);
                    stream.Write(msg, 0, msg.Length);
                    Console.WriteLine("发送: {0}", data);
                }
                else
                {
                    data = "unkown message!";
                    Byte[] msg = System.Text.Encoding.ASCII.GetBytes(data);
                    stream.Write(msg, 0, msg.Length);
                    Console.WriteLine("发送: {0}", data);
                }
            }
        }
    }
}
```

# 客户端部分

```Csharp
using System;
using System.Net.Sockets;

namespace v0._1._3_client
{
    class Program
    {
        static void Main(string[] args)
        {
            Connect("118.89.50.112", "whereis");
            Connect("118.89.50.112", "move to 123,456,789");
            Connect("118.89.50.112", "whereis");
            Connect("118.89.50.112", "move to 987,654,321");

            Console.Read();
        }

        static void Connect(String server, String message)
        {
            Int32 i;
            String data = null;
            Int32[] boxposition = new Int32[3];
            boxposition[0] = 0; boxposition[1] = 0; boxposition[2] = 0;
            try
            {
                // 创建TcpClient
                // 需要有一个TcpServer的服务端才能使本客户端工作
                // 连接到服务器外网IP的指定端口
                Int32 port = 4445;
                TcpClient client = new TcpClient(server, port);

                // 转换消息为Byte[]
                Byte[] bytes = System.Text.Encoding.ASCII.GetBytes(message);

                // 获取客户端的网络流,用于读取和发送信息
                NetworkStream stream = client.GetStream();

                // 发送消息 
                stream.Write(bytes, 0, bytes.Length);

                Console.WriteLine("发送: {0}", message);

                // 等待服务器回复消息

                // 用于存储服务器消息的缓冲区
                bytes = new Byte[256];

                // 读取服务器发来的第一条消息,用for循环的话会堵塞
                i = stream.Read(bytes, 0, bytes.Length);

                Task(stream, bytes);

                // 关闭全部
                stream.Close();
                client.Close();
                Console.WriteLine("已断开连接");
            }
            catch (ArgumentNullException e)
            {
                Console.WriteLine("ArgumentNullException: {0}", e);
            }
            catch (SocketException e)
            {
                Console.WriteLine("SocketException: {0}", e);
            }

            // 处理从服务端接收的消息
            void Task(NetworkStream stream, byte[] recbytes)
            {
                data = System.Text.Encoding.ASCII.GetString(recbytes, 0, i);
                Console.WriteLine("收到: {0}", data);

                // 转化数据为 ASCII string
                // 取data的前7个字母
                // 约定:客户端发送的消息格式为:move to XXX,XX,XXXX
                data = System.Text.Encoding.ASCII.GetString(recbytes, 0, 7);

                if (data == "move to")
                {
                    Console.WriteLine("这是个移动消息");
                    //遍历消息查找关键字",",执行的次数与bytes数组长度有关
                    String word = null;
                    Int32 lastpoint = 8;//已经读取了的部分的长度
                    Int32[] position = new Int32[3];
                    Int32 index = 1; //读到的坐标的顺序

                    //i+1 代表当前读取到的位置
                    for (i = 8; i < recbytes.Length - 8; i++)
                    {
                        //从第9个字母开始遍历
                        word = System.Text.Encoding.ASCII.GetString(recbytes, i, 1);
                        if (word == ",")
                        {
                            word = System.Text.Encoding.ASCII.GetString(recbytes, lastpoint, i - lastpoint);
                            position[index - 1] = Int32.Parse(word);
                            index = index + 1;
                            lastpoint = i + 1;
                        }
                    }
                    word = System.Text.Encoding.ASCII.GetString(recbytes, lastpoint, recbytes.Length - lastpoint);
                    position[index - 1] = Int32.Parse(word);

                    if (position.Length == 3)
                    {
                        boxposition = position;
                        Console.WriteLine("消息解析为移动至{0},{1},{2}", boxposition[0], boxposition[1], boxposition[2]);

                        // 加入Unity组件移动函数
                    }
                    else
                    {
                        Console.WriteLine("无法识别的boxposition");
                    }
                }
                else if (data == "boxposi")
                {
                    Console.WriteLine("客户端已确认新位置");
                }
                else
                {
                    Console.WriteLine("未知消息");
                }
            }
        }
    }
}
```

# 服务端的运行结果

![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/unity/dotnet/012.png)

# 客户端的运行结果

![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/unity/dotnet/013.png) 因为我们还没有在Unity里面设置过组件,上面提到的2段代码还只是两个控制台应用程序之间的交互.

# Unity环境设置

今天我们要创建的Unity环境非常简单,因为只是为了进行测试,能辨认清地面和方块就满足要求了. 这一部分内容强烈建议参考[Unity官方教程Survival Shooter](https://acgmart.com/unity/8/ "Unity官方教程Survival Shooter")的第一部分.

## 创建地板

创建一个Quad,进行以下设置 坐标(Position)设置为(0,0,0)； 角度(Rotation)设置为(90,0,0)； 缩放(Scale)设置为(100,100,0)；

## 创建方块

创建一个一个Cube 坐标(Position)设置为(0,0.5,0)；

## 创建材质

在项目资源目录中创建一个新的Material,重命名为Cube,并进行设置 Albedo选择UISprite; 将Cube.mat拖拽到Cube身上完成赋值; 在项目资源目录中创建一个新的Material,重命名为Quad,并进行设置 Albedo选择Default-Particle; 将Quad.mat拖拽到Quad身上完成赋值; 这样简单的添加以下材质的目的只是为了让物体更好辨识而已,使用的贴图也都是系统自带的贴图.

## 设置主相机

设置主相机位置为(0,25,-22)； 设置主相机角度为(45,0,0)； 设置主相机Projection为Perspective； 设置主相机Field of View为40； 设置主相机Clipping Planes-Far为60；

## 设置光源

设置Lights位置为(0,10,0)； 设置光源Scene Lighting的角度为(50,-30,0) 设置光源Scene Lighting的Intensity为1

## 设置UI

创建一个Canvas; 为Canvas添加一个Text,并设置 Anchors: Min:0,1;Max:0,1;Pivot:0,1; PosX:20,PosY:-20; Text:当前坐标: Color:0,0,0,255

## 为Cube添加移动脚本

新建CubeMove.cs,添加为Cube的组件,并编辑:

```Csharp
using UnityEngine;

public class CubeMove : MonoBehaviour
{
    public float speed = 6f;
    Vector3 movement;
    Rigidbody cubeRigidbody;

    private void Awake()
    {
        cubeRigidbody = GetComponent<Rigidbody>(); //获取Cube刚体
        Getboxposition();
    }

    private void FixedUpdate()
    {
        float h = Input.GetAxisRaw("Horizontal");
        float v = Input.GetAxisRaw("Vertical");
        Move(h, v);
    }

    //设置Cube的初始位置  
    void Getboxposition()
    {

    }

    void Move(float h,float v)
    {
        movement.Set(h, 0f, v);
        movement = movement.normalized * speed * Time.deltaTime;
        cubeRigidbody.MovePosition(transform.position + movement);
    }
}
```

## 摄像机跟随脚本

新建CameraFollow.cs,添加为Main Camera的组件,并编辑:

```Csharp
using UnityEngine;

public class CameraFollow : MonoBehaviour
{
    public Transform target;  //相机将跟随的目标
    public float smoothing = 5f;  //相机移动速度，略低于玩家移动速度
    Vector3 offset;  //存储从相机到目标的位移差的初始值

    void Start()
    {
        offset = transform.position;  //从(0,0,0)指向相机的向量
    }

    void FixedUpdate()
    {
        Vector3 targetCamPos = target.position + offset;   //相机的移动目标
        transform.position = Vector3.Lerp(transform.position, targetCamPos, smoothing * Time.deltaTime);  //平滑移动相机
    }
}
```

设置Mian Camera的Camera Follow组件 Target:Cube; 现在我们已经可以体验一下这个demo了,剩下的就是将Unity与.Net Core结合起来.

# 联机版服务端

v0.\_1.\_3\_server

```Csharp
using System;
using System.Net;
using System.Net.Sockets;

namespace v0._1._3_server
{
    class Program
    {
        static void Main(string[] args)
        {
            // 监听4445端口
            Int32 port = 4445;
            IPAddress localAddr = IPAddress.Parse("0.0.0.0");

            TcpListener server = null;
            // 读取缓冲区
            String data = null;
            Byte[] bytes = new Byte[256];

            int i;

            float[] boxposition = new float[3];
            boxposition[0] = 0f; boxposition[1] = 0f; boxposition[2] = 0f; 

            try
            {
                // 创建Tcplistener实例
                server = new TcpListener(localAddr, port);

                // 开始Listen
                server.Start();

                // 进入监听循环
                while (true)
                {
                    // 这里使用英文命令行输出,避免乱码.
                    Console.Write("等待新连接... ");

                    // 使用阻塞命令,接受请求.
                    TcpClient client = server.AcceptTcpClient();
                    Console.WriteLine("已连接!");

                    // 取TcpClient的网络流,用于读和写
                    NetworkStream stream = client.GetStream();

                    // 循环读取/保存/发送,处理从客户端发送的全部数据
                    // 返回读取到的字节长度,当socket已关闭时返回0
                    while ((i = stream.Read(bytes, 0, bytes.Length)) != 0)
                    {
                        Task(stream,bytes);
                    }

                    // 关闭连接
                    client.Close();
                }
            }
            catch (SocketException e)
            {
                Console.WriteLine("SocketException: {0}", e);
            }
            finally
            {
                // 停止Listen
                server.Stop();
            }


            Console.WriteLine("\nHit enter to continue...");
            Console.Read();

            void Task(NetworkStream stream,byte[] recbytes)
            {
                data = System.Text.Encoding.ASCII.GetString(recbytes, 0, i);
                Console.WriteLine("收到: {0}", data);

                // 转化数据为 ASCII string
                // 取data的前7个字母
                // 约定:客户端发送的消息格式为:move to XXX,XX,XXXX
                data = System.Text.Encoding.ASCII.GetString(recbytes, 0, 7);

                if (data == "move to")
                {
                    Console.WriteLine("这是个移动消息");
                    //遍历消息查找关键字",",执行的次数与bytes数组长度有关
                    String word = null;
                    Int32 lastpoint = 8;//已经读取了的部分的长度
                    float[] position = new float[3];
                    Int32 index = 1; //读到的坐标的顺序

                    //i+1 代表当前读取到的位置
                    for (i=8; i<recbytes.Length-8; i++)
                    {
                        //从第9个字母开始遍历
                        word = System.Text.Encoding.ASCII.GetString(recbytes, i, 1);
                        if(word == ",")
                        {
                            word = System.Text.Encoding.ASCII.GetString(recbytes, lastpoint, i-lastpoint);
                            position[index-1] = float.Parse(word);
                            index = index + 1;
                            lastpoint = i+1;
                        }
                    }
                    // 第3位坐标
                    word = System.Text.Encoding.ASCII.GetString(recbytes, lastpoint, recbytes.Length-lastpoint);
                    position[index - 1] = float.Parse(word);

                    if(position.Length == 3)
                    {
                        boxposition = position;
                        Console.WriteLine("消息解析为移动至{0},{1},{2}", boxposition[0], boxposition[1], boxposition[2]);
                        data = "boxposition refreshed";
                        Byte[] msg = System.Text.Encoding.ASCII.GetBytes(data);
                        stream.Write(msg, 0, msg.Length);
                        Console.WriteLine("发送: {0}", data);
                    }
                    else
                    {
                        data = "unkonwn boxposition!";
                        Byte[] msg = System.Text.Encoding.ASCII.GetBytes(data);
                        stream.Write(msg, 0, msg.Length);
                        Console.WriteLine("发送: {0}", data);
                    }
                }
                else if(data == "whereis")
                {
                    Console.WriteLine("客户端在请求box位置");
                    data = "move to " + boxposition[0].ToString()+","+ boxposition[1].ToString() + ","+boxposition[2].ToString();
                    Byte[] msg = System.Text.Encoding.ASCII.GetBytes(data);
                    stream.Write(msg, 0, msg.Length);
                    Console.WriteLine("发送: {0}", data);
                }
                else
                {
                    data = "unkown message!";
                    Byte[] msg = System.Text.Encoding.ASCII.GetBytes(data);
                    stream.Write(msg, 0, msg.Length);
                    Console.WriteLine("发送: {0}", data);
                }
            }
        }
    }
}
```

# 联机版客户端

CubeMove.cs

```Csharp
using System;
using System.Net.Sockets;
using UnityEngine;
using UnityEngine.UI;

public class CubeMove : MonoBehaviour {

    public float speed = 6f;
    public Text textShow;

    String cubePositionformat;
    Vector3 movement;  //位移向量
    Rigidbody cubeRigidbody;
    Vector3 cubePosition;  //Cube本地坐标
    float[] boxPosition = new float[3];  //服务端传来的坐标

    void Awake()
    {
        cubeRigidbody = GetComponent<Rigidbody>(); //获取Cube刚体
        textShow = GameObject.Find("Canvas/Text").GetComponent<Text>();
        Connect("whereis");  //设置Cube的初始位置
    }

    private void FixedUpdate()
    {
        float h = Input.GetAxisRaw("Horizontal");
        float v = Input.GetAxisRaw("Vertical");
        Move(h, v);
    }

    // Cube移动
    void Move(float h, float v)
    {
        movement.Set(h, 0f, v);
        movement = movement.normalized * speed * Time.deltaTime;
        cubeRigidbody.MovePosition(transform.position + movement);  //运动学刚体

        // 更新text中显示的Cube坐标
        textShow.text = "当前坐标:"+transform.localPosition;


        // 判断Cube是否有移动,向服务器发送坐标
        if (h!=0v!=0)
        {
            cubePositionformat = textShow.text.Replace("当前坐标:(", "move to ");
            cubePositionformat = cubePositionformat.Replace(")","");
            cubePositionformat = cubePositionformat.Replace(", ", ",");
            Connect(cubePositionformat);
        }
    }

    void Connect(String message)
    {
        try
        {
            // 创建TcpClient
            // 需要有一个TcpServer的服务端才能使本客户端工作
            // 连接到服务器外网IP的指定端口
            Int32 port = 4445;
            String server = "118.89.50.112";
            TcpClient client = new TcpClient(server, port);

            // 转换消息为Byte[]
            Byte[] bytes = System.Text.Encoding.ASCII.GetBytes(message);

            // 获取客户端的网络流,用于读取和发送信息
            NetworkStream stream = client.GetStream();

            // 发送消息 
            stream.Write(bytes, 0, bytes.Length);

            Debug.Log("发送:" + message);

            // 等待服务器回复消息

            // 用于存储服务器消息的缓冲区
            bytes = new Byte[256];

            // 读取服务器发来的第一条消息,堵塞
            if(stream.Read(bytes, 0, bytes.Length)>0)
            {
                Task(stream, bytes);
            }

            // 关闭全部
            stream.Close();
            client.Close();
            Debug.Log("已断开连接");
        }
        catch (ArgumentNullException e)
        {
            Debug.Log("ArgumentNullException:" + e);
        }
        catch (SocketException e)
        {
            Debug.Log("SocketException:" + e);
        }
    }

    // 初始化Cube位置和主相机位置
    void Movetoposition(float[] position)
    {
        Debug.Log("初始化Cube位置"+position[0]+","+position[1]+","+position[2]);
        cubePosition.Set(position[0], position[1],position[2]);
        transform.position = cubePosition;

        //主相机位置设置

    }

    // 处理从服务端接收的消息
    void Task(NetworkStream stream, byte[] recbytes)
    {
        String data = null;

        data = System.Text.Encoding.ASCII.GetString(recbytes, 0, recbytes.Length);
        Debug.Log("收到:" + data);

        // 转化数据为 ASCII string
        // 取data的前7个字母
        // 约定:客户端发送的消息格式为:move to XXX,XX,XXXX
        data = System.Text.Encoding.ASCII.GetString(recbytes, 0, 7);

        if (data == "move to")
        {
            Debug.Log("这是个移动消息");
            //遍历消息查找关键字",",执行的次数与bytes数组长度有关
            String word = null;
            Int32 lastpoint = 8;//已经读取了的部分的长度
            float[] position = new float[3];
            Int32 index = 1; //读到的坐标的顺序

            //i+1 代表当前读取到的位置
            for (int i = 8; i < recbytes.Length - 8; i++)
            {
                //从第9个字母开始遍历
                word = System.Text.Encoding.ASCII.GetString(recbytes, i, 1);
                if (word == ",")
                {
                    word = System.Text.Encoding.ASCII.GetString(recbytes, lastpoint, i - lastpoint);
                    position[index - 1] = float.Parse(word);
                    index = index + 1;
                    lastpoint = i + 1;
                }
            }
            word = System.Text.Encoding.ASCII.GetString(recbytes, lastpoint, recbytes.Length - lastpoint);
            position[index - 1] = float.Parse(word);

            if (position.Length == 3)
            {
                boxPosition = position;
                Debug.Log("消息解析为移动至" + boxPosition[0] + "," + boxPosition[1] + "," + boxPosition[2]);

                // 加入Unity组件移动函数
                Movetoposition(boxPosition);
            }
            else
            {
                Debug.Log("无法识别的boxposition");
            }
        }
        else if (data == "boxposi")
        {
            Debug.Log("客户端已确认新位置");
        }
        else
        {
            Debug.Log("未知消息");
        }
    }
}
```

# 服务端运行结果

![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/unity/dotnet/014.png)

# Unity运行结果

![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/unity/dotnet/015.png)

# 总结

初次做这个demo的时候会出很多的错,不断修BUG改正. 总体原则是将通信信息转化为byte\[\]后进行数据交换,而坐标信息是通过浮点数存储的,所以存储坐标时又得转换一下. 本篇中依然是使用单线程,所以在性能上非常堪忧,只能说勉强完成了标题上的要求.

# 改善目标

使用非阻塞的函数,多线程处理;网络组件对象/实例化;支持多个客户端同时/同屏登陆. 还有就是接入数据库存储信息.

# 扩展思维

demo我运行后的感想是,网络不能影响移动,在前端上移动跟网络没有太大直接关联的,可以改善. 就方块demo而言,如果想开发一个独立游戏,可以做碰撞小游戏,2个方块同时相撞时,"力道"更大的那一方将另一方面撞飞. 如果两个方块同时掉下悬崖了还可以想办法把对方先拖下水.有个推特上的demo可以参考一下. \[video width="480" height="270" mp4="https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/unity/dotnet/016.mp4"\]\[/video\]