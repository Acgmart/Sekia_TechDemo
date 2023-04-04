---
title: 从0开始的Unity3D游戏开发 v0.1.13 热更新/打包
categories:
- [Unity, ET]
date: 2018-08-24 01:03:47
---

\[toc\]本篇的内容为将ET客户端打包到其他平台 将ET客户端的默认项目打包发布到PC端发现无法运行,本篇的目的就是解决客户端打包发布的问题,因为目前没有mac机器,ios版暂不讨论. 由于在Unity编辑模式下,对资源的读取会和非编辑模式有差异. 如ET在编辑模式下: // 下载ab包 `await BundleHelper.DownloadBundle();` 会因为Define.IsAsync的定义而跳过执行. ResourcesComponent的LoadOneBundle方法也有这样的差异. 在编辑模式下会使用AssetDatabase类来直接获得assetBundleName下的全部路径. 在非编辑模式下则通过找到被打包后的assetBundleName文件来获得文件内的资源.

# 测试非编辑模式

直接发布会失去现有的Log环境,那么如何测试非编辑模式下的资源读取呢. 把编辑条件下执行的代码全部注释掉即可: ResourcesComponent.cs: if (!Define.IsAsync)整段注释 BundleHelper.cs: if (Define.IsAsync)去掉执行条件,使内容被执行. 重新编译客户端,并运行.

# GlobalConfigComponent

GlobalConfigComponent是ET客户端加载的第一个组件. 这个组件使用`Resources.Load(path);`方法获取prefab. 再通过`config.Get<TextAsset>("GlobalProto").text;`方法获取txt文件中的字符串. 这个读取资源的方法区别于热更,可以用来加载基础资源.

# 热更新

当去除Define.IsAsync条件后,程序将不再使用编辑模式的读取方式. 当加载一个assetBundleName,比如code.unity3d时: `string p = Path.Combine(PathHelper.AppHotfixResPath, assetBundleName);` 非移动环境下返回的路径为:Unity项目目录/Assets/StreamingAssets/code.unity3d `assetBundle = AssetBundle.LoadFromFile(p);` 同步从本地磁盘上的指定路径加载一个AssetBundle文件. 如果assetBundle为null则报错. 也就是说,需要先下载code.unity3d文件到StreamingAssets文件夹.

# 下载AssetBundle

也就是下载ab包 `await BundleHelper.DownloadBundle();`

```
//表示执行完方法后自动释放括号内的资源
//实例化一个BundleDownloaderComponent Awake方法仅默认初始化3个成员
using (BundleDownloaderComponent bundleDownloaderComponent = Game.Scene.AddComponent<BundleDownloaderComponent>())
{
    await bundleDownloaderComponent.StartAsync();
    Game.EventSystem.Run(EventIdType.LoadingBegin);
    await bundleDownloaderComponent.DownloadAsync();
}
Game.EventSystem.Run(EventIdType.LoadingFinish);
Game.Scene.GetComponent<ResourcesComponent>().LoadOneBundle("StreamingAssets");
ResourcesComponent.AssetBundleManifestObject = (AssetBundleManifest)Game.Scene.GetComponent<ResourcesComponent>().GetAsset("StreamingAssets", "AssetBundleManifest");
```

这一部分内容比较多,一句一句来看吧.

## StartAsync

在StartAsync方法中,有相当多的操作内容: StartAsync方法调用GlobalConfigComponent的AssetBundleServerUrl成员,也就是提供AssetBundle资源下载的服务器地址,在GlobalProto.txt文件中修改它. 默认资源下载服务器地址:`http://127.0.0.1:8080/` GlobalProto.GetUrl方法返回的地址就是相对目录 默认相对目录为:`http://127.0.0.1:8080/PC/` versionUrl:`http://127.0.0.1:8080/PC/StreamingAssets/Version.txt` 使用异步方法下载Version.txt,并将其转化为VersionConfig实例. `await webRequestAsync.DownloadAsync(versionUrl);` 接着也用同样的方法读取一遍本地的Version.txt 本地版本文件路径:D:/Unity/Assets/StreamingAssets/Version.txt 接着对比资源下载服务器上的Version.txt和客户端上的热更目录. 删掉远程不存在的文件. 由于remoteVersionConfig是由远程Version.txt序列化得到的,序列化后的VersionConfig实例自带3个成员:Version/TotalSize/FileInfoDict 接着对比MD5 每个文件都是一个FileVersionInfo实例,包含File/MD5/Size三个参数,序列化前: `{"File":"code.unity3d","MD5":"571dd8efb2718cbad37d3d662f2609ec","Size":61778}` 遍历对比远程和本地文件的MD5值,不同则执行入队bundles列表操作: `this.bundles.Enqueue(fileVersionInfo.File);` 通过StartAsync方法整理了热更新所需的文件列表.

