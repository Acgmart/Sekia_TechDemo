# 参考链接
ACES官网 https://community.acescentral.com/



https://zhuanlan.zhihu.com/p/76749824
https://www.bilibili.com/video/BV1dV411i7M1
https://www.bilibili.com/video/BV1jM4y1N7yT

# ACES预备课
https://mp.weixin.qq.com/s/HDOQGHNK0Aprn5lznVwtOA
https://mp.weixin.qq.com/s/5GBbDNYJL6InuI3ASCjAkg

CIE RGB色彩空间 -> 应用3x3矩阵 -> CIE XYZ色彩空间 ->在XYZ规划色域
XYZ色彩空间的色彩分布不均匀 即XYZ上不同区域人眼可发觉色差差异的距离不同

Gamma值2.2的意义
存储图片时提高暗部精度 8bit中有6bit给暗部
	比如Gamma的0-0.5对应Linear的0-0.2 给了暗部更多的存储区域
更接近人眼直觉 人眼和显示器都做了一次矫正 
	人眼看到的Linear的0.2对应中灰 人眼对暗部细节更敏感

所有的色彩空间的三个指标：
1.色域 三基色的坐标和亮度构成的立体范围  
	色域三角形里的颜色R+G+B=1
2.gamma 如何对色域进行切分
	指数为1、2.2、2.4不等
3.白点 色域三角形的中心 (1/3, 1/3, 1/3)
	白点移动时 色域三角形内的差值结果发生变化
常说的Gamma和Linear转换只发生了gamma值的变化 色域和白点没动
gamma值2.2表示靠近三基色的位置被切的更细

OETF：Linear -> Gamma 方便后续的记录传输
EOTF：Gamma -> Linear 反编码 还原场景光照
	SDR显示器只有100nit

色域(和白点一起规定)	 白点          gamma
sRGB					D65          2.2
Rec709					D65          2.4
DCI-P3					D65            ？
Rec2020					D65            ?
WideGamut				？           2.2
ACES AP0				D60            1
ACES AP1				D60            1

ACES色彩系统下的色彩空间：AP0和AP1
AP0：标准色彩空间2065-1 包含所有可见光 工作上不方便
AP1：与Rec2020相近 有少量区域为不可见光
	AP1下有很多working space：ACEScg|ACEScc|ACEScct|ACES proxy

IDT Input Device Transform：将输入的任何色彩空间转换到AP0
RRT Reference Rendering Transform：在工作模式和显示模式间切换
	Scene-referred：Linear的、HDR的、基于物理真实的
	Display-referred：经过转化、可在显示设备呈现、符合人眼感受
ODT Output Device Transform：还原到目标色彩空间上
	如sRGB显示器、Rec709监视器、P3放映机、Rec2020 1000nit电视机



# https://knarkowicz.wordpress.com/2016/01/06/aces-filmic-tone-mapping-curve/
ACES Filmic Tone Mapping Curve Posted by Krzysztof Narkowicz
	采样ODT(RRT(X))矩阵并用简单曲线拟合
	Linear -> 自动曝光(Shift) -> 拟合曲线 -> Linear
	ACES is RGB linear color space with a D60 white point
	sRGB和Rec709使用D65的白点 ACES使用D60白点
	将颜色转换到ACEGcg色域(AP1)后应用RRT？

ACES color encoding system was designed for seamless working with color images regardless of input or output color space. It also features a carefully crafted filmic curve for displaying HDR images on LDR output devices. Full ACES integration is a bit of overkill for games, but we can just sample ODT( RRT( x ) ) transform and fit a simple curve to this data. We don’t even need to run any ACES code at all, as ACES provides reference images for all transforms. Although there is no linear RGB D65 ODT transform, but we can just use REC709 D65 and remove 2.4 gamma from it.
ACES颜色编码系统用于处理图片工作流，不论输入和输出是什么色彩空间。
ACES也包括一个filmic曲线用于将HDR转换到LDR。
完整的ACES系统对于游戏来说太复杂，我们只用和RRT => ODT转换来简单拟合曲线。
我们甚至无需运行ACES代码，因为ACES为所有转换提供了不同色彩空间的Lut图片。
虽然没有线性空间的Lut，我们可以用Rec709的Lut并移除2.4的Gamma。

