title: vue-router 多个路由地址绑定一个组件造成 created 不执行的解决方法
date: 2017-01-06 17:08:54 +0800
update: 2017-01-06 17:08:54 +0800
author: fungleo
tags:
    -vue-router
    -vue
    -created
    -VueRouter2
---

#vue-router 多个路由地址绑定一个组件造成 created 不执行的解决方法

##需求分析

导航上有2个菜单，指向的是同一个列表，但是是不同的状态。我需要根据不同的状态获取状态参数给接口拿到不同的数据。

需求貌似很简单 \*0_0\*。

本文只针对有一定vue基础的同学有用，如果你是其他框架的同学请忽略。如果想学习vue但不是很熟悉的同学，可以参看我的vue相关博客 [ Vue2+VueRouter2+webpack 构建项目实战](http://blog.csdn.net/fungleo/article/details/53171052)

为说明核心问题，只放出核心代码。其他代码请自行脑补。

##执行方案1

通过问号传参解决方案

**菜单配置**

|菜单|路由|
|-|-|
|进行中|/list?status=doing|
|已结束|/list?status=finish|

**路由配置**

```js
{path: 'list', component: list}
```

**页面代码**
```js
created () {
  console.log(this.$route.query.status)
}
```

**执行结果**

如上，我希望得到结果是，点击不同的菜单，得到不同的状态值，然后我就可以拿这个值去向接口请求信息了。结果是，只有从其他页面来这边的时候，才会出现一次，但是，在这两个页面之间进行切换的时候，毛都没有。。。。

**装模作样总结原因**

路由没有发生变化，因此，只有在第一次进入的时候会因为`created`执行。在这两个页面之间进行切换，是不会触发这个执行的。

好，貌似找到原因，进行修改。

##执行方案2

通过配置不同的路由进行获取传参

**菜单配置**

|菜单|路由|
|-|-|
|进行中|/list/doing|
|已结束|/list/finish|

**路由配置**

```js
{
  path: '/list',
  component: frame,
  children: [
    {path: 'doing', component: list},
    {path: 'finish', component: list}
  ]
}
```

**页面代码**
```js
created () {
  console.log(this.getStatus(this.$route.path))
},
methods: {
  getStatus (urlStr) {
    var urlStrArr = urlStr.split('/')
    return urlStrArr[urlStrArr.length - 1]
  }
}
```

**执行结果**

代码看上去健壮了很多嘛，执行以下看看。。。。

干他大娘的，和第一个执行结果一毛一样啊！！！只有第一次打开的时候，才会执行，在两个之间切换，啥都没发生。。。。

**装模作样总结原因**

虽然路由地址变化了，但是还是只想的是同一个组件，而`created`是创建组件的时候执行，这个钩子根本就不适用啊。。。

翻查`vue-router` 官方文档，始终找不到一个合适的钩子来执行代码。咋整？？

一页一页的翻看官方文档，终于找到了解决方法，参看 [响应路由参数的变化](http://router.vuejs.org/zh-cn/essentials/dynamic-matching.html#响应路由参数的变化)

###最终解决方案

其他设置和方案2一样，页面代码如下：

**页面代码**
```js
created () {
  console.log(this.getStatus(this.$route.path))
},
methods: {
  getStatus (urlStr) {
    var urlStrArr = urlStr.split('/')
    return urlStrArr[urlStrArr.length - 1]
  }
},
watch: {
  '$route' (to, from) {
    console.log(this.getStatus(this.$route.path))
  }
}
```

##小结

我这种够用就行的学习方案很不合适，需要把所有的文档都细看一遍，然后解决问题的时候才能有准确的方向。。。说啥呢，都是无知惹的祸。。。。
