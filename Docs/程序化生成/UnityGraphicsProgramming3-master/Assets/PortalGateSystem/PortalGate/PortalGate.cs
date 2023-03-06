using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace PortalGateSystem
{
    public class PortalGate : MonoBehaviour
    {
        public static class ShaderParam
        {
            public const string MainCameraViewProj = "_MainCameraViewProj";
            public const string OpenRate = "_OpenRate";
            public const string ConnectRate = "_ConnectRate";
            public const string FrameColor0 = "_FrameColor0";
            public const string FrameColor1 = "_FrameColor1";
        }


        public GameObject virtualCameraPrefab;
        public int maxGeneration = 5;
        public float openTime = 0.5f;
        public float connectTime = 0.5f;

        public PortalGate pair { get; protected set; }
        public Collider hitColl;


        public Quaternion gateRot { get; } = Quaternion.Euler(0f, 180f, 0f);

        public Color frameColor0;
        public Color frameColor1;

        Dictionary<Camera, VirtualCamera> pairVCTable = new Dictionary<Camera, VirtualCamera>();

        Material material;
        Collider coll;


        #region Unity

        private void Awake()
        {
            material = GetComponent<Renderer>().material;
            coll = GetComponent<Collider>();

            material.SetFloat(ShaderParam.ConnectRate, 0f);
        }

        private void Start()
        {
            material.SetColor(ShaderParam.FrameColor0, frameColor0);
            material.SetColor(ShaderParam.FrameColor1, frameColor1);
        }

        private void OnDestroy()
        {
            Destroy(material);
        }

        private void OnWillRenderObject()
        {
            if (pair == null) return;

            var cam = Camera.current;
            var vc = cam.gameObject.GetComponent<VirtualCamera>();

            VirtualCamera pairVC;
            if (!pairVCTable.TryGetValue(cam, out pairVC))
            {
                if ((vc == null) || vc.generation < maxGeneration)
                {
                    pairVC = pairVCTable[cam] = CreateVirtualCamera(cam, vc);
                    return;
                }
            }


            RenderTexture tex;

            if (pairVC != null)
            {
                tex = pairVC.targetTexture;
            }
            // last generation
            else
            {
                cam = vc.parentCamera;
                tex = vc.lastTex;
            }

            var rootCam = vc?.rootCamera ?? cam;
            Matrix4x4 projGPU = GL.GetGPUProjectionMatrix(rootCam.projectionMatrix, true) * cam.worldToCameraMatrix;


            material.mainTexture = tex;
            material.SetMatrix(ShaderParam.MainCameraViewProj, projGPU);
        }

        #endregion


        public void Open()
        {
            StartCoroutine(UpdateRateCoroutine(ShaderParam.OpenRate, openTime));
        }

        public void SetPair(PortalGate gate)
        {
            if (pair == null && gate != null)
            {
                StartCoroutine(UpdateRateCoroutine(ShaderParam.ConnectRate, connectTime));
            }

            pair = gate;
        }

        VirtualCamera CreateVirtualCamera(Camera parentCam, VirtualCamera parentVC)
        {
            var rootCam = parentVC?.rootCamera ?? parentCam;
            var generation = parentVC?.generation + 1 ?? 1;

            var go = Instantiate(virtualCameraPrefab);
            go.name = rootCam.name + "_virtual" + generation;
            go.transform.SetParent(transform);

            var vc = go.GetComponent<VirtualCamera>();
            vc.rootCamera = rootCam;
            vc.parentCamera = parentCam;
            vc.parentGate = this;
            vc.generation = generation;

            vc.Init();

            return vc;
        }

        public bool IsVisible(Camera camera)
        {
            var ret = false;

            var pos = transform.position;
            var camPos = camera.transform.position;

            var camToGateDir = (pos - camPos).normalized;
            var dot = Vector3.Dot(camToGateDir, transform.forward);
            if (dot > 0f)
            {
                var planes = GeometryUtility.CalculateFrustumPlanes(camera);
                ret = GeometryUtility.TestPlanesAABB(planes, coll.bounds);
            }

            return ret;
        }


        public void UpdateTransformOnPair(Transform trans)
        {
            UpdateTransformOnPair(trans, trans.position, trans.rotation);
        }

        public void UpdateTransformOnPair(
            Transform trans, 
            Vector3 worldPos,
            Quaternion worldRot
            )
        {
            var localPos = transform.InverseTransformPoint(worldPos);
            var localRot = Quaternion.Inverse(transform.rotation) * worldRot;

            var pairGateTrans = pair.transform;
            var gateRot = pair.gateRot;
            var pos = pairGateTrans.TransformPoint(gateRot * localPos);
            var rot = pairGateTrans.rotation * gateRot * localRot;

            trans.SetPositionAndRotation(pos, rot);
        }

        public Vector3 UpdateDirOnPair(Vector3 dir)
        {
            var rot = pair.transform.rotation * pair.gateRot * Quaternion.Inverse(transform.rotation);
            return rot * dir;
        }


        IEnumerator UpdateRateCoroutine(string param, float time)
        {
            var startTime = Time.time;
            var rate = 0f;
            while (rate < 1f)
            {
                rate = Mathf.Min(1f, (Time.time - startTime) / time);
                material.SetFloat(param, rate);
                yield return null;
            }
        }
    }
}