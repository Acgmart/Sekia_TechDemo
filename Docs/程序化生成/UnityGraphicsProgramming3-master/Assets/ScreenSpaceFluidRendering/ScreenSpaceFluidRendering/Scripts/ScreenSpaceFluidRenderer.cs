using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;

namespace ScreenSpaceFluidRendering
{
    //[ExecuteInEditMode]
    public class ScreenSpaceFluidRenderer : MonoBehaviour
    {
        // カメラに格納するコマンドバッファの情報
        private struct CmdBufferInfo
        {
            public CameraEvent   pass;   // CommandBufferを格納するカメラのパス
            public CommandBuffer buffer; // カメラに格納するCommandBuffer
        };

        // CommandBufferを登録したカメラとCommandBufferを格納するリスト
        Dictionary<Camera, CmdBufferInfo> _cameras = new Dictionary<Camera, CmdBufferInfo>();

        // パーティクルを描画し、そのカラーと深度値を計算するシェーダとマテリアル
        [SerializeField]
        Shader _renderParticleDepthShader = null;
        Material _renderParticleDepthMaterial;

        // ブラーエフェクトを行うシェーダとマテリアル
        [SerializeField]
        Shader _bilateralFilterBlurShader = null;
        Material _bilateralFilterBlurMaterial;

        // デプスから法線を計算するシェーダとマテリアル
        [SerializeField]
        Shader _calcNormalShader = null;
        Material _calcNormalMaterial;

        // G-Bufferを合成するシェーダとマテリアル
        [SerializeField]
        Shader _renderGBufferShader = null;
        Material _renderGBufferMaterial;  
        
        // パーティクルのサイズ
        [SerializeField]
        float _particleSize = 0.01f;

        // ブラーエフェクトの半径
        [SerializeField, Range(1, 16)]
        int _blurFilterRadius = 2;

        // ブラーエフェクトのスケール
        [SerializeField]
        float _blurScale = 1.0f;

        // ブラーエフェクトの深度によるブラーの強さの減衰値
        [SerializeField]
        float _blurDepthFallOff = 50.0f;

        // パーティクルの拡散色
        public Color _diffuse           = new Color(0.0f, 0.2f, 1.0f, 1.0f);
        // パーティクルの反射色
        public Color _specular          = new Color(0.25f, 0.25f, 0.25f, 0.25f);
        // パーティクルのラフネス（物質表面の粗さ）
        public float _roughness         = 0.25f;
        // パーティクルの放出色
        public Color _emission          = new Color(0.0f, 0.0f, 0.0f, 0.0f);
        // パーティクルの放出食の強さ
        public float _emissionIntensity = 1.0f;

        // 流体シミュレーションを行うスクリプトの参照
        [SerializeField]
        SPHFluidSimulation _simScript;

        // スクリーンスペース全体に描画するための矩形
        private Mesh _quad;
        private Mesh quad { get { return _quad ?? (_quad = GenerateQuad()); } }

        // スクリーンスペースを覆う矩形のメッシュの生成
        Mesh GenerateQuad()
        {
            var mesh = new Mesh();
            mesh.vertices = new Vector3[4]
            {
                new Vector3( 1.0f,  1.0f, 0.0f),
                new Vector3(-1.0f,  1.0f, 0.0f),
                new Vector3(-1.0f, -1.0f, 0.0f),
                new Vector3( 1.0f, -1.0f, 0.0f),
            };
            mesh.triangles = new int[6] { 0, 1, 2, 2, 3, 0 };
            return mesh;
        }

        void OnEnable()
        {
            // 解放処理
            CleanUp();

            // 計算用のマテリアルを作成
            CreateMaterial(ref _renderParticleDepthMaterial, _renderParticleDepthShader);
            CreateMaterial(ref _bilateralFilterBlurMaterial, _bilateralFilterBlurShader);
            CreateMaterial(ref _calcNormalMaterial,          _calcNormalShader);
            CreateMaterial(ref _renderGBufferMaterial,       _renderGBufferShader);
        }

