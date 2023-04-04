---
title: 从0开始的Unity3D游戏开发 v0.1.14 IOS+ET
categories:
- [Unity, ET]
date: 2018-08-24 01:03:51
---

\[toc\]本篇内容为将ET框架从PC平台移植到IOS平台. 操作环境: ET4.0(2018年9月25日) macOS Mojave 10.14 Xcode10.0 Unity2018.2.10f1(以后升级到2018.4 LTS最新版) 注：Unity2018.3也能用ET4.0，可能会有点麻烦。

# Tips:

## 虚拟机的使用技巧

调整屏幕大小:查看-自动调整大小-自适应客户机 和PC共享文件:添加共享文件夹,在macOS-访达-偏好中开启"已连接的服务器"

## PC下开发macOS虚拟机编译?

windows上的Unity工程可以迁移到Mac上打开。

## 黑苹果

我另外写了一篇如何[安装黑苹果](https://acgmart.com/article/15/ "安装黑苹果")的文章，主要是参考远景论坛上的帖子。 如果主要设备如CPU/集成显卡/内存都能识别出来的话，性能上比虚拟机要强的多，足够开发了。

# 设置资源下载服务器

这里参考[热更新/打包](https://acgmart.com/unity/unity13/ "热更新/打包")。 设置资源下载服务器地址，以后Edit/PC/iOS模式都将从资源服务器下载assetbundle。

# 设置客户端

移植到iOS以后客户端是苹果手机，服务端在阿里云/腾讯云上的Centos7上，脱离了本地测试环境。 这里通过修改GlobalProto.txt文件中的Address来实现。 "AssetBundleServerUrl":"https://acgmart.oss-cn-hangzhou.aliyuncs.com/gameSource/" "Address":"118.89.50.112:10002" 平台：iOS 脚本预定义：NET45;ILRuntime 代码处理部分： 去除BundleHelper.cs中DownloadBundle方法的执行条件； 注释ResourcesComponent.cs中LoadOneBundle方法的if (!Define.IsAsync)条件执行代码； 处理好资源下载服务器中的资源目录；

## 客户端第一次通信

修改Address后，连接服务端会报错。 位置在UILoginComponent.cs的Onlogin方法，也就是客户端按登陆按钮的那一刻。 这个时候，检查一下服务端是否在监听10002端口。 如果服务端所在的机器没有图形化界面的话，运行ET服务端会被阻塞。 我们要想同时运行多个程序/安装图形界面，可以参考我的文章：[单线程通信示例](https://acgmart.com/unity/unity2/ "单线程通信示例")。 文末有些调试技巧。 这里，我会使用vnc工具远程登陆图形界面化的Centos7，使用Linux的netstat命令查看端口活跃情况： 运行服务端程序 ：`dotnet App.dll --appId=1 --appType=AllServer --config=../AllServer.txt` netstat -ntl 127.0.0.1：10002 被监听中 注：windows下也可以测试，但是使用netstat -at命令。 修改配置文件中的IP（不同版本ET的默认配置文件可能不同）： 127.0.0.1 → 0.0.0.0 再次运行服务端程序和netstat命令 可以看到10002和20000端口已经被监听： ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/postunity14_1.png)

## OuterConfig

OuterConfig有2个地址 第一个地址是给服务端看的，告诉服务端监听哪个端口。 第二个地址是给客户端看得，当客户端第一次连接服务端时，返回这个地址并在客户端上建立Session。 所以第一个地址填写0.0.0.0：10002即可，服务端会监听全IP段。 第二个地址填写服务端的独立IP+端口号即可。 AllServer配置目前只需要设置好OuterConfig就可以实现外网部署了。

## 打包设置

在windows上进行开发时，安装iOS支持组件即可。 如果使用iOS的默认配置，在处理网络小包时可能会报错，根据ET的设置如下： 开启：Dynamic Batching 关闭：GPU Skinning 关闭：Strip Engine Code 关闭：Optimize Mesh Data 预定义脚本：NET45;ILRuntime 如果注册了苹果开发者可以在开发者网页获取Team ID 没有注册苹果开发者可以在Xcode中选择个人团队帐号 真机打包调试：Device SDK

## 触屏操作

默认工程如果设置没有太大问题的话，丢进Mac用相同版本Unity打开就可以正常建立Xcode工程了。 打开游戏后登陆-屏幕出现骷髅-点击屏幕 有概率可以移动，并不能自由操控。 到此也算是在iOS平台有了一个开始，有什么问题以后再一一解决。