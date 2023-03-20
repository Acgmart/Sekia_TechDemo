using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

//编辑器模式下的辅助函数
public static class SekiaEditorHelper
{
    #region Path
    /// <summary>
    /// 返回当前Transform(this)在Hierarchy视图下的相对于另一个Transform(root)的路径
    /// 返回的路径中不包括"root/"
    /// </summary>
    /// <param name="transform"></param>
    /// <param name="root"></param>
    /// <returns></returns>
    public static string Sekia_Editor_GetTransformRelativePath(this Transform transform, Transform root)
    {
        return AnimationUtility.CalculateTransformPath(transform, root);
    }
    #endregion

    #region Bingding
    /// <summary>
    /// 返回当前GameObject(this)的数据中可以被设置为Curve的属性(Binding)
    /// root提供在Hierarchy视图下的参考Transform路径
    /// root不是this的父级时root相当于"/"
    /// m_isActive是GameObject的属性 只在"this≠root'时出现 Component是GameObject的子集
    /// 这里获得的Binding没有绑定对应的Object
    /// </summary>
    /// <param name="gameObject"></param>
    /// <param name="root"></param>
    /// <returns></returns>
    public static EditorCurveBinding[] Sekia_Editor_GetAnimatableBindings(this GameObject gameObject, GameObject root)
    {
        return AnimationUtility.GetAnimatableBindings(gameObject, root);
    }

    /// <summary>
    /// 返回Clip的Binding列表中属性类型为float的那一部分
    /// 属性类型可分为float和object reference两类
    /// </summary>
    /// <param name="clip"></param>
    /// <returns></returns>
    public static EditorCurveBinding[] Sekia_Editor_GetFloatCurveBindings(this AnimationClip clip)
    {
        return AnimationUtility.GetCurveBindings(clip);
    }

    /// <summary>
    /// 返回Clip的Binding列表中属性类型为object reference的那一部分
    /// 属性类型可分为float和object reference两类
    /// </summary>
    /// <param name="clip"></param>
    /// <returns></returns>
    public static EditorCurveBinding[] Sekia_Editor_GetObjectReferenceCurveBindings(this AnimationClip clip)
    {
        return AnimationUtility.GetObjectReferenceCurveBindings(clip);
    }
    #endregion

    #region Object
    /// <summary>
    /// 返回Binding指向的Object
    /// root提供自身的绝对路径 Binding中包含root的相对路径 root+Binding组成新的绝对路径 root是Object的某个父级之一 也可以是自身
    /// 判断绝对路径上是否存在拥有指定propertyName
    /// </summary>
    /// <param name="root"></param>
    /// <param name="binding"></param>
    /// <returns></returns>
    public static Object Sekia_Editor_GetAnimatedObject(this EditorCurveBinding binding, GameObject root)
    {
        // 返回的Object不能强制转化为GameObject
        return AnimationUtility.GetAnimatedObject(root, binding);
    }
    #endregion

    #region Clip
    /// <summary>
    /// 返回this(不包括子集)下Animator/Animation组件关联的Clip列表
    /// </summary>
    /// <param name="gameObject"></param>
    /// <returns></returns>
    public static AnimationClip[] Sekia_Editor_GetAnimationClips(this GameObject gameObject)
    {
        return AnimationUtility.GetAnimationClips(gameObject);
    }
    #endregion

    #region Event
    /// <summary>
    /// 返回Clip的Event列表
    /// </summary>
    /// <param name="clip"></param>
    /// <returns></returns>
    public static AnimationEvent[] Sekia_Editor_GetAnimationEvents(this AnimationClip clip)
    {
        return AnimationUtility.GetAnimationEvents(clip);
    }
    #endregion

    #region Curve
    /// <summary>
    /// 返回Clip文件中的float Curve 需要指定Curve的float Binding
    /// m_FloatCurves
    /// </summary>
    /// <param name="clip"></param>
    /// <param name="binding"></param>
    /// <returns></returns>
    public static AnimationCurve Sekia_Editor_GetFloatCurve(this AnimationClip clip, EditorCurveBinding binding)
    {
        return AnimationUtility.GetEditorCurve(clip, binding);
    }

    /// <summary>
    /// 返回Clip文件中的object reference Curve 需要指定Curve的object reference Binding
    /// m_PPtrCurves
    /// 与float Curve不同 object reference Curve没有额外数据 仅返回关键帧列表
    /// </summary>
    /// <param name="clip"></param>
    /// <param name="binding"></param>
    /// <returns></returns>
    public static ObjectReferenceKeyframe[] Sekia_Editor_GetObjectReferenceCurve(this AnimationClip clip, EditorCurveBinding binding)
    {
        return AnimationUtility.GetObjectReferenceCurve(clip, binding);
    }
    #endregion

    #region Keyframe
    //AnimationClipCurveData包含描述Curve的全部信息
    //curve：多个关键帧构成的状态变化
    //path：相对root的路径
    //type：Component/material的type(UnityEngine.Light)
    //propertyName：m_Clor.r 单个属性名

    //AnimationCurve的成员
    //keys：关键帧列表
    //preWrapMode/postWrapMode：过度模式

    //Keyframe的成员
    //time/value：时间(秒、float)/值(float)
    //inTangent/outTangent：斜率、单位时间内值的偏移量、默认inTangent=outTangent
    //inWeight/outWeight：
    //weightedMode：None/In/Out/Both

    //ObjectReferenceKeyframe
    //time/value：根据时间替换value对应的Object(Prefab)
    #endregion

    #region Value
    /// <summary>
    /// 获取float Binding对应的属性的当前值
    /// 通过访问GameObject的属性来获得采样值 无需访问Clip文件
    /// 在运行时播放Clip会对值产生了影响 可以间接理解为是对曲线的采样
    /// </summary>
    /// <param name="binding"></param>
    /// <param name="root"></param>
    /// <param name="value"></param>
    /// <returns></returns>
    public static float Sekia_Editor_GetFloatValue(this EditorCurveBinding binding, GameObject root)
    {
        float result1;
        AnimationUtility.GetFloatValue(root, binding, out result1);
        return result1;
    }
    #endregion
}
