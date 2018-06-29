title: javascript 自己实现数字\字母和中文的混合排序方法 by FungLeo
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -javascript
    -数字排序
    -字母排序
    -中文排序
---

#javascript 自己实现数字\字母和中文的混合排序方法(纯粹研究,不实用)

##前言

在上一篇博文《[javascript 数组排序sort方法和自我实现排序方法的学习小结](http://blog.csdn.net/fungleo/article/details/51555590)》中,我用自己的方法实现了数字数组的排序.

当然,实际运用中,我还是会使用`sort`方法更加方便.但是,我上一篇博文,仅仅是实现了数字排序,而`srot`方法默认可是能给字母实现排序的哦!而我的代码只能排序数字,看起来还是弱弱的.

所以,我得加上能排字母甚至中文的排序方法.

##实现代码

```javascript
$(function(){
	var arr = ["Jack","Book","Fung",76,"Love","Mark","中国","china","phone","刘德华"];
	console.log('原数组');
	console.log(arr);
	console.log('for方法从小到大排序');
	console.log(arrSortMinToMax(arr));
	console.log('for方法从大到小排序');
	console.log(arrSortMaxToMin(arr));
	console.log('原数组');
	console.log(arr);
});

function arrMinNum(arr){
	var minNum = Infinity, index = -1,minVul = "";
	for (var i = 0; i < arr.length; i++) {
		if (typeof(arr[i]) == "string") {
			if (arr[i].charCodeAt()<minNum) {
				minNum = arr[i].charCodeAt();
				minVul = arr[i];
				index = i;
			}
		}else {
			if (arr[i]<minNum) {
				minNum = arr[i];
				minVul = arr[i]
				index = i;
			}
		}
	};
	return {"minNum":minVul,"index":index};
}
function arrSortMinToMax(arr){
	var arrNew = [];
	var arrOld = arr.concat();
	for (var i = 0; i < arr.length; i++) {
		arrNew.push(arrMinNum(arrOld).minNum);
		arrOld.splice(arrMinNum(arrOld).index,1)
	};
	return (arrNew);
}
function arrMaxNum(arr){
	var maxNum = -Infinity, index = -1,maxVul = "";
	for (var i = 0; i < arr.length; i++) {
		if (typeof(arr[i]) == "string") {
			if (arr[i].charCodeAt()>maxNum) {
				maxNum = arr[i].charCodeAt();
				maxVul = arr[i];
				index = i;
			}
		}else {
			if (arr[i]>maxNum) {
				maxNum = arr[i];
				maxVul = arr[i];
				index = i;
			}
		}
	};
	return {"maxNum":maxVul,"index":index};
}
function arrSortMaxToMin(arr){
	var arrNew = [];
	var arrOld = arr.slice(0);
	for (var i = 0; i < arr.length; i++) {
		arrNew.push(arrMaxNum(arrOld).maxNum);
		arrOld.splice(arrMaxNum(arrOld).index,1);
	};
	return (arrNew);
}
```
运行截图如下:

![](https://raw.githubusercontent.com/fengcms/articles/master/image/11/08e9ed3de9c4ff281aeded8691e58a.jpg)
##排序原理

1. 如果是数字,则直接是数字进行比对
2. 如果是字符串,则使用`charCodeAt()`转换成`Unicode`编码进行排序.
3. `Unicode` 是 0 - 65535 之间的整数

##其他说明

1. 按照正常的排序逻辑,应该是:**数字比一切字母都小,字母比一切中文都小,中文应该按照首字拼音的首字母排序**.
2. 我的这段代码除了**字母比一切中文都小**这一条实现了,其他都没有实现.
3. 逻辑也应该可以实现,把数字字母中文分别找出来,数字跟数组进行比较,字母跟字母比较,中文跟中文比较,然后拼接数组
4. 中文获取首字的首字母可能稍微麻烦一点.

##汉字居然可以直接比对的.

![](https://raw.githubusercontent.com/fengcms/articles/master/image/0b/24e6ca1e0f5e9d79162cabcafd9d8d.jpg)
如上图所示,张飞想要做老大是有道理的.`javascript`终于在千年之后为张飞正名,当年他就应该是做老大的!~

本文由FungLeo原创,允许转载.但转载必须署名作者,并保留文章首发链接.否则将追究法律责任. 
首发地址:http://blog.csdn.net/FungLeo/article/details/51583344