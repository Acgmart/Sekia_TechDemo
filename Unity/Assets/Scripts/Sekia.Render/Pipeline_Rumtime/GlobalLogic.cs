
using UnityEngine;
using UnityEngine.Rendering;
using System;
using System.Collections.Generic;
using UnityEngine.Rendering.Universal;
using UnityEngine.Rendering.Universal.Internal;

namespace Sekia
{
    public static class GlobalLogic
    {
        public static ClearFlag GetCameraClearFlag(ref CameraData cameraData)
        {
            var cameraClearFlags = cameraData.camera.clearFlags;
            if (cameraData.renderType == CameraRenderType.Overlay)
                return (cameraData.clearDepth) ? ClearFlag.DepthStencil : ClearFlag.None;

            if (cameraClearFlags == CameraClearFlags.Skybox && RenderSettings.skybox != null)
                return ClearFlag.DepthStencil;

            return ClearFlag.All;
        }

        public static void SetCameraMatrices(CommandBuffer cmd, ref CameraData cameraData, bool setInverseMatrices, bool isTargetFlipped)
        {
            Matrix4x4 viewMatrix = cameraData.GetViewMatrix();
            Matrix4x4 projectionMatrix = cameraData.GetProjectionMatrix();

            // TODO: Investigate why SetViewAndProjectionMatrices is causing y-flip / winding order issue
            // for now using cmd.SetViewProjecionMatrices
            //SetViewAndProjectionMatrices(cmd, viewMatrix, cameraData.GetDeviceProjectionMatrix(), setInverseMatrices);
            cmd.SetViewProjectionMatrices(viewMatrix, projectionMatrix);

            if (setInverseMatrices)
            {
                Matrix4x4 gpuProjectionMatrix = cameraData.GetGPUProjectionMatrix(isTargetFlipped);
                Matrix4x4 viewAndProjectionMatrix = gpuProjectionMatrix * viewMatrix;
                Matrix4x4 inverseViewMatrix = Matrix4x4.Inverse(viewMatrix);
                Matrix4x4 inverseProjectionMatrix = Matrix4x4.Inverse(gpuProjectionMatrix);
                Matrix4x4 inverseViewProjection = inverseViewMatrix * inverseProjectionMatrix;

                // There's an inconsistency in handedness between unity_matrixV and unity_WorldToCamera
                // Unity changes the handedness of unity_WorldToCamera (see Camera::CalculateMatrixShaderProps)
                // we will also change it here to avoid breaking existing shaders. (case 1257518)
                Matrix4x4 worldToCameraMatrix = Matrix4x4.Scale(new Vector3(1.0f, 1.0f, -1.0f)) * viewMatrix;
                Matrix4x4 cameraToWorldMatrix = worldToCameraMatrix.inverse;
                cmd.SetGlobalMatrix(ShaderPropertyId.worldToCameraMatrix, worldToCameraMatrix);
                cmd.SetGlobalMatrix(ShaderPropertyId.cameraToWorldMatrix, cameraToWorldMatrix);

                cmd.SetGlobalMatrix(ShaderPropertyId.inverseViewMatrix, inverseViewMatrix);
                cmd.SetGlobalMatrix(ShaderPropertyId.inverseProjectionMatrix, inverseProjectionMatrix);
                cmd.SetGlobalMatrix(ShaderPropertyId.inverseViewAndProjectionMatrix, inverseViewProjection);
            }

            // TODO: Add SetPerCameraClippingPlaneProperties here once we are sure it correctly behaves in overlay camera for some time
        }

