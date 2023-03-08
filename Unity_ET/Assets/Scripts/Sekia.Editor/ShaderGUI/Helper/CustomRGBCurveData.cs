using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CustomRGBCurveData : ScriptableObject
{
    public AnimationCurve _curve1 = AnimationCurve.Linear(0, 0, 1, 1);
    public AnimationCurve _curve2 = AnimationCurve.Linear(0, 0, 1, 1);
    public AnimationCurve _curve3 = AnimationCurve.Linear(0, 0, 1, 1);
    public AnimationCurve _curve4 = AnimationCurve.Linear(0, 0, 1, 1);
}
