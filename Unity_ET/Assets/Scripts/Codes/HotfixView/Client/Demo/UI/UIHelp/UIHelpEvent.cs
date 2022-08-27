using System;
using UnityEngine;
using FairyGUI;
//Edit by Sekia

namespace ET.Client
{
	[UIEvent(UIType.UIHelp)]
    public class UIHelpEvent: AUIEvent
    {
        public override async ETTask<UI> OnCreate(UIComponent uiComponent, UILayer uiLayer)
        {
	        try
	        {
		        string uiPackageName = UIEventComponent.Instance.GetPackageName(UIType.UIHelp);
            	await UIEventComponent.Instance.AddPackage(uiPackageName);
            	GObject gObject = UIPackage.CreateObject(uiPackageName, UIType.UIHelp);
            	var root = UIEventComponent.Instance.GetLayer((int)uiLayer);
            	root.AddChild(gObject);
            	UI ui = uiComponent.AddChild<UI, string, GObject>(UIType.UIHelp, gObject);

				ui.AddComponent<UIHelpComponent>();
				return ui;
	        }
	        catch (Exception e)
	        {
				Log.Error(e);
		        return null;
	        }
		}

        public override void OnRemove(UIComponent uiComponent)
        {
        }
    }
}