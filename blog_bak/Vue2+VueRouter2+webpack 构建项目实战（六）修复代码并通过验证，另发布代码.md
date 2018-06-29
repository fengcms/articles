title: Vue2+VueRouter2+webpack 构建项目实战（六）修复代码并通过验证，另发布代码
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -vue
    -build
    -webpack
    -vuerouter
    -fungleo
---

# Vue2+VueRouter2+webpack 构建项目实战（六）修复代码并通过验证，另发布代码

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



## 前言

去年11月份写了一系列教程。但是当时的代码并不能通过验证。我现在已经完全适应了这种能够通过验证的编码规范，并且写了一篇博文，如何[Atom 编辑器安装 linter-eslint 插件，并配置使其支持 vue 文件中的 js 格式校验](http://blog.csdn.net/fungleo/article/details/54581896)。让自己的编辑器可以随时提醒自己代码的规范格式。

另外，有人给我留言，说代码写好了如何进行发布。因此，今天追加这篇博文，简单讲一下，我们的代码如何进行发布。

## 关注我无错误的 github

到 github clone 我的最新代码即可 https://github.com/fengcms/vuedemo

## 发布我们的代码

这里打开终端，我们进入到项目文件夹，如下图所示：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/2a/6482abe0d5af71445e5c70aa148ab3.jpg)
进入终端后，我们执行下面的命令

```
npm run build
```
![](https://raw.githubusercontent.com/fengcms/articles/master/image/d0/57b67a96c84824e9aed2b1e0daa185.jpg)
执行命令后，会输出如上的样子。打包过程可能需要一会儿，根据你的项目的大小以及你的电脑配置情况。耐心等待即可。

然后，在我们的项目中，就生成了一个 `disk`的文件夹。这个文件夹里面有一个 `index.html` 文件和 `static` 的资源目录。如下图所示：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/1c/8b89e8dec42d22bc226bf4af1b8f1c.jpg)
这些文件就是打包生成的文件。在 `static`文件夹中，如下图所示，会根据不同的文件类型，分别是 `css`、`js` 文件夹。另外，在我们项目的根目录中的 `static` 中的文件，也会复制到这里的。我这个测试项目里面是空的，所以没有文件。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/02/ba49a07c2b53b046d63715a14882c8.jpg)
基本上就是这样的情况了，我们把这些代码放到其他的服务器上，就可以正常的访问了。

**注意**

直接打开`index.html`是无法正常访问的，这些文件必须在服务器环境下，如 `apache` 下面才能正常访问。另外，文件必须在服务器根目录中才能正常访问。不能放在子目录中。

回头我抽时间再写一篇教程，说一下如何打包在子目录里面吧。

版权申明：本文由FungLeo原创，允许转载，但转载必须附注首发链接。谢谢。


