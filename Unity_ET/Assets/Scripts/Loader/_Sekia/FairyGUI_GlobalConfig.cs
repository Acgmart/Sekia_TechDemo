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
    
    [CreateAssetMenu(menuName = "ET/FairyGUI_CreateGlobalConfig", fileName = "FairyGUI_CreateGlobalConfig", order = 0)]
    public partial class FairyGUI_GlobalConfig: ScriptableObject
    {
        public UIPackageContentList[] uIPackages;
        public Vector2Int uiDesignResolution = new Vector2Int(960, 540);
    }
}