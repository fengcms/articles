title: Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（九）再把内容页面渲染出来
date: 2017-08-26 18:02:44 +0800
update: 2017-08-26 18:02:44 +0800
author: fungleo
tags:
    -vue
    -vue-js
    -vuerouter
    -webpack
    -axios
---

# Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（九）再把内容页面渲染出来

## 前情回顾

在上一篇博文《[Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（八）渲染一个列表出来先](http://blog.csdn.net/fungleo/article/details/77603537)》中，我们已经成功的把一个列表给渲染出来了。我们从文章中留下的引子 `<router-link :to="'/content/' + i.id">` 应该知道，我们还是要做内容页面的。

好，这篇文章，就来做我们的内容页面：

## 编写内容页面

照旧，先看东西，再说话：

```html
<template>
  <div>
    <myHeader></myHeader>
    <h2 v-text="dat.title"></h2>
    <p>作者：{{dat.author.loginname}}　　发表于：{{$utils.goodTime(dat.create_at)}}</p>
    <hr>
    <article v-html="dat.content"></article>
    <h3>网友回复：</h3>
    <ul>
      <li v-for="i in dat.replies">
        <p>评论者：{{i.author.loginname}}　　评论于：{{$utils.goodTime(i.create_at)}}</p>
        <article v-html="i.content"></article>
      </li>
    </ul>
    <myFooter></myFooter>
  </div>
</template>
<script>
import myHeader from '../components/header.vue'
import myFooter from '../components/footer.vue'
export default {
  components: { myHeader, myFooter },
  data () {
    return {
      id: this.$route.params.id,
      dat: {}
    }
  },
  created () {
    this.getData()
  },
  methods: {
    getData () {
      this.$api.get('topic/' + this.id, null, r => {
        this.dat = r.data
      })
    }
  }
}
</script>
```

好，我们这边把代码写进 `src/page/content.vue` 文件。然后保存，我在我们先前的列表页面随便点开一篇文章，然后我们看下结果：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/b1/e1b373fcb66dea3125c029e6c7e00a.png)
![](https://raw.githubusercontent.com/fengcms/articles/master/image/1e/7be71e72f5401fe1fa0ae20af16f59.png)
好，按照我们的需求已经渲染出来了。

> 重复一下，样式，我就不管了，自己去写。

## 说明一下里面的重点

### template 部分

其他的内容，我们在列表页面已经见过了。这里第一次出现 `<article v-html="dat.content"></article>` 这个东西。

同样是渲染内容， `v-html` 和 `v-text` 有什么区别呢？其实区别非常简单，`v-text` 会把所有的内容当成字符串给直接输出出来。而 `v-html` 会把字符串给转换为 `html` 标记语言给渲染出来。这部门更多内容，请参考：https://cn.vuejs.org/v2/api/#v-html

**注意了！** 我们在列表中，我们使用的是 `Header` 注意的组件命名方式，为什么我这边用了 `myHeader` 注意的组件命名方式呢？

**其实，我想说明的是，我们不要使用 `html` 本身就支持的标签名称来自定义我们的组件，这容易导致混乱，最好，是像内容页里面这样，使用自定义的标签名。**

> 好吧，我承认，就是我先前写忘掉了，不要鄙视我~~但我感觉这里强调一下也好，省得你以后也忘记了。

### script 部分

代码基本上是一致的，重点是 `id: this.$route.params.id,` 这一句。

还记得我们先前是怎么配置路由的吗？忘记了？点击 [Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（四）调整 App.vue 和 router 路由](http://blog.csdn.net/fungleo/article/details/77600798#t4) 直达。

我们是这么配置的：

```js
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
重点：`path: '/content/:id',` 中，我们使用了 `:id` 这个东西。这是动态路由匹配。参考文档： 《[动态路由匹配](https://router.vuejs.org/zh-cn/essentials/dynamic-matching.html)》

我们需要从我们的 `url` 中，来获取我们的 `id` 然后根据这个 `id` 来进行数据的查询。

好，想起来了。那么我们已经在 `url` 包含了这个 `id` 了。

```#
http://localhost:8080/#/content/58eee565a92d341e48cfe7fc
```
如上：`58eee565a92d341e48cfe7fc` 这个就是 `ID` ，奇怪是奇怪了点，但确实就是 `id`。

我们如何取出来呢？

不用想很多复杂的事情，`vuerouter` 早就给我们准备了解决方法了。

我们可以在项目中打印如下代码：

```js
console.log(this.$route)
```
> 擦，博客写到这里 `cnodejs.org` 网站挂了。。。那就暂时不放我的打印结果图了，大家可以看下官方文档 [路由信息对象的属性](https://router.vuejs.org/zh-cn/api/route-object.html#路由信息对象的属性)

回头，你也可以自己打印了看下，有助于你自己分析理解问题。

好了，除了上面的问题，我们再看下我们的接口数据调用，代码如下：

```js
this.$api.get('topic/' + this.id, null, r => {
  this.dat = r.data
})
```
等于没什么要说的，就是把数据拿过来了而已，需要注意的是，我们的请求的接口地址是根据 `id` 进行变化的。所以，我这边采用了字符串拼接的方法，`'topic/' + this.id` 来得到我们真正想要请求的接口数据。

好，到这里为止，我们已经非常顺利的把列表页面和内容页面已经渲染出来了。希望你也成功了！

> 如果文章由于我学识浅薄，导致您发现有严重谬误的地方，请一定在评论中指出，我会在第一时间修正我的博文，以避免误人子弟。

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。


