using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace KleinianGroup
{
    [ExecuteAlways]
    public class SaveRenderTextureToFile : MonoBehaviour
    {
        public KleinianGroupToRenderTexture kg;

        public string DirectoryPath = "";
        public string AssetFilePath = "test";

        public int Index = 0;
        public bool AutoIncrementIndex = true;

        public bool Save = false;

        void Update()
        {
            //if (Input.GetKeyUp("s"))
            if (Save)
            {
                SaveToRTToFile();
                Save = false;
            }
        }

        void SaveToRTToFile()
        {   
            if (kg == null)
                return;

            if (kg.texture == null)
                return;

            RenderTexture.active = kg.texture;
            Texture2D tex = new Texture2D(kg.texture.width, kg.texture.height, TextureFormat.RGBAFloat, false);
            tex.ReadPixels(new Rect(0, 0, kg.texture.width, kg.texture.height), 0, 0);
            RenderTexture.active = null;

            byte[] bytes;
            bytes = tex.EncodeToPNG();

            //string path = Application.dataPath + "/" + AssetFilePath + "_" + Index.ToString("000") + ".png";
            string path = DirectoryPath + "/" + AssetFilePath + "_" + Index.ToString("000") + ".png";
            System.IO.File.WriteAllBytes(path, bytes);

            if (AutoIncrementIndex)
            {
                Index++;
            }

        }
    }
}