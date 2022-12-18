using System;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;
using UnityEditor.Rendering;
using UnityEditor;
using System.Linq;
using UnityEditorInternal;
using System.Collections.Generic;
using UnityEditor.SceneManagement;

namespace Sekia
{
    using CED = CoreEditorDrawer<SekiaPipelineSerializedCamera>;

    class SekiaPipelineSerializedCamera : ISerializedCamera
    {
        public SerializedObject serializedObject { get; }
        public SerializedObject serializedAdditionalDataObject { get; }
        public CameraEditor.Settings baseCameraSettings { get; }

        // This one is internal in UnityEditor for whatever reason...
        public SerializedProperty projectionMatrixMode { get; }

        // Common properties
        public SerializedProperty dithering { get; }
        public SerializedProperty stopNaNs { get; }
        public SerializedProperty allowDynamicResolution { get; }
        public SerializedProperty volumeLayerMask { get; }
        public SerializedProperty clearDepth { get; }
        public SerializedProperty antialiasing { get; }

        // URP specific properties
        public SerializedProperty renderShadows { get; }
        public SerializedProperty renderDepth { get; }
        public SerializedProperty renderOpaque { get; }
        public SerializedProperty renderer { get; }
        public SerializedProperty cameraType { get; }
        public SerializedProperty cameras { get; set; }
        public SerializedProperty volumeTrigger { get; }
        public SerializedProperty volumeFrameworkUpdateMode { get; }
        public SerializedProperty renderPostProcessing { get; }
        public SerializedProperty antialiasingQuality { get; }

        public (Camera camera, SekiaPipelineSerializedCamera serializedCamera) this[int index]
        {
            get
            {
                if (index < 0 || index >= numCameras)
                    throw new ArgumentOutOfRangeException($"{index} is out of bounds [0 - {numCameras}]");

                // Return the camera on that index
                return (cameras.GetArrayElementAtIndex(index).objectReferenceValue as Camera, cameraSerializedObjects[index]);
            }
        }

        public int numCameras => cameras?.arraySize ?? 0;

        SekiaPipelineSerializedCamera[] cameraSerializedObjects { get; set; }

        public UniversalAdditionalCameraData[] camerasAdditionalData { get; }

        public SekiaPipelineSerializedCamera(SerializedObject serializedObject, CameraEditor.Settings settings = null)
        {
            this.serializedObject = serializedObject;
            projectionMatrixMode = serializedObject.FindProperty("m_projectionMatrixMode");

            allowDynamicResolution = serializedObject.FindProperty("m_AllowDynamicResolution");

            if (settings == null)
            {
                baseCameraSettings = new CameraEditor.Settings(serializedObject);
                baseCameraSettings.OnEnable();
            }
            else
            {
                baseCameraSettings = settings;
            }

            camerasAdditionalData = CoreEditorUtils
                .GetAdditionalData<UniversalAdditionalCameraData>(serializedObject.targetObjects);
            serializedAdditionalDataObject = new SerializedObject(camerasAdditionalData);

            // Common properties
            stopNaNs = serializedAdditionalDataObject.FindProperty("m_StopNaN");
            dithering = serializedAdditionalDataObject.FindProperty("m_Dithering");
            antialiasing = serializedAdditionalDataObject.FindProperty("m_Antialiasing");
            volumeLayerMask = serializedAdditionalDataObject.FindProperty("m_VolumeLayerMask");
            clearDepth = serializedAdditionalDataObject.FindProperty("m_ClearDepth");

            // URP specific properties
            renderShadows = serializedAdditionalDataObject.FindProperty("m_RenderShadows");
            renderDepth = serializedAdditionalDataObject.FindProperty("m_RequiresDepthTextureOption");
            renderOpaque = serializedAdditionalDataObject.FindProperty("m_RequiresOpaqueTextureOption");
            renderer = serializedAdditionalDataObject.FindProperty("m_RendererIndex");
            volumeLayerMask = serializedAdditionalDataObject.FindProperty("m_VolumeLayerMask");
            volumeTrigger = serializedAdditionalDataObject.FindProperty("m_VolumeTrigger");
            volumeFrameworkUpdateMode = serializedAdditionalDataObject.FindProperty("m_VolumeFrameworkUpdateModeOption");
            renderPostProcessing = serializedAdditionalDataObject.FindProperty("m_RenderPostProcessing");
            antialiasingQuality = serializedAdditionalDataObject.FindProperty("m_AntialiasingQuality");
            cameraType = serializedAdditionalDataObject.FindProperty("m_CameraType");
        }

        /// <summary>
        /// Updates the internal serialized objects
        /// </summary>
        public void Update()
        {
            baseCameraSettings.Update();
            serializedObject.Update();
            serializedAdditionalDataObject.Update();

            for (int i = 0; i < numCameras; ++i)
            {
                cameraSerializedObjects[i].Update();
            }
        }

        /// <summary>
        /// Applies the modified properties to the serialized objects
        /// </summary>
        public void Apply()
        {
            baseCameraSettings.ApplyModifiedProperties();
            serializedObject.ApplyModifiedProperties();
            serializedAdditionalDataObject.ApplyModifiedProperties();

            for (int i = 0; i < numCameras; ++i)
            {
                cameraSerializedObjects[i].Apply();
            }
        }

        /// <summary>
        /// Refreshes the serialized properties from the serialized objects
        /// </summary>
        public void Refresh()
        {
            var o = new PropertyFetcher<UniversalAdditionalCameraData>(serializedAdditionalDataObject);
            cameras = o.Find("m_Cameras");

            cameraSerializedObjects = new SekiaPipelineSerializedCamera[numCameras];
            for (int i = 0; i < numCameras; ++i)
            {
                Camera cam = cameras.GetArrayElementAtIndex(i).objectReferenceValue as Camera;
                cameraSerializedObjects[i] = new SekiaPipelineSerializedCamera(new SerializedObject(cam));
            }
        }
    }

    [CanEditMultipleObjects]
    [CustomEditor(typeof(UniversalAdditionalCameraData))]
    class SekiaCameraDataEditor : Editor
    {
        SekiaPipelineSerializedCamera m_SerializedCamera;
        UniversalAdditionalCameraData _target;
        Camera _brother;

        ReorderableList m_LayerList;
        List<Camera> validCameras = new List<Camera>();
        List<Camera> m_TypeErrorCameras = new List<Camera>();
        List<Camera> m_NotSupportedOverlayCameras = new List<Camera>();
        List<Camera> m_IncompatibleCameras = new List<Camera>();
        List<(Camera, SekiaPipelineSerializedCamera)> m_OutputWarningCameras = new();
        static Camera selectedCameraInStack;

