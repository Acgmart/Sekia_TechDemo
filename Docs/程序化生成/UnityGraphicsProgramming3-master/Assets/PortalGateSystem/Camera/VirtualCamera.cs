using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace PortalGateSystem
{
    [RequireComponent(typeof(Camera))]
    public class VirtualCamera : MonoBehaviour
    {
        const string PlayerLayerName = "Player";

        public Camera camera_;

        public PortalGate parentGate;
        public Camera rootCamera;
        public Camera parentCamera;

        public int generation;

        bool currentTex0;
        protected RenderTexture tex0;
        protected RenderTexture tex1;


        public RenderTexture targetTexture => currentTex0 ? tex0 : tex1;

        public RenderTexture lastTex => currentTex0 ? tex1 : tex0;

        private void Awake()
        {
            camera_ = GetComponent<Camera>();
        }

        public void Init()
        {
            camera_.aspect = rootCamera.aspect;
            camera_.fieldOfView = rootCamera.fieldOfView;
            camera_.nearClipPlane = rootCamera.nearClipPlane;
            camera_.farClipPlane = rootCamera.farClipPlane;
            camera_.cullingMask |= LayerMask.GetMask(new[] { PlayerLayerName });
            camera_.depth = parentCamera.depth - 1;

            camera_.targetTexture = tex0;
            currentTex0 = true;
        }

        private void Update()
        {
            CheckTexSize();

            SwapTex();
        }

        private void LateUpdate()
        {
            // PreviewCameraなどはこのタイミングでnullになっているようなのでチェック
            if (parentCamera == null)
            {
                Destroy(gameObject);
                return;
            }

            camera_.enabled = parentGate.IsVisible(parentCamera);
            if (camera_.enabled)
            {
                var parentCamTrans = parentCamera.transform;
                var parentGateTrans = parentGate.transform;

                parentGate.UpdateTransformOnPair(
                    transform, 
                    parentCamTrans.position, 
                    parentCamTrans.rotation
                    );


                UpdateCamera();
            }
        }


        void CheckTexSize()
        {
            var baseTex = rootCamera.targetTexture;
            var size = (baseTex != null)
                ? new Vector2Int(baseTex.width, baseTex.height)
                : new Vector2Int(Screen.width, Screen.height);

            if ((tex0 == null) || tex0.width != size.x || tex0.height != size.y)
            {
                if (tex0 != null) tex0.Release();
                if (tex1 != null) tex1.Release();

                tex0 = new RenderTexture(size.x, size.y, 24);
                tex1 = new RenderTexture(size.x, size.y, 24);
            }
        }

        void SwapTex()
        {
            // swap
            camera_.targetTexture = lastTex;
            currentTex0 = !currentTex0;
        }


        void UpdateCamera()
        {
            var pair = parentGate.pair;
            var pairTrans = pair.transform;
            var mesh = pair.GetComponent<MeshFilter>().sharedMesh;
            var vtxList = mesh.vertices.Select(vtx => pairTrans.TransformPoint(vtx)).ToList();

            TargetCameraUtility.Update(camera_, vtxList);

            // Oblique
            // pairGateの奥しか描画しない = nearClipPlane を pairGateと一致させる
            var pairGateTrans = parentGate.pair.transform;
            var clipPlane = CalcPlane(camera_, pairGateTrans.position, -pairGateTrans.forward);

            camera_.projectionMatrix = camera_.CalculateObliqueMatrix(clipPlane);
        }

        Vector4 CalcPlane(Camera cam, Vector3 pos, Vector3 normal)
        {
            var viewMat = cam.worldToCameraMatrix;

            var normalOnView = viewMat.MultiplyVector(normal).normalized;
            var posOnView = viewMat.MultiplyPoint(pos);

            return new Vector4(
                normalOnView.x,
                normalOnView.y,
                normalOnView.z,
                -Vector3.Dot(normalOnView, posOnView)
                );
        }
    }
}