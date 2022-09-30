using UnityEngine;
using System;
//Edit by Sekia

namespace ET
{
    public enum CodeMode
    {
        Client = 1,
        Server = 2,
        ClientServer = 3,
    }
    
    [Serializable]
    public class UIPackageContentList
    {
        public string packageName;
        public string[] uiTypes;
    }
    
    [CreateAssetMenu(menuName = "ET/CreateGlobalConfig", fileName = "GlobalConfig", order = 0)]
    public class GlobalConfig: ScriptableObject
    {
        public CodeMode CodeMode;
        public UIPackageContentList[] uIPackages;
        public Vector2Int uiDesignResolution = new Vector2Int(960, 540);
    }
}