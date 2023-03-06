using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using UnityEngine.Assertions;
using UnityEngine.Rendering;
using UnityEngine.Events;

namespace Fluid
{
    public struct GPUThreads
    {
        public int x;
        public int y;
        public int z;

        public GPUThreads(uint x, uint y, uint z)
        {
            this.x = (int)x;
            this.y = (int)y;
            this.z = (int)z;
        }
    }

    public static class DirectCompute5_0
    {
        //Use DirectCompute 5.0 on DirectX11 hardware.
        public const int MAX_THREAD = 1024;
        public const int MAX_X = 1024;
        public const int MAX_Y = 1024;
        public const int MAX_Z = 64;
        public const int MAX_DISPATCH = 65535;
        public const int MAX_PROCESS = MAX_DISPATCH * MAX_THREAD;
    }

    public class Solver : MonoBehaviour
    {
        #region Variables

        protected enum ComputeKernels
        {
            AddSourceDensity,
            DiffuseDensity,
            AdvectDensity,
            AdvectDensityFromExt,
            SwapDensity,

            AddSourceVelocity,
            DiffuseVelocity,
            SwapVelocity,
            ProjectStep1,
            ProjectStep2,

            Draw
        }

        Dictionary<ComputeKernels, int> kernelMap = new Dictionary<ComputeKernels, int>();
        GPUThreads gpuThreads;
        RenderTexture solverTex;
        RenderTexture densityTex;
        RenderTexture velocityTex;
        RenderTexture prevTex;
        string solverProp = "solver";
        string densityProp = "density";
        string velocityProp = "velocity";
        string prevProp = "prev";
        string sourceProp = "source";
        string diffProp = "diff";
        string viscProp = "visc";
        string dtProp = "dt";
        string velocityCoefProp = "velocityCoef";
        string densityCoefProp = "densityCoef";
        int solverId, densityId, velocityId, prevId, sourceId, diffId, viscId, dtId, velocityCoefId, densityCoefId, solverTexId;
        int width, height;


        [SerializeField]
        ComputeShader computeShader = null;

        [SerializeField]
        string solverTexProp = "SolverTex";

        [SerializeField]
        float diff = 10f;

        [SerializeField]
        float visc = 100f;

        [SerializeField]
        float velocityCoef = 4f;

        [SerializeField]
        float densityCoef = 6f;

        [SerializeField]
        bool isDensityOnly = false;

        [SerializeField]
        int lod = 0;

        [SerializeField] RenderTexture sourceTex;
        public RenderTexture SorceTex { set { sourceTex = value; } get { return sourceTex; } }

        public TextureEvent textureBinding;

        #endregion

        #region unity builtin

        void Start()
        {
            Initialize();
        }

        void Update()
        {
            if (width != Screen.width || height != Screen.height) InitializeComputeShader();
            computeShader.SetFloat(diffId, diff);
            computeShader.SetFloat(viscId, visc);
            computeShader.SetFloat(diffId, diff);
            computeShader.SetFloat(viscId, visc);
            computeShader.SetFloat(dtId, Time.deltaTime);
            computeShader.SetFloat(velocityCoefId, velocityCoef);
            computeShader.SetFloat(densityCoefId, densityCoef);

            if (!isDensityOnly) VelocityStep();
            DensityStep();

            computeShader.SetTexture(kernelMap[ComputeKernels.Draw], densityId, densityTex);
            computeShader.SetTexture(kernelMap[ComputeKernels.Draw], velocityId, velocityTex);
            computeShader.SetTexture(kernelMap[ComputeKernels.Draw], solverId, solverTex);
            computeShader.Dispatch(kernelMap[ComputeKernels.Draw], Mathf.CeilToInt((float)solverTex.width / gpuThreads.x), Mathf.CeilToInt((float)solverTex.height / gpuThreads.y), 1);

            textureBinding.Invoke(solverTex);
        }

        void OnDestroy()
        {
            CleanUp();
        }

        #endregion

        #region Initialize

