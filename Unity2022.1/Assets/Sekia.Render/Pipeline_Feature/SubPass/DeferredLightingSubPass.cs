using UnityEngine;
using UnityEngine.Rendering;
using Unity.Collections;
using UnityEngine.Rendering.Universal;

namespace Sekia
{
    //[CreateAssetMenu(fileName = "DeferredLightingSubPass", menuName = "Rendering/DeferredLightingSubPass", order = 0)]
    public class DeferredLightingSubPass : SekiaSubPass
    {
        enum StencilDeferredPasses
        {
            PunctualLit,
            DirectionalLit,
            Fog
        };

        static NativeArray<ushort> m_stencilVisLights;
        static NativeArray<ushort> m_stencilVisLightOffsets;
        static Mesh m_SphereMesh; //点光
        static Mesh m_HemisphereMesh; //Spot光
        const float kStencilShapeGuard = 1.06067f; // stencil geometric shapes must be inflated to fit the analytic shapes.
        const ushort k_InvalidLightOffset = 0xFFFF;
        GlobalData ins;

        public override void Init()
        {
            //近似于半径为1的圆球 略微有些碰撞 比如有1.070f
            Mesh CreateSphereMesh()
            {
                Vector3[] positions =
                {
                new Vector3(0.000f,  0.000f, -1.070f), new Vector3(0.174f, -0.535f, -0.910f),
                new Vector3(-0.455f, -0.331f, -0.910f), new Vector3(0.562f,  0.000f, -0.910f),
                new Vector3(-0.455f,  0.331f, -0.910f), new Vector3(0.174f,  0.535f, -0.910f),
                new Vector3(-0.281f, -0.865f, -0.562f), new Vector3(0.736f, -0.535f, -0.562f),
                new Vector3(0.296f, -0.910f, -0.468f), new Vector3(-0.910f,  0.000f, -0.562f),
                new Vector3(-0.774f, -0.562f, -0.478f), new Vector3(0.000f, -1.070f,  0.000f),
                new Vector3(-0.629f, -0.865f,  0.000f), new Vector3(0.629f, -0.865f,  0.000f),
                new Vector3(-1.017f, -0.331f,  0.000f), new Vector3(0.957f,  0.000f, -0.478f),
                new Vector3(0.736f,  0.535f, -0.562f), new Vector3(1.017f, -0.331f,  0.000f),
                new Vector3(1.017f,  0.331f,  0.000f), new Vector3(-0.296f, -0.910f,  0.478f),
                new Vector3(0.281f, -0.865f,  0.562f), new Vector3(0.774f, -0.562f,  0.478f),
                new Vector3(-0.736f, -0.535f,  0.562f), new Vector3(0.910f,  0.000f,  0.562f),
                new Vector3(0.455f, -0.331f,  0.910f), new Vector3(-0.174f, -0.535f,  0.910f),
                new Vector3(0.629f,  0.865f,  0.000f), new Vector3(0.774f,  0.562f,  0.478f),
                new Vector3(0.455f,  0.331f,  0.910f), new Vector3(0.000f,  0.000f,  1.070f),
                new Vector3(-0.562f,  0.000f,  0.910f), new Vector3(-0.957f,  0.000f,  0.478f),
                new Vector3(0.281f,  0.865f,  0.562f), new Vector3(-0.174f,  0.535f,  0.910f),
                new Vector3(0.296f,  0.910f, -0.478f), new Vector3(-1.017f,  0.331f,  0.000f),
                new Vector3(-0.736f,  0.535f,  0.562f), new Vector3(-0.296f,  0.910f,  0.478f),
                new Vector3(0.000f,  1.070f,  0.000f), new Vector3(-0.281f,  0.865f, -0.562f),
                new Vector3(-0.774f,  0.562f, -0.478f), new Vector3(-0.629f,  0.865f,  0.000f),
            };

                int[] indices =
                {
                0,  1,  2,  0,  3,  1,  2,  4,  0,  0,  5,  3,  0,  4,  5,  1,  6,  2,
                3,  7,  1,  1,  8,  6,  1,  7,  8,  9,  4,  2,  2,  6, 10, 10,  9,  2,
                8, 11,  6,  6, 12, 10, 11, 12,  6,  7, 13,  8,  8, 13, 11, 10, 14,  9,
                10, 12, 14,  3, 15,  7,  5, 16,  3,  3, 16, 15, 15, 17,  7, 17, 13,  7,
                16, 18, 15, 15, 18, 17, 11, 19, 12, 13, 20, 11, 11, 20, 19, 17, 21, 13,
                13, 21, 20, 12, 19, 22, 12, 22, 14, 17, 23, 21, 18, 23, 17, 21, 24, 20,
                23, 24, 21, 20, 25, 19, 19, 25, 22, 24, 25, 20, 26, 18, 16, 18, 27, 23,
                26, 27, 18, 28, 24, 23, 27, 28, 23, 24, 29, 25, 28, 29, 24, 25, 30, 22,
                25, 29, 30, 14, 22, 31, 22, 30, 31, 32, 28, 27, 26, 32, 27, 33, 29, 28,
                30, 29, 33, 33, 28, 32, 34, 26, 16,  5, 34, 16, 14, 31, 35, 14, 35,  9,
                31, 30, 36, 30, 33, 36, 35, 31, 36, 37, 33, 32, 36, 33, 37, 38, 32, 26,
                34, 38, 26, 38, 37, 32,  5, 39, 34, 39, 38, 34,  4, 39,  5,  9, 40,  4,
                9, 35, 40,  4, 40, 39, 35, 36, 41, 41, 36, 37, 41, 37, 38, 40, 35, 41,
                40, 41, 39, 41, 38, 39,
            };


                Mesh mesh = new Mesh();
                mesh.indexFormat = IndexFormat.UInt16;
                mesh.vertices = positions;
                mesh.triangles = indices;
                mesh.hideFlags |= HideFlags.HideAndDontSave;
                mesh.UploadMeshData(true);

                return mesh;
            }

            //有盖的半球 盖子朝向Z负轴 半径为1 在顶点shader里进行略微膨胀
            Mesh CreateHemisphereMesh()
            {
                Vector3[] positions =
                {
                new Vector3(0.000000f, 0.000000f, 0.000000f), new Vector3(1.000000f, 0.000000f, 0.000000f),
                new Vector3(0.923880f, 0.382683f, 0.000000f), new Vector3(0.707107f, 0.707107f, 0.000000f),
                new Vector3(0.382683f, 0.923880f, 0.000000f), new Vector3(-0.000000f, 1.000000f, 0.000000f),
                new Vector3(-0.382684f, 0.923880f, 0.000000f), new Vector3(-0.707107f, 0.707107f, 0.000000f),
                new Vector3(-0.923880f, 0.382683f, 0.000000f), new Vector3(-1.000000f, -0.000000f, 0.000000f),
                new Vector3(-0.923880f, -0.382683f, 0.000000f), new Vector3(-0.707107f, -0.707107f, 0.000000f),
                new Vector3(-0.382683f, -0.923880f, 0.000000f), new Vector3(0.000000f, -1.000000f, 0.000000f),
                new Vector3(0.382684f, -0.923879f, 0.000000f), new Vector3(0.707107f, -0.707107f, 0.000000f),
                new Vector3(0.923880f, -0.382683f, 0.000000f), new Vector3(0.000000f, 0.000000f, 1.000000f),
                new Vector3(0.707107f, 0.000000f, 0.707107f), new Vector3(0.000000f, -0.707107f, 0.707107f),
                new Vector3(0.000000f, 0.707107f, 0.707107f), new Vector3(-0.707107f, 0.000000f, 0.707107f),
                new Vector3(0.816497f, -0.408248f, 0.408248f), new Vector3(0.408248f, -0.408248f, 0.816497f),
                new Vector3(0.408248f, -0.816497f, 0.408248f), new Vector3(0.408248f, 0.816497f, 0.408248f),
                new Vector3(0.408248f, 0.408248f, 0.816497f), new Vector3(0.816497f, 0.408248f, 0.408248f),
                new Vector3(-0.816497f, 0.408248f, 0.408248f), new Vector3(-0.408248f, 0.408248f, 0.816497f),
                new Vector3(-0.408248f, 0.816497f, 0.408248f), new Vector3(-0.408248f, -0.816497f, 0.408248f),
                new Vector3(-0.408248f, -0.408248f, 0.816497f), new Vector3(-0.816497f, -0.408248f, 0.408248f),
                new Vector3(0.000000f, -0.923880f, 0.382683f), new Vector3(0.923880f, 0.000000f, 0.382683f),
                new Vector3(0.000000f, -0.382683f, 0.923880f), new Vector3(0.382683f, 0.000000f, 0.923880f),
                new Vector3(0.000000f, 0.923880f, 0.382683f), new Vector3(0.000000f, 0.382683f, 0.923880f),
                new Vector3(-0.923880f, 0.000000f, 0.382683f), new Vector3(-0.382683f, 0.000000f, 0.923880f)
            };

                int[] indices =
                {
                0, 2, 1, 0, 3, 2, 0, 4, 3, 0, 5, 4, 0, 6, 5, 0,
                7, 6, 0, 8, 7, 0, 9, 8, 0, 10, 9, 0, 11, 10, 0, 12,
                11, 0, 13, 12, 0, 14, 13, 0, 15, 14, 0, 16, 15, 0, 1, 16,
                22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 14, 24, 34, 35,
                22, 16, 36, 23, 37, 2, 27, 35, 38, 25, 4, 37, 26, 39, 6, 30,
                38, 40, 28, 8, 39, 29, 41, 10, 33, 40, 34, 31, 12, 41, 32, 36,
                15, 22, 24, 18, 23, 22, 19, 24, 23, 3, 25, 27, 20, 26, 25, 18,
                27, 26, 7, 28, 30, 21, 29, 28, 20, 30, 29, 11, 31, 33, 19, 32,
                31, 21, 33, 32, 13, 14, 34, 15, 24, 14, 19, 34, 24, 1, 35, 16,
                18, 22, 35, 15, 16, 22, 17, 36, 37, 19, 23, 36, 18, 37, 23, 1,
                2, 35, 3, 27, 2, 18, 35, 27, 5, 38, 4, 20, 25, 38, 3, 4,
                25, 17, 37, 39, 18, 26, 37, 20, 39, 26, 5, 6, 38, 7, 30, 6,
                20, 38, 30, 9, 40, 8, 21, 28, 40, 7, 8, 28, 17, 39, 41, 20,
                29, 39, 21, 41, 29, 9, 10, 40, 11, 33, 10, 21, 40, 33, 13, 34,
                12, 19, 31, 34, 11, 12, 31, 17, 41, 36, 21, 32, 41, 19, 36, 32
            };

                Mesh mesh = new Mesh();
                mesh.indexFormat = IndexFormat.UInt16;
                mesh.vertices = positions;
                mesh.triangles = indices;
                mesh.hideFlags |= HideFlags.HideAndDontSave;
                mesh.UploadMeshData(true);

                return mesh;
            }

            ins = GlobalData.Instance;
            ins.m_StencilDeferredMaterial.SetFloat(GlobalData.ShaderPropertyIDs._StencilRef, (float)StencilUsage.MaterialLit);

            if (m_SphereMesh == null)
                m_SphereMesh = CreateSphereMesh();
            if (m_HemisphereMesh == null)
                m_HemisphereMesh = CreateHemisphereMesh();
        }

