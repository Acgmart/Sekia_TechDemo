#if UNITY_EDITOR //编辑器工具
using UnityEngine;
using UnityEditor;
using System;
using System.IO;
using System.Collections.Generic;
using System.Text;
using System.Security.Cryptography;
using ET;

public partial class ResourceExporter
{
    static string GetBundleSaveDir(BuildTarget target)
    {
        string path;
        switch (target)
        {
            case BuildTarget.Android:
                path = string.Format("{0}/../ABoutputAndroid/", Application.dataPath);
                break;
            case BuildTarget.iOS:
                path = string.Format("{0}/../ABoutputIOS/", Application.dataPath);
                break;
            default:
                path = string.Format("{0}/../ABoutputWindows/", Application.dataPath);
                break;
        }
        return path;
    }

    static void BuildAssetBundles(BuildTarget target, BuildAssetBundleOptions options = BuildAssetBundleOptions.ChunkBasedCompression)
    {
        string dir = GetBundleSaveDir(target);
        Directory.CreateDirectory(Path.GetDirectoryName(dir));

        BuildPipeline.BuildAssetBundles(dir, options, target);

        EditorUtility.DisplayCancelableProgressBar("打包完成 等待保存", "wait....", 0);
        //ResetAssetBundleLabel();
        SaveDependency(target);
        AddToAssetList(target); //添加到全部资源列表
        EditorUtility.ClearProgressBar();

        Debug.Log("打包完成 平台：" + target);
    }

    static string FileMD5(string filePath)
    {
        byte[] retVal;
        using (FileStream file = new FileStream(filePath, FileMode.Open))
        {
            MD5 md5 = new MD5CryptoServiceProvider();
            retVal = md5.ComputeHash(file);
        }
        return ToHex(retVal, "x2");
    }

    static string ToHex(byte[] bytes, string format)
    {
        StringBuilder stringBuilder = new StringBuilder();
        foreach (byte b in bytes)
        {
            stringBuilder.Append(b.ToString(format));
        }
        return stringBuilder.ToString();
    }

    public static void AddToAssetList(BuildTarget target)
    {
        //版本号 总大小 文件列表
        //列表中的单个文件：assetbundlename MD5 文件大小

        //获取旧文件中的数据
        VersionInfo version = new VersionInfo();
        ReadAssetList(target, version);

        //获取常规资源的数据
        string dir = GetBundleSaveDir(target);
        foreach (string directory in Directory.GetDirectories(dir))
        {
            DirectoryInfo dinfo = new DirectoryInfo(directory);

            //Debug.Log("文件夹名：" + dinfo.Name);
            foreach (string file in Directory.GetFiles(directory))
            {
                //输出打包资源 和 自定义资源(Config/Lua)
                if (!file.EndsWith(".bundle") && !file.EndsWith(".ui") && !file.EndsWith(".data"))
                    continue;

                string md5 = FileMD5(file);
                FileInfo fi = new FileInfo(file);
                long size = fi.Length;
                string filePath = $"{dinfo.Name}/{fi.Name}";
                AssetInfo newfile = new AssetInfo
                {
                    MD5 = md5,
                    Size = size,
                };

                version.AssetInfoDict[filePath] = newfile;
            }
        }

        //版本自加1
        int indexDot = version.Version.LastIndexOf(".");
        string versionHead = version.Version.Substring(0, indexDot + 1);
        string versionBack = version.Version.Substring(indexDot + 1);
        int oldVersion = versionBack.StringToInt();
        int newVersion = oldVersion + 1;
        version.Version = versionHead + newVersion.ToString();

        //计算文件总数
        version.TotalNumber = version.AssetInfoDict.Count;

        //计算数据量
        long totalSize = 0;
        foreach (var file in version.AssetInfoDict)
        {
            totalSize += file.Value.Size;
        }
        version.TotalSize = totalSize;

        //写入文件
        WriteAssetList(target, version);
    }

