using UnityEditor.Presets;
using UnityEngine;
using System.IO;
using System.Collections.Generic;
using System.Runtime.Serialization.Formatters.Binary;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;
using UnityEngine.UI;
using UnityEngine.Experimental.Rendering;
using UnityEngine.SceneManagement;

namespace UnityEditor
{
    public class Shader_GUI_Common : ShaderGUI
    {
        //显示一个归一化的向量 用欧拉角表示
        public static void ShowNormalizeVector(MaterialEditor materialEditor, string _VectorName, string _Title)
        {
            //由于一个唯一的向量能对应多个欧拉角
            //直接滑动从向量推导的欧拉角会导致欧拉角数值闪烁
            //所以这里将欧拉角的数字限定在特定范围内
            Vector3 _FromDir = new Vector3(0, 0, 1);
            Material material = materialEditor.target as Material;
            //将向量转换为欧拉角
            Vector4 _VectorValue = material.GetVector(_VectorName);
            Vector3 _ToDir = new Vector3(_VectorValue.x, _VectorValue.y, _VectorValue.z);
            _ToDir = Vector3.Normalize(_ToDir);
            Quaternion _Rotate = Quaternion.FromToRotation(_FromDir, _ToDir);
            Vector3 _RotateAngle = _Rotate.eulerAngles;
            int _RotateAngle_X = Mathf.RoundToInt(_RotateAngle.x);
            int _RotateAngle_Y = Mathf.RoundToInt(_RotateAngle.y);
            _RotateAngle_X = (_RotateAngle_X + 360) % 360;
            if (_RotateAngle_X > 180)
                _RotateAngle_X = _RotateAngle_X - 360;
            _RotateAngle_Y = (_RotateAngle_Y + 360) % 360;
            if (_RotateAngle_Y > 180)
                _RotateAngle_Y = _RotateAngle_Y - 360;
            if (_RotateAngle_X > 90 || _RotateAngle_X < -90) //x轴旋转幅度太大导致朝向反向
            {
                if (_RotateAngle_X > 90) //俯视
                    _RotateAngle_X = 180 - _RotateAngle_X;
                else if (_RotateAngle_X < -90) //仰视
                    _RotateAngle_X = -180 - _RotateAngle_X;
                _RotateAngle_Y += 180;
                if (_RotateAngle_Y > 180)
                    _RotateAngle_Y = _RotateAngle_Y - 360;
            }

            EditorGUI.BeginChangeCheck();
            Vector2Int _EulerAngle = new Vector2Int(_RotateAngle_X, _RotateAngle_Y);
            string title1 = $"{_Title}_欧拉角_X";
            string title2 = $"{_Title}_欧拉角_Y";
            string describe = "使用欧拉角[x, y, 0]表示归一化的向量\n" +
                "将向量分别围绕世界空间Z轴X轴Y轴旋转zxy角度\n" +
                "与光源组件的transform旋转参数正好相反\n" +
                "z：以向量[0, 0, 1]为出发角度 可忽略z\n" +
                "x：决定俯视[0, 90)和仰视[-90, 0]角度\n" +
                "y：决定朝向([-179, 180]";
            int _Output_X = EditorGUILayout.IntSlider(new GUIContent(title1, describe), _EulerAngle.x, -90, 90);
            int _Output_Y = EditorGUILayout.IntSlider(new GUIContent(title2, describe), _EulerAngle.y, -179, 180);
            if (EditorGUI.EndChangeCheck())
                materialEditor.RegisterPropertyChangeUndo("Change Value"); //注册恢复点

            if (_Output_X != _EulerAngle.x || _Output_Y != _EulerAngle.y)
            {
                //更新缓存
                Vector3 _NewToDir = Quaternion.Euler(_Output_X, _Output_Y, 0) * _FromDir;
                _NewToDir = Vector3.Normalize(_NewToDir);
                material.SetVector(_VectorName, new Vector4(_NewToDir.x, _NewToDir.y, _NewToDir.z, 0));
            }
        }

        public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] properties)
        {
            materialEditor.PropertiesDefaultGUI(properties);
        }
    }
}