        void Initialize()
        {
            uint threadX, threadY, threadZ;

            InitialCheck();

            kernelMap = System.Enum.GetValues(typeof(ComputeKernels))
                .Cast<ComputeKernels>()
                .ToDictionary(t => t, t => computeShader.FindKernel(t.ToString()));

            computeShader.GetKernelThreadGroupSizes(kernelMap[ComputeKernels.Draw], out threadX, out threadY, out threadZ);

            gpuThreads = new GPUThreads(threadX, threadY, threadZ);
            solverTexId = Shader.PropertyToID(solverTexProp);

            solverId = Shader.PropertyToID(solverProp);
            densityId = Shader.PropertyToID(densityProp);
            velocityId = Shader.PropertyToID(velocityProp);
            prevId = Shader.PropertyToID(prevProp);
            sourceId = Shader.PropertyToID(sourceProp);
            diffId = Shader.PropertyToID(diffProp);
            viscId = Shader.PropertyToID(viscProp);
            dtId = Shader.PropertyToID(dtProp);
            velocityCoefId = Shader.PropertyToID(velocityCoefProp);
            densityCoefId = Shader.PropertyToID(densityCoefProp);

            InitializeComputeShader();
        }

        void InitialCheck()
        {
            Assert.IsTrue(SystemInfo.graphicsShaderLevel >= 50, "Under the DirectCompute5.0 (DX11 GPU) doesn't work : StableFluid");
            Assert.IsTrue(gpuThreads.x * gpuThreads.y * gpuThreads.z <= DirectCompute5_0.MAX_PROCESS, "Resolution is too heigh : Stablefluid");
            Assert.IsTrue(gpuThreads.x <= DirectCompute5_0.MAX_X, "THREAD_X is too large : StableFluid");
            Assert.IsTrue(gpuThreads.y <= DirectCompute5_0.MAX_Y, "THREAD_Y is too large : StableFluid");
            Assert.IsTrue(gpuThreads.z <= DirectCompute5_0.MAX_Z, "THREAD_Z is too large : StableFluid");
        }

        void InitializeComputeShader()
        {
            width = Screen.width;
            height = Screen.height;
            solverTex = CreateRenderTexture(width >> lod, height >> lod, 0, RenderTextureFormat.ARGBFloat, solverTex);
            densityTex = CreateRenderTexture(width >> lod, height >> lod, 0, RenderTextureFormat.RHalf, densityTex);
            velocityTex = CreateRenderTexture(width >> lod, height >> lod, 0, RenderTextureFormat.RGHalf, velocityTex);
            prevTex = CreateRenderTexture(width >> lod, height >> lod, 0, RenderTextureFormat.ARGBHalf, prevTex);

            computeShader.SetFloat(diffId, diff);
            computeShader.SetFloat(viscId, visc);
            computeShader.SetFloat(dtId, Time.deltaTime);
            computeShader.SetFloat(velocityCoefId, velocityCoef);
            computeShader.SetFloat(densityCoefId, densityCoef);
        }

        #endregion


        #region StableFluid gpu kernel steps

