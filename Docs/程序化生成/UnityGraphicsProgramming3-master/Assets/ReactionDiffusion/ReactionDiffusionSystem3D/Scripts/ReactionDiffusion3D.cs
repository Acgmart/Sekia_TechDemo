using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Runtime.InteropServices;

public class ReactionDiffusion3D : MonoBehaviour {
    public struct RDData
    {
        public float u;
        public float v;
    }

    const int THREAD_NUM_X = 10;

    #region public
    public int texWidth = 256;
    public int texHeight = 256;
    public int texDepth = 256;

    public float du = 1;
    public float dv = 0.5f;
    [Range(0,0.1f)]
    public float f = 0.055f;
    [Range(0, 0.1f)]
    public float k = 0.062f;
    [Range(0, 32)]
    public int speed = 1;

    public int seedSize = 10;
    public int seedNum = 10;

    public int inputMax = 32;

    public ComputeShader cs;

    public RenderTexture heightMapTexture;
    #endregion

    #region private
    private int kernelClear = -1;
    private int kernelUpdate = -1;
    private int kernelDraw = -1;
    private int kernelAddSeed = -1;
    private int kernelDellSeed = -1;

    private ComputeBuffer[] buffers;
    private ComputeBuffer addInputBuffer;
    private ComputeBuffer dellInputBuffer;
    private Vector3[] addInputData;
    private Vector3[] dellInputData;
    private int addInputIndex = 0;
    private int dellInputIndex = 0;
    #endregion

    void ResetBuffer()
    {
        for (int i = 0; i < buffers.Length; i++)
        {
            cs.SetBuffer(kernelClear, "_BufferWrite", buffers[i]);
            cs.Dispatch(kernelClear, Mathf.CeilToInt((float)texWidth / THREAD_NUM_X), Mathf.CeilToInt((float)texHeight / THREAD_NUM_X), Mathf.CeilToInt((float)texDepth / THREAD_NUM_X));
        }
    }

    void Initialize()
    {
        kernelClear = cs.FindKernel("Clear");
        kernelUpdate = cs.FindKernel("Update");
        kernelDraw = cs.FindKernel("Draw");
        kernelAddSeed = cs.FindKernel("AddSeed");
        kernelDellSeed = cs.FindKernel("DellSeed");

        heightMapTexture = CreateTexture(texWidth, texHeight, texDepth);

        int whd = texWidth * texHeight * texDepth;
        buffers = new ComputeBuffer[2];
        
        cs.SetInt("_TexWidth", texWidth);
        cs.SetInt("_TexHeight", texHeight);
        cs.SetInt("_TexDepth", texDepth);

        for (int i = 0; i < buffers.Length; i++)
        {
            buffers[i] = new ComputeBuffer(whd, Marshal.SizeOf(typeof(RDData)));
        }

        ResetBuffer();

        addInputData = new Vector3[inputMax];
        addInputIndex = 0;
        addInputBuffer = new ComputeBuffer(inputMax, Marshal.SizeOf(typeof(Vector3)));
        dellInputData = new Vector3[inputMax];
        dellInputIndex = 0;
        dellInputBuffer = new ComputeBuffer(inputMax, Marshal.SizeOf(typeof(Vector3)));
    }

    RenderTexture CreateTexture(int width, int height, int depth)
    {
        RenderTexture tex = new RenderTexture(width, height, 0, RenderTextureFormat.RFloat, RenderTextureReadWrite.Linear);
        tex.volumeDepth = depth;
        tex.enableRandomWrite = true;
        tex.dimension = UnityEngine.Rendering.TextureDimension.Tex3D;
        tex.filterMode = FilterMode.Bilinear;
        tex.wrapMode = TextureWrapMode.Repeat;
        tex.Create();

        return tex;
    }

    void UpdateBuffer()
    {
        cs.SetFloat("_DU", du);
        cs.SetFloat("_DV", dv);
        cs.SetFloat("_Feed", f);
        cs.SetFloat("_K", k);
        cs.SetBuffer(kernelUpdate, "_BufferRead", buffers[0]);
        cs.SetBuffer(kernelUpdate, "_BufferWrite", buffers[1]);
        cs.Dispatch(kernelUpdate, Mathf.CeilToInt((float)texWidth / THREAD_NUM_X), Mathf.CeilToInt((float)texHeight / THREAD_NUM_X), Mathf.CeilToInt((float)texDepth/ THREAD_NUM_X));

        SwapBuffer();
    }

    void DrawTexture()
    {
        cs.SetInt("_TexWidth", texWidth);
        cs.SetInt("_TexHeight", texHeight);
        cs.SetInt("_TexDepth", texDepth);
        cs.SetBuffer(kernelDraw, "_BufferRead", buffers[0]);
        cs.SetTexture(kernelDraw, "_HeightMap", heightMapTexture);
        cs.Dispatch(kernelDraw, Mathf.CeilToInt((float)texWidth / THREAD_NUM_X), Mathf.CeilToInt((float)texHeight / THREAD_NUM_X), Mathf.CeilToInt((float)texDepth / THREAD_NUM_X));
    }

