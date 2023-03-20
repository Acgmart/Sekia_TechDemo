using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Linq;
using System.IO;
using System;

public enum Bone_Custom //全部基础骨骼
{
    //上半身
    Root, Center, Spine1, c_spine1, c_spine2, Spine2, c_spine3, Neck, c_neck, Head,
    //胸
    c_bust1_L, c_bust2_L, c_bust3_L, c_bnip1_L, c_bnip2_L,
    c_bust1_R, c_bust2_R, c_bust3_R, c_bnip1_R, c_bnip2_R,
    //上臂
    Clavicle_L, c_clavicle_L, UpperArm_L, c_upperarm1_L, c_upperarm2_L, c_upperarm3_L,
    Clavicle_R, c_clavicle_R, UpperArm_R, c_upperarm1_R, c_upperarm2_R, c_upperarm3_R,
    //下臂
    ForeArm_L, c_forearm1_L, c_forearm2_L, c_forearm3_L, Hand_L,
    ForeArm_R, c_forearm1_R, c_forearm2_R, c_forearm3_R, Hand_R,
    //手指
    Finger11_L, Finger12_L, Finger13_L, Finger21_L, Finger22_L, Finger23_L, Finger31_L, Finger32_L, Finger33_L, Finger41_L, Finger42_L, Finger43_L, Finger51_L, Finger52_L, Finger53_L,
    Finger11_R, Finger12_R, Finger13_R, Finger21_R, Finger22_R, Finger23_R, Finger31_R, Finger32_R, Finger33_R, Finger41_R, Finger42_R, Finger43_R, Finger51_R, Finger52_R, Finger53_R,
    //下半身
    Waist, c_waist1, c_waist2, c_siri_L, c_siri_R,
    //大腿
    Thigh_L, c_thigh1_L, c_thigh2_L, c_thigh3_L,
    Thigh_R, c_thigh1_R, c_thigh2_R, c_thigh3_R,
    //小腿
    Calf_L, c_calf1_L, c_calf2_L, c_calf3_L, Foot_L, Toes_L,
    Calf_R, c_calf1_R, c_calf2_R, c_calf3_R, Foot_R, Toes_R,

    //头
    Head_Root, Head_Top, Head_Fore,
    //脸颊
    Cheek_Down_L, Cheek_Top_L, Cheek_Side_L,
    Cheek_Down_R, Cheek_Top_R, Cheek_Side_R,
    //下巴
    Chin, Chin_Tip, Chin_Side,
    //耳朵
    Ear_L, Ear_Down_L, Ear_Top_L,
    Ear_R, Ear_Down_R, Ear_Top_R,
    //眼睛
    Hitomi_L, Eye_L, Eye1_L, Eye2_L, Eye3_L, Eye4_L, Eye5_L, Eye6_L, Eye7_L, Eye8_L,
    Hitomi_R, Eye_R, Eye1_R, Eye2_R, Eye3_R, Eye4_R, Eye5_R, Eye6_R, Eye7_R, Eye8_R,
    //眉毛
    Mayu_Mid_L, Mayu_Tip_L,
    Mayu_Mid_R, Mayu_Tip_R,
    //嘴巴
    Mouth, Mouth_Down, Mouth_L, Mouth_R, Mouth_Top, Mouth_Cavity,
    //鼻子
    Nose, Nose_Bridge, Nose_Tip,
}

public static class SekiaHelp
{
    #region Array-List-Dictionary-Enum-String
    //Sekia_CombineArray 将另外一个数组添加到当前数组后面
    //Sekia_GetArrayByIndexs 根据序列数组投影出指定数组的"特定排序"
    //Sekia_GetIndexInArray 获取一个对象在数据中的index
    //Sekia_StringToEnum 字符串转化为Enum
    //Sekia_EnumToArray Enum转化为Enum数组
    //Sekia_EnumToStringArray Enum转化为String数组
    //Sekia_EnumerableRange 返回整数递增序列
    //Sekia_SelectOne 使用一元lambda进行数组投影
    //Sekia_SelectTwo 使用二元lambda进行数组投影
    //Sekia_Sort 数组自定义排序

    /// <summary>
    /// 使用自定义比较器进行重新排序 机制参考注释
    /// </summary>
    /// <typeparam name="T"></typeparam>
    /// <param name="array"></param>
    /// <param name="comparison"></param>
    public static T[] Sekia_Sort<T>(this T[] array, Comparison<T> lambda)
    {
        //降序例：Array.Sort(array, (x,y)=>y.vertices.Length - x.vertices.Length)
        //x和y是将要参与比较的两个array中的元素 将逐元素进行对比
        //lambda的参数固定为2个 输出为bool类型
        Array.Sort(array, lambda);
        return array;

        //Array.Sort(array, 1, 3); //使用内置的(不考虑大小写字母顺序递增:abc)比较器 指定要重新排序的区域(数组) 参数2：开始序列 参数2：长度
        //Array.Sort(array, 1, 3, lambda); //使用指定的比较器

        /* 测试比较器的工作机制
        Vector2 vector1 = new Vector2(1F,0.10F);
        Vector2 vector2 = new Vector2(2F, 0.11F);
        Vector2 vector3 = new Vector2(3F, 0.11F);
        Vector2 vector4 = new Vector2(4F, 0.13F);
        Vector2 vector5 = new Vector2(5F, 0.09F);
        Vector2[] words = new Vector2[] { vector1 , vector2 , vector3 , vector4 , vector5 };
        Debug.Log(words[0].x.ToString() + words[1].x.ToString() + words[2].x.ToString() + words[3].x.ToString() + words[4].x.ToString());
        //输出：12345
        words.Sekia_Sort((vectx, vexty) => vexty.y.CompareTo(vectx.y)); //根据Y值进行重新排序
        Debug.Log(words[0].x.ToString() + words[1].x.ToString() + words[2].x.ToString() + words[3].x.ToString() + words[4].x.ToString());
        //输出：42314
        //CompareTo返回-1和0时不会更改顺序
        */
    }

