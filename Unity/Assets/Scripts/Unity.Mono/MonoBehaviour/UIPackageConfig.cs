using UnityEngine;
using System;

namespace ET
{
    [Serializable]
    public class UIPackageContentList
    {
        public string packageName;
        public string[] uiTypes;
    }

    [CreateAssetMenu(menuName = "ET/CreateUIPackageConfig", fileName = "UIPackageConfig", order = 0)]
    public class UIPackageConfig : ScriptableObject
    {
        public UIPackageContentList[] uIPackages;
    }
}
