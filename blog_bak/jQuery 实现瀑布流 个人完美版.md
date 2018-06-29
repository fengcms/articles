title: jQuery 实现瀑布流 个人完美版
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -jquery
    -瀑布流
---

前面已经通过这种方式实现过瀑布流了。看到慕课网上有一个类似的视频教程，就仔细看了一下。就大体实现思路来说，基本是没差的。但是就实现方法来说，慕课网上的教程（http://www.imooc.com/learn/101）我感觉还是繁琐冗余了。尤其是javascript原生实现方法。
但其jquery方法，我还是学到一点的。就是如何查找数值在数组中的索引。
## html+css结构
查看：http://blog.csdn.net/fungleo/article/details/49179611

## jQuery实现瀑布流

```
$(function(){
	var Obj = $("#waterfall"),
		Ul = Obj.children('ul'),
		Li = Ul.children('li');
	$(window).load(function(event) {
		waterfall();
	});
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
				var MinI = $.inArray(MinH,AllLi);			// 通过 $.inArray 查找数值在数组中的索引
				var ThisH = T.outerHeight()+Blank; 			// 自身的高度加上留白

				AllLi[MinI] = parseInt(MinH+ThisH);			// 将被占位的数组重新赋值

				T.css({
					top: MinH+Blank+'px',
					left: LiW*MinI+'px'
				});
			};
		});
	}
})
```

效果预览地址：http://sandbox.runjs.cn/show/zwqw5o2d
这个是原生js的效果。jquery的和他一样。