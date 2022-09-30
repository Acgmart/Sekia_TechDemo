using UnityEngine;
using FairyGUI;

namespace ET.Client
{
    [UIEvent(UIType.UILobby)]
    public class UILobbyEvent: AUIEvent
    {
        public override async ETTask<UI> OnCreate(UIComponent uiComponent, UILayer uiLayer)
        {
            string uiPackageName = UIEventComponent.Instance.GetPackageName(UIType.UILobby);
            await UIEventComponent.Instance.AddPackage(uiPackageName);
            GObject gObject = UIPackage.CreateObject(uiPackageName, UIType.UILobby);
            var root = UIEventComponent.Instance.GetLayer((int)uiLayer);
            root.AddChild(gObject);
            UI ui = uiComponent.AddChild<UI, string, GObject>(UIType.UILobby, gObject);

            ui.AddComponent<UILobbyComponent>();
            return ui;
        }

        public override void OnRemove(UIComponent uiComponent)
        {
            ResourcesComponent.Instance.UnloadBundle(UIType.UILobby.StringToAB());
        }
    }
}