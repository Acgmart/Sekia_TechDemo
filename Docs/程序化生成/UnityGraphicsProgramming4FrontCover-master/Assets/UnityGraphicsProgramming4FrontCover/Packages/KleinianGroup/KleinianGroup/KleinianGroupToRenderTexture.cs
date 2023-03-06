using UnityEngine;

namespace KleinianGroup
{
    [ExecuteAlways]
    public class KleinianGroupToRenderTexture : MonoBehaviour
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
        //public float time = 0.0f;

        [Header("Texture Parameters")]
        public Vector2Int size;

        public RenderTexture tex_;
        public RenderTexture texture => tex_ ?? (tex_ = new RenderTexture(size.x, size.y, 0));


        private void Awake()
        {
            tex_ = null;
        }

        private void Update()
        {
            UpdateTexture();
        }

        private void UpdateTexture()
        {
            material.SetColor("_HitColor", hitColor);
            material.SetColor("_BackColor", backColor);
            material.SetInt("_Iteration", iteration);
            material.SetFloat("_Scale", scale);
            material.SetVector("_Offset", offset);
            material.SetVector("_Circle", circle);
            material.SetFloat("_Aspect", (float)tex_.width / tex_.height);

            Vector2 uv = kleinUV;
            if ( useUVAnimation)
            {
                uv = new Vector2(
                    animKleinU.Evaluate(time),
                    animKleinV.Evaluate(time)
                    );           
            }
            material.SetVector("_KleinUV", uv);

            var tmp = RenderTexture.active;
            RenderTexture.active = texture;

            Graphics.Blit(null, texture, material, pass);

            RenderTexture.active = tmp;
        }
    }

}