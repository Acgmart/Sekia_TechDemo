//#define _DEBUG_MODE
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;
using System.Text;
using System.Linq;

class ToolWindow_VP_Matrix_CalCulator : EditorWindow
{
    [MenuItem("Window/TA工具/计算VP矩阵")]
    static void InitWindow()
    {
        ToolWindow_VP_Matrix_CalCulator window = EditorWindow.GetWindow<ToolWindow_VP_Matrix_CalCulator>(false, "计算VP矩阵");
        window.Show();
    }

    #region 初始定义
    readonly static string[] _V_M = new string[16] { "1", "0", "0", $"-1*x",
                                                     "0", "1", "0", $"-1*y",
                                                     "0", "0", "1", $"-1*z",
                                                     "0", "0", "0", "1",};
    readonly static string[] _V_Y = new string[16]{ "cosY", "0", "-1*sinY", "0",
                                                    "0", "1", "0", "0",
                                                    "sinY", "0", "cosY", "0",
                                                    "0", "0", "0", "1",};
    readonly static string[] _V_X = new string[16]{ "1", "0", "0", "0",
                                                    "0", "cosX", "sinX", "0",
                                                    "0", "-1*sinX", "cosX", "0",
                                                    "0", "0", "0", "1",};
    readonly static string[] _V_Z_Any = new string[16]{ "cosZ", "sinZ", "0", "0",
                                                    "-1*sinZ", "cosZ", "0", "0",
                                                    "0", "0", "1", "0",
                                                    "0", "0", "0", "1",};
    readonly static string[] _V_Z_Zero = new string[16]{ "1", "0", "0", "0",
                                                         "0", "1", "0", "0",
                                                         "0", "0", "1", "0",
                                                         "0", "0", "0", "1",};
    readonly static string[] _V_N = new string[16]{ "1", "0", "0", "0",
                                                    "0", "1", "0", "0",
                                                    "0", "0", "-1", "0",
                                                    "0", "0", "0", "1",};
    readonly static string[] _P = new string[16]{ $"{k3}*{k4}", "0", "0", "0",
                                                  "0", k3, "0", "0",
                                                  "0", "0", $"-1*{k1}", $"-2*{k2}",
                                                  "0", "0", "-1", "0",};
    readonly static string[] _R_DX = new string[16]{ "1", "0", "0", "0",
                                                     "0", "-1", "0", "0",
                                                     "0", "0", "-0.5", "0.5",
                                                     "0", "0", "0", "1",};
    readonly static string[] _R_GL = new string[16]{ "1", "0", "0", "0",
                                                     "0", "1", "0", "0",
                                                     "0", "0", "1", "0",
                                                     "0", "0", "0", "1",};
    static string[] _V_Z;
    static string[] _V;
    static string[] _R;
    static string[] _PR;
    static string[] _VP;
    static string[] _Vformula;
    static string[] _PRformula;
    static string[] _VPformula;

    static Vector3 fore_cameraPosition = new Vector3(1, 2, 3);
    static Vector3 fore_cameraRotation = new Vector3(30, 30, 0);
    static int fore_screenWidth = 16;
    static int fore_screenHeight = 9;
    static int fore_Fov = 60;
    static float fore_Far = 1000;
    static float fore_Near = 100f;
    static string[] fore_V = new string[16] { "-", "-", "-", "-",
                                              "-", "-", "-", "-",
                                              "-", "-", "-", "-",
                                              "-", "-", "-", "-",};
    static string[] fore_P = new string[16] { "-", "-", "-", "-",
                                              "-", "-", "-", "-",
                                              "-", "-", "-", "-",
                                              "-", "-", "-", "-",};
    static string[] fore_VP = new string[16] { "-", "-", "-", "-",
                                               "-", "-", "-", "-",
                                               "-", "-", "-", "-",
                                               "-", "-", "-", "-",};

    static Vector4 back_vp_Line1 = new Vector4(1.358f, 0f, 0f, 2609.99756f);
    static Vector4 back_vp_Line2 = new Vector4(0f, 1.70711f, 1.70711f, -5663.74707f);
    static Vector4 back_vp_Line3 = new Vector4(0f, -0.73519f, 0.73519f, -1454.34229f);
    static Vector4 back_vp_Line4 = new Vector4(0f, -0.70711f, 0.70711f, -1246.00208f);
    static string[] back_vp_cameraPosition = new string[3] { "-", "-", "-" };
    static string[] back_vp_cameraRotation = new string[3] { "-", "-", "-" };
    static string back_vp_aspect = "-";
    static string back_vp_Fov = "-";
    static string back_vp_Far = "-";
    static string back_vp_Near = "-";

    static Vector4 back_v_Line1 = new Vector4(0.8660254f, 0, -0.5f, 0.6339746f);
    static Vector4 back_v_Line2 = new Vector4(0.25f, 0.8660254f, 0.4330127f, -3.281089f);
    static Vector4 back_v_Line3 = new Vector4(-0.4330127f, 0.5f, -0.75f, 1.683013f);
    static Vector4 back_v_Line4 = new Vector4(0, 0, 0, 1);
    static string[] back_v_cameraPosition = new string[3] { "-", "-", "-" };
    static string[] back_v_cameraRotation = new string[3] { "-", "-", "-" };

    static Vector4 back_p_Line1 = new Vector4(0.9742786f, 0, 0, 0);
    static Vector4 back_p_Line2 = new Vector4(0, -1.732051f, 0, 0);
    static Vector4 back_p_Line3 = new Vector4(0, 0, 0.1111111f, 111.1111f);
    static Vector4 back_p_Line4 = new Vector4(0, 0, -1, 0);
    static string back_p_aspect = "-";
    static string back_p_Fov = "-";
    static string back_p_Far = "-";
    static string back_p_Near = "-";

    static bool _isDx = false;
    static bool _isCameraRotateZisZero = true;
    static bool _showSimpleVersion = true;

    static bool _showV_MYXZN = false;
    static bool _showV_V = false;
    static bool _showP = false;
    static bool _showVP = false;

    const string k1 = "(Far+Near)*/(Far+-1*Near)";
    const string k2 = "Far*Near*/(Far+-1*Near)";
    const string k3 = "cot(Fov/2)";
    const string k4 = "/Aspect";
    const string sinX = "sinX";
    const string cosX = "cosX";
    const string sinY = "sinY";
    const string cosY = "cosY";
    const string sinZ = "sinZ";
    const string cosZ = "cosZ";
    const string x = "x";
    const string y = "y";
    const string z = "z";
    const string Far = "Far";
    const string Near = "Near";
    static string[] args = new string[13] { k1, k2, k3, k4, sinX, cosX, sinY, cosY, sinZ, cosZ, x, y, z };
    #endregion

    #region 简单的数学和字符串运算
    static string[] CalculateMatrixMul(string[] left, string[] right)
    {
        int CalculateStringAddCount(string input)
        {
            int result = 1;
            bool waitRightKuoHao = false;
            for (int i = 0; i < input.Length; i++)
            {
                string word = input.Substring(i, 1);

                if (waitRightKuoHao && word == ")")
                {
                    waitRightKuoHao = false;
                    continue;
                }
                else if (waitRightKuoHao)
                {
                    continue;
                }

                if (word == "(")
                {
                    waitRightKuoHao = true;
                    continue;
                }

                if (word == "+")
                {
                    result += 1;
                }
            }
            return result;
        }

        string CalculateStringMathMul(string left, string right)
        {
            if (left == "1")
                return right;
            if (right == "1")
                return left;
            if (left == "0")
                return "0";
            if (right == "0")
                return "0";

            int signCountLeft = CalculateStringAddCount(left);
            int signCountRight = CalculateStringAddCount(right);
            if (signCountLeft == 1 && signCountRight == 1)
                return $"{left}*{right}";
            else if (signCountLeft == 1)
                return $"{left}*({right})";
            else if (signCountRight == 1)
                return $"({left})*{right}";
            else
                return $"({left})*({right})";
        }

        string CalculateStringMathAdd(string left, string right)
        {
            if (left == "0")
                return right;
            if (right == "0")
                return left;
            return $"{left}+{right}";
        }

        string CalculateStringMath(string left1, string left2, string left3, string left4, string right1, string right2, string right3, string right4)
        {
            string value1 = CalculateStringMathMul(left1, right1);
            string value2 = CalculateStringMathMul(left2, right2);
            string value3 = CalculateStringMathMul(left3, right3);
            string value4 = CalculateStringMathMul(left4, right4);
            value1 = CalculateStringMathAdd(value1, value2);
            value1 = CalculateStringMathAdd(value1, value3);
            value1 = CalculateStringMathAdd(value1, value4);
            return value1;
        }

        string[] result = new string[16];
        for (int i = 0; i < 16; i++)
        {
            int leftBase = i - i % 4;
            int rightBase = i % 4;
            result[i] = CalculateStringMath(left[leftBase], left[leftBase + 1], left[leftBase + 2], left[leftBase + 3],
                right[rightBase], right[rightBase + 4], right[rightBase + 8], right[rightBase + 12]);
        }
        return result;
    }

    static float[] CalculateMatrixMul(float[] left, float[] right)
    {
        float CalculateFloatMath(float left1, float left2, float left3, float left4, float right1, float right2, float right3, float right4)
        {
            float value1 = left1 * right1;
            float value2 = left2 * right2;
            float value3 = left3 * right3;
            float value4 = left4 * right4;
            value1 = value1 + value2;
            value1 = value1 + value3;
            value1 = value1 + value4;
            return value1;
        }

        float[] result = new float[16];
        for (int i = 0; i < 16; i++)
        {
            int leftBase = i - i % 4;
            int rightBase = i % 4;
            result[i] = CalculateFloatMath(left[leftBase], left[leftBase + 1], left[leftBase + 2], left[leftBase + 3],
                right[rightBase], right[rightBase + 4], right[rightBase + 8], right[rightBase + 12]);
        }
        return result;
    }

    private float[] CreateMatrix(Vector4 line1, Vector4 line2, Vector4 line3, Vector4 line4)
    {
        float[] result = new float[16];
        result[0] = line1.x; result[1] = line1.y; result[2] = line1.z; result[3] = line1.w;
        result[4] = line2.x; result[5] = line2.y; result[6] = line2.z; result[7] = line2.w;
        result[8] = line3.x; result[9] = line3.y; result[10] = line3.z; result[11] = line3.w;
        result[12] = line4.x; result[13] = line4.y; result[14] = line4.z; result[15] = line4.w;
        return result;
    }

    private string[] CopyMatrix(string[] input)
    {
        string[] result = new string[16];
        for (int i = 0; i < 16; i++)
            result[i] = input[i];
        return result;
    }

    private static void DebugMatrix(string[] formula, string prefix = "", float[] value = null)
    {
#if _DEBUG_MODE
        if (value == null)
        {
            string result = prefix;
            for (int i = 0; i < formula.Length; i++)
                result = result + "\n" + formula[i];
            Debug.LogError(result);
        }
        else
        {
            string result = prefix;
            for (int i = 0; i < formula.Length; i++)
                result = result + "\n" + value[i].ToString() + " = " + formula[i];
            Debug.LogError(result);
        }
#endif
    }

    public static void DebugString(string input)
    {
#if _DEBUG_MODE
        Debug.LogError(input);
#endif
    }
    #endregion

    #region 窗口界面和功能入口
    private void OnEnable()
    {
        ReCalculateMatrix();
    }

    //初始化公式
    private void ReCalculateMatrix()
    {
        _V_Z = _isCameraRotateZisZero ? _V_Z_Zero : _V_Z_Any;
        _R = _isDx ? _R_DX : _R_GL;
        _V = CalculateMatrixMul(_V_X, _V_Y);
        _V = CalculateMatrixMul(_V_Z, _V);
        _V = CalculateMatrixMul(_V, _V_M);
        _V = CalculateMatrixMul(_V_N, _V);
        _PR = CalculateMatrixMul(_R, _P);
        _VP = CalculateMatrixMul(_P, _V);
        _VP = CalculateMatrixMul(_R, _VP);
        _Vformula = CopyMatrix(_V);
        _PRformula = CopyMatrix(_PR);
        _VPformula = CopyMatrix(_VP);
        for (int i = 0; i < 16; i++)
        {
            _V[i] = new Formula(_V[i], false).FormulaStringExpressForShowOnly(_showSimpleVersion);
            _PR[i] = new Formula(_PR[i], false).FormulaStringExpressForShowOnly(_showSimpleVersion);
            _VP[i] = new Formula(_VP[i], false).FormulaStringExpressForShowOnly(_showSimpleVersion);
        }
    }

