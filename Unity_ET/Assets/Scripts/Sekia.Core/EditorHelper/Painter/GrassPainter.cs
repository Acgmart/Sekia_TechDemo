using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using System;
using UnityEngine.SceneManagement;
using System.Linq;
using System.IO;

#if UNITY_EDITOR
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
#endif
