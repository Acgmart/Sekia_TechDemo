using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine.SceneManagement;
using UnityEngine;
using System.IO;
using System;
using UnityEngine.Experimental.Rendering;
using AmazingAssets.TerrainToMesh;

namespace Sekia
{
    public class BuildTools : Editor
    {
        /*
         * #预制体分类
         * 原始预制体：比如房子桌子等 概念原型
         *      可以制作多个来满足颜色、大小等差异化
         *      放在固定目录根据分类管理 多场景复用
         *      对于多场景复用的资源 改动时也会影响到多个场景的效果 要注意通用性
         *      公共资源打包到公共资源路径
         *          公共预制体分类：目录以Type结尾
         * 变体：对原始预制体的修改版
         *      有复杂的属性override或者添加了其他组件导致没法直接实例化
         *      打包时清理并重新生成 不在多场景复用 不进行分类
         *      有复用价值的变体可以挪到公用目录
         *      逐场景资源打包到逐场景资源路径
         * 地形分块预制体：替代Unity Terrain组件的物体
         *      打包时清理并重新生成 生成的是材质球、mesh、预制体
         *      笔刷相关的贴图可以多场景复用
         * 
         * #特殊文件
         * LightMap：烘培产出的文件
         *      动态加载模式下可能有多份LightMap数据用于切换 每份单独出包
         *      https://zhuanlan.zhihu.com/p/448101065
         * Shader：公共资源
         * 
         * #动态加载方案
         * 打包输出空场景
         *      空场景：简化后的场景 仅保留少量关键信息
         *          光源/后处理/探针 等场景信息不希望单独出bundle
         *          寻路mesh、触发器 等交互信息不希望单独出bundle
         *          相机和测试角色不参与打包
         *      空场景与单个引用对应的预制体之间脱离了依赖关系
         *      引用信息存储在空场景bundle中 不影响原场景的工作流
         * 运行时动态加载
         *      加载场景对应的空场景bundle
         *      设置LightMap信息
         *      通过Bounds判断可见性 通过SceneObject组件记录的引用信息加载资源
         * 
         * #依赖链管理方案
         * 如果每个文件都分类后上一个bundle标签 那么依赖链非常清晰可靠
         * 可选择性的简化引用链 减少单纯的被引用资源(deps)的读取次数 简化后风险增加
         *      简化后 对deps资源的修改需要重新打包合并了deps的上一级资源
         *      暂时不考虑简化引用链
         * 1.由于引用关系随着版本开发会有很大的变动 特别是多场景复用资源的引用关系
         * 2.特效、2D、3D、地编、音频、动作、程序、策划 等部门互相独立又有配合
         *      特效属于低频资源 按需触发 图片复用情况复杂
         *          同样触发类的资源还有音频
         *      2D(UI界面)和场景有可能希望初次加载快一点 但是很难有完美方案
         *          比如把很多个文件压缩后再解压 比单个传要快 但是灵活性不足
         *      模型和动作是可以延迟加载的 先使用替代资源
         *      策划配的一些行为树
         *       
         * 主要资源：
         *      prefab/NoType/
         *      prefab/TreeType/
         * 次要资源：
         *      action/NoHost/fileName.unity3d
         *      action/_ActionHost/fileName.unity3d
         *      texture/
         *      audio/
         * 逐场景资源：
         *      scenes/_SceneName/prefab/
         *      scenes/_SceneName/_SceneName
         * 
         */

        //特定节点名称和资源名称
        private const string _SceneRoot = "_SceneRoot"; //挂载场景物体
        private const string _TempRoot = "_TempRoot"; //挂载一些打包阶段会删除的物体
        private const string _TerrainRoot = "_TempRoot/_TerrainRoot"; //挂载了Unity的Terrain组件
        private const string _TerrainShaderName = "SekiaPipeline/Level/Terrain/Layer";

        private const string _SceneVariantsPath = "Assets/Bundles/Variants/";

        public static readonly List<Type> CanRepairTypes = new List<Type>
            { typeof(Transform) };

