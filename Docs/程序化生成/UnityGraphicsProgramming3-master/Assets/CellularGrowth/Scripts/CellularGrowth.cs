using System;
using System.Linq;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.InteropServices;

using UnityEngine;

namespace CellularGrowth
{

    public class CellularGrowth : MonoBehaviour {

        protected enum DividePattern
        {
            Closed,
            Branch,
        };

        [SerializeField] protected int count = 4096;
        [SerializeField] protected ComputeShader compute;
        [SerializeField] protected Material particleMaterial, edgeMaterial;
        [SerializeField] protected Gradient gradient;
        protected Texture2D pallete;

        [SerializeField, Range(0.1f, 1.5f)] protected float size = 0.9f;
        [SerializeField, Range(0.01f, 1f)] protected float grow = 0.25f;

        [SerializeField] protected DividePattern pattern = DividePattern.Branch;
        [SerializeField, Range(1, 4)] protected int iterations = 2;
        [SerializeField, Range(0.02f, 3f)] protected float divideInterval = 0.5f;
        [SerializeField, Range(1, 128)] protected int maxDivideCount = 16;
        [SerializeField, Range(2, 6)] protected int maxLink = 4;

        [SerializeField, Range(0.1f, 1f)] protected float drag = 0.995f;
        [SerializeField, Range(0.1f, 5f)] protected float limit = 3f;

        [SerializeField, Range(1f, 5f)] protected float repulsion = 1f;
        [SerializeField, Range(1f, 10f)] protected float spring = 5f;

        protected GPUObjectPoolPingPong particlePool;
        protected GPUObjectPool edgePool;
        protected ComputeBuffer particleArgsBuffer, edgeArgsBuffer;

        protected ComputeBuffer dividablePoolBuffer, countBuffer;

        int[] countArgs = new int[] { 0, 1, 0, 0 };
        uint[] particleDrawArgs = new uint[5] { 0, 0, 0, 0, 0 };
        uint[] edgeDrawArgs = new uint[5] { 0, 0, 0, 0, 0 };

        protected Mesh particleMesh, edgeMesh;

        #region Lifecycle

        protected void Start()
        {
            // Initialize particle buffer
            particlePool = new GPUObjectPoolPingPong(count, typeof(Particle_t));
            edgePool = new GPUObjectPool(count, typeof(Edge_t));

            countBuffer = new ComputeBuffer(4, Marshal.SizeOf(typeof(int)), ComputeBufferType.IndirectArguments);
            countBuffer.SetData(countArgs);
            dividablePoolBuffer = new ComputeBuffer(count, Marshal.SizeOf(typeof(int)), ComputeBufferType.Append);
            dividablePoolBuffer .SetCounterValue(0);

            // Initialize for gpu-instancing
            particleMesh = BuildQuad();
            particleDrawArgs[0] = particleMesh.GetIndexCount(0);
            particleDrawArgs[1] = (uint)count;
            particleArgsBuffer = new ComputeBuffer(1, sizeof(uint) * particleDrawArgs.Length, ComputeBufferType.IndirectArguments);
            particleArgsBuffer.SetData(particleDrawArgs);

            pallete = CreatePallete(gradient, 128);
            particleMaterial.SetTexture("_Gradient", pallete);

            edgeMesh = BuildSegment();
            edgeDrawArgs[0] = edgeMesh.GetIndexCount(0);
            edgeDrawArgs[1] = (uint)count;
            edgeArgsBuffer = new ComputeBuffer(1, sizeof(uint) * edgeDrawArgs.Length, ComputeBufferType.IndirectArguments);
            edgeArgsBuffer.SetData(edgeDrawArgs);

            // Execute kernel to initialize particle and pool buffers
            InitParticlesKernel();
            InitEdgesKernel();

            EmitParticlesKernel(Vector2.zero, 1);

            StartCoroutine(IDivider());
        }
        
        protected void Update () {
            float time = Time.timeSinceLevelLoad, dt = Time.deltaTime;
            compute.SetFloat("_Time", time);
            compute.SetFloat("_DT", dt);

            for(int i = 0; i < iterations; i++)
            {
                UpdateEdgesKernel();
                SpringEdgesKernel();
                UpdateParticlesKernel();
            }

            Render();
        }

        protected void OnDestroy()
        {
            particlePool.Dispose();
            edgePool.Dispose();
            particleArgsBuffer.Dispose();
            edgeArgsBuffer.Dispose();
            countBuffer.Dispose();
            dividablePoolBuffer.Dispose();
        }

        #endregion

        protected int GetKernelBlock(int count, int blockSize)
        {
            return (count + blockSize - 1) / blockSize;
        }

        protected void Dispatch1D(int kernel, int count)
        {
            uint tx, ty, tz;
            compute.GetKernelThreadGroupSizes(kernel, out tx, out ty, out tz);
            compute.Dispatch(kernel, GetKernelBlock(count, (int)tx), (int)ty, (int)tz);
        }

