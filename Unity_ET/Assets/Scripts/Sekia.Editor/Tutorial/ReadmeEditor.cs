using UnityEngine;
using UnityEditor;
using System.Reflection;

namespace Sekia
{
    [CustomEditor(typeof(Readme))]
    [InitializeOnLoad] //编译会触发
    public class ReadmeEditor : Editor
    {
        static string kShowedReadmeSessionStateName = "ReadmeEditor.showedReadme";

        static float kSpace = 16f;

        static ReadmeEditor()
        {
            EditorApplication.delayCall += SelectReadmeAutomatically;
        }

        static void SelectReadmeAutomatically()
        {
            //关闭Unity重启可触发
            if (!SessionState.GetBool(kShowedReadmeSessionStateName, false))
            {
                SelectReadme();
                SessionState.SetBool(kShowedReadmeSessionStateName, true);

                //首次打开工程时触发
                if (Sekia.EditorPrefs.GetBool(Sekia.EditorPrefs._NeedLoadLayout, true))
                {
                    LoadLayout();
                    Sekia.EditorPrefs.SetBool(Sekia.EditorPrefs._NeedLoadLayout, false);
                }

                string sceneName = UnityEngine.SceneManagement.SceneManager.GetActiveScene().name;
                string sampleGuid = "e0d691ac8c1d0454ba07089ea820e18a";
                string samplePath = AssetDatabase.GUIDToAssetPath(sampleGuid);
                if (string.IsNullOrEmpty(sceneName))
                    UnityEditor.SceneManagement.EditorSceneManager.OpenScene(samplePath);
            }
        }

        //加载.wlt布局文件
        static void LoadLayout()
        {
            var assembly = typeof(EditorApplication).Assembly;
            var windowLayoutType = assembly.GetType("UnityEditor.WindowLayout", true);
            //var method = windowLayoutType.GetMethod("LoadWindowLayout", BindingFlags.Public | BindingFlags.Static);
            var methods = windowLayoutType.GetMethods(BindingFlags.Public | BindingFlags.Static);
            foreach (var method in methods)
            {
                if (method.Name == "LoadWindowLayout" && method.GetParameters().Length == 2)
                {
                    string guid = "eabc9546105bf4accac1fd62a63e88e6";
                    string assetPath = AssetDatabase.GUIDToAssetPath(guid);
                    method.Invoke(null, new object[] { assetPath, false });
                }
            }
        }

        //选中ReadMe文件
        static void SelectReadme()
        {
            var ids = AssetDatabase.FindAssets("Readme t:Readme");
            if (ids.Length == 1)
            {
                var readmeObject = AssetDatabase.LoadMainAssetAtPath(AssetDatabase.GUIDToAssetPath(ids[0]));
                Selection.objects = new UnityEngine.Object[] { readmeObject };
            }
            else
            {
                Debug.Log("Couldn't find a readme");
            }
        }

        //Inspector标题信息
        protected override void OnHeaderGUI()
        {
            var readme = (Readme)target;
            Init();

            var iconWidth = Mathf.Min(EditorGUIUtility.currentViewWidth / 3f - 20f, 128f);

            GUILayout.BeginHorizontal("In BigTitle");
            {
                GUILayout.Label(readme.icon, GUILayout.Width(iconWidth), GUILayout.Height(iconWidth));
                GUILayout.Label(readme.title, TitleStyle);
            }
            GUILayout.EndHorizontal();
        }

        public override void OnInspectorGUI()
        {
            var readme = (Readme)target;
            Init();

            foreach (var section in readme.sections)
            {
                if (!string.IsNullOrEmpty(section.heading))
                {
                    GUILayout.Label(section.heading, HeadingStyle);
                }
                if (!string.IsNullOrEmpty(section.text))
                {
                    GUILayout.Label(section.text, BodyStyle);
                }
                if (!string.IsNullOrEmpty(section.linkText))
                {
                    if (LinkLabel(new GUIContent(section.linkText)))
                    {
                        Application.OpenURL(section.url);
                    }
                }
                GUILayout.Space(kSpace);
            }
        }

        bool m_Initialized;

        GUIStyle LinkStyle { get { return m_LinkStyle; } }
        [SerializeField] GUIStyle m_LinkStyle;

        GUIStyle TitleStyle { get { return m_TitleStyle; } }
        [SerializeField] GUIStyle m_TitleStyle;

        GUIStyle HeadingStyle { get { return m_HeadingStyle; } }
        [SerializeField] GUIStyle m_HeadingStyle;

        GUIStyle BodyStyle { get { return m_BodyStyle; } }
        [SerializeField] GUIStyle m_BodyStyle;

        void Init()
        {
            if (m_Initialized)
                return;
            m_BodyStyle = new GUIStyle(EditorStyles.label);
            m_BodyStyle.wordWrap = true;
            m_BodyStyle.fontSize = 14;

            m_TitleStyle = new GUIStyle(m_BodyStyle);
            m_TitleStyle.fontSize = 26;

            m_HeadingStyle = new GUIStyle(m_BodyStyle);
            m_HeadingStyle.fontSize = 18;

            m_LinkStyle = new GUIStyle(m_BodyStyle);
            m_LinkStyle.wordWrap = false;
            // Match selection color which works nicely for both light and dark skins
            m_LinkStyle.normal.textColor = new Color(0x00 / 255f, 0x78 / 255f, 0xDA / 255f, 1f);
            m_LinkStyle.stretchWidth = false;

            m_Initialized = true;
        }

        bool LinkLabel(GUIContent label, params GUILayoutOption[] options)
        {
            var position = GUILayoutUtility.GetRect(label, LinkStyle, options);

            //下划线
            Handles.BeginGUI();
            Handles.color = LinkStyle.normal.textColor;
            Handles.DrawLine(new Vector3(position.xMin, position.yMax), new Vector3(position.xMax, position.yMax));
            Handles.color = Color.white;
            Handles.EndGUI();

            //替换鼠标样式
            EditorGUIUtility.AddCursorRect(position, MouseCursor.Link);

            return GUI.Button(position, label, LinkStyle);
        }
    }
}
