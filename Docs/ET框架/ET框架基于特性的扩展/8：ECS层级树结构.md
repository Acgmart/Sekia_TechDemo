# ECS节点系统
ECS系统维护一个实体组件树结构 实体组件之间通过父子关系链传递逻辑
为了简化开发ET中Entity和Component的基类都是Entity
    比如玩家管理组件负责管理全部玩家 表现上倾向于Component
    玩家可以挂载移动组件、攻击组件 表现上倾向于Entity

# ZoneScene
创建RootScene：Entry中添加了场景的根节点Scene：Root.Instance.Scene
    RootScene的zone为0，SceneType为Process，名称为Process，父级为null
    SceneType有消息过滤的功能，比如入口初始化事件的EventHanndler就需要SceneType为Process
    RootScene节点上挂载全局基础组件 基础组件是所有业务逻辑执行的前提
        对于双端：网络、消息收发、AI、ClientSceneManagerComponent等组件
        对于客户端：资源加载、全局挂点组件
        对于服务端：寻路、内网等组件
创建ClientScene：SceneFactory.CreateClientScene
    对于客户端来说只有1个Client类型的Scene
        zone为1，SceneType为Client，名称为Game，父级为ClientSceneManagerComponent单例
    ClientScene节点上挂载玩家、CurrentScenesComponent等业务组件
创建CurrentScene：SceneFactory.CreateCurrentScene
    CurrentScene对应当前角色所在场景 也只有1个
        zone为ClientScene的zone，SceneType为Current，名称为场景名，父级为CurrentScenesComponent

# 快捷访问ClientScene/CurrentScene
Entity.ClientScene：通过ClientSceneManagerComponent组件查询zone值对应的ClientScene
Entity.DomainScene：返回实体层级树的顶层的Scene节点
    一个层级树的Domain都是一样的：this.Domain = this.parent.domain;
    Scene的Domain就是自己：this.Domain = this;

