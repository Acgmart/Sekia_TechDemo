using System;
using System.Collections.Generic;

namespace ET
{
    public enum AppType
    {
        Server,
        Watcher, // 每台物理机一个守护进程，用来启动该物理机上的所有进程
        GameTool,
        ExcelExporter,
        Proto2CS,
        BenchmarkClient,
        BenchmarkServer,

        Demo,
        LockStep,
    }

    public class Options : Singleton<Options>
    {
        public AppType AppType = AppType.Server;
        public string StartConfig = "StartConfig/Localhost";
        public int Process = 1;
        //0正式 1开发 2压测
        public int Develop = 0;
        public int LogLevel = 2;
        public int Console = 0;
    }
}
