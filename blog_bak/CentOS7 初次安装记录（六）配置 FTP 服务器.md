title: CentOS7 初次安装记录（六）配置 FTP 服务器
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -centos
    -ftp服务器
    -vsftpd
---

下面要去研究研究配置FTP服务器了。

一直以来，我都是用 WinSCP 来上传下载文件的。当然，有高手直接用命令行来上传文件。我没试过，回头也可以研究一下。但是，有时候，我们不能把服务器的全部权限交给别人。这时候，FTP就显得很有作用了。

因为之前完全没有配过，所以百度了一下相关的资料。在 centos 上，一般都是使用 vsftpd 来实现FTP的，好吧。查找相关资料，开始实战！

##用 vsftpd 配置 FTP 服务器

yum 安装 vsftpd

```language
yum -y install vsftpd
```

很快就安装完成了。设定它开机自启动

```language
systemctl enable vsftpd.service
```

安装完成之后，就需要配置它了。到`/etc/vsftpd/`目录看看配置文件`vftpd.conf`
```language
// 编辑配置文件
vi /etc/vsftpd/vftpd.conf
// 配置开始
#设定不允许匿名访问 默认是YES
anonymous_enable=NO
#设定支持ASCII模式的上传和下载功能 默认前面有#号
ascii_upload_enable=YES
ascii_download_enable=YES
#使用户不能离开主目录 默认前面有#号
chroot_list_enable=YES

在最末尾，添加下面三行 不含注释
#设定启用虚拟用户功能 
guest_enable=YES
#指定虚拟用户的宿主用户，CentOS中已经有内置的ftp用户了
guest_username=ftp
#设定虚拟用户个人vsftp的CentOS FTP服务
user_config_dir=/etc/vsftpd/vuser_conf

```

新建 `chroot_list` 文件 写入 `guest_username` 这里是 `ftp`。
看的教程，没说清楚，我是 `vi chroot_list` 新建了这个文件，然后输入 `ftp` 保存退出。不知道对不对。

创建用户名密码文件，`vi /etc/vsftpd/vuser_passwd.txt` 奇数行用户名，偶数行密码。写好之后，保存退出。

生成DB文件，命令如下：
```language
db_load -T -t hash -f /etc/vsftpd/vuser_passwd.txt /etc/vsftpd/vuser_passwd.db
```
然后我`ls` 一下，果然看到了这个DB文件。

然后编辑认证文件 `vi /etc/pam.d/vsftpd`

```language
##把原有的内容全部注释，然后在下面写上
auth required /lib64/security/pam_userdb.so db=/etc/vsftpd/vuser_passwd
account required /lib64/security/pam_userdb.so db=/etc/vsftpd/vuser_passwd
```
我压根不明白这是干嘛，跟着教程走，教程说得不清楚。

接着创建虚拟用户配置文件。先新建文件夹 `mkdir /etc/vsftpd/vuser_conf/`

然后新建一个文件。文件名为你在`/etc/vsftpd/vuser_passwd.txt`里设置的用户名我这里是`test`

所以，我在建立好文件夹后，输入 `vi /etc/vsftpd/vuser_conf/test`

在里面输入配置内容

```language
#虚拟用户根目录,根据实际情况修改  该目录必须要有读写权限 chmod -R 777 目录 
local_root=/home/website/
write_enable=YES
anon_umask=022
anon_world_readable_only=NO
anon_upload_enable=YES
anon_mkdir_write_enable=YES
anon_other_write_enable=YES
```
然后设置Selinux
```
#设置ftp可以使用home目录
setsebool -P ftp_home_dir=1
#设置ftp用户可以有所有权限
setsebool -P allow_ftpd_full_access=1
```
我把selinux 关闭了，应该不用设置了。

然后教程说可以了。。。。准备启动ftp服务

```language
systemctl start vsftpd.service
```

好像没报什么错误。

用flashfxp链接一下看看。。。。果然连不上去！！！！我就知道肯定没这么顺利！！！告诉我错哪里了？？？

百度了一下，说是给配置文件加上 `allow_writeable_chroot=YES`

```language
vi /etc/vsftpd/vsftpd.conf
#在最后，加上
allow_writeable_chroot=YES
#然后重启ftp服务
systemctl restart vsftpd.service
```
我擦！！果然连上了！！！庆祝一下先，抽根烟去~