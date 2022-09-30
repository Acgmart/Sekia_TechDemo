using UnityEngine;

namespace Sekia
{
    public class SceneObject : MonoBehaviour
    {
        public string _BundleName; //有指定的bundle标签
        public string _UnityPath;
        public Bounds _Bounds;
        public int[] _LightmapIndexArray = new int[0];
        public Vector4[] _LightmapScaleOffsetArray = new Vector4[0];
        public float[] _ScaleInLightmapArray = new float[0];
        public bool[] _CastShadow = new bool[0];
    }
}
