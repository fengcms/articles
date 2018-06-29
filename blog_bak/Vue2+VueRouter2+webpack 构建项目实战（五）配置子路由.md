title: Vue2+VueRouter2+webpack 构建项目实战（五）配置子路由
date: 2016-11-18 10:14:17 +0800
update: 2016-11-18 10:14:17 +0800
author: fungleo
tags:
    -Vue2
    -VueRouter2
    -webpack
    -vue
    -vuerouter
---

#Vue2+VueRouter2+webpack 构建项目实战（五）配置子路由

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



##前情回顾
[《Vue2+VueRouter2+webpack 构建项目实战（一）准备工作》](http://blog.csdn.net/fungleo/article/details/53171052)

[《Vue2+VueRouter2+webpack 构建项目实战（二）目录以及文件结构》](http://blog.csdn.net/fungleo/article/details/53171614)

[《Vue2+VueRouter2+webpack 构建项目实战（三）配置路由，整俩页面先》](http://blog.csdn.net/FungLeo/article/details/53199436)

[《Vue2+VueRouter2+webpack 构建项目实战（四）接通api，先渲染个列表》](http://blog.csdn.net/fungleo/article/details/53202276)

##前言

通过前面几章的实战，我们已经顺利的构建项目，并且从API接口获取到数据并且渲染出来了。制作更多的页面，更复杂的应用，就是各位自己根据自己的项目去调整的事情了。

本章讲一下如何配置子路由，因为我们的项目不可能只有一个页面，而是由众多页面构成的。

##新建子路由页面

在第二节中，我们新建了一个`src/frame/subroute.vue`的子页面。当时是留空放在那里的。这里，我们给它填写上内容，代码如下：

```js
<template>
<div>
    <router-view></router-view>
</div>
</template>
```
好，我们的子路由页面就构建好了。

##新建子页面

我们在`src/page`文件夹下新建文件夹`user`，然后在里面新建三个文件`index.vue`，`info.vue`和`love.vue`。代码内容分别如下：

```js
// src/page/user/index.vue
<template>
  <div>user index page</div>
</template>

// src/page/user/info.vue
<template>
  <div>user info page</div>
</template>
// src/page/user/love.vue
<template>
  <div>user love page</div>
</template>
```

好，很简单，三个子页面分别有内容就是了，只是作为演示。

##配置routes.js文件

打开`src/config/routes.js`文件，这个文件就是配置所有路由的文件。首先，在顶部插入下面的代码，引用子路由文件
```js
// 引入子路由
import Frame from '../frame/subroute.vue'
```

然后，我们需要引入我们前面写的俩子页面模板。代码如下：

```js
// 引入子页面
import userIndex from '../page/user/index.vue'
import userInfo from '../page/user/info.vue'
import userLove from '../page/user/love.vue'
```

引入好这些文件之后，我们就开始配置子路由了。

```js
{
  path: '/user',
  component: Frame,
  children: [
    {path: '/',component: userIndex},
    {path: 'info',component: userInfo},
    {path: 'love',component: userLove}
  ],
},
```

如上，新建一个 `user`的顶级路由节点，把`component`设置为`Frame`，然后添加子路由节点`children`,然后下面分别设置。

我的项目的整体代码演示如下：

```js
// 引入子路由
import Frame from '../frame/subroute.vue'
// 引用模板
import index from '../page/index.vue'
import content from '../page/content.vue'
// 引入子页面
import userIndex from '../page/user/index.vue'
import userInfo from '../page/user/info.vue'
import userLove from '../page/user/love.vue'
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
  {
    path: '/user',
    component: Frame,
    children: [
      {path: '/',component: userIndex},
      {path: 'info',component: userInfo},
      {path: 'love',component: userLove}
    ],
  },
]

```

好，我们通过浏览器访问以下，截图如下：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/b1/64bcfb2297823b4dff9f722f271952.jpg)
如上，我们就很顺利的搞好这个子路由了。

##小结

这东西真心是难者不会，会者不难。现在vue的各种官方文档和第三方的教程都非常多，但是很苦恼的是，居然没有一个适应新手入门的教程。

比如一些教程上来就是一堆命令，首先，你得让我知道在哪里输入命令吧！获取你会很惊讶，这都不知道？很奇怪吗？一个windows用户，连cmd都没用过，心血来潮想要学习一下前端，然后打开各种教程一看，各种命令，晕不晕？

若干年前我写过一篇教程文章，看过的人问“文中的‘任意目录’是TM哪个目录？”，我当时很崩溃。这都不知道？随便啊~你爱放哪里放哪里。。。但是，就有人不知道。

而我现在学习前端的各种新东西的时候，一开始也有这种迷茫。太多了，各种各样的东西。所幸我不是一个人在战斗，我和同事一起学习研究，终于，算是入门了。

入门之前，连门在哪里都找不到。

本系列教程不是让你很快的掌握高超的技巧，而是，跟着这个教程走，可以很顺利的搭建起一个项目。虽然，你可能不明白到底是为什么。

但是没有关系，在已经顺利的把一堆代码跑起来的前提下，再去看各种文档和各种教程，就顺利得多了。

最后，祝大家都学习进步。

>我的代码风格不严谨。所以通不过那个劳什子编译检查。比如多个分好啦，多个逗号啦之类的。所以请关闭编译检查后执行，否则，满屏错误不要怪我哦。

本测试项目github地址是 https://github.com/fengcms/vuedemo 之所以前面没放出来，但是给了大量的代码，是让你自己手工干出一个来，而不是clone一下了事。

本文由FungLeo原创，允许转载，但转载必须附带首发链接。如果你不带链接，我将采取包括但不限于深深的鄙视你等手段！

首发地址：http://blog.csdn.net/fungleo/article/details/53213167
