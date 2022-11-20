using UnityEngine;
#if UNITY_EDITOR
using System;
using System.Collections.Generic;
using UnityEditor;
using System.IO;
using System.Collections;
using System.Runtime.Serialization.Formatters.Binary;

namespace Sekia
{
    public class MeshPainter : MonoBehaviour
    {
    }

    [CustomEditor(typeof(MeshPainter))]
    [CanEditMultipleObjects]
    public class MeshPainterStyle : Editor
    {
        private const string NEXT_VERSION_CACHE_PATH = "Library/MeshPainterCache_v0";
        private const string CACHE_PATH = "Library/MeshPainterCache_v0";
        public const string _Control = "_Control";
        public const string _Splat1 = "_Splat1";
        public const string _Splat2 = "_Splat2";
        public const string _Splat3 = "_Splat3";
        public const string _Splat4 = "_Splat4";
        public const string _Color1 = "_Color1";
        public const string _Color2 = "_Color2";
        public const string _Color3 = "_Color3";
        public const string _Color4 = "_Color4";
        private const string brushFolderGUID = "3a6dd75a22ce0974e832299f9a7799b7";
        private static string brushFolderPath = "";
        private MeshCollider collider;

        class userSettings
        {
            public float brushSize = 16f;
            public float brushStronger = 0.5f;
            public float brushScale = 1;
            public int layerIndex = 0;
            public int brushIndex = 0;
        }
        private static userSettings userSetting;
        private static void ReadFromCache()
        {
            string targetPath = CACHE_PATH;
            bool needUpdate = false;
            if (File.Exists(NEXT_VERSION_CACHE_PATH))
            {
                targetPath = NEXT_VERSION_CACHE_PATH;
                needUpdate = true;
            }

            userSetting = new userSettings();
            if (!File.Exists(targetPath))
                return;

            //反序列化数据
            FileStream fs = File.OpenRead(targetPath);
            try
            {
                if (needUpdate) { }
                BinaryFormatter bf = new BinaryFormatter();
                userSetting.brushSize = (float)bf.Deserialize(fs);
                userSetting.brushStronger = (float)bf.Deserialize(fs);
                userSetting.brushScale = (float)bf.Deserialize(fs);
                userSetting.layerIndex = (int)bf.Deserialize(fs);
                userSetting.brushIndex = (int)bf.Deserialize(fs);
            }
            catch (Exception e)
            {
                Debug.LogError(e);
                if (File.Exists(targetPath))
                    File.Delete(targetPath);
            }
            finally
            {
                fs.Close();
            }
        }

        private static void WriteToChache()
        {
            string targetPath = NEXT_VERSION_CACHE_PATH;
            if (File.Exists(targetPath))
                File.Delete(targetPath);
            //序列化
            using (FileStream fs = File.OpenWrite(targetPath))
            {
                BinaryFormatter bf = new BinaryFormatter();
                bf.Serialize(fs, userSetting.brushSize);
                bf.Serialize(fs, userSetting.brushStronger);
                bf.Serialize(fs, userSetting.brushScale);
                bf.Serialize(fs, userSetting.layerIndex);
                bf.Serialize(fs, userSetting.brushIndex);
            }

            //检查是否勾选了Gizmos
            SceneView sceneView = SceneView.lastActiveSceneView;
            if (isPaint && sceneView != null && !sceneView.drawGizmos)
                sceneView.drawGizmos = true;
        }

        private static bool showSceneGUI = false;
        private MeshPainter _target;
        private MeshRenderer seletMeshrender;
        private Texture2D[] texLayer;
        private Texture2D MaskTex;
        private Texture[] brushTex;
        private static bool isPaint;
        private bool needSaveControlMap = false; //已更改 待保存
        private bool requestSaveControlMap = false; //请求保存

        void OnSceneGUI()
        {
            if (!showSceneGUI)
                return;

            if (isPaint && Tools.current == Tool.None)
                Painter();
        }

        private void OnDisable()
        {
            isPaint = false;
            if (needSaveControlMap || requestSaveControlMap)
            {
                SaveTexture(MaskTex);
            }
            needSaveControlMap = false;
            requestSaveControlMap = false;
            ResetData();
            _target = null;
            collider = null;
        }

        public void ResetData()
        {
            texLayer = null;
            brushTex = null;
            MaskTex = null;
        }

        enum ControlMapResolution
        {
            Res512 = 512,
            Res1024 = 1024,
            Res2048 = 2048,
        }
        ControlMapResolution selectResolution = ControlMapResolution.Res1024;

