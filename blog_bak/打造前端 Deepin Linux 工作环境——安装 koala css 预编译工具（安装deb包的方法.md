title: 打造前端 Deepin Linux 工作环境——安装 koala css 预编译工具（安装deb包的方法
date: 2017-11-04 18:06:02 +0800
update: 2017-11-04 18:06:02 +0800
author: fungleo
tags:
    -css
    -deepin
    -前端
    -koala
    -sass
---

#打造前端 Deepin Linux 工作环境——安装 koala css 预编译工具（安装deb包的方法）

`koala` 是国人开发的一个 `css` 预编译工具，可以编译 `sass\less` 之类的文件，非常好用的软件。我相信各位前端朋友都在 `windows` 或者 `mac` 平台上安装和使用过这款工具。

但是到目前位置， `koala` 还没有加入到包管理器中去。所以我们不能用命令行安装 `koala` 工具。下面，我们就来手动安装 `koala` 工具。

## 下载安装 koala

首先，我们到官方网站下载 `koala` 安装 `deb` 包。官方网址：http://koala-app.com/index-zh.html

目前最新版本为 `koala_2.2.0_x86_64.deb` 的安装包，现在我已经下载到了 `Downloads` 目录，然后执行安装命令：

```#
sudo dpkg -i koala_2.2.0_x86_64.deb
```

![](https://raw.githubusercontent.com/fengcms/articles/master/image/4c/8db3a7370587ac2303fb2001d6fdbe.png)
出错了。提示我们 `koala` 依赖 `ruby` 环境。那我们就先安装 `ruby`吧。

执行

```#
sudo apt-get install ruby -y
```

进行安装。但是我安装的时候出错了，提示我使用以下命令修复：

```#
apt --fix-broken install
```

我执行这个命令之后，顺利的修复，并安装好 `ruby` 了。

再重新执行

```#
sudo dpkg -i koala_2.2.0_x86_64.deb
```
进行安装，然后就顺利的安装好了。如下图所示：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/3c/32b82e04d201b9b794c01d182e9909.png)
然后就可以在菜单里面打开我们的 `koala` 了，如下图所示：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/f5/ce710b2483485548c498679236dcad.png)
> 出错了并不需要紧张，很多人初次接触命令行，总有一种莫名其妙的担心。其实是大可不必的。命令行的一个重大的优点就是出错了会告诉你详细的问题，一般情况下，还会给你解决方案。另外上图我已经设置为中文了。


## 关于 deb 软件安装包以及安装方法

`deb`是`debian linus`的安装格式，跟`red hat`的`rpm`非常相似，最基本的安装命令是：`dpkg -i file.deb`

`dpkg` 是`Debian Package`的简写，是为`Debian` 专门开发的套件管理系统，方便软件的安装、更新及移除。所有源自`Debian`的`Linux`发行版都使用`dpkg`，例如`Ubuntu`、`Knoppix` 等。

以下是一些 `Dpkg` 的普通用法：

```
dpkg -i <package.deb>
```
安装一个 `Debian` 软件包，如你手动下载的文件。
```
dpkg -c <package.deb>
```
列出 `<package.deb>` 的内容。
```
dpkg -I <package.deb>
```
从 `<package.deb>` 中提取包裹信息。
```
dpkg -r <package>
```
移除一个已安装的包裹。
```
dpkg -P <package>
```
完全清除一个已安装的包裹。和 `remove` 不同的是，`remove` 只是删掉数据和可执行文件，`purge `另外还删除所有的配制文件。
```
dpkg -L <package>
```
列出 `<package>` 安装的所有文件清单。同时请看 `dpkg -c` 来检查一个 `.deb `文件的内容。
```
dpkg -s <package>
```
显示已安装包裹的信息。同时请看 `apt-cache` 显示 `Debian` 存档中的包裹信息，以及 `dpkg -I` 来显示从一个 `.deb `文件中提取的包裹信息。
```
dpkg-reconfigure <package>
```
重新配制一个已经安装的包裹，如果它使用的是 `debconf` (`debconf `为包裹安装提供了一个统一的配制界面)。

以上有关 `deb` 的部分我转载的 http://blog.csdn.net/kevinhg/article/details/5934462 这里的。

一般情况下，我们只要知道如何安装就可以了。

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。