using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using GeomUtil = GeometryUtil;

namespace EarClippingTriangulation
{

    /// <summary>
    /// 多角形クラス
    /// </summary>
    public class Polygon 
    {
        // ループの方向
        public enum LoopType
        {
            CW,     // 時計回り
            CCW,    // 反時計回り
            ERR,    // 不定（向きがない）
        }

        public Vector3[] vertices;  // 頂点配列
        public LoopType loopType;   // ループの方向

        public Rect rect;           // 矩形領域

        public float minX = float.MaxValue;
        public float maxX = float.MinValue;
        public float minY = float.MaxValue;
        public float maxY = float.MinValue;

        public Polygon(Vector3[] points)
        {
            vertices = points.Clone() as Vector3[];

            for (int i = 0; i < vertices.Length; i++)
            {
                if (vertices[i].x < minX) { minX = vertices[i].x; }
                if (vertices[i].x > maxX) { maxX = vertices[i].x; }
                if (vertices[i].y < minY) { minY = vertices[i].y; }
                if (vertices[i].y > maxY) { maxY = vertices[i].y; }
            }
            rect = new Rect(minX, minY, maxX - minX, maxY - minY);

            CheckLoopType();
        }
        
        /// <summary>
        /// 面積の計算
        /// </summary>
        /// <returns></returns>
        public float CalcArea()
        {
            float area = 0;
            for (int i = 0; i < vertices.Length; i++)
            {
                int next = (i + 1) % vertices.Length;
                Vector3 v1 = vertices[i];
                Vector3 v2 = vertices[next];

                area += GeomUtil.Cross2D(v1, v2);
            }

            return area * 0.5f;
        }

        /// <summary>
        /// ループの方向をチェックする
        /// </summary>
        public LoopType CheckLoopType()
        {
            float area = CalcArea();

            if (area > 0)
            {
                loopType = LoopType.CCW;
            }else if (area < 0)
            {
                loopType = LoopType.CW;
            }
            else
            {
                loopType = LoopType.ERR;
            }

            return loopType;
        }
        
        /// <summary>
        /// 頂点配列の順番を反転させる処理 
        /// </summary>
        public void ReverseIndices()
        {
            int len = vertices.Length / 2;
            for(int i = 0; i < len; i++)
            {
                int backIdx = vertices.Length - 1 - i;

                Vector3 tmp = vertices[i];
                vertices[i] = vertices[backIdx];
                vertices[backIdx] = tmp;
            }

            CheckLoopType();
        }

        
        private const float _unit = 1f / 360f;

        // 多角形の中に点が入っているか？
        public bool IsPointInPolygon(Vector3 point)
        {
            // 辺と交差する回数などで判定する方法
            int crossCount = 0;

            Vector3 p0 = vertices[0];
            bool flag0x = (point.x <= p0.x);
            bool flag0y = (point.y <= p0.y);

            for (int i = 1; i < (vertices.Length + 1); i++)
            {
                Vector3 p1 = vertices[i % vertices.Length];

                bool flag1x = (point.x <= p1.x);
                bool flag1y = (point.y <= p1.y);

                if (flag0y != flag1y)
                {
                    // 線分はレイを横切る可能性あり
                    if(flag0x == flag1x)
                    {
                        // 線分の２端点は対象点に対して両方→か左にある
                        if (flag0x)
                        {
                            // 完全に右→線分はレイを横切る
                            crossCount += (flag0y ? -1 : 1);    // 上から下にレイを横切る時は-1、下から上は+1
                        }
                    }
                    else
                    {
                        // レイと交差するかどうか、対象点と同じ高さで、対象点の→で交差するか、左で交差するかを求める
                        if(point.x <= (p0.x + (p1.x - p0.x) * (point.y - p0.y) / (p1.y - p0.y)))
                        {
                            // 線分は、対象点と同じ高さで、対象点の右で交差する→線分はレイを横切る
                            crossCount += (flag0y ? -1 : 1);    // 上から下にレイを横切る時は-1、下から上は+1
                        }
                    }
                }

                p0 = p1;
                flag0x = flag1x;
                flag0y = flag1y;
            }

            return (0 != crossCount);
            
        }

        /// <summary>
        /// 多角形の中に多角形が入っているか？
        /// </summary>
        /// <param name="polygon"></param>
        /// <returns></returns>
        public bool IsPointInPolygon(Polygon polygon)
        {
            for(int i = 0; i < polygon.vertices.Length; i++)
            {
                if (!IsPointInPolygon(polygon.vertices[i]))
                {
                    return false;
                }
            }

            return true;
        }
        
    }
}