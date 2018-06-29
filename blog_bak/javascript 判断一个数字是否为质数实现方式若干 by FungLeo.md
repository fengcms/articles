title: javascript 判断一个数字是否为质数实现方式若干 by FungLeo
date: 2016-05-23 18:37:03 +0800
update: 2016-05-23 18:37:03 +0800
author: fungleo
tags:
    -javascript
    -质数
    -FungLeo
---

#javascript 判断一个数字是否为质数实现方式若干 by FungLeo

##前言

今天看到一个题目,让判断一个数字是否为质数.看上去好像不难.因此,我决定实现一下.

##DOM结构

```html
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>计算500以内的质数并输出</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
	<script src="http://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"></script>
</head>
<body>
	<div class="echo">
		<input type="text" id="num" value="">
		<input type="button" id="submit" value="提交">
	</div>
</body>
</html>
<script>
$(function(){
	$("#submit").on('click',function(){
		var num = $("#num").val();
		if (isPrimeNum(num)) {
			alert(num+"是质数");
		}else{
			alert(num+"是合数");
		}
	});
});
</script>
```
如上所示,我们通过 `isPrimeNum(num)` 函数,来实现判断是否为质数.下面我们来实现这个函数.

##通过FOR循环来判断是否为质数

```javascript
function isPrimeNum(num){
	for (var i = 2; i < num; i++) {
		if (num%i==0){
			return false;
		}
	};
	return true;
}
```
原理比较简单,通过2以上的数字不断和目标数字求余数,如果能得到0,就表示这是一个合数而不是质数.

不过这个运算量好像有点大

##优化一下第一个方法

很简单嘛,一下子就实现了.但是,好像可以优化一下.我们好像不必一直追到这个数字去求余数,我们好像只需要循环到这个数的一半,就可以计算出来这个数字是不是质数了.

```javascript
function isPrimeNum(num){
	for (var i = 2; i < num/2+1; i++) {
		if (num%i==0){
			return false;
		}
	};
	return true;
}
```
经过实测,速度确实大为提升,但是,我知道,数字尾数为双数,或者为5,那么肯定不是质数,因此没必要去计算.我们再来优化一下

##不计算数字尾数为双数或者5的数字

```javascript
function isPrimeNum(num){
	if (!isDual(num)){
		return false;
	}
    for (var i = 2; i < num/2+1; i++) {
		if (num%i==0){
			return false;
		}
	};
	return true;
}
function isDual(num){
	var num = num.toString();
	var lastNum = num.substring(num.length-1,num.length);
	return lastNum%2 == 0 || lastNum%5 == 0 ? false : true;
}
```
通过这样的优化,我们可以再减小运算量了,至少减少一大半数字哦.(但是实测提升性能一般,因为这样的数字,能够很快的判断出来不是质数)

>这里`substring()`函数发现,不能用在数字上,只能用在字符串上.悲催,因此先把数字变成了字符串.

##如果不是数字或者整数的处理

如果用户输入的不是数字,或者是一个小数,怎么办呢?我迅速的写了两个方法来进行处理...

```javascript
function isPrimeNum(num){
	if (!isNum(num)){
		return false;
	}
	if (!isInteger(num)){
		return false;
	}
	if (!isDual(num)){
		return false;
	}
    for (var i = 2; i < num/2+1; i++) {
		if (num%i==0){
			return false;
		}
	};
	return true;
}
function isInteger(num){
	return num == ~~num ? true : false;
}
function isNum(num){
	return num == +num ? true : false;
}
function isDual(num){
	var num = num.toString();
	var lastNum = num.substring(num.length-1,num.length);
	return lastNum%2 == 0 || lastNum%5 == 0 ? false : true;
}
```
这里用了两个小技巧,一个是小数取整`~~num`,一个是字符串转数字.`+num`.

