using UnityEngine;

public class Drawable : MonoBehaviour
{
    public int textureSize = 1024;
    public RenderTexture output;
    public Color initialColor = Color.gray;
    public Material fillCrack;

    RenderTexture[] pingPongRts;
    Mesh mesh;

    void Start()
    {
        output = new RenderTexture(textureSize, textureSize, 0, RenderTextureFormat.ARGBHalf);
        output.Create();
        var r = GetComponent<Renderer>();
        var mpb = new MaterialPropertyBlock();
        r.GetPropertyBlock(mpb);
        mpb.SetTexture("_MainTex", output);
        r.SetPropertyBlock(mpb);

        pingPongRts = new RenderTexture[2];
        for (var i = 0; i < 2; i++)
        {
            var outputRt = new RenderTexture(textureSize, textureSize, 0, RenderTextureFormat.ARGBHalf);
            outputRt.Create();
            RenderTexture.active = outputRt;
            GL.Clear(true, true, initialColor);
            pingPongRts[i] = outputRt;
        }
        mesh = GetComponent<MeshFilter>().sharedMesh;

        Graphics.CopyTexture(pingPongRts[0], output);
    }

    private void OnDestroy()
    {
        foreach (var rt in pingPongRts)
            rt.Release();
        output.Release();
    }

    public void Draw(Material drawingMat)
    {
        var currentActive = RenderTexture.active;

        RenderTexture.active = pingPongRts[1];
        GL.Clear(true, true, Color.clear);
        drawingMat.SetTexture("_MainTex", pingPongRts[0]);
        drawingMat.SetPass(0); //写入临时1号贴图
        Graphics.DrawMeshNow(mesh, transform.localToWorldMatrix);

        RenderTexture.active = currentActive;

        Swap(pingPongRts); //交换临时0号和1号 保证1号是下一个写入目标

        if (fillCrack != null)
        {
            Graphics.Blit(pingPongRts[0], pingPongRts[1], fillCrack); //对写入结果进行后处理
            Swap(pingPongRts);
        }

        Graphics.CopyTexture(pingPongRts[0], output); //输出写入结果 更新模型纹理
    }

    void Swap<T>(T[] array)
    {
        var tmp = array[0];
        array[0] = array[1];
        array[1] = tmp;
    }
}