        protected int CopyPoolSize(ComputeBuffer buffer)
        {
            countBuffer.SetData(countArgs);
            ComputeBuffer.CopyCount(buffer, countBuffer, 0);
            countBuffer.GetData(countArgs);
            return countArgs[0];
        }

        #region Particle kernels

        protected void InitParticlesKernel()
        {
            var kernel = compute.FindKernel("InitParticles");
            compute.SetBuffer(kernel, "_Particles", particlePool.ObjectPingPong.Read);

            // Set object pool buffer as AppendStructuredBuffer
            compute.SetBuffer(kernel, "_ParticlePoolAppend", particlePool.PoolBuffer);

            Dispatch1D(kernel, count);
        }

        protected void EmitParticlesKernel(Vector2 point, int emitCount = 8)
        {
            // compare object pool size and emit count
            // and check if emit count is more than 0
            // to avoid calling pool.Consume() with 0 size
            emitCount = Mathf.Max(0, Mathf.Min(emitCount, particlePool.CopyPoolSize()));
            if (emitCount <= 0) return;

            var kernel = compute.FindKernel("EmitParticles");
            compute.SetBuffer(kernel, "_Particles", particlePool.ObjectPingPong.Read);
            compute.SetBuffer(kernel, "_ParticlePoolConsume", particlePool.PoolBuffer);

            compute.SetVector("_Point", point);
            compute.SetInt("_EmitCount", emitCount);

            Dispatch1D(kernel, count);
        }

        protected void UpdateParticlesKernel()
        {
            var kernel = compute.FindKernel("UpdateParticles");
            compute.SetBuffer(kernel, "_ParticlesRead", particlePool.ObjectPingPong.Read);
            compute.SetBuffer(kernel, "_Particles", particlePool.ObjectPingPong.Write);

            compute.SetFloat("_Drag", drag);
            compute.SetFloat("_Limit", limit);
            compute.SetFloat("_Repulsion", repulsion);
            compute.SetFloat("_Grow", grow);

            Dispatch1D(kernel, count);

            particlePool.ObjectPingPong.Swap();
        }

        protected void DivideUnconnectedParticles()
        {
            var kernel = compute.FindKernel("DivideUnconnectedParticles");
            compute.SetBuffer(kernel, "_Particles", particlePool.ObjectPingPong.Read);
            compute.SetBuffer(kernel, "_ParticlePoolConsume", particlePool.PoolBuffer);
            compute.SetBuffer(kernel, "_Edges", edgePool.ObjectBuffer);
            compute.SetBuffer(kernel, "_EdgePoolConsume", edgePool.PoolBuffer);

            Dispatch1D(kernel, count);
        }

        #endregion

        #region Edge kernels

        protected void InitEdgesKernel()
        {
            var kernel = compute.FindKernel("InitEdges");
            compute.SetBuffer(kernel, "_Edges", edgePool.ObjectBuffer);
            compute.SetBuffer(kernel, "_EdgePoolAppend", edgePool.PoolBuffer);

            Dispatch1D(kernel, count);
        }

        protected void UpdateEdgesKernel()
        {
            // calculate spring force for each edges
            var kernel = compute.FindKernel("UpdateEdges");
            compute.SetBuffer(kernel, "_Particles", particlePool.ObjectPingPong.Read);
            compute.SetBuffer(kernel, "_Edges", edgePool.ObjectBuffer);
            compute.SetFloat("_Spring", spring);

            Dispatch1D(kernel, count);
        }

        protected void SpringEdgesKernel()
        {
            // apply spring force for each particles
            var kernel = compute.FindKernel("SpringEdges");
            compute.SetBuffer(kernel, "_Particles", particlePool.ObjectPingPong.Read);
            compute.SetBuffer(kernel, "_Edges", edgePool.ObjectBuffer);

            Dispatch1D(kernel, count);
        }

        protected void GetDividableEdgesKernel()
        {
            // Reset active pool buffer count to zero
            dividablePoolBuffer.SetCounterValue(0);

            var kernel = compute.FindKernel("GetDividableEdges");
            compute.SetBuffer(kernel, "_Particles", particlePool.ObjectPingPong.Read);
            compute.SetBuffer(kernel, "_Edges", edgePool.ObjectBuffer);
            compute.SetBuffer(kernel, "_DividablePoolAppend", dividablePoolBuffer);
            compute.SetInt("_MaxLink", maxLink);

            Dispatch1D(kernel, count);
        }

        protected void DivideEdgesBranchKernel(int dividableEdgesCount, int maxDivideCount = 16)
        {
            var kernel = compute.FindKernel("DivideEdgesBranch");
            DivideEdgesKernel(kernel, dividableEdgesCount, maxDivideCount);
        }

        protected void DivideEdgesClosedKernel(int dividableEdgesCount, int maxDivideCount = 16)
        {
            var kernel = compute.FindKernel("DivideEdgesClosed");
            DivideEdgesKernel(kernel, dividableEdgesCount, maxDivideCount);
        }

