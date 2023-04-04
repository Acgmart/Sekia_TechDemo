---
title: Unity 友元程序集与Package Manager
categories:
- [Unity, ET]
date: 2020-06-30 12:31:23
---

\[toc\]本篇描述，设置有元程序集，使其他程序集可访问Internal类型。

# Asmdef自定义友元程序集

在Unity中创建一个.asmdef文件，描述一个程序集，同级目录添加AssemblyInfo.cs：

```csharp
using System.Runtime.CompilerServices;

[assembly: InternalsVisibleTo("Unity.ShaderGraph.Editor.Tests")]
[assembly: InternalsVisibleTo("Unity.RenderPipelines.Universal.Editor")]
[assembly: InternalsVisibleTo("Unity.ShaderGraph.GraphicsTests")]
[assembly: InternalsVisibleTo("Unity.ShaderGraph.Editor.GraphicsTests")]
[assembly: InternalsVisibleTo("Unity.RenderPipelines.HighDefinition.Editor")]
```

设置后，指定名称的程序集可访问当前程序集中的Internal类型。 如果某个程序集使用友元程序集，提供给第三方用户访问Internal类型，第三方用户的程序集名就指定了。

# 自定义Package源

```
{
 "scopedRegistries": [
    {
      "name": "Keijiro",
      "url": "https://registry.npmjs.com",
      "scopes": [ "jp.keijiro" ]
    }
  ],

   "dependencies": {
    "jp.keijiro.klak.math": "1.0.1",
    "jp.keijiro.klak.motion": "1.0.1",
    "jp.keijiro.neolowman": "1.0.0",
    "jp.keijiro.test-assets": "1.0.1"
     }
 }
```

# 自主管理Package

将Package迁移到项目/Packages目录； 工程中有自定义DLL依赖这些Package，可能需要重新添加依赖。