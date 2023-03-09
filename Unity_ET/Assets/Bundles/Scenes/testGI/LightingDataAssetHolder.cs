using UnityEngine;
using UnityEngine.SceneManagement;

public class LightingDataAssetHolder : MonoBehaviour
{
    void Start()
    {
        // Additively load a Scene containing light probes
        SceneManager.LoadScene("testWithGI", LoadSceneMode.Additive);

        // Force Unity to synchronously regenerate the tetrahedral tesselation for all loaded Scenes
        LightProbes.Tetrahedralize();
    }
}
