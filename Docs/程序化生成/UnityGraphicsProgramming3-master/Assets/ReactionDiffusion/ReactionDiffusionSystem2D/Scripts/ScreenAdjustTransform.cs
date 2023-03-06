using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ScreenAdjustTransform : MonoBehaviour
{

    public Camera targetCamera = null;
    public bool isEveryUpdate = false;

    void AdjustScreen()
    {
        Camera cam = (targetCamera != null) ? targetCamera : Camera.main;

        if (cam == null)
        {
            return;
        }

        float height = cam.orthographicSize * 2;
        float width = height * cam.aspect;

        transform.localScale = new Vector3(width, height, 1);
    }

    // Use this for initialization
    void Start()
    {
        AdjustScreen();
    }

    void Update()
    {
        if (isEveryUpdate)
        {
            AdjustScreen();
        }
    }
}