    //输入相机参数 得到V PR VP
    private void ReCalculateValueToMatrix()
    {
        float[] MatrixStringToFloat(string[] input, Vector3 position, Vector3 rotate,
            int fov, int width, int height,
            float far, float near
            )
        {
            float[] result = new float[16];
            for (int i = 0; i < 16; i++)
            {
                string value = input[i];
                if (value == "0")
                    result[i] = 0;
                else if (value == "1")
                    result[i] = 1;
                else if (value == "-1")
                    result[i] = -1;
                else if (value == "0.5")
                    result[i] = 0.5f;
                else if (value == "-0.5")
                    result[i] = -0.5f;
                else if (value == "-1*x")
                    result[i] = -position.x;
                else if (value == "-1*y")
                    result[i] = -position.y;
                else if (value == "-1*z")
                    result[i] = -position.z;
                else if (value == "sinX")
                    result[i] = Mathf.Sin(rotate.x * Mathf.Deg2Rad);
                else if (value == "-1*sinX")
                    result[i] = -Mathf.Sin(rotate.x * Mathf.Deg2Rad);
                else if (value == "cosX")
                    result[i] = Mathf.Cos(rotate.x * Mathf.Deg2Rad);
                else if (value == "-1*cosX")
                    result[i] = -Mathf.Cos(rotate.x * Mathf.Deg2Rad);
                else if (value == "sinY")
                    result[i] = Mathf.Sin(rotate.y * Mathf.Deg2Rad);
                else if (value == "-1*sinY")
                    result[i] = -Mathf.Sin(rotate.y * Mathf.Deg2Rad);
                else if (value == "cosY")
                    result[i] = Mathf.Cos(rotate.y * Mathf.Deg2Rad);
                else if (value == "-1*cosY")
                    result[i] = -Mathf.Cos(rotate.y * Mathf.Deg2Rad);
                else if (value == "cosZ")
                    result[i] = Mathf.Cos(rotate.z * Mathf.Deg2Rad);
                else if (value == "-1*cosZ")
                    result[i] = -Mathf.Cos(rotate.z * Mathf.Deg2Rad);
                else if (value == "sinZ")
                    result[i] = Mathf.Sin(rotate.z * Mathf.Deg2Rad);
                else if (value == "-1*sinZ")
                    result[i] = -Mathf.Sin(rotate.z * Mathf.Deg2Rad);
                else if (value == "cot(Fov/2)*/Aspect")
                    result[i] = (1f / Mathf.Tan((float)fov * 0.5f * Mathf.Deg2Rad)) * (float)height / (float)width;
                else if (value == "cot(Fov/2)")
                    result[i] = 1f / Mathf.Tan((float)fov * 0.5f * Mathf.Deg2Rad);
                else if (value == "-1*(Far+Near)*/(Far+-1*Near)")
                    result[i] = -(far + near) / (far - near);
                else if (value == "-2*Far*Near*/(Far+-1*Near)")
                    result[i] = -(2f * far * near) / (far - near);
                else
                    Debug.LogError("未翻译的变量：" + value);
            }
            return result;
        }

        float[] m_M = MatrixStringToFloat(_V_M, fore_cameraPosition, fore_cameraRotation, fore_Fov, fore_screenWidth, fore_screenHeight, fore_Far, fore_Near);
        float[] m_Y = MatrixStringToFloat(_V_Y, fore_cameraPosition, fore_cameraRotation, fore_Fov, fore_screenWidth, fore_screenHeight, fore_Far, fore_Near);
        float[] m_X = MatrixStringToFloat(_V_X, fore_cameraPosition, fore_cameraRotation, fore_Fov, fore_screenWidth, fore_screenHeight, fore_Far, fore_Near);
        float[] m_Z = MatrixStringToFloat(_V_Z_Any, fore_cameraPosition, fore_cameraRotation, fore_Fov, fore_screenWidth, fore_screenHeight, fore_Far, fore_Near);
        float[] m_N = MatrixStringToFloat(_V_N, fore_cameraPosition, fore_cameraRotation, fore_Fov, fore_screenWidth, fore_screenHeight, fore_Far, fore_Near);
        float[] m_P = MatrixStringToFloat(_P, fore_cameraPosition, fore_cameraRotation, fore_Fov, fore_screenWidth, fore_screenHeight, fore_Far, fore_Near);
        float[] m_R = MatrixStringToFloat(_R, fore_cameraPosition, fore_cameraRotation, fore_Fov, fore_screenWidth, fore_screenHeight, fore_Far, fore_Near);

        float[] m_V = CalculateMatrixMul(m_X, m_Y);
        m_V = CalculateMatrixMul(m_Z, m_V);
        m_V = CalculateMatrixMul(m_V, m_M);
        m_V = CalculateMatrixMul(m_N, m_V);
        float[] m_PR = CalculateMatrixMul(m_R, m_P);
        float[] m_VP = CalculateMatrixMul(m_PR, m_V);

        for (int i = 0; i < 16; i++)
        {
            fore_V[i] = m_V[i].ToString("0.########");
            fore_P[i] = m_PR[i].ToString("0.########");
            fore_VP[i] = m_VP[i].ToString("0.########");
        }
    }

    //输入VP矩阵 求相机参数
    private void ReCalculateVPToValue()
    {
        float defaultNumber = -9164662;
        Vector3 position = new Vector3(defaultNumber, defaultNumber, defaultNumber);
        Vector3 rotation = new Vector3(defaultNumber, defaultNumber, defaultNumber);
        float fov = defaultNumber;
        float aspect = defaultNumber;
        float far = defaultNumber;
        float near = defaultNumber;
        Formula._history.Clear();

        back_vp_cameraPosition = new string[3] { "-", "-", "-" };
        back_vp_cameraRotation = new string[3] { "-", "-", "-" };
        back_vp_aspect = "-";
        back_vp_Fov = "-";
        back_vp_Far = "-";
        back_vp_Near = "-";

        float[] input = CreateMatrix(back_vp_Line1, back_vp_Line2, back_vp_Line3, back_vp_Line4);
        string[] formula = CopyMatrix(_VPformula);
        int turn = 0;
        var extension1 = new List<string>();
        var extension2 = new List<string>();
        CalculateMatrixValue(ref formula, ref input, ref position, ref rotation, ref fov, ref aspect, ref far, ref near,
            ref turn, ref extension1, ref extension2);

        if (position.x != defaultNumber)
            back_vp_cameraPosition[0] = position.x.ToString("0.########");
        if (position.y != defaultNumber)
            back_vp_cameraPosition[1] = position.y.ToString("0.########");
        if (position.z != defaultNumber)
            back_vp_cameraPosition[2] = position.z.ToString("0.########");
        if (rotation.x != defaultNumber)
            back_vp_cameraRotation[0] = rotation.x.ToString("0.########");
        if (rotation.y != defaultNumber)
            back_vp_cameraRotation[1] = rotation.y.ToString("0.########");
        if (rotation.z != defaultNumber)
            back_vp_cameraRotation[2] = rotation.z.ToString("0.########");
        if (fov != defaultNumber)
            back_vp_Fov = fov.ToString();
        if (aspect != defaultNumber)
            back_vp_aspect = aspect.ToString();
        if (far != defaultNumber)
            back_vp_Far = far.ToString();
        if (near != defaultNumber)
            back_vp_Near = near.ToString();
    }

    //输入V矩阵求相机参数
    private void ReCalculateVToValue()
    {
        float defaultNumber = -9164662;
        Vector3 position = new Vector3(defaultNumber, defaultNumber, defaultNumber);
        Vector3 rotation = new Vector3(defaultNumber, defaultNumber, defaultNumber);
        float fov = defaultNumber;
        float aspect = defaultNumber;
        float far = defaultNumber;
        float near = defaultNumber;
        Formula._history.Clear();

        back_v_cameraPosition = new string[3] { "-", "-", "-" };
        back_v_cameraRotation = new string[3] { "-", "-", "-" };

        float[] input = CreateMatrix(back_v_Line1, back_v_Line2, back_v_Line3, back_v_Line4);
        string[] formula = CopyMatrix(_Vformula);
        int turn = 0;
        List<string> extensionNameMatch1 = new List<string>();
        List<string> extensionNameMatch2 = new List<string>();
        CalculateMatrixValue(ref formula, ref input, ref position, ref rotation, ref fov, ref aspect, ref far, ref near,
            ref turn, ref extensionNameMatch1, ref extensionNameMatch2);

        if (position.x != defaultNumber)
            back_v_cameraPosition[0] = position.x.ToString("0.########");
        if (position.y != defaultNumber)
            back_v_cameraPosition[1] = position.y.ToString("0.########");
        if (position.z != defaultNumber)
            back_v_cameraPosition[2] = position.z.ToString("0.########");
        if (rotation.x != defaultNumber)
            back_v_cameraRotation[0] = rotation.x.ToString("0.########");
        if (rotation.y != defaultNumber)
            back_v_cameraRotation[1] = rotation.y.ToString("0.########");
        if (rotation.z != defaultNumber)
            back_v_cameraRotation[2] = rotation.z.ToString("0.########");
    }

    //输入PR矩阵求相机参数
    private void ReCalculatePToValue()
    {
        float defaultNumber = -9164662;
        Vector3 position = new Vector3(defaultNumber, defaultNumber, defaultNumber);
        Vector3 rotation = new Vector3(defaultNumber, defaultNumber, defaultNumber);
        float fov = defaultNumber;
        float aspect = defaultNumber;
        float far = defaultNumber;
        float near = defaultNumber;
        Formula._history.Clear();

        back_p_aspect = "-";
        back_p_Fov = "-";
        back_p_Far = "-";
        back_p_Near = "-";

        float[] input = CreateMatrix(back_p_Line1, back_p_Line2, back_p_Line3, back_p_Line4);
        string[] formula = CopyMatrix(_PRformula);
        int turn = 0;
        List<string> extensionNameMatch1 = new List<string>();
        List<string> extensionNameMatch2 = new List<string>();
        CalculateMatrixValue(ref formula, ref input, ref position, ref rotation, ref fov, ref aspect, ref far, ref near,
            ref turn, ref extensionNameMatch1, ref extensionNameMatch2);

        if (fov != defaultNumber)
            back_p_Fov = fov.ToString();
        if (aspect != defaultNumber)
            back_p_aspect = aspect.ToString();
        if (far != defaultNumber)
            back_p_Far = far.ToString();
        if (near != defaultNumber)
            back_p_Near = near.ToString();
    }

