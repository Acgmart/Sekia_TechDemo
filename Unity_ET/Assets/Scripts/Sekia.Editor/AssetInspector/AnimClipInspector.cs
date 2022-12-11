using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;
using System.IO;

namespace Sekia
{
    [CustomEditor(typeof(AnimationClip))]
    public class AnimClipInspector : Editor
    {
        AnimationClip _target;
        string animMessage = "";
        CustomAnim customAnim; //自定义序列化类
        public float precision = 0.01F;

        //面板状态变为可编辑(Enabled)时执行一次
        private void OnEnable()
        {
            _target = (AnimationClip)target;
            customAnim = new CustomAnim(_target); //解析Clip文件数据
        }

        public override void OnInspectorGUI() //每帧执行
        {
            //绘制文本框显示.anim文件信息
            if (animMessage.Length == 0) //填充文子串
            {
                animMessage = animMessage + "ClipName：" + customAnim.animName;
                animMessage = animMessage + "\nFilePath：" + customAnim.animFilePath;
                animMessage = animMessage + "\nFileSize：" + customAnim.animFileSize / 1000 + "kb";
                animMessage = animMessage + "\nLength：" + customAnim.animLength + "s";
                animMessage = animMessage + "\nSampleRate：" + customAnim.animSample + "fps";
                animMessage = animMessage + "\nEventsNumber：" + customAnim.animEvents.Length.ToString();
                animMessage = animMessage + "\nFloatCurveNumber：" + customAnim.floatBindings.Length.ToString();
                animMessage = animMessage + "\nObjectReferenceCurveNumber：" + customAnim.objectreferenceBindings.Length.ToString();
                animMessage = animMessage + "\nTotalKeyFrameNumber：" + customAnim.animKeyFrameNumber.ToString();
                animMessage = animMessage + "\nFree:" + customAnim.animLeftTangentModeFree.ToString()
                                          + " Constant:" + customAnim.animLeftTangentModeConstant.ToString()
                                          + " Linear:" + customAnim.animLeftTangentModeLinear.ToString()
                                          + " Auto:" + customAnim.animLeftTangentModeAuto.ToString()
                                          + " Clamped:" + customAnim.animLeftTangentModeClampedAuto.ToString();
                animMessage = animMessage + "\nFree:" + customAnim.animRightTangentModeFree.ToString()
                                          + " Constant:" + customAnim.animRightTangentModeConstant.ToString()
                                          + " Linear:" + customAnim.animRightTangentModeLinear.ToString()
                                          + " Auto:" + customAnim.animRightTangentModeAuto.ToString()
                                          + " Clamped:" + customAnim.animRightTangentModeClampedAuto.ToString();
                animMessage = animMessage + "\n   TangentModeDistinctNumber：" + customAnim.animTangentModeDistinct.ToString();
                animMessage = animMessage + "\n   WeightedKeyFrameNumber：" + customAnim.animWeightedFloatKeyFrameNumber.ToString();
            }
            EditorGUILayout.HelpBox(animMessage, MessageType.None);

            precision = EditorGUILayout.Slider("贡献率", precision, 0F, 0.1F);

            if (GUILayout.Button("删除贡献率低的关键帧"))
            {
                customAnim.precision = precision;
                customAnim.DeleteUnusedKeyFrames();
            }
        }
    }

    public class CustomAnim
    {
        public AnimationClip clip;
        public float precision = 0F;

        //Float关键帧
        public EditorCurveBinding[] floatBindings;
        public AnimationCurve[] floatCurves;
        public Keyframe[][] floatKeyframes;

        //Object指针关键帧
        public EditorCurveBinding[] objectreferenceBindings;
        public ObjectReferenceKeyframe[][] objectreferenceKeyframes;

