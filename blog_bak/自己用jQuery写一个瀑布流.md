title: 自己用jQuery写一个瀑布流
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -jquery
    -瀑布流
    -javascript
---

#自己用jQuery写一个瀑布流
##前言
这个月一直在忙工作。一直没有机会学习新的知识。前两天，突然想写一个瀑布流代码。倒不是找不到瀑布流代码。而是我想自己练练脑子。
首先，先考虑思路。所有的图片，全部采用相对父目录定位的方式。然后用`jQuery`来找出它应该排在什么位置。最终，达成瀑布流的效果。
想再多没用。开干。
##构建html构架
```
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>瀑布流jquery版本测试</title>
	<link rel="stylesheet" href="style/style.css">
	<script src="js/jquery/jquery.js"></script>
	<script src="js/FengWaterFall.beta2.js"></script>
</head>
<body>
<h1 class="tc cf">瀑布流jquery版本测试</h1>
<section id="waterfall">
	<ul class="piclist">
		<li><img src="image/1.jpg" alt=""><span>瀑布流测试1</span></li>
		<li><img src="image/2.jpg" alt=""><span>瀑布流测试2</span></li>
		<li><img src="image/3.jpg" alt=""><span>瀑布流测试3</span></li>
		<li><img src="image/4.jpg" alt=""><span>瀑布流测试4</span></li>
		<li><img src="image/5.jpg" alt=""><span>瀑布流测试5</span></li>
		<li><img src="image/6.jpg" alt=""><span>瀑布流测试6</span></li>
		<li><img src="image/7.jpg" alt=""><span>瀑布流测试7</span></li>
		<li><img src="image/8.jpg" alt=""><span>瀑布流测试8</span></li>
		<li><img src="image/9.jpg" alt=""><span>瀑布流测试9</span></li>
		<li><img src="image/10.jpg" alt=""><span>瀑布流测试10</span></li>
		<li><img src="image/1.jpg" alt=""><span>瀑布流测试1</span></li>
		<li><img src="image/2.jpg" alt=""><span>瀑布流测试2</span></li>
		<li><img src="image/3.jpg" alt=""><span>瀑布流测试3</span></li>
		<li><img src="image/4.jpg" alt=""><span>瀑布流测试4</span></li>
		<li><img src="image/5.jpg" alt=""><span>瀑布流测试5</span></li>
		<li><img src="image/6.jpg" alt=""><span>瀑布流测试6</span></li>
		<li><img src="image/7.jpg" alt=""><span>瀑布流测试7</span></li>
		<li><img src="image/8.jpg" alt=""><span>瀑布流测试8</span></li>
		<li><img src="image/9.jpg" alt=""><span>瀑布流测试9</span></li>
		<li><img src="image/10.jpg" alt=""><span>瀑布流测试10</span></li>
	</ul>
</section>
</body>
</html>
```
##SCSS代码
```
@charset "UTF-8";
@import "reset.scss";

.piclist {
	margin: auto;position: relative;
	li {width: 180px;padding: 10px;border-radius: 5px;box-shadow: 0 0 4px #ddd;position: absolute;}
	img {display: block;width: 180px;}
	span {display: block;text-align: center;height: 26px;overflow: hidden;line-height: 26px;}
}
```
关于 reser.scss 初始文件。其实里面没啥，只是清除了默认样式而已。大家有兴趣，可以看一下我之前写的博文：http://blog.csdn.net/fungleo/article/details/48027493
页面宽度设置为100%
```
$WinWitdh:100%; 
```

##jquery 实战 第一回合

```
/*
	FengWaterFall.beta1.js
	这个版本基本实现了瀑布流的效果。但是其算法不是很优秀。
	当顺序操作到图片时，它不是找空白最大的一列，所以某些情况看上去会很怪。
	2015年10月15日 15:07:03
*/

$(function(){
	var Obj = $("#waterfall"),
		Ul = Obj.children('ul'),
		Li = Ul.children('li');
	waterfall();
	$(window).resize(function(event) {
		waterfall();
	});
	function waterfall(){
		var WinW = $(window).width();
		var Blank = 20,						// 每个图片之间的间隔留白
			LiW = 200+Blank,				// 一个图片距离上一个图片的宽度距离
			LiCol = parseInt(WinW/LiW),		// 计算在当前窗口下，有几列
			UlW = LiCol*LiW-Blank;			// 根据有几列，设定总的宽度（减掉最后一个留白）
		Ul.width(UlW);
		Li.each(function(i, e){
			var T = $(this),
				TCol = i%LiCol,				// 用求余数的方法获知当前图片为一行中的第几个
				TRow = parseInt(i/LiCol);	// 当前索引除以列数，并取整，得知为第几行
			/*
				取得位于当前图片上侧的图片元素
				获取这个元素本身的高度，和父元素顶部的距离，加上空格留白，得出当前图片距离顶部的距离。
			*/
			var PrevLi = Li.eq(i-LiCol),
				PrevLiSize = PrevLi.innerHeight()+PrevLi.position().top+Blank;

			TRow==0 ? Ttop = 0 : Ttop = PrevLiSize+'px';

			var Tleft = TCol*LiW+'px';
			T.css({
				top: Ttop,
				left: Tleft
			});
		});
	}
})
```
实现了第一个方法之后，通过预览效果，感觉算法不是很好。所以，开始勾勒第二版。

