using UnityEngine;
using System.IO;
using System.Collections.Generic;
using UnityEngine.Rendering;
using Autodesk.Fbx;
using System.Linq;
using UnityEditor.Formats.Fbx.Exporter;

namespace UnityEditor
{
    public class Shader_GUI_Common : ShaderGUI
    {
        #region GUIStyle
        private static GUIStyle _TitleStyle_hide;

        public static GUIStyle _TitleStyle
        {
            get
            {
                if (_TitleStyle_hide == null)
                {
                    _TitleStyle_hide = new GUIStyle(GUI.skin.button);
                    _TitleStyle_hide.normal.textColor = Color.red;
                    _TitleStyle_hide.fontStyle = FontStyle.Bold;
                }
                return _TitleStyle_hide;
            }
        }

        private static GUIStyle _TitleStyleChinese_hide;

        public static GUIStyle _TitleStyleChinese
        {
            get
            {
                if (_TitleStyleChinese_hide == null)
                {
                    _TitleStyleChinese_hide = new GUIStyle(GUI.skin.button);
                    _TitleStyleChinese_hide.normal.textColor = Color.red;
                }
                return _TitleStyleChinese_hide;
            }
        }
        #endregion

        #region GUI方法
        public static void ShowKeyword(Material material, string title, string keyword, string onTitle = "On", string offTitle = "Off")
        {
            EditorGUILayout.BeginHorizontal();
            EditorGUILayout.PrefixLabel(title);
            string keywordName = keyword;
            bool isKeywordOn = material.IsKeywordEnabled(keywordName);
            bool isValueOn = material.GetInt(keywordName) == 1;
            if (isKeywordOn && !isValueOn)
                material.SetInt(keywordName, 1);

            if (isKeywordOn)
            {
                if (GUILayout.Button(onTitle, _TitleStyle))
                {
                    material.SetInt(keywordName, 0);
                    material.DisableKeyword(keywordName);
                }
            }
            else
            {
                if (GUILayout.Button(offTitle))
                {
                    material.SetInt(keywordName, 1);
                    material.EnableKeyword(keywordName);
                }
            }
            EditorGUILayout.EndHorizontal();
        }

        public static void ShowKeyword2(Material material, string title, string keyword1, string keyword2,
            string onTitle1, string onTitle2, string offTitle = "Off")
        {
            EditorGUILayout.BeginHorizontal();
            EditorGUILayout.PrefixLabel(title);
            bool isKeywordOn1 = material.IsKeywordEnabled(keyword1);
            bool isKeywordOn2 = material.IsKeywordEnabled(keyword2);
            bool isValueOn1 = material.GetInt(keyword1) == 1;
            bool isValueOn2 = material.GetInt(keyword2) == 1;

            if (isKeywordOn1 && !isValueOn1)
                material.SetInt(keyword1, 1);
            if (isKeywordOn2 && !isValueOn2)
                material.SetInt(keyword2, 1);

            //两个关键字只能最多开启一个
            if (isKeywordOn1 && isKeywordOn2)
            {
                material.DisableKeyword(keyword2);
                material.SetInt(keyword2, 0);
            }

            if (isKeywordOn1)
            {
                if (GUILayout.Button(onTitle1, _TitleStyle))
                {
                    material.SetInt(keyword1, 0);
                    material.DisableKeyword(keyword1);
                    material.SetInt(keyword2, 1);
                    material.EnableKeyword(keyword2);
                }
            }
            else if (isKeywordOn2)
            {
                if (GUILayout.Button(onTitle2, _TitleStyle))
                {
                    material.SetInt(keyword1, 0);
                    material.DisableKeyword(keyword1);
                    material.SetInt(keyword2, 0);
                    material.DisableKeyword(keyword2);
                }
            }
            else
            {
                if (GUILayout.Button(offTitle))
                {
                    material.SetInt(keyword1, 1);
                    material.EnableKeyword(keyword1);
                    material.SetInt(keyword2, 0);
                    material.DisableKeyword(keyword2);
                }
            }
            EditorGUILayout.EndHorizontal();
        }

        public static void ShowKeyword3(Material material, string title,
            string keyword1, string keyword2, string keyword3,
            string onTitle1, string onTitle2, string onTitle3, string offTitle = "Off")
        {
            EditorGUILayout.BeginHorizontal();
            EditorGUILayout.PrefixLabel(title);
            bool isKeywordOn1 = material.IsKeywordEnabled(keyword1);
            bool isKeywordOn2 = material.IsKeywordEnabled(keyword2);
            bool isKeywordOn3 = material.IsKeywordEnabled(keyword3);
            bool isValueOn1 = material.GetInt(keyword1) == 1;
            bool isValueOn2 = material.GetInt(keyword2) == 1;
            bool isValueOn3 = material.GetInt(keyword3) == 1;

            if (isKeywordOn1 && !isValueOn1)
                material.SetInt(keyword1, 1);
            if (isKeywordOn2 && !isValueOn2)
                material.SetInt(keyword2, 1);
            if (isKeywordOn3 && !isValueOn3)
                material.SetInt(keyword3, 1);

            //两个关键字只能最多开启一个
            if (isKeywordOn1 && isKeywordOn2)
            {
                material.DisableKeyword(keyword2);
                material.SetInt(keyword2, 0);
            }

            if (isKeywordOn1 && isKeywordOn3)
            {
                material.DisableKeyword(keyword3);
                material.SetInt(keyword3, 0);
            }

            if (isKeywordOn2 && isKeywordOn3)
            {
                material.DisableKeyword(keyword3);
                material.SetInt(keyword3, 0);
            }

            if (isKeywordOn1)
            {
                if (GUILayout.Button(onTitle1, _TitleStyle))
                {
                    material.SetInt(keyword1, 0);
                    material.DisableKeyword(keyword1);
                    material.SetInt(keyword2, 1);
                    material.EnableKeyword(keyword2);
                    material.SetInt(keyword3, 0);
                    material.DisableKeyword(keyword3);
                }
            }
            else if (isKeywordOn2)
            {
                if (GUILayout.Button(onTitle2, _TitleStyle))
                {
                    material.SetInt(keyword1, 0);
                    material.DisableKeyword(keyword1);
                    material.SetInt(keyword2, 0);
                    material.DisableKeyword(keyword2);
                    material.SetInt(keyword3, 1);
                    material.EnableKeyword(keyword3);
                }
            }
            else if (isKeywordOn3)
            {
                if (GUILayout.Button(onTitle3, _TitleStyle))
                {
                    material.SetInt(keyword1, 0);
                    material.DisableKeyword(keyword1);
                    material.SetInt(keyword2, 0);
                    material.DisableKeyword(keyword2);
                    material.SetInt(keyword3, 0);
                    material.DisableKeyword(keyword3);
                }
            }
            else
            {
                if (GUILayout.Button(offTitle))
                {
                    material.SetInt(keyword1, 1);
                    material.EnableKeyword(keyword1);
                    material.SetInt(keyword2, 0);
                    material.DisableKeyword(keyword2);
                    material.SetInt(keyword3, 0);
                    material.DisableKeyword(keyword3);
                }
            }
            EditorGUILayout.EndHorizontal();
        }

