title: webpack+vue-cil 配置接口地址代理以及将项目打包到子目录的方法
date: 2017-05-23 16:43:12 +0800
update: 2017-05-23 16:43:12 +0800
author: fungleo
tags:
    -webpack
    -vue-cil
    -webpack代理
    -vue打包子目录
---


# webpack+vue-cil 配置接口地址代理以及将项目打包到子目录的方法

##前言

很久没有更新关于`webpack+vue`的内容了。前面承诺过大家告诉大家如何打包到子目录的。由于太忙，也忘记了。今天补充两个知识点给大家。

##将接口配置到本地代理的方法

一般来说，我们会在正式环境中讲接口配置到和项目路径是一个域名下的。因此，我们没必要在调用接口的时候使用绝对地址，使用相对地址即可。但是开发环境的话，我们本地跑的是`localhost:8080`地址，当然要使用包含域名的接口地址了。

文字描述有点晕，举个栗子

**正式环境**

接口地址|前端页面地址
---|---
/api/**|/

**开发环境**

接口地址|前端页面地址
---|---
http://www.xxx.com/api/**|http://localhost:8080

如上，在请求上，我们的开发环境不仅仅面临要把接口的全路径写全的问题，还包括跨域问题等等。

所以，解决这个问题的方法就出来了，将接口地址通过代理的方式映射到本地，让我们的本地开发也可以使用相对根目录的方式请求接口。

`webpack`本身自带了代理功能，我们的`vue-cil`更是集成了进来，只要经过简单的配置即可。

我们打开下面路径的文件

`config/index.js`

在其中的`dev`对象里面找到：
```js
proxyTable: {},
```
这里就是配置代理的地方，我们进行如下设置：

```js
proxyTable: {
  '/api/**': {
    target: 'http://www.xxx.com', // 你接口的域名
    secure: false,		// 如果是https接口，需要配置这个参数
    changeOrigin: true,		// 如果接口跨域，需要进行这个参数配置
  }
},
```
更多配置参数请参阅：https://github.com/chimurai/http-proxy-middleware#options

webpack代理设置请参阅：https://webpack.js.org/configuration/dev-server/#devserver-proxy

> 如果你看不懂我在说什么，那么是你没有遇到这个问题。给自己的记忆打个点，当遇到这个问题的时候，记得回来看这篇文章

## 将项目打包到子目录

默认配置下，我们的项目只能在根目录下运行，如果真这样的话，那还是非常麻烦的，可能我们需要在一个域名下面跑多个项目。

通过下面的简单设置，可以将我们打包的文件放在任意地方跑起来。

同样是`config/index.js`这个配置文件，我们找到`build`节点，找到下面的代码：

```js
assetsPublicPath: '/',
```
上面的代码是表示，我们打包出来的路径是相对根目录的。这里，你可能想到了，那就在这里写具体的子目录路径就好了。也不是不行，不过我们一般这么配置
```js
assetsPublicPath: './',
```
加一个英文句号即可。这表示在当前目录下。这样，你随便放在哪里都可以跑起来了。
> 上面的说法是错误的。经过测试，在有资源的情况下，这样处理会出问题，正确的做法是，你放在什么目录就应该在这里填写什么目录，才能够正确的编译css中的图片地址。
> 例如，你想放在`/h5/`下面，就应该这样填写`assetsPublicPath: '/h5/',`
> 另外，在windows下面实测编译会出错，会提示没有权限创建文件夹。但是在mac和linux上没有问题。
> 这我就不得而知了。


##我的其他webpack+vue文章索引
[《Vue2+VueRouter2+webpack 构建项目实战（一）准备工作》](http://blog.csdn.net/fungleo/article/details/53171052)

[《Vue2+VueRouter2+webpack 构建项目实战（二）目录以及文件结构》](http://blog.csdn.net/fungleo/article/details/53171614)

[《Vue2+VueRouter2+webpack 构建项目实战（三）配置路由，整俩页面先》](http://blog.csdn.net/FungLeo/article/details/53199436)

[《Vue2+VueRouter2+webpack 构建项目实战（四）接通api，先渲染个列表》](http://blog.csdn.net/fungleo/article/details/53202276)

[《Vue2+VueRouter2+webpack 构建项目实战（五）配置子路由》](http://blog.csdn.net/fungleo/article/details/53213167)

[《Vue2+VueRouter2+webpack 构建项目实战（六）修复代码并通过验证，另发布代码》](http://blog.csdn.net/fungleo/article/details/54602753)

[《Vue2+VueRouter2+webpack+Axios 构建项目实战（七）重构API文件为使用axios》](http://blog.csdn.net/fungleo/article/details/71557042)

本文由FungLeo原创，允许转载，但转载必须附带首发链接。如果你不带链接，我将采取包括但不限于深深的鄙视你等手段！


