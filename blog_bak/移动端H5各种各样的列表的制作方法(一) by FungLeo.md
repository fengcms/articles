title: 移动端H5各种各样的列表的制作方法(一) by FungLeo
date: 2016-03-14 15:17:50 +0800
update: 2016-03-14 15:17:50 +0800
author: fungleo
tags:
    -移动端h5
    -列表制作
    -html5+css3
    -sass-scss
---

#移动端H5各种各样的列表的制作方法(一) by FungLeo
##前言
随着移动互联网的发展,大量前端人员从pc端转移动端.而很多PC端的前端经验并不适用于移动端.前几日我撰写的一篇博文《[移动端H5的一些基本知识点总结](http://blog.csdn.net/fungleo/article/details/50811739)》获得了大量的点击量.因此,FungLeo决定,在接下来的时间里,我将围绕移动端,展开一系列的教程.

>本系列文章的CSS部分,将全部采用SASS语法撰写.如果您不会SASS,建议阅读相关教程,包括本人的《[CSS预编译技术之SASS学习经验小结](http://blog.csdn.net/fungleo/article/details/50851192)》教程.
>本系列文章将引用reset.scss和mixin.scss两个基础文档,用于重置浏览器样式,和基础的一些SASS代码块.由于代码较长,请参阅《[移动端系列博文基础reset.scss和mixin.scss](http://blog.csdn.net/fungleo/article/details/50877720)》获取.

本人水平有限,能力一般,因此文章中将不可避免的有错误和遗漏.因此,欢迎大家在文章里评论留言.我将在第一时间内回应.谢谢大家.

##最简单的列表

首先,来一个最简单的列表.我们要实现的效果,如下图所示:

![](https://raw.githubusercontent.com/fengcms/articles/master/image/4c/c420d989cbac08b5d795a6b292c897.png)
如上所示,我们要实现的就是这样简单的列表.这个没有丝毫的难度.

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
这里需要说明的是,移动端一定需要加上`<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />`这段代码.否则移动端的浏览器会当成PC版的网页,是可以伸缩的.

>建议,服务器,数据库,后端程序,前台html以及CSS都全部统一为utf-8编码.避免因为编码造成乱码的情况.

###SASS代码

```css
.list_1 {
	ul {}
	li {
		border-bottom: 1px solid #ddd;padding:0 1.6rem;
		a {display: block;height: 4rem;line-height: 4rem;overflow: hidden;font-size: 1.4rem;}
	}
}
```
>这里的单位全部使用的是`rem`,我们`reset.scss`里面,已经将`html`的字体大小设置为了`62.5%`,也就相当于正常情况下的10px.也就是说,上面的`1.6rem`相当于`16px`.至于为什么这么写,请到本文开头的链接里面查看前面我写的文章中的解释.
>不会sass的,请先阅读sass相关教程.不要觉得难,一个小时保证学会,两天能玩的非常溜.

##还是一个简单的列表

首先,我们来看效果图:

![](https://raw.githubusercontent.com/fengcms/articles/master/image/f3/f3c752d703cd57f0d86b32fe219ebd.png)
这个列表咋一看,和上面的列表没有任何区别.但是,我们仔细看一下,会发现下面的线条是不顶头的.

不要奇怪,很多时候,设计师这样设计,是有其自己的设计理念的.作为前端人员,我们要忠实的还原设计师设计的一些小的细节.即便你认为这有点多此一举.呵呵.

html代码,和第一个示例完全一样.这里不再重复代码

###SASS代码

```css
.list_1 {
	ul {padding-left: 1.6rem;}
	li {
		border-bottom: 1px solid #ddd;padding-right: 1.6rem;
		a {display: block;height: 4rem;line-height: 4rem;overflow: hidden;font-size: 1.4rem;}
	}
}
```

其实,也只是稍微的转换一下思路.将在demo1里面的加载li上的padding值,分配到ul和li上,就可以了.

##小结

好,通过这样两个demo,我们应该对一些基本的情况有所了解了.FungLeo将在下面的章节里面,逐渐的提高列表的复杂程度.为大家呈现各种各样不同的列表.

这是两道开胃菜,非常的简单.需要说明的是这样几点:

1. 不要给任何元素设置宽度,因为这是一个独占一行的列表
2. 在不设置宽度的情况下,可以设定内填充,不会造成任何问题.
3. 要做好隐藏溢出处理,防止标题过长导致折行.

###附录
[移动端H5的一些基本知识点总结](http://blog.csdn.net/fungleo/article/details/50811739)
[sass入门 - sass教程 官方网站](http://www.w3cplus.com/sassguide/)
[CSS预编译技术之SASS学习经验小结](http://blog.csdn.net/fungleo/article/details/50851192)
[移动端系列博文基础reset.scss和mixin.scss](http://blog.csdn.net/fungleo/article/details/50877720)

本文由FungLeo原创,转载请保留版权申明,以及首发地址: [http://blog.csdn.net/FungLeo/article/details/50886680](http://blog.csdn.net/FungLeo/article/details/50886680)

好像微博图床不能用了.有知道是什么情况的吗?