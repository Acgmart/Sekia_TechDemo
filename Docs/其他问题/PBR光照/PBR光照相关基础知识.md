1.什么是颜色空间Color Space
问题：人眼感知与物理参数的差异 为什么在要在线性空间进行光照计算
常见液晶面板参数差异：峰值亮度、色域、调光模式
    gamma2.2和2.4的区别：https://zhuanlan.zhihu.com/p/66558476
        比如贴图中的0.5 在gamma2.2下转换到线性空间为0.217
            相当于将一半的存储范围用于0~0.217之间的暗部区域
        当gamma值提高到2.2 0.5转换到线性空间为0.189
            相当于暗部细节变多了 亮部细节减少了
        
参考文章：十分钟色彩科学系列
https://mp.weixin.qq.com/mp/appmsgalbum?__biz=MzIxMzc3NTQ5OA==&action=getalbum&album_id=1988071137502691328&scene=173&from_msgid=2247483701&from_itemidx=1&count=3&nolastread=1#wechat_redirect

2.现代PBR制作工作流
问题：PBR光照的构成与各种参数的组合
直接光照与间接光照的差异
金属光照与非金属光照的差异
粗糙度与金属度的作用

参考：PBR_Guide_Vol1_中文版.pdf 和 PBR_Guide_Vol2_中文版.pdf
参考：天涯明月刀渲染

3.HDR、Bloom、AO、阴影、反射、实时GI等
问题：如何提升画面的真实性
了解URP后处理中出现的一些调色技巧：HSV颜色空间、对比度、冷暖色
    可以尝试搜索关键词查找科普

HDR：根据环境的最大亮度自动调整亮度范围以表现更多的细节
    为什么白天的阳光照不到的地方特别黑：动态范围太大导致暗部范围被压缩
Bloom：亮度扩散 与环境进行融合
    高质量泛光：https://zhuanlan.zhihu.com/p/525500877
    通透感：https://zhuanlan.zhihu.com/p/111633226
AO/阴影：强调空间关系 与环境进行融合
    如果角色与环境不融合就显得角色漂浮在场景上 没有立体感
    原神中的多种AO技术：http://www.76k.com/post/56503.html
反射/折射：物理正确 强调材质特征
实时GI：描述了光线在环境中充分弹射后造成的环境平均亮度
    传统烘培GI在内容制作上渐渐体现出局限性