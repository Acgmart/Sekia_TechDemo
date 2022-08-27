using System;
using UnityEngine;

namespace ET.Client
{
    /*
    [FriendOf(typeof(UICamera))]
    public static class UICameraSystem
    {
        public class UICameraAwakeSystem : AwakeSystem<UICamera, Transform>
        {
            protected override void Awake(UICamera self, Transform transform)
            {
                UICamera.Instance = self;
                self.cachedTransform = transform;
                self.cachedCamera = transform.GetComponent<Camera>();

                if (Display.displays.Length > 1 &&
                    self.cachedCamera.targetDisplay != 0 &&
                    self.cachedCamera.targetDisplay < Display.displays.Length)
                    self.display = Display.displays[self.cachedCamera.targetDisplay];

                Log.Debug("UI相机初始化完成");
                if (self.display == null)
                    self.OnScreenSizeChanged(Screen.width, Screen.height);
                else
                    self.OnScreenSizeChanged(self.display.renderingWidth, self.display.renderingHeight);
            }
        }

        public class UICameraUpdateSystem : UpdateSystem<UICamera>
        {
            protected override void Update(UICamera self)
            {
                if (self.display == null)
                {
                    if (self.screenWidth != Screen.width ||
                        self.screenHeight != Screen.height)
                        self.OnScreenSizeChanged(Screen.width, Screen.height);
                }
                else
                {
                    if (self.screenWidth != self.display.renderingWidth ||
                        self.screenHeight != self.display.renderingHeight)
                        self.OnScreenSizeChanged(self.display.renderingWidth, self.display.renderingHeight);
                }
            }
        }

        public class UICameraDestroySystem : DestroySystem<UICamera>
        {
            protected override void Destroy(UICamera self)
            {

            }
        }

        public static void OnScreenSizeChanged(this UICamera self, int newWidth, int newHeight)
        {
            if (newWidth == 0 || newHeight == 0)
                return;

            self.screenWidth = newWidth;
            self.screenHeight = newHeight;

            //UI相机可以选择unitsPerPixel和orthographicSize之一相对固定
            //由于固定orthographicSize的应用场景太小
            //且unitsPerPixel恒定为1有利于转换屏幕空间坐标到世界空间
            //这里选择固定unitsPerPixel为1
            self.cachedCamera.orthographicSize = newHeight * 0.5f;
            self.cachedTransform.localPosition = new Vector3(newWidth * 0.5f, -self.cachedCamera.orthographicSize);
            Game.EventSystem.Callback(UICallbackType.ScreenSizeChanged, self.screenWidth, self.screenHeight);
        }
    }

    /// <summary>
    /// 全局唯一的UI相机
    /// </summary>
    [ComponentOf(typeof(Scene))]
    public sealed class UICamera : Entity, IAwake<Transform>, IUpdate, IDestroy
    {
        public static UICamera Instance;
        public Transform cachedTransform;
        public Camera cachedCamera;

        public int screenWidth;
        public int screenHeight;
        public Display display;
    }
    */
}
