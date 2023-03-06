using System.Collections;
using System.Collections.Generic;
using System.Runtime.InteropServices;

using UnityEngine;

namespace CellularGrowth
{

    [StructLayout (LayoutKind.Sequential)]
    public struct Edge_t 
    {
        public int a, b;
        public Vector2 force;
        uint alive;
    }

}


