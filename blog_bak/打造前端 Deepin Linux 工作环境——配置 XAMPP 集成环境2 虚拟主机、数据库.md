title: 打造前端 Deepin Linux 工作环境——配置 XAMPP 集成环境2 虚拟主机、数据库
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -数据库
    -mysql
    -虚拟主机
    -deepin
    -前端
---

#打造前端 Deepin Linux 工作环境——配置 XAMPP 集成环境2 虚拟主机、数据库

再上一篇博文当中，我们安装上了 `XAMPP` 集成环境。这一篇，我们继续进行配置。

## 配置 mysql 数据库 简写命令

首先，`XAMPP` 默认情况下，启动 `mysql` 命令行，也是一个比较长的命令：

```#
/opt/lampp/bin/mysql
```

我们用上一篇博文中同样的方法，给 `~/.bash_profile` 文件中增加一句

```#
echo 'alias mysql="/opt/lampp/bin/mysql"' >> ~/.bash_profile && . ~/.bash_profile
```
执行上面这一句命令，就可以给 `~/.bash_profile` 文件末尾追加内容，并且同时执行 `. ~/.bash_profile` 使它生效。

好，我们来执行一下命令，看看能否正常的连接数据库

![](https://raw.githubusercontent.com/fengcms/articles/master/image/ff/c112002775a23ac0ab92660a338410.png)
> 前提条件是，你的 xampp 要跑起来哦，如果是关闭状态，当然是连接不上的。

## 配置 XAMPP 自带 mysql 的密码

在默认情况下，xampp自带的 mysql 的用户名为　root ，但是默认密码为空，所以，我们需要给mysql 设置一个密码。

继续命令行：

```#
// 如果你上面的配置成功了，输入mysql即可进入mysql命令行模式
// 用 root 用户登录 mysql
mysql -u root
// 打开 mysql 这个数据库（这里的mysql 和上面的 mysql是不一样的，这个是库名，上面是命令）
use mysql
// 将 mysql 的 root 用户密码设置为 123456
UPDATE user SET password=PASSWORD('123456') WHERE user='root';
// 使修改生效
flush PRIVILEGES;
// 退出 
exit
```
![](https://raw.githubusercontent.com/fengcms/articles/master/image/b3/4617c83093940294a9d9690fe5b636.png)
好，如上图所示，现在我们登录 `mysql` 就必须输入密码了。

一般来说，我们习惯在图形界面下管理数据库，但是在 `linux` 我暂时没有很认真的找一下有哪些好用的免费开源的数据库管理软件，如果你有的话，非常感谢你能够在评论中给出意见。

我推荐使用 `mycli` 这款终端下的 `mysql` 管理软件管理，比自带的命令行好用多了，可以补全命令。

使用以下命令安装：

```#
sudo apt-get install mycli -y
```

使用方法基本与 `mysql` 自带命令行一致。可以自己体验以下。

如果实在是不喜欢命令行，也可以使用 `phpmyadmin` 来进行管理。

## 配置 apache 虚拟主机

** 配置 apache 主配置文件**

```#
sudo vim /opt/lampp/etc/httpd.conf
```

进入后，搜索`<Directory />`，如果VIM不熟悉，请用方向键慢慢往下找！将这里面的内容替换成如下配置：

```#
<Directory />
    Options Indexes FollowSymLinks Includes ExecCGI
    AllowOverride All
    Require all granted
</Directory>
```

然后搜索 `DirectoryIndex` 这里是配置默认首页文件的。将配置修改为以下（或者你项目常用的）

```#
DirectoryIndex index.htm index.html index.php
```

然后搜索 `httpd-vhosts.conf` 这个，这个文件是配置虚拟主机的文件，需要把最前面的`#`号删除（在这个配置文件中`#`是代表注释的意思），如下：

```#
# Various default settings
Include etc/extra/httpd-default.conf
```

全部编辑完成后，我们按 `esc` 退出编辑模式，输入 `:wq` 命令保存退出。

**好，下面继续配置虚拟主机。**



```#
# 我们在家目录中创建 Site 文件夹，并在里面创建一个 mySite 的子文件夹
mkdir -p ~/Site/mySite
# 在子文件夹中，我们创建一个 index.html 文件，并写入 hello world
echo "hello world" > ~/Site/mySite/index.html
# 编辑虚拟主机配置文件
sudo vim /opt/lampp/etc/extra/httpd-vhosts.conf
// 进入VIM编辑这个文件
```
把里面原有的内容清空，输入下面的内容
```#
<VirtualHost *:80>
    ServerAdmin web@fengcms.com
    DocumentRoot "/home/fungleo/Site/mySite"
    ServerName my.com
    ServerAlias my.com
    ErrorLog "logs/web-error_log"
    CustomLog "logs/web-access_log" common
</VirtualHost>
```

`:wq` 命令保存退出

>上面的 `fungleo` 是我的用户名。你的具体路径可以用 `cd ~/Site/mySite && pwd` 查看

**配置hosts文件**

继续命令行

```#
// 编辑 hosts 文件，可能会要求输入密码
sudo vim /etc/hosts
// 进入VIM编辑
```
在里面插入
```#
127.0.0.1       my.com
```

`:wq` 命令保存退出

> `sudo` 是申请超级权限的意思。因为 `/etc` 是系统目录，所以编辑里面的文件需要申请超级权限。在`linux` 下面也是同样的命令

**重启 xampps ，测试一下**

```#
xprs
```

重启成功后，我们在浏览器中输入 `my.com` 应该，就能打开你自己的这个网站了。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/ae/0513e9e288b288da03b26ab7640d2d.png)
如果需要配置多个网站，则在 `/opt/lampp/etc/extra/httpd-vhosts.conf` 中再增加一套上面的那样的配置参数，然后在增加一个本地域名解析，然后再重启就好了。

好，到这里，我们的配置就基本已经完成了，可以新增一个虚拟主机啊上面的。

本文由FungLeo原创，允许转载，但转载必须附注首发链接。谢谢。