        //用3个值范围在0-1的曲线表示一张Remap贴图
        public static void ShowCurveRemapTexture(Texture _targetRemapTexture, CustomRGBCurveData _data, int width = 256)
        {
            if (_targetRemapTexture == null)
                EditorGUILayout.LabelField(new GUIContent("先指定一个Remap贴图"));
            EditorGUI.BeginChangeCheck();
            _targetRemapTexture = (Texture)EditorGUILayout.ObjectField(new GUIContent("Remap贴图",
                "Remap贴图用于实现在shader中采样自定义曲线\n" +
                "可实现将0至1范围映射为另一个范围的任意曲线\n" +
                "三个通道对应三个曲线\n" +
                "低精度贴图使用8bit保存 高精度贴图使用32bit保存"), _targetRemapTexture, typeof(Texture), allowSceneObjects: false);
            if (EditorGUI.EndChangeCheck())
                _data = null; //数据和贴图是一对一的关系

            if (_targetRemapTexture != null)
            {
                string texturePath = AssetDatabase.GetAssetPath(_targetRemapTexture);
                if (_data == null)
                {
                    string textureName = Path.GetFileNameWithoutExtension(texturePath);
                    string textureDir = Path.GetDirectoryName(texturePath);
                    string _dataPath = textureDir + "/" + textureName + "_CurveData.asset";
                    _dataPath = _dataPath.Replace('\\', '/');
                    //Debug.LogError("数据路径：" + _dataPath);
                    if (File.Exists(_dataPath)) //根据相对路径找到对应的data 读取数据
                    {
                        _data = AssetDatabase.LoadAssetAtPath<CustomRGBCurveData>(_dataPath);
                    }
                    else //如果data不存在则新建data
                    {
                        _data = ScriptableObject.CreateInstance<CustomRGBCurveData>();
                        _data._curve1 = AnimationCurve.Linear(0, 0, 1, 1);
                        _data._curve2 = AnimationCurve.Linear(0, 0, 1, 1);
                        _data._curve3 = AnimationCurve.Linear(0, 0, 1, 1);
                        AssetDatabase.CreateAsset(_data, _dataPath);
                        AssetDatabase.SaveAssets();
                        AssetDatabase.Refresh();
                    }
                }

                EditorGUI.BeginChangeCheck();
                AnimationCurve _curve1 = EditorGUILayout.CurveField(_data._curve1);
                AnimationCurve _curve2 = EditorGUILayout.CurveField(_data._curve2);
                AnimationCurve _curve3 = EditorGUILayout.CurveField(_data._curve3);
                if (EditorGUI.EndChangeCheck())
                {
                    Undo.RegisterCompleteObjectUndo(_data, "CurveData");
                    _data._curve1 = _curve1;
                    _data._curve2 = _curve2;
                    _data._curve3 = _curve3;

                    //保存曲线到图片
                    CheckTextureNoSrgb(_targetRemapTexture);
                    CheckTextureReadable(_targetRemapTexture);
                    CheckTextureNoCompress(_targetRemapTexture);
                    CheckTextureNoMipmap(_targetRemapTexture);
                    Texture2D outputData = new Texture2D(width, 1, TextureFormat.RGB48, false, true);
                    Color[] pixels = new Color[width];
                    //填充像素
                    for (int i = 0; i < 1; ++i)
                    {
                        for (int j = 0; j < width; ++j)
                        {
                            float u = j / (float)width;
                            float Value_R = Mathf.Clamp01(_data._curve1.Evaluate(u));
                            float Value_G = Mathf.Clamp01(_data._curve2.Evaluate(u));
                            float Value_B = Mathf.Clamp01(_data._curve3.Evaluate(u));
                            pixels[width * i + j] = new Color(Value_R, Value_G, Value_B);
                        }
                    }

                    //保存RT
                    outputData.SetPixels(pixels);
                    outputData.Apply();
                    File.WriteAllBytes(texturePath, outputData.EncodeToTGA());
                    UnityEngine.Object.DestroyImmediate(outputData);
                    EditorUtility.SetDirty(_data);
                    AssetDatabase.SaveAssets();
                    AssetDatabase.Refresh();
                }
            }
        }

        //显示一个归一化的向量 用欧拉角表示
        public static void ShowNormalizeVector(MaterialEditor materialEditor, string _VectorName, string _Title)
        {
            //由于一个唯一的向量能对应多个欧拉角
            //直接滑动从向量推导的欧拉角会导致欧拉角数值闪烁
            //所以这里将欧拉角的数字限定在特定范围内
            Vector3 _FromDir = new Vector3(0, 0, 1);
            Material material = materialEditor.target as Material;
            //将向量转换为欧拉角
            Vector4 _VectorValue = material.GetVector(_VectorName);
            Vector3 _ToDir = new Vector3(_VectorValue.x, _VectorValue.y, _VectorValue.z);
            _ToDir = Vector3.Normalize(_ToDir);
            Quaternion _Rotate = Quaternion.FromToRotation(_FromDir, _ToDir);
            Vector3 _RotateAngle = _Rotate.eulerAngles;
            int _RotateAngle_X = Mathf.RoundToInt(_RotateAngle.x);
            int _RotateAngle_Y = Mathf.RoundToInt(_RotateAngle.y);
            _RotateAngle_X = (_RotateAngle_X + 360) % 360;
            if (_RotateAngle_X > 180)
                _RotateAngle_X = _RotateAngle_X - 360;
            _RotateAngle_Y = (_RotateAngle_Y + 360) % 360;
            if (_RotateAngle_Y > 180)
                _RotateAngle_Y = _RotateAngle_Y - 360;
            if (_RotateAngle_X > 90 || _RotateAngle_X < -90) //x轴旋转幅度太大导致朝向反向
            {
                if (_RotateAngle_X > 90) //俯视
                    _RotateAngle_X = 180 - _RotateAngle_X;
                else if (_RotateAngle_X < -90) //仰视
                    _RotateAngle_X = -180 - _RotateAngle_X;
                _RotateAngle_Y += 180;
                if (_RotateAngle_Y > 180)
                    _RotateAngle_Y = _RotateAngle_Y - 360;
            }

            EditorGUI.BeginChangeCheck();
            Vector2Int _EulerAngle = new Vector2Int(_RotateAngle_X, _RotateAngle_Y);
            string title1 = $"{_Title}_欧拉角_X";
            string title2 = $"{_Title}_欧拉角_Y";
            string describe = "使用欧拉角[x, y, 0]表示归一化的向量\n" +
                "将向量分别围绕世界空间Z轴X轴Y轴旋转zxy角度\n" +
                "与光源组件的transform旋转参数正好相反\n" +
                "z：以向量[0, 0, 1]为出发角度 可忽略z\n" +
                "x：决定俯视[0, 90)和仰视[-90, 0]角度\n" +
                "y：决定朝向([-179, 180]";
            int _Output_X = EditorGUILayout.IntSlider(new GUIContent(title1, describe), _EulerAngle.x, -90, 90);
            int _Output_Y = EditorGUILayout.IntSlider(new GUIContent(title2, describe), _EulerAngle.y, -179, 180);
            if (EditorGUI.EndChangeCheck())
                materialEditor.RegisterPropertyChangeUndo("Change Value"); //注册恢复点

            if (_Output_X != _EulerAngle.x || _Output_Y != _EulerAngle.y)
            {
                //更新缓存
                Vector3 _NewToDir = Quaternion.Euler(_Output_X, _Output_Y, 0) * _FromDir;
                _NewToDir = Vector3.Normalize(_NewToDir);
                material.SetVector(_VectorName, new Vector4(_NewToDir.x, _NewToDir.y, _NewToDir.z, 0));
            }
        }

        public static void ShowPBR_Adujst_Cof(MaterialEditor materialEditor)
        {
            Material material = materialEditor.target as Material;

            if (material.HasProperty("_PBR_Adujst_Cof"))
            {
                EditorGUI.BeginChangeCheck();
                Vector4 _PBR_Adujst_Value = material.GetVector("_PBR_Adujst_Cof");
                float _PBR_Adujst_Value_X = EditorGUILayout.Slider(
                    new GUIContent("环境漫反射系数", "调节环境漫反射比例\n" +
                    "环境漫反射能表现环境整体的明暗\n" +
                    "作为低频光照提供的细节很少"),
                    _PBR_Adujst_Value.x, 0, 10);
                float _PBR_Adujst_Value_Y = EditorGUILayout.Slider(
                    new GUIContent("环境漫反射系数", "调节环境镜面反射比例\n" +
                    "环境漫反射能反射周围环境\n" +
                    "粗糙度高反射越模糊"),
                    _PBR_Adujst_Value.y, 0, 10);
                float _PBR_Adujst_Value_Z = EditorGUILayout.Slider(
                    new GUIContent("直接光漫反射系数", "调节直接光漫反射比例\n" +
                    "简单的兰伯特漫反射"),
                    _PBR_Adujst_Value.z, 0, 10);
                float _PBR_Adujst_Value_W = EditorGUILayout.Slider(
                    new GUIContent("直接光镜面反射系数", "调节直接光镜面反射比例\n" +
                    "粗糙度低高光斑点越小高光峰值越高"),
                    _PBR_Adujst_Value.w, 0, 10);
                if (EditorGUI.EndChangeCheck())
                    materialEditor.RegisterPropertyChangeUndo("Change Value"); //注册恢复点
                if (_PBR_Adujst_Value.x != _PBR_Adujst_Value_X ||
                    _PBR_Adujst_Value.y != _PBR_Adujst_Value_Y ||
                    _PBR_Adujst_Value.z != _PBR_Adujst_Value_Z ||
                    _PBR_Adujst_Value.w != _PBR_Adujst_Value_W)
                {
                    material.SetVector("_PBR_Adujst_Cof", new Vector4(_PBR_Adujst_Value_X, _PBR_Adujst_Value_Y, _PBR_Adujst_Value_Z, _PBR_Adujst_Value_W));
                }
            }
        }

        public static bool ShowDefaultOrCustomGUI(MaterialEditor materialEditor, MaterialProperty[] properties)
        {
            Material material = materialEditor.target as Material;

            if (material != _CurrentTarget)
                _CurrentTarget = material; //更换材质时 检查新材质

            if (_UseOriginalInspector)
            {
                if (GUILayout.Button("Change To Custom UI"))
                    _UseOriginalInspector = false;
                EditorGUILayout.Space();
                materialEditor.PropertiesDefaultGUI(properties);
                return true;
            }

            if (GUILayout.Button("Show All properties"))
                _UseOriginalInspector = true;
            EditorGUILayout.Space();
            return false;
        }

