using System;
using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

namespace Sekia
{
    [CustomEditor(typeof(Bezier3D_Line))]
    public class Bezier3D_Line_Editor : Editor
    {
        #region 渲染曲线/节点坐标/切线
        private const int QUAD_SIZE = 12;
        private static Color CURVE_COLOR = new Color(0.8f, 0.8f, 0.8f);
        private static Color CURVE_BUTTON_COLOR = new Color(0.2f, 0.6f, 0.8f);
        private static Color DIRECTION_LINE_COLOR = Color.cyan;
        private static Color DIRECTION_BUTTON_COLOR = Color.red;
        [Range(0, 1f)]
        private static float curvature = 0.5f;

        private enum SelectionType
        {
            Node,
            Direction,
            InverseDirection
        }
        private SelectionType selectionType;

        private GUIStyle nodeButtonStyle, directionButtonStyle;
        private int selectedNodeIndex;
        private Bezier3D_Line _target;
        #endregion

        #region Line to Mesh
        private static bool generareMesh = false;
        private static Material meshMaterial;
        private static Mesh meshInput;
        private static Collider meshColider;
        private Vector3 meshPositionOffset = Vector3.zero;
        private Vector3 meshRotationOffset = new Vector3(0, 90, 0);
        private Vector2 meshScaleOffset = new Vector2(0.1f, 0.1f);
        private bool curveHasChanged = false;
        private string meshPath;
        #endregion

        private void OnEnable()
        {
            _target = target as Bezier3D_Line;

            Texture2D t = new Texture2D(1, 1);
            t.SetPixel(0, 0, CURVE_BUTTON_COLOR);
            t.Apply();
            nodeButtonStyle = new GUIStyle();
            nodeButtonStyle.normal.background = t;

            t = new Texture2D(1, 1);
            t.SetPixel(0, 0, DIRECTION_BUTTON_COLOR);
            t.Apply();
            directionButtonStyle = new GUIStyle();
            directionButtonStyle.normal.background = t;
        }