        public void OnEnable()
        {
            k_ExpandedState = new(Expandable.Projection, "SekiaRP");

            _target = target as UniversalAdditionalCameraData;
            _brother = _target.GetComponent<Camera>();
            SerializedObject cameraSerialized = new SerializedObject(_brother);
            m_SerializedCamera = new SekiaPipelineSerializedCamera(cameraSerialized, null);
            m_SerializedCamera.Refresh();

            #region 初始化Drawer
            SectionProjectionSettings = CED.FoldoutGroup(
                EditorGUIUtility.TrTextContent("Projection"),
                Expandable.Projection,
                k_ExpandedState,
                FoldoutOption.Indent,
                CED.Group(DrawerProjection),
                DrawerPhysicalCamera);

            BaseCameraRenderTypeDrawer = CED.Conditional(
                (serialized, owner) => (CameraRenderType)serialized.cameraType.intValue == CameraRenderType.Base,

                //后处理开关
                CED.Group(DrawerRenderingRenderPostProcessing),

                //抗锯齿
                CED.Group(DrawerRenderingAntialiasing),
                CED.Conditional(
                    (serialized, owner) => !serialized.antialiasing.hasMultipleDifferentValues,
                    CED.Group(
                        GroupOption.Indent,
                        CED.Conditional(
                            (serialized, owner) => (AntialiasingMode)serialized.antialiasing.intValue ==
                            AntialiasingMode.SubpixelMorphologicalAntiAliasing,
                            CED.Group(DrawerRenderingSMAAQuality))
                    )),

                //StopNaNs
                CED.Group(Drawer_Rendering_StopNaNs),
                CED.Conditional( //StopNaNs的渲染平台警告
                    (serialized, owner) => serialized.stopNaNs.boolValue && CoreEditorUtils.buildTargets.Contains(GraphicsDeviceType.OpenGLES2),
                    (serialized, owner) => EditorGUILayout.HelpBox(Styles_stopNaNsMessage, MessageType.Warning)),

                //抖动
                CED.Group(Drawer_Rendering_Dithering),

                CED.Group(
                    DrawerRenderingRenderShadows,
                    DrawerRenderingPriority,
                    DrawerRenderingOpaqueTexture,
                    DrawerRenderingDepthTexture));

            OverlayCameraRenderTypeDrawer = CED.Conditional(
                (serialized, owner) => (CameraRenderType)serialized.cameraType.intValue == CameraRenderType.Overlay,
                CED.Group(DrawerRenderingRenderPostProcessing),
                CED.Group(
                    DrawerRenderingClearDepth,
                    DrawerRenderingRenderShadows,
                    DrawerRenderingDepthTexture));

            Draw_Rendering = CED.FoldoutGroup(
                CameraUI.Rendering.Styles.header,
                Expandable.Rendering,
                k_ExpandedState,
                FoldoutOption.Indent,
                CED.Group(DrawerRenderingRenderer),
                BaseCameraRenderTypeDrawer,
                OverlayCameraRenderTypeDrawer,
                CED.Group(Drawer_Rendering_CullingMask,
                     Drawer_Rendering_OcclusionCulling));

            Drawer_Environment = CED.FoldoutGroup(
                CameraUI.Environment.Styles.header,
                Expandable.Environment,
                k_ExpandedState,
                FoldoutOption.Indent,
                CED.Conditional(
                    (serialized, owner) => (CameraRenderType)serialized.cameraType.intValue == CameraRenderType.Base,
                    CED.Group(Drawer_Environment_ClearFlags)),
                CED.Group(
                    Styles_volumesSettingsText,
                    CED.Group(
                        GroupOption.Indent,
                        Drawer_Environment_VolumeUpdate,
                        CameraUI.Environment.Drawer_Environment_VolumeLayerMask,
                        Drawer_Environment_VolumeTrigger)));

            Drawer_Output = CED.Conditional(
                (serialized, owner) => (CameraRenderType)serialized.cameraType.intValue == CameraRenderType.Base,
                CED.FoldoutGroup(
                    CameraUI.Output.Styles.header,
                    Expandable.Output,
                    k_ExpandedState,
                    FoldoutOption.Indent,
                    CED.Group(DrawerOutputTargetTexture),
                    CED.Conditional(
                        (serialized, owner) => serialized.serializedObject.targetObject is Camera camera && camera.targetTexture == null,
                        CED.Group(DrawerOutputMultiDisplay)),
                    CED.Group(DrawerOutputNormalizedViewPort),
                    CED.Conditional(
                        (serialized, owner) => serialized.serializedObject.targetObject is Camera camera && camera.targetTexture == null,
                        CED.Group(
                            DrawerOutputHDR,
                            DrawerOutputMSAA,
                            DrawerOutputAllowDynamicResolution))));

            Inspector = new CED.IDrawer[6];
            Inspector[0] = CED.Group(DrawerCameraType);
            Inspector[1] = SectionProjectionSettings;
            Inspector[2] = Draw_Rendering;
            Inspector[3] = SectionStackSettings;
            Inspector[4] = Drawer_Environment;
            Inspector[5] = Drawer_Output;
            #endregion end of 初始化Drawer

            selectedCameraInStack = null;
            validCameras.Clear();
            m_TypeErrorCameras.Clear();
            m_NotSupportedOverlayCameras.Clear();
            m_IncompatibleCameras.Clear();
            m_OutputWarningCameras.Clear();

            m_LayerList = new ReorderableList(m_SerializedCamera.serializedObject, m_SerializedCamera.cameras, true, true, true, true)
            {
                drawHeaderCallback = rect => EditorGUI.LabelField(rect, Styles_cameras),
                drawElementCallback = DrawElementCallback,
                onSelectCallback = SelectElement,
                onRemoveCallback = RemoveCamera,
                onCanRemoveCallback = CanRemoveCamera,
                onAddDropdownCallback = AddCameraToCameraList
            };
        }

        public override void OnInspectorGUI()
        {
            if (SekiaPipeline.Instance == null)
                return;

            if (!(GraphicsSettings.currentRenderPipeline is SekiaPipelineAsset))
                return;

            m_SerializedCamera.Update();

            EditorGUILayout.BeginVertical();
            foreach (var drawer in Inspector)
                if (drawer != null)
                    drawer.Draw(m_SerializedCamera, this);
            EditorGUILayout.EndVertical();

            m_SerializedCamera.Apply();
        }

        #region 栈列表委托
        bool CanRemoveCamera(ReorderableList list) => m_SerializedCamera.numCameras > 0;

        void RemoveCamera(ReorderableList list)
        {
            // As multi selection is disabled, selectedIndices will only return 1 element, remove that element from the list
            if (list.selectedIndices.Any())
            {
                m_SerializedCamera.cameras.DeleteArrayElementAtIndex(list.selectedIndices.First());
            }
            else
            {
                // Nothing selected, remove the last item on the list
                ReorderableList.defaultBehaviours.DoRemoveButton(list);
            }

            // Force update the list as removed camera could been there
            m_TypeErrorCameras.Clear();
            m_NotSupportedOverlayCameras.Clear();
            m_IncompatibleCameras.Clear();
            m_OutputWarningCameras.Clear();
        }

        void SelectElement(ReorderableList list)
        {
            var element = m_SerializedCamera.cameras.GetArrayElementAtIndex(list.index);
            selectedCameraInStack = element.objectReferenceValue as Camera;
            if (Event.current.clickCount == 2)
            {
                Selection.activeObject = selectedCameraInStack;
            }

            EditorGUIUtility.PingObject(selectedCameraInStack);
        }