        [MenuItem("ET/场景导出/1.一键整理场景资源")]
        public static void OneKeyBuildScene()
        {
            var scene = SceneManager.GetActiveScene();
            string originalSceneUnityPath = scene.path;
            string backUpSceneTempPath = Application.dataPath + "/../" + scene.name + ".unity";

            string sceneVariantsPath = _SceneVariantsPath + scene.name + "/";
            string sceneVariantsPath_Prefab = sceneVariantsPath + "Prefab/";
            string sceneVariantsPath_Terrain = sceneVariantsPath + "Terrain/";
            string sceneVariantsPath_EmptyScene = sceneVariantsPath + "EmptyScene/";
            string sceneVariantsPath_EmptySceneFile = sceneVariantsPath_EmptyScene + scene.name + ".unity";

            //场景层级规范检查
            {
                var sceneRoot = GameObject.Find(_SceneRoot)?.transform;
                if (sceneRoot == null)
                {
                    EditorUtility.DisplayDialog("错误", "没找到物体：" + _SceneRoot, "确定");
                    return;
                }

                if (sceneRoot.childCount == 0)
                    return;
            }

            //清理Assets下的过期临时文件
            {
                //清空当前场景关联的临时资源目录
                if (Directory.Exists(sceneVariantsPath_Prefab))
                    Directory.Delete(sceneVariantsPath_Prefab, true);
                if (Directory.Exists(sceneVariantsPath_Terrain))
                    Directory.Delete(sceneVariantsPath_Terrain, true);
                if (Directory.Exists(sceneVariantsPath_EmptyScene))
                    Directory.Delete(sceneVariantsPath_EmptyScene, true);

                if (!Directory.Exists(sceneVariantsPath))
                    Directory.CreateDirectory(sceneVariantsPath);
                if (!Directory.Exists(sceneVariantsPath_Prefab))
                    Directory.CreateDirectory(sceneVariantsPath_Prefab);
                if (!Directory.Exists(sceneVariantsPath_Terrain))
                    Directory.CreateDirectory(sceneVariantsPath_Terrain);
                if (!Directory.Exists(sceneVariantsPath_EmptyScene))
                    Directory.CreateDirectory(sceneVariantsPath_EmptyScene);
            }

            //备份当前场景
            {
                AssetDatabase.SaveAssets();
                File.Copy(originalSceneUnityPath, backUpSceneTempPath, true);
            }

            //打包场景
            {
                //实例与对应的预制体
                Dictionary<GameObject, GameObject> instanceToPrefab = new Dictionary<GameObject, GameObject>();
                //预制体与关联的脏实例
                Dictionary<GameObject, List<GameObject>> prefabToDirtyInstaces = new Dictionary<GameObject, List<GameObject>>();
                //预制体与关联的变体 预制体对应的脏实例可以转化为变体
                Dictionary<GameObject, List<GameObject>> prefabToVariantInstances = new Dictionary<GameObject, List<GameObject>>();
                //脏实例与对应的变体 脏实例必定对应着一个变体
                Dictionary<GameObject, GameObject> dirtyInstaceToVariantInstance = new Dictionary<GameObject, GameObject>();
                //变体与关联的脏实例 一个变体对应着多个脏实例
                Dictionary<GameObject, List<GameObject>> variantInstanceToDirtyInstances = new Dictionary<GameObject, List<GameObject>>();
                //变体与对应的预制体路径 一个变体对应着一个资源路径
                Dictionary<GameObject, string> variantInstanceToVariantPath = new Dictionary<GameObject, string>();
                //实例与对应的引用信息 一个实例对应着一个引用信息
                Dictionary<GameObject, SceneObject> instanceToSceneObject = new Dictionary<GameObject, SceneObject>();
                //所有预制体路径
                List<string> allPrefabPaths = new List<string>();

                //收集实例
                var sceneRoot = GameObject.Find(_SceneRoot).transform;
                sceneRoot.gameObject.GetCorresondingPrefabRecursively(instanceToPrefab);

                //收集脏实例
                foreach (var instancePair in instanceToPrefab)
                {
                    var instance = instancePair.Key;
                    var prefab = instancePair.Value;

                    //有4种修改类型 可以在Override界面中查看改动细节 忽略默认改动
                    var overridedObjects = PrefabUtility.GetObjectOverrides(instance, false);
                    var addedComponents = PrefabUtility.GetAddedComponents(instance);
                    var addedInstances = PrefabUtility.GetAddedGameObjects(instance);
                    var removedComponents = PrefabUtility.GetRemovedComponents(instance);

                    int changeCount = overridedObjects.Count + addedComponents.Count +
                            addedInstances.Count + removedComponents.Count;
                    if (changeCount > 0)
                    {
                        if (prefabToDirtyInstaces.ContainsKey(prefab))
                            prefabToDirtyInstaces[prefab].Add(instance);
                        else
                        {
                            prefabToDirtyInstaces[prefab] = new List<GameObject>();
                            prefabToDirtyInstaces[prefab].Add(instance);
                        }
                    }
                }

                //分析脏实例中的变体 合并变体
                foreach (var prefabChan in prefabToDirtyInstaces)
                {
                    var prefab = prefabChan.Key;
                    foreach (var dirtyInstace in prefabChan.Value)
                    {
                        bool needCreateNewVariant = true;

                        if (prefabToVariantInstances.ContainsKey(prefab))
                        {
                            foreach (var variantInstance in prefabToVariantInstances[prefab])
                            {
                                bool IsTransformEqual(UnityEngine.Object left, UnityEngine.Object right)
                                {
                                    var obj1 = left as Transform;
                                    var obj2 = right as Transform;
                                    return obj1.localPosition == obj2.localPosition &&
                                        obj1.localRotation == obj2.localRotation &&
                                        obj1.localScale == obj2.localScale;
                                }

                                bool IsEqualComponnet(UnityEngine.Object left, UnityEngine.Object right)
                                {
                                    if (left == null || right == null)
                                    {
                                        Debug.LogError("生成变体预制体：未知错误 参与对比的物体存在null");
                                        return false;
                                    }

                                    if (left.GetType() != right.GetType())
                                    {
                                        Debug.LogError("生成变体预制体：参与对比的物体Type不一致");
                                        return false;
                                    }

                                    Type type = left.GetType();

                                    if (!CanRepairTypes.Contains(type))
                                    {
                                        Debug.LogError($"生成变体预制体：暂未支持的Override类型：{type.Name}");
                                        return false;
                                    }

                                    if (type == typeof(Transform) && !IsTransformEqual(left, right))
                                    {
                                        Debug.LogError($"生成变体预制体：Transform不一致");
                                        return false;
                                    }

                                    return true;
                                }

                                bool IsEqualGameObject(GameObject left, GameObject right)
                                {
                                    return false;
                                }

                                //判断两个脏实例是否可以等价
                                bool IsEqualInstace(GameObject left, GameObject right)
                                {
                                    var overridedObjects1 = PrefabUtility.GetObjectOverrides(left, false);
                                    var addedComponents1 = PrefabUtility.GetAddedComponents(left);
                                    var addedInstances1 = PrefabUtility.GetAddedGameObjects(left);
                                    var removedComponents1 = PrefabUtility.GetRemovedComponents(left);

                                    var overridedObjects2 = PrefabUtility.GetObjectOverrides(right, false);
                                    var addedComponents2 = PrefabUtility.GetAddedComponents(right);
                                    var addedInstances2 = PrefabUtility.GetAddedGameObjects(right);
                                    var removedComponents2 = PrefabUtility.GetRemovedComponents(right);

                                    {
                                        if (overridedObjects1.Count != overridedObjects2.Count)
                                            return false;
                                        if (addedComponents1.Count != addedComponents2.Count)
                                            return false;
                                        if (addedInstances1.Count != addedInstances2.Count)
                                            return false;
                                        if (removedComponents1.Count != removedComponents2.Count)
                                            return false;
                                    }

                                    {
                                        int overridedObjectsCount = overridedObjects1.Count;
                                        for (int i = 0; i < overridedObjectsCount; ++i)
                                        {
                                            var obj1 = overridedObjects1[i].instanceObject;
                                            var obj2 = overridedObjects2[i].instanceObject;
                                            if (!IsEqualComponnet(obj1, obj2))
                                                return false;
                                        }
                                    }

                                    {
                                        int addedComponentsCount = addedComponents1.Count;
                                        for (int i = 0; i < addedComponentsCount; ++i)
                                        {
                                            var obj1 = addedComponents1[i].instanceComponent;
                                            var obj2 = addedComponents2[i].instanceComponent;
                                            if (!IsEqualComponnet(obj1, obj2))
                                                return false;
                                        }
                                    }

                                    {
                                        int addedInstancesCount = addedInstances1.Count;
                                        for (int i = 0; i < addedInstancesCount; ++i)
                                        {
                                            var obj1 = addedInstances1[i].instanceGameObject;
                                            var obj2 = addedInstances2[i].instanceGameObject;
                                            if (!IsEqualGameObject(obj1, obj2))
                                                return false;
                                        }
                                    }

                                    {
                                        int removedComponentsCount = removedComponents1.Count;
                                        for (int i = 0; i < removedComponentsCount; ++i)
                                        {
                                            var obj1 = removedComponents1[i].assetComponent;
                                            var obj2 = removedComponents2[i].assetComponent;
                                            if (obj1 != obj2)
                                                return false;
                                        }
                                    }

                                    //Debug.LogError($"节约一个变体{left.name} 镜像是{right.name}");
                                    return true;
                                }

                                if (IsEqualInstace(dirtyInstace, variantInstance))
                                {
                                    needCreateNewVariant = false;
                                    dirtyInstaceToVariantInstance[dirtyInstace] = variantInstance;
                                    variantInstanceToDirtyInstances[variantInstance].Add(dirtyInstace);
                                    break;
                                }
                            }
                        }

                        if (needCreateNewVariant)
                        {
                            //Debug.LogError($"生成变体预制体：变体数量+1 {dirtyInstace.name}");
                            if (prefabToVariantInstances.ContainsKey(prefab))
                                prefabToVariantInstances[prefab].Add(dirtyInstace);
                            else
                            {
                                prefabToVariantInstances[prefab] = new List<GameObject>();
                                prefabToVariantInstances[prefab].Add(dirtyInstace);
                            }
                            dirtyInstaceToVariantInstance[dirtyInstace] = dirtyInstace;
                            variantInstanceToDirtyInstances[dirtyInstace] = new List<GameObject>();
                            variantInstanceToDirtyInstances[dirtyInstace].Add(dirtyInstace);
                        }
                    }
                }

                //为实例生成引用信息 之后可以断开依赖
                {
                    foreach (var instancePair in instanceToPrefab)
                    {
                        var instance = instancePair.Key;
                        var variantInstance = instancePair.Value; //非脏实例
                        string assetPath = AssetDatabase.GetAssetPath(variantInstance);

                        if (dirtyInstaceToVariantInstance.ContainsKey(instance)) //如果是脏实例
                        {
                            variantInstance = dirtyInstaceToVariantInstance[instance];
                            assetPath = sceneVariantsPath_Prefab + variantInstance.name +
                                    variantInstance.GetInstanceID().ToString() + ".prefab";
                            if (variantInstanceToVariantPath.ContainsKey(variantInstance))
                            {
                                if (variantInstanceToVariantPath[variantInstance] != assetPath)
                                    Debug.LogError($"为实例生成引用信息：未知错误 变体路径不一致 {variantInstanceToVariantPath[variantInstance]} {assetPath}");
                            }
                            else
                            {
                                variantInstanceToVariantPath[variantInstance] = assetPath;
                                allPrefabPaths.Add(assetPath);
                            }
                        }
                        else //非脏实例 公共资源
                        {
                            if (!allPrefabPaths.Contains(assetPath))
                            {
                                allPrefabPaths.Add(assetPath);
                                AssetImporter importer = AssetImporter.GetAtPath(assetPath);
                                string fileName = Path.GetFileNameWithoutExtension(assetPath);
                                string directoryName = Path.GetDirectoryName(assetPath);
                                directoryName = directoryName.Replace("\\", "/");
                                if (directoryName.EndsWith("Type") && directoryName.LastIndexOf("/") > 3)
                                {
                                    string typeName = directoryName.Substring(directoryName.LastIndexOf("/") + 1);
                                    importer.assetBundleName = $"Shared/Prefab/{typeName}/{fileName}.unity3d";
                                }
                                else
                                {
                                    importer.assetBundleName = $"Shared/Prefab/NoType/{fileName}.unity3d";
                                }
                            }
                        }

                        var infoRoot = new GameObject(instance.name).transform;
                        infoRoot.parent = instance.transform.parent;
                        infoRoot.localPosition = instance.transform.localPosition;
                        infoRoot.localRotation = instance.transform.localRotation;
                        infoRoot.localScale = instance.transform.localScale;
                        var info = infoRoot.gameObject.AddComponent<SceneObject>();
                        info._UnityPath = assetPath;
                        instanceToSceneObject[instance] = info;
                    }
                }

                //将变体保存为预制体
                {
                    foreach (var pair in variantInstanceToVariantPath)
                    {
                        var variantInstance = pair.Key;
                        string assetPath = pair.Value;
                        PrefabUtility.UnpackPrefabInstance(variantInstance, PrefabUnpackMode.Completely, InteractionMode.AutomatedAction);
                        var prefab = PrefabUtility.SaveAsPrefabAssetAndConnect(variantInstance, assetPath, InteractionMode.UserAction);
                        if (prefab == null)
                            Debug.LogError($"将变体保存为预制体：未知错误 保存失败 {assetPath}");
                        else
                        {
                            AssetImporter importer = AssetImporter.GetAtPath(assetPath);
                            string fileName = Path.GetFileNameWithoutExtension(assetPath).ToLower();
                            importer.assetBundleName = $"scenes/{scene.name.ToLower()}/prefab/" + fileName + ".unity3d";
                        }
                    }
                }

                //删除实例和临时节点
                {
                    foreach (var instancePair in instanceToPrefab)
                    {
                        var instance = instancePair.Key;
                        DestroyImmediate(instance);
                    }

                    var tempRoot = GameObject.Find(_TempRoot)?.transform;
                    if (tempRoot != null)
                        DestroyImmediate(tempRoot);
                }

                //为所有被引用的资源上bundle标签
                {
                    foreach (var path in allPrefabPaths)
                    {
                        string[] dependPaths = AssetDatabase.GetDependencies(path);
                        foreach (var dependPath in dependPaths)
                        {
                            AssetImporter importer = AssetImporter.GetAtPath(dependPath);
                            string bundleName = importer.assetBundleName;
                            string fileName = Path.GetFileNameWithoutExtension(dependPath).ToLower();
                            string directoryName = Path.GetDirectoryName(dependPath);
                            directoryName = directoryName.Replace("\\", "/");
                            string typeName = directoryName.Substring(directoryName.LastIndexOf("/") + 1).ToLower();
                            if (string.IsNullOrEmpty(bundleName)) //不影响已有的场景
                            {
                                //根据文件的类型分别设置bundle标签
                                if (dependPath.EndsWith(".anim"))
                                {
                                    importer.assetBundleName = $"action/{typeName}/{fileName}.unity3d";
                                }
                                else if (dependPath.EndsWith(".mp3") || dependPath.EndsWith(".ogg"))
                                {
                                    importer.assetBundleName = $"audio/{typeName}/{fileName}.unity3d";
                                }
                                else if (dependPath.EndsWith(".png") || dependPath.EndsWith(".tga"))
                                {
                                    //根据文件的路径设置bundle标签
                                    if (dependPath.StartsWith("Assets/Bundles/Character"))
                                    {
                                        importer.assetBundleName = $"texture/character/{typeName}/{fileName}.unity3d";
                                    }
                                    else if (dependPath.StartsWith("Assets/Bundles/Sfx"))
                                    {
                                        importer.assetBundleName = $"texture/sfx/{typeName}/{fileName}.unity3d";
                                    }
                                }
                                else if (dependPath.EndsWith(".shader"))
                                {
                                    importer.assetBundleName = $"shader/{typeName}/{fileName}.unity3d";
                                }
                                else if (dependPath.EndsWith(".prefab"))
                                {
                                    //根据文件的路径设置bundle标签
                                    if (dependPath.StartsWith("Assets/Bundles/Sfx"))
                                    {
                                        importer.assetBundleName = $"sfx/{typeName}/{fileName}.unity3d";
                                    }
                                    else if (dependPath.StartsWith("Assets/Bundles/Character"))
                                    {
                                        importer.assetBundleName = $"character/{typeName}/{fileName}.unity3d";
                                    }
                                    else if (dependPath.StartsWith("Assets/Bundles/UI"))
                                    {
                                        importer.assetBundleName = $"ui/{typeName}/{fileName}.unity3d";
                                    }
                                    else if (dependPath.StartsWith("Assets/Bundles/Weapon"))
                                    {
                                        importer.assetBundleName = $"weapon/{typeName}/{fileName}.unity3d";
                                    }
                                }
                            }
                        }
                    }
                }
            }

            //打包结束 恢复场景
            {
                EditorSceneManager.SaveScene(SceneManager.GetActiveScene(), sceneVariantsPath_EmptySceneFile, false);
                File.Copy(backUpSceneTempPath, originalSceneUnityPath, true);
                EditorSceneManager.OpenScene(sceneVariantsPath_EmptySceneFile, OpenSceneMode.Single);
                AssetDatabase.Refresh();
                if (File.Exists(backUpSceneTempPath))
                    File.Delete(backUpSceneTempPath);
                EditorSceneManager.OpenScene(originalSceneUnityPath, OpenSceneMode.Single);
            }
        }

