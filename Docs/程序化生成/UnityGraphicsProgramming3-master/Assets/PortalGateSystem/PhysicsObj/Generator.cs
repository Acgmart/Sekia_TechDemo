using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;


namespace PortalGateSystem
{
    public class Generator : MonoBehaviour
    {
        public GameObject prefab;
        public float speed = 50f;
        public float offset = 1f;
        public KeyCode fireKey = KeyCode.Mouse0;


        private void Update()
        {
            if ( Input.GetKeyDown(fireKey) )
            {
                Fire();
            }
        }

        private void Fire()
        {
            var go = Instantiate(prefab);
            //go.transform.SetParent(transform);
            go.transform.position = transform.position + transform.forward * offset;

            var rb = go.GetComponent<Rigidbody>();
            rb.velocity = transform.forward * speed;
        }
    }
}