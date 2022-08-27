using UnityEngine;
//Edit by Sekia

namespace ET.Client
{
    [ObjectSystem]
    public class GlobalComponentAwakeSystem : AwakeSystem<GlobalComponent>
    {
        protected override void Awake(GlobalComponent self)
        {
            GlobalComponent.Instance = self;

            self.Global = GameObject.Find("/Global").transform;

            ReferenceCollector rc = self.Global.GetComponent<ReferenceCollector>();
            self.unitRoot = rc.Get<GameObject>("Root_Unit").transform;
            self.mainCamera = rc.Get<GameObject>("MainCamera").transform;
            self.uiCamera = rc.Get<GameObject>("UICamera").transform;
        }
    }
}
