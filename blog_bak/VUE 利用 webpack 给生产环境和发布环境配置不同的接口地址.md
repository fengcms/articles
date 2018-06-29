title: VUE 利用 webpack 给生产环境和发布环境配置不同的接口地址
date: 2017-01-16 14:47:07 +0800
update: 2017-01-16 14:47:07 +0800
author: fungleo
tags:
    -Vue2
    -webpack
---

# VUE 利用 webpack 给生产环境和发布环境配置不同的接口地址
## 前言
我们在开发项目的时候，往往会在同一个局域网进行开发，前后端分离同时进行开发。我们前端调用后端给的接口也是在局域网内部的。但是，当项目推到线上的时候，我们会从真实服务器上获取接口，因此，我们可能在测试接口和真实接口之间频繁切换，让人十分恶心。

因此，我们有必要想办法解决这个问题。

> 本文是 [Vue2+VueRouter2+webpack 构建项目实战
](http://blog.csdn.net/fungleo/article/details/53171052) 的后续文章。理解本文内容，需要VUE相关技术基础。

## 第一步，分别设置不同的接口地址

首先，我们分别找到下面的文件：
```
/config/dev.env.js
/config/prod.env.js
```
其实，这两个文件就是针对生产环境和发布环境设置不同参数的文件。我们打开`dev.en.js`文件。代码如下：

```js
var merge = require('webpack-merge')
var prodEnv = require('./prod.env')

module.exports = merge(prodEnv, {
  NODE_ENV: '"development"'
})
```
好，我们在`NODE_ENV`下面增加一项，代码如下：

```js
var merge = require('webpack-merge')
var prodEnv = require('./prod.env')

module.exports = merge(prodEnv, {
  NODE_ENV: '"development"',
  API_ROOT: '"//192.168.1.8/api"'
})
```
然后，我们编辑`prod.env.js`文件，
```js
module.exports = {
  NODE_ENV: '"production"',
  API_ROOT: '"//www.baidu.com/api"'
}
```
好。我们分别设定的路径已经有了。下面就是如何调用的问题了。

## 第二部，在代码中调用设置好的参数

以我们之前的演示代码为例。你自己的项目请根据你自己的情况调整。以下文件和代码仅供参考。

我们打开`src/config/api.js`文件，将原来开头的代码

```js
// 配置API接口地址
var root = 'https://cnodejs.org/api/v1'
```
修改为
```js
// 配置API接口地址
var root = process.env.API_ROOT
```
然后就完成了我们的配置工作。最后，重启项目，就能使新配置的接口地址生效了。

在经过这样的配置之后，我们在运行 

```
npm run dev
```
的时候，跑的就是测试接口。而我们运行

```
npm run build
```
打包项目的时候，打包的是服务器正式接口，我们就不用调来调去得了。

祝开心！

本文由 FungLeo 原创，允许转载，但必须保留首发链接。

##2017年06月19日更新

上面的方法是没有问题的。但是需要重新运行 `npm run dev` 重新跑项目才能成功。

另外，为了解决跨域问题以及其他，我现在不推荐采用这种方式调用接口，而是采用webpack自带的代理功能来实现接口的调用。具体方法参见《[webpack+vue-cil 配置接口地址代理以及将项目打包到子目录的方法](http://blog.csdn.net/fungleo/article/details/72650409)》