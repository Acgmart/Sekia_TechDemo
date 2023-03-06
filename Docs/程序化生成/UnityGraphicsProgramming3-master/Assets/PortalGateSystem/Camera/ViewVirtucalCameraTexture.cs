using UnityEngine;


namespace PortalGateSystem
{
    public class ViewVirtucalCameraTexture : MonoBehaviour
    {
        public VirtualCamera virtualCamera;

        private void OnRenderImage(RenderTexture source, RenderTexture destination)
        {
            var tex = virtualCamera?.targetTexture ?? source;

            Graphics.Blit(tex, destination);   
        }
    }
}
