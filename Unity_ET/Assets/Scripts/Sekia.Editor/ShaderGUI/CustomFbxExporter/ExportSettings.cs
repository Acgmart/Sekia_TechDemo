using UnityEngine;
using System.Collections.Generic;
using System.Linq;
using Autodesk.Fbx;
using UnityEngine.Animations;
using System;

namespace UnityEditor.CustomFbxExporter
{
    [CustomEditor(typeof(ExportSettings))]
    internal class ExportSettingsEditor : UnityEditor.Editor
    {
        Vector2 scrollPos = Vector2.zero;
        const float LabelWidth = 180;

        private void OnEnable()
        {
        }

        public override void OnInspectorGUI()
        {
            EditorGUIUtility.labelWidth = LabelWidth;
            scrollPos = GUILayout.BeginScrollView(scrollPos);
            GUILayout.BeginVertical();
            EditorGUILayout.Space();

            EditorGUI.BeginChangeCheck();
            EditorGUILayout.PropertyField(serializedObject.FindProperty("modelAnimIncludeOption"), new GUIContent("导出内容"), true);
            EditorGUILayout.PropertyField(serializedObject.FindProperty("exportFormat"), new GUIContent("导出格式"), true);
            EditorGUILayout.PropertyField(serializedObject.FindProperty("preserveImportSettings"), new GUIContent("保留导入设置"), true);
            EditorGUILayout.PropertyField(serializedObject.FindProperty("mayaCompatibleNaming"),
                new GUIContent("命名规则兼容", "In Maya some symbols such as spaces and accents get replaced when importing an FBX\n" +
                "   e.g. \"foo bar\" becomes \"fooFBXASC032bar\" \n" +
                "Convert the names of GameObjects so they are Maya compatible"), true);
            EditorGUILayout.PropertyField(serializedObject.FindProperty("keepInstances"),
                new GUIContent("复用资源", "开启后 如果一个资源有多个实例 将只打包一次，如果不同实例的材质球不一样就会出现问题"), true);
            EditorGUILayout.PropertyField(serializedObject.FindProperty("animatedSkinnedMesh"), new GUIContent("导出蒙皮动作"), true);
            EditorGUILayout.PropertyField(serializedObject.FindProperty("exportUnrendered"), new GUIContent("导出未启用物体"), true);
            EditorGUILayout.PropertyField(serializedObject.FindProperty("objectSpace"), new GUIContent("坐标系"), true);
            EditorGUILayout.PropertyField(serializedObject.FindProperty("fbxChannels"), new GUIContent("选择通道数据"), true);
            EditorGUILayout.PropertyField(serializedObject.FindProperty("showDebugInfo"), new GUIContent("显示调试日志"), true);
            if (EditorGUI.EndChangeCheck())
                serializedObject.ApplyModifiedProperties();

            EditorGUILayout.Space();
            GUILayout.EndVertical();
            GUILayout.EndScrollView();
        }
    }

    #region 类型定义
    [Flags]
    public enum FbxChannels
    {
        Normal = 0x01,
        Tangent = 0x02,
        Binormal = 0x04,
        VertexColor = 0x08,
    }

    ///<summary>
    ///Information about the mesh that is important for exporting.
    ///</summary>
    public class MeshInfo
    {
        public Mesh mesh;

        /// <summary>
        /// Return true if there's a valid mesh information
        /// </summary>
        public bool IsValid { get { return mesh; } }

        /// <summary>
        /// Gets the vertex count.
        /// </summary>
        /// <value>The vertex count.</value>
        public int VertexCount { get { return mesh.vertexCount; } }

        /// <summary>
        /// Gets the triangles. Each triangle is represented as 3 indices from the vertices array.
        /// Ex: if triangles = [3,4,2], then we have one triangle with vertices vertices[3], vertices[4], and vertices[2]
        /// </summary>
        /// <value>The triangles.</value>
        private int[] m_triangles;
        public int[] Triangles
        {
            get
            {
                if (m_triangles == null) { m_triangles = mesh.triangles; }
                return m_triangles;
            }
        }

