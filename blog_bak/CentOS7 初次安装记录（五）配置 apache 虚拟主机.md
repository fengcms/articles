title: CentOS7 初次安装记录（五）配置 apache 虚拟主机
date: 2015-11-18 14:59:16 +0800
update: 2015-11-18 14:59:16 +0800
author: fungleo
tags:
    -centos
    -虚拟主机
    -服务器
---

#CentOS7 初次安装记录（五）配置 apache 虚拟主机

数据库也挪好了。下面准备配置虚拟主机。不准备安装乱七八糟的管理软件，就是能够支持一台服务器多个网站即可。

##apache 配置虚拟主机

学聪明了，不再凭借自己的经验来了，还是老老实实的百度吧 -_-

一般教程上来说，会说去修改 `/etc/httpd/conf/httpd.conf` 文件。但是我不推荐这样做。因为这个是主配置文件，比较长，也比较重要。我建议是在 `/etc/httpd/conf.d/` 下面建立一个 `vhost.conf` 文件来配置虚拟主机。

这样也方便管理。当然，还有人会说一个虚拟主机一个配置文件，我不反对，但我认为没有必要。

好。新建一个 `vhost.conf` 文件，命令如下：

```language
// 新建配置文件
vi /etc/httpd/conf.d/vhost.conf

// 下面是输入的内容 在明白其中含义的情况下，设置内的注释可以删除
#
# 测试网站一
#
<VirtualHost *:80>
#绑定的主域
ServerName test.com
#绑定的子域名
ServerAlias www.test.com
#网站主目录
DocumentRoot /home/website/com.test.www/
#日志配置
ErrorLog /home/web_log/com.test.www_error.log
CustomLog /home/web_log/com.test.www_access.log common
#ServerSignature Off
</VirtualHost>
#测试一的配置
<Directory "/home/website/com.test.www/">
    Options FollowSymLinks
    AllowOverride All
    Require all granted
</Directory>

// 如果有更多内容，重复上面的
```
然后，就是去 `/home/webstie/com.test.www/` 里面放上一个测试的html页面了

重启 httpd 服务 `systemctl restart httpd.service`

我了个擦擦擦~~~怎么又报错了啊？赶紧看看啥原因 `systemctl status httpd.service` 命令看看到底是啥原因。

我了个去。。。原来我忘记新建 `web_log` 文件夹了，因为找不到这个文件夹，所以就出错了。

赶紧去新建了这个文件夹，然后重启，一切顺利！OK，虚拟主机配置成功了！

下面要去研究研究配置FTP服务器了。