        void OnDisable()
        {
            // 解放処理
            CleanUp();
        }

        // アタッチされたレンダラー(MeshRenderer)がカメラに映っているときに呼び出される
        void OnWillRenderObject()
        {
            // 自身がアクティブでなければ解放処理をして、以降は何もしない
            var act = gameObject.activeInHierarchy && enabled;
            if (!act)
            {
                CleanUp();
                return;
            }
            // 現在レンダリング処理をしているカメラがなければ、以降は何もしない
            var cam = Camera.current;
            if (!cam)
            {
                return;
            }

            // 現在レンダリング処理をしているカメラに、CommandBufferがアタッチされていなければ
            if (!_cameras.ContainsKey(cam))
            {
                // CommandBufferの情報作成
                var buf = new CmdBufferInfo();
                buf.pass   = CameraEvent.BeforeGBuffer;
                buf.buffer = new CommandBuffer() { name = "Screen Space Fluid Renderer" };
                // G-Bufferが生成される前のカメラのレンダリングパイプライン上のパスに、
                // 作成したCommandBufferを追加
                cam.AddCommandBuffer(buf.pass, buf.buffer);
                
                // CommandBufferを追加したカメラを管理するリストにカメラを追加
                _cameras.Add(cam, buf);
            }
            // CommandBuffer がアタッチされているならば
            else
            {
                // コマンドバッファを取得
                var buf = _cameras[cam].buffer;
                // コマンドバッファをクリア
                buf.Clear();
                
                // -----------------------------------------------------------------------------
                // 1. パーティクルをポイントスプライトとして描画し、深度とカラーのデータを得る
                // -----------------------------------------------------------------------------
                // デプスバッファのシェーダプロパティIDを取得
                int depthBufferId = Shader.PropertyToID("_DepthBuffer");
                // 一時的なRenderTextureを取得
                buf.GetTemporaryRT(depthBufferId, -1, -1, 24, FilterMode.Point, RenderTextureFormat.RFloat);
                
                // カラーバッファとデプスバッファをレンダーターゲットに指定
                buf.SetRenderTarget
                (
                    new RenderTargetIdentifier(depthBufferId),  // デプス
                    new RenderTargetIdentifier(depthBufferId)   // デプス書き込み用
                );
                // カラーバッファとデプスバッファをクリア
                buf.ClearRenderTarget(true, true, Color.clear);
                
                // パーティクルのサイズをセット
                _renderParticleDepthMaterial.SetFloat ("_ParticleSize", _particleSize);
                // パーティクルのデータ（ComputeBuffer）をセット
                _renderParticleDepthMaterial.SetBuffer("_ParticleDataBuffer", _simScript.GetParticlesBuffer());
                
                // パーティクルをポイントスプライトとして描画
                buf.DrawProcedural
                (
                    Matrix4x4.identity,
                    _renderParticleDepthMaterial,
                    0,
                    MeshTopology.Points,
                    _simScript.GetParticleNum()
                );

                // -----------------------------------------------------------------------------
                // 2. デプスバッファにブラーをかける
                // -----------------------------------------------------------------------------
                // ブラーエフェクト計算に一時的に使用するバッファの作成
                var tempDepthBufferId = Shader.PropertyToID("_TempDepthBufferId");
                buf.GetTemporaryRT(tempDepthBufferId, -1, -1, 0, FilterMode.Trilinear, RenderTextureFormat.RFloat);
                // ブラーエフェクトのプロパティをセット
                _bilateralFilterBlurMaterial.SetFloat("_FilterRadius",     _blurFilterRadius);
                _bilateralFilterBlurMaterial.SetFloat("_BlurScale",        _blurScale);
                _bilateralFilterBlurMaterial.SetFloat("_BlurDepthFallOff", _blurDepthFallOff);
                // 水平方向のブラーを実行
                buf.SetGlobalVector("_BlurDir", new Vector2(1.0f, 0.0f));
                buf.Blit(depthBufferId, tempDepthBufferId, _bilateralFilterBlurMaterial);
                // 垂直方向のブラーを実行
                buf.SetGlobalVector("_BlurDir", new Vector2(0.0f, 1.0f));
                buf.Blit(tempDepthBufferId, depthBufferId, _bilateralFilterBlurMaterial);

                // -----------------------------------------------------------------------------
                // 3. デプスバッファから法線バッファを計算
                // -----------------------------------------------------------------------------
                // 法線バッファの作成
                int normalBufferId = Shader.PropertyToID("_NormalBuffer");
                buf.GetTemporaryRT(normalBufferId, -1, -1, 0, FilterMode.Point, RenderTextureFormat.ARGBFloat);
                // 法線バッファをレンダーターゲットにセット
                buf.SetRenderTarget(normalBufferId);
                // クリア
                buf.ClearRenderTarget(false, true, Color.clear);
                // ビュー変換マトリックスをセット
                var view = cam.worldToCameraMatrix;
                _calcNormalMaterial.SetMatrix("_ViewMatrix", view);
                // デプスバッファをシェーダにセット
                buf.SetGlobalTexture("_DepthBuffer", depthBufferId);
                // デプスから法線をスクリーンスペースで計算
                buf.Blit(null, normalBufferId, _calcNormalMaterial);

                // -----------------------------------------------------------------------------
                // 4. 計算結果を G-Buffer に書き込みパーティクルを描画
                // -----------------------------------------------------------------------------
                buf.SetGlobalTexture("_NormalBuffer", normalBufferId); // 法線バッファをセット
                buf.SetGlobalTexture("_DepthBuffer",  depthBufferId);  // デプスバッファをセット

                // プロパティをセット
                _renderGBufferMaterial.SetColor("_Diffuse",  _diffuse );
                _renderGBufferMaterial.SetColor("_Specular", new Vector4(_specular.r, _specular.g, _specular.b, 1.0f - _roughness));
                _renderGBufferMaterial.SetColor("_Emission", _emission);
                
                // G-Buffer を レンダーターゲットにセット
                buf.SetRenderTarget
                (
                    new RenderTargetIdentifier[4]
                    {
                        BuiltinRenderTextureType.GBuffer0, // Diffuse
                        BuiltinRenderTextureType.GBuffer1, // Specular + Roughness
                        BuiltinRenderTextureType.GBuffer2, // World Normal
                        BuiltinRenderTextureType.GBuffer3  // Emission
                    },
                    BuiltinRenderTextureType.CameraTarget  // Depth
                );
                // G-Bufferに書き込み
                buf.DrawMesh(quad, Matrix4x4.identity, _renderGBufferMaterial);

                // -----------------------------------------------------------------------------
                // 一時的に作成したRenderTextureを解放
                buf.ReleaseTemporaryRT(depthBufferId);
                buf.ReleaseTemporaryRT(tempDepthBufferId);
                buf.ReleaseTemporaryRT(normalBufferId);
            }
        }

        // 解放処理
        void CleanUp()
        {
            // カメラに追加したCommandBufferを除去
            foreach (var pair in _cameras)
            {
                var cam  = pair.Key;
                var info = pair.Value;
                if (cam)
                    cam.RemoveCommandBuffer(info.pass, info.buffer);
            }
            _cameras.Clear();
            
            // 生成した計算のためのマテリアルを破棄
            DestroyMaterial(ref _renderParticleDepthMaterial);
            DestroyMaterial(ref _bilateralFilterBlurMaterial);
            DestroyMaterial(ref _calcNormalMaterial   );
            DestroyMaterial(ref _renderGBufferMaterial);   
        }

        // 計算のためのマテリアルを生成
        void CreateMaterial (ref Material m, Shader s)
        {
            if (m == null && s != null)
            {
                m = new Material(s) { hideFlags = HideFlags.DontSave };
            }
        }

        // 計算のためのマテリアルを破棄
        void DestroyMaterial(ref Material m)
        {
            if (m != null)
            {
                if (Application.isPlaying)
                    Material.Destroy(m);
                else
                    Material.DestroyImmediate(m);
            }
            m = null;
        }
    }
}