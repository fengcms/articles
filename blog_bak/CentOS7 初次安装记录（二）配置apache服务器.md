title: CentOS7 初次安装记录（二）配置apache服务器
date: 2015-11-17 16:50:13 +0800
update: 2015-11-17 16:50:13 +0800
author: fungleo
tags:
    -centos
    -apache
---

#CentOS7 初次安装记录（二）配置apache服务器
网络正常了，那么就要来配服务器了。我的目标很简单，配置一个 apache+php+mysql 的服务器即可。

首先，`yum -y update` 升级下所有的软件。

这个过程比较漫长，抽根烟等一会儿。

## 配置apache服务器

YUM 安装配置，简单方便可靠
```language
yum install httpd 
```
好，安装上了apache了，访问一下。我X，连接超时。啥情况？百度一下。

原来，CENTOS 7 默认拒绝所有连接 -_-!!!

```language
// 进入httpd 配置目录
cd /etc/httpd/conf
// 看一下有啥文件
ls
// 结果如下：
httpd.conf  magic
// 编辑 httpd.conf
vi httpd.conf
```
好，进入编辑模式了。

把里面的 `AllowOverride None` 全部修改为 `AllowOverride All`

顺便在 `DirectoryIndex index.html` 后面加上 `index.htm index.php index.shtml`

这个是配置默认首页的

`:wq` 保存退出 `service httpd restart` 重启 apache 服务，再访问一下。果然可以访问了。

这时候发现不对劲。怎么输入重启命令之后总提示个啥东西？百度一下，原来 centos7的命令换了。新的重启命令是`systemctl restart httpd.service` 我X这个不好了嘛！！这个没之前那个好记。既然原来的也可以用，那先不管了。

最后 `systemctl enable httpd.service` 设置 apache 开机启动。好吧，这里罗列一下 apache 常用命令。

```language
systemctl start httpd.service #启动apache
systemctl stop httpd.service #停止apache
systemctl restart httpd.service #重启apache
systemctl enable httpd.service #设置apache开机启动
```


**PS:为了不必要的麻烦，关闭防火墙**

```language
// 关闭firewall：
systemctl stop firewalld.service #停止firewall
systemctl disable firewalld.service #禁止firewall开机启动
// 关闭SELINUX
vi /etc/selinux/config
#SELINUX=enforcing #注释掉
#SELINUXTYPE=targeted #注释掉
SELINUX=disabled #增加
:wq! #保存退出
setenforce 0 #使配置立即生效
```

PS:所有相关资料均为百度所得。