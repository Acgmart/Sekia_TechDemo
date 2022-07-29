# C#编辑器设置
Unity2022版本可以确定对应VisualStudio2022版本
在Edit/Preferences/External Tools下进行设置

Generate .csproj files for选项：
在自动生成的sln文件中包括哪些project
Embedded packages：在Assets中自定义或默认的生成的project
Built-in packages：包含与URP关联的几个库
    这些库在packages-lock.json中依赖项的source属性为builtin

# VS插件
在VS的扩展-管理扩展中浏览已安装的和市场中的插件包
Format on Save for VS2022：
在保存文件时执行格式化保存，避免出现换行符、字符集等问题。
安装好Format on Save for VS2022后在工具-选项中可找到Format on Save相关设置。
Format document：文本对齐换行
UTF8：字符集设置
Line break：换行符设置