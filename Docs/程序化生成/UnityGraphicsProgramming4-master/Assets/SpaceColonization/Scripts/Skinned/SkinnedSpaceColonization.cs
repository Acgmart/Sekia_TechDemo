using System;
using System.Linq;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.InteropServices;

using UnityEngine;
using Random = UnityEngine.Random;

using SpaceColonization.VolumeSampler;

namespace SpaceColonization
{

    public class SkinnedSpaceColonization : MonoBehaviour
    {

        public float InfluenceDistance { get { return influenceDistance; } set { influenceDistance = value; } }
        public float GrowthDistance { get { return growthDistance; } set { growthDistance = value; } }
        public float KillDistance { get { return killDistance; } set { killDistance = value; } }
        public float GrowthSpeed { get { return growthSpeed; } set { growthSpeed = value; } }

        public ComputeBuffer AttractionBuffer { get { return attractionBuffer; } }
        public ComputeBuffer NodeBuffer { get { return nodeBuffer; } }
        public ComputeBuffer EdgeBuffer { get { return edgeBuffer; } }
        public int Count { get { return count; } }
        public int NodesCount { get { return nodesCount; } }
        public int EdgesCount { get { return edgesCount; } }

        [SerializeField] protected ComputeShader compute;

        [Header ("Animation")]
        [SerializeField] protected SkinnedMeshRenderer skinnedRenderer;
        [SerializeField] protected Volume volume;

        [Header("Rendering")]
        [SerializeField] protected Material material;
        protected MaterialPropertyBlock block;

        protected Mesh segment;
        protected ComputeBuffer drawBuffer;
        protected uint[] 
            drawArgs = new uint[5] { 0, 0, 0, 0, 0 };

        protected ComputeBuffer attractionBuffer, nodeBuffer;
        protected ComputeBuffer edgeBuffer, nodePoolBuffer, candidateBuffer;
        protected ComputeBuffer bindPoseBuffer;

        protected ComputeBuffer poolArgsBuffer;
        protected int[] poolArgs = new int[] { 0, 1, 0, 0 };

        SkinnedAttraction[] attractions;

        [Header("Seeds")]
        [SerializeField, Range(4, 16)] protected int seedCount = 6;
        protected float unitDistance;

        [SerializeField] protected int count;
        [SerializeField] protected int nodesCount, edgesCount;

        [SerializeField, Range(1, 5)] protected int frame = 1;
        [SerializeField, Range(1, 5)] protected int iterations = 1;
        [SerializeField, Range(0f, 1f)] protected float massMin = 0.25f, massMax = 1f;

        [Header("Distances")]
        [SerializeField, Range(1f, 10f)] protected float unitScale = 1f;
        [SerializeField, Range(0.25f, 3f)] protected float influenceDistance = 0.25f;
        [SerializeField, Range(0.25f, 1f)] protected float growthDistance = 0.2f, killDistance = 0.2f;
        [SerializeField] protected float growthSpeed = 22f;

        #region MonoBehaviour

        protected void OnEnable()
        {
        }

        protected void Awake()
        {
            segment = BuildSegment();
            block = new MaterialPropertyBlock();
        }

        protected void Start() {
            poolArgsBuffer = new ComputeBuffer(4, sizeof(int), ComputeBufferType.IndirectArguments);

            var bindposes = skinnedRenderer.sharedMesh.bindposes;
            bindPoseBuffer = new ComputeBuffer(bindposes.Length, Marshal.SizeOf(typeof(Matrix4x4)));
            bindPoseBuffer.SetData(bindposes);

            attractions = GenerateAttractions(volume);
            count = attractions.Length;
            attractionBuffer = new ComputeBuffer(count, Marshal.SizeOf(typeof(SkinnedAttraction)), ComputeBufferType.Default);
            attractionBuffer.SetData(attractions);

            SetupSkin();

            unitDistance = volume.UnitLength * unitScale;

            Reset();
        }
        
        protected void Update () {
            if (Time.frameCount % frame != 0) return;

            for (int i = 0; i < iterations; i++)
                Step(Time.deltaTime);

            Animate();

            Render();

            if (Input.GetKeyDown(KeyCode.Space))
                Reset();
        }

        protected void OnDrawGizmosSelected()
        {
            if (nodeBuffer == null) return;

            Gizmos.matrix = transform.localToWorldMatrix;
            Gizmos.color = Color.white;

            SkinnedNode[] nodes = new SkinnedNode[nodeBuffer.count];
            nodeBuffer.GetData(nodes);

            Edge[] edges = new Edge[edgeBuffer.count];
            edgeBuffer.GetData(edges);

            for(int i = 0, n = edges.Length; i < n; i++)
            {
                var e = edges[i];
                int ia = e.a, ib = e.b;
                SkinnedNode na = nodes[ia], nb = nodes[ib];
                Gizmos.DrawLine(na.position, nb.position);
            }
        } 

        protected void OnDestroy()
        {
            Release();
            bindPoseBuffer.Dispose();
            attractionBuffer.Dispose();
            poolArgsBuffer.Dispose();
            drawBuffer.Dispose();
        }

