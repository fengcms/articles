title: 移动端H5做一个不限个数的通栏按钮 by FungLeo
date: 2016-03-18 17:03:42 +0800
update: 2016-03-18 17:03:42 +0800
author: fungleo
tags:
    -移动端H5
    -通栏按钮
    -html5+css3
    -FungLeo
    -表格
---

#移动端H5做一个不限个数的通栏按钮 by FungLeo

##前言

在移动端h5的页面上经常需要一些通栏的按钮.当然,要做一个通栏的按钮这个事儿还是巨简单的.可是,产品经理和设计师永远都会给你添点麻烦.比如,明明是格式一样的按钮,但这里是一个通栏的按钮,到下面,就变成了通栏需要两个按钮,进到内页,就是三个按钮挤在一个通栏上.

如果没有一个合理的解决方法,那么,无疑是非常恶心的.因为,我们必须写多个样式.而我们总想少写一些代码,那么,我们有没有什么好的解决方法来实现呢?

其实是有的.下面,这篇博文,就让我们来实现这个挑战.

##所要的效果.

可能看了上面的文字,你并没有理解我想表达什么.下面,我们来看一下一个效果图,你就明白我说的是什么了.

![](https://raw.githubusercontent.com/fengcms/articles/master/image/e0/b6979b278f4f9e4dd000e24cf09435.jpg)
如上图所示,第一个是一个通栏的按钮,第二行是两个按钮,第三行是三个按钮.

我希望通过一种CSS就能满足这所有的需求,并且,html结构异常简单才行.怎么实现?看下面的代码:

##html结构

```html
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="zh">
<head>
	<meta charset="UTF-8">
	<title>移动端H5做一个不限个数的通栏按钮</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
	<link rel="stylesheet" href="../style/style.css">
</head>
<body>
	<br>
	<!-- 第一行按钮 -->
	<div class="button_box">
		<div class="button pink">确定</div>
	</div>
	<br>
	<!-- 第二行按钮 -->
	<div class="button_box">
		<div class="button pink">付款</div>
		<div class="button">取消订单</div>
	</div>
	<br>
	<!-- 第三行按钮 -->
	<div class="button_box">
		<div class="button pink">设为默认</div>
		<a class="button">修改</a>
		<label class="button">删除<input type="submit"></label>
	</div>
</body>
</html>
```

如上代码所示.
>其中的`br`是为了区隔各个按钮之间的距离,主要是`div.button_box`里面的内容.

html的结构应该说是相当简单的.首先,外层是`div.button_box`的盒子,而里面呢,需要什么按钮,就写一个.button的非自闭和元素即可.

>非自闭和元素是指除了`br\hr\input`等自闭元素之外的其他元素.

在第三行里面,我们演示了普通的盒子,链接,以及按钮的写法.

由于按钮是自闭和元素,因此,我们用一个`label`元素进行包裹,使其是可用的.

##SASS部分

首先引用reset.scss和mixin.scss,见 [移动端H5系列博文基础reset.scss和mixin.scss](http://blog.csdn.net/fungleo/article/details/50877720)

其次,CSS部分使用SASS语法书写,如果不会的话,请参考 [CSS预编译技术之SASS学习经验小结](http://blog.csdn.net/fungleo/article/details/50851192). 不再做过多阐述.

```css
.button_box {
	display: table;		// 将 button_box 外层盒子模拟成表格
	width: 100%;		// 表格非完整块级元素,需要设定宽度
	table-layout:fixed;	// 设定表格内单元格的宽度为自动等宽,重要!
	border-collapse: collapse;	// 合并表格和单元格边框
	.button {
		display: table-cell;	// 将子元素模拟成单元格
		font-size: 1.5rem;text-align: center;
		background: #eee;color: #555;	// 设定默认按钮样式
		box-shadow: 0 0 0 1px #ddd;		// 利用阴影模拟边框(阴影不占用盒子模型)
		text-decoration: none;			// 如果元素是链接,则去掉下划线
		@include hlh(4.8rem);			// 引用高度行高隐藏溢出代码块
		&.pink {		//设定一个特殊按钮样式,可根据需要设定多个
			background: #F13E7A;
			color: #fff;
			box-shadow:0 0 0 1px #F13E7A;
		}
		input {display: none;}		// 如果是按钮,则隐藏
	}
}
```

sass部分的解释,我已经放在注释里面了.其思考主要是利用表格的特殊属性,来实现了这个看上去比较费劲的需求.

##总结

表格,多么神奇的元素.由于当年我们使用表格布局,造成代码像老太太的裹脚布一样又臭又长,因此,我们掀起了div+css的热潮.而由于矫枉过正,导致我们忽略了表格的很多牛逼的特性.

其实表格是很牛逼的.通过这个案例,我们利用表格,顺利的解决了这个看似困难的需求.而且完成得非常理想,非常棒.

html元素远非块级元素和内联元素.有很多的属性,也需要我们去尝试和了解.看上去简单,你确定简单吗?

本文由FungLeo原创,转载请保留版权以及首发链接[http://blog.csdn.net/FungLeo/article/details/50925094](http://blog.csdn.net/FungLeo/article/details/50925094)
