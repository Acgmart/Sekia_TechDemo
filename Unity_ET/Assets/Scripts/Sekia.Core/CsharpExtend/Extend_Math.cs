using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Linq;
using System.IO;
using System;
using System.Text;

public static partial class SekiaExtend
{
    /// <summary>
    /// bottom的n次方等于poweredvalue 求n
    /// </summary>
    /// <param name="bottom">底数</param>
    /// <param name="poweredvalue">真值</param>
    /// <returns></returns>
    public static float Sekia_Log(this float bottom, float poweredvalue)
    {
        return UnityEngine.Mathf.Log(poweredvalue, bottom);
    }

    /// <summary>
    /// 求自然数e的power次方 e等于2.71828 当power小于0时在Y轴左侧的曲线增速递增且过点(0,1)
    /// </summary>
    /// <param name="power">指数</param>
    /// <returns></returns>
    public static float Sekia_Exp(this float power)
    {
        return UnityEngine.Mathf.Exp(power);
    }

    //使角度的范围在-180~180之间 不包括-180
    public static float ClampAngle(this float angle)
    {
        angle = angle % 360f;
        if (angle <= -180f)
            angle += 360f;
        else if (angle > 180f)
            angle -= 360f;
        return angle;
    }

    //使角度的范围在-180~180之间 不包括-180
    public static Vector3 ClampAngles(this Vector3 eulerAngles)
    {
        return new Vector3(ClampAngle(eulerAngles.x),
            ClampAngle(eulerAngles.y),
            ClampAngle(eulerAngles.z));
    }

    public static bool IsWithin(this int value, int minimum, int maximum)
    {
        return value >= minimum && value <= maximum;
    }

    public static bool IsWithin(this float value, float minimum, float maximum)
    {
        return value >= minimum && value <= maximum;
    }

    public static Vector3 SmoothStep(this Vector3 from, Vector3 to, float progress)
    {
        var x = Mathf.SmoothStep(from.x, to.x, progress);
        var y = Mathf.SmoothStep(from.y, to.y, progress);
        var z = Mathf.SmoothStep(from.z, to.z, progress);
        return new Vector3(x, y, z);
    }

    public static float ScaleToFitWidthOrHeight(this Vector2 sourceSize, Vector2 targetSize)
    {
        var targetAspect = targetSize.x / targetSize.y;
        var sourceAspect = sourceSize.x / sourceSize.y;
        if (targetAspect > sourceAspect) //目标更宽屏 缩小source至两者高度一样
            return targetSize.y / sourceSize.y;
        return targetSize.x / sourceSize.x;
    }
}
