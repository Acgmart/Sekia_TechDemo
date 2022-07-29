#if UNITY_EDITOR
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Sekia
{
    public class AlignToGround : MonoBehaviour
    {
        LayerMask mask = ~0;
        public void Align()
        {
            Transform trans = GetComponent<Transform>();
            RaycastHit hit;

            if (Physics.Raycast(trans.position + new Vector3(0f, 1.0f, 0.0f), Vector3.down, out hit, 3.0f, mask.value))
            {
                //proj：z轴新朝向
                //hit.normal：y轴新朝向

                //proj：减去trans.forward在hit.normal方向上的分量 变得与hit.normal垂直
                //Vector3.Dot(trans.forward, hit.normal) * hit.normal表示trans.forward在hit.normal上的投影
                Vector3 proj = trans.forward - Vector3.Dot(trans.forward, hit.normal) * hit.normal;
                trans.rotation = Quaternion.LookRotation(proj, hit.normal);
            }
        }
    }
}
#endif
