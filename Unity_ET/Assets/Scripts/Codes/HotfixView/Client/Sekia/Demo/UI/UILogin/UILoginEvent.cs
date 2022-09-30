using System;
using UnityEngine;
using FairyGUI;

namespace ET.Client
{
    [UIEvent(UIType.UILogin)]
    public class UILoginEvent: AUIEvent
    {
        public override async ETTask<UI> OnCreate(UIComponent uiComponent, UILayer uiLayer)
        {
            string uiPackageName = UIEventComponent.Instance.GetPackageName(UIType.UILogin);
            await UIEventComponent.Instance.AddPackage(uiPackageName);
            GObject gObject = UIPackage.CreateObject(uiPackageName, UIType.UILogin);
            var root = UIEventComponent.Instance.GetLayer((int)uiLayer);
            root.AddChild(gObject);
            UI ui = uiComponent.AddChild<UI, string, GObject>(UIType.UILogin, gObject);
            
            return ui;
        }

        public override void OnRemove(UIComponent uiComponent)
        {
            //ResourcesComponent.Instance.UnloadBundle(UIType.UILogin.StringToAB());
        }
    }
}