title: React + webpack 开发单页面应用简明中文文档教程（五）配置 api 接口请求文件
date: 2018-06-28 12:02:29 +0800
update: 2018-06-28 12:02:29 +0800
author: fungleo
tags:
    -react
    -reactjs
    -react请求接口
    -react中文文档
    -react API
---

# React + webpack 开发单页面应用简明中文文档教程（五）配置 api 接口请求文件


## React 入门系列教程导航

[React + webpack 开发单页面应用简明中文文档教程（一）一些基础概念](http://blog.csdn.net/fungleo/article/details/80841159)
[React + webpack 开发单页面应用简明中文文档教程（二）创建项目](http://blog.csdn.net/fungleo/article/details/80841181)
[React + webpack 开发单页面应用简明中文文档教程（三）目录说明以及调整项目构架文件](http://blog.csdn.net/fungleo/article/details/80841200)
[React + webpack 开发单页面应用简明中文文档教程（四）调整项目文件以及项目配置](http://blog.csdn.net/fungleo/article/details/80841220)
[React + webpack 开发单页面应用简明中文文档教程（五）配置 api 接口请求文件](http://blog.csdn.net/fungleo/article/details/80841241)
[React + webpack 开发单页面应用简明中文文档教程（六）渲染一个列表，初识 jsx 文件](http://blog.csdn.net/fungleo/article/details/80841255)
[React + webpack 开发单页面应用简明中文文档教程（七）jsx 组件中调用组件、父组件给子组件传值](http://blog.csdn.net/fungleo/article/details/80841263)
[React + webpack 开发单页面应用简明中文文档教程（八）Link 跳转以及编写内容页面](http://blog.csdn.net/fungleo/article/details/80841274)
[React + webpack 开发单页面应用简明中文文档教程（九）子组件给父组件传值](http://blog.csdn.net/fungleo/article/details/80841290)
[React + webpack 开发单页面应用简明中文文档教程（十）在 jsx 和 scss 中使用图片](http://blog.csdn.net/fungleo/article/details/80841296)
[React + webpack 开发单页面应用简明中文文档教程（十一）将项目打包到子目录运行](http://blog.csdn.net/fungleo/article/details/80841308)

****

我们的项目大多数情况下，是需要和服务端进行交互的。因此，我们需要一个接口请求文件，这里，我们的接口调用，按照老习惯，还是请求 cnodejs.org 提供的公用接口。接口文档查看，请点击 https://cnodejs.org/api

## 配置代理

`react` 的代理配置相比 `vue` 的配置，要简单很多。

我们打开 `package.json` 文件，在最下面加上

```json
,
"proxy": "https://cnodejs.org/"
```
![](https://raw.githubusercontent.com/fengcms/articles/master/image/fc/0d7c95a9f7558a0e9d7e9f2249c7ed.jpg)
如上图所示，我们就配置好了。

注意，配置了代理之后，我们的项目需要重启，才能生效。我们用 `command + c` 停止运行，然后再输入 `npm start` 重新运行项目。

> linux 和 windows 是 ctrl + c 停止终端运行。

## 配置 tool/api.js 文件

我们将我们的接口请求配置文件存放于 `tool/api.js` 这个位置，我们填写以下内容：

> 虽然这个文件比较长，但是还请仔细研究一下，确保搞懂。

```js
var root = '/api/v1'
var request = require('superagent')
function dataType(data) { // 获取数据类型
  return ({}).toString.call(data).match(/\s([a-zA-Z]+)/)[1].toLowerCase()
}
function filterNull(o) { // 过滤值为null的请求参数数据
  for (var key in o) {
    if (o[key] === null) {
      delete o[key]
    }
    if (dataType(o[key]) === 'string') {
      o[key] = o[key].trim()
      if (key === 'asset_id') {
        o[key] = +o[key]
      }
      if (o[key].length === 0) {
        delete o[key]
      }
    } else if (dataType(o[key]) === 'object') {
      o[key] = filterNull(o[key])
    } else if (dataType(o[key]) === 'array') {
      o[key] = filterNull(o[key])
    }
  }
  return o
}
function ajaxAgent(method, url, params, success, failure) { // 发送请求并得到响应
  if (!navigator.onLine) {
    return
  }
  var r = request(method, url).type('application/json').withCredentials()
  if (params) {
    params = filterNull(params)
    if (method === 'POST' || method === 'PUT') {
      if (dataType(params) === 'object') {
        params = JSON.stringify(params)
      }
      r = r.send(params)
    } else if (method === 'GET' || method === 'DELETE') {
      r = r.query(params)
    }
  }
  r.end(function (err, response) {
    if (err) {
      if (failure) {
        failure({ data: err.name + ': ' + err.message, http_status: response.status }, response, 'HTTP_ERROR') // err, res, esta
      } else {
        console.log('网络连接出错，请稍后重试')
      }
    } else {
      // 这里的判断条件，需要和后端进行确认，这里使用的是 cnodejs.org 的规则
      if (response.body.success === true) {
        if (success) {
          success(response.body, response) // rdata, res
        }
      } else {
        if (failure) {
          failure(response.body, response, 'STATUS_ERROR') // err:, res, esta
        } else {
          console.log(response.body.return_msg)
        }
      }
    }
  })
}
function testRequestParams(method, url, params, success, failure) { // 验证请求时，传递的参数
  if (Object.prototype.toString.call(success) !== '[object Function]') {
    try {
      throw new Error('成功的回调函数位置接受的是一个Function,但是却得到一个' + dataType(success))
    } catch (e) {
      console.error(e)
      return
    }
  }
  if (failure) {
    if (Object.prototype.toString.call(failure) !== '[object Function]') {
      try {
        throw new Error('失败的回调函数位置接受的是一个Function,但是却得到一个' + dataType(failure))
      } catch (e) {
        console.error(e)
        return
      }
    }
  }
  if (Object.prototype.toString.call(params) === '[object Object]' || params === null) {
    return ajaxAgent(method, url, params, success, failure)
  } else {
    try {
      throw new Error('接受的是一个对象或者为空(即null),但是却得到一个' + dataType(params))
    } catch (e) {
      console.error(e)
    }
  }
}
export default {
  get: function (url, params, success, failure) {
    testRequestParams('GET', root + '/' + url, params, success, failure)
  },
  post: function (url, params, success, failure) {
    testRequestParams('POST', root + '/' + url, params, success, failure)
  },
  put: function (url, params, success, failure) {
    testRequestParams('PUT', root + '/' + url, params, success, failure)
  },
  delete: function (url, params, success, failure) {
    testRequestParams('DELETE', root + '/' + url, params, success, failure)
  },
  root() {
    return root
  },
  filterNull
}

```

这里，我们使用了 `superagent` 这个接口请求工具，因此，我们需要安装这个这个工具：

```shell
npm i superagent
```

## 测试一下是否正常

我们的配置文件配置完成之后，我们编辑 `page/site/index.jsx` 这个文件，在里面尝试请求一下，看看是否能够请求到数据。

内容如下：

```js
import React, { Component } from 'react'
import Api from '@/tool/api.js'

export default class Index extends Component {
  constructor (props) {
    super(props)
    this.state = {}
  }

  componentDidMount () {
    Api.get('topics', null, r => {
      console.log(r)
    })
  }

  render () {
    return (
      <div className="outer home">
        indexPage
      </div>
    )
  }
}
```

根据这段代码，控制台按照我们的需要，打印出了以下内容。说明我们的配置成功了。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/79/04350f07343578c34a7006e40f894f.jpg)

> `componentDidMount` 是说组件加载时执行，更多内容，请搜索 **react 生命周期** 查看相关内容。
> 
> 如果是初次接触 react 肯定对上面的代码云里雾里，不知所云。但是，这根本就不重要，重要的是项目跑起来，跑起来之后，我们可以慢慢的把这些未知的问题全部搞定。临渊羡鱼不如退而结网。站在河边是学不会游泳的。
> 
> 现在你要做的就是，复制，粘贴，跑起来，成功了，欧耶！

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。