        void DrawElementCallback(Rect rect, int index, bool isActive, bool isFocused)
        {
            rect.height = EditorGUIUtility.singleLineHeight;
            rect.y += 1;

            (Camera camera, SekiaPipelineSerializedCamera serializedCamera) overlayCamera = m_SerializedCamera[index];
            Camera cam = overlayCamera.camera;

            if (cam != null)
            {
                var baseAdditionalData = _brother.GetUniversalAdditionalCameraData();
                bool outputWarning = false;

                // Checking if the Base Camera and the overlay cameras are of the same type.
                // If not, we report an error.
                var overlayAdditionalData = cam.GetUniversalAdditionalCameraData();
                var type = overlayAdditionalData.renderType;

                GUIContent errorContent = EditorGUIUtility.TrTextContent(type.GetName());

                if (type != CameraRenderType.Overlay)
                {
                    if (!m_TypeErrorCameras.Contains(cam))
                    {
                        m_TypeErrorCameras.Add(cam);
                    }
                    errorContent = EditorGUIUtility.TrTextContent(type.GetName(), $"Stack can only contain Overlay cameras. The camera: {cam.name} " +
                                                                                    $"has a type {type} that is not supported. Will skip rendering.",
                        CoreEditorStyles.iconFail);
                }
                else if (m_TypeErrorCameras.Contains(cam))
                {
                    m_TypeErrorCameras.Remove(cam);
                }

                if (IsStackCameraOutputDirty(cam, overlayCamera.serializedCamera))
                {
                    outputWarning = true;
                    if (!m_OutputWarningCameras.Exists(c => c.Item1 == cam))
                    {
                        m_OutputWarningCameras.Add((cam, overlayCamera.serializedCamera));
                    }
                }
                else
                {

                    m_OutputWarningCameras.RemoveAll(c => c.Item1 == cam);
                }


                GUIContent nameContent =
                    outputWarning ?
                    EditorGUIUtility.TrTextContent(cam.name, "Output properties do not match base camera", CoreEditorStyles.iconWarn) :
                    EditorGUIUtility.TrTextContent(cam.name);

                EditorGUI.BeginProperty(rect, GUIContent.none, m_SerializedCamera.cameras.GetArrayElementAtIndex(index));
                var labelWidth = EditorGUIUtility.labelWidth;
                EditorGUIUtility.labelWidth -= 20f;

                using (var iconSizeScope = new EditorGUIUtility.IconSizeScope(new Vector2(rect.height, rect.height)))
                {
                    EditorGUI.LabelField(rect, nameContent, errorContent);
                }

                // Printing if Post Processing is on or not.
                var isPostActive = cam.GetUniversalAdditionalCameraData().renderPostProcessing;
                if (isPostActive)
                {
                    Rect selectRect = new Rect(rect.width - 20, rect.y, 50, EditorGUIUtility.singleLineHeight);

                    EditorGUI.LabelField(selectRect, "PP");
                }
                EditorGUI.EndProperty();

                EditorGUIUtility.labelWidth = labelWidth;
            }
            else
            {
                _brother.GetUniversalAdditionalCameraData().UpdateCameraStack();

                // Need to clean out the errorCamera list here.
                m_TypeErrorCameras.Clear();
                m_OutputWarningCameras.Clear();
            }
        }

        // Modified version of StageHandle.FindComponentsOfType<T>()
        // This version more closely represents unity object referencing restrictions.
        // I added these restrictions:
        // - Can not reference scene object outside scene
        // - Can not reference cross scenes
        // - Can reference child objects if it is prefab
        Camera[] FindCamerasToReference(GameObject gameObject)
        {
            var scene = gameObject.scene;

            var inScene = !EditorUtility.IsPersistent(_brother) || scene.IsValid();
            var inPreviewScene = EditorSceneManager.IsPreviewScene(scene) && scene.IsValid();
            var inCurrentScene = !EditorUtility.IsPersistent(_brother) && scene.IsValid();

            Camera[] cameras = Resources.FindObjectsOfTypeAll<Camera>();
            List<Camera> result = new List<Camera>();
            if (!inScene)
            {
                foreach (var camera in cameras)
                {
                    if (camera.transform.IsChildOf(gameObject.transform))
                        result.Add(camera);
                }
            }
            else if (inPreviewScene)
            {
                foreach (var camera in cameras)
                {
                    if (camera.gameObject.scene == scene)
                        result.Add(camera);
                }
            }
            else if (inCurrentScene)
            {
                foreach (var camera in cameras)
                {
                    if (!EditorUtility.IsPersistent(camera) && !EditorSceneManager.IsPreviewScene(camera.gameObject.scene) && camera.gameObject.scene == scene)
                        result.Add(camera);
                }
            }

            return result.ToArray();
        }

        void AddCameraToCameraList(Rect rect, ReorderableList list)
        {
            // Need to do clear the list here otherwise the menu just fills up with more and more entries
            validCameras.Clear();
            var allCameras = FindCamerasToReference(_brother.gameObject);
            foreach (var camera in allCameras)
            {
                var component = camera.GetUniversalAdditionalCameraData();
                if (component != null)
                {
                    if (component.renderType == CameraRenderType.Overlay)
                    {
                        validCameras.Add(camera);
                    }
                }
            }

            var names = new GUIContent[validCameras.Count];
            for (int i = 0; i < validCameras.Count; ++i)
            {
                names[i] = new GUIContent((i + 1) + " " + validCameras[i].name);
            }

            if (!validCameras.Any())
            {
                names = new GUIContent[1];
                names[0] = new GUIContent("No Overlay Cameras exist.");
            }
            EditorUtility.DisplayCustomMenu(rect, names, -1, AddCameraToCameraListMenuSelected, null);
        }

        void AddCameraToCameraListMenuSelected(object userData, string[] options, int selected)
        {
            if (!validCameras.Any())
                return;

            m_SerializedCamera.cameras.InsertArrayElementAtIndex(m_SerializedCamera.numCameras);
            m_SerializedCamera.cameras.GetArrayElementAtIndex(m_SerializedCamera.numCameras - 1).objectReferenceValue = validCameras[selected];
            m_SerializedCamera.serializedAdditionalDataObject.ApplyModifiedProperties();

            m_SerializedCamera.Refresh();

            (Camera camera, SekiaPipelineSerializedCamera serializedCamera) overlayCamera = m_SerializedCamera[m_SerializedCamera.numCameras - 1];
            UpdateStackCameraOutput(overlayCamera.camera, overlayCamera.serializedCamera);
        }
        #endregion

        #region Drawer
        enum Expandable //有哪些模块可以展开
        {
            Projection = 1 << 0,
            Physical = 1 << 1,
            Output = 1 << 2,
            Orthographic = 1 << 3,
            RenderLoop = 1 << 4,
            Rendering = 1 << 5,
            Environment = 1 << 6,
            Stack = 1 << 7,
        }

        static ExpandedState<Expandable, Camera> k_ExpandedState;
        static CED.IDrawer[] Inspector;

        //Sec1
        static void DrawerCameraType(SekiaPipelineSerializedCamera p, Editor owner)
        {
            int selectedRenderer = p.renderer.intValue;
            var scriptableRenderer = SekiaPipeline.Instance.asset.GetRenderer(selectedRenderer);
            bool isDeferred = scriptableRenderer.useRenderPass;

            EditorGUI.BeginChangeCheck();

            CameraRenderType originalCamType = (CameraRenderType)p.cameraType.intValue;
            CameraRenderType camType = originalCamType;

            EditorGUI.BeginDisabledGroup(false);
            camType = (CameraRenderType)EditorGUILayout.EnumPopup(
                EditorGUIUtility.TrTextContent("Render Type"),
                camType,
                e => true,
                false
            );
            EditorGUI.EndDisabledGroup();

            if (EditorGUI.EndChangeCheck() || camType != originalCamType)
            {
                p.cameraType.intValue = (int)camType;
            }

            EditorGUILayout.Space();
        }

        #region Sec2 投影矩阵
        public enum ProjectionType
        {
            Perspective,
            Orthographic
        }

        public enum ProjectionMatrixMode
        {
            Explicit,
            Implicit,
            PhysicalPropertiesBased,
        }

        static bool s_FovChanged;
        static float s_FovLastValue;
        static CED.IDrawer SectionProjectionSettings;

        static void DrawerProjection(ISerializedCamera p, Editor owner)
        {
            //相机的透视模式：透视相机or正交相机
            var projectionType = DrawerProjectionType(p);

            if (p.baseCameraSettings.orthographic.hasMultipleDifferentValues)
                return;

            using (new EditorGUI.IndentLevelScope())
            {
                if (projectionType == ProjectionType.Orthographic)
                {
                    DrawerOrthographicType(p);
                }
                else
                {
                    DrawerPerspectiveType(p);
                }
            }
        }

