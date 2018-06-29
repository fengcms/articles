title: Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（七）初识 *.vue 文件
date: 2017-08-26 16:14:00 +0800
update: 2017-08-26 16:14:00 +0800
author: fungleo
tags:
    -vue
    -vue组件
    -webpack
    -axios
    -vuerouter
---

# Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（七）初识 *.vue 文件

## 前情回顾

在上一篇文章《[Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（六）将接口用 webpack 代理到本地](http://blog.csdn.net/fungleo/article/details/77601761)》中，我们顺利的将接口代理到了本地。需要说明的是， `cnodejs.org` 的这套接口是没有跨域问题的，也就是说，本来我们是不需要代理到本地的。但是我们在实际的工作开发中，接口基本上是有跨域问题的，所以我们需要利用代理的方式来解决问题。

在前面的数篇文章中，我们做了很多的工作，又是干这个，又是干那个的，但一直没有切入到正题，那就是我们要做的工作呢，我们要开发的代码呢。这一篇博文开始，我们要来开发代码了。

## 什么是 *.vue 文件

首先，我们用 `vue-cli` 脚手架搭建的项目，里面我们已经遇到了很多，如 `index.vue` 或者 `App.vue` 这一的文件了。这到底是个什么东西？如果是初次接触 `vue` 开发的同学，可能之前没有见过这个东西。

`*.vue` 文件，是一个自定义的文件类型，用类 `HTML` 语法描述一个 `Vue` 组件。每个 `.vue `文件包含三种类型的顶级语言块 `<template>`, `<script>` 和 `<style>`。这三个部分分别代表了 `html`,`js`,`css`。

其中 `<template>` 和 `<style>` 是支持用预编译语言来写的。比如，在我们的项目中，我们就用了 `scss` 预编译，因此，我们是这样写的：

```html
<style lang="scss">
```

`html` 也有自己的预编译语言， `vue` 也是支持的，不过一般来说，我们前端人员还是比较中意 `html` 原生语言，所以，我就不过多阐述了。

> 另外，我在 `App.vue` 文件中，已经用一句 `@import "./style/style";` 将我们的样式给写到指定的地方去了。所以，在后面所有的我的文章中，是不会出现这个部分的内容的。所有样式，都会在 `src/style/` 文件夹中对应的位置去写。
> 我这样做的好处是，不需要重复的引入各种 `scss` 基础文件，并且做到了项目的样式代码的可管控。

## 一个常见的 *.vue 文件代码解析

首先，我们来简单看一下：

```html
<template>
  <div>
    <Header></Header>
    <div class="article_list">
      <ul>
        <li></li>
      </ul>
    </div>
    <Footer></Footer>
  </div>
</template>
<script>
import Header from '../components/header.vue'
import Footer from '../components/footer.vue'
export default {
  components: { Header, Footer },
  data () {
    return {
      list: []
    }
  },
  created () {
    this.getData()
  },
  methods: {
    getData () {
      this.$api.get('topics', null, r => {
        console.log(r)
      })
    }
  }
}
</script>
<style>
  .article_list {margin: auto;}
</style>
```
好，以上就是一个简单的 `*.vue` 文件的基本结构。我们一部分一部分的来解释。

### template 部分

> 以下，我不再称呼它为 `*.vue` 文件了。改成为 `vue` 组件。

首先，一个 `vue` 组件，他的 `template` 则代表它的 `html` 结构，相信大家可以理解了。但是需要注意的是，我们不是说把代码包裹在 `<template></template>` 中就可以了，**而是必须在里面放置一个 `html` 标签来包裹所有的代码。** 本例子中，我们采用了 `<div></div>` 标签。

> 我个人不喜欢注意，在 `vue1.x` 中，也是不需要这样的。但是不清楚出于什么原因，`vue2.x` 开始，就必须这样去写。龟腚就是龟腚，我们按照这样的标准去写就可以了。

大家看到 `<Header></Header>` 这个代码的时候肯定很奇怪，这是个什么玩意儿。其实，这是一个自定义组件。我们在其他地方写好了一个组件，然后就可以用这种方式引入进来。

同样 `<Footer></Footer>` 也是一个组件。不再累述。

其他的内容，我们就想这么写就怎么写了。和写我们的 `html` 代码没有什么太大的区别。

### script 部分

首先，我们需要两个自定义组件，我们先引用进来。如下格式，比较好理解吧。

```js
import Header from '../components/header.vue'
import Footer from '../components/footer.vue'
```

其次，除了引用的文件，我们将所有的代码包裹于如下的代码中间：

```js
export default {
  // 这里写你的代码，外面要包起来。
}
```

如果你基础比较好，应该知道为什么，如果不知道，也没关系，就这么写就可以了。

> 在这个外面也是可以写代码的。但是你先别管这个，学得深了，自然知道怎么做了。这里先按照标准的来，不要太节外生枝。

好，我们再说说这里面的内容。

```js
  components: { Header, Footer },
```
如上，我们先引入了 `Header` 和 `Footer` 这两个组件的源文件，这里，我们要把引用的组件给申明到 `components` 里面去。这样，我们就可以在 `template` 里面使用了。

```js
  data () {
    return {
      list: []
    }
  },
```
这里，是我们的数据。我们的演示代码，给了一个 `list` 的空数组数据。在 `template` 中，我们可以使用 `this.list` 来使用我们的数据。这个我们后面的文章中会讲到，这里不去深入，认识它就可以了。

```js
  created () {
    this.getData()
  },
```
这里，表示当我们的组件加载完成时，需要执行的内容。比如这里，我们就让组件在加载完成时，执行一个叫 `this.getData()` 的函数。

```js
  methods: {
    getData () {
      this.$api.get('topics', null, r => {
        console.log(r)
      })
    }
  }
```

这里，是我们的这个组件的方法，也可以说是函数。比如，上面的代码就表示，我们的组件自定义了一个叫 `getData()` 的方法函数。

`script` 部分，还有其他的内容，比如 `watch` 之类的。目前，我们还不需要深入到那里。更多的内容，可以查看 `vue` 的官方文档，那里有更加全面的介绍。

参考资料：《[vue 模板语法](https://cn.vuejs.org/v2/guide/syntax.html)》

作为初学者，先掌握这么多的内容就可以了。

### style 部分

这里比较简单，就是针对我们的 `template` 里内容出现的 `html` 元素写一些样式。如上，我的代码：

```html
<style>
  .article_list {margin: auto;}
</style>
```

就是给我们的 `.article_list` 元素随便加了一个样式。

好，到这里，我们应该对 `vue` 组件文件有了一定的认知。后面的博文中，将会涉及到比较多的各种写法，因此，建议在阅读完本文后，花比较多的时间，去查看 `vue` 的官方文档。虽然文档你不一定能全部看懂，但要有一个大概的认识，否则下面的学习将会比较困难。

> 如果文章由于我学识浅薄，导致您发现有严重谬误的地方，请一定在评论中指出，我会在第一时间修正我的博文，以避免误人子弟。

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。

