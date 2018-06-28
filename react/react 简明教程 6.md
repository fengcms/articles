# React + webpack 开发单页面应用简明中文文档教程（六）渲染一个列表，初识 jsx 文件

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

在上一章中，我们顺利的配置了代理，并且请求到了 cnodejs.org 的公开 api 数据。这篇文章中，我们将把我们请求到的数据，渲染出来。

通过这个页面的编写，我们需要对 `react` 的 `jsx` 文件，有一个简单的认识。

## 编辑 page/site/index.jsx 文件，渲染列表

我们继续编辑 `page/site/index.jsx` 这个文件。

```js
// 我们需要在页面顶部，引用我们需要的各种工具
import React, { Component } from 'react'
import { Link } from 'react-router-dom'

import Api from '@/tool/api.js'

// 每一个 jsx 文件都得默认导出一个组件，格式如下
export default class Index extends Component {
  // 在这里，我们设置我们的初始数据，如，这里我们设置 list 为一个空数组
  // 其他不用管，照抄，自己需要啥就写啥就可以了。
  constructor (props) {
    super(props)
    this.state = {
      list: []
    }
  }
  
  // 当组件加载时，执行一些内容，其他时机执行，请搜索 react 生命周期
  componentDidMount () {
    this.getData()
  }
  
  // 自定义一个方法，在其他地方用 this.方法名 来调用运行
  getData () {
    Api.get('topics', null, r => {
      // react 和 vue 很大的不同就是 react 是单向绑定的。
      // 所以，我们不能用直接等于的方法来更新数据
      // 而是要用 setState 的方法更新数据
      this.setState({list: r.data})
    })
  }

  // 每一个 jsx 组件，都必须包含 render 函数，这里渲染出我们的 dom 结构
  render () {
    // 用 es6 的方式引用我们设置的数据
    let { list } = this.state
    let dom = null
    // 下面这段代码比较恶心，尤其是之前学习 vue 的朋友更加觉得如此。
    // 数据的循环，必须使用 .map 方式进行处理，然后 return 出来 dom 结构
    // dom 结构用 () 包裹。单行时可以省略，但是不推荐省略
    if (list.length !== 0) {
      let listDom = list.map((i, k) => {
        return (
          <li key={k}><Link to={`/details/${i.id}`}>{i.title}</Link></li>
        )
      })
      dom = (
        <div className='tipics_list'>
          <ul>{listDom}</ul>
        </div>
      )
    }
    // 最后，把结果 return 出去，即可。
    return (
      <div className="outer home">
        {dom}
      </div>
    )
  }
}
```

我们来看一下运行结果

![](https://raw.githubusercontent.com/fengcms/articles/master/image/a5/30a951f7ab797bfb82d1f2c4a34f16.jpg)

## 其他补充说明

其实上面，我已经在代码中将重点已经全部注释出来了。这里说几个注意点：

1. `react` 非常依赖 `es6` 语法，如果你还不熟悉，建议阅读阮一峰的 es6 教程，不必全部精通，但是要有大概了解。
2. `render` 的 `return` 中必须使用 `js` 表达式，也就是说，不能使用 `if else` 这种判断，只能使用三目运算符。
3. 最重要的是，`react` 是单向绑定的，所以表单处理比较恶心，目前我还没找到很好的解决方法。这里，我怀念一下 `vue`。
4. 但是我也很喜欢 `react` ，因为其大多数情况下，都是原生 `js` 写法，所以基本上不用翻各种文档资料，只要上手了，就可以一直写。而在写 `vue` 的时候，需要不断的查文档。嗯，`vue` 的文档做得非常好。
5. `class` 必须写成 `className` 一开始奇怪，但是被强暴久了也就习惯了。

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。


