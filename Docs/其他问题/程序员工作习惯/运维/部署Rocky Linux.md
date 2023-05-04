# 部署Rocky Linux
Rocky Linux作为Centos的继任者，是我们作为游戏服务器的首选。  
这篇内容太旧了，等我下次用到的时候再更新。  

# 阿里云-安全组设置
需要根据服务器的用途开启特定端口的外网访问，临时开启的端口要记得改设置。  
网页服务器：80和443  
SSH工具：22  
数据库：3306(MariaDB默认端口)  

# 安装Nginx
## 随便创建一个repo文件用于设置Nginx的源
`cp /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/nginx.repo;`

## 修改Nginx的repo设置
sed -i -e '6,$d' -e '1c \[nginx\]' -e '2c name=nginx repo' -e '3c baseurl=http://nginx.org/packages/centos/7/$basearch/' -e '4c gpgcheck=0' -e '5c enabled=1' /etc/yum.repos.d/nginx.repo;

## 通过repo设置自动安装Nginx
yum install nginx -y; systemctl enable nginx;

## 开启gzip压缩 降低传输文件大小

sed -i -e '29a\\gzip on;' -e '29a\\gzip\_vary on;' -e '29a\\gzip\_proxied any;' -e '29a\\gzip\_comp\_level 6;' -e '29a\\gzip\_buffers 16 8k;' -e '29a\\gzip\_http\_version 1.1;' -e '29a\\gzip\_types image\\/svg+xml text\\/plain text\\/html text\\/xml text\\/css text\\/javascript application\\/xml application\\/xhtml+xml application\\/rss+xml application\\/javascript application\\/x-javascript application\\/x-font-ttf application\\/vnd.ms-fontobject font\\/opentype font\\/ttf font\\/eot font\\/otf;' /etc/nginx/nginx.conf;

# 一次性搞定域名、强制https、index.php默认文件、重定向、fastcgi设置

sed -i -e '10c index index.php index.html index.htm;' -e '3c server\_name www.acgmart.com; return 301 https://acgmart.com$request\_uri; } server { listen 443; server\_name acgmart.com; ssl on; ssl\_certificate /etc/nginx/1\_acgmart.com\_bundle.crt; ssl\_certificate\_key /etc/nginx/2\_acgmart.com.key; ssl\_session\_timeout 5m; ssl\_protocols TLSv1 TLSv1.1 TLSv1.2; ssl\_ciphers ECDHE-RSA-AES128-GCM-SHA256:HIGH:!aNULL:!MD5:!RC4:!DHE; ssl\_prefer\_server\_ciphers on;' -e '9a\\if (-f $request\_filename/index.html) {rewrite (.\*) $1/index.html break;}' -e '9a\\if (-f $request\_filename/index.php) {rewrite (.\*) $1/index.php;}' -e '9a\\if (!-f $request\_filename) {rewrite (.\*) /index.php;}' -e '12a\\location ~ \\.php$ {' -e '12a\\root /usr/share/nginx/html;' -e '12a\\fastcgi\_pass 127.0.0.1:9000;' -e '12a\\fastcgi\_index index.php;' -e '12a\\include fastcgi\_params;' -e '12a\\fastcgi\_param SCRIPT\_FILENAME $document\_root$fastcgi\_script\_name;}' /etc/nginx/conf.d/default.conf;

# 安装PHP
yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y; yum install php72 -y; yum install php72-php-fpm php72-php-gd php72-php-json php72-php-mbstring php72-php-mysqlnd php72-php-xml php72-php-xmlrpc php72-php-opcache php72-php-pecl-zip -y; systemctl enable php72-php-fpm.service;

# 修改Nginx的默认用户和用户组
sed -i -e '24c user = nginx' -e '26c group = nginx' /etc/opt/remi/php72/php-fpm.d/www.conf; 删除网站根目录下的默认文件 rm -rf /usr/share/nginx/html/\*; 创建info.php用于观测Nginx和PHP的运行状态 cp /etc/yum.repos.d/CentOS-Base.repo /usr/share/nginx/html/info.php; sed -i -e '4,$d' -e '1c <?php' -e '2c phpinfo();' -e '3c ?>' /usr/share/nginx/html/info.php; 提高PHP的默认设置和开启HugePage sed -i -e '383c max\_execution\_time = 300' -e '400c max\_input\_vars = 5000' -e '404c memory\_limit = 1000M' -e '672c post\_max\_size = 300M' -e '825c upload\_max\_filesize = 200M' -e '826a\\zend\_extension=opcache.so' -e '826a\\opcache.enable=1' -e '826a\\opcache.enable\_cli=1' -e '826a\\opcache.huge\_code\_pages=1' -e '826a\\opcache.file\_cache=\\/tmp\\/opcache' /etc/opt/remi/php72/php.ini; sed -i '32a\\vm.nr\_hugepages=200' /etc/sysctl.conf;

