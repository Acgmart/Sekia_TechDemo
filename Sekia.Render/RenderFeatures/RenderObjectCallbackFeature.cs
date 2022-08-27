using UnityEngine;
using UnityEngine.Rendering;

namespace Sekia
{
    public class RenderObjectCallbackFeature : ScriptableRendererFeature
    {
        internal class FeaturePass : ScriptableRenderPass
        {
            public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
            {
                context.InvokeOnRenderObjectCallback();
            }
        }

        [System.Serializable]
        public class FeatureSettings
        {
            public string profilerTag = "RenderObjectCallbackFeature";
        }

        public FeatureSettings settings = new FeatureSettings();
        FeaturePass pass;

        public override void Create()
        {
            if (string.IsNullOrEmpty(settings.profilerTag))
                settings.profilerTag = this.name;
            pass = new FeaturePass();
        }

        public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData)
        {
            renderer.EnqueuePass(pass);
        }
    }
}
