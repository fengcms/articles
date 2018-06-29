title: 打造黑苹果（二）制作黑mac系统安装U盘
date: 2017-02-26 15:04:06 +0800
update: 2017-02-26 15:04:06 +0800
author: fungleo
tags:
    -黑MAC安装U盘
    -黑MAC系统安装
---

# 打造黑苹果（二）制作黑mac系统安装U盘

## 前言

在上一篇[打造黑苹果（一）组装硬件的选择与组装](http://blog.csdn.net/FungLeo/article/details/57412461) 中，我们已经给大家在硬件上有了一个建议。如果你已经购买了硬件了，或者你原来的硬件就已经满足了黑MAC的需求，那么，下面就要开始安装黑MAC系统了。

如果你不愿意折腾，建议在**仓库盘**上先安装一个windows的操作系统，然后上淘宝，找一个黑MAC系统安装的店家，花上百十块钱，就可以安装好了，省的自己研究。

> 在仓库盘上安装windows是因为我们要在固态硬盘上安装 macos系统，安装好了之后，你可以选择保留仓库盘的windows或者格式化掉，随便你咯~在仓库盘格式化的时候，不推荐使用ntfs硬盘分区格式，MAC原生不支持。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/cc/dfa9aa27148f779195132c3dcc95ac.png)
推荐一个商家`andreasoulmate` 你自己去找。他们的技术实力不错，我自己在黑苹果的过程中遇到一些问题，他们给予了有效的解答。我第一次黑苹果，也是他们帮忙安装的。不过店家是做服务的，所以很忙，因此有时候回复慢一些，还需要等一下。

另外，淘宝上的店家虽然都说是安装的原版，但实际上都是懒人版。懒人版使用上基本没问题。

本章节的内容你可以查看 tonymacx86 网站的 Installation Guide 频道。当然是英文的。如果你英文牛逼，就以原版为参照，我的博文辅助，如果英文不好，那就以我的为主，那边的为参照。

## 第一步，准备一台MAC电脑

这一步，比较坑。因为它要求你先有一台MAC电脑。看管可能要愤怒了，我TM不就是因为没有MAC菜黑MAC的吗？这是一个先有鸡还是先有蛋的坑爹问题。解决方法有三：

1. 找朋友借一台。可行性 ★★★。苹果电脑的保有量实在比较小，如果是一线城市，或者大学生，应该是可以解决的。
2. 买一台。可行性 ★ 。虽然这个解决方法有点可笑，但我就是这样的呀，我本来就有macbookpro，黑MAC主要是为了避免linux和mac的快捷键不一致导致我总是混乱在到底按什么按键上，否则我是不会黑MAC的。
3. 找上面的淘宝店家先给自己黑一个，然后你就有MAC电脑啦。可行性 ★★★★★ 。

当然，你要说了，我已经找淘宝卖家黑好了系统，我为毛还要再制作一个安装U盘呢？其实道理很简单，难道，你就不会重新安装系统了？你每次黑苹果都去淘宝上花钱黑？

最重要的是，淘宝上黑的MAC系统是升级不了的（因为懒人版分区的原因）。如果系统升级了，那不是干瞪眼~

当然，有钱，另说！

先不管你怎么找一台MAC电脑了，反正言尽于此。

另外，在黑MAC的时候，最好是两个人两台电脑，方便互相提醒研究，以及查阅资料。

## 第二步，相关准备工作

