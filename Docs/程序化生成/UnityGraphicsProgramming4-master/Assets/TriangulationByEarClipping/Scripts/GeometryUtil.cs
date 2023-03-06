using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public static class GeometryUtil
{
    /// <summary>
    /// 直線OAと直線OBがなす角が180度以内か？(Oの角度)
    /// </summary>
    /// <param name="o"></param>
    /// <param name="a"></param>
    /// <param name="b"></param>
    /// <returns></returns>
    public static bool IsAngleLessPI(Vector3 o, Vector3 a, Vector3 b)
    {
        return (a.x - o.x) * (b.y - o.y) - (a.y - o.y) * (b.x - o.x) > 0;
    }

    /// <summary>
    /// 2次元外積
    /// </summary>
    /// <param name="v1"></param>
    /// <param name="v2"></param>
    /// <returns></returns>
    public static float Cross2D(Vector3 v1, Vector3 v2)
    {
        return v1.x * v2.y - v1.y * v2.x;
    }

    /// <summary>
    /// 線分同士の交差判定
    /// </summary>
    /// <param name="start1"></param>
    /// <param name="end1"></param>
    /// <param name="start2"></param>
    /// <param name="end2"></param>
    /// <param name="intersectionP"></param>
    /// <returns></returns>
    public static bool IsIntersectLine(Vector3 start1, Vector3 end1, Vector3 start2, Vector3 end2, ref Vector3 intersectionP)
    {
        Vector3 va = end1 - start1;
        Vector3 vb = end2 - start2;

        // 外積
        float cross = va.x * vb.y - va.y * vb.x;

        if (cross == 0f)
        {
            // 平行
            return false;
        }

        Vector3 v1 = start1 - start2;

        float t = (v1.y * vb.x - v1.x * vb.y) / cross;
        float s = (v1.y * va.x - v1.x * va.y) / cross;

        if (t < 0f || t > 1f || s < 0f || s > 1f)
        {
            // 交差してない
            return false;
        }

        intersectionP = va * t + start1;
        return true;
    }
    
    /// <summary>
    /// 線と頂点の位置関係を返す
    /// </summary>
    /// <param name="o"></param>
    /// <param name="p1"></param>
    /// <param name="p2"></param>
    /// <returns> +1 : 線の右 -1 : 線の左 0 : 線上</returns>
    public static int CheckLine(Vector3 o, Vector3 p1, Vector3 p2)
    {
        double x0 = o.x - p1.x;
        double y0 = o.y - p1.y;
        double x1 = p2.x - p1.x;
        double y1 = p2.y - p1.y;

        double x0y1 = x0 * y1;
        double x1y0 = x1 * y0;
        double det = x0y1 - x1y0;

        return (det > 0D ? +1 : (det < 0D ? -1 : 0));
    }

    /// <summary>
    /// 三角形(時計回り)と点の内外判定
    /// </summary>
    /// <param name="o"></param>
    /// <param name="p1"></param>
    /// <param name="p2"></param>
    /// <param name="p3"></param>
    /// <returns> +1 : 外側 -1 : 内側 0 : 線上</returns>
    public static int IsInTriangle(Vector3 o, Vector3 p1, Vector3 p2, Vector3 p3)
    {
        int sign1 = CheckLine(o, p2, p3);
        if (sign1 < 0)
        {
            return +1;
        }

        int sign2 = CheckLine(o, p3, p1);
        if (sign2 < 0)
        {
            return +1;
        }

        int sign3 = CheckLine(o, p1, p2);
        if (sign3 < 0)
        {
            return +1;
        }

        return (((sign1 != 0) && (sign2 != 0) && (sign3 != 0)) ? -1 : 0);
    }

    /// <summary>
    /// 多角形と線分の交点を探す（多角形は時計回りである前提）
    /// </summary>
    /// <param name="start"></param>
    /// <param name="end"></param>
    /// <param name="vertices"></param>
    /// <param name="indices"></param>
    /// <param name="intersectionP"></param>
    /// <param name="index0"></param>
    /// <param name="index1"></param>
    /// <returns></returns>
    public static bool GetIntersectionPoint(Vector3 start, Vector3 end, List<Vector3> vertices, LinkedList<int> indices, ref Vector3 intersectionP, ref int index0, ref int index1)
    {
        float distanceMin = float.MaxValue;
        bool isHit = false;

        LinkedListNode<int> indexNode = indices.First;
        while(indexNode != null)
        {
            int index = indexNode.Value;
            int next = (indexNode.Next == null) ? indices.First.Value : indexNode.Next.Value;        // 次の頂点

            indexNode = indexNode.Next;

            Vector3 iP = Vector3.zero;
            Vector3 vstart = vertices[index];
            Vector3 vend = vertices[next];
            
            // 交差する多角形の線分の始点が線分以上にいること
            Vector3 diff0 = vstart - start;
            if (diff0.y < 0f)
            {
                continue;
            }

            // 交差する多角形の線分の終点が線分以下にいること
            Vector3 diff1 = vend - start;
            if (diff1.y > 0f)
            {
                continue;
            }

            if (IsIntersectLine(start, end, vstart, vend, ref iP))
            {
                float distance = Vector3.Distance(start, iP);

                if (distanceMin >= distance)
                {
                    distanceMin = distance;
                    index0 = index;
                    index1 = next;
                    intersectionP = iP;
                    isHit = true;
                }
            }

        }

        return isHit;
    }

    public static bool GetIntersectionPoint(Vector3 start, Vector3 end, Vector3[] vertices, ref Vector3 intersectionP, ref int index0, ref int index1)
    {
        float distanceMin = float.MaxValue;
        bool isHit = false;

        for(int i = 0; i < vertices.Length; i++)
        {
            int index = i;
            int next = (i + 1) % vertices.Length;        // 次の頂点

            Vector3 iP = Vector3.zero;
            Vector3 vstart = vertices[index];
            Vector3 vend = vertices[next];

            // 交差する多角形の線分の始点が線分以上にいること
            Vector3 diff0 = vstart - start;
            if (diff0.y < 0f)
            {
                continue;
            }

            // 交差する多角形の線分の終点が線分以下にいること
            Vector3 diff1 = vend - start;
            if (diff1.y > 0f)
            {
                continue;
            }

            if (IsIntersectLine(start, end, vstart, vend, ref iP))
            {
                float distance = Vector3.Distance(start, iP);

                if (distanceMin >= distance)
                {
                    distanceMin = distance;
                    index0 = index;
                    index1 = next;
                    intersectionP = iP;
                    isHit = true;
                }
            }

        }

        return isHit;
    }
}