        static ProjectionType DrawerProjectionType(ISerializedCamera p)
        {
            var cam = p.baseCameraSettings;
            ProjectionType projectionType;

            Rect perspectiveRect = EditorGUILayout.GetControlRect();
            EditorGUI.BeginProperty(perspectiveRect, EditorGUIUtility.TrTextContent("Projection"), cam.orthographic);
            {
                projectionType = cam.orthographic.boolValue ? ProjectionType.Orthographic : ProjectionType.Perspective;

                EditorGUI.BeginChangeCheck();
                projectionType = (ProjectionType)EditorGUI.EnumPopup(perspectiveRect, EditorGUIUtility.TrTextContent("Projection"), projectionType);
                if (EditorGUI.EndChangeCheck())
                    cam.orthographic.boolValue = (projectionType == ProjectionType.Orthographic);
            }
            EditorGUI.EndProperty();

            return projectionType;
        }

        //近远裁剪面
        static void Drawer_FieldClippingPlanes(ISerializedCamera p)
        {
            CoreEditorUtils.DrawMultipleFields(
                EditorGUIUtility.TrTextContent("Clipping Planes"),
                new[] { p.baseCameraSettings.nearClippingPlane, p.baseCameraSettings.farClippingPlane },
                new[] { EditorGUIUtility.TrTextContent("Near"), EditorGUIUtility.TrTextContent("Far") });
        }

        static void DrawerOrthographicType(ISerializedCamera p)
        {
            EditorGUILayout.PropertyField(p.baseCameraSettings.orthographicSize, EditorGUIUtility.TrTextContent("Size"));
            Drawer_FieldClippingPlanes(p);
        }

        static void DrawerPerspectiveType(ISerializedCamera p)
        {
            var cam = p.baseCameraSettings;

            var targets = p.serializedObject.targetObjects;
            var camera0 = targets[0] as Camera;

            float fovCurrentValue;
            bool multipleDifferentFovValues = false;
            bool isPhysicalCamera = p.projectionMatrixMode.intValue == (int)ProjectionMatrixMode.PhysicalPropertiesBased;

            var rect = EditorGUILayout.GetControlRect();

            #region Field of View Axis
            var guiContent = EditorGUI.BeginProperty(rect,
                EditorGUIUtility.TrTextContent("Field of View Axis", "The axis the Camera's view angle is measured along."),
                cam.fovAxisMode);
            EditorGUI.showMixedValue = cam.fovAxisMode.hasMultipleDifferentValues;

            CoreEditorUtils.DrawEnumPopup<Camera.FieldOfViewAxis>(rect, guiContent, cam.fovAxisMode);

            bool fovAxisVertical = cam.fovAxisMode.intValue == 0;

            if (!fovAxisVertical && !cam.fovAxisMode.hasMultipleDifferentValues)
            {
                float aspectRatio = isPhysicalCamera ? cam.sensorSize.vector2Value.x / cam.sensorSize.vector2Value.y : camera0.aspect;
                // camera.aspect is not serialized so we have to check all targets.
                fovCurrentValue = Camera.VerticalToHorizontalFieldOfView(camera0.fieldOfView, aspectRatio);
                if (targets.Cast<Camera>().Any(camera => camera.fieldOfView != fovCurrentValue))
                    multipleDifferentFovValues = true;
            }
            else
            {
                fovCurrentValue = cam.verticalFOV.floatValue;
                multipleDifferentFovValues = cam.fovAxisMode.hasMultipleDifferentValues;
            }
            #endregion

            #region FOV
            EditorGUI.showMixedValue = multipleDifferentFovValues;
            var content = EditorGUI.BeginProperty(EditorGUILayout.BeginHorizontal(),
                EditorGUIUtility.TrTextContent("Field of View",
                    "The height of the Camera's view angle, measured in degrees along the specified axis."),
                cam.verticalFOV);
            EditorGUI.BeginDisabledGroup(p.projectionMatrixMode.hasMultipleDifferentValues || isPhysicalCamera && (cam.sensorSize.hasMultipleDifferentValues || cam.fovAxisMode.hasMultipleDifferentValues));
            EditorGUI.BeginChangeCheck();
            s_FovLastValue = EditorGUILayout.Slider(content, fovCurrentValue, 0.00001f, 179f);
            s_FovChanged = EditorGUI.EndChangeCheck();
            EditorGUI.EndDisabledGroup();
            EditorGUILayout.EndHorizontal();
            EditorGUI.EndProperty();
            EditorGUI.showMixedValue = false;
            #endregion

            Drawer_FieldClippingPlanes(p);

            content = EditorGUI.BeginProperty(EditorGUILayout.BeginHorizontal(),
                EditorGUIUtility.TrTextContent("Physical Camera",
                    "Enables Physical camera mode for FOV calculation. When checked, the field of view is calculated from properties for simulating physical attributes (focal length, sensor size, and lens shift)."),
                p.projectionMatrixMode);
            EditorGUI.showMixedValue = p.projectionMatrixMode.hasMultipleDifferentValues;

            EditorGUI.BeginChangeCheck();
            isPhysicalCamera = EditorGUILayout.Toggle(content, isPhysicalCamera);
            if (EditorGUI.EndChangeCheck())
            {
                p.projectionMatrixMode.intValue = isPhysicalCamera ? (int)ProjectionMatrixMode.PhysicalPropertiesBased : (int)ProjectionMatrixMode.Implicit;
                s_FovChanged = true;
            }
            EditorGUILayout.EndHorizontal();
            EditorGUI.EndProperty();

            EditorGUI.showMixedValue = false;
            if (s_FovChanged)
            {
                if (!isPhysicalCamera || p.projectionMatrixMode.hasMultipleDifferentValues)
                {
                    cam.verticalFOV.floatValue = fovAxisVertical
                        ? s_FovLastValue
                        : Camera.HorizontalToVerticalFieldOfView(s_FovLastValue, camera0.aspect);
                }
                else if (!p.projectionMatrixMode.hasMultipleDifferentValues)
                {
                    cam.verticalFOV.floatValue = fovAxisVertical
                        ? s_FovLastValue
                        : Camera.HorizontalToVerticalFieldOfView(s_FovLastValue, camera0.aspect);
                }
            }
        }

        //Sec2,2
        public static readonly CED.IDrawer DrawerPhysicalCamera = CED.Conditional(
                (serialized, owner) => serialized.projectionMatrixMode.intValue == (int)CameraUI.ProjectionMatrixMode.PhysicalPropertiesBased,
                CED.Group(
                    CameraUI.PhysicalCamera.Styles.cameraBody,
                    GroupOption.Indent,
                    CED.Group(
                        GroupOption.Indent,
                        CameraUI.PhysicalCamera.Drawer_PhysicalCamera_CameraBody_Sensor,
                        /*
                                    CameraUI.PhysicalCamera.Drawer_PhysicalCamera_CameraBody_ISO,
                                    CameraUI.PhysicalCamera.Drawer_PhysicalCamera_CameraBody_ShutterSpeed,
                        */
                        CameraUI.PhysicalCamera.Drawer_PhysicalCamera_CameraBody_GateFit
                    )
                    )
            /*
            ,
                CED.Group(
                    CameraUI.PhysicalCamera.Styles.lens,
                    GroupOption.Indent,
                    CED.Group(
                        GroupOption.Indent,
                        CameraUI.PhysicalCamera.Drawer_PhysicalCamera_Lens_FocalLength,
                        CameraUI.PhysicalCamera.Drawer_PhysicalCamera_Lens_Shift,
                        CameraUI.PhysicalCamera.Drawer_PhysicalCamera_Lens_Aperture,
                        CameraUI.PhysicalCamera.Drawer_PhysicalCamera_FocusDistance
                    )
                    ),
                CED.Group(
                    CameraUI.PhysicalCamera.Styles.apertureShape,
                    GroupOption.Indent,
                    CED.Group(
                        GroupOption.Indent,
                        CameraUI.PhysicalCamera.Drawer_PhysicalCamera_ApertureShape
                    )
                )
            */
            );

