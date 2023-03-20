using System;
using System.Collections.Generic;
using UnityEngine;

public class Custom_Model
{
    #region 捏人实现
    //自定义模型数据
    public GameObject root; //1.物体
    public Transform root_bone; //2.骨架根目录 不参与计算权重
    public Transform root_part; //3.部件根目录
    public int[] relation; //4.对应骨骼的父级编号 没有父级时值为-1
    public Transform[] bones; //5.骨骼 参与计算权重
    public GameObject[] parts; //6.对应每个部件的根目录
    public int[][] bone_index; //7.对应每个mesh的权重骨架 骨骼对应bones中的骨骼编号
    public Mesh[] meshs; //8.对应部件的序列
    public Material[][] materials; //9.对应每个mesh的材质
    public int layer; //10.图层 需要

    //捏人系统配置
    Custom_Config custom_Config = new Custom_Config();
    static public int[] custom_ints = new int[]
    {
        0,50,   1,0,    2,0,    3,100,  4,0,
        5,50,   6,0,    7,0,    8,50,   9,50,
        10,50,  11,50,  12,50,  13,0,   14,50,
        15,50,  16,50,  17,50,  18,50,  19,50,
        20,50,  21,50,  22,50,  23,50,  24,50,
        25,50,  26,50,  27,50,  28,50,  29,50,
        30,50,  31,50,  32,50,  33,50,  34,50,
        35,50,  36,0,   37,50,  38,50,  39,50,
        40,50,  41,50,  42,50,  43,50,  44,50,
        45,50,  46,50,  47,50,  48,50,  49,50,
        50,0,   51,50,  52,100, 53,100, 54,50,
        55,50,  56,50,  57,50,  58,50,  59,50,
        60,50,  61,0,   62,50,  63,0,   64,50,
        65,50,  66,50,  67,50,  68,50,  69,50,
        70,50,  71,50,  72,50,  73,50,  74,50,
        75,50,  76,50,  77,50,  78,50,  79,50,
        80,50,  81,50,  82,50,  83,50,  84,50,
        85,50,  86,50,  87,50,  88,50,  89,50,
        90,50,  91,50,  92,50,  93,50,  94,50,
        95,50
    }; //操作项初始值
    static public int[] hair_ints = new int[]
    {
        //fore  back    ahoge   
        0,4,    1,3,    2,2
    }; //头发设置页面初始值
    static public int[] clothes_ints = new int[]
    {
        //top   bot    shoes
        0,18,    1,3,    2,4
    }; //服装设置页面初始值
    Dictionary<Bone_Custom, Transform> bone_Custom = new Dictionary<Bone_Custom, Transform>(); //记录形变骨骼
    Dictionary<Bone_Custom, Vector3[]> bone_Values = new Dictionary<Bone_Custom, Vector3[]>(); //记录形变骨骼初始位置

