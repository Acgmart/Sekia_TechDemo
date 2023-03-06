using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;


namespace PortalGateSystem
{
    public class PortalGun : MonoBehaviour
    {
        public KeyCode key0 = KeyCode.Mouse0;
        public KeyCode key1 = KeyCode.Mouse1;

        public Color gateColor0_0;
        public Color gateColor0_1;

        public Color gateColor1_0;
        public Color gateColor1_1;


        public GameObject gatePrefab;
        List<PortalGate> gatePair = new List<PortalGate>(2) { null, null };

        public float gatePosOffset = 0.02f;


        private void Update()
        {
            if (Input.GetKeyDown(key0))
            {
                Shot(0);
            }
            else if (Input.GetKeyDown(key1))
            {
                Shot(1);
            }
        }

        void Shot(int idx)
        {
            RaycastHit hit;
            if (Physics.Raycast(transform.position,
                transform.forward, 
                out hit,
                float.MaxValue,
                LayerMask.GetMask(new[] { "StageColl" })))
            {
                var gate = gatePair[idx];
                if (gate == null)
                {
                    var go = Instantiate(gatePrefab);
                    gate = gatePair[idx] = go.GetComponent<PortalGate>();

                    gate.frameColor0 = (idx == 0) ? gateColor0_0 : gateColor1_0;
                    gate.frameColor1 = (idx == 0) ? gateColor0_1 : gateColor1_1;

                    var pair = gatePair[(idx + 1) % 2];
                    if (pair != null)
                    {
                        gate.SetPair(pair);
                        pair.SetPair(gate);
                    }
                }

                gate.hitColl = hit.collider;

                var trans = gate.transform;
                var normal = hit.normal;
                var up = normal.y >= 0f ? transform.up : transform.forward;

                trans.position = hit.point + normal * gatePosOffset;
                trans.rotation = Quaternion.LookRotation(-normal, up);

                gate.Open();
            }
        }
    }
}