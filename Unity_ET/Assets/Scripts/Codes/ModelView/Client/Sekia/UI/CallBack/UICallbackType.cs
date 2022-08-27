
namespace ET.Client
{
    [UniqueId(20001, 30000)]
    public static class UICallbackType
    {
        //20001~21000为UI系统用的UI事件
        public const int ScreenSizeChanged = 20001;
        public const int Test20002 = 20002;
        public const int Test20003 = 20003;
        public const int Test20004 = 20004;
        public const int Test20005 = 20005;

        //21001~为业务模块用的UI事件
    }

    //订阅：Game.Scene.AddComponent<NetInnerComponent, IPEndPoint, int>(processConfig.InnerIPPort, CallbackType.SessionStreamDispatcherServerInner);
    //触发：Game.EventSystem.Callback(self.SessionStreamDispatcherType, session, memoryStream);
    //执行：[Callback(CallbackType.SessionStreamDispatcherServerInner)]

    //事件类型
    public enum UISubscriptionType
    {
        OnClik,
        OnRightClick,
        OnTouchBegin,
        OnTouchMove,
        OnTouchEnd
    }

    //事件上下文
    public struct UIEventContext
    {
        //鼠标点击的坐标啥的事件关联信息
    }



    [FriendOf(typeof(UIEventSubscriber))]
    public static class UIEventSubscriberSystem
    {

    }

    public sealed class UIEventSubscriber : Entity
    {
        public int callbackType;
        public UISubscriptionType uiSubscriptionType;
        public Entity owner;

        public void Run()
        {
            //EventSystem.Instance.Callback(callbackType, uiSubscriptionType, owner);
        }
    }

    //订阅者和服务者 Subscriber and Provider
    //1.预定义事件逻辑
    //2.订阅时向服务者添加 UIEventSubscriber
    //3.触发事件时查找对应 UIEventSubscriber 执行事件
}
