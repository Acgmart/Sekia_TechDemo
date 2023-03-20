using System.Collections.Generic;
using UnityEngine;

/// <summary>
/// 定义了所有的可操作类型
/// </summary>
public class Custom_Config
{
    /// <summary>
    /// key1：操作编号 key2：骨骼编号 value：是否使用transform参数
    /// </summary>
    Dictionary<int, Dictionary<int, bool[]>> _Custom_Config;

    /// <summary>
    /// key1：骨骼编号 key2：操作编号 value：当前值/transform参数/曲线编号
    /// </summary>
    Dictionary<int, Dictionary<int, int[]>> _Custom_Keys;

    /// <summary>
    /// transform参数
    /// </summary>
    enum t
    {
        posx = 1,
        posy = 2,
        posz = 3,
        rotx = 4,
        roty = 5,
        rotz = 6,
        sclx = 7,
        scly = 8,
        sclz = 9,
    }

    enum p
    {
        fore_d005 = 0,
        fore_d01 = 1,
        midf_d025 = 2,
        midf_fd025 = 3,
        fore_fd025 = 4,
        twos_fd005 = 5,
        twos_fd01 = 6,
        twos_d015 = 7,
        twos_d005 = 8,
        twos_d0012 = 9,
        twos_fd0012 = 10,
        twos_10 = 11,
        twos_f10 = 12,
        fore_fd01 = 13,
        twos_d01 = 14,
        twos_20 = 15,
        twos_f20 = 16,
        fore_d025 = 17,
        fore_d05 = 18,
        twos_5 = 19,
        twos_f5 = 20,
        midf_fd01 = 21,
        midf_5 = 22,
        midf_d005 = 23,
        midf_f5 = 24,
        twos_d005ad01 = 25,
    }

    enum s
    {
        twos_5 = 0,
        back_f10 = 1,
        twos_10 = 2,
        midf_50 = 3,
        midf_f50 = 4,
        midf_25 = 5,
        fore_25 = 6,
        twos_25 = 7,
        fore_500 = 8,
        fore_f90 = 9,
        back_f20 = 10,
        midb_f25 = 11,
        twos_100 = 12,
        twos_f50a25 = 14,
        twos_50af25 = 13,
        twos_f25 = 15,
        twos_40a10 = 16,
    }

