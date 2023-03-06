using UnityEngine;
using System.Collections;
using System.IO;

public class ScreenRecorder : MonoBehaviour
{
    public string DirectoryPath = "";
    public string SceneName = "";
    public string TakeName = "";

    public int framerate = 30;
    public int startFrame = 0;
    public int endFrame = 1000;
    public int skipFrame = 4;
    private int recordedFrameCount = 0;
    //public int  superSize;
    public bool autoRecord;

    [SerializeField]
    int frameCount;
    [SerializeField]
    bool recording;

    string directoryPath = "";

    void Awake()
    {
        Application.targetFrameRate = 30;
        QualitySettings.vSyncCount = 0;
    }

    void Start()
    {

        directoryPath = string.IsNullOrEmpty(SceneName) ? DirectoryPath : DirectoryPath + "\\" + SceneName;
        directoryPath = string.IsNullOrEmpty(TakeName) ? directoryPath : directoryPath + "\\" + TakeName;

        // LoadSetting
        LoadSetting();

        if (autoRecord) StartRecording();

    }

    void LoadSetting()
    {

        string text = "";

        try
        {

            string path = Application.streamingAssetsPath + "/screenRecorderSetting.txt";
            //string path = Path;

            using (System.IO.StreamReader sr = new System.IO.StreamReader(path, System.Text.Encoding.GetEncoding("UTF-8")))
            {
                int count = 0;
                while (sr.EndOfStream == false)
                {
                    //string line = sr.ReadLine();
                    if (count == 0)
                    {
                        enabled = bool.Parse(sr.ReadLine());
                    }
                    if (count == 1)
                    {
                        framerate = int.Parse(sr.ReadLine());
                    }
                    if (count == 2)
                    {
                        startFrame = int.Parse(sr.ReadLine());
                    }
                    if (count == 3)
                    {
                        endFrame = int.Parse(sr.ReadLine());
                    }
                    count++;
                }
                sr.Close();
            }

        }
        catch (System.Exception e)
        {
            Debug.Log(e.ToString());
        }

        Debug.Log(text);

    }

    void StartRecording()
    {
        //System.IO.Directory.CreateDirectory(Path + "/Capture");
        System.IO.Directory.CreateDirectory(directoryPath);
        Time.captureFramerate = framerate;
        //frameCount = -1;
        recording = true;
    }

    IEnumerator Capture(string filePath)
    {
        yield return new WaitForEndOfFrame();

        int width = Screen.width;
        int height = Screen.height;
        Texture2D tex = new Texture2D(width, height, TextureFormat.ARGB32, false);
        // Read screen contents into the texture
        tex.ReadPixels(new Rect(0, 0, width, height), 0, 0);
        tex.Apply();

        // Encode texture into PNG
        byte[] bytes = tex.EncodeToPNG();
        Destroy(tex);

        // For testing purposes, also write to a file in the project folder
        File.WriteAllBytes(directoryPath + "/" + filePath, bytes);
    }

    void Update()
    {

        if (!recording)
        {
            frameCount = Mathf.FloorToInt(Time.time * framerate);
            if (frameCount >= startFrame)
            {
                StartRecording();
                recording = true;
                enabled = true;
            }
        }

        if (frameCount >= endFrame)
        {
            recording = false;
            enabled = false;
        }

        

        if (recording)
        {
            if (Input.GetMouseButtonDown(0))
            {
                recording = false;
                enabled = false;
            }
            else
            {
                if (frameCount > 0)
                {
                    if (frameCount % skipFrame == 0)
                    {
                        var name = "frame" + recordedFrameCount.ToString("0000") + ".png";
                        StartCoroutine(Capture(name));
                        recordedFrameCount++;
                    }
                }

                frameCount++;

                if (recordedFrameCount > 0 && recordedFrameCount % framerate == 0)
                {
                    Debug.Log((recordedFrameCount / framerate).ToString() + " seconds elapsed.");
                }
            }
        }
    }

    void OnGUI()
    {
        if (!recording && GUI.Button(new Rect(0, 0, 200, 50), "Start Recording"))
        {
            StartRecording();
            Debug.Log("Click Game View to stop recording.");
        }
    }
}