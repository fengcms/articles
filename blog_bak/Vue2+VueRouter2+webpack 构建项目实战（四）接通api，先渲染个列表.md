title: Vue2+VueRouter2+webpack 构建项目实战（四）接通api，先渲染个列表
date: 2016-11-17 16:41:36 +0800
update: 2016-11-17 16:41:36 +0800
author: fungleo
tags:
    -Vue2
    -VueRouter2
    -webpack
    -api
---

#Vue2+VueRouter2+webpack 构建项目实战（四）接通api，先渲染个列表

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

通过前面几篇教程，我们已经顺利搭建起来了，并且已经组建好路由了。本章节，我们需要做一个列表页面，然后利用获取 http://cnodejs.org/api 的公开API，渲染出来。

##制作列表页面

我们打开`src/page/index.vue`文件，在这里写入下面的代码：
```js
<template>
  <div>
    <h1 class="logo">cnodejs Api Test</h1>
    <ul class="list">
      <li v-for="item in lists" v-text="item.title"></li>
    </ul>
  </div>
</template>
<script>
export default {
  data() {
    return {
      lists:[{
        id:1,
        title:"test title 1"
      },{
        id:2,
        title:"test title 2"
      }]
    }
  }
}
</script>
```

如上，我们通过自己写的两组数据，很轻松的将页面渲染成功了。通过浏览器，我们可以看到效果

