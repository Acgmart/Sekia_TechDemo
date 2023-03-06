using System.Runtime.InteropServices;
using UnityEngine;
using UnityEngine.Assertions;

namespace StrangeAttractors
{
    public class ThomasAttractor : StrangeAttractor
    {
        [SerializeField, Tooltip("Default is 0.32899f")]
        float b = 0.32899f;

        private int bId;
        private string bProp = "b";

        protected sealed override void Initialize()
        {
            Assert.IsTrue(computeShader.name == "ThomasAttractor", "Please set AizawaAttractor.compute");
            base.Initialize();
        }

        protected sealed override void InitializeComputeBuffer()
        {
            if (cBuffer != null)
                cBuffer.Release();

            cBuffer = new ComputeBuffer(instanceCount, Marshal.SizeOf(typeof(Params)));
            Params[] parameters = new Params[cBuffer.count];
            for (int i = 0; i < instanceCount; i++)
            {
                var rs = Random.insideUnitSphere;
                var color = gradient.Evaluate(rs.magnitude);
                parameters[i] = new Params(rs * emitterSize, particleSize, color);
            }
            cBuffer.SetData(parameters);
        }

        protected override void InitializeShaderUniforms()
        {
            bId = Shader.PropertyToID(bProp);
        }

        protected override void UpdateShaderUniforms()
        {
            computeShaderInstance.SetFloat(bId, b);
        }
    }
}