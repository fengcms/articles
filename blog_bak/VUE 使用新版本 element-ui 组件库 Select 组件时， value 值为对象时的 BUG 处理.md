title: VUE 使用新版本 element-ui 组件库 Select 组件时， value 值为对象时的 BUG 处理
date: 2017-09-21 16:25:48 +0800
update: 2017-09-21 16:25:48 +0800
author: fungleo
tags:
    -element-ui
    -select
    -vue
---

# VUE 使用新版本 element-ui 组件库 Select 组件时， value 值为对象时的 BUG 处理

在公司项目中，我们使用了 `element-ui` 组件库，非常的好用。近日我们的项目升级，而 `element-ui` 组件库也升级了。而升级的内容中有我们希望使用的新特性，于是我们愉快的升级了。

但是在升级之后，我们发现在某一块功能中使用的 `Select` 组件出现了问题。具体表现为选不上值，随便选一个值之后，从视觉角度讲，貌似把所有的值全部选上了，而事实是，啥也没选上。

我们退回到 `element-ui@1.3.7` 版本时，问题消失。因此，我们初步判断，这是 `element-ui` 的 `BUG`。

为了解决这个问题，我们自己写了一个下拉组件。但是我总感觉 `element-ui` 应该不会有这么明显的问题。今天仔细看了一下官方更新文档，焕然大悟。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/14/08ed2ae9a0d0ece26f625bc5eb68a2.png)
迅速查看文档

![](https://raw.githubusercontent.com/fengcms/articles/master/image/5f/ef4ad6455dd9612253c37107726951.png)
问题找到之后，我们没在项目中使用自己写的组件，而是还原成使用 `element-ui` 的组件了。

PS: 这篇文章的次要重点是提醒那些遇到同样问题的朋友。不过可气的是，当我一眼看到官方文档的说明之后，开发人员还埋怨人家 `eleme` 更新文档没有说清楚。被我狠狠的批评了一顿，**看文档，很重要啊！**

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。


