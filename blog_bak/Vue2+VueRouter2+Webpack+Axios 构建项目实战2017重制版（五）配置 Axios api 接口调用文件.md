title: Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（五）配置 Axios api 接口调用文件
date: 2017-08-26 14:42:06 +0800
update: 2017-08-26 14:42:06 +0800
author: fungleo
tags:
    -ajax
    -vue
    -axios
    -cnodejs
    -webpack
---

# Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（五）配置 Axios api 接口调用文件

## 前情回顾

在上一篇《[Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（四）调整 App.vue 和 router 路由](http://blog.csdn.net/fungleo/article/details/77600798)》，我们通过配置基本的信息，已经让我们的项目能够正常的跑起来了。但是，这里还没有涉及到 `AJAX` 请求接口的内容。

`vue` 本身是不支持 `ajax` 接口请求的，所以我们需要安装一个接口请求的 `npm` 包，来使我们的项目拥有这个功能。

> 这其实是一个重要的 `unix` 思想，就是一个工具只做好一件事情，你需要额外的功能的时候，则需要安装对应的软件来执行。如果你以前是一个 `jquery` 重度用户，那么可能理解这个思想一定要深入的理解。

支持 `ajax` 的工具有很多。一开始，我使用的是 `superagent` 这个工具。但是我发现近一年来，绝大多数的教程都是使用的 `axios` 这个接口请求工具。其实，这本来是没有什么差别的。但是为了防止你们在看了我的博文和其他的文章之后，产生理念上的冲突。因此，我也就改用 `axios` 这个工具了。

本身， `axios` 这个工具已经做了很好的优化和封装。但是，在使用的时候，还是略显繁琐，因此，我重新封装了一下。当然，更重要的是，封装 `axios` 这个工具是为了和我以前写的代码的兼容。不过我封装得很好，也推荐大家使用。

## 封装 axios 工具，编辑 src/api/index.js 文件

首先，我们要使用 `axios` 工具，就必须先安装 `axios` 工具。执行下面的命令进行安装

```#
npm install axios -D
```
![](https://raw.githubusercontent.com/fengcms/articles/master/image/f0/cd527684a8f970f94c5ebfe42bb180.png)
> 由于宿舍翻墙条件不好，这里使用 `cnpm` 替代

这样，我们就安装好了 `axios` 工具了。

还记得我们在第三篇博文中整理的系统结构吗？我们新建了一个 `src/api/index.js` 这个空文本文件，就那么放在那里了。这里，我们给它填写上内容。

```js
// 配置API接口地址
var root = 'https://cnodejs.org/api/v1'
// 引用axios
var axios = require('axios')
// 自定义判断元素类型JS
function toType (obj) {
  return ({}).toString.call(obj).match(/\s([a-zA-Z]+)/)[1].toLowerCase()
}
// 参数过滤函数
function filterNull (o) {
  for (var key in o) {
    if (o[key] === null) {
      delete o[key]
    }
    if (toType(o[key]) === 'string') {
      o[key] = o[key].trim()
    } else if (toType(o[key]) === 'object') {
      o[key] = filterNull(o[key])
    } else if (toType(o[key]) === 'array') {
      o[key] = filterNull(o[key])
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
  主要是，不同的接口的成功标识和失败提示是不一致的。
  另外，不同的项目的处理方法也是不一致的，这里出错就是简单的alert
*/

function apiAxios (method, url, params, success, failure) {
  if (params) {
    params = filterNull(params)
  }
  axios({
    method: method,
    url: url,
    data: method === 'POST' || method === 'PUT' ? params : null,
    params: method === 'GET' || method === 'DELETE' ? params : null,
    baseURL: root,
    withCredentials: false
  })
  .then(function (res) {
    if (res.data.success === true) {
      if (success) {
        success(res.data)
      }
    } else {
      if (failure) {
        failure(res.data)
      } else {
        window.alert('error: ' + JSON.stringify(res.data))
      }
    }
  })
  .catch(function (err) {
    let res = err.response
    if (err) {
      window.alert('api error, HTTP CODE: ' + res.status)
    }
  })
}

// 返回在vue模板中的调用接口
export default {
  get: function (url, params, success, failure) {
    return apiAxios('GET', url, params, success, failure)
  },
  post: function (url, params, success, failure) {
    return apiAxios('POST', url, params, success, failure)
  },
  put: function (url, params, success, failure) {
    return apiAxios('PUT', url, params, success, failure)
  },
  delete: function (url, params, success, failure) {
    return apiAxios('DELETE', url, params, success, failure)
  }
}
```
好，我们写好这个文件之后，保存。

> 2017年10月20日补充，删除了评论中有人反映会出错的 `return` ，确实这个 `return` 是没有什么作用的。不过我这边确实没出错。没关系啦，本来就没啥用，只是一个以前的不好的习惯代码。

有关 `axios` 的更多内容，请参考官方 `github`： https://github.com/mzabriskie/axios ，中文资料自行百度。

但就是这样，我们还不能再 `vue` 模板文件中使用这个工具，还需要调整一下 `main.js` 文件。

## 调整 main.js 绑定 api/index.js 文件

这次呢，我们没有上来就调整 `main.js` 文件，因为原始文件就配置得比较好，我就没有刻意的想要调整它。

原始文件如下：

```js
import Vue from 'vue'
import App from './App'
import router from './router'

Vue.config.productionTip = false

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  template: '<App/>',
  components: { App }
})
```
我们插入以下代码：

```js
// 引用API文件
import api from './api/index.js'
// 将API方法绑定到全局
Vue.prototype.$api = api
```
也就是讲代码调整为：

```js
import Vue from 'vue'
import App from './App'
import router from './router'

// 引用API文件
import api from './api/index.js'
// 将API方法绑定到全局
Vue.prototype.$api = api

Vue.config.productionTip = false

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  template: '<App/>',
  components: { App }
})
```
好了，这样，我们就可以在项目中使用我们封装的 `api` 接口调用文件了。

## 测试一下看看能不能调通

我们来修改一下 `src/page/index.vue` 文件，将代码调整为以下代码：

```html
<template>
  <div>index page</div>
</template>
<script>
export default {
  created () {
    this.$api.get('topics', null, r => {
      console.log(r)
    })
  }
}
</script>
```
好，这里是调用 `cnodejs.org` 的 `topics` 列表接口，并且将结果打印出来。

我们在浏览器中打开控制台，看看 `console` 下面有没有输出入下图一样的内容。如果有的话，就说明我们的接口配置已经成功了。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/91/e7f52b3bef0ca4ba6c02d5185f2494.png)
好，如果你操作正确，代码没有格式错误的话，那么现在应该得到的结果是和我一样的。如果出错或者怎么样，请仔细的检查代码，看看有没有什么问题。

> 如果文章由于我学识浅薄，导致您发现有严重谬误的地方，请一定在评论中指出，我会在第一时间修正我的博文，以避免误人子弟。

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。


