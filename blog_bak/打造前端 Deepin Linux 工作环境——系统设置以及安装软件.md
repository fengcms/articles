title: 打造前端 Deepin Linux 工作环境——系统设置以及安装软件
date: 2017-11-03 12:58:52 +0800
update: 2017-11-03 12:58:52 +0800
author: fungleo
tags:
    -deepin
    -linux
    -前端
    -软件安装
---

#打造前端 Deepin Linux 工作环境——系统设置以及安装软件


## 系统的基本设置

由于 `deepin` 系统做得太多，以至于，我们常见的在 `linux` 上要进行的工作，基本上都不需要进行了。属于开箱即用的感觉。

默认，任务栏是模仿MAC系统的 `dock` 栏的样式，不过这个东西，我在 `mac` 上都是关掉的，所以还是调整成 `windows` 的样式为好。

在状态栏空白处右击，在菜单里的模式里面，可以切换**时尚模式和高效模式**，这里，我们选择高效模式。在大小里面，我们选择小。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/aa/2b7f3cea029f2ff607f20491bd5d5a.png)
基本上没有什么驱动的问题，我们就可以正常的工作了。点击状态栏上的设置图标，可以打开设置面板。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/93/fe593cf754e734fdcb9ce65304eaac.png)
在这里可以进行系统的全部设置。基本上没什么要做的，你可以自己尝试一下。

## 软件安装

`deepin` 提供了一个图形化的 **深度商城** 来安装软件，我目测了一下，感觉还是非常好用的。尝试在图形界面下搜索 `Haroopad` 然后顺利的安装上了。现在这篇博文就是在 `Haroopad` 这款 `markdown` 编辑器中书写的。感觉还是比较好的。

这里我就不说图形界面如何安装软件了，我们来讲一下如何使用命令行安装软件。

### 命令行安装 atool 压缩软件

首先，我们打开终端。和 `arch` 下的 `pacman` 包管理器，或者 `mac` 下的 `brew` 包管理器不一样，`deepin`的包管理器的搜索和安装分别是两个命令。搜索命令是 `apt-cache search xxx` 这样的命令，而安装则是执行 `apt-get install xxx` 这样的命令。

没有什么好与不好的，习惯了就好。

```#
# 搜索软件
apt-cache search atool
# 安装软件
sudo apt-get install atool
```

同样，安装软件是需要超级权限的，在命令前面加上 `sudo` ，回车后需要输入你的密码。第一次使用 `linux` 的朋友需要注意，这里，输入密码是看不见的（连星号都不会有），盲输入。

这一段，我们就应该掌握了命令行安装软件的基本方法。可以使用图形界面安装的软件，基本上都可以使用命令行安装。但反之，则不然，所以，我感觉还是很有必要掌握命令行安装软件的方法的。

另外，你可能不知道需要安装什么软件。没关系，我在后面会陆续讲到的。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/ac/1397c91e05d36ed39fc32c10bcd890.png)
### 安装 photoshop

由于 `deepin` 做得太细致了，什么QQ呀，`wps` 办公软件呀，都给你安装好了。除了需要安装点其他的开发软件，基本上日常使用没什么需要配置的。

但是，安装 `photoshop` 这个就有点高大上了。

首先，我们打开软件 `CrossOver` 这个软件，能够安装 `windows` 上的软件，全是这个软件的功劳。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/4c/95952a7d94af6f34bae73a3dbcf6ea.png)
我们点击 **安装 windows 软件** 	按钮

![](https://raw.githubusercontent.com/fengcms/articles/master/image/ec/1408fc19a856190b4c84c618a5844b.png)
在弹出来的面板中，我们搜索 `photoshop` 然后下拉菜单中会出现多个版本，然后 `cs2` 的版本表示近乎完美，那么我们就安装这个版本吧。点击继续。

> 上面有更新提示，我们点击 总是更新

然后我发现，需要我自己去找安装包 -_-|||，好吧，我去找一个，目前 `downloading`

> 由于cs2的版本也是历史悠久了，我找到了一个下载地址：http://www.9ht.com/xz/32219.html ，我不保证你在下载的时候，这里还是可以正常下载的。请自行找一个地方下载。

下载好安装包文件，解压到任意文件夹（不要问我任意文件夹是哪个文件夹）

![](https://raw.githubusercontent.com/fengcms/articles/master/image/c2/4c2881514d0d34d8198532acf5a542.png)
我们点击**选择安装文件夹**然后在出来的选框里面，选择我们的解压的文件夹，就可以出现如上图所示的，我们点击继续。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/60/0265b8dc8a85a80ea73fb4f507b9fd.png)
点击**安装**

![](https://raw.githubusercontent.com/fengcms/articles/master/image/94/fca9599e6b80ffe0147767316f9edf.png)
然后就开始安装了，后面有一系列的设置，下一步什么的，我忘记截图了。中间或者还有报错页面，我也没管。但后面仔细一看，安装成功了。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/49/fc6ec59d7ff522055ee4b95295ebce.png)
我右击，创建了一个收藏夹图标，点击，就可以打开 `photoshop` 了。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/7e/456b4d38ef7865f64ac8aaf9841e8f.png)
如上图，正常打开了软件。

## deepin 安装软件小结

1. 可以通过官方自带的 深度商店 安装常见的软件
2. 可以通过 apt-get install 命令，安装各种 linux 上的软件
3. 可以通过 CrossOver 安装 windows 软件

通过这三种软件的安装方式，我们就可以很好的安装各种软件了。

我们按 `win` 键，可以打开类似 windows 的开始菜单，里面会有各种软件的图标，点击图标就可以打开软件了。另外，右击图标，可以卸载软件。

后面，我们继续来配置我们的前端工作环境。

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。