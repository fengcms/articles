title: CentOS 7 配置 Nginx + php + mysql 搭建 lnmp 环境过程全纪录
date: 2017-12-13 11:25:11 +0800
update: 2017-12-13 11:25:11 +0800
author: fungleo
tags:
    -centos
    -nginx
    -php
    -mysql
    -lnmp
---

# CentOS 7 配置 Nginx + php + mysql 搭建 lnmp 环境过程全纪录

昨天搞了一个美国的便宜 `VPS` 给朋友搭建一个简单的 `php+mysql` 的小站。本来我是准备用 `lamp` 环境的。反正也是非常简单的一件事情。但是考虑我之前没有配置过 `lnmp` 的环境，所以准备实战一下。

## CentOS 7 服务器基本配置

服务器初始安装系统之后，我们就可以利用 `ssh` 连接上服务器终端了。如果使用的是 `windows` 系统，可以使用 `putty` 之类的工具进行连接。我是 `mac` 系统，所以不需要这些。

你可以选择一直用密码登录，不过我喜欢用 `key` 登录，这样可以免密码。

> 这里，我们都使用 `root` 最高权限的用户来进行管理。如果你使用的是普通用户，在执行大多数命令的时候都没有权限，需要在前面加上 `sudo`。

### 配置 key 秘钥登录服务器 （可跳过）

这一步配置可以跳过，并且只适合 `mac` 或者 `linux` 系统。`windows` 系统理论上是可以的，但是操作比较麻烦，并且和我下面说的不太一致。

**配置服务器端**
首先用密码登录服务器。

```#
# 安装 vim 工具
yum install vim -y
# 新建 ssh 配置目录
mkdir ~/.ssh
# 创建自动秘钥登录配置文件
touch ~/.ssh/authorized_keys
# 编辑配置文件
vim ~/.ssh/authorized_keys
```
然后把自己的秘钥粘贴进去。

**配置客户端**

本地生成自己的秘钥等，我这里不说了，不清楚的可以自行搜索一下。

```#
vim ~/.ssh/config
```

在里面添加如下内容

```#
# 配置服务器简写
Host myserver
# 配置服务器IP
Hostname 100.100.100.100
# 配置服务器ssh连接端口，默认是22则不用配置，但建议修改默认端口号，避免被黑客扫描
Port 22
# 配置默认登录用户
User root
```

好，经过上面客户端和服务端的配置之后，我们就可以在本地用非常简单的命令登录服务器了。

登录服务器命令如下：

```#
ssh myserver
```

除了登录服务器变得异常简单，不用密码。我们使用 `scp` 传输文件也变得异常简单

```#
# 传输单个文件到服务器
scp ~/.vimrc myserver:~
# 传输单个文件夹到服务器
scp -r ~/.vim myserver:~
```

更多 `scp` 命令请参考相关资料，这里不做过多延伸。

### 更新服务器系统以及软件，安装常用工具

一般来说，云服务器或者 `vps` 安装的系统镜像都不是最新的，所以我们连接上服务器之后，必须尽快更新服务器的系统以及软件，这样可以更好的保障我们的服务器系统安全。

**服务器系统以及软件升级命令**

```#
yum -y update
```

`CentOS` 系列的服务器系统有一个毛病，就是官方自带的源的软件比较古老，并且很多的软件都没有。因为他们的首要任务是保证服务器的稳定，而不是追求最新。但是太过于保守了，一般来说，我们会给服务器添加一个 `epel-release` 这个源。这个源里包含了例如 `nginx` 之类的我们需要的软件，使用起来比较方便。

**安装 `epel-release` **

```#
yum install epel-release -y
```

通过上面的命令进行安装。确认是否安装成功，可以用下面的命令检测一下

```#
yum search nginx
```

如果搜索的结果包含下面的这行内容，就表示安装成功了，然后我们就能愉快的安装我们需要的软件了。

```#
nginx.x86_64 : A high performance web server and reverse proxy server
```

我昨天在配置的时候发现不能搜索出来，但是确实是安装上了。后来检查了一下 `/etc/yum.repos.d/epel.repo` 文件，发现里面配置不对，修改了一下就好。

主要是 `epel` 段落中的 `enabled` 值默认设置为 `0` 了，我们将值改成 `1` 就可以了。

> PS：你应该没这个问题。如果遇到了问题，可以看下这里。如果是其他问题，请自行搜索解决。 

**安装服务器常用软件**

前面我们登录上服务器之后，第一件事情就是安装了 `vim` 编辑器。但我们在工作中，可能会需要各种各样的软件，例如我经常使用的如下：

