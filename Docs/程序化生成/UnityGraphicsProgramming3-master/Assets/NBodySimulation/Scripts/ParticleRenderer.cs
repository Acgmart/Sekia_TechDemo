using UnityEngine;

namespace Kodai
{

    public class ParticleRenderer : MonoBehaviour
    {

        [SerializeField] GameObject simObject;

        [SerializeField] Material particleRenderMat;

        IParticleRenderable simScript;

        private void Start()
        {
            simScript = simObject.GetComponent<IParticleRenderable>();

        }

        private void OnRenderObject()
        {

            particleRenderMat.SetPass(0);
            particleRenderMat.SetBuffer("_Particles", simScript.GetParticleBuffer());

            Graphics.DrawProcedural(MeshTopology.Points, simScript.GetParticleNum());


        }
    }

}