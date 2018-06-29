title: 纯CSS实现移动端常见布局——高度和宽度挂钩的秘密
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -css3
    -布局
    -移动
    -css
---

#纯CSS实现移动端常见布局——高度和宽度挂钩的秘密
不踩坑不回头.之前我在一个项目中大量使用css3的calc计算属性.写代码的时候真心不要太爽啊...但是在项目上线之后,才让我崩溃了,原因很简单,在低于安卓4.4的版本的手机上,自带的浏览器是不支持这个属性的.

好吧,这还不时最坑爹的,在国产的猎豹浏览器以及其他一些浏览器里面,有可能也不支持.总而言之,这个坑踩大了.不过没关系,大部分的常见布局问题,我都能解决掉.但是,下面这个....我真心有点费解.不过,没关系,通过我的研究,最终还是很快用CSS解决了.

需要的效果,如下图:

![](https://raw.githubusercontent.com/fengcms/articles/master/image/1a/2f06a6a7ff8ede3ee233312eba0d4c.jpg)
##需求分析

看图,其实很简单.如果宽度是固定的,那么这个布局就不要太简单了.

问题是,设备的宽度是不固定的哦,那么问题就是,在不知道具体宽度的时候,如何来设定它对应的高度呢?

也就是说,如何在CSS中,找到一个高度和宽度挂钩的属性.只要存在这个参数,那么,问题就能解决.

那么有没有这个参数呢?

有的.那就是padding

##代码实践

一般情况下,是想不起来padding有这个特性的.不过,想起来了,那么这个问题就迎刃而解了,看代码吧.

###HTML结构

```html
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Document</title>
<meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no">
</head>
<body>
	<div class="box1"></div>
	<div class="box2"></div>
	<div class="box3"></div>
</body>
</html>
```

###CSS代码

```css
* {margin: 0;padding: 0;}
.box1 {width: 50%;padding-bottom: 50%;float: left;background: #123;}
.box2 {width: 50%;padding-bottom: 25%;float: right;background: #234;}
.box3 {width: 50%;padding-bottom: 25%;float: right;background: #345;}
```

##总结

对于常见的CSS参数,你可能很难知道里面的一些好玩的东西,或者看到了也熟视无睹.

在我们遇到一些问题的时候,尤其是布局这种问题,我们要考虑的是,能不能用CSS解决,而不时一位的去考虑JS.毕竟,JS是用来交互的,而CSS是用来布局的.

FungLeo原创,转载请保留版本申明,以及首发地址:http://blog.csdn.net/fungleo/article/details/50811589