        /// <summary>
        /// Gets the vertices, represented in local coordinates.
        /// </summary>
        /// <value>The vertices.</value>
        private Vector3[] m_vertices;
        public Vector3[] Vertices
        {
            get
            {
                if (m_vertices == null) { m_vertices = mesh.vertices; }
                return m_vertices;
            }
        }

        /// <summary>
        /// Gets the normals for the vertices.
        /// </summary>
        /// <value>The normals.</value>
        private Vector3[] m_normals;
        public Vector3[] Normals
        {
            get
            {
                if (m_normals == null)
                {
                    m_normals = mesh.normals;
                }
                return m_normals;
            }
        }

        /// <summary>
        /// Gets the binormals for the vertices.
        /// </summary>
        /// <value>The normals.</value>
        private Vector3[] m_Binormals;

        public Vector3[] Binormals
        {
            get
            {
                /// NOTE: LINQ
                ///    return mesh.normals.Zip (mesh.tangents, (first, second)
                ///    => Math.cross (normal, tangent.xyz) * tangent.w
                if (m_Binormals == null || m_Binormals.Length == 0)
                {
                    var normals = Normals;
                    var tangents = Tangents;

                    if (HasValidNormals() && HasValidTangents())
                    {
                        m_Binormals = new Vector3[normals.Length];

                        for (int i = 0; i < normals.Length; i++)
                            m_Binormals[i] = Vector3.Cross(normals[i],
                                tangents[i])
                            * tangents[i].w;
                    }
                }
                return m_Binormals;
            }
        }

        /// <summary>
        /// Gets the tangents for the vertices.
        /// </summary>
        /// <value>The tangents.</value>
        private Vector4[] m_tangents;
        public Vector4[] Tangents
        {
            get
            {
                if (m_tangents == null)
                {
                    m_tangents = mesh.tangents;
                }
                return m_tangents;
            }
        }

        /// <summary>
        /// Gets the vertex colors for the vertices.
        /// </summary>
        /// <value>The vertex colors.</value>
        private Color32[] m_vertexColors;
        public Color32[] VertexColors
        {
            get
            {
                if (m_vertexColors == null)
                {
                    m_vertexColors = mesh.colors32;
                }
                return m_vertexColors;
            }
        }

        /// <summary>
        /// Gets the uvs.
        /// </summary>
        /// <value>The uv.</value>
        private Vector2[] m_UVs;
        public Vector2[] UV
        {
            get
            {
                if (m_UVs == null)
                {
                    m_UVs = mesh.uv;
                }
                return m_UVs;
            }
        }

        /// <summary>
        /// The material(s) used.
        /// Always at least one.
        /// None are missing materials (we replace missing materials with the default material).
        /// </summary>
        public Material[] Materials { get; private set; }


        static Material s_defaultMaterial = null;
        public static Material DefaultMaterial
        {
            get
            {
                if (!s_defaultMaterial)
                {
                    var obj = GameObject.CreatePrimitive(PrimitiveType.Quad);
                    s_defaultMaterial = obj.GetComponent<Renderer>().sharedMaterial;
                    UnityEngine.Object.DestroyImmediate(obj);
                }
                return s_defaultMaterial;
            }
        }

        public static FbxQuaternion EulerToQuaternionXYZ(FbxVector4 euler)
        {
            FbxAMatrix m = new FbxAMatrix();
            m.SetR(euler);
            return m.GetQ();
        }

        public static FbxQuaternion EulerToQuaternionZXY(Vector3 euler)
        {
            var unityQuat = Quaternion.Euler(euler);
            return new FbxQuaternion(unityQuat.x, unityQuat.y, unityQuat.z, unityQuat.w);
        }


