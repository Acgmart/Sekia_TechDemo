---
title: 服务端启蒙2 单线程通信示例
categories:
- [Unity, ET]
date: 2018-08-24 01:02:13
---

\[toc\]本篇将编写一个简单的服务端和客户端，当客户端连接服务端时，服务端简单的回复消息给客户端。 解决了TCP连接的socket报错,并记录了网络相关的测试技巧.

# 安装Linux桌面

```
yum groupinstall "X Window System" -y;yum groupinstall "GNOME Desktop" -y;systemctl set-default graphical.target;reboot;
```

安装图形界面，除了便于找文件，还有个原因是便于开新的进程。 在网络通信时，单线程被阻塞是很常见的事情，被阻塞了就什么也干不了难以调试。 阿里云的默认网页后台登陆系统支持图形化界面，腾讯云、Xshell只支持命令行，我们可以选一款vnc软件解决这个问题。 如果要卸载图形界面的话: yum groupremove "GNOME Desktop";yum groupremove "X Window System"

# 安装vnc

```
yum install tigervnc-server -y;cp /lib/systemd/system/vncserver@.service /lib/systemd/system/vncserver@:1.service;sed -i "s/<USER>/root/g" /lib/systemd/system/vncserver@:1.service;
```

vncpasswd root; 设置vnc密码 问要不要设置view-only（只看模式）密码时，输入n。 vncserver; 第一次启动vncserver时要设置密码 问要不要设置view-only（只看模式）密码时，输入n。 会自动创建启动脚本/root/.vnc/xstartup，为该脚本设置权限就可以愉快的自动启动了。

```
systemctl daemon-reload;systemctl enable vncserver@:1.service;chmod 777 /root/.vnc/xstartup;reboot;
```

