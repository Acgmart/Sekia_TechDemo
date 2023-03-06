using System.Collections;
using System.Collections.Generic;
using System.Runtime.InteropServices;

using UnityEngine;

namespace CellularGrowth
{

    public class PingPongBuffer : System.IDisposable {

        #region Accessors

        public ComputeBuffer Read { get { return buffers[read]; } }
        public ComputeBuffer Write { get { return buffers[write]; } }

        #endregion

        private int read = 0, write = 1;
        protected ComputeBuffer[] buffers;

        public PingPongBuffer(int count, System.Type type)
        {
            buffers = new ComputeBuffer[2];
            buffers[0] = new ComputeBuffer(count, Marshal.SizeOf(type), ComputeBufferType.Default);
            buffers[1] = new ComputeBuffer(count, Marshal.SizeOf(type), ComputeBufferType.Default);
        }

        public void Swap()
        {
            int tmp = read;
            read = write;
            write = tmp;
        }

        public void Dispose()
        {
            buffers[0].Dispose();
            buffers[1].Dispose();
        }

    }

}


