title: 移动端H5各种各样的列表的制作方法(四) by FungLeo
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -移动端H5
    -html5+css3
    -sass-scss
    -图文列表
---

#移动端H5各种各样的列表的制作方法(四) by FungLeo

##前情回顾
前三章的学习地址:
《[移动端H5各种各样的列表的制作方法(一)](http://blog.csdn.net/fungleo/article/details/50886680)》
《[移动端H5各种各样的列表的制作方法(二)](http://blog.csdn.net/FungLeo/article/details/50887529)》
《[移动端H5各种各样的列表的制作方法(三)](http://blog.csdn.net/FungLeo/article/details/50888014)》

>如果你是先看到的这篇文章,建议您先去上面的链接,把对应的内容给看一下,这样上下文连贯,更容易理解本文的内容.

前面三章,都是说一个普通的列表应该如何去实现.难度由易到难,但总的来说,一看就能掌握.这一章,我们来做图文列表.

##普通两列图(图为正方形)文列表

两列的图文列表是非常常见的.在JD\TB等电商移动端H5更是比比皆是.这里,我们先来做一个最简单的.如下图所示.

![普通两列图(图为正方形)文列表](http://ww1.sinaimg.cn/large/459e195ajw1f1xc19i50hj209l0ijtbj.jpg)

这里是一个非常简单的双列布局的图文列表,每一块,包含图片,名称和价格.在PC端实现这样的布局实在是太简单了.但是由于我们在移动端,不同的手机的宽度是不一致的.因此,要求是自适应的.

> 这里的所有图片都是统一规格,皆为正方形的.在实际的项目中,一般都会对产品的图片有所要求.如果您的产品并非正方形的.下面我们会有相关的教程.

###html代码
```html
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
<title>list 2</title>
<link rel="stylesheet" href="../style/style.css">
</head>
<body>
<div class="list_2">
	<ul>
		<li>
			<a href="">
				<img src="../image/goods.jpg" alt="商品图片" class="goods_photo">
				<h4 class="goods_title">这里是商品标题1</h4>
				<em class="goods_price">￥4999.00</em>
			</a>
		</li>
		<li>
			<a href="">
				<img src="../image/goods.jpg" alt="商品图片" class="goods_photo">
				<h4 class="goods_title">这里是商品标题2</h4>
				<em class="goods_price">￥4999.00</em>
			</a>
		</li>
		<li>
			<a href="">
				<img src="../image/goods.jpg" alt="商品图片" class="goods_photo">
				<h4 class="goods_title">这里是商品标题3</h4>
				<em class="goods_price">￥4999.00</em>
			</a>
		</li>
		<li>
			<a href="">
				<img src="../image/goods.jpg" alt="商品图片" class="goods_photo">
				<h4 class="goods_title">这里是商品标题4</h4>
				<em class="goods_price">￥4999.00</em>
			</a>
		</li>
	</ul>
</div>
</body>
</html>
```
代码比较长.但是还是一眼就能看清楚的.我们给不同的元素加上了不同的class.而这样做的目的是为了在全站范围内,用到这些元素的基本样式可以得到统一,并且实现CSS的代码复用.

###SASS代码

```sass
.list_2 {
	ul {
		@extend .cf; // 引用清理浮动代码片,看不懂请看本人scss相关教程
		li {
			width: 50%;float: left;padding: 1rem 0;
			outline: 1px solid #ddd;  // 使用 outline 模拟边框 (outline不占据盒子模型)
			background: #fff;  // 使用白色背景颜色,防止 outline 重叠造成 2px 线条
			a {
            	display: block;
				text-decoration: none; // 去除默认下划线
			}
			.goods_title,.goods_price {
				padding: 0 1rem; // 加上左右内填充,防止文字和边框粘结
				text-align: center;
			}
			.goods_photo {
				width: 60%;margin: .5rem auto;display: block;
			}
		}
	}
}
// 全站范围内用到的图文基本样式
.goods_title,.goods_price {
	display: block;position: relative;
	@include ts(); // 引用文字描白边代码片
	@include online(1.8rem); // 引用文字超出一行省略号代码片
}
.goods_title {color:#000;font-size: 1.2rem;}
.goods_price {color:#f60;font-size: 1.5rem;font-weight: bold;}
```

再次强调一下,本系列教程的CSS部分是采用了SASS语法,如果你不会SASS语法,建议花上半个小时到一个小时的时间来学习SASS.

这里,我们将全站内通用的一些样式摘取出来.这样方便代码复用.

##小结

这一章节,我们通过简单的一个双列布局的图文列表,着重要掌握以下几点内容

1. 在移动端,要用到左右边框的时候,尽量不要使用`border`边框来实现.本例使用 `outline`来模拟.
2. 在使用 `outline` 来模拟边框的时候,一定要配合背景颜色的使用,来避免 `2px` 边框.
3. CSS3文字描边的实现方法.`text-shadow`
4. css3一行文字标题超出显示省略号的实现方法
5. sass引入代码块的两种方法,以及之间的异同(请自行考虑或参考相关教程)

> 在`html5` 中 `a` 标签是可以嵌套块级元素的.而在`xhtml`或者更早的`html`版本里,是不推荐这样做的.这里不要混淆,或者感觉到不合适.与时俱进.

###附录
[移动端H5的一些基本知识点总结](http://blog.csdn.net/fungleo/article/details/50811739)
[sass入门 - sass教程 官方网站](http://www.w3cplus.com/sassguide/)
[CSS预编译技术之SASS学习经验小结](http://blog.csdn.net/fungleo/article/details/50851192)
[移动端系列博文基础reset.scss和mixin.scss](http://blog.csdn.net/fungleo/article/details/50877720)
- - -
[移动端各种各样的列表的制作方法(一)](http://blog.csdn.net/fungleo/article/details/50886680)
[移动端各种各样的列表的制作方法(二)](http://blog.csdn.net/FungLeo/article/details/50887529)
[移动端各种各样的列表的制作方法(三)](http://blog.csdn.net/FungLeo/article/details/50888014)

本文由FungLeo原创,转载请保留版权申明,以及首发地址: [http://blog.csdn.net/FungLeo/article/details/50894602](http://blog.csdn.net/FungLeo/article/details/50894602)