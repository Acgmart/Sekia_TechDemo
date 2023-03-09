using UnityEngine;
using System.IO;
using System.Collections.Generic;
using UnityEngine.Rendering;
using Autodesk.Fbx;
using System.Linq;
using UnityEditor.CustomFbxExporter;
using UnityEditor.SceneManagement;
using UnityEngine.Animations;

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



        public static void ExportOneFbx(GameObject fbxGameObject, string filePath, ExportSettings exportSettings)
        {
            Dictionary<GameObject, FbxNode> MapUnityObjectToFbxNode = new Dictionary<GameObject, FbxNode>();
            Dictionary<Mesh, FbxNode> sharedMeshes = new Dictionary<Mesh, FbxNode>();
            int meshNodeCounter = 0;
            int NumMeshes = 0;
            int NumTriangles = 0;
            Dictionary<System.Type, KeyValuePair<System.Type, FbxNodeRelationType>> MapsToFbxObject = new Dictionary<System.Type, KeyValuePair<System.Type, FbxNodeRelationType>>()
            {
                { typeof(Transform),            new KeyValuePair<System.Type, FbxNodeRelationType>(typeof(FbxProperty), FbxNodeRelationType.Property) },
                { typeof(MeshFilter),           new KeyValuePair<System.Type, FbxNodeRelationType>(typeof(FbxMesh), FbxNodeRelationType.NodeAttribute) },
                { typeof(SkinnedMeshRenderer),  new KeyValuePair<System.Type, FbxNodeRelationType>(typeof(FbxMesh), FbxNodeRelationType.NodeAttribute) },
                { typeof(Light),                new KeyValuePair<System.Type, FbxNodeRelationType>(typeof(FbxLight), FbxNodeRelationType.NodeAttribute) },
                { typeof(Camera),               new KeyValuePair<System.Type, FbxNodeRelationType>(typeof(FbxCamera), FbxNodeRelationType.NodeAttribute) },
                { typeof(Material),             new KeyValuePair<System.Type, FbxNodeRelationType>(typeof(FbxSurfaceMaterial), FbxNodeRelationType.Material) },
            };


            /// <summary>
            /// Format for creating unique names
            /// </summary>

            var exportDir = Path.GetDirectoryName(filePath);
            var lastFileName = Path.GetFileName(filePath);
            var tempFileName = "_CustomFbxExportTempFile" + lastFileName;
            var tempFilePath = Path.Combine(exportDir, tempFileName);
            string Title = "Created by FBX Exporter from Unity Technologies";
            string Subject = "";
            string Keywords = "Nodes Meshes Materials Textures Cameras Lights Skins Animation";
            string Comments = @"";
            string ProgressBarTitle = "FBX Exporter";
            char MayaNamespaceSeparator = ':';
            // replace invalid chars with this one
            char InvalidCharReplacement = '_';
            float UnitScaleFactor = 100f;
            const string PACKAGE_NAME = "FBX Exporter";
            const string PACKAGE_VERSION = "0.0.0";
            /// <summary>
            /// name of the scene's default camera
            /// </summary>
            string DefaultCamera = "";
            string SkeletonPrefix = "_Skel";
            string SkinPrefix = "_Skin";


            /// <summary>
            /// keep a map between the constrained FbxNode (in Unity this is the GameObject with constraint component)
            /// and its FbxConstraints for quick lookup when exporting constraint animations.
            /// </summary>
            Dictionary<FbxNode, Dictionary<FbxConstraint, System.Type>> MapConstrainedObjectToConstraints = new Dictionary<FbxNode, Dictionary<FbxConstraint, System.Type>>();

            /// <summary>
            /// keep a map between the FbxNode and its blendshape channels for quick lookup when exporting blendshapes.
            /// </summary>
            Dictionary<FbxNode, List<FbxBlendShapeChannel>> MapUnityObjectToBlendShapes = new Dictionary<FbxNode, List<FbxBlendShapeChannel>>();

            /// <summary>
            /// Map Unity material ID to FBX material object
            /// </summary>
            Dictionary<int, FbxSurfaceMaterial> MaterialMap = new Dictionary<int, FbxSurfaceMaterial>();

            /// <summary>
            /// Map texture filename name to FBX texture object
            /// </summary>
            Dictionary<string, FbxTexture> TextureMap = new Dictionary<string, FbxTexture>();

            /// <summary>
            /// Map a Unity mesh to an fbx node (for preserving instances) 
            /// </summary>
            Dictionary<Mesh, FbxNode> SharedMeshes = new Dictionary<Mesh, FbxNode>();



            /// <summary>
            /// Keeps track of the index of each point in the exported vertex array.
            /// </summary>
            Dictionary<Vector3, int> ControlPointToIndex = new Dictionary<Vector3, int>();









            /// <summary>
            /// Gets the bind pose for the Unity bone.
            /// </summary>
            /// <returns>The bind pose.</returns>
            /// <param name="unityBone">Unity bone.</param>
            /// <param name="bindPoses">Bind poses.</param>
            /// <param name="boneInfo">Contains information about bones and skinned mesh.</param>
            Matrix4x4 GetBindPose(Transform unityBone, Matrix4x4[] bindPoses, ref SkinnedMeshBoneInfo boneInfo)
            {
                var boneDict = boneInfo.boneDict;
                var skinnedMesh = boneInfo.skinnedMesh;
                var boneToBindPose = boneInfo.boneToBindPose;

                // If we have already retrieved the bindpose for this bone before
                // it will be present in the boneToBindPose dictionary,
                // simply return this bindpose.
                Matrix4x4 bindPose;
                if (boneToBindPose.TryGetValue(unityBone, out bindPose))
                {
                    return bindPose;
                }

                // Check if unityBone is a bone registered in the bone list of the skinned mesh.
                // If it is, then simply retrieve the bindpose from the boneDict (maps bone to index in bone/bindpose list).
                // Make sure to update the boneToBindPose list in case the bindpose for this bone needs to be retrieved again.
                int index;
                if (boneDict.TryGetValue(unityBone, out index))
                {
                    bindPose = bindPoses[index];
                    boneToBindPose.Add(unityBone, bindPose);
                    return bindPose;
                }

                // unityBone is not registered as a bone in the skinned mesh, therefore there is no bindpose
                // associated with it, we need to calculate one.

                // If this is the rootbone of the mesh or an object without a parent, use the global matrix relative to the skinned mesh
                // as the bindpose.
                if (unityBone == skinnedMesh.rootBone || unityBone.parent == null)
                {
                    // there is no bone above this object with a bindpose, calculate bindpose relative to skinned mesh
                    bindPose = (unityBone.worldToLocalMatrix * skinnedMesh.transform.localToWorldMatrix);
                    boneToBindPose.Add(unityBone, bindPose);
                    return bindPose;
                }

                // If this object has a parent that could be a bone, then it is not enough to use the worldToLocalMatrix,
                // as this will give an incorrect global transform if the parents are not already in the bindpose in the scene.
                // Instead calculate what the bindpose would be based on the bindpose of the parent object.

                // get the bindpose of the parent
                var parentBindPose = GetBindPose(unityBone.parent, bindPoses, ref boneInfo);
                // Get the local transformation matrix of the bone, then transform it into
                // the global transformation matrix with the parent in the bind pose.
                // Formula to get the global transformation matrix:
                //   (parentBindPose.inverse * boneLocalTRSMatrix)
                // The bindpose is then the inverse of this matrix:
                //   (parentBindPose.inverse * boneLocalTRSMatrix).inverse
                // This can be simplified with (AB)^{-1} = B^{-1}A^{-1} rule as follows:
                //   (parentBindPose.inverse * boneLocalTRSMatrix).inverse
                // = boneLocalTRSMatrix.inverse * parentBindPose.inverse.inverse
                // = boneLocalTRSMatrix.inverse * parentBindPose
                var boneLocalTRSMatrix = Matrix4x4.TRS(unityBone.localPosition, unityBone.localRotation, unityBone.localScale);
                bindPose = boneLocalTRSMatrix.inverse * parentBindPose;
                boneToBindPose.Add(unityBone, bindPose);
                return bindPose;
            }

            /// <summary>
            /// Export bones of skinned mesh, if this is a skinned mesh with
            /// bones and bind poses.
            /// </summary> 
            bool ExportSkeleton(SkinnedMeshRenderer skinnedMesh, FbxScene fbxScene, out Dictionary<SkinnedMeshRenderer, Transform[]> skinnedMeshToBonesMap)
            {
                skinnedMeshToBonesMap = new Dictionary<SkinnedMeshRenderer, Transform[]>();

                if (!skinnedMesh)
                {
                    return false;
                }
                var bones = skinnedMesh.bones;
                if (bones == null || bones.Length == 0)
                {
                    return false;
                }
                var mesh = skinnedMesh.sharedMesh;
                if (!mesh)
                {
                    return false;
                }

                var bindPoses = mesh.bindposes;
                if (bindPoses == null || bindPoses.Length != bones.Length)
                {
                    return false;
                }

                // Two steps:
                // 0. Set up the map from bone to index.
                // 1. Set the transforms.

                // Step 0: map transform to index so we can look up index by bone.
                Dictionary<Transform, int> index = new Dictionary<Transform, int>();
                for (int boneIndex = 0; boneIndex < bones.Length; boneIndex++)
                {
                    Transform unityBoneTransform = bones[boneIndex];

                    // ignore null bones
                    if (unityBoneTransform != null)
                    {
                        index[unityBoneTransform] = boneIndex;
                    }
                }

                skinnedMeshToBonesMap.Add(skinnedMesh, bones);

                // Step 1: Set transforms
                var boneInfo = new SkinnedMeshBoneInfo(skinnedMesh, index);
                foreach (var bone in bones)
                {
                    // ignore null bones
                    if (bone != null)
                    {
                        var fbxBone = MapUnityObjectToFbxNode[bone.gameObject];
                        ExportBoneTransform(fbxBone, fbxScene, bone, boneInfo);
                    }
                }
                return true;
            }

            /// <summary>
            /// Export binding of mesh to skeleton
            /// </summary>
            bool ExportSkin(SkinnedMeshRenderer skinnedMesh, MeshInfo meshInfo, FbxScene fbxScene, FbxMesh fbxMesh, FbxNode fbxRootNode)
            {
                FbxSkin fbxSkin = FbxSkin.Create(fbxScene, (skinnedMesh.name + SkinPrefix));

                FbxAMatrix fbxMeshMatrix = fbxRootNode.EvaluateGlobalTransform();

                // keep track of the bone index -> fbx cluster mapping, so that we can add the bone weights afterwards
                Dictionary<int, FbxCluster> boneCluster = new Dictionary<int, FbxCluster>();

                for (int i = 0; i < skinnedMesh.bones.Length; i++)
                {
                    // ignore null bones
                    if (skinnedMesh.bones[i] != null)
                    {
                        FbxNode fbxBoneNode = MapUnityObjectToFbxNode[skinnedMesh.bones[i].gameObject];

                        // Create the deforming cluster
                        FbxCluster fbxCluster = FbxCluster.Create(fbxScene, "BoneWeightCluster");

                        fbxCluster.SetLink(fbxBoneNode);
                        fbxCluster.SetLinkMode(FbxCluster.ELinkMode.eNormalize);

                        boneCluster.Add(i, fbxCluster);

                        // set the Transform and TransformLink matrix
                        fbxCluster.SetTransformMatrix(fbxMeshMatrix);

                        FbxAMatrix fbxLinkMatrix = fbxBoneNode.EvaluateGlobalTransform();
                        fbxCluster.SetTransformLinkMatrix(fbxLinkMatrix);

                        // add the cluster to the skin
                        fbxSkin.AddCluster(fbxCluster);
                    }
                }

                // set the vertex weights for each bone
                SetVertexWeights(meshInfo, boneCluster);

                // Add the skin to the mesh after the clusters have been added
                fbxMesh.AddDeformer(fbxSkin);

                return true;
            }

            /// <summary>
            /// set vertex weights in cluster
            /// </summary>
            void SetVertexWeights(MeshInfo meshInfo, Dictionary<int, FbxCluster> boneIndexToCluster)
            {
                var mesh = meshInfo.mesh;
                // Get the number of bone weights per vertex
                var bonesPerVertex = mesh.GetBonesPerVertex();
                if (bonesPerVertex.Length == 0)
                {
                    // no bone weights to set
                    return;
                }

                HashSet<int> visitedVertices = new HashSet<int>();

                // Get all the bone weights, in vertex index order
                // Note: this contains all the bone weights for all vertices.
                //       Use number of bonesPerVertex to determine where weights end
                //       for one vertex and begin for another.
                var boneWeights1 = mesh.GetAllBoneWeights();

                // Keep track of where we are in the array of BoneWeights, as we iterate over the vertices
                var boneWeightIndex = 0;

                for (var vertIndex = 0; vertIndex < meshInfo.VertexCount; vertIndex++)
                {
                    // Get the index into the list of vertices without duplicates
                    var actualIndex = ControlPointToIndex[meshInfo.Vertices[vertIndex]];

                    var numberOfBonesForThisVertex = bonesPerVertex[vertIndex];

                    if (visitedVertices.Contains(actualIndex))
                    {
                        // skip duplicate vertex
                        boneWeightIndex += numberOfBonesForThisVertex;
                        continue;
                    }
                    visitedVertices.Add(actualIndex);

                    // For each vertex, iterate over its BoneWeights
                    for (var i = 0; i < numberOfBonesForThisVertex; i++)
                    {
                        var currentBoneWeight = boneWeights1[boneWeightIndex];

                        // bone index is index into skinnedmesh.bones[]
                        var boneIndex = currentBoneWeight.boneIndex;
                        // how much influence does this bone have on vertex at vertIndex
                        var weight = currentBoneWeight.weight;

                        if (weight <= 0)
                        {
                            continue;
                        }

                        // get the right cluster
                        FbxCluster boneCluster;
                        if (!boneIndexToCluster.TryGetValue(boneIndex, out boneCluster))
                        {
                            continue;
                        }
                        // add vertex and weighting on vertex to this bone's cluster
                        boneCluster.AddControlPointIndex(actualIndex, weight);

                        boneWeightIndex++;
                    }
                }
            }

            /// <summary>
            /// Export bind pose of mesh to skeleton
            /// </summary>
            bool ExportBindPose(SkinnedMeshRenderer skinnedMesh, FbxNode fbxMeshNode,
                                   FbxScene fbxScene, Dictionary<SkinnedMeshRenderer, Transform[]> skinnedMeshToBonesMap)
            {
                if (fbxMeshNode == null || skinnedMeshToBonesMap == null || fbxScene == null)
                {
                    return false;
                }

                FbxPose fbxPose = FbxPose.Create(fbxScene, fbxMeshNode.GetName());

                // set as bind pose
                fbxPose.SetIsBindPose(true);

                // assume each bone node has one weighted vertex cluster
                Transform[] bones;
                if (!skinnedMeshToBonesMap.TryGetValue(skinnedMesh, out bones))
                {
                    return false;
                }
                for (int i = 0; i < bones.Length; i++)
                {
                    // ignore null bones
                    if (bones[i] != null)
                    {
                        FbxNode fbxBoneNode = MapUnityObjectToFbxNode[bones[i].gameObject];

                        // EvaluateGlobalTransform returns an FbxAMatrix (affine matrix)
                        // which has to be converted to an FbxMatrix so that it can be passed to fbxPose.Add().
                        // The hierarchy for FbxMatrix and FbxAMatrix is as follows:
                        //
                        //      FbxDouble4x4
                        //      /           \
                        // FbxMatrix     FbxAMatrix
                        //
                        // Therefore we can't convert directly from FbxAMatrix to FbxMatrix,
                        // however FbxMatrix has a constructor that takes an FbxAMatrix.
                        FbxMatrix fbxBindMatrix = new FbxMatrix(fbxBoneNode.EvaluateGlobalTransform());

                        fbxPose.Add(fbxBoneNode, fbxBindMatrix);
                    }
                }

                fbxPose.Add(fbxMeshNode, new FbxMatrix(fbxMeshNode.EvaluateGlobalTransform()));

                // add the pose to the scene
                fbxScene.AddPose(fbxPose);

                return true;
            }



            /// <summary>
            /// Euler (roll/pitch/yaw (ZXY rotation order) to quaternion.
            /// </summary>
            /// <returns>a quaternion.</returns>
            /// <param name="euler">ZXY Euler.</param>
            FbxQuaternion EulerToQuaternionZXY(Vector3 euler)
            {
                var unityQuat = Quaternion.Euler(euler);
                return new FbxQuaternion(unityQuat.x, unityQuat.y, unityQuat.z, unityQuat.w);
            }

            /// <summary>
            /// Euler X/Y/Z rotation order to quaternion.
            /// </summary>
            /// <param name="euler">XYZ Euler.</param>
            /// <returns>a quaternion</returns>
            FbxQuaternion EulerToQuaternionXYZ(FbxVector4 euler)
            {
                FbxAMatrix m = new FbxAMatrix();
                m.SetR(euler);
                return m.GetQ();
            }


            bool ExportCommonConstraintProperties<TUnityConstraint, TFbxConstraint>(TUnityConstraint uniConstraint, TFbxConstraint fbxConstraint, FbxNode fbxNode)
               where TUnityConstraint : IConstraint where TFbxConstraint : FbxConstraint
            {
                fbxConstraint.Active.Set(uniConstraint.constraintActive);
                fbxConstraint.Lock.Set(uniConstraint.locked);
                fbxConstraint.Weight.Set(uniConstraint.weight * UnitScaleFactor);

                AddFbxNodeToConstraintsMapping(fbxNode, fbxConstraint, typeof(TUnityConstraint));
                return true;
            }



            List<ExpConstraintSource> GetConstraintSources(IConstraint unityConstraint)
            {
                if (unityConstraint == null)
                {
                    return null;
                }

                var fbxSources = new List<ExpConstraintSource>();
                var sources = new List<ConstraintSource>();
                unityConstraint.GetSources(sources);
                foreach (var source in sources)
                {
                    // ignore any sources that are not getting exported
                    FbxNode sourceNode;
                    if (!MapUnityObjectToFbxNode.TryGetValue(source.sourceTransform.gameObject, out sourceNode))
                    {
                        continue;
                    }
                    fbxSources.Add(new ExpConstraintSource(sourceNode, source.weight * UnitScaleFactor));
                }
                return fbxSources;
            }

            void AddFbxNodeToConstraintsMapping<T>(FbxNode fbxNode, T fbxConstraint, System.Type uniConstraintType) where T : FbxConstraint
            {
                Dictionary<FbxConstraint, System.Type> constraintMapping;
                if (!MapConstrainedObjectToConstraints.TryGetValue(fbxNode, out constraintMapping))
                {
                    constraintMapping = new Dictionary<FbxConstraint, System.Type>();
                    MapConstrainedObjectToConstraints.Add(fbxNode, constraintMapping);
                }
                constraintMapping.Add(fbxConstraint, uniConstraintType);
            }

            bool ExportPositionConstraint(IConstraint uniConstraint, FbxScene fbxScene, FbxNode fbxNode)
            {
                if (fbxNode == null)
                {
                    return false;
                }

                var uniPosConstraint = uniConstraint as PositionConstraint;
                Debug.Assert(uniPosConstraint != null);

                FbxConstraintPosition fbxPosConstraint = FbxConstraintPosition.Create(fbxScene, fbxNode.GetName() + "_positionConstraint");
                fbxPosConstraint.SetConstrainedObject(fbxNode);
                var uniSources = GetConstraintSources(uniPosConstraint);
                uniSources.ForEach(uniSource => fbxPosConstraint.AddConstraintSource(uniSource.node, uniSource.weight));
                ExportCommonConstraintProperties(uniPosConstraint, fbxPosConstraint, fbxNode);

                var uniAffectedAxes = uniPosConstraint.translationAxis;
                fbxPosConstraint.AffectX.Set((uniAffectedAxes & Axis.X) == Axis.X);
                fbxPosConstraint.AffectY.Set((uniAffectedAxes & Axis.Y) == Axis.Y);
                fbxPosConstraint.AffectZ.Set((uniAffectedAxes & Axis.Z) == Axis.Z);

                var fbxTranslationOffset = MeshInfo.ConvertToFbxVector4(uniPosConstraint.translationOffset, UnitScaleFactor);
                fbxPosConstraint.Translation.Set(Vector4ToFbxDouble3(fbxTranslationOffset));

                // rest position is the position of the fbx node
                var fbxRestTranslation = MeshInfo.ConvertToFbxVector4(uniPosConstraint.translationAtRest, UnitScaleFactor);
                // set the local position of fbxNode
                fbxNode.LclTranslation.Set(Vector4ToFbxDouble3(fbxRestTranslation));
                return true;
            }

            bool ExportRotationConstraint(IConstraint uniConstraint, FbxScene fbxScene, FbxNode fbxNode)
            {
                if (fbxNode == null)
                {
                    return false;
                }

                var uniRotConstraint = uniConstraint as RotationConstraint;
                Debug.Assert(uniRotConstraint != null);

                FbxConstraintRotation fbxRotConstraint = FbxConstraintRotation.Create(fbxScene, fbxNode.GetName() + "_rotationConstraint");
                fbxRotConstraint.SetConstrainedObject(fbxNode);
                var uniSources = GetConstraintSources(uniRotConstraint);
                uniSources.ForEach(uniSource => fbxRotConstraint.AddConstraintSource(uniSource.node, uniSource.weight));
                ExportCommonConstraintProperties(uniRotConstraint, fbxRotConstraint, fbxNode);

                var uniAffectedAxes = uniRotConstraint.rotationAxis;
                fbxRotConstraint.AffectX.Set((uniAffectedAxes & Axis.X) == Axis.X);
                fbxRotConstraint.AffectY.Set((uniAffectedAxes & Axis.Y) == Axis.Y);
                fbxRotConstraint.AffectZ.Set((uniAffectedAxes & Axis.Z) == Axis.Z);

                // Not converting rotation offset to XYZ euler as it gives the incorrect result in both Maya and Unity.
                var uniRotationOffset = uniRotConstraint.rotationOffset;
                var fbxRotationOffset = Vector3ToFbxDouble3(uniRotationOffset);

                fbxRotConstraint.Rotation.Set(fbxRotationOffset);

                // rest rotation is the rotation of the fbx node
                var fbxRestRotation = Vector3ToFbxDouble3(uniRotConstraint.rotationAtRest);
                // set the local rotation of fbxNode
                fbxNode.LclRotation.Set(fbxRestRotation);
                return true;
            }

            bool ExportScaleConstraint(IConstraint uniConstraint, FbxScene fbxScene, FbxNode fbxNode)
            {
                if (fbxNode == null)
                {
                    return false;
                }

                var uniScaleConstraint = uniConstraint as ScaleConstraint;
                Debug.Assert(uniScaleConstraint != null);

                FbxConstraintScale fbxScaleConstraint = FbxConstraintScale.Create(fbxScene, fbxNode.GetName() + "_scaleConstraint");
                fbxScaleConstraint.SetConstrainedObject(fbxNode);
                var uniSources = GetConstraintSources(uniScaleConstraint);
                uniSources.ForEach(uniSource => fbxScaleConstraint.AddConstraintSource(uniSource.node, uniSource.weight));
                ExportCommonConstraintProperties(uniScaleConstraint, fbxScaleConstraint, fbxNode);

                var uniAffectedAxes = uniScaleConstraint.scalingAxis;
                fbxScaleConstraint.AffectX.Set((uniAffectedAxes & Axis.X) == Axis.X);
                fbxScaleConstraint.AffectY.Set((uniAffectedAxes & Axis.Y) == Axis.Y);
                fbxScaleConstraint.AffectZ.Set((uniAffectedAxes & Axis.Z) == Axis.Z);

                var uniScaleOffset = uniScaleConstraint.scaleOffset;
                var fbxScalingOffset = Vector3ToFbxDouble3(uniScaleOffset);
                fbxScaleConstraint.Scaling.Set(fbxScalingOffset);

                // rest rotation is the rotation of the fbx node
                var uniRestScale = uniScaleConstraint.scaleAtRest;
                var fbxRestScale = Vector3ToFbxDouble3(uniRestScale);
                // set the local rotation of fbxNode
                fbxNode.LclScaling.Set(fbxRestScale);
                return true;
            }

            bool ExportAimConstraint(IConstraint uniConstraint, FbxScene fbxScene, FbxNode fbxNode)
            {
                if (fbxNode == null)
                {
                    return false;
                }

                var uniAimConstraint = uniConstraint as AimConstraint;
                Debug.Assert(uniAimConstraint != null);

                FbxConstraintAim fbxAimConstraint = FbxConstraintAim.Create(fbxScene, fbxNode.GetName() + "_aimConstraint");
                fbxAimConstraint.SetConstrainedObject(fbxNode);
                var uniSources = GetConstraintSources(uniAimConstraint);
                uniSources.ForEach(uniSource => fbxAimConstraint.AddConstraintSource(uniSource.node, uniSource.weight));
                ExportCommonConstraintProperties(uniAimConstraint, fbxAimConstraint, fbxNode);

                var uniAffectedAxes = uniAimConstraint.rotationAxis;
                fbxAimConstraint.AffectX.Set((uniAffectedAxes & Axis.X) == Axis.X);
                fbxAimConstraint.AffectY.Set((uniAffectedAxes & Axis.Y) == Axis.Y);
                fbxAimConstraint.AffectZ.Set((uniAffectedAxes & Axis.Z) == Axis.Z);

                var uniRotationOffset = uniAimConstraint.rotationOffset;
                var fbxRotationOffset = Vector3ToFbxDouble3(uniRotationOffset);
                fbxAimConstraint.RotationOffset.Set(fbxRotationOffset);

                // rest rotation is the rotation of the fbx node
                var fbxRestRotation = Vector3ToFbxDouble3(uniAimConstraint.rotationAtRest);
                // set the local rotation of fbxNode
                fbxNode.LclRotation.Set(fbxRestRotation);

                FbxConstraintAim.EWorldUp fbxWorldUpType = FbxConstraintAim.EWorldUp.eAimAtNone;
                switch (uniAimConstraint.worldUpType)
                {
                    case AimConstraint.WorldUpType.None:
                        fbxWorldUpType = FbxConstraintAim.EWorldUp.eAimAtNone;
                        break;
                    case AimConstraint.WorldUpType.ObjectRotationUp:
                        fbxWorldUpType = FbxConstraintAim.EWorldUp.eAimAtObjectRotationUp;
                        break;
                    case AimConstraint.WorldUpType.ObjectUp:
                        fbxWorldUpType = FbxConstraintAim.EWorldUp.eAimAtObjectUp;
                        break;
                    case AimConstraint.WorldUpType.SceneUp:
                        fbxWorldUpType = FbxConstraintAim.EWorldUp.eAimAtSceneUp;
                        break;
                    case AimConstraint.WorldUpType.Vector:
                        fbxWorldUpType = FbxConstraintAim.EWorldUp.eAimAtVector;
                        break;
                    default:
                        throw new System.NotImplementedException();
                }
                fbxAimConstraint.WorldUpType.Set((int)fbxWorldUpType);

                var uniAimVector = MeshInfo.ConvertToFbxVector4(uniAimConstraint.aimVector);
                fbxAimConstraint.AimVector.Set(Vector4ToFbxDouble3(uniAimVector));
                fbxAimConstraint.UpVector.Set(Vector3ToFbxDouble3(uniAimConstraint.upVector));
                fbxAimConstraint.WorldUpVector.Set(Vector3ToFbxDouble3(uniAimConstraint.worldUpVector));

                if (uniAimConstraint.worldUpObject && MapUnityObjectToFbxNode.ContainsKey(uniAimConstraint.worldUpObject.gameObject))
                {
                    fbxAimConstraint.SetWorldUpObject(MapUnityObjectToFbxNode[uniAimConstraint.worldUpObject.gameObject]);
                }
                return true;
            }

            bool ExportParentConstraint(IConstraint uniConstraint, FbxScene fbxScene, FbxNode fbxNode)
            {
                if (fbxNode == null)
                {
                    return false;
                }

                var uniParentConstraint = uniConstraint as ParentConstraint;
                Debug.Assert(uniParentConstraint != null);

                FbxConstraintParent fbxParentConstraint = FbxConstraintParent.Create(fbxScene, fbxNode.GetName() + "_parentConstraint");
                fbxParentConstraint.SetConstrainedObject(fbxNode);
                var uniSources = GetConstraintSources(uniParentConstraint);
                var uniTranslationOffsets = uniParentConstraint.translationOffsets;
                var uniRotationOffsets = uniParentConstraint.rotationOffsets;
                for (int i = 0; i < uniSources.Count; i++)
                {
                    var uniSource = uniSources[i];
                    var uniTranslationOffset = uniTranslationOffsets[i];
                    var uniRotationOffset = uniRotationOffsets[i];

                    fbxParentConstraint.AddConstraintSource(uniSource.node, uniSource.weight);

                    var fbxTranslationOffset = MeshInfo.ConvertToFbxVector4(uniTranslationOffset, UnitScaleFactor);
                    fbxParentConstraint.SetTranslationOffset(uniSource.node, fbxTranslationOffset);

                    var fbxRotationOffset = MeshInfo.ConvertToFbxVector4(uniRotationOffset);
                    fbxParentConstraint.SetRotationOffset(uniSource.node, fbxRotationOffset);
                }
                ExportCommonConstraintProperties(uniParentConstraint, fbxParentConstraint, fbxNode);

                var uniTranslationAxes = uniParentConstraint.translationAxis;
                fbxParentConstraint.AffectTranslationX.Set((uniTranslationAxes & Axis.X) == Axis.X);
                fbxParentConstraint.AffectTranslationY.Set((uniTranslationAxes & Axis.Y) == Axis.Y);
                fbxParentConstraint.AffectTranslationZ.Set((uniTranslationAxes & Axis.Z) == Axis.Z);

                var uniRotationAxes = uniParentConstraint.rotationAxis;
                fbxParentConstraint.AffectRotationX.Set((uniRotationAxes & Axis.X) == Axis.X);
                fbxParentConstraint.AffectRotationY.Set((uniRotationAxes & Axis.Y) == Axis.Y);
                fbxParentConstraint.AffectRotationZ.Set((uniRotationAxes & Axis.Z) == Axis.Z);

                // rest position is the position of the fbx node
                var fbxRestTranslation = MeshInfo.ConvertToFbxVector4(uniParentConstraint.translationAtRest, UnitScaleFactor);
                // set the local position of fbxNode
                fbxNode.LclTranslation.Set(Vector4ToFbxDouble3(fbxRestTranslation));

                // rest rotation is the rotation of the fbx node
                var fbxRestRotation = Vector3ToFbxDouble3(uniParentConstraint.rotationAtRest);
                // set the local rotation of fbxNode
                fbxNode.LclRotation.Set(fbxRestRotation);
                return true;
            }





            /// <summary>
            /// Export animation curve key frames with key tangents 
            /// NOTE : This is a work in progress (WIP). We only export the key time and value on
            /// a Cubic curve using the default tangents.
            /// </summary>
            void ExportAnimationKeys(AnimationCurve uniAnimCurve, FbxAnimCurve fbxAnimCurve, UnityToMayaConvertSceneHelper convertSceneHelper)
            {
                // Copy Unity AnimCurve to FBX AnimCurve.
                // NOTE: only cubic keys are supported by the FbxImporter
                using (new FbxAnimCurveModifyHelper(new List<FbxAnimCurve> { fbxAnimCurve }))
                {
                    for (int keyIndex = 0; keyIndex < uniAnimCurve.length; ++keyIndex)
                    {
                        var uniKeyFrame = uniAnimCurve[keyIndex];
                        var fbxTime = FbxTime.FromSecondDouble(uniKeyFrame.time);

                        int fbxKeyIndex = fbxAnimCurve.KeyAdd(fbxTime);


                        // configure tangents
                        var lTangent = AnimationUtility.GetKeyLeftTangentMode(uniAnimCurve, keyIndex);
                        var rTangent = AnimationUtility.GetKeyRightTangentMode(uniAnimCurve, keyIndex);

                        // Always set tangent mode to eTangentBreak, as other modes are not handled the same in FBX as in
                        // Unity, thus leading to discrepancies in animation curves.
                        FbxAnimCurveDef.ETangentMode tanMode = FbxAnimCurveDef.ETangentMode.eTangentBreak;

                        // Default to cubic interpolation, which is the default for KeySet
                        FbxAnimCurveDef.EInterpolationType interpMode = FbxAnimCurveDef.EInterpolationType.eInterpolationCubic;
                        switch (rTangent)
                        {
                            case AnimationUtility.TangentMode.Linear:
                                interpMode = FbxAnimCurveDef.EInterpolationType.eInterpolationLinear;
                                break;
                            case AnimationUtility.TangentMode.Constant:
                                interpMode = FbxAnimCurveDef.EInterpolationType.eInterpolationConstant;
                                break;
                            default:
                                break;
                        }

                        fbxAnimCurve.KeySet(fbxKeyIndex,
                            fbxTime,
                            convertSceneHelper.Convert(uniKeyFrame.value),
                            interpMode,
                            tanMode,
                            // value of right slope
                            convertSceneHelper.Convert(uniKeyFrame.outTangent),
                            // value of next left slope
                            keyIndex < uniAnimCurve.length - 1 ? convertSceneHelper.Convert(uniAnimCurve[keyIndex + 1].inTangent) : 0,
                            FbxAnimCurveDef.EWeightedMode.eWeightedAll,
                            // weight for right slope
                            uniKeyFrame.outWeight,
                            // weight for next left slope
                            keyIndex < uniAnimCurve.length - 1 ? uniAnimCurve[keyIndex + 1].inWeight : 0
                        );
                    }
                }
            }



            /// <summary>
            /// Get the FbxConstraint associated with the constrained node.
            /// </summary>
            /// <param name="constrainedNode"></param>
            /// <param name="uniConstraintType"></param>
            /// <returns></returns>
            FbxConstraint GetFbxConstraint(FbxNode constrainedNode, System.Type uniConstraintType)
            {
                if (uniConstraintType == null || !uniConstraintType.GetInterfaces().Contains(typeof(IConstraint)))
                {
                    // not actually a constraint
                    return null;
                }

                Dictionary<FbxConstraint, System.Type> constraints;
                if (MapConstrainedObjectToConstraints.TryGetValue(constrainedNode, out constraints))
                {
                    var targetConstraint = constraints.FirstOrDefault(constraint => (constraint.Value == uniConstraintType));
                    if (!targetConstraint.Equals(default(KeyValuePair<FbxConstraint, System.Type>)))
                    {
                        return targetConstraint.Key;
                    }
                }

                return null;
            }

            /// <summary>
            /// Get the FbxBlendshape with the given name associated with the FbxNode.
            /// </summary>
            /// <param name="blendshapeNode"></param>
            /// <param name="uniPropertyName"></param>
            /// <returns></returns>
            FbxBlendShapeChannel GetFbxBlendShape(FbxNode blendshapeNode, string uniPropertyName)
            {
                List<FbxBlendShapeChannel> blendshapeChannels;
                if (MapUnityObjectToBlendShapes.TryGetValue(blendshapeNode, out blendshapeChannels))
                {
                    var match = System.Text.RegularExpressions.Regex.Match(uniPropertyName, @"blendShape\.(\S+)");
                    if (match.Success && match.Groups.Count > 0)
                    {
                        string blendshapeName = match.Groups[1].Value;

                        var targetChannel = blendshapeChannels.FirstOrDefault(channel => (channel.GetName() == blendshapeName));
                        if (targetChannel != null)
                        {
                            return targetChannel;
                        }
                    }
                }
                return null;
            }

            FbxProperty GetFbxProperty(FbxNode fbxNode, string fbxPropertyName, System.Type uniPropertyType, string uniPropertyName)
            {
                if (fbxNode == null)
                {
                    return null;
                }

                // check if property maps to a constraint
                // check this first because both constraints and FbxNodes can contain a RotationOffset property,
                // but only the constraint one is animatable.
                var fbxConstraint = GetFbxConstraint(fbxNode, uniPropertyType);
                if (fbxConstraint != null)
                {
                    var prop = fbxConstraint.FindProperty(fbxPropertyName, false);
                    if (prop.IsValid())
                    {
                        return prop;
                    }
                }

                // check if the property maps to a blendshape
                var fbxBlendShape = GetFbxBlendShape(fbxNode, uniPropertyName);
                if (fbxBlendShape != null)
                {
                    var prop = fbxBlendShape.FindProperty(fbxPropertyName, false);
                    if (prop.IsValid())
                    {
                        return prop;
                    }
                }

                // map unity property name to fbx property
                var fbxProperty = fbxNode.FindProperty(fbxPropertyName, false);
                if (fbxProperty.IsValid())
                {
                    return fbxProperty;
                }

                var fbxNodeAttribute = fbxNode.GetNodeAttribute();
                if (fbxNodeAttribute != null)
                {
                    fbxProperty = fbxNodeAttribute.FindProperty(fbxPropertyName, false);
                }
                return fbxProperty;
            }







            /// <summary>
            /// Transfers transform animation from source to dest. Replaces dest's Unity Animation Curves with updated animations.
            /// NOTE: Source must be the parent of dest.
            /// </summary>
            /// <param name="source">Source animated object.</param>
            /// <param name="dest">Destination, child of the source.</param>
            /// <param name="sampleRate">Sample rate.</param>
            /// <param name="unityCurves">Unity curves.</param> 
            void TransferMotion(Transform source, Transform dest, float sampleRate, ref Dictionary<GameObject, List<UnityCurve>> unityCurves)
            {
                // get sample times for curves in dest + source
                // at each sample time, evaluate all 18 transfom anim curves, creating 2 transform matrices
                // combine the matrices, get the new values, apply to the 9 new anim curves for dest
                if (dest.parent != source)
                {
                    Debug.LogError("dest must be a child of source");
                    return;
                }

                List<UnityCurve> sourceUnityCurves;
                if (!unityCurves.TryGetValue(source.gameObject, out sourceUnityCurves))
                {
                    return; // nothing to do, source has no animation
                }

                List<UnityCurve> destUnityCurves;
                if (!unityCurves.TryGetValue(dest.gameObject, out destUnityCurves))
                {
                    destUnityCurves = new List<UnityCurve>();
                }

                List<AnimationCurve> animCurves = new List<AnimationCurve>();
                foreach (var curve in sourceUnityCurves)
                {
                    // TODO: check if curve is anim related
                    animCurves.Add(curve.uniAnimCurve);
                }
                foreach (var curve in destUnityCurves)
                {
                    animCurves.Add(curve.uniAnimCurve);
                }

                var sampleTimes = MeshInfo.GetSampleTimes(animCurves.ToArray(), sampleRate);
                // need to create 9 new UnityCurves, one for each property
                var posKeyFrames = new Keyframe[3][];
                var rotKeyFrames = new Keyframe[3][];
                var scaleKeyFrames = new Keyframe[3][];

                for (int k = 0; k < posKeyFrames.Length; k++)
                {
                    posKeyFrames[k] = new Keyframe[sampleTimes.Count];
                    rotKeyFrames[k] = new Keyframe[sampleTimes.Count];
                    scaleKeyFrames[k] = new Keyframe[sampleTimes.Count];
                }

                // If we have a point in local coords represented as a column-vector x, the equation of x in coordinates relative to source's parent is:
                //   x_grandparent = source * dest * x
                // Now we're going to change dest to dest' which has the animation from source. And we're going to change
                // source to source' which has no animation. The equation of x will become:
                //   x_grandparent = source' * dest' * x
                // We're not changing x_grandparent and x, so we need that:
                //   source * dest = source' * dest'
                // We know dest and source (both animated) and source' (static). Solve for dest':
                //   dest' = (source')^-1 * source * dest
                int keyIndex = 0;
                var sourceStaticMatrixInverse = Matrix4x4.TRS(source.localPosition, source.localRotation, source.localScale).inverse;
                foreach (var currSampleTime in sampleTimes)
                {
                    var sourceLocalMatrix = GetTransformMatrix(currSampleTime, source, sourceUnityCurves);
                    var destLocalMatrix = GetTransformMatrix(currSampleTime, dest, destUnityCurves);

                    var newLocalMatrix = sourceStaticMatrixInverse * sourceLocalMatrix * destLocalMatrix;

                    FbxVector4 translation, rotation, scale;
                    GetTRSFromMatrix(newLocalMatrix, out translation, out rotation, out scale);

                    // get rotation directly from matrix, as otherwise causes issues
                    // with negative rotations.
                    var rot = newLocalMatrix.rotation.eulerAngles;

                    for (int k = 0; k < 3; k++)
                    {
                        posKeyFrames[k][keyIndex] = new Keyframe(currSampleTime, (float)translation[k]);
                        rotKeyFrames[k][keyIndex] = new Keyframe(currSampleTime, rot[k]);
                        scaleKeyFrames[k][keyIndex] = new Keyframe(currSampleTime, (float)scale[k]);
                    }
                    keyIndex++;
                }

                // create the new list of unity curves, and add it to dest's curves
                var newUnityCurves = new List<UnityCurve>();
                string posPropName = "m_LocalPosition.";
                string rotPropName = "localEulerAnglesRaw.";
                string scalePropName = "m_LocalScale.";
                var xyz = "xyz";
                for (int k = 0; k < 3; k++)
                {
                    var posUniCurve = new UnityCurve(posPropName + xyz[k], new AnimationCurve(posKeyFrames[k]), typeof(Transform));
                    newUnityCurves.Add(posUniCurve);

                    var rotUniCurve = new UnityCurve(rotPropName + xyz[k], new AnimationCurve(rotKeyFrames[k]), typeof(Transform));
                    newUnityCurves.Add(rotUniCurve);

                    var scaleUniCurve = new UnityCurve(scalePropName + xyz[k], new AnimationCurve(scaleKeyFrames[k]), typeof(Transform));
                    newUnityCurves.Add(scaleUniCurve);
                }

                // remove old transform curves
                RemoveTransformCurves(ref sourceUnityCurves);
                RemoveTransformCurves(ref destUnityCurves);

                unityCurves[source.gameObject] = sourceUnityCurves;
                if (!unityCurves.ContainsKey(dest.gameObject))
                {
                    unityCurves.Add(dest.gameObject, newUnityCurves);
                    return;
                }
                unityCurves[dest.gameObject].AddRange(newUnityCurves);

            }


            void RemoveTransformCurves(ref List<UnityCurve> curves)
            {
                var transformCurves = new List<UnityCurve>();
                var transformPropNames = new string[] { "m_LocalPosition.", "m_LocalRotation", "localEulerAnglesRaw.", "m_LocalScale." };
                foreach (var curve in curves)
                {
                    foreach (var prop in transformPropNames)
                    {
                        if (curve.propertyName.StartsWith(prop))
                        {
                            transformCurves.Add(curve);
                            break;
                        }
                    }
                }
                foreach (var curve in transformCurves)
                {
                    curves.Remove(curve);
                }
            }

            Matrix4x4 GetTransformMatrix(float currSampleTime, Transform orig, List<UnityCurve> unityCurves)
            {
                var sourcePos = orig.localPosition;
                var sourceRot = orig.localRotation;
                var sourceScale = orig.localScale;

                foreach (var uniCurve in unityCurves)
                {
                    float currSampleValue = uniCurve.uniAnimCurve.Evaluate(currSampleTime);
                    string propName = uniCurve.propertyName;
                    // try position, scale, quat then euler
                    int temp = QuaternionCurve.GetQuaternionIndex(propName);
                    if (temp >= 0)
                    {
                        sourceRot[temp] = currSampleValue;
                        continue;
                    }
                    temp = EulerCurve.GetEulerIndex(propName);
                    if (temp >= 0)
                    {
                        var euler = sourceRot.eulerAngles;
                        euler[temp] = currSampleValue;
                        sourceRot.eulerAngles = euler;
                        continue;
                    }
                    temp = GetPositionIndex(propName);
                    if (temp >= 0)
                    {
                        sourcePos[temp] = currSampleValue;
                        continue;
                    }
                    temp = GetScaleIndex(propName);
                    if (temp >= 0)
                    {
                        sourceScale[temp] = currSampleValue;
                    }
                }

                sourceRot = Quaternion.Euler(sourceRot.eulerAngles.x, sourceRot.eulerAngles.y, sourceRot.eulerAngles.z);
                return Matrix4x4.TRS(sourcePos, sourceRot, sourceScale);
            }



            int GetPositionIndex(string uniPropertyName)
            {
                System.StringComparison ct = System.StringComparison.CurrentCulture;
                bool isPositionComponent = uniPropertyName.StartsWith("m_LocalPosition.", ct);

                if (!isPositionComponent) { return -1; }

                switch (uniPropertyName[uniPropertyName.Length - 1])
                {
                    case 'x':
                        return 0;
                    case 'y':
                        return 1;
                    case 'z':
                        return 2;
                    default:
                        return -1;
                }
            }

            int GetScaleIndex(string uniPropertyName)
            {
                System.StringComparison ct = System.StringComparison.CurrentCulture;
                bool isScaleComponent = uniPropertyName.StartsWith("m_LocalScale.", ct);

                if (!isScaleComponent) { return -1; }

                switch (uniPropertyName[uniPropertyName.Length - 1])
                {
                    case 'x':
                        return 0;
                    case 'y':
                        return 1;
                    case 'z':
                        return 2;
                    default:
                        return -1;
                }
            }

            /// <summary>
            /// Gets or creates the rotation curve for GameObject uniGO.
            /// </summary>
            /// <returns>The rotation curve.</returns>
            /// <param name="uniGO">Unity GameObject.</param>
            /// <param name="frameRate">Frame rate.</param>
            /// <param name="rotations">Rotations.</param>
            /// <typeparam name="T"> RotationCurve is abstract so specify type of RotationCurve to create.</typeparam>
            RotationCurve GetRotationCurve<T>(
              GameObject uniGO, float frameRate,
              ref Dictionary<GameObject, RotationCurve> rotations
              ) where T : RotationCurve, new()
            {
                RotationCurve rotCurve;
                if (!rotations.TryGetValue(uniGO, out rotCurve))
                {
                    rotCurve = new T { SampleRate = frameRate };
                    rotations.Add(uniGO, rotCurve);
                }
                return rotCurve;
            }

            /// <summary>
            /// configures default camera for the scene
            /// </summary>
            void SetDefaultCamera(FbxScene fbxScene)
            {
                if (fbxScene == null) { return; }

                if (string.IsNullOrEmpty(DefaultCamera))
                    DefaultCamera = Globals.FBXSDK_CAMERA_PERSPECTIVE;

                fbxScene.GetGlobalSettings().SetDefaultCamera(DefaultCamera);
            }



            bool exportCancelled = false;




            /// <summary>
            /// Exports the bone transform.
            /// </summary>
            /// <returns><c>true</c>, if bone transform was exported, <c>false</c> otherwise.</returns>
            /// <param name="fbxNode">Fbx node.</param>
            /// <param name="fbxScene">Fbx scene.</param>
            /// <param name="unityBone">Unity bone.</param>
            /// <param name="boneInfo">Bone info.</param>
            bool ExportBoneTransform(FbxNode fbxNode, FbxScene fbxScene, Transform unityBone, SkinnedMeshBoneInfo boneInfo)
            {
                if (boneInfo == null || boneInfo.skinnedMesh == null || boneInfo.boneDict == null || unityBone == null)
                {
                    return false;
                }

                var skinnedMesh = boneInfo.skinnedMesh;
                var boneDict = boneInfo.boneDict;
                var rootBone = skinnedMesh.rootBone;

                // setup the skeleton
                var fbxSkeleton = fbxNode.GetSkeleton();
                if (fbxSkeleton == null)
                {
                    fbxSkeleton = FbxSkeleton.Create(fbxScene, unityBone.name + SkeletonPrefix);

                    fbxSkeleton.Size.Set(1.0f * UnitScaleFactor);
                    fbxNode.SetNodeAttribute(fbxSkeleton);
                }
                var fbxSkeletonType = FbxSkeleton.EType.eLimbNode;

                // Only set the rootbone's skeleton type to FbxSkeleton.EType.eRoot
                // if it has at least one child that is also a bone.
                // Otherwise if it is marked as Root but has no bones underneath,
                // Maya will import it as a Null object instead of a bone.
                if (rootBone == unityBone && rootBone.childCount > 0)
                {
                    var hasChildBone = false;
                    foreach (Transform child in unityBone)
                    {
                        if (boneDict.ContainsKey(child))
                        {
                            hasChildBone = true;
                            break;
                        }
                    }
                    if (hasChildBone)
                    {
                        fbxSkeletonType = FbxSkeleton.EType.eRoot;
                    }
                }
                fbxSkeleton.SetSkeletonType(fbxSkeletonType);

                var bindPoses = skinnedMesh.sharedMesh.bindposes;

                // get bind pose
                Matrix4x4 bindPose = GetBindPose(unityBone, bindPoses, ref boneInfo);

                Matrix4x4 pose;
                // get parent's bind pose
                Matrix4x4 parentBindPose = GetBindPose(unityBone.parent, bindPoses, ref boneInfo);
                pose = parentBindPose * bindPose.inverse;

                FbxVector4 translation, rotation, scale;
                GetTRSFromMatrix(pose, out translation, out rotation, out scale);

                // Export bones with zero rotation, using a pivot instead to set the rotation
                // so that the bones are easier to animate and the rotation shows up as the "joint orientation" in Maya.
                fbxNode.LclTranslation.Set(new FbxDouble3(translation.X * UnitScaleFactor, translation.Y * UnitScaleFactor, translation.Z * UnitScaleFactor));
                fbxNode.LclRotation.Set(new FbxDouble3(0, 0, 0));
                fbxNode.LclScaling.Set(new FbxDouble3(scale.X, scale.Y, scale.Z));

                // TODO (UNI-34294): add detailed comment about why we export rotation as pre-rotation
                fbxNode.SetRotationActive(true);
                fbxNode.SetPivotState(FbxNode.EPivotSet.eSourcePivot, FbxNode.EPivotState.ePivotReference);
                fbxNode.SetPreRotation(FbxNode.EPivotSet.eSourcePivot, new FbxVector4(rotation.X, rotation.Y, rotation.Z));

                return true;
            }

            void GetTRSFromMatrix(Matrix4x4 unityMatrix, out FbxVector4 translation, out FbxVector4 rotation, out FbxVector4 scale)
            {
                // FBX is transposed relative to Unity: transpose as we convert.
                FbxMatrix matrix = new FbxMatrix();
                matrix.SetColumn(0, new FbxVector4(unityMatrix.GetRow(0).x, unityMatrix.GetRow(0).y, unityMatrix.GetRow(0).z, unityMatrix.GetRow(0).w));
                matrix.SetColumn(1, new FbxVector4(unityMatrix.GetRow(1).x, unityMatrix.GetRow(1).y, unityMatrix.GetRow(1).z, unityMatrix.GetRow(1).w));
                matrix.SetColumn(2, new FbxVector4(unityMatrix.GetRow(2).x, unityMatrix.GetRow(2).y, unityMatrix.GetRow(2).z, unityMatrix.GetRow(2).w));
                matrix.SetColumn(3, new FbxVector4(unityMatrix.GetRow(3).x, unityMatrix.GetRow(3).y, unityMatrix.GetRow(3).z, unityMatrix.GetRow(3).w));

                // FBX wants translation, rotation (in euler angles) and scale.
                // We assume there's no real shear, just rounding error.
                FbxVector4 shear;
                double sign;
                matrix.GetElements(out translation, out rotation, out shear, out scale, out sign);
            }

            /// <summary>
            /// Recursively go through the hierarchy, unioning the bounding box centers
            /// of all the children, to find the combined bounds.
            /// </summary>
            /// <param name="t">Transform.</param>
            /// <param name="boundsUnion">The Bounds that is the Union of all the bounds on this transform's hierarchy.</param>
            static void EncapsulateBounds(Transform t, ref Bounds boundsUnion)
            {
                var bounds = GetBounds(t);
                boundsUnion.Encapsulate(bounds);

                foreach (Transform child in t)
                {
                    EncapsulateBounds(child, ref boundsUnion);
                }
            }

            /// <summary>
            /// Gets the bounds of a transform. 
            /// Looks first at the Renderer, then Mesh, then Collider.
            /// Default to a bounds with center transform.position and size zero.
            /// </summary>
            /// <returns>The bounds.</returns>
            /// <param name="t">Transform.</param>
            static Bounds GetBounds(Transform t)
            {
                var renderer = t.GetComponent<Renderer>();
                if (renderer)
                {
                    return renderer.bounds;
                }
                var mesh = t.GetComponent<Mesh>();
                if (mesh)
                {
                    return mesh.bounds;
                }
                var collider = t.GetComponent<Collider>();
                if (collider)
                {
                    return collider.bounds;
                }
                return new Bounds(t.position, Vector3.zero);
            }




            /// <summary>
            /// Removes the diacritics (i.e. accents) from letters.
            /// e.g. é becomes e
            /// </summary>
            /// <returns>Text with accents removed.</returns>
            /// <param name="text">Text.</param>
            string RemoveDiacritics(string text)
            {
                var normalizedString = text.Normalize(System.Text.NormalizationForm.FormD);
                var stringBuilder = new System.Text.StringBuilder();

                foreach (var c in normalizedString)
                {
                    var unicodeCategory = System.Globalization.CharUnicodeInfo.GetUnicodeCategory(c);
                    if (unicodeCategory != System.Globalization.UnicodeCategory.NonSpacingMark)
                    {
                        stringBuilder.Append(c);
                    }
                }

                return stringBuilder.ToString().Normalize(System.Text.NormalizationForm.FormC);
            }

            string ConvertToMayaCompatibleName(string name)
            {
                //不能为空
                //不能以数字开头
                //除了字母和数字以外只能使用"_"符号

                if (string.IsNullOrEmpty(name))
                {
                    return InvalidCharReplacement.ToString();
                }
                string newName = RemoveDiacritics(name);

                if (char.IsDigit(newName[0]))
                {
                    newName = newName.Insert(0, InvalidCharReplacement.ToString());
                }

                for (int i = 0; i < newName.Length; i++)
                {
                    if (!char.IsLetterOrDigit(newName, i))
                    {
                        if (i < newName.Length - 1 && newName[i] == MayaNamespaceSeparator)
                        {
                            continue;
                        }
                        newName = newName.Replace(newName[i], InvalidCharReplacement);
                    }
                }
                return newName;
            }


            /// <summary>
            /// Export animation curve key samples
            /// </summary> 
            void ExportAnimationSamples(AnimationCurve uniAnimCurve, FbxAnimCurve fbxAnimCurve,
              double sampleRate,
              UnityToMayaConvertSceneHelper convertSceneHelper)
            {

                using (new FbxAnimCurveModifyHelper(new List<FbxAnimCurve> { fbxAnimCurve }))
                {
                    foreach (var currSampleTime in MeshInfo.GetSampleTimes(new AnimationCurve[] { uniAnimCurve }, sampleRate))
                    {
                        float currSampleValue = uniAnimCurve.Evaluate((float)currSampleTime);

                        var fbxTime = FbxTime.FromSecondDouble(currSampleTime);

                        int fbxKeyIndex = fbxAnimCurve.KeyAdd(fbxTime);

                        fbxAnimCurve.KeySet(fbxKeyIndex,
                            fbxTime,
                            convertSceneHelper.Convert(currSampleValue)
                        );
                    }
                }
            }

            /// <summary>
            /// Export an AnimationClip as a single take
            /// </summary> 
            void ExportAnimationClip(AnimationClip uniAnimClip, GameObject uniRoot, FbxScene fbxScene)
            {
                if (!uniAnimClip || !uniRoot || fbxScene == null) return;

                if (exportSettings.showDebugInfo)
                    Debug.Log(string.Format("Exporting animation clip ({1}) for {0}", uniRoot.name, uniAnimClip.name));

                // setup anim stack
                FbxAnimStack fbxAnimStack = FbxAnimStack.Create(fbxScene, uniAnimClip.name);
                fbxAnimStack.Description.Set("Animation Take: " + uniAnimClip.name);

                // add one mandatory animation layer
                FbxAnimLayer fbxAnimLayer = FbxAnimLayer.Create(fbxScene, "Animation Base Layer");
                fbxAnimStack.AddMember(fbxAnimLayer);

                // Set up the FPS so our frame-relative math later works out
                // Custom frame rate isn't really supported in FBX SDK (there's
                // a bug), so try hard to find the nearest time mode.
                FbxTime.EMode timeMode = FbxTime.EMode.eCustom;
                double precision = 1e-6;
                while (timeMode == FbxTime.EMode.eCustom && precision < 1000)
                {
                    timeMode = FbxTime.ConvertFrameRateToTimeMode(uniAnimClip.frameRate, precision);
                    precision *= 10;
                }
                if (timeMode == FbxTime.EMode.eCustom)
                {
                    timeMode = FbxTime.EMode.eFrames30;
                }

                fbxScene.GetGlobalSettings().SetTimeMode(timeMode);

                // set time correctly
                var fbxStartTime = FbxTime.FromSecondDouble(0);
                var fbxStopTime = FbxTime.FromSecondDouble(uniAnimClip.length);

                fbxAnimStack.SetLocalTimeSpan(new FbxTimeSpan(fbxStartTime, fbxStopTime));

                var unityCurves = new Dictionary<GameObject, List<UnityCurve>>();

                // extract and store all necessary information from the curve bindings, namely the animation curves
                // and their corresponding property names for each GameObject.
                foreach (EditorCurveBinding uniCurveBinding in AnimationUtility.GetCurveBindings(uniAnimClip))
                {
                    Object uniObj = AnimationUtility.GetAnimatedObject(uniRoot, uniCurveBinding);
                    if (!uniObj)
                    {
                        continue;
                    }

                    AnimationCurve uniAnimCurve = AnimationUtility.GetEditorCurve(uniAnimClip, uniCurveBinding);
                    if (uniAnimCurve == null)
                    {
                        continue;
                    }

                    var uniGO = GetGameObject(uniObj);
                    // Check if the GameObject has an FBX node to the animation. It might be null because the LOD selected doesn't match the one on the gameobject. 
                    if (!uniGO || MapUnityObjectToFbxNode.ContainsKey(uniGO) == false)
                    {
                        continue;
                    }

                    if (unityCurves.ContainsKey(uniGO))
                    {
                        unityCurves[uniGO].Add(new UnityCurve(uniCurveBinding.propertyName, uniAnimCurve, uniCurveBinding.type));
                        continue;
                    }
                    unityCurves.Add(uniGO, new List<UnityCurve>() { new UnityCurve(uniCurveBinding.propertyName, uniAnimCurve, uniCurveBinding.type) });
                }

                // transfer root motion
                var animSource = exportSettings.animationSource;
                var animDest = exportSettings.animationDest;
                if (animSource && animDest && animSource != animDest)
                {
                    // list of all transforms between source and dest, including source and dest
                    var transformsFromSourceToDest = new List<Transform>();
                    var curr = animDest;
                    while (curr != animSource)
                    {
                        transformsFromSourceToDest.Add(curr);
                        curr = curr.parent;
                    }
                    transformsFromSourceToDest.Add(animSource);
                    transformsFromSourceToDest.Reverse();

                    // while there are 2 transforms in the list, transfer the animation from the
                    // first to the next transform.
                    // Then remove the first transform from the list.
                    while (transformsFromSourceToDest.Count >= 2)
                    {
                        var source = transformsFromSourceToDest[0];
                        transformsFromSourceToDest.RemoveAt(0);
                        var dest = transformsFromSourceToDest[0];

                        TransferMotion(source, dest, uniAnimClip.frameRate, ref unityCurves);
                    }
                }

                /* The major difficulty: Unity uses quaternions for rotation
                    * (which is how it should be) but FBX uses Euler angles. So we
                    * need to gather up the list of transform curves per object.
                    * 
                    * For euler angles, Unity uses ZXY rotation order while Maya uses XYZ.
                    * Maya doesn't import files with ZXY rotation correctly, so have to convert to XYZ.
                    * Need all 3 curves in order to convert.
                    * 
                    * Also, in both cases, prerotation has to be removed from the animated rotation if
                    * there are bones being exported.
                    */
                var rotations = new Dictionary<GameObject, RotationCurve>();

                // export the animation curves for each GameObject that has animation
                foreach (var kvp in unityCurves)
                {
                    var uniGO = kvp.Key;
                    foreach (var uniCurve in kvp.Value)
                    {
                        var propertyName = uniCurve.propertyName;
                        var uniAnimCurve = uniCurve.uniAnimCurve;

                        // Do not create the curves if the component is a SkinnedMeshRenderer and if the option in FBX Export settings is toggled on.
                        if (!exportSettings.animatedSkinnedMesh && (uniGO.GetComponent<SkinnedMeshRenderer>() != null))
                        {
                            continue;
                        }

                        FbxNode fbxNode;
                        if (!MapUnityObjectToFbxNode.TryGetValue(uniGO, out fbxNode))
                        {
                            Debug.LogError(string.Format("no FbxNode found for {0}", uniGO.name));
                            continue;
                        }

                        int index = QuaternionCurve.GetQuaternionIndex(propertyName);
                        if (index >= 0)
                        {
                            // Rotation property; save it to convert quaternion -> euler later.
                            RotationCurve rotCurve = GetRotationCurve<QuaternionCurve>(uniGO, uniAnimClip.frameRate, ref rotations);
                            rotCurve.SetCurve(index, uniAnimCurve);
                            continue;
                        }

                        // If this is an euler curve with a prerotation, then need to sample animations to remove the prerotation.
                        // Otherwise can export normally with tangents.
                        index = EulerCurve.GetEulerIndex(propertyName);
                        if (index >= 0 &&
                            // still need to sample euler curves if baking is specified
                            (exportSettings.bakeAnimationProperty ||
                            // also need to make sure to sample if there is a prerotation, as this is baked into the Unity curves
                            fbxNode.GetPreRotation(FbxNode.EPivotSet.eSourcePivot).Distance(new FbxVector4()) > 0))
                        {

                            RotationCurve rotCurve = GetRotationCurve<EulerCurve>(uniGO, uniAnimClip.frameRate, ref rotations);
                            rotCurve.SetCurve(index, uniAnimCurve);
                            continue;
                        }

                        // simple property (e.g. intensity), export right away
                        ExportAnimationCurve(fbxNode, uniAnimCurve, uniAnimClip.frameRate,
                            propertyName, uniCurve.propertyType,
                            fbxAnimLayer);
                    }
                }

                // now export all the quaternion curves 
                foreach (var kvp in rotations)
                {
                    var unityGo = kvp.Key;
                    var rot = kvp.Value;

                    FbxNode fbxNode;
                    if (!MapUnityObjectToFbxNode.TryGetValue(unityGo, out fbxNode))
                    {
                        Debug.LogError(string.Format("no FbxNode found for {0}", unityGo.name));
                        continue;
                    }
                    rot.Animate(unityGo.transform, fbxNode, fbxAnimLayer, exportSettings.showDebugInfo);
                }
            }

            /// <summary>
            /// Export an AnimationCurve.
            /// NOTE: This is not used for rotations, because we need to convert from
            /// quaternion to euler and various other stuff.
            /// </summary> 
            void ExportAnimationCurve(FbxNode fbxNode,
                                                  AnimationCurve uniAnimCurve,
                                                  float frameRate,
                                                  string uniPropertyName,
                                                  System.Type uniPropertyType,
                                                  FbxAnimLayer fbxAnimLayer)
            {
                if (fbxNode == null)
                {
                    return;
                }

                if (exportSettings.showDebugInfo)
                {
                    Debug.Log("Exporting animation for " + fbxNode.GetName() + " (" + uniPropertyName + ")");
                }

                var fbxConstraint = GetFbxConstraint(fbxNode, uniPropertyType);
                FbxPropertyChannelPair[] fbxPropertyChannelPairs;
                if (!FbxPropertyChannelPair.TryGetValue(uniPropertyName, out fbxPropertyChannelPairs, fbxConstraint))
                {
                    Debug.LogWarning(string.Format("no mapping from Unity '{0}' to fbx property", uniPropertyName));
                    return;
                }

                foreach (var fbxPropertyChannelPair in fbxPropertyChannelPairs)
                {
                    // map unity property name to fbx property
                    var fbxProperty = GetFbxProperty(fbxNode, fbxPropertyChannelPair.Property, uniPropertyType, uniPropertyName);
                    if (!fbxProperty.IsValid())
                    {
                        Debug.LogError(string.Format("no fbx property {0} found on {1} node or nodeAttribute ", fbxPropertyChannelPair.Property, fbxNode.GetName()));
                        return;
                    }
                    if (!fbxProperty.GetFlag(FbxPropertyFlags.EFlags.eAnimatable))
                    {
                        Debug.LogErrorFormat("fbx property {0} found on node {1} is not animatable", fbxPropertyChannelPair.Property, fbxNode.GetName());
                    }

                    // Create the AnimCurve on the channel
                    FbxAnimCurve fbxAnimCurve = fbxProperty.GetCurve(fbxAnimLayer, fbxPropertyChannelPair.Channel, true);
                    if (fbxAnimCurve == null)
                    {
                        return;
                    }

                    // create a convert scene helper so that we can convert from Unity to Maya
                    // AxisSystem (LeftHanded to RightHanded) and FBX's default units 
                    // (Meters to Centimetres)
                    var convertSceneHelper = new UnityToMayaConvertSceneHelper(uniPropertyName, fbxNode, UnitScaleFactor);

                    if (exportSettings.bakeAnimationProperty)
                    {
                        ExportAnimationSamples(uniAnimCurve, fbxAnimCurve, frameRate, convertSceneHelper);
                    }
                    else
                    {
                        ExportAnimationKeys(uniAnimCurve, fbxAnimCurve, convertSceneHelper);
                    }
                }
            }


            #region Helper帮助
            FbxDouble3 Vector3ToFbxDouble3(Vector3 v)
            {
                return new FbxDouble3(v.x, v.y, v.z);
            }

            FbxDouble3 Vector4ToFbxDouble3(FbxVector4 v)
            {
                return new FbxDouble3(v.X, v.Y, v.Z);
            }

            //计算物体与根节点root之间的物体数量 不包括本体和root
            int GetObjectToRootDepth(Transform startObject, Transform root)
            {
                if (startObject == null)
                {
                    return 0;
                }

                int count = 0;
                var parent = startObject.parent;
                while (parent != null && parent != root)
                {
                    count++;
                    parent = parent.parent;
                }
                return count;
            }

            //统计全部节点数量
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

            //统计全部节点数量
            int GetHierarchyCount(GameObject root)
            {
                int count = 0;
                Queue<GameObject> queue = new Queue<GameObject>();
                queue.Enqueue(root);
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

            void ReplaceFile()
            {
                if (tempFilePath.Equals(filePath) || !File.Exists(tempFilePath))
                {
                    return;
                }

                // delete old file
                try
                {
                    File.Delete(filePath);
                    // delete meta file also
                    File.Delete(filePath + ".meta");
                }
                catch (IOException)
                {
                }

                if (File.Exists(filePath))
                {
                    Debug.LogWarning("Failed to delete file: " + filePath);
                }

                // rename the new file
                try
                {
                    File.Move(tempFilePath, filePath);
                }
                catch (IOException)
                {
                    Debug.LogWarning(string.Format("Failed to move file {0} to {1}", tempFilePath, filePath));
                }
            }

            string SaveMetafile()
            {
                var tempMetafilePath = Path.GetTempFileName();

                if (AssetDatabase.LoadAssetAtPath(filePath, typeof(Object)) == null)
                {
                    Debug.LogWarning(string.Format("Failed to find a valid asset at {0}. Import settings will be reset to default values.", filePath));
                    return "";
                }

                // get metafile for original fbx file
                var metafile = filePath + ".meta";

#if UNITY_2019_1_OR_NEWER
                metafile = VersionControl.Provider.GetAssetByPath(filePath).metaPath;
#endif

                // save it to a temp file
                try
                {
                    File.Copy(metafile, tempMetafilePath, true);
                }
                catch (IOException)
                {
                    Debug.LogWarning(string.Format("Failed to copy file {0} to {1}. Import settings will be reset to default values.", metafile, tempMetafilePath));
                    return "";
                }

                return tempMetafilePath;
            }

            void ReplaceMetafile(string metafilePath)
            {
                if (AssetDatabase.LoadAssetAtPath(filePath, typeof(Object)) == null)
                {
                    Debug.LogWarning(string.Format("Failed to find a valid asset at {0}. Import settings will be reset to default values.", filePath));
                    return;
                }

                // get metafile for new fbx file
                var metafile = filePath + ".meta";

#if UNITY_2019_1_OR_NEWER
                metafile = VersionControl.Provider.GetAssetByPath(filePath).metaPath;
#endif

                // replace metafile with original one in temp file
                try
                {
                    File.Copy(metafilePath, metafile, true);
                }
                catch (IOException)
                {
                    Debug.LogWarning(string.Format("Failed to copy file {0} to {1}. Import settings will be reset to default values.", metafilePath, filePath));
                }
            }

            void DeleteTempFile()
            {
                if (!File.Exists(tempFilePath))
                {
                    return;
                }

                try
                {
                    File.Delete(tempFilePath);
                }
                catch (IOException)
                {
                }

                if (File.Exists(tempFilePath))
                {
                    Debug.LogWarning("Failed to delete file: " + tempFilePath);
                }
            }
            #endregion

            #region 动作
            //返回物体(被动画驱动)挂载的节点
            GameObject GetGameObject(Object obj)
            {
                if (obj is UnityEngine.Transform)
                {
                    var xform = obj as UnityEngine.Transform;
                    return xform.gameObject;
                }
                else if (obj is UnityEngine.SkinnedMeshRenderer)
                {
                    var skinnedMeshRenderer = obj as UnityEngine.SkinnedMeshRenderer;
                    return skinnedMeshRenderer.gameObject;
                }
                else if (obj is UnityEngine.GameObject)
                {
                    return obj as UnityEngine.GameObject;
                }
                else if (obj is Behaviour)
                {
                    var behaviour = obj as Behaviour;
                    return behaviour.gameObject;
                }

                return null;
            }

            //收集动画引用的节点和帧动画
            void CollectDependencies(AnimationOnlyExportData exportData, AnimationClip[] animClips, GameObject animRoot, ExportSettings exportSettings)
            {
                foreach (var animClip in animClips)
                {
                    if (exportData.animationClips.ContainsKey(animClip))
                        continue;
                    exportData.animationClips.Add(animClip, animRoot);

                    //遍历轨道
                    foreach (EditorCurveBinding uniCurveBinding in AnimationUtility.GetCurveBindings(animClip))
                    {
                        //轨道驱动的Object
                        Object uniObj = AnimationUtility.GetAnimatedObject(animRoot, uniCurveBinding);
                        if (!uniObj)
                            continue;

                        GameObject unityGo = GetGameObject(uniObj);
                        if (!unityGo)
                            continue;

                        if (!exportSettings.animatedSkinnedMesh && unityGo.GetComponent<SkinnedMeshRenderer>())
                            continue;

                        if ((uniCurveBinding.type == typeof(SkinnedMeshRenderer)) && unityGo.GetComponent<SkinnedMeshRenderer>())
                        {
                            //仅当当轨道用于驱动形态键时连带着导出mesh
                            if (FbxPropertyChannelPair.TryGetValue(uniCurveBinding.propertyName, out FbxPropertyChannelPair[] channelPairs))
                            {
                                exportData.exportComponent[unityGo] = typeof(SkinnedMeshRenderer);
                            }
                        }

                        exportData.goExportSet.Add(unityGo);
                    }
                }
            }

            //获取动作数据
            AnimationOnlyExportData GetExportData(GameObject go, ExportSettings exportSettings = null)
            {
                if (exportSettings.modelAnimIncludeOption == Include.Model)
                    return null;

                // gather all animation clips
                var legacyAnim = go.GetComponentsInChildren<Animation>();
                var genericAnim = go.GetComponentsInChildren<Animator>();
                var exportData = new AnimationOnlyExportData();

                int depthFromRootAnimation = int.MaxValue;
                Animation rootAnimation = null; //寻找挂点最高的Animation组件作为Root

                foreach (var anim in legacyAnim)
                {
                    int count = GetObjectToRootDepth(anim.transform, go.transform);

                    if (count < depthFromRootAnimation)
                    {
                        depthFromRootAnimation = count;
                        rootAnimation = anim;
                    }

                    var animClips = AnimationUtility.GetAnimationClips(anim.gameObject);
                    CollectDependencies(exportData, animClips, anim.gameObject, exportSettings);
                }

                int depthFromRootAnimator = int.MaxValue;
                Animator rootAnimator = null;

                foreach (var anim in genericAnim)
                {
                    int count = GetObjectToRootDepth(anim.transform, go.transform);

                    if (count < depthFromRootAnimator)
                    {
                        depthFromRootAnimator = count;
                        rootAnimator = anim;
                    }

                    // Try the animator controller (mecanim)
                    var controller = anim.runtimeAnimatorController;
                    if (controller)
                    {
                        CollectDependencies(exportData, controller.animationClips, anim.gameObject, exportSettings);
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
            #endregion

            #region Mesh相关资源：Mesh、材质

            //获取Mesh的数据通道 如果不存在就创建
            FbxLayer GetOrCreateLayer(FbxMesh fbxMesh, int layer = 0 /* default layer */)
            {
                int maxLayerIndex = fbxMesh.GetLayerCount() - 1;
                while (layer > maxLayerIndex)
                {
                    // We'll have to create the layer (potentially several).
                    // Make sure to avoid infinite loops even if there's an
                    // FbxSdk bug.
                    int newLayerIndex = fbxMesh.CreateLayer();
                    if (newLayerIndex <= maxLayerIndex)
                    {
                        // Error!
                        throw new System.Exception(
                            "Internal error: Unable to create mesh layer "
                            + (maxLayerIndex + 1)
                            + " on mesh " + fbxMesh.GetName());
                    }
                    maxLayerIndex = newLayerIndex;
                }
                return fbxMesh.GetLayer(layer);
            }

            //导出法线、切线、副切线、顶点色、UV0-UV3通道
            bool ExportComponentAttributes(MeshInfo mesh, FbxMesh fbxMesh, int[] unmergedTriangles)
            {
                //如果成功导出了任何通道 返回true
                bool exportedAttribute = false;

                // Set the normals on Layer 0.
                FbxLayer fbxLayer = GetOrCreateLayer(fbxMesh);

                if ((exportSettings.fbxChannels & FbxChannels.Normal) != 0 && mesh.HasValidNormals())
                {
                    using (var fbxLayerElement = FbxLayerElementNormal.Create(fbxMesh, "Normals"))
                    {
                        fbxLayerElement.SetMappingMode(FbxLayerElement.EMappingMode.eByPolygonVertex);
                        fbxLayerElement.SetReferenceMode(FbxLayerElement.EReferenceMode.eDirect);

                        // Add one normal per each vertex face index (3 per triangle)
                        FbxLayerElementArray fbxElementArray = fbxLayerElement.GetDirectArray();

                        for (int n = 0; n < unmergedTriangles.Length; n++)
                        {
                            int unityTriangle = unmergedTriangles[n];
                            fbxElementArray.Add(MeshInfo.ConvertToFbxVector4(mesh.Normals[unityTriangle]));
                        }

                        fbxLayer.SetNormals(fbxLayerElement);
                    }
                    exportedAttribute = true;
                }

                /// Set the binormals on Layer 0.
                if ((exportSettings.fbxChannels & FbxChannels.Binormal) != 0 && mesh.HasValidBinormals())
                {
                    using (var fbxLayerElement = FbxLayerElementBinormal.Create(fbxMesh, "Binormals"))
                    {
                        fbxLayerElement.SetMappingMode(FbxLayerElement.EMappingMode.eByPolygonVertex);
                        fbxLayerElement.SetReferenceMode(FbxLayerElement.EReferenceMode.eDirect);

                        // Add one normal per each vertex face index (3 per triangle)
                        FbxLayerElementArray fbxElementArray = fbxLayerElement.GetDirectArray();

                        for (int n = 0; n < unmergedTriangles.Length; n++)
                        {
                            int unityTriangle = unmergedTriangles[n];
                            fbxElementArray.Add(MeshInfo.ConvertToFbxVector4(mesh.Binormals[unityTriangle]));
                        }
                        fbxLayer.SetBinormals(fbxLayerElement);
                    }
                    exportedAttribute = true;
                }

                /// Set the tangents on Layer 0.
                if ((exportSettings.fbxChannels & FbxChannels.Tangent) != 0 && mesh.HasValidTangents())
                {
                    using (var fbxLayerElement = FbxLayerElementTangent.Create(fbxMesh, "Tangents"))
                    {
                        fbxLayerElement.SetMappingMode(FbxLayerElement.EMappingMode.eByPolygonVertex);
                        fbxLayerElement.SetReferenceMode(FbxLayerElement.EReferenceMode.eDirect);

                        // Add one normal per each vertex face index (3 per triangle)
                        FbxLayerElementArray fbxElementArray = fbxLayerElement.GetDirectArray();

                        for (int n = 0; n < unmergedTriangles.Length; n++)
                        {
                            int unityTriangle = unmergedTriangles[n];
                            fbxElementArray.Add(MeshInfo.ConvertToFbxVector4(
                                new Vector3(
                                    mesh.Tangents[unityTriangle][0],
                                    mesh.Tangents[unityTriangle][1],
                                    mesh.Tangents[unityTriangle][2]
                                )));
                        }
                        fbxLayer.SetTangents(fbxLayerElement);
                    }
                    exportedAttribute = true;
                }

                exportedAttribute |= ExportUVs(fbxMesh, mesh, unmergedTriangles);

                if ((exportSettings.fbxChannels & FbxChannels.VertexColor) != 0 && mesh.HasValidVertexColors())
                {
                    using (var fbxLayerElement = FbxLayerElementVertexColor.Create(fbxMesh, "VertexColors"))
                    {
                        fbxLayerElement.SetMappingMode(FbxLayerElement.EMappingMode.eByPolygonVertex);
                        fbxLayerElement.SetReferenceMode(FbxLayerElement.EReferenceMode.eIndexToDirect);

                        // set texture coordinates per vertex
                        FbxLayerElementArray fbxElementArray = fbxLayerElement.GetDirectArray();

                        // (Uni-31596) only copy unique UVs into this array, and index appropriately
                        for (int n = 0; n < mesh.VertexColors.Length; n++)
                        {
                            // Converting to Color from Color32, as Color32 stores the colors
                            // as ints between 0-255, while FbxColor and Color
                            // use doubles between 0-1
                            Color color = mesh.VertexColors[n];
                            fbxElementArray.Add(new FbxColor(color.r,
                                color.g,
                                color.b,
                                color.a));
                        }

                        // For each face index, point to a texture uv
                        FbxLayerElementArray fbxIndexArray = fbxLayerElement.GetIndexArray();
                        fbxIndexArray.SetCount(unmergedTriangles.Length);

                        for (int i = 0; i < unmergedTriangles.Length; i++)
                        {
                            fbxIndexArray.SetAt(i, unmergedTriangles[i]);
                        }
                        fbxLayer.SetVertexColors(fbxLayerElement);
                    }
                    exportedAttribute = true;
                }

                return exportedAttribute;
            }

            //导出UV0-UV3通道
            bool ExportUVs(FbxMesh fbxMesh, MeshInfo meshInfo, int[] unmergedTriangles)
            {
                var mesh = meshInfo.mesh;

                List<Vector2> uvs = new List<Vector2>();

                int k = 0;
                for (int i = 0; i < 8; i++)
                {
                    mesh.GetUVs(i, uvs);

                    if (uvs == null || uvs.Count == 0)
                    {
                        continue; // don't have these UV's, so skip
                    }

                    FbxLayer fbxLayer = GetOrCreateLayer(fbxMesh, k);
                    using (var fbxLayerElement = FbxLayerElementUV.Create(fbxMesh, "UVSet" + i))
                    {
                        fbxLayerElement.SetMappingMode(FbxLayerElement.EMappingMode.eByPolygonVertex);
                        fbxLayerElement.SetReferenceMode(FbxLayerElement.EReferenceMode.eIndexToDirect);

                        // set texture coordinates per vertex
                        FbxLayerElementArray fbxElementArray = fbxLayerElement.GetDirectArray();

                        // (Uni-31596) only copy unique UVs into this array, and index appropriately
                        for (int n = 0; n < uvs.Count; n++)
                        {
                            fbxElementArray.Add(new FbxVector2(uvs[n][0],
                                uvs[n][1]));
                        }

                        // For each face index, point to a texture uv
                        FbxLayerElementArray fbxIndexArray = fbxLayerElement.GetIndexArray();
                        fbxIndexArray.SetCount(unmergedTriangles.Length);

                        for (int j = 0; j < unmergedTriangles.Length; j++)
                        {
                            fbxIndexArray.SetAt(j, unmergedTriangles[j]);
                        }
                        fbxLayer.SetUVs(fbxLayerElement, FbxLayerElement.EType.eTextureDiffuse);
                    }
                    k++;
                    uvs.Clear();
                }

                // if we incremented k, then at least on set of UV's were exported
                return k > 0;
            }

            //导出形态键
            FbxBlendShape ExportBlendShapes(MeshInfo mesh, FbxMesh fbxMesh, FbxScene fbxScene, int[] unmergedTriangles)
            {
                var umesh = mesh.mesh;
                if (umesh.blendShapeCount == 0)
                    return null;

                var fbxBlendShape = FbxBlendShape.Create(fbxScene, umesh.name + "_BlendShape");
                fbxMesh.AddDeformer(fbxBlendShape);

                var numVertices = umesh.vertexCount;
                var basePoints = umesh.vertices;
                var baseNormals = umesh.normals;
                var baseTangents = umesh.tangents;
                var deltaPoints = new Vector3[numVertices];
                var deltaNormals = new Vector3[numVertices];
                var deltaTangents = new Vector3[numVertices];

                for (int bi = 0; bi < umesh.blendShapeCount; ++bi)
                {
                    var bsName = umesh.GetBlendShapeName(bi);
                    var numFrames = umesh.GetBlendShapeFrameCount(bi);
                    var fbxChannel = FbxBlendShapeChannel.Create(fbxScene, bsName);
                    fbxBlendShape.AddBlendShapeChannel(fbxChannel);

                    for (int fi = 0; fi < numFrames; ++fi)
                    {
                        var weight = umesh.GetBlendShapeFrameWeight(bi, fi);
                        umesh.GetBlendShapeFrameVertices(bi, fi, deltaPoints, deltaNormals, deltaTangents);

                        var fbxShapeName = bsName;

                        if (numFrames > 1)
                        {
                            fbxShapeName += "_" + fi;
                        }

                        var fbxShape = FbxShape.Create(fbxScene, fbxShapeName);
                        fbxChannel.AddTargetShape(fbxShape, weight);

                        // control points
                        fbxShape.InitControlPoints(ControlPointToIndex.Count());
                        for (int vi = 0; vi < numVertices; ++vi)
                        {
                            int ni = ControlPointToIndex[basePoints[vi]];
                            var v = basePoints[vi] + deltaPoints[vi];
                            fbxShape.SetControlPointAt(MeshInfo.ConvertToFbxVector4(v, UnitScaleFactor), ni);
                        }

                        // normals
                        if (mesh.HasValidNormals())
                        {
                            var elemNormals = fbxShape.CreateElementNormal();
                            elemNormals.SetMappingMode(FbxLayerElement.EMappingMode.eByPolygonVertex);
                            elemNormals.SetReferenceMode(FbxLayerElement.EReferenceMode.eDirect);
                            var dstNormals = elemNormals.GetDirectArray();
                            dstNormals.SetCount(unmergedTriangles.Length);
                            for (int ii = 0; ii < unmergedTriangles.Length; ++ii)
                            {
                                int vi = unmergedTriangles[ii];
                                var n = baseNormals[vi] + deltaNormals[vi];
                                dstNormals.SetAt(ii, MeshInfo.ConvertToFbxVector4(n));
                            }
                        }

                        // tangents
                        if (mesh.HasValidTangents())
                        {
                            var elemTangents = fbxShape.CreateElementTangent();
                            elemTangents.SetMappingMode(FbxLayerElement.EMappingMode.eByPolygonVertex);
                            elemTangents.SetReferenceMode(FbxLayerElement.EReferenceMode.eDirect);
                            var dstTangents = elemTangents.GetDirectArray();
                            dstTangents.SetCount(unmergedTriangles.Length);
                            for (int ii = 0; ii < unmergedTriangles.Length; ++ii)
                            {
                                int vi = unmergedTriangles[ii];
                                var t = (Vector3)baseTangents[vi] + deltaTangents[vi];
                                dstTangents.SetAt(ii, MeshInfo.ConvertToFbxVector4(t));
                            }
                        }
                    }
                }
                return fbxBlendShape;
            }

            //将硬盘上的贴图保存到FBX
            bool ExportTexture(Material unityMaterial, string unityPropName, FbxSurfaceMaterial fbxMaterial, string fbxPropName)
            {
                if (!unityMaterial)
                {
                    return false;
                }

                // Get the texture on this property, if any.
                if (!unityMaterial.HasProperty(unityPropName))
                {
                    return false;
                }
                var unityTexture = unityMaterial.GetTexture(unityPropName);
                if (!unityTexture)
                {
                    return false;
                }

                // Find its filename
                var textureSourceFullPath = AssetDatabase.GetAssetPath(unityTexture);
                if (string.IsNullOrEmpty(textureSourceFullPath))
                {
                    return false;
                }

                // get absolute filepath to texture
                textureSourceFullPath = Path.GetFullPath(textureSourceFullPath);

                if (exportSettings.showDebugInfo)
                {
                    Debug.Log(string.Format("{2}.{1} setting texture path {0}", textureSourceFullPath, fbxPropName, fbxMaterial.GetName()));
                }

                // Find the corresponding property on the fbx material.
                var fbxMaterialProperty = fbxMaterial.FindProperty(fbxPropName);
                if (fbxMaterialProperty == null || !fbxMaterialProperty.IsValid())
                {
                    Debug.Log("property not found");
                    return false;
                }

                // Find or create an fbx texture and link it up to the fbx material.
                if (!TextureMap.ContainsKey(textureSourceFullPath))
                {
                    var textureName = GetUniqueTextureName(fbxPropName + "_Texture");
                    var fbxTexture = FbxFileTexture.Create(fbxMaterial, textureName);
                    fbxTexture.SetFileName(textureSourceFullPath);
                    fbxTexture.SetTextureUse(FbxTexture.ETextureUse.eStandard);
                    fbxTexture.SetMappingType(FbxTexture.EMappingType.eUV);
                    TextureMap.Add(textureSourceFullPath, fbxTexture);
                }
                TextureMap[textureSourceFullPath].ConnectDstProperty(fbxMaterialProperty);

                return true;
            }

            //获取材质颜色 
            FbxDouble3 GetMaterialColor(Material unityMaterial, string unityPropName, float defaultValue = 1)
            {
                if (!unityMaterial)
                {
                    return new FbxDouble3(defaultValue);
                }
                if (!unityMaterial.HasProperty(unityPropName))
                {
                    return new FbxDouble3(defaultValue);
                }
                var unityColor = unityMaterial.GetColor(unityPropName);
                return new FbxDouble3(unityColor.r, unityColor.g, unityColor.b);
            }

            /// Export (and map) a Unity PBS material to FBX classic material 
            /// Sets up the material to polygon mapping for fbxMesh.
            /// To determine which part of the mesh uses which material, look at the submeshes
            /// and which polygons they represent.
            /// Assuming equal number of materials as submeshes, and that they are in the same order.
            /// (i.e. submesh 1 uses material 1) 
            void AssignLayerElementMaterial(FbxMesh fbxMesh, Mesh mesh, int materialCount)
            {
                // Add FbxLayerElementMaterial to layer 0 of the node
                FbxLayer fbxLayer = fbxMesh.GetLayer(0 /* default layer */);
                if (fbxLayer == null)
                {
                    fbxMesh.CreateLayer();
                    fbxLayer = fbxMesh.GetLayer(0 /* default layer */);
                }

                using (var fbxLayerElement = FbxLayerElementMaterial.Create(fbxMesh, "Material"))
                {
                    // if there is only one material then set everything to that material
                    if (materialCount == 1)
                    {
                        fbxLayerElement.SetMappingMode(FbxLayerElement.EMappingMode.eAllSame);
                        fbxLayerElement.SetReferenceMode(FbxLayerElement.EReferenceMode.eIndexToDirect);

                        FbxLayerElementArray fbxElementArray = fbxLayerElement.GetIndexArray();
                        fbxElementArray.Add(0);
                    }
                    else
                    {
                        fbxLayerElement.SetMappingMode(FbxLayerElement.EMappingMode.eByPolygon);
                        fbxLayerElement.SetReferenceMode(FbxLayerElement.EReferenceMode.eIndexToDirect);

                        FbxLayerElementArray fbxElementArray = fbxLayerElement.GetIndexArray();

                        for (int subMeshIndex = 0; subMeshIndex < mesh.subMeshCount; subMeshIndex++)
                        {
                            var topology = mesh.GetTopology(subMeshIndex);
                            int polySize;

                            switch (topology)
                            {
                                case MeshTopology.Triangles:
                                    polySize = 3;
                                    break;
                                case MeshTopology.Quads:
                                    polySize = 4;
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

                            // Specify the material index for each polygon.
                            // Material index should match subMeshIndex.
                            var indices = mesh.GetIndices(subMeshIndex);
                            for (int j = 0, n = indices.Length / polySize; j < n; j++)
                            {
                                fbxElementArray.Add(subMeshIndex);
                            }
                        }
                    }
                    fbxLayer.SetMaterials(fbxLayerElement);
                }
            }

            bool ExportMaterial(Material unityMaterial, FbxScene fbxScene, FbxNode fbxNode)
            {
                if (!unityMaterial)
                {
                    unityMaterial = MeshInfo.DefaultMaterial;
                }

                var unityID = unityMaterial.GetInstanceID();
                FbxSurfaceMaterial mappedMaterial;
                if (MaterialMap.TryGetValue(unityID, out mappedMaterial))
                {
                    fbxNode.AddMaterial(mappedMaterial);
                    return true;
                }

                var unityName = unityMaterial.name;
                var fbxName = exportSettings.mayaCompatibleNaming
                    ? ConvertToMayaCompatibleName(unityName) : unityName;

                fbxName = GetUniqueMaterialName(fbxName);

                if (exportSettings.showDebugInfo)
                {
                    if (unityName != fbxName)
                    {
                        Debug.Log(string.Format("exporting material {0} as {1}", unityName, fbxName));
                    }
                    else
                    {
                        Debug.Log(string.Format("exporting material {0}", unityName));
                    }
                }

                // We'll export either Phong or Lambert. Phong if it calls
                // itself specular, Lambert otherwise.
                var shader = unityMaterial.shader;
                bool specular = shader.name.ToLower().Contains("specular");
                bool hdrp = shader.name.ToLower().Contains("hdrp");

                var fbxMaterial = specular
                    ? FbxSurfacePhong.Create(fbxScene, fbxName)
                    : FbxSurfaceLambert.Create(fbxScene, fbxName);

                // Copy the flat colours over from Unity standard materials to FBX.
                fbxMaterial.Diffuse.Set(GetMaterialColor(unityMaterial, "_Color"));
                fbxMaterial.Emissive.Set(GetMaterialColor(unityMaterial, "_EmissionColor", 0));
                // hdrp materials dont export emission properly, so default to 0
                if (hdrp)
                {
                    fbxMaterial.Emissive.Set(new FbxDouble3(0, 0, 0));
                }
                fbxMaterial.Ambient.Set(new FbxDouble3());

                fbxMaterial.BumpFactor.Set(unityMaterial.HasProperty("_BumpScale") ? unityMaterial.GetFloat("_BumpScale") : 0);

                if (specular)
                {
                    (fbxMaterial as FbxSurfacePhong).Specular.Set(GetMaterialColor(unityMaterial, "_SpecColor"));
                }

                // Export the textures from Unity standard materials to FBX.
                ExportTexture(unityMaterial, "_MainTex", fbxMaterial, FbxSurfaceMaterial.sDiffuse);
                ExportTexture(unityMaterial, "_EmissionMap", fbxMaterial, FbxSurfaceMaterial.sEmissive);
                ExportTexture(unityMaterial, "_BumpMap", fbxMaterial, FbxSurfaceMaterial.sNormalMap);
                if (specular)
                {
                    ExportTexture(unityMaterial, "_SpecGlossMap", fbxMaterial, FbxSurfaceMaterial.sSpecular);
                }

                MaterialMap.Add(unityID, fbxMaterial);
                fbxNode.AddMaterial(fbxMaterial);
                return true;
            }

            //导出Mesh到节点
            bool ExportMeshData(MeshInfo meshInfo, FbxNode fbxNode)
            {
                if (!meshInfo.IsValid)
                {
                    return false;
                }

                NumMeshes++;
                NumTriangles += meshInfo.Triangles.Length / 3;

                // create the mesh structure.
                var fbxScene = fbxNode.GetScene();
                FbxMesh fbxMesh = FbxMesh.Create(fbxScene, "Scene");
                //Debug.LogError($"fbxMeshName：{fbxMesh.GetName()}");

                // Create control points.
                ControlPointToIndex.Clear();
                {
                    var vertices = meshInfo.Vertices;
                    for (int v = 0, n = meshInfo.VertexCount; v < n; v++)
                    {
                        if (ControlPointToIndex.ContainsKey(vertices[v]))
                        {
                            continue;
                        }
                        ControlPointToIndex[vertices[v]] = ControlPointToIndex.Count();
                    }
                    fbxMesh.InitControlPoints(ControlPointToIndex.Count());

                    foreach (var kvp in ControlPointToIndex)
                    {
                        var controlPoint = kvp.Key;
                        var index = kvp.Value;
                        fbxMesh.SetControlPointAt(MeshInfo.ConvertToFbxVector4(controlPoint, UnitScaleFactor), index);
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

                            polyVert = ControlPointToIndex[meshInfo.Vertices[polyVert]];
                            fbxMesh.AddPolygon(polyVert);

                        }
                        fbxMesh.EndPolygon();
                    }
                }

                // Set up materials per submesh.
                foreach (var mat in meshInfo.Materials)
                {
                    ExportMaterial(mat, fbxScene, fbxNode);
                }
                AssignLayerElementMaterial(fbxMesh, meshInfo.mesh, meshInfo.Materials.Length);

                // Set up normals, etc.
                ExportComponentAttributes(meshInfo, fbxMesh, unmergedPolygons.ToArray());

                // Set up blend shapes.
                FbxBlendShape fbxBlendShape = ExportBlendShapes(meshInfo, fbxMesh, fbxScene, unmergedPolygons.ToArray());

                if (fbxBlendShape != null && fbxBlendShape.GetBlendShapeChannelCount() > 0)
                {
                    // Populate mapping for faster lookup when exporting blendshape animations
                    List<FbxBlendShapeChannel> blendshapeChannels;
                    if (!MapUnityObjectToBlendShapes.TryGetValue(fbxNode, out blendshapeChannels))
                    {
                        blendshapeChannels = new List<FbxBlendShapeChannel>();
                        MapUnityObjectToBlendShapes.Add(fbxNode, blendshapeChannels);
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

            bool ExportSkinnedMesh(GameObject unityGo, FbxScene fbxScene, FbxNode fbxNode)
            {
                if (!unityGo || fbxNode == null)
                {
                    return false;
                }

                SkinnedMeshRenderer unitySkin
                = unityGo.GetComponent<SkinnedMeshRenderer>();

                if (unitySkin == null)
                {
                    return false;
                }

                var mesh = unitySkin.sharedMesh;
                if (!mesh)
                {
                    return false;
                }

                if (exportSettings.showDebugInfo)
                    Debug.Log(string.Format("exporting {0} {1}", "Skin", fbxNode.GetName()));


                var meshInfo = new MeshInfo(unitySkin.sharedMesh, unitySkin.sharedMaterials);

                FbxMesh fbxMesh = null;
                if (ExportMeshData(meshInfo, fbxNode))
                {
                    fbxMesh = fbxNode.GetMesh();
                }
                if (fbxMesh == null)
                {
                    Debug.LogError("Could not find mesh");
                    return false;
                }

                Dictionary<SkinnedMeshRenderer, Transform[]> skinnedMeshToBonesMap;
                // export skeleton
                if (ExportSkeleton(unitySkin, fbxScene, out skinnedMeshToBonesMap))
                {
                    // bind mesh to skeleton
                    ExportSkin(unitySkin, meshInfo, fbxScene, fbxMesh, fbxNode);

                    // add bind pose
                    ExportBindPose(unitySkin, fbxNode, fbxScene, skinnedMeshToBonesMap);

                    // now that the skin and bindpose are set, make sure that each of the bones
                    // is set to its original position
                    var bones = unitySkin.bones;
                    foreach (var bone in bones)
                    {
                        // ignore null bones
                        if (bone != null)
                        {
                            var fbxBone = MapUnityObjectToFbxNode[bone.gameObject];
                            ExportTransform(bone, fbxBone, newCenter: Vector3.zero, TransformExportType.Local);

                            // Cancel out the pre-rotation from the exported rotation

                            // Get prerotation
                            var fbxPreRotationEuler = fbxBone.GetPreRotation(FbxNode.EPivotSet.eSourcePivot);
                            // Convert the prerotation to a Quaternion
                            var fbxPreRotationQuaternion = EulerToQuaternionXYZ(fbxPreRotationEuler);
                            // Inverse of the prerotation
                            fbxPreRotationQuaternion.Inverse();

                            // Multiply LclRotation by pre-rotation inverse to get the LclRotation without pre-rotation applied
                            var finalLclRotationQuat = fbxPreRotationQuaternion * EulerToQuaternionZXY(bone.localEulerAngles);

                            // Convert to Euler with Unity axis system and update LclRotation
                            var finalUnityQuat = new Quaternion((float)finalLclRotationQuat.X, (float)finalLclRotationQuat.Y, (float)finalLclRotationQuat.Z, (float)finalLclRotationQuat.W);
                            fbxBone.LclRotation.Set(Vector3ToFbxDouble3(finalUnityQuat.eulerAngles));
                        }
                        else
                        {
                            Debug.Log("Warning: One or more bones are null. Skeleton may not export correctly.");
                        }
                    }
                }

                return true;
            }
            #endregion

            #region 命名
            Dictionary<string, int> NameToIndexMap = new Dictionary<string, int>();
            Dictionary<string, int> MaterialNameToIndexMap = new Dictionary<string, int>();
            Dictionary<string, int> TextureNameToIndexMap = new Dictionary<string, int>();
            string UniqueNameFormat = "{0}_{1}";

            string GetUniqueName(string name, Dictionary<string, int> nameToCountMap)
            {
                var uniqueName = name;
                int count;
                if (nameToCountMap.TryGetValue(name, out count))
                {
                    uniqueName = string.Format(UniqueNameFormat, name, count);
                }
                else
                {
                    count = 0;
                }
                nameToCountMap[name] = count + 1;
                return uniqueName;
            }

            string GetUniqueFbxNodeName(string name)
            {
                return GetUniqueName(name, NameToIndexMap);
            }

            string GetUniqueMaterialName(string name)
            {
                return GetUniqueName(name, MaterialNameToIndexMap);
            }

            string GetUniqueTextureName(string name)
            {
                return GetUniqueName(name, TextureNameToIndexMap);
            }
            #endregion

            #region Hierarchy层级_模型
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
                    if (exportSettings.showDebugInfo)
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
                        if (mat != null && MaterialMap.TryGetValue(mat.GetInstanceID(), out newMaterial))
                        {
                            fbxNode.AddMaterial(newMaterial);
                        }
                        else
                        {
                            // create new material
                            ExportMaterial(mat, fbxScene, fbxNode);
                        }
                    }
                }

                // set the fbxNode containing the mesh
                fbxNode.SetNodeAttribute(fbxMesh);
                fbxNode.SetShadingMode(FbxNode.EShadingMode.eWireFrame);

                return true;
            }

            //创建节点
            FbxNode CreateFbxNode(GameObject unityGo, FbxScene fbxScene)
            {
                string fbxName = unityGo.name;
                if (exportSettings.mayaCompatibleNaming)
                    fbxName = ConvertToMayaCompatibleName(unityGo.name);

                FbxNode fbxNode = FbxNode.Create(fbxScene, GetUniqueFbxNodeName(fbxName));

                // Default inheritance type in FBX is RrSs, which causes scaling issues in Maya as
                // both Maya and Unity use RSrs inheritance by default.
                // Note: MotionBuilder uses RrSs inheritance by default as well, though it is possible
                //       to select a different inheritance type in the UI.
                // Use RSrs as the scaling inheritance instead.
                fbxNode.SetTransformationInheritType(FbxTransform.EInheritType.eInheritRSrs);

                // Fbx rotation order is XYZ, but Unity rotation order is ZXY.
                // Also, DeepConvert does not convert the rotation order (assumes XYZ), unless RotationActive is true.
                fbxNode.SetRotationOrder(FbxNode.EPivotSet.eSourcePivot, FbxEuler.EOrder.eOrderZXY);
                fbxNode.SetRotationActive(true);

                MapUnityObjectToFbxNode[unityGo] = fbxNode;

                return fbxNode;
            }

            //设置节点Transform
            bool ExportTransform(UnityEngine.Transform unityTransform, FbxNode fbxNode, Vector3 newCenter, TransformExportType exportType)
            {
                UnityEngine.Vector3 unityTranslate;
                FbxDouble3 fbxRotate;
                UnityEngine.Vector3 unityScale;

                switch (exportType)
                {
                    case TransformExportType.Global:
                        unityTranslate = unityTransform.position - newCenter;
                        fbxRotate = Vector3ToFbxDouble3(unityTransform.eulerAngles);
                        unityScale = unityTransform.lossyScale;
                        break;
                    default: /*case TransformExportType.Local*/
                        unityTranslate = unityTransform.localPosition;
                        fbxRotate = Vector3ToFbxDouble3(unityTransform.localEulerAngles);
                        unityScale = unityTransform.localScale;
                        break;
                }

                // Transfer transform data from Unity to Fbx
                var fbxTranslate = MeshInfo.ConvertToFbxVector4(unityTranslate, UnitScaleFactor);
                var fbxScale = new FbxDouble3(unityScale.x, unityScale.y, unityScale.z);

                // Zero scale causes issues in 3ds Max (child of object with zero scale will end up with a much larger scale, e.g. >9000).
                // When exporting 0 scale from Maya, the FBX contains 1e-12 instead of 0,
                // which doesn't cause issues in Max. Do the same here.
                if (fbxScale.X == 0)
                {
                    fbxScale.X = 1e-12;
                }
                if (fbxScale.Y == 0)
                {
                    fbxScale.Y = 1e-12;
                }
                if (fbxScale.Z == 0)
                {
                    fbxScale.Z = 1e-12;
                }

                // set the local position of fbxNode
                fbxNode.LclTranslation.Set(new FbxDouble3(fbxTranslate.X, fbxTranslate.Y, fbxTranslate.Z));
                fbxNode.LclRotation.Set(fbxRotate);
                fbxNode.LclScaling.Set(fbxScale);

                return true;
            }

            //循环导出所有节点
            int ExportTransformHierarchy(GameObject root, FbxScene fbxScene, FbxNode fbxNodeParent,
                int exportProgress, int objectCount, Vector3 newCenter, TransformExportType exportType)
            {
                int numObjectsExported = exportProgress;

                FbxNode fbxNode = CreateFbxNode(root, fbxScene);

                if (exportSettings.showDebugInfo)
                    Debug.Log(string.Format("exporting {0}", fbxNode.GetName()));

                numObjectsExported++;
                if (EditorUtility.DisplayCancelableProgressBar(ProgressBarTitle,
                        string.Format("Creating FbxNode {0}/{1}", numObjectsExported, objectCount),
                        (numObjectsExported / (float)objectCount) * 0.25f))
                {
                    // cancel silently
                    return -1;
                }

                ExportTransform(root.transform, fbxNode, newCenter, exportType);

                fbxNodeParent.AddChild(fbxNode);

                // now  unityGo  through our children and recurse
                foreach (Transform childT in root.transform)
                {
                    numObjectsExported = ExportTransformHierarchy(childT.gameObject, fbxScene, fbxNode, numObjectsExported, objectCount, newCenter, TransformExportType.Local);
                }

                return numObjectsExported;
            }

            //判断Mesh导出类型
            bool TryExportMesh(GameObject gameObject, FbxNode fbxNode)
            {
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
                }

                // If we're here, custom handling didn't work.
                // Revert to default handling.

                // if user doesn't want to export mesh colliders, and this gameobject doesn't have a renderer
                // then don't export it.
                if (!exportSettings.exportUnrendered && (!gameObject.GetComponent<Renderer>() || !gameObject.GetComponent<Renderer>().enabled))
                {
                    return false;
                }

                var meshFilter = defaultComponent as MeshFilter;
                if (meshFilter)
                {
                    var renderer = gameObject.GetComponent<Renderer>();
                    var materials = renderer ? renderer.sharedMaterials : null;
                    return ExportMeshData(new MeshInfo(meshFilter.sharedMesh, materials), fbxNode);
                }
                else
                {
                    var smr = defaultComponent as SkinnedMeshRenderer;
                    if (smr)
                    {
                        var result = ExportSkinnedMesh(gameObject, fbxNode.GetScene(), fbxNode);
                        if (!result)
                        {
                            // fall back to exporting as a static mesh
                            var mesh = new Mesh();
                            smr.BakeMesh(mesh);
                            var materials = smr.sharedMaterials;
                            result = ExportMeshData(new MeshInfo(mesh, materials), fbxNode);
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
                int objectCount = MapUnityObjectToFbxNode.Count;
                foreach (KeyValuePair<GameObject, FbxNode> entry in MapUnityObjectToFbxNode)
                {
                    numObjectsExported++;
                    if (EditorUtility.DisplayCancelableProgressBar(
                            ProgressBarTitle,
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
                    if (exportSettings.keepInstances)
                    {
                        exportedMesh = ExportInstance(unityGo, fbxScene, fbxNode);
                    }

                    if (!exportedMesh)
                    {
                        exportedMesh = TryExportMesh(unityGo, fbxNode);
                    }

                    ExportConstraints(unityGo, fbxScene, fbxNode);
                }
                return true;
            }

            #endregion

            #region Hierarchy层级_仅动画
            bool ExportAnimatedBones(GameObject unityGo, FbxScene fbxScene, ref int exportProgress, int objectCount, AnimationOnlyExportData exportData)
            {
                var skinnedMeshRenderers = unityGo.GetComponentsInChildren<SkinnedMeshRenderer>();
                foreach (var skinnedMesh in skinnedMeshRenderers)
                {
                    var boneArray = skinnedMesh.bones;
                    var bones = new HashSet<GameObject>();
                    var boneDict = new Dictionary<Transform, int>();

                    for (int i = 0; i < boneArray.Length; i++)
                    {
                        bones.Add(boneArray[i].gameObject);
                        boneDict.Add(boneArray[i], i);
                    }

                    // get the bones that are also in the export set
                    bones.IntersectWith(exportData.Objects);

                    var boneInfo = new SkinnedMeshBoneInfo(skinnedMesh, boneDict);
                    foreach (var bone in bones)
                    {
                        FbxNode fbxNode;
                        // bone already exported
                        if (MapUnityObjectToFbxNode.TryGetValue(bone, out fbxNode))
                        {
                            continue;
                        }
                        fbxNode = CreateFbxNode(bone, fbxScene);

                        exportProgress++;
                        if (EditorUtility.DisplayCancelableProgressBar(
                                ProgressBarTitle,
                            string.Format("Creating FbxNode {0}/{1}", exportProgress, objectCount),
                            (exportProgress / (float)objectCount) * 0.5f))
                        {
                            // cancel silently
                            return false;
                        }
                        ExportBoneTransform(fbxNode, fbxScene, bone.transform, boneInfo);
                    }
                }
                return true;
            }

            /// <summary>
            /// Exports the Gameobject and its ancestors.
            /// </summary>
            /// <returns><c>true</c>, if game object and parents were exported,
            ///  <c>false</c> if export cancelled.</returns>
            bool ExportGameObjectAndParents(GameObject unityGo, GameObject rootObject, FbxScene fbxScene,
              out FbxNode fbxNode, Vector3 newCenter, TransformExportType exportType, ref int exportProgress, int objectCount)
            {
                // node doesn't exist so create it
                if (!MapUnityObjectToFbxNode.TryGetValue(unityGo, out fbxNode))
                {
                    fbxNode = CreateFbxNode(unityGo, fbxScene);

                    exportProgress++;
                    if (EditorUtility.DisplayCancelableProgressBar(
                            ProgressBarTitle,
                        string.Format("Creating FbxNode {0}/{1}", exportProgress, objectCount),
                        (exportProgress / (float)objectCount) * 0.5f))
                    {
                        // cancel silently
                        return false;
                    }

                    ExportTransform(unityGo.transform, fbxNode, newCenter, exportType);
                }

                if (unityGo == rootObject || unityGo.transform.parent == null)
                {
                    fbxScene.GetRootNode().AddChild(fbxNode);
                    return true;
                }

                // make sure all the nodes are connected and exported
                FbxNode fbxNodeParent;
                if (!ExportGameObjectAndParents(
                    unityGo.transform.parent.gameObject,
                    rootObject,
                    fbxScene,
                    out fbxNodeParent,
                    newCenter,
                    TransformExportType.Local,
                    ref exportProgress,
                    objectCount
                ))
                {
                    // export cancelled
                    return false;
                }
                fbxNodeParent.AddChild(fbxNode);

                return true;
            }

            bool ExportConstraints(GameObject unityGo, FbxScene fbxScene, FbxNode fbxNode)
            {
                if (!unityGo)
                {
                    return false;
                }

                var mapConstraintTypeToExportFunction = new Dictionary<System.Type, ExportConstraintDelegate>()
                {
                    { typeof(PositionConstraint), ExportPositionConstraint },
                    { typeof(RotationConstraint), ExportRotationConstraint },
                    { typeof(ScaleConstraint), ExportScaleConstraint },
                    { typeof(AimConstraint), ExportAimConstraint },
                    { typeof(ParentConstraint), ExportParentConstraint }
                };

                // check if GameObject has one of the 5 supported constraints: aim, parent, position, rotation, scale
                var uniConstraints = unityGo.GetComponents<IConstraint>();

                foreach (var uniConstraint in uniConstraints)
                {
                    var uniConstraintType = uniConstraint.GetType();
                    ExportConstraintDelegate constraintDelegate;
                    if (!mapConstraintTypeToExportFunction.TryGetValue(uniConstraintType, out constraintDelegate))
                    {
                        Debug.LogWarningFormat("FbxExporter: Missing function to export constraint of type {0}", uniConstraintType.Name);
                        continue;
                    }
                    constraintDelegate(uniConstraint, fbxScene, fbxNode);
                }

                return true;
            }

            int ExportAnimationOnly(GameObject unityGO, FbxScene fbxScene, int exportProgress,
                    int objectCount, Vector3 newCenter, IExportData data, TransformExportType exportType = TransformExportType.Local)
            {
                AnimationOnlyExportData exportData = (AnimationOnlyExportData)data;
                int numObjectsExported = exportProgress;

                // make sure anim destination node is exported as well
                var exportSet = exportData.Objects;
                if (exportSettings.animationDest && exportSettings.animationSource)
                {
                    exportSet.Add(exportSettings.animationDest.gameObject);
                }

                // first export all the animated bones that are in the export set
                // as only a subset of bones are exported, but we still need to make sure the bone transforms are correct
                if (!ExportAnimatedBones(unityGO, fbxScene, ref numObjectsExported, objectCount, exportData))
                {
                    // export cancelled
                    return -1;
                }

                // export everything else and make sure all nodes are connected
                foreach (var go in exportSet)
                {
                    FbxNode node;
                    if (!ExportGameObjectAndParents(
                        go, unityGO, fbxScene, out node, newCenter, exportType, ref numObjectsExported, objectCount
                        ))
                    {
                        // export cancelled
                        return -1;
                    }

                    ExportConstraints(go, fbxScene, node);

                    System.Type compType;
                    if (exportData.exportComponent.TryGetValue(go, out compType))
                    {
                        if (compType == typeof(SkinnedMeshRenderer))
                        {
                            // export only what is necessary for exporting blendshape animation
                            var unitySkin = go.GetComponent<SkinnedMeshRenderer>();
                            var meshInfo = new MeshInfo(unitySkin.sharedMesh, unitySkin.sharedMaterials);
                            ExportMeshData(meshInfo, node);
                        }
                    }
                }

                return numObjectsExported;
            }
            #endregion

            {

                bool ExportProgressCallback(float percentage, string status)
                {
                    // Convert from percentage to [0,1].
                    // Then convert from that to [0.5,1] because the first half of
                    // the progress bar was for creating the scene.
                    var progress01 = 0.5f * (1f + (percentage / 100.0f));

                    bool cancel = EditorUtility.DisplayCancelableProgressBar("CustomFbxExporter", "Exporting Scene...", progress01);

                    if (cancel)
                    {
                        exportCancelled = true;
                    }

                    // Unity says "true" for "cancel"; FBX wants "true" for "continue"
                    return !cancel;
                }

                void ExportAll(GameObject root, IExportData exportData)
                {
                    exportCancelled = false;
                    bool animOnly = exportData != null && exportSettings.modelAnimIncludeOption == Include.Anim;
                    bool status = false;

                    {
                        // Create the FBX manager
                        var fbxManager = FbxManager.Create();

                        // Configure fbx IO settings.
                        {
                            var settings = FbxIOSettings.Create(fbxManager, Globals.IOSROOT);
                            //if (exportSettings.embedTextures)
                            //    settings.SetBoolProp(Globals.EXP_FBX_EMBEDDED, true);
                            fbxManager.SetIOSettings(settings);
                        }

                        // Create the exporter
                        var fbxExporter = FbxExporter.Create(fbxManager, "Exporter");

                        // Initialize the exporter.
                        {
                            //如果打包贴图的话必须使用二进制输出方式
                            int fileFormat = -1;
                            if (exportSettings.exportFormat == ExportFormat.ASCII)
                                fileFormat = fbxManager.GetIOPluginRegistry().FindWriterIDByDescription("FBX ascii (*.fbx)");
                            bool success = fbxExporter.Initialize(tempFilePath, fileFormat, fbxManager.GetIOSettings());
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
                            fbxSceneInfo.mTitle = Title;
                            fbxSceneInfo.mSubject = Subject;
                            fbxSceneInfo.mAuthor = "Unity Technologies";
                            fbxSceneInfo.mRevision = "1.0";
                            fbxSceneInfo.mKeywords = Keywords;
                            fbxSceneInfo.mComment = Comments;
                            fbxSceneInfo.Original_ApplicationName.Set(PACKAGE_NAME);
                            // set last saved to be the same as original, as this is a new file.
                            fbxSceneInfo.LastSaved_ApplicationName.Set(PACKAGE_NAME);
                            fbxSceneInfo.Original_ApplicationVersion.Set(PACKAGE_VERSION);
                            fbxSceneInfo.LastSaved_ApplicationVersion.Set(PACKAGE_VERSION);
                            fbxScene.SetSceneInfo(fbxSceneInfo);
                        }

                        //设置单位和轴向 单位厘米+放大100倍
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
                        TransformExportType transformExportType = TransformExportType.Global;

                        switch (exportSettings.objectSpace)
                        {
                            case TransformExportType.Local:
                                // one object to export -> move to (0,0,0)
                                center = root.transform.position;
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
                                exportProgress = ExportTransformHierarchy(root, fbxScene, fbxRootNode, exportProgress, count, center, transformExportType);
                            }
                            if (exportCancelled || exportProgress < 0)
                            {
                                Debug.LogWarning("Export Cancelled");
                                return;
                            }
                        }

                        //导出Mesh
                        if (!animOnly)
                        {
                            if (!ExportComponents(fbxScene))
                            {
                                Debug.LogWarning("Export Cancelled");
                                return;
                            }
                        }

                        //导出动画
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
                                        ExportAnimationClip(defaultClip, data.animationClips[defaultClip], fbxScene);
                                        data.animationClips.Remove(defaultClip);
                                    }

                                    foreach (var animClip in data.animationClips)
                                    {
                                        ExportAnimationClip(animClip.Key, animClip.Value, fbxScene);
                                    }
                                }

                            }
                        }

                        // Set the scene's default camera.
                        SetDefaultCamera(fbxScene);

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

                    if (exportCancelled)
                    {
                        Debug.LogWarning("Export Cancelled");
                        return;
                    }

                    //保持导入设置：缓存原始文件meta
                    string originalMetafilePath = "";
                    if (exportSettings.preserveImportSettings && File.Exists(filePath))
                    {
                        originalMetafilePath = SaveMetafile();
                    }

                    //删除目标路径的文件和meta 移动临时文件到目标路径
                    ReplaceFile();

                    //保持导入设置：使用原始文件的导入设置
                    if (exportSettings.preserveImportSettings && !string.IsNullOrEmpty(originalMetafilePath))
                        ReplaceMetafile(originalMetafilePath);

                    //删除临时文件
                    DeleteTempFile();

                    AssetDatabase.Refresh();
                    EditorUtility.ClearProgressBar();
                }

                Debug.Log($"当前的动画导出设置：{exportSettings.modelAnimIncludeOption}");
                //Debug.Log($"KeepInstances设置：{exportOptions.KeepInstances}");
                Debug.Log($"Format设置：{exportSettings.exportFormat}");
                Debug.Log($"是否维持meta设置：{exportSettings.preserveImportSettings}");

                AnimationOnlyExportData animData = GetExportData(fbxGameObject, exportSettings);
                ExportAll(fbxGameObject, animData);
            }
        }


        [MenuItem("Assets/TA工具/修改FBX", false, 27)]
        static void OneKeyCustomFbxExporter()
        {
            string exportSettingsFilePath = AssetDatabase.GUIDToAssetPath("090a6f976a2e635458d6165401c100bc");
            var exportSettings = AssetDatabase.LoadAssetAtPath<ExportSettings>(exportSettingsFilePath);

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


                ExportOneFbx(fbxGameObject, filePath, exportSettings);
            }
            AssetDatabase.Refresh();
            Debug.LogError("结束...  处理次数：" + count);

        }

        [MenuItem("Window/TA工具/复制场景")]
        static void CopyScene()
        {
            //https://github.com/guycalledfrank/lighting-data-asset-reverse
            //GI信息的format不能读
            //可以将GI保存在空场景里面然后加载副场景
            //https://docs.unity3d.com/ScriptReference/LightProbes.Tetrahedralize.html
            //加载场景后强制刷新LightProbes的

            string sceneTargetPath = "Assets/Bundles/Scenes/testGI/testEmptyGI.unity";
            EditorSceneManager.MarkAllScenesDirty();
            EditorSceneManager.SaveOpenScenes();
            EditorSceneManager.SaveScene(EditorSceneManager.GetActiveScene(), sceneTargetPath, true);
            var Scene = EditorSceneManager.OpenScene(sceneTargetPath);

            //复制场景后新场景的Lightmapping.lightingDataAsset和旧场景共用 导致参与引用 
            LightingDataAsset asset = GameObject.Instantiate(Lightmapping.lightingDataAsset);
            SerializedObject obj = new SerializedObject(asset);
            SerializedProperty property = obj.FindProperty("m_Scene");
            SceneAsset assetscene = AssetDatabase.LoadAssetAtPath<SceneAsset>(Scene.path); //替换新场景
            property.objectReferenceValue = assetscene;
            obj.ApplyModifiedProperties();
            string lightDataPath = AssetDatabase.GetAssetPath(Lightmapping.lightingDataAsset);
            AssetDatabase.CreateAsset(asset, lightDataPath);


            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();
        }

        public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] properties)
        {
            materialEditor.PropertiesDefaultGUI(properties);
        }
    }
}
