---
title: Lua入门
categories:
- [Unity, 插件]
date: 2020-04-28 23:08:10
---

\[toc\]简单的Lua语法入门 参考资料：[菜鸟教程](https://www.runoob.com/lua/lua-tutorial.html "菜鸟教程") type(var) 返回参数的变量类型 可能的变量类型有：nil/boolean/number/string/function/userdata/thread/table table/userdata类型变量：引用类型(指针) print方法 根据参数类型输出不同字符串 print(var) 当var是nil/boolean/number/string时直接输出内容 当var是function时 当var是userdata时：Custom (Custom) 返回数据的类型名 当var是thread时 当var是table时：调用table自定义的\_\_tostring方法 数学运算 数字互相运算：2+3 字符串与数字互相运算：“2”+3 "-2e2" \* "6" 字符串连接 字符串互相连接："a" .. 'b' 数字互相连接：157 .. 428 “#” 返回字符串长度 len = "www.runoob.com" #len #"www.runoob.com" 声明函数 function name(var1) --some code end 声明代码块 do --some code end 赋值语句 a = "hello" .. "world" a, b = 10, 2_x <--> a=10; b=2_x 先计算等式右边所有的值 再依次赋值给等式左边的变量(先左后右) 值不足时用nil补足 值多余时忽略 变量赋值时仅有值传递 索引 site = {} 向table类型变量添加键值对： site\["key"\] = "www.runoob.com" 取值： site\["key"\] site.key 循环 1.while循环： while( condition ) --condition为true时循环执行 do --some code end 2.for循环： for var = exp1,exp2,exp3 do --some code end var初始值为exp1 线性变化到终点值exp2 exp3为递增值 默认为1 3.for循环： table = {"one", "two", "three"} for key, value in ipairs(table) do print(key, value) --表中元素的key为1、2、3... end print(table\[1\]) --输出one 表中元素的index从1开始 4.repeat..untill循环： repeat --some code until( condition ) --先执行一次 直到condition为true才停止 注：true和非nil为真 也就是说0为true 流程控制 if( condition1 ) then --condition1为true时执行 --some code elseif( condition2 ) then --condition2为true时执行 --some code else --以上所有条件均为false时执行 --some code end 作用域 方法和变量默认为全局 局部方法和变量需要使用关键字local 声明函数 声明function类型： local function add(num1,num2,functionValue) --some code end 创建一个function类型变量： myprint = function(var, ...) --固定参数靠前 数组靠后 --some code local j = select('#', ...) --获取数组的长度 return 1, 2 --注：可以有多返回值： local arg={...} --注：可以有可变的输入参数 --some code end 运算符 加减乘除：+ - \* / 默认理解为浮点数 幂运算： 21^2 = 21 \* 21 = 441 余运算： 21 % 10 = 1 关系运算-不等于： 10 ~= 20 = true 逻辑运算： or and not 或 与 非 运算符优先级：同级运算从左到右 字符串 字符可以用单引号/双引号/\[\[string\]\]来表示 转义符用于表示不能直接显示的字符 string相关方法： string.gsub(str,findString,replaceString,times) --替换字符 times为替换次数可忽略 string.find(str, substr) --查找字符 返回substr的头和尾的位置或者nil string格式化： string.format("the value is:%d",4) --指定参数在字符串中的格式 %d, %i - 接受一个数字并将其转化为有符号的整数格式 匹配模式： string.match("I have 2 questions for you.", "%d+ %a+") --指定查找规则 table类型通过metatable实现逻辑扩展 一个table实例(主表)可以关联一个table(metatable)来实现功能上的扩展 当访问主表中不存在的key时： 1.在metatable找到\_\_index键(约定的特殊key)对应的value 2.1.如果value是table类型 则继续尝试在value中查找key 2.2.如果value是function类型 直接执行方法 总结：metatable用于存储特殊key应对不同的逻辑扩展 \_\_index：访问主表中不存在的key时 \_\_newindex：赋值主表中不存在的key时 (操作符对应key) `__add/__sub/_mul/__div/__unm/__concat/__eq/__le` table类型通过metatable实现oop扩展 一个类的实例可以访问自身以及父级链上的参数和方法 Lua中用两个table实现oop扩展： 1.第一个table(主表)保存自身的参数 就是一个普通的表 2.第二个table(副表 \_\_index)保存自身的方法和父级的参数 3.如果副表也有\_\_index声明则可以继续继承 当访问对象的自身参数(主表中的key)时 直接从主表中取值 当访问对象的自身方法/父级参数/父级方法(非主表中的key)时 尝试从副表中取值 副表中可能没有对应key 可沿着继承连持续查找 找不到时返回nil 方法重写： 自身声明父级中存在的同名函数时 自己的key优先返回 实例执行类的非静态方法： myrectangle = Rectangle:new(nil,10,20) --创建实例 myrectangle:printArea() --执行非静态方法 执行类的静态方法： local s,c=Custom.staticCustom(); --执行静态方法 忽略括号执行方法的情况 execute"xxx"; require"xxx";

# coroutine

Lua中的coroutine和Unity中的StartCoroutine方法非常的类似 一个协程任务的状态：dead、suspended、running 区别是在Unity中，遇到yield return则挂起等待下一帧调用return方法 “下一帧调用return”这个操作不需要我们亲自调用。 而Lua中coroutine.resume方法只能启动coroutine一次 Unity中StartCoroutine返回的IEnumerator对象经常没有接收者。 如果用`foreach var in IEnumerator`接收回复则可以快速movenext 而Lua中每次启动都可以输入值、每次挂起都可以返回值：

```lua
return coroutine.yield(2) --coroutine方法中某一次返回
print(coroutine.resume(co, 1)) --使用参数启动名为co的coroutine 并接受一次返回
```

Lua的这个coroutine流程解释成“连续的片段逻辑”更好 而Unity的StartCoroutine则可以解释成“延迟的任务”

# 声明方法

```lua
Time = 
{
    fixedDeltaTime  = 0,
    deltaTime       = 0,
    frameCount      = 1,
    timeScale       = 1,
    timeSinceLevelLoad  = 0,
    unscaledDeltaTime   = 0,        
}

local mt = {}
mt.__index = function(obj, name) --使用主表不存在的key访问时 在__index中查找或执行方法(主表和key作为参数)
    if name == "time" or name == "realtimeSinceStartup" then
        return UTime.realtimeSinceStartup - beginTime
    elseif name == "unscaledTime" then
        return UTime.unscaledTime - unscaledTime
    else
        return rawget(obj, name)        
    end
end

function Time:Init()
    self.frameCount = UnityEngine.Time.frameCount
    self.fixedTime  = UnityEngine.Time.fixedTime 
    self.timeScale  = UnityEngine.Time.timeScale
    self.deltaTime = 0  
    setmetatable(self, mt)
end
```

使用“:”和"."都能声明方法，都是使用\_\_index元表； 区别在于冒号方法中省略了table自身这个参数，方法内用self代替table自身。

# 初始化随机种子

math.randomseed(os.time())

# 文件的读写

## 读

全部阅读：

```lua
local ver_path_name = ins:GetPath(ver_file_name) --设置文件路径
local ver_file = io.open(ver_path_name, "r")
local old_version
if ver_file then
    old_version = ver_file:read("*all") --获取文件内容
    ver_file:close()
end
```

逐行阅读：

```lua
local md5 = ins:GetPath("ios_resource_md5.txt");
local md5File = io.open(md5, "r+")
local lines = md5File:lines()
local tx = lines() --每次调用获得一行内容
while( tx ~= nil )do
--do something
tx =  lines()
end
```

## 写

全部覆盖：

```lua
local cur_version = ins:GetVersion() --自定义要写入的内容
local new_ver_file, err = io.open(ver_path_name, "w") --写入指定路径
if new_ver_file then
    new_ver_file:write(cur_version)
    new_ver_file:close()
else
    print("写入失败" .. err)
end
```

添加内容：

```lua
local md5File = io.open(md5, "a+")
md5File:write("\n"..str)
md5File:flush()
io.close(md5File)
```

# 类的构架

在Lua中类的核心是Table，通过key访问对应的value，这与C#中不同。 我们创建一个空的table B，设置它的元表为另一个table A，于是： B继承于A，或者B是A类型的实例，这两个说法等效。 B可以继续添加数据，被C设置为元表，那么C又继承于B了。 下面是一个继承模型中的基类(Class.lua)，演示用new方法创建类的实例：

```lua
Class = {}

function Class:new(super)
    local class = {}
    class.__index = class

    local mt = {}
    setmetatable(class, mt) --设置元表
    if super then
        mt.__index = super --保存class的父级的table
    end
    function class:new(...) --在class中声明一个new方法
        local obj = {}
        setmetatable(obj, self)
        if obj.__new then --需要自己补充自构函数__new
            obj:__new(...)
        end
        return obj
    end
    return class
end

return Class
```

脚本自身有return，返回的table代表Class自身。 本例中，Class只包含一个new方法，这个方法返回的class可以理解为类的实例。 Class的new方法用于生成子类，class的new方法用于生成子类的实例。 class的实例(也就是obj)，会尝试访问\_\_new方法，也就是约定的自构函数。 下面是一个子类的举例：

```lua
local Class = require "Class"
Character = Class:new()
function Character:__new(var1, var2)
    print(var1, var2) --初始化子类
    --向子级table中添加变量
end
return Character
```

这样一来，就相当于我们声明了一个Class的子级Character。 下面是一个在其他文件尝试new Character实例的举例：

```lua
local Character = require "Character"
local someCharacter = Character:new(1, 2)
```

因为class(也就是Character)中声明的new方法覆盖了Class的new方法，所以程序先执行class:new(...) 在查找\_\_new方法时，因为Character中也声明了\_\_new，则带参数执行。 以上，实现了带参数new类的实例。 继续继承？ 下面演示了一个继承Character的例子：

```lua
local Character = require "Character"
--声明静态变量
local Player = Class:new(Character) --Character会被设置为元表
function Player:__new(var1, var2)
    Character.__new(self, var1, var2) --先初始化父级
    --声明成员变量
    --声明成员方法
end
--声明静态方法
return Player
```

继承链可以无限长，就好像用元表串联起来。 类的成员变量都在实例table中(`__new`方法中复制)，类的方法和静态变量都在元表table中 由于所有的子级都共享同一个元表作为父级，父级中的变量的值对全部子级生效。 子类中需要为父类执行初始化。