using System.Collections;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using UnityEngine;

namespace Kodai
{
    
    public class SimpleNBodySimulation : MonoBehaviour, IParticleRenderable
    {

        // ブロックあたりのスレッド数
        const int SIMULATION_BLOCK_SIZE = 256;

        // バッファ指定時の定数
        const int READ = 0;
        const int WRITE = 1;

        // パーティクルのデフォルト数
        const int DEFAULT_PARTICLE_NUM = 65536;

        // 重力計算用コンピュートシェーダー
        [SerializeField] ComputeShader NBodyCS;

        // 粒子の数
        [SerializeField] NumParticles numParticles = NumParticles.NUM_16K;

        // ランダムシード
        [SerializeField] int seed = 0;

        // パーティクル量が変動した際に見た目を調整するためのパラメータ
        [SerializeField] float positionScale = 16.0f;

        // 物理パラメータ
        // 速度減衰率
        [SerializeField] float damping = 0.96f;
        // Softening因子
        [SerializeField] float softeningSquared = 0.1f;


        int numBodies;

        // GPU計算用バッファ
        ComputeBuffer[] bodyBuffers;


        void Start()
        {

            numBodies = (int) numParticles;
            
            // バッファ作成
            InitBuffer();
            
            // 粒子の初期位置を定義
            DistributeBodies();

        }

        void Update()
        {
            // コンピュートシェーダに定数を転送
            NBodyCS.SetFloat("_DeltaTime", Time.deltaTime);             // Δt
            NBodyCS.SetFloat("_Damping", damping);                      // 速度減衰率
            NBodyCS.SetFloat("_SofteningSquared", softeningSquared);    // Softening因子
            NBodyCS.SetInt("_NumBodies", numBodies);                    // 粒子数

            NBodyCS.SetVector("_ThreadDim", new Vector4(SIMULATION_BLOCK_SIZE, 1, 1, 0));                               // ブロック当たりのスレッド数
            NBodyCS.SetVector("_GroupDim", new Vector4(Mathf.CeilToInt(numBodies / SIMULATION_BLOCK_SIZE), 1, 1, 0));   // ブロック数

            // バッファアドレスを転送
            NBodyCS.SetBuffer(0, "_BodiesBufferRead", bodyBuffers[READ]);
            NBodyCS.SetBuffer(0, "_BodiesBufferWrite", bodyBuffers[WRITE]);

            // コンピュートシェーダ実行
            NBodyCS.Dispatch(0, Mathf.CeilToInt(numBodies / SIMULATION_BLOCK_SIZE), 1, 1);



            // Read/Writeを入れ替え (競合防止)
            Swap(bodyBuffers);
        }

        void OnDestroy()
        {
            // バッファを開放
            bodyBuffers[READ].Release();
            bodyBuffers[WRITE].Release();
        }




        void InitBuffer()
        {
            // バッファの作成 (Read/Write用) → 競合防止
            bodyBuffers = new ComputeBuffer[2];
            bodyBuffers[READ] = new ComputeBuffer(numBodies, Marshal.SizeOf(typeof(Body)));     // 各要素がBody構造体のバッファを粒子の個数分作成
            bodyBuffers[WRITE] = new ComputeBuffer(numBodies, Marshal.SizeOf(typeof(Body)));
        }

        void DistributeBodies()
        {
            Random.InitState(seed);

            // ルック調整用
            float scale = positionScale * Mathf.Max(1, numBodies / DEFAULT_PARTICLE_NUM);

            // バッファにセットするための配列を用意
            Body[] bodies = new Body[numBodies];

            int i = 0;
            while (i < numBodies)
            {
                // 球体内でサンプリング
                Vector3 pos = Random.insideUnitSphere;

                // 配列にセット
                bodies[i].position = pos * scale;
                bodies[i].velocity = Vector3.zero;
                bodies[i].mass = Random.Range(0.1f, 1.0f);


                i++;
            }

            // バッファに配列をセット
            bodyBuffers[READ].SetData(bodies);
            bodyBuffers[WRITE].SetData(bodies);

        }


        void Swap(ComputeBuffer[] buffer)
        {
            ComputeBuffer tmp = buffer[READ];
            buffer[READ] = buffer[WRITE];
            buffer[WRITE] = tmp;
        }


        #region IParticleRenderable

        public int GetParticleNum()
        {
            return numBodies;
        }

        public ComputeBuffer GetParticleBuffer()
        {
            return bodyBuffers[READ];
        }

        #endregion

    }


}