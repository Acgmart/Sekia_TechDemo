# 大文件
Git使用过程中，大于100Mb的文件需要特殊标记，也就是LFS模块

# 安装LFS
git lfs install

# 标记大文件
git lfs track "相对路径"
相对路径可以在文件列表右键菜单"Copy relative file path"获取

添加成功后，在.gitattributes文件中会新增一行，如：
Assets/Editor/x64/Bakery/cudnn64_7.dll filter=lfs diff=lfs merge=lfs -text