    //换装临时数据 key：部件名 value：额外骨架/renderer根目录
    Dictionary<string, Transform[]> extra_Bones = new Dictionary<string, Transform[]>();
    Dictionary<string, GameObject> extra_Parts = new Dictionary<string, GameObject>();
    Dictionary<string, Material[]> extra_Materials = new Dictionary<string, Material[]>();
    static string[] extra_bones = new string[]
    {
        #region 权重骨骼
        //主干上半身
        "cf_s_spine01","cf_s_spine02","cf_s_spine03","cf_s_neck","cf_s_head",
        //主干下半身
        "cf_s_siri_L","cf_s_waist01","cf_s_waist02",
        "cf_s_siri_R",
        //手臂
        "cf_s_shoulder02_L","cf_s_arm01_L","cf_s_arm02_L","cf_s_arm03_L","cf_s_forearm01_L","cf_s_forearm02_L","cf_s_wrist_L","cf_s_hand_L",
        "cf_s_shoulder02_R","cf_s_arm01_R","cf_s_arm02_R","cf_s_arm03_R","cf_s_forearm01_R","cf_s_forearm02_R","cf_s_wrist_R","cf_s_hand_R",
        //胸部
        "cf_s_bust01_L","cf_s_bust02_L","cf_s_bust03_L","cf_s_bnip025_L","cf_j_bnip02_L",
        "cf_s_bust01_R","cf_s_bust02_R","cf_s_bust03_R","cf_s_bnip025_R","cf_j_bnip02_R",
        //裙子
        "cf_d_sk_top","cf_d_sk_00_00","cf_d_sk_01_00","cf_d_sk_02_00","cf_d_sk_03_00","cf_d_sk_04_00","cf_d_sk_05_00","cf_d_sk_06_00","cf_d_sk_07_00",
        "cf_j_sk_00_00","cf_j_sk_00_01","cf_j_sk_00_02","cf_j_sk_00_03","cf_j_sk_00_04","cf_j_sk_00_05",
        "cf_j_sk_01_00","cf_j_sk_01_01","cf_j_sk_01_02","cf_j_sk_01_03","cf_j_sk_01_04","cf_j_sk_01_05",
        "cf_j_sk_02_00","cf_j_sk_02_01","cf_j_sk_02_02","cf_j_sk_02_03","cf_j_sk_02_04","cf_j_sk_02_05",
        "cf_j_sk_03_00","cf_j_sk_03_01","cf_j_sk_03_02","cf_j_sk_03_03","cf_j_sk_03_04","cf_j_sk_03_05",
        "cf_j_sk_04_00","cf_j_sk_04_01","cf_j_sk_04_02","cf_j_sk_04_03","cf_j_sk_04_04","cf_j_sk_04_05",
        "cf_j_sk_05_00","cf_j_sk_05_01","cf_j_sk_05_02","cf_j_sk_05_03","cf_j_sk_05_04","cf_j_sk_05_05",
        "cf_j_sk_06_00","cf_j_sk_06_01","cf_j_sk_06_02","cf_j_sk_06_03","cf_j_sk_06_04","cf_j_sk_06_05",
        "cf_j_sk_07_00","cf_j_sk_07_01","cf_j_sk_07_02","cf_j_sk_07_03","cf_j_sk_07_04","cf_j_sk_07_05",
        //腿
        "cf_s_thigh01_L","cf_s_thigh02_L","cf_s_thigh03_L","cf_s_leg01_L","cf_s_leg02_L","cf_s_leg03_L","cf_j_foot_L","cf_j_toes_L",
        "cf_s_thigh01_R","cf_s_thigh02_R","cf_s_thigh03_R","cf_s_leg01_R","cf_s_leg02_R","cf_s_leg03_R","cf_j_foot_R","cf_j_toes_R",
        //领带
        "cf_j_spinesk_00","cf_j_spinesk_01","cf_j_spinesk_02","cf_j_spinesk_03","cf_j_spinesk_04",
        #endregion
        
        //被删除的权重骨骼
        "cf_d_hand_L","cf_d_kneeF_L","cf_s_kneeB_L","cf_s_leg_L","cf_s_elboback_L","cf_s_elbo_L","cf_s_bnip015_L","cf_s_bnip01_L","cf_s_ana","cf_j_kokan",
        "cf_d_hand_R","cf_d_kneeF_R","cf_s_kneeB_R","cf_s_leg_R","cf_s_elboback_R","cf_s_elbo_R","cf_s_bnip015_R","cf_s_bnip01_R",
        "cf_j_thumb02_L","cf_j_thumb01_L",
        "cf_j_thumb02_R","cf_j_thumb01_R",
        "cf_j_index01_L","cf_j_little01_L","cf_j_middle01_L","cf_j_ring01_L",
        "cf_j_index01_R","cf_j_little01_R","cf_j_middle01_R","cf_j_ring01_R",
        "cf_j_backsk_C_02","cf_j_backsk_L_02","cf_j_backsk_R_02",

        //无权重的间接骨骼
        "cf_j_waist01", //裙子
        "cf_d_spinesk_00","cf_j_spine03", //领带
        "cf_j_ana","cf_d_ana","cf_j_waist02", //ana
        "cf_d_kokan", //kokan
        "cf_j_forearm01_L", //cf_s_elbo_L
        "cf_j_forearm01_R", //cf_s_elbo_R
        "cf_j_bust03_L","cf_d_bnip01_L", //cf_s_bnip015_L/cf_s_bnip01_L
        "cf_j_bust03_R","cf_d_bnip01_R", //cf_s_bnip015_R/cf_s_bnip01_R
        "cf_d_backsk_00","cf_j_backsk_C_01","cf_j_backsk_L_01","cf_j_backsk_R_01", //骑士
        "cf_j_leg01_L","cf_j_leg01_R", //cf_d_kneeF_L/cf_d_kneeF_R
    }; //所有感兴趣的额外骨骼(可能不带权重)    

