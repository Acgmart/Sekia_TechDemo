using UnityEngine;

namespace KleinianGroup
{
    [ExecuteAlways]
    [RequireComponent(typeof(Camera))]
    public class KleinianGroup : MonoBehaviour
    {
        public Material material;
        public int pass;
        public Color hitColor = Color.red;
        public Color backColor = Color.gray;
        public int iteration = 500;
        public float scale = 1f;
        public Vector2 offset;
        public Vector4 circle = new Vector4(0,0,0,1);
        public Vector2 kleinUV = new Vector2(2, 0);

        public bool useUVAnimation;
        public AnimationCurve animKleinU;
        public AnimationCurve animKleinV;

        public float timeScale = 1f;

        float time => Time.time * timeScale;

        private void OnRenderImage(RenderTexture source, RenderTexture destination)
        {
            material.SetColor("_HitColor", hitColor);
            material.SetColor("_BackColor", backColor);
            material.SetInt("_Iteration", iteration);
            material.SetFloat("_Scale", scale);
            material.SetVector("_Offset", offset);
            material.SetVector("_Circle", circle);

            Vector2 uv = kleinUV;
            if ( useUVAnimation)
            {
                uv = new Vector2(
                    animKleinU.Evaluate(time),
                    animKleinV.Evaluate(time)
                    );           
            }
            material.SetVector("_KleinUV", uv);
            Graphics.Blit(source, destination, material, pass);
        }
    }

}