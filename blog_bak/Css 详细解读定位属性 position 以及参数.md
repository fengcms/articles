title: Css 详细解读定位属性 position 以及参数
date: 2015-11-26 15:04:21 +0800
update: 2015-11-26 15:04:21 +0800
author: fungleo
tags:
    -css
    -position
    -relative
    -fixed
    -absolute
---

#Css 详细解读定位属性 position 以及参数

position 定位属性，是CSS中非常重要的属性。除了文档流布局，就是定位布局了。本来我对这个问题没有放在心上，毕竟写了这么多年的css，对position的各类使用是烂熟于心的。但是今天突然发现，居然很多人都不清楚position参数。因此，特地写这篇博文，详细解读一下position 以及参数。

##基础资料

首先，我们可以到 [W3SCHOOL 关于 position 的详细介绍](http://www.w3school.com.cn/cssref/pr_class_position.asp) 页面，来看一下position的资料。

其参数主要有以下：

**absolute	**
生成绝对定位的元素，相对于 static 定位以外的第一个父元素进行定位。
元素的位置通过 "left", "top", "right" 以及 "bottom" 属性进行规定。
**fixed**
生成绝对定位的元素，相对于浏览器窗口进行定位。
元素的位置通过 "left", "top", "right" 以及 "bottom" 属性进行规定。
**relative**
生成相对定位的元素，相对于其正常位置进行定位。
因此，"left:20" 会向元素的 LEFT 位置添加 20 像素。
**static**
默认值。没有定位，元素出现在正常的流中（忽略 top, bottom, left, right 或者 z-index 声明）。
**inherit**
规定应该从父元素继承 position 属性的值。

`static` 默认值，就是没有定位，那就没必要多解释了。`inherit` 继承父元素，基本上这个参数用得相当少，所以也不做过多的解释。

##文档流布局的概念

什么是文档流布局？我百度了一下相对严谨的解释:

> 将窗体自上而下分成一行行， 并在每行中按从左至右的顺序排放元素，即为文档流。 
> 每个非浮动块级元素都独占一行， 浮动元素则按规定浮在行的一端。 若当前行容不下， 则另起新行再浮动。
> 内联元素也不会独占一行。 几乎所有元素(包括块级，内联和列表元素）均可生成子行， 用于摆放子元素。 
> 有三种情况将使得元素脱离文档流而存在，分别是 **浮动**，**绝对定位**， **固定定位**。 但是在IE6中浮动元素也存在于文档流中。

关于浮动会脱离文档流，这里我就不解释了。因为我们一般会大力避免这种问题，而使用清除浮动的方法。上面引用的文字中，**绝对定位** 是指 `position:absolute` ，而 **固定定位** 是指 `position:fixed`。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/94/519fb24a92447d914f60bcdc6929c8.jpg)
如上图所示，这就是正常的文档流布局。一个一个挨着的，到头了，另起一行，接着排布。

理解文档流布局，是理解本文的基础，文档流布局也是css布局最基础的知识。这里就不详细赘述了。

##position:relative 相对定位

什么是相对定位？相对什么定位？这是重要的问题。我的回答是——**相对自己文档流中的原始位置定位**。它的特点是——**不会脱离文档流**。

也就是说，使用`position:relative`定位，其元素依旧在文档流中，他的位置可以使用 `left`、`right`、`top`、`bottom`、`z-index`等定位参数，但是，他的存在，还是会影响文档中紧跟在他周围的元素的。

无论多少文字描述，可能都无法让你理解。下面，我们看一下实际效果。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/03/cc54ec924438822569dd177d372593.jpg)
如上图的演示，我给test3加上了`position:relative`定位效果。代码如下：

```language
position: relative;left: -20px;top: 20px;
```
大家可以清晰的从图上看出来，*test3*根据CSS参数`left: -20px;top: 20px;`发生了位移。

**但是！但是！但是！**重要的事情说三遍，它的唯一**并没有对周围的元素有任何的影响！！**它依然存在于文档流中。它的位移是根据它在文档流中的原始位置发生的！！这一点非常非常重要。

通过上面的图片和阐释，我相信大家都对`position:relative`参数有了深刻的理解了。但这没完。下面我们还有关于它的内容。

##position:fixed 相对浏览器定位

