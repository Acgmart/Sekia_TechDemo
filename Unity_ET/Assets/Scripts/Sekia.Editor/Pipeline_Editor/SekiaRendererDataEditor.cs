using System;
using System.Collections.Generic;
using System.Reflection;
using System.Text.RegularExpressions;
using UnityEngine;
using UnityEngine.Rendering;
using Object = UnityEngine.Object;
using UnityEditor;
using UnityEditor.Rendering;

namespace Sekia
{
    class SekiaRendererFeatureProvider : FilterWindow.IProvider
    {
        class FeatureElement : FilterWindow.Element
        {
            public Type type;
        }

        readonly SekiaRendererDataEditor m_Editor;
        SerializedProperty listProp;
        List<Editor> editors;

        public Vector2 position { get; set; }

        public SekiaRendererFeatureProvider(SekiaRendererDataEditor editor, SerializedProperty listProp, List<Editor> editors)
        {
            m_Editor = editor;
            this.listProp = listProp;
            this.editors = editors;
        }

        public void CreateComponentTree(List<FilterWindow.Element> tree)
        {
            tree.Add(new FilterWindow.GroupElement(0, "Renderer Features"));
            var types = TypeCache.GetTypesDerivedFrom<SekiaRendererFeature>();
            var data = m_Editor.target as SekiaRendererData;
            foreach (var type in types)
            {
                string path = GetMenuNameFromType(type);
                tree.Add(new FeatureElement
                {
                    content = new GUIContent(path),
                    level = 1,
                    type = type
                });
            }
        }

        public bool GoToChild(FilterWindow.Element element, bool addIfComponent)
        {
            if (element is FeatureElement featureElement)
            {
                m_Editor.AddComponent(featureElement.type.Name, listProp, editors);
                return true;
            }

            return false;
        }

        string GetMenuNameFromType(Type type)
        {
            string path = ObjectNames.NicifyVariableName(type.Name);

            if (type.Namespace != null)
            {
                if (type.Namespace.Contains("Experimental"))
                    path += " (Experimental)";
            }

            return path;
        }

    }

    [CustomEditor(typeof(SekiaRendererData), true)]
    public class SekiaRendererDataEditor : Editor
    {
        class Styles
        {
            public static readonly GUIContent SceneviewFeatures = new GUIContent("Sceneview Features");
            public static readonly GUIContent PreviewFeatures = new GUIContent("Preview Features");
            public static readonly GUIContent GameviewFeatures = new GUIContent("Gameview Features");
            public static readonly GUIContent PassNameField = new GUIContent("Name");
            public static readonly GUIContent MissingFeature = new GUIContent("丢失RendererFeature");
            public static GUIStyle BoldLabelSimple;

            public static readonly GUIContent useCopyColorRT = EditorGUIUtility.TrTextContent("useCopyColorRT",
                "开启后可在透明材质渲染时采样_CameraOpaqueTexture");
            public static readonly GUIContent useCopyDepthRT = EditorGUIUtility.TrTextContent("useCopyDepthRT",
                "开启后可在透明材质或后处理渲染时采样_CameraDepthTexture");
            public static readonly GUIContent useRenderPass = EditorGUIUtility.TrTextContent("useRenderPass",
                "开启后Game相机使用延迟渲染+NativeRenderPass的移动端模式");
            public static readonly GUIContent useIntermediateRT = EditorGUIUtility.TrTextContent("useIntermediateRT",
                "是否强制开启中间RT");

            static Styles()
            {
                BoldLabelSimple = new GUIStyle(EditorStyles.label);
                BoldLabelSimple.fontStyle = FontStyle.Bold;
            }
        }

        SerializedProperty m_useCopyColorRT;
        SerializedProperty m_useCopyDepthRT;
        SerializedProperty m_useRenderPass;
        SerializedProperty m_useIntermediateRT;

