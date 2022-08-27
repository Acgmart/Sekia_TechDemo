using UnityEngine;
using UnityEditor;

namespace Sekia
{
    [CustomEditor(typeof(AlignToGround))]
    public class AlignToGroundEditor : Editor
    {
        public override void OnInspectorGUI()
        {
            AlignToGround script = (AlignToGround)target;
            if (GUILayout.Button("Align"))
            {
                script.Align();
            }
        }
    }
}
