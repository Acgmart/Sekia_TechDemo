using System;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.InteropServices;

using UnityEngine;

namespace CellularGrowth
{

    public abstract class GPUObjectPoolBase : System.IDisposable
    {

        #region Accessors

        public ComputeBuffer PoolBuffer { get { return poolBuffer; } }
        public ComputeBuffer CountBuffer { get { return countBuffer; } }

        #endregion

        protected ComputeBuffer poolBuffer, countBuffer;
        protected int[] countArgs = new int[] { 0, 1, 0, 0 };

        public GPUObjectPoolBase(int count, System.Type type)
        {
            // Initialize object pool buffer
            poolBuffer = new ComputeBuffer(count, Marshal.SizeOf(typeof(int)), ComputeBufferType.Append);
            poolBuffer.SetCounterValue(0);
            countBuffer = new ComputeBuffer(4, sizeof(int), ComputeBufferType.IndirectArguments);
            countBuffer.SetData(countArgs);
        }

        // copy & get object pool size
        public int CopyPoolSize()
        {
            countBuffer.SetData(countArgs);
            ComputeBuffer.CopyCount(poolBuffer, countBuffer, 0);
            countBuffer.GetData(countArgs);
            return countArgs[0];
        }

        public virtual void Dispose()
        {
            poolBuffer.Dispose();
            countBuffer.Dispose();
        }

    }

}


