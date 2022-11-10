using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;
using System.IO;
using System.Collections;
using System.Runtime.Serialization.Formatters.Binary;
using UnityEngine.Rendering.Universal;

[CustomEditor(typeof(GrassPainter))]
[CanEditMultipleObjects]
public class GrassPainterStyle : Editor
{
    private const string NEXT_VERSION_CACHE_PATH = "Library/GrassPainterCache_v3";
    private const string CACHE_PATH = "Library/GrassPainterCache_v3";
    private GrassPainterConfig configData;
    private static userSettings userSetting;
    private const string grassPainterConfigGUID = "0d2cc887b365f9c47aee0deb6749287a";

    private static bool showSceneGUI = false;
    private GrassPainter _target;
    private string[] presetNames; //预设材质球的名称
    private static bool isPaint;
    private bool needSaveData = false; //笔刷按下但是未弹起 有临时mesh未合并

    #region Cache
    private class userSettings
    {
        public float brushRadius = 1f; //笔刷框选的Unit范围半径
        public int baseAmount = 1; //笔刷一次生成多少根草
        public int presetIndex = 0; //草预设Index
        public int grassDensity = 20; //1个Unit面积内包含的草数量
        public float grassBaseScale_X = 0.5f; //xyz平面缩放
        public float grassBaseScale_Y = 0.5f;
        public float grassBaseScale_Z = 0.5f;
        public float grassScaleNoiseStrength = 0.2f; //随机缩放噪音
        public float grassBiasNoiseStrength = 0.2f; //随机倾斜噪音
    }

    private static void ReadFromCache()
    {
        string targetPath = CACHE_PATH;
        bool needUpdate = false;
        if (File.Exists(NEXT_VERSION_CACHE_PATH))
        {
            targetPath = NEXT_VERSION_CACHE_PATH;
            needUpdate = true;
        }

        userSetting = new userSettings();
        if (!File.Exists(targetPath))
            return;

        //反序列化数据
        FileStream fs = File.OpenRead(targetPath);
        try
        {
            if (needUpdate) { }
            BinaryFormatter bf = new BinaryFormatter();
            userSetting.brushRadius = (float)bf.Deserialize(fs);
            userSetting.baseAmount = (int)bf.Deserialize(fs);
            userSetting.presetIndex = (int)bf.Deserialize(fs);
            userSetting.grassDensity = (int)bf.Deserialize(fs);
            userSetting.grassBaseScale_X = (float)bf.Deserialize(fs);
            userSetting.grassBaseScale_Y = (float)bf.Deserialize(fs);
            userSetting.grassBaseScale_Z = (float)bf.Deserialize(fs);
            userSetting.grassScaleNoiseStrength = (float)bf.Deserialize(fs);
            userSetting.grassBiasNoiseStrength = (float)bf.Deserialize(fs);
        }
        catch (Exception e)
        {
            Debug.LogError(e);
            if (File.Exists(targetPath))
                File.Delete(targetPath);
        }
        finally
        {
            fs.Close();
        }
    }

    private static void WriteToChache()
    {
        string targetPath = NEXT_VERSION_CACHE_PATH;
        if (File.Exists(targetPath))
            File.Delete(targetPath);
        //序列化
        using (FileStream fs = File.OpenWrite(targetPath))
        {
            BinaryFormatter bf = new BinaryFormatter();
            bf.Serialize(fs, userSetting.brushRadius);
            bf.Serialize(fs, userSetting.baseAmount);
            bf.Serialize(fs, userSetting.presetIndex);
            bf.Serialize(fs, userSetting.grassDensity);
            bf.Serialize(fs, userSetting.grassBaseScale_X);
            bf.Serialize(fs, userSetting.grassBaseScale_Y);
            bf.Serialize(fs, userSetting.grassBaseScale_Z);
            bf.Serialize(fs, userSetting.grassScaleNoiseStrength);
            bf.Serialize(fs, userSetting.grassBiasNoiseStrength);
        }

        //检查是否勾选了Gizmos
        SceneView sceneView = SceneView.lastActiveSceneView;
        if (isPaint && sceneView != null && !sceneView.drawGizmos)
            sceneView.drawGizmos = true;
    }
    #endregion

    void OnSceneGUI()
    {
        if (!showSceneGUI)
            return;

        if (isPaint && Tools.current == Tool.None)
            Painter();
    }

    private void OnDisable()
    {
        isPaint = false;
    }