        #endregion end of  Sec2 投影矩阵

        #region Sec3 渲染选项
        static CED.IDrawer Draw_Rendering;
        static CED.IDrawer BaseCameraRenderTypeDrawer;
        static CED.IDrawer OverlayCameraRenderTypeDrawer;

        public static GUIContent Styles_rendererType = EditorGUIUtility.TrTextContent("Renderer", "The series of operations that translates code into visuals. These have different capabilities and performance characteristics.");
        public static GUIContent Styles_renderPostProcessing = EditorGUIUtility.TrTextContent("Post Processing", "Enable this to make this camera render post-processing effects.");
        public static GUIContent Styles_antialiasing = EditorGUIUtility.TrTextContent("Anti-aliasing", "The method the camera uses to smooth jagged edges.");
        public static GUIContent Styles_antialiasingQuality = EditorGUIUtility.TrTextContent("Quality", "The quality level to use for the selected anti-aliasing method.");
        public static GUIContent Styles_requireDepthTexture = EditorGUIUtility.TrTextContent("Depth Texture", "If this is enabled, the camera builds a screen-space depth texture. Note that generating the texture incurs a performance cost.");
        public static GUIContent Styles_requireOpaqueTexture = EditorGUIUtility.TrTextContent("Opaque Texture", "If this is enabled, the camera copies the rendered view so it can be accessed at a later stage in the pipeline.");
        public static GUIContent Styles_clearDepth = EditorGUIUtility.TrTextContent("Clear Depth", "If enabled, depth from the previous camera will be cleared.");
        public static GUIContent Styles_renderingShadows = EditorGUIUtility.TrTextContent("Render Shadows", "Makes this camera render shadows.");
        public static GUIContent Styles_priority = EditorGUIUtility.TrTextContent("Priority", "A camera with a higher priority is drawn on top of a camera with a lower priority [ -100, 100 ].");

        public static readonly string Styles_noRendererError = L10n.Tr("There are no valid Renderers available on the Universal Render Pipeline asset.");
        public static readonly string Styles_missingRendererWarning = L10n.Tr("The currently selected Renderer is missing from the Universal Render Pipeline asset.");
        public static readonly string Styles_disabledPostprocessing = L10n.Tr("Post Processing is currently disabled on the current Universal Render Pipeline renderer.");
        public static readonly string Styles_stopNaNsMessage = L10n.Tr("Stop NaNs has no effect on GLES2 platforms.");
        public static readonly string Styles_SMAANotSupported = L10n.Tr("Sub-pixel Morphological Anti-Aliasing isn't supported on GLES2 platforms.");
        public static readonly string Styles_selectRenderPipelineAsset = L10n.Tr("Select Render Pipeline Asset");

        public static readonly GUIContent Styles_header = EditorGUIUtility.TrTextContent("Rendering", "These settings control for the specific rendering features for this camera.");
        public static readonly GUIContent Styles_antialiasing_2 = EditorGUIUtility.TrTextContent("Post Anti-aliasing", "The postprocess anti-aliasing method to use.");
        public static readonly GUIContent Styles_dithering = EditorGUIUtility.TrTextContent("Dithering", "Applies 8-bit dithering to the final render to reduce color banding.");
        public static readonly GUIContent Styles_stopNaNs = EditorGUIUtility.TrTextContent("Stop NaNs", "Automatically replaces NaN/Inf in shaders by a black pixel to avoid breaking some effects. This will slightly affect performances and should only be used if you experience NaN issues that you can't fix.");
        public static readonly GUIContent Styles_cullingMask = EditorGUIUtility.TrTextContent("Culling Mask");
        public static readonly GUIContent Styles_occlusionCulling = EditorGUIUtility.TrTextContent("Occlusion Culling");
        public static readonly GUIContent Styles_renderingPath = EditorGUIUtility.TrTextContent("Custom Frame Settings", "Define the custom Frame Settings for this Camera to use.");
        public static readonly GUIContent Styles_exposureTarget = EditorGUIUtility.TrTextContent("Exposure Target", "The object used as a target for centering the Exposure's Procedural Mask metering mode when target object option is set (See Exposure Volume Component).");

        static void DrawerRenderingRenderer(SekiaPipelineSerializedCamera p, Editor owner)
        {
            var rpAsset = SekiaPipeline.Instance.asset;

            int selectedRendererOption = p.renderer.intValue;
            EditorGUI.BeginChangeCheck();

            Rect controlRect = EditorGUILayout.GetControlRect(true);
            EditorGUI.BeginProperty(controlRect, Styles_rendererType, p.renderer);

            EditorGUI.showMixedValue = p.renderer.hasMultipleDifferentValues;
            int selectedRenderer = EditorGUI.IntPopup(controlRect, Styles_rendererType, selectedRendererOption, rpAsset.rendererDisplayList, rpAsset.rendererIndexList);
            EditorGUI.EndProperty();
            if (!rpAsset.ValidateRendererDataList())
            {
                EditorGUILayout.HelpBox(Styles_noRendererError, MessageType.Error);
            }
            else if (!rpAsset.ValidateRendererData(selectedRendererOption))
            {
                EditorGUILayout.HelpBox(Styles_missingRendererWarning, MessageType.Warning);
                var rect = EditorGUI.IndentedRect(EditorGUILayout.GetControlRect());
                if (GUI.Button(rect, Styles_selectRenderPipelineAsset))
                {
                    Selection.activeObject = AssetDatabase.LoadAssetAtPath<SekiaPipelineAsset>(AssetDatabase.GetAssetPath(SekiaPipeline.Instance.asset));
                }
                GUILayout.Space(5);
            }

            if (EditorGUI.EndChangeCheck())
                p.renderer.intValue = selectedRenderer;
        }

        //AllCamera.后处理开关
        static void DrawerRenderingRenderPostProcessing(SekiaPipelineSerializedCamera p, Editor owner)
        {
            EditorGUILayout.PropertyField(p.renderPostProcessing, Styles_renderPostProcessing);
        }

        //BaseCamera.抗锯齿模型
        static void DrawerRenderingAntialiasing(SekiaPipelineSerializedCamera p, Editor owner)
        {
            Rect antiAliasingRect = EditorGUILayout.GetControlRect();
            EditorGUI.BeginProperty(antiAliasingRect, Styles_antialiasing, p.antialiasing);
            {
                EditorGUI.BeginChangeCheck();
                int selectedValue = (int)(AntialiasingMode)EditorGUI.EnumPopup(antiAliasingRect, Styles_antialiasing, (AntialiasingMode)p.antialiasing.intValue);
                if (EditorGUI.EndChangeCheck())
                    p.antialiasing.intValue = selectedValue;
            }
            EditorGUI.EndProperty();
        }

        //BaseCamera.抗锯齿.SMAA等级
        static void DrawerRenderingSMAAQuality(SekiaPipelineSerializedCamera p, Editor owner)
        {
            EditorGUILayout.PropertyField(p.antialiasingQuality, Styles_antialiasingQuality);

            if (CoreEditorUtils.buildTargets.Contains(GraphicsDeviceType.OpenGLES2))
                EditorGUILayout.HelpBox(Styles_SMAANotSupported, MessageType.Warning);
        }

        //BaseCamera.StopNaNs
        static void Drawer_Rendering_StopNaNs(ISerializedCamera p, Editor owner)
        {
            EditorGUILayout.PropertyField(p.stopNaNs, Styles_stopNaNs);
        }

