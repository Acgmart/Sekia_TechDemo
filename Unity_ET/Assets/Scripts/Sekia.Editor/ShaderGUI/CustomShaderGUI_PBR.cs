using UnityEngine;
using System.IO;

namespace UnityEditor
{
    public class CustomShaderGUI_PBR : Shader_GUI_Common
    {
        public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] properties)
        {
            #region 公共开头区域
            GUIStyle _TitleStyle = new GUIStyle(GUI.skin.button);
            _TitleStyle.normal.textColor = Color.red;
            _TitleStyle.fontStyle = FontStyle.Bold;

            GUIStyle _TitleStyleChinese = new GUIStyle(GUI.skin.button);
            _TitleStyleChinese.normal.textColor = Color.red;

            Material material = materialEditor.target as Material;
            string material_shaderName = material.shader.name;

            if (ShowDefaultOrCustomGUI(materialEditor, properties))
                return;
            #endregion

            EditorGUILayout.BeginVertical(GUI.skin.box);
            {
                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.PrefixLabel("透明裁剪");
                string keywordName = "_ALPHATEST_ON";
                bool isEffectOn = material.IsKeywordEnabled(keywordName);
                if (isEffectOn)
                {
                    if (GUILayout.Button("On", _TitleStyle))
                    {
                        material.DisableKeyword(keywordName);
                        material.SetInt("_AlphaClip", 0);
                    }
                }
                else
                {
                    if (GUILayout.Button("Off"))
                    {
                        material.EnableKeyword(keywordName); 
                        material.SetInt("_AlphaClip", 1);
                    }
                }
                
                EditorGUILayout.EndHorizontal();
            }
            EditorGUILayout.EndVertical();

            //材质处理工具
            _ShowMateialTool = GUILayout.Toggle(_ShowMateialTool, new GUIContent("MateialTool"));
            if (_ShowMateialTool)
            {
                void ExtractTexture(string outputPath, int width, int height,
                            Texture input1, int inputChannel1, float rChannelDefaultValue, //R
                            Texture input2, int inputChannel2, float gChannelDefaultValue, //G
                            Texture input3, int inputChannel3, float bChannelDefaultValue) //B
                {
                    CheckTextureNoSrgb(input1);
                    CheckTextureNoSrgb(input2);
                    CheckTextureNoSrgb(input3);
                    CheckTextureReadable(input1);
                    CheckTextureReadable(input2);
                    CheckTextureReadable(input3);
                    CheckTextureNoCompress(input1);
                    CheckTextureNoCompress(input2);
                    CheckTextureNoCompress(input3);

                    Texture2D sourceData1 = input1 == null ? null : input1 as Texture2D;
                    Texture2D sourceData2 = input2 == null ? null : input2 as Texture2D;
                    Texture2D sourceData3 = input3 == null ? null : input3 as Texture2D;

                    Texture2D outputData = new Texture2D(width, height, TextureFormat.RGB24, false, true);
                    Color[] pixels = new Color[width * height];

                    //填充像素
                    for (int i = 0; i < height; ++i)
                    {
                        for (int j = 0; j < width; ++j)
                        {
                            float GetColorChannelValue(int channel, Color sampleValue)
                            {
                                return channel == 1 ? sampleValue.r :
                                                channel == 2 ? sampleValue.g :
                                                channel == 3 ? sampleValue.b :
                                                channel == 4 ? sampleValue.a : 0;
                            }

                            Color defaultR = new Color(rChannelDefaultValue, rChannelDefaultValue, rChannelDefaultValue, rChannelDefaultValue);
                            Color defaultG = new Color(gChannelDefaultValue, gChannelDefaultValue, gChannelDefaultValue, gChannelDefaultValue);
                            Color defaultB = new Color(bChannelDefaultValue, bChannelDefaultValue, bChannelDefaultValue, bChannelDefaultValue);

                            Color targetColor1 = sourceData1 == null ? defaultR : sourceData1.GetPixel(j, i);
                            Color targetColor2 = sourceData2 == null ? defaultG : sourceData2.GetPixel(j, i);
                            Color targetColor3 = sourceData3 == null ? defaultB : sourceData3.GetPixel(j, i);

                            float Value_R = GetColorChannelValue(inputChannel1, targetColor1);
                            float Value_G = GetColorChannelValue(inputChannel2, targetColor2);
                            float Value_B = GetColorChannelValue(inputChannel3, targetColor3);
                            pixels[width * i + j] = new Color(Value_R, Value_G, Value_B);
                        }
                    }

                    //保存RT
                    outputData.SetPixels(pixels);
                    outputData.Apply();
                    File.WriteAllBytes(outputPath, outputData.EncodeToTGA());
                    Object.DestroyImmediate(outputData);
                    AssetDatabase.Refresh();
                }

                void ResetStaticValue()
                {
                    _textureTargetName = null;
                    _textureTargetFolder = null;
                    texture1 = null;
                    texture2 = null;
                    texture3 = null;
                }

                string ChangeObsolutePathToUnityPath(string path)
                {
                    string result = path.Substring(path.IndexOf("Assets"));
                    return result.Replace('\\', '/');
                }

                void CheckTextureNoCompress(Texture texture)
                {
                    if (texture == null)
                        return;
                    string texturePath = AssetDatabase.GetAssetPath(texture);
                    TextureImporter importer = AssetImporter.GetAtPath(texturePath) as TextureImporter;
                    if (importer.textureCompression != TextureImporterCompression.Uncompressed)
                    {
                        importer.textureCompression = TextureImporterCompression.Uncompressed;
                        AssetDatabase.ImportAsset(texturePath);
                        AssetDatabase.Refresh();
                    }
                }

                void CheckTextureReadable(Texture texture)
                {
                    if (texture == null)
                        return;
                    string texturePath = AssetDatabase.GetAssetPath(texture);
                    TextureImporter importer = AssetImporter.GetAtPath(texturePath) as TextureImporter;
                    if (!importer.isReadable)
                    {
                        importer.isReadable = true;
                        AssetDatabase.ImportAsset(texturePath);
                        AssetDatabase.Refresh();
                    }
                }

                void CheckTextureNoSrgb(Texture texture)
                {
                    if (texture == null)
                        return;
                    string texturePath = AssetDatabase.GetAssetPath(texture);
                    TextureImporter importer = AssetImporter.GetAtPath(texturePath) as TextureImporter;
                    if (importer.sRGBTexture)
                    {
                        importer.sRGBTexture = false;
                        AssetDatabase.ImportAsset(texturePath);
                        AssetDatabase.Refresh();
                    }
                }

                EditorGUILayout.BeginVertical(GUI.skin.box);
                {
                    EditorGUI.indentLevel++;

                    EditorGUI.BeginChangeCheck();
                    _ShowMateralTool_CombineCustomMap = GUILayout.Toggle(_ShowMateralTool_CombineCustomMap, new GUIContent("合并MaskMap"));
                    if (EditorGUI.EndChangeCheck())
                        ResetStaticValue();

                    if (_ShowMateralTool_CombineCustomMap)
                    {
                        texture1 = (Texture)EditorGUILayout.ObjectField(new GUIContent("输入R通道(金属度)来源"), texture1, typeof(Texture), false);
                        texture2 = (Texture)EditorGUILayout.ObjectField(new GUIContent("输入G通道(粗糙度)来源"), texture2, typeof(Texture), false);
                        texture3 = (Texture)EditorGUILayout.ObjectField(new GUIContent("输入B通道(AO)来源"), texture3, typeof(Texture), false);
                        if (string.IsNullOrEmpty(_textureTargetName) && texture1 != null)
                        {
                            string texture1_Path = AssetDatabase.GetAssetPath(texture1);
                            FileInfo fileInfo = new FileInfo(texture1_Path);
                            _textureTargetFolder = ChangeObsolutePathToUnityPath(fileInfo.DirectoryName);
                            _textureTargetName = material.name + "_Combined.tga";
                        }
                        _textureTargetName = EditorGUILayout.TextField(new GUIContent("贴图名称", "路径问题？"), _textureTargetName);

                        texture1ChannelIndex = EditorGUILayout.IntField("贴图1通道(1-4)", texture1ChannelIndex);
                        texture2ChannelIndex = EditorGUILayout.IntField("贴图2通道(1-4)", texture2ChannelIndex);
                        texture3ChannelIndex = EditorGUILayout.IntField("贴图3通道(1-4)", texture3ChannelIndex);

                        RChannelDefaultValue = EditorGUILayout.FloatField("R通道默认值", RChannelDefaultValue);
                        GChannelDefaultValue = EditorGUILayout.FloatField("G通道默认值", GChannelDefaultValue);
                        BChannelDefaultValue = EditorGUILayout.FloatField("B通道默认值", BChannelDefaultValue);

                        if (GUILayout.Button("开始合成") && !string.IsNullOrEmpty(_textureTargetName))
                        {
                            if (texture1.width != texture2.width ||
                                texture1.width != texture3.width ||
                                texture1.height != texture2.height ||
                                texture1.height != texture3.height)
                            {
                                Debug.LogError($"三个贴图分辨率不一致\n" +
                                    $"{texture1.width} {texture1.height}\n" +
                                    $"{texture2.width} {texture2.height}\n" +
                                    $"{texture3.width} {texture3.height}");
                                return;
                            }

                            string targetPath = Path.Combine(_textureTargetFolder, _textureTargetName);
                            ExtractTexture(targetPath, texture1.width, texture1.height,
                                texture1, texture1ChannelIndex, RChannelDefaultValue,
                                texture2, texture2ChannelIndex, GChannelDefaultValue,
                                texture3, texture3ChannelIndex, BChannelDefaultValue);

                            _ShowMateralTool_CombineCustomMap = false;
                            ResetStaticValue();
                        }
                    }

                    EditorGUI.indentLevel--;
                }
                EditorGUILayout.EndVertical();
            }
            EditorGUILayout.Space();

            EditorGUILayout.LabelField("PBR input", EditorStyles.boldLabel);
            EditorGUILayout.BeginVertical(GUI.skin.box);
            {
                //_BaseMap
                materialEditor.TexturePropertySingleLine(
                            new GUIContent("主贴图 RGBA", "参数1：主贴图 RGBA\n" +
                            "       RGB：Albedo\n" +
                            "       A：Alpha\n" +
                            "参数2：主颜色 RGBA"),
                            FindProperty("_BaseMap", properties), FindProperty("_BaseColor", properties));

                //_MaskMap
                materialEditor.TexturePropertySingleLine(
                            new GUIContent("数据图 RGBA", "PBR数据贴图 RGBA\n" +
                            "       R：金属度\n" +
                            "       G：粗糙度\n" +
                            "       B：AO\n" +
                            "       A：自发光"),
                            FindProperty("_MaskMap", properties));

                //_NormalMap
                materialEditor.TexturePropertySingleLine(
                        new GUIContent("法线贴图"),
                        FindProperty("_NormalMap", properties));
            }
            EditorGUILayout.EndVertical();
            EditorGUILayout.Space();

            EditorGUILayout.LabelField("PBR Adjust", EditorStyles.boldLabel);
            EditorGUILayout.BeginVertical(GUI.skin.box);
            {
                materialEditor.ShaderProperty(FindProperty("_Cutoff", properties),
                        new GUIContent("透明裁剪阀值"));

                materialEditor.ShaderProperty(FindProperty("_MetallicCof", properties),
                        new GUIContent("金属度系数"));

                materialEditor.ShaderProperty(FindProperty("_RoughnessCof", properties),
                       new GUIContent("粗糙度系数"));

                materialEditor.ShaderProperty(FindProperty("_OcclusionCof", properties),
                    new GUIContent("AO强度"));

                materialEditor.ShaderProperty(FindProperty("_EmissionColor", properties),
                    new GUIContent("自发光"));
            }
            EditorGUILayout.EndVertical();
            EditorGUILayout.Space();
        }
    }
}
