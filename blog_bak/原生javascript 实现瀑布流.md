title: 原生javascript 实现瀑布流
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -javascript
    -瀑布流
---

#前言
刚用 jquery 实现了瀑布流效果。但是其实现方法，我并不满意，所以我还在思考，如何更加简单明了的实现瀑布流效果。与其缠绕在 jquery 里，不如直接跳到 javascript 原生方法里。

让我们抛开 jquery，忘掉各种高级方法，用最原始的方法去实现 瀑布流效果。

##html+scss
html 以及 scss 均在 http://blog.csdn.net/fungleo/article/details/49179611 页面。这里不再赘述。

##javascript版本的瀑布流
代码原理已经写在注释里了。不再重复
```
/*
	瀑布流原生 javascript 实现方法
	之前已经用 jquery 方法已经实现了瀑布流。
	但是我决定再用 javascript的方法再实现一次。
	另外，我一直不理解 Math.min.apply(null,AllLi) 这一句代码。
	虽然高人解释给我听后，大概其明白。但感觉应该有更简单的方法来实现。
	于是，我真的实现了 *^0^*
	--------------
	无论是 jquery 还是原生 js for 循环都是一个非常重要的用法
	只要打开脑洞，就会有更加异想天开的解决方法
*/
/* 常用js方法开始 */
var _doc = document,
	_win = window;

// getId(IdName) / 获取ID 方法
function GetId(IdName){
	return _doc.getElementById(IdName);
}

// GetTag(Fathers,TagName) / 获取 tagname 方法
function GetTag(Fathers,TagName){
	return Fathers.getElementsByTagName(TagName);
}
/* 常用js方法结束 */

// 通过常用方法，找到需要处理的元素
var _obj = GetId("waterfall"),
	_ul = GetTag(_obj,"ul"),
	_li = GetTag(_obj,"li");

// 瀑布流函数
function WaterFall(){
	var _blank = 20,						// 瀑布流间距
		_liW = 200 + _blank,				// 每列宽度
		_winW = _win.outerWidth,			// 窗口宽度
		_row = parseInt(_winW/_liW),		// 得到最多放几列
		_ulW = _row * _liW - _blank + 'px';	// 算出 ul 的宽度

	_ul[0].style.width = _ulW;				// 设定ul的宽度

	var _arr = []; 							// 和jquery 版本一样，建立一个空数组

	// 开始循环每一个 li
	for (var i = 0; i < _li.length; i++) {
		if (i<_row) {								// 第一行的处理

			_li[i].style.top = 0;
			_li[i].style.left = i*_liW + 'px';
			_arr[i] = _li[i].offsetHeight;			// 将自身的高度，写入数组

		}else{

			var _minH = +Infinity,					// 最小高度变量，默认为无穷大
				_minI;								// 空变量，用来存最小高度数组的 key 值

			// 循环由第一行每个li的高度组成的数组
			for (var j = 0; j < _arr.length; j++) {

				if (_arr[j]<_minH) {				// 如果当前数组的值小于上面设定的_minH
					var _minH = _arr[j],			// 则将 _minH 变量写成当前数组的值 （通过循环，能找到最小值）
						_minI = j;					// 将最小值的 key 值写入到 _minI
				};
			};

			_li[i].style.top = _minH +_blank + 'px';
			_li[i].style.left = _minI * _liW + 'px';

			// 将数组中最小的值，加上这个 li 的高度和留白，得出的值存入数组
			_arr[_minI] += _li[i].offsetHeight + _blank;

		};
	};
}

// 加载完成后执行
window.onload = function() {
	WaterFall();
};
// 窗口变化时执行
window.onresize = function() {
	WaterFall();
};

```

##总结

通过改变思路，不再寻求直接的解决方法，而是通过自己构造原生方法，来实现需要的效果。则能够更加简单明了的实现问题，提高智力获胜的愉悦。

如，在jquery版本中，我一直在找，如何找到数组中最小值的方法。最后通过百度得到一个`Math.min.apply(null,AllLi)`的方法。虽然做到了。但真的不要问我，是什么原理做到的。我根本不知道。

但是，在原生JS中，我用默认最小值为无穷大，`var _minH = +Infinity` 然后拿数组中的数字来和这个无穷大进行对比，如果这个数字比无穷大小，则将`_minH`赋值为当前数组的值，然后再拿下一个数组中的数字来进行对比。通过循环，一定能找到数组中的最小值。

这个方法原理清晰，更能获得智力愉悦！

然后，顺便将数组的key值也给获取到了。而在我自己的` jquery `版本中，我还不得不再 `for` 循环一次数组，来找到这个 key 值。

当然，也可以通过`indexOf`方法来获取。不过，这个方法低版本ie是不支持的。

最终，我通过上面的方法，一石二鸟，简单明了的实现了方法。

好了。明天再利用这个方法，把 jquery 版的代码再经过优化。应该就更简单了！

FungLeo
2015.10.16