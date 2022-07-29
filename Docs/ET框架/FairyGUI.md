# 概览
https://www.fairygui.com/docs/unity/drawcall

# UI的层级关系
对于最上级UI组件 父级是GRoot.inst 称为大UI
对于孩子UI组件需要在最上级UI组件中定义挂载方法并管理 称为小UI
ClientScene和CurrentScene各有自己的UIComponent
UI组件和UI的GObject(GameObject)存在对应关系 形成两个关系树
    大UI组件作为UIComponent的子级
    小UI组件作为大UI组件的子级
    大UI组件的GObject作为GRoot.inst的子级
    小UI组件的GObject作为大UI组件的GObject的子级
UI组件和GObject作为表现层数据存储在ModelView

# UGUI创建过程
UIEvent
    输入ClientScene或CurrentScene、UI名、挂点
    由Scene下的UIComponent负责管理UI对象
    UIEventComponent.Instance中保存的UIEvent调用OnCreate
    由Scene下的ResourcesLoaderComponent根据UI名加载ab包
    由ResourcesComponent.Instance根据UI名获取UI的预制体
    实例化预制体 设置挂点为父级
    在UIComponent下添加UI Entity 设置UI名和绑定的预制体
    向UI Entity添加逻辑组件 逻辑组件初始化获取预制体中的数据

# FairyGUI创建过程
在ClientScene创建完后发布AfterCreateClientScene消息 可在此时初始化UI系统
    UIEventComponent.Instance管理UI事件和数个UI Root层级容器
初始化分辨率 根据硬件的实际分辨率和UI的设计分辨率调整自适应方案
    GRoot.inst.SetContentScaleFactor
    UI通常不支持缩放 如果设备分辨率与设计分辨率接近可自适应居中 留下一些多余区域
    也可以考虑基于锚点的自适应 这样随着屏幕分辨率变化UI的位置跟随锚点移动
    GRoot的GameObject为：Stage/GRoot
初始化UI相机
    在Stage.Instantiate()中会确保存在名为“Stage Camera"的UI层相机
    此外还会获取主相机用于将世界空间坐标转换为屏幕空间坐标
    需要UI相机配合URP的相机渲染链
UI层级排序
    Component下的子级根据index排序
    使用sortingOrder自定义深度
    参考Demo Basics/Depth：允许不相关的多个模块向同一个容器添加物体
UI的加载
    FairyGUI有Package概念一个Unity项目可能用到数个Package
    Package之间不共享资源 可以给一个单独的bundle名
    获取UI物体时先加载Package再实例化对象
    
UIEvent
