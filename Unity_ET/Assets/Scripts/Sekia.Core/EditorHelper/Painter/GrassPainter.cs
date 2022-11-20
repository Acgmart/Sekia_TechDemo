using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using System;
using UnityEngine.SceneManagement;
using System.Linq;
using System.IO;
using System.Runtime.Serialization.Formatters.Binary;
#if UNITY_EDITOR
using UnityEditor;

namespace Sekia
{
    public class GrassPainter : MonoBehaviour
    {
        //单帧的数据
        public struct CachedGrassDataConfig
        {
            public Vector3 CachedGrassPoint;
            public float CachedGrassAngle; //Y轴旋转弧度
            public float CachedBiasAngle; //倾斜旋转弧度
            public Vector3 CachedBiasAxis; //倾斜旋转轴
            public Vector3 CachedGrassScale; //缩放
        }

        [HideInInspector]
        public List<CachedGrassDataConfig> cachedGrassData = new List<CachedGrassDataConfig>();
        private GameObject currentTargetChild;
        private List<GameObject> allGrasses = new List<GameObject>();
        public System.Random random = new System.Random(1000);
        const string _childroot = "childroot_";

        public static Mesh _grassQuad = null;
        public static Mesh grassQuad
        {
            get
            {
                if (_grassQuad != null)
                    return _grassQuad;
                else
                    return null; //在GrassPainterConfig中设置

                /*
                float topV = 1.0f;
                float bottomV = 0.0f;

                _grassQuad = new Mesh { name = "Grass Quad" };
                _grassQuad.SetVertices(new List<Vector3>
                    {
                        new Vector3(-1.0f, 0.0f, 0.0f),
                        new Vector3(-1.0f,  2.0f, 0.0f),
                        new Vector3(1.0f, 0.0f, 0.0f),
                        new Vector3(1.0f,  2.0f, 0.0f)
                    });

                _grassQuad.SetUVs(0, new List<Vector2>
                    {
                        new Vector2(0.0f, bottomV),
                        new Vector2(0.0f, topV),
                        new Vector2(1.0f, bottomV),
                        new Vector2(1.0f, topV)
                    });

                _grassQuad.SetIndices(new[] { 0, 1, 2, 2, 1, 3 }, MeshTopology.Triangles, 0, false);
                _grassQuad.UploadMeshData(true);
                return _grassQuad;
                */
            }
        }

        public void GeneriteCachedGrass(Material material, int density)
        {
            if (currentTargetChild == null)
            {
                //在子级中新建root物体
                int childRootCount = this.transform.childCount;
                string newChildRootName = _childroot + childRootCount.ToString();
                GameObject newChildRootObj = new GameObject(newChildRootName);
                newChildRootObj.transform.parent = this.transform;
                currentTargetChild = newChildRootObj;
            }

            //将缓存的信息用于生成草mesh
            int cachedCount = cachedGrassData.Count;
            List<GameObject> newCachedGrasses = new List<GameObject>();
            for (int i = 0; i < cachedCount; ++i)
            {
                GameObject newChildGrass = new GameObject("grass");
                newChildGrass.transform.parent = currentTargetChild.transform;
                newChildGrass.transform.position = cachedGrassData[i].CachedGrassPoint;
                newChildGrass.transform.rotation =
                    Quaternion.AngleAxis(cachedGrassData[i].CachedBiasAngle * Mathf.Rad2Deg, cachedGrassData[i].CachedBiasAxis) * //围绕xz平面的随机轴少量旋转
                    Quaternion.AngleAxis(cachedGrassData[i].CachedGrassAngle * Mathf.Rad2Deg, Vector3.up); //围绕y轴随机旋转
                newChildGrass.transform.localScale = cachedGrassData[i].CachedGrassScale;
                var meshFilter = newChildGrass.AddComponent<MeshFilter>();
                meshFilter.sharedMesh = grassQuad;
                var meshRenderer = newChildGrass.AddComponent<MeshRenderer>();
                meshRenderer.sharedMaterial = material;
                newCachedGrasses.Add(newChildGrass);

                //浓度控制 新增的草可能会替代旧草 ? 蓄水池采样
                //输入的值必须符合浓度规范
                //取出距离为1个Unit范围内的草
                //每个草配备一个随机值
                //根据草的随机值排序并排名删除超过限制的部分
                Dictionary<GameObject, float> nearGrasses = new Dictionary<GameObject, float>();
                foreach (var nearGrass in allGrasses)
                {
                    if (nearGrass == null)
                    {
                        allGrasses.Remove(null);
                        continue;
                    }
                    Vector3 nearPositon = nearGrass.transform.position;
                    float xOffset = Mathf.Abs(nearPositon.x - cachedGrassData[i].CachedGrassPoint.x);
                    float yOffset = Mathf.Abs(nearPositon.z - cachedGrassData[i].CachedGrassPoint.z);
                    if (xOffset < 1 && yOffset < 1)
                        nearGrasses.Add(nearGrass, (float)random.NextDouble());
                }

                if (nearGrasses.Count > density - 1) //附近的草浓度高于限制
                {
                    //排序 值小的在后面
                    nearGrasses = nearGrasses.OrderByDescending(k => k.Value).ToDictionary(p => p.Key, o => o.Value);
                    int nearIndex = 0;
                    List<GameObject> waitDeleteGrass = new List<GameObject>();
                    foreach (var nearGrass in nearGrasses.Keys)
                    {
                        if (nearIndex + 1 > density - 1)
                            waitDeleteGrass.Add(nearGrass);
                        nearIndex++;
                    }
                    foreach (var nearGrass in waitDeleteGrass)
                    {
                        allGrasses.Remove(nearGrass);
                        UnityEngine.Object.DestroyImmediate(nearGrass);
                    }
                }
            }

            allGrasses.AddRange(newCachedGrasses);
            cachedGrassData.Clear();
        }