        public WrapMode animWrapMode;
        public AnimationEvent[] animEvents; //事件列表
        public AnimationClipSettings animSettings; //设置
        public float animLength; //时长(秒) get only
        public float animSample; //帧率
        public string animName; //文件名
        public string animFilePath; //文件路径 去头 去尾
        public int animFileSize = 0; //文件大小
        public int animKeyFrameNumber = 0; //总帧数
        public int animWeightedFloatKeyFrameNumber = 0; //带权重的帧数量
        public int animLeftTangentModeFree = 0;
        public int animLeftTangentModeConstant = 0;
        public int animLeftTangentModeLinear = 0;
        public int animLeftTangentModeAuto = 0;
        public int animLeftTangentModeClampedAuto = 0;
        public int animRightTangentModeFree = 0;
        public int animRightTangentModeConstant = 0;
        public int animRightTangentModeLinear = 0;
        public int animRightTangentModeAuto = 0;
        public int animRightTangentModeClampedAuto = 0;
        public int animTangentModeDistinct = 0; //TangentMode为Broken

        public CustomAnim(Object asset)
        {
            clip = asset as AnimationClip; //检查是否可以转换 失败返回Null 无异常风险
            if (clip == null) //必须是Clip
            {
                throw new System.ArgumentException();
            }
            animWrapMode = clip.wrapMode; //默认Once
            animLength = clip.length;
            animSample = clip.frameRate;
            animEvents = clip.events;
            animName = clip.name;
            animSettings = AnimationUtility.GetAnimationClipSettings(clip);

            //文件路径
            string animAssetPath = AssetDatabase.GetAssetPath(asset); //"Assets/"开头 文件.后缀结尾
            string fullFilePath = Application.dataPath + animAssetPath.Substring(6); //Editor模式下 <project folder>/Assets
            animFilePath = animAssetPath.Substring(6, animAssetPath.Length - 11 - animName.Length); //去头 去尾

            //文件大小
            if (File.Exists(fullFilePath))
            {
                using (FileStream fs = new FileStream(fullFilePath, FileMode.Open))
                {
                    byte[] data = new byte[1000000]; //单次读取1M
                    bool hasData = true;
                    while (hasData)
                    {
                        int readSize = fs.Read(data, 0, data.Length);
                        if (readSize > 0)
                        {
                            animFileSize = animFileSize + readSize;
                        }
                        else
                        {
                            hasData = false;
                        }
                    }
                }
            }

            //读取Float关键帧 绝大部分的动画数据都是这个情况
            floatBindings = AnimationUtility.GetCurveBindings(clip);
            int floatCurveNum = floatBindings.Length;
            floatCurves = new AnimationCurve[floatCurveNum];
            floatKeyframes = new Keyframe[floatCurveNum][];
            for (int i = 0; i < floatCurveNum; ++i)
            {
                floatCurves[i] = AnimationUtility.GetEditorCurve(clip, floatBindings[i]);
                floatKeyframes[i] = floatCurves[i].keys;
            }

            //读取Object指针关键帧 这些关键帧可以在不同时间指向不同的Prefab
            objectreferenceBindings = AnimationUtility.GetObjectReferenceCurveBindings(clip);
            int objectreferenceCurveNum = objectreferenceBindings.Length;
            objectreferenceKeyframes = new ObjectReferenceKeyframe[objectreferenceCurveNum][];
            for (int i = 0; i < objectreferenceCurveNum; ++i)
            {
                objectreferenceKeyframes[i] = AnimationUtility.GetObjectReferenceCurve(clip, objectreferenceBindings[i]);
            }

            //计算总共有多少帧
            for (int i = 0; i < floatKeyframes.Length; ++i)
            {
                animKeyFrameNumber = animKeyFrameNumber + floatKeyframes[i].Length;
                for (int n = 0; n < floatKeyframes[i].Length; ++n) //遍历float关键帧
                {
#if UNITY_2018_3_OR_NEWER
                    if (floatKeyframes[i][n].weightedMode != WeightedMode.None)
                    {
                        //启用了权重模式的关键帧计数 包括In/Out/Both三种模式
                        animWeightedFloatKeyFrameNumber += 1;
                    }
#endif

                    //(默认)Free：需自定义Tangent值 在Animation窗口中手动调节
                    //Constant：强制值为前/后一个关键帧的值 类似bool/int的工作模式
                    //Linear：Tangent自动指向前/后一个关键帧 僵硬的动作
                    //Auto：Tangent自动平行于前后两个关键帧的连线 连贯的动作
                    //ClampedAuto：Tanget根据前后两个关键帧的值差定义斜率 斜率在时间改变时间时不会变

                    //当左右Tanget值相等时 自动取消Broken标签
                    //(默认)Free → Free Smooth 一次调节同时影响左右Tangent
                    //Free Smooth + Flat Tangent固定为0
                    //Auto → Auto (值/时间)平滑
                    //ClampedAuto → ClampedAuto (值差)平滑
                    AnimationUtility.TangentMode leftTangentMode = AnimationUtility.GetKeyLeftTangentMode(floatCurves[i], n);
                    AnimationUtility.TangentMode rightTangentMode = AnimationUtility.GetKeyRightTangentMode(floatCurves[i], n);

                    if (leftTangentMode == AnimationUtility.TangentMode.Free)
                    {
                        animLeftTangentModeFree += 1;
                    }
                    else if (leftTangentMode == AnimationUtility.TangentMode.Constant)
                    {
                        animLeftTangentModeConstant += 1;
                    }
                    else if (leftTangentMode == AnimationUtility.TangentMode.Linear)
                    {
                        animLeftTangentModeLinear += 1;
                    }
                    else if (leftTangentMode == AnimationUtility.TangentMode.Auto)
                    {
                        animLeftTangentModeAuto += 1;
                    }
                    else if (leftTangentMode == AnimationUtility.TangentMode.ClampedAuto)
                    {
                        animLeftTangentModeClampedAuto += 1;
                    }

                    if (rightTangentMode == AnimationUtility.TangentMode.Free)
                    {
                        animRightTangentModeFree += 1;
                    }
                    else if (rightTangentMode == AnimationUtility.TangentMode.Constant)
                    {
                        animRightTangentModeConstant += 1;
                    }
                    else if (rightTangentMode == AnimationUtility.TangentMode.Linear)
                    {
                        animRightTangentModeLinear += 1;
                    }
                    else if (rightTangentMode == AnimationUtility.TangentMode.Auto)
                    {
                        animRightTangentModeAuto += 1;
                    }
                    else if (rightTangentMode == AnimationUtility.TangentMode.ClampedAuto)
                    {
                        animRightTangentModeClampedAuto += 1;
                    }

                    if (leftTangentMode != rightTangentMode)
                    {
                        animTangentModeDistinct += 1;
                    }
                }
            }
            for (int i = 0; i < objectreferenceKeyframes.Length; ++i)
            {
                animKeyFrameNumber = animKeyFrameNumber + objectreferenceKeyframes[i].Length;
            }
        }

