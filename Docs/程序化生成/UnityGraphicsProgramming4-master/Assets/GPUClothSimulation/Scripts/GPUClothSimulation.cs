using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace GPUClothSimulation
{
    public class GPUClothSimulation : MonoBehaviour
    {
        [Header("Simulation Parameters")]
        // タイムステップ
        public float   TimeStep = 0.01f;
        // シミュレーションの反復回数
        [Range(1, 16)]
        public int     VerletIterationNum = 4;
        // 布の解像度（横, 縦)
        public Vector2Int ClothResolution = new Vector2Int(128, 128);
        // 布のグリッドの間隔（バネの自然長）
        public float   RestLength = 0.02f;
        // 布の伸縮性を決定する定数
        public float   Stiffness = 10000.0f;
        // 速度の減衰定数
        public float   Damp = 0.996f;
        // 質量
        public float   Mass = 1.0f;
        // 重力
        public Vector3 Gravity = new Vector3(0.0f, -9.81f, 0.0f);

        [Header("References")]
        // 衝突用球体のTransformの参照
        public Transform CollisionSphereTransform;
        [Header("Resources")]
        // シミュレーションを行うカーネル
        public ComputeShader KernelCS;

        // 布シミュレーション 位置データのバッファ
        private RenderTexture[] _posBuff;
        // 布シミュレーション 位置データ（ひとつ前のフレーム）のバッファ
        private RenderTexture[] _posPrevBuff;
        // 布シミュレーション 法線データのバッファ
        private RenderTexture _normBuff;

        // 布の長さ (横, 縦)
        private Vector2 _totalClothLength;
        
        [Header("Debug")]
        // デバッグ用にシミュレーションバッファを表示する
        public bool EnableDebugOnGUI = true;
        // デバッグ表示時のバッファの表示スケール
        private float _debugOnGUIScale = 1.0f;
        
        // シミュレーションリソースを初期化したか
        public bool IsInit { private set; get; }

        // 位置データのバッファを取得
        public RenderTexture GetPositionBuffer()
        {
            return this.IsInit ? _posBuff[0] : null;
        }
        // 法線データのバッファを取得
        public RenderTexture GetNormalBuffer()
        {
            return this.IsInit ? _normBuff : null;
        }
        // 布の解像度を取得
        public Vector2Int GetClothResolution()
        {
            return ClothResolution;
        }
        
        // ComputeShaderカーネルのX, Y次元のスレッドの数
        const int numThreadsXY = 32;
        
        void Start()
        {
            var w = ClothResolution.x;
            var h = ClothResolution.y;
            var format = RenderTextureFormat.ARGBFloat;
            var filter = FilterMode.Point; // テクセル間の補間がなされないように
            // シミュレーション用のデータを格納するRenderTextureを作成
            CreateRenderTexture(ref _posBuff,     w, h, format, filter);
            CreateRenderTexture(ref _posPrevBuff, w, h, format, filter);
            CreateRenderTexture(ref _normBuff,    w, h, format, filter);
            // シミュレーション用のデータをリセット
            ResetBuffer();
            // 初期化済みのフラグを True
            IsInit = true;
        }

        void Update()
        {
            // rキーを押したら, シミュレーション用のデータをリセットする
            if (Input.GetKeyUp("r"))
                ResetBuffer();

            // シミュレーションを行う
            Simulation();
        }

        void OnDestroy()
        {
            // シミュレーション用のデータを格納するRenderTextureを削除
            DestroyRenderTexture(ref _posBuff    );
            DestroyRenderTexture(ref _posPrevBuff);
            DestroyRenderTexture(ref _normBuff   );
        }

        void OnGUI()
        {
            // デバッグ用にシミュレーション用データを格納したRenderTextureを描画
            DrawSimulationBufferOnGUI();
        }
        
        // シミュレーション用データをリセット
        void ResetBuffer()
        {
            ComputeShader cs = KernelCS;
            // カーネルIDを取得
            int kernelId = cs.FindKernel("CSInit");
            // ComputeShaderカーネルの実行スレッドグループの数を計算
            int groupThreadsX = 
                Mathf.CeilToInt((float)ClothResolution.x / numThreadsXY);
            int groupThreadsY = 
                Mathf.CeilToInt((float)ClothResolution.y / numThreadsXY);
            // 布の長さ（横, 縦）の計算
            _totalClothLength = new Vector2(
                RestLength * ClothResolution.x, 
                RestLength * ClothResolution.y
            );
            // パラメータ, バッファをセット
            cs.SetInts  ("_ClothResolution", 
                new int[2] { ClothResolution.x, ClothResolution.y });
            cs.SetFloats("_TotalClothLength",
                new float[2] { _totalClothLength.x, _totalClothLength.y });
            cs.SetFloat ("_RestLength", RestLength);
            cs.SetTexture(kernelId, "_PositionBufferRW",     _posBuff[0]);
            cs.SetTexture(kernelId, "_PositionPrevBufferRW", _posPrevBuff[0]);
            cs.SetTexture(kernelId, "_NormalBufferRW",       _normBuff);
            // カーネルを実行
            cs.Dispatch(kernelId, groupThreadsX, groupThreadsY, 1);
            // バッファをコピー
            Graphics.Blit(_posBuff[0],     _posBuff[1]);
            Graphics.Blit(_posPrevBuff[0], _posPrevBuff[1]);
        }

        // シミュレーション
        void Simulation()
        {
            ComputeShader cs = KernelCS;
            // CSSimulationの計算1回あたりのタイムステップの値の計算
            float timestep = (float)TimeStep / VerletIterationNum;
            // カーネルIDを取得
            int kernelId = cs.FindKernel("CSSimulation");
            // ComputeShaderカーネルの実行スレッドグループの数を計算
            int groupThreadsX = 
                Mathf.CeilToInt((float)ClothResolution.x / numThreadsXY);
            int groupThreadsY = 
                Mathf.CeilToInt((float)ClothResolution.y / numThreadsXY);

            // パラメータをセット
            cs.SetVector("_Gravity", Gravity);
            cs.SetFloat ("_Stiffness", Stiffness);
            cs.SetFloat ("_Damp", Damp);
            cs.SetFloat ("_InverseMass", (float)1.0f / Mass);
            cs.SetFloat ("_TimeStep", timestep);
            cs.SetFloat ("_RestLength", RestLength);
            cs.SetInts  ("_ClothResolution", 
                new int[2] { ClothResolution.x, ClothResolution.y });

            // 衝突用球のパラメータをセット
            if (CollisionSphereTransform != null)
            {
                Vector3 collisionSpherePos = CollisionSphereTransform.position;
                float collisionSphereRad = 
                    CollisionSphereTransform.localScale.x * 0.5f + 0.01f;
                cs.SetBool  ("_EnableCollideSphere", true);
                cs.SetFloats("_CollideSphereParams", 
                    new float[4] {
                        collisionSpherePos.x,
                        collisionSpherePos.y,
                        collisionSpherePos.z,
                        collisionSphereRad
                    });
            }
            else
                cs.SetBool("_EnableCollideSphere", false);

            for (var i = 0; i < VerletIterationNum; i++)
            {           
                // バッファをセット
                cs.SetTexture(kernelId, "_PositionBufferRO",     _posBuff[0]);
                cs.SetTexture(kernelId, "_PositionPrevBufferRO", _posPrevBuff[0]);
                cs.SetTexture(kernelId, "_PositionBufferRW",     _posBuff[1]);
                cs.SetTexture(kernelId, "_PositionPrevBufferRW", _posPrevBuff[1]);
                cs.SetTexture(kernelId, "_NormalBufferRW",       _normBuff);
                // スレッドを実行
                cs.Dispatch(kernelId, groupThreadsX, groupThreadsY, 1);
                // 読み込み用バッファ, 書き込み用バッファを入れ替え
                SwapBuffer(ref _posBuff[0],     ref _posBuff[1]    );
                SwapBuffer(ref _posPrevBuff[0], ref _posPrevBuff[1]);
            }
        }

        // シミュレーション用のデータを格納するRenderTextureを作成
        void CreateRenderTexture(ref RenderTexture buffer, int w, int h, 
            RenderTextureFormat format, FilterMode filter)
        {
            buffer = new RenderTexture(w, h, 0, format)
            {
                filterMode = filter,
                wrapMode   = TextureWrapMode.Clamp,
                hideFlags  = HideFlags.HideAndDontSave,
                enableRandomWrite = true
            };
            buffer.Create();
        }

        // シミュレーション用のデータを格納するRenderTexture[]を作成
        void CreateRenderTexture(ref RenderTexture[] buffer, int w, int h, 
            RenderTextureFormat format, FilterMode filter)
        {
            buffer = new RenderTexture[2];
            for (var i = 0; i < 2; i++)
            {
                buffer[i] = new RenderTexture(w, h, 0, format)
                {
                    filterMode = filter,
                    wrapMode   = TextureWrapMode.Clamp,
                    hideFlags  = HideFlags.HideAndDontSave,
                    enableRandomWrite = true
                };
                buffer[i].Create();
            }
        }

        // シミュレーション用のデータを格納するRenderTextureを削除
        void DestroyRenderTexture(ref RenderTexture buffer)
        {
            if (Application.isEditor)
                RenderTexture.DestroyImmediate(buffer);
            else
                RenderTexture.Destroy(buffer);
            buffer = null;
        }

        // シミュレーション用のデータを格納するRenderTexture[]を削除
        void DestroyRenderTexture(ref RenderTexture[] buffer)
        {
            if (buffer != null)
                for (var i = 0; i < buffer.Length; i++)
                {
                    if (Application.isEditor)
                        RenderTexture.DestroyImmediate(buffer[i]);
                    else
                        RenderTexture.Destroy(buffer[i]);
                    buffer[i] = null;
                }
        }

        // マテリアルを削除
        void DestroyMaterial(ref Material mat)
        {
            if (mat != null)
                if (Application.isEditor)
                    Material.DestroyImmediate(mat);
                else
                    Material.Destroy(mat);
        }

        // バッファを入れ替え
        void SwapBuffer(ref RenderTexture ping, ref RenderTexture pong)
        {
            RenderTexture temp = ping;
            ping = pong;
            pong = temp;
        }

        // デバッグ用に、シミュレーションのためのバッファをOnGUI関数内で描画
        void DrawSimulationBufferOnGUI()
        {
            if (!EnableDebugOnGUI)
                return;

            var scl = _debugOnGUIScale;
            int rw = Mathf.RoundToInt((float)ClothResolution.x * scl);
            int rh = Mathf.RoundToInt((float)ClothResolution.y * scl);

            Color storeColor = GUI.color;
            GUI.color = Color.gray;

            if (_posBuff != null)
            {
                Rect r00 = new Rect(rw * 0, rh * 0, rw, rh);
                Rect r01 = new Rect(rw * 0, rh * 1, rw, rh);
                GUI.DrawTexture(r00, _posBuff[0]);
                GUI.DrawTexture(r01, _posBuff[1]);
                GUI.Label(r00, "PositionBuffer[0]");
                GUI.Label(r01, "PositionBuffer[1]");
            }

            if (_posPrevBuff != null)
            {
                Rect r10 = new Rect(rw * 1, rh * 0, rw, rh);
                Rect r11 = new Rect(rw * 1, rh * 1, rw, rh);
                GUI.DrawTexture(r10, _posPrevBuff[0]);
                GUI.DrawTexture(r11, _posPrevBuff[1]);
                GUI.Label(r10, "PositionPrevBuffer[0]");
                GUI.Label(r11, "PositionPrevBuffer[1]");
            }

            if (_normBuff != null)
            {
                Rect r20 = new Rect(rw * 2, rh * 0, rw, rh);
                GUI.DrawTexture(r20, _normBuff);
                GUI.Label(r20, "NormalBuffer");
            }

            GUI.color = storeColor;
        }
    }
}