title: 移动端H5各种各样的列表的制作方法(五) by FungLeo
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -移动端列表
    -html5+css3
    -sass-scss
    -FungLeo
---

#移动端H5各种各样的列表的制作方法(五) by FungLeo

##前情回顾
前四章的学习地址:
《[移动端H5各种各样的列表的制作方法(一)](http://blog.csdn.net/fungleo/article/details/50886680)》
《[移动端H5各种各样的列表的制作方法(二)](http://blog.csdn.net/FungLeo/article/details/50887529)》
《[移动端H5各种各样的列表的制作方法(三)](http://blog.csdn.net/FungLeo/article/details/50888014)》
《[移动端H5各种各样的列表的制作方法(四)](http://blog.csdn.net/fungleo/article/details/50894602)》

>如果你是先看到的这篇文章,建议您先去上面的链接,把对应的内容给看一下,这样上下文连贯,更容易理解本文的内容.

在第四章中,我们学习了如何来做一个双列的图文列表.但是,这个图文列表是有一定的局限的.局限就是,其中的图片必须为正方形.

当然,在实际项目的实践中.这样也是够了的.但是,这个问题还是不周全,比如,图片没有加载完成的情况下,还是可能出现变形之类的.而又要考虑自适应等多种问题.因此,本章节,我们还是来做双列的图文列表.不同的是,这次,我们不限制图片的尺寸,并且,要保证在图片未加载完成的时候,是不能变形的.

##普通两列图文列表(不限制图片尺寸,且图片未加载不变形)

这种场景还是非常多的.下面我们来看一下实际效果图

![普通两列图文列表(不限制图片尺寸,且图片未加载不变形)](http://ww4.sinaimg.cn/large/459e195ajw1f1ygfhotgoj20aq0hfq5a.jpg)

看一下这个效果,也不是说太复杂.但是其中有几个关键点.我们先来看html代码

###html代码
```html
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
<title>list 3</title>
<link rel="stylesheet" href="../style/style.css">
</head>
<body>
<div class="list_3">
	<ul>
		<li>
			<a href="">
				<div class="goods_photo">
					<img src="../image/1.jpg" alt="这里是商品标题1">
				</div>
				<h4 class="goods_title">这里是商品标题1</h4>
				<em class="goods_price">￥4999.00</em>
			</a>
		</li>
		<li>
			<a href="">
				<div class="goods_photo">
					<img src="../image/2.jpg" alt="这里是商品标题2">
				</div>
				<h4 class="goods_title">这里是商品标题2</h4>
				<em class="goods_price">￥4999.00</em>
			</a>
		</li>
		<li>
			<a href="">
				<div class="goods_photo">
					<img src="../image/3.jpg" alt="这里是商品标题3">
				</div>
				<h4 class="goods_title">这里是商品标题3</h4>
				<em class="goods_price">￥4999.00</em>
			</a>
		</li>
		<li>
			<a href="">
				<div class="goods_photo">
					<img src="../image/4.jpg" alt="这里是商品标题4">
				</div>
				<h4 class="goods_title">这里是商品标题4</h4>
				<em class="goods_price">￥4999.00</em>
			</a>
		</li>
	</ul>
</div>
</body>
</html>
```

本例的代码,和上一篇图片全部为正方形的代码就不太一样了.可以看到,我为`img`标签加了层的`div`嵌套.这当然不是任性为之.而是要用来给图片占位,提供父盒子.在CSS代码中,我们再来看.

###SASS代码

```sass
.list_3 {
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
            // 和上一章最大的差异在这里.
			.goods_photo {
				width: 100%;padding-bottom: 100%;position: relative;
				img {
					// 限制图片最大宽高,保持不变形
					max-width: 80%;max-height: 80%;display: block;
					// 未知宽高块级元素水平且垂直局中代码
					position: absolute;top: 50%;left: 50%;
					transform: translate(-50%, -50%);
				}
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

这里,我们给`.goods_photo`这个盒子,加上了这样的代码`width: 100%;padding-bottom: 100%;position: relative;`,用来形成一个随设备宽度变化的正方形的盒子.如果你看不明白,可以参考我之前的一篇博文《[纯CSS实现移动端常见布局——高度和宽度挂钩的秘密](http://blog.csdn.net/fungleo/article/details/50811589)》.

##小结

在上一章中,我们实现了双列布局.并且实现了模拟`1px`边框等.在本章节中,主要突出了下面的知识点:

1. CSS如何实现元素的高度和宽度挂钩.
2. CSS如何保持图片等比例缩小.
3. 未知尺寸块级元素水平垂直居中的实现方式.

> **强调**:
> (1.)安卓4.4以下和部分国产移动端浏览器不支持`clac`\ `vw` \ `vh` 等最新的CSS属性.因此,文中的方法是使用传统CSS中的技巧解决.
> (2.)本系列文章我准备循序渐经的讲解移动端的一些我的经验见解.某些人看了第一章就惊呼,这也太简单了.我想反问一句,几乎任何编程书籍都是从`hello world`开始的.是不是也都是很简单呢?

###附录
[移动端H5的一些基本知识点总结](http://blog.csdn.net/fungleo/article/details/50811739)
[sass入门 - sass教程 官方网站](http://www.w3cplus.com/sassguide/)
[CSS预编译技术之SASS学习经验小结](http://blog.csdn.net/fungleo/article/details/50851192)
[移动端H5系列博文基础reset.scss和mixin.scss](http://blog.csdn.net/fungleo/article/details/50877720)

本文由FungLeo原创,转载请保留版权申明,以及首发地址: [http://blog.csdn.net/FungLeo/article/details/50902689](http://blog.csdn.net/FungLeo/article/details/50902689)