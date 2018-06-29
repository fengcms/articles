title: 移动端H5各种各样的列表的制作方法(六) by FungLeo
date: 2016-03-16 11:07:26 +0800
update: 2016-03-16 11:07:26 +0800
author: fungleo
tags:
    -移动端H5
    -移动端列表
    -html5+css3
    -sass-scss
    -FungLeo
---

#移动端H5各种各样的列表的制作方法(六) by FungLeo

##前情回顾
前五章的学习地址:
《[移动端H5各种各样的列表的制作方法(一)](http://blog.csdn.net/fungleo/article/details/50886680)》
《[移动端H5各种各样的列表的制作方法(二)](http://blog.csdn.net/FungLeo/article/details/50887529)》
《[移动端H5各种各样的列表的制作方法(三)](http://blog.csdn.net/FungLeo/article/details/50888014)》
《[移动端H5各种各样的列表的制作方法(四)](http://blog.csdn.net/fungleo/article/details/50894602)》
《[移动端H5各种各样的列表的制作方法(五)](http://blog.csdn.net/fungleo/article/details/50902689)》

>如果你是先看到的这篇文章,建议您先去上面的链接,把对应的内容给看一下,这样上下文连贯,更容易理解本文的内容.

在前面两章中,讲的都是两列布局的图文列表.而事实上,两列布局的图文列表还是比较简单的.这一章,我们将要更进一步来挑战难度.实现一个相对来说,非常复杂的布局方式.

并且,为兼容安卓4.4以下,以及部分傻逼国产移动端浏览器.我们将在实践中,放弃`calc\vh\vw`等`css3`最新属性.只使用比较简单的参数,来实现这个布局.

##复杂图文混排列表

这部分是比较复杂的,但是,特别特别的常见.我们先来看一下最终效果图.

![](https://raw.githubusercontent.com/fengcms/articles/master/image/9d/273d5e119cab6f860959a32c695b34.jpg)
如上图所示,这应该算是一个比较复杂的图文列表了.不知道你看到这个布局,你会构建怎么样的DOM框架.

我是这样考虑的.为了后端能够方便的输出,这六个产品,必须格式统一.因此,我的HTML代码如下:

###html代码
```html
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
<title>list 4</title>
<link rel="stylesheet" href="../style/style.css">
</head>
<body>
<div class="list_4">
	<ul>
		<li>
			<a href="goods/goods.html">
				<!-- 只有第一个有这个热售,其他的木有!~ -->
				<i class="goods_words">热售</i>
				<h3 class="goods_title">苹果iPhone6s</h3>
				<p class="goods_info">A1700</p>
				<em class="goods_price">￥4679.00</em>
				<img src="../image/goods.jpg" alt="苹果iPhone6s" class="goods_photo">
			</a>
		</li>
		<li>
			<a href="goods/goods.html">
				<h3 class="goods_title">苹果iPhone6s苹果iPhone6s苹果iPhone6s苹果iPhone6s</h3>
				<p class="goods_info">A1700</p>
				<em class="goods_price">￥4679.00</em>
				<img src="../image/goods.jpg" alt="苹果iPhone6s苹果iPhone6s苹果iPhone6s苹果iPhone6s" class="goods_photo">
			</a>
		</li>
		<li>
			<a href="goods/goods.html">
				<h3 class="goods_title">苹果iPhone6s苹果iPhone6s苹果iPhone6s苹果iPhone6s</h3>
				<p class="goods_info">A1700</p>
				<em class="goods_price">￥4679.00</em>
				<img src="../image/goods.jpg" alt="苹果iPhone6s苹果iPhone6s苹果iPhone6s苹果iPhone6s" class="goods_photo">
			</a>
		</li>
		<li>
			<a href="goods/goods.html">
				<h3 class="goods_title">苹果iPhone6s苹果iPhone6s苹果iPhone6s苹果iPhone6s</h3>
				<p class="goods_info">A1700</p>
				<em class="goods_price">￥4679.00</em>
				<img src="../image/goods.jpg" alt="苹果iPhone6s" class="goods_photo">
			</a>
		</li>
		<li>
			<a href="goods/goods.html">
				<h3 class="goods_title">苹果iPhone6s</h3>
				<p class="goods_info">A1700</p>
				<em class="goods_price">￥4679.00</em>
				<img src="../image/goods.jpg" alt="苹果iPhone6s" class="goods_photo">
			</a>
		</li>
		<li>
			<a href="goods/goods.html">
				<h3 class="goods_title">苹果iPhone6s</h3>
				<p class="goods_info">A1700</p>
				<em class="goods_price">￥4679.00</em>
				<img src="../image/goods.jpg" alt="苹果iPhone6s" class="goods_photo">
			</a>
		</li>
	</ul>
</div>
</body>
</html>
```

可以看到,在这个HTML结构中,我并没有给li加上不同的class.而事实上,在后端输出的时候,是可以输出不同的class的.但这回使事情复杂.因此,在这里,我们就只输出纯的代码.顺便,温习一下我之前的博文《[css3的nth-child选择器的详细探讨](http://blog.csdn.net/fungleo/article/details/50813881)》.

###SASS代码

```sass
.list_4 {
	margin-top: 0.8rem;background:#fff;border-top: 1px solid #ddd;
	ul {@extend .cf;}
	li {
		background:#fff;outline: 1px solid #ddd;
		&:nth-child(-n+3) {
			width: 50%;height: 0;position: relative;
			a {display: block;position: absolute;left: 0;top: 0;height: 0;width: 100%;}
			.goods_photo {display: block;position: absolute;right:0.5rem;}
			.goods_title,.goods_info,.goods_price {z-index: 2;width: 60%;}
		}
		&:nth-child(1) {
			float: left;padding-bottom: 55%;
			a {padding-bottom: 110%;}
			.goods_photo {width: 50%;bottom: 5%;}
			.goods_title,.goods_info,.goods_price,.goods_words {margin-left: 1.6rem;}
			.goods_words {margin-top: 1.6rem;}
		}
		&:nth-child(n+2):nth-child(-n+3) {
			float: right;padding-bottom: 27.5%;
			a {padding-bottom: 55%;}
			.goods_photo {height: 70%;top: 15%;}
			.goods_title,.goods_info,.goods_price,.goods_words {margin-left: 1.2rem;}
			.goods_title {margin-top: 1.6rem;}
		}
		&:nth-child(n+4) {
			width: 33.3%;float: left;
			a {display: block;padding: 1rem;}
			.goods_photo {width: 70%;max-width: 15rem;margin: 0.5rem auto 0;display: block;}
		}
	}
}

// 全站范围内用到的图文基本样式
.goods_words {
	display:inline-block;padding:0.3rem 0.5rem;border-radius: 0.3rem;background:#f60;color:#fff;font-size: 1.2rem;margin-bottom: 0.5rem;
}
.goods_title,.goods_price,.goods_info {
	display: block;position: relative;
	@include ts(); // 引用文字描白边代码片
	@include online(1.8rem); // 引用文字超出一行省略号代码片
}
.goods_title {color:#000;font-size: 1.2rem;}
.goods_info {color:#999;font-size: 1.2rem;}
.goods_price {color:#f60;font-size: 1.5rem;font-weight: bold;}
```

在我之前的一篇博文《[纯CSS实现移动端常见布局——高度和宽度挂钩的秘密](http://blog.csdn.net/fungleo/article/details/50811589)》里面,我就是讲解的这个布局的实现方法.在那篇文章的发布之后,有人问我,你这样布局,里面的内容怎么排布呢?我说用定位布局,他还是没听明白.不知道看到我这篇文章之后,明白了没有.

具体代码是什么意思,我这里就不详细解释了.自己看了分析吧.重点是 `nth-child`的使用,可以参考我上面的博文,理解我每一个选择器是什么意思.以及,定位布局等.

##小结

这一章的重点有

1. CSS如何实现元素的高度和宽度挂钩.
2. 定位布局,相当的重要
3. `nth-child` 实在是一个非常强大的CSS选择器,在具体项目中,怎么使用它.

> **强调**:
> (1.)安卓4.4以下和部分国产移动端浏览器不支持`clac`\ `vw` \ `vh` 等最新的CSS属性.因此,文中的方法是使用传统CSS中的技巧解决.
> (2.)本系列文章我准备循序渐经的讲解移动端的一些我的经验见解.某些人看了第一章就惊呼,这也太简单了.我想反问一句,几乎任何编程书籍都是从`hello world`开始的.是不是也都是很简单呢?

###附录
[移动端H5的一些基本知识点总结](http://blog.csdn.net/fungleo/article/details/50811739)
[sass入门 - sass教程 官方网站](http://www.w3cplus.com/sassguide/)
[CSS预编译技术之SASS学习经验小结](http://blog.csdn.net/fungleo/article/details/50851192)
[移动端H5系列博文基础reset.scss和mixin.scss](http://blog.csdn.net/fungleo/article/details/50877720)

本文由FungLeo原创,转载请保留版权申明,以及首发地址: [http://blog.csdn.net/FungLeo/article/details/50903374](http://blog.csdn.net/FungLeo/article/details/50903374)