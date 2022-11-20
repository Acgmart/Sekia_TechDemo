using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;
using System.Reflection;
using System;
using System.Linq;

//MeshRenderer自定义面板
[CustomEditor(typeof(SkinnedMeshRenderer))]
public class SkinnedMeshRendererInspector : Editor
{
    Editor _defaultEditor;
    SkinnedMeshRenderer _current;

    static bool _showMeshExchangeHelper;
    SkinnedMeshRenderer _objectForExchange; //用于替换的Mesh物体

    static bool _showHairPrecomputeHelper;
    bool[] fixIndexes = new bool[] { false, false, false, false, false,
                                     false, false, false, false, false};
    int[] dirIndexes = new int[] { -1, -1, -1, -1, -1,
                                   -1, -1, -1, -1, -1};
    string[] titleStrings = new string[] { "subMesh0","subMesh1","subMesh2","subMesh3","subMesh4",
                                      "subMesh5","subMesh6","subMesh7","subMesh8","subMesh9" };

    class IndiceData : IComparable<IndiceData>
    {
        public int a;
        public int b;
        public int c;
        public float score;

        public int CompareTo(IndiceData other)
        {
            if (score > 0)
                return (int)((score - other.score) * 10000);
            else
                return (int)((other.score - score) * 10000);

            //观察方向正向：分值低的优先
            //观察方向负向：分值高的优先
            //从内部[0,0,0]向外部渲染
        }
    }

    public static int[] calculateDirIndices(int[] inputTriangles, Vector3[] vertices, Vector3 viewDir)
    {
        List<IndiceData> orderList = new List<IndiceData>();
        for (int i = 0; i < inputTriangles.Length; i += 3)
        {
            IndiceData data = new IndiceData();
            data.a = inputTriangles[i];
            data.b = inputTriangles[i + 1];
            data.c = inputTriangles[i + 2];
            //积分等于顶点向量与viewDir的点击
            data.score = vertices[data.a].x * viewDir.x +
                         vertices[data.a].y * viewDir.y +
                         vertices[data.a].z * viewDir.z +
                         vertices[data.b].x * viewDir.x +
                         vertices[data.b].y * viewDir.y +
                         vertices[data.b].z * viewDir.z +
                         vertices[data.c].x * viewDir.x +
                         vertices[data.c].y * viewDir.y +
                         vertices[data.c].z * viewDir.z;

            orderList.Add(data);
        }
        orderList.Sort();

        int[] result = new int[inputTriangles.Length];
        for (int i = 0; i < inputTriangles.Length; i += 3)
        {
            result[i] = orderList[i / 3].a;
            result[i + 1] = orderList[i / 3].b;
            result[i + 2] = orderList[i / 3].c;
        }
        return result;
    }

    public static void SetSelectedHairFBXPrecomputeIndex(Mesh mesh, int[] dirIndexes)
    {
        //Debug.LogError("开始");
        //Y正轴是后背 X正轴是脸正面右边 Z正轴是头上
        Vector3[] someViewDirs = new Vector3[16]; //赤道8等分 俯视45度8等分
        someViewDirs[0] = new Vector3(0, -1, 0); //朝向-Y轴
        someViewDirs[1] = new Vector3(-0.707f, -0.707f, 0); //上一个角度顺时针旋转45°
        someViewDirs[2] = new Vector3(-1, 0, 0); //朝向-X轴
        someViewDirs[3] = new Vector3(-0.707f, 0.707f, 0); //上一个角度顺时针旋转45°
        someViewDirs[4] = new Vector3(0, 1, 0); //朝向Y轴
        someViewDirs[5] = new Vector3(0.707f, 0.707f, 0); //上一个角度顺时针旋转45°
        someViewDirs[6] = new Vector3(1, 0, 0); //朝向X轴
        someViewDirs[7] = new Vector3(0.707f, -0.707f, 0); //上一个角度顺时针旋转45°

        someViewDirs[8] = new Vector3(0, -0.707f, 0.707f); //朝向-Y轴
        someViewDirs[9] = new Vector3(-0.5f, -0.5f, 0.707f); //上一个角度顺时针旋转45°
        someViewDirs[10] = new Vector3(-0.707f, 0, 0.707f); //朝向-X轴
        someViewDirs[11] = new Vector3(-0.5f, 0.5f, 0.707f); //上一个角度顺时针旋转45°
        someViewDirs[12] = new Vector3(0, 0.707f, 0.707f); //朝向Y轴
        someViewDirs[13] = new Vector3(0.5f, 0.5f, 0.707f); //上一个角度顺时针旋转45°
        someViewDirs[14] = new Vector3(0.707f, 0, 0.707f); //朝向X轴
        someViewDirs[15] = new Vector3(0.5f, -0.5f, 0.707f); //上一个角度顺时针旋转45°

        int subMeshCount = mesh.subMeshCount;
        var vertices = mesh.vertices;

        for (int i = 0; i < subMeshCount; ++i)
        {
            int dirIndex = dirIndexes[i];
            if (dirIndex < 0 || dirIndex > 15)
                continue;
            Vector3 viewDir = someViewDirs[dirIndex];

            var indices = mesh.GetTriangles(i);
            int[] newTriangles = calculateDirIndices(indices, vertices, viewDir);
            mesh.SetTriangles(newTriangles, i);
            //Debug.LogError("已设置subMesh" + i.ToString() + "  配置:" + dirIndex.ToString());
        }
        AssetDatabase.SaveAssets();
    }