```#
# wget 下载工具
yum install wget
# 统一各种格式压缩文件的工具
yum install atool
# tmux 好用的终端工具(如何使用请自行搜索)
yum install tmux
# zsh 最好用的终端
yum install zsh
# 替代 top 命令的好工具
yum install htop
# git 代码版本管理工具
yum install git
```

上面这些常用软件可以根据你自己的需求进行选择安装。不是都必须安装的。

什么 `zsh` 之类的配置，可以使用 `oh-my-zsh` 这个配置工具，具体搜索一下。网上教程很多。不是必须的。

## 配置 lnmp 服务器环境

好，准备工作差不多了，下面正式开始。

### 安装 nginx

如果你是直接跳到这段看的，请确保你已经运行过下面的命令安装过 `epel-release` 。如果不是，请跳过这条命令。

```#
yum install epel-release -y
```

开始安装：

```#
# 安装 nginx
yum install nginx -y
# 启动 nginx
systemctl start nginx
# 将 nginx 设置为开机启动
systemctl enable nginx
```

好，通过上面三条命令执行之后，应该可以在浏览器中直接用服务器IP可以访问到 `nginx` 默认的首页了。

### 安装 php

`nginx` 安装好之后，我们就需要来安装我们的 `php` 环境了。

**安装 php**

执行下面的命令，安装 `PHP` 已经它的常用的库

```#
yum install php php-mysql php-fpm php-gd php-imap php-ldap php-mbstring php-odbc php-pear php-xml php-xmlrpc -y
```

**配置 php**

安装完成之后，我们需要对它进行一些配置。首先，我们打开配置文件：

```#
vim /etc/php.ini
```

打开文件后，我们找到 `cgi.fix_pathinfo` 并把它的值设置为 `0`

> 大概在 763 行

配置好 `php.ini` 文件之后，我们来配置 `/etc/php-fpm.d/www.conf` 文件

```#
vim /etc/php-fpm.d/www.conf
```

第一处修改，将 `listen = 127.0.0.1:9000` 修改为如下：

```#
listen = /var/run/php-fpm/php-fpm.sock
```

然后找到下面两行，删掉前面的 `;` 分号，取消注释。
```#
listen.owner = nobody
listen.group = nobody
```

最后，我们找到下面两行

```#
user = apache
group = apache
```

将 `apache` 换成 `nginx`，如下所示：

```#
user = nginx
group = nginx
```

好，这样，我们就已经安装并且配置好了。下面我们可以启动了。

```#
# 启动PHP
systemctl start php-fpm
# 将它设置为开机启动
systemctl enable php-fpm
```

### 配置 nginx 使其支持 php

好，我们在安装好 `nginx` 和 `php` 之后，他们还不能协同作战，我们需要对 `nginx` 进行一些配置才可以。

首先，我们打开  `nginx` 的配置文件

```#
vim /etc/nginx/nginx.conf
```

然后在 `server` 这一段的花括号中，添加如下内容：

```#
    location ~ \.php$ {
        try_files $uri =404;
        fastcgi_pass unix:/var/run/php-fpm/php-fpm.sock;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
    }
```

另外，还需要配置默认的首页文件，我们找到 `index index.html index.htm;` 这段配置，在中间添加 `index.php` 。如下所示：

```#
index index.php index.html index.htm;
```

好，经过这样的简单配置，我们的任务就已经完成了。

```#
# 重启 nginx 服务
systemctl restart nginx
```

### 安装 MySQL(MariaDB)

`php` 的最佳拍档 `mysql` 我们还没有安装。这里，我们需要注意的是，自从 `mysql` 被收购之后，我们就不使用了，而是使用一个叫 `mariadb` 的从 `mysql` 发展而来的数据库，完全兼容。

除了名字不一样，哪哪就兼容。

```#
# 安装 mariadb
yum install mariadb-server mariadb
# 启动 mariadb
systemctl start mariadb
# 将 mariadb 设置为开机启动
systemctl enable mariadb
```

好，默认情况下，数据库的密码为空，我们需要设置一下，运行下面的命令：

```#
mysql_secure_installation
```

运行这个命令之后，根据提示进行相应的设置。一般情况下，就是不断的回车，以及输入你的密码，确认密码，然后一路回车即可。

## 配置小结

总体来说，整个配置过程还是非常顺畅的，和 `lamp` 环境有一定的差异，但是通过查找相关的资料，还是可以很快的解决问题的。

其他包括虚拟主机的配置等等，大家可以搜索 `nginx 配置虚拟主机` 关键词，来进行相关资料的查找。

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。

