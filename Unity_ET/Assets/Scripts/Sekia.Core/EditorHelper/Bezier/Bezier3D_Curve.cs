using System;
using System.Collections.Generic;
using UnityEngine;

namespace Sekia
{
    /// <summary>
    /// Bezier曲线由2个node构成 每个node提供一个坐标和一个切线
    /// Bezier曲线提供接口用于采样曲线上的顶点和切线 以及顶点的相对位置
    /// 注意：曲线是非线性的 所以时间0.5和半程点不是一个位置
    /// </summary>
    public class Bezier3D_Curve
    {
        public Bezier3D_Node n1, n2;

        public void Init(Bezier3D_Node n1, Bezier3D_Node n2)
        {
            this.n1 = n1;
            this.n2 = n2;
        }

        #region 3D贝兹尔曲线采样
        //N2切线的反方向与N1切线构成了曲线的外角
        //t的取值范围是0-1
        public Vector3 GetInverseDirection()
        {
            return (2 * n2.Position) - n2.Direction;
        }

        public Vector3 GetLocation(float t)
        {
            float omt = 1f - t;
            float omt2 = omt * omt;
            float t2 = t * t;
            return
                n1.Position * (omt2 * omt) +
                n1.Direction * (3f * omt2 * t) +
                GetInverseDirection() * (3f * omt * t2) +
                n2.Position * (t2 * t);
        }

        public Vector3 GetTangent(float t)
        {
            float omt = 1f - t;
            float omt2 = omt * omt;
            float t2 = t * t;
            Vector3 tangent =
                n1.Position * (-omt2) +
                n1.Direction * (3 * omt2 - 2 * omt) +
                GetInverseDirection() * (-3 * t2 + 2 * t) +
                n2.Position * (t2);
            return tangent;
            //return tangent.normalized;
        }
        #endregion
    }
}
