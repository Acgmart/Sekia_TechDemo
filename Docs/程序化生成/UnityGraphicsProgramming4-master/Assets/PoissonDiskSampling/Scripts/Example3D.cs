using System;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using UnityEngine;

namespace PoissonDiskSampling
{
    [AddComponentMenu("")]
    public class Example3D : ExampleBase<Vector3>
    {
        protected override Func<bool> GetLooper()
            => FastPoissonDiskSampling3D.StepSampling(this.bottomLeftBack, this.topRightForward, this.minimumDistance, this.iterationPerPoint, out this.points);
    }
}
