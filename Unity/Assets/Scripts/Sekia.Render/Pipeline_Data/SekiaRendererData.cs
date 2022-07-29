using System;
using System.Linq;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

namespace Sekia
{
    [Serializable, ReloadGroup, ExcludeFromPreset]
    [URPHelpURL("urp-universal-renderer")]
    public class SekiaRendererData : ScriptableObject
    {
        /// <summary>
        /// 是否为非法 非法实例将在下次访问时重新实例化
        /// </summary>
        internal bool isInvalidated;
        [SerializeField] internal List<SekiaRendererFeature> m_RendererFeatures = new List<SekiaRendererFeature>(10);
        /// <summary>
        /// 保存feature的localId用于确认是否序列号成功
        /// </summary>
        [SerializeField] internal List<long> m_RendererFeatureMap = new List<long>(10);

        public new void SetDirty()
        {
            isInvalidated = true;
        }

        internal SekiaRenderer InternalCreateRenderer()
        {
            isInvalidated = false;
            return new SekiaRenderer(this);
        }

        private void OnEnable()
        {
            SetDirty();
        }

#if UNITY_EDITOR
        private void OnValidate()
        {
            SetDirty();
            if (m_RendererFeatures.Contains(null))
                ValidateRendererFeatures();
        }

        private bool ValidateRendererFeatures()
        {
            // Get all Subassets
            var assetPath = UnityEditor.AssetDatabase.GetAssetPath(this);
            var subassets = UnityEditor.AssetDatabase.LoadAllAssetsAtPath(assetPath);
            var linkedIds = new List<long>();
            var loadedAssets = new Dictionary<long, object>();
            var mapValid = m_RendererFeatureMap != null && m_RendererFeatureMap?.Count == m_RendererFeatures?.Count;
            var debugOutput = $"{name}\nValid Sub-assets:\n";

            //收集合法的反序列化成功的sub-assets
            foreach (var asset in subassets)
            {
                if (asset == null || asset.GetType().BaseType != typeof(SekiaRendererFeature))
                    continue;
                UnityEditor.AssetDatabase.TryGetGUIDAndLocalFileIdentifier(asset, out var guid, out long localId);
                loadedAssets.Add(localId, asset);
                debugOutput += $"-{asset.name}\n--localId={localId}\n";
            }

            //收集在列表中的feature assets
            for (var i = 0; i < m_RendererFeatures?.Count; i++)
            {
                if (!m_RendererFeatures[i])
                    continue;
                if (UnityEditor.AssetDatabase.TryGetGUIDAndLocalFileIdentifier(m_RendererFeatures[i], out var guid, out long localId))
                {
                    linkedIds.Add(localId);
                }
            }

            var mapDebug = mapValid ? "Linking" : "Map missing, will attempt to re-map";
            debugOutput += $"Feature List Status({mapDebug}):\n";

            // Try fix missing references
            for (var i = 0; i < m_RendererFeatures?.Count; i++)
            {
                if (m_RendererFeatures[i] == null) //列表中不应存在null对象 将null对象重新加载
                {
                    if (mapValid && m_RendererFeatureMap[i] != 0) //根据localId重映射
                    {
                        var localId = m_RendererFeatureMap[i];
                        loadedAssets.TryGetValue(localId, out var asset);
                        m_RendererFeatures[i] = (SekiaRendererFeature)asset;
                    }
                    else
                    {
                        //sub assets和list存在不一一对应的情况
                        //遍历sub assets中是否有list中不存在的对象 并添加到list中
                        m_RendererFeatures[i] = (SekiaRendererFeature)GetUnusedAsset(ref linkedIds, ref loadedAssets);
                    }
                }

                debugOutput += m_RendererFeatures[i] != null ? $"-{i}:Linked\n" : $"-{i}:Missing\n";
            }

            UpdateMap(); //根据feature list现状更新localId列表

            if (!m_RendererFeatures.Contains(null))
                return true;

            Debug.LogError($"{name} is missing RendererFeatures\nThis could be due to missing scripts or compile error.", this);
            return false;
        }

        private static object GetUnusedAsset(ref List<long> usedIds, ref Dictionary<long, object> assets)
        {
            foreach (var asset in assets)
            {
                var alreadyLinked = usedIds.Any(used => asset.Key == used);

                if (alreadyLinked)
                    continue;

                usedIds.Add(asset.Key);
                return asset.Value;
            }

            return null;
        }

        private void UpdateMap()
        {
            if (m_RendererFeatureMap.Count != m_RendererFeatures.Count)
            {
                m_RendererFeatureMap.Clear();
                m_RendererFeatureMap.AddRange(new long[m_RendererFeatures.Count]);
            }

            for (int i = 0; i < m_RendererFeatures.Count; i++)
            {
                if (m_RendererFeatures[i] == null)
                    continue;
                if (!UnityEditor.AssetDatabase.TryGetGUIDAndLocalFileIdentifier(m_RendererFeatures[i], out var guid, out long localId))
                    continue;
                m_RendererFeatureMap[i] = localId;
            }
        }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Performance", "CA1812")]
        private class CreateSkiaRendererAsset : UnityEditor.ProjectWindowCallback.EndNameEditAction
        {
            public override void Action(int instanceId, string pathName, string resourceFile)
            {
                var instance = SekiaPipelineAsset.CreateRendererAsset(pathName);
                UnityEditor.Selection.activeObject = instance;
            }
        }

        [UnityEditor.MenuItem("Assets/Create/Rendering/SekiaRenderer", priority = CoreUtils.Sections.section2 + CoreUtils.Priorities.assetsCreateRenderingMenuPriority - 1)]
        private static void CreateUniversalRendererData()
        {
            UnityEditor.ProjectWindowUtil.StartNameEditingIfProjectWindowExists(
                0, CreateInstance<CreateSkiaRendererAsset>(), "SekiaRendererData.asset", null, null);
        }
#endif
    }
}
