using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace EarClippingTriangulation
{
    public class TreeNode<T>
    {
        public TreeNode<T> parent = null;
        public List<TreeNode<T>> children = new List<TreeNode<T>>();

        public T Value;
        public bool isValue = false;

        public TreeNode(T val)
        {
            Value = val;
            isValue = true;
        }

        public TreeNode()
        {
            isValue = false;
        }

        public void AddChild(T val)
        {
            AddChild(new TreeNode<T>(val));
        }

        public void AddChild(TreeNode<T> tree)
        {
            children.Add(tree);
            tree.parent = this;
        }

        public void RemoveChild(TreeNode<T> tree)
        {
            if (children.Contains(tree))
            {
                children.Remove(tree);
                tree.parent = null;
            }
        }
    }
}