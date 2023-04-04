---
title: 日志系统-NLog
categories:
- [Unity, 插件]
date: 2018-08-24 01:03:33
---

\[toc\]本篇将学习NLog日志组件. 本篇也同样作为ET服务器框架的前置学习内容,后面的学习计划嘛~ 直接学习ET核心框架或者组件也不错的样子,总之不急...基础要打牢.

# NLog是?

这里是[官方网站地址](https://nlog-project.org/ "官方网站地址") NLog is a flexible and free logging platform for various .NET platforms, including .NET standard. NLog makes it easy to write to several targets. (database, file, console) and change the logging configuration on-the-fly. NLog是个灵活且免费的日志平台,适用于各种.NET平台.可以轻松向多种目标写入日志,并即时更改日志配置. 特性: Easy to configure:易于配置 Templatable:模版化 Extensible:可扩展 Structured logging:结构化日志 输出目标: Files:保存为本地文件 Event Log:事件日志 Database:在事务之外执行数据库操作,支持mysql数据库. Console:命令行实时输出,彩色代码消息. E-mail:SMTP发送Log消息 对于每个人来说需要的Log功能可能不同,比如: 不同的日志级别 动态打开/关闭日志 学习成本 配置方式/难度 对于运营中的产品,邮件/电话通知应该是一个不错的预警方式.

# 安装NLog

使用NuGet安装即可,在"管理Nuget程序包"中搜索"NLog"即可. 初次学习使用NLog的时候,还可以多安装一个"NLog.Config",会帮忙自动添加一个NLog的配置文件,但是这不是必要的.

# 入门程序

刚开始的时候,我们需要一个简单的程序证明NLog是可用的. 首先配置NLog,打开NLog.config文件,如果没有,你可以选择自己创建NLog.config,方法是: 在项目文件夹手动创建NLog.config,并在项目的.csproj文件中添加一个ItemGroup:

```
  <ItemGroup>
    <None Update="NLog.config">
      <CopyToOutputDirectory>Always</CopyToOutputDirectory>
    </None>
  </ItemGroup>
```

接下来是某NLog.config的全部内容,直接复制粘贴就行,后面再具体将属性设置:

```
<?xml version="1.0" encoding="utf-8" ?>
<nlog xmlns="http://www.nlog-project.org/schemas/NLog.xsd"
      xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
      xsi:schemaLocation="http://www.nlog-project.org/schemas/NLog.xsd NLog.xsd"
      autoReload="true"
      throwExceptions="false"
      internalLogLevel="Off" internalLogFile="c:\temp\nlog-internal.log">

  <!-- optional, add some variables
  https://github.com/nlog/NLog/wiki/Configuration-file#variables
  -->
  <variable name="myvar" value="myvalue"/>

  <!--
  See https://github.com/nlog/nlog/wiki/Configuration-file
  for information on customizing logging rules and outputs.
   -->
  <targets>
    <target name="console" xsi:type ="Console" />
    <target name="debugger" xsi:type="Debugger" layout="${date:format=HH\:mm\:ss.fff}: ${message}" />
    <target name="error_file" xsi:type="File"
                    fileName="${basedir}/Logs/Error/${shortdate}/error.txt" maxArchiveFiles="30"
                    layout="${longdate}  ${level:uppercase=false}  ${message} ${onexception:${exception:format=tostring} ${newline} ${stacktrace} ${newline}" />
    <target name="info" xsi:type="File"
                fileName="${basedir}/Logs/Info/${shortdate}/info.txt" maxArchiveFiles="30"
                layout="${longdate}  ${level:uppercase=false}  ${message} ${onexception:${exception:format=tostring} ${newline} ${stacktrace} ${newline}" />
  </targets>
  <rules>
    <logger name="*" writeTo="console" />
    <logger name="*" minlevel="Debug" writeTo="debugger" />
    <logger name="*" minlevel="Error" writeTo="error_file" />
    <logger name="*" level="Info" writeTo="info" />
  </rules>
</nlog>
```

接着是Program.cs的代码:

```Csharp
using System;
using NLog;

namespace v0._1._10_Log
{
    class Program
    {
        private static readonly Logger logger = LogManager.GetCurrentClassLogger();
        static void Main(string[] args)
        {
            logger.Info("11111nlog test error");
            logger.Fatal("22222nlog test error");
            logger.Error("33333nlog test error");
            Console.ReadLine();
        }
    }
}
```

运行后,不仅仅是命令行中有log显示,输出目录中出现了文件夹Logs,里面有Error和Info文件夹,以及按日期分的.txt记录.

# 配置解释

内容比较长,有需要的话回头看也行.

```
xsi:schemaLocation  帮助验证语法规范的schema文件
  autoReload="true"  程序启动后修改配置文件是否重新加载
  throwExceptions="false"  NLog日志系统抛出异常
  internalLogLevel="Off"  NLog内部日志级别
  internalLogFile="c:\example.log"  NLog内部日志地址

  <variable /> - 定义配置文件中用到的变量
  <targets /> - 定义日志的目标/输出
  <rules /> - 定义日志的路由规则

Layout布局
  ${var:basePath} basePath是前面自定义的变量
  ${longdate} 日期格式 2017-01-17 16:58:03.8667
  ${shortdate}日期格式 2017-01-17 
  ${date:yyyyMMddHHmmssFFF} 日期 20170117165803866
  ${message} 输出内容
  ${guid} guid
  ${level}日志记录的等级
  ${logger} 配置的logger

NLog记录等级
  Trace - 最常见的记录信息，一般用于普通输出
  Debug - 同样是记录信息，不过出现的频率要比Trace少一些，一般用来调试程序
  Info - 信息类型的消息
  Warn - 警告信息，一般用于比较重要的场合
  Error - 错误信息
  Fatal - 致命异常信息。一般来讲，发生致命异常之后程序将无法继续执行。

NLog等级使用
  指定特定等级 如：level="Warn" 
  指定多个等级 如：levels=“Warn,Debug“ 以逗号隔开
  指定等级范围 如：minlevel="Warn" maxlevel="Error"

Logger发邮件参数
  smtpServer=“*****” 邮件服务器 例如126邮箱是smtp.126.com
  smtpPort=“25“端口
  smtpAuthentication=“Basic“ 身份验证方式 基本
  smtpUserName=“*****“ 邮件服务器用户名
  smtpPassword=“******”邮件服务器密码
  enableSsl=“false”是否使用安全连接 需要服务器支持
  addNewLines=“true” 是否换行
  from=“****” 发件邮箱
  to=“XXXX@XX.com,XXXXX@XX.com”收件邮箱 多个以逗号分隔
  subject=“subject:${machinename}报错“ 邮件主题
  header=“-开头-“ 邮件开头
  body=“${newline}${message}${newline}“ 邮件内容
  footer=“-结尾-“ 邮件结尾
```

# 邮件通知

前面说到了,运营中的产品出了错即时获得消息很重要,邮件通知是一个很好的方法. 下面将配置一个"只有Error级别邮件通知"的NLog.config:

```
<?xml version="1.0" encoding="utf-8" ?>
<nlog xmlns="http://www.nlog-project.org/schemas/NLog.xsd" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <targets>
    <target xsi:type="Mail"
            name="SendMail"
            smtpServer="smtp.xxx.com"
            smtpPort="587"
            enableSsl="true"
            smtpAuthentication="Basic"
            smtpUserName="xxx@xxx.com"
            smtpPassword="密码"
            addNewLines="false"
            from="xxx@xxx.com"
            to="xxx@xxx.com"
            subject="subject:${machinename}报错"
            header="-----开头-----"
            body="${longdate} ${level} ${callsite} ${message} ${exception:format=Message, Type, ShortType, ToString, Method, StackTrace}"
            footer="-----结尾-----"
            encoding="UTF-8">
    </target>
  </targets>

  <rules>
    <logger name="*" level="Error"  writeTo="SendMail" />
  </rules>
</nlog>
```

注意,为了能使用SSL,我这里使用的端口号为587,当你使用25/465都不能发送成功时,可以尝试. 坚持开启SSL的理由是为了让帐号密码更安全一些. 另外:我在Windows上测试时,只会在第一次发生错误的时候发一封邮件报告1个BUG.Linux正常.

# 存储在MongoDB

NLog支持将消息存储在数据库,相比本地的txt文件保存方式来说,可以获得更多的筛选条件,指定日期/类型等等,这是一个非常有参考价值的提案. 网上关于NLog存储在mysql的信息会更多一点,因为我打算用MongoDB做游戏开发,这里顺便也使用MongoDB. 从上一节中,我们可以发现每个target的设置都是独立的,xsi:type="Mail"指的就是Mail目标.我们现在将要设置的是Database目标. 但是在进行本节学习之前,强烈建议读者先完成[v0.1.6MongoDB](https://acgmart.com/unity/unity6/ "v0.1.6MongoDB")的学习. 能正确联接MongoDB,且在图形工具中可以观测数据的变化.

## 安装NLog.Mongo

直接搜索Nuget包"NLog.Mongo",在[github](https://github.com/loresoft/NLog.Mongo "github")可以查询更多信息.

## 属性介绍

name target名称 connectionString 连接字符串 databaseName 数据库名,覆盖connect string database collectionName 日志信息将要写入的集合 cappedCollectionSize 如果集合不存在,会创建本最大size的集合 cappedCollectionMaxItems 如果集合不存在,会创建本最大item数的集合 includeDefaults 是否创建默认文档,默认为true. field 指定根级文档字段,可指定多个字段. property 在属性字段指定字段,可指定多个字段

## NLog.config

```
<?xml version="1.0" encoding="utf-8" ?>
<nlog xmlns="http://www.nlog-project.org/schemas/NLog.xsd" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">

  <targets>
    <target xsi:type="Mongo"
            name="MongoDB"
            connectionString="mongodb://localhost/foo"
            collectionName="NLog"
            cappedCollectionSize="26214400">
      <property name="ThreadID" layout="${threadid}" bsonType="Int32" />
      <property name="ProcessID" layout="${processid}" bsonType="Int32" />
      <property name="ProcessName" layout="${processname:fullName=true}" />
    </target>
  </targets>

  <rules>
    <logger name="*" writeTo="MongoDB" />
  </rules>

  <extensions>
    <add assembly="NLog.Mongo"/>
  </extensions>
</nlog>
```

之后在Linux服务端上运行程序就可以将3行日志保存进服务端的本地数据库了. 如果设置了MongoDB的端口,那么要修改连接字符串mongodb://localhost:你的端口/你的数据库 效果如图: ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/postunity10_1.png) 是不是非常工整呢,和表格一个效果.

## 人造BUG

从上面的例子可以看出,默认会有\_id,Data,Level,Message等字段.其中\_id是系统自动生成的. 我们可以考虑人工制造一个异常,如让TcpClient去连接一个不存在的IP: using System.Net.Sockets;

```
            try
            {
                TcpClient tcpClient = new TcpClient("127.0.0", 9999);
            }
            catch (Exception e)
            {
                logger.Error("Error connect" + e);
            }
```

这样你会看到系统所提示你的message.

## 定制个性文档

使用field标签可以增加自定义字段,如:

```
<target xsi:type="Mongo"
            name="MongoDB"
            connectionString="mongodb://localhost/foo"
            collectionName="NLog"
            cappedCollectionSize="26214400">
  <field name="Date" layout="${date}" bsonType="DateTime" />
  <field name="Level" layout="${level}"/>
  <field name="Message" layout="${message}" />
  <field name="Logger" layout="${logger}"/>
  <field name="Exception" layout="${exception:format=tostring}" />
  <field name="ThreadID" layout="${threadid}" bsonType="Int32" />
  <field name="ThreadName" layout="${threadname}" />
  <field name="ProcessID" layout="${processid}" bsonType="Int32" />
  <field name="ProcessName" layout="${processname:fullName=true}" />
  <field name="UserName" layout="${windows-identity}" />
</target>
```

这些属性里面很多都不是必须的,message是主要的有用信息,日期便于排序,Logger辅助定位. 我这边Exception/ThreadName/UserName都是显示出来的,我会删除这些.

# 自定义日志样式

target部分属性: xsi:type="File" 操作目标 fileName File操作类型的输出文件路径 basedir 项目输出目录 deleteOldFileOnStartup="false" 是否删除旧文件 layout 样式 longdate 年月日 时分秒 shortdate 年月日 level 等级 var:xxx 自定义变量 callsite 代码发生位置,还可以细节设置 :className=false 关闭显示类名 :methodName=false 关闭显示方法名 :fileName=true 显示文件名 :includeSourcePath=false: 不显示路径 :skipFrames=2 message 消息正文 newline stacktrace :format=Raw :topFrames :skipFrames

# 显示日志发生行数

直接贴上我自己的NLog.config配置;

```
<?xml version="1.0" encoding="utf-8" ?>
<nlog xmlns="http://www.nlog-project.org/schemas/NLog.xsd" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
<!--写入邮件
<targets>
    <target xsi:type="Mail"
            name="SendMail"
        smtpServer="smtp.xxx.com"
        smtpPort="587"
        enableSsl="true"
        smtpAuthentication="Basic"
        smtpUserName="sekia@acgmart.com"
        smtpPassword="xxx"
        addNewLines="false"
        from="sekia@acgmart.com"
        to="sekia@acgmart.com"
        subject="${machinename}报错"
        encoding="UTF-8"
        body="${longdate} ${callsite:className=false:methodName=false:fileName=true:includeSourcePath=false} ${message}">
    </target>
</targets>
<rules>
    <logger name="*" minlevel="Error" writeTo="SendMail" />
</rules>-->

<!--写入数据库-->
<targets>
    <target xsi:type="Mongo"
        name="MongoDB"
        connectionString="mongodb://localhost/foo"
        collectionName="NLog"
        cappedCollectionSize="26214400">
        <field name="Date" layout="${date}" bsonType="DateTime" />
        <field name="Message" layout="${message}" />
        <field name="Level" layout="${level}"/>
        <field name="Logger" layout="${callsite:className=false:methodName=false:fileName=true:includeSourcePath=false}"/>
    </target>
</targets>
<rules>
    <logger name="*" minlevel="Trace" writeTo="MongoDB" />
</rules>
<extensions>
    <add assembly="NLog.Mongo"/>
</extensions>

<!--本地文件-->
<targets>
    <target xsi:type="File"
        name="All"
              fileName="${basedir}/../Logs/Log.txt"
              deleteOldFileOnStartup="false"
              layout="${longdate} ${callsite:className=false:methodName=false:fileName=true:includeSourcePath=false} ${message}">
    </target>
</targets>
<rules>
    <logger name="*" minlevel="Trace" writeTo="All" />
</rules>

  <!--命令行-->
<targets>
    <target type="ColoredConsole"
        name="Console"
        layout="${longdate} ${callsite:className=false:methodName=false:fileName=true:includeSourcePath=false} ${message}">
    </target>
</targets>
<rules>
    <logger name="*" minlevel="Trace" writeTo="Console" />
</rules>
</nlog>
```

Console效果: `2018-09-11 05:08:46.1842 (Program.cs:10) 测试错误` MongoDB效果: ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/postunity10_3.png)

# 友情提示

![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/postunity10_2.png) 代码可以折叠起来,每个target可以单独作为一块. 发邮件间隔1秒,不知道会造成多少系统负担,建议平时注释了关着吧. callsite还有个属性是skipFrames,默认值为0.skipFrames值指跳过的框架层数,当你封装了Log功能时,Log的外层会包装上其他新的名字. 而skipFrames为0时是指代码中最终调用日志函数的方法,可以通过增加skipFrames值的方式调试,当值超出包装层数则不显示本条日志.