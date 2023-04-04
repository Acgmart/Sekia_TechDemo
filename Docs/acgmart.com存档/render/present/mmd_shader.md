---
title: MMD shader
categories:
- [渲染, 效果表现]
date: 2020-07-01 07:33:04
---

\[toc\]本篇内容主要为解析MMD4Mecanim插件中的shader。 工程中使用了RemMiku，测试用的Unity版本为2018.3.9和2019.1.0b10。 MMD4Mecanim使用的2018/05/23版本，Unity加载后会为每个材质生成MMD材质编号。

# 观察

PmxEditor中、Unity中分别观察Miku，可以发现一些不同来。 这些不同有可能是Unity的锅，也有可能是shader的锅。 不同一： 21号材质Fronthair+表现的头发很死板，高光区域非常小。 ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/render/present/019.png) 在PmxEditor中观察，这块区域由2个材质20.Fronthair和21.Fronthair+控制。 ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/render/present/020.png) 显示顶点后可以发现这2个材质的顶点位置完全相同，但分别使用的不同顶点。 21.Fronthair+只有头发高光采样，高光区域有发色的渐变效果。 20.Fronthair就是普通的前发了。 而在Unity中，重叠着色的两个片元是竞争关系，ZTest默认值LEqual。 所以，应该要为这些重叠的片元做混合。另外高光区域则是Cubemap生成的问题。 21.Fronthair+应该使用透明shader，这样可以在20.Fronthair之后渲染。 如果这个问题很难解决，可以尝试隐藏掉21.Fronthair+的顶点，这需要一个空shader。 空shader 效果可以是剔除掉所有的片元，这样就什么都不会显示，也不干扰其他材质的片元。

```
Shader "Sekia/Clip"
{
    Subshader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            struct a2v
            {
                float4 vertex:POSITION;
            };
            struct v2f
            {
                float4 pos : SV_POSITION;
            };

            v2f vert(a2v v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                return o;
            }

            half4 frag(v2f i) : SV_TARGET
            {
                clip(-1);
                return half4(0,0,0,0);
            }

            ENDCG
        }
    }
}
```

测试：对Cube创建新材质应用，Cube完全被隐藏。 将21.Fronthair+更换Shader为Sekia/Clip，Miku的前发显示变得正常点了。 ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/render/present/021.png) 不同二： PmxEditor中是没有阴影的，不能设置光照，但是模型也很亮。 Unity中，删除默认的平行光后Miku昏暗无光，显然是要参与严格的光照计算。 ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/render/present/022.png) 在PmxEditor中观察刘海阴影，可以发现这只是模拟阴影的一层灰色面片。 29.hairshadow也需要在Unity换空shader，这样MMD shader就会使用前发的实时阴影。 到这里，前发这个部位基本没问题了。 模型如果要和PmxEditor中亮度一样，需要将环境光设置的更亮一点。 不同三 20.Fronthair的shader为MMDLit-Edge，描边表现出明显的锯齿。 而PmxEditor中只有侧面观察头发时才会有明显描边，描边上PmxEditor表现的更棒。

# MMDLit-ForwardBase

这里先参考MMDlit中的ForwardBase Pass，遇到其他不同类型的ForwardBass时再做比较。 CGPROGRAM内的指令有：

```
CGPROGRAM
#pragma target 2.0 //指定Shader Model
#pragma exclude_renderers flash //排除指定平台
#pragma vertex vert_surf //指定函数
#pragma fragment frag_fast //指定函数
#pragma fragmentoption ARB_precision_hint_fastest //过期指令
#pragma multi_compile_fwdbase nolightmap nodirlightmap //前向渲染指令
#pragma multi_compile _ SPECULAR_ON
#pragma multi_compile _ EMISSIVE_ON
#pragma multi_compile _ SPHEREMAP_MUL SPHEREMAP_ADD
#pragma multi_compile _ SELFSHADOW_ON
#pragma multi_compile _ AMB2DIFF_ON
#include "MMD4Mecanim-MMDLit-Surface-ForwardBase.cginc"
ENDCG
```

Shader Model指定为2.0，也就是低端的硬件水平，支持所有的移动平台；默认值是2.5。 exclude\_renderers命令可以用于排除指定平台，但是flash并不是一个可选平台，参考Unity手册。 vertex/fragment 这里只是指定了两个着色器阶段使用的函数，按照习惯的话我会命名为vert/frag。 fragmentoption 过期指令，Unity手册中指明可以安全删除。 multi\_compile\_fwdbase 获取前向渲染必要的光照变量支持，顺便排除不需要的关键字。 multi\_compile 自定义关键字，控制代码分支。关键字除了运行时设置，还可以有初始值。 找到任意材质，使用Notepad++打开.mat文件或者在属性面板右上角进入debug模式查看关键字。 这些关键字对应PmxEditor中材质的属性，例如20.Fronthair是不透明+描边+自影+地面影+加算高光。 include 包含文件，和把里面的内容复制粘贴过来等效，只有vertex/fragment着色器相关的内容才生效。 也就是说，很多命令在现在看来是过期的，可以安全删除。 MMD4Mecanim-MMDLit-Surface-ForwardBase.cginc .shader文件中将代码细节隐藏在了.cginc文件，从这里开始需要寻找指定的内容，下面列出的代码粗略看下即可。 vert\_surf

```
v2f_surf vert_surf(appdata_full v)
{
    v2f_surf o;
    o.pos = _UnityObjectToClipPos(v.vertex);
    o.pack0.xy = v.texcoord.xy;
    float3 worldN = mul((float3x3)_UNITY_OBJECT_TO_WORLD, SCALED_NORMAL);
    o.normal = worldN;

    #ifdef SPHEREMAP_ON
    float4x4 matMV = MMDLit_GetMatrixMV();
    half3 norm = normalize(mul((float3x3)matMV, v.normal));
    half3 eye = normalize(mul(matMV, v.vertex).xyz);
    o.mmd_uvwSphere = reflect(eye, norm);
    #endif

    o.viewDir = (half3)WorldSpaceViewDir(v.vertex);

    o.vlight = ShadeSH9(float4(worldN, 1.0));
    o.mmd_globalAmbient = o.vlight;
    #ifdef VERTEXLIGHT_ON
    float3 worldPos = mul(_UNITY_OBJECT_TO_WORLD, v.vertex).xyz;
    o.vlight += Shade4PointLights(
        unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0,
        unity_LightColor[0].rgb, unity_LightColor[1].rgb, unity_LightColor[2].rgb, unity_LightColor[3].rgb,
        unity_4LightAtten0, worldPos, worldN );
    #endif // VERTEXLIGHT_ON
    // Feedback Ambient.
    o.vlight *= MMDLit_GetAmbientRate();

    TRANSFER_VERTEX_TO_FRAGMENT(o);
    return o;
}
```

从这里开始就要表现出耐心了，关联的文件很多，查找引用变得很繁琐。 appdata\_full UnityCG.cginc中的最全结构体。 v2f\_surf 自定义的v2f结构体。

