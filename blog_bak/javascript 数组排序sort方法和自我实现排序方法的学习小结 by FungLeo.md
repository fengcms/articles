title: javascript 数组排序sort方法和自我实现排序方法的学习小结 by FungLeo
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -javascript
    -数组排序
    -sort排序
    -for排序
    -数组复制
---

#前言

针对一个数组进行排序,一个很常见的需求.尤其在后端.当然,前端也是有这个需求的.

当然,数组排序,是有现成的方法的.就是`sort()`方法.

我们先开看下这个.

##标准答案,sort方法

```javascript
var arr = [45,98,67,57,85,6,58,83,48,18];
console.log('原数组');
console.log(arr);
console.log('sort方法从小到大排序');
console.log(arr.sort(function(a,b){return a-b}));
console.log('sort方法从大到小排序');
console.log(arr.sort(function(a,b){return b-a}));
```
运行结果如下:

![](https://raw.githubusercontent.com/fengcms/articles/master/image/ce/9602922195ffa9f3529d21bcac4720.jpg)
这里需要注意的是,`sort`默认是按照字母顺序来进行排序的.因此,我们在排列数字的时候,需要一个自定义函数.

如上面的代码

```javascript
function(a,b){return a-b}
```

这就是一个从小到大的排序函数.看上去好简单的样子,**但是我不理解**,所以,我根据我的想法,来实现排序吧~

##我的答案,for方法排序
```javascript
var arr = [45,98,67,57,85,6,58,83,48,18];
console.log('原数组');
console.log(arr);
console.log('for方法从小到大排序');
console.log(arrSortMinToMax(arr));
console.log('for方法从大到小排序');
console.log(arrSortMaxToMin(arr));
// 找数组中最小的值
function arrMinNum(arr){
	var minNum = Infinity, index = -1;
	for (var i = 0; i < arr.length; i++) {
		if (arr[i]<minNum) {
			minNum = arr[i];
			index = i;
		}
	};
	return {"minNum":minNum,"index":index};
}
// 返回数组从小到大排序结果
function arrSortMinToMax(arr){
	var arrNew = [];
	var arrOld = arr.concat();
	for (var i = 0; i < arr.length; i++) {
		arrNew.push(arrMinNum(arrOld).minNum);
		arrOld.splice(arrMinNum(arrOld).index,1)
	};
	return (arrNew);
}
// 找数组中最大的值
function arrMaxNum(arr){
	var maxNum = -Infinity, index = -1;
	for (var i = 0; i < arr.length; i++) {
		if (arr[i]>maxNum) {
			maxNum = arr[i];
			index = i;
		}
	};
	return {"maxNum":maxNum,"index":index};
}
// 返回数组从大到小排序结果
function arrSortMaxToMin(arr){
	var arrNew = [];
	var arrOld = arr.slice(0);
	for (var i = 0; i < arr.length; i++) {
		arrNew.push(arrMaxNum(arrOld).maxNum);
		arrOld.splice(arrMaxNum(arrOld).index,1);
	};
    console.log(arr)
	return (arrNew);
}
```
运行结果如下图所示
![](https://raw.githubusercontent.com/fengcms/articles/master/image/8e/d17642bf373be011a8877f44b56286.jpg)##我的方法中的知识点
1. 当一个函数需要返回多条数据的时候,使用json对象格式比较方便.如上面的`return {"minNum":minNum,"index":index};`
2. 如果使用 `var arrOld = arr` 这种方法来复制一个数组,并且,对`arrOld`进行操作的话,是会影响到`arr`这个原数组的.因为**javascript分原始类型与引用类型（与java、c#类似）。Array是引用类型。arrOld得到的是引用，所以对arrOld的修改会影响到arr。**
	1. 复制数组的方法(一)`var arrOld = arr.concat();` ,原理:`concat()`函数是用于拼接多个数组的函数,这种写法相当于拼接自己.也就是复制了.
	2. 复制数组的方法(二)`var arrOld = arr.slice(0)` , 原理:`slice()`函数是一个截取数组的函数,设置值为0,则是全部截取,相当于复制了.
3. `splice()`方法用于插入、删除或替换数组的元素。这里是使用了其删除数组中指定位置的特性.
4. 我的方法和`sort`方法的差异.
	1. 我的方法没有修改原数组,而sort是在原数组的基础上进行的修改.
	2. 我的方法返回的是一个新数组,原数组并没有消失或者改变.(好像和上面一句是一个意思....)
5. 排序是编程中非常非常基础并且非常非常重要的知识点.`sort`排序在执行大量数据的情况下,效率还是比较低的.当然,我的方法的效率也是很低的.

本文由FungLeo原创,允许转载.但转载必须署名作者,并保留文章首发链接.否则将追究法律责任. 
首发地址:http://blog.csdn.net/FungLeo/article/details/51555590