    static void WriteAssetList(BuildTarget target, VersionInfo config)
    {
        string dataPath = GetBundleSaveDir(target) + "assetlist";
        FileStream fs = new FileStream(dataPath, FileMode.Create, FileAccess.ReadWrite);
        BinaryWriter w = new BinaryWriter(fs);

        w.Write(config.Version);
        w.Write(config.TotalNumber);
        w.Write(config.TotalSize);

        foreach (var file in config.AssetInfoDict)
        {
            w.Write(file.Key);
            w.Write(file.Value.MD5);
            w.Write(file.Value.Size);
        }
        w.Close();
        fs.Close();

        string txtPath = Application.dataPath + "/../ServerOnlyFolder/assetlist.txt";
        using (StreamWriter sw = File.CreateText(txtPath))
        {
            string head = "版本：" + config.Version + "  文件数量：" + config.TotalNumber + "  总大小：" + config.TotalSize / 1048576 + "M";
            sw.WriteLine(head);

            foreach (var file in config.AssetInfoDict)
            {
                string line = "资源名：" + file.Key + "  MD5：" + file.Value.MD5 + "  大小：" + file.Value.Size / 1048576 + "M";
                sw.WriteLine(line);
            }
            sw.Close();
        }
    }

    static void ReadAssetList(BuildTarget target, VersionInfo config)
    {
        string dataPath = GetBundleSaveDir(target) + "assetlist";
        if (!File.Exists(dataPath))
            return;

        FileStream fs = new FileStream(dataPath, FileMode.Open, FileAccess.Read);
        BinaryReader br = new BinaryReader(fs);

        config.Version = br.ReadString();
        //Debug.Log("旧版本：" + config.Version);
        config.TotalNumber = br.ReadInt32();
        config.TotalSize = br.ReadInt64();

        string name;
        string md5;
        long size;

        for (int i = 0; i < config.TotalNumber; ++i)
        {
            name = br.ReadString();
            md5 = br.ReadString();
            size = br.ReadInt64();
            AssetInfo newfile = new AssetInfo
            {
                MD5 = md5,
                Size = size,
            };
            config.AssetInfoDict[name] = newfile;
        }
        br.Close();
        fs.Close();
    }

    static void SaveDependency(BuildTarget target)
    {
        //获取旧的依赖关系
        SortedDictionary<string, List<string>> dic = new SortedDictionary<string, List<string>>();
        ReadDependency(target, dic);

        //获取打包生成的依赖关系
        string dir = GetBundleSaveDir(target);
        string depfile = dir.Substring(dir.TrimEnd('/').LastIndexOf("/") + 1);
        depfile = depfile.TrimEnd('/');
        string path = dir + depfile;
        AssetBundle ab = AssetBundle.LoadFromFile(path);
        AssetBundleManifest manifest = (AssetBundleManifest)ab.LoadAsset("AssetBundleManifest");
        ab.Unload(false);

        int assetbundleNumberChange = 0; //有依赖的资源的数量变化
        foreach (string asset in manifest.GetAllAssetBundles())
        {
            List<string> list = new List<string>();
            string[] deps = manifest.GetAllDependencies(asset); //获取全部依赖
            foreach (string dep in deps)
            {
                list.Add(dep);
            }

            if (deps.Length > 0)
            {
                if (!dic.ContainsKey(asset))
                    assetbundleNumberChange += 1; //资源变得有依赖了
                dic[asset] = list;
            }
            else if (dic.ContainsKey(asset))
            {
                assetbundleNumberChange -= 1; //资源不再有依赖了
                dic.Remove(asset);
            }
        }

        if (assetbundleNumberChange != 0)
            Debug.Log("有依赖的资源的数量变化：" + assetbundleNumberChange.ToString());

        WriteDependency(target, dic);
    }

    static void WriteDependency(BuildTarget target, SortedDictionary<string, List<string>> m_Dependencies)
    {
        string dataPath = GetBundleSaveDir(target) + "dependency";
        FileStream fs = new FileStream(dataPath, FileMode.Create, FileAccess.ReadWrite);
        BinaryWriter w = new BinaryWriter(fs);

        w.Write(m_Dependencies.Count);
        foreach (KeyValuePair<string, List<string>> pair in m_Dependencies)
        {
            w.Write(pair.Key);
            w.Write(pair.Value.Count);
            foreach (string s in pair.Value)
            {
                w.Write(s);
            }
        }
        w.Close();
        fs.Close();

        string txtPath = Application.dataPath + "/../ServerOnlyFolder/dependency.txt";
        using (StreamWriter sw = File.CreateText(txtPath))
        {
            sw.WriteLine("有依赖的资源总数：" + m_Dependencies.Count);

            foreach (var pair in m_Dependencies)
            {
                sw.WriteLine();
                string line = "依赖数：" + pair.Value.Count + "  " + pair.Key;
                sw.WriteLine(line);
                foreach (string s in pair.Value)
                {
                    sw.WriteLine(s);
                }
            }
            sw.Close();
        }
    }

