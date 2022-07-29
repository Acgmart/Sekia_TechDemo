using System;
using UnityEngine.Scripting.APIUpdating;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

namespace Sekia
{
    /// <summary>
    /// You can add a <c>SekiaRendererFeature</c> to the <c>SekiaRenderer</c>. Use this scriptable renderer feature to inject render passes into the renderer.
    /// </summary>
    /// <seealso cref="SekiaRenderer"/>
    /// <seealso cref="SekiaRendererPass"/>
    [ExcludeFromPreset]
    public abstract class SekiaRendererFeature : ScriptableObject, IDisposable
    {
        [SerializeField, HideInInspector] private bool m_Active = true;
        /// <summary>
        /// Returns the state of the ScriptableRenderFeature (true: the feature is active, false: the feature is inactive). Use the method ScriptableRenderFeature.SetActive to change the value of this variable.
        /// </summary>
        public bool isActive => m_Active;

        /// <summary>
        /// Initializes this feature's resources. This is called every time serialization happens.
        /// </summary>
        public abstract void Create();

        /// <summary>
        /// Callback before cull happens in renderer.
        /// </summary>
        /// <param name="renderer">Renderer of callback.</param>
        /// <param name="cameraData">CameraData contains all relevant render target information for the camera.</param>
        public virtual void OnCameraPreCull(SekiaRenderer renderer, in CameraData cameraData) { }

        /// <summary>
        /// Injects one or multiple <c>SekiaRendererPass</c> in the renderer.
        /// </summary>
        /// <param name="renderer">Renderer used for adding render passes.</param>
        /// <param name="renderingData">Rendering state. Use this to setup render passes.</param>
        public abstract void AddRenderPasses(SekiaRenderer renderer, ref RenderingData renderingData);

        /// <summary>
        /// Callback after render targets are initialized. This allows for accessing targets from renderer after they are created and ready.
        /// </summary>
        /// <param name="renderer">Renderer used for adding render passes.</param>
        /// <param name="renderingData">Rendering state. Use this to setup render passes.</param>
        public virtual void SetupRenderPasses(SekiaRenderer renderer, in RenderingData renderingData) { }

        void OnEnable()
        {
            Create();
        }

        void OnValidate()
        {
            Create();
        }

        /// <summary>
        /// Override this method and return true if the feature should use the Native RenderPass API
        /// </summary>
        internal virtual bool SupportsNativeRenderPass()
        {
            return false;
        }

        /// <summary>
        /// Override this method and return true that renderer would produce rendering layers texture.
        /// </summary>
        /// <param name="isDeferred">True if renderer is using deferred rendering mode</param>
        /// <param name="atEvent">Requeted event at which rendering layers texture will be produced</param>
        /// <param name="maskSize">Requested bit size of rendering layers texture</param>
        /// <returns></returns>
        internal virtual bool RequireRenderingLayers(bool isDeferred, out RenderingLayerUtils.Event atEvent, out RenderingLayerUtils.MaskSize maskSize)
        {
            atEvent = RenderingLayerUtils.Event.DepthNormalPrePass;
            maskSize = RenderingLayerUtils.MaskSize.Bits8;
            return false;
        }

        /// <summary>
        /// Sets the state of ScriptableRenderFeature (true: the feature is active, false: the feature is inactive).
        /// If the feature is active, it is added to the renderer it is attached to, otherwise the feature is skipped while rendering.
        /// </summary>
        /// <param name="active">The true value activates the ScriptableRenderFeature and the false value deactivates it.</param>
        public void SetActive(bool active)
        {
            m_Active = active;
        }

        /// <summary>
        /// Disposable pattern implementation.
        /// </summary>
        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        protected virtual void Dispose(bool disposing)
        {
        }
    }
}