    public void Load_Custom_Model(GameObject body, GameObject head, int layer)
    {
        //用2个prefab生成一个Model实例
        //创建根目录（参数1/2/3）
        this.root = new GameObject("Custom");
        this.root_bone = new GameObject("root_bone").transform;
        this.root_part = new GameObject("root_part").transform;
        this.root_bone.parent = this.root.transform;
        this.root_part.parent = this.root.transform;
        this.layer = layer;

        //获取目标骨架
        Transform body_root = body.transform.Sekia_GetChildByName("Root"); //身体骨架的根
        Transform head_root = head.transform.Sekia_GetChildByName("Head_Root"); //头部骨架的根
        Transform[] body_bones = body_root.Sekia_GetChildsOfTransform(true);
        Transform[] head_bones = head_root.Sekia_GetChildsOfTransform(true);
        Transform[] target_bones = body_bones.Sekia_CombineArray(head_bones);
        //获取总骨骼数
        int bones_count = target_bones.Length;
        //获取全部render
        SkinnedMeshRenderer[] smrs_body = body.GetComponentsInChildren<SkinnedMeshRenderer>();
        SkinnedMeshRenderer[] smrs_head = head.GetComponentsInChildren<SkinnedMeshRenderer>();
        SkinnedMeshRenderer[] smrs = smrs_body.Sekia_CombineArray(smrs_head);
        //获取部件数量
        int mesh_count = smrs.Length;

        //生成骨架上的骨骼父级映射（参数4）
        this.relation = new int[bones_count];
        for (int i = 0; i < bones_count; ++i)
        {
            if (target_bones[i].name == "Head_Root") //头部骨架的根的父级在身体上
            {
                Transform bone_head = body.transform.Sekia_GetChildByName("Head");
                this.relation[i] = Array.IndexOf(target_bones, bone_head);
                continue;
            }
            //Root的父级不在里面 返回-1
            this.relation[i] = Array.IndexOf(target_bones, target_bones[i].parent);
        }

        //生成骨架并设置父级（参数5）
        this.bones = new Transform[bones_count];
        for (int i = 0; i < bones_count; ++i)
        {
            this.bones[i] = new GameObject(target_bones[i].name).transform;
            if (this.relation[i] != -1)
            {
                this.bones[i].parent = this.bones[this.relation[i]]; //普通骨骼
            }
            else
            {
                this.bones[i].parent = this.root_bone; //根骨骼
            }
            this.bones[i].localPosition = target_bones[i].localPosition;
            this.bones[i].localEulerAngles = target_bones[i].localEulerAngles;
            this.bones[i].localScale = target_bones[i].localScale;

            //测试bones中是否完整映射Bone_Custom
            //Bone_Custom bone_type = SekiaHelp.Sekia_StringToEnum<Bone_Custom>(target_bones[i].name);
        }

        //生成部件的根目录（参数6）
        this.parts = new GameObject[mesh_count];
        for (int i = 0; i < mesh_count; ++i)
        {
            //目标模型上可能有空的mesh存在
            if (smrs[i].sharedMesh == null)
            {
                Debug.LogError("发现物体" + smrs[i].gameObject.name + "没有mesh");
                continue;
            }
            this.parts[i] = new GameObject(smrs[i].sharedMesh.name);
            this.parts[i].transform.parent = this.root_part;
            this.parts[i].layer = this.layer;
        }

        //部件的骨架映射（参数7）
        this.bone_index = new int[mesh_count][];
        for (int i = 0; i < mesh_count; ++i)
        {
            this.bone_index[i] = new int[smrs[i].bones.Length];
            for (int n = 0; n < this.bone_index[i].Length; ++n)
            {
                this.bone_index[i][n] = Array.IndexOf(target_bones, smrs[i].bones[n]);
            }
        }

        //创建mesh（参数8）
        this.meshs = new Mesh[mesh_count];
        for (int i = 0; i < mesh_count; ++i)
        {
            this.meshs[i] = smrs[i].sharedMesh.Sekia_CopyMesh(true);
        }

        //创建material（参数9）
        this.materials = new Material[mesh_count][];
        for (int i = 0; i < mesh_count; ++i)
        {
            this.materials[i] = new Material[smrs[i].sharedMaterials.Length];
            for (int n = 0; n < this.materials[i].Length; ++n)
            {
                this.materials[i][n] = smrs[i].sharedMaterials[n].Sekia_CopyMaterial();
            }
        }

        //设置render
        for (int i = 0; i < mesh_count; ++i)
        {
            SkinnedMeshRenderer smr = this.parts[i].AddComponent<SkinnedMeshRenderer>();
            //this.parts[i].AddComponent<EmissionObject>();
            smr.sharedMesh = this.meshs[i];
            smr.bones = this.bones.Sekia_GetArrayByIndexs(this.bone_index[i]);
            smr.sharedMaterials = this.materials[i];
            smr.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.Off;
            smr.receiveShadows = false;
        }

        //记录Custom骨骼的初始位
        Bone_Custom[] _bone_Customs = SekiaHelp.Sekia_EnumToArray<Bone_Custom>();
        for (int i = 0; i < _bone_Customs.Length; ++i)
        {
            string bone_name = _bone_Customs[i].ToString();
            Transform bone = null;
            for (int n = 0; n < bones_count; ++n)
            {
                if (bone_name == this.bones[n].name)
                {
                    bone = this.bones[n];  //根据骨骼名找到骨骼
                    break;
                }
            }
            if (bone == null)
            {
                Debug.LogError("缺少自定义骨骼" + bone_name);
                continue;
            }
            Vector3[] transform = new Vector3[3];
            transform[0] = bone.localPosition;
            transform[1] = bone.localEulerAngles;
            transform[2] = bone.localScale;
            this.bone_Custom[_bone_Customs[i]] = bone; //记录骨骼
            this.bone_Values[_bone_Customs[i]] = transform; //记录骨骼的初始位置
        }

        custom_Config.Load_Custom_Config(); //初始化捏脸设置
    }

