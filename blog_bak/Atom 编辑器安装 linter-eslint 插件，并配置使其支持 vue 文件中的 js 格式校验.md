title: Atom 编辑器安装 linter-eslint 插件，并配置使其支持 vue 文件中的 js 格式校验
date: 2017-01-17 12:14:20 +0800
update: 2017-01-17 12:14:20 +0800
author: fungleo
tags:
    -atom
    -linter
    -eslint
    -vue
    -格式校验
---

# Atom 编辑器安装 linter-eslint 插件，并配置使其支持 vue 文件中的 js 格式校验

## 前言
之前我的博文写了一系列的vue教程。但是关闭了其中的代码校验，这一直让我很不爽。因为我希望自己写的代码是完美的。因此，后来我安装上了校验插件，并且使自己的代码通过了格式校验。

本文就是教大家如何安装插件让ATOM支持格式校验。毕竟，每次都到终端里面去看代码的错误是及其恶心的。

> 通过一段时间的适应，目前我写代码的规范性也大大提高了。建议大家先痛苦一下，适应这个破玩意儿吧。我个人适应初期还是蛮痛苦的，因为我是tab缩进派，换成4个空格已经很讨厌了，换成俩空格，更加让我的眼睛奔溃。不过，既然这是潮流，那就适应它吧。

## 安装插件
> 本人不知道 windows 下面会出现什么情况。大概可以参考我的文章，但是具体，请实践。我的代码在 arch linux 和 mac 下面是通过的。评论中有关 windows 的任何问题，不负责回答。谢谢理解。
以下均为终端命令，请逐条输入即可：

```#
# 进入atom插件文件夹
cd ~/.atom/packages/
# git clone 插件源文件
git clone https://github.com/AtomLinter/linter-eslint
# 进入linter-eslint插件文件夹
cd linter-eslint
# 安装插件
npm install
```

然后重启 atom 就可以了。

## 配置插件使其支持 VUE 文件中的 js

安装好插件后，就能够提醒我们的JS文件中的格式不正确的地方了。但是， `.vue`文件中的 JS 代码还是不能校验，因此，我们来设置一下。

首先，打开 atom 的设置面板 切换到 `packages` 选项卡，找到 `linter-eslint` 插件，点击 **设置** (我的安装了汉化插件，如果没有汉化，则是英文的设置。类似 `setting` 之类的)

进入面板后，勾选 `Lint HTML Files` 选项后，即可。

如下图所示：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/25/f4835d89376f354e8be3b37b2e6636.jpg)
然后，就可以在 `.vue`文件中校验代码格式了。

如下图所示：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/e8/aa57f3430c5665f19a60f7a84414a2.jpg)
## 附注 为什么 main.js 死活过不了验证？

当你把项目中的大多数代码全部调整合适了之后，你会发现，你的 `main.js` 文件死活通过不了验证。因为这里必须不满足验证。因此，需要下面的代码跳过验证

```js
/* eslint-disable no-new */
new Vue({ // eslint-disable-line no-new
  router,
  el: '#app',
  render: (h) => h(App)
})

```
就是上面的 `/* eslint-disable no-new */` 来强制跳过验证。我一开始也没搞明白，后来才知道，跳过验证是通过这样的注释的方法。其他的请自行查找资料了。

版权申明：本文由 FungLeo 原创，允许转载，但请务必保留首发链接。谢谢。


