# Vue + Webpack 将路由文件分拆为多个文件分别管理简明教程

近日，有网友留言，询问，如何将 `vue` 的路由分拆为多个文件进行管理。这当然是可以的。今天我就来写一个简单的教程，希望对大家有所帮助。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/56/6f54c4da7040c388ac6a8d85495bc2.jpg)


事实是，如果你的项目不是特别大，一般是用不着分拆的。如果项目大了，那就需要考虑分拆路由了。其实，这个操作并不复杂。

当我们用 `vue-cli` 工具，创建一个新的 `vue` 项目时，就已经给大家新建好了一个路由文件 `src/router/index.js` ，内容如下：

```js
import Vue from 'vue'
import Router from 'vue-router'
import HelloWorld from '@/components/HelloWorld'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'HelloWorld',
      component: HelloWorld
    }
  ]
})
```

我们以这个文件为蓝本，进行调整。举例，我们现在要新建一个 `news` 的这个路由，然后这个路由下面，还有一些子路由，我们就可以这样写：

## router/index.js 文件调整

```js
// src/router/index.js
import Vue from 'vue'
import Router from 'vue-router'
// 子路由视图VUE组件
import frame from '@/frame/frame'

import HelloWorld from '@/components/HelloWorld'
// 引用 news 子路由配置文件
import news from './news.js'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'HelloWorld',
      component: HelloWorld
    }, {
      path: '/news',
      component: frame,
      children: news
    }
  ]
})
```

如上，我们引入一个子路由视图的 `vue` 组件，然后再引入 `news` 的子路由配置文件即可。下面我们来编写这两个文件。

## frame/frame 子路由视图 vue 组件

```js
<template>
  <router-view />
</template>
```
子路由视图组件就异常简单了，如上，三行代码即可，有关 `router-view` 的相关内容，请查看： https://router.vuejs.org/zh/api/#router-view

## router/news.js 子路由配置文件

其实，配置这个文件和 `vue` 没有什么关系，纯粹就是 `js es6` 的导出和导入而已。


```js
import main from '@/page/news/main'
import details from '@/page/news/details'

export default [
  {path: '', component: main},
  {path: 'details', component: details}
]
```

如上，即可。我们就完成了路由的多文件管理了。这样看，是不是很简单呢？有什么问题，请在评论中留言，我会抽时间答复大家。

更多内容，请参考官方网站：https://router.vuejs.org/zh/

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。


