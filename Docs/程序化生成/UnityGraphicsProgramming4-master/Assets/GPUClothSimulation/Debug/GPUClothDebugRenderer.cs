using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Runtime.InteropServices;

namespace GPUClothSimulation
{
    [RequireComponent(typeof(GPUClothSimulation))]
    public class GPUClothDebugRenderer : MonoBehaviour
    {
        struct SpringIds
        {
            public Vector2Int a;
            public Vector2Int b;

            public SpringIds(Vector2Int a, Vector2Int b)
            {
                this.a = a;
                this.b = b;
            }
        }

        ComputeBuffer _gridBuffer;
        ComputeBuffer _gridDiagonalBuffer;
        ComputeBuffer _gridDiagonalAlternateBuffer;

        GPUClothSimulation _clothSim;

        [SerializeField]
        float _particleSize = 0.005f;

        [SerializeField]
        Color _massParticleColor = new Color(1.0f, 1.0f, 1.0f, 0.5f);

        [SerializeField]
        Color _gridColor = new Color(0.0f, 0.0f, 1.0f, 0.5f);

        [SerializeField]
        Color _gridDiagonalColor = new Color(0.0f, 1.0f, 0.0f, 0.5f);

        [SerializeField]
        Color _gridDiagonalAlternateColor = new Color(1.0f, 0.0f, 0.0f, 0.5f);

        [SerializeField]
        bool _drawMassParticle = true;

        [SerializeField]
        bool _drawGrid = true;

        [SerializeField]
        bool _drawGridDiagonal = true;

        [SerializeField]
        bool _drawGridDiagonalAlternate = true;

        [SerializeField]
        Material _renderMat = null;

        private bool _isInit = false;
        
        void Update()
        {
            if (!_isInit)
            {
                if (_clothSim == null)
                    _clothSim = GetComponent<GPUClothSimulation>();
                
                if (_clothSim != null && _clothSim.IsInit)
                {
                    var gridList                  = new List<SpringIds>();
                    var gridDiagonalList          = new List<SpringIds>();
                    var gridDiagonalAlternateList = new List<SpringIds>();

                    var res = _clothSim.GetClothResolution();
                    for (var y = 0; y < res.y; y++)
                    {
                        for (var x = 0; x < res.x; x++)
                        {
                            gridList.Add(new SpringIds(new Vector2Int(x, y), new Vector2Int(x, y + 1)));
                            gridList.Add(new SpringIds(new Vector2Int(x, y), new Vector2Int(x + 1, y)));

                            if (x < res.x - 1 && y < res.y - 1)
                            {
                                gridDiagonalList.Add(new SpringIds(new Vector2Int(x, y), new Vector2Int(x + 1, y + 1)));
                                gridDiagonalList.Add(new SpringIds(new Vector2Int(x + 1, y), new Vector2Int(x, y + 1)));
                            }

                            if (x < res.x - 2 && y < res.y - 2)
                                gridDiagonalAlternateList.Add(new SpringIds(new Vector2Int(x, y), new Vector2Int(x + 2, y + 2)));
                            if (x >= 2 && y < res.y - 2)
                                gridDiagonalAlternateList.Add(new SpringIds(new Vector2Int(x, y), new Vector2Int(x - 2, y + 2)));
                        }
                    }

                    _gridBuffer = new ComputeBuffer(gridList.Count, Marshal.SizeOf(typeof(SpringIds)));
                    _gridBuffer.SetData(gridList.ToArray());

                    _gridDiagonalBuffer = new ComputeBuffer(gridDiagonalList.Count, Marshal.SizeOf(typeof(SpringIds)));
                    _gridDiagonalBuffer.SetData(gridDiagonalList.ToArray());

                    _gridDiagonalAlternateBuffer = new ComputeBuffer(gridDiagonalAlternateList.Count, Marshal.SizeOf(typeof(SpringIds)));
                    _gridDiagonalAlternateBuffer.SetData(gridDiagonalAlternateList.ToArray());

                    gridList = null;
                    gridDiagonalList = null;
                    gridDiagonalAlternateList = null;

                    _isInit = true;
                }
            }
        }

        void OnRenderObject()
        {
            if (!_isInit || !_renderMat)
                return;

            if (_drawMassParticle)
            {
                _renderMat.SetFloat("_ParticleSize", _particleSize);
                _renderMat.SetColor("_Color", _massParticleColor);
                _renderMat.SetTexture("_PositionTex", _clothSim.GetPositionBuffer());
                _renderMat.SetPass(0);

                Graphics.DrawProcedural(MeshTopology.Points, _clothSim.GetClothResolution().x * _clothSim.GetClothResolution().y);
            }

            if (_drawGrid)
            {
                _renderMat.SetColor("_Color", _gridColor);
                _renderMat.SetTexture("_PositionTex", _clothSim.GetPositionBuffer());
                _renderMat.SetBuffer("_SpringIdsBuffer", _gridBuffer);
                _renderMat.SetPass(1);

                Graphics.DrawProcedural(MeshTopology.Points, _gridBuffer.count);
            }

            if (_drawGridDiagonal)
            {
                _renderMat.SetColor("_Color", _gridDiagonalColor);
                _renderMat.SetTexture("_PositionTex", _clothSim.GetPositionBuffer());
                _renderMat.SetBuffer("_SpringIdsBuffer", _gridDiagonalBuffer);
                _renderMat.SetPass(1);

                Graphics.DrawProcedural(MeshTopology.Points, _gridDiagonalBuffer.count);
            }

            if (_drawGridDiagonalAlternate)
            {
                _renderMat.SetColor("_Color", _gridDiagonalAlternateColor);
                _renderMat.SetTexture("_PositionTex", _clothSim.GetPositionBuffer());
                _renderMat.SetBuffer("_SpringIdsBuffer", _gridDiagonalAlternateBuffer);
                _renderMat.SetPass(1);

                Graphics.DrawProcedural(MeshTopology.Points, _gridDiagonalAlternateBuffer.count);
            }
        }

        void OnDestroy()
        {
            if (_gridBuffer != null)
            {
                _gridBuffer.Release();
                _gridBuffer = null;
            }

            if (_gridDiagonalBuffer != null)
            {
                _gridDiagonalBuffer.Release();
                _gridDiagonalBuffer = null;
            }

            if (_gridDiagonalAlternateBuffer != null)
            {
                _gridDiagonalAlternateBuffer.Release();
                _gridDiagonalAlternateBuffer = null;
            }
        }
    }
}