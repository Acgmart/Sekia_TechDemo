using System;
using System.Reflection;

namespace ET
{
    public class CodeLoader : Singleton<CodeLoader>, ISingletonAwake
    {
        public void Awake()
        {
        }

        public void Start()
        {
            Assembly[] assemblies = AppDomain.CurrentDomain.GetAssemblies();
            World.Instance.AddSingleton<CodeTypes, Assembly[]>(assemblies);
            Entry.Start();
        }
    }
}