        public void CombineCachedGrass()
        {
            Undo.RegisterCreatedObjectUndo(currentTargetChild, "Add Grass");
            currentTargetChild = null;

            //清理空子级
            int childCount = this.transform.childCount;
            for (int i = childCount - 1; i >= 0; i--)
            {
                if (this.transform.GetChild(i).childCount == 0 &&
                    this.transform.GetChild(i).name.StartsWith(_childroot))
                    UnityEngine.Object.DestroyImmediate(this.transform.GetChild(i).gameObject, true);
            }

            //重新命名
            childCount = this.transform.childCount;
            for (int i = childCount - 1; i >= 0; i--)
            {
                if (this.transform.GetChild(i).name.StartsWith(_childroot))
                    this.transform.GetChild(i).gameObject.name = _childroot + (i + 1).ToString();
            }
        }

        public void GeneriteGrassPrefab()
        {
            //将当前GameObject保存为Prefab 并编辑Prefab
            //所有的grass都会参与合并
            //每个材质新建一个子级
            //不支持重新编辑
            var scene = SceneManager.GetActiveScene();
            string dirPath = "Assets/Res/GrassPrefab/";
            dirPath = dirPath + scene.name;
            string prefabName = "Grass_";
            DateTime dt = DateTime.Now;
            prefabName = prefabName + dt.Year.ToString().Substring(2);
            prefabName = prefabName + dt.Month.ToString("00");
            prefabName = prefabName + dt.Day.ToString("00");
            prefabName = prefabName + dt.Hour.ToString("00");
            prefabName = prefabName + dt.Minute.ToString("00");
            prefabName = prefabName + dt.Second.ToString("00");
            string prefabPath = dirPath + "/" + prefabName + ".prefab";
            //Debug.LogError("Prefab路径：" + prefabPath);
            if (File.Exists(prefabPath))
                return;
            if (!Directory.Exists(dirPath))
                Directory.CreateDirectory(dirPath);

            //收集子级
            List<GameObject> needDeleteChilds = new List<GameObject>();
            Dictionary<Material, List<MeshFilter>> dic = new Dictionary<Material, List<MeshFilter>>();
            for (int i = 0; i < this.transform.childCount; ++i)
            {
                Transform transform = this.transform.GetChild(i);
                needDeleteChilds.Add(transform.gameObject);
                MeshRenderer[] childRenderers = transform.GetComponentsInChildren<MeshRenderer>(true);
                //Debug.LogError("子级个数：" + childRenderers.Length);
                foreach (var childRenderer in childRenderers)
                {
                    MeshFilter childFilter = childRenderer.GetComponent<MeshFilter>();
                    if (childRenderer.sharedMaterials.Length != 1 ||
                        childRenderer.sharedMaterials[0] == null ||
                        childFilter == null ||
                        childFilter.sharedMesh == null)
                        continue;
                    Material childMaterial = childRenderer.sharedMaterials[0];
                    if (!dic.ContainsKey(childMaterial))
                        dic[childMaterial] = new List<MeshFilter>();
                    dic[childMaterial].Add(childFilter);
                    //Debug.LogError("物体名：" + childFilter.name);
                }
            }

            //合并子级
            int materialIndex = 0;
            foreach (var pair in dic)
            {
                //Debug.LogError("材质名：" + pair.Key.name);
                GameObject childObj = new GameObject("Grass" + materialIndex.ToString());
                materialIndex++;
                childObj.transform.parent = this.transform;
                MeshFilter meshFilter = childObj.AddComponent<MeshFilter>();
                MeshRenderer meshRenderer = childObj.AddComponent<MeshRenderer>();
                meshRenderer.sharedMaterial = pair.Key;

                //合并mesh
                List<CombineInstance> TheCombineInstances = new List<CombineInstance>();
                foreach (var childMeshFilter in pair.Value)
                {
                    CombineInstance ci = new CombineInstance();
                    ci.transform = childMeshFilter.transform.localToWorldMatrix;
                    ci.mesh = childMeshFilter.sharedMesh;
                    ci.subMeshIndex = 0;
                    TheCombineInstances.Add(ci);
                }
                Mesh mesh = new Mesh();
                mesh.CombineMeshes(TheCombineInstances.ToArray(), true, true); //检查模型文件是否开启了可读写
                string path = dirPath + "/" + prefabName + materialIndex.ToString() + ".asset";
                AssetDatabase.CreateAsset(mesh, path);
                Mesh createdMesh = AssetDatabase.LoadAssetAtPath<Mesh>(path);
                if (createdMesh != null)
                    meshFilter.sharedMesh = createdMesh;
                else
                    Debug.LogError("没有找到创建的Mesh：" + createdMesh);
            }

            //删除多余子级
            foreach (var child in needDeleteChilds)
                UnityEngine.Object.DestroyImmediate(child, true);
            allGrasses.Clear();

            PrefabUtility.SaveAsPrefabAssetAndConnect(this.gameObject, prefabPath, InteractionMode.UserAction, out bool saveSuccced);
            if (!saveSuccced)
            {
                Debug.LogError("保存预制体失败");
                return;
            }
            else
                this.gameObject.name = prefabName;
        }
    }

