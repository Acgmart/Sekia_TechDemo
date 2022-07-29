using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Sekia
{
    public class LayerBasedCulling : MonoBehaviour
    {
        public LayerMask SmallDetailsLayer;
        public float SmallDetailsDistance = 30.0f;

        public LayerMask MediumDetailsLayer;
        public float MediumDetailsDistance = 50.0f;

        int GetLayerNumber(int LayerValue)
        {
            int layerNumber = 0;
            int layer = LayerValue;
            while (layer > 0)
            {
                layer = layer >> 1;
                layerNumber++;
            }
            return (layerNumber - 1);
        }

        void OnEnable()
        {
            // Get layer numbers
            int smallLayerNumber = GetLayerNumber(SmallDetailsLayer.value);
            int mediumLayerNumber = GetLayerNumber(MediumDetailsLayer.value);

            for (int i = 0; i < Camera.allCameras.Length; i++)
            {
                float[] distances = Camera.allCameras[i].layerCullDistances;
                if (smallLayerNumber > 0)
                    distances[smallLayerNumber] = SmallDetailsDistance;         // small things like DetailDistance of the terrain engine
                if (mediumLayerNumber > 0)
                    distances[mediumLayerNumber] = MediumDetailsDistance;
                Camera.allCameras[i].layerCullDistances = distances;
            }
        }
    }
}
