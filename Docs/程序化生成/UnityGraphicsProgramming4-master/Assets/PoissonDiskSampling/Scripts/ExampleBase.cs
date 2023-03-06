using System;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using UnityEngine;

namespace PoissonDiskSampling
{
    public abstract class ExampleBase<T> : MonoBehaviour where T : struct
    {
        public const int MaxPoint = 50000;

        [Header("For Sampling")]
        [SerializeField]
        protected T bottomLeftBack = default;
        [SerializeField]
        protected T topRightForward = default;
        [SerializeField]
        protected float minimumDistance = 10f;
        [SerializeField]
        protected int iterationPerPoint = 30;

        [Header("For Viewing")]
        [SerializeField]
        protected float delay = 0.01f;
        [SerializeField]
        protected Material geometryMaterial = null;
        [SerializeField]
        protected float radiusRate = 0.5f;

        protected List<T> points = new List<T>();
        protected ComputeBuffer buffer = null;


        protected virtual void Awake()
        {
            this.buffer = new ComputeBuffer(MaxPoint, Marshal.SizeOf(typeof(T)), ComputeBufferType.Default);
            StartCoroutine(this.Loop());
        }

        protected virtual IEnumerator Loop()
        {
            var looper = this.GetLooper();
            var result = true;

            do
            {
                yield return new WaitForSeconds(this.delay);
                result = looper();
            }
            while(result == true);
        }

        protected abstract Func<bool> GetLooper();

        protected virtual void OnDestroy()
        {
            this.buffer?.Dispose();
        }

        protected virtual void OnRenderObject()
        {
            this.buffer.SetData(this.points);
            this.geometryMaterial.SetBuffer("_Points", this.buffer);
            this.geometryMaterial.SetFloat("_Radius", this.minimumDistance * this.radiusRate * 0.5f);

            this.geometryMaterial.SetPass(0);
            Graphics.DrawProcedural(MeshTopology.Points, this.points.Count, 1);
        }
    }
}