    [CustomEditor(typeof(GrassPainter))]
    [CanEditMultipleObjects]
    public class GrassPainterStyle : Editor
    {
        private const string NEXT_VERSION_CACHE_PATH = "Library/GrassPainterCache_v3";
        private const string CACHE_PATH = "Library/GrassPainterCache_v3";
        private GrassPainterConfig configData;
        private static userSettings userSetting;
        private const string grassPainterConfigGUID = "0d2cc887b365f9c47aee0deb6749287a";

        private static bool showSceneGUI = false;
        private GrassPainter _target;
        private string[] presetNames; //预设材质球的名称
        private static bool isPaint;
        private bool needSaveData = false; //笔刷按下但是未弹起 有临时mesh未合并

        #region Cache
        private class userSettings
        {
            public float brushRadius = 1f; //笔刷框选的Unit范围半径
            public int baseAmount = 1; //笔刷一次生成多少根草
            public int presetIndex = 0; //草预设Index
            public int grassDensity = 20; //1个Unit面积内包含的草数量
            public float grassBaseScale_X = 0.5f; //xyz平面缩放
            public float grassBaseScale_Y = 0.5f;
            public float grassBaseScale_Z = 0.5f;
            public float grassScaleNoiseStrength = 0.2f; //随机缩放噪音
            public float grassBiasNoiseStrength = 0.2f; //随机倾斜噪音
        }

