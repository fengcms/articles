title: 纯CSS实现文字一行居中，多行左对齐的方法
date: 2015-11-12 12:29:08 +0800
update: 2015-11-12 12:29:08 +0800
author: fungleo
tags:
    -css
    -文字一行居中
    -多行左对齐
---

#纯CSS实现文字一行居中，多行左对齐的方法

其实这种需求还是蛮常见的。主要用于产品列表页面，用于产品图片下面，显示产品的名称。但是其纯CSS实现实在是烧脑，一般就放掉这个需求，或者，使用JS实现。

但是，我坚信这一定能用纯CSS来解决！！我为什么如此信念笃定呢？因为我多年前在蓝色理想论坛见到过高手解决过！！！

好吧。我实在是找不到这个帖子了，万能的百度没能给我解决方案。我只能自己想办法了。

##问题描述

如何使用css实现文字一行居中，多行左对齐？
想要实现的效果为：

未知文字长度，当文字长度小于盒子宽度，也就是一行时，文字居中。
当文字长度大于盒子的宽度，会自动换行，成为多行文字，此时文字左对齐。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/02/12ea17af00a7ea8950af22fa0ddc3e.jpg)
好了！该如何实现呢？经过我自己的研究，找到了两种解决方法！！

##解决方法一：利用行内元素

我首先想到了这个思路，思路如下：

```
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>文字测试</title>
</head>
<body>
<ul>
	<li><p>一行文字</p></li>
	<li><p>这里是比较长的两行文字</p></li>
</ul>
</body>
</html>
```
这应该是HTML的结构
让P居中，P中的文字左对齐
P的宽度根据文字的宽度伸缩
当文字为一行是，则P的宽度小于LI的宽度，又居中
则，看上去文字是局中的
当大于一行时，P的宽度和LI的宽度是一致的
文字就居左了

所以，CSS是：

```
/* 傻大本粗RESET*/
*{margin: 0;padding: 0;list-style: none;font-weight: normal;font-style: normal;}
body {font-size:13px;font-family:tahoma,Helvetica, Arial,"\5FAE\8F6F\96C5\9ED1";line-height: 1;}
/* 代码开始 */
ul {width: 500px;margin: 100px auto;overflow: hidden;}
/* 开始了！！！！ */
li {
	/* 这些都不重要 */
	float: left;width: 100px;background: #fafafa;height: 50px;margin-right: 10px;
	/* 重点 */
	text-align: center;
}
/* 重点 */
p {display: inline-block;text-align: left;}
```

好了，这是我想到的，但是我忘记给P加上 `text-align: left;`让我误认为此路不通。于是，我又想到了另一个解决方法。

然后群里的朋友根据我的思路，把完整代码写出来了。于是，这条解决方案的原创权，就离我而去了！！

##解决方法二：利用万能的表格

HTML代码和解决方法一是一致的。

CSS如下：

```
/* 傻大本粗RESET*/
*{margin: 0;padding: 0;list-style: none;font-weight: normal;font-style: normal;}
body {font-size:13px;font-family:tahoma,Helvetica, Arial,"\5FAE\8F6F\96C5\9ED1";line-height: 1;}
/* 代码开始 */
ul {width: 500px;margin: 100px auto;overflow: hidden;}
li {loat: left;width: 100px;background: #fafafa;height: 50px;margin-right: 10px;}
/* 重点 */
p {display: table;margin: 0 auto}
```

这个解决方法是在我第一个解决方法因为粗心大意而不得已放弃的情况下，转头找到的。主要是利用了table的牛逼特性。未知宽度的table 也是可以左右对齐的！！

是不是暴露年龄了？の~~那个table布局的年代-_-|||

效果预览地址：http://runjs.cn/detail/oxgbgjji

##利用图层遮盖解决的方法

这是群里的另一个朋友给出的解决方法，出乎我的意料。因为我们没有沟通，他看到我的题目就直接去做去了，给出了完全不同于我的思路的解决方法。虽然在结果看来，代码冗余，但是其思路非常新颖！

html代码如下
```
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>RunJS</title>
	</head>
	<body>
		
		<div class="holder">
			<div class="center">
				<p class="title">
					短标题
				</p>
				<p class="shadow">
					短标题
				</p>
			</div>
			<div class="center">
				<p class="title">
					长标题就是长标题很长的长标题
				</p>
				<p class="shadow">
					长标题就是长标题很长的长标题
				</p>
			</div>
			<div class="center">
				<p class="title">
					长标题就是长标题很长的长标题想短也短不了的长标题
				</p>
				<p class="shadow">
					长标题就是长标题很长的长标题想短也短不了的长标题
				</p>
			</div>
		</div>
			
	</body>
</html>
```

CSS代码如下

```
body{background:#fff;}
div, p{margin:0; padding:0;}

.holder .center{
	float: left;
	margin: 10px;
}
.center{
	width:140px; 
	height:60px; 
	position: relative;
	font:normal 14px/20px "Microsoft Yahei";
}
.center .title{
	
}
.center .shadow{
	position: absolute;
	text-align: center;
	background: #fff;
	overflow: hidden;
	height: 20px;
	top: 0;
	left: 0;
	width: 100%;
}
```

效果预览地址：http://runjs.cn/detail/g4fq6gxr

##总结

当我把这个题目发到群里之后，所有人的第一反应就是——这绝不可能！！

但是，有人自己就想出来了解决方法。而我，也找到了两条解决方法（其中一个被自己PASS掉，另外一个朋友写出来了，然后我一看，の~~~~）

当然，我能解决，主要还是当年在蓝色理想上看到过这个解决方法，只是真心忘记了。但是通过努力回忆，找到思路，然后再实现出来。其实是占有先机的。

最后这个朋友，通过完全自己的思路解决，能够这么快解决，真是了不起！！