        SerializedProperty m_FeaturesSceneView;
        SerializedProperty m_FeaturesPreview;
        SerializedProperty m_FeaturesGameView;
        SerializedProperty m_FalseBool;
        List<Editor> m_EditorsSceneView = new List<Editor>();
        List<Editor> m_EditorsPreview = new List<Editor>();
        List<Editor> m_EditorsGameview = new List<Editor>();

        [SerializeField] private bool falseBool = false;
        public static bool showDefaultList;
        public static bool showEditorList;

        private void OnEnable()
        {
            m_useCopyColorRT = serializedObject.FindProperty("useCopyColorRT");
            m_useCopyDepthRT = serializedObject.FindProperty("useCopyDepthRT");
            m_useRenderPass = serializedObject.FindProperty("useRenderPass");
            m_useIntermediateRT = serializedObject.FindProperty("useIntermediateRT");

            m_FeaturesSceneView = serializedObject.FindProperty(nameof(SekiaRendererData.m_Features_Sceneview));
            m_FeaturesPreview = serializedObject.FindProperty(nameof(SekiaRendererData.m_Features_Preview));
            m_FeaturesGameView = serializedObject.FindProperty(nameof(SekiaRendererData.m_Features_Gameview));
            var editorObj = new SerializedObject(this);
            m_FalseBool = editorObj.FindProperty(nameof(falseBool));
            UpdateEditorList(m_FeaturesSceneView, m_EditorsSceneView);
            UpdateEditorList(m_FeaturesPreview, m_EditorsPreview);
            UpdateEditorList(m_FeaturesGameView, m_EditorsGameview);
        }

        private void OnDisable()
        {
            ClearEditorsList(m_EditorsSceneView);
            ClearEditorsList(m_EditorsPreview);
            ClearEditorsList(m_EditorsGameview);
        }

        /// <inheritdoc/>
        public override void OnInspectorGUI()
        {
            if (m_FeaturesSceneView == null ||
                m_FeaturesPreview == null ||
                m_FeaturesGameView == null)
                OnEnable();
            else if (m_FeaturesSceneView.arraySize != m_EditorsSceneView.Count ||
                m_FeaturesPreview.arraySize != m_EditorsPreview.Count ||
                m_FeaturesGameView.arraySize != m_EditorsGameview.Count)
            {
                UpdateEditorList(m_FeaturesSceneView, m_EditorsSceneView);
                UpdateEditorList(m_FeaturesPreview, m_EditorsPreview);
                UpdateEditorList(m_FeaturesGameView, m_EditorsGameview);
            }

            serializedObject.Update();

            showDefaultList = EditorGUILayout.Toggle("ShowDefaulInspector", showDefaultList);
            if (!showDefaultList)
                showEditorList = EditorGUILayout.Toggle("ShowEditorList", showEditorList);

            if (showDefaultList)
            {
                base.OnInspectorGUI();
            }
            else
            {
                EditorGUI.BeginChangeCheck();
                EditorGUILayout.Space();
                EditorGUILayout.PropertyField(m_useCopyColorRT, Styles.useCopyColorRT);
                EditorGUILayout.PropertyField(m_useCopyDepthRT, Styles.useCopyDepthRT);
                EditorGUILayout.PropertyField(m_useRenderPass, Styles.useRenderPass);
                EditorGUILayout.PropertyField(m_useIntermediateRT, Styles.useIntermediateRT);
                EditorGUILayout.Space();
                if (EditorGUI.EndChangeCheck())
                    serializedObject.ApplyModifiedProperties();

                DrawRendererFeatureList(Styles.GameviewFeatures, m_FeaturesGameView, m_EditorsGameview);

                if (showEditorList)
                {
                    EditorGUILayout.Space();
                    DrawRendererFeatureList(Styles.SceneviewFeatures, m_FeaturesSceneView, m_EditorsSceneView);
                    EditorGUILayout.Space();
                    DrawRendererFeatureList(Styles.PreviewFeatures, m_FeaturesPreview, m_EditorsPreview);
                }
            }
        }

