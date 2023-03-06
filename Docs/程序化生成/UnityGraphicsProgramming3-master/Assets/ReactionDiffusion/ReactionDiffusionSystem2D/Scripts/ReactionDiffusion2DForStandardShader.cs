using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Runtime.InteropServices;

namespace kaiware
{

    public class ReactionDiffusion2DForStandardShader : MonoBehaviour
    {
        #region define
        const int THREAD_NUM_X = 32;
        [StructLayout(LayoutKind.Sequential)]
        public struct RDData
        {
            public float u; // Uの濃度
            public float v; // Vの濃度
        }
        #endregion

        #region public
        // テクスチャ解像度
        public int texWidth = 256;
        public int texHeight = 256;

        public float du = 1;
        public float dv = 0.5f;

        [Header("Normal Feed/Kill")]
        [Range(0, 0.1f)]
        public float feed = 0.055f;
        [Range(0, 0.1f)]
        public float kill = 0.062f;

        [Space]

        [Range(0, 64)]
        public int speed = 1;

        public int seedSize = 10;
        public int seedNum = 10;

        // Albedo
        public Color topColor = Color.white;
        public Color bottomColor = Color.black;

        // Emittion
        public Color topEmit = Color.black;
        public Color bottomEmit = Color.black;
        [Range(0, 10)]
        public float topEmitIntensity = 0;
        [Range(0, 10)]
        public float bottomEmitIntensity = 0;

        public int inputMax = 32;

        [Space]

        public ComputeShader cs;
        #endregion

        #region private
        int kernelUpdate = -1;
        int kernelDraw = -1;
        int kernelAddSeed = -1;

        ComputeBuffer[] buffers;
        ComputeBuffer inputBuffer;
        RDData[] bufData;
        RDData[] bufData2;
        Vector2[] inputData;
        int inputIndex = 0;
        Material material;
        RenderTexture heightMapTexture;
        RenderTexture normalMapTexture;

        #endregion

        /// <summary>
        /// バッファのリセット
        /// </summary>
        void ResetBuffer()
        {
            for (int x = 0; x < texWidth; x++)
            {
                for (int y = 0; y < texHeight; y++)
                {
                    int idx = x + y * texWidth;
                    bufData[idx].u = 1;
                    bufData[idx].v = 0;

                    bufData2[idx].u = 1;
                    bufData2[idx].v = 0;

                }
            }

            buffers[0].SetData(bufData);
            buffers[1].SetData(bufData2);
        }

        /// <summary>
        /// 初期化
        /// </summary>
        void Initialize()
        {
            kernelUpdate = cs.FindKernel("Update");
            kernelDraw = cs.FindKernel("Draw");
            kernelAddSeed = cs.FindKernel("AddSeed");

            heightMapTexture = CreateRenderTexture(texWidth, texHeight, RenderTextureFormat.RFloat);    // 高さマップ用テクスチャ作成
            normalMapTexture = CreateRenderTexture(texWidth, texHeight, RenderTextureFormat.ARGBFloat);    // ノーマルマップマップ用テクスチャ作成

            int wh = texWidth * texHeight;
            buffers = new ComputeBuffer[2];

            cs.SetInt("_TexWidth", texWidth);
            cs.SetInt("_TexHeight", texHeight);

            for (int i = 0; i < buffers.Length; i++)
            {
                buffers[i] = new ComputeBuffer(wh, Marshal.SizeOf(typeof(RDData)));
            }

            bufData = new RDData[texWidth * texHeight];
            bufData2 = new RDData[texWidth * texHeight];

            ResetBuffer();

            inputData = new Vector2[inputMax];
            inputIndex = 0;
            inputBuffer = new ComputeBuffer(inputMax, Marshal.SizeOf(typeof(Vector2)));

            var ren = GetComponent<Renderer>();
            if (ren != null)
            {
                material = ren.material;
                material.SetTexture("_MainTex", heightMapTexture);
                material.SetColor("_Color0", bottomColor);
                material.SetColor("_Color1", topColor);
                material.SetColor("_Emit0", bottomEmit);
                material.SetColor("_Emit1", topEmit);
                material.SetFloat("_EmitInt0", bottomEmitIntensity);
                material.SetFloat("_EmitInt1", topEmitIntensity);
            }
        }