        public void ShowCreateNewControlMap(Material material)
        {
            string assetPath = AssetDatabase.GetAssetPath(material);
            string sceneName = UnityEngine.SceneManagement.SceneManager.GetActiveScene().name;
            string assetName = Path.GetFileName(assetPath);
            string assetFolder = assetPath.Substring(0, assetPath.Length - assetName.Length);
            selectResolution = (ControlMapResolution)EditorGUILayout.EnumPopup("选择分辨率：", selectResolution);

            EditorGUILayout.LabelField("目录：" + assetFolder);
            string controlMapName = sceneName + "_Control.tga";
            EditorGUILayout.LabelField("新建：" + controlMapName);

            if (GUILayout.Button("创建ControlMap"))
            {
                //创角图片
                int resolution = (int)selectResolution;
                string filePath = assetFolder + controlMapName;
                Texture texture = SaveNewControlMap(filePath, resolution);
                seletMeshrender.sharedMaterial.SetTexture(_Control, texture);
            }
        }

        public Texture SaveNewControlMap(string filePath, int resolution)
        {
            Texture2D data = new Texture2D(resolution, resolution, TextureFormat.ARGB32, false);
            Color[] pixels = new Color[resolution * resolution];
            for (int i = 0; i < resolution; ++i)
                for (int j = 0; j < resolution; ++j)
                    pixels[resolution * i + j] = new Color(1, 0, 0, 0);
            data.SetPixels(pixels);
            data.Apply();
            var bytes = data.EncodeToTGA();
            File.WriteAllBytes(filePath, bytes);
            UnityEngine.Object.DestroyImmediate(data);
            AssetDatabase.Refresh();

            TextureImporter textureImporter = AssetImporter.GetAtPath(filePath) as TextureImporter;
            textureImporter.sRGBTexture = false;
            textureImporter.mipmapEnabled = false;
            textureImporter.anisoLevel = 0;
            //需要设置为不压缩才支持读写
            var platform = textureImporter.GetDefaultPlatformTextureSettings();
            platform.textureCompression = TextureImporterCompression.Uncompressed;
            textureImporter.SetPlatformTextureSettings(platform);
            textureImporter.SaveAndReimport();

            return AssetDatabase.LoadAssetAtPath<Texture>(filePath);
        }

