# React + webpack 开发单页面应用简明中文文档教程（八）Link 跳转以及编写内容页面

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

在前面博文中，我们已经渲染了列表，并且用 `Link` 标签，来进行了跳转。但是我们并没有编写内容页面。这一篇，我们来解决这些问题。

## 创建 page/site/details.jsx 文件

我们创建 `page/site/details.jsx` 文件，并录入一下内容：

```js
// 我们需要在页面顶部，引用我们需要的各种工具
import React, { Component } from 'react'

import Api from '@/tool/api.js'

import Header from '@/coms/header'

// 每一个 jsx 文件都得默认导出一个组件，格式如下
export default class Details extends Component {
  // 在这里，我们设置我们的初始数据，如，这里我们设置 dat 为一个空对象
  // 其他不用管，照抄，自己需要啥就写啥就可以了。
  constructor (props) {
    super(props)
    this.state = {
      dat: {},
      loading: true
    }
  }

  // 当组件加载时，执行一些内容，其他时机执行，请搜索 react 生命周期
  componentDidMount () {
    this.getData()
  }

  // 自定义一个方法，在其他地方用 this.方法名 来调用运行
  getData () {
    // 通过 props.match 来拿到 url 中的 id
    let id = this.props.match.params.id
    Api.get(`topic/${id}`, null, r => {
      this.setState({dat: r.data, loading: false})
    })
  }

  // 每一个 jsx 组件，都必须包含 render 函数，这里渲染出我们的 dom 结构
  render () {
    let { dat, loading } = this.state
    let dom = null
    let reDom = null
    // 我们用 loading 的值来判断是否请求到接口
    // 实际这里可以做更多的处理，比如做一个加载中的组件。
    if (!loading) {
      if (dat.replies.length !== 0) {
        let listDom = dat.replies.map((i, k) => {
          return (
            <li key={k}>
              <h3>{i.author.loginname} 说：</h3>
              <article dangerouslySetInnerHTML={{__html: i.content}}></article>
            </li>
          )
        })
        reDom = (
          <div className='replies_list'>
            <ol>{listDom}</ol>
          </div>
        )
      }
      dom = (
        <div className="outer home">
          <Header title='内容详情' />
          <h2>{dat.title}</h2>
          <p>
            作者：{dat.author.loginname}
            <br />
            日期：{dat.create_at}
          </p>
          <article dangerouslySetInnerHTML={{__html: dat.content}}></article>
          <hr />
          {reDom}
        </div>
      )
    }
    // 最后，把结果 return 出去，即可。
    return dom
  }
}
```

## 配置 @/router/App.js 路由文件

路由文件内容如下：

```js
import React, { Component } from 'react'
import { BrowserRouter as Router, Switch, Route } from 'react-router-dom'

import SiteIndex from '@/page/site/index'
import SiteDetails from '@/page/site/details'

export default class App extends Component {
  render () {
    return (
      <Router basename="/">
        <Switch>
          <Route exact path='/' component={SiteIndex} />
          <Route exact path='/details/:id' component={SiteDetails} />
        </Switch>
      </Router>
    )
  }
}
```

动态参数，我们可以用 `:id` 这种方式写在路由当中。

编写完成之后，我们在首页上点击链接，就可以看到我们刚刚做的详情页面了。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/a2/055cf598a29d615907b8069cd1fea6.jpg)

![](https://raw.githubusercontent.com/fengcms/articles/master/image/ff/6f83ba9b03e9527c7b977e3bb0420a.jpg)

## 其他补充

1. `dangerouslySetInnerHTML={{__html: dat.content}}` 是渲染 `html` 代码的方式。使用时一定要注意安全。
2. `this.props.match.params.id` 是获取 `url` 中的参数的方法。


其他没什么要说的了。都是 js 的基本功了。

通过这八篇博文的学习，我们已经掌握了 `react` 的基本开发了。下面的博文，我们会脱离接口调用这个部分，来讲一些更加进阶的内容。

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。

