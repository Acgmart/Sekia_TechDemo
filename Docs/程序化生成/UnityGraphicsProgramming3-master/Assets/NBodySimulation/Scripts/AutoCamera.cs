using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Kodai
{

    public class AutoCamera : MonoBehaviour
    {

        [SerializeField] Transform target;
        [SerializeField] float radius = 40;
        [SerializeField] float speed = 1f;

        float time;

        // Use this for initialization
        void Start()
        {
            time = 0;
        }

        // Update is called once per frame
        void Update()
        {

            time += Time.deltaTime * speed;

            if (target != null)
            {
                transform.SetPositionAndRotation(new Vector3(radius * Mathf.Cos(time), radius * Mathf.Sin(time * 0.5f), radius * Mathf.Sin(time)), Quaternion.identity);
                transform.LookAt(target);
            }

        }
    }

}