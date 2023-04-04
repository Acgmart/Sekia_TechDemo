---
title: Centos 服务端同步工具rsync
categories:
- [其他, 运维]
date: 2020-04-18 01:03:20
---

\[toc\]服务端同步文件需求很常见，这里推荐使用rsync作为同步工具。

# Rsync

大多数Linux系统自带rsync服务，无需安装，为了确认可以输入命令查询本机上rsync的版本: `rsync -v` **创建文件/文件夹** 下面的命令创建了rsync文件夹和2个配置文件,然后给rsyncd.conf完成了设置权限: `mkdir /etc/rsyncd;touch /etc/rsyncd/rsyncd.conf;touch /etc/rsyncd/rsyncd.secrets;chmod 600 /etc/rsyncd/rsyncd.secrets;` `vim /etc/rsyncd/rsyncd.conf` 按I键进入编辑模式

```
uid = root
gid = root
use chroot = no
max connections = 100
read only = no
write only = no
log file =/var/log/rsyncd.log
fake super = yes
[Upload]
path = /root/Server/
auth users = root
secrets file = /etc/rsyncd/rsyncd.secrets
list = yes
```

按ESC键退出编辑模式，再按输入`:wq`保存并退出。 **配置解释** 监听默认端口873，不限制读写，使用root账号；模块名为Upload，模块地址对应为/root/Server/。 模块：提供给外界访问用的地址的抽象，用模块名称代指模块地址。 如果模块地址对应的路径上不存在文件夹，就需要新建文件夹: `mkdir /root/Server;` 这里创建的Server文件夹，将用于存储同步过来的文件。 可以按需修改端口、账号。 **编辑账号信息** `vim /etc/rsyncd/rsyncd.secrets`

```
root:123456
```

由**帐号:密码**组成一条数据,可以填写多个帐号；这些账号就是系统账号. **启动服务端rsync** `rsync --daemon --config=/etc/rsyncd/rsyncd.conf` **设置rsync开机启动** vim /etc/rc.local 在末尾加入一行启动rsync的命令 rsync --daemon --config=/etc/rsyncd/rsyncd.conf 这重启服务器时自动运行rsync，到此服务端配置完成。 **客户端上执行同步** 在windows创建一个bat脚本，输入： `start %cd%/Tools/cwRsync/rsync.exe -vzrtopg --password-file=./Tools/cwRsync/Config/rsync.secrets --delete ./Output/ root@111.222.50.333::Upload/ --chmod=ugo=rwX` 也就是用附带调试参数的形式运行exe文件。 1.rsync.exe：这个是ET中提供的一个工具 这里指向该文件所在路径。 2.vzrtopg：这里包含7个字母，分别代表7中传输时的规则，指保持所有文件属性。 3.password-file：指定登录用的密码，避免额外输入。 4.delete：删除目标文件夹中的多余文件。 5.`./Output/` 指定本地的源文件夹路径。 6.`root@111.222.50.333::Upload/` 指定登录用的账号、目标主机的IP、目标路径(由模块名代替)。 7.chmod：设置新文件权限

# SSH命令+密钥

有时候我们希望可使用SSH命令远程控制Centos端执行一些简单的命令： `ssh -p 22 root@111.222.333.444 'reboot'` 这个过程中会提示需要输入密码。 配置好密钥后可以避免输入密码这个步骤。 **生成密钥** 在Centos中输入：`ssh-keygen -t rsa` 询问在哪保存key，直接回车使用默认地址（/root/.ssh）。 询问是否使用密码，可以直接回车，即不使用密码，避免额外的输入。 得到id\_rsa文件和id\_rsa.pub文件，前者为私钥，后者为公钥。 在Windows中我们也进行同样的操作，但是目录变成了： C:\\Users\\你的用户名.ssh\\id\_rsa.pub **在服务端添加可免密钥访问列表** 只需要将客户端的公钥添加到Centos上的authorized\_keys文件即可。 authorized\_keys文件在执行ssh-keygen命令后生成，可直接编辑： `vim /root/.ssh/authorized_keys` 一行一个公钥，持有任意配对成功的公钥的用户都可以访问。 注：Windows在第一次连接Centos服务器的时候，判断对方为未知主机，需用户确认后添加到known\_hosts。 如果Centos重置过系统，会导致本地主机无法识别，需要删除known\_hosts中对应的端口号。