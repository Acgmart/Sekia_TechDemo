using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace BoidsSimulationOnGPU
{
    [RequireComponent(typeof(Boids_UpdateComputeBuffer))]
    public class BoidsRender : MonoBehaviour
    {
        public Vector3 ObjectScale = new Vector3(0.1f, 0.2f, 0.5f);
        public Boids_UpdateComputeBuffer GPUBoidsScript;
        public Mesh InstanceMesh;
        public Material InstanceRenderMaterial;

        uint[] args = new uint[5] { 0, 0, 0, 0, 0 };
        ComputeBuffer argsBuffer;

        void Start()
        {
            argsBuffer = new ComputeBuffer(1, args.Length * sizeof(uint), ComputeBufferType.IndirectArguments);
        }

        void Update()
        {
            RenderInstancedMesh();
        }

        void OnDisable()
        {
            if (argsBuffer != null)
                argsBuffer.Release();
            argsBuffer = null;
        }

        void RenderInstancedMesh()
        {
            if (InstanceRenderMaterial == null ||
                GPUBoidsScript == null ||
                !SystemInfo.supportsInstancing ||
                InstanceMesh == null)
                return;

            InstanceRenderMaterial.SetVector("_ObjectScale", ObjectScale);

            args[0] = InstanceMesh.GetIndexCount(0) - 18;
            args[1] = (uint)GPUBoidsScript.GetMaxObjectNum();
            argsBuffer.SetData(args);


            InstanceRenderMaterial.SetBuffer("_BoidDataBuffer", GPUBoidsScript.GetBoidDataBuffer());

            var bounds = new Bounds
            (
                GPUBoidsScript.GetSimulationAreaCenter(),
                GPUBoidsScript.GetSimulationAreaSize()
            );

            Graphics.DrawMeshInstancedIndirect
            (
                mesh: InstanceMesh,
                submeshIndex: 0,
                InstanceRenderMaterial,
                bounds,
                argsBuffer
            );
        }
    }
}
