using System;
using System.Collections.Generic;
using UnityEngine;
using FairyGUI;
//Edit by Sekia

namespace ET.Client
{
    /// <summary>
    /// 管理所有UI GameObject
    /// </summary>
    [ComponentOf(typeof(Scene))]
    public class UIEventComponent : Entity, IAwake, IDestroy
    {
        [StaticField]
        public static UIEventComponent Instance;

        public Dictionary<string, AUIEvent> UIEvents = new Dictionary<string, AUIEvent>();

        public Dictionary<int, GComponent> UILayers = new Dictionary<int, GComponent>();

        public Dictionary<string, UIPackage> UIPackages = new Dictionary<string, UIPackage>();

        public Dictionary<string, string> UITypeToPackageName = new Dictionary<string, string>();

        public Dictionary<string, string> PackageNameToBundleName = new Dictionary<string, string>();
    }
}