    static void ReadDependency(BuildTarget target, SortedDictionary<string, List<string>> dic)
    {
        string dataPath = GetBundleSaveDir(target) + "dependency";
        if (!File.Exists(dataPath))
            return;

        FileStream fs = new FileStream(dataPath, FileMode.Open, FileAccess.Read);
        BinaryReader br = new BinaryReader(fs);

        int size = br.ReadInt32();
        string resname;
        string textureBundleName;

        for (int i = 0; i < size; i++)
        {
            resname = br.ReadString();
            int count = br.ReadInt32();
            if (!dic.ContainsKey(resname))
                dic[resname] = new List<string>();
            for (int j = 0; j < count; ++j)
            {
                textureBundleName = br.ReadString();
                dic[resname].Add(textureBundleName);
            }
        }
        br.Close();
        fs.Close();
    }

    static void SetAssetBundleLabel(Dictionary<string, string> assets)
    {
        EditorUtility.DisplayCancelableProgressBar("设置BundleLabel-不包括依赖项", "wait....", 0);

        AssetImporter importer = null;
        foreach (var pair in assets)
        {
            importer = AssetImporter.GetAtPath(pair.Key);

            if (importer == null)
            {
                Debug.LogError("没有找到资源：" + pair.Key);
            }

            if (importer.assetBundleName == null || importer.assetBundleName != pair.Value)
            {
                importer.assetBundleName = pair.Value;
            }
        }

        EditorUtility.ClearProgressBar();
    }

    static void GetAssetsInFolder(string srcFolder, string searchPattern, string dstFolder, ref Dictionary<string, string> assets)
    {
        //遍历当前文件夹 搜索包含关键词的路径
        string[] files = Directory.GetFiles(srcFolder, searchPattern);
        foreach (string oneFile in files)
        {
            //只能使用bundle作为结尾
            string dstFile = dstFolder + string.Format("{0}.bundle", Path.GetFileNameWithoutExtension(oneFile));
            assets[oneFile] = dstFile;
            //UnityEngine.Debug.Log("srcFile: " + oneFile + " => dstFile: " + dstFile);
        }

        //遍历子文件夹
        string[] dirs = Directory.GetDirectories(srcFolder);
        foreach (string oneDir in dirs)
        {
            GetAssetsInFolder(oneDir, searchPattern, dstFolder, ref assets);
        }
    }

    static void SetAssetBundleDependencyLabel(Dictionary<string, string> assets, string[] depFormats, string depPath, bool bPrefix = false)
    {
        foreach (var pair in assets)
        {
            string[] dependencies = AssetDatabase.GetDependencies(pair.Key);
            foreach (string sdep in dependencies)
            {
                foreach (string format in depFormats)
                {
                    if (sdep.EndsWith(format)) //如果依赖文件包含指定后缀
                    {
                        AssetImporter importer = AssetImporter.GetAtPath(sdep);

                        //被依赖项的资源名
                        string newName = string.Format("{0}{1}.bundle", depPath, Path.GetFileNameWithoutExtension(sdep));
                        newName = newName.Replace(" ", "").ToLower();

                        //UnityEngine.Debug.Log("srcFile: " + sdep + " => dstFile: " + newName);

                        if (importer.assetBundleName == null || importer.assetBundleName != newName)
                        {
                            importer.assetBundleName = newName;
                        }
                    }
                }
            }
        }
    }

    static void ResetAssetBundleLabel()
    {
        string[] oldAssetBundleNames = AssetDatabase.GetAllAssetBundleNames();
        for (int j = 0; j < oldAssetBundleNames.Length; j++)
        {
            AssetDatabase.RemoveAssetBundleName(oldAssetBundleNames[j], true);
        }
    }

    private static string[] GetAllFiles(string path)
    {
        List<string> result = new List<string>();
        GetAllFilesInDirectory(path, result);
        return result.ToArray();
    }

    private static void GetAllFilesInDirectory(string path, List<string> container)
    {
        container.AddRange(Directory.GetFiles(path)); //收集本地文件
        string[] dirs = Directory.GetDirectories(path);
        if (dirs.Length > 0)
        {
            foreach (var k in dirs)
            {
                GetAllFilesInDirectory(k, container);
            }
        }
    }

    [MenuItem("Tools/清除进度条")]
    static void ClearProgressBar()
    {
        EditorUtility.ClearProgressBar();
    }

    [MenuItem("Tools/打包AssetBundle/不改动标签-直接打包")]
    static void ExportByDefault()
    {
        BuildAssetBundles(BuildTarget.StandaloneWindows);
    }
}
#endif
