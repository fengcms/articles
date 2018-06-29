title: 打造前端 Deepin Linux 工作环境——配置 XAMPP 集成环境
date: 2017-11-03 20:16:01 +0800
update: 2017-11-03 20:16:01 +0800
author: fungleo
tags:
    -apache
    -mysql
    -php
    -deepin
    -xampp
---

#打造前端 Deepin Linux 工作环境——配置 XAMPP 集成环境

虽然前后端分离开发的我们，已经很少需要跑一个 `apache+php+mysql` 的集成环境了。但是我想可能还是有很多的人是需要跑这个环境的。所以我讲一下，这个东西到底是怎么配置的。

## 下载并安装 XAMPP 集成环境

首先，我们打开官方网站的下载页面 https://www.apachefriends.org/zh_cn/download.html 然后选择我们需要的版本进行下载，这里，我选择最新的版本，如下图所示：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/50/d469b87e0cfef3659c3fb5c104adbf.png)
我也是第一次下载安装 `XAMPP` ，以前在 `Arch linux` 是用命令行安装的，所以，我们来看一下帮助文档，点击下载页面右侧的 [linux常见问题](https://www.apachefriends.org/zh_cn/faq_linux.html)

好的，第一个就是告诉我们，如何来安装这个东东的。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/1b/78d617f9bacbd2cc49e1d324b5ad6e.png)
好的，我们来执行命令：

```#
# 设定安装文件的权限
chmod 755 xampp-linux-*-installer.run
# 用超级权限来执行安装文件
sudo ./xampp-linux-*-installer.run
```

运行结果如下图所示：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/b6/10591489299a3f85dd90aa17cd0d89.png)
然后居然很神奇的出现了这个图形界面的玩意儿。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/49/ecdf2d74e83802e484aca4a0bdbc81.png)
![](https://raw.githubusercontent.com/fengcms/articles/master/image/41/25866b80178cf2b24efd50a78d56a7.png)
![](https://raw.githubusercontent.com/fengcms/articles/master/image/d3/48006a31c787344d796310f45cf635.png)
![](https://raw.githubusercontent.com/fengcms/articles/master/image/b8/05aeb1cbfe609bc072c1ba877d9ea9.png)
这里有一个我们不需要的东西，我们去掉勾选。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/d1/bac080c02b3b3ee5104a79ae4bc4f8.png)
![](https://raw.githubusercontent.com/fengcms/articles/master/image/de/3d3c26f8541b7dd677656b1069f52f.png)
![](https://raw.githubusercontent.com/fengcms/articles/master/image/8b/8fb700c93c5f2524b311c159931907.png)
好的，安装完成了。然后就出现了这样的界面：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/7f/a4e6d9835718872076537076355eda.png)
然后，我们在浏览器中输入 http://127.0.0.1 就可以看到效果了。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/a1/29719ea8f1686d8fa2d28a713a0377.png)
好的。我们可以很方便的用图形界面来管理我们的 `xampp` 集成环境了，具体不再详述，使用过这个环境的朋友应该都知道怎么跑起来的。

## 配置 xampp 环境

首先，我们可以从刚刚的官方 `linux` 帮助文档里面找到两条命令，分别是启动和关闭 `xampp` 的。

```#
# 启动 xampp
sudo /opt/lampp/lampp start
# 关闭 xampp
sudo /opt/lampp/lampp stop
```

![](https://raw.githubusercontent.com/fengcms/articles/master/image/01/2928e28ea59ee1fb41b87a03a2654d.png)
但是这个命令确实是有点太长了。还记得我们前面讲的如何讲长的命令变成短的命令吗？这里，我们也来配置一下：

```#
vim ~/.bash_profile
```
编辑个人终端配置文件，录入以下内容
```#
alias xpst="sudo /opt/lampp/lampp start"
alias xpsp="sudo /opt/lampp/lampp stop"
alias xprs="sudo /opt/lampp/lampp restart"
```
然后 `:wq` 保存文件

```#
. ~/.bash_profile
```
使配置文件生效，然后我们运行以下我们的简写命令，看能否正常运行：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/f3/0ece5bab19617e5a8f48c2b27a2734.png)
如上图所示，我们的简写命令是可以运行的，嘿嘿，这样我们就可以用很短的命令来运行环境，并且，不用管那个控制面板了。

这篇博文已经很长了，下一章我们再来讲更多的配置。

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。