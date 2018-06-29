title: Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（六）将接口用 webpack 代理到本地
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -api
    -webpack
    -接口代理
    -proxy
    -vue
---

# Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（六）将接口用 webpack 代理到本地

## 前情回顾

在上一篇博文《[Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（五）配置 Axios api 接口调用文件](http://blog.csdn.net/fungleo/article/details/77601270)》中，我们已经非常顺利的调用到了 `cnodejs.org` 的接口了。但是，我们可以注意到我们的 `src/api/index.js` 的第一句，就是：

```js
// 配置API接口地址
var root = 'https://cnodejs.org/api/v1'
```
这里，我们将接口地址写死了。

当然，这并不是最重要的事情，而是 `cnodejs.org` 帮我们把接口处理得很好，解决了跨域的问题。而我们的实际项目中，很多接口都是不允许我们这样跨域请求的。

而我们的开发环境下，不可能跑到服务器上直接开发，或者在本地直接搞一个服务器环境，这样就违背了我们前后端分离开发的初衷了。

如何解决这个问题呢？其实非常好办，要知道 **跨域不是接口的限制** 而是浏览器为了保障数据安全做的限制。因此，一种方法可以解决，那就是打开浏览器的限制，让我们可以顺利的进行开发。但是无奈的是，最新的 `chrome` 浏览器好像已经关闭了这个选项，那么我们只能采用另外一种方法了——将接口代理到本地。

## 配置 webpack 将接口代理到本地

好在，`vue-cli` 脚手架工具，已经充分的考虑了这个问题，我们只要进行简单的设置，就可以实现我们的目的。

我们打开 `config/index.js` 文件，找到以下代码：

```js
  dev: {
    env: require('./dev.env'),
    port: 8080,
    autoOpenBrowser: true,
    assetsSubDirectory: 'static',
    assetsPublicPath: '/',
    proxyTable: {},
    cssSourceMap: false
  }
```
其中，`proxyTable: {},` 这一行，就是给我们配置代理的。

根据 `cnodejs.org` 的接口，我们把这里调整为：

```js
proxyTable: {
  '/api/v1/**': {
    target: 'https://cnodejs.org', // 你接口的域名
    secure: false,
    changeOrigin: false,
  }
}
```

OK，我们这样配置好后，就可以将接口代理到本地了。

更多接口参数配置，请参考 https://github.com/chimurai/http-proxy-middleware#options

`webpack` 接口配置文档 https://webpack.js.org/configuration/dev-server/#devserver-proxy

## 重新配置 src/api/index.js 文件

好，上面已经代理成功了，但是我们的 `src/api/index.js` 文件，还是直接调用的人家的地址呢，我们要调整为我们的地址，调整如下：

```js
// 配置API接口地址
var root = '/api/v1'
```

之前我有一篇博文，说过如何配置开发接口地址和生产接口地址，当时是利用了 `webpack` 的不同的配置文件来进行配置的。如果我们采用这种代理模式呢，那么就没有必要那么做了。因为我们的系统放到生产环境的时候，一般是没有这个跨域问题的。这个问题一般仅仅是存在于我们的开发环境下面。

值得注意的事情是，配置完成后，是不会立即生效的，我们需要重启我们的项目。

我们按 `ctrl + c` 停止掉之前的服务，然后重新输入命令 `npm run dev` 重启项目，就可以了。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/1a/050287cc5b43059f457329dede6b22.png)
如上图所示，我们可以清晰的看到，我们跑的服务，先开启了一个代理。

重新跑起来之后，我们看下我们的项目在浏览器中的表现：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/fb/5c9a5b650efb935ee0865bbd677c8a.png)
我们打开浏览器控制台，切换到 `network` 选项卡中，选中我们调用的接口 `topics` 接口，我们可以清晰的看到，我们读取的接口地址是我们的本地代理过来的地址。

状态码为 `304` 代表这个数据没有发生变化，直接读取本地缓存了。关于 `http 状态码` 的部分，请参考 [百度百科 http 状态码](https://baike.baidu.com/item/HTTP%E7%8A%B6%E6%80%81%E7%A0%81)，这里不做过多的说明。

我们再看一下数据是不是正常的过来了。切换到 `Previdw` 选项卡查看：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/77/733b9c6aaa4f5a6ccca43c2c0ceafb.png)
没有问题，数据过来了。

好，到这里，我们已经顺利的将接口代理到本地，并且数据读取出来了。我们开始准备下面的工作吧！

> 如果文章由于我学识浅薄，导致您发现有严重谬误的地方，请一定在评论中指出，我会在第一时间修正我的博文，以避免误人子弟。

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。