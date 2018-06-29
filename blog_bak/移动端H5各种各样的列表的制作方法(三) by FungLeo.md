title: 移动端H5各种各样的列表的制作方法(三) by FungLeo
date: 2016-03-14 17:05:49 +0800
update: 2016-03-14 17:05:49 +0800
author: fungleo
tags:
    -移动端列表
    -html5+css3
    -sass-scss
---

#移动端H5各种各样的列表的制作方法(三) by FungLeo
##前情回顾

在上一篇博文《[移动端各种各样的列表的制作方法(二)](http://blog.csdn.net/FungLeo/article/details/50887529)》中,我们再通过两个DEMO,演示了一下在移动端H5中更多需求的列表制作.不过,看起来,好像还是蛮简单的.这一章,接着深入.

>如果你是先看到的这篇文章,建议您先去上面的链接,把对应的内容给看一下,这样上下文连贯,更容易理解本文的内容.

##带小图标的列表

上面两章,我们做了一些普通的列表.而在移动端H5中,我们经常会做一行一个小图标的列表.这个DEMO,我们就来制作这种类型的列表.示例如下图所示.

![](https://raw.githubusercontent.com/fengcms/articles/master/image/db/b14b16532562251e6dd83ba51e0586.jpg)
这里我就不使用小图标了,画一个圆圈圈代替一下.

###html代码
```html
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
<title>list 1</title>
<link rel="stylesheet" href="../style/style.css">
</head>
<body>
<div class="list_1">
	<ul>
		<li><a href=""><i class="ico ico_1"></i>这是一个列表1</a></li>
		<li><a href=""><i class="ico ico_2"></i>这是一个列表2</a></li>
		<li><a href=""><i class="ico ico_3"></i>这是一个列表3</a></li>
		<li><a href=""><i class="ico ico_4"></i>这是一个列表4</a></li>
		<li><a href=""><i class="ico ico_5"></i>这是一个列表5</a></li>
		<li><a href=""><i class="ico ico_6"></i>这是一个列表6</a></li>
		<li><a href=""><i class="ico ico_7"></i>这是一个列表7</a></li>
		<li><a href=""><i class="ico ico_8"></i>这是一个列表8</a></li>
	</ul>
</div>
</body>
</html>
```
这里的html代码和前面的例子就不太一样了.这里我们加了一个`i`标签来制作图标.给每一个`i`标签加上不同的`class`是为了订制不同的图标.

###SASS代码

```css
.list_1 {
	ul {padding-left: 1.6rem;}
	li {
		border-bottom: 1px solid #ddd;padding-right: 1.6rem;
		a {
			display: block;height: 4rem;line-height: 4rem;overflow: hidden;font-size: 1.4rem;
			background:url("../image/icon_goto.png") right center no-repeat;
			background-size: auto 1.4rem;
			padding-left: 3rem;
			position: relative;
		}
		.ico {
			display: block;width: 2.4rem;height: 2.4rem;position: absolute;left: 0;top: .8rem;
			background: #f60;border-radius: 50%;
		}
	}
}
```

在这个例子当中,我们采用了定位布局的方式.如果您对定位布局不是很了解,请阅读我的博文《[Css 详细解读定位属性 position 以及参数](http://blog.csdn.net/fungleo/article/details/50056111)》.

此外,由于每个图标都得不一样,所以我在html中给每一个`i`标签都加上了不同的class方便在CSS中调用不同的图标图片.也就是说,我们使用背景图片的方式来制作图标.

SASS是支持循环输出的,因此,只需要一个循环代码,就可以将所有的图标都制作OK了.这里呢,也需要使用到`background-size`来处理图标,关于`background-size`的使用,本文的上一章中有阐述.这里不再赘述.

SASS循环,建议在[sass入门 - sass教程 官方网站](http://www.w3cplus.com/sassguide/)查看实现方法.这里不再过多的阐述了.

##带图标的列表,但是分割线要和文字对齐.

首先,我们来看效果图:

![](https://raw.githubusercontent.com/fengcms/articles/master/image/a3/59f85bb20645fdddad112fe88d3820.jpg)
这个列表和上面的列表乍一看没什么不同.但仔细看就会发现,这个分割线是和文字对齐,而不是和图标对齐的.

不要怪我事儿逼,设计师就是这么设计的.如果没有做到的话,设计师很生气.

>html代码和上面的DEMO是一致的.这里不再重复

话不多说,调整css

###SASS代码

```css
.list_1 {
	ul {padding-left: 4.6rem;}
	li {
		border-bottom: 1px solid #ddd;
		padding-right: 1.6rem;
		position: relative;
		a {
			display: block;height: 4rem;line-height: 4rem;overflow: hidden;font-size: 1.4rem;
			background:url("../image/icon_goto.png") right center no-repeat;
			background-size: auto 1.4rem;
		}
		.ico {
			display: block;width: 2.4rem;height: 2.4rem;position: absolute;left: -3rem;top: .8rem;
			background: #f60;border-radius: 50%;
		}
	}
}
```

原来在` a `上的左填充,给加到` ul `上面去了.这样,就可以压缩`li`来达到边线缩小的效果.
而在图标的处理上,`left`值采用了负数,给移到`ul`的填充上面去.就达到设计效果了.

##小结

本章没有着重去讲SASS的循环如何处理,这些都是技术性的问题,参考一下SASS的教程,很快就能学会的.

我这里假设是使用背景图片的方法,来实现小图标的.当然,现在有很多种方法来实现小图标的制作,比如CSS图标,比如字体图标.这些实现方法各有优劣,不是我今天考虑的问题.

本章着重讲了以下几点:

1. 定位布局.这一点很重要.
2. 灵活的使用各种元素,使用内填充或者外填充,来实现你想要的效果.
3. 使用不同的class名,来实现不同的小图标.

###附录
[移动端H5的一些基本知识点总结](http://blog.csdn.net/fungleo/article/details/50811739)
[sass入门 - sass教程 官方网站](http://www.w3cplus.com/sassguide/)
[CSS预编译技术之SASS学习经验小结](http://blog.csdn.net/fungleo/article/details/50851192)
[移动端系列博文基础reset.scss和mixin.scss](http://blog.csdn.net/fungleo/article/details/50877720)
- - -
[移动端各种各样的列表的制作方法(一)](http://blog.csdn.net/fungleo/article/details/50886680)
[移动端各种各样的列表的制作方法(二)](http://blog.csdn.net/FungLeo/article/details/50887529)

本文由FungLeo原创,转载请保留版权申明,以及首发地址: [http://blog.csdn.net/FungLeo/article/details/50888014](http://blog.csdn.net/FungLeo/article/details/50888014)