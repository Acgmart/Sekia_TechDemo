using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;
using System.IO;
using System.Linq;

public static class BuildHelper
{
    private const string _BundleOutputPath = "/../BundleOutput/";

    public static string GetCurrentPlatformName()
    {
        switch (EditorUserBuildSettings.activeBuildTarget)
        {
            case BuildTarget.Android:
                return "Android";
            case BuildTarget.iOS:
                return "iOS";
            case BuildTarget.StandaloneWindows:
            case BuildTarget.StandaloneWindows64:
                return "Windows";
            case BuildTarget.StandaloneOSX:
                return "OSX";
            default:
                return null;
        }
    }

    public static void BuildBundleList(string sceneName, AssetBundleBuild[] bundleList)
    {
        string fullPath = Application.dataPath + _BundleOutputPath +
            GetCurrentPlatformName() + "/" + sceneName + "/";

        if (Directory.Exists(fullPath))
            Directory.Delete(fullPath, true);

        if (!Directory.Exists(fullPath))
            Directory.CreateDirectory(fullPath);

        BuildPipeline.BuildAssetBundles(fullPath, bundleList,
            BuildAssetBundleOptions.ChunkBasedCompression, //压缩资源
            EditorUserBuildSettings.activeBuildTarget); //基于当前平台
    }

    public static void BuildTargetGameObject(GameObject gameObject)
    {
        HashSet<string> depends = new HashSet<string>();
        gameObject.transform.GetCorrespondingPrefabPaths(depends);
        AssetBundleBuild[] bundles = AnalyzeDependenciesForOneScene(depends.ToList());
    }

    public class RefNode
    {
        public string unityPath; //以Assets/开头的路径
        public bool isRoot; //引用链的起点 或者 指定单独出bundle的物体
        public bool isCombine; //合并到上一级阶段 不单独设置bundle路径
        public List<string> combineList = new List<string>(); //当前节点合并了的节点列表
        public Dictionary<string, RefNode> deps = new Dictionary<string, RefNode>(); //依赖于
        public Dictionary<string, RefNode> refs = new Dictionary<string, RefNode>(); //被引用
    }

    public static void AddDependencies(string assetPath, RefNode refNode, Dictionary<string, RefNode> refNodeList)
    {
        string unityPath = assetPath.Replace("\\", "/");
        if (unityPath == refNode.unityPath)
            return;
        if (!refNodeList.ContainsKey(unityPath))
        {
            RefNode childNode = new RefNode();
            childNode.unityPath = unityPath;
            childNode.combineList.Add(unityPath);
            refNode.deps.Add(unityPath, childNode);
            childNode.refs.Add(refNode.unityPath, refNode);

            refNodeList.Add(unityPath, childNode);
            string[] dependPaths = AssetDatabase.GetDependencies(childNode.unityPath);
            foreach (var dependPath in dependPaths)
                AddDependencies(dependPath, childNode, refNodeList);
        }
    }

    public static bool DeleteRepeatReference(RefNode reference, RefNode depend)
    {
        bool continueCheck = false;
        if (reference.deps.ContainsKey(depend.unityPath))
        {
            Debug.LogError("断开一次");
            reference.deps.Remove(depend.unityPath);
            depend.refs.Remove(reference.unityPath);
            continueCheck = true;
        }

        foreach (var beDependNode in reference.refs.Values)
            continueCheck |= DeleteRepeatReference(beDependNode, depend);
        return continueCheck;
    }

    public static bool IsBeDependsEqual(RefNode a, RefNode b)
    {
        if (a.refs.Count != b.refs.Count) return false;
        if (a.refs.Count == 0) return false;
        foreach (var beDepend in a.refs.Values)
            if (!b.refs.ContainsKey(beDepend.unityPath))
                return false;
        return true;
    }