        //Unity is left-handed, Maya and Max are right-handed.
        public static FbxVector4 ConvertToFbxVector4(Vector3 leftHandedVector, float unitScale = 1f)
        {
            // negating the x component of the vector converts it from left to right handed coordinates
            return unitScale * new FbxVector4(
                leftHandedVector[0],
                leftHandedVector[1],
                leftHandedVector[2]);
        }

        /// <summary>
        /// Return set of sample times to cover all keys on animation curves
        /// </summary> 
        public static HashSet<float> GetSampleTimes(AnimationCurve[] animCurves, double sampleRate)
        {
            var keyTimes = new HashSet<float>();
            double fs = 1.0 / sampleRate;

            double firstTime = double.MaxValue, lastTime = double.MinValue;

            foreach (var ac in animCurves)
            {
                if (ac == null || ac.length <= 0) continue;

                firstTime = System.Math.Min(firstTime, ac[0].time);
                lastTime = System.Math.Max(lastTime, ac[ac.length - 1].time);
            }

            // if these values didn't get set there were no valid anim curves,
            // so don't return any keys
            if (firstTime == double.MaxValue || lastTime == double.MinValue)
            {
                return keyTimes;
            }

            int firstframe = (int)System.Math.Floor(firstTime * sampleRate);
            int lastframe = (int)System.Math.Ceiling(lastTime * sampleRate);
            for (int i = firstframe; i <= lastframe; i++)
            {
                keyTimes.Add((float)(i * fs));
            }

            return keyTimes;
        }

        /// <summary>
        /// Set up the MeshInfo with the given mesh and materials.
        /// </summary>
        public MeshInfo(Mesh mesh, Material[] materials)
        {
            this.mesh = mesh;

            this.m_Binormals = null;
            this.m_vertices = null;
            this.m_triangles = null;
            this.m_normals = null;
            this.m_UVs = null;
            this.m_vertexColors = null;
            this.m_tangents = null;

            if (materials == null)
            {
                this.Materials = new Material[] { DefaultMaterial };
            }
            else
            {
                this.Materials = materials.Select(mat => mat ? mat : DefaultMaterial).ToArray();
                if (this.Materials.Length == 0)
                {
                    this.Materials = new Material[] { DefaultMaterial };
                }
            }
        }

        public bool HasValidNormals()
        {
            return Normals != null && Normals.Length > 0;
        }

        public bool HasValidBinormals()
        {
            return HasValidNormals() &&
                HasValidTangents() &&
                Binormals != null;
        }

        public bool HasValidTangents()
        {
            return Tangents != null && Tangents.Length > 0;
        }

        public bool HasValidVertexColors()
        {
            return VertexColors != null && VertexColors.Length > 0;
        }
    }

    delegate bool ExportConstraintDelegate(IConstraint c, FbxScene fs, FbxNode fn);

    public struct ExpConstraintSource
    {
        private FbxNode m_node;
        public FbxNode node
        {
            get { return m_node; }
            set { m_node = value; }
        }

        private float m_weight;
        public float weight
        {
            get { return m_weight; }
            set { m_weight = value; }
        }

        public ExpConstraintSource(FbxNode node, float weight)
        {
            this.m_node = node;
            this.m_weight = weight;
        }
    }

    /// <summary>
    /// Which components map from Unity Object to Fbx Object
    /// </summary>
    public enum FbxNodeRelationType
    {
        NodeAttribute,
        Property,
        Material
    }

    public class SkinnedMeshBoneInfo
    {
        public SkinnedMeshRenderer skinnedMesh;
        public Dictionary<Transform, int> boneDict;
        public Dictionary<Transform, Matrix4x4> boneToBindPose;

        public SkinnedMeshBoneInfo(SkinnedMeshRenderer skinnedMesh, Dictionary<Transform, int> boneDict)
        {
            this.skinnedMesh = skinnedMesh;
            this.boneDict = boneDict;
            this.boneToBindPose = new Dictionary<Transform, Matrix4x4>();
        }
    }