    public void Custom_Bone(int custom_index, int custom_value)
    {
        //修改骨骼属性 指定捏人操作编号和操作值
        if (custom_value < 0 || custom_value > 100) //限定输入值为 0-100的整数
            return;

        //根据操作类型判断有哪些骨骼会受影响
        Dictionary<int, bool[]> list = custom_Config.Get_Index(custom_index);
        foreach (var item in list)
        {
            Transform bone = this.bone_Custom[(Bone_Custom)item.Key]; //受影响的骨骼
            Vector3[] original_values = this.bone_Values[(Bone_Custom)item.Key]; //骨骼的初始位置
            Vector3[] values = new Vector3[3];
            for (int i = 0; i < 3; ++i)
            {
                values[i] = new Vector3(original_values[i].x, original_values[i].y, original_values[i].z);
            }
            bool[] use = item.Value;

            if (custom_Config.Get_Info(item.Key, custom_index, custom_value, ref values, use))
            {
                if (use[0] || use[1] || use[2])
                {
                    float x = bone.localPosition.x;
                    float y = bone.localPosition.y;
                    float z = bone.localPosition.z;
                    if (use[0])
                        x = values[0].x;
                    if (use[1])
                        y = values[0].y;
                    if (use[2])
                        z = values[0].z;
                    bone.localPosition = new Vector3(x, y, z);
                }
                if (use[3] || use[4] || use[5])
                {
                    float x = bone.localEulerAngles.x;
                    float y = bone.localEulerAngles.y;
                    float z = bone.localEulerAngles.z;
                    if (use[3])
                        x = values[1].x;
                    if (use[4])
                        y = values[1].y;
                    if (use[5])
                        z = values[1].z;
                    bone.localEulerAngles = new Vector3(x, y, z);
                }
                if (use[6] || use[7] || use[8])
                {
                    float x = bone.localScale.x;
                    float y = bone.localScale.y;
                    float z = bone.localScale.z;
                    if (use[6])
                        x = values[2].x;
                    if (use[7])
                        y = values[2].y;
                    if (use[8])
                        z = values[2].z;
                    bone.localScale = new Vector3(x, y, z);
                }
            }
        }
    }
    #endregion