## LoadingBegin

`Game.EventSystem.Run(EventIdType.LoadingBegin);` 也就是LoadingBeginEvent\_CreateLoadingUI类的Run方法 `Game.Scene.GetComponent<UIComponent>().Create(UIType.UILoading);` UILoading在编辑模式下并没有出现过,这里需要重新了解下. Create方法指向UiTypes词典中的指定IUIFactory,也就是UILoadingFactory类. 因为UILoading这个Prefab并不是热更资源,所以需要挂在Reference Collector上. 将克隆UILoading到LoginCanvas下面,默认会显示0%. 同时,新增的UILoadingComponent则有更新加载进度的功能. 创建UILoadingComponent时,其Awake方法将成员text设置为UI的Text组件. UiLoadingComponentStartSystem的Start方法将每秒钟更新一次进度: `self.text.text = $"{bundleDownloaderComponent.Progress}%";` 这个进度是通过已下载字节数/总字节数进行计算的. 在下载完热更资源后UILoadingComponent会被关闭.

## DownloadAsync

异步下载热更资源. 将遍历bundles列表,异步下载文件并写入到指定文件地址. 成功下载的文件名被添加到downloadedBundles列表,用于计算下载进度.

## LoadOneBundle

ET中加载一个assetBundleName,做了2件事. 1.用AddResource方法将资源添加进resourceCache词典,使用GetAsset方法可以访问. GetAsset方法需要2个key,分别是bundleName和prefab. 2.生成ABInfo对象,当需要使用assetBundle时,则通过名称查找词典: `ResourcesComponent.bundles.TryGetValue(assetBundleName, out abInfo)` 但是bundles是内部成员,仅限class内部使用.

## AssetBundleManifest

DownloadBundle方法的最后一个操作,访问下载到的AssetBundleManifest文件,并将其标记为ResourcesComponent的公开成员AssetBundleManifestObject.

# 生成AssetBundle

因为没有生成AssetBundle,上面的程序运行到LoadOneBundle的时候,会因为要执行: `LoadOneBundle("StreamingAssets");` 而StreamingAssets这个文件并不存在而报错. 要生成AssetBundle,可以使用自定义编辑器功能.

## 创建自定义AssetBundle工具

在Assets/Editor文件夹创建脚本CreateAssetBundles.cs

```
using UnityEngine;
using UnityEditor;

public class CreateAssetBundles : MonoBehaviour
{
    [MenuItem("Tools/Build AssetBundles")]
    static void BuildAllAssetBundles()
    {
        BuildPipeline.BuildAssetBundles("Assets/StreamingAssets", BuildAssetBundleOptions.None, BuildTarget.StandaloneWindows64);
    } 
}
```

上面的代码指定了Assets/StreamingAssets为输出目录. BuildAssetBundles:打包全部assetbundle. 选项为None. 目标为win64平台. 可根据自己的需求更改参数. 运行这个自定义工具可以在输出目录下看到输出文件啦.

# 配置Version.txt

完成了上面的步骤后,就可以通过注释掉StartAsync方法本地加载assetbundle啦. 实现PC平台出包后的效果: ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/postunity13_1.png) 但是,这个算不上是热更,assetbundle全部从资源服务器下载/客户端本地只有一个默认的Version.txt才行. 通过阅读ET客户端源代码可知:

## 序列化泛型T实例

`public static T FromJson<T>(string str)` 通过访问实例的参数,可以修改实例属性,将实例写入文件可达到修改目的.

## 修改Version

`streamingVersionConfig.Version += 1;`

## 修改单个MD5

`string localFileMD5 = BundleHelper.GetBundleMD5(streamingVersionConfig, assetBundleName);` `streamingVersionConfig.FileInfoDict[assetBundleName].MD5 = localFileMD5;`

## 从txt文件实例化VersionConfig实例

