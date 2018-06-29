title: 【转载】css sprite css雪碧图生成工具
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -css-sprite
---

#css sprite css雪碧图生成工具
##什么是css sprite

CSS sprite在国内很多人叫css精灵，是一种网页图片应用处理方式。它允许你将一个页面涉及到的所有零星图片都包含到一张大图中去，这样一来，当访问该页面时，载入的图片就不会像以前那样一幅一幅地慢慢显示出来了。

##为什么要用这个工具

###1.加快网页加载速度

浏览器接受的同时请求数是10个，如果图片过多会影响整体的视觉效果，而且对于不稳定的网络带宽，加载起来更是噩梦，所以把图片拼接为一张大图，从而加快加载速度，以及加速页面渲染

###2.后期维护简单

该工具可以直接通过选择图片进行图片的拼接，当然你也可以自己挪动里面的图片，自己去布局你的雪碧图，直接生成代码，简单易用

###3.开源

该程序已经在github上开源，地址：https://github.com/iwangx/sprite

###csdn下载地址（不要分）

http://download.csdn.net/detail/wx247919365/8641795

##如何使用

**1.用ps或者dw把需要的图片切下来**
![](https://raw.githubusercontent.com/fengcms/articles/master/image/f2/d98d920a3954325532b7925595d128.png)css sprite css雪碧图生成工具

**2.打开CssSprite.exe**

打开CssSprite.exe文件，下载地址我会放在下面一点
![](https://raw.githubusercontent.com/fengcms/articles/master/image/73/3c9cc00a1a0f72e23603eed80ced33.png)css sprite css雪碧图生成工具

**3.打开图片**

点击左上角按钮打开图片
![](https://raw.githubusercontent.com/fengcms/articles/master/image/21/1d79bd0dca58984284ce81c99094d0.png)css sprite css雪碧图生成工具

选择多张图片，点击打开按钮

**4.排布图片**

可以选择上面的最上面按钮今天横竖的默认排布，也可以鼠标选中图片拖动位置，拖动完成后程序会根据内部图片的位置生成面积最小的雪碧图，当然也会改变相应的图片位置

**5.代码生成**

在程序中可以生成sass代码，以及css代码，看自己需要嘛，自己选择，选中“是否是手机端”的时候会把所有的尺寸除以2，因为手机端往往会设计图比较大，所以要缩放，建议生成图片后再复制生成的代码

**6.保存雪碧图**

点击“生成雪碧图”按钮，程序会默认选中你在第3步的时候打开图片的地址，然后点击确定后生成雪碧图。

原文地址：http://developer.51cto.com/art/201504/474506.htm