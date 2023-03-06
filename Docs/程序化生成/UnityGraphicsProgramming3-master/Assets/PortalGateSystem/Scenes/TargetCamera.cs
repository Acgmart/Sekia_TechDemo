using System.Linq;
using UnityEngine;

namespace PortalGateSystem
{
    public class TargetCamera : MonoBehaviour
    {
        public MeshFilter target;
        Camera camera_;


        private void Start()
        {
            camera_ = GetComponent<Camera>();
        }

        void Update()
        {
            var mesh = target.sharedMesh;
            var posList = mesh.vertices
                .Select(vtx => target.transform.TransformPoint(vtx))
                .ToList();

            TargetCameraUtility.Update(camera_, posList);
        }
    }
}