    public override void OnInspectorGUI()
    {
        base.OnInspectorGUI();
        showSceneGUI = false;
        if (_target == null)
            _target = (GrassPainter)target;
        if (_target.gameObject == null)
            return;

        //读取个人设置
        if (userSetting == null)
            ReadFromCache();

        //检查grass笔刷配置文件 获取可以的材质球
        if (configData == null)
        {
            string grassPainterPath = AssetDatabase.GUIDToAssetPath(grassPainterConfigGUID);
            if (string.IsNullOrEmpty(grassPainterPath) || !File.Exists(grassPainterPath))
            {
                EditorGUILayout.HelpBox("Grass笔刷配置文件不存在", MessageType.Error);
                return;
            }

            configData = AssetDatabase.LoadAssetAtPath<GrassPainterConfig>(grassPainterPath);
            if (configData == null)
            {
                EditorGUILayout.HelpBox("加载Shader配置文件发生错误：" + grassPainterPath, MessageType.Error);
                return;
            }

            if (GrassPainter._grassQuad == null)
                GrassPainter._grassQuad = configData.grassQuad;

            presetNames = new string[configData.grassPresets.Count];
            for (int i = 0; i < configData.grassPresets.Count; i++)
                presetNames[i] = configData.grassPresets[i].name;
        }

        EditorGUI.BeginChangeCheck();
        //绘制状态切换 开始绘制GUI
        {
            GUILayout.BeginHorizontal();
            GUILayout.FlexibleSpace();
            if (GUILayout.Button("打包", GUILayout.Height(25)))
            {
                if (PrefabUtility.IsAnyPrefabInstanceRoot(_target.gameObject))
                    PrefabUtility.UnpackPrefabInstance(_target.gameObject, PrefabUnpackMode.Completely, InteractionMode.UserAction);
                _target.GeneriteGrassPrefab();
            }
            if (GUILayout.Button("刷新", GUILayout.Height(25)))
            {
                configData = null;
                isPaint = false;
                return;
            }
            GUIStyle boolBtnOn = new GUIStyle(GUI.skin.GetStyle("Button"));
            GUIContent guiContent = EditorGUIUtility.IconContent("EditCollider");
            isPaint = GUILayout.Toggle(isPaint, guiContent, boolBtnOn, GUILayout.Width(35), GUILayout.Height(25));
            if (isPaint)
                GUILayout.Label("Drawing", GUILayout.Height(25));
            GUILayout.FlexibleSpace();
            GUILayout.EndHorizontal();
        }

        //笔刷属性
        {
            userSetting.brushRadius = EditorGUILayout.Slider("笔刷宽度", userSetting.brushRadius, 0.1f, 10f);
            userSetting.baseAmount = (int)EditorGUILayout.Slider("草基数", userSetting.baseAmount, 1, 50);
            userSetting.grassDensity = (int)EditorGUILayout.Slider("草浓度", userSetting.grassDensity, 0, 50);
            userSetting.grassBaseScale_X = EditorGUILayout.Slider("基础缩放X", userSetting.grassBaseScale_X, 0.1f, 10f);
            userSetting.grassBaseScale_Y = EditorGUILayout.Slider("基础缩放Y", userSetting.grassBaseScale_Y, 0.1f, 10f);
            userSetting.grassBaseScale_Z = EditorGUILayout.Slider("基础缩放Z", userSetting.grassBaseScale_Z, 0.1f, 10f);
            userSetting.grassScaleNoiseStrength = EditorGUILayout.Slider("缩放噪音", userSetting.grassScaleNoiseStrength, 0.1f, 0.5f);
            userSetting.grassBiasNoiseStrength = EditorGUILayout.Slider("倾斜噪音", userSetting.grassBiasNoiseStrength, 0.1f, 0.5f);

            GUILayout.Label("材质预设");
            EditorGUI.indentLevel++;
            GUILayout.BeginHorizontal();
            int texCount = presetNames.Length;
            int singleHeiht = 20;
            int gridWidth = 200;
            int gridHeight = singleHeiht * texCount;
            int singleLineCount = 1; //单行个数
            userSetting.presetIndex = GUILayout.SelectionGrid(userSetting.presetIndex, presetNames,
                singleLineCount, "gridlist", GUILayout.Width(gridWidth), GUILayout.Height(gridHeight));
            GUILayout.EndHorizontal();
            EditorGUI.indentLevel--;
        }

        if (EditorGUI.EndChangeCheck())
            WriteToChache();

        //当切换到绘制模式时更改工具模式
        {
            if (isPaint && Tools.current != Tool.None)
                Tools.current = Tool.None;
        }

        //检测通过才在Scene窗口显示笔刷
        showSceneGUI = true;
    }

