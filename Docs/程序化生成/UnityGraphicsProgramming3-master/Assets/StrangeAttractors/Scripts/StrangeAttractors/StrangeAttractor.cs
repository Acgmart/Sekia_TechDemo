using System;
using System.Linq;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Assertions;

namespace StrangeAttractors
{
    public abstract class StrangeAttractor : MonoBehaviour
    {
        #pragma warning disable 0414

        protected struct Params
        {
            Vector3 emitPos;
            Vector3 position;
            Vector3 velocity; // xyz = velocity, w = velocity coef;
            float   life;
            Vector2 size;     // x = current size, y = target size.
            Vector4 color;

            public Params(Vector3 emitPos, float size, Color color)
            {
                this.emitPos = emitPos;
                this.position = Vector3.zero;
                this.velocity = Vector3.zero;
                this.life = 0;
                this.size = new Vector2(0, size);
                this.color = color;
            }
        }

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

        #region Variables

        private enum ComputeKernels
        {
            Emit,
            Iterator
        }

        private Dictionary<ComputeKernels, int> kernelMap = new Dictionary<ComputeKernels, int>();
        private GPUThreads gpuThreads;

        [SerializeField] protected int instanceCount = 100000;
        [SerializeField] protected Gradient gradient;
        [SerializeField] protected float particleSize;
        [SerializeField] protected KeyCode reEmitKey;
        [SerializeField] protected float emitterSize = 10f;
        [SerializeField] protected Mesh instanceMesh;
        [SerializeField] protected Material mat;
        [SerializeField] protected ComputeShader computeShader;

        protected ComputeShader computeShaderInstance;
        protected ComputeBuffer cBuffer;
        protected ComputeBuffer argsBuffer;
        private int cachedInstanceCount = -1;
        private uint[] args = new uint[5] { 0, 0, 0, 0, 0 };
        private float timer = 0f;
        private float idleTime = 3f;

        private int bufferPropId;
        private int timesPropId;
        private int modelMatrixPropId;

        #endregion

        protected virtual void Initialize()
        {
            computeShaderInstance = computeShader;
            uint threadX, threadY, threadZ;
            kernelMap = System.Enum.GetValues(typeof(ComputeKernels))
                .Cast<ComputeKernels>()
                .ToDictionary(t => t, t => computeShaderInstance.FindKernel(t.ToString()));
            computeShaderInstance.GetKernelThreadGroupSizes(kernelMap[ComputeKernels.Emit], out threadX, out threadY, out threadZ);
            gpuThreads = new GPUThreads(threadX, threadY, threadZ);
            argsBuffer = new ComputeBuffer(1, args.Length * sizeof(uint), ComputeBufferType.IndirectArguments);

            bufferPropId           = Shader.PropertyToID("buf");
            modelMatrixPropId      = Shader.PropertyToID("modelMatrix");
            timesPropId            = Shader.PropertyToID("times");

            InitializeShaderUniforms();

            InitialCheck();
            InitializeBuffers();
        }

        void InitialCheck()
        {
            Assert.IsTrue(SystemInfo.graphicsShaderLevel >= 50, "Under the DirectCompute5.0 (DX11 GPU) doesn't work");
            Assert.IsTrue(gpuThreads.x * gpuThreads.y * gpuThreads.z <= DirectCompute5_0.MAX_PROCESS, "Resolution is too heigh");
            Assert.IsTrue(gpuThreads.x <= DirectCompute5_0.MAX_X, "THREAD_X is too large");
            Assert.IsTrue(gpuThreads.y <= DirectCompute5_0.MAX_Y, "THREAD_Y is too large");
            Assert.IsTrue(gpuThreads.z <= DirectCompute5_0.MAX_Z, "THREAD_Z is too large");
            Assert.IsTrue(instanceCount <= DirectCompute5_0.MAX_PROCESS, "particleNumber is too large");
        }

        void Start()
        {
            Initialize();
        }

        protected virtual void Update()
        {
            timer += Time.deltaTime;

            if (timer <= idleTime) return; // just for idling

            if (cachedInstanceCount != instanceCount)
                InitializeBuffers();

            mat.SetPass(0);
            mat.SetBuffer(bufferPropId, cBuffer);
            mat.SetMatrix(modelMatrixPropId, transform.localToWorldMatrix);

            UpdateShaderUniforms();

            computeShaderInstance.SetVector(timesPropId, new Vector2(Time.deltaTime, timer));

            computeShaderInstance.SetBuffer(kernelMap[ComputeKernels.Iterator], bufferPropId, cBuffer);
            computeShaderInstance.Dispatch(kernelMap[ComputeKernels.Iterator], Mathf.CeilToInt((float)instanceCount / (float)gpuThreads.x), gpuThreads.y, gpuThreads.z);

            // Render
            Graphics.DrawMeshInstancedIndirect(instanceMesh, 0, mat, new Bounds(Vector3.zero, new Vector3(100f, 100f, 100f)), argsBuffer);

            if (Input.GetKeyDown(reEmitKey))
            {
                computeShaderInstance.SetBuffer(kernelMap[ComputeKernels.Emit], bufferPropId, cBuffer);
                computeShaderInstance.Dispatch(kernelMap[ComputeKernels.Emit], Mathf.CeilToInt((float)instanceCount / (float)gpuThreads.x), gpuThreads.y, gpuThreads.z);
            }
        }

        void InitializeBuffers()
        {
            InitializeComputeBuffer();

            uint numIndices = (instanceMesh != null) ? (uint)instanceMesh.GetIndexCount(0) : 0;
            args[0] = numIndices;
            args[1] = (uint)instanceCount;
            argsBuffer.SetData(args);

            cachedInstanceCount = instanceCount;

            computeShaderInstance.SetBuffer(kernelMap[ComputeKernels.Emit], bufferPropId, cBuffer);
            computeShaderInstance.Dispatch(kernelMap[ComputeKernels.Emit], Mathf.CeilToInt((float)instanceCount / (float)gpuThreads.x), gpuThreads.y, gpuThreads.z);
        }

        protected abstract void InitializeComputeBuffer();

        protected abstract void InitializeShaderUniforms();

        protected abstract void UpdateShaderUniforms();

        void OnDisable()
        {
            if (cBuffer != null)
                cBuffer.Release();
            cBuffer = null;

            if (argsBuffer != null)
                argsBuffer.Release();
            argsBuffer = null;
        }
    } 
}
