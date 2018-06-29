title: Atom 在 linux 下安装有几率侧边栏默认显示在右侧，移动到左侧的设置方法
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -atom
    -arch linux
    -linux
    -侧边栏
    -右侧
---

# Atom 在 linux 下安装有几率侧边栏默认显示在右侧，移动到左侧的设置方法

遇到一个奇葩的事情。没有macbook了。我及其讨厌windows，于是给新来的前端一台笔记本，安装上了archlinux系统。在安装好atom编辑器之后，发现，侧边栏显示在右侧，恶心坏了。

通过一番摸索，终于找到了设置选项。如下：

打开 设置 → `Packages` → 一直往下翻，找到 `tree-view` → 点击 `setting` 或 设置 → 去掉`Show On Right Side` 的勾选，然后就立即生效了。如下图所示。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/1c/4d81ebb6fc682fcb383005438993a6.jpg)
在中文网络上应该是我第一个解决这个问题的。除了archlinux ，在 ubuntu 上应该也有几率出现。不知道什么原因。

版权申明：本文由FungLeo原创，允许转载，但转载必须附注首发链接。谢谢。
