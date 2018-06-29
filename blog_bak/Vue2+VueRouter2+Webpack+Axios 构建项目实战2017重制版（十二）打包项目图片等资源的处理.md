title: Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（十二）打包项目图片等资源的处理
date: 2017-09-02 10:03:57 +0800
update: 2017-09-02 10:03:57 +0800
author: fungleo
tags:
    -webpack
    -vue
    -img
    -axios
---

# Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（十二）打包项目图片等资源的处理

## 前情回顾

在《[Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（十）打包项目并发布到子目录](http://blog.csdn.net/fungleo/article/details/77606216)》章节中，我们讲解了项目打包，默认，是打包在根目录下面的。当然，我们可以通过设置，打包到任意子目录中去。

但是，我们之前的项目是没有引入资源的。比如，引入图片资源，js资源，或者字体图标之类的。那么各位可能在这个中间又会踩坑，所以，我再写一篇博客，专门来说说这个问题。

## 在 vue 文件中，引用图片

例如，我们将一张图片放到资源目录 `/static/image/lyf.jpg` 我们在 `vue` 文件中用下面的代码来使用这张图片。

```html
<img src="static/image/lyf.jpg" alt="刘亦菲">
```

注意，最前面不要加 `/` 如果是这样操作的话，会变成相对根目录调用图片。如果你的项目要打包到子目录的话，这样做就会出现问题。

## 在 css 文件中，引用图片的处理

还是上面那张图片，我们需要在 `css` 中来引用，如何来写呢？

```css
.love {
  background-image: url('../static/image/lyf.jpg');
}
```
好，这里为什么要加上 `../` 呢？

如果是最终打包到根目录的话，可以使用 `/` 这种路径。这个是完全可以理解的。

但，如果是打包到子目录，我们必须看下生成的最终路径：

```#
├── index.html
└── static
    ├── css
    │   └── app.a7a745952a8ca7f8c9413d53b431b8c8.css
    ├── image
    │   └── lyf.jpg
    ├── img
    │   └── lyf.9125a01.jpg
    └── js
        ├── app.39ccc604caeb34166b49.js
        ├── manifest.b1ad113c36e077a9b54d.js
        └── vendor.0b8d67613e49db91b787.js
```

如上，我们可以看到这个 `css` 相对 `图片` 的路径的地址。

你要疑问了，这样的相对路径，我们可以使用 `../image/lyf.jpg` 来进行调用呀。嗯，看上去可以，但是，如果是这样的话，在开发模式中又会出错了。

所以，还是要用 `'../static/image/lyf.jpg'` 这样的路径方式来调用图片。

> 字体图标，js 文件等，都是这样的路数。不在赘述。

好，大概就是这样，我已经在 `github` 新增了这部分演示内容，大家可以前往： https://github.com/fengcms/vue-demo-cnodejs 查看


> 如果文章由于我学识浅薄，导致您发现有严重谬误的地方，请一定在评论中指出，我会在第一时间修正我的博文，以避免误人子弟。

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。