        public override void OnInspectorGUI()
        {
            showSceneGUI = false;
            if (_target == null)
                _target = (MeshPainter)target;
            if (_target.gameObject == null)
                return;

            //添加碰撞体
            collider = _target.GetComponent<MeshCollider>();
            if (collider == null)
                collider = _target.gameObject.AddComponent<MeshCollider>();

            //读取个人设置
            if (userSetting == null)
                ReadFromCache();

            //检查组件依赖
            seletMeshrender = _target.GetComponent<MeshRenderer>();
            var selectMeshFilter = _target.GetComponent<MeshFilter>();
            if (seletMeshrender == null || selectMeshFilter.sharedMesh == null)
            {
                EditorGUILayout.HelpBox("目标需要有MeshRender/MeshFilter并指定shadredMesh", MessageType.Error);
                return;
            }

            //检查笔刷目录
            if (string.IsNullOrEmpty(brushFolderPath) || !Directory.Exists(brushFolderPath))
            {
                brushFolderPath = AssetDatabase.GUIDToAssetPath(brushFolderGUID);
                if (string.IsNullOrEmpty(brushFolderPath) || !Directory.Exists(brushFolderPath))
                {
                    EditorGUILayout.HelpBox("笔刷目录不存在", MessageType.Error);
                    return;
                }
            }

            //检查材质数量
            if (seletMeshrender.sharedMaterials == null ||
                seletMeshrender.sharedMaterials.Length != 1 ||
                seletMeshrender.sharedMaterial == null)
            {
                EditorGUILayout.HelpBox("当前目标的材质数量必须为1", MessageType.Error);
                return;
            }

            //检查Shader兼容性 需要包含指定名称的属性
            var targetMat = seletMeshrender.sharedMaterial;
            if (!targetMat.HasProperty(_Control) ||
               !targetMat.HasProperty(_Splat1) ||
               !targetMat.HasProperty(_Splat2))
            {
                EditorGUILayout.HelpBox($"当前目标的shader需要有Terrain相关属性：{_Control} {_Splat1} {_Splat2}", MessageType.Error);
                return;
            }

            //检查Layer层数
            int layerCount = 2;
            if (targetMat.HasProperty(_Splat3))
            {
                layerCount += 1;
                if (targetMat.HasProperty(_Splat4))
                    layerCount += 1;
            }

            //材质球需要先设置好贴图属性
            if (targetMat.GetTexture(_Splat1) == null ||
              targetMat.GetTexture(_Splat2) == null ||
              (layerCount > 2 && targetMat.GetTexture(_Splat3) == null) ||
              (layerCount == 4 && targetMat.GetTexture(_Splat4) == null))
            {
                EditorGUILayout.HelpBox($"当前目标的材质需要设置好贴图", MessageType.Error);
                return;
            }

            //生成Layer预览图
            if (texLayer == null)
            {
                string[] layerNames = new string[4] { _Splat1, _Splat2, _Splat3, _Splat4 };
                string[] colorNames = new string[4] { _Color1, _Color2, _Color3, _Color4 };
                texLayer = new Texture2D[layerCount];
                for (int i = 0; i < layerCount; i++)
                {
                    texLayer[i] = AssetPreview.GetAssetPreview(targetMat.GetTexture(layerNames[i]));
                    if (texLayer[i] == null)
                        texLayer[i] = Texture2D.whiteTexture;
                    if (targetMat.HasProperty(colorNames[i]))
                        texLayer[i] = MergeTexture(texLayer[i], targetMat.GetColor(colorNames[i]));
                }

                //将Layer预览图乘以Layer颜色
                Texture2D MergeTexture(Texture2D a, Color b)
                {
                    var newTexture = new Texture2D(a.width, a.height);
                    newTexture.filterMode = FilterMode.Point;

                    for (int i = 0; i < newTexture.width; i++)
                    {
                        for (int j = 0; j < newTexture.height; j++)
                        {
                            var color = a.GetPixel(i, j);
                            color.r = color.r * b.r;
                            color.g = color.g * b.g;
                            color.b = color.b * b.b;
                            newTexture.SetPixel(i, j, color);
                        }
                    }

                    newTexture.Apply();
                    return newTexture;
                }
            }

            //检查笔刷贴图
            if (brushTex == null)
            {
                ArrayList BrushList = new ArrayList();
                Texture BrushesTL;
                int BrushNum = 0;
                do
                {
                    BrushesTL = (Texture)AssetDatabase.LoadAssetAtPath(brushFolderPath + "/Brush" + BrushNum + ".png", typeof(Texture));
                    if (BrushesTL)
                        BrushList.Add(BrushesTL);
                    BrushNum++;
                } while (BrushesTL);
                brushTex = BrushList.ToArray(typeof(Texture)) as Texture[];
            }

            //将Texture2D保存为TGA
            if (requestSaveControlMap)
            {
                SaveTexture(MaskTex);
                requestSaveControlMap = false;
            }

            //检查ControlMap是否为空 如果为空可帮助创建
            if (MaskTex == null)
            {
                MaskTex = (Texture2D)targetMat.GetTexture(_Control);
                if (MaskTex == null)
                {
                    EditorGUILayout.HelpBox("当前目标的Control Map为空", MessageType.Error);
                    ShowCreateNewControlMap(targetMat);
                    return;
                }
                TextureEnableReadable(MaskTex);
            }

            EditorGUI.BeginChangeCheck();
            //绘制状态切换 开始绘制GUI
            {
                GUILayout.BeginHorizontal();
                GUILayout.FlexibleSpace();
                if (GUILayout.Button("刷新", GUILayout.Height(25)))
                {
                    AssetDatabase.Refresh();
                    isPaint = false;
                    ResetData();
                    return;
                }
                GUIStyle boolBtnOn = new GUIStyle(GUI.skin.GetStyle("Button"));
                GUIContent guiContent = EditorGUIUtility.IconContent("EditCollider");
                isPaint = GUILayout.Toggle(isPaint, guiContent, boolBtnOn, GUILayout.Width(35), GUILayout.Height(25));
                if (isPaint)
                    GUILayout.Label("Drawing", GUILayout.Height(25));
                GUILayout.FlexibleSpace();
                GUILayout.EndHorizontal();
            }

            //笔刷属性
            {
                userSetting.brushSize = EditorGUILayout.Slider("笔刷宽度", userSetting.brushSize, 0.1f, 50);
                userSetting.brushStronger = EditorGUILayout.Slider("笔刷强度", userSetting.brushStronger, 0f, 1f);
                userSetting.brushScale = EditorGUILayout.Slider("笔刷缩放", userSetting.brushScale, 0.1f, 10f);
            }

            //Layer
            {
                GUILayout.BeginHorizontal();
                GUILayout.FlexibleSpace();
                int texCount = texLayer.Length;
                int singleWidth = 80; int doubleWidth = singleWidth * 2; int maxWidth = singleWidth * 4;
                int gridHeight = texCount > 4 ? doubleWidth : singleWidth;
                int gridWidth = texCount > 4 ? maxWidth : singleWidth * texCount;
                int singleLineCount = texCount > 4 ? 4 : texCount;
                userSetting.layerIndex = GUILayout.SelectionGrid(userSetting.layerIndex, texLayer, singleLineCount, "gridlist", GUILayout.Width(gridWidth), GUILayout.Height(gridHeight));
                GUILayout.FlexibleSpace();
                GUILayout.EndHorizontal();
            }

            //Brush
            {
                GUILayout.BeginHorizontal();
                GUILayout.FlexibleSpace();
                userSetting.brushIndex = GUILayout.SelectionGrid(userSetting.brushIndex, brushTex, 9, "gridlist", GUILayout.Width(340), GUILayout.Height(70));
                GUILayout.FlexibleSpace();
                GUILayout.EndHorizontal();
            }

            if (EditorGUI.EndChangeCheck())
                WriteToChache();

            //当切换到绘制模式时更改工具模式
            {
                if (isPaint && Tools.current != Tool.None)
                    Tools.current = Tool.None;
            }

            //检查LayerIndex是否超过限制
            if (userSetting.layerIndex >= texLayer.Length)
            {
                userSetting.layerIndex = 0;
                WriteToChache();
            }

            //检查笔刷Index是否超过限制
            if (userSetting.brushIndex >= brushTex.Length)
            {
                userSetting.brushIndex = 0;
                WriteToChache();
            }

            //检测通过才在Scene窗口显示笔刷
            showSceneGUI = true;
        }

