using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AutoInstancedDemo : MonoBehaviour
{
    public bool useExsistence;
    public GameObject exsistence;

    [Space(5)]
    public int population = 100;
    public float range = 10;
    public GameObject source;

    private MaterialPropertyBlock block;

    private void Start()
    {
        if (source == null)
            return;

        block = new MaterialPropertyBlock();

        if (useExsistence) //使用场景里已经存在的GameObject或者使用预制体实例化
        {
            exsistence.SetActive(true);
            foreach (Transform instance in exsistence.transform)
            {
                var color = Color.Lerp(Color.red, Color.blue, Random.value);
                block.SetColor("_Color", color);
                instance.GetComponent<MeshRenderer>().SetPropertyBlock(block);
            }
        }
        else
        {
            for (int i = 0; i < population; i++)
            {
                Vector3 position = new Vector3(Random.Range(-range, range), Random.Range(-range, range), Random.Range(-range, range));
                Quaternion rotation = Quaternion.Euler(Random.Range(-180, 180), Random.Range(-180, 180), Random.Range(-180, 180));

                var instance = GameObject.Instantiate(source).transform;
                instance.position = position;
                instance.rotation = rotation;


                var color = Color.Lerp(Color.red, Color.blue, Random.value);
                block.SetColor("_Color", color);
                instance.GetComponent<MeshRenderer>().SetPropertyBlock(block);
            }
        }
    }
}
