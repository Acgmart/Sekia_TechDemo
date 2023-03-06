using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Rotate : MonoBehaviour {

    public float angleVel = 10f;
	
	// Update is called once per frame
	void Update () {
        transform.Rotate(Vector3.up, angleVel * Time.deltaTime, Space.World);
	}

    private void OnDrawGizmos()
    {
        Gizmos.DrawLine(transform.position, transform.position + Vector3.up * 10);
    }
}
