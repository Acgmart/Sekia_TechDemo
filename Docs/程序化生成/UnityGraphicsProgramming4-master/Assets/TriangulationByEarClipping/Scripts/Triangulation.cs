using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Text;
using GeomUtil = GeometryUtil;

namespace EarClippingTriangulation
{
    /// <summary>
    /// 多角形をEar Clippingで三角形分割
    /// </summary>
    public class Triangulation : MonoBehaviour
    {
        /// <summary>
        /// 三角形の描画フラグ
        /// </summary>
        [SerializeField]
        bool isDrawTriangle = true;

        // 頂点配列
        List<Vector3> vertices = new List<Vector3>();

        // 頂点番号のリスト（末尾と先頭がつながってることにする）
        LinkedList<int> indices = new LinkedList<int>();

        // 耳頂点リスト
        List<int> earTipList = new List<int>();

        int resultTriangulationOffset = 0;
        List<Vector3> resultVertices = new List<Vector3>();  // Mesh化用の頂点配列
        List<int> resultTriangulation = new List<int>();
        List<Vector2> resultUVs = new List<Vector2>();

        List<Triangle> triangles = new List<Triangle>();

        Mesh mesh;

        // 多角形リスト
        List<Polygon> polygonList = new List<Polygon>();

        public void ClearPolygon()
        {
            polygonList.Clear();
            MeshFilter filter = GetComponent<MeshFilter>();
            if (filter != null)
            {
                filter.mesh = null;
            }
        }

        public void AddPolygon(Polygon polygon)
        {
            polygonList.Add(polygon);
        }

        // 多角形ツリー
        TreeNode<Polygon> polygonTree = null;

        Rect uvRect;
        float minX = float.MaxValue;
        float maxX = float.MinValue;
        float minY = float.MaxValue;
        float maxY = float.MinValue;

#if UNITY_EDITOR
        // デバッグ用
        List<Vector3> debugVertices = new List<Vector3>();      // 頂点配列
        LinkedList<int> debugIndices = new LinkedList<int>();   // 頂点番号のリスト（末尾と先頭がつながってることにする）
#endif

        /// <summary>
        /// 三角形分割処理の開始
        /// </summary>
        public void Triangulate()
        {
            resultVertices.Clear();
            resultTriangulation.Clear();
            resultUVs.Clear();
            resultTriangulationOffset = 0;
            triangles.Clear();

#if UNITY_EDITOR
            debugVertices.Clear();
            debugIndices.Clear();
#endif

            minX = float.MaxValue;
            maxX = float.MinValue;
            minY = float.MaxValue;
            maxY = float.MinValue;
            
            for (int i = 0; i < polygonList.Count; i++)
            {
                for (int j = 0; j < polygonList[i].vertices.Length; j++)
                {
                    // UV範囲の計算
                    Vector3 nowVertex = polygonList[i].vertices[j];
                    if (nowVertex.x < minX) { minX = nowVertex.x; }
                    if (nowVertex.x > maxX) { maxX = nowVertex.x; }
                    if (nowVertex.y < minY) { minY = nowVertex.y; }
                    if (nowVertex.y > maxY) { maxY = nowVertex.y; }
                }
            }

            uvRect = new Rect(minX, minY, maxX - minX, maxY - minY);
            Debug.Log("min " + minX + ", " + minY + " max " + maxX + ", " + maxY);
            Debug.Log("uvRect " + uvRect);

            // 多角形リストの矩形領域の面積の大きい順にソート
            polygonList.Sort((a, b) => Mathf.FloorToInt((b.rect.width * b.rect.height) - (a.rect.width * a.rect.height)));

            // ルート作成（空っぽ）
            polygonTree = new TreeNode<Polygon>();

            // 多角形の階層構造を作る
            foreach (Polygon polygon in polygonList)
            {
                TreeNode<Polygon> tree = polygonTree;

                CheckInPolygonTree(tree, polygon, 1);
            }

#if UNITY_EDITOR
            DumpNode(polygonTree, 0);
#endif
            
            // 結合
            Queue<TreeNode<Polygon>> treeQueue = new Queue<TreeNode<Polygon>>();
            for (int i = 0; i < polygonTree.children.Count; i++)
            {
                treeQueue.Enqueue(polygonTree.children[i]);
            }

            while (treeQueue.Count > 0)
            {
                //Debug.Log("treeQueue.Count " + treeQueue.Count);

                // 外側多角形取り出し
                TreeNode<Polygon> outer = treeQueue.Dequeue();
                int childCount = outer.children.Count;

                // 子がいなければ自分だけ三角形分割
                if (childCount == 0)
                {
                    InitializeVertices(outer.Value.vertices);

                    // 三角形分割
                    EarClipping();
                }
                else
                {
                    // 内側多角形の子は新たな外側多角形になるのでQueueに追加
                    List<Polygon> inners = new List<Polygon>(childCount);
                    for(int i = 0; i < childCount; i++)
                    {
                        TreeNode<Polygon> inner = outer.children[i];
                        inners.Add(inner.Value);
                        int grandChildCount = inner.children.Count;
                        for(int j = 0; j < grandChildCount; j++)
                        {
                            treeQueue.Enqueue(inner.children[j]);
                        }
                    }

                    // 外側多角形と内側多角形の結合
                    if (outer.isValue)
                    {
                        Vector3[] newOuter = CombineOuterAndInners(outer.Value.vertices, inners);

                        InitializeVertices(newOuter);

                        // 三角形分割
                        EarClipping();
                    }
                }
            }

            MakeMesh();
            
        }

