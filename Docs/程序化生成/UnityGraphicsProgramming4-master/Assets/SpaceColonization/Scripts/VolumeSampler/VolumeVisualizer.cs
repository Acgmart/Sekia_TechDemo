using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace SpaceColonization.VolumeSampler
{

    public class VolumeVisualizer : MonoBehaviour
    {

        [SerializeField] protected Volume volume;

        protected void OnDrawGizmos()
        {
            if (volume == null) return;

            Gizmos.matrix = transform.localToWorldMatrix;
            volume.Points.ForEach(p =>
            {
                Gizmos.DrawWireSphere(p, volume.UnitLength * 0.1f);
            });
        }

    }

}