1. 在 [tonymacx86.com](http://www.tonymacx86.com) 注册一个账户。点击 [这里](https://tonymacx86.com/login/login) 注册。
2. 注册完成后，到 **Download** 频道下载 **UniBeast** 和 **MultiBeast** 两个软件，找最新的下载。当前最新为 `UniBeast 7.0.1` 和 `MultiBeast - Sierra 9.0.1`
3. 准备一个 16G 以上的U盘，质量要好一点的。
4. 备份你原来的资料

**UniBeast** 是制作启动盘的工具。**MultiBeast** 是系统引导，以及安装驱动的工具。

## 第三步，下载 mac 原版系统

1. 打开苹果电脑的 `app store` ，并登陆你的 `apple id`。
2. 下载 `macOS Sierra` 系统。

`macOS Sierra` 是目前最新的苹果系统。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/30/f9e8ca125747f1acf57ecd7daa3deb.png)
![](https://raw.githubusercontent.com/fengcms/articles/master/image/ce/f29271b88d805d45df75d0069816e0.png)
这个系统文件是很大的，下载过程也是比较久的，要看你的网速。经过漫长的等待，就下载好了。

最后在 `/Applications` 里面就会出现一个 **`Install macOS Sierra`**

下载好了之后，放在这里就可以了。啥也不用动

## 第四步，格式化你的U盘

下面，图片我使用的是 tonymacx86的图片。是英文的，如果你不能准确理解英文与中文的关系，建议你将 mac 系统调整到英文，然后再进行下面的操作。系统偏好设置中，语言与地区，将`English`拖动到`简体中文`的上面，然后重启系统就可以了。

1. 插入你准备好的16G U盘
2. 打开 磁盘工具 **Disk Utility**，路径 **/Applications/Utilities/Disk Utility**
3. 在左侧栏，选中你插入的U盘

![](https://raw.githubusercontent.com/fengcms/articles/master/image/04/a05ee521a4c8d1aded26ac1281fb6d.png)
4. 点击上方的 **Erase** 按钮 （中文版为 **抹掉** ）
5. Name: 在弹出来的对话框中，名字后面输入`USB`
6. Format:第二个，选择 ` OS X Extended (Journaled)`
7. Scheme: 第三个，选择 ` GUID Partition Map`

![](https://raw.githubusercontent.com/fengcms/articles/master/image/6a/ccf442c6fd3cb53a958072b555e119.png)
如上图所示，然后再点击 **Erase** 按钮。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/3a/a5df1985036ad1d85d9f1e32201f24.png)
如上图，执行完成之后，我们点击 **Done** 按钮，中文版应该为 **完成**
这里，需要注意的是，有可能执行一次会失败，如果失败了，就再来一次，一般就成功了。

好了，到这一步，我们的U盘就准备好了，下面我们要开始制作了。

## 第五步，用 UniBeast 创建一个可以启动的 U盘

1. 解压并打开我们上面下载的 **UniBeast** 工具
2. 点击 `Continue`, `Continue`, `Continue`, `Continue`, `Agree`。一路下来，有没有windows下面一路`next`的畅爽感？呵呵。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/f9/4f036f15935ae321e0d3b727cdf829.png)
3. 到了如上图的这一步，我们点击右侧的`USB` 上面的图标，选择我们的U盘，然后点击 **Continue** 按钮。

4. 然后在 `Select OS Installation screen`这一步选择 `Sierra` 然后点击  **Continue** 按钮，这一步没有截图。但是应该算表述得清楚。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/6c/aeb63373190be5c8c8466bc98bde52.png)
5. 在 `Bootloader Options screen` 这一步，选择 `UEFI Boot Mode` 这个，然后点击  **Continue** 按钮。如上图所示。
6. 在 `Graphics Configuration` 这一步，需要选择你的显卡类型。如果你是用的集成显卡，就什么都不用选，直接点击 **Continue** 按钮，如果你是用的 `GTX650` 或者其他 黑MAC支持的英伟达显卡，那么，这里就要点选 英伟达 的显卡驱动 ，绿色的眼睛图标，这里不放了。然后再点击 **Continue** 按钮

![](https://raw.githubusercontent.com/fengcms/articles/master/image/5d/d75fd4721d40f1cc4bf04253464165.png)
7. 然后就到了这一步了，如果你是用的集成显卡，就和上面的图片一模一样，如果你点选了 英伟达 的显卡图标，那么这里就有4个图标。一切准备好后，我们点击  **Continue** 按钮 ，就会到下面的图片

![](https://raw.githubusercontent.com/fengcms/articles/master/image/11/070e6485d45e36b72d527e21d177b0.png)
正在复制文件。

因为文件比较大，需要的时间比较长，大概15分钟到20分钟的时间，需要耐心等待一下。中间别手贱，到处乱搞。

最后，在U盘制作完成之后，将我们下载的 **MultiBeast** 压缩包解压，得到一个文件夹，里面有一个叫 **MultiBeast** 的软件，复制到我们的U盘当中。然后我们的黑MAC系统安装U盘就算制作完成了。

本文由FungLeo原创，部分内容以及图片参考与 tonymacx86 网站，允许转载，但转载必须附注首发链接。谢谢。

tonymacx86原文链接：https://www.tonymacx86.com/threads/unibeast-install-macos-sierra-on-any-supported-intel-based-pc.200564/

