using UnityEngine;
using System.Collections;

namespace UnityEditor
{
    public class GUI_VectorTwo : MaterialPropertyDrawer
    {
        //使用：
        //[GUI_VectorTwo] _SplatTiling("Detail Tiling (UV)", Vector) = (1,1,0,0)

        public override void OnGUI(Rect position, MaterialProperty prop, string label, MaterialEditor editor)
        {
            var preLabelWidth = EditorGUIUtility.labelWidth;
            EditorGUIUtility.labelWidth = 0;

            Vector4 vec4value = prop.vectorValue;

            GUILayout.Space(-18);
            EditorGUI.BeginChangeCheck();
            EditorGUILayout.BeginVertical();
            EditorGUILayout.BeginHorizontal();
            EditorGUILayout.PrefixLabel(label);
            GUILayout.Space(-1);
            vec4value = EditorGUILayout.Vector2Field("", vec4value);
            EditorGUILayout.EndHorizontal();
            EditorGUILayout.EndVertical();
            // GUILayout.Space(2);
            if (EditorGUI.EndChangeCheck())
            {
                prop.vectorValue = vec4value;
            }
            EditorGUIUtility.labelWidth = preLabelWidth;
        }
    }

    public class GUI_NormalizedDir : MaterialPropertyDrawer
    {
        //使用：
        //[GUI_NormalizedDir]_FakeLightDir("假光源", Vector) = (-0.81603, 0.08716, 0.57139, 0)

        public override void OnGUI(Rect position, MaterialProperty prop, string label, MaterialEditor editor)
        {
            GUILayout.Space(-18);
            Shader_GUI_Common.ShowNormalizeVector(editor, prop.name, label);
        }
    }

    public class GUI_BlendMode_RGB_SRC : MaterialPropertyDrawer
    {
        public static Material targetMaterial;
        public static MaterialProperty srcProp;

        //使用：
        //[GUI_BlendMode_RGB_SRC] _SRCBLEND("SrcBlend模式", Int) = 5

        public override void OnGUI(Rect position, MaterialProperty prop, string label, MaterialEditor editor)
        {
            if (prop.type != MaterialProperty.PropType.Float)
            {
                Debug.LogError("材质属性的类型需要为浮点类型：" + prop.name);
                return;
            }

            GUILayout.Space(-20);
            targetMaterial = editor.target as Material;
            srcProp = prop;
        }
    }

    public class GUI_BlendMode_RGB_DST : MaterialPropertyDrawer
    {
        //使用：
        //[GUI_BlendMode_RGB_DST] _SRCBLEND("SrcBlend模式", Int) = 5

        enum BlendType //常用的混合类型
        {
            NoBlend,
            AlphaBlend,
            Additive_One_One,
            Additive_SrcAlpha_One
        }

