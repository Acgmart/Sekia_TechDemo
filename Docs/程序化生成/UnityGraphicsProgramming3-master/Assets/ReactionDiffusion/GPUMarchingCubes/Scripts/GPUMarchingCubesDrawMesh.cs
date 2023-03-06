using UnityEngine;

public class GPUMarchingCubesDrawMesh : MonoBehaviour {
    
    #region public
    public int Width = 32;
    public int height = 32;
    public int depth = 32;
    public float renderScale = 1f;
    [Range(0,10)]
    public float sampleScale = 0.5f;
    [Range(0,1)]
    public float threashold = 0.5f;
    public Material mat;

    public Color DiffuseColor = Color.green;
    public Color EmissionColor = Color.black;
    public float EmissionIntensity = 0;

    [Range(0,1)]
    public float metallic = 0;
    [Range(0, 1)]
    public float glossiness = 0.5f;
    [Range(0, 1)]
    public float occlusion = 1f;

    public ReactionDiffusion3D reactionDiffuse;
    #endregion

    #region private
    int vertexMax = 0;
    Mesh[] meshs = null;
    Material[] materials = null;    
    #endregion

    void Initialize()
    {
        vertexMax = Width * height * depth;
        
        Debug.Log("VertexMax " + vertexMax);

        CreateMesh();
    }

    void CreateMesh()
    {
        int vertNum = vertexMax;
        int meshNum = 1;
        Debug.Log("meshNum " + meshNum );

        meshs = new Mesh[meshNum];
        materials = new Material[meshNum];

        Bounds bounds = new Bounds(transform.position, new Vector3(Width, height, depth) * renderScale);

        int id = 0;
        for (int i = 0; i < meshNum; i++)
        {
            Vector3[] vertices = new Vector3[vertNum];
            int[] indices = new int[vertNum];
            for(int j = 0; j < vertNum; j++)
            {
                vertices[j].x = (float)(id % Width);
                vertices[j].y = (float)((id / Width) % height);
                vertices[j].z = (float)((id / (Width * height)) % depth);

                indices[j] = j;
                id++;
            }

            meshs[i] = new Mesh();
            meshs[i].indexFormat = UnityEngine.Rendering.IndexFormat.UInt32;
            meshs[i].vertices = vertices;
            meshs[i].SetIndices(indices, MeshTopology.Points, 0);
            meshs[i].bounds = bounds;

            materials[i] = new Material(mat);
        }
    }

    void RenderMesh()
    {
        Vector3 halfSize = new Vector3(Width, height, depth) * renderScale * 0.5f;
        Matrix4x4 trs = Matrix4x4.TRS(transform.position, transform.rotation, transform.localScale);
        for (int i = 0; i < meshs.Length; i++)
        {
            materials[i].SetPass(0);
            materials[i].SetInt("_Width", Width);
            materials[i].SetInt("_Height", height);
            materials[i].SetInt("_Depth", depth);
            materials[i].SetFloat("_Scale", renderScale);
            materials[i].SetFloat("_SampleScale", sampleScale);
            materials[i].SetFloat("_Threashold", threashold);
            materials[i].SetFloat("_Metallic", metallic);
            materials[i].SetFloat("_Glossiness", glossiness);
            materials[i].SetFloat("_EmissionIntensity", EmissionIntensity);
            materials[i].SetFloat("_Occlusion", occlusion);
            
            materials[i].SetVector("_HalfSize", halfSize);
            materials[i].SetColor("_DiffuseColor", DiffuseColor);
            materials[i].SetColor("_EmissionColor", EmissionColor);
            materials[i].SetMatrix("_Matrix", trs);
            materials[i].SetTexture("_MainTex", reactionDiffuse.heightMapTexture);
            Graphics.DrawMesh(meshs[i], Matrix4x4.identity, materials[i], 0);
        }
    }

    // Use this for initialization
    void Start () {
        Initialize();
    }

    void Update()
    {
        RenderMesh();
    }
}