        public void Painter()
        {
            //检查LayerIndex是否超过限制
            if (userSetting.layerIndex >= texLayer.Length)
            {
                userSetting.layerIndex = 0;
                WriteToChache();
            }

            //检查笔刷Index是否超过限制
            if (userSetting.brushIndex >= brushTex.Length)
            {
                userSetting.brushIndex = 0;
                WriteToChache();
            }

            Event e = Event.current;
            HandleUtility.AddDefaultControl(0);

            Ray terrain = HandleUtility.GUIPointToWorldRay(e.mousePosition);
            if (collider.Raycast(terrain, out var raycastHit, Mathf.Infinity))
            {
                //像素宽度
                Vector3 targetSize = _target.GetComponent<MeshRenderer>().bounds.size;
                float maxSize = Mathf.Max(targetSize.x, targetSize.y, targetSize.z) + 1;
                float brushCoverage = Mathf.Clamp01(userSetting.brushSize / maxSize);
                int brushPixelSize = Mathf.RoundToInt(MaskTex.width * brushCoverage * userSetting.brushScale);

                Handles.color = new Color(1f, 1f, 0f, 1f); //黄色的圆圈
                Handles.DrawWireDisc(raycastHit.point, raycastHit.normal, userSetting.brushSize);
                Handles.color = new Color(1f, 0f, 0f, 1f); //红色的法线
                Handles.DrawLine(raycastHit.point, raycastHit.point + raycastHit.normal);

                //左键拖拽 或 左键单击
                if (e.alt == false && e.control == false && e.shift == false && e.button == 0 &&
                    (e.type == EventType.MouseDrag || e.type == EventType.MouseDown))
                {
                    //根据Layer决定写入的通道
                    Color targetColor = new Color(1f, 0f, 0f, 0f);
                    switch (userSetting.layerIndex)
                    {
                        case 0:
                            break;
                        case 1:
                            targetColor = new Color(0f, 1f, 0f, 0f);
                            break;
                        case 2:
                            targetColor = new Color(0f, 0f, 1f, 0f);
                            break;
                        case 3:
                            targetColor = new Color(0f, 0f, 0f, 1f);
                            break;
                    }

                    Vector2 pixelUV = raycastHit.textureCoord; //UV需要转换到0-1范围

                    #region 矫正UV
                    float changX, changY;
                    if (Mathf.Abs(pixelUV.x) > 1 || Mathf.Abs(pixelUV.y) > 1) //xy转换到0-1
                    {
                        if (pixelUV.x > 1)
                            changX = pixelUV.x % 1;
                        else if (pixelUV.x < -1)
                            changX = 1 - Mathf.Abs(pixelUV.x % (-1));
                        else
                            changX = pixelUV.x;

                        if (pixelUV.y > 1)
                            changY = pixelUV.y % 1;
                        else if (pixelUV.y < -1)
                            changY = 1 - Mathf.Abs(pixelUV.y % (-1));
                        else
                            changY = pixelUV.y;

                        pixelUV = new Vector2(changX, changY);
                    }

                    if ((pixelUV.y < 0 && pixelUV.y >= -1) || (pixelUV.x < 0 && pixelUV.x >= -1))
                    {
                        if (pixelUV.x < 0 && pixelUV.x >= -1)
                            changX = 1 - Mathf.Abs(pixelUV.x);
                        else
                            changX = pixelUV.x;

                        if (pixelUV.y < 0 && pixelUV.y >= -1)
                            changY = 1 - Mathf.Abs(pixelUV.y);
                        else
                            changY = pixelUV.y;

                        pixelUV = new Vector2(changX, changY);
                    }
                    #endregion

                    //笔刷A通道数据 不会比width和height窄
                    Texture2D TBrush = brushTex[userSetting.brushIndex] as Texture2D;
                    float[] brushAlpha = new float[brushPixelSize * brushPixelSize];
                    for (int i = 0; i < brushPixelSize; i++)
                    {
                        for (int j = 0; j < brushPixelSize; j++)
                        {
                            brushAlpha[j * brushPixelSize + i] = TBrush.GetPixelBilinear(((float)i) / brushPixelSize, ((float)j) / brushPixelSize).a;
                        }
                    }

                    {
                        //被笔刷覆盖区域的ControlMap数据
                        int PuX = Mathf.FloorToInt(pixelUV.x * MaskTex.width);
                        int PuY = Mathf.FloorToInt(pixelUV.y * MaskTex.height);
                        int x = Mathf.Clamp(PuX - brushPixelSize / 2, 0, MaskTex.width - 1);
                        int y = Mathf.Clamp(PuY - brushPixelSize / 2, 0, MaskTex.height - 1);
                        int width = Mathf.Clamp((PuX + brushPixelSize / 2), 0, MaskTex.width) - x;
                        int height = Mathf.Clamp((PuY + brushPixelSize / 2), 0, MaskTex.height) - y;
                        Color[] terrainBay = MaskTex.GetPixels(x, y, width, height, 0);

                        //填充像素
                        for (int i = 0; i < height; i++)
                        {
                            for (int j = 0; j < width; j++)
                            {
                                int index = (i * width) + j;
                                int uvY = Mathf.Clamp((y + i) - (PuY - brushPixelSize / 2), 0, brushPixelSize - 1);
                                int uvX = Mathf.Clamp((x + j) - (PuX - brushPixelSize / 2), 0, brushPixelSize - 1);
                                float Stronger = brushAlpha[uvY * brushPixelSize + uvX] * userSetting.brushStronger;
                                terrainBay[index] = Color.Lerp(terrainBay[index], targetColor, Stronger);
                            }
                        }
                        Undo.RegisterCompleteObjectUndo(MaskTex, "MeshPaint");//Save history for revocation
                        MaskTex.SetPixels(x, y, width, height, terrainBay, 0);//Save the drawn Control texture
                        MaskTex.Apply();
                    }

                    needSaveControlMap = true;
                }

                if (e.alt == false && e.control == false && e.shift == false && e.button == 0 &&
                    e.type == EventType.MouseUp && needSaveControlMap)
                {
                    needSaveControlMap = false;
                    requestSaveControlMap = true;
                }

                //加速Scene场景渲染
                SceneView.RepaintAll();
            }
        }