```
//获得VersionConfig对象
public static VersionConfig GetVersionConfig()
{
    // 获取streaming目录的Version.txt
    VersionConfig streamingVersionConfig;
    string versionPath = PathHelper.AppHotfixResPath + "/Version.txt";
    using (UnityWebRequestAsync request = ComponentFactory.Create<UnityWebRequestAsync>())
    {
        request.DownloadAsync(versionPath);
        streamingVersionConfig = JsonHelper.FromJson<VersionConfig>(request.Request.downloadHandler.text);
        //Log.Debug("本地Version.txt" + JsonHelper.ToJson(streamingVersionConfig));
    }
    return streamingVersionConfig;
}
```

## 获取指定文件的Size

```
//获取单个文件大小
public static long GetBundleSize(VersionConfig streamingVersionConfig, string bundleName)
{
    string path = Path.Combine(PathHelper.AppHotfixResPath, bundleName);
    if (File.Exists(path))
    {
        using (FileStream fs = new FileStream(path, FileMode.Open))
        {
            byte[] data = new byte[9999999];
            long size = fs.Read(data, 0, data.Length);
            Log.Debug(bundleName + "文件Size为:" + size);
            return size;
        }
    }

    return 0;
}
```

## 删除旧的assetbundle文件

```
//删除文件
public static void Delete(VersionConfig streamingVersionConfig)
{
    foreach (var a in streamingVersionConfig.FileInfoDict)
    {
        if (a.Value.File == "Version.txt")
        {
            continue;
        }

        string path = PathHelper.AppHotfixResPath + "/" + a.Value.File;
        File.Delete(path);
        Log.Debug("删除文件:" + path);
    }
}
```

## 写入到Version.txt

```
//修改Version.txt
public static void Modify(VersionConfig streamingVersionConfig)
{
    streamingVersionConfig.Version += 1;
    streamingVersionConfig.TotalSize = 0;
    //遍历修改单个文件
    foreach (var a in streamingVersionConfig.FileInfoDict)
    {
        a.Value.MD5 = GetBundleMD5(streamingVersionConfig, a.Value.File);
        a.Value.Size = GetBundleSize(streamingVersionConfig, a.Value.File);
        streamingVersionConfig.TotalSize += a.Value.Size;
    }

    //写入文件Version.txt
    string path = PathHelper.AppHotfixResPath + "/Version.txt";
    using (FileStream fs = new FileStream(path, FileMode.Create))
    {
        byte[] data = System.Text.Encoding.ASCII.GetBytes(JsonHelper.ToJson(streamingVersionConfig));
        fs.Write(data, 0, data.Length);
    }

    Log.Debug("已修改Version.txt");
}
```

## 新增自定义工具

因为是编辑模式下才需要的功能,所以可以在刚才我们新建的自定义工具中新增Version.txt的修改功能. 先在BundleHelper新建一个静态成员: public static VersionConfig version;

```
BundleHelper.version = BundleHelper.GetVersionConfig();
BundleHelper.Delete(BundleHelper.version);
BuildPipeline.BuildAssetBundles("Assets/StreamingAssets", BuildAssetBundleOptions.None, BuildTarget.StandaloneWindows64);
BundleHelper.Modify(BundleHelper.version);
```

这样一来,就可以实现一键打包assetbundle啦. 虽然运行的时候Unity经常报错,说object没有依赖,但是我找不出问题来. 大概不影响使用. 将获得的新文件上传到资源下载服务器/CDN/云端,再运行客户端. 客户端会先对比文件差异后,下载有差异的文件. 可以观察到UILoading的进度,将进度更新频率修改为500毫秒更明显一些. 到这里,PC端的热更新发布就完成了.

# 局部更新

在本例中,客户端一次性下载了全部的assetbundle资源,这不一定是我们期待的. 或者说,只有当客户主动选择一次性下载全部资源的情况下才可以这么干. 用户在进行一个任务,或者一个关卡时,判断其有没有下载指定名称的assetbundle. 如果没有下载资源,那么游戏事件肯定继续不下去,必须下载. 可以提前异步下载下一个关卡所需的资源,以减少用户的等待时间.

## 实现方案

实现局部更新,可以考虑对异步下载步骤进行修改,全局资源文件对比的步骤依然不变. 这样本地就可以获得一份未下载资源文件目录. DownloadAsync直接不执行. 在每个事件(event)中执行LoadOneBundle时,判断当指定文件不存在就执行下载方法. 并执行下一个事件的LoadOneBundle方法.

## 界面切换

