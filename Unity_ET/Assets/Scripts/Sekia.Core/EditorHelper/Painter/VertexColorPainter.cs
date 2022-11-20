using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;
using System.Linq;
using System.Reflection;
#if UNITY_EDITOR
using UnityEditor;
#endif

#if UNITY_EDITOR
namespace Sekia
{
    [ExecuteInEditMode]
    public class VertexColorPainter : MonoBehaviour
    {
        public int curColorChannel; // All:0    R~A:1~4     RGB:5
        public Color brushColor;
        public float brushIntensity;

        public float brushSize = 0.1f;
        public float brushFalloff = 0.1f; //数值越大 笔刷边缘衰减越少
        public float brushOpacity = 1f;
    }

    [CustomEditor(typeof(VertexColorPainter))]
    public class VertexColorPainterEditor : Editor
    {
        private VertexColorPainter _target;
        private Mesh curMesh;
        private bool allowPainting = false;

        private const float MinBrushSize = 0.01f;
        public const float MaxBrushSize = 10f;

        private static Type type_HandleUtility;
        private static MethodInfo meth_IntersectRayMesh;
        private static object[] parameters = new object[4];

        private static GUIStyle _TitleStyle_hide;

        public static GUIStyle _TitleStyle
        {
            get
            {
                if (_TitleStyle_hide == null)
                {
                    _TitleStyle_hide = new GUIStyle(GUI.skin.button);
                    _TitleStyle_hide.normal.textColor = Color.red;
                    _TitleStyle_hide.fontStyle = FontStyle.Bold;
                }
                return _TitleStyle_hide;
            }
        }

        private void OnEnable()
        {
            var editorTypes = typeof(Editor).Assembly.GetTypes();
            type_HandleUtility = editorTypes.FirstOrDefault(t => t.Name == "HandleUtility");
            meth_IntersectRayMesh = type_HandleUtility.GetMethod("IntersectRayMesh", (BindingFlags.Static | BindingFlags.NonPublic));
        }

        public static bool IntersectRayMesh(Ray ray, Mesh mesh, Matrix4x4 matrix, out RaycastHit hit)
        {
            parameters[0] = ray;
            parameters[1] = mesh;
            parameters[2] = matrix;
            parameters[3] = null;
            bool result = (bool)meth_IntersectRayMesh.Invoke(null, parameters);
            hit = (RaycastHit)parameters[3];
            return result;
        }

        public override void OnInspectorGUI()
        {
            if (_target == null)
                _target = (VertexColorPainter)target;
            if (_target == null)
            {
                EditorGUILayout.HelpBox("当前目标为空", MessageType.Error);
                return;
            }
            if (curMesh == null)
            {
                MeshFilter curFilter = _target.gameObject.GetComponent<MeshFilter>();
                SkinnedMeshRenderer curSkinnned = _target.gameObject.GetComponent<SkinnedMeshRenderer>();
                if (curFilter)
                    curMesh = curFilter.sharedMesh;
                else if (curSkinnned)
                    curMesh = curSkinnned.sharedMesh;
            }
            if (curMesh == null)
            {
                EditorGUILayout.HelpBox("当前目标的mesh不存在", MessageType.Error);
                return;
            }

            //绘制状态切换 开始绘制GUI
            {
                GUILayout.BeginHorizontal();
                GUILayout.FlexibleSpace();
                if (GUILayout.Button("刷新", GUILayout.Height(25)))
                {
                    AssetDatabase.Refresh();
                    return;
                }
                GUIStyle boolBtnOn = new GUIStyle(GUI.skin.GetStyle("Button"));
                GUIContent guiContent = EditorGUIUtility.IconContent("EditCollider");
                allowPainting = GUILayout.Toggle(allowPainting, guiContent, boolBtnOn, GUILayout.Width(35), GUILayout.Height(25));
                if (allowPainting)
                    GUILayout.Label("Drawing", GUILayout.Height(25));
                GUILayout.FlexibleSpace();
                GUILayout.EndHorizontal();
            }

            //当切换到绘制模式时更改工具模式
            {
                if (allowPainting && Tools.current != Tool.None)
                    Tools.current = Tool.None;
            }

            {
                EditorGUILayout.BeginHorizontal(GUI.skin.box);
                {
                    EditorGUILayout.LabelField("顶点色调试关键字");

                    if (Shader.IsKeywordEnabled("_DEBUG_VERTEXCOLOR"))
                    {
                        if (GUILayout.Button("开启", _TitleStyle))
                        {
                            Shader.DisableKeyword("_DEBUG_VERTEXCOLOR");
                            SceneView.RepaintAll();
                        }
                    }
                    else
                    {
                        if (GUILayout.Button("关闭"))
                        {
                            Shader.EnableKeyword("_DEBUG_VERTEXCOLOR");
                            SceneView.RepaintAll();
                        }
                    }
                }
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.Space();
            }

            {
                if (curMesh.colors == null || curMesh.colors.Length == 0)
                {
                    EditorGUILayout.HelpBox("当前目标mesh没有顶点色通道", MessageType.Info);
                }
            }

            //选择笔刷的颜色通道
            GUILayout.BeginHorizontal();
            GUILayout.Label("目标通道", GUILayout.Width(90));
            string[] channelName = { "RGBA", "R", "G", "B", "A", "RGB" };
            int[] channelIds = { 0, 1, 2, 3, 4, 5 };
            _target.curColorChannel = EditorGUILayout.IntPopup(_target.curColorChannel,
                channelName, channelIds, GUILayout.Width(50));
            GUILayout.EndHorizontal();

            GUILayout.BeginHorizontal();
            if (_target.curColorChannel == 0)
                _target.brushColor = EditorGUILayout.ColorField("笔刷颜色", _target.brushColor);
            else if (_target.curColorChannel == 5)
                _target.brushColor = EditorGUILayout.ColorField(new GUIContent("笔刷颜色"),
                    _target.brushColor, true, false, false);
            else
                _target.brushIntensity = EditorGUILayout.Slider("笔刷颜色强度", _target.brushIntensity, 0, 1);

            if (GUILayout.Button("填充mesh顶点色"))
            {
                Vector3[] verts = curMesh.vertices;
                Color[] colors = curMesh.colors;
                int vertCount = verts.Length;
                if (colors == null || vertCount != colors.Length)
                    colors = new Color[verts.Length];
                if (_target.curColorChannel == 0 || _target.curColorChannel == 5)
                {
                    for (int i = 0; i < vertCount; i++)
                        colors[i] = ColorLerp(colors[i], _target.brushColor, 1, _target.curColorChannel);
                }
                else
                {
                    for (int i = 0; i < vertCount; i++)
                        colors[i] = OneChannelLerp(colors[i], _target.brushIntensity, 1, _target.curColorChannel);
                }
                curMesh.colors = colors;
            }

            GUILayout.EndHorizontal();
            _target.brushSize = EditorGUILayout.Slider("笔刷大小", _target.brushSize, MinBrushSize, MaxBrushSize);
            _target.brushOpacity = EditorGUILayout.Slider("笔刷透明度", _target.brushOpacity, 0, 1);
            _target.brushFalloff = EditorGUILayout.Slider("笔刷衰减", _target.brushFalloff, MinBrushSize, _target.brushSize);
        }

