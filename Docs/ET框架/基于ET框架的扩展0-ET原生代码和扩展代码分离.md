# 各部分代码的依赖顺序
框架的demo代码难免会对我们的工作进行干扰 最终还是要重写覆盖的
需要做必要的记录 明确各个文件夹的用途 修改维护方式等

Scripts/ThirdParty：有源代码的第三方插件 无任何依赖
    像FairyGUI这样的插件对Unity有依赖 所以应该放在别的目录 比如Loader层

Packages/：使用包管理器进行模块化管理的插件 主要通过云管理方式托管
    这部分插件通常我们不会去修改 由对应服务商进行版本升级

Loader：依赖于Unity的逻辑入口、运行时插件
    FairyGUI可放在Loader/Plugins下

Codes or Empty：对应逻辑层的4个DLL Model层不依赖于Unity
    依赖于Loader提供的逻辑入口和必要的mono脚本
    主要的逻辑修改点

Editor：编辑器扩展 不依赖于Empty

Codes/Editor：逻辑层插件 比如技能编辑器等需要运行时支持的插件
    优化工作流程的主要修改点

