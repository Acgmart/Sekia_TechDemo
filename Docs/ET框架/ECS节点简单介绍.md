# 客户端ECS节点简单介绍
Root：根节点
    NetThreadComponent
    OpcodeTypeComponent
    MessageDispatcherComponent
    NumericWatcherComponent
    AIDispatcherComponent
    ClientSceneManagerComponent
        ClientScene
            CurrentSceneComponent
            ObjectWait
            PlayerComponent
            UIEventComponent
            UIComponent
                UI_登录
                    UILoginComponent
            ResourceLoaderComponent
    ResourcesComponent
    GlobalComponent


# 服务端ECS节点简单介绍
Root：根节点
    NetThreadComponent
    OpcodeTypeComponent
    MessageDispatcherComponent
    NumericWatcherComponent
    AIDispatcherComponent
    ClientSceneManagerComponent

    ActorMessageSenderComponent
    ActorLocationSenderComponent
    LocationProxyComponent
    ActorMessageDispatcherComponent
    ServerSceneManagerComponent
        ServerScene
    RobotCaseComponent
    NavmeshComponent
    NetInnerComponent