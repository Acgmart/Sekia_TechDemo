using System.Collections;
using System.Collections.Generic;
using UnityEngine;

//[CreateAssetMenu(menuName = "E3D/GrassPainterConfig")]
public class GrassPainterConfig : ScriptableObject
{
    //使用配置好的材质球渲染草
    [SerializeField]
    public List<Material> grassPresets = new List<Material>();

    [SerializeField]
    public Mesh grassQuad;
}