        void OnSceneGUI()
        {
            bool Button(Vector2 position, GUIStyle style)
            {
                return GUI.Button(new Rect(position - new Vector2(QUAD_SIZE / 2, QUAD_SIZE / 2), new Vector2(QUAD_SIZE, QUAD_SIZE)), GUIContent.none, style);
            }

            if (Selection.activeGameObject == _target.gameObject)
            {
                if (!_target.enabled)
                {
                    Tools.current = Tool.Move;
                }
                else
                {
                    Tools.current = Tool.None;
                    if (selectedNodeIndex >= _target.nodes.Count)
                        selectedNodeIndex = 0;
                }
            }

            if (!_target.enabled)
                return;

            Bezier3D_Node selection = _target.nodes[selectedNodeIndex];

            if (selectionType == SelectionType.Node)
            {
                var posWS = _target.transform.TransformPoint(selection.Position);
                posWS = Handles.PositionHandle(posWS, _target.transform.rotation);
                Vector3 posOS = _target.transform.InverseTransformPoint(posWS);
                if (posOS != selection.Position)
                {
                    Undo.RecordObject(target, $"Moved node {selectedNodeIndex} of {_target.name}");
                    selection.Direction += posOS - selection.Position;
                    selection.Position = posOS;
                    curveHasChanged = true;
                }
            }
            else if (selectionType == SelectionType.Direction)
            {
                var posWS = _target.transform.TransformPoint(selection.Direction);
                posWS = Handles.PositionHandle(posWS, Quaternion.identity);
                var posOS = _target.transform.InverseTransformPoint(posWS);
                if (posOS != selection.Direction)
                {
                    Undo.RecordObject(target, $"Changed direction of node {selectedNodeIndex} in {_target.name}");
                    selection.Direction = posOS;
                    curveHasChanged = true;
                }
            }
            else if (selectionType == SelectionType.InverseDirection)
            {
                var posWS_Inv = 2 * selection.Position - selection.Direction;
                var posWS = _target.transform.TransformPoint(posWS_Inv);
                posWS = Handles.PositionHandle(posWS, Quaternion.identity);
                var posOS = _target.transform.InverseTransformPoint(posWS);
                posOS = 2 * selection.Position - posOS;
                if (posOS != selection.Direction)
                {
                    Undo.RecordObject(target, $"Changed inverse-direction of node {selectedNodeIndex} in {_target.name}");
                    selection.Direction = posOS;
                    curveHasChanged = true;
                }
            }

            Handles.BeginGUI();
            int nIdx = -1;

            for (int i = 0; i < _target.nodes.Count; i++)
            {
                Bezier3D_Node n1 = _target.nodes[i];
                Transform transform = _target.transform;
                ++nIdx;
                var pos = transform.TransformPoint(n1.Position);
                var dir = transform.TransformPoint(n1.Direction);
                var invDir = transform.TransformPoint(2 * n1.Position - n1.Direction);
                Vector3 guiPos = HandleUtility.WorldToGUIPoint(pos);

                if (n1 == selection)
                {
                    Vector3 guiDir = HandleUtility.WorldToGUIPoint(dir);
                    Vector3 guiInvDir = HandleUtility.WorldToGUIPoint(invDir);
                    Handles.color = DIRECTION_LINE_COLOR;
                    Handles.DrawLine(guiDir, guiInvDir);

                    if (selectionType != SelectionType.Node)
                        if (Button(guiPos, nodeButtonStyle))
                            selectionType = SelectionType.Node;

                    //切线两端
                    if (selectionType != SelectionType.Direction)
                        if (Button(guiDir, directionButtonStyle))
                            selectionType = SelectionType.Direction;
                    if (selectionType != SelectionType.InverseDirection)
                        if (Button(guiInvDir, directionButtonStyle))
                            selectionType = SelectionType.InverseDirection;
                }
                else
                {
                    if (Button(guiPos, nodeButtonStyle))
                    {
                        Undo.RecordObject(target, $"Selected node {nIdx} of {_target.name}");
                        selection = n1;
                        selectedNodeIndex = nIdx;
                        selectionType = SelectionType.Node;
                        EditorUtility.SetDirty(target);
                    }
                }
            }
            Handles.EndGUI();

            if (GUI.changed)
                EditorUtility.SetDirty(target);
        }