    /// <summary>
    /// 操作配置
    /// </summary>
    int[] config = new int[]
    {
        //操作0：脸部整体宽度 默认值50
        0, (int)t.sclx, (int)s.twos_5, (int)Bone_Custom.Cheek_Top_L,
        0, (int)t.sclx, (int)s.twos_5, (int)Bone_Custom.Cheek_Top_R,
        0, (int)t.sclx, (int)s.twos_5, (int)Bone_Custom.Cheek_Down_L,
        0, (int)t.sclx, (int)s.twos_5, (int)Bone_Custom.Cheek_Down_R,
        0, (int)t.sclx, (int)s.twos_5, (int)Bone_Custom.Chin,
        0, (int)t.sclx, (int)s.twos_5, (int)Bone_Custom.Chin_Side,
        0, (int)t.sclx, (int)s.twos_5, (int)Bone_Custom.Mouth_Cavity,
        0, (int)t.sclx, (int)s.twos_5, (int)Bone_Custom.Mouth,
        0, (int)t.sclx, (int)s.twos_5, (int)Bone_Custom.Head_Top,
        0, (int)t.sclx, (int)s.twos_5, (int)Bone_Custom.Nose,
        //操作1：额头前后 默认值0
        1, (int)t.posz, (int)p.fore_d005, (int)Bone_Custom.Head_Fore,
        1, (int)t.posz, (int)p.fore_d005, (int)Bone_Custom.Nose_Bridge,
        //操作2：头上部的上下 默认值0
        2, (int)t.posy, (int)p.fore_d01, (int)Bone_Custom.Head_Top,
        2, (int)t.posy, (int)p.fore_d01, (int)Bone_Custom.Nose_Bridge,
        //操作3：头上部的大小 默认值100
        3, (int)t.sclx, (int)s.back_f10, (int)Bone_Custom.Head_Top,
        3, (int)t.scly, (int)s.back_f10, (int)Bone_Custom.Head_Top,
        3, (int)t.sclz, (int)s.back_f10, (int)Bone_Custom.Head_Top,
        //操作4：头下部的前后 默认值0
        4, (int)t.posz, (int)p.fore_d005, (int)Bone_Custom.Cheek_Top_L,
        4, (int)t.posz, (int)p.fore_d005, (int)Bone_Custom.Cheek_Top_R,
        4, (int)t.posz, (int)p.fore_d005, (int)Bone_Custom.Cheek_Down_L,
        4, (int)t.posz, (int)p.fore_d005, (int)Bone_Custom.Cheek_Down_R,
        4, (int)t.posz, (int)p.fore_d005, (int)Bone_Custom.Chin,
        4, (int)t.posz, (int)p.fore_d005, (int)Bone_Custom.Chin_Side,
        4, (int)t.posz, (int)p.fore_d005, (int)Bone_Custom.Mouth_Cavity,
        4, (int)t.posz, (int)p.fore_d005, (int)Bone_Custom.Mouth,
        //操作5：脸颊的宽度 默认值50
        5, (int)t.posx, (int)p.midf_fd025, (int)Bone_Custom.Cheek_Side_L,
        5, (int)t.posx, (int)p.midf_d025, (int)Bone_Custom.Cheek_Side_R,
        5, (int)t.sclx, (int)s.twos_10, (int)Bone_Custom.Cheek_Top_L,
        5, (int)t.sclx, (int)s.twos_10, (int)Bone_Custom.Cheek_Top_R,
        5, (int)t.sclx, (int)s.twos_10, (int)Bone_Custom.Cheek_Down_L,
        5, (int)t.sclx, (int)s.twos_10, (int)Bone_Custom.Cheek_Down_R,
        5, (int)t.sclx, (int)s.twos_10, (int)Bone_Custom.Chin,
        5, (int)t.sclx, (int)s.twos_10, (int)Bone_Custom.Chin_Side,
        //操作6：下颚的肉度 默认值0
        6, (int)t.posy, (int)p.fore_fd025, (int)Bone_Custom.Chin_Side,
        6, (int)t.sclx, (int)s.midf_50, (int)Bone_Custom.Chin_Side,
        6, (int)t.scly, (int)s.midf_f50, (int)Bone_Custom.Chin_Side,
        6, (int)t.sclz, (int)s.midf_25, (int)Bone_Custom.Chin_Side,
        //操作7：下颚线末端的厚度 默认值0
        7, (int)t.posz, (int)p.fore_fd025, (int)Bone_Custom.Cheek_Down_L,
        7, (int)t.sclz, (int)s.fore_25, (int)Bone_Custom.Cheek_Down_L,
        7, (int)t.posz, (int)p.fore_fd025, (int)Bone_Custom.Cheek_Down_R,
        7, (int)t.sclz, (int)s.fore_25, (int)Bone_Custom.Cheek_Down_R,
        //操作8：下巴的上下 默认值50
        8, (int)t.posy, (int)p.twos_fd005, (int)Bone_Custom.Cheek_Down_L,
        8, (int)t.posy, (int)p.twos_fd005, (int)Bone_Custom.Cheek_Down_R,
        8, (int)t.posy, (int)p.twos_fd005, (int)Bone_Custom.Chin,
        //操作9：下巴的宽度 默认值50
        9, (int)t.sclx, (int)s.twos_25, (int)Bone_Custom.Cheek_Down_L,
        9, (int)t.sclx, (int)s.twos_25, (int)Bone_Custom.Cheek_Down_R,
        9, (int)t.sclx, (int)s.twos_25, (int)Bone_Custom.Chin,
        //操作10：下巴的前后 默认值50
        10, (int)t.posz, (int)p.twos_fd005, (int)Bone_Custom.Cheek_Down_L,
        10, (int)t.posz, (int)p.twos_fd005, (int)Bone_Custom.Cheek_Down_R,
        10, (int)t.posz, (int)p.twos_fd005, (int)Bone_Custom.Chin,
        //操作11：下巴尖的上下 默认值50
        11, (int)t.posy, (int)p.twos_fd01, (int)Bone_Custom.Chin_Tip,
        //操作12：下巴尖的前后 默认值50
        12, (int)t.posz, (int)p.twos_fd01, (int)Bone_Custom.Chin_Tip,
        //操作13：下巴尖的宽度 默认值0
        13, (int)t.sclx, (int)s.fore_500, (int)Bone_Custom.Chin_Tip,
        //操作14：脸颊侧面宽度 默认值50
        14, (int)t.sclx, (int)s.twos_25, (int)Bone_Custom.Cheek_Side_L,
        14, (int)t.sclx, (int)s.twos_25, (int)Bone_Custom.Cheek_Side_R,
        //操作15：脸颊侧面前后 默认值50
        15, (int)t.posz, (int)p.twos_d015, (int)Bone_Custom.Cheek_Side_L,
        15, (int)t.posz, (int)p.twos_d015, (int)Bone_Custom.Cheek_Side_R,
        //操作16：脸颊的宽度 默认值50
        16, (int)t.posx, (int)p.twos_fd005, (int)Bone_Custom.Cheek_Top_L,
        16, (int)t.posx, (int)p.twos_d005, (int)Bone_Custom.Cheek_Top_R,
        //操作17：脸颊的前后 默认值50
        17, (int)t.posz, (int)p.twos_d005, (int)Bone_Custom.Cheek_Top_L,
        17, (int)t.posz, (int)p.twos_d005, (int)Bone_Custom.Cheek_Top_R,
        //操作18：脸颊的上下 默认值50
        18, (int)t.posy, (int)p.twos_d005, (int)Bone_Custom.Cheek_Top_L,
        18, (int)t.posy, (int)p.twos_d005, (int)Bone_Custom.Cheek_Top_R,
        //操作19：眉毛的上下 默认值50
        19, (int)t.posy, (int)p.twos_d005, (int)Bone_Custom.Mayu_Mid_L,
        19, (int)t.posy, (int)p.twos_d005, (int)Bone_Custom.Mayu_Mid_R,
        19, (int)t.posy, (int)p.twos_d005, (int)Bone_Custom.Mayu_Tip_L,
        19, (int)t.posy, (int)p.twos_d005, (int)Bone_Custom.Mayu_Tip_R,
        19, (int)t.posz, (int)p.twos_d005, (int)Bone_Custom.Mayu_Mid_L,
        19, (int)t.posz, (int)p.twos_d0012, (int)Bone_Custom.Mayu_Mid_R,
        19, (int)t.posz, (int)p.twos_d0012, (int)Bone_Custom.Mayu_Tip_L,
        19, (int)t.posz, (int)p.twos_d0012, (int)Bone_Custom.Mayu_Tip_R,
        //操作20：眉毛的左右 默认值50
        20, (int)t.posx, (int)p.twos_d0012, (int)Bone_Custom.Mayu_Mid_L,
        20, (int)t.posx, (int)p.twos_fd0012, (int)Bone_Custom.Mayu_Mid_R,
        20, (int)t.posx, (int)p.twos_d0012, (int)Bone_Custom.Mayu_Tip_L,
        20, (int)t.posx, (int)p.twos_fd0012, (int)Bone_Custom.Mayu_Tip_R,
        //操控21：眉毛的角度 默认值50
        21, (int)t.rotz, (int)p.twos_10, (int)Bone_Custom.Mayu_Mid_L,
        21, (int)t.rotz, (int)p.twos_f10, (int)Bone_Custom.Mayu_Mid_R,
        21, (int)t.rotz, (int)p.twos_10, (int)Bone_Custom.Mayu_Tip_L,
        21, (int)t.rotz, (int)p.twos_f10, (int)Bone_Custom.Mayu_Tip_R,
        //操作22：眉毛的内侧形状 默认值50
        22, (int)t.rotz, (int)p.twos_10, (int)Bone_Custom.Mayu_Mid_L,
        22, (int)t.rotz, (int)p.twos_f10, (int)Bone_Custom.Mayu_Mid_R,
        //操作23：眉毛的外侧形状 默认值50
        23, (int)t.rotz, (int)p.twos_10, (int)Bone_Custom.Mayu_Tip_L,
        23, (int)t.rotz, (int)p.twos_f10, (int)Bone_Custom.Mayu_Tip_R,
        //操作24：眼部1上下 默认值50
        24, (int)t.posy, (int)p.twos_d005, (int)Bone_Custom.Eye2_L,
        24, (int)t.posy, (int)p.twos_d005, (int)Bone_Custom.Eye2_R,
        //操作25：眼部2上下 默认值50
        25, (int)t.posy, (int)p.twos_d005, (int)Bone_Custom.Eye3_L,
        25, (int)t.posy, (int)p.twos_d005, (int)Bone_Custom.Eye3_R,
        //操作26：眼部3上下 默认值50
        26, (int)t.posy, (int)p.twos_d005, (int)Bone_Custom.Eye4_L,
        26, (int)t.posy, (int)p.twos_d005, (int)Bone_Custom.Eye4_R,
        //操作27：眼部4上下 默认值50
        27, (int)t.posy, (int)p.twos_d005, (int)Bone_Custom.Eye8_L,
        27, (int)t.posy, (int)p.twos_d005, (int)Bone_Custom.Eye8_R,
        //操作28：眼部5上下 默认值50
        28, (int)t.posy, (int)p.twos_d005, (int)Bone_Custom.Eye7_L,
        28, (int)t.posy, (int)p.twos_d005, (int)Bone_Custom.Eye7_R,
        //操作29：眼部6上下 默认值50
        29, (int)t.posy, (int)p.twos_d005, (int)Bone_Custom.Eye6_L,
        29, (int)t.posy, (int)p.twos_d005, (int)Bone_Custom.Eye6_R,
        //操作30：眼部的上下 默认值50
        30, (int)t.posy, (int)p.twos_d005, (int)Bone_Custom.Eye_L,
        30, (int)t.posy, (int)p.twos_d005, (int)Bone_Custom.Eye_R,
        30, (int)t.posy, (int)p.twos_d0012, (int)Bone_Custom.Cheek_Top_L,
        30, (int)t.posy, (int)p.twos_d0012, (int)Bone_Custom.Cheek_Top_R,
        //操作31：眼部的左右 默认值50
        31, (int)t.posx, (int)p.twos_d005, (int)Bone_Custom.Eye_L,
        31, (int)t.posx, (int)p.twos_fd005, (int)Bone_Custom.Eye_R,
        //操作32：眼部的前后 默认值50
        32, (int)t.posz, (int)p.twos_d005, (int)Bone_Custom.Eye_L,
        32, (int)t.posz, (int)p.twos_d005, (int)Bone_Custom.Eye_R,
        //操作33：眼部的角度 默认值50
        33, (int)t.rotz, (int)p.twos_10, (int)Bone_Custom.Eye_L,
        33, (int)t.rotz, (int)p.twos_f10, (int)Bone_Custom.Eye_R,
        //操作34：眼部的高度 默认值50
        34, (int)t.scly, (int)s.twos_10, (int)Bone_Custom.Eye_L,
        34, (int)t.scly, (int)s.twos_10, (int)Bone_Custom.Eye_R,
        //操作35：眼部的宽度 默认值50
        35, (int)t.sclx, (int)s.twos_10, (int)Bone_Custom.Eye_L,
        35, (int)t.sclx, (int)s.twos_10, (int)Bone_Custom.Eye_R,
        //操作36：内眦的左右 默认值0
        36, (int)t.posx, (int)p.fore_d01, (int)Bone_Custom.Eye1_L,
        36, (int)t.posx, (int)p.fore_fd01, (int)Bone_Custom.Eye1_R,
        //操作37：外眦的上下 默认值50
        37, (int)t.posy, (int)p.twos_d005, (int)Bone_Custom.Eye5_L,
        37, (int)t.posy, (int)p.twos_d005, (int)Bone_Custom.Eye5_R,
        //操作38：鼻尖的高度 默认值50
        38, (int)t.posz, (int)p.twos_d01, (int)Bone_Custom.Nose_Tip,
        //操作39：鼻尖的上下 默认值50
        39, (int)t.posy, (int)p.twos_d01, (int)Bone_Custom.Nose_Tip,
        39, (int)t.posz, (int)p.twos_d0012, (int)Bone_Custom.Nose_Tip,
        //操作40：鼻梁的高度 默认值50
        40, (int)t.posz, (int)p.twos_d01, (int)Bone_Custom.Nose_Bridge,
        //操作41：嘴的上下 默认值50
        41, (int)t.posy, (int)p.twos_d005, (int)Bone_Custom.Mouth,
        41, (int)t.posy, (int)p.twos_d005, (int)Bone_Custom.Mouth_Cavity,
        41, (int)t.posz, (int)p.twos_d0012, (int)Bone_Custom.Mouth,
        41, (int)t.posz, (int)p.twos_d0012, (int)Bone_Custom.Mouth_Cavity,
        //操作42：嘴的宽度 默认值50
        42, (int)t.posx, (int)p.twos_d01, (int)Bone_Custom.Mouth_L,
        42, (int)t.posx, (int)p.twos_fd01, (int)Bone_Custom.Mouth_R,
        //操作43：嘴的前后 默认值50
        43, (int)t.posz, (int)p.twos_d005, (int)Bone_Custom.Mouth,
        43, (int)t.posz, (int)p.twos_d005, (int)Bone_Custom.Mouth_Cavity,
        //操作44：嘴上部的高度 默认值50
        44, (int)t.posz, (int)p.twos_d005, (int)Bone_Custom.Mouth_Top,
        //操作45：嘴下部的高度 默认值50
        45, (int)t.posz, (int)p.twos_d005, (int)Bone_Custom.Mouth_Down,
        //操作46：嘴的形状 默认值50
        46, (int)t.posy, (int)p.twos_d005, (int)Bone_Custom.Mouth_L,
        46, (int)t.posy, (int)p.twos_d005, (int)Bone_Custom.Mouth_R,
        //操作47：耳朵的大小 默认值50
        47, (int)t.sclx, (int)s.twos_25, (int)Bone_Custom.Ear_L,
        47, (int)t.sclx, (int)s.twos_25, (int)Bone_Custom.Ear_R,
        47, (int)t.scly, (int)s.twos_25, (int)Bone_Custom.Ear_L,
        47, (int)t.scly, (int)s.twos_25, (int)Bone_Custom.Ear_R,
        47, (int)t.sclz, (int)s.twos_25, (int)Bone_Custom.Ear_L,
        47, (int)t.sclz, (int)s.twos_25, (int)Bone_Custom.Ear_R,
        //操作48：耳朵的角度Y轴 默认值50
        48, (int)t.roty, (int)p.twos_20, (int)Bone_Custom.Ear_L,
        48, (int)t.roty, (int)p.twos_f20, (int)Bone_Custom.Ear_R,
        //操作49：耳朵的角度Z轴 默认值50
        49, (int)t.rotz, (int)p.twos_10, (int)Bone_Custom.Ear_L,
        49, (int)t.rotz, (int)p.twos_f10, (int)Bone_Custom.Ear_R,
        //操作50：耳朵上部的形变 默认值0
        50, (int)t.posx, (int)p.fore_fd025, (int)Bone_Custom.Ear_Top_L,
        50, (int)t.posx, (int)p.fore_d025, (int)Bone_Custom.Ear_Top_R,
        50, (int)t.posy, (int)p.fore_d05, (int)Bone_Custom.Ear_Top_L,
        50, (int)t.posy, (int)p.fore_d05, (int)Bone_Custom.Ear_Top_R,
        50, (int)t.sclx, (int)s.fore_f90, (int)Bone_Custom.Ear_Top_L,
        50, (int)t.sclx, (int)s.fore_f90, (int)Bone_Custom.Ear_Top_R,
        50, (int)t.scly, (int)s.fore_f90, (int)Bone_Custom.Ear_Top_L,
        50, (int)t.scly, (int)s.fore_f90, (int)Bone_Custom.Ear_Top_R,
        50, (int)t.sclz, (int)s.fore_f90, (int)Bone_Custom.Ear_Top_L,
        50, (int)t.sclz, (int)s.fore_f90, (int)Bone_Custom.Ear_Top_R,
        //操作51：耳朵下部的形变 默认值50
        51, (int)t.posy, (int)p.twos_d005, (int)Bone_Custom.Ear_Down_L,
        51, (int)t.posy, (int)p.twos_d005, (int)Bone_Custom.Ear_Down_R,
        //操作52：身体的大小 默认值100
        52, (int)t.sclx, (int)s.back_f20, (int)Bone_Custom.Root,
        52, (int)t.scly, (int)s.back_f20, (int)Bone_Custom.Root,
        52, (int)t.sclz, (int)s.back_f20, (int)Bone_Custom.Root,
        //操作53：头的大小 默认值100
        53, (int)t.sclx, (int)s.back_f20, (int)Bone_Custom.Head,
        53, (int)t.scly, (int)s.back_f20, (int)Bone_Custom.Head,
        53, (int)t.sclz, (int)s.back_f20, (int)Bone_Custom.Head,
        //操作54：胸部的大小 默认值50
        54, (int)t.rotx, (int)p.twos_5, (int)Bone_Custom.c_bust1_L,//下垂
        54, (int)t.posy, (int)p.midf_fd01, (int)Bone_Custom.c_bust1_L,//下移
        54, (int)t.posz, (int)p.twos_d005, (int)Bone_Custom.c_bust1_L,//前后移
        54, (int)t.rotx, (int)p.twos_5, (int)Bone_Custom.c_bust1_R,
        54, (int)t.posy, (int)p.midf_fd01, (int)Bone_Custom.c_bust1_R,
        54, (int)t.posz, (int)p.twos_d005, (int)Bone_Custom.c_bust1_R,
        54, (int)t.sclx, (int)s.twos_50af25, (int)Bone_Custom.c_bust2_L,
        54, (int)t.scly, (int)s.twos_50af25, (int)Bone_Custom.c_bust2_L,
        54, (int)t.sclz, (int)s.twos_100, (int)Bone_Custom.c_bust2_L,
        54, (int)t.rotx, (int)p.midf_5, (int)Bone_Custom.c_bust2_L,
        54, (int)t.posy, (int)p.midf_fd01, (int)Bone_Custom.c_bust2_L,
        54, (int)t.posz, (int)p.twos_d015, (int)Bone_Custom.c_bust2_L,
        54, (int)t.sclx, (int)s.twos_50af25, (int)Bone_Custom.c_bust2_R,
        54, (int)t.scly, (int)s.twos_50af25, (int)Bone_Custom.c_bust2_R,
        54, (int)t.sclz, (int)s.twos_100, (int)Bone_Custom.c_bust2_R,
        54, (int)t.rotx, (int)p.midf_5, (int)Bone_Custom.c_bust2_R,
        54, (int)t.posy, (int)p.midf_fd01, (int)Bone_Custom.c_bust2_R,
        54, (int)t.posz, (int)p.twos_d015, (int)Bone_Custom.c_bust2_R,
        54, (int)t.sclx, (int)s.twos_f50a25, (int)Bone_Custom.c_bust3_L,
        54, (int)t.scly, (int)s.twos_f50a25, (int)Bone_Custom.c_bust3_L,
        54, (int)t.sclz, (int)s.twos_f50a25, (int)Bone_Custom.c_bust3_L,
        54, (int)t.posy, (int)p.midf_d005, (int)Bone_Custom.c_bust3_L,
        54, (int)t.rotx, (int)p.midf_f5, (int)Bone_Custom.c_bust3_L,
        54, (int)t.sclx, (int)s.twos_f50a25, (int)Bone_Custom.c_bust3_R,
        54, (int)t.scly, (int)s.twos_f50a25, (int)Bone_Custom.c_bust3_R,
        54, (int)t.sclz, (int)s.twos_f50a25, (int)Bone_Custom.c_bust3_R,
        54, (int)t.posy, (int)p.midf_d005, (int)Bone_Custom.c_bust3_R,
        54, (int)t.rotx, (int)p.midf_f5, (int)Bone_Custom.c_bust3_R,
        //操作55：胸部的上下 默认值50
        55, (int)t.posy, (int)p.twos_d015, (int)Bone_Custom.c_bust1_L,
        55, (int)t.posy, (int)p.twos_d015, (int)Bone_Custom.c_bust1_R,
        //操作56：胸部的左右角度 默认值50
        56, (int)t.roty, (int)p.twos_f10, (int)Bone_Custom.c_bust1_L,
        56, (int)t.roty, (int)p.twos_10, (int)Bone_Custom.c_bust1_R,
        //操作57：胸部的左右 默认值50
        57, (int)t.posx, (int)p.twos_fd005, (int)Bone_Custom.c_bust1_L,
        57, (int)t.posx, (int)p.twos_d005, (int)Bone_Custom.c_bust1_R,
        //操作58：胸部的上下角度 默认值50
        58, (int)t.posz, (int)p.twos_d005ad01, (int)Bone_Custom.c_bust1_L,
        58, (int)t.posz, (int)p.twos_d005ad01, (int)Bone_Custom.c_bust1_R,
        58, (int)t.rotx, (int)p.twos_f10, (int)Bone_Custom.c_bust1_L,
        58, (int)t.rotx, (int)p.twos_f10, (int)Bone_Custom.c_bust1_R,
        //操作59：胸部前端的粗细 默认值50
        59, (int)t.sclx, (int)s.twos_f25, (int)Bone_Custom.c_bust3_L,
        59, (int)t.scly, (int)s.twos_f25, (int)Bone_Custom.c_bust3_L,
        59, (int)t.posz, (int)p.twos_d005, (int)Bone_Custom.c_bust3_L,
        59, (int)t.sclx, (int)s.twos_f25, (int)Bone_Custom.c_bust3_R,
        59, (int)t.scly, (int)s.twos_f25, (int)Bone_Custom.c_bust3_R,
        59, (int)t.posz, (int)p.twos_d005, (int)Bone_Custom.c_bust3_R,
        //操作60：胸部整体变圆 默认值50
        60, (int)t.sclx, (int)s.twos_f25, (int)Bone_Custom.c_bust1_L,
        60, (int)t.scly, (int)s.twos_f25, (int)Bone_Custom.c_bust1_L,
        60, (int)t.sclx, (int)s.twos_50af25, (int)Bone_Custom.c_bust2_L,
        60, (int)t.scly, (int)s.twos_50af25, (int)Bone_Custom.c_bust2_L,
        60, (int)t.sclz, (int)s.twos_40a10, (int)Bone_Custom.c_bust2_L,
        60, (int)t.posz, (int)p.midf_fd025, (int)Bone_Custom.c_bust2_L,
        //操作61：乳轮的长度 默认值0
        61, (int)t.posz, (int)p.fore_d01, (int)Bone_Custom.c_bnip1_L,
        61, (int)t.posz, (int)p.fore_d01, (int)Bone_Custom.c_bnip1_R,
        //操作62：乳头的半径 默认值50
        62, (int)t.sclx, (int)s.twos_25, (int)Bone_Custom.c_bnip2_L,
        62, (int)t.scly, (int)s.twos_25, (int)Bone_Custom.c_bnip2_L,
        62, (int)t.sclz, (int)s.twos_25, (int)Bone_Custom.c_bnip2_L,
        62, (int)t.sclx, (int)s.twos_25, (int)Bone_Custom.c_bnip2_R,
        62, (int)t.scly, (int)s.twos_25, (int)Bone_Custom.c_bnip2_R,
        62, (int)t.sclz, (int)s.twos_25, (int)Bone_Custom.c_bnip2_R,
        //操作63：乳头的长度 默认值0
        63, (int)t.posz, (int)p.fore_d005, (int)Bone_Custom.c_bnip2_L,
        63, (int)t.posz, (int)p.fore_d005, (int)Bone_Custom.c_bnip2_L,
        //操作64：脖子的宽度 默认值50
        64, (int)t.sclx, (int)s.twos_10, (int)Bone_Custom.c_neck,
        //操作65：脖子的厚度 默认值50
        65, (int)t.sclz, (int)s.twos_25, (int)Bone_Custom.c_neck,
        //操作66：胸围的宽度 默认值50
        66, (int)t.sclx, (int)s.twos_10, (int)Bone_Custom.c_spine3,
        66, (int)t.posx, (int)p.twos_fd01, (int)Bone_Custom.c_clavicle_L,
        66, (int)t.posx, (int)p.twos_d01, (int)Bone_Custom.c_clavicle_R,
        //操作67：胸围的厚度 默认值50
        67, (int)t.sclz, (int)s.twos_10, (int)Bone_Custom.c_spine3,
        67, (int)t.sclz, (int)s.twos_10, (int)Bone_Custom.c_clavicle_L,
        67, (int)t.sclz, (int)s.twos_10, (int)Bone_Custom.c_clavicle_R,
        67, (int)t.posz, (int)p.twos_d01, (int)Bone_Custom.c_bust1_L,
        67, (int)t.posz, (int)p.twos_d01, (int)Bone_Custom.c_bust1_R,
        //操作68：胸下的宽度 默认值50
        68, (int)t.sclx, (int)s.twos_10, (int)Bone_Custom.c_spine2,
        //操作69：胸下的厚度 默认值50
        69, (int)t.sclz, (int)s.twos_10, (int)Bone_Custom.c_spine2,
        69, (int)t.posz, (int)p.twos_d005, (int)Bone_Custom.c_bust1_L,
        69, (int)t.posz, (int)p.twos_d005, (int)Bone_Custom.c_bust1_R,
        //操作70：腰上部的宽度 默认值50
        70, (int)t.sclx, (int)s.twos_50af25, (int)Bone_Custom.c_spine1,
        //操作71：腰上部的厚度 默认值50
        71, (int)t.sclz, (int)s.twos_50af25, (int)Bone_Custom.c_spine1,
        71, (int)t.posz, (int)p.midf_fd01, (int)Bone_Custom.c_spine1,
        //操作72：腰上部的上下位置 默认值50
        72, (int)t.posy, (int)p.twos_d015, (int)Bone_Custom.c_spine1,
        //操作73：腰上+腰的角度 默认值50
        73, (int)t.sclx, (int)s.twos_10, (int)Bone_Custom.c_spine1,
        73, (int)t.sclz, (int)s.twos_10, (int)Bone_Custom.c_spine1,
        73, (int)t.scly, (int)s.midf_25, (int)Bone_Custom.c_spine1,
        73, (int)t.rotx, (int)p.midf_5, (int)Bone_Custom.c_spine1,
        73, (int)t.sclx, (int)s.twos_10, (int)Bone_Custom.c_waist1,
        73, (int)t.sclz, (int)s.twos_10, (int)Bone_Custom.c_waist1,
        73, (int)t.scly, (int)s.midf_25, (int)Bone_Custom.c_waist1,
        73, (int)t.rotx, (int)p.midf_5, (int)Bone_Custom.c_waist1,
        73, (int)t.posy, (int)p.twos_fd0012, (int)Bone_Custom.c_waist1,
        //操作74：腰的宽度 默认值50
        74, (int)t.sclx, (int)s.twos_25, (int)Bone_Custom.c_waist1,
        //操作75：腰的厚度 默认值50
        75, (int)t.sclz, (int)s.twos_25, (int)Bone_Custom.c_waist1,
        //操作76：臀的宽度 默认值50
        76, (int)t.sclx, (int)s.twos_25, (int)Bone_Custom.c_waist2,
        //操作77：臀的厚度 默认值50
        77, (int)t.sclz, (int)s.twos_25, (int)Bone_Custom.c_waist2,
        77, (int)t.posz, (int)p.twos_fd01, (int)Bone_Custom.c_waist2,
        //操作78：屁股的大小 默认值50
        78, (int)t.sclx, (int)s.twos_25, (int)Bone_Custom.c_siri_L,
        78, (int)t.scly, (int)s.twos_25, (int)Bone_Custom.c_siri_L,
        78, (int)t.sclz, (int)s.twos_25, (int)Bone_Custom.c_siri_L,
        78, (int)t.posz, (int)p.twos_fd005, (int)Bone_Custom.c_siri_L,
        78, (int)t.sclx, (int)s.twos_25, (int)Bone_Custom.c_siri_R,
        78, (int)t.scly, (int)s.twos_25, (int)Bone_Custom.c_siri_R,
        78, (int)t.sclz, (int)s.twos_25, (int)Bone_Custom.c_siri_R,
        78, (int)t.posz, (int)p.twos_fd005, (int)Bone_Custom.c_siri_R,
        //操作79：屁股的角度 默认值50
        79, (int)t.rotx, (int)p.twos_10, (int)Bone_Custom.c_siri_L,
        79, (int)t.posy, (int)p.twos_d015, (int)Bone_Custom.c_siri_L,
        79, (int)t.rotx, (int)p.twos_10, (int)Bone_Custom.c_siri_R,
        79, (int)t.posy, (int)p.twos_d015, (int)Bone_Custom.c_siri_R,
        //操作80：肩膀的宽度 默认值50
        80, (int)t.sclx, (int)s.midf_25, (int)Bone_Custom.c_clavicle_L,
        80, (int)t.scly, (int)s.twos_25, (int)Bone_Custom.c_clavicle_L,
        80, (int)t.posy, (int)p.midf_d005, (int)Bone_Custom.c_clavicle_L,
        80, (int)t.scly, (int)s.twos_25, (int)Bone_Custom.c_upperarm1_L,
        80, (int)t.posy, (int)p.twos_d005, (int)Bone_Custom.c_upperarm1_L,
        80, (int)t.sclx, (int)s.midf_25, (int)Bone_Custom.c_clavicle_R,
        80, (int)t.scly, (int)s.twos_25, (int)Bone_Custom.c_clavicle_R,
        80, (int)t.posy, (int)p.midf_d005, (int)Bone_Custom.c_clavicle_R,
        80, (int)t.scly, (int)s.twos_25, (int)Bone_Custom.c_upperarm1_R,
        80, (int)t.posy, (int)p.twos_d005, (int)Bone_Custom.c_upperarm1_R,
        //操作81：肩膀的厚度 默认值50
        81, (int)t.sclz, (int)s.twos_25, (int)Bone_Custom.c_clavicle_L,
        81, (int)t.sclz, (int)s.twos_25, (int)Bone_Custom.c_upperarm1_L,
        81, (int)t.sclz, (int)s.twos_25, (int)Bone_Custom.c_clavicle_R,
        81, (int)t.sclz, (int)s.twos_25, (int)Bone_Custom.c_upperarm1_R,
        //操作82：上臂中下部的宽度 默认值50
        82, (int)t.scly, (int)s.twos_25, (int)Bone_Custom.c_upperarm2_L,
        82, (int)t.scly, (int)s.twos_25, (int)Bone_Custom.c_upperarm3_L,
        82, (int)t.scly, (int)s.twos_25, (int)Bone_Custom.c_upperarm2_R,
        82, (int)t.scly, (int)s.twos_25, (int)Bone_Custom.c_upperarm3_R,
        //操作83：上臂中下部的厚度 默认值50
        83, (int)t.sclz, (int)s.twos_25, (int)Bone_Custom.c_upperarm2_L,
        83, (int)t.sclz, (int)s.twos_25, (int)Bone_Custom.c_upperarm3_L,
        83, (int)t.sclz, (int)s.twos_25, (int)Bone_Custom.c_upperarm2_R,
        83, (int)t.sclz, (int)s.twos_25, (int)Bone_Custom.c_upperarm3_R,
        //操作84：下臂上部的宽度 默认值50
        84, (int)t.scly, (int)s.twos_25, (int)Bone_Custom.c_forearm1_L,
        84, (int)t.scly, (int)s.twos_25, (int)Bone_Custom.c_forearm2_L,
        84, (int)t.scly, (int)s.twos_25, (int)Bone_Custom.c_forearm1_R,
        84, (int)t.scly, (int)s.twos_25, (int)Bone_Custom.c_forearm2_R,
        //操作85：下臂上部的厚度 默认值50
        85, (int)t.sclz, (int)s.twos_25, (int)Bone_Custom.c_forearm1_L,
        85, (int)t.sclz, (int)s.twos_25, (int)Bone_Custom.c_forearm2_L,
        85, (int)t.sclz, (int)s.twos_25, (int)Bone_Custom.c_forearm1_R,
        85, (int)t.sclz, (int)s.twos_25, (int)Bone_Custom.c_forearm2_R,
        //操作86：下臂下部的大小 默认值50
        86, (int)t.scly, (int)s.twos_25, (int)Bone_Custom.c_forearm3_L,
        86, (int)t.sclz, (int)s.twos_25, (int)Bone_Custom.c_forearm3_L,
        86, (int)t.scly, (int)s.twos_25, (int)Bone_Custom.c_forearm3_R,
        86, (int)t.sclz, (int)s.twos_25, (int)Bone_Custom.c_forearm3_R,
        //操作87：大腿上部的宽度 默认值50
        87, (int)t.sclx, (int)s.twos_10, (int)Bone_Custom.c_thigh1_L,
        87, (int)t.posx, (int)p.twos_fd01, (int)Bone_Custom.c_thigh1_L,
        87, (int)t.sclx, (int)s.twos_10, (int)Bone_Custom.c_thigh2_L,
        87, (int)t.posx, (int)p.twos_fd01, (int)Bone_Custom.c_thigh2_L,
        87, (int)t.sclx, (int)s.twos_10, (int)Bone_Custom.c_thigh1_R,
        87, (int)t.posx, (int)p.twos_d01, (int)Bone_Custom.c_thigh1_R,
        87, (int)t.sclx, (int)s.twos_10, (int)Bone_Custom.c_thigh2_R,
        87, (int)t.posx, (int)p.twos_d01, (int)Bone_Custom.c_thigh2_R,
        //操作88：大腿上部的厚度 默认值50
        88, (int)t.sclz, (int)s.twos_10, (int)Bone_Custom.c_thigh1_L,
        88, (int)t.posz, (int)p.twos_fd005, (int)Bone_Custom.c_thigh1_L,
        88, (int)t.sclz, (int)s.twos_10, (int)Bone_Custom.c_thigh2_L,
        88, (int)t.posz, (int)p.twos_fd005, (int)Bone_Custom.c_thigh2_L,
        88, (int)t.sclz, (int)s.twos_10, (int)Bone_Custom.c_thigh1_R,
        88, (int)t.posz, (int)p.twos_fd005, (int)Bone_Custom.c_thigh1_R,
        88, (int)t.sclz, (int)s.twos_10, (int)Bone_Custom.c_thigh2_R,
        88, (int)t.posz, (int)p.twos_fd005, (int)Bone_Custom.c_thigh2_R,
        //操作89：大腿下部的宽度 默认值50
        89, (int)t.sclx, (int)s.twos_10, (int)Bone_Custom.c_thigh3_L,
        89, (int)t.posx, (int)p.twos_fd0012, (int)Bone_Custom.c_thigh3_L,
        89, (int)t.sclx, (int)s.twos_10, (int)Bone_Custom.c_thigh3_R,
        89, (int)t.posx, (int)p.twos_d0012, (int)Bone_Custom.c_thigh3_R,
        //操作90：大腿下部的厚度 默认值50
        90, (int)t.sclz, (int)s.twos_10, (int)Bone_Custom.c_thigh3_L,
        90, (int)t.posz, (int)p.twos_fd0012, (int)Bone_Custom.c_thigh3_L,
        90, (int)t.sclz, (int)s.twos_10, (int)Bone_Custom.c_thigh3_R,
        90, (int)t.posz, (int)p.twos_fd0012, (int)Bone_Custom.c_thigh3_R,
        //操作91：小腿上部的宽度 默认值50
        91, (int)t.sclx, (int)s.twos_10, (int)Bone_Custom.c_calf1_L,
        91, (int)t.sclx, (int)s.twos_10, (int)Bone_Custom.c_calf1_R,
        //操作92：小腿上部的厚度 默认值50
        92, (int)t.sclz, (int)s.twos_10, (int)Bone_Custom.c_calf1_L,
        92, (int)t.posz, (int)p.twos_fd0012, (int)Bone_Custom.c_calf1_L,
        92, (int)t.sclz, (int)s.twos_10, (int)Bone_Custom.c_calf1_R,
        92, (int)t.posz, (int)p.twos_fd0012, (int)Bone_Custom.c_calf1_R,
        //操作93：小腿中部的宽度+厚度 默认值50
        93, (int)t.sclx, (int)s.twos_10, (int)Bone_Custom.c_calf2_L,
        93, (int)t.sclz, (int)s.twos_10, (int)Bone_Custom.c_calf2_L,
        93, (int)t.sclx, (int)s.twos_10, (int)Bone_Custom.c_calf2_R,
        93, (int)t.sclz, (int)s.twos_10, (int)Bone_Custom.c_calf2_R,
        //操作94：小腿下部的宽度 默认值50
        94, (int)t.sclx, (int)s.twos_10, (int)Bone_Custom.c_calf3_L,
        94, (int)t.sclx, (int)s.twos_10, (int)Bone_Custom.c_calf3_R,
        //操作95：小腿下部的厚度 默认值50
        95, (int)t.sclz, (int)s.twos_10, (int)Bone_Custom.c_calf3_L,
        95, (int)t.sclz, (int)s.twos_10, (int)Bone_Custom.c_calf3_R,
    };

