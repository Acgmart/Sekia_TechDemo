using UnityEngine;
//Edit by Sekia

namespace ET.Client
{
    [ComponentOf(typeof(Scene))]
    public class GlobalComponent: Entity, IAwake
    {
        [StaticField]
        public static GlobalComponent Instance;

        public FairyGUI_GlobalConfig globalConfig;
        
        public Transform Global;
        
        //Root
        public Transform Root_Unit;
        
        //Camera
        public Camera Camera_Main;
        public Camera Camera_UI;
    }
}