    void OnGUI()
    {
        GUIStyle style = new GUIStyle(GUI.skin.button);
        style.normal.textColor = Color.red;
        int index1 = 0, index2 = 1, index3 = 2, index4 = 3;
        float preLabelWidth;
        int width1 = 200, width2 = 100, width3 = 200, width4 = 600;

        //显示参考信息
        {
            EditorGUILayout.BeginHorizontal();
            {
                EditorGUILayout.LabelField("计算矩阵V = N(反转Z轴) * Z * X * Y * M", GUILayout.Width(250));
                EditorGUI.BeginChangeCheck();
                preLabelWidth = EditorGUIUtility.labelWidth;
                EditorGUIUtility.labelWidth = 80;
                _isCameraRotateZisZero = EditorGUILayout.Toggle("旋转Z是否为0", _isCameraRotateZisZero, GUILayout.Width(150));
                EditorGUIUtility.labelWidth = preLabelWidth;
                if (EditorGUI.EndChangeCheck())
                    ReCalculateMatrix();

                preLabelWidth = EditorGUIUtility.labelWidth;
                EditorGUIUtility.labelWidth = 135;
                _showV_MYXZN = EditorGUILayout.Toggle("是否显示V`/V/P/VP矩阵", _showV_MYXZN, GUILayout.Width(150));
                EditorGUIUtility.labelWidth = 0;
                _showV_V = EditorGUILayout.Toggle(_showV_V, GUILayout.Width(13));
                _showP = EditorGUILayout.Toggle(_showP, GUILayout.Width(13));
                _showVP = EditorGUILayout.Toggle(_showVP, GUILayout.Width(13));
                EditorGUIUtility.labelWidth = preLabelWidth;
            }
            EditorGUILayout.EndHorizontal();

            EditorGUILayout.BeginHorizontal();
            {
                EditorGUILayout.LabelField("计算矩阵VP = R(平台矫正) * P * V", GUILayout.Width(200));
                EditorGUI.BeginChangeCheck();
                preLabelWidth = EditorGUIUtility.labelWidth;
                EditorGUIUtility.labelWidth = 80;
                _isDx = EditorGUILayout.Toggle("是否为DX平台", _isDx, GUILayout.Width(150));
                EditorGUIUtility.labelWidth = 62;
                _showSimpleVersion = EditorGUILayout.Toggle("显示简化版", _showSimpleVersion);
                EditorGUIUtility.labelWidth = preLabelWidth;
                if (EditorGUI.EndChangeCheck())
                    ReCalculateMatrix();
            }
            EditorGUILayout.EndHorizontal();

            if (_showV_MYXZN)
            {
                EditorGUILayout.Space();
                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.LabelField("矩阵M：", GUILayout.Width(200));
                EditorGUILayout.LabelField("矩阵Y：", GUILayout.Width(200));
                EditorGUILayout.LabelField("矩阵X：", GUILayout.Width(200));
                EditorGUILayout.LabelField("矩阵Z：", GUILayout.Width(200));
                EditorGUILayout.LabelField("矩阵N：", GUILayout.Width(200));
                EditorGUILayout.EndHorizontal();

                //第一排
                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(200));
                EditorGUILayout.LabelField(_V_M[index1], GUILayout.Width(40)); EditorGUILayout.LabelField(_V_M[index2], GUILayout.Width(40));
                EditorGUILayout.LabelField(_V_M[index3], GUILayout.Width(40)); EditorGUILayout.LabelField(_V_M[index4], GUILayout.Width(40));
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(200));
                EditorGUILayout.LabelField(_V_Y[index1], GUILayout.Width(40)); EditorGUILayout.LabelField(_V_Y[index2], GUILayout.Width(40));
                EditorGUILayout.LabelField(_V_Y[index3], GUILayout.Width(60)); EditorGUILayout.LabelField(_V_Y[index4], GUILayout.Width(40));
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(200));
                EditorGUILayout.LabelField(_V_X[index1], GUILayout.Width(40)); EditorGUILayout.LabelField(_V_X[index2], GUILayout.Width(60));
                EditorGUILayout.LabelField(_V_X[index3], GUILayout.Width(40)); EditorGUILayout.LabelField(_V_X[index4], GUILayout.Width(40));
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(200));
                EditorGUILayout.LabelField(_V_Z[index1], GUILayout.Width(40)); EditorGUILayout.LabelField(_V_Z[index2], GUILayout.Width(40));
                EditorGUILayout.LabelField(_V_Z[index3], GUILayout.Width(40)); EditorGUILayout.LabelField(_V_Z[index4], GUILayout.Width(40));
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(200));
                EditorGUILayout.LabelField(_V_N[index1], GUILayout.Width(40)); EditorGUILayout.LabelField(_V_N[index2], GUILayout.Width(40));
                EditorGUILayout.LabelField(_V_N[index3], GUILayout.Width(40)); EditorGUILayout.LabelField(_V_N[index4], GUILayout.Width(40));
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.EndHorizontal();

                //第二排
                index1 += 4; index2 += 4; index3 += 4; index4 += 4;
                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(200));
                EditorGUILayout.LabelField(_V_M[index1], GUILayout.Width(40)); EditorGUILayout.LabelField(_V_M[index2], GUILayout.Width(40));
                EditorGUILayout.LabelField(_V_M[index3], GUILayout.Width(40)); EditorGUILayout.LabelField(_V_M[index4], GUILayout.Width(40));
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(200));
                EditorGUILayout.LabelField(_V_Y[index1], GUILayout.Width(40)); EditorGUILayout.LabelField(_V_Y[index2], GUILayout.Width(40));
                EditorGUILayout.LabelField(_V_Y[index3], GUILayout.Width(60)); EditorGUILayout.LabelField(_V_Y[index4], GUILayout.Width(40));
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(200));
                EditorGUILayout.LabelField(_V_X[index1], GUILayout.Width(40)); EditorGUILayout.LabelField(_V_X[index2], GUILayout.Width(60));
                EditorGUILayout.LabelField(_V_X[index3], GUILayout.Width(40)); EditorGUILayout.LabelField(_V_X[index4], GUILayout.Width(40));
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(200));
                EditorGUILayout.LabelField(_V_Z[index1], GUILayout.Width(40)); EditorGUILayout.LabelField(_V_Z[index2], GUILayout.Width(40));
                EditorGUILayout.LabelField(_V_Z[index3], GUILayout.Width(40)); EditorGUILayout.LabelField(_V_Z[index4], GUILayout.Width(40));
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(200));
                EditorGUILayout.LabelField(_V_N[index1], GUILayout.Width(40)); EditorGUILayout.LabelField(_V_N[index2], GUILayout.Width(40));
                EditorGUILayout.LabelField(_V_N[index3], GUILayout.Width(40)); EditorGUILayout.LabelField(_V_N[index4], GUILayout.Width(40));
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.EndHorizontal();

                //第三排
                index1 += 4; index2 += 4; index3 += 4; index4 += 4;
                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(200));
                EditorGUILayout.LabelField(_V_M[index1], GUILayout.Width(40)); EditorGUILayout.LabelField(_V_M[index2], GUILayout.Width(40));
                EditorGUILayout.LabelField(_V_M[index3], GUILayout.Width(40)); EditorGUILayout.LabelField(_V_M[index4], GUILayout.Width(40));
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(200));
                EditorGUILayout.LabelField(_V_Y[index1], GUILayout.Width(40)); EditorGUILayout.LabelField(_V_Y[index2], GUILayout.Width(40));
                EditorGUILayout.LabelField(_V_Y[index3], GUILayout.Width(60)); EditorGUILayout.LabelField(_V_Y[index4], GUILayout.Width(40));
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(200));
                EditorGUILayout.LabelField(_V_X[index1], GUILayout.Width(40)); EditorGUILayout.LabelField(_V_X[index2], GUILayout.Width(60));
                EditorGUILayout.LabelField(_V_X[index3], GUILayout.Width(40)); EditorGUILayout.LabelField(_V_X[index4], GUILayout.Width(40));
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(200));
                EditorGUILayout.LabelField(_V_Z[index1], GUILayout.Width(40)); EditorGUILayout.LabelField(_V_Z[index2], GUILayout.Width(40));
                EditorGUILayout.LabelField(_V_Z[index3], GUILayout.Width(40)); EditorGUILayout.LabelField(_V_Z[index4], GUILayout.Width(40));
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(200));
                EditorGUILayout.LabelField(_V_N[index1], GUILayout.Width(40)); EditorGUILayout.LabelField(_V_N[index2], GUILayout.Width(40));
                EditorGUILayout.LabelField(_V_N[index3], GUILayout.Width(40)); EditorGUILayout.LabelField(_V_N[index4], GUILayout.Width(40));
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.EndHorizontal();

                //第四排
                index1 += 4; index2 += 4; index3 += 4; index4 += 4;
                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(200));
                EditorGUILayout.LabelField(_V_M[index1], GUILayout.Width(40)); EditorGUILayout.LabelField(_V_M[index2], GUILayout.Width(40));
                EditorGUILayout.LabelField(_V_M[index3], GUILayout.Width(40)); EditorGUILayout.LabelField(_V_M[index4], GUILayout.Width(40));
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(200));
                EditorGUILayout.LabelField(_V_Y[index1], GUILayout.Width(40)); EditorGUILayout.LabelField(_V_Y[index2], GUILayout.Width(40));
                EditorGUILayout.LabelField(_V_Y[index3], GUILayout.Width(60)); EditorGUILayout.LabelField(_V_Y[index4], GUILayout.Width(40));
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(200));
                EditorGUILayout.LabelField(_V_X[index1], GUILayout.Width(40)); EditorGUILayout.LabelField(_V_X[index2], GUILayout.Width(60));
                EditorGUILayout.LabelField(_V_X[index3], GUILayout.Width(40)); EditorGUILayout.LabelField(_V_X[index4], GUILayout.Width(40));
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(200));
                EditorGUILayout.LabelField(_V_Z[index1], GUILayout.Width(40)); EditorGUILayout.LabelField(_V_Z[index2], GUILayout.Width(40));
                EditorGUILayout.LabelField(_V_Z[index3], GUILayout.Width(40)); EditorGUILayout.LabelField(_V_Z[index4], GUILayout.Width(40));
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(200));
                EditorGUILayout.LabelField(_V_N[index1], GUILayout.Width(40)); EditorGUILayout.LabelField(_V_N[index2], GUILayout.Width(40));
                EditorGUILayout.LabelField(_V_N[index3], GUILayout.Width(40)); EditorGUILayout.LabelField(_V_N[index4], GUILayout.Width(40));
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.EndHorizontal();
            }

            if (_showV_V)
            {
                EditorGUILayout.Space();
                index1 = 0; index2 = 1; index3 = 2; index4 = 3;
                EditorGUILayout.LabelField("矩阵V：");
                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.LabelField(_V[index1], GUILayout.Width(width1)); EditorGUILayout.LabelField(_V[index2], GUILayout.Width(width2));
                EditorGUILayout.LabelField(_V[index3], GUILayout.Width(width3)); EditorGUILayout.LabelField(_V[index4], GUILayout.Width(width4));
                EditorGUILayout.EndHorizontal();
                index1 += 4; index2 += 4; index3 += 4; index4 += 4;
                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.LabelField(_V[index1], GUILayout.Width(width1)); EditorGUILayout.LabelField(_V[index2], GUILayout.Width(width2));
                EditorGUILayout.LabelField(_V[index3], GUILayout.Width(width3)); EditorGUILayout.LabelField(_V[index4], GUILayout.Width(width4));
                EditorGUILayout.EndHorizontal();
                index1 += 4; index2 += 4; index3 += 4; index4 += 4;
                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.LabelField(_V[index1], GUILayout.Width(width1)); EditorGUILayout.LabelField(_V[index2], GUILayout.Width(width2));
                EditorGUILayout.LabelField(_V[index3], GUILayout.Width(width3)); EditorGUILayout.LabelField(_V[index4], GUILayout.Width(width4));
                EditorGUILayout.EndHorizontal();
                index1 += 4; index2 += 4; index3 += 4; index4 += 4;
                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.LabelField(_V[index1], GUILayout.Width(width1)); EditorGUILayout.LabelField(_V[index2], GUILayout.Width(width2));
                EditorGUILayout.LabelField(_V[index3], GUILayout.Width(width3)); EditorGUILayout.LabelField(_V[index4], GUILayout.Width(width4));
                EditorGUILayout.EndHorizontal();
            }

            if (_showP)
            {
                EditorGUILayout.Space();
                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.LabelField("矩阵P：", GUILayout.Width(610));
                EditorGUILayout.LabelField("矩阵R：", GUILayout.Width(200));
                EditorGUILayout.LabelField("矩阵PR：", GUILayout.Width(200));
                EditorGUILayout.EndHorizontal();

                //第一排
                index1 = 0; index2 = 1; index3 = 2; index4 = 3;
                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(600));
                EditorGUILayout.LabelField(_P[index1], GUILayout.Width(120)); EditorGUILayout.LabelField(_P[index2], GUILayout.Width(80));
                EditorGUILayout.LabelField(_P[index3], GUILayout.Width(200)); EditorGUILayout.LabelField(_P[index4], GUILayout.Width(200));
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(200));
                EditorGUILayout.LabelField(_R[index1], GUILayout.Width(40)); EditorGUILayout.LabelField(_R[index2], GUILayout.Width(40));
                EditorGUILayout.LabelField(_R[index3], GUILayout.Width(40)); EditorGUILayout.LabelField(_R[index4], GUILayout.Width(40));
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(200));
                EditorGUILayout.LabelField(_PR[index1], GUILayout.Width(120)); EditorGUILayout.LabelField(_PR[index2], GUILayout.Width(80));
                EditorGUILayout.LabelField(_PR[index3], GUILayout.Width(260)); EditorGUILayout.LabelField(_PR[index4], GUILayout.Width(230));
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.EndHorizontal();

                //第二排
                index1 += 4; index2 += 4; index3 += 4; index4 += 4;
                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(600));
                EditorGUILayout.LabelField(_P[index1], GUILayout.Width(120)); EditorGUILayout.LabelField(_P[index2], GUILayout.Width(80));
                EditorGUILayout.LabelField(_P[index3], GUILayout.Width(200)); EditorGUILayout.LabelField(_P[index4], GUILayout.Width(200));
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(200));
                EditorGUILayout.LabelField(_R[index1], GUILayout.Width(40)); EditorGUILayout.LabelField(_R[index2], GUILayout.Width(40));
                EditorGUILayout.LabelField(_R[index3], GUILayout.Width(40)); EditorGUILayout.LabelField(_R[index4], GUILayout.Width(40));
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(200));
                EditorGUILayout.LabelField(_PR[index1], GUILayout.Width(120)); EditorGUILayout.LabelField(_PR[index2], GUILayout.Width(80));
                EditorGUILayout.LabelField(_PR[index3], GUILayout.Width(260)); EditorGUILayout.LabelField(_PR[index4], GUILayout.Width(230));
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.EndHorizontal();

                //第三排
                index1 += 4; index2 += 4; index3 += 4; index4 += 4;
                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(600));
                EditorGUILayout.LabelField(_P[index1], GUILayout.Width(120)); EditorGUILayout.LabelField(_P[index2], GUILayout.Width(80));
                EditorGUILayout.LabelField(_P[index3], GUILayout.Width(200)); EditorGUILayout.LabelField(_P[index4], GUILayout.Width(200));
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(200));
                EditorGUILayout.LabelField(_R[index1], GUILayout.Width(40)); EditorGUILayout.LabelField(_R[index2], GUILayout.Width(40));
                EditorGUILayout.LabelField(_R[index3], GUILayout.Width(40)); EditorGUILayout.LabelField(_R[index4], GUILayout.Width(40));
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(200));
                EditorGUILayout.LabelField(_PR[index1], GUILayout.Width(120)); EditorGUILayout.LabelField(_PR[index2], GUILayout.Width(80));
                EditorGUILayout.LabelField(_PR[index3], GUILayout.Width(260)); EditorGUILayout.LabelField(_PR[index4], GUILayout.Width(230));
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.EndHorizontal();

                //第四排
                index1 += 4; index2 += 4; index3 += 4; index4 += 4;
                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(600));
                EditorGUILayout.LabelField(_P[index1], GUILayout.Width(120)); EditorGUILayout.LabelField(_P[index2], GUILayout.Width(80));
                EditorGUILayout.LabelField(_P[index3], GUILayout.Width(200)); EditorGUILayout.LabelField(_P[index4], GUILayout.Width(200));
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(200));
                EditorGUILayout.LabelField(_R[index1], GUILayout.Width(40)); EditorGUILayout.LabelField(_R[index2], GUILayout.Width(40));
                EditorGUILayout.LabelField(_R[index3], GUILayout.Width(40)); EditorGUILayout.LabelField(_R[index4], GUILayout.Width(40));
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(200));
                EditorGUILayout.LabelField(_PR[index1], GUILayout.Width(120)); EditorGUILayout.LabelField(_PR[index2], GUILayout.Width(80));
                EditorGUILayout.LabelField(_PR[index3], GUILayout.Width(260)); EditorGUILayout.LabelField(_PR[index4], GUILayout.Width(230));
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.EndHorizontal();
            }

            if (_showVP)
            {
                EditorGUILayout.Space();
                width1 = 340; width2 = 280; width3 = 350; width4 = 1400;
                index1 = 0; index2 = 1; index3 = 2; index4 = 3;

                EditorGUILayout.LabelField("矩阵VP：");

                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.LabelField(_VP[index1], GUILayout.Width(width1)); EditorGUILayout.LabelField(_VP[index2], GUILayout.Width(width2));
                EditorGUILayout.LabelField(_VP[index3], GUILayout.Width(width3)); EditorGUILayout.LabelField(_VP[index4], GUILayout.Width(width4));
                EditorGUILayout.EndHorizontal();
                index1 += 4; index2 += 4; index3 += 4; index4 += 4;
                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.LabelField(_VP[index1], GUILayout.Width(width1)); EditorGUILayout.LabelField(_VP[index2], GUILayout.Width(width2));
                EditorGUILayout.LabelField(_VP[index3], GUILayout.Width(width3)); EditorGUILayout.LabelField(_VP[index4], GUILayout.Width(width4));
                EditorGUILayout.EndHorizontal();
                index1 += 4; index2 += 4; index3 += 4; index4 += 4;
                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.LabelField(_VP[index1], GUILayout.Width(width1)); EditorGUILayout.LabelField(_VP[index2], GUILayout.Width(width2));
                EditorGUILayout.LabelField(_VP[index3], GUILayout.Width(width3)); EditorGUILayout.LabelField(_VP[index4], GUILayout.Width(width4));
                EditorGUILayout.EndHorizontal();
                index1 += 4; index2 += 4; index3 += 4; index4 += 4;
                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.LabelField(_VP[index1], GUILayout.Width(width1)); EditorGUILayout.LabelField(_VP[index2], GUILayout.Width(width2));
                EditorGUILayout.LabelField(_VP[index3], GUILayout.Width(width3)); EditorGUILayout.LabelField(_VP[index4], GUILayout.Width(width4));
                EditorGUILayout.EndHorizontal();
            }
        }

        //计算工具
        {
            //输入相机参数求矩阵
            {
                width1 = 80; width2 = 80; width3 = 80; width4 = 80;
                index1 = 0; index2 = 1; index3 = 2; index4 = 3;
                EditorGUILayout.Space();
                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.LabelField("输入相机参数", GUILayout.Width(200));
                EditorGUILayout.LabelField("矩阵V", GUILayout.Width(360));
                EditorGUILayout.LabelField("矩阵P", GUILayout.Width(360));
                EditorGUILayout.LabelField("矩阵VP", GUILayout.Width(360));
                EditorGUILayout.EndHorizontal();

                //第一排
                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(200));
                EditorGUILayout.LabelField("坐标", GUILayout.Width(40));
                EditorGUI.BeginChangeCheck();
                fore_cameraPosition.x = EditorGUILayout.FloatField(fore_cameraPosition.x, GUILayout.Width(40));
                fore_cameraPosition.y = EditorGUILayout.FloatField(fore_cameraPosition.y, GUILayout.Width(40));
                fore_cameraPosition.z = EditorGUILayout.FloatField(fore_cameraPosition.z, GUILayout.Width(40));
                if (EditorGUI.EndChangeCheck())
                    ReCalculateValueToMatrix();
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(360));
                EditorGUILayout.LabelField(fore_V[index1], GUILayout.Width(width1)); EditorGUILayout.LabelField(fore_V[index2], GUILayout.Width(width2));
                EditorGUILayout.LabelField(fore_V[index3], GUILayout.Width(width3)); EditorGUILayout.LabelField(fore_V[index4], GUILayout.Width(width4));
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(360));
                EditorGUILayout.LabelField(fore_P[index1], GUILayout.Width(width1)); EditorGUILayout.LabelField(fore_P[index2], GUILayout.Width(width2));
                EditorGUILayout.LabelField(fore_P[index3], GUILayout.Width(width3)); EditorGUILayout.LabelField(fore_P[index4], GUILayout.Width(width4));
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(360));
                EditorGUILayout.LabelField(fore_VP[index1], GUILayout.Width(width1)); EditorGUILayout.LabelField(fore_VP[index2], GUILayout.Width(width2));
                EditorGUILayout.LabelField(fore_VP[index3], GUILayout.Width(width3)); EditorGUILayout.LabelField(fore_VP[index4], GUILayout.Width(width4));
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.EndHorizontal();

                //第二排 
                index1 += 4; index2 += 4; index3 += 4; index4 += 4;
                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(200));
                EditorGUILayout.LabelField("旋转", GUILayout.Width(40));
                EditorGUI.BeginChangeCheck();
                fore_cameraRotation.x = EditorGUILayout.FloatField(fore_cameraRotation.x, GUILayout.Width(40));
                fore_cameraRotation.y = EditorGUILayout.FloatField(fore_cameraRotation.y, GUILayout.Width(40));
                fore_cameraRotation.z = EditorGUILayout.FloatField(fore_cameraRotation.z, GUILayout.Width(40));
                if (EditorGUI.EndChangeCheck())
                    ReCalculateValueToMatrix();
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(360));
                EditorGUILayout.LabelField(fore_V[index1], GUILayout.Width(width1)); EditorGUILayout.LabelField(fore_V[index2], GUILayout.Width(width2));
                EditorGUILayout.LabelField(fore_V[index3], GUILayout.Width(width3)); EditorGUILayout.LabelField(fore_V[index4], GUILayout.Width(width4));
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(360));
                EditorGUILayout.LabelField(fore_P[index1], GUILayout.Width(width1)); EditorGUILayout.LabelField(fore_P[index2], GUILayout.Width(width2));
                EditorGUILayout.LabelField(fore_P[index3], GUILayout.Width(width3)); EditorGUILayout.LabelField(fore_P[index4], GUILayout.Width(width4));
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(360));
                EditorGUILayout.LabelField(fore_VP[index1], GUILayout.Width(width1)); EditorGUILayout.LabelField(fore_VP[index2], GUILayout.Width(width2));
                EditorGUILayout.LabelField(fore_VP[index3], GUILayout.Width(width3)); EditorGUILayout.LabelField(fore_VP[index4], GUILayout.Width(width4));
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.EndHorizontal();

                //第三排
                index1 += 4; index2 += 4; index3 += 4; index4 += 4;
                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(200));
                EditorGUILayout.LabelField("Fov/W&H", GUILayout.Width(60));
                EditorGUI.BeginChangeCheck();
                fore_Fov = EditorGUILayout.IntField(fore_Fov, GUILayout.Width(30));
                fore_screenWidth = EditorGUILayout.IntField(fore_screenWidth, GUILayout.Width(35));
                fore_screenHeight = EditorGUILayout.IntField(fore_screenHeight, GUILayout.Width(35));
                if (EditorGUI.EndChangeCheck())
                    ReCalculateValueToMatrix();
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(360));
                EditorGUILayout.LabelField(fore_V[index1], GUILayout.Width(width1)); EditorGUILayout.LabelField(fore_V[index2], GUILayout.Width(width2));
                EditorGUILayout.LabelField(fore_V[index3], GUILayout.Width(width3)); EditorGUILayout.LabelField(fore_V[index4], GUILayout.Width(width4));
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(360));
                EditorGUILayout.LabelField(fore_P[index1], GUILayout.Width(width1)); EditorGUILayout.LabelField(fore_P[index2], GUILayout.Width(width2));
                EditorGUILayout.LabelField(fore_P[index3], GUILayout.Width(width3)); EditorGUILayout.LabelField(fore_P[index4], GUILayout.Width(width4));
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(360));
                EditorGUILayout.LabelField(fore_VP[index1], GUILayout.Width(width1)); EditorGUILayout.LabelField(fore_VP[index2], GUILayout.Width(width2));
                EditorGUILayout.LabelField(fore_VP[index3], GUILayout.Width(width3)); EditorGUILayout.LabelField(fore_VP[index4], GUILayout.Width(width4));
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.EndHorizontal();

                //第四排
                index1 += 4; index2 += 4; index3 += 4; index4 += 4;
                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(200));
                EditorGUILayout.LabelField("Far/Near", GUILayout.Width(63));
                EditorGUI.BeginChangeCheck();
                fore_Far = EditorGUILayout.FloatField(fore_Far, GUILayout.Width(55));
                fore_Near = EditorGUILayout.FloatField(fore_Near, GUILayout.Width(45));
                if (EditorGUI.EndChangeCheck())
                    ReCalculateValueToMatrix();
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(360));
                EditorGUILayout.LabelField(fore_V[index1], GUILayout.Width(width1)); EditorGUILayout.LabelField(fore_V[index2], GUILayout.Width(width2));
                EditorGUILayout.LabelField(fore_V[index3], GUILayout.Width(width3)); EditorGUILayout.LabelField(fore_V[index4], GUILayout.Width(width4));
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(360));
                EditorGUILayout.LabelField(fore_P[index1], GUILayout.Width(width1)); EditorGUILayout.LabelField(fore_P[index2], GUILayout.Width(width2));
                EditorGUILayout.LabelField(fore_P[index3], GUILayout.Width(width3)); EditorGUILayout.LabelField(fore_P[index4], GUILayout.Width(width4));
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(360));
                EditorGUILayout.LabelField(fore_VP[index1], GUILayout.Width(width1)); EditorGUILayout.LabelField(fore_VP[index2], GUILayout.Width(width2));
                EditorGUILayout.LabelField(fore_VP[index3], GUILayout.Width(width3)); EditorGUILayout.LabelField(fore_VP[index4], GUILayout.Width(width4));
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.EndHorizontal();
            }

            //输入VP矩阵求参数
            {
                EditorGUILayout.Space();
                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.LabelField("输入矩阵VP", GUILayout.Width(240));
                EditorGUILayout.LabelField("相机参数", GUILayout.Width(240));
                EditorGUILayout.EndHorizontal();

                //第一排
                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(240));
                EditorGUI.BeginChangeCheck();
                back_vp_Line1.x = EditorGUILayout.FloatField(back_vp_Line1.x, GUILayout.Width(50));
                back_vp_Line1.y = EditorGUILayout.FloatField(back_vp_Line1.y, GUILayout.Width(50));
                back_vp_Line1.z = EditorGUILayout.FloatField(back_vp_Line1.z, GUILayout.Width(50));
                back_vp_Line1.w = EditorGUILayout.FloatField(back_vp_Line1.w, GUILayout.Width(50));
                if (EditorGUI.EndChangeCheck())
                    ReCalculateVPToValue();
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(240));
                EditorGUILayout.LabelField("坐标", GUILayout.Width(80));
                EditorGUILayout.LabelField($"({back_vp_cameraPosition[0]}, {back_vp_cameraPosition[1]}, {back_vp_cameraPosition[2]})");
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.EndHorizontal();

                //第二排 
                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(240));
                EditorGUI.BeginChangeCheck();
                back_vp_Line2.x = EditorGUILayout.FloatField(back_vp_Line2.x, GUILayout.Width(50));
                back_vp_Line2.y = EditorGUILayout.FloatField(back_vp_Line2.y, GUILayout.Width(50));
                back_vp_Line2.z = EditorGUILayout.FloatField(back_vp_Line2.z, GUILayout.Width(50));
                back_vp_Line2.w = EditorGUILayout.FloatField(back_vp_Line2.w, GUILayout.Width(50));
                if (EditorGUI.EndChangeCheck())
                    ReCalculateVPToValue();
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(240));
                EditorGUILayout.LabelField("旋转", GUILayout.Width(80));
                EditorGUILayout.LabelField($"({back_vp_cameraRotation[0]}, {back_vp_cameraRotation[1]}, {back_vp_cameraRotation[2]})");
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.EndHorizontal();

                //第三排
                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(240));
                EditorGUI.BeginChangeCheck();
                back_vp_Line3.x = EditorGUILayout.FloatField(back_vp_Line3.x, GUILayout.Width(50));
                back_vp_Line3.y = EditorGUILayout.FloatField(back_vp_Line3.y, GUILayout.Width(50));
                back_vp_Line3.z = EditorGUILayout.FloatField(back_vp_Line3.z, GUILayout.Width(50));
                back_vp_Line3.w = EditorGUILayout.FloatField(back_vp_Line3.w, GUILayout.Width(50));
                if (EditorGUI.EndChangeCheck())
                    ReCalculateVPToValue();
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(240));
                EditorGUILayout.LabelField("Fov/Aspect", GUILayout.Width(80));
                EditorGUILayout.LabelField($"{back_vp_Fov} / {back_vp_aspect}");
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.EndHorizontal();

                //第四排
                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(240));
                EditorGUI.BeginChangeCheck();
                back_vp_Line4.x = EditorGUILayout.FloatField(back_vp_Line4.x, GUILayout.Width(50));
                back_vp_Line4.y = EditorGUILayout.FloatField(back_vp_Line4.y, GUILayout.Width(50));
                back_vp_Line4.z = EditorGUILayout.FloatField(back_vp_Line4.z, GUILayout.Width(50));
                back_vp_Line4.w = EditorGUILayout.FloatField(back_vp_Line4.w, GUILayout.Width(50));
                if (EditorGUI.EndChangeCheck())
                    ReCalculateVPToValue();
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(240));
                EditorGUILayout.LabelField("Far/Near", GUILayout.Width(80));
                EditorGUILayout.LabelField($"{back_vp_Far} / {back_vp_Near}");
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.EndHorizontal();
            }

            //输入V矩阵求参数
            {
                EditorGUILayout.Space();
                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.LabelField("输入矩阵V", GUILayout.Width(240));
                EditorGUILayout.LabelField("相机参数", GUILayout.Width(240));
                EditorGUILayout.EndHorizontal();

                //第一排
                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(240));
                EditorGUI.BeginChangeCheck();
                back_v_Line1.x = EditorGUILayout.FloatField(back_v_Line1.x, GUILayout.Width(50));
                back_v_Line1.y = EditorGUILayout.FloatField(back_v_Line1.y, GUILayout.Width(50));
                back_v_Line1.z = EditorGUILayout.FloatField(back_v_Line1.z, GUILayout.Width(50));
                back_v_Line1.w = EditorGUILayout.FloatField(back_v_Line1.w, GUILayout.Width(50));
                if (EditorGUI.EndChangeCheck())
                    ReCalculateVToValue();
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(240));
                EditorGUILayout.LabelField("坐标", GUILayout.Width(80));
                EditorGUILayout.LabelField($"({back_v_cameraPosition[0]}, {back_v_cameraPosition[1]}, {back_v_cameraPosition[2]})");
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.EndHorizontal();

                //第二排 
                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(240));
                EditorGUI.BeginChangeCheck();
                back_v_Line2.x = EditorGUILayout.FloatField(back_v_Line2.x, GUILayout.Width(50));
                back_v_Line2.y = EditorGUILayout.FloatField(back_v_Line2.y, GUILayout.Width(50));
                back_v_Line2.z = EditorGUILayout.FloatField(back_v_Line2.z, GUILayout.Width(50));
                back_v_Line2.w = EditorGUILayout.FloatField(back_v_Line2.w, GUILayout.Width(50));
                if (EditorGUI.EndChangeCheck())
                    ReCalculateVToValue();
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(240));
                EditorGUILayout.LabelField("旋转", GUILayout.Width(80));
                EditorGUILayout.LabelField($"({back_v_cameraRotation[0]}, {back_v_cameraRotation[1]}, {back_v_cameraRotation[2]})");
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.EndHorizontal();

                //第三排
                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(240));
                EditorGUI.BeginChangeCheck();
                back_v_Line3.x = EditorGUILayout.FloatField(back_v_Line3.x, GUILayout.Width(50));
                back_v_Line3.y = EditorGUILayout.FloatField(back_v_Line3.y, GUILayout.Width(50));
                back_v_Line3.z = EditorGUILayout.FloatField(back_v_Line3.z, GUILayout.Width(50));
                back_v_Line3.w = EditorGUILayout.FloatField(back_v_Line3.w, GUILayout.Width(50));
                if (EditorGUI.EndChangeCheck())
                    ReCalculateVToValue();
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.EndHorizontal();

                //第四排
                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(240));
                EditorGUI.BeginChangeCheck();
                back_v_Line4.x = EditorGUILayout.FloatField(back_v_Line4.x, GUILayout.Width(50));
                back_v_Line4.y = EditorGUILayout.FloatField(back_v_Line4.y, GUILayout.Width(50));
                back_v_Line4.z = EditorGUILayout.FloatField(back_v_Line4.z, GUILayout.Width(50));
                back_v_Line4.w = EditorGUILayout.FloatField(back_v_Line4.w, GUILayout.Width(50));
                if (EditorGUI.EndChangeCheck())
                    ReCalculateVToValue();
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.EndHorizontal();
            }

            //输入P矩阵求参数
            {
                EditorGUILayout.Space();
                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.LabelField("输入矩阵P", GUILayout.Width(240));
                EditorGUILayout.LabelField("相机参数", GUILayout.Width(240));
                EditorGUILayout.EndHorizontal();

                //第一排
                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(240));
                EditorGUI.BeginChangeCheck();
                back_p_Line1.x = EditorGUILayout.FloatField(back_p_Line1.x, GUILayout.Width(50));
                back_p_Line1.y = EditorGUILayout.FloatField(back_p_Line1.y, GUILayout.Width(50));
                back_p_Line1.z = EditorGUILayout.FloatField(back_p_Line1.z, GUILayout.Width(50));
                back_p_Line1.w = EditorGUILayout.FloatField(back_p_Line1.w, GUILayout.Width(50));
                if (EditorGUI.EndChangeCheck())
                    ReCalculatePToValue();
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(240));
                EditorGUILayout.LabelField("Fov/Aspect", GUILayout.Width(80));
                EditorGUILayout.LabelField($"{back_p_Fov} / {back_p_aspect}");
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.EndHorizontal();

                //第二排 
                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(240));
                EditorGUI.BeginChangeCheck();
                back_p_Line2.x = EditorGUILayout.FloatField(back_p_Line2.x, GUILayout.Width(50));
                back_p_Line2.y = EditorGUILayout.FloatField(back_p_Line2.y, GUILayout.Width(50));
                back_p_Line2.z = EditorGUILayout.FloatField(back_p_Line2.z, GUILayout.Width(50));
                back_p_Line2.w = EditorGUILayout.FloatField(back_p_Line2.w, GUILayout.Width(50));
                if (EditorGUI.EndChangeCheck())
                    ReCalculatePToValue();
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(240));
                EditorGUILayout.LabelField("Far/Near", GUILayout.Width(80));
                EditorGUILayout.LabelField($"{back_p_Far} / {back_p_Near}");
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.EndHorizontal();

                //第三排
                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(240));
                EditorGUI.BeginChangeCheck();
                back_p_Line3.x = EditorGUILayout.FloatField(back_p_Line3.x, GUILayout.Width(50));
                back_p_Line3.y = EditorGUILayout.FloatField(back_p_Line3.y, GUILayout.Width(50));
                back_p_Line3.z = EditorGUILayout.FloatField(back_p_Line3.z, GUILayout.Width(50));
                back_p_Line3.w = EditorGUILayout.FloatField(back_p_Line3.w, GUILayout.Width(50));
                if (EditorGUI.EndChangeCheck())
                    ReCalculatePToValue();
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.EndHorizontal();

                //第四排
                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.BeginHorizontal(GUILayout.Width(240));
                EditorGUI.BeginChangeCheck();
                back_p_Line4.x = EditorGUILayout.FloatField(back_p_Line4.x, GUILayout.Width(50));
                back_p_Line4.y = EditorGUILayout.FloatField(back_p_Line4.y, GUILayout.Width(50));
                back_p_Line4.z = EditorGUILayout.FloatField(back_p_Line4.z, GUILayout.Width(50));
                back_p_Line4.w = EditorGUILayout.FloatField(back_p_Line4.w, GUILayout.Width(50));
                if (EditorGUI.EndChangeCheck())
                    ReCalculatePToValue();
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.EndHorizontal();
            }
        }
    }
    #endregion

    #region 解析式公式运算
    class Formula
    {
        //假设只存在加法、乘法
        //运算符号只剩下+ * ( )     通过符号匹配来进行运算     解析时不保存*这个符号
        public List<string> _childs = new List<string>(); //将字符串拆分成很多个字符
        public List<int> _types = new List<int>(); //每个child的类型
                                                   //1：数字      2：基础变量     3：+      4：*     5：(     6：)
        public static Dictionary<string, float> _history = new Dictionary<string, float>();
        public static Dictionary<string, float> _historyFloat = new Dictionary<string, float>();
        private static Dictionary<string, string> _historyCache = new Dictionary<string, string>();
        private static StringBuilder sb = new StringBuilder();

        //获取字符串头部的数字
        public static string GetStringAheadNumber(string input)
        {
            string result = "";
            if (input.Length < 1)
                return result;

            if (input.StartsWith("-"))
            {
                result = "-";
                input = input.Substring(1);
            }

            int stringLength = input.Length;
            int numberLength = 0;
            for (int i = 0; i < stringLength; i++)
            {
                string word = input.Substring(i, 1);
                if (word == "0" || word == "1" || word == "2" || word == "3" || word == "4" ||
                    word == "5" || word == "6" || word == "7" || word == "8" || word == "9" || word == ".")
                    numberLength++;
                else
                    break;
            }

            if (numberLength == 0) //不能单纯返回负号
                return "";

            //检查浮点数规范性
            string backString = input.Substring(0, numberLength);
            if (backString.Contains("."))
            {
                int dotCount = 0;
                int backStringLength = backString.Length;
                for (int i = 0; i < backStringLength; i++)
                {
                    string word = input.Substring(i, 1);
                    if (word == ".")
                    {
                        dotCount++;
                        if (i == 0 || i == backStringLength - 1)
                            Debug.LogError("小数点位置不能出现在首尾" + input);

                    }
                }
                if (dotCount > 1)
                    Debug.LogError("小数点数量大于1" + input);
            }
            if (backString.StartsWith("0") && backString.Length > 1 && backString.Substring(1, 1) != ".")
                Debug.LogError("0不能作为整数部分开头" + input);

            result = result + backString;
            return result;
        }

        public static string GetHistoryValue(string input)
        {
            //避免ToString()产生GC 这里不检查是否已有历史
            if (_historyCache.ContainsKey(input))
                return _historyCache[input];
            string cache = _history[input].ToString("0.########");
            _historyCache[input] = cache;
            return cache;
        }

        public static float GetHistoryFloatValue(string input)
        {
            if (_historyFloat.ContainsKey(input))
                return _historyFloat[input];
            float result = float.Parse(input);
            _historyFloat[input] = result;
            return result;
        }

        private void Parse(string input, bool checkHistory)
        {
            //string k = "k";
            //string v = k.Substring(1); //得到""

            if (input.Length == 0)
                return;

            foreach (var arg in args)
            {
                if (input.StartsWith(arg))
                {
                    if (checkHistory && _history.ContainsKey(arg))
                    {
                        _childs.Add(GetHistoryValue(arg));
                        _types.Add(1);
                        Parse(input.Substring(arg.Length), checkHistory);
                    }
                    else
                    {
                        _childs.Add(arg);
                        _types.Add(2);
                        Parse(input.Substring(arg.Length), checkHistory);
                    }
                    return;
                }
            }

            if (input.StartsWith("("))
            {
                _childs.Add("(");
                _types.Add(5);
                Parse(input.Substring(1), checkHistory);
            }
            else if (input.StartsWith(")"))
            {
                _childs.Add(")");
                _types.Add(6);
                Parse(input.Substring(1), checkHistory);
            }
            else if (input.StartsWith("+"))
            {
                _childs.Add("+");
                _types.Add(3);
                Parse(input.Substring(1), checkHistory);
            }
            else if (input.StartsWith("*"))
            {
                //隐藏了乘号
                Parse(input.Substring(1), checkHistory);
            }
            else if (GetStringAheadNumber(input) != "")
            {
                string numberString = GetStringAheadNumber(input);
                _childs.Add(numberString);
                _types.Add(1);
                Parse(input.Substring(numberString.Length), checkHistory);
            }
            else
                Debug.LogError("无法识别的字符：" + input);
        }

        private int CalculateStringAddCount()
        {
            int result = 1;
            foreach (var data in _types)
            {
                if (data == 3)
                    result += 1;
            }
            return result;
        }

        //单个变量的公式与值构成的等式的运算 根据值input简化公式计算得到result
        public void CalculateOneValue(float input, ref float result)
        {
            //公式中仅有一个元时 消耗元中的浮点数成员
            if (CalculateStringAddCount() == 1)
            {
                bool hasAnyMulInOneCof = false;
                for (int i = 0; i < _childs.Count; i++)
                {
                    if (_types[i] == 1)
                    {
                        hasAnyMulInOneCof = true;
                        input = input / GetHistoryFloatValue(_childs[i]);
                        _childs.RemoveAt(i);
                        _types.RemoveAt(i);
                        break;
                    }
                    if (_types[i] == 2 && _history.ContainsKey(_childs[i]))
                    {
                        hasAnyMulInOneCof = true;
                        input = input / _history[_childs[i]];
                        _childs.RemoveAt(i);
                        _types.RemoveAt(i);
                        break;
                    }
                }

                if (hasAnyMulInOneCof)
                    CalculateOneValue(input, ref result);
                else if (_childs.Count == 1)
                    result = input;
            }
            else //公式有相加的浮点数时 消耗加法运算
            {
                bool hasAnyFloatAdd = false;
                int lastCofStartFloatAdd = 0;
                for (int k = 0; k < _childs.Count + 1; k++)
                {
                    if (k == _childs.Count || _types[k] == 3)
                    {
                        int leftMulCount = k - lastCofStartFloatAdd;
                        int rightMulCount = 0;

                        for (int i = k + 1; i < _childs.Count; i++) //从加号的右边第一个开始
                        {
                            if (_types[i] == 1 || _types[i] == 2)
                                rightMulCount++;
                            else
                                break;
                        }

                        if (k != _childs.Count && leftMulCount == 1)
                        {
                            DebugString("简化加法前：" + FormulaStringExpressForShowOnly());
                            hasAnyFloatAdd = true;
                            input = input - GetHistoryFloatValue(_childs[k - 1]);
                            _childs.RemoveAt(k);
                            _types.RemoveAt(k);
                            _childs.RemoveAt(k - 1);
                            _types.RemoveAt(k - 1);
                            DebugString("简化加法后：" + FormulaStringExpressForShowOnly());
                        }
                        else if (rightMulCount == 1)
                        {
                            DebugString("简化加法前：" + FormulaStringExpressForShowOnly());
                            hasAnyFloatAdd = true;
                            input = input - GetHistoryFloatValue(_childs[k + 1]);
                            _childs.RemoveAt(k + 1);
                            _types.RemoveAt(k + 1);
                            _childs.RemoveAt(k);
                            _types.RemoveAt(k);
                            DebugString("简化加法后：" + FormulaStringExpressForShowOnly());
                        }

                        if (hasAnyFloatAdd)
                            break;
                        lastCofStartFloatAdd = k + 1;
                    }
                }

                if (hasAnyFloatAdd)
                    CalculateOneValue(input, ref result);
                else if (_childs.Count == 1)
                    result = input;
            }
        }

        //将两个公式混合运算减少变量数量 得到新的公式
        public static void CalculateMultiCofFormula(List<string> variableList,
            Formula input1, Formula input2, float result1, float result2,
            ref List<Formula> formulas, ref List<float> results, ref Vector3 rotation, ref bool hasGetRotationZ)
        {
            //判断有没有变量乘法 根据公式复杂度来消除变量
            bool hasAnyVariableMulVariable = false;

            int lastCofStartFloatAdd = 0;
            for (int k = 0; k < input1._childs.Count + 1; k++)
            {
                if (k == input1._childs.Count || input1._types[k] == 3)
                {
                    int leftMulVariableCount = 0;
                    for (int i = lastCofStartFloatAdd; i < k; i++) //从加号的右边第一个开始
                    {
                        if (input1._types[i] == 2)
                            leftMulVariableCount++;
                    }

                    if (leftMulVariableCount > 1)
                    {
                        hasAnyVariableMulVariable = true;
                        break;
                    }

                    lastCofStartFloatAdd = k + 1;
                }
            }
            lastCofStartFloatAdd = 0;
            for (int k = 0; k < input2._childs.Count + 1; k++)
            {
                if (k == input2._childs.Count || input2._types[k] == 3)
                {
                    int leftMulVariableCount = 0;
                    for (int i = lastCofStartFloatAdd; i < k; i++) //从加号的右边第一个开始
                    {
                        if (input2._types[i] == 2)
                            leftMulVariableCount++;
                    }

                    if (leftMulVariableCount > 1)
                    {
                        hasAnyVariableMulVariable = true;
                        break;
                    }

                    lastCofStartFloatAdd = k + 1;
                }
            }

            if (hasAnyVariableMulVariable)
            {
                /*
                 a = 0.8660251*sinZ*cot(Fov/2)+-0.2500003*cosZ*cot(Fov/2)
                 b = -0.5000006*sinZ*cot(Fov/2)+-0.4330125*cosZ*cot(Fov/2)
                 求Z
                 */

                float SinzFov, CoszFov;

                //求SinzFov
                {
                    Formula input1_Copy = new Formula(input1);
                    Formula input2_Copy = new Formula(input2);
                    float result1_Copy = result1;
                    float result2_Copy = result2;

                    float mulCofBesideCoszFov1 = -9999;
                    float mulCofBesideCoszFov2 = -9999;

                    for (int k = 3; k < input1._childs.Count + 1; k++)
                    {
                        if (k == input1._childs.Count || input1._types[k] == 3)
                        {
                            int variableLength = 0;
                            for (int i = k - 1; i >= 0; i--)
                            {
                                if (input1._types[i] == 2)
                                    variableLength++;
                                else
                                    break;
                            }

                            bool hasCosz = false;
                            bool hasFov = false;
                            if (variableLength == 2)
                            {
                                if (input1._childs[k - 1] == k3)
                                    hasFov = true;
                                if (input1._childs[k - 2] == k3)
                                    hasFov = true;
                                if (input1._childs[k - 1] == cosZ)
                                    hasCosz = true;
                                if (input1._childs[k - 2] == cosZ)
                                    hasCosz = true;
                            }

                            if (hasCosz && hasFov && input1._types[k - 3] == 1)
                                mulCofBesideCoszFov1 = GetHistoryFloatValue(input1._childs[k - 3]);
                        }
                    }

                    for (int k = 3; k < input2._childs.Count + 1; k++)
                    {
                        if (k == input2._childs.Count || input2._types[k] == 3)
                        {
                            int variableLength = 0;
                            for (int i = k - 1; i >= 0; i--)
                            {
                                if (input2._types[i] == 2)
                                    variableLength++;
                                else
                                    break;
                            }

                            bool hasCosz = false;
                            bool hasFov = false;
                            if (variableLength == 2)
                            {
                                if (input2._childs[k - 1] == k3)
                                    hasFov = true;
                                if (input2._childs[k - 2] == k3)
                                    hasFov = true;
                                if (input2._childs[k - 1] == cosZ)
                                    hasCosz = true;
                                if (input2._childs[k - 2] == cosZ)
                                    hasCosz = true;
                            }

                            if (hasCosz && hasFov && input2._types[k - 3] == 1)
                                mulCofBesideCoszFov2 = GetHistoryFloatValue(input2._childs[k - 3]);
                        }
                    }

                    if (mulCofBesideCoszFov1 == -9999 || mulCofBesideCoszFov2 == -999)
                    {
                        Debug.LogError("没有找到两个公式中SinzFov旁边的系数");
                        return;
                    }
                    else
                    {
                        DebugString("找到了系数" + mulCofBesideCoszFov1 + "    " + mulCofBesideCoszFov2);
                    }

                    result1_Copy = result1_Copy / mulCofBesideCoszFov1;
                    for (int k = 0; k < input1_Copy._childs.Count; k++)
                    {
                        if (input1_Copy._types[k] == 1)
                        {
                            float floatDivideValue = GetHistoryFloatValue(input1_Copy._childs[k]) / mulCofBesideCoszFov1;
                            input1_Copy._childs[k] = floatDivideValue.ToString("0.########");
                        }
                    }

                    mulCofBesideCoszFov2 = mulCofBesideCoszFov2 * -1f;
                    result2_Copy = result2_Copy / mulCofBesideCoszFov2;
                    for (int k = 0; k < input2_Copy._childs.Count; k++)
                    {
                        if (input2_Copy._types[k] == 1)
                        {
                            float floatDivideValue = GetHistoryFloatValue(input2_Copy._childs[k]) / mulCofBesideCoszFov2;
                            input2_Copy._childs[k] = floatDivideValue.ToString("0.########");
                        }
                    }

                    float newResult = result1_Copy + result2_Copy;
                    Formula newFormula = new Formula(input1_Copy, input2_Copy);
                    DebugString("测试1：" + result1_Copy + "=" + input1_Copy.FormulaStringExpressForShowOnly());
                    DebugString("测试2：" + result2_Copy + "=" + input2_Copy.FormulaStringExpressForShowOnly());
                    DebugString("得到新公式：" + newResult + "=" + newFormula.FormulaStringExpressForShowOnly());

                    int newFormulaAddCount = newFormula.CalculateStringAddCount();
                    if (newFormulaAddCount != 1)
                    {
                        DebugString("新公式必须只有1元 为a*sinZ*Fov");
                        return;
                    }

                    SinzFov = newResult / GetHistoryFloatValue(newFormula._childs[0]);
                    DebugString("sinZ*Fov=" + SinzFov);
                }

                //求CoszFov
                {
                    Formula input1_Copy = new Formula(input1);
                    Formula input2_Copy = new Formula(input2);
                    float result1_Copy = result1;
                    float result2_Copy = result2;

                    float mulCofBesideSinzFov1 = -9999;
                    float mulCofBesideSinzFov2 = -9999;

                    for (int k = 3; k < input1._childs.Count + 1; k++)
                    {
                        if (k == input1._childs.Count || input1._types[k] == 3)
                        {
                            int variableLength = 0;
                            for (int i = k - 1; i >= 0; i--)
                            {
                                if (input1._types[i] == 2)
                                    variableLength++;
                                else
                                    break;
                            }

                            bool hasSinz = false;
                            bool hasFov = false;
                            if (variableLength == 2)
                            {
                                if (input1._childs[k - 1] == k3)
                                    hasFov = true;
                                if (input1._childs[k - 2] == k3)
                                    hasFov = true;
                                if (input1._childs[k - 1] == sinZ)
                                    hasSinz = true;
                                if (input1._childs[k - 2] == sinZ)
                                    hasSinz = true;
                            }

                            if (hasSinz && hasFov && input1._types[k - 3] == 1)
                                mulCofBesideSinzFov1 = GetHistoryFloatValue(input1._childs[k - 3]);
                        }
                    }

                    for (int k = 3; k < input2._childs.Count + 1; k++)
                    {
                        if (k == input2._childs.Count || input2._types[k] == 3)
                        {
                            int variableLength = 0;
                            for (int i = k - 1; i >= 0; i--)
                            {
                                if (input2._types[i] == 2)
                                    variableLength++;
                                else
                                    break;
                            }

                            bool hasSinz = false;
                            bool hasFov = false;
                            if (variableLength == 2)
                            {
                                if (input2._childs[k - 1] == k3)
                                    hasFov = true;
                                if (input2._childs[k - 2] == k3)
                                    hasFov = true;
                                if (input2._childs[k - 1] == sinZ)
                                    hasSinz = true;
                                if (input2._childs[k - 2] == sinZ)
                                    hasSinz = true;
                            }

                            if (hasSinz && hasFov && input2._types[k - 3] == 1)
                                mulCofBesideSinzFov2 = GetHistoryFloatValue(input2._childs[k - 3]);
                        }
                    }

                    if (mulCofBesideSinzFov1 == -9999 || mulCofBesideSinzFov2 == -999)
                    {
                        Debug.LogError("没有找到两个公式中SinzFov旁边的系数");
                        return;
                    }
                    else
                    {
                        DebugString("找到了系数" + mulCofBesideSinzFov1 + "    " + mulCofBesideSinzFov2);
                    }

                    result1_Copy = result1_Copy / mulCofBesideSinzFov1;
                    for (int k = 0; k < input1_Copy._childs.Count; k++)
                    {
                        if (input1_Copy._types[k] == 1)
                        {
                            float floatDivideValue = GetHistoryFloatValue(input1_Copy._childs[k]) / mulCofBesideSinzFov1;
                            input1_Copy._childs[k] = floatDivideValue.ToString("0.########");
                        }
                    }

                    mulCofBesideSinzFov2 = mulCofBesideSinzFov2 * -1f;
                    result2_Copy = result2_Copy / mulCofBesideSinzFov2;
                    for (int k = 0; k < input2_Copy._childs.Count; k++)
                    {
                        if (input2_Copy._types[k] == 1)
                        {
                            float floatDivideValue = GetHistoryFloatValue(input2_Copy._childs[k]) / mulCofBesideSinzFov2;
                            input2_Copy._childs[k] = floatDivideValue.ToString("0.########");
                        }
                    }

                    float newResult = result1_Copy + result2_Copy;
                    Formula newFormula = new Formula(input1_Copy, input2_Copy);
                    DebugString("测试1：" + result1_Copy + "=" + input1_Copy.FormulaStringExpressForShowOnly());
                    DebugString("测试2：" + result2_Copy + "=" + input2_Copy.FormulaStringExpressForShowOnly());
                    DebugString("得到新公式：" + newResult + "=" + newFormula.FormulaStringExpressForShowOnly());

                    int newFormulaAddCount = newFormula.CalculateStringAddCount();
                    if (newFormulaAddCount != 1)
                    {
                        DebugString("新公式必须只有1元 为a*socZ*Fov");
                        return;
                    }

                    CoszFov = newResult / GetHistoryFloatValue(newFormula._childs[0]);
                    DebugString("CoszFov=" + CoszFov);
                }

                {
                    //tanZ = sinZ/cosZ = SinzFov / CoszFov

                    float tanValue = SinzFov / CoszFov;
                    float radian = Mathf.Atan(tanValue);
                    float degrees = Mathf.Round(radian * Mathf.Rad2Deg);
                    rotation.z = degrees;
                    float sinValue = Mathf.Sin(degrees * Mathf.Deg2Rad);
                    float cosValue = Mathf.Cos(degrees * Mathf.Deg2Rad);
                    Formula._history[sinZ] = sinValue;
                    Formula._history[cosZ] = cosValue;
                    DebugString($"旋转角度Z为{rotation.z}");
                    hasGetRotationZ = true;
                }
            }
            else
            {
                DebugString("开始求解：" + result1 + "=" + input1.FormulaStringExpressForShowOnly() + "   " + result2 + "=" + input2.FormulaStringExpressForShowOnly());
                foreach (var variable in variableList)
                {
                    Formula input1_Copy = new Formula(input1);
                    Formula input2_Copy = new Formula(input2);
                    float result1_Copy = result1;
                    float result2_Copy = result2;

                    //两边公式都除以变量的系数 使得变量的系数为1 再相减得到新公式
                    {
                        float targetVariabeMulCof1 = 1;
                        for (int k = 0; k < input1_Copy._childs.Count; k++)
                        {
                            if (input1_Copy._childs[k] == variable) //定位变量位置
                            {
                                if (k > 0 && input1_Copy._types[k - 1] == 1) //如果k前面有浮点数
                                    targetVariabeMulCof1 = GetHistoryFloatValue(input1_Copy._childs[k - 1]);
                                break;
                            }
                        }
                        result1_Copy = result1_Copy / targetVariabeMulCof1;
                        for (int k = 0; k < input1_Copy._childs.Count; k++)
                        {
                            if (input1_Copy._types[k] == 1)
                            {
                                float floatDivideValue = GetHistoryFloatValue(input1_Copy._childs[k]) / targetVariabeMulCof1;
                                input1_Copy._childs[k] = floatDivideValue.ToString("0.########");
                            }
                        }
                    }
                    {
                        float targetVariabeMulCof2 = -1; //a-b中b的系数为-1
                        for (int k = 0; k < input2_Copy._childs.Count; k++)
                        {
                            if (input2_Copy._childs[k] == variable)
                            {
                                if (k > 0 && input2_Copy._types[k - 1] == 1)
                                    targetVariabeMulCof2 = targetVariabeMulCof2 * GetHistoryFloatValue(input2_Copy._childs[k - 1]);
                                break;
                            }
                        }
                        result2_Copy = result2_Copy / targetVariabeMulCof2;
                        for (int k = 0; k < input2_Copy._childs.Count; k++)
                        {
                            if (input2_Copy._types[k] == 1)
                            {
                                float floatDivideValue = GetHistoryFloatValue(input2_Copy._childs[k]) / targetVariabeMulCof2;
                                input2_Copy._childs[k] = floatDivideValue.ToString("0.########");
                            }
                        }
                    }
                    DebugString("公式除以系数后：" + result1_Copy + "=" + input1_Copy.FormulaStringExpressForShowOnly() + "   " + result2_Copy + "=" + input2_Copy.FormulaStringExpressForShowOnly());

                    float newResult = result1_Copy + result2_Copy;
                    results.Add(newResult);
                    Formula newFormula = new Formula(input1_Copy, input2_Copy);
                    formulas.Add(newFormula);
                    DebugString("得到新公式：" + newResult + "=" + newFormula.FormulaStringExpressForShowOnly());
                }
            }
        }

        //将公式转换为适合阅读的形式显示出来
        public string FormulaStringExpressForShowOnly(bool showSimpleVersion = false, bool checkHistory = false)
        {
            if (checkHistory)
            {
                //如果历史记录中有变量的值 就替代变量为浮点数表示
                for (int i = 0; i < _childs.Count; i++)
                {
                    if (_types[i] == 2 && _history.ContainsKey(_childs[i]))
                    {
                        _childs[i] = GetHistoryValue(_childs[i]);
                        _types[i] = 1;
                    }
                }
            }

            sb.Clear();
            sb.Append(_childs[0]);
            for (int i = 1; i < _childs.Count; i++)
            {
                if ((_types[i] == 1 || _types[i] == 2) &&
                    (_types[i - 1] == 1 || _types[i - 1] == 2)) //a*b
                    sb.Append("*");
                if ((_types[i] == 5) &&
                    (_types[i - 1] == 1 || _types[i - 1] == 2)) //)*a
                    sb.Append("*");
                if ((_types[i] == 1 || _types[i] == 2) && //a*(
                    (_types[i - 1] == 6))
                    sb.Append("*");
                sb.Append(_childs[i]);
            }

            string result = sb.ToString();
            if (showSimpleVersion)
                ClearSignForShowOnly(ref result);

            return result;
        }

        private void ClearSignForShowOnly(ref string input)
        {
            bool hasAnyChange = false;
            int stringLength = input.Length;
            int lastCofStartFloatMul = 0;
            for (int k = 0; k < stringLength + 1; k++)
            {
                if (k == stringLength || input[k] == '+')
                {
                    string _cofString = input.Substring(lastCofStartFloatMul, k - lastCofStartFloatMul);
                    if (_cofString.StartsWith("-1*"))
                    {
                        DebugString("修改符号前：" + input);
                        hasAnyChange = true;
                        if (lastCofStartFloatMul == 0) //-1在开头位置 变成-
                        {
                            string _targetBack = input.Substring(3);
                            input = "-" + _targetBack;
                        }
                        else
                        {
                            string _targetFore = input.Substring(0, lastCofStartFloatMul - 1);
                            string _targetBack = input.Substring(lastCofStartFloatMul + 3);
                            input = _targetFore + "-" + _targetBack;
                        }
                        DebugString("修改符号后：" + input);
                    }
                    else if (lastCofStartFloatMul != 0 && GetStringAheadNumber(_cofString).StartsWith("-"))
                    {
                        hasAnyChange = true;
                        string _targetFore = input.Substring(0, lastCofStartFloatMul - 1);
                        string _targetBack = input.Substring(lastCofStartFloatMul + 1);
                        input = _targetFore + "-" + _targetBack;
                    }
                    lastCofStartFloatMul = k + 1;
                }
                if (hasAnyChange)
                    break;
            }
            if (hasAnyChange)
                ClearSignForShowOnly(ref input);
            else if (input.Contains("*/"))
                input = input.Replace("*/", "/");
        }

        //内部简化公式 除掉括号和可以计算的加乘 调整变量的位置到后面 相加掉单元浮点数
        public void ClearFloatCalculate()
        {
            //先消灭括号 将括号展开
            {
                int kuohaoCount = 0;
                int kuohaoLeftIndex = -1;

                for (int i = 0; i < _childs.Count; i++) //区最后一个左括号
                {
                    if (_types[i] == 5)
                    {
                        kuohaoCount++;
                        kuohaoLeftIndex = i;
                    }
                }

                if (kuohaoCount > 0)
                {
                    int kuohaoRightIndex = -1;

                    for (int i = kuohaoLeftIndex + 1; i < _childs.Count; i++) //取关联的右括号
                    {
                        if (_types[i] == 6)
                        {
                            kuohaoRightIndex = i;
                            break;
                        }
                    }

                    //(的左侧和)的右侧寻找可能的系数
                    int leftCofCount = 0;
                    int rightCofCount = 0;
                    for (int i = kuohaoLeftIndex - 1; i >= 0; i--)
                    {
                        if (_types[i] == 1 || _types[i] == 2)
                            leftCofCount++;
                        else
                            break;
                    }
                    for (int i = kuohaoRightIndex + 1; i < _childs.Count; i++)
                    {
                        if (_types[i] == 1 || _types[i] == 2)
                            rightCofCount++;
                        else
                            break;
                    }
                    if (leftCofCount == 0 && rightCofCount == 0)
                        Debug.LogError("括号的左边和右边都没能找到系数 有bug");

                    //开始消除括号
                    List<string> _kuohaoChilds = new List<string>();
                    List<int> _kuohaoTypes = new List<int>();
                    bool isFirstAdd = true;
                    for (int k = kuohaoLeftIndex; k < kuohaoRightIndex; k++)
                    {
                        if (isFirstAdd || _types[k] == 3) //遇到+号 取括号内的每个元素
                        {
                            if (!isFirstAdd)
                            {
                                _kuohaoChilds.Add("+");
                                _kuohaoTypes.Add(3);
                            }
                            isFirstAdd = false;

                            //x*(a*b*c+d*b*c)*y 
                            for (int i = k + 1; i < kuohaoRightIndex + 1; i++) //添加括号内当前元素的系数
                            {
                                if (_types[i] == 1 || _types[i] == 2)
                                {
                                    _kuohaoChilds.Add(_childs[i]);
                                    _kuohaoTypes.Add(_types[i]);
                                }
                                else
                                    break;
                            }

                            for (int i = kuohaoLeftIndex - leftCofCount; i < kuohaoLeftIndex; i++)
                            {
                                _kuohaoChilds.Add(_childs[i]); //添加左侧的系数
                                _kuohaoTypes.Add(_types[i]);
                            }

                            for (int i = kuohaoRightIndex + 1; i < kuohaoRightIndex + 1 + rightCofCount; i++)
                            {
                                _kuohaoChilds.Add(_childs[i]); //添加右侧的系数
                                _kuohaoTypes.Add(_types[i]);
                            }
                        }
                    }

                    //公式合并起来 a+ x*()*y +b
                    List<string> _kuohaoForeChilds = new List<string>();
                    List<int> _kuohaoForeTypes = new List<int>();
                    for (int i = 0; i < kuohaoLeftIndex - leftCofCount; i++)
                    {
                        _kuohaoForeChilds.Add(_childs[i]);
                        _kuohaoForeTypes.Add(_types[i]);
                    }
                    for (int i = kuohaoRightIndex + 1 + rightCofCount; i < _childs.Count; i++)
                    {
                        _kuohaoChilds.Add(_childs[i]);
                        _kuohaoTypes.Add(_types[i]);
                    }
                    _kuohaoForeChilds.AddRange(_kuohaoChilds);
                    _kuohaoForeTypes.AddRange(_kuohaoTypes);

                    DebugString("删除括号前：" + FormulaStringExpressForShowOnly());
                    _childs = _kuohaoForeChilds;
                    _types = _kuohaoForeTypes;
                    DebugString("删除括号后：" + FormulaStringExpressForShowOnly());
                    ClearFloatCalculate();
                    return;
                }
            }

            //现在只剩下+和*了 开始调整相乘顺序 将变量置后 
            {
                int lastCofStartChangePosition = 0;
                bool hasAnyChangePosition = false;

                for (int k = 0; k < _childs.Count + 1; k++)
                {
                    if (k == _childs.Count || _types[k] == 3)
                    {
                        int currentValueIndex = -1;
                        int firstVariableIndex = 999;
                        for (int i = lastCofStartChangePosition; i < k; i++)
                        {
                            if (_types[i] == 1)
                                currentValueIndex = i;
                            else if (firstVariableIndex == 999 || (i > 0 && _types[i - 1] == 2))
                                firstVariableIndex = i;
                            if (firstVariableIndex < currentValueIndex)
                            {
                                hasAnyChangePosition = true; //调换两个变量的位置
                                string _targetVarialbleString = _childs[firstVariableIndex];
                                int _targetVariableType = _types[firstVariableIndex];
                                DebugString("交换前：" + FormulaStringExpressForShowOnly());
                                _childs[firstVariableIndex] = _childs[currentValueIndex];
                                _types[firstVariableIndex] = _types[currentValueIndex];
                                _childs[currentValueIndex] = _targetVarialbleString;
                                _types[currentValueIndex] = _targetVariableType;
                                DebugString("交换后：" + FormulaStringExpressForShowOnly());
                                break;
                            }
                        }
                        if (hasAnyChangePosition)
                            break;
                        lastCofStartChangePosition = k + 1;
                    }
                }

                if (hasAnyChangePosition)
                {
                    ClearFloatCalculate();
                    return;
                }
            }

            //现在可以将 数值乘法 计算消耗掉
            {
                int lastCofStartFloatMul = 0;
                bool hasAnyFloatMul = false;
                for (int k = 0; k < _childs.Count + 1; k++)
                {
                    if (k == _childs.Count || _types[k] == 3)
                    {
                        for (int i = lastCofStartFloatMul + 1; i < k; i++) //因为需要2个系数 从左侧系数的第二个变量开始遍历
                        {
                            if (_types[i] == 1 && _types[i - 1] == 1)
                            {
                                hasAnyFloatMul = true;
                                float _targeValueFloat = GetHistoryFloatValue(_childs[i - 1]) * GetHistoryFloatValue(_childs[i]);
                                DebugString("计算前：" + FormulaStringExpressForShowOnly());
                                _childs[i - 1] = _targeValueFloat.ToString("0.########");
                                _childs.RemoveAt(i);
                                _types.RemoveAt(i);
                                if (_targeValueFloat == 1)
                                {
                                    _childs.RemoveAt(i - 1);
                                    _types.RemoveAt(i - 1);
                                }
                                DebugString("计算后：" + FormulaStringExpressForShowOnly());
                                break;
                            }
                        }
                        if (hasAnyFloatMul)
                            break;
                        lastCofStartFloatMul = k + 1;
                    }
                }

                if (hasAnyFloatMul)
                {
                    ClearFloatCalculate();
                    return;
                }
            }

            //现在可以将 数值加法 计算消耗掉
            {
                int lastCofStartFloatAdd = 0;
                bool hasAnyFloatAdd = false;
                for (int k = 1; k < _childs.Count; k++)
                {
                    if (_types[k] == 3 &&
                        (k - lastCofStartFloatAdd) == 1 &&
                        _types[k - 1] == 1) //左侧找到的第一个+
                    {
                        for (int i = k + 1; i < _childs.Count + 1; i++)
                        {
                            if ((i == _childs.Count || _types[i] == 3) &&
                                _types[i - 1] == 1) //由侧找到的第一个+
                            {
                                DebugString("去掉加法前：" + FormulaStringExpressForShowOnly());
                                hasAnyFloatAdd = true;
                                float _targeValueFloat = GetHistoryFloatValue(_childs[k - 1]) + GetHistoryFloatValue(_childs[i - 1]);
                                _childs[k - 1] = _targeValueFloat.ToString("0.########");
                                _childs.RemoveAt(i - 1);
                                _types.RemoveAt(i - 1);
                                _childs.RemoveAt(i - 2);
                                _types.RemoveAt(i - 2);
                                DebugString("去掉加法后：" + FormulaStringExpressForShowOnly());
                                break;
                            }
                        }

                        if (hasAnyFloatAdd)
                            break;
                        lastCofStartFloatAdd = k + 1;
                    }
                }

                if (hasAnyFloatAdd)
                {
                    ClearFloatCalculate();
                    return;
                }
            }

            //如果两个元素的变量部分相同 那么可以合并元素
            {
                int lastCofStartCheckTheSameVariablePart = 0;
                bool hasAnyTheSanmeVariablePart = false;

                //k和i是两个+的index
                for (int k = 1; k < _childs.Count; k++)
                {
                    int leftVariableCount = 0;
                    int leftMulCofIndex = -1;
                    if (_types[k] == 3)
                    {
                        for (int i = k - 1; i > lastCofStartCheckTheSameVariablePart - 1; i--)
                        {
                            if (_types[i] == 2)
                                leftVariableCount++;
                            else if (_types[i] == 1)
                            {
                                leftMulCofIndex = i;
                                break;
                            }
                            else
                                break;
                        }

                        if (leftVariableCount > 0) //左侧变量数量大于0(不是纯数字元素) 开始在右侧搜寻
                        {
                            for (int i = k + 1; i < _childs.Count + 1; i++)
                            {
                                if (i == _childs.Count || _types[i] == 3) //搜索到下一个+
                                {
                                    int rightVariableCount = 0;
                                    int rightMulCofIndex = -1;
                                    for (int p = i - 1; p > k; p--)
                                    {
                                        if (_types[p] == 2)
                                            rightVariableCount++;
                                        else if (_types[p] == 1)
                                        {
                                            rightMulCofIndex = p;
                                            break;
                                        }
                                        else
                                            break;
                                    }

                                    int addCofStartIndex = -1;
                                    for (int p = i - 1; p > k - 1; p--)
                                    {
                                        if (_types[p] == 3)
                                        {
                                            addCofStartIndex = p;
                                            break;
                                        }
                                    }

                                    if (addCofStartIndex == -1)
                                    {
                                        Debug.LogError("没有找到相邻的+");
                                        return;
                                    }

                                    if (leftVariableCount == rightVariableCount)
                                    {
                                        bool allVariableIsTheSame = true;
                                        for (int p = 0; p < leftVariableCount; p++)
                                        {
                                            string leftVariableName = _childs[k - p - 1];
                                            string rightVariableName = _childs[i - p - 1];
                                            if (leftVariableName != rightVariableName)
                                                allVariableIsTheSame = false;
                                        }

                                        if (allVariableIsTheSame)
                                        {
                                            hasAnyTheSanmeVariablePart = true;
                                            float leftMulCof = 1f;
                                            if (leftMulCofIndex != -1)
                                                leftMulCof = leftMulCof * GetHistoryFloatValue(_childs[leftMulCofIndex]);
                                            if (rightMulCofIndex != -1)
                                            {
                                                leftMulCof = leftMulCof + GetHistoryFloatValue(_childs[rightMulCofIndex]);
                                                if (Mathf.Abs(leftMulCof) < 0.0001f) //避免因为因子太小导致除以因子后误差放大
                                                    leftMulCof = 0;
                                            }
                                            string leftMulCosString = leftMulCof.ToString("0.########");

                                            DebugString("合并元素前：" + FormulaStringExpressForShowOnly());
                                            for (int p = i - 1; p > addCofStartIndex - 1; p--) //移除右边整个元素
                                            {
                                                _childs.RemoveAt(p);
                                                _types.RemoveAt(p);
                                            }

                                            if (leftMulCofIndex != -1) //修改左边的系数 
                                                _childs[leftMulCofIndex] = leftMulCosString;
                                            else //移除右边整个元素 添加左边的系数
                                            {
                                                _childs.Insert(k - leftVariableCount, leftMulCosString);
                                                _types.Insert(k - leftVariableCount, 1);
                                            }
                                            DebugString("合并元素后：" + FormulaStringExpressForShowOnly());
                                        }
                                    }
                                }

                                if (hasAnyTheSanmeVariablePart)
                                    break;
                            }

                            if (hasAnyTheSanmeVariablePart)
                                break;
                        }

                        lastCofStartCheckTheSameVariablePart = k + 1;
                    }
                }

                if (hasAnyTheSanmeVariablePart)
                {
                    ClearFloatCalculate();
                    return;
                }
            }

            //如果有系数为0或者1 可以消除元素
            if (_childs.Count > 1)
            {
                int lastCofStartFloatAdd = 0;
                bool hasAnyFloatIsZeroOrOne = false;
                for (int k = 0; k < _childs.Count + 1; k++)
                {
                    if (k == _childs.Count || _types[k] == 3)
                    {
                        if (_types[lastCofStartFloatAdd] == 1 &&
                            lastCofStartFloatAdd + 1 < _childs.Count &&
                            (_types[lastCofStartFloatAdd + 1] == 1 || _types[lastCofStartFloatAdd + 1] == 2))
                        {
                            float floatValue = GetHistoryFloatValue(_childs[lastCofStartFloatAdd]);
                            if (floatValue == 1) //1*a+b = a+b
                            {
                                DebugString("简化前：" + FormulaStringExpressForShowOnly());
                                hasAnyFloatIsZeroOrOne = true;
                                _childs.RemoveAt(lastCofStartFloatAdd);
                                _types.RemoveAt(lastCofStartFloatAdd);
                                DebugString("简化后：" + FormulaStringExpressForShowOnly());
                            }
                            else if (floatValue == 0 && lastCofStartFloatAdd == 0) //0*a + b => b 或者0*a => 0
                            {
                                if (CalculateStringAddCount() == 1)
                                {
                                    DebugString("简化前：" + FormulaStringExpressForShowOnly());
                                    hasAnyFloatIsZeroOrOne = true;
                                    for (int i = k - 1; i > -1; i--) //添加0
                                    {
                                        _childs.RemoveAt(i);
                                        _types.RemoveAt(i);
                                    }
                                    _childs.Add("0");
                                    _types.Add(1);
                                    DebugString("简化后：" + FormulaStringExpressForShowOnly());
                                }
                                else
                                {
                                    DebugString("简化前：" + FormulaStringExpressForShowOnly());
                                    hasAnyFloatIsZeroOrOne = true;
                                    for (int i = k; i > -1; i--) //去除加号
                                    {
                                        _childs.RemoveAt(i);
                                        _types.RemoveAt(i);
                                    }
                                    DebugString("简化后：" + FormulaStringExpressForShowOnly());
                                }
                            }
                            else if (floatValue == 0 && lastCofStartFloatAdd != 0)
                            {
                                int addCofStartIndex = -1;
                                for (int p = k - 1; p > -1; p--)
                                {
                                    if (_types[p] == 3)
                                    {
                                        addCofStartIndex = p;
                                        break;
                                    }
                                }

                                if (addCofStartIndex == -1)
                                {
                                    DebugString("没有找到相邻的+");
                                    return;
                                }

                                DebugString("简化前：" + FormulaStringExpressForShowOnly());
                                hasAnyFloatIsZeroOrOne = true;
                                for (int i = k - 1; i > addCofStartIndex - 1; i--)
                                {
                                    _childs.RemoveAt(i);
                                    _types.RemoveAt(i);
                                }
                                DebugString("简化后：" + FormulaStringExpressForShowOnly());
                            }

                            if (hasAnyFloatIsZeroOrOne)
                                break;
                        }
                        lastCofStartFloatAdd = k + 1;
                    }
                }

                if (hasAnyFloatIsZeroOrOne)
                {
                    ClearFloatCalculate();
                    return;
                }
            }
        }

        public Formula(string input, bool checkHistory = true)
        {
            Parse(input, checkHistory);
            ClearFloatCalculate();
        }

        public Formula(Formula a, Formula b)
        {
            _childs.AddRange(a._childs);
            _childs.Add("+");
            _childs.AddRange(b._childs);
            _types.AddRange(a._types);
            _types.Add(3);
            _types.AddRange(b._types);
            ClearFloatCalculate();
        }

        public Formula(Formula a)
        {
            _childs.AddRange(a._childs);
            _types.AddRange(a._types);
            ClearFloatCalculate();
        }
    }

    private void CalculateMatrixValue(ref string[] formula, ref float[] result, ref Vector3 position, ref Vector3 rotation,
        ref float fov, ref float aspect, ref float far, ref float near, ref int turn, ref List<string> extensionNameMatch1, ref List<string> extensionNameMatch2)
    {
        int CalculateFormulaVariableCount(string formulastring)
        {
            int variableCount = 0;
            if (!Formula._history.ContainsKey(sinX) && !Formula._history.ContainsKey(cosX) &&
                (formulastring.Contains(sinX) || formulastring.Contains(cosX)))
                variableCount++;
            if (!Formula._history.ContainsKey(sinY) && !Formula._history.ContainsKey(cosY) &&
                (formulastring.Contains(sinY) || formulastring.Contains(cosY)))
                variableCount++;
            if (!Formula._history.ContainsKey(sinZ) && !Formula._history.ContainsKey(cosZ) &&
                (formulastring.Contains(sinZ) || formulastring.Contains(cosZ)))
                variableCount++;
            if (!Formula._history.ContainsKey(x) && (formulastring.Contains(x)))
                variableCount++;
            if (!Formula._history.ContainsKey(y) && (formulastring.Contains(y)))
                variableCount++;
            if (!Formula._history.ContainsKey(z) && (formulastring.Contains(z)))
                variableCount++;
            if (!Formula._history.ContainsKey(k1) && (formulastring.Contains(k1)))
                variableCount++;
            if (!Formula._history.ContainsKey(k2) && (formulastring.Contains(k2)))
                variableCount++;
            if (!Formula._history.ContainsKey(k3) && (formulastring.Contains(k3)))
                variableCount++;
            if (!Formula._history.ContainsKey(k4) && (formulastring.Contains(k4)))
                variableCount++;
            return variableCount;
        }

        string CalculateFirstFormulaVariableName(string formulastring)
        {
            if (!Formula._history.ContainsKey(sinX) && formulastring.Contains(sinX))
                return sinX;
            if (!Formula._history.ContainsKey(cosX) && formulastring.Contains(cosX))
                return cosX;
            if (!Formula._history.ContainsKey(sinY) && formulastring.Contains(sinY))
                return sinY;
            if (!Formula._history.ContainsKey(cosY) && formulastring.Contains(cosY))
                return cosY;
            if (!Formula._history.ContainsKey(sinZ) && formulastring.Contains(sinZ))
                return sinZ;
            if (!Formula._history.ContainsKey(cosZ) && formulastring.Contains(cosZ))
                return cosZ;
            if (!Formula._history.ContainsKey(k1) && (formulastring.Contains(k1)))
                return k1;
            if (!Formula._history.ContainsKey(k2) && (formulastring.Contains(k2)))
                return k2;
            if (!Formula._history.ContainsKey(k3) && (formulastring.Contains(k3)))
                return k3;
            if (!Formula._history.ContainsKey(k4) && (formulastring.Contains(k4)))
                return k4;
            if (!Formula._history.ContainsKey(x) && (formulastring.Contains(x)))
                return x;
            if (!Formula._history.ContainsKey(y) && (formulastring.Contains(y)))
                return y;
            if (!Formula._history.ContainsKey(z) && (formulastring.Contains(z)))
                return z;
            return "Undefined";
        }

        bool anyResult = false;
        int historyLength = Formula._history.Count;
        int formulaLength = formula.Length;
        int firstOneVariableIndex = -1;
        int firstZeroVariableIndex = -1;
        int[] formulaVariableCount = new int[formulaLength];
        string[] formulaVariableCountString = new string[formulaLength];
        //这里的formula和input不一定长度为16 随着添加扩展公式长度会增加
        //如果公式里变量数目为0 则删除这个公式
        //将input中的数值和formula中的公式建立等式 也就是开局有16个等式和0个扩展公式
        //判断等式中的变量数量 只计算变量数量为1的等式 变量数量大于1的等式在多轮计算后降低变量数量

        //对formula的预判分析
        {
            for (int i = 0; i < formulaLength; i++)
            {
                int _variableCount = CalculateFormulaVariableCount(formula[i]);
                formulaVariableCount[i] = _variableCount;
                formulaVariableCountString[i] = _variableCount.ToString();
            }
            turn++;
            //DebugMatrix(formulaVariableCountString, $"第{turn}轮 formula长度为{formulaLength}↓");

            for (int i = 0; i < formulaLength; i++)
            {
                if (formulaVariableCount[i] == 1)
                {
                    firstOneVariableIndex = i;
                    break;
                }
            }
            for (int i = 0; i < formulaLength; i++)
            {
                if (formulaVariableCount[i] == 0)
                {
                    firstZeroVariableIndex = i;
                    break;
                }
            }
        }

        //try
        {
            if (formula.Length == 0)
            {
                anyResult = true;
                if (Formula._history.ContainsKey(k1) && Formula._history.ContainsKey(k2) &&
                   !Formula._history.ContainsKey(Far) && !Formula._history.ContainsKey(Near))
                {
                    //a = (Far + Near) / (Far - Near)
                    //b = Far * Near / (Far - Near)
                    //1/a * Far + 1/a * Near = Far - Near = Far * Near * 1/b
                    //先计算左边2个 要将Near用Far表达出来 减少变量数量 二者都除以Near
                    //1/a * Far/Near + 1/a = Far/Near - 1
                    //(1/a - 1) * Far/Near = -1 - 1/a
                    //Near = (1/a - 1) * Far / (-1 - 1/a);
                    //再计算右边2个 二者都除以Near
                    //Far/Near - 1 = Far * 1/b
                    //Near = Far / (Far * 1/b + 1)
                    //通过Near 将两个结果构成新的1元公式 可求得Far
                    //(1/a - 1) * Far / (-1 - 1/a) = Far / (Far * 1/b + 1)
                    //(1/a - 1) / (-1 - 1/a) = 1 / (Far * 1/b + 1)
                    //Far = ((-1 - 1/a) / (1/a - 1) - 1) * b
                    float k1Value = Formula._history[k1];
                    float k2Value = Formula._history[k2];
                    float farValue = ((-1f - 1f / k1Value) / (1f / k1Value - 1f) - 1f) * k2Value;
                    float nearValue1 = (1f / k1Value - 1f) * farValue / (-1f - 1f / k1Value);
                    //float nearValue2 = farValue / (farValue / k2Value + 1f);
                    Formula._history[Far] = farValue;
                    Formula._history[Near] = nearValue1;
                    far = farValue;
                    near = nearValue1;
                    DebugString("求证Far和Near成功 计算结束");
                    return;
                }
            }
            else if (firstZeroVariableIndex != -1)
            {
                List<int> zeroVariableFormulaIndexList = new List<int>();

                for (int i = formulaLength - 1; i >= 0; i--)
                {
                    if (formulaVariableCount[i] == 0)
                    {
                        zeroVariableFormulaIndexList.Add(i);
                    }
                }

                List<string> formulaList = formula.ToList();
                List<float> resultList = result.ToList();
                foreach (var index in zeroVariableFormulaIndexList)
                {
                    formulaList.RemoveAt(index);
                    resultList.RemoveAt(index);
                }
                formula = formulaList.ToArray();
                result = resultList.ToArray();

                anyResult = true;
                DebugMatrix(formula, $"删除{zeroVariableFormulaIndexList.Count}个无变量公式↓", result);
            }
            else if (firstOneVariableIndex == -1)
            {
                //DebugMatrix(formula, $"没有找到变量数量为1的公式 考虑使用多等式求解↓");

                //寻找出任意一对变量组合完全相同的公式 变量数为N
                //通过匹配出的2个公式进行抵消变量运算 得到额外的N个公式 2个参与匹配的公式应该不再继续一起匹配了
                //使用N个公式与现有公式查询是否有变量组合完全相同的公式 变量数为N-1
                //如此循环 直到出现变量数为1的公式
                bool CheckAndGetTheSameVariableCountFormula(int count, ref int leftIndex, ref int rightIndex,
                    ref string[] formula_Copy, ref List<string> extension1, ref List<string> extension2)
                {
                    for (int k = 0; k < formulaLength; k++)
                    {
                        if (formulaVariableCount[k] == count)
                            leftIndex = k;
                        if (leftIndex != -1)
                        {
                            for (int i = leftIndex + 1; i < formulaLength; i++)
                            {
                                if (formulaVariableCount[i] == count)
                                    rightIndex = i;
                                if (rightIndex != -1)
                                {
                                    bool twoFormulaTheSameVariable = true;
                                    string leftNewFormulaString = formula_Copy[leftIndex];
                                    for (int p = 0; p < count; p++)
                                    {
                                        string leftFirstVariableName = CalculateFirstFormulaVariableName(leftNewFormulaString);
                                        if (!formula_Copy[rightIndex].Contains(leftFirstVariableName))
                                            twoFormulaTheSameVariable = false;
                                        leftNewFormulaString = leftNewFormulaString.Replace(leftFirstVariableName, "");
                                    }

                                    if (!twoFormulaTheSameVariable)
                                    {
                                        //判断变量名称是否相同
                                        rightIndex = -1;
                                    }
                                    else if (extension1.Contains(formula_Copy[leftIndex]) && extension2.Contains(formula_Copy[rightIndex]))
                                    {
                                        //判断是否已经产出额外公式
                                        rightIndex = -1;
                                    }
                                    else
                                    {
                                        extension1.Add(formula_Copy[leftIndex]);
                                        extension2.Add(formula_Copy[rightIndex]);
                                        DebugString($"匹配变量长度成功 count{count}：{formula_Copy[leftIndex]}     {formula_Copy[rightIndex]}");
                                        return true;
                                    }
                                }
                            }

                            if (rightIndex == -1) //匹配失败
                                leftIndex = -1;
                        }
                    }

                    return false;
                }

                void CheckVariableToList(int variableCount, ref List<string> result, string formulaInput)
                {
                    string firstVariableName = CalculateFirstFormulaVariableName(formulaInput);
                    result.Add(firstVariableName);
                    formulaInput = formulaInput.Replace(firstVariableName, "");
                    variableCount--;
                    if (variableCount > 0)
                        CheckVariableToList(variableCount, ref result, formulaInput);
                }

                int leftFormulaIndex = -1;
                int rightFormulaIndex = -1;
                if (!CheckAndGetTheSameVariableCountFormula(2, ref leftFormulaIndex, ref rightFormulaIndex, ref formula, ref extensionNameMatch1, ref extensionNameMatch2))
                    if (!CheckAndGetTheSameVariableCountFormula(3, ref leftFormulaIndex, ref rightFormulaIndex, ref formula, ref extensionNameMatch1, ref extensionNameMatch2))
                        if (!CheckAndGetTheSameVariableCountFormula(4, ref leftFormulaIndex, ref rightFormulaIndex, ref formula, ref extensionNameMatch1, ref extensionNameMatch2))
                            CheckAndGetTheSameVariableCountFormula(5, ref leftFormulaIndex, ref rightFormulaIndex, ref formula, ref extensionNameMatch1, ref extensionNameMatch2);
                if (leftFormulaIndex == -1 || rightFormulaIndex == -1)
                {
                    DebugMatrix(formula, "匹配变量长度失败↓", result);
                    DebugMatrix(formulaVariableCountString, $"第{turn}轮 formula长度为{formulaLength}↓");
                    return;
                }

                Formula input1 = new Formula(formula[leftFormulaIndex]);
                Formula input2 = new Formula(formula[rightFormulaIndex]);
                List<Formula> outputs = new List<Formula>();
                List<float> results = new List<float>();
                List<string> variableList = new List<string>();
                CheckVariableToList(CalculateFormulaVariableCount(formula[leftFormulaIndex]), ref variableList, formula[leftFormulaIndex]);

                bool hasGetRotationZ = false;
                Formula.CalculateMultiCofFormula(variableList, input1, input2, result[leftFormulaIndex], result[rightFormulaIndex],
                    ref outputs, ref results, ref rotation, ref hasGetRotationZ);

                if (outputs.Count == 0 && Formula._history.Count == historyLength)
                {
                    DebugMatrix(formula, "扩展公式扩充失败↓", result);
                    DebugMatrix(formulaVariableCountString, $"第{turn}轮 formula长度为{formulaLength}↓");
                    CalculateMatrixValue(ref formula, ref result, ref position, ref rotation, ref fov, ref aspect, ref far, ref near,
                        ref turn, ref extensionNameMatch1, ref extensionNameMatch2);
                }

                if (hasGetRotationZ == true)
                {
                    for (int i = 0; i < formula.Length; i++)
                        formula[i] = new Formula(formula[i]).FormulaStringExpressForShowOnly(false, true);

                    DebugMatrix(formula, $"求得旋转角度Z 角度：{rotation.z}", result);
                }
                else if (outputs.Count > 0)
                {
                    //DebugMatrix(formula, $"添加额外公式前↓");
                    var newFormulaList = formula.ToList();
                    var newResultList = result.ToList();
                    foreach (var data in outputs)
                        newFormulaList.Add(data.FormulaStringExpressForShowOnly(false, true));
                    foreach (var data in results)
                        newResultList.Add(data);
                    formula = newFormulaList.ToArray();
                    result = newResultList.ToArray();
                    DebugMatrix(formula, $"添加额外公式后", result);
                }

                anyResult = true;
            }
            else //仅一个变量的情况 可轻松计算出结果
            {
                //DebugString("开始计算单个变量");
                string targetFormulaString = formula[firstOneVariableIndex];
                string targetVariableName = CalculateFirstFormulaVariableName(targetFormulaString);
                Formula parser = new Formula(targetFormulaString);
                float targetVariableValue = -9999;
                string targetVariableNameString = parser.FormulaStringExpressForShowOnly(true, true);
                parser.CalculateOneValue(result[firstOneVariableIndex], ref targetVariableValue);
                if (parser._childs.Count > 1)
                    DebugString("没有计算出结果 需要检查问题：" + targetVariableNameString);
                else
                    anyResult = true;

                //解析变量
                {
                    if (targetVariableName == sinX)
                    {
                        float sinValue = targetVariableValue;
                        float degress = Mathf.Round(Mathf.Asin(sinValue) * Mathf.Rad2Deg * 10) * 0.1f;
                        rotation.x = degress;

                        sinValue = Mathf.Sin(degress * Mathf.Deg2Rad);
                        float cosValue = Mathf.Cos(degress * Mathf.Deg2Rad);

                        Formula._history[sinX] = sinValue;
                        Formula._history[cosX] = cosValue;

                        Debug.LogError($"解锁新变量 旋转角度X度数：{degress}");
                    }
                    else if (targetVariableName == sinY)
                    {
                        float sinValue = targetVariableValue;
                        float degress = Mathf.Round(Mathf.Asin(sinValue) * Mathf.Rad2Deg * 10) * 0.1f;
                        rotation.y = degress;

                        sinValue = Mathf.Sin(degress * Mathf.Deg2Rad);
                        float cosValue = Mathf.Cos(degress * Mathf.Deg2Rad);

                        Formula._history[sinY] = sinValue;
                        Formula._history[cosY] = cosValue;

                        Debug.LogError($"解锁新变量 旋转角度Y度数：{degress}");
                    }
                    else if (targetVariableName == sinZ)
                    {
                        float sinValue = targetVariableValue;
                        float degress = Mathf.Round(Mathf.Asin(sinValue) * Mathf.Rad2Deg * 10) * 0.1f;
                        rotation.z = degress;

                        sinValue = Mathf.Sin(degress * Mathf.Deg2Rad);
                        float cosValue = Mathf.Cos(degress * Mathf.Deg2Rad);

                        Formula._history[sinZ] = sinValue;
                        Formula._history[cosZ] = cosValue;

                        Debug.LogError($"解锁新变量 旋转角度Z度数：{degress}");
                    }
                    else if (targetVariableName == cosY)
                    {
                        float cosValue = targetVariableValue;
                        float degress = Mathf.Round(Mathf.Acos(cosValue) * Mathf.Rad2Deg * 10) * 0.1f;
                        rotation.y = degress;

                        float sinValue = Mathf.Sin(degress * Mathf.Deg2Rad);
                        cosValue = Mathf.Cos(degress * Mathf.Deg2Rad);

                        Formula._history[sinY] = sinValue;
                        Formula._history[cosY] = cosValue;

                        Debug.LogError($"解锁新变量 旋转角度Y度数：{degress}");
                    }
                    else if (targetVariableName == x)
                    {
                        position.x = targetVariableValue;
                        Formula._history[x] = targetVariableValue;

                        Debug.LogError($"解锁新变量 坐标X：{targetVariableValue}");
                    }
                    else if (targetVariableName == y)
                    {
                        position.y = targetVariableValue;
                        Formula._history[y] = targetVariableValue;

                        Debug.LogError($"解锁新变量 坐标Y：{targetVariableValue}");
                    }
                    else if (targetVariableName == z)
                    {
                        position.z = targetVariableValue;
                        Formula._history[z] = targetVariableValue;

                        Debug.LogError($"解锁新变量 坐标Z：{targetVariableValue}");
                    }
                    else if (targetVariableName == k3)
                    {
                        fov = Mathf.Atan(1f / targetVariableValue) * 2f * Mathf.Rad2Deg;
                        fov = Mathf.Round(fov * 10) * 0.1f;
                        Formula._history[k3] = 1f / Mathf.Tan(fov * Mathf.Deg2Rad * 0.5f);

                        Debug.LogError($"解锁新变量 FOV：{fov}");
                    }
                    else if (targetVariableName == k4)
                    {
                        aspect = 1f / targetVariableValue;
                        Formula._history[k4] = targetVariableValue;

                        Debug.LogError($"解锁新变量 Aspect：{aspect}");
                    }
                    else if (targetVariableName == k1)
                    {
                        Formula._history[k1] = targetVariableValue;
                    }
                    else if (targetVariableName == k2)
                    {
                        Formula._history[k2] = targetVariableValue;
                    }
                    else
                    {
                        DebugString("未解析的变量 需要检查：" + targetVariableName);
                        return;
                    }
                }


                for (int i = 0; i < formula.Length; i++)
                    formula[i] = new Formula(formula[i]).FormulaStringExpressForShowOnly(false, true);

                DebugMatrix(formula, $"字符串解析：{result[firstOneVariableIndex]} = {targetVariableNameString}    目标变量名：{targetVariableName} = {targetVariableValue}", result);
            }

            if (anyResult)
            {
                bool anyDifferent = Formula._history.Count != historyLength || formulaLength != formula.Length;

                if (anyDifferent)
                {
                    CalculateMatrixValue(ref formula, ref result, ref position, ref rotation, ref fov, ref aspect, ref far, ref near,
                        ref turn, ref extensionNameMatch1, ref extensionNameMatch2);
                }
                else
                {
                    DebugString("没有实际变化 退出循环");
                }
            }
            else
            {
                DebugString("无法计算出结果");
            }
        }
        //catch (System.Exception ex)
        {
            //DebugString("报错：" + ex.Message);
        }
    }
    #endregion
}