    float[] position_curves = new float[]
    {
        //曲线0：正向0.005
        .0000F,.0002F,.0004F,.0006F,.0008F,
        .0010F,.0012F,.0014F,.0016F,.0018F,
        .0020F,.0022F,.0024F,.0026F,.0028F,
        .0030F,.0032F,.0034F,.0036F,.0038F,
        .0040F,.0042F,.0044F,.0046F,.0048F,
        //曲线1：正向0.01
        .0000F,.0004F,.0008F,.0012F,.0016F,
        .0020F,.0024F,.0028F,.0032F,.0036F,
        .0040F,.0044F,.0048F,.0052F,.0056F,
        .0060F,.0064F,.0068F,.0072F,.0076F,
        .0080F,.0084F,.0088F,.0092F,.0098F,
        //曲线2：从中间0.025
        .000F,.000F,.000F,.000F,.000F,
        .000F,.000F,.000F,.000F,.000F,
        .000F,.000F,.000F,.002F,.004F,
        .006F,.008F,.010F,.012F,.014F,
        .016F,.018F,.020F,.022F,.024F,
        //曲线3：从中间-0.025
        .000F,.000F,.000F,.000F,.000F,
        .000F,.000F,.000F,.000F,.000F,
        .000F,.000F,.000F,-.002F,-.004F,
        -.006F,-.008F,-.010F,-.012F,-.014F,
        -.016F,-.018F,-.020F,-.022F,-.024F,
        //曲线4：正向-0.025
        .000F,-.001F,-.002F,-.003F,-.004F,
        -.005F,-.006F,-.007F,-.008F,-.009F,
        -.010F,-.011F,-.012F,-.013F,-.014F,
        -.015F,-.016F,-.017F,-.018F,-.019F,
        -.020F,-.021F,-.022F,-.023F,-.024F,
        //曲线5：双向-0.005
        .0048F,.0044F,.0040F,.0036F,.0032F,
        .0028F,.0024F,.0020F,.0016F,.0012F,
        .0008F,.0004F,.0000F,-.0004F,-.0008F,
        -.0012F,-.0016F,-.0020F,-.0024F,-.0028F,
        -.0032F,-.0036F,-.0040F,-.0044F,-.0048F,
        //曲线6：双向-0.01
        .0096F,.0088F,.0080F,.0072F,.0064F,
        .0056F,.0048F,.0040F,.0032F,.0024F,
        .0016F,.0008F,.0000F,-.0008F,-.0016F,
        -.0024F,-.0032F,-.0040F,-.0048F,-.0056F,
        -.0064F,-.0072F,-.0080F,-.0088F,-.0096F,
        //曲线7：双向0.015
        -.0144F,-.0132F,-.0120F,-.0108F,-.0096F,
        -.0084F,-.0072F,-.0060F,-.0048F,-.0026F,
        -.0024F,-.0012F,.0000F,.0012F,.0024F,
        .0036F,.0048F,.0060F,.0072F,.0084F,
        .0096F,.0108F,.0120F,.0132F,.0144F,
        //曲线8：双向0.005
        -.0048F,-.0044F,-.0040F,-.0036F,-.0032F,
        -.0028F,-.0024F,-.0020F,-.0016F,-.0012F,
        -.0008F,-.0004F,.0000F,.0004F,.0008F,
        .0012F,.0016F,.0020F,.0024F,.0028F,
        .0032F,.0036F,.0040F,.0044F,.0048F,
        //曲线9：双向0.0012
        -.0012F,-.0011F,-.0010F,-.0009F,-.0008F,
        -.0007F,-.0006F,-.0005F,-.0004F,-.0003F,
        -.0002F,-.0001F,.0000F,.0001F,.0002F,
        .0003F,.0004F,.0005F,.0006F,.0007F,
        .0008F,.0009F,.0010F,.0011F,.0012F,
        //曲线10：双向-0.0012
        .0012F,.0011F,.0010F,.0009F,.0008F,
        .0007F,.0006F,.0005F,.0004F,.0003F,
        .0002F,.0001F,.0000F,-.0001F,-.0002F,
        -.0003F,-.0004F,-.0005F,-.0006F,-.0007F,
        -.0008F,-.0009F,-.0010F,-.0011F,-.0012F,
        //曲线11：双向10
        -9.6F,-8.8F,-8.0F,-7.2F,-6.4F,
        -5.6F,-4.8F,-4.0F,-3.2F,-2.4F,
        -1.6F,-.8F,.0F,.8F,1.6F,
        2.4F,3.2F,4.0F,4.8F,5.6F,
        6.4F,7.2F,8.0F,8.8F,9.6F,
        //曲线12：双向-10
        9.6F,8.8F,8.0F,7.2F,6.4F,
        5.6F,4.8F,4.0F,3.2F,2.4F,
        1.6F,.8F,.0F,-.8F,-1.6F,
        -2.4F,-3.2F,-4.0F,-4.8F,-5.6F,
        -6.4F,-7.2F,-8.0F,-8.8F,-9.6F,
        //曲线13：正向-0.01
        .0000F,-.0004F,-.0008F,-.0012F,-.0016F,
        -.0020F,-.0024F,-.0028F,-.0032F,-.0036F,
        -.0040F,-.0044F,-.0048F,-.0052F,-.0056F,
        -.0060F,-.0064F,-.0068F,-.0072F,-.0076F,
        -.0080F,-.0084F,-.0088F,-.0092F,-.0098F,
        //曲线14：双向0.01
        -.0096F,-.0088F,-.0080F,-.0072F,-.0064F,
        -.0056F,-.0048F,-.0040F,-.0032F,-.0024F,
        -.00016F,-.0008F,.0000F,.0008F,.00016F,
        .0024F,.0032F,.0040F,.0048F,.0056F,
        .0064F,.0072F,.0080F,.0088F,.0096F,
        //曲线15：双向20
        -19.2F,-17.6F,-16.0F,-14.4F,-12.8F,
        -11.2F,-9.6F,-8.0F,-6.4F,-4.8F,
        -3.2F,-1.6F,.0F,1.6F,3.2F,
        4.8F,6.4F,8.0F,9.6F,11.2F,
        12.8F,14.4F,16.0F,17.6F,19.2F,
        //曲线16：双向-20
        19.2F,17.6F,16.0F,14.4F,12.8F,
        11.2F,9.6F,8.0F,6.4F,4.8F,
        3.2F,1.6F,.0F,-1.6F,-3.2F,
        -4.8F,-6.4F,-8.0F,-9.6F,-11.2F,
        -12.8F,-14.4F,-16.0F,-17.6F,-19.2F,
        //曲线17：正向0.025
        .000F,.001F,.002F,.003F,.004F,
        .005F,.006F,.007F,.008F,.009F,
        .010F,.011F,.012F,.013F,.014F,
        .015F,.016F,.017F,.018F,.019F,
        .020F,.021F,.022F,.023F,.024F,
        //曲线18：正向0.05
        .000F,.002F,.004F,.006F,.008F,
        .010F,.012F,.014F,.016F,.018F,
        .020F,.022F,.024F,.026F,.028F,
        .030F,.032F,.034F,.036F,.038F,
        .040F,.042F,.044F,.046F,.048F,
        //曲线19：双向5
        -4.8F,-4.4F,-4F,-3.6F,-3.2F,
        -2.8F,-2.4F,-2F,-1.6F,-1.2F,
        -.8F,-.4F,.0F,.4F,.8F,
        1.2F,1.6F,2F,2.4F,2.8F,
        3.2F,3.6F,4F,4.4F,4.8F,
        //曲线20：双向-5
        4.8F,4.4F,4F,3.6F,3.2F,
        2.8F,2.4F,2F,1.6F,1.2F,
        .8F,.4F,.0F,-.4F,-.8F,
        -1.2F,-1.6F,-2F,-2.4F,-2.8F,
        -3.2F,-3.6F,-4F,-4.4F,-4.8F,
        //曲线21：中间-正向-0.01
        0F,0F,0F,0F,0F,
        0F,0F,0F,0F,0F,
        0F,0F,0F,-.0008F,-.00016F,
        -.0024F,-.0032F,-.0040F,-.0048F,-.0056F,
        -.0064F,-.0072F,-.0080F,-.0088F,-.0096F,
        //曲线22：中间-正向5
        0F,0F,0F,0F,0F,
        0F,0F,0F,0F,0F,
        0F,0F,0F,.4F,.8F,
        1.2F,1.6F,2F,2.4F,2.8F,
        3.2F,3.6F,4F,4.4F,4.8F,
        //曲线23：中间-正向0.005
        0F,0F,0F,0F,0F,
        0F,0F,0F,0F,0F,
        0F,0F,0F,.0004F,.0008F,
        .0012F,.0016F,.002F,.0024F,.0028F,
        .0032F,.0036F,.004F,.0044F,.0048F,
        //曲线24：中间-正向-5
        0F,0F,0F,0F,0F,
        0F,0F,0F,0F,0F,
        0F,0F,0F,-.4F,-.8F,
        -1.2F,-1.6F,-2F,-2.4F,-2.8F,
        -3.2F,-3.6F,-4F,-4.4F,-4.8F,
        //曲线25：双向-0.015
        .0096F,.0088F,.0080F,.0072F,.0064F,
        .0056F,.0048F,.0040F,.0032F,.0024F,
        .0016F,.0008F,.0000F,.0004F,.0008F,
        .0012F,.0016F,.0020F,.0024F,.0028F,
        .0032F,.0036F,.0040F,.0044F,.0048F,
    };

