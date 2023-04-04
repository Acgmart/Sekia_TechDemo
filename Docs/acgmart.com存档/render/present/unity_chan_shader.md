---
title: Unity-Chan shader
categories:
- [渲染, 效果表现]
date: 2020-07-01 22:50:31
cover: https://acgmart.oss-cn-hangzhou.aliyuncs.com/uploads/article/render/present/031.gif
---
本篇内容主要为解析Unity日本分部提供的NPR着色技术，会引用到很多Unity酱相关的资源。 
参考资料： [Unity-Chan "Candy Rock Star" Live Demo](https://github.com/unity3d-jp/unitychan-crs) [UnityChanToonShaderVer2 Project](https://github.com/unity3d-jp/UnityChanToonShaderVer2_Project) [Unity酱官网](http://unity-chan.com/) 解析过程中使用Unity2017.4.25f1。 
本篇内容基于[Unity渲染流水线](https://acgmart.com/3d/lwrp/)/[ShaderLab数学](https://acgmart.com/3d/lwrp7/)/[ShaderLab函数](https://acgmart.com/3d/lwrp8/)/[MMD shader](https://acgmart.com/3d/lwrp12/)。

# Chara Shader

先看Candy Rock Star中Unity酱身上的shader，路径位置： Assets\\UnityChan\\CandyRockStar\\Shader 在这里目录附近还能找到与Unity酱相关的模型、材质、贴图文件； 模型的mesh数量特别多，可以在模型软件中先观察熟悉一下:

mesh名

部位

材质名

shader名

BLW\_DEF

眉毛

eyeline

Eyelash - Transparent

BodyParts\_new01

身体

body

Clothing - Double-sided

cheek

脸颊

mat\_cheek

Blush - Transparent

Effector\_new01

腰侧+手腕侧小道具

Effector

Clothing

EL\_DEF

上睫毛

eyeline

Eyelash - Transparent

eye\_base\_old

眼白

eyebase

Eye

EYE\_DEF

眼眶

face

Skin

eye\_L\_old

左眼

eye\_L1

Eye - Transparent

eye\_R\_old

右眼

eye\_R1

Eye - Transparent

Globe\_new01

手套

body

Clothing - Double-sided

HairBack\_DS\_new01

后发

hair

Hair - Double-sided

HairBand\_DS\_new01

发饰+头巾

body

Clothing - Double-sided

HairFront\_DS\_new01

前发

hair

Hair - Double-sided

HairSide\_DS\_new01

侧发

hair

Hair - Double-sided

head\_back

后半头+耳朵

face

Skin

jacket\_BK\_new01

夹克背面

body

Clothing - Double-sided

jacket\_FR\_new01

夹克正面

body

Clothing - Double-sided

jacketEri\_new01

夹克衣领

body

Clothing - Double-sided

JacketFrill\_DS\_new01

夹克褶边

body\_trans

Blush - Transparent

JacketSode\_new01

夹克袖子

body

Clothing - Double-sided

Kneeso\_new01

长袜

body

Clothing - Double-sided

Mizugi\_new01

泳衣+泳裤

body

Clothing - Double-sided

MTH\_DEF

脸部+下巴+额头

face

Skin

Pants\_new01

短裤

body

Clothing - Double-sided

PantsFrill\_DS\_new01

短裤褶边

body\_trans

Blush - Transparent

Shoes\_new01

鞋子

body

Clothing - Double-sided

Skin

皮肤

skin

Skin

UnityChan/Clothing 作为一整套shader体系，我们需要了解其光照模型，从Clothing开始最合适了； 整个shader包括多个SubShader，用LOD值区分开，而项目设置中全局LOD值为0； 意味着项目不检查LOD值，使用第一个可用的SubShader，这里我们从LOD低的说起： LOD 200 不透明队列，RenderState是默认设置，无自定义关键词，引用了Unlic.cg： 直接返回贴图采样值。 也就是说，这个档次是没有实时光照计算的。 SubShader中包含Tags："LightMode"="ForwardBase" LightMode设置将应用于该SubShader的所有Pass。 LOD 250 仅有ForwardBass，默认RenderState，开启了2个关键词，引用了CharaMain.cg： vertex着色器中代码以填充v2f结构为主要任务； 2个关键词使用#define激活对应代码块，与multi\_compile命令生成变体不同； 分别计算了uv偏移、世界空间法线、世界空间相机方向、世界空间光源方向； ENABLE\_CAST\_SHADOWS ENABLE\_CAST\_SHADOWS关键字激活了v2f结构、vertex/fragment着色器中阴影的计算； saturate( 2.0 \* LIGHT\_ATTENUATION( i ) - 1.0 ); 这样计算出来的衰减值去插值时，实际上开始衰减处不变，衰减加深； fragment着色器的代码颇长，整体上将颜色加算给combinedColor； diffSamplerColor：贴图采样得到的diffuse色； normalDotEye：法线和观察方向的dot，cosβ，需要再次归一化，正面取值在1~0； falloffU：1-cosβ，取值范围为0~1，β0→90°时，值0.02→0.98，加速递增曲线； falloffSamplerColor：采样渐变贴图,β45~67.5°时，1-cosβ为0.29~0.61,值为0~0.3； shadowColor：diffuse色自乘后得到，作为阴影参照色； combinedColor：对diffuse色进行阶段性阴影衰减，falloffSamplerColor为衰减率； diffuse加乘衰减：对diffuse色乘以(1+衰减\*衰减.a），可观察衰减贴图的A通道预览； 在1-cosβ值在0.7~1时，也就是掠射角附近对衰减进行补偿，使渐变过程更平缓。 diffuse+specular色调修正：(diffuse+specular)乘以\_Color和\_LightColor0； \_LightColor0代表光照颜色，在光源面板中Color设置颜色值，Intensity控制倍率； 在本例中并没有包括Lighting.cginc，而是单独声明\_LightColor0用于获取光照颜色； opacity透明度：使用贴图、色调、光照的A通道分量相乘，需要开启混合才能生效； diffuse+specular阴影修正：这两种颜色成分均受阴影衰减控制； ENABLE\_RIMLIGHT rimlightDot：NdotL \* 0.5 +0.5，最亮处为1，掠射角为0.5，最暗处为0； rimlightDot \* (1-NdotV)：视角正面严重衰减，只剩下朝光边缘处亮度正常； 边缘光衰减采样(x=0.7时采样到1)：求最亮处边界，若rimlightDot=1，1-cosβ=0.7，β=73°； 边缘光在所有亮度(0~1)区间都很明显，diffuse渐变只在低亮度(0~0.4)区间敏感。 LOD 300 相比上一个级别，额外开启了ENABLE\_SPECULAR定义； ENABLE\_SPECULAR reflectionMaskColor：高光贴图采样，逐像素控制高光强度； lighting.z=lit(NdotV,NdotV,n).z:返回NdotV的n次方； specularColor=diffuse \* mask \* lighting.z 这里的Specular不同于Phong/Blinn高光模型，与光照角度无关： 正面视角的部分获得亮度加成，\_SpecularPower控制衰减率。 LOD 400 相比上一个级别，使用一个额外的Pass进行描边： Cull Front：使用法线外扩的背面进行描边； ZTest Less：强化深度测试，避免遮蔽原有片元； 描边代码被隐藏在CharaOutline.cg中，无光照计算和特殊关键词； vertxt着色器目的为计算出在裁剪空间下，顶点外扩后的位置； projSpaceNormal：使用UnityObjectToClipPos将法线转换到裁剪空间，法线不再垂直于表面； 这里使用了normalize(half4 v)，忽略第四维进行归一化，得到(a,b,c,w)； scaledNormal：裁剪空间中坐标的缩小，向O(0,0,0,-2·Near·Far/(Far+Near)))靠近； 这里scaledNormal缩小4个分量，系数为正小数k； scaledNormal.z += 0.00001：法线顶点微量后移； o.pos = projSpacePos + scaledNorm：顶点位置朝新法线方向外扩； o.pos = projSpacePos + (ak,bk,ck+0.00001,wk)，NDC化需要除以projSpacePos.w； projSpacePos.w(顶点的相机深度)和w并没有直接的联系； 顶点位置向法线方向移动k个单位后，z微量增加(远离相机)；w微量增加(靠近O)； 结论：在裁剪空间中计算的描边宽度相对固定，不会随着物体离相机距离而剧烈变化； fragment着色器中对偏移后的顶点进行着色； diffuseMapColor为diffuse色；maxChan用于辅助计算差值lerpVals； lerpVals为(0,0,1)或(0,1,0)或(1,0,0)，取决于diffuse的色调； 色调修正：lerp处理newMapColor，使RGB中值最低的两个通道变暗，衰减因子为0.6； 修正后的颜色色调不变，颜色变暗，如淡红→暗红； 最后的return中乘以衰减因子0.8、diffuse色、\_Color、光源色等，进一步变暗。 总结：本例中描边使用了diffuse的阴影色作为参照，消除使用黑色描边的异样感。 LOD 450 这是等级最高的SubShader，也是真正默认执行的SubShader； 相比上一级，在描边上没有变化，光照计算方面新增了2个define； ENABLE\_NORMAL\_MAP 这个关键词的目的是使用法线贴图，逐像素控制法线方向，增加细节。 在vertex着色器中计算了世界空间下的tangent、binormal、normal； 使用这3个矢量构成竖向填充矩阵，可以将矢量从法线空间转换到世界空间； 在fragment着色器中，需要使用法线贴图采样的结果代替原世界空间法线； normalVec：对法线贴图采样；xyz\*2-1，手动解压法线数据； localToWorldTranspose：这里使用的是横向填充矩阵，在mul计算式放在右边； ENABLE\_REFLECTION reflectVector：观察方向取反后的反射方向，用于环境光取样； sphereMapCoords：用单张室内贴图模拟环境，采样范围是贴图中心构成的圆； 此时，combinedColor是未经修正过的diffuse+specular； GetOverlayColor inUpper是环境采样色，上层遮盖；inLower是combinedColor，底色； lerpVals = round(inLower); 对底色的分量四舍五入，得到0或1，对应返回结果lowerResult/greaterResult； 当lerpVals的分量为0时，对应lowerResult的分量为inLower \* 2.0 \* inUpper； inLower为0~0.5时，lowerResult取值<inLower 当lerpVals的分量为1时，对应greaterResult的分量为： 2.0 \* inUpper \* (1-inLower) + 2(inLower - 0.5) inLower为0.5~1时，greaterResult取值为inUpper→inLower reflectionMaskColor.a的值可以在预览中观察高光贴图的A通道； 总结： 采样UV与观察角度有关，采样颜色类于毛玻璃反射下的室内，有连贯高光和阴影； 法线贴图补充的细节能充分表现出这种明暗变化。 Reflection模拟了环境反射，RGB分量根据强度对环境色进行反射； 分量值低于0.5时，对应分量的环境色就像贴图一样覆盖在表面； 分量值高于0.5时，reflectColor受环境色的影响变小。 例如：粉红(249,198,166)→(243,146,104)；棕色(187,129,97)→(83,56,36)； 这样的反射方式让表面细节呈现随机多样性、增强色调。 UnityChan/Clothing - Double-sided 双面shader在表现人物穿着时使用的非常频繁，单面仅在额外小道具中使用； 和Clothing的差别是第一个ForwardBase使用了Cull Off; 结论：双面shader处理服装时可使背面也上色，不透明时整体差别不大； UnityChan/Blush - Transparent 用于表现脸红、布料褶边等单片元半透明效果，仅有一个Pass； Blend SrcAlpha OneMinusSrcAlpha, One One ：混合RGB通道； ZWrite Off：不再写入深度值，需要最后被绘制； "Queue"="Geometry+3"：本例中，不透明队列的最高值；会被透明队列遮盖； "IgnoreProjector"="True"：不被投影，意味着阴影衰减值固定为1？ Cull Back 一般设置，单面效果，例如：脸红从后面看不到； 代码隐藏在CharaSkin.cg中： vertex着色器中填充v2f结构； fragment着色器中计算diffuse、渐变、边缘光、衰减等； combinedColor中lerp的差值由渐变贴图的A通道值决定，可在贴图预览中查看RGB/A通道； falloffSamplerColor是diffuse的系数，设NdotV的角度为β，当β0~90°时： 1-cosβ作为采样UV的x轴，falloffSamplerColor的变化与贴图横向色调变化有关； 在材质mat\_cheek中使用的贴图表明combinedColor随着观察角度变大红色调变深； ENABLE\_RIMLIGHT宏中的边缘光效果可以使朝光掠射角出有高亮月牙形色带； 这个效果在没有足够的NdotV角度、显示面积、光照时，非常不明显。 UnityChan/Hair 和UnityChan/Clothing内容一样； UnityChan/Hair - Double-sided 和UnityChan/Clothing - Double-sided内容一样； UnityChan/Skin 有3个LOD级别，不透明队列，使用了渐变、边缘光、阴影效果； CharaSkin.cg中的代码适合表现有柔和渐变的不透明非金属物体。 UnityChan/Skin - Transparent 本例中，没有任何部位使用这个shader； Queue"="Transparent+1：透明队列，很靠后的队列值； "RenderType"="Overlay"：这只是个标签，可能用于遮盖效果； UnityChan/Eye 这里用于表现眼白； "Queue"="Geometry"：默认RenderState和不透明队列，针对不透明非金属物体； UnityChan/Eye - Transparent 这里用于表现左眼珠和右眼珠； 开启了Blend，"IgnoreProjector"="True"，"Queue"="Geometry+1"； 类似于Blush - Transparent，有颜色混合，但是队列值不高，容易被遮挡； 针对半透明非金属物体； UnityChan/Eyelash - Transparent 这里用于表现眼睫毛和眉毛； 和Eye - Transparent类似，仅队列值+1，针对半透明非金属物体。