老版的MuMu支持OpenGL 新版本不支持 但是支持Vulkan
有时候是老版本的RenderDoc可以截帧新版本不行 以前用RenderDoc1.6 + win10好使过

下载一个老版本的MuMu 比如：
    MuMuInstaller_1.4.2.10_v2.6.32.0x64_zh-Hans_1656582010
    https://a11.gdl.netease.com/MuMuInstaller_1.4.2.10_v2.6.32.0x64_zh-Hans_1656582010.exe
安装后切换到GL模式
安装最新版的RenderDoc 比如RenderDoc v1.24
    开启Hook 设置环境变量和路径
    C:\Program Files\NemuVbox\Hypervisor\NemuHeadless.exe
    Set RENDERDOC_HOOK_EGL to 0
    Launch 启动模拟器后可看到调试UI