        #region Configure
        void PrecomputeLights(
            out NativeArray<ushort> stencilVisLights,
            out NativeArray<ushort> stencilVisLightOffsets,
            ref NativeArray<VisibleLight> visibleLights,
            bool hasAnylLights,
            int mainLightIndex)
        {
            const int lightTypeCount = (int)LightType.Disc + 1;

            if (!hasAnylLights)
            {
                stencilVisLights = new NativeArray<ushort>(0, Allocator.Temp, NativeArrayOptions.UninitializedMemory);
                stencilVisLightOffsets = new NativeArray<ushort>(lightTypeCount, Allocator.Temp, NativeArrayOptions.UninitializedMemory);
                for (int i = 0; i < lightTypeCount; ++i)
                    stencilVisLightOffsets[i] = k_InvalidLightOffset;
                return;
            }

            NativeArray<int> stencilLightCounts = new NativeArray<int>(lightTypeCount, Allocator.Temp, NativeArrayOptions.ClearMemory);
            stencilVisLightOffsets = new NativeArray<ushort>(lightTypeCount, Allocator.Temp, NativeArrayOptions.ClearMemory);

            // Count the number of lights per type.
            int visibleLightCount = visibleLights.Length;
            for (ushort visLightIndex = 0; visLightIndex < visibleLightCount; ++visLightIndex)
            {
                ref VisibleLight vl = ref visibleLights.UnsafeElementAtMutable(visLightIndex);
                ++stencilVisLightOffsets[(int)vl.lightType];
            }

            int totalStencilLightCount = stencilVisLightOffsets[(int)LightType.Spot] + stencilVisLightOffsets[(int)LightType.Directional] + stencilVisLightOffsets[(int)LightType.Point];
            stencilVisLights = new NativeArray<ushort>(totalStencilLightCount, Allocator.Temp, NativeArrayOptions.UninitializedMemory);

            for (int i = 0, soffset = 0; i < stencilVisLightOffsets.Length; ++i)
            {
                if (stencilVisLightOffsets[i] == 0)
                    stencilVisLightOffsets[i] = k_InvalidLightOffset;
                else
                {
                    int c = stencilVisLightOffsets[i];
                    stencilVisLightOffsets[i] = (ushort)soffset;
                    soffset += c;
                }
            }

            //将光源根据类型排序
            //m_stencilVisLightOffsets：index：LightType value：光源类型排序偏移
            //m_stencilVisLights：index：将光源根据类型排序 value：可见光源index
            //          例如：{平行光/平行光/点光/Spot光/Spot光/Spot光}
            //              平行光类型的偏移为0 点光类型的偏移为2
            //          存在主光源时 主光源永远在平行光队列的最前面
            if (mainLightIndex >= 0)
            {
                bool hasFindMainLight = false;
                for (ushort visLightIndex = 0; visLightIndex < visibleLightCount; ++visLightIndex)
                {
                    ref VisibleLight vl = ref visibleLights.UnsafeElementAtMutable(visLightIndex);
                    int i = stencilLightCounts[(int)vl.lightType]++;
                    if (!hasFindMainLight && vl.lightType == LightType.Directional && visLightIndex != mainLightIndex)
                        i++;
                    else if (vl.lightType == LightType.Directional && visLightIndex == mainLightIndex)
                    {
                        i = 0;
                        hasFindMainLight = true;
                    }
                    stencilVisLights[stencilVisLightOffsets[(int)vl.lightType] + i] = visLightIndex;
                }
            }
            else
            {
                for (ushort visLightIndex = 0; visLightIndex < visibleLightCount; ++visLightIndex)
                {
                    ref VisibleLight vl = ref visibleLights.UnsafeElementAtMutable(visLightIndex);
                    int i = stencilLightCounts[(int)vl.lightType]++;
                    stencilVisLights[stencilVisLightOffsets[(int)vl.lightType] + i] = visLightIndex;
                }
            }

            stencilLightCounts.Dispose();
        }

