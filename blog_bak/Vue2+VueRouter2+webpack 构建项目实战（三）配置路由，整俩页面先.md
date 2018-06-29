title: Vue2+VueRouter2+webpack 构建项目实战（三）配置路由，整俩页面先
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -Vue
    -VueRouter2
    -webpack
---

#Vue2+VueRouter2+webpack 构建项目实战（三）配置路由，整俩页面先

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

##制作模板文件

通过前面的两篇博文的学习，我们已经建立好了一个项目。问题是，我们还没有开始制作页面。下面，我们要来做页面了。

我们还是利用 http://cnodejs.org/api 这里公开的`api`来做项目。不过本章节不涉及调用接口等内容。这里，我们假设我们的项目是做俩页面，一个列表页面，一个内容页面。列表页面有分页等，内容页面展示。

因此，我们需要两个模板文件。

我们在`src/page`目录下面新建两个文件，分别是`index.vue`和`content.vue`

代码分别是

```js
//index.vue
<template>
  <div>index</div>
</template>

//content.vue
<template>
  <div>content</div>
</template>
```
这里，我们只要先把基础的内容写好就是了。我就用两个单词代表我们的页面。

##安装VueRouter2

接下来，我们需要安装`VueRouter2`到我们的项目。参考文档见[VueRouter2安装文档](https://router.vuejs.org/zh-cn/installation.html)

在终端中，我们把当前目录跳转到我们的项目，然后执行`npm install vue-router -D`命令。如下：

```console
cd ~/Sites/MyWork/vuedemo
npm install vue-router -D
```
![](https://raw.githubusercontent.com/fengcms/articles/master/image/7b/12a15dd11d8b63eb24505ca51c7a42.jpg)
我们查阅文档，会知道，命令是`npm install vue-router`，那为什么我后面加一个`-D`的参数呢？这个是为了让我们的安装的`vue-router`这个插件写入到`package.json`配置文件中。以便于下次再其他地方安装的时候，可以一并安装进去，否则，还得再安装一遍。

##配置 main.js

通过在终端中执行命令，我们已经安装好路由了。下面，我们需要在`src/main.js`文件中进行配置。
整理代码如下：
```js
// 引用 vue 没什么要说的
import Vue from 'vue'
// 引用路由
import VueRouter from 'vue-router'
// 入口文件为 src/App.vue 文件 所以要引用
import App from './App.vue'
// 引用路由配置文件
import routes from './config/routes'
// 光引用不成，还得使用
Vue.use(VueRouter)
// 使用配置文件规则
const router = new VueRouter({
  routes
})
// 跑起来吧
new Vue({
  router,
  el: '#app',
  render: (h) => h(App)
})
```
上面的配置文件中的一部分在官方文档里面也找不到，这是我整理出来的，不用管，全部复制过去吧！

##配置 App.vue

入口文件肯定和默认的不一样，我的配置文件如下：
```js
<template>
  <div>
    <router-view
      class="view"
      keep-alive
      transition
      transition-mode="out-in">
    </router-view>
  </div>
</template>

<script>
export default {
  components: {}
}
</script>

<style lang="scss">
  @import "./style/style";
</style>
```
就只是一个单纯的路由入口页面。比较特殊的是，下面我 `import`了一个`scss`文件。我喜欢把`css`独立出来，而不是写在一起，所以我之前在`src`目录下面建立了一个`style`的文件，里面放`scss`文件。

我建议你先跟着我走，回头自己根据自己的习惯调整。

##配置 routes.js

下面我们配置路由文件。

```js
// 引用模板
import index from '../page/index.vue'
import content from '../page/content.vue'
// 配置路由
export default [
  {
    path: '/',
    component: index
  },
  {
    path: '/content',
    component: content
  },
]
```
如上，我们引用模板，然后再配置路由，这里，我们没有涉及自路由的内容，我们先这样配置上。然后，我们就可以在终端里面输入 `npm run dev` 来看我们做的效果了。

##配置运行端口

如果没有跑起来，提示下面的错误，就表明默认的端口`8080`被占用了。一般不会被占用，但是也有可能被占用。所以，我们这边来学习一下如何配置运行端口。

```
# 端口被占用的提示
Error: listen EADDRINUSE :::8080
    at Object.exports._errnoException (util.js:953:11)
    at exports._exceptionWithHostPort (util.js:976:20)
    at Server._listen2 (net.js:1253:14)
......
```

打开项目根目录下`/config/index.js`配置文件，找到

```js
dev: {
  env: require('./dev.env'),
  port: 8080,
  assetsSubDirectory: 'static',
  assetsPublicPath: '/',
  proxyTable: {},
  // CSS Sourcemaps off by default because relative paths are "buggy"
  // with this option, according to the CSS-Loader README
  // (https://github.com/webpack/css-loader#sourcemaps)
  // In our experience, they generally work as expected,
  // just be aware of this issue when enabling this option.
  cssSourceMap: false
}
```
如上，把 `port` 后面的端口改成其他数字，如`9000` 即可。

##关闭格式检查插件eslint

如上，我们再次运行 `npm run dev` 跑起来，结果发现命令行里面错误一片。。。很多人在这里就都晕了。。。没关系，其中大部分错误都是格式造成的，并不是很重要的错误，但是这样的提示很不爽。因此，我们把检查错误插件`eslint`给关闭掉。

打开根目录下面的`/build/webpack.base.conf.js`文件，找到如下代码：

```js
preLoaders: [
  {
    test: /\.vue$/,
    loader: 'eslint',
    include: projectRoot,
    exclude: /node_modules/
  },
  {
    test: /\.js$/,
    loader: 'eslint',
    include: projectRoot,
    exclude: /node_modules/
  }
],
```

全部注释掉，如下

```js
// preLoaders: [
//   {
//     test: /\.vue$/,
//     loader: 'eslint',
//     include: projectRoot,
//     exclude: /node_modules/
//   },
//   {
//     test: /\.js$/,
//     loader: 'eslint',
//     include: projectRoot,
//     exclude: /node_modules/
//   }
// ],
```
回头，调整格式的时候可以再打开。先关掉，解决核心错误，再来考虑这些格式错误。

##安装sass-loader以及node-sass插件

然后我们再跑，这回错误肯定少多了，但是还是有错误。如果你上面是严格按照我的代码来的，这里应该会提示缺少`sass-loader`组件错误。

没关系，缺什么，就安装什么，我们输入 `npm install sass-loader -D`进行安装。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/56/64f0d15bc0393db0857fe00d34c4bb.jpg)
如上图所示，就安装好了。

安装好了再跑，这回又提示我们缺少`node-sass`插件。折磨疯了吧？没关系，缺啥，安啥。

输入命令`npm install node-sass -D`进行安装。

安装结果不截图，然后，我们运行`npm run dev`，如果不出意外的话，应该能够顺利的跑起来了。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/83/08aef9c96ad9beb079845561a94e7f.jpg)
我们在地址栏后面输入`http://localhost:9000/#/content`应该就能访问到我们配置的内容页面的模板了，如下图所示：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/56/13c694ab92b825c9ba89cc67eaa196.jpg)
##小结

好，通过本章的学习，我们已经顺利的安装好路由，并简单的配置了两个页面，并且顺利的跑起来了。

可能是我写的代码不太标准，因此在跑起来的时候不能通过校验，必须把校验关闭掉才能跑起来。如果你知道我的代码有什么问题，欢迎留言给我，让我修复我的问题。

通过本章学习，我们需要掌握如下技能：

1. 简单配置`main.js`文件。
2. 简单安装组件，以及相应的配置。
3. 遇到错误提示的时候，不要着急，一步一步排查，最终解决问题。

>我的博文和官方文档最大的差别就是，我是一步一步走，并不是简单给你几个命令就好了。在这过程中，我们要学会排查问题，解决问题。要多看官方文档。

本文由FungLeo原创，允许转载，但转载必须附带首发链接。如果你不带链接，我将采取包括但不限于深深的鄙视你等手段！

首发地址：http://blog.csdn.net/fungleo/article/details/53199436