        private static Color OneChannelLerp(Color colorA, float intensity, float value, int channel)
        {
            if (channel == 1)
                return new Color(Mathf.Lerp(colorA.r, intensity, value), colorA.g, colorA.b, colorA.a);
            else if (channel == 2)
                return new Color(colorA.r, Mathf.Lerp(colorA.g, intensity, value), colorA.b, colorA.a);
            else if (channel == 3)
                return new Color(colorA.r, colorA.g, Mathf.Lerp(colorA.b, intensity, value), colorA.a);
            else if (channel == 4)
                return new Color(colorA.r, colorA.g, colorA.b, Mathf.Lerp(colorA.a, intensity, value));
            return Color.cyan;
        }

        private static Color ColorLerp(Color colorA, Color colorB, float value, int channel)
        {
            if (channel == 5)
                colorB.a = colorA.a;
            return Color.Lerp(colorA, colorB, value);
        }

        private void OnSceneGUI()
        {
            if (_target == null || curMesh == null || !allowPainting)
                return;
            //忽略Scene中选择其他物体 关闭绘制可解决
            HandleUtility.AddDefaultControl(GUIUtility.GetControlID(FocusType.Passive));

            Event e = Event.current;
            Ray worldRay = HandleUtility.GUIPointToWorldRay(e.mousePosition);
            if (_target != null && curMesh != null)
            {
                Matrix4x4 mtx = _target.transform.localToWorldMatrix;
                if (IntersectRayMesh(worldRay, curMesh, mtx, out var tempHit))
                {
                    Color discColor = getSolidDiscColor(_target.curColorChannel);
                    Handles.color = discColor;
                    Handles.DrawSolidDisc(tempHit.point, tempHit.normal, _target.brushSize);
                    Handles.color = new Color(discColor.r * 0.5f, discColor.g * 0.5f, discColor.b * 0.5f, discColor.a);
                    Handles.DrawWireDisc(tempHit.point, tempHit.normal, _target.brushSize);
                    Handles.DrawWireDisc(tempHit.point, tempHit.normal, _target.brushFalloff);

                    if (e.alt == false && e.control == false && e.shift == false && e.button == 0 &&
                    (e.type == EventType.MouseDrag || e.type == EventType.MouseDown))
                    {
                        Vector3[] verts = curMesh.vertices;
                        Color[] colors = curMesh.colors;
                        int vertCount = verts.Length;
                        if (colors == null || vertCount != colors.Length)
                            colors = new Color[verts.Length];

                        for (int i = 0; i < verts.Length; i++)
                        {
                            Vector3 vertPos = _target.transform.TransformPoint(verts[i]);

                            //以碰撞点为中心 笔刷宽度为半径的球体为笔刷范围
                            float mag = (vertPos - tempHit.point).magnitude;
                            if (mag > _target.brushSize)
                                continue;

                            //笔刷透明度中间为1 边缘为0
                            float opacity = Mathf.Clamp01(1 - mag / _target.brushSize);
                            opacity = Mathf.Pow(opacity, Mathf.Clamp01(1 - _target.brushFalloff / _target.brushSize));
                            opacity = opacity * _target.brushOpacity;

                            if (_target.curColorChannel == 0 || _target.curColorChannel == 5)
                                colors[i] = ColorLerp(colors[i], _target.brushColor, opacity, _target.curColorChannel);
                            else
                                colors[i] = OneChannelLerp(colors[i], _target.brushIntensity, opacity, _target.curColorChannel);
                        }
                        curMesh.colors = colors;
                    }

                    SceneView.RepaintAll();
                }
            }
        }

        //Scene指示UI圆盘的中心区域颜色
        Color getSolidDiscColor(int channel)
        {
            if (channel == 0 || channel == 5)
                return new Color(_target.brushColor.r, _target.brushColor.g, _target.brushColor.b, _target.brushOpacity);
            else
                return new Color(_target.brushIntensity, _target.brushIntensity, _target.brushIntensity, _target.brushOpacity);
        }
    }
}
#endif