        void SetupMainLightConstants(CommandBuffer cmd, ref LightData lightData)
        {
            if (lightData.mainLightIndex < 0)
                return;

            Vector4 lightPos, lightColor, lightAttenuation, lightSpotDir, lightOcclusionChannel;
            UniversalRenderPipeline.InitializeLightConstants_Common(lightData.visibleLights, lightData.mainLightIndex, out lightPos, out lightColor, out lightAttenuation, out lightSpotDir, out lightOcclusionChannel);

            cmd.SetGlobalVector(GlobalData.ShaderPropertyIDs._MainLightPosition, lightPos);
            cmd.SetGlobalVector(GlobalData.ShaderPropertyIDs._MainLightColor, lightColor);
        }

        //NDC到世界空间矩阵
        void SetupMatrixConstants(CommandBuffer cmd, ref RenderingData renderingData)
        {
            ref CameraData cameraData = ref renderingData.cameraData;
            var desc = cameraData.cameraTargetDescriptor;

            Matrix4x4 proj = cameraData.projectionMatrix;
            Matrix4x4 view = cameraData.viewMatrix;

            //如果渲染到中间RT 不反转Y
            //如果渲染到backBuffer 反转Y
            //片元shader中i.positionCS.xy语义根据目标RT是否为backBuffer变化
            //  目标RT为backBuffer时 左上角为0
            //  目标RT为RenderTexture时 基于DX平台P矩阵发生Y反转 左下角为0
            Matrix4x4 gpuProj = GL.GetGPUProjectionMatrix(proj, !cameraData.isTargetFlipped);

            // xy coordinates in range [-1; 1] go to pixel coordinates.
            Matrix4x4 toScreen = new Matrix4x4(
                new Vector4(0.5f * desc.width, 0.0f, 0.0f, 0.0f),
                new Vector4(0.0f, 0.5f * desc.height, 0.0f, 0.0f),
                new Vector4(0.0f, 0.0f, 1.0f, 0.0f),
                new Vector4(0.5f * desc.width, 0.5f * desc.height, 0.0f, 1.0f)
            );

            Matrix4x4 zScaleBias = Matrix4x4.identity;
            if (ins.IsGLDevice)
            {
                // We need to manunally adjust z in NDC space from [-1; 1] to [0; 1] (storage in depth texture).
                zScaleBias = new Matrix4x4(
                    new Vector4(1.0f, 0.0f, 0.0f, 0.0f),
                    new Vector4(0.0f, 1.0f, 0.0f, 0.0f),
                    new Vector4(0.0f, 0.0f, 0.5f, 0.0f),
                    new Vector4(0.0f, 0.0f, 0.5f, 1.0f)
                );
            }

            Matrix4x4 screenToWorld = Matrix4x4.Inverse(toScreen * zScaleBias * gpuProj * view);

            cmd.SetGlobalMatrix(GlobalData.ShaderPropertyIDs._ScreenToWorld, screenToWorld);
        }
        #endregion