        public static void SetPerCameraShaderVariables(CommandBuffer cmd, ref CameraData cameraData)
        {
            using var profScope = new ProfilingScope(null, GlobalData.Profiling.setPerCameraShaderVariables);
            {
                bool isTargetFlipped = cameraData.IsCameraProjectionMatrixFlipped();
                Camera camera = cameraData.camera;

                float scaledCameraWidth = (float)cameraData.cameraTargetDescriptor.width;
                float scaledCameraHeight = (float)cameraData.cameraTargetDescriptor.height;
                float cameraWidth = (float)camera.pixelWidth;
                float cameraHeight = (float)camera.pixelHeight;

                if (camera.allowDynamicResolution)
                {
                    scaledCameraWidth *= ScalableBufferManager.widthScaleFactor;
                    scaledCameraHeight *= ScalableBufferManager.heightScaleFactor;
                }

                float near = camera.nearClipPlane;
                float far = camera.farClipPlane;
                float invNear = Mathf.Approximately(near, 0.0f) ? 0.0f : 1.0f / near;
                float invFar = Mathf.Approximately(far, 0.0f) ? 0.0f : 1.0f / far;
                float isOrthographic = camera.orthographic ? 1.0f : 0.0f;

                // From http://www.humus.name/temp/Linearize%20depth.txt
                // But as depth component textures on OpenGL always return in 0..1 range (as in D3D), we have to use
                // the same constants for both D3D and OpenGL here.
                // OpenGL would be this:
                // zc0 = (1.0 - far / near) / 2.0;
                // zc1 = (1.0 + far / near) / 2.0;
                // D3D is this:
                float zc0 = 1.0f - far * invNear;
                float zc1 = far * invNear;

                Vector4 zBufferParams = new Vector4(zc0, zc1, zc0 * invFar, zc1 * invFar);

                if (SystemInfo.usesReversedZBuffer)
                {
                    zBufferParams.y += zBufferParams.x;
                    zBufferParams.x = -zBufferParams.x;
                    zBufferParams.w += zBufferParams.z;
                    zBufferParams.z = -zBufferParams.z;
                }

                // Projection flip sign logic is very deep in GfxDevice::SetInvertProjectionMatrix
                // This setup is tailored especially for overlay camera game view
                // For other scenarios this will be overwritten correctly by SetupCameraProperties
                float projectionFlipSign = isTargetFlipped ? -1.0f : 1.0f;
                Vector4 projectionParams = new Vector4(projectionFlipSign, near, far, 1.0f * invFar);
                cmd.SetGlobalVector(ShaderPropertyId.projectionParams, projectionParams);

                Vector4 orthoParams = new Vector4(camera.orthographicSize * cameraData.aspectRatio, camera.orthographicSize, 0.0f, isOrthographic);

                // Camera and Screen variables as described in https://docs.unity3d.com/Manual/SL-UnityShaderVariables.html
                cmd.SetGlobalVector(ShaderPropertyId.worldSpaceCameraPos, cameraData.worldSpaceCameraPos);
                cmd.SetGlobalVector(ShaderPropertyId.screenParams, new Vector4(cameraWidth, cameraHeight, 1.0f + 1.0f / cameraWidth, 1.0f + 1.0f / cameraHeight));
                cmd.SetGlobalVector(ShaderPropertyId.scaledScreenParams, new Vector4(scaledCameraWidth, scaledCameraHeight, 1.0f + 1.0f / scaledCameraWidth, 1.0f + 1.0f / scaledCameraHeight));
                cmd.SetGlobalVector(ShaderPropertyId.zBufferParams, zBufferParams);
                cmd.SetGlobalVector(ShaderPropertyId.orthoParams, orthoParams);

                cmd.SetGlobalVector(ShaderPropertyId.screenSize, new Vector4(cameraWidth, cameraHeight, 1.0f / cameraWidth, 1.0f / cameraHeight));
                CoreUtils.SetKeyword(cmd, ShaderKeywordStrings.SCREEN_COORD_OVERRIDE, cameraData.useScreenCoordOverride);
                cmd.SetGlobalVector(ShaderPropertyId.screenSizeOverride, cameraData.screenSizeOverride);
                cmd.SetGlobalVector(ShaderPropertyId.screenCoordScaleBias, cameraData.screenCoordScaleBias);

                // Calculate a bias value which corrects the mip lod selection logic when image scaling is active.
                // We clamp this value to 0.0 or less to make sure we don't end up reducing image detail in the downsampling case.
                float mipBias = Math.Min((float)-Math.Log(cameraWidth / scaledCameraWidth, 2.0f), 0.0f);
                cmd.SetGlobalVector(ShaderPropertyId.globalMipBias, new Vector2(mipBias, Mathf.Pow(2.0f, mipBias)));

                //Set per camera matrices.
                SetCameraMatrices(cmd, ref cameraData, true, isTargetFlipped);
            }
        }

