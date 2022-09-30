using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;

public static partial class SekiaExtend
{
    /// <summary>
    /// 复制
    /// </summary>
    /// <param name="destination">目标</param>
    /// <param name="source">来源</param>
    /// <param name="type">复制的属性字段模板</param>
    /// <param name="excludeName">排除下列名称的属性不要复制</param>
    /// <returns>成功复制的值个数</returns>
    public static int Copy(object source, object destination, Type type, IEnumerable<string> excludeName)
    {
        if (destination == null || source == null)
        {
            return 0;
        }

        if (excludeName == null)
        {
            excludeName = new List<string>();
        }
        int i = 0;
        Type desType = destination.GetType();

        //字段
        foreach (FieldInfo mi in type.GetFields())
        {
            if (excludeName.Contains(mi.Name))
                continue;

            FieldInfo des = desType.GetField(mi.Name);
            if (des != null && des.FieldType == mi.FieldType)
            {
                des.SetValue(destination, mi.GetValue(source));
                i++;
            }
        }

        //属性get/set
        foreach (PropertyInfo pi in type.GetProperties())
        {
            if (excludeName.Contains(pi.Name))
                continue;

            PropertyInfo des = desType.GetProperty(pi.Name);
            if (des != null && des.PropertyType == pi.PropertyType && des.CanWrite && pi.CanRead)
            {
                des.SetValue(destination, pi.GetValue(source, null), null);
                i++;
            }
        }

        return i;
    }
}