        public void Configure(ScriptableRenderContext context, ref RenderingData renderingData)
        {
            ref CameraData cameraData = ref renderingData.cameraData;
            var cmd = renderingData.commandBuffer;
            using var profScope = new ProfilingScope(cmd, GlobalData.Profiling.TryGetOrAddSampler("SubPass.DeferredLighting"));

            PrecomputeLights(
                out m_stencilVisLights,
                out m_stencilVisLightOffsets,
                ref renderingData.lightData.visibleLights,
                renderingData.lightData.additionalLightsCount != 0 || renderingData.lightData.mainLightIndex >= 0,
                renderingData.lightData.mainLightIndex);

            SetupMainLightConstants(cmd, ref renderingData.lightData);

            SetupMatrixConstants(cmd, ref renderingData);

            profScope.Dispose();
            context.ExecuteCommandBuffer(cmd);
            cmd.Clear();
        }

        #region Lighting
        void RenderStencilLights(ScriptableRenderContext context, CommandBuffer cmd, ref RenderingData renderingData)
        {
            if (m_stencilVisLights.Length == 0)
                return;

            NativeArray<VisibleLight> visibleLights = renderingData.lightData.visibleLights;

            if (HasStencilLightsOfType(LightType.Directional))
                RenderStencilDirectionalLights(context, cmd, ref renderingData, visibleLights);
            if (HasStencilLightsOfType(LightType.Point))
                RenderStencilPointLights(context, cmd, ref renderingData, visibleLights);
            if (HasStencilLightsOfType(LightType.Spot))
                RenderStencilSpotLights(context, cmd, ref renderingData, visibleLights);
        }