        private void SaveTexture(Texture2D texture)
        {
            var path = AssetDatabase.GetAssetPath(texture);
            if (path.EndsWith(".png") || path.EndsWith(".PNG"))
            {
                var bytes = texture.EncodeToPNG();
                File.WriteAllBytes(path, bytes);
            }
            else if (path.EndsWith(".tga") || path.EndsWith(".TGA"))
            {
                var bytes = texture.EncodeToTGA();
                File.WriteAllBytes(path, bytes);
            }
            else if (path.EndsWith(".jpg") || path.EndsWith(".JPG"))
            {
                var bytes = texture.EncodeToJPG();
                File.WriteAllBytes(path, bytes);
            }
        }

        private void TextureEnableReadable(Texture2D texture)
        {
            if (texture == null)
                return;
            var path = AssetDatabase.GetAssetPath(texture);
            var textureImporter = AssetImporter.GetAtPath(path) as TextureImporter;
            if (textureImporter == null)
                return;

            var defaultPlatform = textureImporter.GetDefaultPlatformTextureSettings();
            var iosPlatform = textureImporter.GetPlatformTextureSettings("iOS");
            var androidPlatform = textureImporter.GetPlatformTextureSettings("Android");

            if (!textureImporter.isReadable ||
                iosPlatform.overridden ||
                androidPlatform.overridden ||
                defaultPlatform.textureCompression != TextureImporterCompression.Uncompressed)
            {
                iosPlatform.overridden = false;
                textureImporter.SetPlatformTextureSettings(iosPlatform);

                androidPlatform.overridden = false;
                textureImporter.SetPlatformTextureSettings(androidPlatform);

                defaultPlatform.textureCompression = TextureImporterCompression.Uncompressed;
                textureImporter.SetPlatformTextureSettings(defaultPlatform);

                textureImporter.isReadable = true;

                textureImporter.SaveAndReimport();
            }
        }