        protected void OnGUI()
        {
            using (new GUILayout.VerticalScope())
            {
                GUILayout.Space(20f);
                using (new GUILayout.HorizontalScope())
                {
                    GUILayout.Space(20f);
                    if (GUILayout.Button("Reset", GUILayout.Width(100f), GUILayout.Height(40f)))
                        Reset();
                }
            }
        }



        #endregion

        protected void Release()
        {
            if (nodeBuffer == null) return;

            nodeBuffer.Dispose();
            nodePoolBuffer.Dispose();
            candidateBuffer.Dispose();
            edgeBuffer.Dispose();
        }

        #region Initialization

        protected void SetupSkin()
        {
            var mesh = skinnedRenderer.sharedMesh;
            var vertices = mesh.vertices;
            var weights = mesh.boneWeights;
            var indices = new int[weights.Length];
            for(int i = 0, n = weights.Length; i < n; i++)
                indices[i] = weights[i].boneIndex0;

            using (
                ComputeBuffer
                vertBuffer = new ComputeBuffer(vertices.Length, Marshal.SizeOf(typeof(Vector3))),
                boneBuffer = new ComputeBuffer(weights.Length, Marshal.SizeOf(typeof(uint)))
            )
            {
                vertBuffer.SetData(vertices);
                boneBuffer.SetData(indices);

                var kernel = compute.FindKernel("SetupSkin");
                compute.SetBuffer(kernel, "_Vertices", vertBuffer);
                compute.SetBuffer(kernel, "_Bones", boneBuffer);
                compute.SetBuffer(kernel, "_Attractions", attractionBuffer);
                GPUHelper.Dispatch1D(compute, kernel, attractionBuffer.count);
            }
        }

        protected void SetupAttractions()
        {
            var kernel = compute.FindKernel("SetupAttractions");
            compute.SetBuffer(kernel, "_Attractions", attractionBuffer);
            GPUHelper.Dispatch1D(compute, kernel, count);
        }

        protected void SetupNodes(Vector3[] seeds)
        {
            var kernel = compute.FindKernel("SetupNodes");
            compute.SetBuffer(kernel, "_NodesPoolAppend", nodePoolBuffer);
            compute.SetBuffer(kernel, "_Nodes", nodeBuffer);
            GPUHelper.Dispatch1D(compute, kernel, count);

            using(ComputeBuffer seedBuffer = new ComputeBuffer(seeds.Length, Marshal.SizeOf(typeof(Vector3))))
            {
                seedBuffer.SetData(seeds);
                kernel = compute.FindKernel("Seed");
                compute.SetFloat("_MassMin", massMin);
                compute.SetFloat("_MassMax", massMax);
                compute.SetBuffer(kernel, "_Seeds", seedBuffer);
                compute.SetBuffer(kernel, "_NodesPoolConsume", nodePoolBuffer);
                compute.SetBuffer(kernel, "_Nodes", nodeBuffer);
                compute.SetBuffer(kernel, "_Attractions", attractionBuffer);
                GPUHelper.Dispatch1D(compute, kernel, seedBuffer.count);
            }

            nodesCount = nodePoolBuffer.count;
            edgesCount = 0;
        }

        protected void Reset()
        {
            Release();

            nodeBuffer = new ComputeBuffer(count, Marshal.SizeOf(typeof(SkinnedNode)), ComputeBufferType.Default);
            nodePoolBuffer = new ComputeBuffer(count, Marshal.SizeOf(typeof(int)), ComputeBufferType.Append);
            nodePoolBuffer.SetCounterValue(0);

            candidateBuffer = new ComputeBuffer(count, Marshal.SizeOf(typeof(SkinnedCandidate)), ComputeBufferType.Append);
            candidateBuffer.SetCounterValue(0);

            edgeBuffer = new ComputeBuffer(count * 2, Marshal.SizeOf(typeof(Edge)), ComputeBufferType.Append);
            edgeBuffer.SetCounterValue(0);

            SetupAttractions();

            var seeds = Enumerable.Range(0, seedCount).Select((_) => { return attractions[Random.Range(0, count)].position; }).ToArray();
            SetupNodes(seeds);

            CopyNodesCount();
            CopyEdgesCount();
            Step(0f);

            SetupDrawArgumentsBuffers(count);
        }

        protected SkinnedAttraction[] GenerateAttractions(Volume volume)
        {
            var count = volume.Points.Count;
            var attractions = new SkinnedAttraction[volume.Points.Count];
            for(int i = 0; i < count; i++)
            {
                var p = volume.Points[i];
                var attr = attractions[i];
                attr.position = p;
                attr.active = 1;
                attractions[i] = attr;
            }
            return attractions;
        }

        #endregion

        protected void Step(float dt)
        {
            if (nodesCount > 0)
            {
                Search();
                Attract();
                Connect();
                Remove();

                CopyNodesCount();
                CopyEdgesCount();
            }
            Grow(dt);
        }

        #region Kernels

        protected void Search()
        {
            var kernel = compute.FindKernel("Search");
            compute.SetBuffer(kernel, "_Attractions", attractionBuffer);
            compute.SetBuffer(kernel, "_Nodes", nodeBuffer);
            compute.SetFloat("_InfluenceDistance", unitDistance * influenceDistance);
            GPUHelper.Dispatch1D(compute, kernel, count);
        }