    float[] scale_curves = new float[]
    {
        //曲线0：双向5%
        .952F,.956F,.960F,.964F,.968F,
        .972F,.976F,.980F,.984F,.988F,
        .992F,.996F,1.000F,1.004F,1.008F,
        1.012F,1.016F,1.020F,1.024F,1.028F,
        1.032F,1.036F,1.040F,1.044F,1.048F,
        //曲线1：负向-10%
        .904F,.908F,.912F,.916F,.920F,
        .924F,.928F,.932F,.936F,.940F,
        .944F,.948F,.952F,.956F,.960F,
        .964F,.968F,.972F,.976F,.980F,
        .984F,.988F,.992F,.996F,1.000F,
        //曲线2：双向10%
        .904F,.912F,.920F,.928F,.936F,
        .944F,.952F,.960F,.968F,.976F,
        .984F,.992F,1.000F,1.008F,1.016F,
        1.024F,1.032F,1.040F,1.048F,1.056F,
        1.064F,1.072F,1.080F,1.088F,1.096F,
        //曲线3：中间50%
        1.000F,1.000F,1.000F,1.000F,1.000F,
        1.000F,1.000F,1.000F,1.000F,1.000F,
        1.000F,1.000F,1.000F,1.040F,1.080F,
        1.120F,1.160F,1.200F,1.240F,1.280F,
        1.320F,1.360F,1.400F,1.440F,1.480F,
        //曲线4：中间-50%
        1.000F,1.000F,1.000F,1.000F,1.000F,
        1.000F,1.000F,1.000F,1.000F,1.000F,
        1.000F,1.000F,1.000F,.960F,.920F,
        .880F,.840F,.800F,.760F,.720F,
        .680F,.640F,.600F,.560F,.520F,
        //曲线5：中间25%
        1.000F,1.000F,1.000F,1.000F,1.000F,
        1.000F,1.000F,1.000F,1.000F,1.000F,
        1.000F,1.000F,1.000F,1.020F,1.040F,
        1.060F,1.080F,1.100F,1.120F,1.140F,
        1.160F,1.180F,1.200F,1.220F,1.240F,
        //曲线6：正向25%
        1.000F,1.010F,1.020F,1.030F,1.040F,
        1.050F,1.060F,1.070F,1.080F,1.090F,
        1.100F,1.110F,1.120F,1.130F,1.140F,
        1.150F,1.160F,1.170F,1.180F,1.190F,
        1.200F,1.210F,1.220F,1.230F,1.240F,
        //曲线7：双向25%
        .76F,.78F,.80F,.82F,.84F,
        .86F,.88F,.90F,.92F,.94F,
        .96F,.98F,1.00F,1.02F,1.04F,
        1.06F,1.08F,1.10F,1.12F,1.14F,
        1.16F,1.18F,1.20F,1.22F,1.24F,
        //曲线8：正向500%
        1.0F,1.2F,1.4F,1.6F,1.8F,
        2.0F,2.2F,2.4F,2.6F,2.8F,
        3.0F,3.2F,3.4F,3.6F,3.8F,
        4.0F,4.2F,4.4F,4.6F,4.8F,
        5.0F,5.2F,5.4F,5.6F,5.8F,
        //曲线9：正向-90%
        1F,.963F,.925F,.888F,.850F,
        .813F,.775F,.738F,.700F,.663F,
        .625F,.588F,.550F,.513F,.475F,
        .438F,.400F,.363F,.325F,.288F,
        .250F,.213F,.175F,.138F,.100F,
        //曲线10：负向-20%
        .808F,.816F,.824F,.832F,.840F,
        .848F,.856F,.864F,.872F,.880F,
        .888F,.896F,.904F,.912F,.920F,
        .928F,.936F,.944F,.952F,.960F,
        .968F,.976F,.984F,.992F,1.000F,
        //曲线11：中间-负向-25%
        .76F,.78F,.80F,.82F,.84F,
        .86F,.88F,.90F,.92F,.94F,
        .96F,.98F,1F,1F,1F,
        1F,1F,1F,1F,1F,
        1F,1F,1F,1F,1F,
        //曲线12：双向100%
        .5F,.542F,.583F,.625F,.667F,
        .708F,.750F,.792F,.833F,.875F,
        .917F,.958F,1.00F,1.08F,1.16F,
        1.24F,1.32F,1.40F,1.48F,1.56F,
        1.64F,1.72F,1.80F,1.88F,1.96F,
        //曲线13：双向-正向50%-负向-25%
        .720F,.743F,.767F,.790F,.813F,
        .837F,.860F,.883F,.907F,.930F,
        .953F,.977F,1.00F,1.04F,1.08F,
        1.12F,1.16F,1.20F,1.24F,1.28F,
        1.32F,1.36F,1.40F,1.44F,1.48F,
        //曲线14：双向-正向-50%-负向25%
        1.24F,1.22F,1.20F,1.18F,1.16F,
        1.14F,1.12F,1.10F,1.08F,1.06F,
        1.04F,1.02F,1F,.960F,.920F,
        .880F,.840F,.800F,.760F,.720F,
        .680F,.640F,.600F,.560F,.520F,
        //曲线15：双向-25%
        1.24F,1.22F,1.20F,1.18F,1.16F,
        1.14F,1.12F,1.10F,1.08F,1.06F,
        1.04F,1.02F,1.00F,.98F,.96F,
        .94F,.92F,.90F,.88F,.86F,
        .84F,.82F,.80F,.78F,.76F,
        //曲线16：双向-正向40%-负向10%
        1.100F,1.091F,1.081F,1.070F,1.059F,
        1.048F,1.038F,1.027F,1.019F,1.011F,
        1.005F,1.001F,1.000F,1.005F,1.020F,
        1.044F,1.074F,1.110F,1.150F,1.193F,
        1.237F,1.281F,1.324F,1.364F,1.400F,
    };

