title: 打造前端 Deepin Linux 工作环境——安装最新版本的火狐firefox浏览器
date: 2017-11-06 18:02:56 +0800
update: 2017-11-06 18:02:56 +0800
author: fungleo
tags:
    -firefox
    -deepin
    -火狐
    -前端
---

#打造前端 Deepin Linux 工作环境——安装最新版本的火狐firefox浏览器

尝试使用 `apt-get` 命令安装火狐浏览器，但是，居然是 `55` 的版本，而最新的已经是 `56` 了。当然，这并不是我最关心的。而是重要的是，我需要的一些插件只能在最新版本的火狐浏览器里安装。这就让我有点小小的不爽了。

没关系，我们手动安装最新版本的火狐浏览器即可。

首先，我们在火狐浏览器官方找到最新版本的中文版本的下载地址。打开官方网站：http://www.firefox.com.cn/download/#more

![](https://raw.githubusercontent.com/fengcms/articles/master/image/77/361221769fc6ab30c915b76440c2ac.png)
我右击，复制出来链接地址，进入终端，开启装逼模式：

```#
# 进入下载目录
cd ~/Downloads/
# 下载安装包
wget http://download.firefox.com.cn/releases/firefox/56.0/zh-CN/Firefox-latest-x86_64.tar.bz2
# 解压压缩包(我用的是 atool 工具，标准命令是：tar -jxvf 难记，建议安装 atool)
atool -x Firefox-latest-x86_64.tar.bz2
# 移动文件到系统目录
sudo mv firefox/ /opt/
# 创建图标文件
sudo vim /usr/share/applications/firefox.desktop
```

进入 `vim` 之后，输入以下内容：

```#
[Desktop Entry]
Name=Firefox
Exec=/opt/firefox/firefox
Icon=/opt/firefox/browser/icons/mozicon128.png
Terminal=false
Type=Application
Categories=Application;Network;
```

`:wq` 保存退出。

然后，我们的应用列表里面就有最新版本的火狐浏览器了。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/a1/4e193c154c856731bd9a0dfedd084a.png)

好，然后我们就能打开火狐愉快的玩耍了！

本文由FungLeo原创，允许转载，但转载必须附注首发链接。谢谢。

## 2017年11月17日补充

火狐浏览器已经升级到57版本了。照以上教程也是一样安装的，没有问题。如果之前按照本教程安装了56的版本，只需要用火狐自带的升级功能升级一下，就升级到57版本了。