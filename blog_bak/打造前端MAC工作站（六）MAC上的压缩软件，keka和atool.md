title: 打造前端MAC工作站（六）MAC上的压缩软件，keka和atool
date: 2017-02-28 19:17:37 +0800
update: 2017-02-28 19:17:37 +0800
author: fungleo
tags:
    -mac压缩软件
    -keka
    -atool
---

# 打造前端MAC工作站（六）MAC上的压缩软件，keka和atool

## 前言

在MAC下面对于`windows`重度用户来说，可能最不适应的就是压缩软件了。因为没有一款免费的压缩软件是如**winzip**、**winrar**、**好压**、**360压缩**这样好用的。都是双击直接就解压到一个文件夹下面的这种。

没办法，不适应归不适应，问题是，我们还是需要压缩软件这样的功能的。这里给两个软件，一个是图形界面的，叫**Keka**，一个是命令行的，叫**atool**。

## 图形界面的压缩软件 Keka

你可以在 `App Store` 里面找到这款软件是收费的。不过在其官方网站是免费的。官方网站地址：http://www.kekaosx.com/zh-cn/

![](http://www.kekaosx.com/img/keka_icon.png)

下载后安装，即可。

软件是英文的，用来解压软件是没有问题的，只要双击压缩文件，即可实现文件的解压。

至于如何压缩文件，我没有尝试过，你可以自己研究一下。

## 命令行压缩以及解压文件工具 atool

首先，这款软件无论是 `linux` 还是`mac`都是支持的，我建议用 `linux` 的朋友可以安装一下。

### 安装 atool

`atool` 是通过 `brew` 进行安装的。如果你还没有安装 `brew` ，请参看 [打造前端MAC工作站（三）使用brew利用命令行安装软件](http://blog.csdn.net/fungleo/article/details/57567538)

在安装好 `brew` 之后，我们在终端内输入：

```#
brew install atool
```
等待几分钟，就安装好了，要看你的网速，安装好了之后，我们输入

```#
atool --help
```

就可以出现如下图的帮助信息，就说明安装好了。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/48/66a8042f1db3faecfbb079767036ca.png)
### 压缩文件

首先，我们进入我们需要压缩的文件目录

```#
# 进入文件夹
cd ~/Downloads/test/
# 查看有啥文件
ls
```
![](https://raw.githubusercontent.com/fengcms/articles/master/image/7e/50660775bcf7ca1d2e16872d3bb9b4.png)
好，我现在要将这下面的几个文件全部加入压缩包，并且命名为 `txt.7z` 这个7z压缩包。

> 压缩为`7z`文件，需要安装一个插件包 `p7zip` 如果你没有安装的话，它会提醒你安装的。安装命令 `brew install p7zip`。我一般用`7z`格式，如果你需要使用其他的格式的话，可能需要安装其他的包，反正它会给你提示，根据提示安装一下即可。

我们输入下面的命令开始压缩：

```#
atool -a txt.7z 1.txt 2.txt 3.txt 4.txt
```
运行结果如下图所示：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/58/726649b20d89fef83f36f7bfea134d.png)
这段命令分四段，

1. `atool` 这个是命令名称
2. `-a` 这个是参数，表示 add 添加的意思
3. `txt.7z` 这个是我们要想要得压缩文件的名称
4. `1.txt 2.txt 3.txt 4.txt` 这个是要添加进压缩包的文件名称，有几个就几个，当然，也可以只有一个。

如上图所示，最后输出 `Everything is Ok` 就说明压缩好啦！

### 查看压缩包中的文件

这是一个比较常用的功能，但是MAC和LINUX上大多数的图形界面的压缩软件都没有提供，但是这个命令行工具是提供了的。还是以上面的那个压缩包为例，我们进行下面的命令

```#
atool -l txt.7z
```

运行结果如下图所示：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/fb/1cd8fbe50f0653acef9c57b17acad2.png)
看上面的图片，压缩包中的文件就详细的展示在这边了。这段命令分三个参数

1. `atool` 这个是命令名称
2. `-l` 这个是参数，表示 `list` 列表的意思
3. `txt.7z` 这个是我们要想查看压缩文件的名称

### 解压压缩包

好，我们还是以上面我们的压缩包为例，我们要解压它，只要下面的命令即可

```#
atool -x txt.7z
```

运行结果如下图所示：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/47/a4a78bb5e2efec3a138fccf1dd8838.png)
如上图所示，文件已经解压到 `txt` 这个文件夹中了。你可以 `ls` 看一下。

1. `atool` 这个是命令名称
2. `-x` 这个是参数，表示 `extract` 提取的意思
3. `txt.7z` 这个是我们要想解压的压缩文件的名称

如上，通过一个命令，三个参数，就解决了压缩文件的问题。

## 小结

在`mac`或者`linux`下面，每一种压缩文件都有对应的压缩或者解压缩的命令，要是全部都记忆不是说不可以，而是比较费劲。因此我推荐`atool`这个命令行压缩软件工具。

虽然我曾经是一个`windows`重度用户，但是因为我一直需要维护`linux`服务器，所以在命令行方面我虽然不是特别擅长，但是普通运用也没有问题。我个人的感觉是，能用命令行做到的，就轻易不要使用图形界面了。除非图形界面做得更好。

另外，MAC上有一款收费的功能强大的图形界面的压缩软件，而且是国人开发的。我没使用过，如果你感觉本文不能满足你的需求的话，可以尝试找一下。

本文由FungLeo原创，允许转载，但转载必须附注首发链接。谢谢。

