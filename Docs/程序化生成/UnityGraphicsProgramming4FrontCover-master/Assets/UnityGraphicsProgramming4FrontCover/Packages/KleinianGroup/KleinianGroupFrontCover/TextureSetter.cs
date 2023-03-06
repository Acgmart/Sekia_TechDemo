using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace KleinianGroup
{
    [ExecuteAlways]
    public class TextureSetter : MonoBehaviour
    {
        public KleinianGroupToRenderTexture kg;

        bool _bSet = false;

        private void Update()
        {
            if (_bSet == false)
            {
                if (GetComponent<Renderer>() != null)
                {
                    var renderer = GetComponent<Renderer>();
                    renderer.sharedMaterial.mainTexture = kg.texture;
                    _bSet = true;
                }
            }
        }
    }
}