using System;
using System.Collections;
using System.Collections.Generic;

using UnityEngine;

namespace CellularGrowth
{

    public class GPUObjectPoolPingPong : GPUObjectPoolBase {

        #region Accessors

        public PingPongBuffer ObjectPingPong { get { return pingpong; } }

        #endregion

        protected PingPongBuffer pingpong;

        public GPUObjectPoolPingPong(int count, System.Type type) : base(count, type)
        {
            pingpong = new PingPongBuffer(count, type);
        }

        public override void Dispose()
        {
            base.Dispose();
            pingpong.Dispose();
        }

    }

}


