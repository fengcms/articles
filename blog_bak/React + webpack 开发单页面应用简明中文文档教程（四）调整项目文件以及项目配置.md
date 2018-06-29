title: React + webpack 开发单页面应用简明中文文档教程（四）调整项目文件以及项目配置
date: 2018-06-28 12:00:42 +0800
update: 2018-06-28 12:00:42 +0800
author: fungleo
tags:
    -react
    -reactjs
    -react中文文档
    -react入门教程
    -react文件说明
---

# React + webpack 开发单页面应用简明中文文档教程（四）调整项目文件以及项目配置


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

在上一篇博文中，我们很好的认识了项目的各个文件的所用，并且进行了一些调整。经过这些调整之后，我们的项目已经很成功的跑不起来了。

嗯，我们要接着干，才能让我们的项目跑起来。

## 编辑调整项目 src 文件

### 配置 index.js 文件

原文内容如下：

```js
import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import App from './App';
import registerServiceWorker from './registerServiceWorker';

ReactDOM.render(<App />, document.getElementById('root'));
registerServiceWorker();
```

我们调整为

```js
import React from 'react'
import ReactDOM from 'react-dom'
import './style/style.scss'
import App from './router/App'
import registerServiceWorker from './registerServiceWorker'

ReactDOM.render(<App />, document.getElementById('root'))
registerServiceWorker()
```

如上，我们引入了俩文件，一个是 `style.scss` 和 `route/App.js` 文件

> .js 和 .jsx 后缀是可以省略的。

所以，我们需要去创建这俩文件。

> 我们遵循 JavaScript Standard Style 风格编写代码，所以，我们是不写分号的。更多相关标准，请参考： https://blog.csdn.net/fungleo/article/details/77934448

### 配置 style.scss 文件

首先，我们创建这个文件，然后在里面写入一下内容：

```scss
//$res: "/erjimulu/image/"; // 打包时用此路径
$res: "/image/"; // 本地开发是用此路径
body {
  background: #f00;
}
```

好了，不管他了。

### 配置 router/App.js 文件

这里是我们的路由入口文件，我们写入一下内容：

```js
import React, { Component } from 'react'
import { BrowserRouter as Router, Switch, Route } from 'react-router-dom'

import SiteIndex from '@/page/site/index'

export default class App extends Component {
  render () {
    return (
      <Router basename="/">
        <Switch>
          <Route exact path='/' component={SiteIndex} />
        </Switch>
      </Router>
    )
  }
}
```

好的，我们在这里，引用了一个 `@/page/site/index` 文件，所以，下面我们再去写这个文件

### 编写 page/site/index.jsx 首页文件

```js
import React, { Component } from 'react'

export default class Index extends Component {
  constructor (props) {
    super(props)
    this.state = {}
  }

  componentDidMount () {
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

好了，现在你是不是迫不及待的去运行 `npm start` 命令，希望看到自己的工作成果了？哈哈，你太天真了，现在项目还跑不起来呢。我们要继续进行配置。

## react 基础配置

### 配置支持 @ 文件映射 src 目录

在 `vue-cli` 脚手架中，会配置 `@` 符号映射到 `src` 目录，来避免我们使用 `../../../` 这样恶心的调用文件方式。但是 `react` 的脚手架默认没有配置支持，所以我们需要自己手动配置一下。

> 上面我们已经使用过了，回头看下我们的路由配置文件。

我们打开项目根目录下的 `/config/webpack.config.dev.js` 文件，找到 `'react-native': 'react-native-web',` 这一行，在下面加入

```json
'@': path.join(__dirname, '..', 'src'),
```
![](https://raw.githubusercontent.com/fengcms/articles/master/image/0a/e02bff048c1159cef070194207365e.jpg)
如上图所示，这样配置一下。同时，我们需要修改 `/config/webpack.config.prod.js` 文件的相同部分，不再赘述。

> webpack.config.dev.js 是用于开发环境的配置文件，而 webpack.config.prod.js 是用于生产环境的配置。因此，开发环境进行了变更，生产环境也要进行同样的变更，否则，在项目最后编译输出的时候，是会出错的。

### 配置项目支持 scss 文件

我们继续编辑 `/config/webpack.config.dev.js` 文件。我们找到 `test: /\.(js|jsx|mjs)$/` 这一行，在其上面加上：

```json
{ test: /\.scss$/, loaders: ['style-loader', 'css-loader', 'sass-loader'],},
```
![](https://raw.githubusercontent.com/fengcms/articles/master/image/8d/101546d9be49a43a5f4c072ede427f.jpg)
然后，再找到 `exclude: [/\.(js|jsx|mjs)$/, /\.html$/, /\.json$` 这一行，将其修改为

```json
exclude: [/\.(js|jsx|mjs)$/, /\.html$/, /\.json$/,/.scss$/],
```
![](https://raw.githubusercontent.com/fengcms/articles/master/image/ca/0b0875bec8b56227cdd223f3ca0f65.jpg)
好，修改好之后，我们要对 `/config/webpack.config.prod.js` 进行同样的修改。

### 安装缺少组件

我们在路由文件中使用了 `react-router-dom` 这个包，我们需要安装一下

```shell
npm i react-router-dom
```

我们使用了 `sass` 所以需要安装 `node-sass` 和 `sass-loader` 这两个包。

```shell
npm i node-sass sass-loader
```

![](https://raw.githubusercontent.com/fengcms/articles/master/image/c6/d1d703b33e01e00ed81fedccf72bfb.jpg)
最后，我们运行 

```shell
npm start
```

我们的项目终于跑起来了。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/be/56ff75f91555cff844e209ae068cc3.jpg)
虽然只是一个简单的页面，但是，我们经过这一系列的配置，下面我们可以愉快的撸代码了。

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。


