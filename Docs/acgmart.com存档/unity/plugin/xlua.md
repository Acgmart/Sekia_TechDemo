---
title: XLua入门
categories:
- [Unity, 插件]
date: 2020-05-05 15:30:06
---

\[toc\]本篇主要通过XLua的官方demo整理XLua的入门知识。 Github：https://github.com/Tencent/xLua Master版本有案例说明，Release版本里没有。 XLua支持的特性相当多，相比SLua开发模式不需要反复导出，易用性更强。

# 目录关系与程序集

Plugins文件夹中存放各个平台Lua虚拟机用的库文件，比如： Assets/Plugins/x86\_64/xlua.dll 就是在64位windows系统中使用的库文件 XLua/Gen目录：生成的接口文件导出目录 XLua/Src目录：XLua的核心源代码 核心源代码+自定义接口+生成的接口文件需要放在同一个程序集。 比如：我们使用自定义的程序集名称：Runtime，文件夹Scripts。 引用关系如下： 我们需要在Runtime中使用：using XLua; 生成的接口文件需要引用Runtime中的代码 生成的接口文件需要引用XLua/Src中的代码 如果XLua不与Runtime在一个程序集，就会出现循环引用的编译BUG。 解决办法： 将XLua文件夹移动到Scripts文件夹(Editor部分拆分出去) 修改接口代码生成的路径

# C#中写逻辑

要导出接口的类，添加特性`LuaCallCSharp`。 启动一个虚拟机：`LuaEnv luaEnv = new LuaEnv();` 在虚拟机中创建一个空table：`LuaTable table = luaEnv.NewTable();`

## Get访问全局变量：

```csharp
luaenv.Global.Get<int>("a") //返回一个名称为a的数值型变量
luaenv.Global.Get<string>("b") //返回一个名称为b的字符串变量
luaenv.Global.Get<bool>("c") //返回一个名称为c的布尔变量
luaenv.Global.Get<DClass>("d"); //返回一个名称为b的table变量
luaenv.Global.Get<Dictionary<string, double>>("d");
luaenv.Global.Get<List<double>>("d");
luaenv.Global.Get<Interface>("d");
luaenv.Global.Get<LuaTable>("d");
luaenv.Global.Get<Action>("e"); //返回一个名称为e的function变量
luaenv.Global.Get<LuaFunction>("e");
luaenv.Global.Get<FDelegate>("f"); //返回一个名称为f的function变量
```

number转换为int，当number为非整数时，拷贝值0。 根据数据类型转换位string，只有nill和false为假。 table转换为class，只有class的同名+同类型参数的数据会被拷贝。 table转换为Dictionary，只有key和value类型一致的数据会被拷贝。 table转换为List，只有key为默认值的数据会被拷贝。 table转换为自定义导出的接口类，通过接口与table建立映射关系，推荐。 table转化为LuaTable实例，建立映射关系，慢+没有类型检查，不推荐。 function转化为自定义导出的Action，通过接口与function建立映射关系，推荐。 function转化为LuaFunction实例，建立映射关系，返回object数组，不推荐。 function转化为自定义导出的delegate，映射function，自定义out参数。 建议：尽量少访问Lua全局变量，建立映射关系后保存-调用即可。 为table添加数据：`meta.Set("__index", luaEnv.Global);` Tick方法：

## 声明接口：

```csharp
[CSharpCallLua]
public interface ItfD
{
    int f1 { get; set; }
    int f2 { get; set; }
    int add(int a, int b);
}

[CSharpCallLua]
public delegate int FDelegate(int a, string b, out DClass c);

[CSharpCallLua]
public delegate Action GetE();
```

# Lua逻辑入口

加载Lua文件：`luaenv.DoString("require 'filename'")` require方法：如果已知列表中没有目标文件的key，尝试寻找并执行文件。 路径判断逻辑：所有定义的工作目录都查找失败后报文件找不到。 1.Resource目录使用txt结尾 在任意Resource目录下放置：**filename.lua.txt** 2.通过虚拟机的接口，提供loader委托，定义加载文件的方式。

```csharp
public delegate byte[] CustomLoader(ref string filepath);
public void LuaEnv.AddLoader(CustomLoader loader)
```

委托返回的是字符串的byte数组(同DoSting)，具体逻辑虚拟机不关心。 读取目录和解加密操作都可以在委托中执行。

# Lua中写逻辑

```lua
local newGameObj = CS.UnityEngine.GameObject() --自构
local newGameObj2 = CS.UnityEngine.GameObject('helloworld') --支持重载
CS.UnityEngine.Time.deltaTime --读静态属性
CS.UnityEngine.Time.timeScale = 0.5 --写静态属性
CS.UnityEngine.GameObject.Find('helloworld') --调用静态方法
local GameObject = CS.UnityEngine.GameObject --使用局部变量保存引用
testobj.DMF --读(父级)成员属性
testobj.DMF = 1024 --写(父级)成员属性
testobj:DMFunc() --调用(父级)成员方法 第一个参数是成员自身 这里使用冒号语法糖
--输入参数包括：C#普通输入、ref
--输出参数包括：C#返回值、ref、out
testobj:EnumTestFunc(CS.Tutorial.TestEnum.E1) --enum变量 相当于静态属性
CS.Tutorial.TestEnum.__CastFrom(1) --number转换为enum类型变量
CS.Tutorial.TestEnum.__CastFrom('E1') --string转换为enum类型变量
testobj.TestDelegate = lua_delegate + testobj.TestDelegate --delegate相加
testobj:TestEvent('+', lua_event_callback1) --Event操作
testobj:CallEvent() --Event调用 Event不能为空
newGameObj:AddComponent(typeof(CS.UnityEngine.ParticleSystem)) --泛型-typeof
```

# 推荐方式+LuaTable/LuaFunction

## 获取全局table变量：

```csharp
LuaTable d4 = luaenv.Global.Get<LuaTable>("d");
```

## 使用Get方法访问table的成员：

```charp
int f1 = d4.Get<int>("f1");
Action e = luaenv.Global.Get<Action>("e"); //要求添加到生成列表
e();
```

## 添加delegate类型：

在上例中，使用了Action类型委托，无参数+无返回值，需要先添加后使用。 添加方式参考：Assets/XLua/Examples/ExampleGenConfig.cs 默认已经添加了：`typeof(Action),` 没有添加时，运行不会报错，会以反射方式运行；可以在日志中看到反射特征： `System.Reflection.MethodBase:Invoke(Object, Object[])` 新增了该类型的导出后，就不再使用反射了。