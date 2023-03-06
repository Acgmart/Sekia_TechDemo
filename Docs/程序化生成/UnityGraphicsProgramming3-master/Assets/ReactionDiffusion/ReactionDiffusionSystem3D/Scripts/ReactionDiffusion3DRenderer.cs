using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public abstract class ReactionDiffusion3DRenderer : MonoBehaviour {
    protected ReactionDiffusion3D reactionDiffuse;

    protected virtual void Initialize()
    {
        reactionDiffuse = GetComponent<ReactionDiffusion3D>();
    }

    protected abstract void UpdateMaterial();

    private void Start()
    {
        Initialize();
    }

    private void LateUpdate()
    {
        UpdateMaterial();
    }
}
