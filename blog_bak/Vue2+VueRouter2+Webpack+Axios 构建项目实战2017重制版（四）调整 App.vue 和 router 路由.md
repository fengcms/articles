title: Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（四）调整 App.vue 和 router 路由
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -Vue
    -VueRouter
    -Webpack
    -app-vue
    -router
---

# Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（四）调整 App.vue 和 router 路由

## 前情回顾

在上一篇《[Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（三）认识项目所有文件](http://blog.csdn.net/fungleo/article/details/77585205)》，我们已经重新整理了我们的目录结构，如果你已经忘记了，可以先去看一下。

如果你按照我的结构框架去调整了之后，那么，现在你的项目应该是出错，并且跑不起来了。所以，我们需要进行一些调整，让项目重新跑起来。

## 调整 App.vue 文件

我们先把默认项目里面没用的东西先删除掉，把代码调整为下面的样子。

```html
<template>
  <div id="app">
    <router-view></router-view>
  </div>
</template>

<script>
export default {
  name: 'app'
}
</script>

<style lang="scss">
  @import "./style/style";
</style>
```

入口，只有一个空的路由视窗，我们的项目的所有内容，都基于这个视窗来展现。

我们的样式，都将从 `src/style/style.scss` 这个文件中引用，因此，在 `App.vue` 这个文件中，直接引用 `./style/style` 即可。

> `scss` 中，引用文件，是可以省略 `.scss` 这个后缀名的。
> 并且，我们某个不用编译成 `css` 的文件，我们给文件命名为 `_xxx.scss` 其中，文件名前缀的下划线，也是可以省略的。
> 更多内容可以参考我以前写的博文《[CSS预编译技术之SASS学习经验小结](http://blog.csdn.net/fungleo/article/details/50851192)》

好，调整好了我们的 `App.vue` 文件后，因为我们使用了 `scss` 文件预编译，所以我们需要安装两个支持 `scss` 的 `npm` 包。

我们在项目终端内输入下面的两句命令来进行安装：

```#
npm install sass-loader -D
npm install node-sass -D
```

![](https://raw.githubusercontent.com/fengcms/articles/master/image/4c/04e5b9a2ed8ad188aab56c17c121d3.png)
![](https://raw.githubusercontent.com/fengcms/articles/master/image/eb/48842711680b1deef58a07878263c9.png)
> 因宿舍翻墙效果不好，这里用 `cnpm` 替代了 `npm` 进行安装的。效果是一样一样的。

## 调整 index.vue 和 content.vue 文件

昨天，我们在 `page` 文件夹下面建立了两个空文本文件 `index.vue` 和 `content.vue` 文件，是我们准备用来放列表和内容的。

这里，我们先去填写一点基础内容在里面。

**index.vue**
```html
<template>
  <div>index page</div>
</template>
```

**content.vue**
```html
<template>
  <div>content page</div>
</template>
```

好，写上如上的代码就行，我们后面再丰富这些内容。

## 调整 router 路由文件

现在，这个项目还跑不起来呢，如果你运行 `npm run dev` 还是会出错的。因为我们还没有配置路由。

```js
import Vue from 'vue'
import Router from 'vue-router'
import Hello from '@/components/Hello'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'Hello',
      component: Hello
    }
  ]
})
```

以上，是默认的路由文件，引用了一个 `Hello` 的组件，这个组件被我们昨天的博文中整理文件结构的时候删除掉了。所以，这里就报错啦。

我们根据我们的需要，来调整这个路由文件，如下：

```js
import Vue from 'vue'
import Router from 'vue-router'
import Index from '@/page/index'
import Content from '@/page/content'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      component: Index
    }, {
      path: '/content/:id',
      component: Content
    }
  ]
})
```
默认，我们的首页，就是我们的 `Index` 组件，这里，你可能要问 `:id` 是什么意思？

因为我们的内容页面是要展示N条内容的，我们如何来区分这些内容呢，就是根据ID来进行区分。所以，这里使用了动态路由匹配。

更多内容，可以参考官方文档《[动态路由匹配](https://router.vuejs.org/zh-cn/essentials/dynamic-matching.html)》

好，我们现在，项目应该是没有任何错误，可以跑起来了。忘记跑起来的命令了？如下：

```#
npm run dev
```

如果你的项目没有能够顺利的跑起来，则说明你哪里写错了。在终端里面或者浏览器里面，是会告诉你出错在哪里的。

但很可能你的英文不是很好，看不懂那些提示。没有关系，借助搜索引擎和翻译引擎，应该能够很快的排查出来，到底是哪里出错了。

另外，我是使用 `Atom` 编辑器来编写代码的。关于如何在 `Atom` 编辑器里面开启代码检查，请参看我另外一篇博文 《[Atom 编辑器安装 linter-eslint 插件，并配置使其支持 vue 文件中的 js 格式校验](http://blog.csdn.net/fungleo/article/details/54581896)》

即便你可能遇到一些问题。但是我希望你还是能够顺利的跑起来，得到如下的结果：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/55/a0f5e6d54350fd83099dc8ff4a5ebd.png)
> 如果文章由于我学识浅薄，导致您发现有严重谬误的地方，请一定在评论中指出，我会在第一时间修正我的博文，以避免误人子弟。

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。