    /// <summary>
    /// 从数组加载可操作类型
    /// </summary>
    public void Load_Custom_Config()
    {
        _Custom_Config = new Dictionary<int, Dictionary<int, bool[]>>();
        _Custom_Keys = new Dictionary<int, Dictionary<int, int[]>>();

        //添加一条操作数据
        for (int i = 0; i < this.config.Length / 4; ++i)
        {
            //判断是否添加操作类型
            Dictionary<int, bool[]> custom_Infos = null;
            if (!_Custom_Config.TryGetValue(this.config[i * 4], out custom_Infos))
            {
                custom_Infos = new Dictionary<int, bool[]>();
                _Custom_Config[this.config[i * 4]] = custom_Infos;
            }
            //判断是否添加骨骼类型
            bool[] use = null;
            if (!custom_Infos.TryGetValue(this.config[i * 4 + 3], out use))
            {
                use = new bool[9];
                for (int n = 0; n < use.Length; ++n)
                {
                    use[n] = false;
                }
                custom_Infos[this.config[i * 4 + 3]] = use;
            }
            //设置数据参数
            use[this.config[i * 4 + 1] - 1] = true;

            //判断是否添加骨骼类型
            Dictionary<int, int[]> _keys = null;
            if (!_Custom_Keys.TryGetValue(this.config[i * 4 + 3], out _keys))
            {
                _keys = new Dictionary<int, int[]>();
                _Custom_Keys[this.config[i * 4 + 3]] = _keys;
            }
            //判断是否添加操作类型
            int[] _indexs = null;
            if (!_keys.TryGetValue(this.config[i * 4], out _indexs))
            {
                _indexs = new int[1];
                _indexs[0] = 50; //设置单个骨骼在单个操作下的默认操作值
            }
            //设置参数数据
            int[] indexs = new int[2] { this.config[i * 4 + 1], this.config[i * 4 + 2] };
            _keys[this.config[i * 4]] = _indexs.Sekia_CombineArray(indexs);
        }
    }

