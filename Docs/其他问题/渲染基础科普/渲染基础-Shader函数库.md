# 渲染基础 ShaderLibrary
shader语法和C++、C#等编程语言差不多，越是复杂的功能背后依赖的函数库就越多。  
shader底层是DXBC指令，DXBC更底层则是不同GPU对指令的实现。  
在Unity中对shader语法进行了一层包装，我们称之为ShaderLab语法。  
    不同渲染API的Shader有差异，如DX、Metal、Vulkan、OpenGL，而Unity是跨平台的。  
    我们能基于ShaderLab语法编写shader，根据DXBC指令进行算法优化。  
<img src="_res_shader_library/cover.png" alt="Shader含数据" width="50%" height="50%">  

## 参考资料 
1.[HLSL微软官方文档](https://docs.microsoft.com/en-us/windows/win32/direct3dhlsl/dx-graphics-hlsl "HLSL微软官方文档")  
2.[Unity SRP Github](https://github.com/Unity-Technologies/ScriptableRenderPipeline "Unity SRP Github")  

# HLSL语法
编写Unity shader时，可以使用CG或HLSL风格的语法，在Unity推出SRP后普遍流行HLSL语法。  
    两种语法差不多，代码定义包含在HLSLINCLUDE/ENDHLSL或CGINCLUDE/ENDCG内即可。  
HLSL语法与C++类似，比如加减乘除余、变量/函数声明、循环控制、输入/输出等，但是也有自己的特色。  

## 基本类型
shader中基本类型有bool、uint、float等，在移动端推荐使用半精度浮点数half；  
GPU侧的并行运算效率非常高，推荐使用多分量的变量进行计算，比如float2~float4。  
	可以使用xyzw或rgba访问分量  

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
if、for、while等C++风格的语法都可以使用，但是性能方面非常堪忧。

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

## Buffer
ConstantBuffer：光栅shader常用的buffer，存储逐材质、逐帧、全局等分类的变量。  
ComputeBuffer：ComputeShader个光栅shader都可以用的，可以传递指定长度的struct队列。  

## Sampler 采样器
shader中大量使用到了贴图采用，关于采样的细节原理参考“缓存命中率.md”。  
URP默认贴图声明：`TEXTURE2D(_MainTex); SAMPLER(sampler_MainTex);`  
    `float4 _MainTex_TexelSize; float4 _MainTex_HDR`  
采样器中包含wrapping和filtering设置，有数量上限，同类型的贴图可以复用采样器。  
    比如多层采样的地形shader服用Layer1的采样器。  

简写模式：`sampler2D _MainTex;` //这个声明方式自带采样器  
自定义采样器：`SAMPLER(sampler_Linear_Clamp);` //可使用字符串拼接的方式声明采样器  

采样语法： 
`half4 value = _Ramp.Sample(sampler_Ramp, float2(intensity, 0));`  
`half4 value = tex2D(_Ramp, uv.xy);`  //使用自带采样器  
`half4 value = SAMPLE_TEXTURE2D(_Ramp, Sampler, uv.xy);`  

## 内置函数 

### 类型转换
asdouble(x, y) ：将2个uint Vector转换为1个double Vector，分量数不变。  
asfloat(x) ：将1个任意Vector转换为float Vector。 
asint ：将1个任意Vector转换为int Vector。  
asuint ：将1个任意Vector转换为uint Vector。   
f16tof32(x) ：返回x(被保存为unit的16位浮点数)的32位浮点数表达形式。 
f32tof16(x) ：返回x(32位浮点数)的16位浮点数表达形式(被保存为unit)。 

### 浮点数操作
floor(x) ：如果x有小数部分，返回比x小的最大整数，floor(-2.3) = -3。 
ceil(x) ：如果x有小数部分，返回比x大的最小的整数。  
trunc(x) ：逐分量去除小数部分，trunc(-2.3)= -2。  
abs(x) ：返回逐分量的绝对值，abs(-1)为1。   
clamp(x, min, max) ：将X的值限制在min和max之间。  
    if(x < min) retrun min;  
    if(x > max) retrun max;  
    else retrun x;  
saturate(a) ：等效于clamp(x, 0, 1) 
fmod(x, y) ：取余，返回x/y的小数部分。  
frac(x) ：返回x的小数部分。 
round(x) ：逐分量四舍五入。  
max(x, y) ：返回逐分量最大值。  
min(x, y) ：返回逐分量最小值。  
sign(x) ：相当于if(x<0) return -1;if(x>0) return 1; return 0;。 

### 三角函数
弧度乘以57.29578转换为角度。  
如果需要将角度转化为弧度，那么就是乘以0.0174532924。  

sin(x) ：返回x(弧度)的正玄值。 
cos(x) ：返回x(弧度)的余玄值。 
tan(x) ：逐分量返回x(弧度)的正切值。  
degree(x) ：将x(弧度)转化为角度。 
radians(x) ：将角度x转换为弧度。  
sincos(x, s, c) ：void，将x(弧度)的sin值和cos值分别赋值到s和c。 

asin(x) ：返回逐分量(在-1至1范围内)的反正玄值(弧度)。 
acos(x) ：返回逐分量(在-1至1范围内)的反余玄值(弧度)。  
atan(x) ：返回逐分量的反正切值(弧度)。
atan2(y, x) ：返回向量(x, y)与X轴的反正切值(弧度)。
    由于x和y可以表达坐标所处在的象限，计算的结果比atan更稳定。

sinh(x) ：双曲线正玄函数。 
cosh(x) ：[双曲线余玄函数](http://tushuo.jk51.com/tushuo/4461003.html "双曲线余玄函数")。 
tanh(x) ：双曲线正切函数。 

### 逻辑运算
all(x) ：如果x的所有分量都不为0，返回true；否则返回false。  
any(x) ：如果x的任一分量不为0，返回true；否则返回false。 
countbits(x) ：返回逐分量(uint类型)的二进制格式中1的位数。   
firstbithigh(x) ：返回逐分量(int或uint)的二进制格式中从高位数第一个1的位置。 
firstbitlow(x) ：返回逐分量(uint)的二进制格式中从低位数第一个1的位置。 
step(a, b) ：等效于(b >= a) ? 1 : 0 

### 特殊功能
clip(x) ：如果x的任意分量小于0，则忽略当前片元；也就是透明度测试alphatest。 
isfinite(x) ：逐分量判断浮点数的值是否为finite(有限的)。 
isinf(x) ：逐分量判断浮点数的值是否为infinite(无限的)。 
isnan(x) ：逐分量判断浮点数的值是否为NAN或QNAN。 

### 指数级别函数
exp(x) ：返回以自然数e(2.71828)为底数，x为指数的值。 
exp2(x) ：返回以2为底数，x为指数的值。 
log(x) ：求对数，返回以e为底数，x为值时对应的指数。 
log2(x) ：求对数，返回以2位底数，x为值时对应的指数。 
log10(x) ：求对数，返回以10为底数，x为值时对应的指数。 
pow(x, y) ：幂运算，x为底数，y为指数，等价于exp(log(x) * y)。 

### 常规函数
rcp(x) ：逐分量返回近似倒数。  
distance(x, y) ：返回x和y(Vector)之间的距离，√((xa-xb)² + (ya-yb)²)。  
length(x) ：返回x(Vector)的长度。  
dot(x, y) ：返回x和y(Vector)的点积，xa * xb + ya * yb。  
mad(a, x, y) ：返回a * x + y，执行速度快。  
fma(a, x, y) ：相比mad运算精度更高。  
lerp(x, y, a) ：等效于x + a(y-x)。  
noise(x) ：Perlin噪声函数，返回值在-1至1内。 
normalize(x) ：归一化x(Vector)。 
reflect(input, normal) ：求反射方向, input为入射方向，返回input - 2 \* normal \* dot(input, normal)。 
refract(input, normal, 折射率) ：求折射方向。 
rsqrt(x) ：逐分量平方根的倒数。
smoothstep(x, y, a) ：类似于clamp(a, x, y)，做曲线映射, x * x * (3 - 2 * x)。   
sqrt(x) ：逐分量返回x的平方根。 

### 矩阵操作
mul(x, y) ：矩阵相乘；矢量在右边时，被竖排序；矢量在左边时，被横排序。 
transpose(x) :返回x(矩阵)的转置矩阵(将行列互换)。
cross(x, y) ：返回x和y(参数为多组件Vector类型)的叉积。 

### 采样
tex2D(sampler, uv) ：默认采样语法，仅用于片元shader。  
    底层会基于uv的ddx和ddy推导mip等级，实现双线性/三线性过滤。  
    因为在顶点Shader阶段没有生成片元，无法产生ddx和ddy，不能用于顶点Shader。   
tex2D(sampler, uv, ddx, ddy) ：使用指定的偏导数替代uv的偏导数  
tex2Dlod(sampler, uv) ：相比tex2D，在uv.w中指定mip等级。  
    在只需要特定mip时tex2Dlod无需计算mip性能更优。
    在3D场景贴图采样时tex2D自动计算mip纹理缓存命中率更高。  
tex2Dbias(sampler, uv) ：相比tex2D，在uv.w中指定mip等级偏移。  
tex2Dproj(sampler, uv) ：相比tex2D，uv是屏幕UV需要除以w分量：uv.xy / uv.w 
tex2Dgrad(sampler, uv, ddx, ddy) ：同tex2D(sampler, uv, ddx, ddy)    
Load(int3(unCoord2, lod)) ：加载指定像素坐标、指定mip的像素，无过滤。  
Gather(sampler, coord2) ：加载指定像素坐标的像素，不支持mip，有过滤。  
    支持采样单通道：GatherRed/GatherGreen/GatherBlue/GatherAlpha  

### 异步指令  
GroupMemoryBarrierWithGroupSync() ：异步读写时，等待group内线程逻辑执行到此调用。 
ddx(x)：范围Vector x的[偏导数](https://blog.csdn.net/wylionheart/article/details/78026707 "偏导数")。   
ddx_coarse(x) ：返回Vector x的低精度偏导数。  
ddx_fine(x) ：返回Vector x的高精度偏导数。  
ddy(y)/ddy_coarse/ddy_fine ：参考ddx。  
fwidth(x) ：返回abs(ddx(x)) + abs(ddy(x))。  


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