    #region 换装实现
    void Change_Skeletion_Part(string prefab_name, string part_name)
    {
        GameObject part = Resources.Load<GameObject>(prefab_name);
        SkinnedMeshRenderer[] smrs = part.GetComponentsInChildren<SkinnedMeshRenderer>();
        Transform[] bones = part.transform.Sekia_GetChildsOfTransform(false);

        int[][] bone_index = new int[smrs.Length][]; //对应每个mesh的权重骨架
        for (int i = 0; i < smrs.Length; ++i)
        {
            bone_index[i] = new int[smrs[i].bones.Length];
            for (int n = 0; n < smrs[i].bones.Length; ++n)
            {
                bone_index[i][n] = bones.Sekia_GetIndexInArray(smrs[i].bones[n]);
            }
        }

        string[] custom_bones = SekiaHelp.Sekia_EnumToStringArray<Bone_Custom>();
        Transform[] bones_reflect = new Transform[bones.Length]; //新建gameObject骨架 映射旧骨架
        List<Transform> bones_new = new List<Transform>(); //创建的新骨骼列表
        for (int i = 0; i < bones.Length; ++i) //遍历全部骨骼
        {
            int extra_index = extra_bones.Sekia_GetIndexInArray(bones[i].name);
            if (extra_index != -1)
            {
                switch (bones[i].name)
                {
                    #region 直接骨骼(有权重)
                    #region 主干上半身
                    case "cf_s_head":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.Head];
                        break;
                    case "cf_s_neck":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.c_neck];
                        break;
                    case "cf_s_spine01":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.c_spine1];
                        break;
                    case "cf_s_spine02":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.c_spine2];
                        break;
                    case "cf_s_spine03":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.c_spine3];
                        break;
                    #endregion
                    #region 主干下半身
                    case "cf_s_waist02":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.c_waist2];
                        break;
                    case "cf_s_waist01":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.c_waist1];
                        break;
                    case "cf_s_siri_L":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.c_siri_L];
                        break;
                    case "cf_s_siri_R":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.c_siri_R];
                        break;
                    #endregion
                    #region 胸
                    case "cf_s_bnip025_L":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.c_bnip1_L];
                        break;
                    case "cf_j_bnip02_L":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.c_bnip2_L];
                        break;
                    case "cf_s_bnip025_R":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.c_bnip1_R];
                        break;
                    case "cf_j_bnip02_R":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.c_bnip2_R];
                        break;
                    case "cf_s_bust01_L":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.c_bust1_L];
                        break;
                    case "cf_s_bust02_L":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.c_bust2_L];
                        break;
                    case "cf_s_bust03_L":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.c_bust3_L];
                        break;
                    case "cf_s_bust01_R":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.c_bust1_R];
                        break;
                    case "cf_s_bust02_R":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.c_bust2_R];
                        break;
                    case "cf_s_bust03_R":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.c_bust3_R];
                        break;
                    #endregion
                    #region 手臂
                    case "cf_s_shoulder02_L":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.c_clavicle_L];
                        break;
                    case "cf_s_shoulder02_R":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.c_clavicle_R];
                        break;
                    case "cf_s_arm01_L":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.c_upperarm1_L];
                        break;
                    case "cf_s_arm02_L":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.c_upperarm2_L];
                        break;
                    case "cf_s_arm03_L":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.c_upperarm3_L];
                        break;
                    case "cf_s_arm01_R":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.c_upperarm1_R];
                        break;
                    case "cf_s_arm02_R":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.c_upperarm2_R];
                        break;
                    case "cf_s_arm03_R":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.c_upperarm3_R];
                        break;
                    case "cf_s_forearm01_L":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.c_forearm1_L];
                        break;
                    case "cf_s_forearm02_L":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.c_forearm2_L];
                        break;
                    case "cf_s_forearm01_R":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.c_forearm1_R];
                        break;
                    case "cf_s_forearm02_R":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.c_forearm2_R];
                        break;
                    case "cf_s_wrist_L":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.c_forearm3_L];
                        break;
                    case "cf_s_wrist_R":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.c_forearm3_R];
                        break;
                    case "cf_s_hand_L":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.Hand_L];
                        break;
                    case "cf_s_hand_R":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.Hand_R];
                        break;
                    #endregion
                    #region 腿
                    case "cf_s_thigh01_L":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.c_thigh1_L];
                        break;
                    case "cf_s_thigh02_L":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.c_thigh2_L];
                        break;
                    case "cf_s_thigh03_L":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.c_thigh3_L];
                        break;
                    case "cf_s_thigh01_R":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.c_thigh1_R];
                        break;
                    case "cf_s_thigh02_R":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.c_thigh2_R];
                        break;
                    case "cf_s_thigh03_R":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.c_thigh3_R];
                        break;
                    case "cf_s_leg01_L":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.c_calf1_L];
                        break;
                    case "cf_s_leg02_L":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.c_calf2_L];
                        break;
                    case "cf_s_leg03_L":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.c_calf3_L];
                        break;
                    case "cf_s_leg01_R":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.c_calf1_R];
                        break;
                    case "cf_s_leg02_R":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.c_calf2_R];
                        break;
                    case "cf_s_leg03_R":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.c_calf3_R];
                        break;
                    case "cf_j_foot_L":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.Foot_L];
                        break;
                    case "cf_j_foot_R":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.Foot_R];
                        break;
                    case "cf_j_toes_L":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.Toes_L];
                        break;
                    case "cf_j_toes_r":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.Toes_R];
                        break;
                    #endregion
                    #endregion
                    #region 间接骨骼(无权重)
                    case "cf_j_waist01":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.Waist];
                        break;
                    case "cf_j_spine03":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.Spine2];
                        break;
                    case "cf_j_forearm01_L":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.c_forearm1_L];
                        break;
                    case "cf_j_forearm01_R":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.c_forearm1_L];
                        break;
                    case "cf_j_bust03_L":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.c_bust3_L];
                        break;
                    case "cf_j_bust03_R":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.c_bust3_R];
                        break;
                    case "cf_j_leg01_L":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.Calf_L];
                        break;
                    case "cf_j_leg01_R":
                        bones_reflect[i] = this.bone_Custom[Bone_Custom.Calf_R];
                        break;
                    #endregion
                    default:
                        break;
                } //在基础骨架上 直接替换
                if (bones_reflect[i] == null) //不在基础骨架上 新建骨骼
                {
                    Transform transform = new GameObject(bones[i].name).transform;
                    bones_new.Add(transform);
                    int parent_index = bones.Sekia_GetIndexInArray(bones[i].parent);
                    transform.parent = bones_reflect[parent_index]; //必定有父级
                    transform.localPosition = bones[i].localPosition;
                    transform.localEulerAngles = bones[i].localEulerAngles;
                    transform.localScale = bones[i].localScale;
                    bones_reflect[i] = transform;
                }
                continue;
            } //基础骨架外扩形(illusion模型)

            int custom_index = custom_bones.Sekia_GetIndexInArray(bones[i].name);
            if (custom_index != -1) //骨骼名是自定义骨骼时(原创模型)
            {
                bones_reflect[i] = this.root_bone.Sekia_GetChildByName(bones[i].name);
                continue;
            }

            //不关心的骨骼将被忽略 保持为Null
        }

        //获取部件 设置新参数
        GameObject root = null;
        if (!extra_Parts.TryGetValue(part_name, out root))
        {
            //如果不存在部件 新建根目录
            root = new GameObject(part_name);
            root.transform.parent = this.root_part;
            extra_Parts[part_name] = root;
        }
        else
        {
            //如果已存在部件 删除所有子gameObject和new骨骼
            GameObject[] childs = new GameObject[root.transform.childCount];
            for (int i = 0; i < root.transform.childCount; ++i)
            {
                childs[i] = root.transform.GetChild(i).gameObject;
            }
            for (int i = 0; i < childs.Length; ++i)
            {
                GameObject.Destroy(childs[i]);
            }

            Transform[] bones_old;
            if (extra_Bones.TryGetValue(part_name, out bones_old))
            {
                foreach (var value in bones_old)
                {
                    if (value != null)
                    {
                        GameObject.Destroy(value.gameObject);
                    }
                }
            }

            extra_Bones[part_name] = bones_new.ToArray();
        }

        //设置子gameObject上的Renderer
        for (int i = 0; i < smrs.Length; ++i) //遍历mesh
        {
            GameObject child = new GameObject(i.ToString());
            child.transform.parent = root.transform;
            child.layer = this.layer;

            SkinnedMeshRenderer smr = child.AddComponent<SkinnedMeshRenderer>();
            smr.sharedMesh = smrs[i].sharedMesh.Sekia_CopyMesh(true);
            smr.bones = bones_reflect.Sekia_GetArrayByIndexs(bone_index[i]);
            Material[] materials = new Material[smrs[i].sharedMaterials.Length];
            for (int n = 0; n < materials.Length; ++n)
            {
                materials[n] = smrs[i].sharedMaterials[n].Sekia_CopyMaterial();
            }
            smr.sharedMaterials = materials;
            smr.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.Off;
            smr.receiveShadows = false;
        }
    }

    void Change_Dynamic_Part(string prefab_name, string part_name)
    {
        #region 公共计算
        Transform root_parent = null; //固定的父级目标
        switch (part_name)
        {
            case "Hair_Front":
                root_parent = this.root_bone.Sekia_GetChildByName("Head_Top");
                break;
            case "Hair_Back":
                root_parent = this.root_bone.Sekia_GetChildByName("Head_Top");
                break;
            case "Hair_Ahoge":
                root_parent = this.root_bone.Sekia_GetChildByName("Head_Top");
                break;
            default:
                break;
        }
        Transform bone_root = new GameObject(prefab_name).transform;
        bone_root.parent = root_parent;
        bone_root.localPosition = new Vector3(0, 0, 0);
        bone_root.localEulerAngles = new Vector3(0, 0, 0);
        bone_root.localScale = new Vector3(1, 1, 1);
        Transform[] bones_new = new Transform[] { bone_root };//仅添加一根骨骼
        GameObject part = Resources.Load<GameObject>(prefab_name);
        GameObject root = null;
        if (!extra_Parts.TryGetValue(part_name, out root))
        {
            //如果不存在部件 新建根目录
            root = new GameObject(part_name);
            root.transform.parent = this.root_part;
            extra_Parts[part_name] = root;
        }
        else
        {
            //如果已存在部件 删除所有子gameObject和new骨骼
            GameObject[] childs = new GameObject[root.transform.childCount];
            for (int i = 0; i < root.transform.childCount; ++i)
            {
                childs[i] = root.transform.GetChild(i).gameObject;
            }
            for (int i = 0; i < childs.Length; ++i)
            {
                GameObject.Destroy(childs[i]);
            }

            Transform[] bones_old;
            if (extra_Bones.TryGetValue(part_name, out bones_old))
            {
                foreach (var value in bones_old)
                {
                    if (value != null)
                    {
                        GameObject.Destroy(value.gameObject);
                    }
                }
            }
        }
        #endregion

        #region smrs部分
        SkinnedMeshRenderer[] smrs = part.GetComponentsInChildren<SkinnedMeshRenderer>();
        Transform[] bones = part.transform.Sekia_GetChildsOfTransform(false);
        int[][] bone_index = new int[smrs.Length][]; //对应每个mesh的权重骨架
        for (int i = 0; i < smrs.Length; ++i)
        {
            bone_index[i] = new int[smrs[i].bones.Length];
            for (int n = 0; n < smrs[i].bones.Length; ++n)
            {
                bone_index[i][n] = bones.Sekia_GetIndexInArray(smrs[i].bones[n]);
            }
        }
        Transform[] bones_reflect = new Transform[bones.Length]; //新建gameObject骨架 映射旧骨架
        for (int i = 0; i < bones.Length; ++i) //遍历全部骨骼
        {
            Transform transform = new GameObject(bones[i].name).transform;
            int parent_index = bones.Sekia_GetIndexInArray(bones[i].parent);
            if (parent_index == -1)
            {
                transform.parent = bone_root;
            }
            else
            {
                transform.parent = bones_reflect[parent_index];
            }
            transform.localPosition = bones[i].localPosition;
            transform.localEulerAngles = bones[i].localEulerAngles;
            transform.localScale = bones[i].localScale;
            bones_reflect[i] = transform;
        }
        for (int i = 0; i < smrs.Length; ++i) //遍历mesh
        {
            GameObject child = new GameObject(i.ToString());
            child.transform.parent = root.transform;
            child.layer = this.layer;

            SkinnedMeshRenderer smr = child.AddComponent<SkinnedMeshRenderer>();
            smr.sharedMesh = smrs[i].sharedMesh.Sekia_CopyMesh(true);
            smr.bones = bones_reflect.Sekia_GetArrayByIndexs(bone_index[i]);
            Material[] materials = new Material[smrs[i].sharedMaterials.Length];
            for (int n = 0; n < materials.Length; ++n)
            {
                materials[n] = smrs[i].sharedMaterials[n].Sekia_CopyMaterial();
            }
            smr.sharedMaterials = materials;
            smr.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.Off;
            smr.receiveShadows = false;
        }
        #endregion

        #region mrs部分
        MeshRenderer[] mrs = part.GetComponentsInChildren<MeshRenderer>();
        for (int i = 0; i < mrs.Length; ++i)
        {
            GameObject child = new GameObject(i.ToString());
            child.transform.parent = bone_root; //MeshRenderer类似于单根骨骼
            child.transform.localPosition = new Vector3(0, 0, 0);
            child.transform.localEulerAngles = new Vector3(0, 0, 0);
            child.transform.localScale = new Vector3(1, 1, 1);
            child.layer = this.layer;

            MeshFilter mf = child.AddComponent<MeshFilter>();
            mf.sharedMesh = mrs[i].GetComponent<MeshFilter>().sharedMesh.Sekia_CopyMesh(true);
            MeshRenderer mr = child.AddComponent<MeshRenderer>();
            Material[] materials = new Material[mrs[i].sharedMaterials.Length];
            for (int n = 0; n < materials.Length; ++n)
            {
                materials[n] = mrs[i].sharedMaterials[n].Sekia_CopyMaterial();
            }
            mr.sharedMaterials = materials;
            mr.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.Off;
            mr.receiveShadows = false;
        }
        #endregion

        extra_Bones[part_name] = bones_new; //保存新骨架
    }

    public void Change_Clothes_Top(Clothes_Top_Kind part_id)
    {
        string prefab_name = "Prefabs/top_" + part_id.ToString();
        string part_name = "Clothes_Top";
        Change_Skeletion_Part(prefab_name, part_name);
    }

    public void Change_Clothes_Bot(Clothes_Bot_Kind part_id)
    {
        string prefab_name = "Prefabs/bot_" + part_id.ToString();
        string part_name = "Clothes_Bot";
        Change_Skeletion_Part(prefab_name, part_name);
    }

    public void Change_Clothes_Shoes(Clothes_Shoes_Kind part_id)
    {
        string prefab_name = "Prefabs/shoes_" + part_id.ToString();
        string part_name = "Clothes_Shoes";
        Change_Skeletion_Part(prefab_name, part_name);
    }

    public void Change_Hair_Front(Hair_Front_Kind part_id)
    {
        string prefab_name = "Prefabs/hair_" + part_id.ToString();
        string part_name = "Hair_Front";
        Change_Dynamic_Part(prefab_name, part_name);
    }

    public void Change_Hair_Back(Hair_Back_Kind part_id)
    {
        string prefab_name = "Prefabs/hair_" + part_id.ToString();
        string part_name = "Hair_Back";
        Change_Dynamic_Part(prefab_name, part_name);
    }

    public void Change_Hair_Ahoge(Hair_Ahoge_Kind part_id)
    {
        string prefab_name = "Prefabs/hair_" + part_id.ToString();
        string part_name = "Hair_Ahoge";
        Change_Dynamic_Part(prefab_name, part_name);
    }
    #endregion
}