刚才我们重启了服务器，稍等后使用[tigervnc的PC客户端](http://tigervnc.bphinz.com/nightly/ "tigervnc的PC客户端")连接118.89.50.112:1 设置好后可实现开机自动启动图形界面效果。 注意：使用tigervnc连接服务器，输入密码时注意切换输入法状态,建议设置为默认英文。

# 安装VS Code(非必须)

```
rpm --import https://packages.microsoft.com/keys/microsoft.asc;sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo';yum check-update;yum install code -y;
```

VS Code将是在Linux中进行.NET Core C#编程的主要工具。 这篇教程来自于[官方VS Code安装引导](https://code.visualstudio.com/docs/setup/linux "官方VS Code安装引导")，就如官方所说，yum repo的更新可能有延迟，所以不能保障你安装的是最新版本的，暂时先不介意这些。 安装成功后的运行方式如图，已经自动添加到应用快捷方式了： ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/unity/dotnet/009.png) 注:为了能流畅跑这个,应该配一台好电脑,或者虚拟机上玩.

# 安装.NET Core

## 如果是用来开发

安装.NET Core SDK，并创建一个控制台应用名为app，在项目文件夹app下有一个C#文件Program.cs。

```
rpm -Uvh https://packages.microsoft.com/config/rhel/7/packages-microsoft-prod.rpm;yum install dotnet-sdk-2.1 -y;dotnet new console -o app;
```

使用VS Code打开工程目录app，选中C#文件后系统会提示是否安装VS Code的C#扩展，选择是。 界面大概是这样的： ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/unity/dotnet/010.png)

## 如果只用来运行程序

`sudo rpm -Uvh https://packages.microsoft.com/config/rhel/7/packages-microsoft-prod.rpm` `sudo yum install aspnetcore-runtime-2.1`

## 安装FTP

安装FTP，添加FTP帐号Sekia，设置Sekia的用户组为root、默认目录为/root/Sekia/；/root/Sekia/文件夹将用于传输文件和测试。

```
yum install vsftpd -y;systemctl start vsftpd.service;systemctl enable vsftpd.service;sed -i '12c anonymous_enable=NO' /etc/vsftpd/vsftpd.conf;useradd Sekia -s /sbin/nologin;mkdir /root/Sekia;chmod -R 777 /root/Sekia;usermod -d /root/Sekia -g root Sekia;
```

## 设置FTP密码

passwd Sekia;

## 修改SSH端口号

由于默认的端口22非常容易被攻击，建议修改为自定义端口号。输入命令： vim /etc/ssh/sshd\_config 将 **#Port 22** 更改为 **Port 4000** ，并保存。 在SSH工具中也进行对应端口修改即可。

## 修改FTP端口号

同样的，这里也修改FTP端口号，默认为21，建议修改为自定义端口号。输入命令： vim /etc/vsftpd/vsftpd.conf 在文件末尾增加**listen\_port=4001** vim /etc/services 将 **ftp 21/tcp** 更改为 **ftp 4001/tcp** 将 **ftp 21/udp** 更改为 **ftp 4001/udp** 将 **ssh 22/tcp** 更改为 **ssh 4000/tcp** 将 **ssh 22/udp** 更改为 **ssh 4000/udp** 保存后reboot重启服务器，并更新阿里云/腾讯云安全组设置。 注：更改端口并不是必须的，但是如果你每次后台登陆看到提示：有4000次登陆失败记录。那么强烈建议改端口。 说不定被入侵了然后挂上广告、木马之类的东西，成为肉鸡。 经过这么一番折腾以后，确认远程登陆、FTP都没问题建议把服务器做个**备份**。

# 简单的单线程通信示例

本篇将学习TCP通信，使用System.Net.Sockets命名空间中的TcpListener类完成端口监听操作。 相关函数解释将统一在[另一篇日志](https://acgmart.com/unity/dotnet/ "另一篇日志")中归纳 下面的2段代码来自于微软官方.NET Core API介绍,没有过于删改,在以后的章节中会有中文注释.

## 服务端代码

```csharp
using System;
using System.IO;
using System.Net;
using System.Net.Sockets;
using System.Text;

class Program
{
  public static void Main()
  { 
    TcpListener server=null;   
    try
    {
      // Set the TcpListener on port 13000.
      Int32 port = 4445;
      IPAddress localAddr = IPAddress.Parse("127.0.0.1");

      // TcpListener server = new TcpListener(port);
      server = new TcpListener(localAddr, port);

      // Start listening for client requests.
      server.Start();

      // Buffer for reading data
      Byte[] bytes = new Byte[256];
      String data = null;

      // Enter the listening loop.
      while(true) 
      {
        Console.Write("Waiting for a connection... ");

        // Perform a blocking call to accept requests.
        // You could also user server.AcceptSocket() here.
        TcpClient client = server.AcceptTcpClient();            
        Console.WriteLine("Connected!");

        data = null;

        // Get a stream object for reading and writing
        NetworkStream stream = client.GetStream();

        int i;

        // Loop to receive all the data sent by the client.
        while((i = stream.Read(bytes, 0, bytes.Length))!=0) 
        {   
          // Translate data bytes to a ASCII string.
          data = System.Text.Encoding.ASCII.GetString(bytes, 0, i);
          Console.WriteLine("Received: {0}", data);

          // Process the data sent by the client.
          data = data.ToUpper();

          byte[] msg = System.Text.Encoding.ASCII.GetBytes(data);

          // Send back a response.
          stream.Write(msg, 0, msg.Length);
          Console.WriteLine("Sent: {0}", data);            
        }

        // Shutdown and end connection
        client.Close();
      }
    }
    catch(SocketException e)
    {
      Console.WriteLine("SocketException: {0}", e);
    }
    finally
    {
       // Stop listening for new clients.
       server.Stop();
    }


    Console.WriteLine("\nHit enter to continue...");
    Console.Read();
  }   
}
```

## 客户端代码

```csharp
using System;
using System.Net;
using System.Net.Sockets;

namespace client
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello World!");
            Connect("118.89.50.112","Hello Unity");
        }

        static void Connect(String server, String message)
        {
            try
            {
                // Create a TcpClient.
                // Note, for this client to work you need to have a TcpServer 
                // connected to the same address as specified by the server, port
                // combination.
                Int32 port = 4445;
                TcpClient client = new TcpClient(server, port);

                // Translate the passed message into ASCII and store it as a Byte array.
                Byte[] data = System.Text.Encoding.ASCII.GetBytes(message);

                // Get a client stream for reading and writing.
                //  Stream stream = client.GetStream();

                NetworkStream stream = client.GetStream();

                // Send the message to the connected TcpServer. 
                stream.Write(data, 0, data.Length);

                Console.WriteLine("Sent: {0}", message);

                // Receive the TcpServer.response.

                // Buffer to store the response bytes.
                data = new Byte[256];

                // String to store the response ASCII representation.
                String responseData = String.Empty;

                // Read the first batch of the TcpServer response bytes.
                Int32 bytes = stream.Read(data, 0, data.Length);
                responseData = System.Text.Encoding.ASCII.GetString(data, 0, bytes);
                Console.WriteLine("Received: {0}", responseData);

                // Close everything.
                stream.Close();
                client.Close();
            }
            catch (ArgumentNullException e)
            {
                Console.WriteLine("ArgumentNullException: {0}", e);
            }
            catch (SocketException e)
            {
                Console.WriteLine("SocketException: {0}", e);
            }

            Console.WriteLine("\n Press Enter to continue...");
            Console.Read();
        }
    }
}
```

**测试结果**为： 在windows上同时运行客户端和服务端时，可以正常收发消息。 在Linux上运行服务端时，服务端收不到客户端发出的消息。

# 问题排查

## 1.防火墙

Centos7默认安装了防火墙Firewall，但是没有启动，可以通过`systemctl status firewalld`查看防火墙状态。

## 2.安全组规则

测试模式下安全组已设置为0.0.0.0/0 ALL全网开放状态.

## 3.TCP端口测试

根据阿里云的[telnet教程](https://help.aliyun.com/knowledge_detail/41340.html?spm=a2c4g.11186631.2.5.2d1e5807HKrplh "telnet教程")，我们可以用telnet检测Linux系统的现有监听端口的连通性。

### Windows下使用telnet

telnet可以用来测试**TCP连接** 在程序与功能中，开启telnet客户端。在cmd中输入命令进行测试： telnet 118.89.50.112 22 22号端口可以连接(前面我修改了ssh端口为4000,这里应该测试端口4000) telnet 118.89.50.112 14444 连接失败

## 服务端没有正确绑定端口

在Linux端使用netstat命令查询网络状态. 显示Local Address:127.0.0.1:14444 被监听中. 通过百度得知127.0.0.1是一个**特殊IP**,代表本机,仅用于本机测试. 而0.0.0.0代表全域名段,就像设置云服务器安全组中0.0.0.0/0代表全网任何端口一样 将服务端的代码中socket监听的IP设置为0.0.0.0后可以正常实现通信.

## 再次使用Windows的telnet工具

telnet 118.89.50.112 14444 成功且自动跳转到交互界面,如图: ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/unity/dotnet/011.png) 当在命令行输入单个字母时,服务器返回大写字母. 当粘贴一段字符串时,会删除首字母并返回剩余内容的大写. 也就是说:如果没有做特殊交互的话,telnet工具用来测试tcp连接的连通性是极好的.

## Linux的netstat命令

虽然在学习的过程中遇到了不少坑从而走了弯路,但是也让我意识到了新的问题. 比如如何观察网络状况,有哪些IP是有特殊意义的,哪些端口是已经被占用的或有特殊意义的. 先从netstat工具查询Linux网络状况常用命令: 所有活跃连接:netstat -a 所有活跃TCP连接:netstat -at 监听中的TCP连接:netstat -tnl //-n为禁用域名解析,建议常用 监听中的TCP连接的进程:netstat -nlpt //必须root权限下,额外显示**进程号**和**进程名** 监听中的TCP连接的拥有者:netstat -lpte //**User** TCP流量统计:netstat -st 内核路由信息:netstat -rn 网络接口:netstat -ie //ipconfig 持续输出TCP信息:netstat -cnt //可以看到TCP的Foreign Address实时在变 查看某端口信息:netstat -anpgrep 端口号 //查看指定端口信息 监视某端口:watch -d -n0 "netstat -anp grep 端口号" //会0.1s刷新一次 监视所有活跃TCP端口:watch -d -n0 "netstat -atnp grep ESTA" //ESTABLISHED为已建立的连接 查看http服务是否在运行:netstat -aplegrep http //同理,smtp或ntp 注:如果要查看UDP端口,使用-u选项,替换-t选项.

## 特殊IP

0.0.0.0:简单理解为外网 127.0.0.1:简单理解为本机 局域网地址: 10.0.0.0 172.16.0.0 192.168.0.0

## 特殊端口

Telnet端口：23 (远程登录) HTTP端口：80 (超文本传输协议) FTP 端口：21 (文件传输协议) DNS 端口：53 (域名服务系统) POP3端口：110(邮筒协议) SMTP端口：25 (简单邮件传输协议)