using UnityEngine;
//Edit by Sekia

namespace ET.Client
{
    [ComponentOf(typeof(Scene))]
    public class GlobalComponent : Entity, IAwake
    {
        [StaticField]
        public static GlobalComponent Instance;

        public Transform Global;

        public Transform unitRoot;
        public Transform mainCamera;
        public Transform uiCamera;
    }
}
