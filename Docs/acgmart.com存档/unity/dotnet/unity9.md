---
title: 描述多线程-Thread
categories:
- [Unity, ET]
date: 2018-08-24 01:03:29
---

本篇的目的是:用非常通俗易懂的方式来描述多线程 离本系列文章[v0.1.5 多人同屏](https://acgmart.com/unity/unity5/ "v0.1.5 多人同屏")发布已有一周,我目前在考虑框架上的问题,并不打算直接做游戏. 在v0.1.5中并没有加入游戏逻辑,但是一个初级游戏框架以及形成,我们可以通过向其中添加MongoDB/Protobuf等第三方工具让程序可以更便捷的处理消息的解析/转化,以及数据的存储/读取/解析. 甚至我们可以研究如何使用Protobuf的方式将byte\[\]转化为BSON,这样byte\[\]可以直接用于存储,今后将就这方面进行深入了解. 本篇也将继续为了对接ET游戏框架而学习多线程方面的知识. 要想通俗易懂描述多线程...编程本身就已经很复杂了,所以这里描述的是线程之间的关联,以及我为什么要这么做. 就好像你在看一个有200个.cs文件的大工程,但是如果只是描述线程关系的话,就可以将线程之间的关系从程序里面剥离出来. 于是就变成了,主线程a,在运行某处产生的子线程b/c/d/e/f,这些子线程最终都活的怎么样了,如果a想让b执行一段代码应如何处理,如果有一个任务我想关闭但是不知道在哪个线程,线程可以和游戏逻辑无关,但是游戏逻辑是需求,为了满足需求这里需要有一个线程在执行点什么.

# 什么是线程

在百科上我们可以了解到:线程(thread)是程序执行流(进程:process)的最小单元,每个线程都有一个ID,我们先来捕获一下进程ID和线程ID.

```Csharp
using System;
using System.Threading;
using System.Diagnostics;

namespace thread
{
    class Program
    {
        static void Main(string[] args)
        {
            //Threading命名空间:提供多线程编程接口
            //Thread类:创建和控制线程,设置其优先级,并获取其状态.
            int threadID = Thread.CurrentThread.ManagedThreadId;
            Console.WriteLine("当前线程ID:"+threadID);

            //System.Diagnostics命名空间:提供可用于与系统进程、 事件日志和性能计数器进行交互的类。
            //Process类:提供对本地和远程进程的访问，使您能够启动和停止本地系统进程。
            Process p = Process.GetCurrentProcess();
            Console.WriteLine("进程ID:" + p.Id);
            Console.WriteLine("启动时间:" + p.StartTime.ToLongDateString() + " " 
                + p.StartTime.ToLongTimeString());
            Console.WriteLine("进程名:" + p.ProcessName);
            Console.WriteLine("是否响应：" + p.Responding);
            Console.WriteLine("关联进程句柄：" + p.Handle);
            Console.WriteLine("进程打开的句柄数：" + p.HandleCount);
            Console.WriteLine("主窗口句柄：" + p.MainWindowHandle);
            Console.WriteLine("主窗口标题：" + p.MainWindowTitle);
            Console.WriteLine("模块数量：" + p.Modules.Count);
            Console.WriteLine("基本优先级：" + p.BasePriority);
            Console.WriteLine("提升优先级：" + p.PriorityBoostEnabled);
            Console.WriteLine("处理器：" + p.ProcessorAffinity.ToInt32());
            Console.WriteLine("最小工作集：" + p.MinWorkingSet.ToInt32());
            Console.WriteLine("最大工作集：" + p.MaxWorkingSet.ToInt32());
            Console.WriteLine("工作集：" + p.WorkingSet64);
            Console.WriteLine("峰值工作集：" + p.PeakWorkingSet64);
            Console.WriteLine("专用内存大小：" + p.PrivateMemorySize64);
            Console.WriteLine("未分页内存大小：" + p.NonpagedSystemMemorySize64);
            Console.WriteLine("分页内存大小：" + p.PagedMemorySize64);
            Console.WriteLine("峰值分页内存大小：" + p.PeakPagedMemorySize64);
            Console.WriteLine("虚拟内存大小：" + p.VirtualMemorySize64);
            Console.WriteLine("峰值虚拟内存大小：" + p.PeakVirtualMemorySize64);
            Console.WriteLine("占用时间：" + p.TotalProcessorTime);
            Console.WriteLine("特权占用时间：" + p.PrivilegedProcessorTime);
            Console.WriteLine("用户占用时间：" + p.UserProcessorTime);
            //Process.GetProcessesByName/Id 通过进程名或Id寻找进程

            Console.ReadLine();
        }
    }
}
```

代码我更新了下,加入了很多Thread的字段,旧代码运行结果: ![](https://cdn.jsdelivr.net/gh/moezx/cdn@3.0.2/img/svg/loader/trans.ajax-spinner-preloader.svg)

![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/postunity9_1.png)

所以我们的程序名是dotnet.exe,我目前还不知道该如何修改程序名/程序描述/图标,说不定等出了.NET Core 3.0,可以在windows上创建桌面程序时就可以用图标设置了.这个问题等2019年再解决吧.

# 创建一个新的线程

现在我们创建1个新的线程,每个线程的任务都是每隔10秒在屏幕上打印自己的线程ID.

```Csharp
            Thread t1 = new Thread(new ThreadStart(T1));
            t1.Start();  //一定要开始线程
            t1.IsBackground = true;
            t1.Name = "sekia";

            while (true)
            {
                int tid = Thread.CurrentThread.ManagedThreadId;
                Console.WriteLine("主线程 ID:" + tid);
                Thread.Sleep(10000);
            }
```

每个线程都需要一个启动方法,这里我们提供一个Thread1方法:

```Csharp
        static void T1()
        {
            while(true)
            {
                int tid = Thread.CurrentThread.ManagedThreadId;
                Console.WriteLine("支线程 ID:" + tid);
                Thread.Sleep(10000);
            }
        }
```

# 获得全部线程ID?

在.NET框架中,进程下的线程还分为托管状态和非托管状态. 以运行库为目标的代码称为托管代码,而不以运行库为目标的代码称为非托管代码. 在操作系统中,线程ID和托管线程(managed thread)并没有直接关系. 使用Thread.ManagedThreadId可以获得managed thread的唯一标识符. 当创建一个新的线程时,将该线程加入到一个容器中便于管理. 也可以给线程取名Thread.Name = string;

# 线程的状态

参考System.Threading.ThreadState,这是一个enum: Running = 0 //线程在前台运行.被另一个线程调用Thread.start或者Thread.Resume StopRequested = 1 //线程被要求停止 SuspendRequested = 2 //线程被要求暂停,被另一个线程调用Thread.Suspend Background = 4 //线程在后台运行 Unstarted = 8 //线程未启动,条用Thread类构造函数. Stopped = 16 //线程已停止 WaitSleepJoin = 32 //线程被锁,因为调用了Thread.Sleep或者被另一个线程调用Thread.Join Suspended = 64 //线程暂停状态,响应Thread.Suspend AbortRequested = 128 //线程被要求终止,暂未执行.被另一个线程调用Thread.Abort Aborted = 256 //线程已经死亡,暂未进入Stopped状态 通过线程的状态Threading.ThreadState测试一下:创建的新线程在执行完后是否会自动释放.

```Csharp
using System;
using System.Threading;

namespace thread
{
    class Program
    {
        static void Main(string[] args)
        {
            Thread t1 = new Thread(new ThreadStart(T1));
            Console.WriteLine("t1状态:" + t1.ThreadState);
            t1.IsBackground = true;
            Console.WriteLine("t1状态:" + t1.ThreadState);
            t1.IsBackground = false;
            Console.WriteLine("t1状态:" + t1.ThreadState);
            t1.Start();  //一定要开始线程
            Console.WriteLine("t1状态:" + t1.ThreadState);

            t1.Name = "sekia";
            Thread.Sleep(1000);
            Console.WriteLine("t1状态:" + t1.ThreadState);

            Console.ReadLine();
        }

        static void T1()
        {
            int tid = Thread.CurrentThread.ManagedThreadId;
            Console.WriteLine("支线程 ID:" + tid);
            Console.WriteLine("支线程 名:" + Thread.CurrentThread.Name);
        }
    }
}
```

输出: t1状态:Unstarted t1状态:Background, Unstarted t1状态:Unstarted t1状态:Running 支线程 ID:3 支线程 名:sekia t1状态:Stopped 结论:线程执行完会自动销毁,无需担心浪费资源.

# 线程间通信-字符串容器

在 [v0.1.5 多人同屏](https://acgmart.com/unity/unity5/ "v0.1.5 多人同屏") 中,客户端通过异步循环读取消息并把消息添加到一个List messageList容器中,实现了消息在线程中的传递.由支线程负责收消息,将收到的byte\[\]简单加工为string传递给主线程,主线程通过解析string来知道自己应该做什么. 但是这种沟通方式没法传递更多消息,支线程所做的无非就是"转发"而已,所有的解析处理都会积压到主线程,当事件发生在子功能模块中,如"有4个玩家创建了一个房间"稍微复杂点的消息就不是简单转发可以完成的了.

# 线程间通信-动作容器

通过SynchronizationContext类,可以实现封装一段来自一个线程的代码到另一个线程执行. 这段被封装的代码我们可以称之为"动作". SynchronizationContext可以翻译为:同步上下文.

```Csharp
using System;
using System.Threading;
using System.Collections.Concurrent;

namespace thread1
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello World!");

            int threadID = Thread.CurrentThread.ManagedThreadId;
            Console.WriteLine("Program.cs.13 当前线程ID:" + threadID);

            SynchronizationContext.SetSynchronizationContext(OneThread.Instance);

            try
            {
                //----这里加入游戏逻辑-----//

                Thread t1 = new Thread(new ThreadStart(T1));
                t1.Start();  //一定要开始线程

                while (true)
                {
                    try
                    {
                        Thread.Sleep(1);
                        OneThread.Instance.Update();
                    }
                    catch (Exception e)
                    {
                        Console.WriteLine("异常:" + e);
                    }
                }
            }
            catch (Exception e)
            {
                Console.WriteLine("异常:" + e);
            }
        }

        static void T1()
        {
            while (true)
            {

                int tid = Thread.CurrentThread.ManagedThreadId;
                string message = "消息来自支线程 ID:" + tid.ToString();
                //改由主线程执行
                //Console.WriteLine("支线程 ID:" + tid);
                SendOrPostCallback action = (x) => 
                {
                    int cid = Thread.CurrentThread.ManagedThreadId;
                    Console.Write(DateTime.Now.ToString());
                    Console.WriteLine(" " + x + " 由线程ID:" + cid + "执行");
                };

                OneThread.Instance.Post(action, message);
                Thread.Sleep(10000);
            }
        }
    }

    class OneThread : SynchronizationContext
    {
        //唯一实例
        public static OneThread Instance { get; } = new OneThread();

        // 线程同步队列,发送接收socket回调都放到该队列,由poll线程统一执行
        //高性能异步队列
        //队列初始化
        private readonly ConcurrentQueue queue = new ConcurrentQueue();

        private Action a;

        //出队执行
        public void Update()
        {
            while (true)
            {
                //一个队列头部的object出队执行
                //   result:当方法返回,操作成功(true)时,将object保存于result中
                // 返回结果:成功移除一个元素返回true,其他false
                //public bool TryDequeue(out T result);
                if (!queue.TryDequeue(out a))
                {
                    return;
                }
                a();
            }
        }

        //入队操作
        //在派生类中重写时,将异步消息调度到synchronization
        //   callback:要调用的委托,指函数callback()
        //   state:传递给委托函数的参数
        public override void Post(SendOrPostCallback callback, object state)
        {
            //回调函数:将函数作为变量进行传递
            //Lambda语句
            //=>运算符:
            //（参数）=>{操作}
            //指定左边的为参数,并返回右边的计算结果
            //下面的() => { callback(state); }部分是函数的声明部分
            //相当于声明了一个无参函数:
            // void action()
            // {
            //     callback(state);
            // }

            int threadID = Thread.CurrentThread.ManagedThreadId;
            Console.WriteLine("OneThread.消息入队 当前线程ID:" + threadID);

            queue.Enqueue(() => { callback(state); });
        }
    }
}
```

运行结果: Hello World! Program.cs.13 当前线程ID:1 OneThread.消息入队 当前线程ID:3 2018/9/9 13:52:50 消息来自支线程 ID:3 由线程ID:1执行 OneThread.消息入队 当前线程ID:3 2018/9/9 13:53:00 消息来自支线程 ID:3 由线程ID:1执行 从结果中可以看出,支线程通过SynchronizationContext成功的将一个action传递给了主线程.

# 定时器

我们再来看看中介绍的定时器功能,可以帮助我们以固定时间执行一段代码.

```Csharp
using System;
using System.Threading;
using System.Timers;

namespace timer
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello World!");
            int threadID = Thread.CurrentThread.ManagedThreadId;
            Console.WriteLine("Program.cs.13 当前线程ID:" + threadID);

            System.Timers.Timer timer = new System.Timers.Timer();
            timer.AutoReset = true;
            timer.Interval = 1000;
            timer.Elapsed += new ElapsedEventHandler(Tick);
            timer.Start();

            Console.Read();
        }

        static void Tick(object sender,ElapsedEventArgs e)
        {
            int threadID = Thread.CurrentThread.ManagedThreadId;
            Console.WriteLine("Program.cs.28 当前线程ID:" + threadID);
            Console.WriteLine("每秒执行一次");
        }
    }
}
```

输出结果: Hello World! Program.cs.13 当前线程ID:1 Program.cs.28 当前线程ID:4 每秒执行一次 Program.cs.28 当前线程ID:5 每秒执行一次 Program.cs.28 当前线程ID:4 每秒执行一次 Program.cs.28 当前线程ID:4 每秒执行一次 生成的定时器会用3个左右线程来执行任务. 可以用类似的方法去了解异步函数

# async await

async/await在[v0.1.6 MongoDB](https://acgmart.com/unity/unity6/ "v0.1.6 MongoDB")中提到了很多次,MongoDB中普遍支持异步操作. 那么究竟是怎么在使用的呢,先抄一段网上其他人研究出来的结果. 最终调查结果如下：

1.  async方法中的代码会被移交给IAsyncStateMachine的MoveNext方法
    
2.  async方法中await操作前后的代码被分离
    
3.  主线程直接执行await前的代码，并将await的Task移交给线程池ThreadPoolGlobal
    
4.  子线程执行完主线程递交来的Task后，再次走入MoveNext方法，执行await后的代码
    

我这边也找来了一个比较简单的例子:

using System; using System.Threading; using System.Threading.Tasks;

namespace v0.\_1.\_9\_thread { class test { static void Main(string\[\] args) { Thread.Sleep(100); Console.WriteLine("Test0.10：" + "线程ID：{0}", System.Threading.Thread.CurrentThread.ManagedThreadId); Test1(); Thread.Sleep(100); Console.WriteLine("Test0.12：" + "线程ID：{0}", System.Threading.Thread.CurrentThread.ManagedThreadId); Console.ReadLine(); }

public static async void Test1() { Thread.Sleep(100); Console.WriteLine("Test1.18：" + "线程ID：{0}", System.Threading.Thread.CurrentThread.ManagedThreadId); Thread.Sleep(100); await Test2(); Thread.Sleep(100); Console.WriteLine("Test1.20：" + "线程ID：{0}", System.Threading.Thread.CurrentThread.ManagedThreadId);

}

public static async Task Test2() { Thread.Sleep(100); Console.WriteLine("Test2.26：" + "线程ID：{0}", System.Threading.Thread.CurrentThread.ManagedThreadId); Thread.Sleep(100); await Task.Run(() => { for (int i = 0; i < 10; i++) { Thread.Sleep(100); Console.WriteLine("Test2.30: " + i + "线程ID：{0}", System.Threading.Thread.CurrentThread.ManagedThreadId); } }); Thread.Sleep(100); Console.WriteLine("Test2.33：" + "线程ID：{0}", System.Threading.Thread.CurrentThread.ManagedThreadId); } } }

运行结果: Test0.10：线程ID：1 Test1.18：线程ID：1 Test2.26：线程ID：1 Test0.12：线程ID：1 Test2.30: 0线程ID：4 Test2.30: 1线程ID：4 Test2.30: 2线程ID：4 Test2.30: 3线程ID：4 Test2.30: 4线程ID：4 Test2.30: 5线程ID：4 Test2.30: 6线程ID：4 Test2.30: 7线程ID：4 Test2.30: 8线程ID：4 Test2.30: 9线程ID：4 Test2.33：线程ID：4 Test1.20：线程ID：4 为了能看清楚执行顺序用到了很多Sleep方法。 与结论中描述的一致,Test1和Test2的await前的部分是主线程执行的,await后面的部分是支线程异步执行的。**这个过程中主线程不会被支线程阻塞**。 支线程的执行也有明显顺序，“await Test2();”的下一行“Thread.Sleep(100);”需要等待“Test2()”执行完，而“Test2()”中也分为“await前”、“await中”、“await后”三个部分。 await前：主线程执行 await中：支线程优先执行 await后：支线程稍后执行

# 结语

将异步编程利用于实战还需要更多的练习.