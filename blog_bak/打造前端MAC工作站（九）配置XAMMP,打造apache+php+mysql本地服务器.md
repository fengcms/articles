title: 打造前端MAC工作站（九）配置XAMMP,打造apache+php+mysql本地服务器
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -apache
    -php
    -mysql
    -mac
    -XAMMP
---

# 打造前端MAC工作站（九）配置XAMMP,打造apache+php+mysql本地服务器

## 前言

虽然我们是前端工程师，但是以php+mysql为开发语言和数据库的程序还是很多的。包括本人开发的`fengcms`系统，都是。如果你的公司或者你从事职位不需要涉及到php和mysql，那么你没必要安装这个东西。如果有，那就整一个呗。

其实`mac`是自带了`apache`的。但是我自己配置了一下，放弃了，缺少很多组件，又不知道怎么安装。我是拿这个来工作的，而不是折腾着破玩意儿的，所以果断放弃了。如果你有心研究，你可以自己尝试开启`mac`自带的`apache`，不过我不推荐。

在`mac`下面有一个非常好用的集成环境软件`xampp`，当然，这款软件是跨平台的，`windows`和`linux`上也都有。我想，你可能在`windows`上也用过这款软件。

话不多说，开干！

## 安装配置 XAMPP

首先到官方网站`https://www.apachefriends.org/zh_cn/index.html`下载MAC版本的安装软件。安装过程非常简单，打开后一路下一步即可。

安装完成后，会出现一个管理面板，打开时会要求你输入你的账户密码，输入即可。如下图所示：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/1b/53f1cb752d98dfd737b7ddc356566d.png)
图形界面的使用就不说了，异常的简单。不过，每次要跑这么个东西，我还是很别扭的。所以我推荐大家使用命令行来跑这个东西。

### 配置命令开启关闭重启 XAMPP

打开命令行工具——`iterm2`，输入下面的命令

```#
// 跳转到个人根目录
cd ~
// 查看有没有.bash_profile文件
ls -a
// 如果没有就创建一个，否则下一步
touch .bash_profile
// 编辑.bash_profile文件
vim .bash_profile
// 进入 vim 开始编辑，按 i 进入编辑模式
```

进入编辑模式后，粘贴如下代码进去：

```#
export CLICOLOR=1

#自定义缩写命令  生效命令  source ~/.bash_profile
alias xpst="sudo /Applications/XAMPP/xamppfiles/xampp start"
alias xpsp="sudo /Applications/XAMPP/xamppfiles/xampp stop"
alias xpre="sudo /Applications/XAMPP/xamppfiles/xampp restart"
alias mysql="/Applications/XAMPP/xamppfiles/bin/mysql"
```

粘贴好之后，按`esc`退出编辑模式，然后`shift+:`进入输入命令模式，输入`wq`保存退出。

然后执行

```#
source ~/.bash_profile
```

刚刚我们创建的这些命令短语就都生效了。我们可以在命令行输入下面的命令

```#
// 启动 XAMPP
xpst
// 然后会要求输入密码，你输入你当前用户的密码即可。需要注意的是
// 你输入任何字符你都看不见，这是unix和linux的特性

// 停止 XAMPP
xpsp
// 重启 XAMPP
xpre
// 进入 MYSQL 命令行
mysql
```

> 其实 `.bash_profile` 这个文件就是配置我们的常用命令简写的配置文件。你可以把你记不住的命令在这里配置成你能记住的短语，然后执行`source ~/.bash_profile`就能立即生效。

四个字母就能解决的问题，我想你应该不会迷恋那个图形界面的管理器了。

当我们启动XAMPP后，我们在浏览器中打开 `localhost` 看能不能打开 `xampp`的默认首页。如果能打开，则说明完全没有问题了。

### 配置 XAMPP 自带 mysql 的密码

在默认情况下，`xampp`自带的 `mysql` 的用户名为　`root` ，但是默认密码为空，所以，我们需要给`mysql` 设置一个密码。

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

好，我们已经设置好Mysql的密码了，可以尝试用下面的命令测试一下

```#
// 尝试用空密码登录 root 账户
mysql -u root
// 如果登录不进去，那就说明设置成功了
// 用密码登录输入下面的命令
mysql -u root -p
// 然后会要求你输入密码，输入123456就能进入mysql了
// 退出 
exit
```

> `mysql` 的图形管理软件，我使用的是 `Navicat Premium` 这一款。这款软件比较强大，可以管理不同的数据库。这款软件是收费的，我用的是破解版。下载地址请在我的[打造前端MAC工作站（二）安装软件的两种方法](http://blog.csdn.net/FungLeo/article/details/57543682)这篇博文里面找。

### 配置 XAMPP 支持虚拟主机

> 命令行中的 `vim` 编辑器不熟悉的同学，可以看下我的博文　[打造前端MAC工作站（五）让我们熟悉一下 MAC 命令行吧！](http://blog.csdn.net/fungleo/article/details/58623587)，中间简单介绍了VIM的基础使用方法。高级的也可以看我转载的博文，上面那篇博文里面有对应的链接。

**配置apache基础文件**

进入命令行

```#
// 进入 XAMPP 配置目录
cd /Applications/XAMPP/etc/
// 编辑配置文件
vim httpd.conf
// 然后进入VIM 编辑器
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

> 其实我有点坑大家。如果你是在是搞不定 `VIM` ,也可以用图形界面的文本编辑器来进行编辑的。具体自己搞去……我还是强调一下，作为一名合格的工程师，即便 `VIM` 不是特别熟悉，能用来做主力编辑器，最起码也要做到能使用的水平。

**好，下面继续配置虚拟主机。**

```#
// 在 ~ 下创建一个 Site 文件夹，用于放我们的网站
cd ~
mkdir Site
// 创建一个叫 mySite 的网站目录。你可以随便放点网页文件进去，我们将用xampp搭建服务器跑这个东西
cd Site
mkdir mySite
// 编辑虚拟主机配置文件
vim /Applications/XAMPP/etc/extra/httpd-vhosts.conf
// 进入VIM编辑这个文件
```
把里面原有的内容清空，输入下面的内容
```#
<VirtualHost *:80>
    ServerAdmin web@fengcms.com
    DocumentRoot "/Users/fungleo/Site/mySite"
    ServerName my.com
    ServerAlias my.com
    ErrorLog "logs/web-error_log"
    CustomLog "logs/web-access_log" common
</VirtualHost>
```

`:wq` 命令保存退出

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

**重启 xampps ，测试一下

```#
xpre
```

重启成功后，我们在浏览器中输入 `my.com` 应该，就能打开你自己的这个网站了。

如果需要配置多个网站，则在 `/Applications/XAMPP/etc/extra/httpd-vhosts.conf` 中再增加一套上面的那样的配置参数，然后在增加一个本地域名解析，然后再重启就好了。

## 小结

1. `vim` 编辑器真心很重要，不求用好，但求能用不懵逼。
2. `mysql`的管理软件除了下载我刚刚上面那个说的，你还可以在本地跑一个 `phpmyadmin`来管理，`phpmyadmin`其实就是一个网站的说，配置一个专用的管理数据库的本地网站即可。
3. 如果你在配置的过程中遇到什么问题，或者版本更新了和本博文不一致，建议利用搜索引擎解决问题。
4. 我不是`xampp`的专家，我只知道简单的配置后能用。所以更多内容请不要咨询于我。


本文由FungLeo原创，允许转载，但转载必须附注首发链接。谢谢。


