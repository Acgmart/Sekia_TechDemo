using System.Collections.Generic;
using UnityEngine;
using FairyGUI;
using System.Linq;
//Edit by Sekia

namespace ET.Client
{
    [FriendOf(typeof(UI))]
    public static class UISystem
    {
        public class UIAwakeSystem : AwakeSystem<UI, string, GObject>
        {
            protected override void Awake(UI self, string name, GObject gObject)
            {
                self.nameChildren.Clear();
                self.Name = name;
                self.GObject = gObject;
            }
        }

        public class UIDestroySystem : DestroySystem<UI>
        {
            protected override void Destroy(UI self)
            {
                foreach (UI ui in self.nameChildren.Values)
                {
                    ui.Dispose();
                }

                self.GObject.Dispose();
                self.GObject = null;
                self.nameChildren.Clear();
            }
        }

        public static void Add(this UI self, UI ui)
        {
            self.nameChildren.Add(ui.Name, ui);
        }

        public static void Remove(this UI self, string name)
        {
            UI ui;
            if (!self.nameChildren.TryGetValue(name, out ui))
            {
                return;
            }
            self.nameChildren.Remove(name);
            ui.Dispose();
        }

        public static UI Get(this UI self, string name)
        {
            UI child;
            if (self.nameChildren.TryGetValue(name, out child))
            {
                return child;
            }
            return child;
        }
    }

    [ChildOf(typeof(UIComponent))]
    public sealed class UI : Entity, IAwake<string, GObject>, IDestroy
    {
        public GObject GObject { get; set; }

        public string Name { get; set; } //可选修改的别名 允许与UI的组件名不同

        public Dictionary<string, UI> nameChildren = new Dictionary<string, UI>();

        public bool Visible => this.GObject.visible;

        public bool IsComponent => this.GObject is GComponent;

        public UI[] GetAll => nameChildren.Values.ToArray();
    }
}