##jquery 实战 第二回合

```
/*
	FengWaterFall.beta2.js
	完美实现了瀑布流效果。其中使用的是for循环来查找索引。
*/

$(function(){
	var Obj = $("#waterfall"),
		Ul = Obj.children('ul'),
		Li = Ul.children('li');
	waterfall();
	$(window).resize(function(event) {
		waterfall();
	});
	function waterfall(){
		var WinW = $(window).width();
		var Blank = 20,						// 每个图片之间的间隔留白
			LiW = 200+Blank,				// 一个图片距离上一个图片的宽度距离
			LiCol = parseInt(WinW/LiW),		// 计算在当前窗口下，有几列
			UlW = LiCol*LiW-Blank;			// 根据有几列，设定总的宽度（减掉最后一个留白）
		Ul.width(UlW);

		var AllLi = [];						// 建立一个空数组变量
		Li.each(function(index, e){
			var T = $(this);
			if (index<LiCol) {						// 第一行的处理
				AllLi[index] = T.outerHeight();		// 给数组添加内容，为当前元素的高度值
				T.css({
					top: 0,
					left: LiW*index+'px'
				});
			} else{
				var MinH = Math.min.apply(null,AllLi);		// 找到数组中，最小的那个值（也就是留白最大的）

				// 通过 for 循环数组 找到最小的这个数字所在的索引值
				for (var i = 0; i < AllLi.length; i++) {
					if (AllLi[i] == MinH) {
						var MinI = i;
					};
				};

				var ThisH = T.outerHeight()+Blank; 			// 自身的高度加上留白

				AllLi[MinI] = parseInt(MinH+ThisH);			// 将被占位的数组重新赋值

				T.css({
					top: MinH+Blank+'px',
					left: LiW*MinI+'px'
				});
			};
		});

		// console.log(AllLi)
	}
})
```

第二个方法的逻辑是完全正确了。实现效果也是完美的。
不过for循环比较怪。jquery嘛，应该用jquery的方法来实现。

##jquery 实战 第三回合

```
/*
	FengWaterFall.beta3.js
	完美实现了瀑布流效果。jquery的each方法循环数组。但是被迫用了全局变量。
*/

$(function(){
	var Obj = $("#waterfall"),
		Ul = Obj.children('ul'),
		Li = Ul.children('li');
	waterfall();
	$(window).resize(function(event) {
		waterfall();
	});
	function waterfall(){
		var WinW = $(window).width();
		var Blank = 20,						// 每个图片之间的间隔留白
			LiW = 200+Blank,				// 一个图片距离上一个图片的宽度距离
			LiCol = parseInt(WinW/LiW),		// 计算在当前窗口下，有几列
			UlW = LiCol*LiW-Blank;			// 根据有几列，设定总的宽度（减掉最后一个留白）
		Ul.width(UlW);

		var AllLi = [];						// 建立一个空数组变量
		Li.each(function(index, e){
			var T = $(this);
			if (index<LiCol) {						// 第一行的处理
				AllLi[index] = T.outerHeight();		// 给数组添加内容，为当前元素的高度值
				T.css({
					top: 0,
					left: LiW*index+'px'
				});
			} else{
				var MinH = Math.min.apply(null,AllLi);		// 找到数组中，最小的那个值（也就是留白最大的）

				// 通过each 循环数组的方式，找到索引
				$.each(AllLi,function(index,value){
					if (value == MinH) {
						MinI = index;		// 因为 var 局部变量不能被用到下面去，所以用了全局变量
					};
				});

				var ThisH = T.outerHeight()+Blank; 			// 自身的高度加上留白

				AllLi[MinI] = parseInt(MinH+ThisH);			// 将被占位的数组重新赋值

				T.css({
					top: MinH+Blank+'px',
					left: LiW*MinI+'px'
				});
			};
		});

		// console.log(AllLi)
	}
})
```

##总结
这时候，我去看了一下别人是怎么写的。结果发现整体思路如出一辙。但是其查找索引的用法比我用for或者each循环要简单可靠得多。不过我还没有弄懂到底是怎么运作的。所以，就不做搬运工了。