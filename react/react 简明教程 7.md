# React + webpack 开发单页面应用简明中文文档教程（七）jsx 组件中调用组件、父组件给子组件传值

在上一章中，我们成功调取数据，并渲染了一个列表。应该还是有成就感的吧。

这一章，我们来实现父子组件之间的传值。

## 创建 @/coms/header.jsx 组件

新建这个文件，并输入以下代码：

```js
import React, { Component } from 'react'

export default class Header extends Component {
  render () {
    let { title } = this.props
    return (
      <header className='header'>
        <h1>{title}</h1>
      </header>
    )
  }
}
```

由上面的代码，我们可以看到 `this.props` 是用来接收父组件的传值的。怎么传值的呢？我们去修改我们的 `page/site/index.jsx` 文件

## 父组件调用并传值给子组件

```js
import React, { Component } from 'react'
import { Link } from 'react-router-dom'

import Api from '@/tool/api.js'

// 这样，调用我们的自定义的组件
import Header from '@/coms/header'

export default class Index extends Component {
  constructor (props) {
    super(props)
    this.state = {
      list: []
    }
  }

  componentDidMount () {
    this.getData()
  }

  getData () {
    Api.get('topics', null, r => {
      this.setState({list: r.data})
    })
  }

  render () {
    let { list } = this.state
    let dom = null
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
    return (
      <div className="outer home">
        {/* 我们像用 html 标签一样，使用我们的自定义组件，并通过标签的方式，传值 */}
        <Header title='网站首页'></Header>
        {dom}
      </div>
    )
  }
}
```

好，我们跑起来看一下：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/a6/5d287adce75152d78ff559c55bcdb1.jpg)

> 我把那个红色的背景给去掉了。

如上，我们顺利的把值传给了子组件，并且子组件顺利的给显示出来了。

## 其他补充

1. `<Header title='网站首页'></Header>` 这的书写方式，也可以写成 `<Header title='网站首页' />`
2. 传值是可以传各种东西的。数字，函数，布尔值，对象，啥都能传。
3. 传的值的格式必须对上，否则会报错的。

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。

