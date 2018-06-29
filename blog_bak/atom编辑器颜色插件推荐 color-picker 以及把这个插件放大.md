title: atom编辑器颜色插件推荐 color-picker 以及把这个插件放大
date: 2016-11-09 12:42:07 +0800
update: 2016-11-09 12:42:07 +0800
author: fungleo
tags:
    -atom
    -color-pick
---

在mac下面用快捷键切换到photoshop下面老是有点卡顿，另外，在ps开启调色板之后，还容易切换不过去。这有点让我烦恼，关键的是，为了调个颜色还要开个ps，是在浪费。因此，想找个软件。

很容易就找到了 `color-picker` 这款插件，非常好用。快捷键为 `cmd+shift+c` 实时调出一个调色盘来调色。而且支持半透明模式。

##安装color-picker

打开终端
```shell
#进入插件目录
cd ~/.atom/packages/
#下载插件
git clone https://github.com/thomaslindstrom/color-picker
#进入color-picker目录
cd color-picker
#安装
npm install
```

##把插件放大
默认这个插件比较小，调色盘不是很好用。因此，我想放大一些，这样调色的时候更加好用。

打开终端
```shell
#进入插件目录
cd ~/.atom/packages/color-picker
#vim 编辑样式
vim styles/extensions/Saturation.less
```
把原来的`@size-saturation: 200px; `改成` @size-saturation: 350px;` 即可。

需要重启atom生效。

截图如下：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/45/82c6f9bbba4fc45d2bef58d9a1a7d7.png)
文章由 Fungleo 原创转载时不得删除首发地址，首发地址：http://blog.csdn.net/fungleo/article/details/53098549 