        //BaseCamera.Dithering
        static void Drawer_Rendering_Dithering(ISerializedCamera p, Editor owner)
        {
            EditorGUILayout.PropertyField(p.dithering, Styles_dithering);
        }

        //AllCamera.CullingMask
        static void Drawer_Rendering_CullingMask(ISerializedCamera p, Editor owner)
        {
            EditorGUILayout.PropertyField(p.baseCameraSettings.cullingMask, Styles_cullingMask);
        }

        //AllCamera.OcclusionCulling
        static void Drawer_Rendering_OcclusionCulling(ISerializedCamera p, Editor owner)
        {
            EditorGUILayout.PropertyField(p.baseCameraSettings.occlusionCulling, Styles_occlusionCulling);
        }

        //OverlayCamera.ClearDepth
        static void DrawerRenderingClearDepth(SekiaPipelineSerializedCamera p, Editor owner)
        {
            EditorGUILayout.PropertyField(p.clearDepth, Styles_clearDepth);
        }

        //AllCamera.RenderShadows
        static void DrawerRenderingRenderShadows(SekiaPipelineSerializedCamera p, Editor owner)
        {
            EditorGUILayout.PropertyField(p.renderShadows, Styles_renderingShadows);
        }

        //BaseCamera.Priority
        static void DrawerRenderingPriority(SekiaPipelineSerializedCamera p, Editor owner)
        {
            EditorGUILayout.PropertyField(p.baseCameraSettings.depth, Styles_priority);
        }

        //AllCamera.DepthTexture
        static void DrawerRenderingDepthTexture(SekiaPipelineSerializedCamera p, Editor owner)
        {
            EditorGUILayout.PropertyField(p.renderDepth, Styles_requireDepthTexture);
        }

        //BaseCamera.OpaqueTexture
        static void DrawerRenderingOpaqueTexture(SekiaPipelineSerializedCamera p, Editor owner)
        {
            EditorGUILayout.PropertyField(p.renderOpaque, Styles_requireOpaqueTexture);
        }
        #endregion //end of Sec3 渲染选项

        #region Sec4 StackSettings
        public static GUIContent Styles_cameraType = EditorGUIUtility.TrTextContent("Render Type", "Defines if a camera renders directly to a target or overlays on top of another camera’s output. Overlay option is not available when Deferred Render Data is in use.");
        public static readonly string Styles_pixelPerfectInfo = L10n.Tr("Projection settings have been overriden by the Pixel Perfect Camera.");

        // Stack cameras
        public static GUIContent Styles_stackSettingsText = EditorGUIUtility.TrTextContent("Stack", "The list of overlay cameras assigned to this camera.");
        public static GUIContent Styles_cameras = EditorGUIUtility.TrTextContent("Cameras", "The list of overlay cameras assigned to this camera.");
        public static string Styles_inspectorOverlayCameraText = L10n.Tr("Inspector Overlay Camera");

        public static readonly CED.IDrawer SectionStackSettings =
            CED.Conditional(
                (serialized, editor) => (CameraRenderType)serialized.cameraType.intValue == CameraRenderType.Base,
                CED.FoldoutGroup(Styles_stackSettingsText, Expandable.Stack, k_ExpandedState, FoldoutOption.Indent, CED.Group(DrawerStackCameras)));

        static void DrawerStackCameras(SekiaPipelineSerializedCamera p, Editor owner)
        {
            if (owner is SekiaCameraDataEditor cameraEditor)
            {
                cameraEditor.DrawStackSettings();
            }
        }

        void DrawStackSettings()
        {
            if (m_SerializedCamera.cameras.hasMultipleDifferentValues)
            {
                EditorGUILayout.HelpBox("Cannot multi edit stack of multiple cameras.", MessageType.Info);
                EditorGUILayout.EndFoldoutHeaderGroup();
                return;
            }

            EditorGUILayout.Space();

            m_LayerList.DoLayoutList();
            m_SerializedCamera.Apply();

            EditorGUI.indentLevel--;

            bool oldRichTextSupport = EditorStyles.helpBox.richText;
            EditorStyles.helpBox.richText = true;

            if (selectedCameraInStack != null)
            {
                if (m_IncompatibleCameras.Any())
                {
                    if (m_IncompatibleCameras.Contains(selectedCameraInStack))
                    {
                        var message = "This camera does not use the same type of renderer as the Base camera.";
                        EditorGUILayout.HelpBox(message, MessageType.Error);
                    }
                }

                if (m_NotSupportedOverlayCameras.Any())
                {
                    if (m_NotSupportedOverlayCameras.Contains(selectedCameraInStack))
                    {
                        var message = "This camera uses a renderer which does not support Overlays in it's current state.";
                        EditorGUILayout.HelpBox(message, MessageType.Error);
                    }
                }

                if (m_TypeErrorCameras.Any())
                {
                    if (m_TypeErrorCameras.Contains(selectedCameraInStack))
                    {
                        var message = "The type of this Camera must be Overlay render type.";
                        CoreEditorUtils.DrawFixMeBox(message, MessageType.Error, UpdateStackCameraToOverlay);
                    }
                }

                if (m_OutputWarningCameras.Any())
                {
                    var camIndex = m_OutputWarningCameras.FindIndex(c => c.Item1 == selectedCameraInStack);
                    if (camIndex != -1)
                    {
                        var message = "The output properties of this Camera do not match the output properties.";
                        if ((CameraRenderType)m_OutputWarningCameras[camIndex].Item2.cameraType.intValue == CameraRenderType.Base)
                        {
                            EditorGUILayout.HelpBox(message, MessageType.Warning);
                        }
                        else
                        {
                            CoreEditorUtils.DrawFixMeBox(message, MessageType.Warning,
                                () => UpdateStackCameraOutput(m_OutputWarningCameras[camIndex].Item1, m_OutputWarningCameras[camIndex].Item2));
                        }
                    }
                }
            }

            EditorStyles.helpBox.richText = oldRichTextSupport;
            EditorGUI.indentLevel++;

            EditorGUILayout.Space();

        }

        private bool IsStackCameraOutputDirty(Camera cam, SekiaPipelineSerializedCamera serializedCamera)
        {
            var settings = serializedCamera.baseCameraSettings;

            serializedCamera.Update();

            // Force same render texture
            RenderTexture targetTexture = settings.targetTexture.objectReferenceValue as RenderTexture;
            if (cam.targetTexture != targetTexture)
                return true;

            // Force same hdr
            bool allowHDR = settings.HDR.boolValue;
            if (cam.allowHDR != allowHDR)
                return true;

            // Force same mssa
            bool allowMSSA = settings.allowMSAA.boolValue;
            if (cam.allowMSAA != allowMSSA)
                return true;

            // Force same viewport rect
            Rect rect = settings.normalizedViewPortRect.rectValue;
            if (cam.rect != rect)
                return true;

            // Force same dynamic resolution
            bool allowDynamicResolution = settings.allowDynamicResolution.boolValue;
            if (serializedCamera.allowDynamicResolution.boolValue != allowDynamicResolution)
                return true;

            // Force same target display
            int targetDisplay = settings.targetDisplay.intValue;
            if (cam.targetDisplay != targetDisplay)
                return true;

            return false;
        }

