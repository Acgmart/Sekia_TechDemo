using UnityEngine;

public interface IParticleRenderable
{
    ComputeBuffer GetParticleBuffer();
    int GetParticleNum();
}