    public void Painter()
    {
        Event e = Event.current;
        HandleUtility.AddDefaultControl(0);

        bool hasResult = false;
        Ray terrain = HandleUtility.GUIPointToWorldRay(e.mousePosition);
        if (Physics.Raycast(terrain, out RaycastHit raycastHit, Mathf.Infinity,
            1 << LayerMask.NameToLayer("Terrain") |
            1 << LayerMask.NameToLayer("Default") ))
            hasResult = true;

        if (hasResult)
        {
            Handles.color = new Color(1f, 1f, 0f, 1f); //黄色的圆圈
            Handles.DrawWireDisc(raycastHit.point, raycastHit.normal, userSetting.brushRadius);
            Handles.color = new Color(1f, 0f, 0f, 1f); //红色的法线
            Handles.DrawLine(raycastHit.point, raycastHit.point + raycastHit.normal);

            //左键拖拽 或 左键单击
            if (e.alt == false && e.control == false && e.shift == false && e.button == 0 &&
                (e.type == EventType.MouseDrag || e.type == EventType.MouseDown))
            {
                float GetRandom()
                {
                    return (float)_target.random.NextDouble();
                }

                float GetGrassAngle()
                {
                    //随机获取弧度 从0-1放大到0-2π
                    return GetRandom() * 2 * Mathf.PI;
                }

                Vector3 GetCircleAxis()
                {
                    float radin = GetGrassAngle();
                    float x = Mathf.Cos(radin);
                    float y = Mathf.Sin(radin);
                    return new Vector3(x, 0, y);
                }

                Vector3 GetCirclePoint()
                {
                    float radin = GetGrassAngle();
                    float x = Mathf.Cos(radin) * GetRandom();
                    float y = Mathf.Sin(radin) * GetRandom();
                    return new Vector3(x, 0, y);
                }

                //在以碰撞点为中心 userSetting.brushRadius为半径的圆内 生成userSetting.baseAmount个草
                Vector3 centerPos = raycastHit.point;
                int newPosCount = 0;
                for (int i = 0; i < userSetting.baseAmount; ++i)
                {
                    Vector3 newGrassPos = GetCirclePoint() * userSetting.brushRadius + centerPos;
                    if (newPosCount > userSetting.grassDensity - 1)
                    {
                        //浓度检测 判断离newGrassPos在1个Unit单位的点是否超过限制
                        int withInCount = 0;
                        foreach (var pos in _target.cachedGrassData)
                        {
                            if (Mathf.Abs(pos.CachedGrassPoint.x - newGrassPos.x) < 1 &&
                                Math.Abs(pos.CachedGrassPoint.z - newGrassPos.z) < 1)
                                withInCount++;
                        }
                        if (withInCount > userSetting.grassDensity - 1)
                            continue;
                    }

                    newPosCount++;
                    //缩放中带有随机噪音
                    Vector3 grassScale = new Vector3(userSetting.grassBaseScale_X, userSetting.grassBaseScale_Y, userSetting.grassBaseScale_Z);
                    Vector3 scaleOffset = grassScale * userSetting.grassScaleNoiseStrength;
                    grassScale.x = scaleOffset.x * 2 * GetRandom() + grassScale.x - scaleOffset.x;
                    grassScale.y = scaleOffset.y * 2 * GetRandom() + grassScale.y - scaleOffset.y;
                    grassScale.z = scaleOffset.z * 2 * GetRandom() + grassScale.z - scaleOffset.z;

                    GrassPainter.CachedGrassDataConfig data = new GrassPainter.CachedGrassDataConfig()
                    {
                        CachedGrassPoint = newGrassPos,
                        CachedGrassAngle = GetGrassAngle(),
                        //在0-90度范围内随机倾斜
                        CachedBiasAngle = GetGrassAngle() * 0.25f * userSetting.grassBiasNoiseStrength,
                        CachedBiasAxis = GetCircleAxis(), //随机噪音倾斜
                        CachedGrassScale = grassScale,
                    };
                    _target.cachedGrassData.Add(data);
                }

                needSaveData = true;
                _target.GeneriteCachedGrass(configData.grassPresets[userSetting.presetIndex], userSetting.grassDensity);
            }

            if (e.alt == false && e.control == false && e.shift == false && e.button == 0 &&
                e.type == EventType.MouseUp && needSaveData)
            {
                needSaveData = false;
                _target.CombineCachedGrass();
            }

            //加速Scene场景渲染
            SceneView.RepaintAll();
        }
    }

    [MenuItem("Window/场景Debug工具/ChangeGrassPainterMode &v", false, 25)]
    static void ChangeMeshPainterMode()
    {
        isPaint = !isPaint;
    }
}
