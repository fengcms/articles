title: javascript 判断数组中的重复内容的两种方法(修复BUG) by FungLeo
date: 2016-06-06 16:27:14 +0800
update: 2016-06-06 16:27:14 +0800
author: fungleo
tags:
    -javascript
    -数组重复
    -正则包含变量
    -FungLeo
---

#javascript 判断数组中的重复内容的两种方法 by FungLeo

##前言

2016年06月08日修复BUG

一般,我们可能会给数组去重,这个操作并不复杂,执行一个循环就是了.现在,我要做的是,判断数组中是否有重复的内容,如果有,返回 `true` 否则,返回 `false`.

**思路**

1. 把数组变成字符串
2. 循环原数组,拿每一个字段和这个字符串进行比对,看是否有重复

如何拿`A字符串`和`B字符串`进行对比,并且要求判断出`B字符串`中包含过个`A字符串`呢?

##方法一 indexOf() 和 lastIndexOf() 对比法.

首先,我们构建代码:

```javascript
var arr = ["aa","bb","cc","bb","aa"];
arrRepeat(arr);
```
如上,我们要用一个`arrRepeat(arr)`的校验函数并执行,下面来构建这个函数

```javascript
function arrRepeat(arr){
	var arrStr = JSON.stringify(arr);
	for (var i = 0; i < arr.length; i++) {
		if (arrStr.indexOf('"'+arr[i]+'"') != arrStr.lastIndexOf('"'+arr[i]+'"')){
			return true;
		}
	};
	return false;
}
```
OK,运行成功.
![](https://raw.githubusercontent.com/fengcms/articles/master/image/ad/67ae7fdbda8d0ab788fb9e94851042.jpg)
>原理特别简单,就是,数组中的字段,在由数组变成的字符串中的首次出现位置和最后一次出现位置是否一致,如果不一致,就说明这个重复出现了.

##方法二 match() 正则对比方法

首先,和上面一样,我们构建代码:

```javascript
var arr = ["aa","bb","cc","bb","aa"];
arrRepeat(arr);
```
然后,我们重新构建`arrRepeat(arr)`函数

```javascript
function arrRepeat(arr){
	var arrStr = JSON.stringify(arr);
	for (var i = 0; i < arr.length; i++) {
		if ((arrStr.match(new RegExp('"'+arr[i]+'"',"g")).length)>1){
			return true;
		}
	};
	return false;
}
```
> 原理是查找确定的重复次数,如果是大于1的话,就肯定是重复了.注意,这里是能够准确的查找出出现了几次的哦!所以,这个方法其实有更广泛的用途.

OK,运行又一次成功
![](https://raw.githubusercontent.com/fengcms/articles/master/image/09/4d401f202977b26c119fb168a1abf8.jpg)
##总结

1. 如果仅仅是比对第一个方法其实足够用了.
2. 第二个方法可以查找出现的真实次数,比如重复了4次,就能找到4.具体的用途自己思考咯.
3. 构建包含变量的正则的方法`new RegExp(arr[i],"g")`也是问别人才问出来的.
4. 其实我先想到的是第二个思路,正则的问题困扰半天,终于解决了.才想到第一个思路的.

本文由FungLeo原创,允许转载.但转载必须署名作者,并保留文章首发链接.否则将追究法律责任. 
首发地址:http://blog.csdn.net/FungLeo/article/details/51596404

##2016年06月08日修复BUG说明

之前考虑的代码没有考虑过数组内一个字段的内容包含另一个字段的内容的这种特殊情况，导致这样的情况下会判断数组是重复的，其实是没有重复的。

举个例子：

```javascript
var arr = ["a","aa"]
```

如这样的情况，原来的代码就会判断这个是重复的字段了。因此，新的代码加上了双引号，这样就避免了这个问题了。

或许大的项目中的一些BUG也是这样的原因产生的吧:)