        private void TextureCloseReadable(Texture2D texture)
        {
            if (texture == null)
                return;
            var path = AssetDatabase.GetAssetPath(texture);
            var textrueImpoter = AssetImporter.GetAtPath(path) as TextureImporter;
            if (textrueImpoter != null && textrueImpoter.isReadable)
            {
                textrueImpoter.isReadable = false;
                textrueImpoter.SaveAndReimport();
            }
        }

        [MenuItem("Window/场景Debug工具/ChangeMeshPainterMode &z", false, 25)]
        static void ChangeMeshPainterMode()
        {
            isPaint = !isPaint;
        }

        #region 切换Layer
        [MenuItem("Window/场景Debug工具/ChangeMeshPainterLayerIndex1 &1", false, 25)]
        static void ChangeMeshPainterLayerIndex0()
        {
            if (isPaint)
            {
                userSetting.layerIndex = 0;
                WriteToChache();
            }
        }

        [MenuItem("Window/场景Debug工具/ChangeMeshPainterLayerIndex2 &2", false, 25)]
        static void ChangeMeshPainterLayerIndex1()
        {
            if (isPaint)
            {
                userSetting.layerIndex = 1;
                WriteToChache();
            }
        }

        [MenuItem("Window/场景Debug工具/ChangeMeshPainterLayerIndex3 &3", false, 25)]
        static void ChangeMeshPainterLayerIndex2()
        {
            if (isPaint)
            {
                userSetting.layerIndex = 2;
                WriteToChache();
            }
        }

        [MenuItem("Window/场景Debug工具/ChangeMeshPainterLayerIndex4 &4", false, 25)]
        static void ChangeMeshPainterLayerIndex3()
        {
            if (isPaint)
            {
                userSetting.layerIndex = 3;
                WriteToChache();
            }
        }
        #endregion

        #region 切换笔刷
        [MenuItem("Window/场景Debug工具/ChangeMeshPainterBrushIndex1 %1", false, 25)]
        static void ChangeMeshPainterBrushIndex0()
        {
            if (isPaint)
            {
                userSetting.brushIndex = 0;
                WriteToChache();
            }
        }


        [MenuItem("Window/场景Debug工具/ChangeMeshPainterBrushIndex2 %2", false, 25)]
        static void ChangeMeshPainterBrushIndex1()
        {
            if (isPaint)
            {
                userSetting.brushIndex = 1;
                WriteToChache();
            }
        }


        [MenuItem("Window/场景Debug工具/ChangeMeshPainterBrushIndex3 %3", false, 25)]
        static void ChangeMeshPainterBrushIndex2()
        {
            if (isPaint)
            {
                userSetting.brushIndex = 2;
                WriteToChache();
            }
        }


        [MenuItem("Window/场景Debug工具/ChangeMeshPainterBrushIndex4 %4", false, 25)]
        static void ChangeMeshPainterBrushIndex3()
        {
            if (isPaint)
            {
                userSetting.brushIndex = 3;
                WriteToChache();
            }
        }
        #endregion
    }
}
#endif
