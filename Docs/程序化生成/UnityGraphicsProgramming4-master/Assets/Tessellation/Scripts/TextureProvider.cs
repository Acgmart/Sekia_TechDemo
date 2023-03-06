using UnityEngine;

public class TextureProvider : MonoBehaviour
{
    [SerializeField] Renderer render = null;
    [SerializeField] string provideTexProp = "_DispTex";
    MaterialPropertyBlock mpb = null;
    int provideId;

    public Texture ProvideTex { get; set; }

    void Start()
    {
        mpb = new MaterialPropertyBlock();
        provideId = Shader.PropertyToID(provideTexProp);
        if (!render) render = GetComponent<Renderer>();
    }

    void Update()
    {
        if (!ProvideTex) return;
        mpb.SetTexture(provideId, ProvideTex);
        render.SetPropertyBlock(mpb);
    }
}
