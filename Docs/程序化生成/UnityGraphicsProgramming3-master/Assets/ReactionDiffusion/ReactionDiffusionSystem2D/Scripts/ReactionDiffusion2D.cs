using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Runtime.InteropServices;

namespace kaiware
{


    public class ReactionDiffusion2D : MonoBehaviour
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

        public int inputMax = 32;

        [Space]

        public ComputeShader cs;

        public RenderTexture resultTexture;

        #endregion

        #region private
        private int kernelUpdate = -1;
        private int kernelDraw = -1;
        private int kernelAddSeed = -1;

        private ComputeBuffer[] buffers;
        private ComputeBuffer inputBuffer;
        private RDData[] bufData;
        private RDData[] bufData2;
        private Vector2[] inputData;
        private int inputIndex = 0;
        private Material material;
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
            // ComputeShaderのKernelIDを取得
            kernelUpdate = cs.FindKernel("Update");
            kernelDraw = cs.FindKernel("Draw");
            kernelAddSeed = cs.FindKernel("AddSeed");

            resultTexture = CreateRenderTexture(texWidth, texHeight);    // 描画用テクスチャ作成

            // ComputeShaderにテクスチャの解像度を渡しておく
            cs.SetInt("_TexWidth", texWidth);
            cs.SetInt("_TexHeight", texHeight);

            int wh = texWidth * texHeight;
            buffers = new ComputeBuffer[2]; // ダブルバッファリング用のComputeBufferの配列初期化

            for (int i = 0; i < buffers.Length; i++)
            {
                // グリッドの初期化
                buffers[i] = new ComputeBuffer(wh, Marshal.SizeOf(typeof(RDData)));
            }

            // リセット用のグリッド配列
            bufData = new RDData[wh];
            bufData2 = new RDData[wh];

            // バッファの初期化
            ResetBuffer();

            // Seed追加用バッファの初期化
            inputData = new Vector2[inputMax];
            inputIndex = 0;
            inputBuffer = new ComputeBuffer(inputMax, Marshal.SizeOf(typeof(Vector2)));

            // Rendererにテクスチャや色をセット
            var ren = GetComponent<Renderer>();
            if (ren != null)
            {
                material = ren.material;
                material.SetTexture("_MainTex", resultTexture);
                material.SetColor("_Color0", bottomColor);
                material.SetColor("_Color1", topColor);
            }
        }

        /// <summary>
        /// RenderTexture作成
        /// </summary>
        /// <param name="width"></param>
        /// <param name="height"></param>
        /// <returns></returns>
        RenderTexture CreateRenderTexture(int width, int height)
        {
            RenderTexture tex = new RenderTexture(width, height, 0, RenderTextureFormat.RFloat, RenderTextureReadWrite.Linear);
            tex.enableRandomWrite = true;
            tex.filterMode = FilterMode.Bilinear;
            tex.wrapMode = TextureWrapMode.Repeat;
            tex.Create();

            return tex;
        }

        /// <summary>
        /// 更新処理
        /// </summary>
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

        /// <summary>
        /// マテリアルの更新
        /// </summary>
        void UpdateMaterial()
        {
            material.SetTexture("_MainTex", resultTexture);

            material.SetColor("_Color0", bottomColor);
            material.SetColor("_Color1", topColor);
        }

        /// <summary>
        /// ReactionDiffusionの結果をテクスチャに書き込み
        /// </summary>
        void DrawTexture()
        {
            cs.SetInt("_TexWidth", texWidth);
            cs.SetInt("_TexHeight", texHeight);
            cs.SetBuffer(kernelDraw, "_BufferRead", buffers[0]);
            cs.SetTexture(kernelDraw, "_HeightMap", resultTexture);
            cs.Dispatch(kernelDraw, Mathf.CeilToInt((float)texWidth / THREAD_NUM_X), Mathf.CeilToInt((float)texHeight / THREAD_NUM_X), 1);
        }

        /// <summary>
        /// Seed配列をComputeShaderにわたす
        /// </summary>
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

        /// <summary>
        /// Seedの追加
        /// </summary>
        /// <param name="x"></param>
        /// <param name="y"></param>
        void AddSeed(int x, int y)
        {
            if (inputIndex < inputMax)
            {
                inputData[inputIndex].x = x;
                inputData[inputIndex].y = y;
                inputIndex++;
            }
        }

        /// <summary>
        /// ランダムな位置にSeed追加
        /// </summary>
        /// <param name="num"></param>
        void AddRandomSeed(int num)
        {
            for (int i = 0; i < num; i++)
            {
                AddSeed(Random.Range(0, texWidth), Random.Range(0, texHeight));
            }
        }

        /// <summary>
        /// バッファの入れ替え
        /// </summary>
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