# 安装MariaDB
cp /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/MariaDB.repo; sed -i -e '6,$d' -e '1c \[mariadb\]' -e '2c name = MariaDB' -e '3c baseurl = http://mirrors.aliyun.com/mariadb/yum/10.3/centos7-amd64/' -e '4c gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB' -e '5c gpgcheck=1' /etc/yum.repos.d/MariaDB.repo; yum install MariaDB-server -y; systemctl start mariadb; systemctl enable mariadb; 初始化MariaDB并设置root用户的密码 mysql\_secure\_installation; 命令行登陆MariaDB,为WordPress创建一个数据库 mysql -u root -p; create database wordpress; \\q reboot 安装FTP yum install vsftpd -y; systemctl start vsftpd.service; systemctl enable vsftpd.service; sed -i '12c anonymous\_enable=NO' /etc/vsftpd/vsftpd.conf; useradd Sekia -s /sbin/nologin; usermod -d /usr/share/nginx/html/ -g root Sekia; 创建FTP专用文件夹并赋予777权限 mkdir /usr/share/nginx/html/FTP; chmod -R 777 /usr/share/nginx/html/FTP; 设置FTP用户的密码 passwd Sekia; 安装WordPress cd /usr/share/nginx/html/FTP; wget http://wordpress.org/latest.zip; unzip latest.zip; cp -R wordpress/\* /usr/share/nginx/html/; cp /usr/share/nginx/html/wp-config-sample.php /usr/share/nginx/html/wp-config.php; sed -i -e "23c define('DB\_NAME', 'wordpress');" -e "26c define('DB\_USER', 'root');" -e "29c define('DB\_PASSWORD', 'root');" -e "32c define('DB\_HOST', 'localhost:3306');" -e "33c define( 'WPMS\_ON', true );" -e "34c define('ALLOW\_UNFILTERED\_UPLOADS', true);" /usr/share/nginx/html/wp-config.php; 上传SSL证书文件并移动到Nginx配置中指定的位置 unzip Nginx.zip; cp /usr/share/nginx/html/FTP/1\_acgmart.com\_bundle.crt /etc/nginx/1\_acgmart.com\_bundle.crt; cp /usr/share/nginx/html/FTP/2\_acgmart.com.key /etc/nginx/2\_acgmart.com.key; 设置网站根目录的所有者为nginx chown -R nginx:root /usr/share/nginx/html/; 替换谷歌字体为国内服务商 sed -i "s/ajax.googleapis.com\\/ajax\\/libs/lib.baomitu.com/g" /usr/share/nginx/html/wp-includes/script-loader.php; 重启服务器 sed -i "s/ajax.googleapis.com\\/ajax\\/libs/lib.baomitu.com/g" /usr/share/nginx/html/wp-includes/script-loader.php; 在这个代码案例中创建了以下文件和帐号，大家根据自己的情况修改即可。 域名：acgmart.com；www.acgmart.com 证书文件：1\_acgmart.com\_bundle.crt；2\_acgmart.com.key FTP帐号：Sekia 数据库用户帐号和密码：root/root 数据库：wordpress MariaDB占用的端口号：3306 主题的压缩文件：Avada.zip 将证书文件打包压缩后：Nginx.zip 安装成功后，浏览器访问域名就会自动跳转到语言选择界面。


# Centos虚拟机安装与网络设置


