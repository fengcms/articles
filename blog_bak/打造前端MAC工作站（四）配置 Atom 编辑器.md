title: 打造前端MAC工作站（四）配置 Atom 编辑器
date: 2017-02-27 14:51:37 +0800
update: 2017-02-27 14:51:37 +0800
author: fungleo
tags:
    -atom
    -编辑器
    -前端
    -git
---

# 打造前端MAC工作站（四）配置 Atom 编辑器

## 前言

前端工程师可选择的编辑器主要有 `Atom`、`Sublime Text3`、`VS Code`，三者风格差不多，你可以选择你喜欢的任意一款从事我们的编码工作。

我个人选择 `Atom` 因为免费开源，与 `git` 配合比较好，另外插件都是用前端语言编写，方便自己有时候需要修改插件。

`Atom` 的有一个比较大的缺点，就是打开大文件的时候会比较卡。除此之外，我感觉它还是非常好用的。

安装就不说了，直接到官方网站下载，然后复制到 `/Applications/` 下面即可（MAC下的安装）

## 为 Atom 安装插件

`Atom` 提供了相对比较简单的图形界面的安装插件。但是在我的实际操作过程中，发现比较难安装上，可能是因为墙的原因，又或者是因为我身处祖国的大西北，网络条件比较差的缘故。图形界面的插件安装比较简单，鼠标点点就可以了，这里不再重复。我主要说一下，如何在命令行下安装插件，这个安装，是百分百会成功的。

> 前提，你已经安装了 `node.js`、`git`。

### 查找插件

我们打开 `Atom` 的官方网站：https://atom.io/ ，点击**Packages**进入到插件搜索栏目，如下图所示：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/c7/9fd7da6f0fd439741861ad6ff4184f.png)
在图中红线框内，输入我们想要的插件名称，就可以进行搜索，例如，我们想要安装我们的前端神器`emmet`，然后按下回车键，就可以搜索到这个插件了。如下图所示：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/ce/fe9ec9d45311a68e8515bfccac8f68.png)
> 这里需要注意的是，并非你搜索的关键词的最好的插件就会排在第一个，你可以上下滚动了看看，哪个的下载量大，就下载哪个，比如上图中`emmet`的下载量是
`1058534`，一百多万人下载，那应该是没有问题的，而下面的那个，只有几百人下载，还如果不是确定知道这个是干嘛的，一般，是不推荐大家安装的。

我们点击进去，就进入到了 `emmet` 的简介网页。我们在这个网页上点击**Repo**进入到插件对应的`github`仓库中，如下图所示：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/4f/ff19b861e032488ff536fa75a99c03.png)
**Repo**按钮的位置如上图所示：

然后，我们就进入到了`github`的网页中。这个网页的内容我们不用管，只需要将浏览器地址栏里的地址复制上即可。如下图所示：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/cc/81e35a6510aef6c77094dc8bd41634.png)
这样，我们就找到了这个插件对应的地址了。如，`emmet`的地址就是`https://github.com/emmetio/emmet-atom`

### 下载并安装插件

我们打开终端，输入下面的命令

```#
# 进入atom插件安装目录
cd ~/.atom/packages/
# 下载插件
git clone https://github.com/emmetio/emmet-atom
# 等待执行一会儿，执行完成后，进入插件目录
cd emmet-atom
# 执行NPM安装命令
npm install
```

等待执行安装完成后，你的插件就安装好了，然后就只需要重启，就可以看到你的插件了。

## 前端常用插件

插件名称|插件简介
--- | ---
emmet|前端神器，如果不知道，自行百度
minimap|迷你地图，羡慕sublime的地图吗？安装上就好
color-picker|调色板，css必备
simplified-chinese-menu|汉化插件，国人必备
atom-jquery|jquery必备
atom-vue|vue必备
linter-eslint|代码检查神器
atom-vim-mode-plus|VIM模式，vim高手必备，新手勿装

简单使用的话，这些插件应该是够用了，如果不够用的话，可以搜索一下相关的需要的关键词，看看有没有合适的，或者问问其他使用`atom`编辑器的朋友，有没有什么神器可以推荐

**当然也欢迎在本帖后面评论留言，留下你认为好用的插件，推荐给大家，我会根据你的评论，整理到文中来**

## 补充阅读

[Atom 编辑器安装 linter-eslint 插件，并配置使其支持 vue 文件中的 js 格式校验](http://blog.csdn.net/fungleo/article/details/54581896)
[atom编辑器颜色插件推荐 color-picker 以及把这个插件放大](http://blog.csdn.net/fungleo/article/details/53098549)
[让ATOM编辑器的EMMET插件支持VUE文件的方法](http://blog.csdn.net/fungleo/article/details/52162768)

其他后续补充...

本文由FungLeo原创，允许转载，但转载必须附注首发链接。谢谢。


