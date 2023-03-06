using System.Collections.Generic;
using UnityEngine;
using System;
using System.Runtime.InteropServices;

namespace PoissonDiskSampling
{
    [AddComponentMenu("")]
    public class Example2D : ExampleBase<Vector2>
    {
        protected override Func<bool> GetLooper()
            => FastPoissonDiskSampling2D.StepSampling(this.bottomLeftBack, this.topRightForward, this.minimumDistance, this.iterationPerPoint, out this.points);
    }
}
