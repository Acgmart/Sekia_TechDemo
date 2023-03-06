using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace EarClippingTriangulation
{
    /// <summary>
    /// マウスで頂点を配置して多角形を作成する
    /// </summary>
    public class DrawingTest : MonoBehaviour
    {
        [SerializeField]
        Camera camera;
        [SerializeField]
        Transform marker;

        Material lineMaterial;
        Triangulation tri;

        List<Vector3> points = new List<Vector3>();

        List<ArrayVector3> pointList = new List<ArrayVector3>();

        // Start is called before the first frame update
        void Start()
        {
            tri = GetComponent<Triangulation>();
           
        }

        // Update is called once per frame
        void Update()
        {
            // 左クリックで点を打つ
            if (Input.GetMouseButtonDown(0))
            {
                Vector3 pos = Input.mousePosition;
                pos.z = 5;
                Vector3 worldPos = camera.ScreenToWorldPoint(pos);
                marker.position = worldPos;

                Debug.Log("pos " + pos + " worldPos " + worldPos);
                points.Add(worldPos);
            }

            // 右クリックで三角形分割する
            if (Input.GetMouseButtonDown(1) && (points.Count > 2))
            {
                ArrayVector3 array = new ArrayVector3();
                array.array = points.ToArray();
                pointList.Add(array);
                points.Clear();
                
                Triangulation();
            }

            if (Input.GetKeyDown(KeyCode.C))
            {
                pointList.Clear();
                points.Clear();
                if (tri != null)
                {
                    tri.ClearPolygon();
                }
            }

            if(Input.GetKeyDown(KeyCode.U))
            {
                pointList.RemoveAt(pointList.Count - 1);
                points.Clear();
                Triangulation();
            }
        }

        void Triangulation()
        {
            if (tri != null)
            {
                tri.ClearPolygon();

                for (int i = 0; i < pointList.Count; i++)
                {
                    tri.AddPolygon(new Polygon(pointList[i].array));
                }

                tri.Triangulate();
            }
        }

        private void OnRenderObject()
        {
            if (points.Count == 0)
                return;

            if (!lineMaterial)
            {
                // Unity has a built-in shader that is useful for drawing
                // simple colored things.
                Shader shader = Shader.Find("Hidden/Internal-Colored");
                lineMaterial = new Material(shader);
                lineMaterial.hideFlags = HideFlags.HideAndDontSave;
                // Turn on alpha blending
                lineMaterial.SetInt("_SrcBlend", (int)UnityEngine.Rendering.BlendMode.SrcAlpha);
                lineMaterial.SetInt("_DstBlend", (int)UnityEngine.Rendering.BlendMode.OneMinusSrcAlpha);
                // Turn backface culling off
                lineMaterial.SetInt("_Cull", (int)UnityEngine.Rendering.CullMode.Off);
                // Turn off depth writes
                lineMaterial.SetInt("_ZWrite", 0);
            }

            // Apply the line material
            lineMaterial.SetPass(0);

            GL.PushMatrix();
            // Set transformation matrix for drawing to
            // match our transform
            GL.MultMatrix(transform.localToWorldMatrix);

            // Draw lines
            GL.Begin(GL.LINE_STRIP);
            for (int i = 0; i <= points.Count; ++i)
            {
                int index = i % points.Count;
                // Vertex colors change from red to green
                GL.Color(Color.HSVToRGB(Mathf.Sin(Time.time * 0.5f) * 0.5f + 0.5f, 1, 1));
                // One vertex at transform position
                GL.Vertex(points[index]);
            }
            GL.End();
            GL.PopMatrix();
        }

        void DrawPolygon(Vector3[] vertices, Color color)
        {
            Gizmos.color = color;
            for (int i = 0; i < vertices.Length; i++)
            {
                int nextIndex = (i + 1) % vertices.Length;

                Gizmos.DrawLine(vertices[i], vertices[nextIndex]);
#if UNITY_EDITOR
                UnityEditor.Handles.color = color;
                UnityEditor.Handles.Label(vertices[i], "[" + i + "]");
#endif
            }
        }

        private void OnDrawGizmos()
        {
            DrawPolygon(points.ToArray(), Color.magenta);
        }
    }
}