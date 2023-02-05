using System;
using System.Collections.Generic;
using UnityEngine;
using FairyGUI;

namespace ET.Client
{
	[FriendOf(typeof(UIEventComponent))]
	public static class UIPackageHelper
	{
		public static string PackageNameToUIBundleName(this string value)
		{
			if (UIEventComponent.Instance.PackageNameToBundleName.TryGetValue(value, out var result))
				return result;

			result = $"ui_{value.ToLower()}.unity3d";
			UIEventComponent.Instance.PackageNameToBundleName[value] = result;
			return result;
		}
	}

    /// <summary>
    /// 管理所有UI GameObject 以及UI事件
    /// </summary>
    [FriendOf(typeof(UIEventComponent))]
    [FriendOfAttribute(typeof(ET.Client.ABInfo))]
    [FriendOfAttribute(typeof(ET.Client.ResourcesComponent))]
    public static class UIEventComponentSystem
    {
        [ObjectSystem]
        public class UIEventComponentAwakeSystem : AwakeSystem<UIEventComponent>
        {
            protected override void Awake(UIEventComponent self)
            {
                UIEventComponent.Instance = self;

                //添加UI的Root 指定UI的设计分辨率
                var uiDesignResolution = GlobalComponent.Instance.globalConfig.uiDesignResolution;
                GRoot.inst.SetContentScaleFactor(uiDesignResolution.x, uiDesignResolution.y, UIContentScaler.ScreenMatchMode.MatchWidthOrHeight);

                //添加4个子根节点
                GComponent uiRoot = GRoot.inst;
                GComponent hidden = new GComponent();
                GComponent low = new GComponent();
                GComponent mid = new GComponent();
                GComponent high = new GComponent();
                self.UILayers.Add((int)UILayer.Hidden, hidden);
                self.UILayers.Add((int)UILayer.Low, low);
                self.UILayers.Add((int)UILayer.Mid, mid);
                self.UILayers.Add((int)UILayer.High, high);

                //设置4个子根节点
                {
                    hidden.name = hidden.rootContainer.name = hidden.container.gameObject.name = "Hidden";
                    hidden.opaque = false;
                    uiRoot.AddChild(hidden);
                    low.name = low.rootContainer.name = low.container.gameObject.name = "Low";
                    low.opaque = true;
                    uiRoot.AddChild(low);
                    mid.name = mid.rootContainer.name = mid.container.gameObject.name = "Mid";
                    mid.opaque = true;
                    uiRoot.AddChild(mid);
                    high.name = high.rootContainer.name = high.container.gameObject.name = "High";
                    high.opaque = true;
                    uiRoot.AddChild(high);
                }

                //初始化UI包名
                var configs = GlobalComponent.Instance.globalConfig.uIPackages;
                foreach (var package in configs)
                    foreach (var type in package.uiTypes)
                        self.UITypeToPackageName[type] = package.packageName;

                var uiEvents = EventSystem.Instance.GetTypes(typeof(UIEventAttribute));
                foreach (Type type in uiEvents)
                {
                    var attrs = type.GetCustomAttributes(typeof(UIEventAttribute), false);
                    if (attrs.Length == 0)
                        continue;
                    UIEventAttribute uiEventAttribute = attrs[0] as UIEventAttribute;
                    AUIEvent aUIEvent = Activator.CreateInstance(type) as AUIEvent;
                    self.UIEvents.Add(uiEventAttribute.UIType, aUIEvent);
                }
            }
        }

        public class UIEventComponentDestroySystem : DestroySystem<UIEventComponent>
        {
            protected override void Destroy(UIEventComponent self)
            {
                foreach (var package in self.UIPackages)
                {
                    var p = UIPackage.GetByName(package.Value.name);
                    if (p != null)
                        UIPackage.RemovePackage(package.Value.name);

                    if (!Define.IsAsync) continue;
                    var uiBundleDesName = package.Key.PackageNameToUIBundleName();
                    ResourcesComponent.Instance.UnloadBundle(uiBundleDesName);
                }

                UIEventComponent.Instance = null;
                self.UILayers.Clear();
                self.UIEvents.Clear();
                self.UIPackages.Clear();
                self.UITypeToPackageName.Clear();
                self.PackageNameToBundleName.Clear();
            }
        }

        public static async ETTask<UI> OnCreate(this UIEventComponent self, UIComponent uiComponent, string uiType, UILayer uiLayer)
        {
            try
            {
                UI ui = await self.UIEvents[uiType].OnCreate(uiComponent, uiLayer);
                return ui;
            }
            catch (Exception e)
            {
                throw new Exception($"on create ui error: {uiType}", e);
            }
        }

        public static void OnRemove(this UIEventComponent self, UIComponent uiComponent, string uiType)
        {
            try
            {
                self.UIEvents[uiType].OnRemove(uiComponent);
            }
            catch (Exception e)
            {
                throw new Exception($"on remove ui error: {uiType}", e);
            }

        }

        public static GComponent GetLayer(this UIEventComponent self, int layer)
        {
            return self.UILayers[layer];
        }

        //用于加载游戏第一个UI 不参与资源更新
        public static void AddPackageInResourcesFolder(this UIEventComponent self, string packageName)
        {
            if (self.UIPackages.ContainsKey(packageName))
                return;
            var path = $"FairyGUI/{packageName}/{packageName}";
            UIPackage uiPackage = UIPackage.AddPackage(path);
            self.UIPackages.Add(packageName, uiPackage);
        }

        //用于加载打包为Bundle的UI
        public static async ETTask AddPackage(this UIEventComponent self, string packageName)
        {
            if (self.UIPackages.ContainsKey(packageName))
                return;

            if (Define.IsAsync)
            {
                //资源所在的路径不会影响package名称
                var uiBundleDesName = packageName.PackageNameToUIBundleName();
                await ResourcesComponent.Instance.LoadBundleAsync(uiBundleDesName);
                AssetBundle desAssetBundle = ResourcesComponent.Instance.bundles[uiBundleDesName].AssetBundle;
                UIPackage uiPackage = UIPackage.AddPackage(desAssetBundle);
                self.UIPackages.Add(packageName, uiPackage);
            }
            else
            {
                var path = $"Assets/Bundles/FairyGUI/{packageName}/{packageName}";
                UIPackage uiPackage = UIPackage.AddPackage(path);
                self.UIPackages.Add(packageName, uiPackage);
            }
        }

        public static string GetPackageName(this UIEventComponent self, string componentName)
        {
            return self.UITypeToPackageName[componentName];
        }

        //当一个Package中的内容确定不再需要时移除Package?
        //1.由玩家的游戏状态判断是否保留Package
        //2.延迟5分钟移除Package
        public static async ETTask RemovePackage(this UIEventComponent self, string packageName)
        {
            if (self.UIPackages.TryGetValue(packageName, out var package))
            {
                self.UIPackages.Remove(packageName);

                var p = UIPackage.GetByName(package.name);
                if (p != null)
                    UIPackage.RemovePackage(package.name);
            }

            if (Define.IsAsync)
            {
                var uiBundleDesName = packageName.PackageNameToUIBundleName();
                await ResourcesComponent.Instance.UnloadBundleAsync(uiBundleDesName);
            }
        }
    }
}