using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.IO;

[ExecuteInEditMode]
public class Reflection_pass : MonoBehaviour {
    [HeaderAttribute("Water reflection settings")]
    [Range(0.001f, 3f)]
    public float clipPlaneOffset = 0.07f;
    [Range(0, 4096f)]
    public int textureSize = 256;
    public bool activated = true;
    [HeaderAttribute("Occlusion culling (turning of is performance expensive)")]
    public bool Culling = true;
    //[Range(1f, 100000f)]
    public float Distance = 50;
    private Dictionary<Camera, Camera> m_ReflectionCameras = new Dictionary<Camera, Camera>();
    private RenderTexture m_ReflectionTexture;
    Texture2D tex;
    private int m_OldReflectionTextureSize;
    private int m_OldRefractionTextureSize;
    private static bool s_InsideWater;
    public LayerMask reflectLayers = -1;
    //public LayerMask refractLayers = -1;

    // Use this for initialization
    void Start()
    {
        
        // SetTexture(@"C:\Users\Wookie\Pictures\texs\mona.jpg");
    }

    public void OnWillRenderObject()
    {
        if (activated)
        {
            Camera cam = Camera.current;
            if (!cam)
            {
                return;
            }

            // Safeguard from recursive water reflections.
            if (s_InsideWater)
            {
                return;
            }
            s_InsideWater = true;

            Camera reflectionCamera, refractionCamera;
            
            CreateWaterObjects(cam, out reflectionCamera, out refractionCamera);
            Vector3 pos = transform.position;
            Vector3 normal = transform.up;




            UpdateCameraModes(cam, reflectionCamera);
            UpdateCameraModes(cam, refractionCamera);


            //render reflections
            float d = -Vector3.Dot(normal, pos) - clipPlaneOffset;
            Vector4 reflectionPlane = new Vector4(normal.x, normal.y, normal.z, d);

            Matrix4x4 reflection = Matrix4x4.zero;
            CalculateReflectionMatrix(ref reflection, reflectionPlane);
            Vector3 oldpos = cam.transform.position;
            Vector3 newpos = reflection.MultiplyPoint(oldpos);
            reflectionCamera.worldToCameraMatrix = cam.worldToCameraMatrix * reflection;

            // Setup oblique projection matrix so that near plane is our reflection
            // plane. This way we clip everything below/above it for free.
            Vector4 clipPlane = CameraSpacePlane(reflectionCamera, pos, normal, 1.0f);
            reflectionCamera.projectionMatrix = cam.CalculateObliqueMatrix(clipPlane);

            // Set custom culling matrix from the current camera
            if (Culling)
            {
                reflectionCamera.cullingMatrix = cam.projectionMatrix * cam.worldToCameraMatrix;
             }
            
            float[] distances = new float[32];
            for (int i = 0; i < distances.Length; i++)
            {
                distances[i] = Distance; //the culling distance
            }
            reflectionCamera.layerCullDistances = distances;
            reflectionCamera.layerCullSpherical = true;
            reflectionCamera.cullingMask = ~(1 << 4) & reflectLayers.value; // never render water layer
            reflectionCamera.targetTexture = m_ReflectionTexture;
            bool oldCulling = GL.invertCulling;
            GL.invertCulling = !oldCulling;
            reflectionCamera.transform.position = newpos;
            Vector3 euler = cam.transform.eulerAngles;
            reflectionCamera.transform.eulerAngles = new Vector3(-euler.x, euler.y, euler.z);
            reflectionCamera.Render();
            reflectionCamera.transform.position = oldpos;
            GL.invertCulling = oldCulling;
            GetComponent<Renderer>().sharedMaterial.SetTexture("_TextureSnap", m_ReflectionTexture);
            //end of reflections renderings



            /*
            tex = LoadPNG(@"C:\Users\Wookie\Pictures\texs\mona.jpg");
            GetComponent<Renderer>().sharedMaterial.SetTexture("_TextureSnap", tex);
            */
            s_InsideWater = false;
        }
    }

        private void Update()
    {
        
            if (!GetComponent<Renderer>())
            {
                return;
            }
            Material mat = GetComponent<Renderer>().sharedMaterial;
            if (!mat)
            {
                return;
            }
        if (activated)
        {
            //Vector4 waveSpeed = mat.GetVector("WaveSpeed");
            // float waveScale = mat.GetFloat("_WaveScale");
            Vector4 waveSpeed = new Vector4(0, 0, 0, 0);
            float waveScale = 0.1f;
            Vector4 waveScale4 = new Vector4(waveScale, waveScale, waveScale * 0.4f, waveScale * 0.45f);

            // Time since level load, and do intermediate calculations with doubles
            double t = Time.timeSinceLevelLoad / 20.0;
            Vector4 offsetClamped = new Vector4(
                (float)System.Math.IEEERemainder(waveSpeed.x * waveScale4.x * t, 1.0),
                (float)System.Math.IEEERemainder(waveSpeed.y * waveScale4.y * t, 1.0),
                (float)System.Math.IEEERemainder(waveSpeed.z * waveScale4.z * t, 1.0),
                (float)System.Math.IEEERemainder(waveSpeed.w * waveScale4.w * t, 1.0)
                );

            mat.SetVector("_WaveOffset", offsetClamped);
            mat.SetVector("_WaveScale4", waveScale4);
            mat.SetInt("_Activated", 1);
        }
        else
        {
            mat.SetInt("_Activated", 0);
        }
    }