        public void ShowTiling2(MaterialEditor materialEditor, string _SpeedU_Name, string _SpeedV_Name, string title = "UV速度")
        {
            Material material = materialEditor.target as Material;
            float _SpeedU_Value = material.GetFloat(_SpeedU_Name);
            float _SpeedV_Value = material.GetFloat(_SpeedV_Name);
            Vector2 _NewSpeedValue = EditorGUILayout.Vector2Field(title, new Vector2(_SpeedU_Value, _SpeedV_Value));
            if (_NewSpeedValue.x != _SpeedU_Value ||
                _NewSpeedValue.y != _SpeedV_Value)
            {
                material.SetFloat(_SpeedU_Name, _NewSpeedValue.x);
                material.SetFloat(_SpeedV_Name, _NewSpeedValue.y);
            }
        }

        public void ShowTiling6(MaterialEditor materialEditor, string _TilingName, string _SpeedU_Name, string _SpeedV_Name)
        {
            Material material = materialEditor.target as Material;
            Vector4 _TilingValue = material.GetVector(_TilingName);
            float _SpeedU_Value = material.GetFloat(_SpeedU_Name);
            float _SpeedV_Value = material.GetFloat(_SpeedV_Name);
            Vector2 _NewScaleValue = EditorGUILayout.Vector2Field("UV缩放", new Vector2(_TilingValue.x, _TilingValue.y));
            Vector2 _NewOffsetValue = EditorGUILayout.Vector2Field("UV偏移", new Vector2(_TilingValue.z, _TilingValue.w));
            Vector2 _NewSpeedValue = EditorGUILayout.Vector2Field("UV速度", new Vector2(_SpeedU_Value, _SpeedV_Value));
            if (_NewScaleValue.x != _TilingValue.x ||
                _NewScaleValue.y != _TilingValue.y ||
                _NewOffsetValue.x != _TilingValue.z ||
                _NewOffsetValue.y != _TilingValue.w ||
                _NewSpeedValue.x != _SpeedU_Value ||
                _NewSpeedValue.y != _SpeedV_Value)
            {
                material.SetVector(_TilingName, new Vector4(_NewScaleValue.x, _NewScaleValue.y, _NewOffsetValue.x, _NewOffsetValue.y));
                material.SetFloat(_SpeedU_Name, _NewSpeedValue.x);
                material.SetFloat(_SpeedV_Name, _NewSpeedValue.y);
            }
        }

        public static void ShowTiling4NoOffset(MaterialEditor materialEditor, string _TilingName, string title1 = "UV缩放", string title2 = "UV速度")
        {
            Material material = materialEditor.target as Material;
            EditorGUI.BeginChangeCheck();
            Vector4 _TilingValue = material.GetVector(_TilingName);
            Vector2 _NewScaleValue = EditorGUILayout.Vector2Field(title1, new Vector2(_TilingValue.x, _TilingValue.y));
            Vector2 _NewSpeedValue = EditorGUILayout.Vector2Field(title2, new Vector2(_TilingValue.z, _TilingValue.w));
            if (EditorGUI.EndChangeCheck()) //注册Undo失败
                materialEditor.RegisterPropertyChangeUndo("Change Value"); //注册恢复点
            if (_NewScaleValue.x != _TilingValue.x ||
                _NewScaleValue.y != _TilingValue.y ||
                _NewSpeedValue.x != _TilingValue.z ||
                _NewSpeedValue.y != _TilingValue.w)
                material.SetVector(_TilingName, new Vector4(_NewScaleValue.x, _NewScaleValue.y, _NewSpeedValue.x, _NewSpeedValue.y));
        }
        #endregion

        #region 全局定义Only
        public static bool _ShowRenderingOption = true; //默认显示渲染选项
        public static bool _ShowMateialTool = false; //默认显示材质工具
        public static bool _ShowMateralTool_CombineBaseMap = false;
        public static bool _ShowMateralTool_CombineMaskMap = false;
        public static bool _ShowMateralTool_CombineCustomMap = false;
        public static bool _ShowDebugOption = false; //默认关闭Debug工具

        //全局状态
        public static bool _UseOriginalInspector = false;
        public static Material _CurrentTarget;

        //合并贴图通道用属性
        public static Texture texture1;
        public static Texture texture2;
        public static Texture texture3;
        public static Texture texture4;
        public static int texture1ChannelIndex;
        public static int texture2ChannelIndex;
        public static int texture3ChannelIndex;
        public static int texture4ChannelIndex;
        public static float RChannelDefaultValue;
        public static float GChannelDefaultValue;
        public static float BChannelDefaultValue;
        public static string _textureTargetFolder;
        public static string _textureTargetName;

        //Debug工具相关
        public static int _DebugMode = 0; //1：模型数据/2：材质数据/3：BRDF数据/4：光源数据/5：输出构成

        //------------------------Debug关键字--------------------------
        public const string debug_uv = "_DEBUG_UV";
        public const string debug_normal = "_DEBUG_NORMAL";
        public const string debug_tangent = "_DEBUG_TANGENT";
        public const string debug_position = "_DEBUG_POSITION";

        public const string debug_basemap = "_DEBUG_BASEMAP";
        public const string debug_alpha = "_DEBUG_ALPHA";
        public const string debug_metallic = "_DEBUG_METALLIC";
        public const string debug_ao = "_DEBUG_AO";
        public const string debug_roughness = "_DEBUG_ROUGHNESS";
        public const string debug_emission_mask = "_DEBUG_EMISSION_MASK";
        public const string debug_specular_level = "_DEBUG_SPECULAR_LEVEL";
        public const string debug_skin_mask = "_DEBUG_SKIN_MASK";

        public const string debug_skin_brdf = "_DEBUG_SKIN_BRDF";
        public const string debug_diffuse = "_DEBUG_BRDF_DIFFUSE";
        public const string debug_f0 = "_DEBUG_BRDF_FO";

        public const string debug_mainshadow_atten = "_DEBUG_MAINSHADOW_ATTEN";
        public const string debug_envir_diffuse_light = "_DEBUG_ENVIR_DIFFUSE_LIGHT";
        public const string debug_envir_specular_light = "_DEBUG_ENVIR_SPECULAR_LIGHT";
        public const string debug_scene_gi = "_DEBUG_SCENE_GI";

        public const string debug_envir_output = "_DEBUG_ENVIR_OUTPUT";
        public const string debug_envir_diffuse_output = "_DEBUG_ENVIR_DIFFUSE_OUTPUT";
        public const string debug_envir_specular_output = "_DEBUG_ENVIR_SPECULAR_OUTPUT";
        public const string debug_main_output = "_DEBUG_MAIN_OUTPUT";
        public const string debug_main_diffuse_output = "_DEBUG_MAIN_DIFFUSE_OUTPUT";
        public const string debug_main_specular_output = "_DEBUG_MAIN_SPECULAR_OUTPUT";
        public const string debug_addittive_output = "_DEBUG_ADDITIVE_OUTPUT";
        public const string debug_emission_output = "_DEBUG_EMISSION_OUTPUT";

        public static List<string> debugKeywords = new List<string>
        {
            debug_uv,
            debug_normal, //模型法线
            debug_tangent,
            debug_position,

            debug_basemap,
            debug_alpha ,
            debug_metallic,
            debug_ao,
            debug_roughness,
            debug_emission_mask,
            debug_specular_level,
            debug_skin_mask,

            debug_skin_brdf, //皮肤表面衰减球 亮白暗红
            debug_diffuse,
            debug_f0,

            debug_mainshadow_atten,
            debug_envir_diffuse_light,
            debug_envir_specular_light,
            debug_scene_gi,

            debug_envir_output,
            debug_envir_diffuse_output,
            debug_envir_specular_output,
            debug_main_output,
            debug_main_diffuse_output,
            debug_main_specular_output,
            debug_addittive_output,
            debug_emission_output
        };

        //-------------------------------- Texture ----------------------------------------------
        public const string defaultEnvirCubemap = "615c11389c823354ea97f70f1f6f2de2";

        public static Texture _default_Texture_EnvirCubemap;
        public static Texture default_Texture_EnvirCubemap
        {
            get
            {
                if (_default_Texture_EnvirCubemap == null)
                {
                    string texturePath = AssetDatabase.GUIDToAssetPath(defaultEnvirCubemap);
                    _default_Texture_EnvirCubemap = AssetDatabase.LoadAssetAtPath<Texture>(texturePath);
                    if (_default_Texture_EnvirCubemap == null)
                        Debug.LogError("没找到EnvirCubemap贴图");
                }
                return _default_Texture_EnvirCubemap;
            }
        }
        #endregion //全局定义Only

        #region 公共代码 文件收集-读写-关键字设置

