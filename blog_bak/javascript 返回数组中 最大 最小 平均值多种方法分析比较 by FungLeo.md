title: javascript 返回数组中 最大 最小 平均值多种方法分析比较 by FungLeo
date: 2016-05-26 13:42:27 +0800
update: 2016-05-26 13:42:27 +0800
author: fungleo
tags:
    -javascript
    -数组最大值
    -数组平均值
    -数组最小值
    -FungLeo
---

#javascript 返回数组中 最大 最小 平均值多种方法分析比较 by FungLeo

##前言

一组数字中全部是数字,我们需要返回数组中最大或者最小的数字,这是常见的需求.当然,求数组中所有数字的平均值,也是一个很常见的需求.今天我学习的内容就是,来实现这些.

##我自己的方法 for循环

看过我博文的朋友应该知道,我的JS水平是很一般的.因此,我只能从我比较能够理解的角度来实现这个问题.简单来说,for循环是我最理解的内容.因此,我用下面的代码实现了这个功能.

```javascript
function arrMaxNum(arr){
	var maxNum = -Infinity;
	for (var i = 0; i < arr.length; i++) {
		arr[i]>maxNum ? maxNum =arr[i] : null;
	};
	return maxNum;
}

function arrMinNum(arr){
	var minNum = Infinity;
	for (var i = 0; i < arr.length; i++) {
		arr[i]<minNum ? minNum =arr[i] : null;
	};
	return minNum;
}
function arrAverageNum(arr){
	var sum = 0;
	for (var i = 0; i < arr.length; i++) {
		sum += arr[i];
	};
	return ~~(sum/arr.length*100)/100;
}
```

代码如上.原理非常简单.例如,找最大的数字,就先设定一个负无穷的数字,然后在数组中找,只要数组中有一个数字比负无穷大,那么就取它.一直循环到结束,然后,返回最终得到的数字.找最小的则反过来.

求平均值则是先求和,然后除以数组的长度.因为有除法,所以很可能得到一个很长的小数.因此再保留小数点后两位.

优点: 简单,快,不会出错

缺点: 代码不够简练

##别人的方法一 Math方法

```javascript
function arrMaxNum2(arr){
	return Math.max.apply(null,arr);
}
function arrMinNum2(arr){
	return Math.min.apply(null,arr);
}
function arrAverageNum2(arr){
	var sum = eval(arr.join("+"));
	return ~~(sum/arr.length*100)/100;
}
```

代码如上.果然简短了很多.

`Math.max.apply(null,arr)` 这段代码同事给我解释过,我大概其能够理解,但是我不能阐述其具体的原理.

就属于会用,但是不是很明白其中原理的方法.不过还好,看字面也能猜出大概.实在不行复制粘贴呗.

但是`eval(arr.join("+"))`这段代码把我给看蒙了.立即百度搜索 `eval` 最终搞明白了是怎么回事.

首先,`arr.join("+")`会将数字中的所有数字进行用加号间隔,然后返回一个**字符串**,而这个**字符串**看上去就是一个算数表达式.

`eval`这个函数,则是会把**字符串**形式的算数表达式给==计算==出来!!

神一样的逻辑.....

优点:代码短
缺点:当数组内的数字足够多,数字足够大,则会出错.
我现在不确定其是在一个什么样指定的数字会出错.但是,看图不解释:
![](https://raw.githubusercontent.com/fengcms/articles/master/image/c9/db98e9b2cba9c0fa81eb2db17fb76d.jpg)
##别人的方法二 给数组绑定方法

此处为转载于别人的代码,原文地址:[js获取数组最大值、最小值和平均数代码实例](http://www.softwhy.com/forum.php?mod=viewthread&tid=13263)

文章代码如下:

```javascript
function cacl(arr, callback) {
	var ret;
	for (var i=0; i<arr.length;i++) {
		ret = callback(arr[i], ret);
	}
	return ret;
}

Array.prototype.max = function () {
	return cacl(this, function (item, max) {
		if (!(max > item)) {
			return item;
		}
		else {
			return max;
		}
	});
};
Array.prototype.min = function () {
	return cacl(this, function (item, min) {
		if (!(min < item)) {
			return item;
		}
		else {
			return min;
		}
	});
};
Array.prototype.sum = function () {
	return cacl(this, function (item, sum) {
		if (typeof (sum) == 'undefined') {
			return item;
		}
		else {
			return sum += item;
		}
	});
};
Array.prototype.avg = function () {
	if (this.length == 0) {
		return 0;
	}
	return this.sum(this) / this.length;
};

var theArray=[1,-2,4,9,15];
console.log(theArray.max());
console.log(theArray.min());
console.log(theArray.sum());
console.log(theArray.avg());
```

这段代码用`prototype`给数组加上了几个方法,然后用这几个方法就能够很方便的实现所需要的功能.

并且这使用了回调函数的 `cacl(arr, callback)` 的设计,整个代码的设计非常优雅,由此可见作者深厚的JS功力.

当然,这其中,也是使用了for循环的方法实现的.因此,应该不存在上面第二种方法的出错的情况.

反正这是一段很值得玩味的代码.

##总结

1. 实现所需要的功能,有简单粗暴的方法.如我的代码.
2. 或者使用程序的一些高级功能去实现,如第二种方法.
3. 使用高级的方法可能有未知的风险,一定需要对这种方法有深刻的理解.
4. 让代码变得优雅,需要更加高的视野,更加细致的规划.
5. 每一天都进步.尽快让自己的JS水平提升到主流.

本文由FungLeo原创,允许转载.但转载必须署名作者,并保留文章首发链接.否则将追究法律责任.
首发地址: http://blog.csdn.net/FungLeo/article/details/51506640