        public override void OnInspectorGUI()
        {
            #region 曲线编辑
            serializedObject.Update();

            if (selectedNodeIndex >= _target.nodes.Count)
                selectedNodeIndex = 0;

            curvature = EditorGUILayout.Slider("平滑度", curvature, 0, 1);
            if (GUILayout.Button("平滑路径"))
            {
                for (int i = 0; i < _target.nodes.Count; i++)
                {
                    var node = _target.nodes[i];
                    var pos = node.Position;
                    var dir = Vector3.zero;
                    float averageMagnitude = 0;
                    if (i != 0)
                    {
                        var previousPos = _target.nodes[i - 1].Position;
                        var toPrevious = pos - previousPos;
                        averageMagnitude += toPrevious.magnitude;
                        dir += toPrevious.normalized;
                    }
                    if (i != _target.nodes.Count - 1)
                    {
                        var nextPos = _target.nodes[i + 1].Position;
                        var toNext = pos - nextPos;
                        averageMagnitude += toNext.magnitude; //流动距离的均值
                        dir -= toNext.normalized; //流动方向的均值
                    }
                    averageMagnitude *= 0.5f;
                    dir = dir.normalized * averageMagnitude * curvature;
                    node.Direction = dir + pos;
                }
                curveHasChanged = true;
                SceneView.RepaintAll();
            }

            Bezier3D_Node selection = _target.nodes[selectedNodeIndex];
            if (selection == null)
                GUI.enabled = false;

            if (GUILayout.Button("Add node after selected"))
            {
                Undo.RecordObject(_target, "add spline node");

                if (selectedNodeIndex == _target.nodes.Count - 1) //在尾部增加
                {
                    //Direction是切线矢量的终点
                    Bezier3D_Node newNode = new Bezier3D_Node(selection.Direction, selection.Direction + selection.Direction - selection.Position);
                    _target.AddNode(newNode);
                    selection = newNode;
                }
                else //插队 取相邻节点的平均值
                {
                    Bezier3D_Curve curve = _target.nodeAsN1toCurve[selection];
                    var position = curve.GetLocation(0.5f);
                    var tangent = curve.GetTangent(0.5f);
                    Bezier3D_Node newNode = new Bezier3D_Node(position, position + tangent);
                    _target.InsertNode(selectedNodeIndex + 1, newNode);
                    selection = newNode;
                }
                selectedNodeIndex = selectedNodeIndex + 1;
                serializedObject.Update();
                curveHasChanged = true;
                SceneView.RepaintAll();
            }
            GUI.enabled = true;

            if (selection == null || _target.nodes.Count <= 2 || selectedNodeIndex == 0)
                GUI.enabled = false;
            if (GUILayout.Button("Delete selected node"))
            {
                Undo.RecordObject(_target, "delete spline node");
                _target.RemoveNode(selection);
                selectedNodeIndex = selectedNodeIndex - 1;
                selection = _target.nodes[selectedNodeIndex];
                serializedObject.Update();
                curveHasChanged = true;
                SceneView.RepaintAll();
            }
            GUI.enabled = true;

            GUI.enabled = false;
            SerializedProperty nodesProp = serializedObject.FindProperty("nodes");
            EditorGUILayout.PropertyField(nodesProp); //不可编辑
            GUI.enabled = true;

            if (selection != null)
            {
                SerializedProperty nodeProp = nodesProp.GetArrayElementAtIndex(selectedNodeIndex);
                EditorGUILayout.LabelField($"Selected node (node{selectedNodeIndex})");

                EditorGUI.indentLevel++;
                var positionProp = nodeProp.FindPropertyRelative("Position");
                var directionProp = nodeProp.FindPropertyRelative("Direction");
                var scaleProp = nodeProp.FindPropertyRelative("scale");
                var rollProp = nodeProp.FindPropertyRelative("roll");
                EditorGUI.BeginChangeCheck();
                EditorGUILayout.PropertyField(positionProp, new GUIContent("Position"));
                EditorGUILayout.PropertyField(directionProp, new GUIContent("Direction"));
                EditorGUILayout.PropertyField(scaleProp, new GUIContent("Scale"));
                EditorGUILayout.PropertyField(rollProp, new GUIContent("Roll"));
                if (EditorGUI.EndChangeCheck())
                {
                    selection.Position = positionProp.vector3Value;
                    selection.Direction = directionProp.vector3Value;
                    selection.scale = scaleProp.vector2Value;
                    selection.roll = rollProp.floatValue;
                    serializedObject.Update();
                    curveHasChanged = true;
                    SceneView.RepaintAll();
                }
                EditorGUI.indentLevel--;
            }
            else
            {
                EditorGUILayout.LabelField("No selected node");
            }
            #endregion

            #region Mesh编辑
            GUILayout.Space(5);
            EditorGUILayout.LabelField("Line to Mesh");
            generareMesh = EditorGUILayout.Toggle("生成mesh", generareMesh);
            if (generareMesh)
            {
                //指定生成参数
                EditorGUI.BeginChangeCheck();
                meshMaterial = (Material)EditorGUILayout.ObjectField(new GUIContent("输入材质",
                    "用于提供给新生成的MeshRenderer的材质"), meshMaterial, typeof(Material), allowSceneObjects: false);
                meshInput = (Mesh)EditorGUILayout.ObjectField(new GUIContent("输入Mesh",
                    "用于编辑的mesh"), meshInput, typeof(Mesh), allowSceneObjects: false);
                meshColider = (Collider)EditorGUILayout.ObjectField(new GUIContent("吸附目标",
                    "将生成的mesh吸附于目标Colider"), meshColider, typeof(Collider), allowSceneObjects: true);
                meshPositionOffset = EditorGUILayout.Vector3Field(new GUIContent("位置偏移"), meshPositionOffset);
                meshRotationOffset = EditorGUILayout.Vector3Field(new GUIContent("旋转偏移"), meshRotationOffset);
                meshScaleOffset = EditorGUILayout.Vector2Field(new GUIContent("缩放偏移"), meshScaleOffset);
                if ((curveHasChanged || EditorGUI.EndChangeCheck()) && meshMaterial != null && meshInput != null)
                {
                    curveHasChanged = false;
                    //多个曲线生成一个mesh 配套MeshRenderer
                    //当移除脚本后可当普通模型使用
                    GameObject rootObj;
                    string rootName = "segement";
                    var rootTransform = _target.transform.Find(rootName);

                    //创建Root
                    if (rootTransform == null)
                    {
                        rootObj = new GameObject(rootName);
                        rootObj.transform.parent = _target.transform;
                        rootObj.transform.localPosition = Vector3.zero;
                        rootObj.transform.localScale = Vector3.one;
                        rootObj.transform.localRotation = Quaternion.identity;
                        rootObj.gameObject.AddComponent<MeshFilter>();
                        rootObj.gameObject.AddComponent<MeshRenderer>();
                    }
                    else
                    {
                        rootObj = rootTransform.gameObject;
                    }
                    rootObj.GetComponent<MeshRenderer>().material = meshMaterial;

                    //生成mesh
                    int curveCount = _target.nodes.Count - 1;
                    Mesh[] meshes = new Mesh[curveCount];
                    for (int i = 0; i < curveCount; i++)
                    {
                        Bezier3D_Node n1 = _target.nodes[i];
                        Bezier3D_Curve curve = _target.nodeAsN1toCurve[n1];
                        meshes[i] = GenerateMesh(meshInput, curve,
                            meshPositionOffset, Quaternion.Euler(meshRotationOffset), meshScaleOffset);

                        Mesh GenerateMesh(Mesh mesh, Bezier3D_Curve curve, Vector3 translation, Quaternion rotation, Vector2 scale)
                        {
                            int[] GetReversedTriangles(Mesh mesh)
                            {
                                int[] res = mesh.triangles.Clone() as int[];
                                var triangleCount = res.Length / 3;
                                for (var i = 0; i < triangleCount; i++)
                                {
                                    var tmp = res[i * 3];
                                    res[i * 3] = res[i * 3 + 1];
                                    res[i * 3 + 1] = tmp;
                                }
                                return res;
                            }

                            float minX = float.MaxValue;
                            float maxX = float.MinValue;

                            //根据负缩放轴数 反转三角面 避免Culling
                            bool reversed = scale.x < 0;
                            if (scale.y < 0) reversed = !reversed;

                            //应用本地rotation/translation/scale 
                            int vertexCount = mesh.vertexCount;
                            Vector3[] position = new Vector3[vertexCount];
                            Vector3[] normal = new Vector3[vertexCount];
                            for (var i = 0; i < vertexCount; i++)
                            {
                                position[i] = mesh.vertices[i];
                                normal[i] = mesh.normals[i];

                                if (rotation != Quaternion.identity)
                                {
                                    position[i] = rotation * position[i];
                                    normal[i] = rotation * normal[i];
                                }

                                if (scale != Vector2.one)
                                {
                                    position[i].y = position[i].y * scale.x;
                                    position[i].z = position[i].z * scale.y;
                                }

                                minX = Math.Min(minX, position[i].x);
                                maxX = Math.Max(maxX, position[i].x);

                                if (translation != Vector3.zero)
                                    position[i] += translation;
                            }

                            float length = Math.Abs(maxX - minX);

                            //本地坐标转化为沿着切线的偏移
                            for (var i = 0; i < vertexCount; i++)
                            {
                                float distanceRate = Math.Abs(position[i].x - minX) / length;

                                float sampleRoll = Mathf.Lerp(curve.n1.roll, curve.n2.roll, distanceRate);
                                Vector2 sampleScale = Vector2.Lerp(curve.n1.scale, curve.n2.scale, distanceRate);
                                Vector3 samplePosition = curve.GetLocation(distanceRate);
                                Vector3 sampleTangent = curve.GetTangent(distanceRate).normalized;

                                position[i] = Vector3.Scale(position[i], new Vector3(0, sampleScale.y, sampleScale.x));
                                position[i] = Quaternion.AngleAxis(sampleRoll, Vector3.right) * position[i];
                                normal[i] = Quaternion.AngleAxis(sampleRoll, Vector3.right) * normal[i];
                                position[i].x = 0;

                                var upVector = Vector3.Cross(sampleTangent, Vector3.Cross(Quaternion.AngleAxis(sampleRoll, Vector3.forward) * Vector3.up, sampleTangent).normalized);
                                Quaternion sampleRotation = Quaternion.LookRotation(sampleTangent, upVector);
                                Quaternion q = sampleRotation * Quaternion.Euler(0, -90, 0);
                                position[i] = q * position[i] + samplePosition;
                                normal[i] = q * normal[i];
                            }

                            Mesh output = new Mesh();
                            output.vertices = position;
                            output.normals = normal;
                            output.uv = mesh.uv;
                            output.triangles = reversed ? GetReversedTriangles(mesh) : mesh.triangles;
                            output.RecalculateBounds();
                            output.RecalculateTangents();
                            return output;
                        }
                    }

                    List<CombineInstance> TheCombineInstances = new List<CombineInstance>();
                    for (int i = 0; i < curveCount; i++)
                    {
                        CombineInstance ci = new CombineInstance();
                        ci.mesh = meshes[i];
                        ci.subMeshIndex = 0;
                        TheCombineInstances.Add(ci);
                    }

                    Mesh m = new Mesh();
                    m.CombineMeshes(TheCombineInstances.ToArray(), true, false);
                    m.name = "segementMeshs";
                    m.RecalculateBounds();
                    m.RecalculateTangents();
                    string dirPath = "Assets/";
                    string prefabName = "GeneratedMesh_";
                    DateTime dt = DateTime.Now;
                    prefabName = prefabName + dt.Year.ToString().Substring(2);
                    prefabName = prefabName + dt.Month.ToString("00");
                    prefabName = prefabName + dt.Day.ToString("00");
                    prefabName = prefabName + dt.Hour.ToString("00");
                    prefabName = prefabName + dt.Minute.ToString("00");
                    prefabName = prefabName + dt.Second.ToString("00");
                    if (string.IsNullOrEmpty(meshPath))
                        meshPath = dirPath + "/" + prefabName + ".asset";
                    AssetDatabase.CreateAsset(m, meshPath);
                    rootObj.GetComponent<MeshFilter>().sharedMesh = m;
                }

                if (GUILayout.Button("当前节点吸附地面"))
                {
                    //先吸附顶点
                    {
                        Bezier3D_Node n1 = _target.nodes[selectedNodeIndex];
                        Vector3 origin = n1.Position;
                        origin = _target.transform.TransformPoint(origin);
                        origin.y += 1000;
                        Ray terrain = new Ray(origin, Vector3.down);
                        if (meshColider.Raycast(terrain, out var raycastHit, Mathf.Infinity))
                        {
                            Vector3 n1Offset = n1.Direction - n1.Position;
                            n1.Position = _target.transform.InverseTransformPoint(raycastHit.point);
                            n1.Direction = n1.Position + n1Offset;
                        }
                    }

                    //再吸附切线
                    {
                        Bezier3D_Node n1 = _target.nodes[selectedNodeIndex];
                        Vector3 origin = n1.Direction;
                        origin = _target.transform.TransformPoint(origin);
                        origin.y += 1000;
                        Ray terrain = new Ray(origin, Vector3.down);
                        if (meshColider.Raycast(terrain, out var raycastHit, Mathf.Infinity))
                        {
                            n1.Direction = _target.transform.InverseTransformPoint(raycastHit.point); ;
                        }
                    }
                    curveHasChanged = true;
                    SceneView.RepaintAll();
                }

                if (GUILayout.Button("曲线吸附地面"))
                {
                    for (int i = 0; i < _target.nodes.Count; i++)
                    {
                        //先吸附顶点
                        {
                            Bezier3D_Node n1 = _target.nodes[i];
                            Vector3 origin = n1.Position;
                            origin = _target.transform.TransformPoint(origin);
                            origin.y += 1000;
                            Ray terrain = new Ray(origin, Vector3.down);
                            if (meshColider.Raycast(terrain, out var raycastHit, Mathf.Infinity))
                            {
                                Vector3 n1Offset = n1.Direction - n1.Position;
                                n1.Position = _target.transform.InverseTransformPoint(raycastHit.point);
                                n1.Direction = n1.Position + n1Offset;
                            }
                        }

                        //再吸附切线
                        {
                            Bezier3D_Node n1 = _target.nodes[i];
                            Vector3 origin = n1.Direction;
                            origin = _target.transform.TransformPoint(origin);
                            origin.y += 1000;
                            Ray terrain = new Ray(origin, Vector3.down);
                            if (meshColider.Raycast(terrain, out var raycastHit, Mathf.Infinity))
                            {
                                n1.Direction = _target.transform.InverseTransformPoint(raycastHit.point); ;
                            }
                        }
                    }
                    curveHasChanged = true;
                    SceneView.RepaintAll();
                }

                if (GUILayout.Button("Mesh吸附地面"))
                {
                    string rootName = "segement";
                    var rootTransform = _target.transform.Find(rootName);
                    if (rootTransform == null)
                        return;
                    var meshFilter = rootTransform.gameObject.GetComponent<MeshFilter>();
                    if (meshFilter == null)
                        return;
                    var targetMesh = meshFilter.sharedMesh;
                    int vertexCount = targetMesh.vertexCount;
                    var vertexs = targetMesh.vertices;
                    for (int i = 0; i < vertexCount; i++)
                    {
                        Vector3 origin = vertexs[i];
                        origin = rootTransform.TransformPoint(origin);
                        origin.y += 1000;
                        Ray terrain = new Ray(origin, Vector3.down);
                        if (meshColider.Raycast(terrain, out var raycastHit, Mathf.Infinity))
                        {
                            vertexs[i] = rootTransform.InverseTransformPoint(raycastHit.point);
                        }
                    }
                    targetMesh.vertices = vertexs;
                    targetMesh.RecalculateBounds();
                    targetMesh.RecalculateTangents();
                }
            }
            #endregion
        }

        [DrawGizmo(GizmoType.InSelectionHierarchy)]
        static void DisplayUnselected(Bezier3D_Line target, GizmoType gizmoType)
        {
            for (int i = 0; i < target.nodes.Count - 1; i++)
            {
                Bezier3D_Node n1 = target.nodes[i];
                Bezier3D_Curve curve = target.nodeAsN1toCurve[n1];
                Transform transform = target.transform;
                Handles.DrawBezier(transform.TransformPoint(curve.n1.Position),
                    transform.TransformPoint(curve.n2.Position),
                    transform.TransformPoint(curve.n1.Direction),
                    transform.TransformPoint(curve.GetInverseDirection()),
                    CURVE_COLOR,
                    null,
                    3);
            }
        }
    }
}