        private void DrawRendererFeatureList(GUIContent content, SerializedProperty listProp, List<Editor> editors)
        {
            EditorGUILayout.LabelField(content, EditorStyles.boldLabel);
            EditorGUILayout.Space();

            if (listProp.arraySize == 0)
            {
                EditorGUILayout.HelpBox("No Renderer Features added", MessageType.Info);
            }
            else
            {
                //Draw List
                CoreEditorUtils.DrawSplitter();
                for (int i = 0; i < listProp.arraySize; i++)
                {
                    SerializedProperty renderFeaturesProperty = listProp.GetArrayElementAtIndex(i);
                    DrawRendererFeature(i, ref renderFeaturesProperty, listProp, editors);
                    CoreEditorUtils.DrawSplitter();
                }
            }
            EditorGUILayout.Space();

            //Add renderer
            using (var hscope = new EditorGUILayout.HorizontalScope())
            {
                if (GUILayout.Button("Add Renderer Feature", EditorStyles.miniButton))
                {
                    var r = hscope.rect;
                    var pos = new Vector2(r.x + r.width / 2f, r.yMax + 18f);
                    // FilterWindow.Show(pos, new SekiaRendererFeatureProvider(this, listProp, editors));
                }
            }
        }

        private void DrawRendererFeature(int index, ref SerializedProperty renderFeatureProperty, SerializedProperty listProp, List<Editor> editors)
        {
            Object rendererFeatureObjRef = renderFeatureProperty.objectReferenceValue;
            if (rendererFeatureObjRef != null)
            {
                bool hasChangedProperties = false;
                string title = ObjectNames.GetInspectorTitle(rendererFeatureObjRef);

                // Get the serialized object for the editor script & update it
                Editor rendererFeatureEditor = editors[index];
                SerializedObject serializedRendererFeaturesEditor = rendererFeatureEditor.serializedObject;
                serializedRendererFeaturesEditor.Update();

                // Foldout header
                EditorGUI.BeginChangeCheck();
                SerializedProperty activeProperty = serializedRendererFeaturesEditor.FindProperty(nameof(SekiaRendererFeature.isActive));
                bool displayContent = CoreEditorUtils.DrawHeaderToggle(
                    EditorGUIUtility.TrTextContent(title), renderFeatureProperty, activeProperty, pos => OnContextClick(pos, index, listProp, editors));
                hasChangedProperties |= EditorGUI.EndChangeCheck();

                // ObjectEditor
                if (displayContent)
                {
                    EditorGUI.BeginChangeCheck();
                    rendererFeatureObjRef.name = ValidateName(EditorGUILayout.DelayedTextField(Styles.PassNameField, rendererFeatureObjRef.name));
                    hasChangedProperties |= EditorGUI.EndChangeCheck();

                    EditorGUI.BeginChangeCheck();
                    rendererFeatureEditor.OnInspectorGUI();
                    hasChangedProperties |= EditorGUI.EndChangeCheck();

                    EditorGUILayout.Space(EditorGUIUtility.singleLineHeight);
                }

                // Apply changes and save if the user has modified any settings
                if (hasChangedProperties)
                {
                    serializedRendererFeaturesEditor.ApplyModifiedProperties();
                    serializedObject.ApplyModifiedProperties();
                    ForceSave();
                }
            }
            else
            {
                CoreEditorUtils.DrawHeaderToggle(Styles.MissingFeature, renderFeatureProperty, m_FalseBool, pos => OnContextClick(pos, index, listProp, editors));
                m_FalseBool.boolValue = false; // always make sure false bool is false
                EditorGUILayout.HelpBox("Feature为null或对应的C#脚本不存在", MessageType.Error);
            }
        }

