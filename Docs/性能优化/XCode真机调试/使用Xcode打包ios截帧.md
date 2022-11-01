# 使用免费开发者证书打包
参考：http://t.zoukankan.com/zdx20-p-15084391.html
准备条件：Apple ID
    登录开发者网站 -> 同意开发者协议 -> 到达开发者欢迎界面
        如果Build失败可以尝试换一个Apple ID重试
真机链接至Mac
    真机可能需要切换至开发者模式
        设置 -> 隐私与安全性 -> 开发者模式
打包URP默认demo
    构建设置中勾选 Run in Xcode as Debug
    生成XCode工程 可使用XCode打开或运行.xcodeproj文件
    设置证书：在All标签下使用自动化配置 Team中指定账号
        没有账号时添加账号并添加证书
        All表现表示对多个项目使用
    Bundle标签根据提示修改为com.xxxx.xxxx
        需要是一个

# 处理开发者证书 uuid
用于安装调试的手机需要先绑定uuid到开发者账号
如果需要调试要使用Development证书

# 使用模拟器构建
在Unity的PlayerSettings中设置TargetSDK为SimulatorSDK
切换SDK后可使用模拟器作为目标设备
模拟器模式下不支持截帧