\[toc\]使用虚拟机作为测试开发用的服务器。 安装Centos虚拟机和相关的网络设置，使虚拟机可以联网且与主机组成区域网。 一.安装虚拟机步骤 1.创建虚拟机-自定义 2.稍后安装操作系统(提前准备好.iso文件) [Centos官网](https://www.centos.org/download/ "Centos官网")找下载地址，可以选择一个镜像站，通常路径都是`http://网址/centos/大版本号/isos/x86_64/CentOS-8.1.1911-x86_64-dvd1.iso`。 举例：`http://mirrors.aliyun.com/centos/` 举例：`http://mirrors.aliyun.com/centos/7.8.2003/isos/x86_64/CentOS-7-x86_64-Minimal-2003.iso` 3.选择系统类型Centos6/7 64位 4.选择虚拟磁盘路径 5.选择网络模式： NAT网络：虚拟网卡-与主机组成局域网-虚拟机可能无法上网-可自由设定外网IP 桥接网络：共享网卡-与主机组成局域网-可以上网-外网IP自动分配在主机的网段 **服务器设计IP**：是192.168.1.100(1号网段)或者192.168.11.200(11号网段)都差别不大，地址需要固定死。 拿虚拟机作为服务器使用时，虚拟机没必要联通internet，但是要提供一个固定的IP给客户端访问。 **主机IP**：由猫或者路由器决定，用网线(192.168.1.3)或Wifi(192.168.31.10)会更改IP。 **NAT网络切换网段**：编辑-虚拟网络编辑器-更改设置(管理员)-选择VMnet8(NAT模式)-设置子网IP-**192.168.XXX.0** 6.创建完成，其他选项可选择默认值。 二.编辑虚拟机设置 1.自定义硬件-CD-指定.iso文件 2.移除打印机、声卡 三.安装系统 **Centos6**： 1.开启此虚拟机-点击虚拟机屏幕范围 2.选项1-安装 3.跳过检查(Skip) 4.检测到不支持的硬件(OK) 5.Basic Storage Devices - Yes,Discard any data. 6.Hostname:Sekia 7.root password:bidll123 8.Use All Space - Write changes to disk - Reboot **Centos7**： 1.开启此虚拟机-点击虚拟机屏幕范围 2.选项1-安装 3.选择语言-Done 4.安装配置总览 时间设置-设置时区、当前时间 软件安装设置-默认 磁盘分区-自动 网络和主机名设置-打开网卡-设置Host name-Done IPv4 Settings(可选)： Method：Manul 指定地址、掩码、网关 192.168.XXX.XXX 255.255.255.0 192.168.XXX.1 全部设置好后可以选择Begin Installation(开始安装) 5.设置root密码-(可选-添加额外账号) 6.等待安装完成-选择重启 三.网络配置 网络设置解释： 桥接模式下，主机与虚拟机在同一个网段，桥接的目标是主机正在使用的网卡。 IP中的第3个数一致时，即在同一个网段。 如果使用了路由器，根据品牌(如小米、华为)，可能会将主机分配到非1号网段。 去掉路由器直接连猫再重启电脑，就可以被分配到1号网段。 设置好虚拟机的网关和IP后，虚拟机可以联网，虚拟机和主机可以互ping(可能需关闭主机的防火墙)。 **网络设置**： Centos6: vi /etc/sysconfig/network-scripts/ifcfg-eth0 Centos7(直接在安装时的网络设置中填写 这里仅用于修改): vi /etc/sysconfig/network-scripts/ifcfg-ens33 (Centos7的值需要填在“”里，根据文件里已有的格式即可。) BOOTPROTO=static ONBOOT=yes IPADDR=192.168.XXX.XXX NETMASK=255.255.255.0 GATEWAY=192.168.XXX.1 DNS1=8.8.8.8 **关闭防火墙**： Centos6: chkconfig iptables off Centos7： systemctl stop firewalld systemctl disable firewalld **重启网络服务**： service network restart **查看虚拟机IP**： ip addr **测试网络连通性**： ping baidu.com ctrl+C ping 192.168.XXX.XXX(主机的IP) ctrl+C

# 手动安装vm-tools

准备安装文件： mkdir /mnt/cdrom;mount /dev/cdrom /mnt/cdrom;cd; tar zxpf /mnt/cdrom/VMwareTools-x.x.x-yyyy.tar.gz(根据自己看到的版本修改) umount /dev/cdrom 安装依赖： yum -y update;yum -y install kernel-headers kernel-devel gcc 查看内核版本： uname -r;rpm -qagrep kernel [需要Kernel、Kernel-devel、Kernel-headers版本一致](https://www.cnblogs.com/jianshuai520/p/10649313.html "需要Kernel、Kernel-devel、Kernel-headers版本一致") 安装vm-tools cd vmware-tools-distrib;sudo ./vmware-install.pl 如果系统版本过高，会推荐使用集成工具，是否继续，回复yes(有坑)。

# Centos7前端配置

**安装Nginx**： `cp /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/nginx.repo;sed -i -e '6,$d' -e '1c [nginx]' -e '2c name=nginx repo' -e '3c baseurl=http://nginx.org/packages/centos/7/$basearch/' -e '4c gpgcheck=0' -e '5c enabled=1' /etc/yum.repos.d/nginx.repo;yum install nginx -y;systemctl enable nginx;` **安装PHP**： `yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y;yum install php72 -y;yum install php72-php-fpm php72-php-gd php72-php-json php72-php-mbstring php72-php-mysqlnd php72-php-xml php72-php-xmlrpc php72-php-opcache php72-php-pecl-zip -y;systemctl enable php72-php-fpm.service;` **配置PHP**：使用nginx作为Web引擎 `sed -i -e '24c user = nginx' -e '26c group = nginx' /etc/opt/remi/php72/php-fpm.d/www.conf;` **配置Nginx**：可使用php文件作为主页 `sed -i -e '10c index index.php index.html index.htm;' -e '9a\if (-f $request_filename/index.html){rewrite (.*) $1/index.html break;}' -e '9a\if (-f $request_filename/index.php){rewrite (.*) $1/index.php;}' -e '9a\if (!-f $request_filename){rewrite (.*) /index.php;}' -e '12a\location ~ \.php$ {' -e '12a\root /usr/share/nginx/html;' -e '12a\fastcgi_pass 127.0.0.1:9000;' -e '12a\fastcgi_index index.php;' -e '12a\include fastcgi_params;' -e '12a\fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;}' /etc/nginx/conf.d/default.conf;` **创建info.php页面**:检查php状态(访问http:你的IP/info.php) `rm -rf /usr/share/nginx/html/*;cp /etc/yum.repos.d/CentOS-Base.repo /usr/share/nginx/html/info.php;sed -i -e '4,$d' -e '1c <?php' -e '2c phpinfo();' -e '3c ?>' /usr/share/nginx/html/info.php;` **安装网络工具(可使用netstat命令)**： `yum install net-tools -y;`