        public static void CleanMaterialProperty(Material material, ref int count)
        {
            bool CleanTextureProperty(SerializedProperty property, Material mat)
            {
                bool res = false;
                for (int j = property.arraySize - 1; j >= 0; j--)
                {
                    string propertyName = property.GetArrayElementAtIndex(j).FindPropertyRelative("first").stringValue;
                    if (!mat.HasProperty(propertyName))
                    {
                        if (propertyName == "_MainTex")
                        {
                            if (property.GetArrayElementAtIndex(j).FindPropertyRelative("second").FindPropertyRelative("m_Texture").objectReferenceValue != null)
                            {
                                property.GetArrayElementAtIndex(j).FindPropertyRelative("second").FindPropertyRelative("m_Texture").objectReferenceValue = null;
                                res = true;
                            }
                        }
                        else
                        {
                            property.DeleteArrayElementAtIndex(j);
                            Debug.Log("Delete 贴图属性 in serialized object:" + propertyName);
                            res = true;
                        }
                    }
                }
                return res;
            }

            bool CleanFloatProperty(SerializedProperty property, Material mat)
            {
                bool res = false;
                for (int j = property.arraySize - 1; j >= 0; j--)
                {
                    string propertyName = property.GetArrayElementAtIndex(j).FindPropertyRelative("first").stringValue;
                    if (!mat.HasProperty(propertyName))
                    {
                        property.DeleteArrayElementAtIndex(j);
                        Debug.Log("Delete 浮点数属性 in serialized object:" + propertyName);
                        res = true;
                    }
                }
                return res;
            }

            bool CleanColorProperty(SerializedProperty property, Material mat)
            {
                bool res = false;
                for (int j = property.arraySize - 1; j >= 0; j--)
                {
                    string propertyName = property.GetArrayElementAtIndex(j).FindPropertyRelative("first").stringValue;
                    if (!mat.HasProperty(propertyName))
                    {
                        property.DeleteArrayElementAtIndex(j);
                        Debug.Log("Delete 颜色属性 in serialized object:" + propertyName);
                        res = true;
                    }
                }
                return res;
            }

            if (material == null)
                return;
            SerializedObject psSource = new SerializedObject(material);

            SerializedProperty emissionProperty = psSource.FindProperty("m_SavedProperties");
            SerializedProperty texEnvs = emissionProperty.FindPropertyRelative("m_TexEnvs");
            SerializedProperty floats = emissionProperty.FindPropertyRelative("m_Floats");
            SerializedProperty colors = emissionProperty.FindPropertyRelative("m_Colors");
            CleanTextureProperty(texEnvs, material);
            CleanFloatProperty(floats, material);
            CleanColorProperty(colors, material);

            psSource.ApplyModifiedProperties();
            EditorUtility.SetDirty(material);
            count += 1;
        }

        public static void CleanMaterialKeyWord(Material material, ref int count)
        {
            if (material == null)
                return;
            if (material.shaderKeywords.Length == 0)
                return;
            material.shaderKeywords = new string[0];
            EditorUtility.SetDirty(material);
            count += 1;
        }

        public static void CheckTextureReadable(Texture texture)
        {
            string texturePath = AssetDatabase.GetAssetPath(texture);
            TextureImporter importer = AssetImporter.GetAtPath(texturePath) as TextureImporter;
            if (!importer.isReadable)
            {
                importer.isReadable = true;
                AssetDatabase.ImportAsset(texturePath);
                AssetDatabase.Refresh();
            }
        }

        public static void CheckTextureNoSrgb(Texture texture)
        {
            string texturePath = AssetDatabase.GetAssetPath(texture);
            TextureImporter importer = AssetImporter.GetAtPath(texturePath) as TextureImporter;
            if (importer.sRGBTexture)
            {
                importer.sRGBTexture = false;
                AssetDatabase.ImportAsset(texturePath);
                AssetDatabase.Refresh();
            }
        }

        public static void CheckTextureNoCompress(Texture texture)
        {
            string texturePath = AssetDatabase.GetAssetPath(texture);
            TextureImporter importer = AssetImporter.GetAtPath(texturePath) as TextureImporter;
            if (importer.textureCompression != TextureImporterCompression.Uncompressed)
            {
                importer.textureCompression = TextureImporterCompression.Uncompressed;
                AssetDatabase.ImportAsset(texturePath);
                AssetDatabase.Refresh();
            }
        }

        public static void CheckTextureTypeNormal(Texture texture)
        {
            string texturePath = AssetDatabase.GetAssetPath(texture);
            TextureImporter importer = AssetImporter.GetAtPath(texturePath) as TextureImporter;
            if (importer.textureType != TextureImporterType.NormalMap)
            {
                importer.textureType = TextureImporterType.NormalMap;
                AssetDatabase.ImportAsset(texturePath);
                AssetDatabase.Refresh();
            }
        }

        public static void CheckTextureNoMipmap(Texture texture)
        {
            string texturePath = AssetDatabase.GetAssetPath(texture);
            TextureImporter importer = AssetImporter.GetAtPath(texturePath) as TextureImporter;
            if (importer.mipmapEnabled)
            {
                importer.mipmapEnabled = false;
                AssetDatabase.ImportAsset(texturePath);
                AssetDatabase.Refresh();
                Debug.LogError("已关闭贴图的mip：" + texturePath, texture);
            }
        }

        public static float SRGBToLinear(float c)
        {
            float x = Mathf.Max(0.0001f, c);
            return Mathf.Pow(x, 2.2f);
        }

        public static string ChangeObsolutePathToUnityPath(string path)
        {
            string result = path.Substring(path.IndexOf("Assets"));
            return result.Replace('\\', '/');
        }

        public static string GetTransPath(Transform trans)
        {
            if (trans.parent == null)
                return trans.name;
            return GetTransPath(trans.parent) + "/" + trans.name;
        }

        public static void GetFileAllReferences(string fileGUID, List<string> resultGUIDs)
        {
            if (Sekia.ReferenceFinderWindow.data.assetDict.ContainsKey(fileGUID) &&
                Sekia.ReferenceFinderWindow.data.assetDict[fileGUID].references.Count > 0)
            {
                foreach (var itemGuid in Sekia.ReferenceFinderWindow.data.assetDict[fileGUID].references)
                {
                    if (!resultGUIDs.Contains(itemGuid))
                    {
                        resultGUIDs.Add(itemGuid);
                        GetFileAllReferences(itemGuid, resultGUIDs);
                    }
                }
            }
        }

        public static Vector4[] TransferSHtoCoefficients(SphericalHarmonicsL2 sh)
        {
            var shCoefficients = new Vector4[7];
            //unity_SHAr unity_SHAg unity_SHAb
            for (int i = 0; i < 3; ++i) //L0在3个float4的w分量
            {
                shCoefficients[i].x = sh[i, 3]; //xyz分量对应的通道待定
                shCoefficients[i].y = sh[i, 1];
                shCoefficients[i].z = sh[i, 2];
                shCoefficients[i].w = sh[i, 0] - sh[i, 6];
            }
            //unity_SHBr unity_SHBg unity_SHBb
            for (int i = 0; i < 3; ++i)
            {
                shCoefficients[i + 3].x = sh[i, 4];
                shCoefficients[i + 3].y = sh[i, 5];
                shCoefficients[i + 3].z = 3.0f * sh[i, 6];
                shCoefficients[i + 3].w = sh[i, 7];
            }
            //unity_SHC
            shCoefficients[6].x = sh[0, 8];
            shCoefficients[6].y = sh[1, 8];
            shCoefficients[6].z = sh[2, 8];
            shCoefficients[6].w = 1.0f;

            string result = "";
            for (int i = 0; i < 7; ++i)
            {
                result += shCoefficients[i].x.ToString() + ";";
                result += shCoefficients[i].y.ToString() + ";";
                result += shCoefficients[i].z.ToString() + ";";
                result += shCoefficients[i].w.ToString() + ";";
            }
            Debug.LogError("采样结果：" + result);

            return shCoefficients;
        }

        public static void DisableAllDebugKeywords(string exceptKeyWord = null)
        {
            if (string.IsNullOrEmpty(exceptKeyWord))
            {
                foreach (var keyword in debugKeywords)
                    Shader.DisableKeyword(keyword);
            }
            else
            {
                foreach (var keyword in debugKeywords)
                {
                    if (keyword != exceptKeyWord)
                        Shader.DisableKeyword(keyword);
                }
            }
        }

        public static void EnableOneDebugKeyword(string keyword)
        {
            DisableAllDebugKeywords(keyword);
            Shader.EnableKeyword(keyword);
        }

        public static void GetAllChildGameObject(GameObject target, List<GameObject> result)
        {
            result.Add(target);
            int childCount = target.transform.childCount;
            if (childCount > 0)
            {
                for (int i = 0; i < childCount; ++i)
                {
                    GetAllChildGameObject(target.transform.GetChild(i).gameObject, result);
                }
            }
        }

        public static List<GameObject> GetAllSelectedGameObjects()
        {
            List<GameObject> result = new List<GameObject>();
            if (Selection.objects.Length == 0)
                Debug.LogError("必须选中一个GameObject");
            else
            {
                foreach (var obj in Selection.objects)
                {
                    var target = obj as GameObject;
                    if (target == null)
                        continue;
                    GetAllChildGameObject(target, result);
                }
            }
            return result;
        }