        private void OnContextClick(Vector2 position, int id, SerializedProperty listProp, List<Editor> editors)
        {
            var menu = new GenericMenu();

            if (id == 0)
                menu.AddDisabledItem(EditorGUIUtility.TrTextContent("Move Up"));
            else
                menu.AddItem(EditorGUIUtility.TrTextContent("Move Up"), false, () => MoveComponent(id, -1, listProp, editors));

            if (id == listProp.arraySize - 1)
                menu.AddDisabledItem(EditorGUIUtility.TrTextContent("Move Down"));
            else
                menu.AddItem(EditorGUIUtility.TrTextContent("Move Down"), false, () => MoveComponent(id, 1, listProp, editors));

            menu.AddSeparator(string.Empty);
            menu.AddItem(EditorGUIUtility.TrTextContent("Remove"), false, () => RemoveComponent(id, listProp, editors));

            menu.DropDown(new Rect(position, Vector2.zero));
        }

        internal void AddComponent(string type, SerializedProperty listProp, List<Editor> editors)
        {
            serializedObject.Update();

            ScriptableObject component = CreateInstance((string)type);
            component.name = $"{(string)type}";
            Undo.RegisterCreatedObjectUndo(component, "Add Renderer Feature");

            // Store this new effect as a sub-asset so we can reference it safely afterwards
            // Only when we're not dealing with an instantiated asset
            if (EditorUtility.IsPersistent(target))
            {
                AssetDatabase.AddObjectToAsset(component, target);
            }

            // Grow the list first, then add - that's how serialized lists work in Unity
            listProp.arraySize++;
            SerializedProperty componentProp = listProp.GetArrayElementAtIndex(listProp.arraySize - 1);
            componentProp.objectReferenceValue = component;

            // Update GUID Map
            UpdateEditorList(listProp, editors);
            serializedObject.ApplyModifiedProperties();

            // Force save / refresh
            if (EditorUtility.IsPersistent(target))
            {
                ForceSave();
            }
            serializedObject.ApplyModifiedProperties();
        }

        private void RemoveComponent(int id, SerializedProperty listProp, List<Editor> editors)
        {
            SerializedProperty property = listProp.GetArrayElementAtIndex(id);
            Object component = property.objectReferenceValue;
            property.objectReferenceValue = null;

            Undo.SetCurrentGroupName(component == null ? "Remove Renderer Feature" : $"Remove {component.name}");

            // remove the array index itself from the list
            listProp.DeleteArrayElementAtIndex(id);
            UpdateEditorList(listProp, editors);
            serializedObject.ApplyModifiedProperties();

            // Destroy the setting object after ApplyModifiedProperties(). If we do it before, redo
            // actions will be in the wrong order and the reference to the setting object in the
            // list will be lost.
            if (component != null)
                Undo.DestroyObjectImmediate(component);

            // Force save / refresh
            ForceSave();
        }

        private void MoveComponent(int id, int offset, SerializedProperty listProp, List<Editor> editors)
        {
            Undo.SetCurrentGroupName("Move Render Feature");
            serializedObject.Update();
            listProp.MoveArrayElement(id, id + offset);
            UpdateEditorList(listProp, editors);
            serializedObject.ApplyModifiedProperties();

            // Force save / refresh
            ForceSave();
        }

        private string ValidateName(string name)
        {
            name = Regex.Replace(name, @"[^a-zA-Z0-9 ]", "");
            return name;
        }

        private void UpdateEditorList(SerializedProperty listProp, List<Editor> editors)
        {
            ClearEditorsList(editors);
            for (int i = 0; i < listProp.arraySize; i++)
            {
                editors.Add(CreateEditor(listProp.GetArrayElementAtIndex(i).objectReferenceValue));
            }
        }

        //To avoid leaking memory we destroy editors when we clear editors list
        private void ClearEditorsList(List<Editor> editors)
        {
            for (int i = editors.Count - 1; i >= 0; --i)
            {
                DestroyImmediate(editors[i]);
            }
            editors.Clear();
        }

        private void ForceSave()
        {
            EditorUtility.SetDirty(target);
        }
    }
}
