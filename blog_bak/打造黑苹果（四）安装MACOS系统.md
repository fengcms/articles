title: 打造黑苹果（四）安装MACOS系统
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -安装MACOS
    -黑苹果
    -黑MACOS系统
    -黑苹果安装
---

# 打造黑苹果（四）安装MACOS系统

## 前情回顾
[打造黑苹果（一）组装硬件的选择与组装](http://blog.csdn.net/fungleo/article/details/57412461)
[打造黑苹果（二）制作黑mac系统安装U盘](http://blog.csdn.net/fungleo/article/details/57414420)
[打造黑苹果（三）COMS(BIOS)设置](http://blog.csdn.net/fungleo/article/details/57415408)

## 前言

经过前面的步骤，我们可以正式开始我们的系统安装工作了。这里，我再提醒一下，如果你的硬件不支持黑MAC系统，又或者你的 `BIOS` 设置不正确的话，那么在这里是没办法进行下去的。会不断的重启呀之类的。

另外，再强调一点，内存条必须插在靠近CPU一侧的插槽上，否则是会不断重启的。

如果你确定你的硬件没有问题，内存条也插在正确的位置，但是还是不行，那么基本是 `BIOS` 设置有问题，就不断的调整，知道OK为止。

我没在这一步遇到太多的坑，除了内存条插的不对，但是也是经过反复尝试了几次的。

另外，你需要对你主板集成的网卡以及声卡的芯片有所了解，可以去中关村或者太平洋的网站上查，把芯片记下来，然后安装驱动的时候需要。

## 开始安装 MAC OS 系统

首先，第一步，插入你制作好的安装U盘，开机时选择U盘启动。再次强调一遍，是 **UEFI** 开头的U盘，而不是只是一个U盘名字的U盘。

选择U盘进入安装过程中之后，会出现一个四叶草的界面，如下图，我们选择如下图的图标 **Boot Mac OS X from USB** ，用方向键，左右键控制。选好了之后，我们回车，进入安装过程。忘记拍照了，这张图片是在网上找的。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/95/8d997c1dc63429b8356cee9f3a973d.jpg)
进入安装后，会出现黑色背景，白色的苹果LOGO，持续大概几分钟，会出现下图的界面，选择语言。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/72/7c177c6af11d8324920833a7bd8902.jpg)
我们选择**以简体中文作为主要语言** ，然后点击下面的圆形向右的箭头，进入到下面的图片，我们点击**继续**。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/37/39347028c16b2a4a37681263ce6af6.jpg)
![](https://raw.githubusercontent.com/fengcms/articles/master/image/92/bb4674a7774440beda906f34151c9b.jpg)
然后就出现了一个软件许可协议之类的东西，我们点击**继续**，会弹出一个对话框，**我已经阅读并同意软件许可协议的条款**，我们点击**同意**，然后进进入下图的界面。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/16/b363f8e9cca42ee387802b07767b11.jpg)
如果你准备安装MAC的固态硬盘没有格式化，那么，这里应该只有一个USB，如果安装过黑MAC，则会出现两个，就像我的这张图一样，我们点击顶部的**实用工具**，然后再下拉菜单里面选择**磁盘工具**，打开如下图的磁盘工具面板：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/e7/d2cfc38a06a2b6723f4646bc36dd79.jpg)
在磁盘工具面板的左侧，我们选中我们准备安装黑MAC系统的固态硬盘，然后点击标题栏下面的**抹掉**按钮，将会弹出如下图的**抹掉**面板。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/75/cbabf7fd39f71b28319124cee955de.jpg)
如上图所示，我们在**抹掉**面板中进行如下设置：

1. 名称，后面输入 MAC 
2. 格式，我们选择 ` OS X Extended (Journaled)`
3. 方案，我们选择 ` GUID Partition Map`

选择好后，我们点击下面的 **抹掉** 按钮。
然后会有一个进度条，完成后，会出现绿色的对勾图标。我们点击完成。（这里的界面和前面制作U盘是基本上一样的，就不放图片了。）
**这里，需要注意的是，有可能执行一次会失败，如果失败了，就再来一次，一般就成功了。**

完成之后，回到先前的选择安装盘的界面，我们点击 `MAC` ，也就是我们刚刚格式化的硬盘，然后**继续**，进入安装进度条界面。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/9a/a7a770a03360ae0c8df3e357e15b4c.jpg)
等待十几分钟，安装完成之后，会重启。

## 重启进入黑MAC设置过程

