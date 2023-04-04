---
title: 编辑器API 自定义GUI
categories:
- [Unity, 插件]
date: 2020-08-07 18:03:02
---

\[toc\]编辑器工具中常用的API。

# 常用术语

GUI：图形用户界面 目录：比如Assets/Bundles 路径：比如Assets/Bundles/test.png

# 菜单栏

```csharp
[MenuItem("aaa/bbb/ccc")]
static void FunctionName()
{
    //your custom function
}
```

# Window 窗口

## 唤醒窗口

```csharp
//需要通过MenuItem的custom function打开窗口
EditorWindow.GetWindow(typeof(YourEditorWindowClass));
```

## 定义窗口界面元素

```csharp
class YourEditorWindowClass : EditorWindow
{
    void OnGUI()
    {
        //绘制GUI
    }
}
```

# GUI-Layout(布局)

纵向布局： EditorGUILayout.BeginVertical(); EditorGUILayout.EndVertical(); 横向布局(指定风格？) EditorGUILayout.BeginHorizontal("Label"); EditorGUILayout.EndHorizontal();

# GUI-样式(GUILayoutOption 对UI元素的限制)

多个样式作为参数：`params GUILayoutOption[] options` 限制元素的宽度： GUILayout.Width(300)

# GUI-Style(EditorStyles，文字风格)

粗体字： EditorStyles.boldLabel

# GUI-元素

## LabelField 标签文字框

//粗体风格的标签 EditorGUILayout.LabelField("标签", EditorStyles.boldLabel);

## TextField 可填写文字框

m\_TagName = EditorGUILayout.TextField("TagName:", m\_TagName, GUILayout.Width(300)); 参数1：label，可选的，在文字框左边显示标题； 参数2：string，可修改的文本 参数3：多个GUI样式

## IntField 可填写整数框

size = EditorGUILayout.IntField("整数类型:", size, GUILayout.Width(300));

## Foldout 可折叠隐藏部分UI

```csharp
//在标签左边显示一个小箭头 朝下表示展开 朝右表示隐藏
bool_showFoldout = EditorGUILayout.Foldout(bool_showFoldout, "折叠标签：");
if(bool_showFoldout)
{
    //绘制GUI
}
```

## Toggle 开关

switcher = EditorGUILayout.Toggle("开关", switcher);

## Button 按钮

```csharp
if (GUILayout.Button("Accept"))
{
    //your custom function
}
```

# AssetDatabase

## 返回指定资源的路径/目录

AssetDatabase.GetAssetPath(assetObject); 注：如果tassetObject是目录类型，则返回目录，不带最后的“/”。

## 根据类型搜索目录

```csharp
string[] GUIDs = AssetDatabase.FindAssets("t: prefab", new string[] { path });
```

## GUID转换成资源路径

```csharp
string prefab_path = AssetDatabase.GUIDToAssetPath(GUID);
```

## 加载资源路径 转换为对应的资源类型

```csharp
GameObject prefab = AssetDatabase.LoadAssetAtPath<GameObject>(prefab_path);
```

## 对资源文件修改后的保存操作

```csharp
EditorUtility.SetDirty(prefab);
AssetDatabase.SaveAssets();
```

适用于Prefab或者ScriptableObject等 **可序列化**资源

```csharp
AssetDatabase.ImportAsset(path);
```

适用于修改外部资源的导入设置；

# ProgressBar 进度条

```csharp
//弹出一个小窗口，提示任务的百分比进度。
EditorUtility.DisplayProgressBar("标题", "提示信息", 0.5f);
//关闭进度条窗口
EditorUtility.ClearProgressBar();
```

# Dialog 消息框

```csharp
//弹出一个小窗口，提示确认信息。
EditorUtility.DisplayDialog("标题", "提示信息", "确认按钮上的文字");
```

# 可重排序列表

声明： ReorderableList weatherList; 初始化：

```
//映射方式获取目标的List类型成员
weatherList = new ReorderableList(serializedObject, serializedObject.FindProperty("zoneWeatherPresets"), true, true, true, true);
weatherList.drawHeaderCallback = (Rect rect) =>
{
    EditorGUI.LabelField(rect, "这是标题:");
};

//绘制列表中的元素
weatherList.drawElementCallback =
    (Rect rect, int index, bool isActive, bool isFocused) => {
        var element = weatherList.serializedProperty.GetArrayElementAtIndex(index);
        rect.y += 2;
        EditorGUI.PropertyField(new Rect(rect.x, rect.y, Screen.width * 0.8f, EditorGUIUtility.singleLineHeight), element, GUIContent.none);
    };

//添加新元素事件
weatherList.onAddCallback = (ReorderableList l) =>
{
    var index = l.serializedProperty.arraySize;
    l.serializedProperty.arraySize++;
    l.index = index;
    //var element = l.serializedProperty.GetArrayElementAtIndex(index);
};
```

显示元件： weatherList.DoLayoutList();

# 滑动条

EditorGUILayout.Slider("Lightning Interval", myTarget.lightningInterval, 2f, 60f);

# 字段大写

`[Header("Your CustomTitle")]` public int someInt;

# 字段提示

`[Tooltip("Your Tips")]` public int someInt;

# API接口提示

```csharp
 /// <see cref="ScriptableRenderPass.ConfigureTarget(RenderTargetIdentifier)"/>
```

当注释写就好，可以跳转。