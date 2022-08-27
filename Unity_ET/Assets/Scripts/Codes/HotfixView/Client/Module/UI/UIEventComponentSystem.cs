using System;
using System.Collections.Generic;
using UnityEngine;
using FairyGUI;
//Edit by Sekia

namespace ET.Client
{

    [FriendOf(typeof(UIEventComponent))]
    public static class UIPackageHelper
    {
        public static string PackageNameToUIBundleName(this string value)
        {
            string result;
            if (UIEventComponent.Instance.PackageNameToBundleName.TryGetValue(value, out result))
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
    public static class UIEventComponentSystem
    {
        public class UIEventComponentAwakeSystem : AwakeSystem<UIEventComponent>
        {
            protected override void Awake(UIEventComponent self)
            {
                UIEventComponent.Instance = self;

                //添加UI的Root 指定UI的设计分辨率
                var uiDesignResolution = Init.Instance.GlobalConfig.uiDesignResolution;
                GRoot.inst.SetContentScaleFactor(uiDesignResolution.x, uiDesignResolution.y, UIContentScaler.ScreenMatchMode.MatchWidthOrHeight);

                GComponent uiRoot = GRoot.inst;

                GComponent Hidden = new GComponent();
                Hidden.name = Hidden.rootContainer.name = Hidden.container.gameObject.name = "Hidden";
                Hidden.opaque = false;
                uiRoot.AddChild(Hidden);

                GComponent Low = new GComponent();
                Low.name = Low.rootContainer.name = Low.container.gameObject.name = "Low";
                Low.opaque = true;
                uiRoot.AddChild(Low);

                GComponent Mid = new GComponent();
                Mid.name = Mid.rootContainer.name = Mid.container.gameObject.name = "Mid";
                Mid.opaque = true;
                uiRoot.AddChild(Mid);

                GComponent High = new GComponent();
                High.name = High.rootContainer.name = High.container.gameObject.name = "High";
                High.opaque = true;
                uiRoot.AddChild(High);

                self.UILayers.Add((int)UILayer.Hidden, Hidden);
                self.UILayers.Add((int)UILayer.Low, Low);
                self.UILayers.Add((int)UILayer.Mid, Mid);
                self.UILayers.Add((int)UILayer.High, High);

                //初始化UI包名
                var configs = Init.Instance.GlobalConfig.uIPackages;
                foreach (var package in configs)
                {
                    foreach (var type in package.uiTypes)
                    {
                        if (self.UITypeToPackageName.ContainsKey(type))
                            Log.Error($"出现了重复的UI类型 type:{type} package:{package.packageName}");
                        else
                            self.UITypeToPackageName[type] = package.packageName;
                    }
                }

                var uiEvents = EventSystem.Instance.GetTypes(typeof(UIEventAttribute));
                foreach (Type type in uiEvents)
                {
                    object[] attrs = type.GetCustomAttributes(typeof(UIEventAttribute), false);
                    if (attrs.Length == 0)
                    {
                        continue;
                    }

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

                    if (Define.IsAsync)
                    {
                        string uiBundleDesName = package.Key.PackageNameToUIBundleName();
                        ResourcesComponent.Instance.UnloadBundle(uiBundleDesName);
                    }
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

        public static GComponent GetLayer(this UIEventComponent self, int layer)
        {
            return self.UILayers[layer];
        }

        //用于加载游戏第一个UI 不参与资源更新
        public static void AddPackageInResourcesFolder(this UIEventComponent self, string packageName)
        {
            if (self.UIPackages.ContainsKey(packageName))
                return;

            string path = $"FairyGUI/{packageName}/{packageName}";
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
                string uiBundleDesName = packageName.PackageNameToUIBundleName();
                await ResourcesComponent.Instance.LoadBundleAsync(uiBundleDesName);
                AssetBundle desAssetBundle = ResourcesComponent.Instance.bundles[uiBundleDesName].AssetBundle;
                UIPackage uiPackage = UIPackage.AddPackage(desAssetBundle, desAssetBundle);
                self.UIPackages.Add(packageName, uiPackage);
            }
            else
            {
                string path = $"Assets/Bundles/FairyGUI/{packageName}/{packageName}";
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
            UIPackage package;
            if (self.UIPackages.TryGetValue(packageName, out package))
            {
                self.UIPackages.Remove(packageName);

                var p = UIPackage.GetByName(package.name);
                if (p != null)
                    UIPackage.RemovePackage(package.name);
            }

            if (Define.IsAsync)
            {
                string uiBundleDesName = packageName.PackageNameToUIBundleName();
                await ResourcesComponent.Instance.UnloadBundleAsync(uiBundleDesName);
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
    }
}
