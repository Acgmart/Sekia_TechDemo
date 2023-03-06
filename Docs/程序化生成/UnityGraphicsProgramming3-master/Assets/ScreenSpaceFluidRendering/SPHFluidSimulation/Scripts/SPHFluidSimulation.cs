using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.InteropServices;

namespace ScreenSpaceFluidRendering
{
    /// <summary>
    /// SPH 流体シミュレーション
    /// </summary>
    public class SPHFluidSimulation : MonoBehaviour
    {

        struct FluidParticle
        {
            public Vector3 Position;
            public Vector3 Velocity;
        };

        struct FluidParticleDensity
        {
            public float Density;
        };

        struct FluidParticleForces
        {
            public Vector3 Acceleration;
        };

        const int SIMULATION_BLOCK_SIZE = 256;

        const int NUM_PARTICLES_8K  =  8 * 1024;
        const int NUM_PARTICLES_16K = 16 * 1024;
        const int NUM_PARTICLES_32K = 32 * 1024;
        
        public enum NumParticlesSet
        {
            NUM_8K,
            NUM_16K,
            NUM_32K,
        };

        public NumParticlesSet ParticleNum = NumParticlesSet.NUM_16K;

        public float Smoothlen              = 0.012f;
        public float PressureStiffness      = 200.0f;
        public float RestDensity            = 1000.0f;
        public float ParticleMass           = 0.0002f;
        public float Viscosity              = 0.1f;
        public float MaxAllowableTimeStep   = 0.005f;
        
        public Vector3 Gravity = new Vector3(0.0f, -0.5f, 0.0f);
        public float GravityToCenter = 0.0f;

        public Vector3 DomainCenter = new Vector3(0.0f, 0.0f, 0.0f);
        public float DomainSphereRadius = 1.0f;
        public float Restitution = 1.0f;
        public float MaxVelocity = 0.50f;

        int _numParticles;
        float _timeStep;
        float _smoothlen;
        float _pressureStiffness;
        float _restDensity;
        float _densityCoef;
        float _gradPressureCoef;
        float _lapViscosityCoef;
        float _particleMass;
        Vector4 _gravity;

        ComputeBuffer _particlesBufferRead;
        ComputeBuffer _particlesBufferWrite;
        ComputeBuffer _particlesDensityBuffer;
        ComputeBuffer _particlesForceBuffer;

        [SerializeField]
        ComputeShader _kernelCS;

        [SerializeField]
        bool _needToReset = true;

        [SerializeField]
        bool _enableSimulation = true;
        public bool enableSimulation { get { return _enableSimulation; } set { _enableSimulation = value; } }

        public ComputeBuffer GetParticlesBuffer()
        {
            return this._particlesBufferRead;
        }

        public ComputeBuffer GetParticlesDensityBuffer()
        {
            return this._particlesDensityBuffer;
        }

        public int GetParticleNum()
        {
            return this._numParticles;
        }

        void Start()
        {
            if (_needToReset == true)
            {
                InitParams();
                ReleaseResources();
                InitResources();
                _needToReset = false;
            }
        }

        void Update()
        {
            if(_enableSimulation)
            {
                UpdateParams();
                Simulation();
            }
        }

        void OnDestroy()
        {
            ReleaseResources();
        }

        void InitResources()
        {

            _particlesBufferRead    = new ComputeBuffer((int)_numParticles, Marshal.SizeOf(typeof(FluidParticle)));
            _particlesBufferWrite   = new ComputeBuffer((int)_numParticles, Marshal.SizeOf(typeof(FluidParticle)));
            _particlesForceBuffer   = new ComputeBuffer((int)_numParticles, Marshal.SizeOf(typeof(FluidParticleForces)));
            _particlesDensityBuffer = new ComputeBuffer((int)_numParticles, Marshal.SizeOf(typeof(FluidParticleDensity)));

            FluidParticle[] particles = new FluidParticle[_numParticles];

            for (var i = 0; i < _numParticles; i++)
            {
                particles[i].Position = Random.insideUnitSphere * 0.01f;
                particles[i].Velocity = Vector3.zero;
            }

            _particlesBufferRead.SetData(particles);
            _particlesBufferWrite.SetData(particles);

            particles = null;
        }

