title: Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（十一）阶段性小结
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -vue
    -nodejs
    -archlinux
    -webpack
    -mac
---

# Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（十一）阶段性小结

## 前情回顾

去年写的那一套东西，虽然我也写得非常的认真，但是其中还是有点绕了。当时水平不行。现在我重新整理出来的博文如下，希望对各位有所帮助。

1. [Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（一）基础知识概述](http://blog.csdn.net/fungleo/article/details/77575077)
2. [Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（二）安装 nodejs 环境以及 vue-cli 构建初始项目](http://blog.csdn.net/fungleo/article/details/77584701)
3. [Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（三）认识项目所有文件](http://blog.csdn.net/fungleo/article/details/77585205)
4. [Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（四）调整 App.vue 和 router 路由](http://blog.csdn.net/fungleo/article/details/77600798)
5. [Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（五）配置 Axios api 接口调用文件](http://blog.csdn.net/fungleo/article/details/77601270)
6. [Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（六）将接口用 webpack 代理到本地](http://blog.csdn.net/fungleo/article/details/77601761)
7. [Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（七）初识 *.vue 文件](http://blog.csdn.net/fungleo/article/details/77602914)
8. [Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（八）渲染一个列表出来先](http://blog.csdn.net/fungleo/article/details/77603537)
9. [Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（九）再把内容页面渲染出来](http://blog.csdn.net/fungleo/article/details/77604490)
10. [Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（十）打包项目并发布到子目录](http://blog.csdn.net/fungleo/article/details/77606216)
11. [Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（十一）阶段性小结](http://blog.csdn.net/fungleo/article/details/77606321)
12. [Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（十二）打包项目图片等资源的处理](http://blog.csdn.net/fungleo/article/details/77799057)

## GITHUB 代码开源地址

https://github.com/fengcms/vue-demo-cnodejs

## vue 学习小结

本系列博文，在接口对接方面，只涉及到了 `get` 方法。事实上，我们的 `spa` 页面很大程度上是来开发管理后台的项目的。

在管理后台的开发中，我们将大量的涉及到 `post` `put` 等接口调用。我后期有时间再整理一个小型的管理后台的开发博文系列。

我希望你通过阅读和学习我的博文，能够真正的入门 `vue` 的开发。当然，我还希望你能够收藏我的这个系列的博文。有很多的东西，你收藏起来，回头要用的时候，打开看一下就知道如何去用了。

当然，当你学会了，并且顺利的做了一些比较复杂的应用的时候，也不要骄傲。就好像很多学会了一点 `jquery` 就认为自己会 `javascript` 的人一样。很多人学会了一点 `vue` 就误认为自己会写 `js` 了。

这固然是因为 `vue` 相对来说比较简单。但是，如果你的基础不扎实，我预计你也很难有大的提升。

因此，我建议你一定要花时间来学习犀牛书。深入的学习 `js` 再回头来看我们的 `vue` ，就更加简单了，有很多的地方，也不是知其然不知其所以然了。

还有就是，不要排斥命令行，不要固守 `windows` 操作系统。

我公司的前端团队基本是我一手带出来了，所有人从进公司第一天起，就强制使用 `archlinux` 操作系统，强制他们学习各种命令行。经过痛苦的一周的转换期，目前，已经没有人怀念 `windows` 操作系统了。一个个命令行用的飞起，让我们还在用 `windows` 的后端的同学非常艳羡，也让他们在以后的升职加薪得到了助力。

最重要的是，在 `windows` 下面各种报错，各种问题。至今，我都不知道在 `windows` 下面如何解决编译到子目录失败的问题如何解决。

所以，有条件，但又喜欢漂亮桌面的，可以和我一样，搞一个 `macbook pro` 或者 黑苹果 电脑。没条件的，可以装一个 `ubuntu` 操作系统。

国产的深度 linux 操作系统也是非常不错的选择。其能够兼容一些 `windows` 程序，并且桌面非常漂亮。我认为比较适合 `windows` 刚转 `linux` 的同学。

但是越往后，我越不推荐。虽然先期我还是支持的。因为就我的感觉来说，命令行不是特别好用。当然，也可能是因为我没有深入的使用和了解造成的。

总而言之，抛弃 `windows` ，拥抱命令行，是每一个开发人员最终的宿命。

最后，再接再厉。希望你能取得更大的进步。也对我的博文提出一些建议和意见。

再会！

> 如果文章由于我学识浅薄，导致您发现有严重谬误的地方，请一定在评论中指出，我会在第一时间修正我的博文，以避免误人子弟。

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。

##后续补充

我收回上面对 `DEEPIN` 的观点言论。我现在认为，深度 `linux` 系统特别适合 `windows` 用户来使用，无论是界面设计，还是快捷操作，还是其他方面，都非常适合国情。

并且，深度很好的贯彻了一个思想，就是，系统应该不需要让用户思考，不需要让用户去做更多的工作，开箱即用。管他底层是什么呢。

我强烈建议新手使用 `deepin linux` 真的。

有 MAC 就用 MAC 哈~

