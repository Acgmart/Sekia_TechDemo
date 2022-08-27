using System;
using System.Linq;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;

namespace Sekia
{
    [Serializable, ReloadGroup, ExcludeFromPreset]
    public class SekiaRendererData : ScriptableObject
    {
        /// <summary>
        /// 是否为非法 非法实例将在下次访问时重新实例化
        /// </summary>
        internal bool isInvalidated;
        [SerializeField] public bool useCopyColorRT = false;
        [SerializeField] public bool useCopyDepthRT = false;
        [SerializeField] public bool useRenderPass = false;
        [SerializeField] public bool useIntermediateRT = false;
        [SerializeField] internal List<SekiaRendererFeature> m_Features_Gameview = new List<SekiaRendererFeature>(10);
        [SerializeField] internal List<SekiaRendererFeature> m_Features_Sceneview = new List<SekiaRendererFeature>(10);
        [SerializeField] internal List<SekiaRendererFeature> m_Features_Preview = new List<SekiaRendererFeature>(10);

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
