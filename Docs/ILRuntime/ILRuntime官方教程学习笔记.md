1.主要参考链接
	官方教程首页：https://ourpalm.github.io/ILRuntime/public/v1/guide/tutorial.html
		教程中详细描述了ILRuntime的安装、使用、调试等问题
		使用海外版Unity时，包管理器可能遇到比较棘手的网络问题。
	此外我们还非常关注ILRuntime的优劣，热更新的实现原理，以及开发过程中可能遇到的问题：
		https://zhuanlan.zhihu.com/p/260216935
		https://blog.csdn.net/m0_48554728/article/details/123977368
		这方面的问题网上的帖子很多，有疑问的时候再去查阅即可。
	总得来说ILRuntime对C#程序员友好些，不需要再学一门语言。
	
2.使用步骤
	1.安装ILRuntime的package
	2.在热更DLL和冷更DLL写逻辑
		框架层：Unity和.Net提供的底层库，或者第三方库。
		应用层：分为冷更层和热更层，也有数据和逻辑的分离，冷更层也包含开发者自建的部分框架。
		热更层避免使用MonoBehaviour AddComponent和序列化可能需要额外支持
	3.在热更层调用冷更层代码
		CLR Binding：
		热更DLL调用主工程的方法时，默认使用反射的方式，这个过程会产生GC Alloc，且执行效率偏低。
		使用CLR Binding可以提高执行效率和避免GC Alloc。
		裁剪：Unity在打包时裁剪掉没有使用的代码，CRL Binding使热更层要调用的代码有了引用次数。
		CLR Binding加速执行：执行热更层il时先查找并执行重定向函数，没有时用反射调用。
			CLR Binding文件中提供方法的反射实例和对应的重定向函数
			比如热更层中调用了：renderer.receiveShadows = false;
			则绑定文件中会出现UnityEngine_Renderer_Binding.cs对receiveShadows方法进行包装
	4.在冷更层调用热更层代码
		因为没有DLL引用关系，冷更层只能通过反射方式调用热更层的代码
		ILRuntime中有无GC Alloc的方式来完成这个调用(课程2)
		比如冷更层收到的消息都无脑转发给热更层
	5.委托
		在热更层使用冷更层的委托时需要注册
		注册委托：仅按照输入参数类型和是否有返回值来注册即可
		为所有输入参数为int，无返回值的委托注册：
			appdomain.DelegateManager.RegisterMethodDelegate<int>();
		为所有输入参数为int，返回值为string的委托注册：
			appdomain.DelegateManager.RegisterFunctionDelegate<int, string>();
		注册转换器：非Action和Func类型的委托需要写转换器
			在热更层创建委托实例时使用Action和Func，需要转换为对应类型。
			使用Aciton和Func类型的委托时不需要写转换器。
		在冷更层调用热更层的委托需要注册适配器
	6.适配器
		如果热更层有继承于冷更层的类型，则冷更层的父级需要注册适配器。
		在编辑器代码ILRuntimeCrossBinding.cs中添加要生成的类型。
	7.值类型绑定
		冷更层的值类型在热更层使用时需要类型绑定解决GC Alloc和额外的CPU开销。