ET案例中,界面切换不平滑. 让UILoading默认开启就好,进度显示和背景都可以根据自己的产品进行美化. 当加载完内容完成后再隐藏UILoading,后面一个界面准备好了再卸载前面一个界面. 提升用户体验.

# 安卓发布

关于安卓打包环境设置其实我都倒腾过2次以上了,以前不会写博客,所以资料也就不存在了. 现在再写一遍的说,希望能和博客一起保留下来. 另外需要吐槽的是,建议关闭wordpress的自动更新/软件更新自动更新/更新提示. 如果软件升级导致博客程序无法继续运行会非常悲剧.总之,有博客真好.

## 不兼容的代码

将ET的Build Platform设置为Android的后,可能会产生新的报错. 也就是:原本在PC平台存在的类,在安卓平台无法使用的现象. 本例中出现的问题是:System.Reflection.Emit下的类DynamicMetho 在迁移到安卓平台的过程中,应解决此类问题. \[toc\]本篇的内容为将ET客户端打包到其他平台 将ET客户端的默认项目打包发布到PC端发现无法运行,本篇的目的就是解决客户端打包发布的问题,因为目前没有mac机器,ios版暂不讨论. 由于在Unity编辑模式下,对资源的读取会和非编辑模式有差异. 如ET在编辑模式下: // 下载ab包 `await BundleHelper.DownloadBundle();` 会因为Define.IsAsync的定义而跳过执行. ResourcesComponent的LoadOneBundle方法也有这样的差异. 在编辑模式下会使用AssetDatabase类来直接获得assetBundleName下的全部路径. 在非编辑模式下则通过找到被打包后的assetBundleName文件来获得文件内的资源.

## 轻松出apk

Unity2018.3以上的安卓环境配置以及非常简单,不需要额外查资料: 随便新建一个项目; 切换到Android Platform,需要安装安卓支持组件; Editor-Unity Preferences-External Tools: SDK/JDK默认已经配置好了,**NDK需要下载**.选项右边有下载地址. Unity2018.3要求NDK-r16b,也就是目前最新的稳定版. 相比过去配置环境来说,方便极了. 将打出的.apk用蓝蝶模拟器运行,成功.

# ios发布

因为个人精力有限，如果主攻一个平台的话，我会选择ios，然后才是安卓。 ios的包不像安卓可以在windows上直接运行模拟器，这里直接使用VMware14安装OSX虚拟机: VMware的Mac补丁github,[unlocker地址](https://github.com/DrDonk/unlocker "unlocker地址"); [unlocker百度网盘备份](https://pan.baidu.com/s/1B2umsqQB0fNsXetuVsIQSg "unlocker百度网盘备份"); VMware Workstation 14,官方[下载地址](https://www.vmware.com/products/workstation-pro/workstation-pro-evaluation.html "下载地址"); [VMware Workstation 14百度网盘备份](https://pan.baidu.com/s/1qX79ZpQTo7ksFKkOSD43Rw "VMware Workstation 14百度网盘备份"); VMware Workstation v14.x 永久许可证激活密钥 FF31K-AHZD1-H8ETZ-8WWEZ-WUUVA CV7T2-6WY5Q-48EWP-ZXY7X-QGUWD [macOS High Sierra 10.13下载](https://pan.baidu.com/s/1j061SFIBc8ase1ILHS4p7g "macOS High Sierra 10.13下载");

## 安装macOS虚拟机

1.安装VMware Workstation 14 2.管理员cmd运行win-install.bat 3.建立macOS虚拟机 4.修改虚拟机目录下的.vmx配置文件,在第18行下增加: smc.version = "0" 5.开机虚拟机 成功安装macOS虚拟机后,可以在appstore中平滑升级到macOS Mojave 10.14. 这里也提供[macOS Mojave 10.14镜像](https://pan.baidu.com/s/1Fxy29k_fN3GRkBytQ1GM8w "macOS Mojave 10.14镜像"),macOS相关镜像均来自于远景论坛.

## 配置开发环境

解决好了系统之后,需要配置下Unity开发环境. 在appstore开发板块下载安装Xcode; 在浏览器中搜索Unity,下载Unity Hub,选择自己所需的版本和组件. 真机调试:需要先从PC端断开手机连接,使虚拟机连接上手机. 模拟器调试:需要设置SDK为模拟器SDK,在playersetting中添加OpenGL ES 3支持. 如果还有其他情况,看BUG信息再调试吧.