        //对选中项 获取选中的所有非meta文件
        public static List<string> GetAllSelectedFilesWithNoMeta()
        {
            List<string> allSelectedFiles = new List<string>();
            List<string> allSelectedDirs = new List<string>();
            foreach (var obj in Selection.objects)
            {
                string objPath = AssetDatabase.GetAssetPath(obj);
                if (string.IsNullOrEmpty(objPath))
                    continue;
                DirectoryInfo dir = new DirectoryInfo(objPath);

                //Debug.LogError("遍历选中项(需要激活Inspector)：" + objPath);
                if (dir.Exists) //判断是否是目录类型
                    allSelectedDirs.Add(objPath);
                else
                    allSelectedFiles.Add(objPath);
            }

            foreach (var dir in allSelectedDirs)
            {
                foreach (var file in GetAllFiles(dir))
                {
                    if (!file.EndsWith(".meta"))
                        allSelectedFiles.Add(file.Replace('\\', '/'));
                }
            }

            return allSelectedFiles;
        }

        //收集指定文件夹中全部预制体的deps
        public static void GetFileAllDependencies(string file, List<string> result)
        {
            var deps = AssetDatabase.GetDependencies(file, true);
            if (deps.Length > 0)
            {
                foreach (var dep in deps)
                {
                    if (dep != file && !result.Contains(dep))
                        result.Add(dep);
                }
            }
        }

        //对单个材质 收集某个属性对应的贴图
        public static void getMatTexturePath(string properName, Material material, List<string> list)
        {
            if (!material.HasProperty(properName))
                return;
            Texture texture = material.GetTexture(properName);
            if (texture == null)
                return;
            string path = AssetDatabase.GetAssetPath(texture);
            if (string.IsNullOrEmpty(path))
                return;
            if (!list.Contains(path))
                list.Add(path);
        }

        private static List<string> GetAllFiles(string path)
        {
            void GetAllFilesInDirectory(string current_path, List<string> container)
            {
                container.AddRange(Directory.GetFiles(current_path)); //收集本地文件
                string[] dirs = Directory.GetDirectories(current_path);
                if (dirs.Length > 0)
                {
                    foreach (var k in dirs)
                    {
                        GetAllFilesInDirectory(k, container);
                    }
                }
            }

            List<string> result = new List<string>();
            GetAllFilesInDirectory(path, result);
            return result;
        }

        public static void MoveFile(string source, string target)
        {
            FileInfo a = new FileInfo(source);
            FileInfo b = new FileInfo(target);
            if (a.Directory.Equals(b.Directory) && a.Name.Equals(b.Name))
                return;
            //Debug.LogError(string.Format("form {0} to {1}", source, target));
            if (File.Exists(target))
                File.Delete(target);
            File.Move(source, target);
            string sourceMeta = source + ".meta";
            string targetMeta = target + ".meta";
            if (File.Exists(targetMeta))
                File.Delete(targetMeta);
            File.Move(sourceMeta, targetMeta);
            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();
        }

        #endregion


