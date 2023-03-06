using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace EarClippingTriangulation
{
    public class Triangle
    {

        public Vector3[] vertices = new Vector3[3];
        public string name;

        public Triangle(Vector3 p1, Vector3 p2, Vector3 p3, string n)
        {
            vertices[0] = p1;
            vertices[1] = p2;
            vertices[2] = p3;
            name = n;
        }

#if UNITY_EDITOR
        public void OnDrawGizmos()
        {
            Gizmos.color = Color.magenta;
            Vector3 center = Vector3.zero;
            for (int i = 0; i < vertices.Length; i++)
            {
                int nextIndex = (i + 1) % vertices.Length;
                Gizmos.DrawLine(vertices[i], vertices[nextIndex]);
                center += vertices[i];            
            }

            center.x /= 3;
            center.y /= 3;
            center.z /= 3;

            UnityEditor.Handles.Label(center, name);
        }
#endif
    }
}