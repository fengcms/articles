title: React + webpack 开发单页面应用简明中文文档教程（三）目录说明以及调整项目构架文件
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -react
    -reactjs
    -react文档
    -react 入门教程
    -react中文文档
---

# React + webpack 开发单页面应用简明中文文档教程（三）目录说明以及调整项目构架文件


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

在上一篇博文中，我们已经运行起来了我们的项目。但是，这只是一个初始项目而已，基本上属于不可用的状态，因此，我们要继续工作，展开我们的开发工作。

这篇博文，我们来调整项目构架，以及配置文件，让项目可以更好的开发。

## 自定义配置模式

在默认情况下，项目的各种配置都是默认的，且不可修改，因此，我们需要将项目变成自定义配置模式。

```shell
npm run eject
```

运行这条命令之后，所有的配置文件以及相关依赖，会复制到你的项目中。

> 这是一条不可恢复的命令，因为一旦执行，就再也回不去了。不过没关系，大不了重头再来，哈哈。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/db/0881373a8e0a9c896b71442de6cfcd.jpg)
![](https://raw.githubusercontent.com/fengcms/articles/master/image/69/7c6964e0966c93ea385297e11ef914.jpg)
很快，命令执行成功了，我们的项目中，多了一些文件

### 根目录说明

```shell
├── README.md           # 说明文档，该文档非常丰富，建议由时间阅读
├── config              # 配置文件夹
├── node_modules        # node 依赖文件夹，基本不用管
├── package-lock.json   # 包锁定文件，不用管。
├── package.json        # 配置文件，有些内容在此配置
├── public              # 静态资源目录、入口文件目录
├── scripts             # npm 脚本文件夹，不用管
└── src                 # 开发目录
```

如上所示，这就是我们的项目目录结构了。

### src 开发目录说明

开发目录默认文件如下

```shell
├── App.css                     # 删除
├── App.js                      # 删除
├── App.test.js                 # 删除
├── index.css                   # 删除
├── index.js                    # 入口文件
├── logo.svg                    # 删除
└── registerServiceWorker.js    # 注册服务文件，留着就好
```

执行本命令，删除无用文件

```shell
cd src
rm App.* index.css logo.svg
```

不喜欢 `react` 有一点就是，这都是啥跟啥嘛，基本上啥都没给，我们得从头开始。

创建我们需要的文件夹

```shell
mkdir coms page router style tool
```

说明如下：
```shell
├── coms        # 放各种各样的组件
├── page        # 放我们的项目页面
├── router      # 放我们的路由配置
├── style       # 放我们的样式文件
└── tool        # 放我们用到的自己写的各种工具
```
好，创建好放这里就好了，回头我们再来整理。

### public 静态文件目录说明

```shell
├── favicon.ico         # 标签栏图标文件，找设计做一个替换
├── index.html          # 入口 index.html 文件
└── manifest.json       # 配置参数，不理它 :-)
```

我们在下面创建 `image` 文件夹，用来存放图片。

**修改 `index.html` 文件**

> 我这边以移动端为例，PC端项目请参考后自行调整

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="utf-8">
  <title>React-app</title>
  <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no">
  <style>
    .loader { position: absolute;top: 0;bottom: 0;left: calc(50% - .3rem);width: .6rem; display: inline-block; vertical-align: middle; }
    .loader-3 .dot { width: .1rem; height: .1rem; background: #d42627; border-radius: 50%; position: absolute; top: calc(50% - .05rem); }
    .loader-3 .dot1 { left: 0; animation: dot-jump 0.5s cubic-bezier(0.77, 0.47, 0.64, 0.28) alternate infinite; }
    .loader-3 .dot2 { left: .2rem; animation: dot-jump 0.5s 0.2s cubic-bezier(0.77, 0.47, 0.64, 0.28) alternate infinite; }
    .loader-3 .dot3 { left: .4rem; animation: dot-jump 0.5s 0.4s cubic-bezier(0.77, 0.47, 0.64, 0.28) alternate infinite; }
    @keyframes dot-jump {
      0% {transform: translateY(0);}
      100% {transform: translateY(-.15rem);}
    }
  </style>
  <script src="%PUBLIC_URL%/rem.js"></script>
  <link rel="manifest" href="%PUBLIC_URL%/manifest.json">
</head>
<body>
  <div id="root">
    <div class="loader loader-3">
      <div class="dot dot1"></div>
      <div class="dot dot2"></div>
      <div class="dot dot3"></div>
    </div>
  </div>
</body>
</html>
```

**创建 rem.js 文件**

并在该文件内写入一下内容

```js
function htmlFontSize() {
  var w = Math.max(document.documentElement.clientWidth, window.innerWidth || 0)
  var width = w > 720 ? 720 : w
  var fz = ~~(width * 100000 / 36) / 10000
  var html = document.getElementsByTagName('html')[0]
  html.style.cssText = 'font-size: ' + fz + 'px'
  var realfz = ~~(+window.getComputedStyle(html).fontSize.replace('px', '') * 10000) / 10000
  if (fz !== realfz) {
    html.style.cssText = 'font-size: ' + fz * (fz / realfz) + 'px'
  }
}
htmlFontSize()
window.onresize = function () { htmlFontSize() }
```

这个文件是设置 `html` 的 `fontSize` 的，让我们在移动端的项目中，使用 `rem` 为单位，很好的编写样式。如果是PC端，或者使用其他移动端解决方案，请忽略这段 `js` 文件。或者，根据自己的情况自行调整。

我这里主要是演示，如何在入口文件中引入静态文件中的 `js` 文件。

经过了这些调整，我们的项目应该是跑不起来的。因为我们的 `src` 目录中的文件并没有配置完成。不过为避免博文太长，不便阅读，我们下一篇再讲 `src` 中的文件内容。

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。

