title: Vue2+VueRouter2+webpack 构建项目实战（二）目录以及文件结构
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -Vue
    -VueRouter
    -webpack
    -vue-cil
---

#Vue2+VueRouter2+webpack 构建项目实战（二）目录以及文件结构

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

通过上一篇博文[《Vue2+VueRouter2+webpack 构建项目实战（一）准备工作》](http://blog.csdn.net/fungleo/article/details/53171052)，我们已经新建好了一个基于`vue+webpack`的项目。本篇博文将详细的厘清一下这个项目的结构，然后我们要从哪里开始等。

##项目目录以及文件结构。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/2b/953e8fc507d9f81c69d892a6b1da7b.jpg)
如上图所示，我们的目录结构就是这样的了。

|目录/文件|说明|
|-|-|
|build|这个是我们最终发布的时候会把代码发布在这里，在开发阶段，我们基本不用管。|
|config|配置目录，默认配置没有问题，所以我们也不用管|
|node_modules|这个目录是存放我们项目开发依赖的一些模块，这里面有很多很多内容，不过高兴的是，我们也不用管|
|src|我们的开发目录，基本上绝大多数工作都是在这里开展的|
|static|资源目录，我们可以把一些图片啊，字体啊，放在这里。|
|test|初始测试目录，没用，删除即可|
|.xxxx文件|这些是一些配置文件，包括语法配置，git配置等。基本不用管，放着就是了|
|index.html|首页入口文件，基本不用管，如果是开发移动端项目，可以在`head`区域加上你合适的`meta`头|
|package.json|项目配置文件。前期基本不用管，但是你可以找一下相关的资料，学习一下里面的各项配置。至少，要知道分别是干嘛的。初期就不管了。|
|README.md|不用管|


如上，基本上就是这么个情况。重要的，还是`src`文件夹。

##SRC文件夹的情况

![](https://raw.githubusercontent.com/fengcms/articles/master/image/2a/e9bdb5a293d5d6d14b2e90624a755d.jpg)
如上图所示，这是src文件夹下面的初始情况，里面有一些示例代码之类的。比如，它吧`logo`放在`assets`文件夹里面。我个人很不喜欢这么做，因为代码是代码，资源是资源，各归其位比较好。

`commponents`目录里面放了一个演示的组件文件，你可以打开看下。当然，也可以直接删除，然后根据我的博文往下走。

`App.vue`是项目入口文件。当然，我们需要改造，改造成我们可以使用的样子的。后面的博文会说。

`main.js`这是项目的核心文件。全局的配置都在这个文件里面配置，我后面会详细的讲这里怎么搞。

##整理目录

上面只是让大家了解一下具体是什么情况，下面，我们开始动手，把不想管的干掉，然后把`src`变成这个样子:

![](https://raw.githubusercontent.com/fengcms/articles/master/image/b4/4ac7c3e6a6aa0c0528cba87f23af37.jpg)

如上图所示，把文件夹和文件都新建好，后面的博文我会详细给出每个文件的代码的。这里，都新建空文件即可。注意，我是用`scss`来写`css`文件的。所以看官你最好也学习一下scss的相关内容，我的博客里面有，搜索也是一大把。

|文件\目录|说明|
|-|-|
|component|组件文件夹我们写的一些公用的内容可以放在这里的。|
|config|核心配置文件夹|
|frame|存放自路由的文件夹|
|page|项目模板文件夹,所有的页面文件全部存放与此，后面会根据需要来建立各种子目录|
|style|样式存放目录|

> vue支持每一个模板里面写css，这样可以做到随用随取。但是，我个人不太喜欢这样，我还是喜欢吧css给单独放出来，因为这样便于整理，另外，使用scss的朋友都知道，我们会预设大量的变量，代码片供我们在写css的时候使用，如果每个模板文件里面都需要引用一次那是及其操蛋的。

你可以先根据我这一套来。然后等你全部融会贯通了之后，你可以想怎么玩儿怎么玩儿。随便。

这篇博文先到这里，后面我们继续讲。

本文由FungLeo原创，允许转载，但转载必须附带首发链接。如果你不带链接，我将采取包括但不限于深深的鄙视你等手段！

首发地址：http://blog.csdn.net/fungleo/article/details/53171614
