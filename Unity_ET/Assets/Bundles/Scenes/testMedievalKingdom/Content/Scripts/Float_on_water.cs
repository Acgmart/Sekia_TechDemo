using System.Collections;
using System.Collections.Generic;
using UnityEngine;

//[ExecuteInEditMode]
public class Float_on_water : MonoBehaviour {
    
    [HeaderAttribute("Settings")]
    [Tooltip("Buoyancy speed")]
    [Range(0.001f, 10f)]
    public float Speed=1;
    [Tooltip("Buoyancy range")]
    [Range(1f, 10f)]
    public float Range=1;

    List<Transform> Floating_objects = new List<Transform>();
    List<float> Randoms = new List<float>();

    void Start () {  
        foreach (Transform t in transform)
        {
            Floating_objects.Add(t);
            Randoms.Add(Random.Range(0, 90));
        }
        Debug.Log(Floating_objects.Count);
      }
	
	void Update () {
        for (int i=0;i<Floating_objects.Count;i++) Floating_objects[i].Translate(Vector3.up * Mathf.Sin(Speed * Time.time + Randoms[i]) / 5000 * Range, Space.World);
     }
}