    //面板状态变为可编辑(Enabled)时执行一次
    private void OnEnable()
    {
        //When this inspector is created, also create the built-in inspector
        _defaultEditor = CreateEditor(targets, Type.GetType("UnityEditor.SkinnedMeshRendererEditor, UnityEditor"));
        _current = target as SkinnedMeshRenderer;
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

        int boneCount = _current.bones.Length;
        //for (int i = 0; i < boneCount; ++i)
        //    EditorGUILayout.ObjectField(_current.bones[i], typeof(Transform), false);
        if (GUILayout.Button("全选骨骼"))
            Selection.objects = _current.bones.Select((x) => { return x.gameObject; }).ToArray();

        GUILayout.Space(20);
        _showMeshExchangeHelper = GUILayout.Toggle(_showMeshExchangeHelper, new GUIContent("MeshExchange"));
        if (_showMeshExchangeHelper)
        {
            _objectForExchange = (SkinnedMeshRenderer)EditorGUILayout.ObjectField("用于替换的目标", _objectForExchange, typeof(SkinnedMeshRenderer), true);
            if (GUILayout.Button("尝试用外部Mesh替换当前Mesh"))
            {
                //检查用于替换的SkindedMeshRenderer组件
                if (_objectForExchange == null || _objectForExchange.sharedMesh == null)
                {
                    Debug.LogError("请检查目标SkinedMeshRenderer组件mesh是否为空");
                    return;
                }
                if (_current == null || _current.sharedMesh == null)
                {
                    Debug.LogError("请检查当前SkinedMeshRenderer组件mesh是否为空");
                    return;
                }

                Mesh targetMesh = _objectForExchange.sharedMesh;
                Transform currentRoot = _current.rootBone;
                Transform[] currentAllBones = _current.bones;
                Transform targetRoot = _objectForExchange.rootBone;
                Transform[] targetAllBones = _objectForExchange.bones;

                //检查rootBone
                if (targetRoot.name != currentRoot.name)
                    Debug.LogError("两边的rootBone不一样!");

                //检查权重骨骼长度
                if (targetAllBones.Length != currentAllBones.Length)
                    Debug.LogError(string.Format("两边的骨骼数量不一样! current:{1}, target:{0}", targetAllBones.Length, currentAllBones.Length));

                //检查骨骼名称重复性
                Dictionary<string, Transform> currentBones = new Dictionary<string, Transform>();
                Dictionary<string, Transform> targetBones = new Dictionary<string, Transform>();
                int currentBoneCount = currentAllBones.Length;
                int targetBoneCount = targetAllBones.Length;

                for (int i = 0; i < currentBoneCount; ++i)
                {
                    Transform currentBone = currentAllBones[i];
                    string boneName = currentBone.name;
                    if (currentBones.ContainsKey(boneName))
                        Debug.LogError("当前组件包含重复的骨骼名:" + boneName);
                    else
                        currentBones[boneName] = currentBone;
                }

                for (int i = 0; i < targetBoneCount; ++i)
                {
                    Transform targetBone = targetAllBones[i];
                    string boneName = targetBone.name;
                    if (targetBones.ContainsKey(boneName))
                        Debug.LogError("目标组件包含重复的骨骼名:" + boneName);
                    else
                        targetBones[boneName] = targetBone;

                    if (!currentBones.ContainsKey(boneName))
                        Debug.LogError("当前组件不包含的目标骨骼:" + boneName);
                }

                //目标mesh资源确认
                string targetMeshFilePath = AssetDatabase.GetAssetPath(targetMesh);
                if (!targetMeshFilePath.EndsWith(".mesh"))
                    Debug.LogError("目标mesh需要为独立的资源 不能保存在FBX里");

                //替换骨骼
                _objectForExchange.rootBone = currentRoot;
                for (int i = 0; i < targetBoneCount; ++i)
                {
                    Transform targetBone = targetAllBones[i];
                    string boneName = targetBone.name;
                    if (currentBones.ContainsKey(boneName))
                    {
                        Transform currentBone = currentBones[boneName];
                        targetAllBones[i] = currentBone;
                    }
                    else
                    {
                        Debug.LogError("换骨骼的途中没在当前组件中找到：" + boneName);
                    }
                }
                _objectForExchange.bones = targetAllBones;

                //状态开启
                _current.enabled = false;
                _objectForExchange.enabled = true;
            }
        }

        _showHairPrecomputeHelper = GUILayout.Toggle(_showHairPrecomputeHelper, new GUIContent("HairPrecompute"));
        if (_showHairPrecomputeHelper)
        {
            Mesh mesh = _current.sharedMesh;
            if (mesh == null)
                return;
            int subMeshCount = mesh.subMeshCount;
            bool needRefresh = false;
            for (int i = 0; i < subMeshCount; ++i)
            {
                fixIndexes[i] = GUILayout.Toggle(fixIndexes[i], new GUIContent(titleStrings[i]));
                if (fixIndexes[i])
                {
                    int targetIndex = EditorGUILayout.IntField(titleStrings[i], dirIndexes[i]);
                    if (targetIndex != dirIndexes[i])
                    {
                        needRefresh = true;
                        if (targetIndex < 0 || targetIndex > 15)
                            targetIndex = -1;
                        dirIndexes[i] = targetIndex;
                    }
                }
            }

            if (needRefresh)
                SetSelectedHairFBXPrecomputeIndex(mesh, dirIndexes);
        }
    }
}