![](https://raw.githubusercontent.com/fengcms/articles/master/image/f7/2bdcc2ba4457dcc335e039326003b2.jpg)
##配合点css

这里，我着重强调的不是css如何去写，而是我的组织项目的结构，我感觉我组织得还是很不错的。

新建文件， `src/style/scss/_index.scss`

输入下面的内容

```css
.logo {color: red;}
.list {
  line-height: 2;
  li {border-bottom: 1px solid #ddd;}
}

```
然后在 `src/style/style.scss`中输入

```css
@import "scss/index";
```

然后，我们就可以在浏览器中，看到带样式的列表了。

**我的习惯是，一个文件，一个样式，文件位于`src/page/`文件夹下面，样式位于`src/style/scss`下面。文件和样式同名。如果文件位于子目录，如`src/page/user/pay.vue`，那么，对应的`scss`文件就是`src/style/scss/user/_pay.scss`这样。**

每一个团队的规范都是不一样的，都是各有所长的，重要的是，条理性。

##调用api.js

在第二节中，我们在`src/config`目录下面建立了一个`api.js`的空文件。在第三节中没有使用。本节，我们要开始使用了。

首先，我们编辑 `src/main.js` ，引用 `src/config/api.js`。如下：

```js
import api from './config/api'
Vue.prototype.$api = api
```
插入这两行代码，就引用好了`api.js`，并且，把它绑定到了全局，然后我们就可以在各种地方使用这个文件了。虽然这个文件是空的。

可能部分朋友不知道插入到文件的哪里去。我这里放上`main.js`的全部代码：
```js
// 引用 vue 没什么要说的
import Vue from 'vue'
// 引用路由
import VueRouter from 'vue-router'
// 光引用不成，还得使用
Vue.use(VueRouter)
// 入口文件为 src/App.vue 文件 所以要引用
import App from './App.vue'
// 引用路由配置文件
import routes from './config/routes'
// 引用API文件
import api from './config/api'
// 将API方法绑定到全局
Vue.prototype.$api = api
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
##安装superagent组件
要请求接口，就必须有相对应的组件。如果你使用过`jquery`，应该熟悉其中的`AJAX`方法。当然，在`vue`中，我们就不考虑使用`jquery`了。我们使用`superagent`这个组件。

安装非常简单，我们首先跳转到项目根目录，然后输入 `npm install superagent -D`进行安装。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/9f/e21fdf1e3209a7445e5a6628f3ce8f.jpg)
##编写api.js文件

有了工具了，我们就需要来编写`api.js`文件，使它可以完成我们想要的工作。

```js
// 配置API接口地址
var root = 'https://cnodejs.org/api/v1';
// 引用superagent
var request = require('superagent');
// 自定义判断元素类型JS
function toType(obj) {
  return ({}).toString.call(obj).match(/\s([a-zA-Z]+)/)[1].toLowerCase()
}
// 参数过滤函数
function filter_null(o) {
  for (var key in o) {
    if (o[key] == null) {
      delete o[key]
    }
    if (toType(o[key]) == 'string') {
      o[key] = o[key].trim()
      if (o[key].length == 0) {
        delete o[key]
      }
    }
  }
  return o
}
/*
  接口处理函数
  这个函数每个项目都是不一样的，我现在调整的是适用于
  https://cnodejs.org/api/v1 的接口，如果是其他接口
  需要根据接口的参数进行调整。参考说明文档地址：
  https://cnodejs.org/topic/5378720ed6e2d16149fa16bd
*/
function _api_base(method, url, params, success, failure) {
  var r = request(method, url).type('text/plain')
  if (params) {
    params = filter_null(params);
    if (method === 'POST' || method === 'PUT') {
      if (toType(params) == 'object') {
        params = JSON.stringify(params);
      }
      r = r.send(params)
    } else if (method == 'GET' || method === 'DELETE') {
      r = r.query(params)
    }
  }
  r.end(function(err, res) {
    if (err) {
      alert('api error, HTTP CODE: ' + res.status);
      return;
    };
    if (res.body.success == true) {
      if (success) {
        success(res.body);
      }
    } else {
      if (failure) {
        failure(res.body);
      } else {
        alert('error: ' + JSON.stringify(res.body));
      }
    }
  });
};
// 返回在vue模板中的调用接口
export default {
  get: function(url, params, success, failure) {
    return _api_base('GET', root + '/' + url, params, success, failure)
  },
  post: function(url, params, success, failure) {
    return _api_base('POST', root + '/' + url, params, success, failure)
  },
  put: function(url, params, success, failure) {
    return _api_base('PUT', root + '/' + url, params, success, failure)
  },
  delete: function(url, params, success, failure) {
    return _api_base('DELETE', root + '/' + url, params, success, failure)
  },
}
```
这个文件就有点狂拽酷炫吊炸天了。目前，我们测试`cnodejs.org`的接口，我调整得可以使用。实际上在其他的接口项目中，这个是需要调整的，要调整到你的项目合适的代码。主要是根据接口返回的内容进行各种判断和处理，其中主要的框架代码是不用动的。

如果你JS基础过硬，一看就懂，如果不行，就慢慢看，慢慢理解吧。反正我基础不成，也看着理解了。

##模板中调用api接口试试

编辑`src/page/index.vue`文件，代码如下：

```js
<template>
  <div>
    <h1 class="logo">cnodejs Api Test</h1>
    <ul class="list">
      <li v-for="item in lists" v-text="item.title"></li>
    </ul>
  </div>
</template>
<script>
export default {
  data() {
    return {
      lists:[]
    }
  },
  created () {
    // 组件创建完后获取数据，这里和1.0不一样，改成了这个样子
    this.get_data()
  },
  methods: {
    get_data: function(params) {
      var v = this
      if (!params) params = {}
      // 我们这里用全局绑定的 $api 方法来获取数据，方便吧~
      v.$api.get('topics', params, function(r) {
        v.lists = r.data
      })
    },
  },
}
</script>
```
保存后，我们在浏览器中，就可以看到渲染出来的列表了。如下图所示：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/c1/110bd0c24040b6a2b330628ebef897.jpg)
##小结

好，通过本节的学习，我们已经顺利的从接口获取到数据，并且渲染到我们的页面当中了。这其实已经解决了绝大多数的问题了。

1. 如何新建一个js文件，并且把这个文件引用，然后绑定到全局
2. 学习理解`superagent`插件。
3. 如何在vue模板中调用绑定的方法。
4. 组件渲染完成时，执行函数。

> 我的这个教程着重演示各个部分如何衔接，完成，并非要做一个十全十美的东西，因此，只要能把数据读取出来即可，至于更多的内容的渲染，以及更好看的样式，不是我这里要考虑的事情。可以看我其他的博文。

本文由FungLeo原创，允许转载，但转载必须附带首发链接。如果你不带链接，我将采取包括但不限于深深的鄙视你等手段！

首发地址：http://blog.csdn.net/fungleo/article/details/53202276
