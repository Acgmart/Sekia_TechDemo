using System.Runtime.InteropServices;
using UnityEngine;
using UnityEngine.Assertions;

namespace StrangeAttractors
{
    public class LorenzAttrator : StrangeAttractor
    {
        [Header("Lorenz values are p:10, r:28, b:8/3")]
        [SerializeField, Tooltip("Default is 10")]
        float p = 10f;
        [SerializeField, Tooltip("Default is 28")]
        float r = 28f;
        [SerializeField, Tooltip("Default is 8/3")]
        float b = 2.666667f;

        private int pId, rId, bId;
        private string pProp = "p", rProp = "r", bProp = "b";

        protected override void Initialize()
        {
            Assert.IsTrue(computeShader.name == "LorenzAttractor", "Please set LorenzAttractor.compute");
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
                var normalize = (float)i / instanceCount;
                var color = gradient.Evaluate(normalize);
                parameters[i] = new Params(Random.insideUnitSphere * emitterSize * normalize, particleSize, color);
            }
            cBuffer.SetData(parameters);
        }

        protected override void InitializeShaderUniforms()
        {
            pId = Shader.PropertyToID(pProp);
            rId = Shader.PropertyToID(rProp);
            bId = Shader.PropertyToID(bProp);
        }

        protected override void UpdateShaderUniforms()
        {
            computeShaderInstance.SetFloat(pId, p);
            computeShaderInstance.SetFloat(rId, r);
            computeShaderInstance.SetFloat(bId, b);
        }
    }
}