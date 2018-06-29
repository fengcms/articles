title: Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（十四）在项目中使用 jQuery
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -jquery
    -vue
    -webpack
    -axios
    -import
---

# Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（十四）在项目中使用 jQuery

## 前情回顾

在上一篇博文中，我们讲到了，如何在 `vue` 项目中 使用百度的 `UEditor` 富文本编辑器，详情点击《[Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（十三）集成 UEditor 百度富文本编辑器](http://blog.csdn.net/fungleo/article/details/77867583)》。相信大家对引用这种非 `npm` 的包有了一定的认识。

很多人学习 `js` 都是从 `jQuery` 开始的，我也不例外。有时候进行一些操作的时候，还是感觉 `jQuery` 比较好用，那么，我们如何在项目中使用 `jQuery` 呢？这篇博文带你实践。

## 引用 jQuery 文件

首先呢，`jQuery` 是提供了 `npm` 的安装包的。我们的 `vue-cli` 脚手架，也是支持引入的。不过设置比较麻烦，如果你对使用这种方法比较敢兴趣，可以直接参考下面的内容：

1. [How to include jQuery into Vue.js](https://maketips.net/tip/223/how-to-include-jquery-into-vuejs)
2. [How to use a jQuery plugin inside Vue](https://stackoverflow.com/questions/37928998/how-to-use-a-jquery-plugin-inside-vue#39653758)

虽然资料是英文的，但是阅读应该不成问题。

好，我们不说这种方式引入 `jQuery` 而是引用文件的方式引用。

首先，我们下载 `jQuery` 文件到我们的 `/static/js/` 目录。正好我本地有一个 `jquery-1.8.3.js`，我就放了这么一个 `jQuery` 文件到我们的演示项目里。

然后，在 `/src/main.js` 合适位置插入下面的代码：

```js
// import 'jquery'
import '../static/js/jquery-1.8.3.js'
```

> jQuery 文件路径名，请保持和你自己的一致。

好，这样，我们就引入成功了。

> 经过测试，这个方法不适用于高版本的 `jquery` 高版本请直接使用下面第二种方法引入。

**补充第二个方法**

上面，我们是在 `main.js` 文件中引用 `jQuery` 其实，我们还可以在 `/index.html` 直接引用。

我们编辑 `/index.html` 在 `head` 区域插入下面的代码

```html
<script src="static/js/jquery-1.8.3.js"></script>
```
直接这样引用，就可以在项目中愉快的写 `jquery` 代码了。

> so，明白我为什么不用 `npm` 安装那种啰嗦的方法了吧~，其实，更多的东西，我们都可以使用这两种方法来引入。因为，这样引入，可以加快打包速度。最佳状态是，打包只打包我们自己的代码。
> 不过在正常开发来说，需要时不时的安装一个包，这时候，还是 `npm` 的包管理来得非常方便。但对于一个成熟项目的各种优化来说，这里就可以不断的尝试优化了。
> 这里，我只是提供了这个思路，我并不推荐任何东西都这么做，尤其是开发阶段！

## 搞一个文件测试一下 jQuery 是否可用

新建 `/src/page/jq.vue` 文件，录入下面的内容

```html
<template>
  <div class="love">
    <p>这里是初始文字</p>
    <button @click="testJQ">看看 jquery 有没有工作</button>
  </div>
</template>
<script>
export default {
  methods: {
    testJQ () {
      $('.love p').html('jquery 工作正常！')
    }
  }
}
</script>
```
> 这段代码逻辑非常简单，就是点击的时候改变 `p` 的文字。

将路由配置为 `/jq`，具体操作不表，不会看前面的文章，或者我的 `github` 源码。

好，如果你的编辑器配置了代码审查的话，应该报错了。而浏览器里面，也是报错的。

## 去掉 eslint 报错 '$' is not defined

虽然引用了 `jQuery` 但是你真正去写的时候，会报这个错误。我们首先需要关闭掉这个错误。

关闭有两种方法，一种是临时关闭，一种是永久关闭。我这里提供永久关闭的方法。

我们编辑 `/.eslintrc.js` 文件

```js
  env: {
    browser: true,
    jquery: true
  },
```
在 `env` 区间里面加上 `jquery: true` 参数即可。

然后我们重新跑一下系统 `npm run dev` 就应该可以看到我们想要的效果了。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/b9/0648e7ab2cdf5259003adaf2f976dd.gif)
更加复杂的操作，我没有尝试。但是我可以肯定，绝对没有原生写那样顺畅。还必须依赖 `vue` 的一些方法什么的。我的建议是，一般不使用 `jQuery`，如果使用的话，请确保在可控的范围内。否则，你算是给项目埋大坑了。

> 如果文章由于我学识浅薄，导致您发现有严重谬误的地方，请一定在评论中指出，我会在第一时间修正我的博文，以避免误人子弟。

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。

## 2017年10月19日补充

看到评论中反应使用1.10以上版本的 `jquery` 会始终报错。另外非常感谢有朋友给出了别人的解决方法。

我今天测试了一下，确实发现这个问题。但是我想解决方法用不着那么复杂。直接在 `index.html` 使用如下代码引入 `jquery` 然后配置一下 `eslint` ，然后就在项目中使用就可以了。

```html
<script src="static/js/jquery-3.2.1.min.js"></script>
```
就是使用第一节中我说的第二个方法引入。

`github` 代码已更新。

如有其他问题，欢迎继续给我评论中留言。