        public void DeleteUnusedKeyFrames()
        {
            string targetName = animName + "_fixed";
            string exportFilePath = "Assets" + animFilePath + targetName + ".anim";
            if (File.Exists(exportFilePath))
                File.Delete(exportFilePath);
            AnimationClip result = new AnimationClip();
            result.name = targetName;
            result.wrapMode = animWrapMode;
            result.frameRate = animSample;
            AnimationUtility.SetAnimationEvents(result, animEvents);
            AnimationUtility.SetAnimationClipSettings(result, animSettings);
            AnimationUtility.TangentMode searchTangentMode = AnimationUtility.TangentMode.Free; //判断TangentMode
            bool threeTheSame = false;

            //如果连续3个keyframe的Tanget非Broken 且为非Auto模式有机会删减keyframe并且不影响动作
            for (int i = 0; i < floatCurves.Length; ++i)
            {
                threeTheSame = false;
                List<Keyframe> usingKeyFrames = new List<Keyframe>();
                Keyframe[] sortedKeyFrames = floatKeyframes[i];
                System.Array.Sort(sortedKeyFrames, (x, y) => y.time.CompareTo(x.time));
                int length = sortedKeyFrames.Length;

                if (length < 10) //总帧数小于10时不进行优化
                {
                    for (int n = 0; n < length; ++n)
                    {
                        usingKeyFrames.Add(sortedKeyFrames[n]);
                    }
                }
                else
                {
                    for (int n = 0; n < length; ++n)
                    {
                        AnimationUtility.TangentMode leftTangentMode = AnimationUtility.GetKeyLeftTangentMode(floatCurves[i], n);
                        AnimationUtility.TangentMode rightTangentMode = AnimationUtility.GetKeyRightTangentMode(floatCurves[i], n);

                        if (leftTangentMode != rightTangentMode) //排除掉Broken关键帧
                        {
                            usingKeyFrames.Add(sortedKeyFrames[n]);
                            searchTangentMode = rightTangentMode;
                            threeTheSame = false;
                            continue;
                        }

                        if (searchTangentMode != rightTangentMode) //排除掉关键帧模式发生变化的位置
                        {
                            usingKeyFrames.Add(sortedKeyFrames[n]);
                            searchTangentMode = rightTangentMode;
                            threeTheSame = false;
                            continue;
                        }

                        //出现连续相同模式的关键帧时标记状态
                        //从这里开始出现的都是连续关键帧(非Broken且TagentMode一致)
                        if (!threeTheSame) //同时记录第1帧 忽略第2帧
                        {
                            usingKeyFrames.Add(sortedKeyFrames[n]);
                            threeTheSame = true;
                            continue;
                        }

                        bool autoTangent = searchTangentMode == AnimationUtility.TangentMode.Auto || searchTangentMode == AnimationUtility.TangentMode.ClampedAuto;
                        //从第3帧 排除掉自动模式关键帧
                        if (autoTangent && threeTheSame && n > 1)
                        {
                            usingKeyFrames.Add(sortedKeyFrames[n]);
                            if (n == 2) //如果是自动模式补上第2帧
                                usingKeyFrames.Add(sortedKeyFrames[1]);
                            continue;
                        }

                        //从第3帧 逐帧判断是否可以删除第n-1帧
                        if (threeTheSame && n > 1)
                        {
                            //Unity中封装了曲线计算公式 bezier spline(贝兹曲线)
                            //从Edittor C# SourceCode中可以知道Animation窗口中曲线就是实时的模拟值
                            //可以根据采样率逐帧绘制曲线 30帧相当于1帧间隔0.03334秒
                            //第一个关键帧的LeftTangentMode和最后一个关键帧的RightTangentMode强制为Constant
                            //关键帧必须按时间顺序排列
                            Keyframe left = sortedKeyFrames[n - 2];
                            Keyframe mid = sortedKeyFrames[n - 1];
                            Keyframe right = sortedKeyFrames[n];
                            AnimationCurve animationCurve = new AnimationCurve(new Keyframe[2] { left, right });
                            float duration = right.time - left.time; //左右时间间隔的限制
                            float dropLeftRight = System.Math.Abs(left.value - right.value);
                            float dropMid = System.Math.Abs(animationCurve.Evaluate(mid.time) - mid.value);
                            float dropRate = dropMid / dropLeftRight; //值越大时 Mid的重要性越高

                            if (dropRate > precision || duration > 0.1F)
                            {
                                //左右关键帧之间时间间隔极小 且 差值对最终结果无影响时 忽略中间的关键帧
                                //这里删除的关键帧不会影响动画的精度
                                usingKeyFrames.Add(mid);
                            }
                        }

                        //判断到最后一帧时
                        if (n == length - 1)
                        {
                            usingKeyFrames.Add(sortedKeyFrames[length - 1]);
                        }
                    }
                }

                //使用关键帧列表创建曲线
                AnimationCurve curve = new AnimationCurve(usingKeyFrames.ToArray());
                //对应clip文件中m_Curve的属性：  path         classID              attribute
                result.SetCurve(floatBindings[i].path, floatBindings[i].type, floatBindings[i].propertyName, curve);
            }

            for (int i = 0; i < objectreferenceKeyframes.Length; ++i)
            {
                AnimationUtility.SetObjectReferenceCurve(result, objectreferenceBindings[i], objectreferenceKeyframes[i]);
            }

            result.EnsureQuaternionContinuity();
            AssetDatabase.CreateAsset(result, exportFilePath); //"Assets/"开头 文件.后缀结尾
            AssetDatabase.Refresh();
            //遍历Hierarchy 如果asset/script/静态变量没有被使用则标记为Unused
            //未加载的资源首次使用时会需要加载
            EditorUtility.UnloadUnusedAssetsImmediate();
            Debug.LogError($"优化关键帧成功：{animName}_fixed.anim");
        }
    }
}
