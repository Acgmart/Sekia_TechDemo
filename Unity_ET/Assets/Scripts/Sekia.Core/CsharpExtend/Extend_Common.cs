using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Linq;
using System.IO;
using System;
using System.Text;

public static partial class SekiaExtend
{
    #region String
    static StringBuilder sb = new StringBuilder(20); //用前Clear

    public static int StringToInt(this string word)
    {
        //检查被转换的数值是否能够用 int 表示
        return Convert.ToInt32(word);
    }

    public static string CombineStringList(this IEnumerable<string> strs)
    {
        sb.Clear();
        foreach (var str in strs)
        {
            sb.Append(str);
        }
        return sb.ToString();
    }


    public static T Sekia_StringToEnum<T>(this string value)
    {
        //参数3指定该操作是否不区分大小写 这里区分大小写
        return (T)Enum.Parse(typeof(T), value);
    }

    public static bool IsNullOrEmpty(this string s)
    {
        return string.IsNullOrEmpty(s);
    }
    #endregion

    #region GameObject
    public static T SetDefaultComponent<T>(this GameObject go) where T : UnityEngine.Component
    {
        var result = go.GetComponent<T>();
        if (result == null)
            result = go.AddComponent<T>();
        return result;
    }

    //string作为Layer目标
    public static void SetLayerRecursively(this GameObject go, string layer)
    {
        if (null == go)
            return;

        go.layer = LayerMask.NameToLayer(layer);
        foreach (Transform child in go.transform)
            child.gameObject.SetLayerRecursively(layer);
    }

    //int作为Layer目标
    public static void SetLayerRecursively(this GameObject go, int layer)
    {
        if (null == go)
            return;

        go.layer = layer;
        foreach (Transform child in go.transform)
            child.gameObject.SetLayerRecursively(layer);
    }

    public static void DeleteChildrenImmediate(this GameObject go)
    {
        if (go != null)
        {
            int count = go.transform.childCount;
            for (int i = count - 1; i >= 0; i--)
            {
                GameObject.DestroyImmediate(go.transform.GetChild(i).gameObject, true);
            }

        }
    }

    public static IEnumerable<GameObject> GetDirectChildren(this GameObject go)
    {
        if (null != go)
        {
            foreach (Transform child in go.transform)
            {
                yield return child.gameObject;
            }
        }
    }

    public static void GetCorresondingPrefabRecursively(this GameObject go, Dictionary<GameObject, GameObject> instanceToPrefab)
    {
#if UNITY_EDITOR
        var prefab = UnityEditor.PrefabUtility.GetCorrespondingObjectFromSource(go);
        if (prefab != null)
            instanceToPrefab[go] = prefab;
        else
            for (int i = 0; i < go.transform.childCount; i++)
                go.transform.GetChild(i).gameObject.GetCorresondingPrefabRecursively(instanceToPrefab);
#endif
    }
    #endregion

    #region T[] 排序
    /// <summary>
    /// 使用自定义比较器进行重新排序
    /// </summary>
    public static T[] Sekia_Sort<T>(this T[] array, Comparison<T> lambda = null)
    {
        //比较器举例：返回正值时测试通过-调换顺序
        //1.根据mesh的顶点数量降序排列：(fore, back) => { return back.vertices.Length - fore.vertices.Length; }
        //2.根据顶点的Y值大小降序排列：(fore, back) => { return back.y.CompareTo(fore.y); }

        if (lambda != null)
            Array.Sort(array, lambda);
        else
            Array.Sort(array);
        return array;

        //注：
        //Array.Sort(array, 1, 3); //可指定对比目标的范围 参数2和3：开始排序的起点和长度
        //back和fore相同时 比较失败 不会交换顺序
    }

    /// <summary>
    /// 根据A数组映射出等长度的B数组
    /// </summary>
    public static IEnumerable<TResult> Sekia_Select<TSource, TResult>(this IEnumerable<TSource> source, Func<TSource, TResult> lambda)
    {
        //委托举例：
        //1.源数组中元素作参数：(fore) => { return fore.x; }
        //2.源数组中元素和index作参数：(fore, index) => { return fore.x; }
        return source.Select(lambda);
    }

    /// <summary>
    /// 将另外一个数组添加到当前数组后面
    /// </summary>
    public static T[] Sekia_Combine<T>(this T[] origin, T[] another)
    {
        return origin.Concat(another).ToArray();
    }

    /// <summary>
    /// 根据映射数组返回指定数组
    /// </summary>
    /// <param name="ints">一个骨架序列</param>
    /// <returns></returns>
    public static T[] Sekia_GetArrayByIndexs<T>(this T[] list, int[] ints)
    {
        T[] result = new T[ints.Length];
        for (int i = 0; i < result.Length; ++i)
        {
            result[i] = list[ints[i]];
        }
        return result;
    }

    /// <summary>
    /// 获取一个对象在数据中的index 不存在时返回-1
    /// </summary>
    public static int Sekia_GetIndexInArray<T>(this T[] list, T t)
    {
        return Array.IndexOf(list, t);
    }
    #endregion

    #region Enum
    // Enum Type转化为Enum数组
    public static T[] Sekia_EnumToArray<T>()
    {
        return (T[])Enum.GetValues(typeof(T));
    }

    // Enum Type转化为String数组
    public static string[] Sekia_EnumToStringArray<T>()
    {
        return Enum.GetNames(typeof(T));
    }

    public static Dictionary<string, int> Sekia_EnumToDic(this Type enumType)
    {
        if (enumType.IsEnum == false)
        {
            Debug.LogError("输入的类型不是enum 不能转换");
            return null;
        }

        Dictionary<string, int> result = new Dictionary<string, int>();
        foreach (string s in Enum.GetNames(enumType))
        {
            string key = s;
            int value = (int)Enum.Parse(enumType, s);
            result[key] = value;
        }

        return result;
    }
    #endregion