        bool HasStencilLightsOfType(LightType type)
        {
            return m_stencilVisLightOffsets[(int)type] != k_InvalidLightOffset;
        }

        void RenderStencilDirectionalLights(ScriptableRenderContext context, CommandBuffer cmd, ref RenderingData renderingData, NativeArray<VisibleLight> visibleLights)
        {
            using var profScope = new ProfilingScope(cmd, GlobalData.Profiling.TryGetOrAddSampler("SubPass.DirectionalLights"));

            cmd.EnableShaderKeyword(GlobalData.ShaderKeywordStrings._DIRECTIONAL);
            bool isFirstLight = true;

            for (int soffset = m_stencilVisLightOffsets[(int)LightType.Directional]; soffset < m_stencilVisLights.Length; ++soffset)
            {
                ushort visLightIndex = m_stencilVisLights[soffset];

                ref VisibleLight vl = ref visibleLights.UnsafeElementAtMutable(visLightIndex);
                if (vl.lightType != LightType.Directional)
                    break;
                Light light = vl.light;

                Vector4 lightDir, lightColor, lightAttenuation, lightSpotDir, lightOcclusionChannel;
                UniversalRenderPipeline.InitializeLightConstants_Common(visibleLights, visLightIndex,
                    out lightDir, out lightColor, out lightAttenuation, out lightSpotDir, out lightOcclusionChannel);

                //延迟渲染实际上没有额外光源概念
                //非主光源采样阴影时根据shadowLightIndex寻找额外光源阴影ShadowMap
                bool hasDeferredShadows;
                if (isFirstLight)
                {
                    hasDeferredShadows = light && light.shadows != LightShadows.None;
                    CoreUtils.SetKeyword(cmd, ShaderKeywordStrings.AdditionalLightShadows, false);
                }
                else
                {
                    int shadowLightIndex = -1;// m_AdditionalLightsShadowCasterPass != null ? m_AdditionalLightsShadowCasterPass.GetShadowLightIndexFromLightIndex(visLightIndex) : -1;
                    hasDeferredShadows = light && light.shadows != LightShadows.None && shadowLightIndex >= 0;
                    CoreUtils.SetKeyword(cmd, ShaderKeywordStrings.AdditionalLightShadows, hasDeferredShadows);
                    cmd.SetGlobalInt(GlobalData.ShaderPropertyIDs._ShadowLightIndex, shadowLightIndex);
                }

                bool hasSoftShadow = hasDeferredShadows && renderingData.shadowData.supportsSoftShadows && light.shadows == LightShadows.Soft;
                CoreUtils.SetKeyword(cmd, GlobalData.ShaderKeywordStrings._SHADOWS_SOFT, hasSoftShadow);
                //第一个平行光是主光源 处理环境光和SSAO
                CoreUtils.SetKeyword(cmd, GlobalData.ShaderKeywordStrings._DEFERRED_FIRST_LIGHT, isFirstLight);

                cmd.SetGlobalVector(GlobalData.ShaderPropertyIDs._LightColor, lightColor); // VisibleLight.finalColor already returns color in active color space
                cmd.SetGlobalVector(GlobalData.ShaderPropertyIDs._LightDirection, lightDir);

                // Lighting pass.
                cmd.DrawMesh(ins.triangleMesh, Matrix4x4.identity, ins.m_StencilDeferredMaterial, 0, (int)StencilDeferredPasses.DirectionalLit);

                isFirstLight = false;
            }

            cmd.DisableShaderKeyword(GlobalData.ShaderKeywordStrings._DIRECTIONAL);

            profScope.Dispose();
            context.ExecuteCommandBuffer(cmd);
            cmd.Clear();
        }

