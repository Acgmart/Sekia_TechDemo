using System.Collections;
using System.Collections.Generic;

using UnityEngine;
using UnityEngine.UI;

namespace IndieVisualLab.FrontCover2
{

    public class CursorController : MonoBehaviour {

        [SerializeField] protected Transform cursor;
        [SerializeField] protected float distance = 30f;

        Camera cam;

        void Start () {
            cam = Camera.main;
        }
        
        void Update () {
            Cursor.visible = false;
            var input = Input.mousePosition;
            input.z = distance;
            cursor.transform.position = cam.ScreenToWorldPoint(input);
            cursor.transform.LookAt(cam.transform);
        }

    }

}