        void DensityStep()
        {
            //Add density source to density field
            if (SorceTex != null)
            {
                computeShader.SetTexture(kernelMap[ComputeKernels.AddSourceDensity], sourceId, SorceTex);
                computeShader.SetTexture(kernelMap[ComputeKernels.AddSourceDensity], densityId, densityTex);
                computeShader.SetTexture(kernelMap[ComputeKernels.AddSourceDensity], prevId, prevTex);
                computeShader.Dispatch(kernelMap[ComputeKernels.AddSourceDensity], Mathf.CeilToInt((float)solverTex.width / gpuThreads.x), Mathf.CeilToInt((float)solverTex.height / gpuThreads.y), 1);
            }

            //Diffuse density
            computeShader.SetTexture(kernelMap[ComputeKernels.DiffuseDensity], densityId, densityTex);
            computeShader.SetTexture(kernelMap[ComputeKernels.DiffuseDensity], prevId, prevTex);
            computeShader.Dispatch(kernelMap[ComputeKernels.DiffuseDensity], Mathf.CeilToInt((float)solverTex.width / gpuThreads.x), Mathf.CeilToInt((float)solverTex.height / gpuThreads.y), 1);

            //Swap density
            computeShader.SetTexture(kernelMap[ComputeKernels.SwapDensity], densityId, densityTex);
            computeShader.SetTexture(kernelMap[ComputeKernels.SwapDensity], prevId, prevTex);
            computeShader.Dispatch(kernelMap[ComputeKernels.SwapDensity], Mathf.CeilToInt((float)solverTex.width / gpuThreads.x), Mathf.CeilToInt((float)solverTex.height / gpuThreads.y), 1);

            if (isDensityOnly)
            {
                //Advection using external velocity field via ForceTex.
                computeShader.SetTexture(kernelMap[ComputeKernels.AdvectDensityFromExt], densityId, densityTex);
                computeShader.SetTexture(kernelMap[ComputeKernels.AdvectDensityFromExt], prevId, prevTex);
                computeShader.SetTexture(kernelMap[ComputeKernels.AdvectDensityFromExt], velocityId, velocityTex);
                if (SorceTex != null) computeShader.SetTexture(kernelMap[ComputeKernels.AdvectDensityFromExt], sourceId, SorceTex);
                computeShader.Dispatch(kernelMap[ComputeKernels.AdvectDensity], Mathf.CeilToInt((float)solverTex.width / gpuThreads.x), Mathf.CeilToInt((float)solverTex.height / gpuThreads.y), 1);
            }
            else
            {
                //Advection using velocity solver
                computeShader.SetTexture(kernelMap[ComputeKernels.AdvectDensity], densityId, densityTex);
                computeShader.SetTexture(kernelMap[ComputeKernels.AdvectDensity], prevId, prevTex);
                computeShader.SetTexture(kernelMap[ComputeKernels.AdvectDensity], velocityId, velocityTex);
                computeShader.Dispatch(kernelMap[ComputeKernels.AdvectDensity], Mathf.CeilToInt((float)solverTex.width / gpuThreads.x), Mathf.CeilToInt((float)solverTex.height / gpuThreads.y), 1);
            }
        }