        protected void DivideEdgesKernel(int kernel, int dividableEdgesCount, int maxDivideCount)
        {
            // compare pool buffer sizes 
            // to avoid call pool.Consume() with 0 size
            maxDivideCount = Mathf.Min(dividableEdgesCount, maxDivideCount);
            maxDivideCount = Mathf.Min(particlePool.CopyPoolSize(), maxDivideCount);
            maxDivideCount = Mathf.Min(edgePool.CopyPoolSize(), maxDivideCount);
            if (maxDivideCount <= 0) return;

            compute.SetBuffer(kernel, "_Particles", particlePool.ObjectPingPong.Read);
            compute.SetBuffer(kernel, "_ParticlePoolConsume", particlePool.PoolBuffer);
            compute.SetBuffer(kernel, "_Edges", edgePool.ObjectBuffer);
            compute.SetBuffer(kernel, "_EdgePoolConsume", edgePool.PoolBuffer);

            compute.SetBuffer(kernel, "_DividablePoolConsume", dividablePoolBuffer);
            compute.SetInt("_DivideCount", maxDivideCount);

            Dispatch1D(kernel, maxDivideCount);
        }

        #endregion

        protected void Render()
        {
            // render particles
            particleMaterial.SetBuffer("_Particles", particlePool.ObjectPingPong.Read);
            particleMaterial.SetMatrix("_World2Local", transform.worldToLocalMatrix);
            particleMaterial.SetMatrix("_Local2World", transform.localToWorldMatrix);
            particleMaterial.SetFloat("_Size", size);
            particleMaterial.SetPass(0);
            Graphics.DrawMeshInstancedIndirect(particleMesh, 0, particleMaterial, new Bounds(Vector3.zero, Vector3.one * 100f), particleArgsBuffer);

            // render edges
            if (edgeMaterial == null) return;
            edgeMaterial.SetBuffer("_Particles", particlePool.ObjectPingPong.Read);
            edgeMaterial.SetBuffer("_Edges", edgePool.ObjectBuffer);
            edgeMaterial.SetMatrix("_World2Local", transform.worldToLocalMatrix);
            edgeMaterial.SetMatrix("_Local2World", transform.localToWorldMatrix);
            edgeMaterial.SetPass(0);
            Graphics.DrawMeshInstancedIndirect(edgeMesh, 0, edgeMaterial, new Bounds(Vector3.zero, Vector3.one * 100f), edgeArgsBuffer);
        }

        protected IEnumerator IDivider()
        {
            yield return 0;
            while(true)
            {
                yield return new WaitForSeconds(divideInterval);
                Divide();
            }
        }

        protected void Divide()
        {
            GetDividableEdgesKernel();

            int dividableEdgesCount = CopyPoolSize(dividablePoolBuffer);
            if(dividableEdgesCount == 0)
            {
                // if the # of dividable edges is 0,
                // divide unconnected particles (particles without links)
                DivideUnconnectedParticles();
            } else
            {
                switch(pattern)
                {
                    case DividePattern.Closed:
                        DivideEdgesClosedKernel(dividableEdgesCount, maxDivideCount);
                        break;
                    case DividePattern.Branch:
                        DivideEdgesBranchKernel(dividableEdgesCount, maxDivideCount);
                        break;
                }
            }
        }

        protected Mesh BuildQuad()
        {
            var mesh = new Mesh();
            mesh.hideFlags = HideFlags.HideAndDontSave;

            mesh.vertices = new Vector3[]
            {
                new Vector3(-0.5f,  0.5f, 0f), new Vector3( 0.5f,  0.5f, 0f),
                new Vector3( 0.5f, -0.5f, 0f), new Vector3(-0.5f, -0.5f, 0f)
            };
            mesh.uv = new Vector2[]
            {
                new Vector2(0f, 0f), new Vector2(1f, 0f), 
                new Vector2(1f, 1f), new Vector2(0f, 1f)
            };
            mesh.SetIndices(
                new int[] {
                    0, 1, 2,
                    2, 3, 0
                }, 
                MeshTopology.Triangles, 
                0
            );
            mesh.RecalculateBounds();

            return mesh;
        }

        protected Texture2D CreatePallete(Gradient grad, int width)
        {
            var tex = new Texture2D(width, 1);
            var inv = 1f / width;
            for(int x = 0; x < width; x++)
            {
                tex.SetPixel(x, 0, grad.Evaluate(x * inv));
            }
            tex.Apply();
            return tex;
        }

        protected Mesh BuildSegment()
        {
            var mesh = new Mesh();
            mesh.hideFlags = HideFlags.HideAndDontSave;
            mesh.vertices = new Vector3[2] { Vector3.zero, Vector3.up };
            mesh.uv = new Vector2[2] { new Vector2(0f, 0f), new Vector2(0f, 1f) };
            mesh.SetIndices(new int[2] { 0, 1 }, MeshTopology.Lines, 0);
            return mesh;
        }

    }

}


