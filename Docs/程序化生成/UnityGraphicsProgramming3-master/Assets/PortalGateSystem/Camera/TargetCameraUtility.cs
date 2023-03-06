using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace PortalGateSystem
{
    public static class TargetCameraUtility
    {
        public static void Update(Camera cam, List<Vector3> posList)
        {
            cam.ResetProjectionMatrix();
            UpdateRect(cam, posList);
            UpdateProjection(cam, posList);
        }

        public static void UpdateRect(Camera cam, List<Vector3> posList)
        {
            cam.rect = new Rect(Vector2.zero, Vector2.one);

            var vpPosList = posList
                .Select(wPos => cam.WorldToViewportPoint(wPos))
                .ToList();


            var xList = vpPosList.Select(p => p.x);
            var yList = vpPosList.Select(p => p.y);

            var rect = Rect.MinMaxRect(
                xList.Min(),
                yList.Min(),
                xList.Max(),
                yList.Max()
                );

            cam.rect = rect;
        }

        public static void UpdateProjection(Camera cam, List<Vector3> posList)
        {
            var nearPosList = posList
                .Select(wPos => WorldPosToNearPos(cam, wPos))
                .ToList();

            var xList = nearPosList.Select(p => p.x);
            var yList = nearPosList.Select(p => p.y);

            var frustum = new FrustumPlanes()
            {
                left = xList.Min(),
                right = xList.Max(),
                bottom = yList.Min(),
                top = yList.Max(),
                zNear = cam.nearClipPlane,
                zFar = cam.farClipPlane
            };

            // rect のはみ出てる部分は自動的に範囲内に収まるようなのでfrustrumでクリップする
            var rect = cam.rect;
            if (rect.xMin < 0f) frustum.left *= 0.5f / Mathf.Abs(rect.xMin - 0.5f);
            if (rect.xMax > 1f) frustum.right *= 0.5f / Mathf.Abs(rect.xMax - 0.5f);
            if (rect.yMin < 0f) frustum.bottom *= 0.5f / Mathf.Abs(rect.yMin - 0.5f);
            if (rect.yMax > 1f) frustum.top *= 0.5f / Mathf.Abs(rect.yMax - 0.5f);
            
            cam.projectionMatrix = Matrix4x4.Frustum(frustum);
        }

        public static Vector3 WorldPosToNearPos(Camera cam, Vector3 pos)
        {
            var posLocal = cam.worldToCameraMatrix.MultiplyPoint(pos);
            posLocal.z *= -1f; // worldToCameraMatrix is OpenGL coodinate : foward = z minus.
            var zRate = cam.nearClipPlane / posLocal.z;
            return posLocal * zRate;
        }
    }
}