        /// <summary>
        /// PolygonTreeに含まれるかチェック
        /// </summary>
        /// <param name="tree"></param>
        /// <param name="polygon"></param>
        /// <param name="lv">ネストの深さ</param>
        /// <returns>true:含まれた false:含まれない</returns>
        bool CheckInPolygonTree(TreeNode<Polygon> tree, Polygon polygon, int lv)
        {
            // 自身に多角形が存在するか？
            bool isInChild = false;
            if (tree.isValue)
            {
                if (tree.Value.IsPointInPolygon(polygon))
                {
                    // 自身に含まれる場合、子にも含まれるか検索
                    for(int i = 0; i < tree.children.Count; i++)
                    {
                        isInChild |= CheckInPolygonTree(tree.children[i], polygon, lv + 1);
                    }

                    // 子に含まれない場合は自身の子にする
                    if (!isInChild)
                    {
                        // 必要であれば頂点の順番を反転する
                        // 偶数ネストの時はInnerなのでCW
                        // 奇数ネストの時はOuterなのでCCW
                        if (
                            ((lv % 2 == 0) && (polygon.loopType == Polygon.LoopType.CW)) ||
                            ((lv % 2 == 1) && (polygon.loopType == Polygon.LoopType.CCW))
                            )
                        {
                            polygon.ReverseIndices();
                        }

                        tree.children.Add(new TreeNode<Polygon>(polygon));
                        return true;
                    }
                }
                else
                {
                    // 含まれない
                    return false;
                }
            }
            else
            {
                // 自身に値がない場合、子の方だけ検索
                for (int i = 0; i < tree.children.Count; i++)
                {
                    isInChild |= CheckInPolygonTree(tree.children[i], polygon, lv + 1);
                }

                // 子に含まれない場合は自身の子にする
                if (!isInChild)
                {
                    // 必要であれば頂点の順番を反転する
                    // 偶数ネストの時はInnerなのでCW
                    // 奇数ネストの時はOuterなのでCCW
                    if (
                        ((lv % 2 == 0) && (polygon.loopType == Polygon.LoopType.CW)) ||
                        ((lv % 2 == 1) && (polygon.loopType == Polygon.LoopType.CCW))
                        )
                    {
                        polygon.ReverseIndices();
                    }
                    tree.children.Add(new TreeNode<Polygon>(polygon));
                    return true;
                }
            }

            return isInChild;
        }

