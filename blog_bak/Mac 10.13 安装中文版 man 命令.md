title: Mac 10.13 安装中文版 man 命令
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -mac
    -man
    -中文man
    -brew
    -make
---

# Mac 10.13 安装中文版 man 命令

本文参考于 《[Mac 安装man命令中文文档](http://www.jianshu.com/p/5e35202fc59c)》，但原文提供的链接以及安装的版本比较老旧。因此重新整理新版在这边提供给大家。

## 为什么需要 man 以及 man 怎么使用

`linux` 或者 `mac` 系统的命令行工具非常多，可是我们不能记住所有的这些命令，通常只能记住一些我们常用的。遇到不常用的我们需要来查询一下这个命令是怎么使用的。这时候我们就需要使用到 `man` 命令了。

使用方法也非常简单，例如我们不清楚 `ls` 这个命令的使用方法，我们就可以在命令行中输入

```
man ls
```
来查看这个命令的详情。

但是默认情况下，输出的内容是英文的。可能很多英文不好的朋友希望有中文版本的 `man` ，这篇博文就是告诉大家，如何在 `mac` 上安装中文版本的的 `man`。

至于 `linux` 系统则非常简单，查看 https://github.com/man-pages-zh/manpages-zh 中对应的版本，即可用简单的命令安装。

## 下载 manpages-zh 编辑安装

首先，我们打开上面的 `github` 地址，点击 `releases` 下载最新版本的 `tar.gz` 源码包。目前我下载到的是 `1.6.3.2` 版本的。

因为需要编译安装，所以你电脑上需要有编译工具，运行下面两个命令安装

```
brew install automake
brew install opencc
```
我这边是需要安装这两个编译工具，如果你下面编译出错，会提示你需要安装说明编辑工具的。利用 `brew` 安装即可。

如果你电脑没有安装 `brew` 工具，请参考 http://blog.csdn.net/FungLeo/article/details/57567538 这篇博文安装

好，准备工作做好，我们接着来。

```
# 进入下载目录
cd ~/Downloads/
# 下载最新版本的源码包
wget https://github.com/man-pages-zh/manpages-zh/archive/v1.6.3.2.tar.gz
# 解压源码包(atool命令，推荐安装这个工具，统一所有压缩文档的命令）
atool -x v1.6.3.2.tar.gz
# 或者使用这个命令解压
tar zxvf v1.6.3.2.tar.gz
# 进入源码包文件夹
cd manpages-zh-1.6.3.2/
# 编译安装 1
autoreconf --install --force
# 编译安装 2
./configure
# 编译安装 3
make
# 编译安装 4
sudo make install
# 配置别名
echo "alias cman='man -M /usr/local/share/man/zh_CN'" >> ~/.bash_profile
# 使别名生效
. ~/.bash_profile
```
这样，我们就安装上了中文版本的 `man` 工具了。我们可以使用

```
cman ls
```

来查看中文版本的解释了。但是由于 `mac` 上的 `groff` 工具比较老，所以中文会出现乱码。我们来解决一下这个问题。

## 安装 groff 新版本解决中文乱码的问题

首先，我们到 http://git.savannah.gnu.org/cgit/groff.git 这个页面下载 `1.22` 版本的 `groff` 安装包。我这边用命令行下载，你如果直接复制我的命令，不能下载，请到上面的地址去看看下载地址是否发生变化。

```
# 进入下载目录
cd ~/Downloads/
# 下载1.22版本的源码包
wget http://git.savannah.gnu.org/cgit/groff.git/snapshot/groff-1.22.tar.gz
# 解压
atool -x groff-1.22.tar.gz
# 进入目录
cd groff-1.22
# 编译安装
./configure
sudo make
sudo make install
# 添加配置
sudo vim /etc/man.conf
```
进入编辑之后，在文件末尾添加
```
NROFF preconv -e UTF8 | /usr/local/bin/nroff -Tutf8 -mandoc -c
```
最后 `:wq` 保存退出

然后，我们在输入

```
cman ls
```
就可以看到中文版本的命令介绍了。

本文由FungLeo原创，允许转载，但转载必须附注首发链接。谢谢。


