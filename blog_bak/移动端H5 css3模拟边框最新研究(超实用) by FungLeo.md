title: 移动端H5 css3模拟边框最新研究(超实用) by FungLeo
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -css3
    -移动端H5
    -模拟边框
    -box-shadow
    -FungLeo
---

#移动端H5 css3模拟边框最新研究(超实用) by FungLeo

##前言
在之前写的一篇博文[《移动端H5的一些基本知识点总结 第五节 边框的处理》](http://blog.csdn.net/fungleo/article/details/50811739#t5)中,我提到,可以使用 `box-shadow:0 0 0 1px #ddd;` 这样的方式,来模拟边框.当然,博文中的内容并没有错,但是却有一定的局限性.因此,今天在这里,纠正和完善我之前的博文中的缺陷.

>为什么要模拟边框,而不是直接写边框?
>因为边框要计算盒子模型.而我们在移动端可能使用的是自适应布局的方式.这样计算边框很费劲.
>因此,使用模拟边框的方法,就可以不用考虑边框的宽度的问题了,这样更加方便.
>当然,使用 `box-sizing:border-box` 这样的属性也可以将边框不计算在盒子模型里.
>而且这种方法在很多现代CSS框架上都使用着.
>但是我个人不推荐这种做法.因为,这样padding也不计算在盒子模型里面了.
>反正我不喜欢这样的做法.所以我就模拟边框啦!

##前文回顾
如果你不愿意去打开上面的链接,看下上一篇博文中说了什么.这里我就把两种关键的模拟方法给总结出来.如果不理解,可以去看,如果理解,就直接看下面的内容.

**方法一 `outline` 模拟边框**

使用 `outline: 1px solid #ddd; ` 这样的描边线的方式模拟边框

*优点:*
1. 可以和 `border` 一样使用各种线形
2. 可以调整边框到盒子的距离 `outline-offset` 参数

*缺点:*
1. 不能做成贴合圆角元素(这被W3C认为是一个BUG,可能在不远的将来修复)
2. 只能一下子加到四边,不能只加一边.

**方法二 `box-shadow` 模拟边框 **

使用 `box-shadow:0 0 0 1px #ddd;` 外发光模拟边框

*优点:*
1. 可以贴合圆角元素,生成完美的边框
2. 可以重复参数,生成多条边框

*缺点:*
1. 只有实线线性,不能做虚线

更多请看我前面的博文,或者百度相关信息.

## `box-shadow` 可以模拟任意边的边框

我原来以为是做不到的.可见我的CSS功底还是不够强,还要努力学习呀.

上次我闲来无事,用一个DIV写了一套字母数字表 [查看DEMO](http://sandbox.runjs.cn/show/xedal9uy).虽然用到了相关的知识点,但是还是没有往模拟边框的这条思路上靠.

今天仔细一想,原来 `box-shadow` 是可以模拟四条边中的任意一条边的.因此,才写下这篇博文.

语言太多,都不如直接看代码:

###html代码

```html
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Document</title>
</head>
<body>
	<div class="box sibian"></div>
	<div class="box shangbian"></div>
	<div class="box xibian"></div>
	<div class="box zuobian"></div>
	<div class="box youbian"></div>
	<div class="box zuoshangbian"></div>
	<div class="box youshangbian"></div>
	<div class="box zuoxiabian"></div>
	<div class="box youxiabian"></div>
	<div class="box wushangbian"></div>
	<div class="box wuyoubian"></div>
	<div class="box wuxiabian"></div>
	<div class="box wuzuobian"></div>
</body>
</html>
```

###CSS代码

```css
.box {width: 100px;height: 100px;background: #f00; margin: 50px;float: left;}
.sibian {box-shadow: 0 0 0 5px #000;}
.shangbian {box-shadow: 0 -5px #000;}
.xibian {box-shadow: 0 5px #000;}
.zuobian {box-shadow: -5px 0 #000;}
.youbian {box-shadow: 5px 0 #000;}
.zuoshangbian {box-shadow: -5px -5px #000,-5px 0 #000,0 -5px #000;}
.youshangbian {box-shadow: 5px -5px #000,5px 0 #000,0 -5px #000;}
.zuoxiabian {box-shadow: -5px 5px #000,-5px 0 #000,0 5px #000;}
.youxiabian {box-shadow: 5px 5px #000,5px 0 #000,0 5px #000;}
.wushangbian {box-shadow: 5px 5px #000,5px 0 #000,0 5px #000,-5px 5px #000,-5px 0 #000;}
.wuyoubian {box-shadow: -5px -5px #000,-5px 0 #000,0 -5px #000,-5px 5px #000,0 5px #000;}
.wuxiabian {box-shadow: -5px -5px #000,-5px 0 #000,0 -5px #000,5px -5px #000,5px 0 #000;}
.wuzuobian {box-shadow: 5px -5px #000,5px 0 #000,0 -5px #000,5px 5px #000,0 5px #000;}
```

**[查看box-shadow模拟边框DEMO](http://sandbox.runjs.cn/show/0yotpkir)**

##总结

1. 利用了 `box-shadow` 的属性可以无限重复特性,可以通过不断的填充,来满足我们的需求.
2. 并且, `box-shadow` 可以只设置两个值,这样就没有扩展,没有虚化,一比一的移动.
3.  `box-shadow` 的缺点依然存在,就是只能模拟实线,不能模拟虚线
4. 在圆角的运用上,需要更好的计算,反正是利用多重覆盖的特性
5. 做1px的边框,是最简单的.

本文由FungLeo原创,允许转载.但转载必须署名作者,并保留文章首发链接.否则将追究法律责任. 
首发地址: http://blog.csdn.net/FungLeo/article/details/51396410title: 移动端H5 css3模拟边框最新研究(超实用) by FungLeo
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -css3
    -移动端H5
    -模拟边框
    -box-shadow
    -FungLeo
---

#移动端H5 css3模拟边框最新研究(超实用) by FungLeo

##前言
在之前写的一篇博文[《移动端H5的一些基本知识点总结 第五节 边框的处理》](http://blog.csdn.net/fungleo/article/details/50811739#t5)中,我提到,可以使用 `box-shadow:0 0 0 1px #ddd;` 这样的方式,来模拟边框.当然,博文中的内容并没有错,但是却有一定的局限性.因此,今天在这里,纠正和完善我之前的博文中的缺陷.

>为什么要模拟边框,而不是直接写边框?
>因为边框要计算盒子模型.而我们在移动端可能使用的是自适应布局的方式.这样计算边框很费劲.
>因此,使用模拟边框的方法,就可以不用考虑边框的宽度的问题了,这样更加方便.
>当然,使用 `box-sizing:border-box` 这样的属性也可以将边框不计算在盒子模型里.
>而且这种方法在很多现代CSS框架上都使用着.
>但是我个人不推荐这种做法.因为,这样padding也不计算在盒子模型里面了.
>反正我不喜欢这样的做法.所以我就模拟边框啦!

##前文回顾
如果你不愿意去打开上面的链接,看下上一篇博文中说了什么.这里我就把两种关键的模拟方法给总结出来.如果不理解,可以去看,如果理解,就直接看下面的内容.

**方法一 `outline` 模拟边框**

使用 `outline: 1px solid #ddd; ` 这样的描边线的方式模拟边框

*优点:*
1. 可以和 `border` 一样使用各种线形
2. 可以调整边框到盒子的距离 `outline-offset` 参数

*缺点:*
1. 不能做成贴合圆角元素(这被W3C认为是一个BUG,可能在不远的将来修复)
2. 只能一下子加到四边,不能只加一边.

**方法二 `box-shadow` 模拟边框 **

使用 `box-shadow:0 0 0 1px #ddd;` 外发光模拟边框

*优点:*
1. 可以贴合圆角元素,生成完美的边框
2. 可以重复参数,生成多条边框

*缺点:*
1. 只有实线线性,不能做虚线

更多请看我前面的博文,或者百度相关信息.

## `box-shadow` 可以模拟任意边的边框

我原来以为是做不到的.可见我的CSS功底还是不够强,还要努力学习呀.

上次我闲来无事,用一个DIV写了一套字母数字表 [查看DEMO](http://sandbox.runjs.cn/show/xedal9uy).虽然用到了相关的知识点,但是还是没有往模拟边框的这条思路上靠.

今天仔细一想,原来 `box-shadow` 是可以模拟四条边中的任意一条边的.因此,才写下这篇博文.

语言太多,都不如直接看代码:

###html代码

```html
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Document</title>
</head>
<body>
	<div class="box sibian"></div>
	<div class="box shangbian"></div>
	<div class="box xibian"></div>
	<div class="box zuobian"></div>
	<div class="box youbian"></div>
	<div class="box zuoshangbian"></div>
	<div class="box youshangbian"></div>
	<div class="box zuoxiabian"></div>
	<div class="box youxiabian"></div>
	<div class="box wushangbian"></div>
	<div class="box wuyoubian"></div>
	<div class="box wuxiabian"></div>
	<div class="box wuzuobian"></div>
</body>
</html>
```

###CSS代码

```css
.box {width: 100px;height: 100px;background: #f00; margin: 50px;float: left;}
.sibian {box-shadow: 0 0 0 5px #000;}
.shangbian {box-shadow: 0 -5px #000;}
.xibian {box-shadow: 0 5px #000;}
.zuobian {box-shadow: -5px 0 #000;}
.youbian {box-shadow: 5px 0 #000;}
.zuoshangbian {box-shadow: -5px -5px #000,-5px 0 #000,0 -5px #000;}
.youshangbian {box-shadow: 5px -5px #000,5px 0 #000,0 -5px #000;}
.zuoxiabian {box-shadow: -5px 5px #000,-5px 0 #000,0 5px #000;}
.youxiabian {box-shadow: 5px 5px #000,5px 0 #000,0 5px #000;}
.wushangbian {box-shadow: 5px 5px #000,5px 0 #000,0 5px #000,-5px 5px #000,-5px 0 #000;}
.wuyoubian {box-shadow: -5px -5px #000,-5px 0 #000,0 -5px #000,-5px 5px #000,0 5px #000;}
.wuxiabian {box-shadow: -5px -5px #000,-5px 0 #000,0 -5px #000,5px -5px #000,5px 0 #000;}
.wuzuobian {box-shadow: 5px -5px #000,5px 0 #000,0 -5px #000,5px 5px #000,0 5px #000;}
```

**[查看box-shadow模拟边框DEMO](http://sandbox.runjs.cn/show/0yotpkir)**

##总结

1. 利用了 `box-shadow` 的属性可以无限重复特性,可以通过不断的填充,来满足我们的需求.
2. 并且, `box-shadow` 可以只设置两个值,这样就没有扩展,没有虚化,一比一的移动.
3.  `box-shadow` 的缺点依然存在,就是只能模拟实线,不能模拟虚线
4. 在圆角的运用上,需要更好的计算,反正是利用多重覆盖的特性
5. 做1px的边框,是最简单的.

本文由FungLeo原创,允许转载.但转载必须署名作者,并保留文章首发链接.否则将追究法律责任. 
首发地址: http://blog.csdn.net/FungLeo/article/details/51396410