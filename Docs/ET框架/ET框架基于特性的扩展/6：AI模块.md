# AI模块
AIConfigCategory：将AIConfig数据根据AIConfigId分类整理
    AIConfigId：AI类型
    Name：AI节点名

AIDispatcherComponent：单例 AI事件分发
    Load：收集用用AIHandlerAttribute标记的AI事件类型 Name对应AI节点名

AIComponent：AI组件的本体
    Awake：指定一个AIConfigId 每秒重复执行AITimer委托=>AIComponent的Check方法
    Check：执行AI 相当于遍历状态机
        判断Parent是否为空 Parent是AIComponent的挂载点不能为空
        遍历该AI类型下的全部节点
            取出AI节点名对应的AAIHandler
            判断节点是否满足条件：aaiHandler.Check(...)
            避免反复执行新节点：AIComoinent.Current记录当前执行的节点的Id
            取消旧节点：Cancel()
            安排新节点的任务：aaiHandler.Execute(...).Corouting();