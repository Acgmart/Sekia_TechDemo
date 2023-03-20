using System;
using UnityEngine;

namespace UnityEditor
{
    public class CustomShaderGUI_Toon : ShaderGUI
    {
        static bool _UseOriginalInspector = false;

        public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] props)
        {
            #region 总览
            Material material = materialEditor.target as Material;
            GUIStyle style = new GUIStyle(GUI.skin.button);
            style.normal.textColor = Color.red;
            style.fontStyle = FontStyle.Bold;

            if (_UseOriginalInspector)
            {
                if (GUILayout.Button("Change To Custom UI"))
                {
                    _UseOriginalInspector = false;
                }
                materialEditor.PropertiesDefaultGUI(props);
                return;
            }
            if (GUILayout.Button("Show All properties"))
            {
                _UseOriginalInspector = true;
            }
            EditorGUILayout.Space();

            EditorGUILayout.LabelField("OverView", EditorStyles.boldLabel);
            EditorGUILayout.BeginVertical(GUI.skin.box);
            {
                //_NORMALMAP
                if (material.HasProperty("_NORMALMAP"))
                {
                    EditorGUILayout.BeginHorizontal();
                    EditorGUILayout.PrefixLabel("NormalMap");
                    if (material.GetInt("_NORMALMAP") == 0)
                    {
                        if (GUILayout.Button("Off"))
                        {
                            material.SetInt("_NORMALMAP", 1);
                            material.EnableKeyword("_NORMALMAP_ON");
                            material.DisableKeyword("_NORMALMAP_OFF");
                        }
                    }
                    else if (material.GetInt("_NORMALMAP") == 1)
                    {
                        if (GUILayout.Button("On", style))
                        {
                            material.SetInt("_NORMALMAP", 0);
                            material.EnableKeyword("_NORMALMAP_OFF");
                            material.DisableKeyword("_NORMALMAP_ON");
                        }
                    }
                    EditorGUILayout.EndHorizontal();
                }

                //_DIFFUSE
                if (material.HasProperty("_DIFFUSE"))
                {
                    EditorGUILayout.BeginHorizontal();
                    EditorGUILayout.PrefixLabel("DiffuseMode");
                    if (material.GetInt("_DIFFUSE") == 0)
                    {
                        if (GUILayout.Button("Cell", style))
                        {
                            material.SetInt("_DIFFUSE", 1);
                            material.EnableKeyword("_DIFFUSE_RAMP");
                            material.DisableKeyword("_DIFFUSE_CELL");
                        }
                    }
                    else if (material.GetInt("_DIFFUSE") == 1)
                    {
                        if (GUILayout.Button("Ramp", style))
                        {
                            material.SetInt("_DIFFUSE", 0);
                            material.EnableKeyword("_DIFFUSE_CELL");
                            material.DisableKeyword("_DIFFUSE_RAMP");
                        }
                    }
                    EditorGUILayout.EndHorizontal();
                }

                //_SPECULAR
                if (material.HasProperty("_SPECULAR"))
                {
                    EditorGUILayout.BeginHorizontal();
                    EditorGUILayout.PrefixLabel("SpecularMode");
                    if (material.GetInt("_SPECULAR") == 0)
                    {
                        if (GUILayout.Button("Off"))
                        {
                            material.SetInt("_SPECULAR", 1);
                            material.EnableKeyword("_SPECULAR_STEP");
                            material.DisableKeyword("_SPECULAR_OFF");
                            material.DisableKeyword("_SPECULAR_ANISOTROPIC");
                        }
                    }
                    else if (material.GetInt("_SPECULAR") == 1)
                    {
                        if (GUILayout.Button("Step", style))
                        {
                            material.SetInt("_SPECULAR", 2);
                            material.EnableKeyword("_SPECULAR_ANISOTROPIC");
                            material.DisableKeyword("_SPECULAR_OFF");
                            material.DisableKeyword("_SPECULAR_STEP");
                        }
                    }
                    else if (material.GetInt("_SPECULAR") == 2)
                    {
                        if (GUILayout.Button("Anisotropic", style))
                        {
                            material.SetInt("_SPECULAR", 0);
                            material.EnableKeyword("_SPECULAR_OFF");
                            material.DisableKeyword("_SPECULAR_STEP");
                            material.DisableKeyword("_SPECULAR_ANISOTROPIC");
                        }
                    }
                    EditorGUILayout.EndHorizontal();
                }

                //_OVERLAY
                if (material.HasProperty("_OVERLAY"))
                {
                    EditorGUILayout.BeginHorizontal();
                    EditorGUILayout.PrefixLabel("OverlayMode");
                    if (material.GetInt("_OVERLAY") == 0)
                    {
                        if (GUILayout.Button("Off"))
                        {
                            material.SetInt("_OVERLAY", 1);
                            material.EnableKeyword("_OVERLAY_ON");
                            material.DisableKeyword("_OVERLAY_OFF");
                        }
                    }
                    else if (material.GetInt("_OVERLAY") == 1)
                    {
                        if (GUILayout.Button("On", style))
                        {
                            material.SetInt("_OVERLAY", 0);
                            material.EnableKeyword("_OVERLAY_OFF");
                            material.DisableKeyword("_OVERLAY_ON");
                        }
                    }
                    EditorGUILayout.EndHorizontal();
                }

                //_RIM
                if (material.HasProperty("_RIM"))
                {
                    EditorGUILayout.BeginHorizontal();
                    EditorGUILayout.PrefixLabel("RimMode");
                    if (material.GetInt("_RIM") == 0)
                    {
                        if (GUILayout.Button("Off"))
                        {
                            material.SetInt("_RIM", 1);
                            material.EnableKeyword("_RIM_ON");
                            material.DisableKeyword("_RIM_OFF");
                        }
                    }
                    else if (material.GetInt("_RIM") == 1)
                    {
                        if (GUILayout.Button("On", style))
                        {
                            material.SetInt("_RIM", 0);
                            material.EnableKeyword("_RIM_OFF");
                            material.DisableKeyword("_RIM_ON");
                        }
                    }
                    EditorGUILayout.EndHorizontal();
                }

                //_Outline
                if (material.HasProperty("_OutlineWidth"))
                {
                    EditorGUILayout.BeginHorizontal();
                    EditorGUILayout.PrefixLabel("OutlineMode");
                    if (material.GetShaderPassEnabled("SRPDefaultUnlit"))
                    {
                        if (GUILayout.Button("On", style))
                        {
                            material.SetShaderPassEnabled("SRPDefaultUnlit", false);
                        }
                    }
                    else
                    {
                        if (GUILayout.Button("Off"))
                        {
                            material.SetShaderPassEnabled("SRPDefaultUnlit", true);
                        }
                    }
                    EditorGUILayout.EndHorizontal();
                }
            }
            EditorGUILayout.EndVertical();
            EditorGUILayout.Space();
            #endregion

            #region 光照
            //_NORMALMAP
            if (material.HasProperty("_NORMALMAP"))
            {
                if (material.GetInt("_NORMALMAP") == 1)
                {
                    EditorGUILayout.LabelField("NormalMap", EditorStyles.boldLabel);
                    EditorGUILayout.BeginVertical(GUI.skin.box);
                    {
                        materialEditor.TexturePropertySingleLine(new GUIContent("NormalMap", "从高模烘焙出来的法线贴图\n需要在导入设置中标记为Normal map"), FindProperty("_NormalMap", props));
                    }
                    EditorGUILayout.EndVertical();
                    EditorGUILayout.Space();
                }
            }

            //_DIFFUSE
            if (material.HasProperty("_DIFFUSE"))
            {
                if (material.GetInt("_DIFFUSE") == 0)
                {
                    EditorGUILayout.LabelField("Diffuse-Cell", EditorStyles.boldLabel);
                    EditorGUILayout.BeginVertical(GUI.skin.box);
                    {
                        materialEditor.TexturePropertySingleLine(new GUIContent("MainTex", "物体在明亮处的漫反射表现 默认白色\nRGB通道参与光照计算\nA通道作为最终透明度\n颜色1为明亮区域RGBA修正\n颜色2为阴影区域RGB衰减"),
                            FindProperty("_MainTex", props), FindProperty("_MainColor", props), FindProperty("_ShadowColor", props));
                        materialEditor.ShaderProperty(FindProperty("_ShadowStep", props), new GUIContent("ShadowStep", "设置明亮区域-阴影区域的分界线\n0表示NdotL等于0处"));
                        materialEditor.ShaderProperty(FindProperty("_Feather", props), new GUIContent("ShadowFeather", "设置明亮区域-阴影区域的渐变范围\n0表示完全没有渐变"));
                    }
                    EditorGUILayout.EndVertical();
                    EditorGUILayout.Space();
                }
                else if (material.GetInt("_DIFFUSE") == 1)
                {
                    EditorGUILayout.LabelField("Diffuse-Ramp", EditorStyles.boldLabel);
                    EditorGUILayout.BeginVertical(GUI.skin.box);
                    {
                        materialEditor.ColorProperty(FindProperty("_MainColor", props), "MainColor");
                        materialEditor.ColorProperty(FindProperty("_RampColor2", props), "LightBack");
                        materialEditor.ColorProperty(FindProperty("_RampColor3", props), "ViewFront");
                        materialEditor.ColorProperty(FindProperty("_RampColor4", props), "ViewBack");
                    }
                    EditorGUILayout.EndVertical();
                    EditorGUILayout.Space();
                }
            }

            //_SPECULAR
            if (material.HasProperty("_SPECULAR"))
            {
                if (material.GetInt("_SPECULAR") == 1)
                {
                    EditorGUILayout.LabelField("Specular-Step", EditorStyles.boldLabel);
                    EditorGUILayout.BeginVertical(GUI.skin.box);
                    {
                        materialEditor.ShaderProperty(FindProperty("_SpecularStep", props), new GUIContent("SpecularStep", "高光区域范围\n0表示高光区域小至无"));
                        materialEditor.ShaderProperty(FindProperty("_SpecularColor", props), new GUIContent("SpecularColor", "高光区域用于加算的RGB系数"));
                    }
                    EditorGUILayout.EndVertical();
                    EditorGUILayout.Space();
                }
                else if (material.GetInt("_SPECULAR") == 2)
                {
                    EditorGUILayout.LabelField("Specular-Anisotropic", EditorStyles.boldLabel);
                    EditorGUILayout.BeginVertical(GUI.skin.box);
                    {
                        materialEditor.ShaderProperty(FindProperty("_SpecularStep", props), new GUIContent("SpecularStep", "高光区域范围\n0表示高光区域小至无"));
                        materialEditor.ShaderProperty(FindProperty("_SpecularColor", props), new GUIContent("SpecularColor", "高光区域用于加算的RGB系数"));
                        materialEditor.TexturePropertySingleLine(new GUIContent("BiTangentShift", "逐像素偏移副法线方向"), FindProperty("_BiTangentShiftMap", props));
                        materialEditor.ShaderProperty(FindProperty("_AnisotropicOffset", props), new GUIContent("AnisotropicOffset", "整体调整副法线的偏移量"));
                    }
                    EditorGUILayout.EndVertical();
                    EditorGUILayout.Space();
                }
            }

            //_OVERLAY
            if (material.HasProperty("_OVERLAY"))
            {
                if (material.GetInt("_OVERLAY") == 1)
                {
                    EditorGUILayout.LabelField("Overlay", EditorStyles.boldLabel);
                    EditorGUILayout.BeginVertical(GUI.skin.box);
                    {
                        materialEditor.TexturePropertySingleLine(new GUIContent("OverlayMap", "Overlay效果额外提高表面亮度\n根据观察空间法线方向映射采样"),
                            FindProperty("_OverlayMap", props), FindProperty("_OverlayColor", props));
                        materialEditor.ShaderProperty(FindProperty("_OverlayRotation", props), new GUIContent("Rotation", "旋转Overlay效果\n0表示保持OverlayMap原样\n0.5表示逆时针旋转90度"));
                    }
                    EditorGUILayout.EndVertical();
                    EditorGUILayout.Space();
                }
            }

            //_RIM
            if (material.HasProperty("_RIM"))
            {
                if (material.GetInt("_RIM") == 1)
                {
                    EditorGUILayout.LabelField("Rim", EditorStyles.boldLabel);
                    EditorGUILayout.BeginVertical(GUI.skin.box);
                    {
                        materialEditor.ShaderProperty(FindProperty("_RimStep", props), new GUIContent("RimStep", "边缘光的边界线"));
                        materialEditor.ShaderProperty(FindProperty("_RimColor", props), new GUIContent("RimColor", "边缘发光区域用于加算的RGB系数"));
                    }
                    EditorGUILayout.EndVertical();
                    EditorGUILayout.Space();
                }
            }

            //_Outline
            if (material.HasProperty("_OutlineWidth"))
            {
                if (material.GetShaderPassEnabled("SRPDefaultUnlit"))
                {
                    EditorGUILayout.LabelField("OutlineWidth", EditorStyles.boldLabel);
                    EditorGUILayout.BeginVertical(GUI.skin.box);
                    {
                        materialEditor.ShaderProperty(FindProperty("_OutlineWidth", props), new GUIContent("OutlineWidth", "描边宽度\n1表示屏幕上1像素的宽度"));
                        materialEditor.ShaderProperty(FindProperty("_OutlineColor", props), new GUIContent("OutlineColor", "描边的最终颜色 RGBA"));
                        materialEditor.ShaderProperty(FindProperty("_OutlineFull", props), new GUIContent("FullWidthDistance", "世界空间中物体与相机的最近距离\n低于此距离时描边宽度的系数为1"));
                        materialEditor.ShaderProperty(FindProperty("_OutlineFeather", props), new GUIContent("OutlineFeather", "世界空间中描边宽度渐变的范围\n0表示完全没有渐变"));
                    }
                    EditorGUILayout.EndVertical();
                    EditorGUILayout.Space();
                }
            }
            #endregion
        }
    }
}