        [MenuItem("ET/场景导出/2.预处理Terrain")]
        public static void PreprocessTerrain()
        {
            var scene = SceneManager.GetActiveScene();
            string sceneVariantsPath = _SceneVariantsPath + scene.name + "/";
            string sceneVariantsPath_Terrain = sceneVariantsPath + "Terrain/";

            var sceneRoot = GameObject.Find(_SceneRoot)?.transform;
            if (sceneRoot == null)
            {
                EditorUtility.DisplayDialog("错误", "请检查Scenes节点：" + _SceneRoot, "确定");
                return;
            }

            Terrain terrain = GameObject.Find(_TerrainRoot)?.GetComponent<Terrain>();
            if (terrain == null || terrain.terrainData == null)
            {
                EditorUtility.DisplayDialog("错误", "请检查Terrain节点：" + _TerrainRoot, "确定");
                return;
            }

            //清理Assets下的过期临时文件
            {
                //清空当前场景关联的临时资源目录
                if (Directory.Exists(sceneVariantsPath_Terrain))
                    Directory.Delete(sceneVariantsPath_Terrain, true);

                if (!Directory.Exists(sceneVariantsPath))
                    Directory.CreateDirectory(sceneVariantsPath);
                if (!Directory.Exists(sceneVariantsPath_Terrain))
                    Directory.CreateDirectory(sceneVariantsPath_Terrain);
                AssetDatabase.Refresh();
            }

            var mat = CreateTerrainMaterial(terrain, sceneVariantsPath_Terrain);
            GameObject newTerrainObj = CreateTerrainPrefab(terrain, sceneVariantsPath_Terrain, mat);
            newTerrainObj.transform.SetParent(sceneRoot);

            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();
        }