```
struct v2f_surf {
    float4 pos : SV_POSITION;
    float2 pack0 : TEXCOORD0; //第一套UV
    half3 normal : TEXCOORD1;
    half3 vlight : TEXCOORD2;
    half3 viewDir : TEXCOORD3;
    LIGHTING_COORDS(4,5)
    half3 mmd_globalAmbient : TEXCOORD6;
    #ifdef SPHEREMAP_ON
    half3 mmd_uvwSphere : TEXCOORD7;
    #endif
};
```

o.pack0.xy = v.texcoord.xy; 填充v2f结构中的代表第一套UV的pack0。 float3 worldN = mul((float3x3)\_UNITY\_OBJECT\_TO\_WORLD, SCALED\_NORMAL); 这段代码就非常有历史气息了，SCALED\_NORMAL是Unity4.x年代的产物，那时候Unity帮开发者在CPU中处理非统一缩放，所以求世界空间下的法线方向就是这么暴力，如果换成Unity2018的写法就是： o.worldNormal = UnityObjectToWorldNormal(v.normal); 接下来的一段代码包含在SPHEREMAP\_ON的定义内，这个定义在MMD4Mecanim-MMDLit-Lighting.cginc可以找到。 要搜索到这样的定义当然不能手动一个个的找，这里推荐一个.bat脚本：

```
findstr /m "SPHEREMAP_ON" *.cginc >1.txt
```

将内容复制到新建的.txt文件，修改后缀为.bat格式，即可运行，全局搜索的结果会被保存在1.txt文件中。

```
#if defined(SPHEREMAP_MUL)  defined(SPHEREMAP_ADD)
#define SPHEREMAP_ON
#endif
```

解释：当开启SPHEREMAP\_MUL或SPHEREMAP\_ADD关键词时，SPHEREMAP\_ON的状态为defined。 可以通过Frame Debugger判断当前已开启的关键词，而#ifdef判断则是multi\_compile的代码实现。 这里可以理解为，不论高光是乘算还是加算，开启了高光就需要计算这部分。自然界中的物体一般都会反光。

```
float4x4 matMV = MMDLit_GetMatrixMV();
half3 norm = normalize(mul((float3x3)matMV, v.normal));
half3 eye = normalize(mul(matMV, v.vertex).xyz);
o.mmd_uvwSphere = reflect(eye, norm);
```

float4x4 matMV = MMDLit\_GetMatrixMV(); MMDLit\_GetMatrixMV函数定义在MMD4Mecanim-MMDLit-Compatible.cginc中，将顶点从模型空间转换到观察空间。 norm和eye分别是观察空间下的法线方向和"相机→顶点"观察方向。eye作为入射方向求反射方向。 这个操作相当于对反射探针进行采样，而且这里的反射探针使用的Custom Cubemap，模拟了物体的反射现象。 o.viewDir = (half3)WorldSpaceViewDir(v.vertex); 继续填充v2f结构中的世界空间下的观察方向，一般我们把这个变量写作worldViewDir。 要注意的是观察空间的英文是View Space，别和View Dir搞混了，MV矩阵是Model Space到View Space。 o.vlight = ShadeSH9(float4(worldN, 1.0)); 这里计算出来的结果=所有SH光源+环境光。使用了实时GI和标准shader的物体能对周围产生环境光(漫反射)。 SH函数类似于Cubemap/Light Probe，从质心射出一条线必与球形空间相交于一点。 通过对球形空间的采样获得所有的间接光，具体SH函数的实现我并没有深究。 o.mmd\_globalAmbient = o.vlight; 将全局环境光照再单独保存一份，vlight用于更复杂的计算。 接下来是一段定义在VERTEXLIGHT\_ON之间的内容：

```
#ifdef VERTEXLIGHT_ON
    float3 worldPos = mul(_UNITY_OBJECT_TO_WORLD, v.vertex).xyz;
    o.vlight += Shade4PointLights(
        unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0,
        unity_LightColor[0].rgb, unity_LightColor[1].rgb, unity_LightColor[2].rgb, unity_LightColor[3].rgb,
        unity_4LightAtten0, worldPos, worldN );
    #endif // VERTEXLIGHT_ON
```

也就是标准的求前向渲染中4个点光源的方法，并将结果加算到vlight。 o.vlight \*= MMDLit\_GetAmbientRate(); MMDLit\_GetAmbientRate函数定义在MMD4Mecanim-MMDLit-Surface-Lighting.cginc： return half3(1.0, 1.0, 1.0) - MMDLit\_GetTempAmbientL(); 而MMDLit\_GetTempAmbientL函数的定义是： return max(MMDLIT\_CENTERAMBIENT - (half3)\_Ambient, half3(0,0,0)) \* MMDLIT\_CENTERAMBIENT\_INV; \_Ambient和其他参数也定义于MMD4Mecanim-MMDLit-Surface-Lighting.cginc，这里其代表Color类型的变量。 所以这段代码其实就相当于： o.vlight \*= saturate((half3)\_Ambient \* 2); 接着是TRANSFER\_VERTEX\_TO\_FRAGMENT(o);衰减三剑客登场，细节实现请参考更多资料。 return o;整个vertex着色器阶段到此就结束了，引用了一大堆的.cginc文件。 总的来说，到这里并没有什么特别的，函数的版本都很老，感觉写自Unity4.x年代，实现了前向渲染的基础光照计算。 frag\_fast

```
half4 frag_fast(v2f_surf IN) : MMDLIT_SV_TARGET
{
    half4 albedo = MMDLit_GetAlbedo(IN.pack0.xy);
    MMDLIT_CLIP_FAST(albedo.a)
    return frag_core(IN, albedo);
}
```

MMDLIT\_SV\_TARGET也就是SV\_Target； MMDLit\_GetAlbedo函数是对\_MainTex的Tex2D采样。 MMDLIT\_CLIP\_FAST定义于MMD4Mecanim-MMDLit-Lighting.cginc，有点特殊：

```
#if defined(SHADER_API_PSSL)  defined(SHADER_API_XBOXONE)  defined(SHADER_API_XBOX360)  defined(SHADER_API_PSP2)  defined(SHADER_API_WIIU)
#define _SHADER_API_CONSOLE
#endif

#ifdef _SHADER_API_CONSOLE
#define MMDLIT_CLIP(A_) clip((A_) - (1.0 / 255.0));
#define MMDLIT_CLIP_FAST(A_)
#else
half ___Eliminate; // Please observe terms of use. (Don't modify this code)
#define MMDLIT_CLIP(A_) clip((A_) * ___Eliminate - (1.0 / 255.0));
#define MMDLIT_CLIP_FAST(A_) MMDLIT_CLIP((A_))
#endif
```