        private void UpdateStackCameraOutput(Camera cam, SekiaPipelineSerializedCamera serializedCamera)
        {
            if ((CameraRenderType)serializedCamera.cameraType.intValue == CameraRenderType.Base)
                return;

            serializedCamera.Update();
            Undo.RecordObject(_brother, Styles_inspectorOverlayCameraText);

            bool isChanged = false;
            var settings = serializedCamera.baseCameraSettings;

            // Force same render texture
            RenderTexture targetTexture = settings.targetTexture.objectReferenceValue as RenderTexture;
            if (cam.targetTexture != targetTexture)
            {
                cam.targetTexture = targetTexture;
                isChanged = true;
            }

            // Force same hdr
            bool allowHDR = settings.HDR.boolValue;
            if (cam.allowHDR != allowHDR)
            {
                cam.allowHDR = allowHDR;
                isChanged = true;
            }

            // Force same mssa
            bool allowMSSA = settings.allowMSAA.boolValue;
            if (cam.allowMSAA != allowMSSA)
            {
                cam.allowMSAA = allowMSSA;
                isChanged = true;
            }

            // Force same viewport rect
            Rect rect = settings.normalizedViewPortRect.rectValue;
            if (cam.rect != rect)
            {
                cam.rect = settings.normalizedViewPortRect.rectValue;
                isChanged = true;
            }

            // Force same dynamic resolution
            bool allowDynamicResolution = settings.allowDynamicResolution.boolValue;
            if (serializedCamera.allowDynamicResolution.boolValue != allowDynamicResolution)
            {
                cam.allowDynamicResolution = allowDynamicResolution;
                isChanged = true;
            }

            // Force same target display
            int targetDisplay = settings.targetDisplay.intValue;
            if (cam.targetDisplay != targetDisplay)
            {
                cam.targetDisplay = targetDisplay;
                isChanged = true;
            }

            if (isChanged)
            {
                EditorUtility.SetDirty(cam);
                serializedCamera.Apply();
            }
        }

        private void UpdateStackCameraToOverlay()
        {
            var additionalCameraData = selectedCameraInStack.GetUniversalAdditionalCameraData();
            if (additionalCameraData == null)
                return;

            if (additionalCameraData.renderType == CameraRenderType.Base)
            {
                Undo.RecordObject(additionalCameraData, Styles_inspectorOverlayCameraText);
                additionalCameraData.renderType = CameraRenderType.Overlay;
                EditorUtility.SetDirty(additionalCameraData);
            }
        }
        #endregion //

        #region Sec5 Environment
        static CED.IDrawer Drawer_Environment;

        internal enum BackgroundType
        {
            Skybox = 0,
            SolidColor,
            [InspectorName("Uninitialized")]
            DontCare,
        }

        public static GUIContent Styles_backgroundType = EditorGUIUtility.TrTextContent("Background Type", "Controls how to initialize the Camera's background.\n\nSkybox initializes camera with Skybox, defaulting to a background color if no skybox is found.\n\nSolid Color initializes background with the background color.\n\nUninitialized has undefined values for the camera background. Use this only if you are rendering all pixels in the Camera's view.");
        public static GUIContent Styles_volumesSettingsText = EditorGUIUtility.TrTextContent("Volumes", "These settings define how Volumes affect this Camera.");
        public static GUIContent Styles_volumeTrigger = EditorGUIUtility.TrTextContent("Volume Trigger", "A transform that will act as a trigger for volume blending. If none is set, the camera itself will act as a trigger.");
        public static GUIContent Styles_volumeUpdates = EditorGUIUtility.TrTextContent("Update Mode", "Select how Unity updates Volumes: every frame or when triggered via scripting. In the Editor, Unity updates Volumes every frame when not in the Play mode.");

        static BackgroundType GetBackgroundType(CameraClearFlags clearFlags)
        {
            switch (clearFlags)
            {
                case CameraClearFlags.Skybox:
                    return BackgroundType.Skybox;
                case CameraClearFlags.Nothing:
                    return BackgroundType.DontCare;

                // DepthOnly is not supported by design in UniversalRP. We upgrade it to SolidColor
                default:
                    return BackgroundType.SolidColor;
            }
        }

        static void Drawer_Environment_ClearFlags(SekiaPipelineSerializedCamera p, Editor owner)
        {
            EditorGUI.showMixedValue = p.baseCameraSettings.clearFlags.hasMultipleDifferentValues;

            Rect clearFlagsRect = EditorGUILayout.GetControlRect();
            EditorGUI.BeginProperty(clearFlagsRect, Styles_backgroundType, p.baseCameraSettings.clearFlags);
            {
                EditorGUI.BeginChangeCheck();
                BackgroundType backgroundType = GetBackgroundType((CameraClearFlags)p.baseCameraSettings.clearFlags.intValue);
                var selectedValue = (BackgroundType)EditorGUI.EnumPopup(clearFlagsRect, Styles_backgroundType, backgroundType);
                if (EditorGUI.EndChangeCheck())
                {
                    CameraClearFlags selectedClearFlags;
                    switch (selectedValue)
                    {
                        case BackgroundType.Skybox:
                            selectedClearFlags = CameraClearFlags.Skybox;
                            break;

                        case BackgroundType.DontCare:
                            selectedClearFlags = CameraClearFlags.Nothing;
                            break;

                        default:
                            selectedClearFlags = CameraClearFlags.SolidColor;
                            break;
                    }

                    p.baseCameraSettings.clearFlags.intValue = (int)selectedClearFlags;
                }

                if (!p.baseCameraSettings.clearFlags.hasMultipleDifferentValues)
                {
                    if (GetBackgroundType((CameraClearFlags)p.baseCameraSettings.clearFlags.intValue) == BackgroundType.SolidColor)
                    {
                        using (var group = new EditorGUI.IndentLevelScope())
                        {
                            p.baseCameraSettings.DrawBackgroundColor();
                        }
                    }
                }
            }
            EditorGUI.EndProperty();
            EditorGUI.showMixedValue = false;
        }

        static void Drawer_Environment_VolumeUpdate(SekiaPipelineSerializedCamera p, Editor owner)
        {
            EditorGUI.BeginChangeCheck();
            VolumeFrameworkUpdateMode prevVolumeUpdateMode = (VolumeFrameworkUpdateMode)p.volumeFrameworkUpdateMode.intValue;
            EditorGUILayout.PropertyField(p.volumeFrameworkUpdateMode, Styles_volumeUpdates);
            if (EditorGUI.EndChangeCheck())
            {
                if (p.serializedObject.targetObject is not Camera cam)
                    return;

                VolumeFrameworkUpdateMode curVolumeUpdateMode = (VolumeFrameworkUpdateMode)p.volumeFrameworkUpdateMode.intValue;
                cam.SetVolumeFrameworkUpdateMode(curVolumeUpdateMode);
            }
        }

        static void Drawer_Environment_VolumeTrigger(SekiaPipelineSerializedCamera p, Editor owner)
        {
            var controlRect = EditorGUILayout.GetControlRect(true);
            EditorGUI.BeginProperty(controlRect, Styles_volumeTrigger, p.volumeTrigger);
            {
                EditorGUI.BeginChangeCheck();
                var newValue = EditorGUI.ObjectField(controlRect, Styles_volumeTrigger, (Transform)p.volumeTrigger.objectReferenceValue, typeof(Transform), true);
                if (EditorGUI.EndChangeCheck() && !Equals(p.volumeTrigger.objectReferenceValue, newValue))
                    p.volumeTrigger.objectReferenceValue = newValue;
            }
            EditorGUI.EndProperty();
        }
        #endregion end of Sec5 Environment

        #region Sec6 Output
        static CED.IDrawer Drawer_Output;

        public static GUIContent[] Styles_displayedCameraOptions =
                {
                    EditorGUIUtility.TrTextContent("Off"),
                    EditorGUIUtility.TrTextContent("Use settings from Render Pipeline Asset"),
                };

        public static int[] Styles_cameraOptions = { 0, 1 };