        private static void ReadFromCache()
        {
            string targetPath = CACHE_PATH;
            bool needUpdate = false;
            if (File.Exists(NEXT_VERSION_CACHE_PATH))
            {
                targetPath = NEXT_VERSION_CACHE_PATH;
                needUpdate = true;
            }

            userSetting = new userSettings();
            if (!File.Exists(targetPath))
                return;

            //反序列化数据
            FileStream fs = File.OpenRead(targetPath);
            try
            {
                if (needUpdate) { }
                BinaryFormatter bf = new BinaryFormatter();
                userSetting.brushRadius = (float)bf.Deserialize(fs);
                userSetting.baseAmount = (int)bf.Deserialize(fs);
                userSetting.presetIndex = (int)bf.Deserialize(fs);
                userSetting.grassDensity = (int)bf.Deserialize(fs);
                userSetting.grassBaseScale_X = (float)bf.Deserialize(fs);
                userSetting.grassBaseScale_Y = (float)bf.Deserialize(fs);
                userSetting.grassBaseScale_Z = (float)bf.Deserialize(fs);
                userSetting.grassScaleNoiseStrength = (float)bf.Deserialize(fs);
                userSetting.grassBiasNoiseStrength = (float)bf.Deserialize(fs);
            }
            catch (Exception e)
            {
                Debug.LogError(e);
                if (File.Exists(targetPath))
                    File.Delete(targetPath);
            }
            finally
            {
                fs.Close();
            }
        }

        private static void WriteToChache()
        {
            string targetPath = NEXT_VERSION_CACHE_PATH;
            if (File.Exists(targetPath))
                File.Delete(targetPath);
            //序列化
            using (FileStream fs = File.OpenWrite(targetPath))
            {
                BinaryFormatter bf = new BinaryFormatter();
                bf.Serialize(fs, userSetting.brushRadius);
                bf.Serialize(fs, userSetting.baseAmount);
                bf.Serialize(fs, userSetting.presetIndex);
                bf.Serialize(fs, userSetting.grassDensity);
                bf.Serialize(fs, userSetting.grassBaseScale_X);
                bf.Serialize(fs, userSetting.grassBaseScale_Y);
                bf.Serialize(fs, userSetting.grassBaseScale_Z);
                bf.Serialize(fs, userSetting.grassScaleNoiseStrength);
                bf.Serialize(fs, userSetting.grassBiasNoiseStrength);
            }

            //检查是否勾选了Gizmos
            SceneView sceneView = SceneView.lastActiveSceneView;
            if (isPaint && sceneView != null && !sceneView.drawGizmos)
                sceneView.drawGizmos = true;
        }
        #endregion

        void OnSceneGUI()
        {
            if (!showSceneGUI)
                return;

            if (isPaint && Tools.current == Tool.None)
                Painter();
        }

        private void OnDisable()
        {
            isPaint = false;
        }

