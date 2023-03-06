using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using UnityStandardAssets.Characters.FirstPerson;

namespace PortalGateSystem
{
    [RequireComponent(typeof(Collider))]
    public class PortalObj : MonoBehaviour
    {
        public Transform center;
        public float ignoreGravityTime = 0.1f;
        protected Rigidbody rigidbody_;
        protected Collider collider_;
        protected SimpleFPController fpController;

        protected HashSet<PortalGate> touchingGates = new HashSet<PortalGate>();

        protected float ignoreGravityStartTime;

        private void Start()
        {
            if (center == null) center = transform;
            rigidbody_ = GetComponent<Rigidbody>();
            collider_ = GetComponent<Collider>();
            fpController = GetComponent<SimpleFPController>();
        }

        private void Update()
        {
            var passedGate = touchingGates.FirstOrDefault(gate =>
            {
                var posOnGate = gate.transform.InverseTransformPoint(center.position);
                return posOnGate.z > 0f;
            });


            if (passedGate != null)
            {
                PassGate(passedGate);
            }

            if ((rigidbody_ != null) && !rigidbody_.useGravity)
            {
                if ((Time.time - ignoreGravityStartTime)  > ignoreGravityTime)
                {
                    rigidbody_.useGravity = true;
                }
            }
        }

        private void OnTriggerStay(Collider other)
        {
            var gate = other.GetComponent<PortalGate>();
            if ((gate != null) && !touchingGates.Contains(gate) && (gate.pair != null))
            {
                touchingGates.Add(gate);
                Physics.IgnoreCollision(gate.hitColl, collider_, true);
            }
        }

        private void OnTriggerExit(Collider other)
        {
            var gate = other.GetComponent<PortalGate>();
            if (gate != null)
            {
                touchingGates.Remove(gate);
                Physics.IgnoreCollision(gate.hitColl, collider_, false);
            }
        }


        void PassGate(PortalGate gate)
        {
            gate.UpdateTransformOnPair(transform);

            if (rigidbody_ != null)
            {
                rigidbody_.velocity = gate.UpdateDirOnPair(rigidbody_.velocity);
                rigidbody_.useGravity = false;
                ignoreGravityStartTime = Time.time;
            }

            if (fpController != null)
            {
                fpController.m_MoveDir = gate.UpdateDirOnPair(fpController.m_MoveDir);
                fpController.InitMouseLook();
            }
        }
    }
}