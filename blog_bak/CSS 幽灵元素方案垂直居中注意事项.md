title: CSS 幽灵元素方案垂直居中注意事项
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -css
    -垂直居中
---

之前，我们转载了一篇博文[CSS居中完全指南](http://blog.csdn.net/fungleo/article/details/50786305)，在这篇文章中，提到了一种使用幽灵元素方式的解决垂直居中的问题的方案。

这种方案非常适合解决一些图片布局，因此我也在项目中经常使用这种解决方案。

首先，我们温习一下原文的说法：

>如果上述两种方式均不能使用，你可以使用“幽灵元素”技术，这种方法采用伪元素 ::before 撑开高度 ，文字垂直居中。

```css
.parent {
  position: relative;
}
.parent::before {
  content: " ";
  display: inline-block;
  height: 100%;
  width: 1%;
  vertical-align: middle;
}
.child {
  display: inline-block;
  vertical-align: middle;
}
```

但是今天遇到一个问题，原来客户在CMS使用，模板代码给格式化了，也就是有缩进，导致图片始终距离左侧有3px 到 4px的间隙。

在行内元素中，多个空格或者换行或者TAB缩进，会当成一个空格处理。一个空格，也是有宽度的，这是导致这个问题的原因。

因此，将这段代码调整为如下，即可解决这个问题

```css
.parent {
  position: relative;
}
.parent::after {
  content: "";
  display: inline-block;
  height: 100%;
  width: 0;
  vertical-align: middle;
}
.child {
  display: inline-block;
  vertical-align: middle;
}
```

在我们的 `.child` 后面插入 `::after` 即可避免这个问题。

吃一堑长一智，古人诚不欺我也~

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。
