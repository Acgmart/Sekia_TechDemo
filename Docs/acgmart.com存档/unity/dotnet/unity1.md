---
title: 服务端启蒙1 让程序在Centos上运行
categories:
- [Unity, .NET]
date: 2018-08-24 01:02:05
---

本篇主要目的为配置初期的开发环境。 \[toc\]由于服务端目标运行平台为Centos，而C#是微软的.net平台的语言所以会面临一些新的问题： 1：让C#控制台应用程序能够在Centos上运行 2：在Windows上编写程序，远程调试并在Centos上运行。或者Linux上编程并调试。 3：.net是一个微软推出的平台，是C#程序的运行环境。对于一个刚来到这个环境的新人来说，只能抱微软大腿了。 .net的官网是[https://www.microsoft.com/net](https://www.microsoft.com/net "https://www.microsoft.com/net")，[.NET Core 2.1 API](https://docs.microsoft.com/en-us/dotnet/api/index?view=netcore-2.1 ".NET Core API")以后有什么不懂的多往这里跑吧！

# 前期准备

腾讯云服务器：1核2G；1Mbps；公网地址：118.89.50.112 SSH工具：Xshell 6 FTP工具：FileZilla 系统版本：CentOS Linux release 7.4.1708 (Core) cat /etc/redhat-release ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/unity/dotnet/001.png)

# 安装.NET SDK

在.net的官网上可以很友好的找到[新手引导](https://www.microsoft.com/net/learn/get-started-with-dotnet-tutorial "新手引导")，目前支持Windows/Linux/macOS，这里选择Linux。然后要选择发行版本，这里我选择CentOS/Oracle。 安装步骤建议就顺着官方的来，Centos命令代码如下。

```
rpm -Uvh https://packages.microsoft.com/config/rhel/7/packages-microsoft-prod.rpm;yum install dotnet-sdk-2.1 -y;
dotnet new console -o myApp;cd myApp;
dotnet run;
```

解释：这里安装的是.net的最新版本SDK2.1，如果哪天更新了.net core 3.0，建议更新。 dotnet new console -o myApp：使用dotnet命令，new（新建）一个控制台应用程序（console），创建（-o）一个叫myApp的文件夹，myApp文件夹内包括Program.cs和bin文件夹。 输入命令：dotnet --version;可以查看.net core的版本。 使用命令cat Program.cs可以查看代码：

```csharp
using System;

namespace myApp
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello World!");
        }
    }
}
```

dotnet run;运行程序。 效果如下图，可以正常打印输出，就和Windows上新建C#控制台应用差不多: ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/unity/dotnet/002.png)

## Linux下新建项目的文件结构

![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/unity/dotnet/003.png) ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/unity/dotnet/004.png) 与Windows下新建.NET Core控制台应用项目的结构一致

# Windows上也安装.NET Core

运行Visual Studio Install，如果安装过Unity那么默认安装的是Visual Studio Community 2017。 修改VS安装项，点击**修改**，并勾选指定的**工作负载**，并确认**修改**。 ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/unity/dotnet/005.png)

# 同步Windows文件夹到Linux

想要程序运行在Linux首先要把项目文件转移到Linux中，这里使用老土但稳定的FTP工具。

## 安装FTP

安装FTP，添加FTP帐号Sekia，设置Sekia的用户组为root、默认目录为/root/App/；/root/App/文件夹将用于传输文件和测试。

```
yum install vsftpd -y;systemctl start vsftpd.service;systemctl enable vsftpd.service;sed -i '12c anonymous_enable=NO' /etc/vsftpd/vsftpd.conf;useradd Sekia -s /sbin/nologin;mkdir /root/App;chmod -R 777 /root/App;usermod -d /root/App -g root Sekia;
```

### 设置FTP密码

passwd Sekia; 注：如果不能访问FTP，可能要重启服务or服务器。

## 在Windows下创建项目test

![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/unity/dotnet/006.png)

## 设置FTP工具

站点管理器-新建站点： 协议：FTP-文件传输协议 主机：（外网IP）；端口：（默认为21） 加密：只使用普通FTP 登陆类型：正常 用户：（你的FTP账号） 密码：（你设置的密码） 传输设置-传输模式：**主动**

## 将项目文件转移至Linux

使用FTP工具将D:\\dotnet\\test\\test上传至Linux服务器的/home/Sekia/中 ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/unity/dotnet/007.png)

## 在Linux中运行程序

![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/unity/dotnet/008.png)

### 修改SSH端口号

由于默认的端口22非常容易被攻击，建议修改为自定义端口号。输入命令： vim /etc/ssh/sshd\_config 将 **#Port 22** 更改为 **Port 4000** ，并保存。 在SSH工具中也进行对应端口修改即可。

### 修改FTP端口号

同样的，这里也修改FTP端口号，默认为21，建议修改为自定义端口号。输入命令： vim /etc/vsftpd/vsftpd.conf 在文件末尾增加**listen\_port=4001** vim /etc/services 将 **ftp 21/tcp** 更改为 **ftp 4001/tcp** 将 **ftp 21/udp** 更改为 **ftp 4001/udp** ，并保存 reboot，重启服务器。 修改FTP工具登陆信息中的端口号，测试正常。 以上！