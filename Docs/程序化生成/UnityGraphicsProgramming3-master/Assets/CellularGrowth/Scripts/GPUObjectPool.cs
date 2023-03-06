using System;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.InteropServices;

using UnityEngine;

namespace CellularGrowth
{

    public class GPUObjectPool : GPUObjectPoolBase
    {

        #region Accessors

        public ComputeBuffer ObjectBuffer { get { return objectBuffer; } }

        #endregion

        protected ComputeBuffer objectBuffer;

        public GPUObjectPool(int count, System.Type type) : base(count, type)
        {
            // Initialize object buffer
            objectBuffer = new ComputeBuffer(count, Marshal.SizeOf(type), ComputeBufferType.Default);
        }

        public override void Dispose()
        {
            base.Dispose();
            objectBuffer.Dispose();
        }

    }

}