        void RenderStencilPointLights(ScriptableRenderContext context, CommandBuffer cmd, ref RenderingData renderingData, NativeArray<VisibleLight> visibleLights)
        {
            using var profScope = new ProfilingScope(cmd, GlobalData.Profiling.TryGetOrAddSampler("SubPass.PointLights"));

            cmd.EnableShaderKeyword(GlobalData.ShaderKeywordStrings._POINT);

            for (int soffset = m_stencilVisLightOffsets[(int)LightType.Point]; soffset < m_stencilVisLights.Length; ++soffset)
            {
                ushort visLightIndex = m_stencilVisLights[soffset];
                ref VisibleLight vl = ref visibleLights.UnsafeElementAtMutable(visLightIndex);
                if (vl.lightType != LightType.Point)
                    break;

                Light light = vl.light;

                Vector3 posWS = vl.localToWorldMatrix.GetColumn(3);
                Matrix4x4 transformMatrix = new Matrix4x4(
                    new Vector4(vl.range, 0.0f, 0.0f, 0.0f),
                    new Vector4(0.0f, vl.range, 0.0f, 0.0f),
                    new Vector4(0.0f, 0.0f, vl.range, 0.0f),
                    new Vector4(posWS.x, posWS.y, posWS.z, 1.0f)
                );

                Vector4 lightPos, lightColor, lightAttenuation, lightSpotDir, lightOcclusionChannel;
                UniversalRenderPipeline.InitializeLightConstants_Common(visibleLights, visLightIndex,
                    out lightPos, out lightColor, out lightAttenuation, out lightSpotDir, out lightOcclusionChannel);

                int shadowLightIndex = -1; //m_AdditionalLightsShadowCasterPass != null ? m_AdditionalLightsShadowCasterPass.GetShadowLightIndexFromLightIndex(visLightIndex) : -1;
                bool hasDeferredLightShadows = light && light.shadows != LightShadows.None && shadowLightIndex >= 0;
                bool hasSoftShadow = hasDeferredLightShadows && renderingData.shadowData.supportsSoftShadows && light.shadows == LightShadows.Soft;

                CoreUtils.SetKeyword(cmd, ShaderKeywordStrings.AdditionalLightShadows, hasDeferredLightShadows);
                CoreUtils.SetKeyword(cmd, ShaderKeywordStrings.SoftShadows, hasSoftShadow);

                cmd.SetGlobalVector(GlobalData.ShaderPropertyIDs._LightPosWS, lightPos);
                cmd.SetGlobalVector(GlobalData.ShaderPropertyIDs._LightColor, lightColor);
                cmd.SetGlobalVector(GlobalData.ShaderPropertyIDs._LightAttenuation, lightAttenuation);
                cmd.SetGlobalVector(GlobalData.ShaderPropertyIDs._LightOcclusionProbInfo, lightOcclusionChannel);
                cmd.SetGlobalInt(GlobalData.ShaderPropertyIDs._ShadowLightIndex, shadowLightIndex);

                // Lighting pass.
                cmd.DrawMesh(m_SphereMesh, transformMatrix, ins.m_StencilDeferredMaterial, 0, (int)StencilDeferredPasses.PunctualLit);
            }

            cmd.DisableShaderKeyword(GlobalData.ShaderKeywordStrings._POINT);

            profScope.Dispose();
            context.ExecuteCommandBuffer(cmd);
            cmd.Clear();
        }