相比而言，这个参数是最好理解的。它相对于浏览器的窗口进行定位。同时——**它会脱离文档流**

好，还是上图片。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/0a/040f60b123c866b79c75ce3262793f.jpg)
代码如下：

```language
position: fixed;right:20px;top: 20px;
```

这是初始状态，我们可以看到它的特点：
1. 它脱离了文档流，原来文档流中不存在它的位置，test4好像test3不存在一样的紧贴在了test2的后面。
2. 它的`right:20px;top: 20px;`参数是相对浏览器窗口定位的。

好，我们再来看一下，当页面发生滚动的效果图。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/09/797778c7380312b45b25ae3abb0cd0.jpg)
当页面发生了滚动，我们可以看到，页面的内容已经根据滚动条的位置发生了位移。但是我们的test3 依旧是在相对于浏览器的位置。

通过上面的图文阐释，我相信，大家对于 `position:fixed` 参数已经有了深刻的理解了。

其实`position:fixed`不难理解。

##position:absolute 绝对定位

绝对定位是一个非常牛逼的属性，牛逼到，你不知道会发生什么。注意，它的解释是什么——“**生成绝对定位的元素，相对于 static 定位以外的第一个父元素进行定位。**”

也就是说，它可以相对于各种各样的东西进行定位。除了 `static` 其他都可以！！！**注意！注意！注意！** 是 **除了** ！

也正是因为这一牛逼特性，导致很多人对此概念混乱。其实，这个一点也不混乱，我们可以将概念理顺了，分成几个情况来说。

>PS:`position:absolute`和`position:fixed`一样是会脱离文档流的。这里就不解释脱离文档流的问题，主要研究它的定位问题。

###它的所有父元素的属性都是 `position:static` 

怎么理解这个标题？`position:static` 是所有html元素默认参数。就是说，这个元素的所有上级元素，你都没有使用过定位方式。

我们通过如下代码模拟一个场景：
```language
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Document</title>
	<style>
		div {font-size: 15px;color: #fff;}
		.test1 {width: 500px;height: 500px;background: #123;}
		.test2 {width: 400px;height: 400px;background: #234;}
		.test3 {width: 300px;height: 300px;background: #345;position: absolute;right: 20px;top: 20px;}
	</style>
</head>
<body>
	<div class="test1">
		test1
		<div class="test2">
			test2
			<div class="test3">test3</div>
		</div>
	</div>
</body>
</html>
```
如上，test3是test2的子元素，test1的孙元素。我们来看一下效果图：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/02/a6c2455a9637f5857d02fb27c3b6c0.jpg)
如上图所示。我们可以看到，test3既没有相对于父元素定位，也没有相对于爷元素定位。它居然和`position:fixed`一样！**相对于浏览器定位**了！！

**！！！这是一个错觉！！！**

我们来看一下浏览器发生滚动之后的效果，如下图所示：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/08/3a70ed8c1658edfb59df70ba62e284.jpg)
如上图所示，它并非是相对于浏览器定位，而是相对于**文档**定位。

如果你有一点js基础的话，那么应该很容易理解。`$(document)`和`$(window)`的差别（为了看得清楚，用了JQ写法）

相对于文档，就是相对于整个页面来进行布局，而相对于窗口，则是相对于浏览器的可视区域进行定位，这二者有本质的区别的。

这种情况在实际应用中有，但是不多。下面，我们再来看其他情况。

###它的父元素的属性是 `position:relative`

上面，我们已经说过了，`position:relative`是相对于自身原始位置定位，其自身并没有脱离文档流。而它的子元素，使用`position:absolute`参数是什么效果呢？我们来做个试验。下面是代码：
```language
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Document</title>
	<style>
		div {font-size: 15px;color: #fff;}
		.test1 {width: 500px;height: 500px;background: #123;}
		.test2 {width: 400px;height: 400px;background: #234;position: relative;left: 50px;top: 50px;}
		.test3 {width: 300px;height: 300px;background: #345;position: absolute;right: -20px;top: -20px;}
	</style>
</head>
<body>
	<div class="test1">
		test1
		<div class="test2">
			test2
			<div class="test3">test3</div>
		</div>
	</div>
</body>
</html>
```
我们给test2加上了`position:relative`属性，并给出了偏移值，然后，再给test3使用绝对定位，使用了为负数的偏移值，我们来看一下效果图，如下：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/31/7ec6d6e8f5177bfb74febe0f597887.jpg)
从上图我们可以看到，test2如我们所愿的，相对于自身的位置发生了偏移，而test3则相对于test2发生了偏移。