前面用多个或条件定义了\_SHADER\_API\_CONSOLE，用于标识主机平台(PS/XBOX)。 显然我们在编辑环境下这些定义不会生效，跳到#else这里，声明了一个叫\_\_\_Eliminate的变量。 问题是我们并没有对\_\_\_Eliminate进行赋值，如果将其换个名字直接运行会报错。 其实是背后MMD4Mecanim插件的.dll在运行时为变量赋值、加载自定义属性栏等。 回到代码，这段代码其实就是执行一个clip操作，剔除掉a通道值过低的片元，影响可忽略。 return frag\_core(IN, albedo); 返回值是一个函数，将v2f结构和\_MainTex的采样结果带入即可，没有什么特别的。 frag\_core

```
inline half4 frag_core(in v2f_surf IN, half4 albedo)
{
    half atten = LIGHT_ATTENUATION(IN);
    half shadowAtten = SHADOW_ATTENUATION(IN);
    half3 c;

    half3 baseC;
    half NdotL = dot(IN.normal, _WorldSpaceLightPos0.xyz);
    c = MMDLit_Lighting(
        (half3)albedo,
        #ifdef SPHEREMAP_ON
        IN.mmd_uvwSphere,
        #else
        half3( 0.0, 0.0, 0.0 ),
        #endif
        NdotL,
        IN.normal,
        _WorldSpaceLightPos0.xyz,
        normalize(IN.viewDir),
        atten,
        shadowAtten,
        baseC,
        IN.mmd_globalAmbient);

    c += baseC * IN.vlight;

    return half4(c, albedo.a);
}
```

