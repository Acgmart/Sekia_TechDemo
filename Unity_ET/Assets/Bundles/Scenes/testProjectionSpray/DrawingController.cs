using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DrawingController : MonoBehaviour
{
    public ProjectionSpray pinSpot;
    public Drawable drawable;
    public Color brushColor = Color.red;

    void Update()
    {
        if (Input.GetMouseButton(0))
        {
            var cam = Camera.main;
            var pos = Input.mousePosition;
            pos.z = 5f; //提供任意深度值
            pos = cam.ScreenToWorldPoint(pos); //射线与近平面的交点

            pinSpot.transform.position = cam.transform.position;
            pinSpot.transform.LookAt(pos); //调整Spot光源的坐标与朝向

            pinSpot.color = brushColor;
            pinSpot.UpdateDrawingMat(drawable); //调用Spot光源绘制事件
        }
    }
}
