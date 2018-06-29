title: Vue 脱坑记 - 查漏补缺(汇总下群里高频询问的xxx及给出不靠谱的解决方案)
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -vue
---

##前言
>发现群里有些问题的提问重复率太高了,每次都去回答,回答的贼烦.
这里做一个大体的汇总,废话不多说,直接开始
给出方案,不是手把手..若是连问题和解决都看不懂的..应该去补充下基础知识

##问题汇总

###Q:安装超时(install timeout)

方案有这么些:

- cnpm : 国内对npm的镜像版本
```
/*
cnpm website: https://npm.taobao.org/
*/

npm install -g cnpm --registry=https://registry.npm.taobao.org


// cnpm 的大多命令跟 npm 的是一致的,比如安装,卸载这些
```
yarn 和 npm 改源大法

使用 nrm 模块 : www.npmjs.com/package/nrm
npm config : npm config set registry https://registry.npm.taobao.org
yarn config : yarn config set registry https://registry.npm.taobao.org

更多内容请访问 https://juejin.im/post/59fa9257f265da43062a1b0e

这篇文章汇总了大量新手在群里的提问，回答非常全面，建议新手阅读。涉及版权问题，没有全文转载。