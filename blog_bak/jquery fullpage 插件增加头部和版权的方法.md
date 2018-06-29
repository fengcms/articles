title: jquery fullpage 插件增加头部和版权的方法
date: 2017-02-21 18:26:36 +0800
update: 2017-02-21 18:26:36 +0800
author: fungleo
tags:
    -jquery
    -fullpage
---

# jquery fullpage 插件增加头部和版权的方法

## 前言

一个页面，我们通过 `jquery-fullpage` 插件来制作，整个是全屏滚动的。但是，我们希望在最后一页增加一个版权，大概只有 `100px` 高，而不需要一个全屏来放版权。怎么做呢？搜索了一下，说了各种方法。什么修改源码啦之类的，或者自己写代码判断啦。晕死。其实，官方给出了解决方案。

下面，我们简单的说下是怎么实现的

## 实现其实只需要 html 部分

```html
<div class="fullpage">
  <div class="section fp-auto-height">这里写头部</div>
  <div class="section">page1</div>
  <div class="section">page2</div>
  <div class="section">page3</div>
  <div class="section">page4</div>
  <div class="section fp-auto-height">这里写版权</div>
</div>
```
如上，`js`代码就不说了，只要你能跑起来，就没有问题。这里只需要给头部和底部增加一个`fp-auto-height` 的 `class` 即可。

**没有生效吗？**

嘿嘿，那是因为你只引用了`js`，而没有引用`css`造成的，只要引用下面的`css`即可。

https://github.com/alvarotrigo/fullPage.js/blob/master/dist/jquery.fullpage.css

其实关键代码只是下面的而已

```css
.fp-auto-height.fp-section,
.fp-auto-height .fp-slide,
.fp-auto-height .fp-tableCell{
    height: auto !important;
}

.fp-responsive .fp-auto-height-responsive.fp-section,
.fp-responsive .fp-auto-height-responsive .fp-slide,
.fp-responsive .fp-auto-height-responsive .fp-tableCell {
    height: auto !important;
}
```

## 小结

你的问题可能早就被人遇到了，一定有人给你解决过的。善于利用搜索引擎即可。

[fullpage github](https://github.com/alvarotrigo/fullPage.js)

版权申明：本文由FungLeo原创，允许转载，但转载必须附注首发链接。谢谢。

