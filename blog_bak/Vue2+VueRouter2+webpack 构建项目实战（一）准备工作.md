title: Vue2+VueRouter2+webpack 构建项目实战（一）准备工作
date: 2016-11-15 14:43:06 +0800
update: 2016-11-15 14:43:06 +0800
author: fungleo
tags:
    -Vue
    -VueRouter
    -webpack
    -vue-cil
---

#Vue2+VueRouter2+webpack 构建项目实战（一）准备工作

## 2017年8月补充

2016年，我写了一系列的 VUE 入门教程，当时写这一系列博文的时候，我也只是一个菜鸟，甚至在写的过程中关闭了代码审查，否则通不过校验。

本来写这一系列的博文只是为了给自己看的，但没想到的是，这系列博文的点击量超过了2万以上，搜索引擎的排名也是非常理想，这让我诚惶诚恐，生怕我写的博文有所纰漏，误人子弟。

再者，这一年的发展，VUE 项目快速迭代，看着我一年前写的博文，很可能各种提示已经发生改变，对照着过时的资料，非常可能导致新手在学习的过程中产生不必要的困扰。

因此，本人决定，重写这个系列的博文，力求以简明、清晰、准确的图文以及代码描述，配合 github 的项目开源代码，给各位 VUE 新手提供一个高质量的入门文案。

以下为我写的博文：

