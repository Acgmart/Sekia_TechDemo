using System.Collections;
using System.Collections.Generic;
using System.Runtime.InteropServices;

using UnityEngine;

namespace CellularGrowth
{

    public class CellularGrowthParticleOnly : MonoBehaviour {

        [SerializeField] protected int count = 4096;
        [SerializeField] protected ComputeShader compute;
        [SerializeField] protected Material material;
        [SerializeField] protected Gradient gradient;
        protected Texture2D pallete;

        [SerializeField, Range(0.1f, 1f)] protected float size = 0.9f;
        [SerializeField, Range(0.01f, 1f)] protected float grow = 0.25f;

        [SerializeField, Range(0.1f, 3f)] protected float divideInterval = 0.5f;
        [SerializeField, Range(1, 128)] protected int maxDivideCount = 16;

        [SerializeField, Range(0.1f, 1f)] protected float drag = 0.995f;
        [SerializeField, Range(0.1f, 5f)] protected float limit = 3f;

        [SerializeField, Range(1f, 5f)] protected float repulsion = 1f;

        protected PingPongBuffer particleBuffer;
        protected ComputeBuffer poolBuffer, countBuffer;
        protected ComputeBuffer argsBuffer;

        protected ComputeBuffer dividablePoolBuffer;

        int[] countArgs = new int[] { 0, 1, 0, 0 };
        uint[] drawArgs = new uint[5] { 0, 0, 0, 0, 0 };

        protected Mesh mesh;

        #region Lifecycle

        protected void Start () {
            // Initialize particle buffer
            particleBuffer = new PingPongBuffer(count, typeof(Particle_t));

            // Initialize object pool buffer
            poolBuffer = new ComputeBuffer(count, Marshal.SizeOf(typeof(int)), ComputeBufferType.Append);
            poolBuffer.SetCounterValue(0);
            countBuffer = new ComputeBuffer(4, Marshal.SizeOf(typeof(int)), ComputeBufferType.IndirectArguments);
            countBuffer.SetData(countArgs);

            // Initialize dividable object pool buffer
            dividablePoolBuffer = new ComputeBuffer(count, Marshal.SizeOf(typeof(int)), ComputeBufferType.Append);
            dividablePoolBuffer.SetCounterValue(0);

            // Execute kernel to initialize particle and pool buffers
            InitParticlesKernel();

            // Initialize for gpu-instancing
            mesh = BuildQuad();
            drawArgs[0] = mesh.GetIndexCount(0);
            drawArgs[1] = (uint)count;
            argsBuffer = new ComputeBuffer(1, sizeof(uint) * drawArgs.Length, ComputeBufferType.IndirectArguments);
            argsBuffer.SetData(drawArgs);

            pallete = CreatePallete(gradient, 128);
            material.SetTexture("_Gradient", pallete);

            StartCoroutine(IDivider());
        }
        
        protected void Update () {
            float time = Time.timeSinceLevelLoad, dt = Time.deltaTime;
            compute.SetFloat("_Time", time);
            compute.SetFloat("_DT", dt);

            if(Input.GetMouseButton(0))
            {
                EmitParticlesKernel(GetMousePoint());
            }

            UpdateParticlesKernel();

            Render();
        }

