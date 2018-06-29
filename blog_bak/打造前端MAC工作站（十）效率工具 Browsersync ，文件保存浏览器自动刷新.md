title: 打造前端MAC工作站（十）效率工具 Browsersync ，文件保存浏览器自动刷新
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -Browsersyn
    -浏览器自动刷新
    -前端效率工具
---

# 打造前端MAC工作站（十）效率工具 Browsersync ，文件保存浏览器自动刷新

## 前言

当我们在开发`vue+webpack`的项目时候，发现有一点非常好，就是当我们的文件保存的时候，就立即自动刷新了。这样可以大幅提高我们开发的效率。

问题是，我们并不会所有的项目都是基于`webpack`构架的呀，那么我们还能不能再我就想写一个简单的网页文件的时候，也能有这个功能呢？又或者在我们开发基于`apache`服务端的页面的时候，也能自动刷新呢？

还真有这样的工具，名字就是 `Browsersync`

![](https://raw.githubusercontent.com/fengcms/articles/master/image/38/0faf39a9be2264526e3a295219c69a.gif)
## Browsersync 的安装

安装非常简单，这是一款基于`node.js`的工具。直接执行下面的命令即可

```#
npm install -g browser-sync
```

前提是你已经安装了`node.js`了哦！

## Browsersync 的使用

### 静态页面的使用

```#
// 跳转到你的网页文件目录
cd ~/youSiteName
// 执行下面的命令
browser-sync start --server --files "css/*.css"
```
如上命令，就可以监控你的网页文件下面的css文件夹中的任何css文件。当css文件发生修改并保存的时候，浏览器就会自动刷新。

当然，你可能还要监控其他文件，比如`html`文件

```#
browser-sync start --server --files "css/*.css, *.html"
```
就可以监控`css`目录下面的样式文件和根目录下面的`html`文件了。

你或者有其他要求，就是你的`html`和`css`文件比较松散，那么下面的命令应该合适于你

```#
browser-sync start --server --files "**/*.css, **/*.html"
```
上面的命令就可以监控你的网页文件夹下面的所有的样式文件和网页文件了。如果还有其他的类型的文件，可以直接修改参数哦！

### 动态网站的使用

如果是动态网站，比如你本地用`xampp`跑了一个`php+mysql`的 `fengcms`或者`dedecms`的程序，那么应该怎么使用呢？也是很简单的。

那就是用`browser-sync`做一个反向代理即可。

命令如下：
```#
browser-sync start --proxy "主机名" --files "css/*.css"
```

主机名就是你本地服务器中动态网页绑定的网址，比如`www.cms.com`。然后你要监控所有的样式文件和网页文件，则这条命令就是

```#
browser-sync start --proxy "www.cms.com" --files "**/*.css, **/*.html"
```

## browsersync 附加资料

视频使用教程 http://www.browsersync.cn/example/video/browsersync1.mp4

中文官方网站 http://www.browsersync.cn/

英文官方网站 https://browsersync.io/


本文由FungLeo原创，内容参考`browsersync`中文官方网站，允许转载，但转载必须附注首发链接。谢谢。