1. [Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（一）基础知识概述](http://blog.csdn.net/fungleo/article/details/77575077)
2. [Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（二）安装 nodejs 环境以及 vue-cli 构建初始项目](http://blog.csdn.net/fungleo/article/details/77584701)
3. [Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（三）认识项目所有文件](http://blog.csdn.net/fungleo/article/details/77585205)
4. [Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（四）调整 App.vue 和 router 路由](http://blog.csdn.net/fungleo/article/details/77600798)
5. [Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（五）配置 Axios api 接口调用文件](http://blog.csdn.net/fungleo/article/details/77601270)
6. [Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（六）将接口用 webpack 代理到本地](http://blog.csdn.net/fungleo/article/details/77601761)
7. [Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（七）初识 *.vue 文件](http://blog.csdn.net/fungleo/article/details/77602914)
8. [Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（八）渲染一个列表出来先](http://blog.csdn.net/fungleo/article/details/77603537)
9. [Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（九）再把内容页面渲染出来](http://blog.csdn.net/fungleo/article/details/77604490)
10. [Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（十）打包项目并发布到子目录](http://blog.csdn.net/fungleo/article/details/77606216)
11. [Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（十一）阶段性小结](http://blog.csdn.net/fungleo/article/details/77606321)

**以下为原文**



##目录索引
[《Vue2+VueRouter2+webpack 构建项目实战（一）准备工作》](http://blog.csdn.net/fungleo/article/details/53171052)

[《Vue2+VueRouter2+webpack 构建项目实战（二）目录以及文件结构》](http://blog.csdn.net/fungleo/article/details/53171614)

[《Vue2+VueRouter2+webpack 构建项目实战（三）配置路由，整俩页面先》](http://blog.csdn.net/FungLeo/article/details/53199436)

[《Vue2+VueRouter2+webpack 构建项目实战（四）接通api，先渲染个列表》](http://blog.csdn.net/fungleo/article/details/53202276)

[《Vue2+VueRouter2+webpack 构建项目实战（五）配置子路由》](http://blog.csdn.net/fungleo/article/details/53213167)

[《Vue2+VueRouter2+webpack 构建项目实战（六）修复代码并通过验证，另发布代码》](http://blog.csdn.net/fungleo/article/details/54602753)

之前写的博客没有采用打包工具，而是直接引用js的方式来做的。这种方式很扯淡，也因此，我写了三篇博客之后就没有再写了。通过几个月的学习和实战，基本厘清了`Vue1 + VueRouter1 + browserify`的一些技术点。并且通过几个实际项目的工作，已经验证了自己利用该技术完成项目是没有问题的了。

但是，现在主流的打包方式已经变成了`webpack`了，而在`guthub`上面找的很多插件在`browserify`上打包可能会出现错误，以至于需要自己造轮子。因此，我用了几天时间来捣鼓`webpack`。

更重要的是，vue和VueRouter都已经升级到2.x的版本了。我之前基于1.x版本做的那些方法都发生了改变。

因此，我这次从头来写一个系列的博客，把自己遇到的问题和解决方法都记录下来。以便于自己的温习，也方便新手可以快速的上手。

##环境准备

首先，要开始工作之前，还是需要把环境搭建好。我这里的环境是mac，如果你是windows，请自己确保环境没有问题。

`mac+nodejs+npm`环境是必备的。另外需要文本编辑器，我使用的是`atom`，当然，你可以使用`sublime`或者其他的，都没有关系。只是，nodejs是必须要安装的。

各个系统安装不一样，详情参考：[nodejs 官方网站](https://nodejs.org/en/)

安装好nodejs 之后，在终端下面输入命令`node -v`会有版本号出来。就说明安装成功了。输入`npm -v`也会有版本号出来，就说明，`npm`也已经安装好了。

有了Nodejs环境，则我们可以开始了。

为了在学习过程中便于查找资料，一定要准备好翻墙工具。至于怎么翻墙我就不说了，因为免费的都不太好用。收费的vpn之类的一般都可以。不过我建议有条件的自己购买一个国外的vps之类的自己搭一个翻墙环境，然后自己用，无论是稳定性还是各个方面都相当不错。

最后，不要相信百度，坑死你。

##vue-cil构建项目

`vue-cil`是vue的脚手架工具。其模板可以通过 [vuejs-templates](https://github.com/vuejs-templates/webpack) 来查看。

我们首先，需要安装`vue-cil`。命令如下：

```
$ npm install -g vue-cli
```
>上面代码中的 $ 为终端前缀，不是让你输入的。下面涉及到终端的部分均是如此，不再累述。

这个命令只需要运行一次就可以了。安装上之后，以后就不用安装了。

下面，我们来用vue-cil构建一个项目。

首先，我们在终端中把当前目录定位到你准备存放项目的地方。如我是准备放在`~/Sites/MyWork/`这个目录下面，那么我的命令如下：

```
$ cd ~/Sites/MyWork
```
进入到目录之后，我们按照下面的代码逐条输入，新建一个自己的`vue`项目

```
$ vue init webpack vuedemo
```
输入这个命令之后，会出现一些提示，是什么不用管，一直按回车即可。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/ab/de9bfb17e828929041270776ba1bfd.jpg)
如上图所示，就说明我们的项目构建成功了。并且，给出了下面要执行的命令，我们来逐条执行：
```
$ cd vuedemo
$ npm install
```
执行`npm install`需要一点时间，因为会从服务器上下载代码啦之类的。并且在执行过程中会有一些警告信息。不用管，等着就是了。如果长时间没有响应，就`ctrl+c`停止掉，然后再执行一次即可。如果还是照样，建议检查是不是因为没有翻墙的原因，或者，把npm源换成国内的，这里我就不说这么弄了，具体去问`google`。

安装完成后，终端如图：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/95/ab2980c929aa321db1f97eb3f3b923.jpg)
最后，执行下面一句，把项目跑起来
```
$ npm run dev
```
执行后，终端如图：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/f5/5f207009ee382c52f19e7ad54e8322.jpg)

如上：四行命令，就可以把一个名为`vuedemo`的项目跑起来。当然，这个名字你是可以随便起的，根据你的实际项目来定。

好，通过上面的这些命令，我们就实现了新建一个`vue+webpack`的项目。在运行了`npm run dev`之后，会自动打开一个浏览器窗口，就可以看到实际的效果了。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/0c/cc3295755c8e6995f5dcf1bdd1c47d.jpg)
好，我们的第一步，已经顺利完成了。

##小结

通过上面的几个命令，我们就可以把项目跑起来了。问题是，我们需要掌握一些知识点，我提出来，看官自己找资料学习：

1. 什么是nodejs? nodejs有哪些用处？
2. 什么是npm? npm如何安装软件？
3. 什么是webpack? 它有什么优缺点？
4. 终端的基本使用。

> 我是强烈建议学习前端的同学整mac学习，但是如果你实在没有mac也没有关系，可以使用linux系统来学习。如果你又不用linux，那么没办法了，可以使用windows。但是windows下面的cmd工具实在是太操蛋了。我相信大家在windows上一定安装了一款软件叫`git`。OK，只要有这个也行，在任意文件夹右击菜单，在菜单中点击` git bash here` 菜单，然后可以打开一个类似于终端的面板，这里支持一些linux的常用的命令，包括vim工具都有。虽然界面是丑了点，但是比cmd要好用。

本篇博文只是简单的说了一下如何用vue-cil来构建一个项目，但是这只是一个基础款而已，我们还是要用在我们的项目中，我们下一篇进行学习。

本文由FungLeo原创，允许转载，但转载必须附带首发链接。如果你不带链接，我将采取包括但不限于深深的鄙视你等手段！

首发地址：http://blog.csdn.net/fungleo/article/details/53171052