        /// <summary>
        /// 指定インデックスが凸頂点か反射頂点か耳かチェックして各リストに追加
        /// </summary>
        /// <param name="node"></param>
        void CheckVertex(LinkedListNode<int> node)
        {
            // 凸頂点/反射頂点チェック
            int prevIndex = (node.Previous == null) ? indices.Last.Value : node.Previous.Value; // 一つ前の頂点
            int nextIndex = (node.Next == null) ? indices.First.Value : node.Next.Value;        // 次の頂点
            int nowIndex = node.Value;

            Vector3 prevVertex = vertices[prevIndex];
            Vector3 nextVertex = vertices[nextIndex];
            Vector3 nowVertex = vertices[nowIndex];
            
            bool isEar = false;

            // 内角が180度以内か？
            if (GeomUtil.IsAngleLessPI(nowVertex, prevVertex, nextVertex))
            {
                // 耳チェック
                // 180度以内、三角形の中に他の頂点が含まれない
                isEar = true;
                foreach(int i in indices)
                {
                    if ((i == prevIndex) || (i == nowIndex) || (i == nextIndex))
                        continue;

                    Vector3 p = vertices[i];

                    // 分割時に複製した同一座標だったら無視
                    if (Vector3.Distance(p, prevVertex) <= float.Epsilon) continue;
                    if (Vector3.Distance(p, nowVertex) <= float.Epsilon) continue;
                    if (Vector3.Distance(p, nextVertex) <= float.Epsilon) continue;

                    if(GeomUtil.IsInTriangle(p, prevVertex, nowVertex, nextVertex) <= 0)
                    {
                        isEar = false;
                        //Debug.Log("Triangle(" + prevIndex + ", " + nowIndex + ", " + nextIndex + ") in " + i);
                        break;
                    }
                    
                }
                if (isEar)
                {
                    if (!earTipList.Contains(nowIndex))
                    {
                        // 耳追加
                        earTipList.Add(nowIndex);
                    }
                }
                else
                {
                    // すでに耳のときに耳ではなくなった場合除外
                    if (earTipList.Contains(nowIndex))
                    {
                        // 耳削除
                        earTipList.Remove(nowIndex);
                    }
                }
                
            }

        }

        /// <summary>
        /// 初期化
        /// </summary>
        void InitializeVertices(Vector3[] points)
        {
            vertices.Clear();
            indices.Clear();
            earTipList.Clear();

            // インデックス配列の作成
            resultTriangulationOffset = resultVertices.Count;
            for (int i = 0; i < points.Length; i++)
            {
                Vector3 nowVertex = points[i];
                vertices.Add(nowVertex);

                indices.AddLast(i);

                resultVertices.Add(nowVertex);
#if UNITY_EDITOR
                debugVertices.Add(nowVertex);
#endif
            }

            // 凸三角形と耳の検索
            LinkedListNode<int> node = indices.First;
            while (node != null)
            {
                CheckVertex(node);
#if UNITY_EDITOR
                debugIndices.AddLast(resultTriangulationOffset + node.Value);
#endif
                node = node.Next;
            }


#if UNITY_EDITOR
            // ================================================================
            // debug
            Debug.Log("Initialized Vertices ================================");
            DumpList(indices, "indices");
            DumpList(earTipList, "earTip");
            // ================================================================
#endif
        }

        /// <summary>
        /// X座標最大値と多角形の情報
        /// </summary>
        struct XMaxData
        {
            public float xmax;  // x座標最大値
            public int no;      // 多角形の番号
            public int index;   // xmaxの頂点番号

            public XMaxData(float x, int n, int ind)
            {
                xmax = x;
                no = n;
                index = ind;
            }
        }

