title: 让webpack+vue-cil项目不再自动打开浏览器
date: 2017-01-04 09:31:17 +0800
update: 2017-01-04 09:31:17 +0800
author: fungleo
tags:
    -webpack
    -vue-cil
---

#让webpack+vue-cil项目不再自动打开浏览器

当我们用`vue-cil`建立一个完整的`webpack+vue`的项目之后，它的设置选项还是蛮多的。比如，当我们输入`npm run dev`开始跑起项目之后，就会自动的打开浏览器，并把页面打开。

按理说，这是一个很方便的配置。问题是，我们在调试的过程中，可能需要不断的重启项目。每一次重启，就会开一个网页，让我非常头疼。

查看了一下，找到了解决方法，分享给各位看官。

打开 `/build/dev-server.js` 文件 末尾，代码如下：

```javascript
// when env is testing, don't need open it
if (process.env.NODE_ENV !== 'testing') {
  opn(uri)
}
```

只需要把这段代码注释，即可。