        public static readonly GUIContent Styles_targetTextureLabel = EditorGUIUtility.TrTextContent("Output Texture", "The texture to render this camera into, if none then this camera renders to screen.");

        public static GUIContent Styles_allowMSAA = EditorGUIUtility.TrTextContent("MSAA", "Enables Multi-Sample Anti-Aliasing, a technique that smooths jagged edges.");
        public static GUIContent Styles_allowHDR = EditorGUIUtility.TrTextContent("HDR", "High Dynamic Range gives you a wider range of light intensities, so your lighting looks more realistic. With it, you can still see details and experience less saturation even with bright light.", (Texture)null);

        public static string Styles_cameraTargetTextureMSAA = L10n.Tr("Camera target texture requires {0}x MSAA. Universal pipeline {1}.");
        public static string Styles_pipelineMSAACapsSupportSamples = L10n.Tr("is set to support {0}x");
        public static string Styles_pipelineMSAACapsDisabled = L10n.Tr("has MSAA disabled");

        static void DrawerOutputMultiDisplay(SekiaPipelineSerializedCamera p, Editor owner)
        {
            using (var checkScope = new EditorGUI.ChangeCheckScope())
            {
                p.baseCameraSettings.DrawMultiDisplay();
                if (checkScope.changed)
                {
                    UpdateStackCamerasOutput(p, camera =>
                    {
                        bool isChanged = false;
                        // Force same target display
                        int targetDisplay = p.baseCameraSettings.targetDisplay.intValue;
                        if (camera.targetDisplay != targetDisplay)
                        {
                            camera.targetDisplay = targetDisplay;
                            isChanged = true;
                        }

                        // Force same target display
                        StereoTargetEyeMask stereoTargetEye = (StereoTargetEyeMask)p.baseCameraSettings.targetEye.intValue;
                        if (camera.stereoTargetEye != stereoTargetEye)
                        {
                            camera.stereoTargetEye = stereoTargetEye;
                            isChanged = true;
                        }

                        return isChanged;
                    });
                }
            }
        }

        static void DrawerOutputAllowDynamicResolution(SekiaPipelineSerializedCamera p, Editor owner)
        {
            using (var checkScope = new EditorGUI.ChangeCheckScope())
            {
                CameraUI.Output.Drawer_Output_AllowDynamicResolution(p, owner);
                if (checkScope.changed)
                {
                    UpdateStackCamerasOutput(p, camera =>
                    {
                        bool allowDynamicResolution = p.allowDynamicResolution.boolValue;

                        if (camera.allowDynamicResolution == p.allowDynamicResolution.boolValue)
                            return false;

                        EditorUtility.SetDirty(camera);

                        camera.allowDynamicResolution = allowDynamicResolution;
                        return true;
                    });
                }
            }
        }

        static void DrawerOutputNormalizedViewPort(SekiaPipelineSerializedCamera p, Editor owner)
        {
            using (var checkScope = new EditorGUI.ChangeCheckScope())
            {
                CameraUI.Output.Drawer_Output_NormalizedViewPort(p, owner);
                if (checkScope.changed)
                {
                    UpdateStackCamerasOutput(p, camera =>
                    {
                        Rect rect = p.baseCameraSettings.normalizedViewPortRect.rectValue;
                        if (camera.rect != rect)
                        {
                            camera.rect = p.baseCameraSettings.normalizedViewPortRect.rectValue;
                            return true;
                        }

                        return false;
                    });
                }
            }
        }

        static void UpdateStackCamerasOutput(SekiaPipelineSerializedCamera p, Func<Camera, bool> updateOutputProperty)
        {
            int cameraCount = p.cameras.arraySize;
            for (int i = 0; i < cameraCount; ++i)
            {
                SerializedProperty cameraProperty = p.cameras.GetArrayElementAtIndex(i);
                Camera overlayCamera = cameraProperty.objectReferenceValue as Camera;
                if (overlayCamera != null)
                {
                    Undo.RecordObject(overlayCamera, Styles_inspectorOverlayCameraText);
                    if (updateOutputProperty(overlayCamera))
                        EditorUtility.SetDirty(overlayCamera);
                }
            }
        }

        static void DrawerOutputTargetTexture(SekiaPipelineSerializedCamera p, Editor owner)
        {
            var rpAsset = UniversalRenderPipeline.asset;
            using (var checkScope = new EditorGUI.ChangeCheckScope())
            {
                EditorGUILayout.PropertyField(p.baseCameraSettings.targetTexture, Styles_targetTextureLabel);

                var texture = p.baseCameraSettings.targetTexture.objectReferenceValue as RenderTexture;
                if (!p.baseCameraSettings.targetTexture.hasMultipleDifferentValues && rpAsset != null)
                {
                    int pipelineSamplesCount = rpAsset.msaaSampleCount;

                    if (texture && texture.antiAliasing > pipelineSamplesCount)
                    {
                        string pipelineMSAACaps = (pipelineSamplesCount > 1) ? string.Format(Styles_pipelineMSAACapsSupportSamples, pipelineSamplesCount) : Styles_pipelineMSAACapsDisabled;
                        EditorGUILayout.HelpBox(string.Format(Styles_cameraTargetTextureMSAA, texture.antiAliasing, pipelineMSAACaps), MessageType.Warning, true);
                    }
                }

                if (checkScope.changed)
                {
                    UpdateStackCamerasOutput(p, camera =>
                    {
                        if (camera.targetTexture == texture)
                            return false;

                        camera.targetTexture = texture;
                        return true;
                    });
                }
            }
        }

        static void DrawerOutputHDR(SekiaPipelineSerializedCamera p, Editor owner)
        {
            Rect controlRect = EditorGUILayout.GetControlRect(true);
            EditorGUI.BeginProperty(controlRect, Styles_allowHDR, p.baseCameraSettings.HDR);
            {
                using (var checkScope = new EditorGUI.ChangeCheckScope())
                {
                    int selectedValue = !p.baseCameraSettings.HDR.boolValue ? 0 : 1;
                    var allowHDR = EditorGUI.IntPopup(controlRect, Styles_allowHDR, selectedValue, Styles_displayedCameraOptions, Styles_cameraOptions) == 1;
                    if (checkScope.changed)
                    {
                        p.baseCameraSettings.HDR.boolValue = allowHDR;
                        UpdateStackCamerasOutput(p, camera =>
                        {
                            if (camera.allowHDR == allowHDR)
                                return false;

                            camera.allowHDR = allowHDR;
                            return true;
                        });
                    }
                }
            }
            EditorGUI.EndProperty();
        }

        static void DrawerOutputMSAA(SekiaPipelineSerializedCamera p, Editor owner)
        {
            Rect controlRect = EditorGUILayout.GetControlRect(true);
            EditorGUI.BeginProperty(controlRect, Styles_allowMSAA, p.baseCameraSettings.allowMSAA);
            {
                using (var checkScope = new EditorGUI.ChangeCheckScope())
                {
                    int selectedValue = !p.baseCameraSettings.allowMSAA.boolValue ? 0 : 1;
                    var allowMSAA = EditorGUI.IntPopup(controlRect, Styles_allowMSAA,
                        selectedValue, Styles_displayedCameraOptions, Styles_cameraOptions) == 1;
                    if (checkScope.changed)
                    {
                        p.baseCameraSettings.allowMSAA.boolValue = allowMSAA;
                        UpdateStackCamerasOutput(p, camera =>
                        {
                            if (camera.allowMSAA == allowMSAA)
                                return false;

                            camera.allowMSAA = allowMSAA;
                            return true;
                        });
                    }
                }
            }
            EditorGUI.EndProperty();
        }
        #endregion end of Sec6 Output

        #endregion //end of All Drawer
    }
}