        public static bool CheckPostProcessForDepth(ref CameraData cameraData)
        {
            if (!cameraData.postProcessEnabled)
                return false;

            if (cameraData.antialiasing == AntialiasingMode.SubpixelMorphologicalAntiAliasing && cameraData.renderType == CameraRenderType.Base)
                return true;

            return CheckPostProcessForDepth();
        }

        public static bool CheckPostProcessForDepth()
        {
            var stack = VolumeManager.instance.stack;

            if (stack.GetComponent<DepthOfField>().IsActive())
                return true;

            if (stack.GetComponent<MotionBlur>().IsActive())
                return true;

            return false;
        }

        public static void FinalBlit(
            CommandBuffer cmd,
            ref CameraData cameraData,
            RTHandle source,
            RTHandle destination,
            RenderBufferLoadAction loadAction,
            RenderBufferStoreAction storeAction,
            Material material, int passIndex)
        {
            bool isRenderToBackBufferTarget = !cameraData.isSceneViewCamera;

            Vector2 viewportScale = source.useScaling ? new Vector2(source.rtHandleProperties.rtHandleScale.x, source.rtHandleProperties.rtHandleScale.y) : Vector2.one;

            // We y-flip if
            // 1) we are blitting from render texture to back buffer(UV starts at bottom) and
            // 2) renderTexture starts UV at top
            bool yflip = isRenderToBackBufferTarget && cameraData.targetTexture == null && SystemInfo.graphicsUVStartsAtTop;
            Vector4 scaleBias = yflip ? new Vector4(viewportScale.x, -viewportScale.y, 0, viewportScale.y) : new Vector4(viewportScale.x, viewportScale.y, 0, 0);
            CoreUtils.SetRenderTarget(cmd, destination, loadAction, storeAction, ClearFlag.None, Color.clear);
            if (isRenderToBackBufferTarget)
                cmd.SetViewport(cameraData.pixelRect);

            if (source.rt == null)
                Blitter.BlitTexture(cmd, source.nameID, scaleBias, material, passIndex);  // Obsolete usage of RTHandle aliasing a RenderTargetIdentifier
            else
                Blitter.BlitTexture(cmd, source, scaleBias, material, passIndex);
        }

        public static DrawingSettings CreateDrawingSettings(ShaderTagId shaderTagId, ref RenderingData renderingData, SortingCriteria sortingCriteria)
        {
            Camera camera = renderingData.cameraData.camera;
            SortingSettings sortingSettings = new SortingSettings(camera) { criteria = sortingCriteria };
            DrawingSettings settings = new DrawingSettings(shaderTagId, sortingSettings)
            {
                perObjectData = renderingData.perObjectData,
                mainLightIndex = renderingData.lightData.mainLightIndex,
                enableDynamicBatching = renderingData.supportsDynamicBatching,

                // Disable instancing for preview cameras. This is consistent with the built-in forward renderer. Also fixes case 1127324.
                enableInstancing = camera.cameraType == CameraType.Preview ? false : true,
            };
            return settings;
        }

        public static DrawingSettings CreateDrawingSettings(List<ShaderTagId> shaderTagIdList,
            ref RenderingData renderingData, SortingCriteria sortingCriteria)
        {
            if (shaderTagIdList == null || shaderTagIdList.Count == 0)
            {
                Debug.LogWarning("ShaderTagId list is invalid. DrawingSettings is created with default pipeline ShaderTagId");
                return CreateDrawingSettings(new ShaderTagId("UniversalPipeline"), ref renderingData, sortingCriteria);
            }

            DrawingSettings settings = CreateDrawingSettings(shaderTagIdList[0], ref renderingData, sortingCriteria);
            for (int i = 1; i < shaderTagIdList.Count; ++i)
                settings.SetShaderPassName(i, shaderTagIdList[i]);
            return settings;
        }
        //-----------------------------------------------------------------------------------------------------------------------------------------------------------------
    }
}