        private static Material CreateTerrainMaterial(Terrain terrain, string localPath)
        {
            int layerCount = Mathf.Clamp(terrain.terrainData.terrainLayers.Length, 2, 4);

            string materialName = terrain.terrainData.name + "_Material";
            string controlTextureName = terrain.terrainData.name + "_Control";

            string matPath = localPath + "/" + materialName + ".mat";
            string shaderPath = $"{_TerrainShaderName}{layerCount}";
            string controlPath = localPath + "/" + controlTextureName + ".tga";

            Shader shader = Shader.Find(shaderPath);
            if (shader == null)
            {
                EditorUtility.DisplayDialog("~错误~", "找不到Terrain对应的Shader 文件 " + shaderPath, "确定");
                return null;
            }

            Material newMaterial = new Material(shader);
            AssetDatabase.CreateAsset(newMaterial, matPath);

            if (newMaterial != null)
            {
                byte[] bytes = terrain.terrainData.alphamapTextures[0].EncodeToTGA();
                File.WriteAllBytes(controlPath, bytes);
                AssetDatabase.Refresh(ImportAssetOptions.ForceUpdate);

                TextureImporter textureImporter = (TextureImporter)AssetImporter.GetAtPath(controlPath);
                textureImporter.sRGBTexture = false;
                textureImporter.mipmapEnabled = false;
                textureImporter.wrapMode = TextureWrapMode.Clamp;
                textureImporter.textureCompression = TextureImporterCompression.Uncompressed;
                if (layerCount < 4)
                    textureImporter.alphaSource = TextureImporterAlphaSource.None;
                textureImporter.SaveAndReimport();
                Texture controlTexture = AssetDatabase.LoadAssetAtPath<Texture>(controlPath);

                //Layer层数限制 必须在2-4层

                newMaterial.SetTexture("_Control", controlTexture);
                for (int index = 0; index < layerCount; ++index)
                {
                    var layer = terrain.terrainData.terrainLayers[index];
                    newMaterial.SetTexture($"_Splat{index}_Difuse", layer.diffuseTexture);
                    newMaterial.SetTexture($"_Splat{index}_NormalMap", layer.normalMapTexture);
                    newMaterial.SetFloat($"_Splat{index}_NormalScale", layer.normalScale);
                    newMaterial.SetFloat($"_Splat{index}_TileScale", layer.tileSize.x); //xy缩放相等 Offset为0
                    newMaterial.SetFloat($"_Splat{index}_Smoothness", layer.smoothness);
                    newMaterial.SetFloat($"_Splat{index}_Metallic", layer.metallic);
                    float hasAlpha = 1;
                    if (!GraphicsFormatUtility.HasAlphaChannel(GraphicsFormatUtility.GetGraphicsFormat(layer.diffuseTexture.format, true)))
                        hasAlpha = 0;
                    newMaterial.SetFloat($"_Splat{index}_DiffuseHasAlpha", hasAlpha);
                }
            }
            return newMaterial;
        }

