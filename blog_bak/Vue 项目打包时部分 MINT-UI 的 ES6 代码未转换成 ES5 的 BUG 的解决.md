title: Vue 项目打包时部分 MINT-UI 的 ES6 代码未转换成 ES5 的 BUG 的解决
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -Vue
    -es6es5
    -mint-ui
    -编译出错
---

# Vue 项目打包时部分 MINT-UI 的 ES6 代码未转换成 ES5 的 BUG 的解决

最近在合作开发一个项目的时候遇到一个让人奔溃的问题。在开发阶段没有任何问题，测试都已经通过了。但是在打包的时候发现安卓低版本以及 IOS9 以及以下的版本无法正常访问我们开发的项目。

经过排查发现，在打包的 vendor.js 文件中，包含一部分 es6 的代码。正是由于这些 es6 的代码在低版本的浏览器上不支持，导致项目无法运行。

仔细分析代码，发现这部分代码是 `mint-ui` 的。于是我们经过各种猜测和处理，始终没有解决问题。

最后，在项目中发现了这样的代码：

```js
import MtPopup from '../../../node_modules/mint-ui/packages/popup/src/popup.vue'
```

我很奇怪怎么会有这样的写法，因为按照官方文档给出的引用方法是

```js
import { Popup } from 'mint-ui'
```

于是，我们将代码修改为

```js
import MtPopup from 'mint-ui'
```

然后我们编译代码，发现问题已经顺利解决了。

但是我们怎么会这么引用代码呢？经过我们的推敲分析，可能是IDE自动关联上导致的。

嗯。我用 VIM 所以我的代码没问题。

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。


