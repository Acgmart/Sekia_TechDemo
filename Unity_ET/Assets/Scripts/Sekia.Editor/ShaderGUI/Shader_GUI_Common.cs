using System.Collections.Generic;
using System.IO;
using UnityEngine;

namespace UnityEditor
{
    public class Shader_GUI_Common : ShaderGUI
    {
        //全局状态
        public static bool _ShowMateialTool = false; //默认显示材质工具
        public static bool _UseOriginalInspector = false;
        public static Material _CurrentTarget;

        //合并贴图通道用属性
        public static bool _ShowMateralTool_CombineCustomMap = false;
        public static Texture texture1;
        public static Texture texture2;
        public static Texture texture3;
        public static int texture1ChannelIndex;
        public static int texture2ChannelIndex;
        public static int texture3ChannelIndex;
        public static float RChannelDefaultValue;
        public static float GChannelDefaultValue;
        public static float BChannelDefaultValue;
        public static string _textureTargetFolder;
        public static string _textureTargetName;

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

        #region 公共代码 文件收集-读写-关键字设置
        //对选中项 获取选中的所有非meta文件
        public static List<string> GetAllSelectedFilesWithNoMeta()
        {
            List<string> allSelectedFiles = new List<string>();
            List<string> allSelectedDirs = new List<string>();
            foreach (var obj in Selection.objects)
            {
                string objPath = AssetDatabase.GetAssetPath(obj);
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
        #endregion

        #region MenuItem工具
        static void CleanMaterialProperty(Material material, ref int count)
        {
            List<string> collectedKeywords = new List<string>();

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
            SerializedProperty shaderKeywords = psSource.FindProperty("m_InvalidKeywords");
            CleanTextureProperty(texEnvs, material);
            CleanFloatProperty(floats, material);
            CleanColorProperty(colors, material);

            int invalidKeywordsCount = shaderKeywords.arraySize;
            for (int i = invalidKeywordsCount - 1; i > -1; --i)
                shaderKeywords.DeleteArrayElementAtIndex(i);

            psSource.ApplyModifiedProperties();
            EditorUtility.SetDirty(material);
            count += 1;
        }

        [MenuItem("Assets/TA工具/1 删除材质球上的无用属性", false, 27)]
        static void OneKeyClearMaterialProperty()
        {
            Debug.LogError("开始...");
            List<string> allSelectedFiles = GetAllSelectedFilesWithNoMeta();
            int count = 0;
            foreach (var file in allSelectedFiles)
            {
                Material material = AssetDatabase.LoadAssetAtPath(file, typeof(Material)) as Material;
                CleanMaterialProperty(material, ref count);
            }
            AssetDatabase.SaveAssets();
            Debug.LogError("结束...  处理次数：" + count);
        }
        #endregion

        public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] properties)
        {
            materialEditor.PropertiesDefaultGUI(properties);
        }
    }
}
