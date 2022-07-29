# UNITY_UV_STARTS_AT_TOP
这个宏用于标记当前平台的坐标系风格   
1.DX风格的UV空间：左上角为0 向下递增  
　　应用于Direct3D、Metal、consoles等  
2.GL风格的UV空间：左下角为0 向上递增  
　　应用于OpenGL和OpenGLES等  
Unity为了实现GL风格的**采样**在DX平台上下翻转了贴图  
https://docs.unity3d.com/Manual/SL-PlatformDifferences.html

需要关注的是 在特殊情况下贴图并没有翻转：  
MSAA resolve出来的RT没有翻转 作为中间RT用于后处理时需要手动翻转UV  
　　使用Blit命令实现简单后处理时可顺带解决_MainTex的翻转问题  
手动翻转：
```
//xxx_TexelSize：1/width, 1/ height, width, height
o.uv0.xy = v.uv;    //MainTex的uv
o.uv0.zw = v.uv;    //非MainTex的uv
#if UNITY_UV_STARTS_AT_TOP
if (_MainTex_TexelSize.y < 0) //开启MSAA后 xxx_TexelSize.y 会变成负值
    o.uv0.w = 1.0 - o.uv0.w; //采样非MainTex(如深度图)时需要手动翻转Y轴
#endif
```

# ProjectionParams.x
在DX平台 渲染目标是中间RT需要翻转Y轴 渲染到backBuffer则不需要  
对应URP代码：context.SetupCameraProperties(camera)  
ProjectionParams由底层赋值 每个相机单帧任务开始时赋值一次  
ProjectionParams.x：值为1或-1  
　　-1表示P矩阵已经将Y轴实现了上下翻转  
　　也可以自行声明覆盖掉SetupCameraProperties设置的值  

# ComputeScreenPos
这个方法用于在frag中获取片元的屏幕UV  
```
float4 ComputeScreenPos(float4 positionCS)
{
    float4 o = positionCS * 0.5f;
    o.xy = float2(o.x, o.y * _ProjectionParams.x) + o.w;
    o.zw = positionCS.zw;
    return o;
	//x分量 = pos.w * (pos.x / pos.w + 1) * 0.5
	//在NDC空间中 将x从-1至1范围映射到0至1范围
	//y分量类似 没翻转就映射到0至1 翻转了就映射到1至0
}

//vert
o.screenUV = ComputeScreenPos(v.positionCS);
//frag
half2 screenUV = IN.screenUV.xy / IN.screenUV.w;
```

# UNITY_REVERSED_Z
部分新API开启了Z反转 并提高了depthBuffer的浮点精度为32-bit  
开启了Z翻转的平台：DX11|DX12|PS4|Xbox One|Metal  
Z反转平台depthBuffer范围：1(近平面)至0(far)  
Z反转平台clipSpaceZ范围：near值0  
传统平台depthBufffer范围：0值1  
~~传统DX风格平台clipSpaceZ范围：0至far~~  
传统GL风格平台cliPSpaceZ范围：-near至far  
也就是说P矩阵在Z轴范围方面目前有4个版本  
　　DXorGL？	Z是否翻转？  
实际上URP只有2个版本 可全局搜索UNITY_NEAR_CLIP_VALUE  
	DX风格的平台全部都翻转了 DX9直接不被支持了  
	GL风格的平台全部都没有翻转  
	UNITY_REVERSED_Z和UNITY_UV_STARTS_AT_TOP等效  
GL风格平台齐次去除(NDC)后Z范围：-1至1  
DX风格平台在翻转Z后再齐次去除后Z范围：1至0  

```
//手动访问depthBuffer
float depth = SAMPLE_DEPTH_TEXTURE(_CameraDepthTexture, sampler_PointClamp, input.uv);
#if defined(UNITY_REVERSED_Z)
    z = 1.0f - z;
#endif

real ComputeFogFactor(float zPositionCS)
{
    float clipZ_0Far = UNITY_Z_0_FAR_FROM_CLIPSPACE(zPositionCS);
    return ComputeFogFactorZ0ToFar(clipZ_0Far);
}

//手动访问clipSpaceZ
o.fogFactor = ComputeFogFactor(o.positionCS.z);

//depthBuffer值转换到观察空间0(Camera位置)至1(far)
//不能用于正交相机、倾斜的透视相机
//DX风格 | zBufferParam = { (f-n)/n, 1, (f-n)/n*f, 1/f }
float Linear01Depth(float depth, float4 zBufferParam)
{
    return 1.0 / (zBufferParam.x * depth + zBufferParam.y);
}

//depthBuffer值转换到观察空间线性深度
float LinearEyeDepth(float depth, float4 zBufferParam)
{
	//depth为采样depthBuffer得到的原始值 1-0
	//1：1 / ((f - n + n) / nf) = n
	//0：1 / (zBufferParam.z * 0 + zBufferParam.w) = f
    return 1.0 / (zBufferParam.z * depth + zBufferParam.w);
}
```

# UNITY_NEAR_CLIP_VALUE
NDC近平面值 在DX风格平台固定为1 GL风格平台固定为-1 
```
//ShadowCaster Pass阴影平坠：https://zhuanlan.zhihu.com/p/355814658
//  光源视椎体会尽量往前靠并刚好包括相机视椎体
//  此时会有一些物体不在相机视椎体内但是在光源视椎体近平面上方
//  这些物体必然能在地面留下阴影 但是不能放在光源视椎体外被剔除
#if UNITY_REVERSED_Z
    output.positionCS.z = min(output.positionCS.z, output.positionCS.w * UNITY_NEAR_CLIP_VALUE);
#else
	output.positionCS.z = max(output.positionCS.z, output.positionCS.w * UNITY_NEAR_CLIP_VALUE);
#endif
```

# GL.GetGPUProjectionMatrix
使用camera.projectionMatrix获取的是GL风格的P矩阵
　　如果当前平台是DX风格则需要调整NDC空间Z的范围  
　　如果当前平台是DX风格且渲染到RT则需要反转Y轴  
为了能获得正确的P矩阵可使用GL.GetGPUProjectionMatrix：  
```
public Matrix4x4 GetGPUProjectionMatrix(Matrix4x4 proj)
{
	//proj：来自于camera.projectionMatrix GL风格的P矩阵
	//renderIntoTexture：除了提交到backBuffer其余都是true
	return GL.GetGPUProjectionMatrix(proj, true);
}
```

# 浮点精度
PC平台所有的浮点类型都使用32-bit精度(float|half|fixed)  
移动平台则区分对待不同精度  

# const声明
GL风格的const为编译时常数
DX风格的const为read-only 可被自定义初始化  
建议使用GL风格的const避免出现混淆  

# unity_WorldToCamera和unity_matrixV
https://docs.unity3d.com/ScriptReference/Camera-worldToCameraMatrix.html  
camera.worldToCameraMatrix => unity_matrixV => -Z轴为观察方向  
　　URP的TransformWorldToViewDir方法中使用的是unity_matrixV  
unity_WorldToCamera已经停用了 仅用于兼容老shader => Z轴为观察方向  