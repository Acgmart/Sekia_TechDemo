using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class SetBrdfTestMatrials : MonoBehaviour
{
    public GameObject testBRDF;
    MeshRenderer[] renderers;

    void Start()
    {
        renderers = testBRDF.GetComponentsInChildren<MeshRenderer>();
        Debug.LogError(renderers.Length);
        foreach (var child in renderers)
        {
            child.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.Off;
            Transform pa = child.transform.parent;
            string parentName = pa.name;
            int parentIndex = int.Parse(parentName);

            int index = -1;
            int parentChildCount = pa.childCount;
            for (int i = 0; i < parentChildCount; ++i)
            {
                if (pa.GetChild(i) == child.transform)
                    index = i;
            }
            string matName = $"SekiaPipeline_Lit {index}";
            if (index == 0)
                matName = "SekiaPipeline_Lit";
            string path = $"Assets/Sekia.Render/Pipeline_Assets/EngineShader/Lit/testBRDFMaterial/{parentName}/{matName}.mat";
            var mat = UnityEditor.AssetDatabase.LoadAssetAtPath<Material>(path);
            if (mat == null)
            {
                Debug.LogError("没找到材质：" + path);
                path = UnityEditor.AssetDatabase.GetAssetPath(child.sharedMaterial);
                Debug.LogError("ceshi：" + path);
            }
            else
            {
                mat.SetFloat("_MetallicCof", parentIndex * 0.1f);
                mat.SetFloat("_RoughnessCof", index * 0.1f);
                child.sharedMaterial = mat;
            }
        }
    }

    void Update()
    {

    }
}
