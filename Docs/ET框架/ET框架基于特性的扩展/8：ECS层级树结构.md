# ZoneScene


# ECS节点系统
ECS系统维护一个组件树结构 组件之间通过父子关系链传递逻辑
为了简化开发ET中并没强调Entity和Component的区别
    比如玩家管理组件负责管理全部玩家 表现上倾向于Component
    玩家可以挂载移动组件、攻击组件 表现上倾向于Entity
    不强调Component后 Entity将同时扮演数据和功能组件
客户端多个根节点：
    GameScene：全局基础组件
    ClientScene：玩家全局业务组件按需添加
    CurrentScene：当前场景相关组件按需添加