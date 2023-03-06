using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace ScreenSpaceFluidRendering
{
    public class SPHFluidSimulationGravityController : MonoBehaviour
    {
        [SerializeField]
        SPHFluidSimulation _simScript;

        public float NoiseSpeed = 0.1f;

        void Update()
        {
            _simScript.Gravity.x       = -1.0f + 2.0f * Mathf.PerlinNoise(0.0f, Time.time * NoiseSpeed);
            _simScript.Gravity.y       = -1.0f + 2.0f * Mathf.PerlinNoise(1.0f, Time.time * NoiseSpeed);
            _simScript.Gravity.z       = -1.0f + 2.0f * Mathf.PerlinNoise(2.0f, Time.time * NoiseSpeed);
            _simScript.GravityToCenter = 3.0f * (-1.0f + 2.0f * Mathf.PerlinNoise(3.0f, Time.time * NoiseSpeed));
        }
    }
}