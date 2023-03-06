using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Kodai
{

    public enum NumParticles
    {
        NUM_1K = 1024,
        NUM_2K = 1024 * 2,
        NUM_4K = 1024 * 4,
        NUM_8K = 1024 * 8,
        NUM_16K = 1024 * 16,
        NUM_32K = 1024 * 32,
        NUM_64K = 1024 * 64,
        NUM_128K = 1024 * 128,
        NUM_256K = 1024 * 256,
        NUM_512K = 1024 * 512
    }


    public struct Body
    {
        public Vector3 position;
        public Vector3 velocity;
        public float mass;
    }
}