    /// <summary>
    /// 获取指定编号的可操作数据
    /// </summary>
    public Dictionary<int, bool[]> Get_Index(int index)
    {
        return _Custom_Config[index];
    }

    /// <summary>
    /// 输出骨骼的最终形变量
    /// </summary>
    /// <param name="bone_index">骨骼编号</param>
    /// <param name="custom_index">操作编号</param>
    /// <param name="value">操作值</param>
    /// <param name="values">输出介质</param>
    /// <param name="use">transform参数使用情况</param>
    public bool Get_Info(int bone_index, int custom_index, int custom_value, ref Vector3[] values, bool[] use)
    {
        Dictionary<int, int[]> _keys; //单个骨骼受到的全部影响
        if (!_Custom_Keys.TryGetValue(bone_index, out _keys))
        {
            return false;
        }
        int[] _indexs; //单个骨骼的全部曲线
        if (!_keys.TryGetValue(custom_index, out _indexs))
        {
            return false;
        }
        _indexs[0] = custom_value; //修改单个骨骼在单个操作下的操作值

        for (int i = 0; i < 3; ++i)
        {
            if (use[i * 3] || use[i * 3 + 1] || use[i * 3 + 2])
            {
                foreach (var item in _keys.Values) //遍历所有操作类型
                {
                    int key_index = Mathf.FloorToInt(item[0] * 24 / 100); //转换为关键帧序列号
                    for (int n = 0; n < (item.Length - 1) / 2; ++n) //遍历单个操作类型中的形变参数
                    {
                        for (int x = 0; x < 3; ++x)
                        {
                            if (use[i * 3 + x] && item[n * 2 + 1] == i * 3 + x + 1)
                            {
                                int curve_index = item[n * 2 + 2];
                                if (i == 2)
                                {
                                    float _key = scale_curves[curve_index * 25 + key_index];
                                    switch (x)
                                    {
                                        case 0:
                                            values[i].x = values[i].x * _key;
                                            break;
                                        case 1:
                                            values[i].y = values[i].y * _key;
                                            break;
                                        case 2:
                                            values[i].z = values[i].z * _key;
                                            break;
                                    }
                                }
                                else
                                {
                                    float _key = position_curves[curve_index * 25 + key_index];
                                    switch (x)
                                    {
                                        case 0:
                                            values[i].x = values[i].x + _key;
                                            break;
                                        case 1:
                                            values[i].y = values[i].y + _key;
                                            break;
                                        case 2:
                                            values[i].z = values[i].z + _key;
                                            break;
                                    }
                                }
                            }
                        }
                    }

                }
            }
        }

        return true;
    }
}