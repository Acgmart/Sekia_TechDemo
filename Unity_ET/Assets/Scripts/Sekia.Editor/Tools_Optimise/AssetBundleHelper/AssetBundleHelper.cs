using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEditor;
using UnityEngine;

namespace Sekia
{
    public class AssetBundleHelper : Editor
    {
        [MenuItem("Assets/设置bundle名/设置所选文件的默认bundle名(多选)")]
        public static void SetSelectedGameObjectsAssetsName()
        {
            for (int i = 0; i < Selection.gameObjects.Length; i++)
            {
                string fileFullPath = AssetDatabase.GetAssetPath(Selection.gameObjects[i]);
                AssetImporter importer = AssetImporter.GetAtPath(fileFullPath);
                importer.assetBundleName = $"{Selection.gameObjects[i].name}.unity3d";
                Debug.Log($"设置Bundle名：fileName{Selection.gameObjects[i].name} bundleName{importer.assetBundleName}");
            }
        }


        [MenuItem("Assets/设置bundle名/设置所选文件的默认bundle名(单选)")]
        public static void SetSelectedAssetsName()
        {
            string fileFullPath = AssetDatabase.GetAssetPath(Selection.activeObject);
            AssetImporter importer = AssetImporter.GetAtPath(fileFullPath);
            importer.assetBundleName = $"{Selection.activeObject.name}.unity3d";
            Debug.Log($"设置Bundle名：fileName{Selection.activeObject.name} bundleName{importer.assetBundleName}");
        }

        [MenuItem("Assets/设置bundle名/删除bundle名(单选)")]
        public static void ClearSelectedAssetsName()
        {
            string fileFullPath = AssetDatabase.GetAssetPath(Selection.activeObject);
            AssetImporter importer = AssetImporter.GetAtPath(fileFullPath);
            importer.assetBundleName = "";
            Debug.Log($"删除bundle名：fileName{Selection.activeObject.name}");

        }
    }
}