    void AddSeedBuffer()
    {
        if(addInputIndex > 0)
        {
            addInputBuffer.SetData(addInputData);
            cs.SetInt("_InputNum", addInputIndex);
            cs.SetInt("_TexWidth", texWidth);
            cs.SetInt("_TexHeight", texHeight);
            cs.SetInt("_TexDepth", texDepth);
            cs.SetInt("_SeedSize", seedSize);
            cs.SetBuffer(kernelAddSeed, "_InputBufferRead", addInputBuffer);
            cs.SetBuffer(kernelAddSeed, "_BufferWrite", buffers[0]);    // update前なので0
            cs.Dispatch(kernelAddSeed, Mathf.CeilToInt((float)addInputIndex / (float)THREAD_NUM_X), 1, 1);
            addInputIndex = 0;
        }
    }

    void AddSeed(int x, int y, int z)
    {
        if(addInputIndex < inputMax)
        {
            addInputData[addInputIndex].x = x;
            addInputData[addInputIndex].y = y;
            addInputData[addInputIndex].z = z;
            addInputIndex++;
        }
    }

    void AddRandomSeed(int num)
    {
        for (int i = 0; i < num; i++)
        {
            AddSeed(Random.Range(0, texWidth), Random.Range(0, texHeight), Random.Range(0, texDepth));
        }
    }

    void DellSeedBuffer()
    {
        if (dellInputIndex > 0)
        {
            dellInputBuffer.SetData(dellInputData);
            cs.SetInt("_InputNum", dellInputIndex);
            cs.SetInt("_TexWidth", texWidth);
            cs.SetInt("_TexHeight", texHeight);
            cs.SetInt("_TexDepth", texDepth);
            cs.SetInt("_SeedSize", seedSize * 2);
            cs.SetBuffer(kernelDellSeed, "_InputBufferRead", dellInputBuffer);
            cs.SetBuffer(kernelDellSeed, "_BufferWrite", buffers[0]);    // update前なので0
            cs.Dispatch(kernelDellSeed, Mathf.CeilToInt((float)dellInputIndex / (float)THREAD_NUM_X), 1, 1);
            dellInputIndex = 0;
        }
    }

    void DellSeed(int x, int y, int z)
    {
        if (dellInputIndex < inputMax)
        {
            dellInputData[dellInputIndex].x = x;
            dellInputData[dellInputIndex].y = y;
            dellInputData[dellInputIndex].z = z;
            dellInputIndex++;
        }
    }

    void DellRandomSeed(int num)
    {
        for (int i = 0; i < num; i++)
        {
            DellSeed(Random.Range(0, texWidth), Random.Range(0, texHeight), Random.Range(0, texDepth));
        }
    }

    void SwapBuffer()
    {
        ComputeBuffer temp = buffers[0];
        buffers[0] = buffers[1];
        buffers[1] = temp; 
    }

    // Use this for initialization
    void Start () {
        Initialize();

        // 初期配置
        AddRandomSeed(seedNum);
    }

    // Update is called once per frame
    void Update () {
        // 係数ランダム
        if (Input.GetKeyDown(KeyCode.T))
        {
            f = Random.Range(0.01f, 0.1f);
            k = Random.Range(0.01f, 0.1f);
        }

        // リセット
        if (Input.GetKeyDown(KeyCode.R))
        {
            ResetBuffer();
        }

        // 追加
        if (Input.GetKeyDown(KeyCode.A))
        {
            AddRandomSeed(seedNum);
        }

        // 中心に1つ追加
        if (Input.GetKeyDown(KeyCode.C))
        {
            AddSeed(texWidth / 2, texHeight / 2, texDepth / 2);
        }

        // 削る
        if (Input.GetKeyDown(KeyCode.D))
        {
            DellRandomSeed(seedNum);
        }

        // 中心1つ削る
        if (Input.GetKeyDown(KeyCode.V))
        {
            DellSeed(texWidth / 2, texHeight / 2, texDepth / 2);
        }

        AddSeedBuffer();
        DellSeedBuffer();

        for (int i = 0; i < speed; i++)
        {
            UpdateBuffer();
        }

        DrawTexture();
    }

    private void OnDestroy()
    {
        if(buffers != null)
        {
            for(int i = 0; i < buffers.Length; i++)
            {
                buffers[i].Release();
                buffers[i] = null;
            }
        }
        if(addInputBuffer != null)
        {
            addInputBuffer.Release();
            addInputBuffer = null;
        }
        if (dellInputBuffer != null)
        {
            dellInputBuffer.Release();
            dellInputBuffer = null;
        }
    }
}