        void VelocityStep()
        {
            //Add velocity source to velocity field
            if (SorceTex != null)
            {
                computeShader.SetTexture(kernelMap[ComputeKernels.AddSourceVelocity], sourceId, SorceTex);
                computeShader.SetTexture(kernelMap[ComputeKernels.AddSourceVelocity], velocityId, velocityTex);
                computeShader.SetTexture(kernelMap[ComputeKernels.AddSourceVelocity], prevId, prevTex);
                computeShader.Dispatch(kernelMap[ComputeKernels.AddSourceVelocity], Mathf.CeilToInt((float)velocityTex.width / gpuThreads.x), Mathf.CeilToInt((float)velocityTex.height / gpuThreads.y), 1);
            }

            //Diffuse velocity
            computeShader.SetTexture(kernelMap[ComputeKernels.DiffuseVelocity], velocityId, velocityTex);
            computeShader.SetTexture(kernelMap[ComputeKernels.DiffuseVelocity], prevId, prevTex);
            computeShader.Dispatch(kernelMap[ComputeKernels.DiffuseVelocity], Mathf.CeilToInt((float)velocityTex.width / gpuThreads.x), Mathf.CeilToInt((float)velocityTex.height / gpuThreads.y), 1);

            //Project
            computeShader.SetTexture(kernelMap[ComputeKernels.ProjectStep1], velocityId, velocityTex);
            computeShader.SetTexture(kernelMap[ComputeKernels.ProjectStep1], prevId, prevTex);
            computeShader.Dispatch(kernelMap[ComputeKernels.ProjectStep1], Mathf.CeilToInt((float)velocityTex.width / gpuThreads.x), Mathf.CeilToInt((float)velocityTex.height / gpuThreads.y), 1);

            //Project
            computeShader.SetTexture(kernelMap[ComputeKernels.ProjectStep2], velocityId, velocityTex);
            computeShader.SetTexture(kernelMap[ComputeKernels.ProjectStep2], prevId, prevTex);
            computeShader.Dispatch(kernelMap[ComputeKernels.ProjectStep2], Mathf.CeilToInt((float)velocityTex.width / gpuThreads.x), Mathf.CeilToInt((float)velocityTex.height / gpuThreads.y), 1);

            //Swap velocity
            computeShader.SetTexture(kernelMap[ComputeKernels.SwapVelocity], velocityId, velocityTex);
            computeShader.SetTexture(kernelMap[ComputeKernels.SwapVelocity], prevId, prevTex);
            computeShader.Dispatch(kernelMap[ComputeKernels.SwapVelocity], Mathf.CeilToInt((float)velocityTex.width / gpuThreads.x), Mathf.CeilToInt((float)velocityTex.height / gpuThreads.y), 1);

            //Project
            computeShader.SetTexture(kernelMap[ComputeKernels.ProjectStep1], velocityId, velocityTex);
            computeShader.SetTexture(kernelMap[ComputeKernels.ProjectStep1], prevId, prevTex);
            computeShader.Dispatch(kernelMap[ComputeKernels.ProjectStep1], Mathf.CeilToInt((float)velocityTex.width / gpuThreads.x), Mathf.CeilToInt((float)velocityTex.height / gpuThreads.y), 1);

            //Project
            computeShader.SetTexture(kernelMap[ComputeKernels.ProjectStep2], velocityId, velocityTex);
            computeShader.SetTexture(kernelMap[ComputeKernels.ProjectStep2], prevId, prevTex);
            computeShader.Dispatch(kernelMap[ComputeKernels.ProjectStep2], Mathf.CeilToInt((float)velocityTex.width / gpuThreads.x), Mathf.CeilToInt((float)velocityTex.height / gpuThreads.y), 1);
        }

        #endregion

        #region render texture

        public RenderTexture CreateRenderTexture(int width, int height, int depth, RenderTextureFormat format, RenderTexture rt = null)
        {
            if (rt != null)
            {
                if (rt.width == width && rt.height == height) return rt;
            }

            ReleaseRenderTexture(rt);
            rt = new RenderTexture(width, height, depth, format);
            rt.enableRandomWrite = true;
            rt.wrapMode = TextureWrapMode.Clamp;
            rt.filterMode = FilterMode.Point;
            rt.Create();
            ClearRenderTexture(rt, Color.clear);
            return rt;
        }

        public RenderTexture CreateVolumetricRenderTexture(int width, int height, int volumeDepth, int depth, RenderTextureFormat format, RenderTexture rt = null)
        {
            if (rt != null)
            {
                if (rt.width == width && rt.height == height) return rt;
            }

            ReleaseRenderTexture(rt);
            rt = new RenderTexture(width, height, depth, format);
            rt.dimension = TextureDimension.Tex3D;
            rt.volumeDepth = volumeDepth;
            rt.enableRandomWrite = true;
            rt.wrapMode = TextureWrapMode.Clamp;
            rt.filterMode = FilterMode.Point;
            rt.Create();
            ClearRenderTexture(rt, Color.clear);
            return rt;
        }

        public void ReleaseRenderTexture(RenderTexture rt)
        {
            if (rt == null) return;

            rt.Release();
            Destroy(rt);
        }

        public void ClearRenderTexture(RenderTexture target, Color bg)
        {
            var active = RenderTexture.active;
            RenderTexture.active = target;
            GL.Clear(true, true, bg);
            RenderTexture.active = active;
        }

        #endregion

        #region release

        void CleanUp()
        {
            ReleaseRenderTexture(solverTex);
            ReleaseRenderTexture(densityTex);
            ReleaseRenderTexture(velocityTex);
            ReleaseRenderTexture(prevTex);

#if UNITY_EDITOR
            Debug.Log("Buffer released");
#endif
        }

        #endregion

        [Serializable]
        public class TextureEvent : UnityEvent<RenderTexture> { }
    }
}
