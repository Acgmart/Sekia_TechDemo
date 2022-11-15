using System;
using UnityEngine;

namespace Sekia
{
    [Serializable]
    public class Bezier3D_Node
    {
        [SerializeField]
        public Vector3 Position;
        [SerializeField]
        public Vector3 Direction; //tangent
        public float roll = 0; //横截面的旋转
        public Vector2 scale = Vector2.one; //横截面的缩放

        public Bezier3D_Node(Vector3 position, Vector3 direction)
        {
            Position = position;
            Direction = direction;
        }
    }
}
