using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace ScreenSpaceFluidRendering
{
    [RequireComponent(typeof(Camera))]
    [ExecuteInEditMode]
    public class ShowGBuffer : MonoBehaviour
    {
        enum GBufferType
        {
            diffuse,
            specular,
            normal,
            emission,
            depth,
            source,
        };

        [SerializeField]
        GBufferType _gbufferType = GBufferType.source;

        [SerializeField]
        Material _mat;

        void Start()
        {
            // カメラから見たスクリーンスペースの深度テクスチャを生成する
            GetComponent<Camera>().depthTextureMode |= DepthTextureMode.Depth;
        }

        void OnGUI()
        {
            var fontSizeStore = GUI.skin.label.fontSize;
            var fontSize = 72;
            GUI.skin.label.fontSize = fontSize;
            GUI.color = Color.gray;
            GUI.Label(new Rect(fontSize * 0.4f, fontSize * 0.2f, Screen.width, fontSize * 1.25f), "G-Buffer Type : " + _gbufferType.ToString());
            GUI.skin.label.fontSize = fontSizeStore;
            GUI.color = Color.white;
        }

        [ImageEffectOpaque]
        void OnRenderImage(RenderTexture source, RenderTexture destination)
        {
            foreach (var keyword in _mat.shaderKeywords)
            {
                _mat.DisableKeyword(keyword);
            }

            switch(_gbufferType)
            {
                case GBufferType.diffuse:
                    _mat.EnableKeyword("_GBUFFERTYPE_DIFFUSE");
                    break;
                case GBufferType.specular:
                    _mat.EnableKeyword("_GBUFFERTYPE_SPECULAR");
                    break;
                case GBufferType.normal:
                    _mat.EnableKeyword("_GBUFFERTYPE_WORLDNORMAL");
                    break;
                case GBufferType.emission:
                    _mat.EnableKeyword("_GBUFFERTYPE_EMISSION");
                    break;
                case GBufferType.depth:
                    _mat.EnableKeyword("_GBUFFERTYPE_DEPTH");
                    break;
                default:
                    _mat.EnableKeyword("_GBUFFERTYPE_SOURCE");
                    break;
            }
            Graphics.Blit(source, destination, _mat);
        }
    }
}