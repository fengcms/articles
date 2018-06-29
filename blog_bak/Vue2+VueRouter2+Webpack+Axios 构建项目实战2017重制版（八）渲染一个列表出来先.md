title: Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（八）渲染一个列表出来先
date: 2017-08-26 17:08:53 +0800
update: 2017-08-26 17:08:53 +0800
author: fungleo
tags:
    -vue
    -vuerouter
    -cnodejs
    -webpack
    -axios
---

# Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（八）渲染一个列表出来先

## 前情回顾

在上一篇博文《[Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（七）初识 *.vue 文件](http://blog.csdn.net/fungleo/article/details/77602914)》中，我们队 `vue` 组件应该有了一个简单的认识。如果你去看了官方文档的话，再看这篇博文会比较简单。如果你没去看，呵呵，恭喜你，我喜欢你这样的人。

好，这章开始，真的得写点东西了。

## 制作 header.vue 和 footer.vue 组件文件。

不是本篇文章的重点，但是还是有比较讲一下。在第三篇博文中，我们规划了我们的项目文件结构，当时保留了一个 `components` 的空文件夹。这里，就是准备放我们的自定义组件的。

首先，我们去创建两个空文本文件，分别是 `header.vue` 文件和 `footer.vue` 文件。

然后，往里面输入下面的内容：

**header.vue**
```html
<template>
  <header class="header">
    <h1 class="logo">Vue Demo by FungLeo</h1>
  </header>
</template>
```
**footer.vue**
```html
<template>
  <footer class="copy">
    Copy &copy; FungLeo
  </footer>
</template>
```
非常简单的两个文件，表示我们的组件已经弄好了。

## 编写 src/page/index.vue 文件

少啰嗦，看东西：

```html
<template>
  <div>
    <Header></Header>
    <div class="article_list">
      <ul>
        <li v-for="i in list">
          <time v-text="i.create_at"></time>
          <router-link :to="'/content/' + i.id">
            {{ i.title }}
          </router-link>
        </li>
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
        this.list = r.data
      })
    }
  }
}
</script>
```

如上，代码，我就把页面渲染出来了。我们看下实际的效果：


![](https://raw.githubusercontent.com/fengcms/articles/master/image/6e/d3858d6af5bbaa2eac53793b5372aa.png)
前面一片文章已经让我们认知了 `vue` 组件了。这里我不过多的阐述，省得嫌弃我啰嗦。我只挑几个重点来讲一下：

```html
<li v-for="i in list">
  <time v-text="i.create_at"></time>
  <router-link :to="'/content/' + i.id">
    {{ i.title }}
  </router-link>
</li>
```
如上，我先用了一个 `v-for` 的循环，来循环数据。这里可以参考：https://cn.vuejs.org/v2/api/#v-for 文档。

在 `time` 标签中，我使用了 `v-text="i.create_at"` 来渲染时间数据。参考文档： https://cn.vuejs.org/v2/api/#v-text

`router-link` 是 `VueRouter2` “声明式导航”的写法，在实际转换为 `html` 标签的时候，会转化为 `<a></a>`，里面的 `to` 属性，就相当于 `a` 的 `href` 属性。参考文档：https://router.vuejs.org/zh-cn/essentials/getting-started.html


好，`html` 的部分就说到这里，更多的内容，就交给你们自由发挥去吧。

```js
this.$api.get('topics', null, r => {
  this.list = r.data
})
```
**2017年09月19日补充 不用箭头函数，用普通函数怎么写这段代码**

评论区，有人问用普通函数如何写这段内容。这个是 `js` 的基础内容，和 `vue` 本身无关。

示例代码如下：

```js
var v = this
v.$api.get('topics', null, function (r) {
  v.list = r.data
})
```

**补充结束**

由于有了前面几篇文章的积累，这里就比较好理解了。

我们从接口拿到了 `r.data` 的数据，让我们自己定义的 `this.list` 等于这个数据，然后我们在模板中就可以用 `list` 进行渲染了。这里着重体现了 `vue` 的数据双向绑定的特性。

## 写一个公用的时间处理工具函数

如上面的图片所示，由于拿到的数据是一个标准的时间格式，直接渲染在页面上，这个效果不是很理想。因此，我们可以把时间给处理一下，然后再渲染出来。

这里，我们可以直接在 `getData () {...}` 后面再写一个方法即可。但是，在一个项目中，如果所有的地方都是这样的时间格式，我们在每一个组件中都来写这样的处理方法，很显然就显得我们比较愚蠢了。

因此，我们可以独立出来写一个方法，然后在所有的地方都可以使用，这样就比较方便了。

还记得我们在第三篇博文中，我们建立了一个 `src/utils/index.js` 的空文本文件吗？这里，我们要用上了。

### 编写 src/utils/index.js 文件

直接给代码如下：

```js
export default {
  goodTime (str) {
    let now = new Date().getTime()
    let oldTime = new Date(str).getTime()
    let difference = now - oldTime
    let result = ''
    let minute = 1000 * 60
    let hour = minute * 60
    let day = hour * 24
    let month = day * 30
    let year = month * 12
    let _year = difference / year
    let _month = difference / month
    let _week = difference / (7 * day)
    let _day = difference / day
    let _hour = difference / hour
    let _min = difference / minute

    if (_year >= 1) {
      result = '发表于 ' + ~~(_year) + ' 年前'
    } else if (_month >= 1) {
      result = '发表于 ' + ~~(_month) + ' 个月前'
    } else if (_week >= 1) {
      result = '发表于 ' + ~~(_week) + ' 周前'
    } else if (_day >= 1) {
      result = '发表于 ' + ~~(_day) + ' 天前'
    } else if (_hour >= 1) {
      result = '发表于 ' + ~~(_hour) + ' 个小时前'
    } else if (_min >= 1) {
      result = '发表于 ' + ~~(_min) + ' 分钟前'
    } else {
      result = '刚刚'
    }
    return result
  }
}
```
好，代码恶心了点，我拿我以前写的代码改的，没有深入优化，大家就随便看看，大概就是这么个东西。

写好代码之后，我们保存文件。但是此时，我们还不能使用我们的这个方法函数。我们必须在 `main.js` 中将我们的方法函数给绑定上。如下代码：

```js
// 引用工具文件
import utils from './utils/index.js'
// 将工具方法绑定到全局
Vue.prototype.$utils = utils
```

还记得我们先前是如何将我们的接口请求函数给绑定上的吗？这里其实是采用了同样的方法。如果不记得了，可以[点击链接](http://blog.csdn.net/fungleo/article/details/77601270)过去看看。

好了，这样，我们写的这个函数，就可以随便被我们调用了。我们再来修改一下我们上面的 `index.vue` 中的代码，将 `time` 调整为：

```html
<time v-text="$utils.goodTime(i.create_at)"></time>
```

然后，我们再来看一下实际的效果：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/92/a9211d4a95259e095d8f59cf0551f3.png)
好，我们已经看到，时间已经搞的挺好的了。

> 样式，不是我这个 `demo` 的重点，所以，样式自己去写吧。我就不写了。

不知道大家有没有发现，我们在 `script` 区域，引用一个函数是使用 `this.getData` 或者 `this.list` 这样的代码引用的。但是在 `template` 中，我们是不加 `this` 的。

**在 `js` 中，关于 `this` 的论文就很多，我这里不深入讲解了。大家只要记住这样用就可以了。**

好，我们的列表已经渲染出来了。终于见了点真章，应该很激动了吧。下面，我们继续。

> 如果文章由于我学识浅薄，导致您发现有严重谬误的地方，请一定在评论中指出，我会在第一时间修正我的博文，以避免误人子弟。

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。