    /// <summary>
    /// 返回整数递增序列
    /// 下一个元素x=x+1
    /// IEnumerable<int> 类型等效于 int[] List<int>
    /// </summary>
    /// <param name="start">起始整数</param>
    /// <param name="count">数组长度</param>
    /// <returns></returns>
    public static IEnumerable<int> Sekia_EnumerableRange(int start, int count)
    {
        return Enumerable.Range(start, count);
    }

    /// <summary>
    /// lambda表达式作为映射条件 将源数组投影到目标数组
    /// lambda表达式仅有1个参数 且其代表source中的逐元素
    /// 目标数组的长度和源数组一样
    /// </summary>
    /// <typeparam name="TSource">源数组中的值类型</typeparam>
    /// <typeparam name="TResult">结果数组中的值类型</typeparam>
    /// <param name="source">源数组 得到TSource</param>
    /// <param name="func">单参数lambda表达式 得到TResult</param>
    /// <returns></returns>
    public static IEnumerable<TResult> Sekia_SelectOne<TSource, TResult>(this IEnumerable<TSource> source, Func<TSource, TResult> lambda)
    {
        return source.Select(lambda);
    }

    /// <summary>
    /// 类似于Sekia_Select lambda表达式有2个参数 第2个参数代表source中的逐元素的序列值
    /// </summary>
    public static IEnumerable<TResult> Sekia_SelectTwo<TSource, TResult>(this IEnumerable<TSource> source, Func<TSource, int, TResult> lambda)
    {
        return source.Select(lambda);
    }

    /// <summary>
    /// 将另外一个数组添加到当前数组后面
    /// </summary>
    /// <typeparam name="T"></typeparam>
    /// <param name="origin">原数组</param>
    /// <param name="another">被合并的数组</param>
    /// <returns></returns>
    public static T[] Sekia_CombineArray<T>(this T[] origin, T[] another)
    {
        return origin.Concat(another).ToArray();
    }

    /// <summary>
    /// 字符串转化为Enum
    /// </summary>
    public static T Sekia_StringToEnum<T>(this string value)
    {
        //参数3指定该操作是否不区分大小写 这里区分大小写
        return (T)Enum.Parse(typeof(T), value);
    }

    /// <summary>
    /// Enum转化为Enum数组
    /// </summary>
    public static T[] Sekia_EnumToArray<T>()
    {
        return (T[])Enum.GetValues(typeof(T));
    }

    /// <summary>
    /// Enum转化为String数组
    /// </summary>
    public static string[] Sekia_EnumToStringArray<T>()
    {
        return Enum.GetNames(typeof(T));
    }
    #endregion

    #region Transform
    //Sekia_GetChildsOfTransform 深度收集transform子级
    //Sekia_GetChildByName 根据名称寻找子级
    //Sekia_GetNameOfTransforms 将transform数组转换为其名称数组

    /// <summary>
    /// 深度收集transform子级
    /// </summary>
    /// <param name="includeself">是否包含自身</param>
    /// <returns></returns>
    public static Transform[] Sekia_GetChildsOfTransform(this Transform transform, bool includeself)
    {
        List<Transform> childs = new List<Transform>();
        if (includeself)
        {
            childs.Add(transform);
        }
        transform.Sekia_FindTransformAll(childs);
        return childs.ToArray();
    }

    static void Sekia_FindTransformAll(this Transform transform, List<Transform> list)
    {
        if (transform.childCount > 0)
        {
            for (int i = 0; i < transform.childCount; ++i)
            {
                list.Add(transform.GetChild(i));
                transform.GetChild(i).Sekia_FindTransformAll(list);
            }
        }
    }

    /// <summary>
    /// 根据名称寻找子级
    /// </summary>
    public static Transform Sekia_GetChildByName(this Transform transform, string name)
    {
        Transform result = null;
        Transform[] transforms = transform.GetComponentsInChildren<Transform>();
        for (int i = 0; i < transforms.Length; ++i)
        {
            if (transforms[i].name == name)
            {
                result = transforms[i];
                break;
            }
        }
        return result;
    }

    /// <summary>
    /// 将transform数组转换为其名称数组
    /// </summary>
    public static string[] Sekia_GetNameOfTransforms(this Transform[] transforms)
    {
        string[] result = new string[transforms.Length];
        for (int i = 0; i < transforms.Length; ++i)
        {
            result[i] = transforms[i].name;
        }
        return result;
    }
    #endregion

    #region Render

    public static bool Sekia_SaveRenderTextureToPNG(this RenderTexture rt, string contents = "D:\\", string pngName = "test")
    {
        RenderTexture prev = RenderTexture.active;
        RenderTexture.active = rt;
        Texture2D png = new Texture2D(rt.width, rt.height, TextureFormat.ARGB32, false);
        png.ReadPixels(new Rect(0, 0, rt.width, rt.height), 0, 0);
        if (!Directory.Exists(contents))
            Directory.CreateDirectory(contents);
        System.IO.File.WriteAllBytes(contents + "/" + pngName + ".png", png.EncodeToPNG());
        Texture2D.DestroyImmediate(png);
        png = null;
        RenderTexture.active = prev;
        return true;
    }

    #endregion

    #region Math
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
    #endregion
}
