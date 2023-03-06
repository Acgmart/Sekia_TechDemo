using UnityEngine;
using System.Collections;
using System.IO;

public class ScreenCapture : MonoBehaviour
{
    public string DirectoryPath = "";
    public string SubFolderName = ""; 

    [SerializeField]
    int _takeCount = 0;

    string directoryPath = "";

    void Start()
    {

        _takeCount = 0;

        directoryPath = string.IsNullOrEmpty(SubFolderName) ? DirectoryPath : DirectoryPath + "\\" + SubFolderName;
        
    }

    void Update()
    {
        if (Input.GetKeyUp("s"))
        {
            ScreenShot();
        }
    }

    void ScreenShot()
    {
        if (!System.IO.Directory.Exists(directoryPath))
        {
            System.IO.Directory.CreateDirectory(directoryPath);
        }

        var name = "take_" + _takeCount.ToString("0000") + ".png";
        StartCoroutine(Capture(name));

        _takeCount++;
    }

    IEnumerator Capture(string filePath)
    {
        yield return new WaitForEndOfFrame();

        int width  = Screen.width;
        int height = Screen.height;
        Texture2D tex = new Texture2D(width, height, TextureFormat.ARGB32, false);

        tex.ReadPixels(new Rect(0, 0, width, height), 0, 0);
        tex.Apply();

        byte[] bytes = tex.EncodeToPNG();
        Destroy(tex);

        File.WriteAllBytes(directoryPath + "/" + filePath, bytes);
    }
}