    void SetTexture()
    {
        Material bmp = GetComponent<Renderer>().sharedMaterial;
        // Create new texture2d
        tex = LoadPNG(@"C:\Users\Wookie\Pictures\texs\mona.jpg");

        if (tex == null)
        {
            return;
        }

        // Set width/height scale/offset for UV's
        float twidth = 1.0f;
        float theight = 1.0f;
        float owidth = 0.0f;
        float oheight = 0.0f;
        if (tex.width >= tex.height)
        {
            theight = (float)tex.width / tex.height; // Tiling
            oheight = (theight - 1) / -2; // Offset
        }
        else
        {
            twidth = (float)tex.height / tex.width;
            owidth = (twidth - 1) / -2;
        }

        // Set texture
        bmp.SetTexture("_TextureSnap", tex);

        // Scale object UVs to fit texture
        bmp.SetTextureScale("_TextureSnap", new Vector2(twidth, theight));
        bmp.SetTextureOffset("_TextureSnap", new Vector2(owidth, oheight));
    }

    public static Texture2D LoadPNG(string filePath)
    {
        Texture2D tex = null;
        byte[] fileData;
        if (File.Exists(filePath))
        {
            fileData = File.ReadAllBytes(filePath);
            tex = new Texture2D(2, 2, TextureFormat.ARGB32, false);
            tex.filterMode = FilterMode.Point;
            tex.wrapMode = TextureWrapMode.Clamp;
            tex.LoadImage(fileData);
        }
        return tex;
    }

    static void CalculateReflectionMatrix(ref Matrix4x4 reflectionMat, Vector4 plane)
    {
        reflectionMat.m00 = (1F - 2F * plane[0] * plane[0]);
        reflectionMat.m01 = (-2F * plane[0] * plane[1]);
        reflectionMat.m02 = (-2F * plane[0] * plane[2]);
        reflectionMat.m03 = (-2F * plane[3] * plane[0]);

        reflectionMat.m10 = (-2F * plane[1] * plane[0]);
        reflectionMat.m11 = (1F - 2F * plane[1] * plane[1]);
        reflectionMat.m12 = (-2F * plane[1] * plane[2]);
        reflectionMat.m13 = (-2F * plane[3] * plane[1]);

        reflectionMat.m20 = (-2F * plane[2] * plane[0]);
        reflectionMat.m21 = (-2F * plane[2] * plane[1]);
        reflectionMat.m22 = (1F - 2F * plane[2] * plane[2]);
        reflectionMat.m23 = (-2F * plane[3] * plane[2]);

        reflectionMat.m30 = 0F;
        reflectionMat.m31 = 0F;
        reflectionMat.m32 = 0F;
        reflectionMat.m33 = 1F;
    }


    void CreateWaterObjects(Camera currentCamera, out Camera reflectionCamera, out Camera refractionCamera)
    {
        

        reflectionCamera = null;
        refractionCamera = null;

        
            // Reflection render texture
            if (!m_ReflectionTexture || m_OldReflectionTextureSize != textureSize)
            {
                if (m_ReflectionTexture)
                {
                    DestroyImmediate(m_ReflectionTexture);
                }
                m_ReflectionTexture = new RenderTexture(textureSize, textureSize, 16);
                m_ReflectionTexture.name = "__WaterReflection" + GetInstanceID();
                m_ReflectionTexture.isPowerOfTwo = true;
                m_ReflectionTexture.hideFlags = HideFlags.DontSave;
                m_OldReflectionTextureSize = textureSize;
            }

            // Camera for reflection
            m_ReflectionCameras.TryGetValue(currentCamera, out reflectionCamera);
            if (!reflectionCamera) // catch both not-in-dictionary and in-dictionary-but-deleted-GO
            {
                GameObject go = new GameObject("Water Refl Camera id" + GetInstanceID() + " for " + currentCamera.GetInstanceID(), typeof(Camera), typeof(Skybox));
                reflectionCamera = go.GetComponent<Camera>();
                reflectionCamera.enabled = false;
                reflectionCamera.transform.position = transform.position;
                reflectionCamera.transform.rotation = transform.rotation;
                reflectionCamera.gameObject.AddComponent<FlareLayer>();
                go.hideFlags = HideFlags.HideAndDontSave;
                m_ReflectionCameras[currentCamera] = reflectionCamera;
            }
        

      
    }
    Vector4 CameraSpacePlane(Camera cam, Vector3 pos, Vector3 normal, float sideSign)
    {
        Vector3 offsetPos = pos + normal * clipPlaneOffset;
        Matrix4x4 m = cam.worldToCameraMatrix;
        Vector3 cpos = m.MultiplyPoint(offsetPos);
        Vector3 cnormal = m.MultiplyVector(normal).normalized * sideSign;
        return new Vector4(cnormal.x, cnormal.y, cnormal.z, -Vector3.Dot(cpos, cnormal));
    }

    void UpdateCameraModes(Camera src, Camera dest)
    {
        if (dest == null)
        {
            return;
        }
        // set water camera to clear the same way as current camera
        dest.clearFlags = src.clearFlags;
        dest.backgroundColor = src.backgroundColor;
        if (src.clearFlags == CameraClearFlags.Skybox)
        {
            Skybox sky = src.GetComponent<Skybox>();
            Skybox mysky = dest.GetComponent<Skybox>();
            if (!sky || !sky.material)
            {
                mysky.enabled = false;
            }
            else
            {
                mysky.enabled = true;
                mysky.material = sky.material;
            }
        }
        // update other values to match current camera.
        // even if we are supplying custom camera&projection matrices,
        // some of values are used elsewhere (e.g. skybox uses far plane)
        dest.farClipPlane = src.farClipPlane;
        dest.nearClipPlane = src.nearClipPlane;
        dest.orthographic = src.orthographic;
        dest.fieldOfView = src.fieldOfView;
        dest.aspect = src.aspect;
        dest.orthographicSize = src.orthographicSize;
    }
}
