using System;
using System.Collections.Generic;
using UnityEngine;

namespace Sekia
{
    [DisallowMultipleComponent]
    [ExecuteInEditMode]
    [SelectionBaseAttribute]
    public class Bezier3D_Line : MonoBehaviour
    {
        public List<Bezier3D_Node> nodes = new List<Bezier3D_Node>();
        private static List<Bezier3D_Curve> curvesPool = new List<Bezier3D_Curve>(10);
        private static List<Bezier3D_Node> nodesPool = new List<Bezier3D_Node>(10);
        public Dictionary<Bezier3D_Node, Bezier3D_Curve> nodeAsN1toCurve = new Dictionary<Bezier3D_Node, Bezier3D_Curve>();
        private Dictionary<Bezier3D_Node, Bezier3D_Curve> nodeAsN2toCurve = new Dictionary<Bezier3D_Node, Bezier3D_Curve>();

        private void OnEnable()
        {
            RefreshCurves();
        }

        private void Reset()
        {
            nodes.Clear();
            AddNode(new Bezier3D_Node(new Vector3(5, 0, 0), new Vector3(5, 0, -3)));
            AddNode(new Bezier3D_Node(new Vector3(10, 0, 0), new Vector3(10, 0, 3)));
        }

        public static Bezier3D_Curve GetCurve()
        {
            if (curvesPool.Count != 0)
            {
                int index = curvesPool.Count - 1;
                Bezier3D_Curve curve = curvesPool[index];
                curvesPool.RemoveAt(index);
                return curve;
            }
            else
                return new Bezier3D_Curve();
        }

        //添加节点 在头部增加
        public void AddNode(Bezier3D_Node n2)
        {
            nodes.Add(n2);
            if (nodes.Count != 1)
            {
                Bezier3D_Node n1 = nodes[nodes.IndexOf(n2) - 1];
                Bezier3D_Curve curve = GetCurve();
                curve.Init(n1, n2);
                nodeAsN1toCurve[n1] = curve;
                nodeAsN2toCurve[n2] = curve;
            }
        }

        //添加节点 在中间插队
        public void InsertNode(int index, Bezier3D_Node node)
        {
            if (index < 1 || index > nodes.Count - 1)
                return;
            Bezier3D_Node n1 = nodes[index - 1];
            Bezier3D_Node n2 = nodes[index];
            nodes.Insert(index, node);
            Bezier3D_Curve curve1 = nodeAsN1toCurve[n1];
            Bezier3D_Curve curve2 = GetCurve();
            curve1.Init(n1, node);
            nodeAsN1toCurve[n1] = curve1;
            nodeAsN2toCurve[node] = curve1;
            curve2.Init(node, n2);
            nodeAsN1toCurve[node] = curve2;
            nodeAsN2toCurve[n2] = curve2;
        }

        //任意拆除一个节点 相邻的节点合并
        public void RemoveNode(Bezier3D_Node node)
        {
            if (nodes.Count <= 2) //最低2个节点
                return;

            if (nodeAsN2toCurve.ContainsKey(node))
            {
                Bezier3D_Curve curve = nodeAsN2toCurve[node];
                int index = nodes.IndexOf(node);
                Bezier3D_Node n1 = nodes[index - 1];
                if (index != nodes.Count - 1) //结合
                {
                    Bezier3D_Node n2 = nodes[index + 1];
                    curve.Init(n1, n2);
                    nodeAsN1toCurve[n1] = curve;
                    nodeAsN2toCurve[n2] = curve;
                }
                nodes.RemoveAt(index); //主要影响
            }

            if (nodeAsN1toCurve.ContainsKey(node))
            {
                Bezier3D_Curve curve = nodeAsN1toCurve[node];
                curve.n1 = null;
                curve.n2 = null;
                curvesPool.Add(curve);
                nodeAsN1toCurve.Remove(node);
            }

            nodesPool.Add(node);
        }

        public void RefreshCurves()
        {
            for (int i = 0; i < nodes.Count - 1; i++)
            {
                Bezier3D_Node n1 = nodes[i];
                Bezier3D_Node n2 = nodes[i + 1];
                Bezier3D_Curve curve = GetCurve();
                curve.Init(n1, n2);
                nodeAsN1toCurve[n1] = curve;
                nodeAsN2toCurve[n2] = curve;
            }
        }
    }
}