        private static GameObject CreateTerrainPrefab(Terrain terrain, string localPath, Material mat)
        {
            TerrainData terrainData = terrain.terrainData;
            Transform prefabRoot = new GameObject("Terrain").transform;
            prefabRoot.position = terrain.transform.position;
            prefabRoot.eulerAngles = terrain.transform.eulerAngles;
            prefabRoot.localScale = terrain.transform.localScale;

            Mesh[] array = terrainData.TerrainToMesh().ExportMesh(28, 28, 10, 10, false, AmazingAssets.TerrainToMesh.Normal.CalculateFromMesh);

            if (array == null || array.Length == 0)
            {
                EditorUtility.DisplayDialog("错误", "Terrain读取mesh失败", "确定");
                return null;
            }

            for (int i = 0; i < array.Length; i++)
            {
                array[i].hideFlags = HideFlags.None;
                string meshPath = localPath + "/" + array[i].name + ".asset";
                AssetDatabase.CreateAsset(array[i], meshPath);
            }
            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();

            //生成地面
            {
                var meshRoot = new GameObject("Meshes").transform;
                meshRoot.parent = prefabRoot;
                meshRoot.localPosition = Vector3.zero;
                meshRoot.rotation = Quaternion.identity;
                meshRoot.localScale = Vector3.one;

                for (int i = 0; i < array.Length; i++)
                {
                    GameObject child = new GameObject(array[i].name);
                    child.transform.parent = meshRoot;
                    child.transform.localPosition = Vector3.zero;
                    MeshFilter meshFilter = child.AddComponent<MeshFilter>();

                    string meshPath = localPath + "/" + array[i].name + ".asset";
                    meshFilter.sharedMesh = AssetDatabase.LoadAssetAtPath<Mesh>(meshPath);
                    MeshRenderer meshRenderer = child.AddComponent<MeshRenderer>();
                    meshRenderer.sharedMaterial = mat;
                }
            }

            //生成树
            if (terrainData.treePrototypes != null && terrainData.treeInstances != null)
            {
                var treeRoot = new GameObject("Trees").transform;
                treeRoot.position = Vector3.zero;
                treeRoot.rotation = Quaternion.identity;
                treeRoot.localScale = Vector3.one;

                for (int j = 0; j < terrainData.treeInstances.Length; j++)
                {
                    TreeInstance treeInstance = terrainData.treeInstances[j];
                    TreePrototype treePrototype = terrainData.treePrototypes[treeInstance.prototypeIndex];
                    GameObject treePrefab = treePrototype?.prefab;

                    if (treePrototype != null && treePrefab != null)
                    {
                        GameObject go = PrefabUtility.InstantiatePrefab(treePrefab) as GameObject;
                        go.name = $"Tree_Type{treeInstance.prototypeIndex}";
                        go.transform.parent = treeRoot;

                        Vector3 position = treeInstance.position;
                        position.x *= terrainData.size.x;
                        position.y *= terrainData.size.y;
                        position.z *= terrainData.size.z;

                        go.transform.position = position;
                        go.transform.localRotation = Quaternion.AngleAxis(Mathf.Rad2Deg * treeInstance.rotation, Vector3.up);

                        Vector3 localScale = treePrefab.transform.localScale;
                        localScale.x *= treeInstance.widthScale;
                        localScale.y *= treeInstance.heightScale;
                        localScale.z *= treeInstance.widthScale;
                        go.transform.localScale = localScale;
                    }
                }
            }

            //保存Prefab
            string prefabPath = localPath + "/" + prefabRoot.name + ".prefab";
            var gameObject = PrefabUtility.SaveAsPrefabAsset(prefabRoot.gameObject, prefabPath, out bool success);
            if (!success)
                EditorUtility.DisplayDialog("错误", "保存预制体失败", "确定");
            gameObject.SetLayerRecursively("Terrain");
            AssetDatabase.Refresh();
            AssetDatabase.SaveAssets();
            return gameObject;
        }