        void ReleaseResources()
        {
            // particleBuffer
            if (_particlesBufferRead != null)
            {
                _particlesBufferRead.Release();
            }
            _particlesBufferRead = null;

            if (_particlesBufferWrite != null)
            {
                _particlesBufferWrite.Release();
            }
            _particlesBufferWrite = null;

            // particleForces
            if (_particlesForceBuffer != null)
            {
                _particlesForceBuffer.Release();
            }
            _particlesForceBuffer = null;

            // particleDensity
            if (_particlesDensityBuffer != null)
            {
                _particlesDensityBuffer.Release();
            }
            _particlesDensityBuffer = null;
        }

        void InitParams()
        {
            switch (ParticleNum)
            {
                case NumParticlesSet.NUM_8K:
                    _numParticles = 1024 * 8;
                    break;
                case NumParticlesSet.NUM_16K:
                    _numParticles = 1024 * 16;
                    break;
                case NumParticlesSet.NUM_32K:
                    _numParticles = 1024 * 32;
                    break;
                default:
                    _numParticles = 1024 * 8;
                    break;
            }
        }

        void UpdateParams()
        {
            _timeStep = Mathf.Min(MaxAllowableTimeStep, Time.deltaTime);
            _smoothlen = Smoothlen;
            _pressureStiffness = PressureStiffness;
            _restDensity = RestDensity;
            _densityCoef = ParticleMass * 315.0f / (64.0f * Mathf.PI * Mathf.Pow(Smoothlen, 9.0f));
            _gradPressureCoef = ParticleMass * -45.0f / (Mathf.PI * Mathf.Pow(Smoothlen, 6.0f));
            _lapViscosityCoef = ParticleMass * Viscosity * 45.0f / (Mathf.PI * Mathf.Pow(Smoothlen, 6.0f));

            _gravity = new Vector4(Gravity.x, Gravity.y, Gravity.z, GravityToCenter);
        }

        void Simulation()
        {
            ComputeShader cs = _kernelCS;
            int id = 0;

            cs.SetInt("_NumParticles", _numParticles);
            cs.SetFloat("_TimeStep", _timeStep);
            cs.SetFloat("_Smoothlen", _smoothlen);
            cs.SetFloat("_PressureStiffness", _pressureStiffness);
            cs.SetFloat("_RestDensity", _restDensity);
            cs.SetFloat("_DensityCoef", _densityCoef);
            cs.SetFloat("_GradPressureCoef", _gradPressureCoef);
            cs.SetFloat("_LapViscosityCoef", _lapViscosityCoef);
            cs.SetVector("_Gravity", _gravity);
            cs.SetVector("_DomainCenter", new Vector4(DomainCenter.x, DomainCenter.y, DomainCenter.z, 0.0f));
            cs.SetFloat("_DomainSphereRadius", DomainSphereRadius);
            cs.SetFloat("_Restitution", Restitution);
            cs.SetFloat("_MaxVelocity", MaxVelocity);
            
            // Density
            id = cs.FindKernel("DensityCS_Shared");
            cs.SetBuffer(id, "_ParticlesRead",  _particlesBufferRead);
            cs.SetBuffer(id, "_ParticlesDensityWrite", _particlesDensityBuffer);
            cs.Dispatch(id, _numParticles / (int)SIMULATION_BLOCK_SIZE, 1, 1);
            

            // Force
            id = cs.FindKernel("ForceCS_Shared");
            cs.SetBuffer(id, "_ParticlesRead", _particlesBufferRead);
            cs.SetBuffer(id, "_ParticlesDensityRead", _particlesDensityBuffer);
            cs.SetBuffer(id, "_ParticlesForceWrite", _particlesForceBuffer);
            cs.Dispatch(id, _numParticles / (int)SIMULATION_BLOCK_SIZE, 1, 1);

            // Integrate
            id = cs.FindKernel("IntegrateCS");
            cs.SetBuffer(id, "_ParticlesRead", _particlesBufferRead);
            cs.SetBuffer(id, "_ParticlesForceRead", _particlesForceBuffer);
            cs.SetBuffer(id, "_ParticlesWrite", _particlesBufferWrite);
            cs.Dispatch(id, _numParticles / (int)SIMULATION_BLOCK_SIZE, 1, 1);
            SwapBuffer(ref _particlesBufferRead, ref _particlesBufferWrite);
        }

        void SwapBuffer(ref ComputeBuffer ping, ref ComputeBuffer dest)
        {
            ComputeBuffer temp = dest;
            dest = ping;
            ping = temp;
        }
    }
}