        /// <summary>
        /// 外側と内側の多角形を結合していく
        /// </summary>
        /// <param name="outer"></param>
        /// <param name="inners"></param>
        Vector3[] CombineOuterAndInners(Vector3[] outer, List<Polygon> inners)
        {
            List<XMaxData> pairs = new List<XMaxData>();

            // 内側多角形の中で最もX座標が大きい頂点を持つものを探す
            for (int i = 0; i < inners.Count; i++)
            {
                float xmax = inners[i].vertices[0].x;
                int len = inners[i].vertices.Length;
                int xmaxIndex = 0;
                for (int j = 1; j < len; j++)
                {
                    float x = inners[i].vertices[j].x;
                    if(x > xmax)
                    {
                        xmax = x;
                        xmaxIndex = j;
                        Debug.Log("[" + j + "] xmax " + xmax + " xmaxIndex " + xmaxIndex);
                    }
                }
                pairs.Add(new XMaxData(xmax, i, xmaxIndex));
            }

            // 右順(xmaxが大きい順)にソート
            pairs.Sort((a, b) => Mathf.FloorToInt(b.xmax - a.xmax));

            // 右から順に結合
            for (int i = 0; i < pairs.Count; i++)
            {
#if UNITY_EDITOR
                Debug.Log("Combine Outer and Inner [" + i + "] {" + pairs[i].no + "} " + pairs[i].xmax + " " + pairs[i].index + " %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
#endif

                outer = CombinePolygon(outer, inners[pairs[i].no], pairs[i].index);
            }

            return outer;
        }

        /// <summary>
        /// 内外多角形の結合
        /// </summary>
        /// <param name="outer"></param>
        /// <param name="inner"></param>
        /// <param name="xmaxIndex"></param>
        /// <returns></returns>
        Vector3[] CombinePolygon(Vector3[] outer, Polygon inner, int xmaxIndex)
        {
            Vector3 M = inner.vertices[xmaxIndex];
            
            // 交点を探す
            Vector3 intersectionPoint = Vector3.zero;
            int index0 = 0;
            int index1 = 0;

            if (GeomUtil.GetIntersectionPoint(M, new Vector3(maxX + 0.1f, M.y, M.z), outer, ref intersectionPoint, ref index0, ref index1))
            {
                // 交点発見

                // 交差した線分の一番右の頂点を取得
                int pindex;
                Vector3[] triangle = new Vector3[3];
                if (outer[index0].x > outer[index1].x)
                {
                    pindex = index0;
                    // 選択した線分の頂点によって三角形が逆向きになってしまうので、時計回りになるように調整する
                    triangle[0] = M;
                    triangle[1] = outer[pindex];
                    triangle[2] = intersectionPoint;
                }
                else
                {
                    pindex = index1;
                    triangle[0] = M;
                    triangle[1] = intersectionPoint;
                    triangle[2] = outer[pindex];
                }

                Vector3 P = outer[pindex];

#if UNITY_EDITOR
                //Debug.Log("intersectionPoint " + intersectionPoint + " M " + M + " P " + P + " index0 " + index0 + " index1 " + index1 + " pindex " + pindex);
#endif

                int finalIndex = pindex;

                // 交点とPが同じだったら遮るものがないので三角形チェックしない
                if((Vector3.Distance(intersectionPoint, P) > float.Epsilon))
                {
                    float angleMin = 361f;

                    for(int i = 0; i < outer.Length; i++)
                    {

                        // 凸頂点/反射頂点チェック
                        int prevIndex = (i == 0) ? outer.Length - 1 : i - 1; // 一つ前の頂点
                        int nextIndex = (i + 1) % outer.Length;        // 次の頂点
                        int nowIndex = i;

                        if (nowIndex == pindex) continue;

                        Vector3 outerP = outer[nowIndex];
                        //Debug.Log("[" + i + "] index " + index + " : " + outerP + " convex " + outer.convexFlags[index]);

                        if (outerP.x < M.x) continue;

                        // 分割時に複製した同一座標だったら無視
                        if (Vector3.Distance(outerP, P) <= float.Epsilon) continue;

                        Vector3 prevVertex = outer[prevIndex];
                        Vector3 nextVertex = outer[nextIndex];
                        Vector3 nowVertex = outer[nowIndex];

                        // 反射頂点か？
                        bool isReflex = !GeomUtil.IsAngleLessPI(nowVertex, prevVertex, nextVertex);

                        // 三角形の中に「反射頂点」が含まれているか？
                        if ((GeomUtil.IsInTriangle(outerP, triangle[0], triangle[1], triangle[2]) <= 0)&&(isReflex))
                        {
                            // 三角形の中に頂点が含まれてるので不可視

                            // M,IとM,outerPの線分のなす角度を求める（一番角度が浅い頂点を選択する）
                            float angle = Vector3.Angle(intersectionPoint - M, outerP - M);
                            if (angle < angleMin)
                            {
                                angleMin = angle;
                                finalIndex = nowIndex;
                                //Debug.Log("finalIndex " + finalIndex + " angle " + angle);
                            }
                        }
                    }
                }

                Vector3 FinalP = outer[finalIndex];

                //Debug.Log("finalIndex " + finalIndex + " FinalP " + FinalP);

                // 結合（新しい多角形を作成）
                List<Vector3> newOuterVertices = new List<Vector3>();
#if UNITY_EDITOR
                List<int> newOuterIndices = new List<int>();
                int newIndex = 0;
#endif

                // outerを分割するIndexまで追加
                for (int i = 0; i <= finalIndex; i++)
                {
                    newOuterVertices.Add(outer[i]);
#if UNITY_EDITOR
                    newOuterIndices.Add(newIndex++);
#endif
                }

                // innerをすべて追加
                for (int i = xmaxIndex; i < inner.vertices.Length; i++)
                {
                    newOuterVertices.Add(inner.vertices[i]);
#if UNITY_EDITOR
                    newOuterIndices.Add(newIndex++);
#endif
                }
                for (int i = 0; i < xmaxIndex; i++)
                {
                    newOuterVertices.Add(inner.vertices[i]);
#if UNITY_EDITOR
                    newOuterIndices.Add(newIndex++);
#endif
                }
                
                // 分割するために頂点を2つ増やす
                newOuterVertices.Add(M);
                newOuterVertices.Add(FinalP);
#if UNITY_EDITOR
                newOuterIndices.Add(newIndex++);
                newOuterIndices.Add(newIndex++);
#endif

                // 残りのouterのindexを追加
                for (int i = finalIndex + 1; i < outer.Length; i++)
                {
                    newOuterVertices.Add(outer[i]);
#if UNITY_EDITOR
                    newOuterIndices.Add(newIndex++);
#endif
                }

                outer = newOuterVertices.ToArray();

#if UNITY_EDITOR
                // DumpでIndex配列の確認
                DumpArray(outer, "NewOuter Vertices");
                DumpList(newOuterIndices, "NewOuter Indices");
#endif
            }

            return outer; 
            
        }

        /// <summary>
        /// 耳を削っていく
        /// </summary>
        void EarClipping()
        {
            int triangleIndex = 0;

            while (earTipList.Count > 0)
            {
                int nowIndex = earTipList[0];   // 先頭取り出し

                LinkedListNode<int> indexNode = indices.Find(nowIndex);
                if (indexNode != null)
                {
                    int prevIndex = (indexNode.Previous == null) ? indices.Last.Value : indexNode.Previous.Value; // 一つ前の頂点
                    int nextIndex = (indexNode.Next == null) ? indices.First.Value : indexNode.Next.Value;        // 次の頂点

                    Vector3 prevVertex = vertices[prevIndex];
                    Vector3 nextVertex = vertices[nextIndex];
                    Vector3 nowVertex = vertices[nowIndex];

                    // 三角形作成
                    triangles.Add(new Triangle(prevVertex, nowVertex, nextVertex, "(" + triangleIndex + ")"));
#if UNITY_EDITOR
                    Debug.Log("triangle[" + triangleIndex + "](" + prevIndex + ", " + nowIndex + ", " + nextIndex + ")");
#endif
                    resultTriangulation.Add(resultTriangulationOffset + prevIndex);
                    resultTriangulation.Add(resultTriangulationOffset + nowIndex);
                    resultTriangulation.Add(resultTriangulationOffset + nextIndex);

                    triangleIndex++;

                    if (indices.Count == 3)
                    {
                        // 最後の三角形なので終了
                        break;
                    }

                    // 耳の頂点削除
                    earTipList.RemoveAt(0);     // 先頭削除
                    indices.Remove(nowIndex);

                    // 前後の頂点のチェック
                    int[] bothlist = { prevIndex, nextIndex };
                    for (int i = 0; i < bothlist.Length; i++)
                    {
                        LinkedListNode<int> node = indices.Find(bothlist[i]);
                        CheckVertex(node);
                    }
                }
                else
                {
                    Debug.LogError("index now found");
                    break;
                }
            }

            // UV計算
            for (int i = 0; i < vertices.Count; i++)
            {
                Vector2 uv2 = CalcUV(vertices[i], uvRect);
                resultUVs.Add(uv2);
            }

#if UNITY_EDITOR
            DumpList(resultVertices, "Vertices");
            DumpList(resultTriangulation, "Indices");
            DumpList(resultUVs, "UVs");
#endif
        }

        /// <summary>
        /// メッシュ作成
        /// </summary>
        void MakeMesh()
        {
            mesh = new Mesh();
            mesh.vertices = resultVertices.ToArray();
            mesh.SetIndices(resultTriangulation.ToArray(), MeshTopology.Triangles, 0);
            mesh.RecalculateNormals();
            mesh.SetUVs(0, resultUVs);

            mesh.RecalculateBounds();

            MeshFilter filter = GetComponent<MeshFilter>();
            if(filter != null)
            {
                filter.mesh = mesh;
            }
        }

        /// <summary>
        /// UV計算
        /// </summary>
        /// <param name="vertex"></param>
        /// <param name="rect">x:leftX, y:bottomY</param>
        /// <returns></returns>
        Vector2 CalcUV(Vector3 vertex, Rect uvRect)
        {
            float u = (vertex.x - uvRect.x) / uvRect.width;
            float v = (vertex.y - uvRect.y) / uvRect.height;
            //Debug.Log("UV " + vertex + " -> (" + u + ", " + v + ")");

            return new Vector2(u, v);
        }

#if UNITY_EDITOR
        void DumpArray(bool[] array, string name)
        {
            StringBuilder sb = new StringBuilder(name + " Count " + array.Length + " : ");
            foreach (var i in array)
            {
                sb.Append(i + ", ");
            }
            Debug.Log(sb);
        }

        void DumpArray(int[] array, string name)
        {
            StringBuilder sb = new StringBuilder(name + " Count " + array.Length + " : ");
            foreach (var i in array)
            {
                sb.Append(i + ", ");
            }
            Debug.Log(sb);
        }

        void DumpArray(Vector3[] array, string name)
        {
            StringBuilder sb = new StringBuilder(name + " Count " + array.Length + " : ");
            foreach (var i in array)
            {
                sb.Append(i + ", ");
            }
            Debug.Log(sb);
        }

        void DumpList(List<int> list, string name)
        {
            StringBuilder sb = new StringBuilder(name + " Count " + list.Count + " : ");
            foreach (var i in list)
            {
                sb.Append(i + ", ");
            }
            Debug.Log(sb);
        }

        void DumpList(List<bool> list, string name)
        {
            StringBuilder sb = new StringBuilder(name + " Count " + list.Count + " : ");
            foreach (var i in list)
            {
                sb.Append(i + ", ");
            }
            Debug.Log(sb);
        }

        void DumpList(LinkedList<int> list, string name)
        {
            StringBuilder sb = new StringBuilder(name + " Count " + list.Count + " : ");
            foreach (var i in list)
            {
                sb.Append(i + ", ");
            }
            Debug.Log(sb);
        }

        void DumpList(List<Vector3> list, string name)
        {
            StringBuilder sb = new StringBuilder(name + " Count " + list.Count + " : ");
            foreach (var i in list)
            {
                sb.Append(i + ", ");
            }
            Debug.Log(sb);
        }

        void DumpList(List<Vector2> list, string name)
        {
            StringBuilder sb = new StringBuilder(name + " Count " + list.Count + " : ");
            foreach (var i in list)
            {
                sb.Append(i + ", ");
            }
            Debug.Log(sb);
        }
        
        void DumpNode(TreeNode<Polygon> tree, int lv)
        {
            if (tree.isValue)
            {
                Debug.Log(lv + ":" + tree.isValue + " " + tree.Value.vertices.Length);
            }
            else
            {
                Debug.Log(lv + ":" + tree.isValue);
            }

            for (int i = 0; i < tree.children.Count; i++)
            {
                DumpNode(tree.children[i], lv + 1);
            }
        }
#endif

        /// <summary>
        /// 凸頂点か？
        /// </summary>
        /// <param name="node"></param>
        /// <returns></returns>
        protected bool IsConvex(LinkedListNode<int> node)
        {
            // 凸頂点/反射頂点チェック
            int prevIndex = (node.Previous == null) ? indices.Last.Value : node.Previous.Value; // 一つ前の頂点
            int nextIndex = (node.Next == null) ? indices.First.Value : node.Next.Value;        // 次の頂点
            int nowIndex = node.Value;

            Vector3 prevVertex = vertices[prevIndex];
            Vector3 nextVertex = vertices[nextIndex];
            Vector3 nowVertex = vertices[nowIndex];


            // 内角が180度以内か？
            return GeomUtil.IsAngleLessPI(nowVertex, prevVertex, nextVertex);
        }

        private void OnDrawGizmos()
        {
            if (Application.isPlaying)
            {

#if UNITY_EDITOR
                Gizmos.color = Color.green;

                LinkedListNode<int> node = debugIndices.First;
                Vector3 depth = Vector3.zero;
                while(node != null)
                {
                    int index = node.Value;
                    int next = node.Next == null ? debugIndices.First.Value : node.Next.Value;

                    Gizmos.DrawLine(debugVertices[index], debugVertices[next]);
#if UNITY_EDITOR
                    UnityEditor.Handles.Label(debugVertices[index] + depth, "[" + index + "]");
                    depth.z += 0.1f;
#endif
                    node = node.Next;
                }
#endif
            }

            if (isDrawTriangle)
            {
                foreach (var triangle in triangles)
                {
                    triangle.OnDrawGizmos();
                }
            }
        }
    }
}