# 渲染基础 ShaderLibrary
shader语法和C++、C#等编程语言差不多，越是复杂的功能背后依赖的函数库就越多。  
shader底层是DXBC指令，DXBC更底层则是不同GPU对指令的实现。  
在Unity中对shader语法进行了一层包装，我们称之为ShaderLab语法。  
    不同渲染API的Shader有差异，如DX、Metal、Vulkan、OpenGL，而Unity是跨平台的。  
    我们能基于ShaderLab语法编写shader，根据DXBC指令进行算法优化。  
<img src="_res_shader_library/cover.jpg" alt="Shader含数据" width="50%" height="50%">  

## 参考资料 
1.[HLSL微软官方文档](https://docs.microsoft.com/en-us/windows/win32/direct3dhlsl/dx-graphics-hlsl "HLSL微软官方文档") 
2.[Unity SRP Github](https://github.com/Unity-Technologies/ScriptableRenderPipeline "Unity SRP Github")

# HLSL语法
在Unity中编写Shader、Compute Shader时，我们可以选择使用HLSL语言，这是推荐的做法。
HLSL语法与C++类似，比如加减乘除余、变量/函数声明、循环控制、输入/输出等。

## 变量
变量需要被声明、赋值，作用范围取决于声明的位置，有指定的存储位置和读写限制。
Vector类型：float4 a = float4(b.xyz, 4.0); 
	Vector类型变量包含1-4个标量分量，每个分量的存储类型一致； 
	可以使用xyzw或rgba访问Vector的分量。 
标量(Scalar)类型：常用的有bool、int、uint、float。

## 语句
例：float a = b * (c / d) - Func(e);
一个表达式(语句)由许多变量、运算符和方法构成，以“；”结尾，包括“return”语句。
	加减乘除余：+ - * % 
	数组/矩阵取值操作：array[i] matrix[0] matrix[0][1] 
	赋值操作：= += -= *= /= %= 
	布尔操作：&& ?: 
	比较操作：any(A4 < B4) all(A4 < B4) < > == != <= >= 
	前后置操作：++ --
		注：多元变量运算时通常每个分量单独计算。
		注：比较操作仅限于单个分量。
		注：多元布尔操作返回多元bool Vector。
		注：matrix[0]返回多元Vector。
	显式强制转换操作： (float)i4   等同于   float(i4.x)
	                   (float4)i   等同于   float4(i, i, i, i)
	                   asfloat(i)  asint(f) asuint(f) 
		注：根据转换目标有精度损失。 
	二进制操作(仅对int和uint有效)： ~  <<  >>  &  |  ^
		注：<<为数字左移，高位移出，低位补0。
		注：>>为数字右移，低位移出，高位补符号位(正数补0/负数补1)。
		注：^二进制的逻辑异，不同既为真。

## 流程控制
if、for、while等C++风格的语法都可以使用。

## 语义
语义可用来表示特殊的输入和输出，可声明在结构体内。
这些语义分布在vertex函数输入/输出、frag函数输入/输出。
vertex输入(模型空间数据)
	float4 vertex : POSITION; //模型空间中的坐标 
	float3 normal : NORMAL; //法线方向
	float4 tangent : TANGENT; //切线方向 tangent.w用于确定副法线的方向
	float4 texcoord0 : TEXCOORD0; //第一套纹理坐标
	float4 texcoord1 : TEXCOORD1; //第二套纹理坐标
	float4 texcoord2 : TEXCOORD2; //第三套纹理坐标
	float4 texcoord3 : TEXCOORD3; //第四套纹理坐标
	float4 color : COLOR; //顶点色
	uint vid : SV_VertexID //顶点的index，与mesh.vertex中顺序一致。
vertex输出
	SV_POSITION //顶点在裁剪空间中的坐标
frag输入
	fixed facing : VFACE; //大于0表示当前三角形是正面朝向相机： 
	UNITY_VPOS_TYPE screenPos :  VPOS //屏幕坐标
fragment输出 
	SV_TARGET //指向第一个颜色目标RT

## ComputeBuffer
可以使用ComputeBuffer向GPU传递一个固定长度的struct队列。

## Sampler 采样器
URP默认样式：`TEXTURE2D(_MainTex); SAMPLER(sampler_MainTex); float4 _MainTex_TexelSize;`
采样器中包含wrapping和filtering设置，有数量上限，建议将Texture2D和NoramlMap分别使用采样器。
简写模式：`sampler2D _MainTex;` //这个声明方式自带采样器
自定义采样器：`SAMPLER(sampler_Linear_Clamp);` //可使用字符串拼接的方式声明采样器

采样操作语法： 
`float4 value = _Ramp.Sample(sampler_Ramp, float2(intensity, 0));` 
`float4 value = tex2D(_Ramp, uv.xy);`  //使用自带采样器
`float4 value = SAMPLE_TEXTURE2D(_Ramp, Sampler, uv.xy);` 

## 内置函数
▲abort() 注：报错并终止DrawCall。
▲abs(x) 注：返回逐分量的绝对值，abs(-1)为1。
▲acos(x) 注：返回逐分量(在-1至1范围内)的反余玄值(弧度)，乘以57.29578转换为角度。
注：如果需要将角度转化为弧度，那么就是乘以0.0174532924。
▲all(x) 注：如果x的所有分量都不为0，返回true；否则返回false。
▲AllMemoryBarrier() 注：异步读写时，等待group内线程读写完毕。
▲AllMemoryBarrierWithGroupSync() 注：异步读写时，等待group内线程逻辑执行到此调用。
▲any(x) 注：如果x的任一分量不为0，返回true；否则返回false。
▲asdouble(x, y) 注：将2个uint Vector转换为1个double Vector，分量数不变。
▲asfloat(x) 注：将1个任意Vector转换为float Vector。
▲asin(x) 注：返回逐分量(在-1至1范围内)的反正玄值(弧度)，乘以57.29578转换为角度。
▲asint 注：将1个任意Vector转换为int Vector。
▲asuint 注：将1个任意Vector转换为uint Vector。
▲atan(x) 注：返回逐分量的反正切值(弧度)，乘以57.29578转换为角度。
▲atan2(y, x) 注：返回向量(x, y)与X轴的反正切值(弧度)，乘以57.29578转换为角度。
▲ceil(x) 注：如果x有小数部分，返回比x大的最小的整数。
▲CheckAccessFullyMapped(x) 
▲clamp(a, x, y) 
注：if(a < x) retrun x; if(a > y) retrun y; retrun a; 
▲clip(x) 注：如果x的任意分量小于0，则忽略当前片元；也就是透明度测试alphatest。 
▲cos(x) 注：返回x(弧度)的余玄值。 
▲cosh(x) 注：[双曲线余玄函数](http://tushuo.jk51.com/tushuo/4461003.html "双曲线余玄函数")。 
▲countbits(x) 注：返回逐分量(uint类型)的二进制格式中1的数量。 
▲cross(x, y) 注：返回x和y(参数为多组件Vector类型)的叉积。 
▲D3DCOLORtoUBYTE4(x) 注：返回x的UBYTE4表达形式。 
▲ddx(x) 注：范围Vector x的[偏导数](https://blog.csdn.net/wylionheart/article/details/78026707 "偏导数")。 
▲ddx\_coarse(x) 注：返回Vector x的低精度偏导数。 
▲ddx\_fine(x) 注：返回Vector x的高精度偏导数。 
▲ddy ▲ddy\_coarse 
▲ddy\_fine 注：参考ddx。 
▲degree(x) 注：将x(弧度)转化为角度。 
▲determinant(x) 注：返回x(方形-浮点数-矩阵)的[行列式](https://baike.baidu.com/item/%E4%B8%89%E9%98%B6%E8%A1%8C%E5%88%97%E5%BC%8F/4466518?fr=aladdin "行列式")。 
▲DeviceMemoryBarrier() 注：同步节点，group内所有线程完成对device memory的访问。 
▲DeviceMemoryBarrierWithGroupSync() 注：同步节点，设备内存访问+逻辑同步。
▲distance(x, y) 注：返回x和y(Vector)之间的距离，√((xa-xb)² + (ya-yb)²)。
▲dot(x, y) 注：返回x和y(Vector)的点积，xa \* xb + ya \* yb。
▲dst(x, y) 注：返回[(1, x.y \* y.y, x.z, y.w)](https://docs.microsoft.com/en-us/windows/win32/direct3dhlsl/dst---vs "(1, x.y * y.y, x.z, y.w)")。
▲errof(string, ...) 注：将错误消息提交到信息队列。 
▲EvaluateAttributeAtCentroid(x) 注：评估像素质心。 
▲EvaluateAttributeAtSample(x, y) 注：评估采样位置。 
▲EvaluateAttributeSnapped(x, y) 注：使用偏移量评估像素质心。 
▲exp(x) 注：返回以自然数e(2.71828)为底数，x为指数的值。 
▲exp2(x) 注：返回以2为底数，x为指数的值。 
▲f16tof32(x) 注：返回x(被保存为unit的16位浮点数)的32位浮点数表达形式。 
▲f32tof16(x) 注：返回x(32位浮点数)的16位浮点数表达形式(被保存为unit)。 
▲faceforward(n1, v, n2) 注：使法线方向正对观察方向，-n1 \* sign(dot(v, n2))。 
▲firstbithigh(x) 注：返回逐分量(int或uint)的二进制格式中从高位数第一个1的位置。 
▲firstbitlow(x) 注：返回逐分量(uint)的二进制格式中从低位数第一个1的位置。 
▲floor(x) 注：如果x有小数部分，返回比x小的最大整数，floor(-2.3) = -3。 
▲fma(a, b, c) 注：参数为double类型，a \* b + c。 
▲fmod(x, y) 注：返回x/y的小数部分。 
▲frac(x) 注：返回x的小数部分。 
▲frexp(x, exp) 注：返回输入值的小数部分和指数。 
▲fwidth(x) 注：返回abs(ddx(x) + abs(ddy(x))。 
▲GetRenderTargetSampleCount() 注：返回渲染目标的采样器数量。 
▲GetRenderTargetSamplePosition(x) 注：返回采样器x对应的采样位置(x, y)。 
▲GroupMemoryBarrier() 注：group shared内存访问同步节点。 
▲GroupMemoryBarrierWithGroupSync() 注：group shared内存访问+逻辑同步节点。 
▲InterlockedAdd(dest, value, original\_value) 
▲InterlockedAnd(dest, value, original\_value) 
▲InterlockedCompareExchange(dest, compare\_value, value, original\_value) 
▲InterlockedCompareStore(dest, compare\_value, value) 
▲InterlockedExchange(dest, value, original\_value) 
▲InterlockedMax(dest, value, original\_value) 
▲InterlockedMin(dest, value, original\_value) 
▲InterlockedOr(dest, value, original\_value) 
▲InterlockedXor(dest, value, original\_value) 
▲isfinite(x) 注：逐分量判断浮点数的值是否为finite(有限的)。 
▲isinf(x) 注：逐分量判断浮点数的值是否为infinite(无限的)。 
▲isnan(x) 注：逐分量判断浮点数的值是否为NAN或QNAN。 
▲ldexp(x, y) 注：逐分量返回x \* 2^y。 
▲length(x) 注：返回x(Vector)的长度。 
▲lerp(x, y, a) 注：等效于x + a(y-x)。 
▲lit(NdotL, NdotH, 平滑度) 注：返回Blinn光照模型Vector4(环境光, 漫反射光, 镜面高光, 1)。 
▲log(x) 注：求对数，返回以e为底数，x为值时对应的指数。 
▲log10(x) 注：求对数，返回以10为底数，x为值时对应的指数。 
▲log2(x) 注：求对数，返回以2位底数，x为值时对应的指数。 
▲mad(a, x, y) 注：返回a \* x + y。 
▲max(x, y) 注：返回逐分量最大值。 
▲min(x, y) 注：返回逐分量最小值。 
▲modf(x, a) 注：逐分量返回x的有符号的小数部分，将x的整数部分保存到a。 
▲msad4(reference, source, accum) 
▲mul(x, y) 注：矩阵相乘；矢量在右边时，被竖排序；矢量在左边时，被横排序。 
▲noise(x) 注：Perlin噪声函数，返回值在-1至1内。 
▲normalize(x) 注：归一化x(Vector)。 
▲pow(x, y) 注：幂运算，x为底数，y为指数。 
▲printf(string, ...) 注：将自定义着色器消息提交到信息队列。 
▲Process2DQuadTessFactorsAvg(x, y, a, b, c) 
▲Process2DQuadTessFactorsMax(x, y, a, b, c) 
▲Process2DQuadTessFactorsMin(x, y, a, b, c) 
▲ProcessIsolineTessFactors(x, y, a, b) 
▲ProcessQuadTessFactorsAvg(x, y, a, b, c) 
▲ProcessQuadTessFactorsMax(x, y, a, b, c) 
▲ProcessQuadTessFactorsMin(x, y, a, b, c) 
▲ProcessTriTessFactorsAvg(x, y, a, b, c) 
▲ProcessTriTessFactorsMax(x, y, a, b, c) 
▲ProcessTriTessFactorsMin(x, y, a, b, c) 
▲radians(x) 注：将角度x转换为弧度。 
▲rcp(x) 注：逐分量返回近似倒数。 
▲reflect(input, normal) 注：求反射方向, input为入射方向，返回input - 2 \* normal \* dot(input, normal)。 
▲refract(input, normal, 折射率) 注：求折射方向。 
▲reversebits(x) 注：逐分量使x的高位和低位互换位置，0001 ⇒　1000。 
▲round(x) 注：逐分量四舍五入。 
▲rsqrt(x) 注：逐分量平方根的倒数。 
▲saturate(a) 注：等效于clamp(a, 0, 1) 
▲sign(x) 注：相当于if(x<0) return -1;if(x>0) return 1; return 0;。 
▲sin(x) 注：返回x(弧度)的正玄值。 
▲sincos(x, s, c) 注：void，将x(弧度)的sin值和cos值分别赋值到s和c。 
▲sinh(x) 注：双曲线正玄函数。 
▲smoothstep(x, y, a) 
注：平滑梯度，类似于clamp(a, x, y)； 
当y>x时，a<x时返回0，a>y时返回1，腰部值根据曲线算。 
当y<x时，a>x时返回0，a<y时返回1，腰部值根据曲线算。 
▲sqrt(x) 注：逐分量返回x的平方根。 
▲step(a, b) 注：等效于(b >= a) ? 1 : 0 
▲tan(x) 注：逐分量返回x(弧度)的正切值。 
▲tanh(x) 注：双曲线正切函数。 
▲tex1D(s, t) ▲tex1D(s, t, ddx, ddy) 
▲tex1Dbias ▲tex1Dgrad ▲tex1Dlod ▲tex1Dproj 
▲tex2D(sampler, uv) 注：采样2D texture(pixel shader only)，自动选择Mipmap。 
▲tex2D(sampler, uv, ddx, ddy) 注：相比tex2D，使用屏幕坐标x和y方向上的梯度指定Mipmap。 
▲tex2Dbias(sampler, uv) 注：相比tex2D，uv.w中包含采样位置偏移量。 
▲tex2Dgrad(sampler, uv, ddx, ddy) 注：相比tex2D，使用屏幕坐标x和y方向上的梯度指定Mipmap。 
▲tex2Dlod(sampler, uv) 注：相比tex2D，uv.w中指定Mipmap层级。 
▲tex2Dproj(tex, uv) 注：相比tex2D，UV除以w分量：uv.xy / uv.w。 
▲tex3D(s, t) ▲tex3D(s, t, ddx, ddy) ▲tex3Dbias ▲tex3Dgrad ▲tex3Dlod ▲tex3Dproj ▲texCUBE(s, t) ▲texCUBE(s, t, ddx, ddy) ▲texCUBEbias ▲texCUBEgrad ▲texCUBElod ▲texCUBEproj 
▲transpose(x) 注:返回x(矩阵)的转置矩阵(将行列互换)。 
▲trunc(x) 注：逐分量去除小数部分，trunc(-2.3)= -2。

# Legacy库

由于目前大部分网络上的资料都由内置管线编写，Legacy库依然有学习价值。 ▲ComputeGrabScreenPos(float4)

```
inline float4 ComputeGrabScreenPos (float4 pos) //输入Clip空间4元坐标
{
    #if UNITY_UV_STARTS_AT_TOP
    float scale = -1.0;
    #else
    float scale = 1.0;
    #endif
    float4 o = pos * 0.5f;
    o.xy = float2(o.x, o.y*scale) + o.w; //输出x分量为pos.w * (pos.x / pos.w + 1) * 0.5
#ifdef UNITY_SINGLE_PASS_STEREO          //输出y分量会额外在DX平台反转
    o.xy = TransformStereoScreenSpaceTex(o.xy, pos.w);
#endif
    o.zw = pos.zw;                       //输出zw分量为pos.zw
    return o;
}
```

ComputeGrabScreenPos用于计算屏幕空间的位置，在vertex中调用，fragment中xy分量除以w分量(tex2Dproj)后可作为UV坐标使用。提供DX平台的UV反转，使DX平台屏幕左下角对应(0, 1)，可直接使用tex2Dproj采样基于屏幕空间的Texture，tex2Dproj采样结果与Screen空间(0-1的2D坐标系)位置对应，区别于通常tex2D采样结果与Object空间位置对应。也就是，将A相机看到的结果提供给B相机采样。

# SRP-Core库

SpaceTransforms.hlsl ▲GetObjectToWorldMatrix() 注：返回Object-World矩阵。 ▲GetWorldToObjectMatrix() 注：返回World-Object矩阵。 ▲GetWorldToViewMatrix() 注：返回World-View矩阵。 ▲GetWorldToHClipMatrix() 注：返回World-Clip矩阵。 ▲GetViewToHClipMatrix() 注：返回View-Clip矩阵。 ▲GetAbsolutePositionWS(x) ▲GetCameraRelativePositionWS(x) ▲GetOddNegativeScale ▲TransformObjectToWorld ▲TransformWorldToObject ▲TransformWorldToView ▲TransformObjectToHClip ▲TransformWorldToHClip ▲TransformWViewToHClip ▲TransformObjectToWorldDir ▲TransformWorldToObjectDir ▲TransformWorldToViewDir ▲TransformWorldToHClipDir ▲TransformObjectToWorldNormal ▲CreateTangentToWorld ▲TransformTangentToWorld ▲TransformWorldToTangent ▲TransformTangentToObject ▲TransformObjectToTangent

# SRP-URP库

# SRP-HDRP库

# C#库

在C#中经常需要设置矩阵、向量，实现旋转、反射等效果，也需要图形方面的计算。 ▲Matrix4x4类型结构体 Matrix4x4 test = new Matrix4x4(Vector4.one, new Vector4(2F, 3F, 4F, 5F), Vector4.one, Vector4.one); Matrix4x4结构使用4个Vector4参数填充矩阵的每一列。 test = test1 \* test2; //矩阵相乘，对应mul(a, b)操作，作图时a在左侧，b在上侧。 test = test.transpose; //矩阵置转，交换行列。 test = test.inverse; //矩阵求逆，不一定有逆矩阵。 Debug.Log(test.m03); //可以查看矩阵的分量，两个数字分布代表所在行和列。 Debug.Log(test\[4\]); //使用数组取值方式时，参数为列排序，test\[4\]相当于test.m01。 Debug.Log(test); //可以直接查看矩阵的值。 test.MultiplyPoint3x4(pos); //使用矩阵转移顶点。 test.MultiplyVector(normal); //使用矩阵转移向量。 ▲Vect4类型结构体 Vector4.Dot(test1, test2); //对应dot(a, b)操作。

# Unity内置参数

## UnityShaderVariables.cginc

包含了很多内置的全局变量，这个文件会被自动包含。 参考[Unity用户手册](https://docs.unity3d.com/Manual/SL-UnityShaderVariables.html)。 时间 float4 \_Time;float4\_SinTime;float4\_CosTime;float4 unity\_DeltaTime 常用矩阵 UNITY\_MATRIX\_M 将顶点/矢量从模型空间变换到世界空间。 UNITY\_MATRIX\_V 将顶点/矢量从世界空间变换到观察空间。 UNITY\_MATRIX\_P 将顶点/矢量从观察空间变换到裁剪空间。 UNITY\_MATRIX\_MV 将顶点/方向矢量从模型空间变换到观察空间。 UNITY\_MATRIX\_VP 将顶点/矢量从世界空间变换到裁剪空间。 UNITY\_MATRIX\_MVP 将顶点/方向矢量从模型空间变换到裁剪空间。 经常被UnityObjectToClipPos(v.vertex)函数替换。 UNITY\_MATRIX\_I\_V UNITY\_MATRIX\_V的逆矩阵 UNITY\_MATRIX\_T\_MV UNITY\_MATRIX\_MV的转置矩阵。 unity\_WorldToObject UNITY\_MATRIX\_M的逆矩阵。 全局光照变量 UNITY\_LIGHTMODEL\_AMBIENT 环境光颜色，可在Lighting Settings中确认。 float4 \_WorldSpaceLightPos0 光源方向，对于平行光，w分量为0；对于非平行光，w分量为1。 需要取其xyz分量作为矢量并归一化，只可在ForwardBase/ForwardAdd中使用。 float4 unity\_4LightPosX0;float4 unity\_4LightPosY0;float4 unity\_4LightPosZ0;float4 unity\_4LightAtten0;half4 unity\_LightColor\[4\]; 仅用于ForwardBase，在顶点着色器中计算4个逐顶点光照，作为Shade4PointLights函数的参数。 全局相机参数 \_WorldSpaceCameraPos float3 该相机在世界空间中的位置。 用于减去顶点/片元在世界空间中的坐标，也就是xyz分量，得到摄像机方向。 \_ProjectionParams float4 Near和Far。 \_ScreenParams float4 render target的像素宽度和高度，x为像素宽度，y为像素高度，单位为像素。 \_ZBufferParams float4 x=1−Far/Near，y=Far/Near，z=x/Far，w=y/Far。 unity\_OrthoParams float4 正交相机的W和H。 unity\_CameraProjection float4x4 该相机的投影矩阵。 unity\_CameraInvProjection float4x4 该相机的投影矩阵的逆矩阵。 unity\_CameraWorldClipPlanes\[6\] float4 该相机的6个裁剪面在世界空间下的等式。

## UnityCG.cginc

包含了最常使用的帮助函数、宏、结构体等。 视角方向 float3 UnityWorldSpaceViewDir(float3 worldPos) 输入一个世界空间中的顶点位置，返回世界空间中从该点到相机的观察方向。 在世界空间下，用相机位置减去顶点位置，没有被归一化。 float3 WorldSpaceViewDir(float4 v) 输入模型空间中的顶点位置，返回世界空间中从该点到相机的观察方向。 先将顶点从模型空间转换到世界空间，再使用UnityWorldSpaceViewDir函数，没有被归一化。 float3 ObjSpaceViewDir(float4 v) 输入一个模型空间中的顶点位置，返回模型空间中从该点到相机的观察方向。 将相机位置转换到模型空间，再减去顶点位置。没有被归一化。 光源方向 仅可用于ForwardBase/ForwardAdd。 float3 UnityWorldSpaceLightDir(float3 worldPos) 输入一个世界空间中的顶点位置，返回世界空间中从该点到光源的光照方向。 在世界空间下，用光源位置减去顶点位置。没有被归一化。 float3 WorldSpaceLightDir(float4 v) 输入一个模型空间中的顶点位置，返回世界空间中从该点到光源的光照方向。 先将顶点位置从模型空间转换到世界空间，再使用UnityWorldSpaceLightDir函数。没有被归一化。 float3 ObjSpaceLightDir(float4 v) 输入一个模型空间中的顶点位置，返回模型空间中从该点到光源的光照方向。 将光源的位置从世界空间转换到模型空间，再减去减去顶点位置。没有被归一化。 空间转换 float3 UnityObjectToWorldNormal(float3 norm) 把法线方向从模型空间转换到世界空间中。 判断模型是否统一缩放，非统一缩放时使用**逆转置矩阵**。已归一化。 float3 UnityObjectToWorldDir(float3 dir) 把方向矢量从模型空间转换到世界空间中。 使用unity\_ObjectToWorld函数的3x3简化版本。已归一化。 float3 UnityWorldToObjectDir(float3 dir) 把方向矢量从世界空间转换到模型空间中。 使用unity\_WorldToObject矩阵的3x3简化版本。已归一化。 TANGENT\_SPACE\_ROTATION; 这个宏相当于以下代码，需要提前定义好法线和切线，矩阵rotation可将矢量从模型空间转换到切线空间。 float3 binormal = cross( normalize(v.normal), normalize(v.tangent.xyz) ) \* v.tangent.w; float3x3 rotation = float3x3( v.tangent.xyz, binormal, v.normal ) UnityObjectToClipPos(v.vertex); 顶点着色器中，将顶点从模型空间转换到裁剪空间，用于实现顶点着色器的基础任务。 功能函数/宏 float4 ComputeScreenPos(float4 pos) 输入：裁剪空间中的顶点坐标，4元数，o.screenPos = ComputeScreenPos(o.clipPos);。 输出：x分量等于clipx/2+clipw/2；y分量等于clipy/2+clipw/2；z分量等于clipz；w分量等于clipw。 xy分量相当于对裁剪空间中的顶点转换到视口空间，但是没有除以w分量。 当ComputeScreenPos的输出结果作为vertex函数的输出时，参与了三角形遍历过程中的差值处理。 需要在fragment函数中除以w分量，float4 screenPos = in.screenPos / in.screenPos.w。 处理后，xy分量相当于(clip/2+0.5) 左下角为(0,0) 左上角为(1,1)，可用于采样屏幕贴图。 float2 TRANSFORM\_TEX(v.texcoord,\_Maintex) 顶点着色器中用于得到偏移后的UV坐标。参数为第一套UV坐标和贴图纹理，返回经过了缩放和平移后的UV坐标。 内部计算：v.texcoord.xy \* \_MainTex\_ST.xy + \_MainTex\_ST.zw; 变换后xy值可能超出\[0,1\]，Repeat平铺模式，超出1的部分会无限重复；Clamp平铺模式则保持边缘值。 fixed4 tex2D(\_NormalMap,i.uv); 片元着色器中对贴图采样，输入2D纹理贴图和UV坐标，得到指定位置的rgba值。 当UV值超出\[0,1\]时根据平铺模式返回值。使用Clamp平铺模式可解决Repeat平铺模式的边缘杂色。 对切线空间下的法线贴图的采样：需要将\[-1,1\]范围的值转化到\[0,1\]；转化过程：y=x/2+0.5 对渐变纹理的采样：采样用的UV参数可以使用想要影响的颜色的系数，如通过光照角度实现渐变的反照率。 对遮罩纹理的采样：使用和纹理贴图一样的UV，实现像素级别的控制想要影响的颜色的系数。 fixed3 UnpackNormal(float4 packednormal) 法线纹理解压，当纹理贴图的导入设置中Texture Type被标记为Normal map时，Unity对贴图进行压缩。 压缩过程中只保留了rgba其中两个通道的值，我们无需关心Unity针对哪个平台使用了那种压缩方式。 normal.xy = packednormal.wy \* 2 - 1;normal.z = sqrt(1 - saturate(dot(normal.xy, normal.xy))); 输入采样得到的float4值，得到解压后的rgb值，是一个单位向量。 当法线值为(0,0,1)时，表示平滑表面，可以通过缩放xy分量来增强法线的倾斜效果。 float3 Shade4PointLights(unity\_4LightPosX0, unity\_4LightPosY0, unity\_4LightPosZ0,unity\_LightColor\[0\].rgb, unity\_LightColor\[1\].rgb, unity\_LightColor\[2\].rgb, unity\_LightColor\[3\].rgb, unity\_4LightAtten0, o.worldPos, o.worldNormal); ForwardBase的vertex函数中，一次性计算4个逐顶点光照颜色值。 half3 ShadeSH9 (float4(o.worldNormal, 1.0)) ForwardBase的vertex函数中，一次计算所有SH光源的光照颜色值，包含环境光。

## Lighting.cginc

包含了各种内置的光照模型。 \_LightColor0 该Pass处理的逐像素光源的颜色，用于向前渲染。 USING\_DIRECTIONAL\_LIGHT keyword，判定光源类型是否为平行光。

## AutoLight.cginc

\_LightMatrix0;unity\_WorldToLight float4X4，从世界空间到光源空间的变换矩阵。可用于采样cookie和光强衰减纹理。 使用unity\_WorldToLight替代\_LightMatrix0；光源空间中，光源位置(0,0,0)，光边缘处LightCoord模为1。 \_LightTexture0;\_LightTextureB0 \_LightTexture0为点光源的衰减纹理，\_LightTextureB0为聚光灯的衰减纹理。 POINT;SPOT;POINT\_COOKIE;DIRECTIONAL\_COOKIE 光源模式定义，通过判断keyword正确执行衰减纹理采样。 ForwardAdd中进行光源空间中的光强衰减采样 #if defined (POINT) //如果是点光源 float3 lightCoord = mul(unity\_WorldToLight, float4(i.worldPos, 1)).xyz; fixed atten = tex2D(\_LightTexture0, dot(lightCoord, lightCoord).rr).UNITY\_ATTEN\_CHANNEL; #elif defined (SPOT) //如果是聚光灯，转换矩阵会不同，w分量代表同距离时不同角度处的光照衰减。 float4 lightCoord = mul(unity\_WorldToLight, float4(i.worldPos, 1)); fixed atten = (lightCoord.z > 0) \* tex2D(\_LightTexture0, lightCoord.xy / lightCoord.w + 0.5).w \* tex2D(\_LightTextureB0, dot(lightCoord, lightCoord).rr).UNITY\_ATTEN\_CHANNEL; #endif 聚光灯空间是一个三维空间，光源为(0,0,0)，+Z轴方向为聚光灯方向，受光影响的区域是一个圆锥+球形截面。 在距离光源距离为1的地方光衰减为0，即时在距离1范围内，根据角度不同也有衰减，可创建demo场景进行观察。 0<n<1，所有距离光源距离为n的点构成了一个球形截面，光源-点的矢量与+Z轴之间的夹角越大衰减越大，如下图： ![](https://img.acgmart.com/uploads/233b3a90-85dc-11e6-9e1b-7b1653b4313c.png) lightCoord.xy / lightCoord.w + 0.5的意义就是得到这个夹角，并进行采样。 SHADOW\_COORDS(a);TRANSFER\_SHADOW(o);fixed SHAOW\_ATTENUATION(i) 阴影三剑客，分别用于声明v2f成员(阴影采样uv)、计算uv偏移、采样阴影值。 LIGHTING\_COORDS(a,b);TRANSFER\_VERTEX\_TO\_FRAGMENT(o);fixed LIGHT\_ATTENUATION(i); 衰减三剑客，同时计算了阴影衰减和光照衰减。a和b是下一个可用的差值寄存器序列。 分别用于声明v2f成员(光照衰减采样uv、阴影采样uv)、计算uv偏移、采样阴影值。 UNITY\_LIGHT\_ATTENUATION(atten, i, i.worldPos); 配合阴影三剑客前2个宏，atten为阴影衰减x光照衰减，输入的世界坐标用于光照采样。 VERTEXLIGHT\_ON keyword，判断是否存在有效的顶点光照。

# 光照模型

漫反射颜色\=光源色\*漫反射系数\*反照率；**与观察方向无关**。 漫反射系数：代表物体对光的吸收/漫反射的性质，用rgb分量表示漫反射光的比率(强度)。 兰伯特漫反射反照率=光线方向·法线方向；矢量归一化→积→saturate；反射光线的强度与**表面法线和光源方向之间夹角的余玄值**成正比。 镜面反射颜色\=光源色\*高光系数\*镜面反射率；与观察方向有关 高光系数：对镜面反射颜色的rgb分量进行额外修正，不确定是否有科学依据。 Phong光照模型**镜面反射率**\=pow(saturate(反光方向·视角方向),平滑度) Blinn光照模型**镜面反射率**\=pow(saturate(法线方向·(光源方向+视角方向)),平滑度) 平滑度：这里平滑度值越高，得到的反光率越小，呈指数级别的变化，仅作为参考模型。 环境光\=全局环境光\*漫反射系数 模拟所有的间接光，在物体之间的夹角环境光变弱，也就是环境光遮蔽(AO)。 自发光：一般不会影响周围物体，仅作为一般颜色来源。 片元颜色\=自发光+环境光+漫反射颜色+镜面反射颜色 女神书第6章中提供的兰伯特模型与PBR中的镜面反射/光泽度工作流中有差别。 镜面反射/光泽度工作流 平滑度：灰度-线性，白色(1.0)表示光滑表面，黑色(0.0)表示粗糙表面。 能量守恒：光的总量是一定的，分别参与了漫反射和高光反射，导电性越高的物体参与漫反射的比率越低。 在PBR的Shader中，能量守恒由shader负责计算，这样参与漫反射比率低的金属可以反射更多的光。 半兰伯特模型 漫反射颜色=光源色\*漫反射系数\*半兰伯特系数 半兰伯特系数=(光线方向·法线方向)\*0.5+0.5；矢量先归一化 半兰伯特模型削减了漫反射颜色的变化率，使非光源正面区域也有一定亮度