    public enum TransformExportType { Local, Global };

    public class UnityToMayaConvertSceneHelper
    {
        bool convertDistance = false;
        bool convertToRadian = false;
        bool convertLensShiftX = false;
        bool convertLensShiftY = false;

        FbxCamera camera = null;

        float unitScaleFactor = 1f;

        public UnityToMayaConvertSceneHelper(string uniPropertyName, FbxNode fbxNode, float UnitScaleFactor)
        {
            System.StringComparison cc = System.StringComparison.CurrentCulture;

            bool partT = uniPropertyName.StartsWith("m_LocalPosition.", cc) || uniPropertyName.StartsWith("m_TranslationOffset", cc);

            convertDistance |= partT;
            convertDistance |= uniPropertyName.StartsWith("m_Intensity", cc);
            convertDistance |= uniPropertyName.ToLower().EndsWith("weight", cc);
            convertLensShiftX |= uniPropertyName.StartsWith("m_LensShift.x", cc);
            convertLensShiftY |= uniPropertyName.StartsWith("m_LensShift.y", cc);
            if (convertLensShiftX || convertLensShiftY)
            {
                camera = fbxNode.GetCamera();
            }

            // The ParentConstraint's source Rotation Offsets are read in as radians, so make sure they are exported as radians
            convertToRadian = uniPropertyName.StartsWith("m_RotationOffsets.Array.data", cc);

            if (convertDistance)
                unitScaleFactor = UnitScaleFactor;

            if (convertToRadian)
            {
                unitScaleFactor *= (Mathf.PI / 180);
            }
        }

        public float Convert(float value)
        {
            float convertedValue = value;
            if (convertLensShiftX || convertLensShiftY)
            {
                convertedValue = Mathf.Clamp(Mathf.Abs(value), 0f, 1f) * Mathf.Sign(value);
            }
            if (camera != null)
            {
                if (convertLensShiftX)
                {
                    convertedValue *= (float)camera.GetApertureWidth();
                }
                else if (convertLensShiftY)
                {
                    convertedValue *= (float)camera.GetApertureHeight();
                }
            }

            // left handed to right handed conversion
            // meters to centimetres conversion
            return unitScaleFactor * convertedValue;
        }

    }

    public struct UnityCurve
    {
        public string propertyName;
        public AnimationCurve uniAnimCurve;
        public System.Type propertyType;

        public UnityCurve(string propertyName, AnimationCurve uniAnimCurve, System.Type propertyType)
        {
            this.propertyName = propertyName;
            this.uniAnimCurve = uniAnimCurve;
            this.propertyType = propertyType;
        }
    }

    public enum ExportFormat { Binary = 0, ASCII = 1 }

    public enum Include { Model = 0, Anim = 1, ModelAndAnim = 2 }
    #endregion

    //[CreateAssetMenu(menuName = "TA工具/CustomFbxExporterSettings", fileName = "CustomFbxExportSettings", order = 0)]
    public class ExportSettings : ScriptableObject
    {

        //设置
        [SerializeField]
        public Include modelAnimIncludeOption = Include.ModelAndAnim;
        [SerializeField]
        public ExportFormat exportFormat = ExportFormat.Binary;
        [SerializeField]
        public bool preserveImportSettings = true;
        [SerializeField]
        public bool mayaCompatibleNaming = true;
        [SerializeField]
        public bool keepInstances = true;
        [SerializeField]
        public bool animatedSkinnedMesh = true;
        [SerializeField]
        public bool exportUnrendered = true;
        [SerializeField]
        public TransformExportType objectSpace = TransformExportType.Local;
        [SerializeField]
        public FbxChannels fbxChannels;
        [SerializeField]
        public bool showDebugInfo = false;

        //未知属性
        [SerializeField]
        public bool bakeAnimationProperty = false;
        [SerializeField]
        public Transform animationSource;
        [SerializeField]
        public Transform animationDest;
    }
}
