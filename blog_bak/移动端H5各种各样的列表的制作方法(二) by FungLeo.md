title: 移动端H5各种各样的列表的制作方法(二) by FungLeo
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -移动端列表
    -html5+css3
    -sass
---

#移动端H5各种各样的列表的制作方法(二) by FungLeo
##前情回顾

在上一篇博文《[移动端各种各样的列表的制作方法(一)](http://blog.csdn.net/fungleo/article/details/50886680)》中,我们通过两个简单的DEMO,演示了一下在移动端H5中的列表制作.不过,这两个演示还是太简单了.可能大家觉得不过如此嘛.这一章,我们将制作稍微复杂一点点的列表.

>如果你是先看到的这篇文章,建议您先去上面的链接,把对应的内容给看一下,这样上下文连贯,更容易理解本文的内容.

##带右箭头的列表

这个示例,其实和上一张的第二个差不多,只是右边多了一个右箭头.我们要实现的效果,如下图所示:

![](https://raw.githubusercontent.com/fengcms/articles/master/image/7c/c9b8d149dd475dd542dc4bada6d853.jpg)
如上所示,在列表的右边,有一个右箭头.可能,你会奇怪,为什么右边的下面的线条顶头了?哎,这就是我们这的设计师的设计.你们只需要知道了原理,那么怎么做都是可以的.

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
		<li><a href="">这是一个列表1</a></li>
		<li><a href="">这是一个列表2</a></li>
		<li><a href="">这是一个列表3</a></li>
		<li><a href="">这是一个列表4</a></li>
		<li><a href="">这是一个列表5</a></li>
		<li><a href="">这是一个列表6</a></li>
		<li><a href="">这是一个列表7</a></li>
		<li><a href="">这是一个列表8</a></li>
	</ul>
</div>
</body>
</html>
```
html代码和第一章的例子是一模一样的.

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
		}
	}
}
}
```
实现起来也比较简单,就是给 `a` 加上了一个右箭头的背景图片.没什么稀罕的.

但这里需要特别说明的是, `background-size`其实是可以缩写到 `background` 里面去的.但是因为安卓4.4以下不兼容,所以,我们目前来说,还是需要拆来来写.预计,在2016年年底,我们可能就能忽略到所有的老版本的安卓了.但眼下,貌似不行.

它的缩写代码是:

```css
background:url("../image/icon_goto.png") right center/auto 1.4rem no-repeat;
```
好,第一个demo就这么轻松的完成了.下面我们来做更加复杂一丢丢的.

##带日期的,带右箭头的列表

首先,我们来看效果图:

![](https://raw.githubusercontent.com/fengcms/articles/master/image/12/acaf26b45c513ff1c31615d7e94c32.jpg)
这个列表也没有很复杂,只是添加了一个日期.日期靠右显示,并且日期不会和标题重叠.我们来看一下是怎么做的.

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
		<li><a href=""><time>2016.03.14</time>这是一个列表1</a></li>
		<li><a href=""><time>2016.03.14</time>这是一个列表2</a></li>
		<li><a href=""><time>2016.03.14</time>这是一个列表3</a></li>
		<li><a href=""><time>2016.03.14</time>这是一个列表4</a></li>
		<li><a href=""><time>2016.03.14</time>这是一个列表5</a></li>
		<li><a href=""><time>2016.03.14</time>这是一个列表6</a></li>
		<li><a href=""><time>2016.03.14</time>这是一个列表7</a></li>
		<li><a href=""><time>2016.03.14</time>这是一个列表8</a></li>
	</ul>
</div>
</body>
</html>
```

首先,html5提供了一个 time 标签,用来专门放置时间.我们以往都是使用span或者其他标签来制作.此后,时间有了专门的标签了.真是意见可喜可贺的事情.

其次,为什么time标签在a里面呢?因为,移动端都是触摸操作.我们要保证访客在点击列表的任意位置都能打开链接,因此,a要块状化,并且最大化的处理.这点,和我们在PC端制作的时候是很不一样的.

关于列表日期,我还有一篇老的博文,有兴趣可以阅读一下,《[新闻列表中标题和日期的左右分别对齐的几种处理方法](http://blog.csdn.net/fungleo/article/details/50315437)》

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
			padding-right: 1.5rem;
		}
		time {float: right;color: #999;}
	}
}
```

并没有特别复杂,只是为了防止日期和右箭头重叠,给 `a` 加了一个右内填充.另外,时间使用右浮动法,放到了右边去了.

##小结

相信这两个DEMO并没有非常难理解,聪明的你一定是一看就明白了.我们小小的总结一下:

1. 链接块状化,是为了便于移动端的用户能够更加方便的点击到链接
2. `background-size` 的使用方法和简写,以及为什么当下,我们不去简写这个属性.
3. 时间有专门的 `html5` 标签—— `time`
4. 右浮动法,定位右边的时间

###附录
[移动端H5的一些基本知识点总结](http://blog.csdn.net/fungleo/article/details/50811739)
[sass入门 - sass教程 官方网站](http://www.w3cplus.com/sassguide/)
[CSS预编译技术之SASS学习经验小结](http://blog.csdn.net/fungleo/article/details/50851192)
[移动端系列博文基础reset.scss和mixin.scss](http://blog.csdn.net/fungleo/article/details/50877720)
- - -
[移动端各种各样的列表的制作方法(一)](http://blog.csdn.net/fungleo/article/details/50886680)

本文由FungLeo原创,转载请保留版权申明,以及首发地址: [http://blog.csdn.net/FungLeo/article/details/50887529](http://blog.csdn.net/FungLeo/article/details/50887529)