#region 换装道具声明
public enum Clothes_Top_Kind
{
    aku01, army, babydoll01, bathtowel, cami01,
    cheer, cm01, cm02, cm03, cm04,
    cm05, cm06, epronH, epronJ, flowerP,
    fwanpi, Gymteacher, Heteacher, idol01, inner01,
    inner01_2, inner02, inner03, inner04, inner05,
    inner06, inner07, inner08, jacket01, jacket01_2,
    jacket02, jacket03, jacket04, jacket05, jacket06,
    jacket06_2, jacket07, jacket08, jacket09_ponco, jaji01,
    jtanktop, kimono, knight, kyuudou, kyuudou_MN,
    maid_01, manken, mathteacher, mijiP, neglige01,
    nursec, ofcard, oni, openparker, pajama01,
    pareo1c, pareo_suke, pareoS, parkeropm, run,
    sexypareo, shilon, suspend_t08, swim02, swim04,
    swim_bunny, swim_leotard_high, swim_leotard_nor, swim_otona, swim_SC,
    swimcattube, tennis, tsyatu01, tsyatu02, tsyatu03,
    tubet, whiteonep,
}

public enum Clothes_Bot_Kind
{
    cheer, culloteSK, cutepants, Gymteacher, halfpants,
    HeteacherSK, knightSK, kyuudou, magic, maid_01,
    mankenSK, mathteacher, pajama01, pants01, pants02,
    pants03, pants04_cargo, pants05_jajim, pants05_jajimsk, pantshot,
    pareo, run, skirt01, skirt02, skirt03,
    skirt04, skirt05, skirt06, skirt07, skirt08,
    skirt09, spants, swim02, swim03, swim04,
    swimcattube, tennis, tskmini,
}

