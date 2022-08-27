using UnityEngine;
//Edit by Sekia

namespace ET.Client
{
    [Event(SceneType.Client)]
    public class AfterCreateClientScene_AddComponent : AEvent<EventType.AfterCreateClientScene>
    {
        protected override async ETTask Run(Scene scene, EventType.AfterCreateClientScene args)
        {
            scene.AddComponent<UIEventComponent>();
            scene.AddComponent<UIComponent>();
            scene.AddComponent<ResourcesLoaderComponent>();

            //scene.AddComponent<UICamera, Transform>(GlobalComponent.Instance.uiCamera);

            await ETTask.CompletedTask;
        }
    }
}