        void RenderStencilSpotLights(ScriptableRenderContext context, CommandBuffer cmd, ref RenderingData renderingData, NativeArray<VisibleLight> visibleLights)
        {
            using var profScope = new ProfilingScope(cmd, GlobalData.Profiling.TryGetOrAddSampler("SubPass.SpotLights"));

            cmd.EnableShaderKeyword(GlobalData.ShaderKeywordStrings._SPOT);

            for (int soffset = m_stencilVisLightOffsets[(int)LightType.Spot]; soffset < m_stencilVisLights.Length; ++soffset)
            {
                ushort visLightIndex = m_stencilVisLights[soffset];
                ref VisibleLight vl = ref visibleLights.UnsafeElementAtMutable(visLightIndex);
                if (vl.lightType != LightType.Spot)
                    break;

                Light light = vl.light;

                float alpha = Mathf.Deg2Rad * vl.spotAngle * 0.5f;
                float cosAlpha = Mathf.Cos(alpha);
                float sinAlpha = Mathf.Sin(alpha);
                // Artificially inflate the geometric shape to fit the analytic spot shape.
                // The tighter the spot shape, the lesser inflation is needed.
                float guard = Mathf.Lerp(1.0f, kStencilShapeGuard, sinAlpha);

                Vector4 lightPos, lightColor, lightAttenuation, lightSpotDir, lightOcclusionChannel;
                UniversalRenderPipeline.InitializeLightConstants_Common(visibleLights, visLightIndex, out lightPos, out lightColor, out lightAttenuation, out lightSpotDir, out lightOcclusionChannel);

                int shadowLightIndex = -1; //m_AdditionalLightsShadowCasterPass != null ? m_AdditionalLightsShadowCasterPass.GetShadowLightIndexFromLightIndex(visLightIndex) : -1;
                bool hasDeferredLightShadows = light && light.shadows != LightShadows.None && shadowLightIndex >= 0;
                bool hasSoftShadow = hasDeferredLightShadows && renderingData.shadowData.supportsSoftShadows && light.shadows == LightShadows.Soft;

                CoreUtils.SetKeyword(cmd, ShaderKeywordStrings.AdditionalLightShadows, hasDeferredLightShadows);
                CoreUtils.SetKeyword(cmd, ShaderKeywordStrings.SoftShadows, hasSoftShadow);

                cmd.SetGlobalVector(GlobalData.ShaderPropertyIDs._SpotLightScale, new Vector4(sinAlpha, sinAlpha, 1.0f - cosAlpha, vl.range));
                cmd.SetGlobalVector(GlobalData.ShaderPropertyIDs._SpotLightBias, new Vector4(0.0f, 0.0f, cosAlpha, 0.0f));
                cmd.SetGlobalVector(GlobalData.ShaderPropertyIDs._SpotLightGuard, new Vector4(guard, guard, guard, cosAlpha * vl.range));
                cmd.SetGlobalVector(GlobalData.ShaderPropertyIDs._LightPosWS, lightPos);
                cmd.SetGlobalVector(GlobalData.ShaderPropertyIDs._LightColor, lightColor);
                cmd.SetGlobalVector(GlobalData.ShaderPropertyIDs._LightAttenuation, lightAttenuation);
                cmd.SetGlobalVector(GlobalData.ShaderPropertyIDs._LightDirection, new Vector3(lightSpotDir.x, lightSpotDir.y, lightSpotDir.z));
                cmd.SetGlobalVector(GlobalData.ShaderPropertyIDs._LightOcclusionProbInfo, lightOcclusionChannel);
                cmd.SetGlobalInt(GlobalData.ShaderPropertyIDs._ShadowLightIndex, shadowLightIndex);

                // Lighting pass.
                cmd.DrawMesh(m_HemisphereMesh, vl.localToWorldMatrix, ins.m_StencilDeferredMaterial, 0, (int)StencilDeferredPasses.PunctualLit);
            }

            cmd.DisableShaderKeyword(GlobalData.ShaderKeywordStrings._SPOT);

            profScope.Dispose();
            context.ExecuteCommandBuffer(cmd);
            cmd.Clear();
        }