重启电脑的时候，我们依然要选择用U盘启动。在下面的四叶草的页面，我们选择 `HFS` 的图标，就是中间的这个，进入系统。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/95/8d997c1dc63429b8356cee9f3a973d.jpg)
这个时候因为驱动的关系，可能在显示器上只能显示中间一部分，周边有一圈黑边，没有关系，我们搞好之后就好了。等黑底白果的图标过后，就出现了下图，选择你的地理位置，我们选择中国，点击**继续**

![](https://raw.githubusercontent.com/fengcms/articles/master/image/5f/328168fff30e2072cad80b8a4ee0ed.jpg)
然后就到了输入法的设置页面了。你可以勾选**简体拼音**或者**五笔型**，根据你的需要，选择好之后，点击**继续**

![](https://raw.githubusercontent.com/fengcms/articles/master/image/9c/f0e9786ea0734afb0fcf1bbb0a4bcf.jpg)
然后就到了设置网络连接的页面。在这里，我们选择 **我的电脑不连接到互联网**选择好之后，点击**继续**，然后会弹出一个对话框，我们确定一下。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/f4/fe079eac94883f3609cb181962a16e.jpg)
然后就到了传输信息到这台MAC的设置页面，我们选择 **现在不传输任何信息** ，点击**继续**

![](https://raw.githubusercontent.com/fengcms/articles/master/image/7a/2aabdf153b9760feae48cbc64ca5c2.jpg)
然后是定位服务的设置，我们去掉 **在这台MAC上启用定位服务** 前面的勾选，点击**继续**，会弹出确认对话框，我们点击**不使用**

![](https://raw.githubusercontent.com/fengcms/articles/master/image/72/ce920d73cadaff5118d6d1a9267857.jpg)
然后是条款与条件界面，愿意读一下吗？我是直接点击 **同意**

![](https://raw.githubusercontent.com/fengcms/articles/master/image/c0/db384126cbeeb63c5a5626f6f8c9bf.jpg)
弹出对话框，确认一下，我们继续点击 **同意**

![](https://raw.githubusercontent.com/fengcms/articles/master/image/de/23c3772fee06edc168e59327427986.jpg)
然后就是创建电脑账户了。我们根据下面的标签，设置你的账户名以及密码。强烈建议设置为英文（或者拼音）的，设置好之后，我们点击 **继续**

![](https://raw.githubusercontent.com/fengcms/articles/master/image/2a/9e04b9a7b5144e5b67420fe3991bd1.jpg)
然后，就出现了**选择你的时区** 我们在地图上点击中国的大概区域，一直点击到 **北京市 - 中国** ，也可以在下拉框里面选择。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/b3/876819757e6287ec7e9d25b29e9032.jpg)
然后是一个诊断与用量的界面。这里，我们取消掉两个勾选。咱自己黑的MAC就不给苹果公司添麻烦了-_-|||,选好了之后，我们点击 **继续**

![](https://raw.githubusercontent.com/fengcms/articles/master/image/2a/15cf3a06e7ca3dfe8cca7953a92c66.jpg)
然后就是 **启用Siri** ，我们选择启用，然后点击 **继续**

![](https://raw.githubusercontent.com/fengcms/articles/master/image/21/58161ad4fa9c9f0a0e71618ba5112b.jpg)
然后就设置好了，就会弹出一个正在设置的界面，出现了经典的旋转菊花

![](https://raw.githubusercontent.com/fengcms/articles/master/image/24/96771b0ce95e3bede57d21606ff80c.jpg)
设置完成之后，就进入桌面了，我忘记了这里会不会重启了，因为这些操作很流畅，所以一路**继续**到这里了。

如果在这里设置好了要重启，重启的时候，我们依然选择U盘启动，然后选择**HFS**的这个图标，进入。

进入系统之后，会检测你的键盘，你点击一下**继续**，然后按一下Z键和？键，会自动判断出你的键盘的类型。确定保存即可。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/82/f5ae1426ec46e514234199ac872573.jpg)
到这里，我们的黑MAC系统就已经安装在我们的硬盘上了。下一章节我们讲如何设置系统引导以及安装驱动。

这一章节的内容在`tonymacx86`网站上寥寥带过，其实本来也不难。但是对于初次黑苹果的人来说，可能稍微有点懵逼，所以我就全程拍照下来作为记录，以便于你的操作。

然后，我们重启电脑，依然选择从U盘进入，和上面的一样，选择**HFS**的这个图标，进入系统。

本文由FungLeo原创，允许转载，但转载必须附注首发链接。谢谢。


