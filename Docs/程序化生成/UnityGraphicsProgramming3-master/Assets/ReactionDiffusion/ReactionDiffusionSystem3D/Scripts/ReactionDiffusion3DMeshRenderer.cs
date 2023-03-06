using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ReactionDiffusion3DMeshRenderer : ReactionDiffusion3DRenderer
{
    private List<Renderer> rendererList = new List<Renderer>();

    protected override void Initialize()
    {
        base.Initialize();
        var ren = GetComponentsInChildren<Renderer>();
        if (ren != null)
        {
            foreach (var r in ren)
            {
                rendererList.Add(r);
            }
        }
    }

    protected override void UpdateMaterial()
    {
        for (int i = 0; i < rendererList.Count; i++)
        {
            rendererList[i].material.SetTexture("_MainTex", reactionDiffuse.heightMapTexture);
        }
    }
}