    public static AssetBundleBuild[] AnalyzeDependenciesForOneScene(List<string> depends)
    {
        Dictionary<string, RefNode> refNodeList = new Dictionary<string, RefNode>();
        List<AssetBundleBuild> bundles = new List<AssetBundleBuild>();

        void AddDependencies(string assetPath, RefNode refNode)
        {
            string unityPath = assetPath.Replace("\\", "/");
            if (unityPath == refNode.unityPath)
                return;
            RefNode childNode = null;
            if (refNodeList.ContainsKey(unityPath))
                childNode = refNodeList[unityPath];
            else
            {
                childNode = new RefNode();
                childNode.unityPath = unityPath;
                childNode.combineList.Add(unityPath);
                refNode.deps.Add(unityPath, childNode);
                childNode.refs.Add(refNode.unityPath, refNode);

                refNodeList.Add(unityPath, childNode);
                string[] dependPaths = AssetDatabase.GetDependencies(childNode.unityPath);
                foreach (var dependPath in dependPaths)
                    AddDependencies(dependPath, childNode);
            }
        }

        bool DeleteRepeatReference(RefNode reference, RefNode depend)
        {
            bool continueCheck = false;
            if (reference.deps.ContainsKey(depend.unityPath))
            {
                reference.deps.Remove(depend.unityPath);
                depend.refs.Remove(reference.unityPath);
                continueCheck = true;
            }

            foreach (var beDependNode in reference.refs.Values)
                continueCheck |= DeleteRepeatReference(beDependNode, depend);
            return continueCheck;
        }

        bool IsBeDependsEqual(RefNode a, RefNode b)
        {
            if (a.refs.Count != b.refs.Count) return false;
            if (a.refs.Count == 0) return false;
            foreach (var beDepend in a.refs.Values)
                if (!b.refs.ContainsKey(beDepend.unityPath))
                    return false;
            return true;
        }

        //收集引用链
        for (int i = 0; i < depends.Count; ++i)
        {
            string unityPath = depends[i].Substring(depends[i].IndexOf("Assets/"));
            unityPath = unityPath.Replace("\\", "/");

            RefNode refNode = null;
            if (refNodeList.ContainsKey(unityPath))
            {
                refNode = refNodeList[unityPath];
                refNode.isRoot = true;
            }
            else
            {
                refNode = new RefNode();
                refNode.unityPath = unityPath;
                refNode.isRoot = true;
                refNode.combineList.Add(unityPath);
                refNodeList.Add(unityPath, refNode);

                string[] dependPaths = AssetDatabase.GetDependencies(refNode.unityPath);
                foreach (var dependPath in dependPaths)
                    AddDependencies(dependPath, refNode);
            }
        }

        //简化引用链 如果A引用B和C B引用C 那么A可以删除对C的引用
        bool hasFindAnyTarget = true;
        while (hasFindAnyTarget)
        {
            foreach (var node in refNodeList.Values)
                foreach (var depend in node.deps.Values) //遍历下级
                    foreach (var reference in node.refs.Values) //循环遍历上级
                        hasFindAnyTarget = DeleteRepeatReference(reference, depend);
        }

        //减少bundle个数 如果A引用B B的引用次数为1 那么B可以被A合并
        hasFindAnyTarget = true;
        while (hasFindAnyTarget)
        {
            hasFindAnyTarget = false;
            foreach (var node in refNodeList.Values)
            {
                if (node.isRoot) continue;
                if (node.refs.Count != 1) continue;

                //上一级不再引用本节点
                var reference = node.refs.Values.ToArray()[0];
                reference.deps.Remove(node.unityPath);

                //本节点不再引用下一级 改为上一级节点引用下一级
                foreach (var depend in node.deps.Values)
                {
                    depend.refs.Remove(node.unityPath);

                    if (!depend.refs.ContainsKey(reference.unityPath))
                        depend.refs.Add(reference.unityPath, reference);

                    if (!reference.deps.ContainsKey(depend.unityPath))
                        reference.deps.Add(depend.unityPath, depend);
                }

                refNodeList.Remove(node.unityPath);
                hasFindAnyTarget = true;
            }
        }

        //减少bundle个数 如果A和B都引用了C和D D可以被C合并
        hasFindAnyTarget = true;
        while (hasFindAnyTarget)
        {
            hasFindAnyTarget = false;
            var abNodes = refNodeList.Values.OrderBy(a => a.unityPath).ToArray();
            for (int i = 0; i < abNodes.Length; i++)
            {
                if (abNodes[i].isRoot) continue;
                if (abNodes[i].isCombine) continue;

                for (int j = i + 1; j < abNodes.Length; j++)
                {
                    if (abNodes[j].isRoot) continue;
                    if (abNodes[j].isCombine) continue;
                    if (!IsBeDependsEqual(abNodes[i], abNodes[j])) continue;

                    abNodes[i].combineList.Add(abNodes[j].unityPath);
                    abNodes[j].isCombine = true;
                    hasFindAnyTarget = true;
                }
            }
        }


        foreach (var abNode in refNodeList.Values)
        {
            if (abNode.isCombine) continue;

            AssetBundleBuild abBuild = new AssetBundleBuild();
            abBuild.assetBundleName = AssetDatabase.AssetPathToGUID(abNode.unityPath) + ".unity3d";
            abBuild.assetNames = abNode.combineList.ToArray();
            bundles.Add(abBuild);
        }

        return bundles.ToArray();
    }