        protected void OnDestroy()
        {
            particleBuffer.Dispose();
            poolBuffer.Dispose();
            countBuffer.Dispose();
            argsBuffer.Dispose();
            dividablePoolBuffer.Dispose();

            Destroy(pallete);
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

        // copy & get object pool size
        protected int CopyPoolSize(ComputeBuffer buffer)
        {
            countBuffer.SetData(countArgs);
            ComputeBuffer.CopyCount(buffer, countBuffer, 0);
            countBuffer.GetData(countArgs);
            return countArgs[0];
        }

        #region Kernels

        protected void InitParticlesKernel()
        {
            var kernel = compute.FindKernel("InitParticles");
            compute.SetBuffer(kernel, "_Particles", particleBuffer.Read);

            // Set object pool buffer as AppendStructuredBuffer
            compute.SetBuffer(kernel, "_ParticlePoolAppend", poolBuffer);

            Dispatch1D(kernel, count);
        }

        protected void EmitParticlesKernel(Vector2 point, int emitCount = 8)
        {
            // compare object pool size and emit count
            // and check if emit count is more than 0
            // to avoid calling pool.Consume() with 0 size
            emitCount = Mathf.Max(0, Mathf.Min(emitCount, CopyPoolSize(poolBuffer)));
            if (emitCount <= 0) return;

            var kernel = compute.FindKernel("EmitParticles");
            compute.SetBuffer(kernel, "_Particles", particleBuffer.Read);

            // Set object pool buffer as ConsumeStructuredBuffer
            compute.SetBuffer(kernel, "_ParticlePoolConsume", poolBuffer);

            compute.SetVector("_Point", point);
            compute.SetInt("_EmitCount", emitCount);

            Dispatch1D(kernel, count);
        }

        protected void UpdateParticlesKernel()
        {
            var kernel = compute.FindKernel("UpdateParticles");
            compute.SetBuffer(kernel, "_ParticlesRead", particleBuffer.Read);
            compute.SetBuffer(kernel, "_Particles", particleBuffer.Write);

            compute.SetFloat("_Drag", drag);
            compute.SetFloat("_Limit", limit);
            compute.SetFloat("_Repulsion", repulsion);
            compute.SetFloat("_Grow", grow);

            Dispatch1D(kernel, count);

            particleBuffer.Swap();
        }

        // Set dividable particle candidates to dividablePoolBuffer
        protected void GetDividableParticlesKernel()
        {
            // Reset dividable pool buffer count to zero
            dividablePoolBuffer.SetCounterValue(0);

            var kernel = compute.FindKernel("GetDividableParticles");
            compute.SetBuffer(kernel, "_Particles", particleBuffer.Read);
            compute.SetBuffer(kernel, "_DividablePoolAppend", dividablePoolBuffer);

            Dispatch1D(kernel, count);
        }

        protected void DivideParticlesKernel(int maxDivideCount = 16)
        {
            maxDivideCount = Mathf.Min(CopyPoolSize(dividablePoolBuffer), maxDivideCount);
            maxDivideCount = Mathf.Min(CopyPoolSize(poolBuffer), maxDivideCount);
            if (maxDivideCount <= 0) return;

            var kernel = compute.FindKernel("DivideParticles");
            compute.SetBuffer(kernel, "_Particles", particleBuffer.Read);
            compute.SetBuffer(kernel, "_ParticlePoolConsume", poolBuffer);
            compute.SetBuffer(kernel, "_DividablePoolConsume", dividablePoolBuffer);
            compute.SetInt("_DivideCount", maxDivideCount);

            Dispatch1D(kernel, maxDivideCount);
        }

        #endregion

        protected void Render()
        {
            material.SetBuffer("_Particles", particleBuffer.Read);
            material.SetMatrix("_World2Local", transform.worldToLocalMatrix);
            material.SetMatrix("_Local2World", transform.localToWorldMatrix);
            material.SetFloat("_Size", size);
            material.SetPass(0);
            Graphics.DrawMeshInstancedIndirect(mesh, 0, material, new Bounds(Vector3.zero, Vector3.one * 100f), argsBuffer);
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
            GetDividableParticlesKernel();
            DivideParticlesKernel(maxDivideCount);
        }

        protected Vector2 GetMousePoint()
        {
            var p = Input.mousePosition;
            var world = Camera.main.ScreenToWorldPoint(new Vector3(p.x, p.y, Camera.main.nearClipPlane));
            var local = transform.InverseTransformPoint(world);
            return new Vector4(local.x, local.y);
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

    }

}


