title: 打造前端 Deepin Linux 工作环境——GUI图形压缩软件 PeaZip 的安装与设置
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -deepin
    -压缩
    -PeaZip
    -Linux
---

#打造前端 Deepin Linux 工作环境——GUI图形压缩软件 PeaZip 的安装与设置

说实话，谁不喜欢简单明了的图形化的软件呢。但是在 `linux` 和 `mac` 上关于压缩软件的图形化的实在是不多，并且 `mac` 上的还收费还不好用。为此，我才用命令行的工具 `atool` 的。

今天我找到一个好用的图形化的压缩软件 `PeaZip` 这个软件。跨平台，开源，功能全面，支持的格式也多。因此，推荐给大家使用。

## 安装 PeaZip 压缩软件

打开终端，输入下面的命令进行搜索

```#
apt-cache search peazip
```
看是否包含这个安装包。 `deepin` 我这边看到是有这个包的。所以执行下面的命令安装：

```#
sudo apt-get install peazip -y
```

这个软件依赖的包还比较多，不过没关系，一会儿就安装完成了。

打开软件

![](https://raw.githubusercontent.com/fengcms/articles/master/image/4d/f8f07ff7ae2daae172d5e49a92db60.png)
好，我们可以看到这个软件和我们在 `windows` 上接触的 `winrar` 是差不多的。但是默认是英文。所以我们需要设置一下：

## 设置 PeaZip 压缩软件

![](https://raw.githubusercontent.com/fengcms/articles/master/image/e5/064404a0c13f4a146c5f7d58743aa9.png)
首先，我们点击菜单栏的 `Options` 然后点击 `Localization`，会弹出如下方的选择本地语言配置选框，我们选择 `chs.txt` 然后点击 `打开` 就设置好了。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/c0/23213a8e6fa2e7dabcfec8e7e9903c.png)
设置语言之后，软件会自动重启，重启之后，就可以看到已经全部变成中文了。应该说，还是感到很亲切的。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/bc/1b187cf0b1bad46759317b83d64e9b.png)
`peazip` 的官方网址是 http://www.peazip.org/peazip-linux.html

本文由FungLeo原创，允许转载，但转载必须附注首发链接。谢谢。