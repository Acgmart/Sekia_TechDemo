using System;
using System.IO;
using UnityEngine;
using System.Collections.Generic;
using System.Linq;
using System.Security.Permissions;

namespace UnityEditor.CustomFbxExporter
{
    [CustomEditor(typeof(ExportSettings))]
    internal class ExportSettingsEditor : UnityEditor.Editor
    {
        Vector2 scrollPos = Vector2.zero;
        const float LabelWidth = 180;

        const float ExportOptionsLabelWidth = 205;
        const float ExportOptionsFieldOffset = 18;

        private bool m_showExportSettingsOptions = true;

        private ExportModelSettingsEditor m_exportModelEditor;

        private void OnEnable()
        {
            ExportSettings exportSettings = (ExportSettings)target;
            m_exportModelEditor = UnityEditor.Editor.CreateEditor(exportSettings.ExportModelSettings) as ExportModelSettingsEditor;
        }

        static class Style
        {
            public static GUIContent Application3D = new GUIContent(
                "3D Application",
                "Select the 3D Application for which you would like to install the Unity integration.");
            public static GUIContent KeepOpen = new GUIContent("Keep Open",
                "Keep the selected 3D application open after Unity integration install has completed.");
            public static GUIContent HideNativeMenu = new GUIContent("Hide Native Menu",
                "Replace Maya's native 'Send to Unity' menu with the Unity Integration's menu");
            public static GUIContent InstallIntegrationContent = new GUIContent(
                "Install Unity Integration",
                "Install and configure the Unity integration for the selected 3D application so that you can import and export directly with this project.");
            public static GUIContent RepairMissingScripts = new GUIContent(
                "Run Component Updater",
                "If FBX exporter version 1.3.0f1 or earlier was previously installed, then links to the FbxPrefab component will need updating.\n" +
                "Run this to update all FbxPrefab references in text serialized prefabs and scene files.");
        }

        [SecurityPermission(SecurityAction.LinkDemand)]
        public override void OnInspectorGUI()
        {
            ExportSettings exportSettings = (ExportSettings)target;
            bool isSingletonInstance = this.targets.Length == 1 && this.target == ExportSettings.instance;

            // Increasing the label width so that none of the text gets cut off
            EditorGUIUtility.labelWidth = LabelWidth;
            scrollPos = GUILayout.BeginScrollView(scrollPos);
            GUILayout.BeginVertical();
            EditorGUILayout.Space();

            // EXPORT SETTINGS
            m_showExportSettingsOptions = EditorGUILayout.Foldout(m_showExportSettingsOptions, "FBX File Options", EditorStyles.foldoutHeader);
            if (m_showExportSettingsOptions)
            {
                EditorGUI.indentLevel++;
                EditorGUI.BeginChangeCheck();
                m_exportModelEditor.LabelWidth = ExportOptionsLabelWidth;
                m_exportModelEditor.FieldOffset = ExportOptionsFieldOffset;
                m_exportModelEditor.OnInspectorGUI();
                EditorGUI.indentLevel--;
            }

            EditorGUI.indentLevel--;

            EditorGUILayout.Space();

            GUILayout.EndVertical();
            GUILayout.EndScrollView();

            if (GUI.changed)
            {
                // Only save the settings if we are in the Singleton instance.
                // Otherwise, the user is editing a preset and we don't need to save.
                if (isSingletonInstance)
                {
                    exportSettings.Save();
                }
            }
        }
    }

    //[CreateAssetMenu(menuName = "TA工具/CustomFbxExporterSettings", fileName = "CustomFbxExportSettings", order = 0)]
    public class ExportSettings : ScriptableObject
    {
        #region 类型定义
        public enum ExportFormat { Binary = 0, ASCII = 1 }

        public enum Include { Model = 0, Anim = 1, ModelAndAnim = 2 }

        public enum ObjectPosition { LocalCentered = 0, WorldAbsolute = 1, Reset = 2 /* For convert to model only, no UI option*/}

        public enum LODExportType { All = 0, Highest = 1, Lowest = 2 }

        private static ExportSettings s_Instance;
        public static ExportSettings instance
        {
            get
            {
                if (s_Instance == null)
                {
                    string filePath = AssetDatabase.GUIDToAssetPath("090a6f976a2e635458d6165401c100bc");
                    s_Instance = AssetDatabase.LoadAssetAtPath<ExportSettings>(filePath);
                }
                return s_Instance;
            }
        }
        #endregion

        [SerializeField]
        private bool launchAfterInstallation = true;
        public bool LaunchAfterInstallation
        {
            get { return launchAfterInstallation; }
            set { launchAfterInstallation = value; }
        }

        [SerializeField]
        private bool HideSendToUnityMenu = true;
        public bool HideSendToUnityMenuProperty
        {
            get { return HideSendToUnityMenu; }
            set { HideSendToUnityMenu = value; }
        }

        [SerializeField]
        private bool BakeAnimation = false;
        internal bool BakeAnimationProperty
        {
            get { return BakeAnimation; }
            set { BakeAnimation = value; }
        }

        [SerializeField]
        private bool showConvertToPrefabDialog = false;
        public bool DisplayOptionsWindow
        {
            get { return showConvertToPrefabDialog; }
            set { showConvertToPrefabDialog = value; }
        }

        // don't serialize as ScriptableObject does not get properly serialized on export
        [System.NonSerialized]
        private ExportModelSettings m_exportModelSettings;
        internal ExportModelSettings ExportModelSettings
        {
            get
            {
                if (!m_exportModelSettings)
                {
                    m_exportModelSettings = ScriptableObject.CreateInstance(typeof(ExportModelSettings)) as ExportModelSettings;
                }
                if (this.exportModelSettingsSerialize != null)
                {
                    m_exportModelSettings.info = this.exportModelSettingsSerialize;
                }
                else
                {
                    this.exportModelSettingsSerialize = m_exportModelSettings.info;
                }
                return m_exportModelSettings;
            }
            set { m_exportModelSettings = value; }
        }

        // store contents of export model settings for serialization
        [SerializeField]
        private ExportModelSettingsSerialize exportModelSettingsSerialize;


        internal void LoadDefaults()
        {
            LaunchAfterInstallation = true;
            HideSendToUnityMenuProperty = true;
            BakeAnimationProperty = false;
            exportModelSettingsSerialize = new ExportModelSettingsSerialize();
            ExportModelSettings.info = exportModelSettingsSerialize;
            DisplayOptionsWindow = true;
        }

        internal void Save()
        {
            exportModelSettingsSerialize = ExportModelSettings.info;
        }

        // Called on creation and whenever the reset button is clicked
        internal void Reset()
        {
            // apply default settings
            LoadDefaults();
        }
    }
}
