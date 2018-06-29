title: 打造前端MAC工作站（三）使用brew利用命令行安装软件
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -brew
    -homebrew
    -黑苹果
    -mac-git
    -mac-node
---

# 打造前端MAC工作站（三）使用brew利用命令行安装软件

## 前情回顾

[打造前端MAC工作站（一）简单系统配置](http://blog.csdn.net/fungleo/article/details/57503806)
[打造前端MAC工作站（二）安装软件的两种方法](http://blog.csdn.net/FungLeo/article/details/57543682)

## 前言

最好的系统是`linux`，只是我们前端工程师的一些特殊需求，导致大多数前端工程师选择了MAC系统作为我们的主力工作站。

但是，我们不能沉迷于MAC的各种图形工具，我们还是要练习和使用强大的命令行工具。这一章，我们就两讲如何在MAC下面使用命令行安装软件。

写了一天的文章了，累了，这篇博文主要内容来自于 `http://www.cnblogs.com/TankXiao/p/3247113.html`

下面是原文：

## 使用brew安装软件

brew 又叫Homebrew，是Mac OSX上的软件包管理工具，能在Mac中方便的安装软件或者卸载软件， 只需要一个命令， 非常方便

brew类似ubuntu系统下的apt-get的功能


### 安装brew
brew 的官方网站： http://brew.sh/   在官方网站对brew的用法进行了详细的描述

安装方法：  在Mac中打开Termal:  输入命令：

```#
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

![](https://raw.githubusercontent.com/fengcms/articles/master/image/0a/430635782a227bab838787a6e519e4.jpg)
> 代码是我从官方网站拿的，图是原文的。我的实际操作是在这过程中需要按几次回车，安装时间大概是15分钟

### 使用brew安装软件

一个命令就搞定了， 比如安装`git`
```#
brew install git
```

![](https://raw.githubusercontent.com/fengcms/articles/master/image/b4/4618b3dbfb98820db70ac965da38be.png)
> 安装过程需要等待一会儿，与网速有很大的关系。如果不行，建议科学上网。科学上网的软件，在上一篇中已经给大家了。至于如何获得账号，建议大家在网上购买一个，或者自己买一台国外的VPS服务器搭建一个。这里就不详细表述了。可以在搜索引擎中搜索相关科学上网的资料。

比如安装wget
```#
brew install wget
```

### 使用brew卸载软件
卸载更方便了
```#
brew uninstall wget
```
![](https://raw.githubusercontent.com/fengcms/articles/master/image/2f/43c7447a740610348ba694fd8e20d9.png)
### 使用brew查询软件

有时候，你不知道你安装的软件的名字， 那么你需要先搜索下, 查到包的名字。
比如我要安装
```#
brew search /wge*/
```
`/wge*/`是个正则表达式， 需要包含在`/`中

![](https://raw.githubusercontent.com/fengcms/articles/master/image/e4/b34d684ebc921f4094536e4f5e4849.png)
### 其他brew命令
```#
brew list           // 列出已安装的软件
brew update         // 更新brew
brew home           // 用浏览器打开brew的官方网站
brew info           // 显示软件信息
brew deps           // 显示包依赖
```

![](https://raw.githubusercontent.com/fengcms/articles/master/image/6c/a39a9daf2ca3d063d941e9af64f52e.png)
## 我们需要用 brew 安装哪些软件？

软件名|软件用途
---|---
node|node.js，前端必须的环境
git|版本管理工具，github必备
wget|命令行下载工具，下载必备
atool|命令行解压亚索软件工具，统一所有压缩软件命令，必备

其他就是各种各样的软件了。大家可以在实际的学习工作过程中不断的学习与安装。

本文图片资料参考了 http://www.cnblogs.com/TankXiao/p/3247113.html 这篇博文，其余内容由FungLeo原创，允许转载，但转载必须附注首发链接。谢谢。