        protected void Attract()
        {
            var kernel = compute.FindKernel("Attract");
            compute.SetBuffer(kernel, "_Attractions", attractionBuffer);
            compute.SetBuffer(kernel, "_Nodes", nodeBuffer);

            candidateBuffer.SetCounterValue(0);
            compute.SetBuffer(kernel, "_CandidatesAppend", candidateBuffer);

            compute.SetFloat("_GrowthDistance", unitDistance * growthDistance);

            GPUHelper.Dispatch1D(compute, kernel, count);
        }

        protected void Connect()
        {
            var kernel = compute.FindKernel("Connect");
            compute.SetFloat("_MassMin", massMin);
            compute.SetFloat("_MassMax", massMax);
            compute.SetBuffer(kernel, "_Nodes", nodeBuffer);
            compute.SetBuffer(kernel, "_NodesPoolConsume", nodePoolBuffer);
            compute.SetBuffer(kernel, "_EdgesAppend", edgeBuffer);
            compute.SetBuffer(kernel, "_CandidatesConsume", candidateBuffer);

            var connectCount = Mathf.Min(nodesCount, CopyCount(candidateBuffer));
            if (connectCount > 0)
            {
                compute.SetInt("_ConnectCount", connectCount);
                GPUHelper.Dispatch1D(compute, kernel, connectCount);
            }
        }

        protected void Remove()
        {
            var kernel = compute.FindKernel("Remove");
            compute.SetBuffer(kernel, "_Attractions", attractionBuffer);
            compute.SetBuffer(kernel, "_Nodes", nodeBuffer);
            compute.SetFloat("_KillDistance", unitDistance * killDistance);
            GPUHelper.Dispatch1D(compute, kernel, count);
        }

        protected void Grow(float dt)
        {
            var kernel = compute.FindKernel("Grow");
            compute.SetBuffer(kernel, "_Nodes", nodeBuffer);

            var delta = dt * growthSpeed;
            compute.SetFloat("_DT", delta);

            GPUHelper.Dispatch1D(compute, kernel, count);
        }

        protected void Animate()
        {
            var bones = skinnedRenderer.bones.Select(bone => bone.localToWorldMatrix).ToArray();
            using (ComputeBuffer boneMatrixBuffer = new ComputeBuffer(bones.Length, Marshal.SizeOf(typeof(Matrix4x4))))
            {
                boneMatrixBuffer.SetData(bones);

                var kernel = compute.FindKernel("Animate");
                compute.SetBuffer(kernel, "_BindPoses", bindPoseBuffer);
                compute.SetBuffer(kernel, "_BoneMatrices", boneMatrixBuffer);
                compute.SetBuffer(kernel, "_Nodes", nodeBuffer);
                GPUHelper.Dispatch1D(compute, kernel, count);
            }
        }

        #endregion

        #region Copy Append/ConsumeStructuredBuffer count

        protected int CopyNodesCount()
        {
            return nodesCount = CopyCount(nodePoolBuffer);
        }

        protected int CopyEdgesCount()
        {
            return edgesCount = CopyCount(edgeBuffer);
        }

        protected int CopyCount(ComputeBuffer buffer)
        {
            poolArgsBuffer.SetData(poolArgs);
            ComputeBuffer.CopyCount(buffer, poolArgsBuffer, 0);
            poolArgsBuffer.GetData(poolArgs);
            return poolArgs[0];
        }

        #endregion

        #region Rendering

        protected void SetupDrawArgumentsBuffers(int count)
        {
            if (drawArgs[1] == (uint)count) return;

            drawArgs[0] = segment.GetIndexCount(0);
            drawArgs[1] = (uint)count;

            if (drawBuffer != null) drawBuffer.Dispose();
            drawBuffer = new ComputeBuffer(1, sizeof(uint) * drawArgs.Length, ComputeBufferType.IndirectArguments);
            drawBuffer.SetData(drawArgs);
        }

        protected Mesh BuildSegment()
        {
            var mesh = new Mesh();
            mesh.hideFlags = HideFlags.DontSave;
            mesh.vertices = new Vector3[2] { Vector3.zero, Vector3.up };
            mesh.uv = new Vector2[2] { new Vector2(0f, 0f), new Vector2(0f, 1f) };
            mesh.SetIndices(new int[2] { 0, 1 }, MeshTopology.Lines, 0);
            return mesh;
        }

        protected void Render(float extents = 1000f)
        {
            block.SetBuffer("_Nodes", nodeBuffer);
            block.SetBuffer("_Edges", edgeBuffer);
            block.SetInt("_EdgesCount", edgesCount);
            block.SetMatrix("_World2Local", transform.worldToLocalMatrix);
            block.SetMatrix("_Local2World", transform.localToWorldMatrix);
            Graphics.DrawMeshInstancedIndirect(segment, 0, material, new Bounds(Vector3.zero, Vector3.one * extents), drawBuffer, 0, block);
        }

        #endregion

    }

}


