using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace GPUClothSimulation
{
    [RequireComponent(typeof(GPUClothSimulation))]
    public class GPUClothRenderer : MonoBehaviour
    {
        // メッシュ描画のためのマテリアル
        public Material MeshMat;

        // MeshRendererを取得
        private MeshRenderer _meshRenderer;

        // シミュレーションを行うコンポーネントを取得
        private GPUClothSimulation _clothSim;

        // メッシュ生成など, 初期化済みかどうか
        private bool _isInit = false;

        void Update()
        {
            // 初期化
            Init();
        }

        void OnDestroy()
        {
            // 作成したMeshRendererを削除
            if (_meshRenderer != null) MeshRenderer.Destroy(_meshRenderer);
        }

        // 初期化
        void Init()
        {
            // 初期化済みでなければ
            if (!_isInit)
            {
                // 参照を取得
                if (_clothSim == null)
                    _clothSim = GetComponent<GPUClothSimulation>();

                if (_clothSim != null && _clothSim.IsInit)
                {
                    // メッシュを生成
                    GenerateMesh();

                    // メッシュ描画のためのマテリアルをMeshRendererのセット
                    _meshRenderer.material = MeshMat;
                    MeshMat.SetTexture("_PositionTex", _clothSim.GetPositionBuffer());
                    MeshMat.SetTexture("_NormalTex", _clothSim.GetNormalBuffer());

                    // 初期化完了のフラグをセット
                    _isInit = true;
                }
            }
        }

        // メッシュを生成
        void GenerateMesh()
        {
            // メッシュの解像度を計算
            Vector2Int clothResolution = _clothSim.GetClothResolution();
            int gridWidth  = clothResolution.x - 1;
            int gridHeight = clothResolution.y - 1;

            // MeshRendererを取得, または作成
            if (!GetComponent<MeshRenderer>())
                _meshRenderer = gameObject.AddComponent<MeshRenderer>();
            else
                _meshRenderer = GetComponent<MeshRenderer>();

            _meshRenderer.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.Off;
            _meshRenderer.receiveShadows = false;

            // MeshFilterを作成
            MeshFilter meshFilter;
            if (!GetComponent<MeshFilter>())
                meshFilter = gameObject.AddComponent<MeshFilter>();
            else
                meshFilter = GetComponent<MeshFilter>();

            // Meshを作成
            var mesh = new Mesh();
            meshFilter.mesh = mesh;

            // グリッドの間隔
            var tileSizeX = 1.0f / gridWidth;
            var tileSizeY = 1.0f / gridHeight;

            // 頂点データを作成
            var vertices  = new List<Vector3>(); // 頂点
            var triangles = new List<int>();     // 頂点インデックス
            var normals   = new List<Vector3>(); // 法線
            var uvs       = new List<Vector2>(); // UV

            var index = 0;
            for (var y = 0; y < gridHeight; y++)
                for (var x = 0; x < gridWidth; x++)
                {
                    // 頂点を追加
                    vertices.Add(new Vector3(x * tileSizeX, y * tileSizeY, 0));
                    vertices.Add(new Vector3((x + 1) * tileSizeX, y * tileSizeY, 0));
                    vertices.Add(new Vector3((x + 1) * tileSizeX, (y + 1) * tileSizeY, 0));
                    vertices.Add(new Vector3(x * tileSizeX, (y + 1) * tileSizeY, 0));
                    // 頂点インデックスを追加
                    triangles.Add(index + 2);
                    triangles.Add(index + 1);
                    triangles.Add(index);
                    triangles.Add(index);
                    triangles.Add(index + 3);
                    triangles.Add(index + 2);
                    index += 4;
                    // 法線を追加
                    normals.Add(Vector3.forward);
                    normals.Add(Vector3.forward);
                    normals.Add(Vector3.forward);
                    normals.Add(Vector3.forward);
                    // UVを追加
                    uvs.Add(new Vector2((x + 0) * tileSizeX, (y + 0) * tileSizeY));
                    uvs.Add(new Vector2((x + 1) * tileSizeX, (y + 0) * tileSizeY));
                    uvs.Add(new Vector2((x + 1) * tileSizeX, (y + 1) * tileSizeY));
                    uvs.Add(new Vector2((x + 0) * tileSizeX, (y + 1) * tileSizeY));
                }
            // 頂点の最大数（通常は65535個に制限されている）を上げる
            mesh.indexFormat = UnityEngine.Rendering.IndexFormat.UInt32;
            // 頂点データを代入
            mesh.vertices = vertices.ToArray();
            mesh.normals = normals.ToArray();
            mesh.triangles = triangles.ToArray();
            mesh.uv = uvs.ToArray();
            
            mesh.bounds = new Bounds(transform.position, Vector3.one * 1000.0f);
            mesh.RecalculateNormals();
            mesh.RecalculateTangents();
            mesh.MarkDynamic();
            mesh.name = "Grid_" + gridWidth.ToString() + "_" + gridHeight.ToString();
        }
        
    }
}