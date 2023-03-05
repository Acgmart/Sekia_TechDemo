# ObjectWait
ObjectWait被挂载在ClientScene、Unit等组件
通过等待上下文和通知推送上下文完成点到点的协程
    类似于Invoke 消息的接收者和发送者明确 但是上下文不复用
    Notify只能最多触发1个协程
        Invoke相当于行为触发一段逻辑 逻辑代码上下文不连贯
        Notify相当于通知中止的逻辑继续 逻辑代码上下文连贯