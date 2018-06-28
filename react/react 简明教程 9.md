# React + webpack 开发单页面应用简明中文文档教程（九）子组件给父组件传值

通过前面八篇博文，我们走下来，已经完成了一个小项目的基本开发。从这个章节开始，我们开始做一些更加高级的事情。

前面我们讲过父组件给子组件传值，非常的简单。但是，子组件如何给父组件传值呢？我们需要明白一个概念，就是 `react` 组件之间的关系，如下图所示：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/d7/8c44077b5b5bef82d411a0de090ed1.jpg)

由上及下特别简单，但是由下到上，就会比较困难。

其实，除了 `react` ，`vue` 也是如此的。

1. 在 `react` 组件中，当 `state` 发生了改变，组件才会更新。
2. 父组件写好 `state` 和处理该 `state` 的函数，并将函数通过 `props` 属性值传送给子组件。
3. 子组件调用父组件传过来的函数，引起父组件 `state` 变化，就把值传给父组件了。

好，概念结束。我认为再多的概念都是为了把你搞迷糊，下面我们来上手搞一个示例，我相信你就明白了。

## 搞一个父组件 @/page/other/father.jsx 文件

我们创建 `@/page/other/father.jsx` 文件，并输入以下内容：

```js
import React, { Component } from 'react'
import Son from '@/coms/son'
export default class Father extends Component {
  constructor (props) {
    super(props)
    this.state = {
      name: null
    }
  }

  componentDidMount () {}
  render () {
    let { name } = this.state
    return (
      <div>
        <p>
          {name ?  `您的姓名是：${name}` : '您还没有输入姓名'}
        </p>
        <Son getName={r => this.setState({name: r})}></Son>
      </div>
    )
  }
}
```

好，我们简单的搞这样一个父组件。然后，我们需要到路由 `@/router/App.js` 文件中去引入这个组件。

```js
import React, { Component } from 'react'
import { BrowserRouter as Router, Switch, Route } from 'react-router-dom'

import SiteIndex from '@/page/site/index'
import SiteDetails from '@/page/site/details'
import OtherFather from '@/page/other/father'

export default class App extends Component {
  render () {
    return (
      <Router basename="/">
        <Switch>
          <Route exact path='/' component={SiteIndex} />
          <Route exact path='/details/:id' component={SiteDetails} />
          <Route exact path='/father' component={OtherFather} />
        </Switch>
      </Router>
    )
  }
}
```

*下回再涉及到路由设置，我就不放全部代码了。*

好，我们父组件搞定，并且配置进路由了，下面我们来写子组件

## 搞定子组件 @/coms/son.jsx

上面，我们已经在父组件的代码中引用了 `@/coms/son` 这个子组件，但是这个文件目前还不存在，所以我们的代码是报错的。下面我们来完善子组件。

```js
import React, { Component } from 'react'
export default class Son extends Component {
  constructor (props) {
    super(props)
    this.state = {
      name: null
    }
  }

  componentDidMount () {}
  render () {
    return (
      <div>
        <input ref='name' type='text'
          onChange={el => this.props.getName(el.target.value)}
        />
      </div>
    )
  }
}
```

好，代码写好了，我们跑起来看一下，如下图所示：

![最终效果演示](https://raw.githubusercontent.com/fengcms/articles/master/image/46/2c0662c341dadce5cb1da90af479b7.git)


## 小结

1. 父组件给子组件传一个设置 `state` 的函数
2. 子组件在合适的时机，将值给这个父组件传来的函数执行。

通过这个简单的示例，应该对 `react` 子组件给父组件传值有了一定的了解了。

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。