        void RenderFog(ScriptableRenderContext context, CommandBuffer cmd, ref RenderingData renderingData)
        {
            // Legacy fog does not work in orthographic mode.
            if (!RenderSettings.fog || renderingData.cameraData.camera.orthographic)
                return;

            // Fog parameters and shader variant keywords are already set externally.
            using var profScope = new ProfilingScope(cmd, GlobalData.Profiling.TryGetOrAddSampler("SubPass.Fog"));
            cmd.DrawMesh(ins.triangleMesh, Matrix4x4.identity, ins.m_StencilDeferredMaterial, 0, (int)StencilDeferredPasses.Fog);
            profScope.Dispose();
            context.ExecuteCommandBuffer(cmd);
            cmd.Clear();
        }

        void RenderSkybox(ScriptableRenderContext context, ref RenderingData renderingData)
        {
            Camera camera = renderingData.cameraData.camera;
            if (camera.clearFlags != CameraClearFlags.Skybox ||
                renderingData.cameraData.renderType != CameraRenderType.Base)
                return;

            if (RenderSettings.skybox != null ||
                (camera.TryGetComponent(out Skybox cameraSkybox) && cameraSkybox.material != null))
            {
                context.DrawSkybox(camera);
            }
        }
        #endregion

        public override void ExecuteSubPass(ScriptableRenderContext context, ref RenderingData renderingData)
        {
            Configure(context, ref renderingData);

            ref CameraData cameraData = ref renderingData.cameraData;
            var cmd = renderingData.commandBuffer;
            using var profScope = new ProfilingScope(cmd, GlobalData.Profiling.TryGetOrAddSampler("SubPass.DeferredLighting"));

            RenderStencilLights(context, cmd, ref renderingData);

            RenderFog(context, cmd, ref renderingData); //线性雾

            //恢复前向渲染相关的关键字
            CoreUtils.SetKeyword(cmd, GlobalData.ShaderKeywordStrings._ADDITIONAL_LIGHT_SHADOWS, renderingData.shadowData.isKeywordAdditionalLightShadowsEnabled);
            CoreUtils.SetKeyword(cmd, GlobalData.ShaderKeywordStrings._SHADOWS_SOFT, renderingData.shadowData.isKeywordSoftShadowsEnabled);

            if (m_stencilVisLights.IsCreated)
                m_stencilVisLights.Dispose();
            if (m_stencilVisLightOffsets.IsCreated)
                m_stencilVisLightOffsets.Dispose();

            profScope.Dispose();
            context.ExecuteCommandBuffer(cmd);
            cmd.Clear();

            RenderSkybox(context, ref renderingData);
        }
    }
}