        public override void OnGUI(Rect position, MaterialProperty prop, string label, MaterialEditor editor)
        {
            if (prop.type != MaterialProperty.PropType.Float)
            {
                Debug.LogError("材质属性的类型需要为浮点类型：" + prop.name);
                return;
            }

            GUILayout.Space(-20);
            if (GUI_BlendMode_RGB_SRC.targetMaterial == editor.target as Material)
            {
                float srcValue = GUI_BlendMode_RGB_SRC.srcProp.floatValue;
                float dstValue = prop.floatValue;
                UnityEngine.Rendering.BlendMode blendModeSRC = (UnityEngine.Rendering.BlendMode)srcValue;
                UnityEngine.Rendering.BlendMode blendModeDST = (UnityEngine.Rendering.BlendMode)dstValue;
                bool isOneOfAnyBlendType = false;
                BlendType blendType = BlendType.NoBlend;
                if (blendModeSRC == UnityEngine.Rendering.BlendMode.One &&
                   blendModeDST == UnityEngine.Rendering.BlendMode.Zero)
                {
                    blendType = BlendType.NoBlend;
                    isOneOfAnyBlendType = true;
                }
                else if (blendModeSRC == UnityEngine.Rendering.BlendMode.SrcAlpha &&
                   blendModeDST == UnityEngine.Rendering.BlendMode.OneMinusSrcAlpha)
                {
                    blendType = BlendType.AlphaBlend;
                    isOneOfAnyBlendType = true;
                }
                else if (blendModeSRC == UnityEngine.Rendering.BlendMode.One &&
                   blendModeDST == UnityEngine.Rendering.BlendMode.One)
                {
                    blendType = BlendType.Additive_One_One;
                    isOneOfAnyBlendType = true;
                }
                else if (blendModeSRC == UnityEngine.Rendering.BlendMode.SrcAlpha &&
                   blendModeDST == UnityEngine.Rendering.BlendMode.One)
                {
                    blendType = BlendType.Additive_SrcAlpha_One;
                    isOneOfAnyBlendType = true;
                }

                if (isOneOfAnyBlendType)
                {
                    EditorGUI.BeginChangeCheck();
                    BlendType newBlendType = (BlendType)EditorGUILayout.EnumPopup("透明混合模式：", blendType);
                    EditorGUILayout.BeginHorizontal();
                    EditorGUI.indentLevel++;
                    if (blendType == BlendType.NoBlend)
                        EditorGUILayout.PrefixLabel("NoBlend：One Zero");
                    else if (blendType == BlendType.AlphaBlend)
                        EditorGUILayout.PrefixLabel("AlphaBlend：SrcAlpha OneMinusSrcAlpha");
                    else if (blendType == BlendType.Additive_One_One)
                        EditorGUILayout.PrefixLabel("Additive_One_One：One One");
                    else if (blendType == BlendType.Additive_SrcAlpha_One)
                        EditorGUILayout.PrefixLabel("Additive_SrcAlpha_One：SrcAlpha One");
                    EditorGUI.indentLevel--;
                    EditorGUILayout.EndHorizontal();
                    if (EditorGUI.EndChangeCheck())
                        editor.RegisterPropertyChangeUndo("Change Value"); //注册恢复点
                    if (newBlendType != blendType)
                    {
                        if (newBlendType == BlendType.NoBlend)
                        {
                            GUI_BlendMode_RGB_SRC.srcProp.floatValue = (float)UnityEngine.Rendering.BlendMode.One;
                            prop.floatValue = (float)UnityEngine.Rendering.BlendMode.Zero;
                        }
                        else if (newBlendType == BlendType.AlphaBlend)
                        {
                            GUI_BlendMode_RGB_SRC.srcProp.floatValue = (float)UnityEngine.Rendering.BlendMode.SrcAlpha;
                            prop.floatValue = (float)UnityEngine.Rendering.BlendMode.OneMinusSrcAlpha;
                        }
                        else if (newBlendType == BlendType.Additive_One_One)
                        {
                            GUI_BlendMode_RGB_SRC.srcProp.floatValue = (float)UnityEngine.Rendering.BlendMode.One;
                            prop.floatValue = (float)UnityEngine.Rendering.BlendMode.One;
                        }
                        else if (newBlendType == BlendType.Additive_SrcAlpha_One)
                        {
                            GUI_BlendMode_RGB_SRC.srcProp.floatValue = (float)UnityEngine.Rendering.BlendMode.SrcAlpha;
                            prop.floatValue = (float)UnityEngine.Rendering.BlendMode.One;
                        }
                    }
                }
                else
                {
                    editor.FloatProperty(GUI_BlendMode_RGB_SRC.srcProp,
                        GUI_BlendMode_RGB_SRC.srcProp.displayName);
                    editor.FloatProperty(prop, prop.displayName);
                }
            }
            //GUILayout.Space(-20);
        }
    }

    public class GUI_GlobalKeyword : MaterialPropertyDrawer
    {
        //使用：会根据属性名生成对应大写的关键字
        //[GUI_GlobalKeyword]_Test("测试", Int) = 0

        public override void OnGUI(Rect position, MaterialProperty prop, string label, MaterialEditor editor)
        {
            GUILayout.Space(-18);

            string keywordName = prop.name.ToUpper();
            bool isEffectOn = Shader.IsKeywordEnabled(keywordName);
            bool result = GUILayout.Toggle(isEffectOn,
                new GUIContent(prop.displayName, $"可激活或取消全局关键字{keywordName}"));
            if (result != isEffectOn)
            {
                if (result)
                    Shader.EnableKeyword(keywordName);
                else
                    Shader.DisableKeyword(keywordName);
            }
        }
    }
}