        public override void OnInspectorGUI()
        {
            base.OnInspectorGUI();
            showSceneGUI = false;
            if (_target == null)
                _target = (GrassPainter)target;
            if (_target.gameObject == null)
                return;

            //读取个人设置
            if (userSetting == null)
                ReadFromCache();

            //检查grass笔刷配置文件 获取可以的材质球
            if (configData == null)
            {
                string grassPainterPath = AssetDatabase.GUIDToAssetPath(grassPainterConfigGUID);
                if (string.IsNullOrEmpty(grassPainterPath) || !File.Exists(grassPainterPath))
                {
                    EditorGUILayout.HelpBox("Grass笔刷配置文件不存在", MessageType.Error);
                    return;
                }

                configData = AssetDatabase.LoadAssetAtPath<GrassPainterConfig>(grassPainterPath);
                if (configData == null)
                {
                    EditorGUILayout.HelpBox("加载Shader配置文件发生错误：" + grassPainterPath, MessageType.Error);
                    return;
                }

                if (GrassPainter._grassQuad == null)
                    GrassPainter._grassQuad = configData.grassQuad;

                presetNames = new string[configData.grassPresets.Count];
                for (int i = 0; i < configData.grassPresets.Count; i++)
                    presetNames[i] = configData.grassPresets[i].name;
            }

            EditorGUI.BeginChangeCheck();
            //绘制状态切换 开始绘制GUI
            {
                GUILayout.BeginHorizontal();
                GUILayout.FlexibleSpace();
                if (GUILayout.Button("打包", GUILayout.Height(25)))
                {
                    if (PrefabUtility.IsAnyPrefabInstanceRoot(_target.gameObject))
                        PrefabUtility.UnpackPrefabInstance(_target.gameObject, PrefabUnpackMode.Completely, InteractionMode.UserAction);
                    _target.GeneriteGrassPrefab();
                }
                if (GUILayout.Button("刷新", GUILayout.Height(25)))
                {
                    configData = null;
                    isPaint = false;
                    return;
                }
                GUIStyle boolBtnOn = new GUIStyle(GUI.skin.GetStyle("Button"));
                GUIContent guiContent = EditorGUIUtility.IconContent("EditCollider");
                isPaint = GUILayout.Toggle(isPaint, guiContent, boolBtnOn, GUILayout.Width(35), GUILayout.Height(25));
                if (isPaint)
                    GUILayout.Label("Drawing", GUILayout.Height(25));
                GUILayout.FlexibleSpace();
                GUILayout.EndHorizontal();
            }

            //笔刷属性
            {
                userSetting.brushRadius = EditorGUILayout.Slider("笔刷宽度", userSetting.brushRadius, 0.1f, 10f);
                userSetting.baseAmount = (int)EditorGUILayout.Slider("草基数", userSetting.baseAmount, 1, 50);
                userSetting.grassDensity = (int)EditorGUILayout.Slider("草浓度", userSetting.grassDensity, 0, 50);
                userSetting.grassBaseScale_X = EditorGUILayout.Slider("基础缩放X", userSetting.grassBaseScale_X, 0.1f, 10f);
                userSetting.grassBaseScale_Y = EditorGUILayout.Slider("基础缩放Y", userSetting.grassBaseScale_Y, 0.1f, 10f);
                userSetting.grassBaseScale_Z = EditorGUILayout.Slider("基础缩放Z", userSetting.grassBaseScale_Z, 0.1f, 10f);
                userSetting.grassScaleNoiseStrength = EditorGUILayout.Slider("缩放噪音", userSetting.grassScaleNoiseStrength, 0.1f, 0.5f);
                userSetting.grassBiasNoiseStrength = EditorGUILayout.Slider("倾斜噪音", userSetting.grassBiasNoiseStrength, 0.1f, 0.5f);

                GUILayout.Label("材质预设");
                EditorGUI.indentLevel++;
                GUILayout.BeginHorizontal();
                int texCount = presetNames.Length;
                int singleHeiht = 20;
                int gridWidth = 200;
                int gridHeight = singleHeiht * texCount;
                int singleLineCount = 1; //单行个数
                userSetting.presetIndex = GUILayout.SelectionGrid(userSetting.presetIndex, presetNames,
                    singleLineCount, "gridlist", GUILayout.Width(gridWidth), GUILayout.Height(gridHeight));
                GUILayout.EndHorizontal();
                EditorGUI.indentLevel--;
            }

            if (EditorGUI.EndChangeCheck())
                WriteToChache();

            //当切换到绘制模式时更改工具模式
            {
                if (isPaint && Tools.current != Tool.None)
                    Tools.current = Tool.None;
            }

            //检测通过才在Scene窗口显示笔刷
            showSceneGUI = true;
        }