从这个试验我们可以看出，当一个元素设置了`position:absolute`属性之后，而它的父元素的属性为`position:relative`则，**它不再是相对于文档定位，而是相对于父元素定位**。

这一点非常重要。最最重要的是，父元素设置为`position:relative`并不会脱离文档流，也就是说——**利用给父元素设置`position:relative`属性，再将子元素设置为`position:absolute`就可以在文档流中实现需要的定位**

这一点异常重要，也是非常常用的方法！（PS:基本上焦点图等常见应用，都是使用了这种方式）

###它的父元素的属性是 `position:fixed`

上面，我们说了父元素为`position:relative`的情况，这种情况比较常见，那么它的父元素为 `position:fixed` 又是什么情况呢？如果你聪明的话，应该有了答案。我们来做一个试验，来印证一下你的想法。代码如下：

```language
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Document</title>
	<style>
		div {font-size: 15px;color: #fff;}
		.test1 {width: 500px;height: 500px;background: #123;}
		.test2 {width: 400px;height: 400px;background: #234;position: fixed;right: 20px;top: 20px;}
		.test3 {width: 300px;height: 300px;background: #345;position: absolute;left: -40px;top: 40px;}
	</style>
</head>
<body>
	<div class="test1">
		test1
		<div class="test2">
			test2
			<div class="test3">test3</div>
		</div>
	</div>
</body>
</html>
```
好，我们可以看到我给test2加上了`position: fixed;right: 20px;top: 20px;` 它会相对于浏览器窗口定位，而test3作为test2的子元素，我们加上了`position: absolute;left: -40px;top: 40px;`那么，根据我们的想象，它应该相对于test2作出偏移。那么是不是这个情况呢？我们来看一下效果图：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/89/cf7aeea431c8533fbf73b875304b4a.jpg)
如上图所示，看到了具体的效果了吧！是不是和你想象的是一样的呢？

###它的父元素的属性是 `position:absolute`

好，我们来看一下，如果`position:absolute`嵌套`position:absolute`元素将会出现什么情况呢？

写了这么多，其实你应该有了一定的预见性了吧？好，我们来做试验，代码如下：

```language
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Document</title>
	<style>
		div {font-size: 15px;color: #fff;}
		.test1 {width: 500px;height: 500px;background: #123;}
		.test2 {width: 400px;height: 400px;background: #234;position: absolute;right: 20px;top: 20px;}
		.test3 {width: 300px;height: 300px;background: #345;position: absolute;right: 20px;top: 20px;}
	</style>
</head>
<body>
	<div class="test1">
		test1
		<div class="test2">
			test2
			<div class="test3">test3</div>
		</div>
	</div>
</body>
</html>
```
如上所示，test2我们使用了`position: absolute;right: 20px;top: 20px;`参数，那么，它会相对于**文档**作出设定的偏移值。而我们给test3使用了同样的css样式。如果test3也是相对于文档定位的话，那么它和test2应该是重叠的。

但是，我们根据上面的解释，test3应该相对于test2定位才对，那么是不是呢？我们看效果图：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/13/5f1ba95ce19e4e32053e4e9c8d3884.jpg)
如上图所示，果然，test2相对于文档偏移，而test3相对于test2偏移。

##position 以及参数总结

1. `position: relative;`不会脱离文档流，`position: fixed;position: absolute;`会脱离文档流
2. `position: relative;` 相对于自己在文档流中的初始位置偏移定位。
3. `position: fixed;` 相对于浏览器窗口定位。
4. `position: absolute;` 是相对于父级非`position:static` 浏览器定位。
	1. 如果没有任何一个父级元素是非`position:static`属性，则会相对于**文档**定位。
	2. 这里它的**父级元素**是包含**爷爷级元素、祖爷爷级元素、祖宗十八代级元素**的。任意一级都可以。
	3. 如果它的**父级元素**和**爷爷级元素**都是非`position:static` 属性，则，它会选择距离最近的父元素。

本文为 **FungLeo by FengCMS** 原创，转载，请无比保留此申明！