    public static void AnalyzeDependenciesForProject(List<string> depends)
    {
        Dictionary<string, RefNode> refNodeList = new Dictionary<string, RefNode>();

        //收集引用链
        for (int i = 0; i < depends.Count; ++i)
        {
            string unityPath = depends[i].Substring(depends[i].IndexOf("Assets/"));
            unityPath = unityPath.Replace("\\", "/");

            RefNode refNode;
            if (refNodeList.ContainsKey(unityPath))
            {
                refNode = refNodeList[unityPath];
                refNode.isRoot = true;
            }
            else
            {
                refNode = new RefNode();
                refNode.unityPath = unityPath;
                refNode.isRoot = true;
                refNode.combineList.Add(unityPath);
                refNodeList.Add(unityPath, refNode);

                string[] dependPaths = AssetDatabase.GetDependencies(refNode.unityPath);
                foreach (var dependPath in dependPaths)
                    AddDependencies(dependPath, refNode, refNodeList);
            }
        }

        //简化引用链 如果A引用B和C B引用C 那么A可以删除对C的引用
        bool hasFindAnyTarget = true;
        while (hasFindAnyTarget)
        {
            foreach (var node in refNodeList.Values)
                foreach (var depend in node.deps.Values) //遍历下级
                    foreach (var reference in node.refs.Values) //循环遍历上级
                        hasFindAnyTarget = DeleteRepeatReference(reference, depend);
        }

        /*
        //减少bundle个数 如果A引用B B的引用次数为1 那么B可以被A合并
        hasFindAnyTarget = true;
        while (hasFindAnyTarget)
        {
            hasFindAnyTarget = false;
            foreach (var node in refNodeList.Values)
            {
                if (node.isRoot) continue;
                if (node.refs.Count != 1) continue;

                //上一级不再引用本节点
                var reference = node.refs.Values.ToArray()[0];
                reference.deps.Remove(node.unityPath);

                //本节点不再引用下一级 改为上一级节点引用下一级
                foreach (var depend in node.deps.Values)
                {
                    depend.refs.Remove(node.unityPath);

                    if (!depend.refs.ContainsKey(reference.unityPath))
                        depend.refs.Add(reference.unityPath, reference);

                    if (!reference.deps.ContainsKey(depend.unityPath))
                        reference.deps.Add(depend.unityPath, depend);
                }

                refNodeList.Remove(node.unityPath);
                hasFindAnyTarget = true;
            }
        }

        //减少bundle个数 如果A和B都引用了C和D D可以被C合并
        hasFindAnyTarget = true;
        while (hasFindAnyTarget)
        {
            hasFindAnyTarget = false;
            var abNodes = refNodeList.Values.OrderBy(a => a.unityPath).ToArray();
            for (int i = 0; i < abNodes.Length; i++)
            {
                if (abNodes[i].isRoot) continue;
                if (abNodes[i].isCombine) continue;

                for (int j = i + 1; j < abNodes.Length; j++)
                {
                    if (abNodes[j].isRoot) continue;
                    if (abNodes[j].isCombine) continue;
                    if (!IsBeDependsEqual(abNodes[i], abNodes[j])) continue;

                    abNodes[i].combineList.Add(abNodes[j].unityPath);
                    abNodes[j].isCombine = true;
                    hasFindAnyTarget = true;
                }
            }
        }
        */

        foreach (var abNode in refNodeList.Values)
        {
            if (abNode.isCombine) continue;

            AssetBundleBuild abBuild = new AssetBundleBuild();
            abBuild.assetBundleName = AssetDatabase.AssetPathToGUID(abNode.unityPath) + ".unity3d";
            abBuild.assetNames = abNode.combineList.ToArray();
        }
    }
}
