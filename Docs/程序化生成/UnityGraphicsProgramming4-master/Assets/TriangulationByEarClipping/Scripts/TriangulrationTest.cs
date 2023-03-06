using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace EarClippingTriangulation {
    /// <summary>
    /// 決め打ち座標で多角形を作成する
    /// </summary>
    public class TriangulrationTest : MonoBehaviour {
        
        public ArrayVector3[] nestedVertices;

        
        // Use this for initialization
        void Start() {
            Triangulation tri = GetComponent<Triangulation>();

            if(tri != null)
            {

                for (int i = 0; i < nestedVertices.Length; i++)
                {
                    //DrawPolygon(ref nestedVertices[i].array, Color.HSVToRGB((float)i / nestedVertices.Length, 1, 1));
                    tri.AddPolygon(new Polygon(nestedVertices[i].array));
                }

                tri.Triangulate();
            }
        }

        void DrawPolygon(ref Vector3[] vertices, Color color, int index)
        {
            Gizmos.color = color;
            Vector3 centerPos = Vector3.zero;

            for (int i = 0; i < vertices.Length; i++)
            {
                int nextIndex = (i + 1) % vertices.Length;

                Gizmos.DrawLine(vertices[i], vertices[nextIndex]);
                centerPos += vertices[i];
#if UNITY_EDITOR
                UnityEditor.Handles.Label(vertices[i], "[" + i + "]");
#endif
            }
            centerPos /= vertices.Length;

#if UNITY_EDITOR
            UnityEditor.Handles.Label(centerPos, "{" + index + "}");
#endif
        }

        private void OnDrawGizmos()
        {
            if (!Application.isPlaying)
            {
                for(int i = 0; i < nestedVertices.Length; i++)
                {
                    DrawPolygon(ref nestedVertices[i].array, Color.HSVToRGB((float)i / nestedVertices.Length, 1, 1), i);
                }
            }
        }

    }

}