        [MenuItem("ET/场景导出/3.导出场景的烘焙资源")]
        public static void BuildBakeLightingMapAsset()
        {
            if (!(LightmapSettings.lightmaps.Length > 0))
            {
                return;
            }

            HashSet<string> lightMapFileList = new HashSet<string>();

            foreach (LightmapData item in LightmapSettings.lightmaps)
            {
                if (item.lightmapColor != null)
                {
                    string lightmapColorPath = AssetDatabase.GetAssetPath(item.lightmapColor);
                    lightMapFileList.Add(lightmapColorPath);
                }

                if (item.lightmapDir != null)
                {
                    string lightmapDirPath = AssetDatabase.GetAssetPath(item.lightmapDir);
                    lightMapFileList.Add(lightmapDirPath);
                }

                if (item.shadowMask != null)
                {
                    string shadowMaskPath = AssetDatabase.GetAssetPath(item.shadowMask);
                    lightMapFileList.Add(shadowMaskPath);
                }
            }

            Dictionary<string, string> fileMovement = new Dictionary<string, string>();

            foreach (var file in lightMapFileList)
            {
                //将文件移动到Variants目录
                string targetPath = file;
                fileMovement[file] = targetPath;
            }
            AssetDatabase.Refresh();

            foreach (var pair in fileMovement)
            {
                //给文件上bundle标签
            }
            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();
        }
    }
}
