using UnityEngine;
using System.Collections;
using System.IO;

namespace IndieVisualLab.FrontCover2
{
    public class ScreenCapture : MonoBehaviour
    {

        [SerializeField] int _takeCount = 0;
        [SerializeField, Range(0, 4)] int superSize = 0;

        void Start()
        {
            _takeCount = 0;
        }

        void Update()
        {
            if (Input.GetKeyUp("s"))
            {
                ScreenShot();
            }
        }

        void ScreenShot()
        {
            var name = "take_" + _takeCount.ToString("0000") + ".png";
            UnityEngine.ScreenCapture.CaptureScreenshot(name, superSize);
            _takeCount++;
        }

    }

}