Curve was manually fitted (max fit error: 0.0138) to be more precise in the blacks – after all we will be applying some kind gamma afterwards. Additionally, data was pre-exposed, so 1 on input maps to ~0.8 on output and resulting image’s brightness is more consistent with the one without any tone mapping curve at all. For the original ACES curve just multiply input (x) by 0.6.	
在执行了某些Gamma转换后，应用拟合曲线使暗部更精细，误差小于0.0138.
另外，需要先自动曝光。
所以输入1会得到0.8。
相比没有任何tonemapping曲线的图片，结果更接近我们的期望(显示了更高的亮度)。
对于最初的ACES曲线只需要将输入值乘以0.6。(最初的Filmic输入1输出0.4)
	
UPDATE: This is a very simple luminance only fit, which over saturates brights. This was actually something consistent with our art direction, but for a more realistic rendering you may want a more complex fit like this one from Stephen Hill.	
更新：这只是一个非常简单的亮度拟合，会截断一些亮处。
这实际上与我们的艺术方向一致，但要获得更逼真的渲染，您可能需要像 Stephen Hill 这样的更复杂的拟合。
https://github.com/TheRealMJP/BakingLab/blob/master/BakingLab/ACES.hlsl
https://docs.unity3d.com/Manual/HDR.html


# https://zhuanlan.zhihu.com/p/21983679
对于实时渲染来说，没有必要用全套ACES。
因为第一，没有“输入设备”，渲染出来的HDR图像本身就是线性的数据，直接就在ACES空间中。
输出的时候要进行一次tonemapping，将HDR转到LDR或者另一个HDR。
float3 ACESToneMapping(float3 color, float adapted_lum)
{
	const float A = 2.51f;
	const float B = 0.03f;
	const float C = 2.43f;
	const float D = 0.59f;
	const float E = 0.14f;

	color *= adapted_lum;
	return (color * (A * color + B)) / (color * (C * color + D) + E);
}

# https://knarkowicz.wordpress.com/2016/01/09/automatic-exposure/
In games automatic exposure or eye adaptation is an algorithm for simulating eye reaction to temporal changes in lighting conditions and for selecting optimal exposure for a given scene and lighting conditions. The main challenge here is that optimal settings are hard to define. Should we expose for sunlight, shadows or something in between? Should the image be normally exposed, underexposed or overexposed? This is main reason why some people dislike automatic exposure and prefer to set exposure manually.
在游戏中，自动曝光或眼睛适应是一种算法，用于模拟眼睛对照明条件的时间变化的反应，并为给定的场景和照明条件选择最佳曝光。这里的主要挑战是难以定义最佳设置。我们应该曝光阳光、阴影还是介于两者之间的东西？图像应该正常曝光、曝光不足还是曝光过度？这就是为什么有些人不喜欢自动曝光而喜欢手动设置曝光的主要原因。

In photography exposure is something that’s carefully selected by a photographer during the shot or afterwards during photo processing and for many linear games with static lighting exposing manually is indeed a good solution. Even for some games with changing lighting conditions this can be done manually by placing virtual luminance meters and selecting one using manually placed triggers or exposure volumes (post process volumes).
在摄影中，曝光是摄影师在拍摄过程中或之后在照片处理过程中精心挑选的东西，对于许多带有静态光照的线性游戏来说，手动曝光确实是一个很好的解决方案。即使对于某些光照条件不断变化的游戏(行走时路过不同区域)，也可以通过亮度测量 + 放置后处理Volume构成Volume网络差值来得到合适的固定曝光值。

KeyValue => exp(avg(log(luminance))) =>采样使用Log(luminance)生成图片的最后一层mip再exp
使用EV作为亮度单位
侧重于屏幕中部

# Unity的直方图自动曝光 https://zhuanlan.zhihu.com/p/76416912

# https://docs.nvidia.com/gameworks/index.html#devices/shield-hdr-dev-guide/hdr-dev-guide-nvidia-shield.htm
This linear color undergoes post processing, color grading, LMT, RRT, ODT, etc and then the UI in the same color space as the output from ODT phase is composited on top of it. Refer to the ACES Homepage (http://www.oscars.org/science-technology/sci-tech-projects/aces) and GitHub repo (https://github.com/ampas/aces-dev) for more information and sample code for ACES implementation.
线性颜色经过后处理、色调映射、LMT、RRT、ODT等，在ODT的输出结果中合成UI

ACES dev仓库



# 冯乐乐 https://zhuanlan.zhihu.com/p/150894189
第一篇：https://zhuanlan.zhihu.com/p/129095380
主体渲染是在sRGB linear下进行的