public enum Clothes_Shoes_Kind
{
    armyboots, benjosand, bootsbelt, bsand, cheersboots,
    cheershort, dance, flowersand, fsand2, idol01,
    knight, magic, maid_01, manken, nursec,
    pumps01, pumpsR, reinapumps, ribonstrap, rinasandal,
    roafer01, run01, shell, summer, tennis,
    uwabaki01, zouri,
}

public enum Hair_Front_Kind
{
    f_01, f_02, f_02_i, f_03, f_03_i,
    f_04, f_05, f_06, f_07, f_08,
    f_09, f_10, f_11, f_11_i, f_12,
    f_12_i, f_13, f_14, f_14_i, f_15,
    f_15_i, f_16, f_17, f_18, f_19,
    f_20, f_20_i, f_21, f_21_i, f_22,
    f_23, f_24, f_25, f_25_i, f_26,
    f_30, f_31, f_32, f_32_i, f_33,
    f_33_i, f_34, f_100, f_101, f_102,
    f_103, f_104, f_105, f_106, f_107,
    f_108, f_109, f_110,
}

public enum Hair_Back_Kind
{
    b_01, b_02, b_02_a, b_02_i, b_02_i_a,
    b_03, b_04, b_05, b_06, b_06_a,
    b_07, b_09, b_10, b_10_a,
    b_11, b_11_i, b_12, b_13, b_14,
    b_15, b_16, b_17, b_18, b_19,
    b_20, b_21, b_22, b_23, b_24,
    b_24_i, b_30, b_31, b_31_i, b_33,
    b_100, b_101, b_102, b_103, b_104,
    b_105, b_106, b_107, b_108, b_109,
    b_110, b_111, b_112, b_113, b_114,
    b_115, b_116, b_117, b_118, b_119,
}

public enum Hair_Ahoge_Kind
{
    o_01, o_02, o_03, o_04, o_05,
    o_06, o_07, o_08,
}
#endregion