了解更多请阅读我之前的博文《[javascript 学习小结 JS装逼技巧(一) by FungLeo](http://blog.csdn.net/fungleo/article/details/51378593)》

这并没有提高什么效能,只是免去了计算错误输入.我们再想一下,有没有什么快速判断不是质数的方法呢?

##去除能被3整除的数字不计算

```javascript
function isPrimeNum(num){
	if (!isNum(num)){
		return false;
	}
	if (!isInteger(num)){
		return false;
	}
    if (num==2||num==3||num==5) {
		return true;
	}
	if (!isDual(num)){
		return false;
	}
	if (!isThree(num)){
		return false;
	}
	for (var i = 2; i < num/5+1; i++) {
		if (num%i==0){
			return false;
		}
	};
	return true;
}
function isInteger(num){
	return num == ~~num ? true : false;
}
function isNum(num){
	return num == +num ? true : false;
}
function isDual(num){
	var num = num.toString();
	var lastNum = num.substring(num.length-1,num.length);
	return lastNum%2 == 0 || lastNum%5 == 0 ? false : true;
}
function isThree(num){
	var str = num.toString();
	var sum = 0;
	for (var i = 0; i < str.length; i++) {
		sum += +str.substring(i,i+1);
	};
	return sum%3 == 0 ? false : true;
}
```
这里,我们先把数字变成字符串,然后把字符串每一位都分拆出来,并且相加求和,拿结果和3求余,就能得出这个数字是否能被3整除了.

哈哈我真聪明...实测性能貌似并没有提高很多,但确实提高了一些的.有点小郁闷

但是,如果排除了3整除的数字,那么,我们就完全没必要计算到一半啦,我们完全没必要计算到一半,只需要计算到三分之一就好啦.另外,我们也排除了5,那么只要计算到五分之一就好啦....

迅速调整后,果然效率大大提升啊!!!!我威武...

> 但是,这样在 2\3\5 三个质数,代码会判断是合数,所以,需要再补上一句
> `if (num==2||num==3||num==5) {return true;}`

##别人的方法

然后我就想不到优化的方法啦...于是,我就搜索了一下,找到下面的解决方法,我惊呆了!!!!!
```javascript
function isPrimeNum2(num){
	return !/^.?$|^(..+?)\1+$/.test(Array(num + 1).join('1'))
}
```
使用的是正则的方法,果然是简短啊,但是我毛线也看看懂呀!!!

我对能写出这样代码的人表示拜服!!

我实在是搞不懂这是啥原理,我于是实测了一下,发现,我的代码效率远远高于这段代码.由此可见,我的方法还是很优秀的嘛!!

我的代码打印100000以内的所有质数需要1600ms 而这段代码需要160000ms 也就是说,我的代码只要百分之一的时间就可以了.

不过,谁能看懂这段代码请帮我解释一下....

##总结

1. 一个小的题目,可能会用到很多的知识点,所以,有空的时候可以多练习这样的题目
2. 装逼的方法不一定好 :)
3. 我居然看不懂别人装的逼 -_-|||

本文由FungLeo原创,允许转载.但转载必须署名作者,并保留文章首发链接.否则将追究法律责任.
首发地址: http://blog.csdn.net/FungLeo/article/details/51483844

##2016-05-25补充

看了一些相关的资料,好像我上面用`num/5`的方式貌似不太好(结果并不是错误的).有一个更好的方式,就是使用`Math.sqrt(num)`求平方根的方式.

**我的代码的测试结果如下**

![](https://raw.githubusercontent.com/fengcms/articles/master/image/d7/1e64ae83eb3ab0fdec61ca6bd791fa.png)
如上图所示,我的代码的计算结果是完全正确的哦.但是用时是1638毫秒.经过多次测试依然是这样.

**求平方根方式测试结果如下**

![Math.sqrt(num)求平方根方式](http://img.blog.csdn.net/20160525093919658)

如上图所示,用这个方式更加科学,速度更快,多次测试,用时在1150毫秒到1250毫秒之间.相比我的代码性能提升大约25%.

**去除我的优化代码之后的测试结果**

我又是判断位数是否是双数或者5的,又是判断加起来能不能被3整除的,折腾半天.我肯定是期望减少运算量的.但是这些代码本身也是有运算量的.我把我的代码都去除掉之后再看下

![](https://raw.githubusercontent.com/fengcms/articles/master/image/94/32e1908d9c71940acdce82f7e2748e.png)
性能又得到了提升啊,看来我的那些计算全部都是负优化啊!

最终,代码如下:
```javascript
function isPrimeNum(num){
	if (!isNum(num)){
		return false;
	}
	if (!isInteger(num)){
		return false;
	}
	for (var i = 2; i <= Math.sqrt(num); i++) {
		if (num%i==0){
			return false;
		}
	};
	return true;
}
function isInteger(num){
	return num == ~~num ? true : false;
}
function isNum(num){
	return num == +num ? true : false;
}
```
>小结:完全是我算术不好导致我在前面各种自作聪明.不过,练练小技巧也是好的-_-|||

**最后看下计算100万以内的所有质数需要多长时间**

![](https://raw.githubusercontent.com/fengcms/articles/master/image/28/360290620812886202d912acbea224.png)
>电脑太差不要尝试过大数字,电脑再好也不要在IE下尝试....