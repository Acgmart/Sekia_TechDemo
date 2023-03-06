using System.Collections;
using System.Collections.Generic;
using System.Runtime.InteropServices;

using UnityEngine;

namespace SpaceColonization
{

    [StructLayout (LayoutKind.Sequential)]
    public struct SkinnedCandidate 
    {
        public Vector3 position;
        public int node;
        public int bone;
    }

}


