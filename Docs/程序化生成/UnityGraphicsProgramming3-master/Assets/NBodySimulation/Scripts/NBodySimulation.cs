using System.Collections;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using UnityEngine;

namespace Kodai
{
    
    public class NBodySimulation : MonoBehaviour, IParticleRenderable
    {
        const int SIMULATION_BLOCK_SIZE = 256;
        const int READ = 0;
        const int WRITE = 1;
        const int DEFAULT_PARTICLE_NUM = 65536;

        [SerializeField] ComputeShader NBodyCS;

        [SerializeField] NumParticles numParticles = NumParticles.NUM_16K;

        [SerializeField] int seed = 0;
        [SerializeField] int divideLevel = 4;   //

        [SerializeField] float positionScale = 16.0f;

        [SerializeField] float damping = 0.96f;
        [SerializeField] float softeningSquared = 0.1f;


        int numBodies;
        ComputeBuffer[] bodyBuffers;


        void Start()
        {

            numBodies = (int) numParticles;

            InitBuffer();
            
            DistributeBodies();

        }

        void Update()
        {
            NBodyCS.SetFloat("_DeltaTime", Time.deltaTime);
            NBodyCS.SetFloat("_Damping", damping);
            NBodyCS.SetFloat("_SofteningSquared", softeningSquared);
            NBodyCS.SetInt("_NumBodies", numBodies);

            NBodyCS.SetVector("_ThreadDim", new Vector4(SIMULATION_BLOCK_SIZE, 1, 1, 0));
            NBodyCS.SetInt("_Division", divideLevel);
            NBodyCS.SetVector("_GroupDim", new Vector4(Mathf.CeilToInt(numBodies / SIMULATION_BLOCK_SIZE), 1, 1, 0));

            NBodyCS.SetBuffer(0, "_BodiesBufferRead", bodyBuffers[READ]);
            NBodyCS.SetBuffer(0, "_BodiesBufferWrite", bodyBuffers[WRITE]);

            NBodyCS.Dispatch(0, Mathf.CeilToInt(numBodies / SIMULATION_BLOCK_SIZE), 1, 1);

            Swap(bodyBuffers);

        }

        void OnDestroy()
        {
            bodyBuffers[READ].Release();
            bodyBuffers[WRITE].Release();
        }

        void InitBuffer()
        {
            bodyBuffers = new ComputeBuffer[2];
            bodyBuffers[READ] = new ComputeBuffer(numBodies, Marshal.SizeOf(typeof(Body)));
            bodyBuffers[WRITE] = new ComputeBuffer(numBodies, Marshal.SizeOf(typeof(Body)));
        }

        void DistributeBodies()
        {
            Random.InitState(seed);

            float scale = positionScale * Mathf.Max(1, numBodies / DEFAULT_PARTICLE_NUM);

            Body[] bodies = new Body[numBodies];

            int i = 0;
            while (i < numBodies)
            {
                Vector3 pos = new Vector3(Random.Range(-1.0f, 1.0f), Random.Range(-1.0f, 1.0f), Random.Range(-1.0f, 1.0f));

                if (Vector3.Dot(pos, pos) > 1.0) continue;

                bodies[i].position = pos * scale;
                bodies[i].velocity = Vector3.zero;
                bodies[i].mass = Random.Range(0.1f, 1.0f);


                i++;
            }

            bodyBuffers[READ].SetData(bodies);
            bodyBuffers[WRITE].SetData(bodies);

        }



        void Swap(ComputeBuffer[] buffer)
        {
            ComputeBuffer tmp = buffer[READ];
            buffer[READ] = buffer[WRITE];
            buffer[WRITE] = tmp;
        }



        #region IParticleRenderable

        public int GetParticleNum()
        {
            return numBodies;
        }

        public ComputeBuffer GetParticleBuffer()
        {
            return bodyBuffers[READ];
        }

        #endregion

    }


}