        [MenuItem("Assets/TA工具/修改FBX", false, 27)]
        static void OneKeyCustomFbxExporter()
        {
            Debug.LogError("开始...");
            List<string> allSelectedFiles = GetAllSelectedFilesWithNoMeta();
            int count = 0;
            foreach (var file in allSelectedFiles)
            {
                if (!file.EndsWith(".fbx") && !file.EndsWith(".FBX"))
                    continue;
                GameObject fbxGameObject = AssetDatabase.LoadAssetAtPath<GameObject>(file);
                string filename = fbxGameObject.name;
                var folderPath = Path.GetDirectoryName(file);
                var filePath = System.IO.Path.Combine(folderPath, filename + "1.fbx");

                {
                    ModelExporter.LastFilePath = filePath;
                    Dictionary<Mesh, FbxNode> sharedMeshes = new Dictionary<Mesh, FbxNode>();
                    int meshNodeCounter = 0;

                    using (var fbxExporter = new ModelExporter())
                    {
                        var exportOptions = ExportSettings.instance.ExportModelSettings.info;
                        if (exportOptions == null)
                            exportOptions = ModelExporter.DefaultOptions as ExportModelSettingsSerialize;
                        Debug.Log($"当前的动画导出设置：{exportOptions.ModelAnimIncludeOption}");
                        Debug.Log($"KeepInstances设置：{exportOptions.KeepInstances}");

                        fbxExporter.ExportOptions = exportOptions;

                        AnimationOnlyExportData GetExportData(GameObject go, IExportOptions exportOptions = null)
                        {
                            if (exportOptions.ModelAnimIncludeOption == ExportSettings.Include.Model)
                                return null;

                            // gather all animation clips
                            var legacyAnim = go.GetComponentsInChildren<Animation>();
                            var genericAnim = go.GetComponentsInChildren<Animator>();

                            var exportData = new AnimationOnlyExportData();

                            int depthFromRootAnimation = int.MaxValue;
                            Animation rootAnimation = null;
                            foreach (var anim in legacyAnim)
                            {
                                int count = ModelExporter.GetObjectToRootDepth(anim.transform, go.transform);

                                if (count < depthFromRootAnimation)
                                {
                                    depthFromRootAnimation = count;
                                    rootAnimation = anim;
                                }

                                var animClips = AnimationUtility.GetAnimationClips(anim.gameObject);
                                exportData.CollectDependencies(animClips, anim.gameObject, exportOptions);
                            }

                            int depthFromRootAnimator = int.MaxValue;
                            Animator rootAnimator = null;
                            foreach (var anim in genericAnim)
                            {
                                int count = ModelExporter.GetObjectToRootDepth(anim.transform, go.transform);

                                if (count < depthFromRootAnimator)
                                {
                                    depthFromRootAnimator = count;
                                    rootAnimator = anim;
                                }

                                // Try the animator controller (mecanim)
                                var controller = anim.runtimeAnimatorController;
                                if (controller)
                                {
                                    exportData.CollectDependencies(controller.animationClips, anim.gameObject, exportOptions);
                                }
                            }

                            // set the first clip to export
                            if (depthFromRootAnimation < depthFromRootAnimator)
                            {
                                exportData.defaultClip = rootAnimation.clip;
                            }
                            else if (rootAnimator)
                            {
                                // Try the animator controller (mecanim)
                                var controller = rootAnimator.runtimeAnimatorController;
                                if (controller)
                                {
                                    var dController = controller as UnityEditor.Animations.AnimatorController;
                                    if (dController && dController.layers.Length > 0)
                                    {
                                        var motion = dController.layers[0].stateMachine.defaultState.motion;
                                        var defaultClip = motion as AnimationClip;
                                        if (defaultClip)
                                        {
                                            exportData.defaultClip = defaultClip;
                                        }
                                        else
                                        {
                                            if (motion != null)
                                            {
                                                Debug.LogWarningFormat("Couldn't export motion {0}", motion.name);
                                            }
                                            // missing animation
                                            else
                                            {
                                                Debug.LogWarningFormat("Couldn't export motion. Motion is missing.");
                                            }
                                        }
                                    }
                                }
                            }
                            return exportData;
                        }

                        int GetAnimOnlyHierarchyCount(IExportData data)
                        {
                            var completeExpSet = new HashSet<GameObject>();

                            {
                                if (data == null || data.Objects == null || data.Objects.Count <= 0)
                                {
                                    return 0;
                                }
                                foreach (var go in data.Objects)
                                {
                                    completeExpSet.Add(go); //添加Animator的所有父级节点

                                    var parent = go.transform.parent;
                                    while (parent != null && completeExpSet.Add(parent.gameObject))
                                    {
                                        parent = parent.parent;
                                    }
                                }
                            }

                            return completeExpSet.Count;
                        }

                        int GetHierarchyCount(GameObject exportSet)
                        {
                            int count = 0;
                            Queue<GameObject> queue = new Queue<GameObject>();
                            queue.Enqueue(exportSet);
                            while (queue.Count > 0)
                            {
                                var obj = queue.Dequeue();
                                var objTransform = obj.transform; //添加所有节点
                                foreach (Transform child in objTransform)
                                {
                                    queue.Enqueue(child.gameObject);
                                }
                                count++;
                            }
                            return count;
                        }

                        bool ExportProgressCallback(float percentage, string status)
                        {
                            // Convert from percentage to [0,1].
                            // Then convert from that to [0.5,1] because the first half of
                            // the progress bar was for creating the scene.
                            var progress01 = 0.5f * (1f + (percentage / 100.0f));

                            bool cancel = EditorUtility.DisplayCancelableProgressBar("CustomFbxExporter", "Exporting Scene...", progress01);

                            if (cancel)
                            {
                                ModelExporter.exportCancelled = true;
                            }

                            // Unity says "true" for "cancel"; FBX wants "true" for "continue"
                            return !cancel;
                        }

                        int ExportAnimationOnly(GameObject unityGO, FbxScene fbxScene, int exportProgress,
                                int objectCount, Vector3 newCenter, IExportData data, ModelExporter.TransformExportType exportType = ModelExporter.TransformExportType.Local)
                        {
                            AnimationOnlyExportData exportData = (AnimationOnlyExportData)data;
                            int numObjectsExported = exportProgress;

                            // make sure anim destination node is exported as well
                            var exportSet = exportData.Objects;
                            if (exportOptions.AnimationDest && exportOptions.AnimationSource)
                            {
                                exportSet.Add(exportOptions.AnimationDest.gameObject);
                            }

                            // first export all the animated bones that are in the export set
                            // as only a subset of bones are exported, but we still need to make sure the bone transforms are correct
                            if (!fbxExporter.ExportAnimatedBones(unityGO, fbxScene, ref numObjectsExported, objectCount, exportData))
                            {
                                // export cancelled
                                return -1;
                            }

                            // export everything else and make sure all nodes are connected
                            foreach (var go in exportSet)
                            {
                                FbxNode node;
                                if (!fbxExporter.ExportGameObjectAndParents(
                                    go, unityGO, fbxScene, out node, newCenter, exportType, ref numObjectsExported, objectCount
                                    ))
                                {
                                    // export cancelled
                                    return -1;
                                }

                                fbxExporter.ExportConstraints(go, fbxScene, node);

                                System.Type compType;
                                if (exportData.exportComponent.TryGetValue(go, out compType))
                                {
                                    if (compType == typeof(Light))
                                    {
                                        fbxExporter.ExportLight(go, fbxScene, node);
                                    }
                                    else if (compType == typeof(Camera))
                                    {
                                        fbxExporter.ExportCamera(go, fbxScene, node);
                                    }
                                    else if (compType == typeof(SkinnedMeshRenderer))
                                    {
                                        // export only what is necessary for exporting blendshape animation
                                        var unitySkin = go.GetComponent<SkinnedMeshRenderer>();
                                        var meshInfo = new ModelExporter.MeshInfo(unitySkin.sharedMesh, unitySkin.sharedMaterials);
                                        fbxExporter.ExportMesh(meshInfo, node);
                                    }
                                }
                            }

                            return numObjectsExported;
                        }

                        int ExportTransformHierarchy(GameObject unityGo, FbxScene fbxScene, FbxNode fbxNodeParent,
                               int exportProgress, int objectCount, Vector3 newCenter, ModelExporter.TransformExportType exportType = ModelExporter.TransformExportType.Local,
                               ExportSettings.LODExportType lodExportType = ExportSettings.LODExportType.All)
                        {
                            int numObjectsExported = exportProgress;

                            FbxNode fbxNode = fbxExporter.CreateFbxNode(unityGo, fbxScene);

                            if (fbxExporter.Verbose)
                                Debug.Log(string.Format("exporting {0}", fbxNode.GetName()));

                            numObjectsExported++;
                            if (EditorUtility.DisplayCancelableProgressBar(
                                    ModelExporter.ProgressBarTitle,
                                    string.Format("Creating FbxNode {0}/{1}", numObjectsExported, objectCount),
                                    (numObjectsExported / (float)objectCount) * 0.25f))
                            {
                                // cancel silently
                                return -1;
                            }

                            fbxExporter.ExportTransform(unityGo.transform, fbxNode, newCenter, exportType);

                            fbxNodeParent.AddChild(fbxNode);

                            // if this object has an LOD group, then export according to the LOD preference setting
                            var lodGroup = unityGo.GetComponent<LODGroup>();
                            if (lodGroup && lodExportType != ExportSettings.LODExportType.All)
                            {
                                LOD[] lods = lodGroup.GetLODs();

                                // LODs are ordered from highest to lowest.
                                // If exporting lowest LOD, reverse the array
                                if (lodExportType == ExportSettings.LODExportType.Lowest)
                                {
                                    // reverse the array
                                    LOD[] tempLods = new LOD[lods.Length];
                                    System.Array.Copy(lods, tempLods, lods.Length);
                                    System.Array.Reverse(tempLods);
                                    lods = tempLods;
                                }

                                for (int i = 0; i < lods.Length; i++)
                                {
                                    var lod = lods[i];
                                    bool exportedRenderer = false;
                                    foreach (var renderer in lod.renderers)
                                    {
                                        // only export if parented under LOD group
                                        if (renderer.transform.parent == unityGo.transform)
                                        {
                                            numObjectsExported = ExportTransformHierarchy(renderer.gameObject, fbxScene, fbxNode, numObjectsExported, objectCount, newCenter, lodExportType: lodExportType);
                                            exportedRenderer = true;
                                        }
                                        else if (fbxExporter.Verbose)
                                        {
                                            Debug.LogFormat("FbxExporter: Not exporting LOD {0}: {1}", i, renderer.name);
                                        }
                                    }

                                    // if at least one renderer for this LOD was exported, then we succeeded
                                    // so stop exporting.
                                    if (exportedRenderer)
                                    {
                                        return numObjectsExported;
                                    }
                                }
                            }

                            // now  unityGo  through our children and recurse
                            foreach (Transform childT in unityGo.transform)
                            {
                                numObjectsExported = ExportTransformHierarchy(childT.gameObject, fbxScene, fbxNode, numObjectsExported, objectCount, newCenter, lodExportType: lodExportType);
                            }

                            return numObjectsExported;
                        }

                        //为重复存在的mesh标记实例而不是全部导出
                        bool ExportInstance(GameObject unityGo, FbxScene fbxScene, FbxNode fbxNode)
                        {
                            if (!unityGo || fbxNode == null)
                            {
                                return false;
                            }

                            // where the fbx mesh is stored on a successful export
                            FbxMesh fbxMesh = null;
                            // store the shared mesh of the game object
                            Mesh unityGoMesh = null;

                            // get the mesh of the game object
                            if (unityGo.TryGetComponent<MeshFilter>(out MeshFilter meshFilter))
                            {
                                unityGoMesh = meshFilter.sharedMesh;
                            }

                            if (!unityGoMesh)
                            {
                                return false;
                            }
                            //判断是否有共享的mesh 如果存在则导出为实例 export mesh as an instance if it is a duplicate mesh or a prefab
                            else if (sharedMeshes.TryGetValue(unityGoMesh, out FbxNode node))
                            {
                                if (fbxExporter.Verbose)
                                {
                                    Debug.Log(string.Format("exporting instance {0}", unityGo.name));
                                }

                                //取出在ExportMesh流程中生成好的mesh
                                fbxMesh = node.GetMesh();
                            }
                            // unique mesh, so save it to find future duplicates
                            //没有出现过的mesh 缓存后在ExportMesh流程中导出
                            else
                            {
                                sharedMeshes.Add(unityGoMesh, fbxNode);
                                return false;
                            }

                            // mesh doesn't exist or wasn't exported successfully
                            if (fbxMesh == null)
                            {
                                return false;
                            }

                            // We don't export the mesh because we already have it from the parent, but we still need to assign the material
                            var renderer = unityGo.GetComponent<Renderer>();
                            var materials = renderer ? renderer.sharedMaterials : null;

                            Autodesk.Fbx.FbxSurfaceMaterial newMaterial = null;
                            if (materials != null)
                            {
                                foreach (var mat in materials)
                                {
                                    if (mat != null && fbxExporter.MaterialMap.TryGetValue(mat.GetInstanceID(), out newMaterial))
                                    {
                                        fbxNode.AddMaterial(newMaterial);
                                    }
                                    else
                                    {
                                        // create new material
                                        fbxExporter.ExportMaterial(mat, fbxScene, fbxNode);
                                    }
                                }
                            }

                            // set the fbxNode containing the mesh
                            fbxNode.SetNodeAttribute(fbxMesh);
                            fbxNode.SetShadingMode(FbxNode.EShadingMode.eWireFrame);

                            return true;
                        }

                        //导出静态mesh到节点
                        bool ExportMesh2(ModelExporter.MeshInfo meshInfo, FbxNode fbxNode)
                        {
                            if (!meshInfo.IsValid)
                            {
                                return false;
                            }

                            fbxExporter.NumMeshes++;
                            fbxExporter.NumTriangles += meshInfo.Triangles.Length / 3;

                            // create the mesh structure.
                            var fbxScene = fbxNode.GetScene();
                            FbxMesh fbxMesh = FbxMesh.Create(fbxScene, "Scene");
                            Debug.LogError($"fbxMeshName：{fbxMesh.GetName()}");

                            // Create control points.
                            fbxExporter.ControlPointToIndex.Clear();
                            {
                                var vertices = meshInfo.Vertices;
                                for (int v = 0, n = meshInfo.VertexCount; v < n; v++)
                                {
                                    if (fbxExporter.ControlPointToIndex.ContainsKey(vertices[v]))
                                    {
                                        continue;
                                    }
                                    fbxExporter.ControlPointToIndex[vertices[v]] = fbxExporter.ControlPointToIndex.Count();
                                }
                                fbxMesh.InitControlPoints(fbxExporter.ControlPointToIndex.Count());

                                foreach (var kvp in fbxExporter.ControlPointToIndex)
                                {
                                    var controlPoint = kvp.Key;
                                    var index = kvp.Value;
                                    fbxMesh.SetControlPointAt(ModelExporter.ConvertToFbxVector4(controlPoint, ModelExporter.UnitScaleFactor), index);
                                }
                            }

                            var unmergedPolygons = new List<int>();
                            var mesh = meshInfo.mesh;
                            for (int s = 0; s < mesh.subMeshCount; s++)
                            {
                                var topology = mesh.GetTopology(s);
                                var indices = mesh.GetIndices(s);

                                int polySize;
                                int[] vertOrder;

                                switch (topology)
                                {
                                    case MeshTopology.Triangles:
                                        polySize = 3;
                                        vertOrder = new int[] { 0, 1, 2 };
                                        break;
                                    case MeshTopology.Quads:
                                        polySize = 4;
                                        vertOrder = new int[] { 0, 1, 2, 3 };
                                        break;
                                    case MeshTopology.Lines:
                                        throw new System.NotImplementedException();
                                    case MeshTopology.Points:
                                        throw new System.NotImplementedException();
                                    case MeshTopology.LineStrip:
                                        throw new System.NotImplementedException();
                                    default:
                                        throw new System.NotImplementedException();
                                }

                                for (int f = 0; f < indices.Length / polySize; f++)
                                {
                                    fbxMesh.BeginPolygon();

                                    foreach (int val in vertOrder)
                                    {
                                        int polyVert = indices[polySize * f + val];

                                        // Save the polygon order (without merging vertices) so we
                                        // properly export UVs, normals, binormals, etc.
                                        unmergedPolygons.Add(polyVert);

                                        polyVert = fbxExporter.ControlPointToIndex[meshInfo.Vertices[polyVert]];
                                        fbxMesh.AddPolygon(polyVert);

                                    }
                                    fbxMesh.EndPolygon();
                                }
                            }

                            // Set up materials per submesh.
                            foreach (var mat in meshInfo.Materials)
                            {
                                fbxExporter.ExportMaterial(mat, fbxScene, fbxNode);
                            }
                            fbxExporter.AssignLayerElementMaterial(fbxMesh, meshInfo.mesh, meshInfo.Materials.Length);

                            // Set up normals, etc.
                            fbxExporter.ExportComponentAttributes(meshInfo, fbxMesh, unmergedPolygons.ToArray());

                            // Set up blend shapes.
                            FbxBlendShape fbxBlendShape = fbxExporter.ExportBlendShapes(meshInfo, fbxMesh, fbxScene, unmergedPolygons.ToArray());

                            if (fbxBlendShape != null && fbxBlendShape.GetBlendShapeChannelCount() > 0)
                            {
                                // Populate mapping for faster lookup when exporting blendshape animations
                                List<FbxBlendShapeChannel> blendshapeChannels;
                                if (!fbxExporter.MapUnityObjectToBlendShapes.TryGetValue(fbxNode, out blendshapeChannels))
                                {
                                    blendshapeChannels = new List<FbxBlendShapeChannel>();
                                    fbxExporter.MapUnityObjectToBlendShapes.Add(fbxNode, blendshapeChannels);
                                }

                                for (int i = 0; i < fbxBlendShape.GetBlendShapeChannelCount(); i++)
                                {
                                    var bsChannel = fbxBlendShape.GetBlendShapeChannel(i);
                                    blendshapeChannels.Add(bsChannel);
                                }
                            }

                            fbxNode.SetName(meshNodeCounter.ToString());
                            meshNodeCounter++;

                            // set the fbxNode containing the mesh
                            fbxNode.SetNodeAttribute(fbxMesh);
                            Debug.LogError($"fbxMeshName：{fbxMesh.GetName()}");
                            fbxNode.SetShadingMode(FbxNode.EShadingMode.eWireFrame);
                            return true;
                        }

                        //判断Mesh导出类型
                        bool ExportMesh1(GameObject gameObject, FbxNode fbxNode)
                        {
                            // First allow the object-based callbacks to have a hack at it.
                            foreach (var callback in ModelExporter.MeshForObjectCallbacks)
                            {
                                if (callback(fbxExporter, gameObject, fbxNode))
                                {
                                    return true;
                                }
                            }

                            // Next iterate over components and allow the component-based
                            // callbacks to have a hack at it. This is complicated by the
                            // potential of subclassing. While we're iterating we keep the
                            // first MeshFilter or SkinnedMeshRenderer we find.
                            Component defaultComponent = null;
                            foreach (var component in gameObject.GetComponents<Component>())
                            {
                                if (!component)
                                {
                                    continue;
                                }
                                var monoBehaviour = component as MonoBehaviour;
                                if (!monoBehaviour)
                                {
                                    // Check for default handling. But don't commit yet.
                                    if (defaultComponent)
                                    {
                                        continue;
                                    }
                                    else if (component is MeshFilter)
                                    {
                                        defaultComponent = component;
                                    }
                                    else if (component is SkinnedMeshRenderer)
                                    {
                                        defaultComponent = component;
                                    }
                                }
                                else
                                {
                                    // Check if we have custom behaviour for this component type, or
                                    // one of its base classes.
                                    if (!monoBehaviour.enabled)
                                    {
                                        continue;
                                    }
                                    var componentType = monoBehaviour.GetType();
                                    do
                                    {
                                        GetMeshForComponent callback;
                                        if (ModelExporter.MeshForComponentCallbacks.TryGetValue(componentType, out callback))
                                        {
                                            if (callback(fbxExporter, monoBehaviour, fbxNode))
                                            {
                                                return true;
                                            }
                                        }
                                        componentType = componentType.BaseType;
                                    } while (componentType.IsSubclassOf(typeof(MonoBehaviour)));
                                }
                            }

                            // If we're here, custom handling didn't work.
                            // Revert to default handling.

                            // if user doesn't want to export mesh colliders, and this gameobject doesn't have a renderer
                            // then don't export it.
                            if (!exportOptions.ExportUnrendered && (!gameObject.GetComponent<Renderer>() || !gameObject.GetComponent<Renderer>().enabled))
                            {
                                return false;
                            }

                            var meshFilter = defaultComponent as MeshFilter;
                            if (meshFilter)
                            {
                                var renderer = gameObject.GetComponent<Renderer>();
                                var materials = renderer ? renderer.sharedMaterials : null;
                                return ExportMesh2(new ModelExporter.MeshInfo(meshFilter.sharedMesh, materials), fbxNode);
                            }
                            else
                            {
                                var smr = defaultComponent as SkinnedMeshRenderer;
                                if (smr)
                                {
                                    var result = fbxExporter.ExportSkinnedMesh(gameObject, fbxNode.GetScene(), fbxNode);
                                    if (!result)
                                    {
                                        // fall back to exporting as a static mesh
                                        var mesh = new Mesh();
                                        smr.BakeMesh(mesh);
                                        var materials = smr.sharedMaterials;
                                        result = ExportMesh2(new ModelExporter.MeshInfo(mesh, materials), fbxNode);
                                        Object.DestroyImmediate(mesh);
                                    }
                                    return result;
                                }
                            }

                            return false;
                        }

                        bool ExportComponents(FbxScene fbxScene)
                        {
                            var animationNodes = new HashSet<GameObject>();

                            int numObjectsExported = 0;
                            int objectCount = fbxExporter.MapUnityObjectToFbxNode.Count;
                            foreach (KeyValuePair<GameObject, FbxNode> entry in fbxExporter.MapUnityObjectToFbxNode)
                            {
                                numObjectsExported++;
                                if (EditorUtility.DisplayCancelableProgressBar(
                                        ModelExporter.ProgressBarTitle,
                                        string.Format("Exporting Components for GameObject {0}/{1}", numObjectsExported, objectCount),
                                        ((numObjectsExported / (float)objectCount) * 0.25f) + 0.25f))
                                {
                                    // cancel silently
                                    return false;
                                }

                                var unityGo = entry.Key;
                                var fbxNode = entry.Value;

                                // try export mesh
                                bool exportedMesh = false;
                                if (exportOptions.KeepInstances)
                                {
                                    exportedMesh = ExportInstance(unityGo, fbxScene, fbxNode);
                                }

                                if (!exportedMesh)
                                {
                                    exportedMesh = ExportMesh1(unityGo, fbxNode);
                                }

                                // export camera, but only if no mesh was exported
                                bool exportedCamera = false;
                                if (!exportedMesh)
                                {
                                    exportedCamera = fbxExporter.ExportCamera(unityGo, fbxScene, fbxNode);
                                }

                                // export light, but only if no mesh or camera was exported
                                if (!exportedMesh && !exportedCamera)
                                {
                                    fbxExporter.ExportLight(unityGo, fbxScene, fbxNode);
                                }

                                fbxExporter.ExportConstraints(unityGo, fbxScene, fbxNode);
                            }
                            return true;
                        }

                        void ExportAll(ModelExporter instance, GameObject root, IExportData exportData)
                        {
                            ModelExporter.exportCancelled = false;

                            instance.m_lastFilePath = ModelExporter.LastFilePath;
                            var exportDir = Path.GetDirectoryName(filePath);
                            var lastFileName = Path.GetFileName(filePath);
                            var tempFileName = "_CustomFbxExportTempFile" + lastFileName;
                            instance.m_tempFilePath = Path.Combine(exportDir, tempFileName);

                            bool animOnly = exportData != null && exportOptions.ModelAnimIncludeOption == ExportSettings.Include.Anim;

                            bool status = false;

                            {
                                // Create the FBX manager
                                var fbxManager = FbxManager.Create();

                                // Configure fbx IO settings.
                                {
                                    var settings = FbxIOSettings.Create(fbxManager, Globals.IOSROOT);
                                    if (exportOptions.EmbedTextures)
                                        settings.SetBoolProp(Globals.EXP_FBX_EMBEDDED, true);
                                    fbxManager.SetIOSettings(settings);
                                }

                                // Create the exporter
                                var fbxExporter = FbxExporter.Create(fbxManager, "Exporter");

                                // Initialize the exporter.
                                {
                                    //如果打包贴图的话必须使用二进制输出方式
                                    int fileFormat = -1;
                                    if (exportOptions.ExportFormat == ExportSettings.ExportFormat.ASCII)
                                        fileFormat = fbxManager.GetIOPluginRegistry().FindWriterIDByDescription("FBX ascii (*.fbx)");
                                    bool success = fbxExporter.Initialize(instance.m_tempFilePath, fileFormat, fbxManager.GetIOSettings());
                                    // Check that initialization of the fbxExporter was successful
                                    if (!success)
                                        return;
                                }

                                //设置FBX SDK的进度值回调
                                fbxExporter.SetProgressCallback(ExportProgressCallback);

                                //创建FBX Scene
                                var fbxScene = FbxScene.Create(fbxManager, "Scene");

                                //设置FBX Scene
                                {
                                    // set up the scene info
                                    FbxDocumentInfo fbxSceneInfo = FbxDocumentInfo.Create(fbxManager, "SceneInfo");
                                    fbxSceneInfo.mTitle = ModelExporter.Title;
                                    fbxSceneInfo.mSubject = ModelExporter.Subject;
                                    fbxSceneInfo.mAuthor = "Unity Technologies";
                                    fbxSceneInfo.mRevision = "1.0";
                                    fbxSceneInfo.mKeywords = ModelExporter.Keywords;
                                    fbxSceneInfo.mComment = ModelExporter.Comments;
                                    fbxSceneInfo.Original_ApplicationName.Set(string.Format("Unity {0}", ModelExporter.PACKAGE_UI_NAME));
                                    // set last saved to be the same as original, as this is a new file.
                                    fbxSceneInfo.LastSaved_ApplicationName.Set(fbxSceneInfo.Original_ApplicationName.Get());

                                    var version = ModelExporter.GetVersionFromReadme();
                                    if (version != null)
                                    {
                                        fbxSceneInfo.Original_ApplicationVersion.Set(version);
                                        fbxSceneInfo.LastSaved_ApplicationVersion.Set(fbxSceneInfo.Original_ApplicationVersion.Get());
                                    }
                                    fbxScene.SetSceneInfo(fbxSceneInfo);
                                }

                                //设置单位和轴向
                                {
                                    var fbxSettings = fbxScene.GetGlobalSettings();

                                    // Set up the axes (Y up, Z forward, X to the right) and units (centimeters)
                                    // Exporting in centimeters as this is the default unit for FBX files, and easiest
                                    // to work with when importing into Maya or Max
                                    fbxSettings.SetSystemUnit(FbxSystemUnit.cm);

                                    // The Unity axis system has Y up, Z forward, X to the right (left handed system with odd parity).
                                    // DirectX has the same axis system, so use this constant.
                                    var unityAxisSystem = FbxAxisSystem.DirectX;
                                    fbxSettings.SetAxisSystem(unityAxisSystem);
                                }

                                // export set of object
                                FbxNode fbxRootNode = fbxScene.GetRootNode();
                                // stores how many objects we have exported, -1 if export was cancelled
                                int exportProgress = 0;
                                int count = 0; //全部节点数量

                                {
                                    if (animOnly)
                                        count = GetAnimOnlyHierarchyCount(exportData); //只包括Animator的上级
                                    else
                                        count = GetHierarchyCount(root); //包括根节点的全部子级

                                    if (count <= 0)
                                    {
                                        // nothing to export
                                        Debug.LogWarning("Nothing to Export");
                                        return;
                                    }
                                }


                                Vector3 center = Vector3.zero;
                                ModelExporter.TransformExportType transformExportType = ModelExporter.TransformExportType.Global;

                                switch (exportOptions.ObjectPosition)
                                {
                                    case ExportSettings.ObjectPosition.LocalCentered:
                                        // one object to export -> move to (0,0,0)
                                        center = root.transform.position;
                                        break;
                                    case ExportSettings.ObjectPosition.Reset:
                                        transformExportType = ModelExporter.TransformExportType.Reset;
                                        break;
                                    // absolute center -> don't do anything
                                    default:
                                        center = Vector3.zero;
                                        break;
                                }

                                //创建Transform层级树
                                {
                                    if (animOnly && exportData != null)
                                    {
                                        exportProgress = ExportAnimationOnly(root, fbxScene, exportProgress, count, center, exportData, transformExportType);
                                    }
                                    else
                                    {
                                        exportProgress = ExportTransformHierarchy(root, fbxScene, fbxRootNode,
                                            exportProgress, count, center, transformExportType, exportOptions.LODExportType);
                                    }
                                    if (ModelExporter.exportCancelled || exportProgress < 0)
                                    {
                                        Debug.LogWarning("Export Cancelled");
                                        return;
                                    }
                                }

                                //导出Mesh、Camera、Light
                                if (!animOnly)
                                {
                                    if (!ExportComponents(fbxScene))
                                    {
                                        Debug.LogWarning("Export Cancelled");
                                        return;
                                    }
                                }

                                //导出动画
                                // Export animation if any
                                if (exportData != null)
                                {
                                    {
                                        IExportData iData = exportData;
                                        if (iData != null)
                                        {
                                            var data = iData as AnimationOnlyExportData;
                                            if (data == null)
                                            {
                                                Debug.LogWarningFormat("FBX Exporter: no animation export data found for {0}", root.name);

                                            }
                                            // export animation
                                            // export default clip first
                                            if (data.defaultClip != null)
                                            {
                                                var defaultClip = data.defaultClip;
                                                instance.ExportAnimationClip(defaultClip, data.animationClips[defaultClip], fbxScene);
                                                data.animationClips.Remove(defaultClip);
                                            }

                                            foreach (var animClip in data.animationClips)
                                            {
                                                instance.ExportAnimationClip(animClip.Key, animClip.Value, fbxScene);
                                            }
                                        }

                                    }
                                }

                                // Set the scene's default camera.
                                instance.SetDefaultCamera(fbxScene);

                                // The Maya axis system has Y up, Z forward, X to the left (right handed system with odd parity).
                                // We need to export right-handed for Maya because ConvertScene (used by Maya and Max importers) can't switch handedness:
                                // https://forums.autodesk.com/t5/fbx-forum/get-confused-with-fbxaxissystem-convertscene/td-p/4265472
                                // This needs to be done last so that everything is converted properly.
                                FbxAxisSystem.MayaYUp.DeepConvertScene(fbxScene);

                                // Export the scene to the file.
                                status = fbxExporter.Export(fbxScene);

                                // cleanup
                                fbxScene.Destroy();
                                fbxExporter.Destroy();
                                fbxManager.Dispose();
                            }

                            if (ModelExporter.exportCancelled)
                            {
                                Debug.LogWarning("Export Cancelled");
                                return;
                            }

                            // make a temporary copy of the original metafile
                            string originalMetafilePath = "";
                            if (instance.ExportOptions.PreserveImportSettings && File.Exists(instance.m_lastFilePath))
                            {
                                originalMetafilePath = instance.SaveMetafile();
                            }

                            // delete old file, move temp file
                            instance.ReplaceFile();

                            // refresh the database so Unity knows the file's been deleted
                            AssetDatabase.Refresh();

                            // replace with original metafile if specified to
                            if (instance.ExportOptions.PreserveImportSettings && !string.IsNullOrEmpty(originalMetafilePath))
                            {
                                instance.ReplaceMetafile(originalMetafilePath);
                            }

                            //return status == true ? instance.NumNodes : 0;

                            // You must clear the progress bar when you're done,
                            // otherwise it never goes away and many actions in Unity
                            // are blocked (e.g. you can't quit).
                            EditorUtility.ClearProgressBar();

                            // make sure the temp file is deleted, no matter
                            // when we return
                            instance.DeleteTempFile();
                        }

                        AnimationOnlyExportData animData = GetExportData(fbxGameObject, exportOptions);
                        ExportAll(fbxExporter, fbxGameObject, animData);
                    }
                }
            }
            AssetDatabase.Refresh();
            Debug.LogError("结束...  处理次数：" + count);

        }

        public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] properties)
        {
            materialEditor.PropertiesDefaultGUI(properties);
        }
    }
}