        /// <summary>
        /// RenderTexture作成
        /// </summary>
        /// <param name="width"></param>
        /// <param name="height"></param>
        /// <param name="texFormat"></param>
        /// <returns></returns>
        RenderTexture CreateRenderTexture(int width, int height, RenderTextureFormat texFormat)
        {
            RenderTexture tex = new RenderTexture(width, height, 0, texFormat, RenderTextureReadWrite.Linear);
            tex.enableRandomWrite = true;
            tex.filterMode = FilterMode.Bilinear;
            tex.wrapMode = TextureWrapMode.Repeat;
            tex.Create();

            return tex;
        }

        void UpdateBuffer()
        {
            cs.SetInt("_TexWidth", texWidth);
            cs.SetInt("_TexHeight", texHeight);
            cs.SetFloat("_DU", du);
            cs.SetFloat("_DV", dv);

            cs.SetFloat("_Feed", feed);
            cs.SetFloat("_K", kill);

            cs.SetBuffer(kernelUpdate, "_BufferRead", buffers[0]);
            cs.SetBuffer(kernelUpdate, "_BufferWrite", buffers[1]);
            cs.Dispatch(kernelUpdate, Mathf.CeilToInt((float)texWidth / THREAD_NUM_X), Mathf.CeilToInt((float)texHeight / THREAD_NUM_X), 1);

            SwapBuffer();
        }

        void UpdateMaterial()
        {
            material.SetTexture("_MainTex", heightMapTexture);
            material.SetTexture("_NormalTex", normalMapTexture);

            material.SetColor("_Color0", bottomColor);
            material.SetColor("_Color1", topColor);
            material.SetColor("_Emit0", bottomEmit);
            material.SetColor("_Emit1", topEmit);
            material.SetFloat("_EmitInt0", bottomEmitIntensity);
            material.SetFloat("_EmitInt1", topEmitIntensity);

        }

        void DrawTexture()
        {
            cs.SetInt("_TexWidth", texWidth);
            cs.SetInt("_TexHeight", texHeight);
            cs.SetBuffer(kernelDraw, "_BufferRead", buffers[0]);
            cs.SetTexture(kernelDraw, "_HeightMap", heightMapTexture);
            cs.SetTexture(kernelDraw, "_NormalMap", normalMapTexture);
            cs.Dispatch(kernelDraw, Mathf.CeilToInt((float)texWidth / THREAD_NUM_X), Mathf.CeilToInt((float)texHeight / THREAD_NUM_X), 1);
        }

        void AddSeedBuffer()
        {
            if (inputIndex > 0)
            {
                inputBuffer.SetData(inputData);
                cs.SetInt("_InputNum", inputIndex);
                cs.SetInt("_TexWidth", texWidth);
                cs.SetInt("_TexHeight", texHeight);
                cs.SetInt("_SeedSize", seedSize);
                cs.SetBuffer(kernelAddSeed, "_InputBufferRead", inputBuffer);
                cs.SetBuffer(kernelAddSeed, "_BufferWrite", buffers[0]);    // update前なので0
                cs.Dispatch(kernelAddSeed, Mathf.CeilToInt((float)inputIndex / (float)THREAD_NUM_X), 1, 1);
                inputIndex = 0;
            }
        }

        void AddSeed(int x, int y)
        {
            if (inputIndex < inputMax)
            {
                inputData[inputIndex].x = x;
                inputData[inputIndex].y = y;
                inputIndex++;
            }
        }

        void AddRandomSeed(int num)
        {
            for (int i = 0; i < num; i++)
            {
                AddSeed(Random.Range(0, texWidth), Random.Range(0, texHeight));
            }
        }

        void SwapBuffer()
        {
            ComputeBuffer temp = buffers[0];
            buffers[0] = buffers[1];
            buffers[1] = temp;
        }

        // Use this for initialization
        void Start()
        {
            Initialize();

            // 初期配置
            AddRandomSeed(seedNum);
        }

        // Update is called once per frame
        void Update()
        {
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
                AddSeed(texWidth / 2, texHeight / 2);
            }

            AddSeedBuffer();

            for (int i = 0; i < speed; i++)
            {
                UpdateBuffer();
            }

            UpdateMaterial();

            DrawTexture();
        }

        private void OnDestroy()
        {
            if (buffers != null)
            {
                for (int i = 0; i < buffers.Length; i++)
                {
                    buffers[i].Release();
                    buffers[i] = null;
                }
            }
            if (inputBuffer != null)
            {
                inputBuffer.Release();
                inputBuffer = null;
            }
        }

        private void OnGUI()
        {
            GUILayout.Label("A Key : Add Seed to Random Position");
            GUILayout.Label("R Key : Reset");
            GUILayout.Label("C Key : Add Seed to Center");
        }
    }
}