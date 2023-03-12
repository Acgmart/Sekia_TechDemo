using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DrawMeshInstancedDemo : MonoBehaviour
{
    public int population = 100;
    public float range = 10;
    public Material material;
    public Mesh mesh;

    private Matrix4x4[] matrices;
    private MaterialPropertyBlock block;

    private void Start()
    {
        matrices = new Matrix4x4[population];
        Vector4[] colors = new Vector4[population];

        block = new MaterialPropertyBlock();

        for (int i = 0; i < population; i++)
        {
            Vector3 position = new Vector3(Random.Range(-range, range), Random.Range(-range, range), Random.Range(-range, range));
            Quaternion rotation = Quaternion.Euler(Random.Range(-180, 180), Random.Range(-180, 180), Random.Range(-180, 180));
            Vector3 scale = Vector3.one;

            matrices[i] = Matrix4x4.TRS(position, rotation, scale);

            colors[i] = Color.Lerp(Color.red, Color.blue, Random.value);
        }

        // Custom shader needed to read these!!
        block.SetVectorArray("_Color", colors);
    }

    private void Update()
    {
        // Draw a bunch of meshes each frame.
        Graphics.DrawMeshInstanced(mesh, 0, material, matrices, population, block);
    }
}
