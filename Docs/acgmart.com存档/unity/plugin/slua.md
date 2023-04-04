---
title: SLua入门
categories:
- [Unity, 插件]
date: 2020-04-28 23:09:20
---

\[toc\]本篇内容主要是通过SLua的官方demo来学习在项目开发中SLua的用法 demo下载地址： [https://github.com/pangweiwei/slua/releases](https://github.com/pangweiwei/slua/releases "https://github.com/pangweiwei/slua/releases") 作者写的帮助文档： [https://github.com/pangweiwei/slua/blob/master/help.md](https://github.com/pangweiwei/slua/blob/master/help.md "https://github.com/pangweiwei/slua/blob/master/help.md") 目录结构： Assets/Plugins/Slua\_Managed目录：SLua插件源代码 Assets/Plugins/下的Android/iOS/x64/x86/slua.bundle目录：各平台的Lua虚拟机库 Assets/SLua/Editor目录：编辑工具 Assets/SLua/example目录：演示deno 初学者可以先跑跑看看效果 Assets/SLua/Resources目录：以txt格式的Lua脚本为主 Assets/SLua/Source目录： Assets/SLua/LuaObject目录：接口输出 build目录：Lua虚拟机库文件生成工具 Demo：circle 运行场景我们可以看到很亮眼的粒子效果，这些粒子挂载在数百个Cube上。 打开Circle.cs，里面并没有对GameOject的操作，也就是说： 新建GameObject、设置UI和物体运动逻辑的操作都在虚拟机中完成。 关于Lua语法方面可以参考[Lua语法入门](https://acgmart.com/unity/lua/ "Lua语法入门")。 在Lua虚拟机中执行Unity中的方法前需要先导出方法； SLua默认导出了Unity自带的库，用户需决定第三方库和自定义库的导出。 在C#中也可以执行Lua代码(导入方法)，也就是Lua中的table、function。 既然Slua自动导出了Unity自带的库，我们可以在Lua虚拟机中大有作为。

# 启动Lua虚拟机

C#代码：

```csharp
LuaSvr svr = new LuaSvr();
svr.init(null, () => { svr.start("circle/circle"); });
```

LuaSvr类：管理者，至少管理一台Lua虚拟机(进程)，只能init和start。 **init方法**：加载所有导出，默认的导出就有800多个.cs文件，所以这个工作量不少。 参数一：提供接口用于反映加载导出的百分比进度。 参数二：提供接口用于执行Lua虚拟机的逻辑入口，获取热点对象用于后续操作。 参数三：指定加载范围，Unity自带库和CustomLuaClass必加载。 **start方法**：从上到下逐行执行Lua脚本，再执行其中的main方法，可返回一个值。

# Lua中oop编程

熟练掌握Lua中的代码写法就可以快速将C#代码移植到Lua。

```lua
local somemodule = require 'module.some'
import "UnityEngine"
if not UnityEngine.GameObject or not  UnityEngine.UI then
    error("Click Make/All to generate lua wrap file")
end
```

import/require后，我们就可以使用其他lua文件中的全局变量； 在加载虚拟机的过程中我们已经创建好了UnityEngine这个全局table变量； 类的子类通过“.”访问：UnityEngine.GameObject 类的静态方法“.”访问：Custom.staticCustom() 类的静态成员通过“.”访问：math.pi (注：搞不懂为啥是小写的) 类的泛型方法只能有一种override：gameObject:GetComponent(UI.Slider) 对象的委托成员通过“.”访问：slider.onValueChanged 对象的成员变量通过“.”访问：counttxt.text 对象的成员方法通过“:”访问：gameObject:GetComponent(UI.Slider) 对象的自构方法省略“new”访问：root = GameObject("root")

## 声明一个类：

local class = {} 为类声明变量： class.t = 0 为类声明方法：

```lua
function class:int(count)
    self.t = 1
end
```

执行类的方法： `class:init()`

## 操作符：

`local offset = i%2==1 and 5 or -5` 相当于 `int a = (i%2==1)? 5:-5;` 连续的and和or从左往右顺序计算； bool and bool：返回第一个假值；如果都是真值则返回第二个值。 bool or bool：返回第一个真值；如果全部都是假值则返回第二个值。

## this成员方法：

```csharp
public int this[string key]
{ //get/set...
}
```

在Lua中访问this方法：

```lua
c:setItem("test",10)
c:getItem("test")
```

## 可变参数方法

```csharp
static public void func6(string str, params object[] args)
{ //一些逻辑
}
```

在Lua中访问可变参数方法：

```lua
HelloWorld.func6("aa")
HelloWorld.func6("aa",1,2)
HelloWorld.func6("aa",1,2,3,"bb")
HelloWorld.func6("aa",1,2,3,"bb",true,false)
local ss=String("bb")
HelloWorld.func6(ss,1,2,ss)
```

Lua中的string变量和C#中的System.String都能作为字符串参数传递。

## out参数

在Lua中访问带有out参数的方法： `local ok,hitinfo = Physics.Raycast(Vector3(0,0,0),Vector3(0,0,1),Slua.out)` 用额外的返回值作为out参数。

## Type参数-传递类型

```csharp
static public void ofunc(Type t) {
    Debug.Log(t.Name);
}
```

在Lua中访问带有Type参数的方法：

```lua
HelloWorld.ofunc(GameObject)
```

使用table类型变量代替Type。

## 类型转换

ocal v = CreateBase() -- 返回BaseObject local x = Slua.As(v,Child) -- Child继承自Base 访问v的metatable ChildObject，实现转换为子级对象。

## Delegate/Action

```csharp
public delegate bool GetBundleInfoDelegate(string path, out string url);
public GetBundleInfoDelegate d;
```

在Lua中将function变量赋值给delegate对象(userdata)：

```lua
xxx.d=function(path)
    return true,url --返回值数量 = 1 + out数量
end
```

Lua中对delegate对象(userdata)使用操作符：

```lua
self={}
function self.xxx(a,b,c)
    --声明一个function
end

h.d={"+=",self.xxx} --操作符 + function变量作为参数
h.d={"-=",self.xxx}
```

Lua中对泛型Action的访问：

```csharp
public static Action<int, Dictionary<int, object>> daction;
```

action同delegate，将泛型参数展开，可使用操作符：

```lua
Deleg.daction = {"+=",callback}
```

## Coroutine

```lua
local c=coroutine.create(function()
    print "coroutine start"
    Yield(WaitForSeconds(2))
    print "coroutine WaitForSeconds 2"
    local www = WWW("http://www.sineysoft.com")
    Yield(www)
    print(www.bytes)
    print(#www.bytes)
end)
coroutine.resume(c)
```

在Lua中的coroutine内使用Yield方法，可阻塞起当前的线程(coroutine)，等待操作完成。 Yield方法不能再主线程()，区别于[coroutine.yield](https://www.runoob.com/lua/lua-coroutine.html "coroutine.yield")命令。

## Lua专用定时器

```lua
--Add(delay,func)
--Add(delay,cycle,func)
LuaTimer.Add(0,20,function(id)
    cube.transform.localScale = Vector3(10,10,10)*(0.1+math.sin(os.clock()))
    cube2.transform.position = Vector3(math.sin(os.clock())*5,0,0)
    return true
end)
```

参数delay：任务延迟dalay(毫秒)后触发 参数cycle：任务循环间隔cycle(毫秒)触发 参数func：指定function类型参数为任务逻辑 参数func的返回值：返回true表示任务还可以被继续触发，false表示func只执行一次。 Add方法的返回值：成功创建任务后返回任务ID，用于主动删除任务。 删除任务：LuaTimer.Delete(id)

## Lua自定义类继承父级

虽然我们通常都是在C#中定义好了Class导出到Lua中使用，也可以在Lua定义：

```lua
MyGameObject=Slua.Class(GameObject, --父级类型
    nil, --静态方法table
    { --成员方法table
        AddComponent=function(self,t)
            print "overloaded AddComponent"
            self.__base:AddComponent(t)
        end,
    }
)
```

## Lua中数组的使用

在Lua中数组都以userdata的形式存在，push或者创建一个`Vector3[]`：

```lua
local a=Slua.MakeArray("UnityEngine.Vector3",{Vector3(1,0,0),Vector3(1,0,0)})
```

使用迭代器遍历数组中的元素，区别于`for k,v in ipairs(table) do/end`：

```lua
for v in Slua.iter(a) do
    print(v)
end
```

# 导出方法

使用插件的clear all/make all工具导出接口文件； 最终导出效果以导出的接口文件为准，用户可以调整导出范围。 在Lua虚拟机中使用(直接访问或作为参数)不存在的接口则报错。

## 缩减导出范围

因为Unity库很大，导致加载时间过长： 在CustomExport.cs的OnGetNoUseList方法中添加要忽略的接口 处理因版本/平台差异导致的接口丢失： 在LuaCodeGen.cs的memberFilter中添加丢失的接口

## 导出自定义类/方法

### 手动添加要导出的Class

方法一：在CustomExport.cs的OnAddCustomClass方法中追加类、泛型类

```csharp
//add(type, typename) typename用于在Lua代码中访问全局table变量
add(typeof(Dictionary<string, UnityEngine.GameObject>), "DicGameObjectByName");
add(typeof(List<string>), "ListString");
```

方法二：为Class/Delegate/struct添加`[CustomLuaClassAttribute]`属性 所有public 成员方法/静态方法/属性(set/get)/数据/delegate成员都会导出 手动添加要导出的程序集/namespace： 在CustomExport.cs的OnAddCustomAssembly方法中添加要加载的第三方程序集名 在CustomExport.cs的OnAddCustomNamespace方法中添加要加载的自定义namespace

### 在已导出类中 手动添加用户自定义成员方法

```csharp
[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
static public int instanceCustom(IntPtr l) {
     Custom self = (Custom)LuaObject.checkSelf(l);
     LuaObject.pushValue(l, true);
     LuaDLL.lua_pushstring(l,"hanmeimei");
     LuaDLL.lua_pushinteger(l,self.v);
     LuaObject.pushObject(l, c);
     return 4;
}
```

可用于在Lua中返回多个值，如string/number/userdata等。

### 在已导出类中 手动添加用户自定义静态方法

相比成员方法，额外加一个`[StaticExport]`属性。

### 在已导出类/namespace中 指定不导出的部分public成员

方法一：为成员/方法/属性/delegate添加`[DoNotToLua]`属性 方法二：标记类为internal可见性

### 指定重载方法版本

一个方法有多个重载时，Lua中因为类型过少无法区分，所以需要指定重载。 为某一个重载添加LuaOverrideAttribute。

### 重载默认导出方法

SLua自动导出了Unity库，所以我们能通过GameObject.Find访问方法； 我们可以通过自定义代码(MyGameObject.Find)来重载GameObject.Find方法：

```csharp
[OverloadLuaClass(typeof(GameObject))]
public class MyGameObject : LuaObject
{
    [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
    public static int Find_s(IntPtr l)
    {
        UnityEngine.Debug.Log("GameObject.Find overloaded my MyGameObject.Find");
        try
        {
            System.String a1;
            checkType(l, 1, out a1);
            var ret = UnityEngine.GameObject.Find(a1);
            pushValue(l, true);
            pushValue(l, ret);
            return 2;
        }
        catch (Exception e)
        {
            return error(l, e);
        }
    }
}
```

这样的重载会修改导出的接口文件。

### 重新Make

当我们更改了源代码时，就可能需要重新Make更新接口文件。 只是修改函数的逻辑，不改变函数的输入和输出(数量/类型)时，不需要Clear/Make。

# demo演示内容

demo中一共有9个场景，阅读这些源代码便于快速理解实际开发中遇到的问题。 1.**Circle**：从LuaTable导入方法到C#、Lua中对GameObject和UI的常见操作 2.**Custom**：自定义导出、push数据、Override导出 3.**Delegate**：Delegate的赋值、委托内容在C#和Lua虚拟机中被调用 4.**Main**：从LuaState导入方法到C#、Coroutine、数组、字节、?参数、struct... 5.**MultiState**：多LuaState(线程) 6.**NewCoroutine**：Lua中执行MonoBehaviour.MonoStartCoroutine(coroutine.yield阻塞) 7.**PerformanceTest**：性能测试 8.**ValueTypeTest**：值类型变量测试 9.**VarObj**：未导出的泛型类型的错误演示

# C#中调用SLua

## LuaSvr

用于管理全部LuaState，自身有一个常驻的LuaState。

### init

启动Lua虚拟机，加载导出。

### start

内部实现是用mainState先doFile然后run文件里的main方法。

## LuaFunction

获取table中名为update的function： `LuaFunction update = (LuaFunction)self["update"] ;`

### call

转换fuction为C#中的delegate(须先导出UpdateDelegate这个Class)： `UpdateDelegate ud = update.cast<UpdateDelegate>();` 转换成delegate优于直接运行LuaFunction： `update.call();`

## LuaState

LuaState是一个独立的线程。 相比C#中的线程来说，它和其他线程没有交互，独享一片内存。

### doFile

`LuaState.doFile("目录名/文件名")` 执行单个Lua文件，执行过程中产生的全局变量写入到LuaState的内存中。

### openSluaLib

添加Slua库，这样才能用Slua.xxx和LuaTimer等扩展方法。

### bindUnity

添加Slua库，自定义库，这样才能用CustomLuaClass的导出方法。

### doString

```csharp
LuaState.doString (string.Format ("print('number：{0}')", 1));
LuaState.doString(@" //@符号表示不处理转义符 可以直接复制粘贴文本
//Lua脚本...
")
```

和从二进制文件总读取字符串效果是一样的，可以执行几乎任何逻辑。

### getFunction/getTable/this\["key"\]

`LuaSvr.mainState.getFunction("foo").call(1, 2, 3);` 获取/设置function、table...，key中的父子关系用“.”号表示。

### run

`LuaState.run("全局方法名")` 判断getFunction成功，则执行；不能携带参数。

### Dispose

`LuaState.Dispose();` 主动释放内存并回收垃圾。

### Name

`LuaState.Name = "someName";` 能给线程起名字。

## LuaTable

LuaTable表现为列表容器，通常被扩展后当做自定义类来用。

### this\["key"\]

获取/设置列表中的成员。

### TablePair

```csharp
LuaTable t;
foreach (LuaTable.TablePair pair in t)
{
    Debug.Log(string.Format("key：{0}  value：{1}", pair.key, pair.value));
}
```

用于作为迭代器中的基础元素类型。

### GetEnumerator

`var iter = t.GetEnumerator();` 将LuaTable转换为迭代器。

### new

`LuaTable t = new LuaTable(LuaState.main);` 在指定的LuaState下创建table变量