    #region Transform

    public static void FromMatrix(this Transform transform, Matrix4x4 matrix)
    {
        transform.localScale = matrix.ExtractScale();
        transform.rotation = matrix.ExtractRotation();
        transform.position = matrix.ExtractPosition();
    }

    /// <summary>
    /// 深度收集transform子级
    /// </summary>
    /// <param name="includeself">是否包含自身</param>
    /// <returns></returns>
    public static Transform[] GetTransforms(this Transform transform, bool includeself)
    {
        List<Transform> childs = new List<Transform>();
        if (includeself)
            childs.Add(transform);
        transform.FindAllChilds(childs);
        return childs.ToArray();
    }

    static void FindAllChilds(this Transform transform, List<Transform> list)
    {
        if (transform.childCount > 0)
        {
            for (int i = 0; i < transform.childCount; ++i)
            {
                list.Add(transform.GetChild(i));
                transform.GetChild(i).FindAllChilds(list);
            }
        }
    }

    /// <summary>
    /// 根据名称寻找子级 返回第一个
    /// </summary>
    public static Transform FindChildByName(this Transform transform, string name)
    {
        Transform result = null;
        Transform[] transforms = transform.GetTransforms(false);
        for (int i = 0; i < transforms.Length; ++i)
        {
            if (transforms[i].name == name)
            {
                result = transforms[i];
                break;
            }
        }
        return result;
    }

    public static void GetCorrespondingPrefabPaths(this Transform transform, HashSet<string> depends)
    {
#if UNITY_EDITOR
        var obj = UnityEditor.PrefabUtility.GetCorrespondingObjectFromSource(transform.gameObject);
        if (obj != null)
        {
            string prefabPath = UnityEditor.AssetDatabase.GetAssetPath(obj);
            depends.Add(prefabPath);
        }
        else
        {
            for (int i = 0; i < transform.childCount; i++)
            {
                GetCorrespondingPrefabPaths(transform.GetChild(i), depends);
            }
        }
#endif
    }
    #endregion

    #region Transform[]
    /// <summary>
    /// 将transform数组转换为其名称数组
    /// </summary>
    public static string[] ToNameStrings(this Transform[] transforms)
    {
        string[] result = new string[transforms.Length];
        for (int i = 0; i < transforms.Length; ++i)
        {
            result[i] = transforms[i].name;
        }
        return result;
    }
    #endregion

    #region Mesh
    public static Mesh Sekia_CopyMesh(this Mesh mesh, bool canread)
    {
        Mesh result = new Mesh();
        result.vertices = mesh.vertices; //Vect3[] 顶点
        result.normals = mesh.normals; //Vect3[] 法线
        result.uv = mesh.uv; //Vect2[] UV
        result.boneWeights = mesh.boneWeights; //BoneWeights[] 权重
        result.bindposes = mesh.bindposes; //Matrix4x4[] 绑定姿势
        result.subMeshCount = mesh.subMeshCount; //材质数
        result.name = mesh.name; //名称
        for (int n = 0; n < result.subMeshCount; ++n)
        {
            result.SetTriangles(mesh.GetTriangles(n), n);
        }
        if (!canread)
        {
            result.UploadMeshData(true); //设置是否可读
        }
        return result;
    }
    #endregion

    #region Material
    public static Material Sekia_CopyMaterial(this Material material)
    {
        string shader_name = material.shader.name;
        Material result = new Material(Shader.Find(shader_name)); //shader
        result.CopyPropertiesFromMaterial(material); //属性
        result.shaderKeywords = material.shaderKeywords;
        result.SetShaderPassEnabled("SRPDefaultUnlit", material.GetShaderPassEnabled("SRPDefaultUnlit"));
        return result;
    }
    #endregion

    #region RenderTexture

    public static bool Sekia_SaveRenderTextureToPNG(this RenderTexture rt, string contents = "D:\\", string pngName = "test")
    {
        RenderTexture prev = RenderTexture.active;
        RenderTexture.active = rt;
        Texture2D png = new Texture2D(rt.width, rt.height, TextureFormat.ARGB32, false);
        png.ReadPixels(new Rect(0, 0, rt.width, rt.height), 0, 0);
        if (!Directory.Exists(contents))
            Directory.CreateDirectory(contents);
        System.IO.File.WriteAllBytes(contents + "/" + pngName + ".png", png.EncodeToPNG());
        Texture2D.DestroyImmediate(png);
        png = null;
        RenderTexture.active = prev;
        return true;
    }

    #endregion

    #region Matrix4x4
    public static Quaternion ExtractRotation(this Matrix4x4 matrix)
    {
        Vector3 forward;
        forward.x = matrix.m02;
        forward.y = matrix.m12;
        forward.z = matrix.m22;

        Vector3 upwards;
        upwards.x = matrix.m01;
        upwards.y = matrix.m11;
        upwards.z = matrix.m21;

        return Quaternion.LookRotation(forward, upwards);
    }

    public static Vector3 ExtractPosition(this Matrix4x4 matrix)
    {
        Vector3 position;
        position.x = matrix.m03;
        position.y = matrix.m13;
        position.z = matrix.m23;
        return position;
    }

    public static Vector3 ExtractScale(this Matrix4x4 matrix)
    {
        Vector3 scale;
        scale.x = new Vector4(matrix.m00, matrix.m10, matrix.m20, matrix.m30).magnitude;
        scale.y = new Vector4(matrix.m01, matrix.m11, matrix.m21, matrix.m31).magnitude;
        scale.z = new Vector4(matrix.m02, matrix.m12, matrix.m22, matrix.m32).magnitude;
        return scale;
    }
    #endregion
}
