using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;
using System.Reflection;
using System;

//MeshRenderer自定义面板
[CustomEditor(typeof(MeshRenderer))]
public class MeshRendererInspector : Editor
{
    Editor _defaultEditor;
    MeshRenderer _current;

    static bool recalculateBoundingBoxHelper;
    float boundingBoxScale = 1.0f;

    //面板状态变为可编辑(Enabled)时执行一次
    private void OnEnable()
    {
        //When this inspector is created, also create the built-in inspector
        _defaultEditor = CreateEditor(targets, Type.GetType("UnityEditor.MeshRendererEditor, UnityEditor"));
        _current = target as MeshRenderer;
    }

    private void OnDisable()
    {
        //When OnDisable is called, the default editor we created should be destroyed to avoid memory leakage.
        //Also, make sure to call any required methods like OnDisable
        MethodInfo disableMethod = _defaultEditor.GetType().GetMethod("OnDisable", BindingFlags.Instance | BindingFlags.NonPublic | BindingFlags.Public);
        if (disableMethod != null)
            disableMethod.Invoke(_defaultEditor, null);
        DestroyImmediate(_defaultEditor);
    }

    public override void OnInspectorGUI() //每帧执行
    {
        //base.OnInspectorGUI();
        //DrawDefaultInspector();
        if (_defaultEditor == null || _current == null)
            return;
        _defaultEditor.OnInspectorGUI();

        GUILayout.Space(20);

        recalculateBoundingBoxHelper = GUILayout.Toggle(recalculateBoundingBoxHelper, new GUIContent("重计算包围盒"));
        if (recalculateBoundingBoxHelper)
        {
            boundingBoxScale = EditorGUILayout.FloatField("包围盒缩放系数", boundingBoxScale);
            if (GUILayout.Button("重计算包围盒"))
            {
                MeshFilter meshFilter = _current.GetComponent<MeshFilter>();
                if (meshFilter == null)
                    return;
                //renderer.bounds和collider.bounds是mesh的模型空间bounds转世界空间
#if ART
                Mesh mesh = meshFilter.sharedMesh;
#else
                Mesh mesh = meshFilter.mesh;
#endif
                if (mesh == null)
                    return;
                mesh.RecalculateBounds();
                Bounds bounds = mesh.bounds;
                Vector3 size = bounds.size;
                bounds.size = new Vector3(size.x * boundingBoxScale, size.y * boundingBoxScale, size.z * boundingBoxScale);
                mesh.bounds = bounds;
            }
        }
    }
}