        public void Painter()
        {
            Event e = Event.current;
            HandleUtility.AddDefaultControl(0);

            bool hasResult = false;
            Ray terrain = HandleUtility.GUIPointToWorldRay(e.mousePosition);
            if (Physics.Raycast(terrain, out RaycastHit raycastHit, Mathf.Infinity,
                1 << LayerMask.NameToLayer("Terrain") |
                1 << LayerMask.NameToLayer("Default")))
                hasResult = true;

            if (hasResult)
            {
                Handles.color = new Color(1f, 1f, 0f, 1f); //黄色的圆圈
                Handles.DrawWireDisc(raycastHit.point, raycastHit.normal, userSetting.brushRadius);
                Handles.color = new Color(1f, 0f, 0f, 1f); //红色的法线
                Handles.DrawLine(raycastHit.point, raycastHit.point + raycastHit.normal);

                //左键拖拽 或 左键单击
                if (e.alt == false && e.control == false && e.shift == false && e.button == 0 &&
                    (e.type == EventType.MouseDrag || e.type == EventType.MouseDown))
                {
                    float GetRandom()
                    {
                        return (float)_target.random.NextDouble();
                    }

                    float GetGrassAngle()
                    {
                        //随机获取弧度 从0-1放大到0-2π
                        return GetRandom() * 2 * Mathf.PI;
                    }

                    Vector3 GetCircleAxis()
                    {
                        float radin = GetGrassAngle();
                        float x = Mathf.Cos(radin);
                        float y = Mathf.Sin(radin);
                        return new Vector3(x, 0, y);
                    }

                    Vector3 GetCirclePoint()
                    {
                        float radin = GetGrassAngle();
                        float x = Mathf.Cos(radin) * GetRandom();
                        float y = Mathf.Sin(radin) * GetRandom();
                        return new Vector3(x, 0, y);
                    }

                    //在以碰撞点为中心 userSetting.brushRadius为半径的圆内 生成userSetting.baseAmount个草
                    Vector3 centerPos = raycastHit.point;
                    int newPosCount = 0;
                    for (int i = 0; i < userSetting.baseAmount; ++i)
                    {
                        Vector3 newGrassPos = GetCirclePoint() * userSetting.brushRadius + centerPos;
                        if (newPosCount > userSetting.grassDensity - 1)
                        {
                            //浓度检测 判断离newGrassPos在1个Unit单位的点是否超过限制
                            int withInCount = 0;
                            foreach (var pos in _target.cachedGrassData)
                            {
                                if (Mathf.Abs(pos.CachedGrassPoint.x - newGrassPos.x) < 1 &&
                                    Math.Abs(pos.CachedGrassPoint.z - newGrassPos.z) < 1)
                                    withInCount++;
                            }
                            if (withInCount > userSetting.grassDensity - 1)
                                continue;
                        }

                        newPosCount++;
                        //缩放中带有随机噪音
                        Vector3 grassScale = new Vector3(userSetting.grassBaseScale_X, userSetting.grassBaseScale_Y, userSetting.grassBaseScale_Z);
                        Vector3 scaleOffset = grassScale * userSetting.grassScaleNoiseStrength;
                        grassScale.x = scaleOffset.x * 2 * GetRandom() + grassScale.x - scaleOffset.x;
                        grassScale.y = scaleOffset.y * 2 * GetRandom() + grassScale.y - scaleOffset.y;
                        grassScale.z = scaleOffset.z * 2 * GetRandom() + grassScale.z - scaleOffset.z;

                        GrassPainter.CachedGrassDataConfig data = new GrassPainter.CachedGrassDataConfig()
                        {
                            CachedGrassPoint = newGrassPos,
                            CachedGrassAngle = GetGrassAngle(),
                            //在0-90度范围内随机倾斜
                            CachedBiasAngle = GetGrassAngle() * 0.25f * userSetting.grassBiasNoiseStrength,
                            CachedBiasAxis = GetCircleAxis(), //随机噪音倾斜
                            CachedGrassScale = grassScale,
                        };
                        _target.cachedGrassData.Add(data);
                    }

                    needSaveData = true;
                    _target.GeneriteCachedGrass(configData.grassPresets[userSetting.presetIndex], userSetting.grassDensity);
                }

                if (e.alt == false && e.control == false && e.shift == false && e.button == 0 &&
                    e.type == EventType.MouseUp && needSaveData)
                {
                    needSaveData = false;
                    _target.CombineCachedGrass();
                }

                //加速Scene场景渲染
                SceneView.RepaintAll();
            }
        }

        [MenuItem("Window/场景Debug工具/ChangeGrassPainterMode &v", false, 25)]
        static void ChangeMeshPainterMode()
        {
            isPaint = !isPaint;
        }
    }
}
#endif
