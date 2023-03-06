using System.Collections;
using System.Collections.Generic;
using System.Runtime.InteropServices;

using UnityEngine;

namespace CellularGrowth
{

    [StructLayout (LayoutKind.Sequential)]
    public struct Particle_t 
    {
        public Vector2 position;
        public Vector2 velocity;
        public float radius;
        public float threshold;
        public int links;
        public uint alive;
    }

}