这里的inline关键词可省略，参考[微软HLSL语法](https://docs.microsoft.com/en-us/windows/desktop/direct3dhlsl/dx-graphics-hlsl-function-syntax)。 整个frag\_core函数的返回类型与fragment函数一致，其效果类似于简单的替换。 LIGHT\_ATTENUATION是衰减三剑客之一、SHADOW\_ATTENUATION是阴影三剑客之一。 也就是说阴影衰减被重复计算了一次，也就是对shadowmap重复采样了1次。 接下来是一个超级复杂的MMDLit\_Lighting函数，c/baseC/NodtL都是为其提供参数的。 NdotL：法线与光源方向的点积，必须归一化，表示光照方向。 这里的代码不严谨，vertex着色器传递给fragment着色器的参数会被强制插值，这个插值是线性的。 一个三角面片由三个顶点围成，三个顶点的法线方向不同，在线性插值过程中方向和长短均发生了变化。 fragment收到的法线数据代表片元所在区域的平均方向，需要被归一化。 而\_WorldSpaceLightPos0.xyz不能完全代表单位矢量，即使这里是平行光。 按照原来的公式计算会产生误差，这个误差有可能不大以至于难以发觉，应使用normalize处理。 再说回到NdotL，这个点积就是兰伯特漫反射的反照率albedo，用于计算diffuse光照部分。 自然界中的物体一般都有漫反射现象，纯金属将折射进入内部的光线都吸收了，所以其albedo为0。 MMDLit\_Lighting函数中进行了很多计算，不仔细看很难判断参数c和baseC所代表的意义。 MMDLit\_Lighting

```
inline half3 MMDLit_Lighting(half3 albedo,half3 uvw_Sphere,half NdotL,
    half3 normal,half3 lightDir,half3 viewDir,
    half atten,half shadowAtten,out half3 baseC,half3 globalAmbient)
{
    half3 ramp = MMDLit_GetRamp(NdotL, shadowAtten);
    half3 lightColor = (half3)_LightColor0 * MMDLIT_ATTEN(atten);

    half3 baseD;
    MMDLit_GetBaseColor(albedo, MMDLit_GetTempDiffuse(globalAmbient), uvw_Sphere, baseC, baseD);

    half3 c = baseD * lightColor * ramp;

    #ifdef SPECULAR_ON
    half refl = MMDLit_SpecularRefl(normal, lightDir, viewDir, _Shininess);
    c += (half3)_Specular * lightColor * refl;
    #endif

    #ifdef EMISSIVE_ON
    // AutoLuminous
    c += baseC * (half3)_Emissive;
    #endif
    return c;
}
```

看不出来代码写成这样的必要性，将最终颜色输出分为几个颜色构成分别进行计算会更好理解些。 这里代码风格很乱，为了集中注意力需要重点观察输出的c/baseC所代表的意义。 half3 c = baseD \* lightColor \* ramp; 这里c第一次被定义，baseD类似于固有色/漫反射系数，lightColor是光源色，ramp类似于反照率。 在具体计算细节没搞清楚的情况下，把c先看做是diffuse部分。 漫反射颜色=光源色\*漫反射系数\*反照率；c=diffuse half3 ramp = MMDLit\_GetRamp(NdotL, shadowAtten); 现在我们要考虑下ramp代表什么，以及与反照率的差别： MMDLit\_GetRamp

```
inline half3 MMDLit_GetRamp(half NdotL, half shadowAtten)
{
    half refl = saturate(min(MMDLit_GetToolRefl(NdotL), MMDLit_GetShadowAttenToToon(shadowAtten)));

    half toonRefl = refl;

    #ifdef SELFSHADOW_ON
    refl = 0;
    #endif

    half3 ramp = (half3)tex2D(_ToonTex, half2(refl, refl));

    #ifdef SELFSHADOW_ON
    half toonShadow = MMDLit_GetToonShadow(toonRefl);
    ramp = lerp(ramp, half3(1.0, 1.0, 1.0), toonShadow);
    #endif

    ramp = saturate(1.0 - (1.0 - ramp) * _ShadowLum);
    return ramp;
}
```

注意这里有个临时参数refl，在别的函数里可能会有同名的临时参数。 可以发现refl被用于对\_ToonTex采样；如果开启了自影，refl=0，采样结果的rgb分量最低。 会开启自影的部位如：皮肤、头发、头发，相对来说都是身体上色调单一的大件。 开启自影后，身体的其他部位遮住光线时，在阴影部位乘算toon采样值就能模拟阴影效果。 接着回过头来继续看代码：

```
half refl = saturate(min(MMDLit_GetToolRefl(NdotL), MMDLit_GetShadowAttenToToon(shadowAtten)));
```

NdotL表示反照率albedo，对漫反射部分生效，diffuse = lightcolor \* diffusecolor \* albedo。 shadowAtten是阴影衰减atten，对漫反射和反射部分生效，(diffuse + specular) \* atten。 所以相当于同时计算了光正面和背光面两种情况，下面是具体分析： MMDLit\_GetToolRefl(NdotL) 其中NdotL是模，取值范围是-1~1，函数MMDLit\_GetToolRefl的默认效果是将值范围转移到0~1内。 MMDLit\_GetShadowAttenToToon(shadowAtten) shadowAtten也是Color，三个分量取值范围为0~1，MMDLit\_GetShadowAttenToToon的默认效果不会改变其范围。 其中\_ToonTone.y是针对直接光照的修正参数，\_ToonTone.x是针对阴影的修正参数，通常我们不会去调它。 在正面朝光非阴影处时，NdotL偏移后对应0.5~1之间的值，shadowAtten为1。 在正面朝光阴影处，NdotL偏移后对应0.5~1之间的值，shadowAtten接近于0。 在背朝光阴影处，NdotL偏移后对应0~0.5之间的值，shadowAtten接近于0。 shadowAtten的具体值取决于阴影采样，设置光源Shadow Type为Soft Shadows时边界区域会有从0→1的渐变： ![](https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/render/present/023.png) 如图示，水平方向表示平铺的片元，低洼开始处以下(纵轴)表示refl的值，阴影衰减接近1时会被更小值取代。 综合来看，min操作的返回值为：非阴影处为Ndot偏移后的结果，阴影处为shadowAtten。 本部分计算的意义是获得diffuse光照的衰减值。 因为函数中使用了关键词SELFSHADOW\_ON，对应两种情况： 非自影物体，如头饰、眼白、马尾等区域，通常不会被过于关注，很可能没有专门的toon贴图。 这里以马尾(22.Tail)为例，使用代表衰减的refl参数进行采样得到ramp。 ramp = saturate(1.0 - (1.0 - ramp) \* \_ShadowLum); \_ShadowLum为范围在0~10之间的浮点数，默认值1.5；公式构成了一个一元一次方程对ramp进行修正。 自影物体，身体上大部分部位都满足此条件。 half3 ramp = (half3)tex2D(\_ToonTex, half2(0, 0)); toon贴图是jpg，从左下角(0,0)有颜色到右上角(1,1)颜色逐渐变白，这里采样得到最大的衰减效果。 half toonShadow = MMDLit\_GetToonShadow(toonRefl); ramp = lerp(ramp, half3(1.0, 1.0, 1.0), toonShadow); MMDLit\_GetToonShadow函数对衰减率的处理： half toonShadow = toonRefl \* 2.0; return (half)saturate(toonShadow \* toonShadow - 1.0); 相当于平方后乘以4减去1后saturate，衰减值为0.5~1时结果为0~1；用此值去插值ramp。 这样的操作会导致diffuse非线性的衰减，在ramp为0→0.7左右时结果加速递增。 本部分计算的意义是对diffuse衰减值的重新分布。 返回到MMDLit\_Lighting函数，继续看代码，现在我们知道了ramp参数代表diffuse衰减值。 half3 lightColor = (half3)\_LightColor0 \* MMDLIT\_ATTEN(atten); \_LightColor0是前向渲染路径提供的当前Pass所处理的光源色；MMDLIT\_ATTEN(atten)等效于atten。 lightColor的值为：光源色x光照衰减x阴影衰减，对于平行光光照衰减为1，光照被遮挡时阴影衰减为0。 接着是baseD参数，通过MMDLit\_GetBaseColor被赋值。 其中第二个参数tempDiffuse的值为MMDLit\_GetTempDiffuse(globalAmbient)

```
inline half3 MMDLit_GetTempDiffuse( half3 globalAmbient )
{
    half3 tempColor = min((half3)_Ambient + (half3)_Color * MMDLIT_GLOBALLIGHTING, half3(1,1,1));
    tempColor = max(tempColor - MMDLit_GetTempAmbient(globalAmbient), half3(0,0,0));
    #ifdef AMB2DIFF_ON // Passed in Forward Add
    tempColor *= min(globalAmbient * _AmbientToDiffuse, half3(1,1,1)); // Feedback ambient for Unity5.
    #endif
    return tempColor;
}
```

globalAmbient也就是v2f结构中保存的SH光照，\_Color是材质面板中的Diffuse色。 half3 tempColor = min((half3)\_Ambient + (half3)\_Color \* 0.6, half3(1,1,1)); 用环境色和Diffuse色计算得到tempColor，Diffuse默认为(1,1,1)，tempColor默认值为(1,1,1)。 MMD的模型很少会去设置扩散色、反射色、环境色等参数，所以通常这些值都会保持默认值。 AMB2DIFF\_ON关键字对应着PmxEditor中的"扩散-环境同期"特性，也是通常不会用到的关键词。 tempColor = max(tempColor - MMDLit\_GetTempAmbient(globalAmbient), half3(0,0,0)); MMDLit\_GetTempAmbient函数中的MMDLit\_GetAmbientRate函数我们在vertex着色器中遇到过，其相当于： globalAmbient \* saturate((half3)\_Ambient \* 2) Ambient为0.5，Diffuse为1时：tempColor = 1-globalAmbient Ambient为0.5，Diffuse值在0.83~1之间时完全不影响光照结果；Diffuse过小时物体变暗。 Ambient为0时，Diffuse为1时：tempColor=0.6；物体此时变得很暗。 结论：tempColor同时受Ambient和Diffuse的非等比例相加因素影响。 再回到函数MMDLit\_GetBaseColor函数。

```
inline void MMDLit_GetBaseColor(
    half3 albedo,half3 tempDiffuse,half3 uvw_Sphere,
    out half3 baseC,out half3 baseD)
{
    #ifdef SPHEREMAP_MUL
    half3 sph = (half3)texCUBE(_SphereCube, uvw_Sphere);
    baseC = albedo * sph;
    baseD = baseC * tempDiffuse; // for Diffuse only.
    #elif SPHEREMAP_ADD
    half3 sph = (half3)texCUBE(_SphereCube, uvw_Sphere);
    baseC = albedo + sph;
    baseD = albedo * tempDiffuse + sph; // for Diffuse only.
    #else
    baseC = albedo;
    baseD = albedo * tempDiffuse;
    #endif
}
```

按照前面的代码分析理解来看，这里baseD应该代表固有色的概念。 函数内部被SPHEREMAP相关的定义分成了三块，不同的反光模式使用的输出。 SPHEREMAP\_MUL：乘算高光 这里的baseC是fragment函数中传递过来的空值，用于作为次要光照的系数。 baseC = albedo \* sph; 使次要光照同时受到采样色和高光采样的衰减。 baseD = baseC \* tempDiffuse; 固有色=贴图采样色·tempDiffuse·高光采样色。 SPHEREMAP\_ADD：加算高光 baseC = albedo + sph; 次要光照受贴图采样色和高光采样色的叠加影响。 baseD = albedo \* tempDiffuse + sph; 固有色=贴图采样色·tempDiffuse+高光采样色； 高光效果分析： 两种高光模式对应的Cubemap不同； 乘算用的少，比如在头发上印出指定形状的高光； 加算可以模拟出各向异性类似的反光效果； 继续回到MMDLit\_Lighting部分的后续代码： half3 c = baseD \* lightColor \* ramp; 这里的c不仅是diffuse，也包含了高光采样的结果。 接下来是SPECULAR\_ON定义的区域：

```
#ifdef SPECULAR_ON
half refl = MMDLit_SpecularRefl(normal, lightDir, viewDir, _Shininess);
c += (half3)_Specular * lightColor * refl;
#endif
```

SPECULAR就是高光呀，和前面的SPHEREMAP的高光有什么区别呢？ 而且，作为关键词SPECULAR在PmxEditor中对应的是？ MMDLit\_SpecularRefl定义于MMD4Mecanim-MMDLit-Lighting.cginc。 函数内容是Blinn高光模型，\_Specular默认只为0使本部分光照计算结果默认为0。 可能SPECULAR是被弃用的模拟高光的方式，如果主动设置高光参数可能激活这个关键词。 接下来是EMISSIVE\_ON定义的区域： c += baseC \* (half3)\_Emissive; 这里把间接光直接当次要光照处理，加算在最终光照上。 并没有在PmxEditor中发现可能能够激活这个关键字的设置，可能是Mikumikudance里面的。 到此MMDLit\_Lighting部分结束，接下来回到frag\_core函数部分。 c += baseC \* IN.vlight; IN.vlight表示SH光照和4个额外点光源光照之和。 c在整个过程中不断的叠加光照内容，到此完成了所有的光照计算。 c=diffuse+SPHEREMAP+SH+VertexLight

# MMDLit-ForwardAdd

接下来看MMDLit shader的第二个Pass，ForwardAdd。 通常来说，ForwardAdd用于处理除了最重要的平行光以外的逐像素光照。 在光照计算上，这里不再考虑SH光照计算和VertextLight计算。 而ForwardAdd处理的光源类型可以是多样的，不再限于平行光。 ForwardAdd需要叠加的光照有diffuse、specular，在计算上和ForwardBase差不多。 接下来开始看代码！

```
Pass {
Name "FORWARD_DELTA"
Tags { "LightMode" = "ForwardAdd" }

ZWrite Off Blend One One Fog { Color (0,0,0,0) }
CGPROGRAM
#pragma target 2.0
#pragma exclude_renderers flash
#pragma vertex vert_surf
#pragma fragment frag_fast
#pragma fragmentoption ARB_precision_hint_fastest
#pragma multi_compile_fwdadd
#pragma multi_compile _ SPECULAR_ON
#pragma multi_compile _ SELFSHADOW_ON
#include "MMD4Mecanim-MMDLit-Surface-ForwardAdd.cginc"
ENDCG
}
```

Zwrite Off和Blend One One，这些是常规操作。 ForwardAdd上的片元与ForwardBass上的片元是一致的，可使用ForwardBass上写好的深度值。 ForwardAdd上的光照计算理应与ForwardBass等价叠加，Blend One One实际上就是叠加变亮。 Fog {...}这个tag并不常见，可以参考[Unity手册](https://docs.unity3d.com/Manual/SL-Fog.html)。 Unity称之为Lagacy Fog会让我认为这是一个被淘汰的技术，至少应该有其他模拟雾效的方式。 Fog会对片元颜色进行RGB通道的混合，基于与相机的距离，越远时越接近指定的FogColor值。 一个完整的Fog命令：Fog { Mode Linear Color\[\_Color\] Range \[\_From\],\[\_To\]} Mode的默认值为Global，会被处理为Off或Exp2，取决于Lighting Settings-Fog。 Color指定雾效的目标颜色，以片元颜色为源颜色，根据雾效模式和片元到相机的距离进行插值。 Density指定指数衰减雾效的衰减因子，模拟光随着距离增加被吸收。 Range指定线性衰减雾效的Near和Far距离，这里的距离概念与世界空间相同。 测试：在Lighting Settings中开启Fog，设置Color为(0,0,0)，模式为Linear，End为20。 创建一个Cube，其使用默认的标准shader且颜色为白色，拖动Cube使其靠近和远离相机。 这里Fog只指定了Color，默认的Fog是关闭的，所以并不会生效。 如果开启Fog，根据不同的衰减模式，随着物体远离相机颜色会变暗。 继续看编译指令，相对于ForwardBase少了三种关键字，具体差别可以在讲代码时分析。 函数部分依然是被隐藏在了.cginc文件中。 vert\_surf

```
v2f_surf vert_surf(appdata_full v)
{
    v2f_surf o;
    o.pos = _UnityObjectToClipPos(v.vertex);
    o.pack0.xy = v.texcoord.xy;
    o.normal = mul((float3x3)_UNITY_OBJECT_TO_WORLD, SCALED_NORMAL);
    o.lightDir.xyz = WorldSpaceLightDir(v.vertex);
    o.viewDir.xyz = WorldSpaceViewDir(v.vertex);
    half NdotL = dot(o.normal, (half3)o.lightDir);
    half toonRefl = MMDLit_GetToolRefl(NdotL);
    o.pack0.z = toonRefl;
    o.pack0.w = MMDLit_GetForwardAddStr(toonRefl);
    o.lightDir.w = 0.0;
    o.viewDir.w = MMDLit_GetToonShadow(toonRefl);
    TRANSFER_VERTEX_TO_FRAGMENT(o);
    return o;
}
```

这段代码可以和ForwardBase的版本对比着看。 o.lightDir.xyz计算了世界空间下的光源方向。 NdotL的计算中，法线和光照方向都没有归一化，这样做是有隐患的。 toonRefl中使用NdotL来获得diffuse光照的衰减，这里不用考虑阴影衰减。 来看看MMDLit\_GetForwardAddStr函数：

```
inline half MMDLit_GetForwardAddStr(half toonRefl)
{
    half toonShadow = (toonRefl - _AddLightToonCen) * 2.0;
    return (half)clamp(toonShadow * toonShadow - 1.0, _AddLightToonMin, 1.0);
}
```

toonRefl是NdotL的取值范围偏移到0~1后的结果，正对光照时为1。 \_AddLightToonCen默认是-0.1，在PmxEditor中没有这种光照参数设置，所以其保持默认值。 clamp运算，值超出边界时取边界值；clamp(x,a,b)，a为下限，b为上限。 当toonRefl为0.6~1时，返回值为1；toonRefl为0.5时返回0.44。 掠射角，指入射角趋近于90度时，对入射角的描述。 这个函数可以描述渐变式的光照强度，75°左右的掠射角处开始变暗。 而添加自定义变量\_AddLightToonCen的作用则是调整这个角度值，值越高达到同样强度需要的toonRefl值越高。 MMDLit\_GetToonShadow函数在ForwardBase中提过，相当于把有效的NdotL范围非线性偏移到0~1范围。 pack0的xy分量用于\_MainTex的采样，z分量保存toonRefl，w分量存储渐变式的光照强度。 lightDir的w分量直接存储的固定值0；viewDir的w分量用于存储非线性的光照强度。 到此vertex着色器部分结束，更多的光照计算从fragment转移到了这个部分以节约性能。 frag\_fast函数和ForwardBase的版本差不多，但是a通道值写死为0。 这样做的目的是使颜色缓冲中的a通道值在使用Blend One One混合后保持不变。 frag\_core

```
inline half3 frag_core(in v2f_surf IN, half4 albedo)
{
    half atten = LIGHT_ATTENUATION(IN);
    #ifndef USING_DIRECTIONAL_LIGHT
    half3 lightDir = normalize((half3)IN.lightDir);
    #else
    half3 lightDir = (half3)IN.lightDir;
    #endif

    half toonRefl = (half)IN.pack0.z;
    half forwardAddStr = (half)IN.pack0.w;
    half toonShadow = IN.viewDir.w;
    half NdotL = IN.lightDir.w;
    half3 c = MMDLit_Lighting_Add(
        (half3)albedo,NdotL,toonRefl,toonShadow,IN.normal,
        (half3)lightDir,normalize((half3)IN.viewDir),atten);

    c *= forwardAddStr;
    return c;
}
```

atten获取阴影衰减\*光照衰减，非平行光的光照衰减计算是很有必要的。 lightDir的归一化没有看懂，不管是什么光源插值后都必须重新归一化。 NdotL这里会取到固定值0，其功能性可能被toonRefl/forwardAddStr/toonShadow等值代替。 接下来是将这一大堆的变量带入到MMDLit\_Lighting\_Add计算出代表diffuse的c。 MMDLit\_Lighting\_Add

```
inline half3 MMDLit_Lighting_Add(
    half3 albedo,half NdotL,half toonRefl,half toonShadow,
    half3 normal,half3 lightDir,half3 viewDir,half atten)
{
    half3 ramp = MMDLit_GetRamp_Add(toonRefl, toonShadow);
    half3 lightColor = (half3)_LightColor0 * MMDLIT_ATTEN(atten);

    half3 baseC;
    half3 baseD;
    MMDLit_GetBaseColor(albedo, MMDLit_GetTempDiffuse_NoAmbient(), half3(0.0, 0.0, 0.0), baseC, baseD);

    half3 c = baseD * lightColor * ramp;

    #ifdef SPECULAR_ON
    half refl = MMDLit_SpecularRefl(normal, lightDir, viewDir, _Shininess);
    c += (half3)_Specular * lightColor * refl;
    #endif

    return c;
}
```

这里代表toonShadow的参数为NdotL，也就是0。 MMDLit\_GetRamp\_Add用于计算diffuse光照部分的albedo，其结果近似于toonRefl。 在计算代表固有色的baseD时，由于ForwardAdd没有开启SPHEREMAP，则不考虑高光部分。 得到的c代表diffuse部分的结果，不再继续讨论SPECULAR和EMISSIVE关键字。 接着回到frag\_core函数： c \*= forwardAddStr; 为ForwardAdd光源的光照结果提供线性衰减影响，正面朝光的区域不受此影响，掠射角处变暗。 到此ForwardAdd部分的光照计算结束，整体计算的内容相比ForwardBase少了很多。

# MMDLit-ShadowCaster

关于ShadowCaster的Pass编程，女神书上讲的少，一般用三个宏简单处理。 ShadowCaster用于将材质的添加到shadowmap中，这样其他的材质就能采样到阴影。

```
Pass {
    Name "ShadowCaster"
    Tags { "LightMode" = "ShadowCaster" }
    Fog {Mode Off}
    ZWrite On ZTest LEqual Cull Off
    Offset 1, 1
    CGPROGRAM
    #pragma target 2.0
    #pragma exclude_renderers flash
    #pragma vertex vert_surf
    #pragma fragment frag_fast
    #pragma fragmentoption ARB_precision_hint_fastest
    #pragma multi_compile_shadowcaster
    #include "MMD4Mecanim-MMDLit-Surface-ShadowCaster.cginc"
    ENDCG
}
```

Offset是一个很少见的RenderState，参考[Unity手册](https://docs.unity3d.com/Manual/SL-CullAndDepth.html)。 深度偏移，参数1为斜率因子，参数2为偏移单位。 offset = (m \* factor) + (r \* units) m是三角面片的斜率，三角面片与近截面平行，m就越接近0。 测试：新建场景，创建一个Plane，并复制一份得到Plane(1)，为Plane/Plane(1)新建材质和Unlit shader； 设置两个物体为不同的贴图，以便于区分；默认是Plane被遮住，显示Plane(1)。 单独修改Plane的shader，添加Offset 0, -1到Pass内；Plane被显示出来。 单独修改Plane的shader，Offset 1, -1；Plane(1)被显示出来。 在Hierarchy中将Plane调整到Plane(1)下面，使Plane(1)优先被渲染。 设置相机与Plane平行，单独修改Plane的shader，Offset 1, -1；Plane被显示出来。 单独修改Plane的shader，设置Offset 0.01, -1，不断设置相机的x分量角度；显示Plane(1)。 单独修改Plane的shader，设置Offset -0.01, -1，不断设置相机的x分量角度；显示Plane。 设置两个Plane的距离为0.1个单位，Plane在下方，调整Plane的Offset直到其显示出来(需要1万以上)。 结论： Offset参数修改的是深度值，能影响物体的显示顺序，改变相对位置，移动1个单位需要的Offset值会很大。 m和r都是非负数，所以因子提供负数时Offset为负，负的越多在深度上离摄像机越近。 深度偏移可以用于制作眉毛、眼睛等卡通效果，使其在被遮蔽时也能显示出来。 r是能产生在窗口坐标系的深度值中可分辨的差异的最小值，离相机越远越大； m代表三角面片的斜率，表面两点之间的向量(x,y,z)，m=max(z/x,z/y)； 当表面垂直于相机时，m=0；当表面绕X轴旋转30°，m=1/√3；具体数值不明 Offset 1, 1这里的操作目标不明，主要是我们对ShadowCaster的执行规则不清楚。 测试： 新建场景，创建一个Plane用于承接投影，在Plane上面创建一个Cube，为其新建材质和Unlit shader； 可以看到使用标准shader时的Cube在Plane上有投影(projection)，其Cube背面有自影(self-shadowing)； 当为Cube换上默认的Unlit shader以后，投影和自影都消失了； 删除Cube的全部Pass和FallBack，添加一个ShadowCaster类型的Pass：

```
Pass{
    Name "ShadowCaster"
    Tags { "LightMode" = "ShadowCaster" }
    //Fog { Mode Off }
    //ZWrite On ZTest Less Cull Off
    //Offset 1, 1

    CGPROGRAM
    #pragma vertex vert
    #pragma fragment frag
    #pragma multi_compile_shadowcaster
    #include "UnityCG.cginc"
    struct v2f
    { 
        V2F_SHADOW_CASTER;
    };

    v2f vert(appdata_base v)
    {
        v2f o;
        TRANSFER_SHADOW_CASTER_NORMALOFFSET(o)
        return o;
    }

    float4 frag(v2f i) : SV_Target
    {
        SHADOW_CASTER_FRAGMENT(i)
    }

    ENDCG
}
```

这个ShaodwCaster是最简化的版本，单独存在于SubShader时对不可见的Cube造成投影+自影。 有三行RenderState我做了注释，我们可以取消注释、修改参数进行调整观察。 为Plane新建材质，设置颜色；Cube的自影颜色也跟着变化。 结论： Cube的自定义shader中的确没有光照计算，也就不存在可以承载颜色的片元。 Cube的ShadowCaster Pass将深度信息写入到了shadowmap，被Plane上的片元采样到了。 如果是单纯期望只制造投影而本体不可见，可设置Cube的Shaodw模式为Shadow Only。 疑问： ShadowCaster中的RenderState是否与ForwardBase/ForwardAdd中不同？ 在Cube的Mesh Renderer组件中设置Cast Shadows会产生不同结果，其原理是？ ShadowCaster的vertex/fragment着色器的输出被用来干啥了？ Frame Debugger 1.UpdateDepthTexture RenderTarget:Carmera DepthTexture Clear(color+Z+stencil)：清除颜色值、深度值、模板值；需要场景中有一个平行光。 Draw Mesh：使用ShadowCaster绘制DepthTexture,使用到了RenderState。 默认RenderState参数： Blend One Zero /ZClip True /ZTest LessEqual /Zwrite On /Cull Back 深度测试是对片元进行测试，这里的ZTest/Blend的输入都是ShadowCaster中插值得到的片元。 ShadowCaster的vertex着色器完成了将顶点从模型空间转换到裁剪空间的任务。 ZClip是否对z值超出范围的片元进行裁剪；Cull Back背面的深度值永远会被正面覆盖。 DepthTexture默认黑色，物体靠近相机时变红，到达近截面时为(1,0,0)，然后被裁剪。 2.Drawing RenderTarget:TempBuffer 物体根据队列顺序渲染，ShadowMap→Opaque→Skybox→Transparent。 Unity的默认shader并没有为准备透明物体用的ShadowCaster，透明物体不参与投射和阴影采样。 Shadows.RenderShadowMap RenderTarget:Shadowmap Clear(color+Z+stencil):不确定这里的清除目标具体是什么。 在绘制相机的DepthTexture前，清除过这些信息；可能每个RenderTarget都有新的FrameBuffer。 但是对于Carmera DepthTexture来说，它只需要一个通道的即可，无法利用完所有缓冲。 光源的视锥体 调整相机距离/角度可产生/减少DrawCall，额外的DrawCall来自于级联阴影(shadow cascade)。 在Game视图观察时会把多个级联的shadow depth绘制到同一个Shadowmap。 对于平行光，投影使用正交相机，其视锥体应包含"主相机的视椎体和Scene相交"的部分。 当确定光源的视椎体后，将片元到近截面的距离转换至0~1范围内，表示其shadow depth。 ShadowCaster宏 V2F\_SHADOW\_CASTER; → float4 pos : SV\_POSITION； TRANSFER\_SHADOW\_CASTER\_NORMALOFFSET(o) 将顶点转换到裁剪空间并沿法线方向朝相机靠近(Bias)。 SHADOW\_CASTER\_FRAGMENT(i) → return 0; 其fragment不需要输出颜色值。 Shadowmap流程中出现的问题 shadow ance：Shadowmap分辨率不足时，一个pixel对应DepthTexture上多个(光源距离不同的)片元； 需要片元向法线/光线方向移动到刚好消除shadow ance，移动量与NdotL对应的sin成正比。 peter panning：为了修正shadow ance进行Bias时，Bias过大导致阴影体积后移过多，像物体飘起来一样。 Hard Shadow & Soft Shadow：阴影采样过程只对比深度得出是否在阴影中，阴影边缘没有渐变效果。 Cascaded Shadow Map：根据与相机的距离决定片元阴影采样时使用的级联。 比如，光源的视锥体1覆盖相机的视锥体前0~1/10，光源的视锥体2覆盖相机的视锥体前1/10~3/10。 光源shadow参数 Normal Bias：阴影体积沿着法线方向缩小，避免shadow ance。 Bias：使阴影体积远离光源，避免shadow ance。 Resolution：设置Shadowmap的分辨率。 生成Shadowmap Shadowmap的RenderState与DepthTexture一致。 Shadowmap绘制过程中，需要为不同的级联生成多次光源的视锥体，对应不同的转换矩阵。 ShadowCaster的vertex着色器输出的是顶点在裁剪空间中用于阴影计算的位置，描述阴影体积(Volume)。 将A通过转换矩阵转换到光源空间，并计算其与光源的距离，越近r通道值越高，即Cull/ZTest/Blend。 Shadows.CollectShadows 对于现代GPU，生成了Camera DepthTexture和Shadowmap以后，会继续生成Screenspace ShadowMap。 Camera DepthTexture包含Screenspace的深度记录，Shadowmap包含光源空间的(Bias后的)深度记录。 生成Screenspace ShadowMap需要将片元(pos)转换(matrix)到光源空间，和Shadowmap对比深度值(depth)。 这里pos的来自ShadowCaster，但是设置光源的角度/Bias不会影响到Camera DepthTexture； 也就是说pos不是ShadowCaster的vertext/fragment输出，只要开启投影会自动参与深度纹理绘制； Camera DepthTexture中还包括对应片元的pos记录(只是Frame Debugger中没显示)。 matrix有很多个，对应不同的级联(cascade)，靠前的级联对应的Scene空间更大(精度越低)。 depth值对比时，比的是离光源距离，也就是光源空间的代表深度的轴值，返回是/否在阴影。 疑问解答 1.ShadowCaster中的RenderState是否与ForwardBase/ForwardAdd中不同？ ShadowCaster的RenderState是针对Camera DepthTexture和Shadowmap绘制过程的； Fog会被转化为前向渲染的keyword，如FOG\_LINEAR，不参与阴影计算。 Offset作为RenderState，同时参与了Camera DepthTexture和Shadowmap的计算，提供深度变化。 但是仅仅是Offset 1, 1，对depth值的影响极低。 其他RenderState以后遇到了再说，具体是否生效需要在Frame Debugger中测试。 2.在Cube的Mesh Renderer组件中设置Cast Shadows会产生不同结果，其原理是？ 因为默认设置Cube参与了Camera DepthTexture的绘制，留下了自己的pos和depth记录。 设置为Shadows Only后其不参与Camera DepthTexture只提供Shadowmap中的阴影体积。 3.ShadowCaster的vertex/fragment着色器的输出被用来干啥了？ vertex输出Shadowmap中的阴影体积，fragment返回值无意义。 ShadowCollector 在Unity5中，这部分代码已经失效，可以安全删除。 更多Unity版本升级改动，可以参考[Unity手册](https://docs.unity3d.com/Manual/UpgradeGuide5-Shaders.html)。

# MMD shader

MMDLit 常规光照，不透明物体；有4个材质使用； 用于发夹、舌头等无描边完全不透明物体； 在插件中有一套判断材质是否透明的逻辑，需要阅读内部代码。 MMDLit-BothFaces 双面渲染shader，无被使用记录； 主要差别是ForwardBase中的Cull Off，其他和MMDLit一样。 当RenderState穿插在Pass之间时，会有什么效果呢？ 测试：新建Scene，新建Cube并为其创建材质与Unlit shader； 将.shader中的默认pass复制3份；出现4个DrawCall用于绘制Cube； 4个DrawCall均使用默认RenderState ZWrite On Cull Back； 在第一个Pass后面插入ZWrite Off Cull Off；第二个Pass：ZWrite On Cull Front 在所有Pass后面添加默认版本ShadowCaster；将ShadowCaster移动到第一个Pass前面； 为第2个Pass添加"LightMode" = "ForwardAdd"，添加一个平行光； 第3、5个Pass添加"LightMode" = "ForwardBase"；第5个Pass内添加Cull Back； 结论： SubShader中的RenderState对其后续的Pass均生效； 同SubShader中的前向Pass按照代码循序执行，ForwardAdd可以先于ForwardBase。 MMDLit-Edge 50个材质中有19个使用了MMDLit-Edge，是最常用的shader之一； 用于带有描边效果的不透明物体，描边可以是带有a通道值的。 MMDLit-Edge的前3个Pass和MMDLit一样；接着修改RenderState并新建2个前向Pass;

```
Cull Front
ZWrite On ZTest Less
Blend SrcAlpha OneMinusSrcAlpha
ColorMask RGB
Offset 0.1, 1 // Edge to far
```

Cull Front剔除前面，保证本体的正面不会被遮挡； ZTest Less比默认的设置更严格，只有朝相机移动过的片元才能通过测试； Blend SrcAlpha OneMinusSrcAlpha，是皮肤中间的描边混合肤色，皮肤边缘则没有； ColorMask RGB，指定输出到RenderTarget #0的RGB通道，混合后不修改A通道； Offset 0.1, 1 微量远离相机，和ZTest Less类似的效果； 接下来是2个额外的前向Pass: FORWARD\_EDGE

```
v2f_surf vert_surf (appdata_full v)
{
    v2f_surf o;
    v.vertex = MMDLit_GetEdgeVertex(v.vertex, v.normal);
    o.pos = MMDLit_TransformEdgeVertex(v.vertex);
    float3 worldN = mul((float3x3)_UNITY_OBJECT_TO_WORLD, SCALED_NORMAL);
    o.vlight = ShadeSH9(float4(worldN, 1.0));
    TRANSFER_VERTEX_TO_FRAGMENT(o);
    return o;
}
```

v.vertex = MMDLit\_GetEdgeVertex(v.vertex, v.normal); 直接使用a2v结构体v.vertex去赋值这种操作很罕见； MMDLit\_GetEdgeVertex定义于MMD4Mecanim-MMDLit-SurfaceEdge-Lighting.cginc：

```
inline float4 MMDLit_GetEdgeVertex(float4 vertex, float3 normal)
{
#if 1
    float edge_size = _EdgeSize;
#else
    // Adjust edge_size by distance & fovY
    float4 world_pos = mul(MMDLit_GetMatrixMV(), vertex);
    float r_proj_y = UNITY_MATRIX_P[1][1];
    float edge_size = abs(_EdgeSize / r_proj_y * world_pos.z) * 2.0;
#endif
    return vertex + float4(normal.xyz * edge_size, 0.0);
}
```

分支一：结果返回法线方向偏移固定值后的顶点，没使用法线贴图； 数据基于模型空间下的固定值正值，需要考虑模型的相对大小进行调整。 分支二：基于FOV(摄像机张角)和相机深度，使描边保持相对宽度： UNITY\_MATRIX\_P\[1\]\[1\]：取透视裁剪矩阵的第2排第2个元素； FOV越大edge\_size越大；观察空间z值负的越多(裁剪后)相机depth越高，edge\_size越大。 o.pos = MMDLit\_TransformEdgeVertex(v.vertex);

```
inline float4 MMDLit_TransformEdgeVertex(float4 vertex)
{
#if 0
    vertex = _UnityObjectToClipPos(vertex);
    vertex.z += 0.00001 * vertex.w;
    return vertex;
#else
    return _UnityObjectToClipPos(vertex);
#endif
}
```

分支一：结果裁剪空间微量z值正增加，远离相机； 分支二：常规的裁剪空间转换(法线方向偏移后)。

```
fixed4 frag_surf (v2f_surf IN) : MMDLIT_SV_TARGET
{
    half alpha;
    half3 albedo = MMDLit_GetAlbedo(alpha);

    MMDLIT_CLIP(alpha)

    half atten = LIGHT_ATTENUATION(IN);
    half3 c;

    c = MMDLit_Lighting(albedo, atten, IN.vlight);
    return fixed4(c, alpha);
}
```

alpha = \_EdgeColor.a; 即描边的A通道值； albedo = (half3)\_EdgeColor；即描边的RGB通道值； atten是阴影衰减\*光照衰减；IN.vlight是SH光照+环境光； MMDLit\_Lighting函数为针对描边片元的光照计算：

```
inline half3 MMDLit_Lighting(half3 albedo, half atten, half3 globalAmbient)
{
    half3 color = (half3)_LightColor0 * MMDLIT_ATTEN(atten);
    color *= 0.6;
    #ifdef AMB2DIFF_ON
    color *= saturate(globalAmbient * _AmbientToDiffuse);
    #endif
    #ifdef UNITY_PASS_FORWARDADD
    // No Ambient.
    #else
    color += globalAmbient;
    #endif
    color *= albedo;
    return color;
}
```

finalcolor = (diffuse + ambient) \* 描边色； 总结： 描边部分的颜色计算很简单，重点是控制描边的深度、宽度； 增加深度的因素(远离相机/隐藏描边体)：Offset 0.1, 1 减少深度的因素(靠近相机/显示描边体)：顶点偏移值(\_EdgeSize)在相机深度中的分量 顶点偏移时，描边体会球形变大罩住本体； 因为Cull Front，描边体的正面会被剔除，不会遮挡本体的正面部分； Offset对最终描边效果影响过低，Offset的的r因子要上万才能隐藏部分描边； 当\_EdgeSize值过高，大量多余的描边体的背面会显示出来。 MMDLit-Transparent 50个材质中被用到了8次，如眼白、眼睛、舌头、前发假影； 这些材质使用的贴图中A通道值不为0，被判断为透明类型的材质。 ForwardBase "Queue" = "Geometry+2" 比MMDLit的序列值高1； Blend SrcAlpha OneMinusSrcAlpha 混合已有的缓冲颜色； Offset -0.1, -1 微小程度靠近相机，重叠模型时优先显示； ForwardBase代码方面与MMDLit不同之处在于，使用\_Color.a作为A通道值； ForwardAdd Blend One One 输出时RGB分量乘以A通道值，返回的A通道值固定为0； 总结： 这里的Transparent依然在不透明队列，可以模拟单片元透明效果； A通道值不会产生直接显示效果，在混合时降低RGB值(变黑)，可不保留； 34.Skirt\_main的绘制需要3个DrawCall，分别Back/Front/描边； UsePass使用的RenderState由代码被定义的区域决定； 其他组合类型的shader都是简单引用以上基础shader的Pass。