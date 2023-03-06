using System.Collections.Generic;
using UnityEngine;

public class StarGlow : ImageEffectBase
{
    #region Enum

    public enum CompositeType
    {
        _COMPOSITE_TYPE_ADDITIVE         = 0,
        _COMPOSITE_TYPE_SCREEN           = 1,
        _COMPOSITE_TYPE_COLORED_ADDITIVE = 2,
        _COMPOSITE_TYPE_COLORED_SCREEN   = 3,
        _COMPOSITE_TYPE_DEBUG            = 4
    }

    #endregion Enum

    #region Field

    private static Dictionary<CompositeType, string> CompositeTypes = new Dictionary<CompositeType, string>()
    {
        { CompositeType._COMPOSITE_TYPE_ADDITIVE,         CompositeType._COMPOSITE_TYPE_ADDITIVE.ToString()         },
        { CompositeType._COMPOSITE_TYPE_SCREEN,           CompositeType._COMPOSITE_TYPE_SCREEN.ToString()           },
        { CompositeType._COMPOSITE_TYPE_COLORED_ADDITIVE, CompositeType._COMPOSITE_TYPE_COLORED_ADDITIVE.ToString() },
        { CompositeType._COMPOSITE_TYPE_COLORED_SCREEN,   CompositeType._COMPOSITE_TYPE_COLORED_SCREEN.ToString()   },
        { CompositeType._COMPOSITE_TYPE_DEBUG,            CompositeType._COMPOSITE_TYPE_DEBUG.ToString()            }
    };

    public StarGlow.CompositeType compositeType = StarGlow.CompositeType._COMPOSITE_TYPE_ADDITIVE;

    [Range(0, 1)]
    public float threshold = 1;

    [Range(0, 10)]
    public float intensity = 1;

    [Range(1, 20)]
    public int divide = 3;

    [Range(1, 5)]
    public int iteration = 5;

    [Range(0, 1)]
    public float attenuation = 1;

    [Range(0, 360)]
    public float angleOfStreak = 0;

    [Range(1, 16)]
    public int numOfStreak = 4;

    public Color color = Color.white;

    private int idCompositeTex   = 0;
    private int idCompositeColor = 0;
    private int idParameter  = 0;
    private int idIteration  = 0;
    private int idOffset     = 0;

    #endregion Field

    #region Method

    protected override void Start()
    {
        base.Start();

        this.idCompositeTex   = Shader.PropertyToID("_CompositeTex");
        this.idCompositeColor = Shader.PropertyToID("_CompositeColor");
        this.idParameter      = Shader.PropertyToID("_Parameter");
        this.idIteration      = Shader.PropertyToID("_Iteration");
        this.idOffset         = Shader.PropertyToID("_Offset");
    }

    protected override void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        RenderTexture brightnessTex = RenderTexture.GetTemporary(source.width  / this.divide,
                                                                 source.height / this.divide,
                                                                 source.depth,
                                                                 source.format);
        RenderTexture blurredTex1   = RenderTexture.GetTemporary(brightnessTex.descriptor);
        RenderTexture blurredTex2   = RenderTexture.GetTemporary(brightnessTex.descriptor);
        RenderTexture compositeTex  = RenderTexture.GetTemporary(brightnessTex.descriptor);

        // STEP:1
        // Get resized birghtness image.

        base.material.SetVector
        (this.idParameter, new Vector3(this.threshold, this.intensity, this.attenuation));

        Graphics.Blit(source, brightnessTex, base.material, 1);

        // DEBUG:
        // Graphics.Blit(brightnessTex, destination, base.material, 0);
        // return;

        // STEP:2
        // Get blurred brightness image.

        float angle = 360f / this.numOfStreak;

        for (int x = 1; x <= this.numOfStreak; x++)
        {
            Vector2 offset =
            (Quaternion.AngleAxis(angle * x + this.angleOfStreak, Vector3.forward) * Vector2.down).normalized;

            base.material.SetVector(this.idOffset, offset);

            base.material.SetInt   (this.idIteration, 1);

            Graphics.Blit(brightnessTex, blurredTex1, base.material, 2);

            // DEBUG:
            // Graphics.Blit(blurredTex1, destination, base.material, 0);
            // return;

            for (int i = 2; i <= this.iteration; i++)
            {
                base.material.SetInt(this.idIteration, i);

                Graphics.Blit(blurredTex1, blurredTex2, base.material, 2);

                // DEBUG:
                // Graphics.Blit(blurredTex2, destination, base.material, 0);
                // return;

                RenderTexture temp = blurredTex1;
                blurredTex1 = blurredTex2;
                blurredTex2 = temp;
            }

            Graphics.Blit(blurredTex1, compositeTex, base.material, 3);
        }

        // DEBUG:
        // Graphics.Blit(compositeTex, destination, base.material, 0);
        // return;

        // STEP:3
        // Composite.

        base.material.EnableKeyword(StarGlow.CompositeTypes[this.compositeType]);
        base.material.SetColor(this.idCompositeColor, this.color);
        base.material.SetTexture(this.idCompositeTex, compositeTex);

        Graphics.Blit(source, destination, base.material, 4);

        // STEP:4
        // Close.

        base.material.DisableKeyword(StarGlow.CompositeTypes[this.compositeType]);

        RenderTexture.ReleaseTemporary(brightnessTex);
        RenderTexture.ReleaseTemporary(blurredTex1);
        RenderTexture.ReleaseTemporary(blurredTex2);
        RenderTexture.ReleaseTemporary(compositeTex);
    }

    #endregion Method
}