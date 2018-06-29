title: javascript 数组以及对象的深拷贝（复制数组或复制对象）的方法
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -javascript
    -数组复制
    -对象深拷贝
    -数组深拷贝
    -对象复制
---

# javascript 数组以及对象的深拷贝（复制数组或复制对象）的方法
## 前言
在js中，数组和对象的复制如果使用`=`号来进行复制，那只是浅拷贝。如下图演示：
![](https://raw.githubusercontent.com/fengcms/articles/master/image/71/b4d56cd3ca2ad575b410b4790837c5.jpg)如上，`arr`的修改，会影响`arr2`的值，这显然在绝大多数情况下，并不是我们所需要的结果。
因此，数组以及对象的深拷贝就是`javascript`的一个基本功了。
## 数组的深拷贝
条条大道通罗马，实现数组的深拷贝，是有好几种方法的。举例如下：
### for 循环实现数组的深拷贝
for循环是非常好用的。如果不知道高级方法，通过for循环能够完成我们大多数的需求。
```js
var arr = [1,2,3,4,5]
var arr2 = copyArr(arr)
function copyArr(arr) {
	let res = []
	for (let i = 0; i < arr.length; i++) {
	 res.push(arr[i])
	}
	return res
}
```
如上，通过对数组的for循环，即可实现对数组的深拷贝了。
### slice 方法实现数组的深拷贝
这个代码实现非常简单。原理也比较好理解，他是将原数组中抽离部分出来形成一个新数组。我们只要设置为抽离全部，即可完成数组的深拷贝。代码如下：
```js
var arr = [1,2,3,4,5]
var arr2 = arr.slice(0)
arr[2] = 5
console.log(arr)
console.log(arr2)
```
运行结果如下：
![](https://raw.githubusercontent.com/fengcms/articles/master/image/a6/e22a9d89c8e9235fe0e0ca1406a73d.jpg)更多 `slice` 内容请访问 [w3school JavaScript slice 方法
](http://www.w3school.com.cn/jsref/jsref_slice_array.asp) 
### concat 方法实现数组的深拷贝
这个代码也非常简单，原理更加粗暴。它是用于连接多个数组组成一个新的数组的方法。那么，我们只要连接它自己，即可完成数组的深拷贝。代码如下：
```js
var arr = [1,2,3,4,5]
var arr2 = arr.concat()
arr[2] = 5
console.log(arr)
console.log(arr2)
```
运行结果如下：
![](https://raw.githubusercontent.com/fengcms/articles/master/image/25/bf4407fd7e44056c627bc2d8d5c719.jpg)更多 `concat` 内容请访问 [w3school JavaScript concat 方法
](http://www.w3school.com.cn/jsref/jsref_concat_array.asp) 

### 2017年10月31日补充：ES6扩展运算符实现数组的深拷贝

OK，以上之前讲的方法全部过时了，用下面的方法实现数组的深拷贝是最简单的。

```js
var arr = [1,2,3,4,5]
var [ ...arr2 ] = arr
arr[2] = 5
console.log(arr)
console.log(arr2)
```
运行结果如下：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/fe/03cf60d8a645c42b25df60c1975a3d.png)
## 对象的深拷贝
对象的深拷贝相比数组也没有困难许多，列举两个方法。
### 万能的for循环实现对象的深拷贝
在很多时候，for循环能够解决大问题。
```js
var obj = {
  name: 'FungLeo',
  sex: 'man',
  old: '18'
}
var obj2 = copyObj(obj)
function copyObj(obj) {
  let res = {}
  for (var key in obj) {
    res[key] = obj[key]
  }
  return res
}
```
### 转换成json再转换成对象实现对象的深拷贝
上面的代码实在是比较长，所以，用一个更暴力的方法吧！代码如下：

```js
var obj = {
  name: 'FungLeo',
  sex: 'man',
  old: '18'
}
var obj2 = JSON.parse(JSON.stringify(obj))
```
这个原理没什么好解释的，实在是够简单粗暴的啦！

### 2017年10月31日补充： 扩展运算符实现对象的深拷贝

```js
var obj = {
  name: 'FungLeo',
  sex: 'man',
  old: '18'
}
var { ...obj2 } = obj
obj.old = '22'
console.log(obj)
console.log(obj2)
```

运行结果如下：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/59/409177c94661ba3209d22384e6014b.png)

## 小结
数组和对象的深拷贝是js中最常见的应用。理解各种方法是必须的。希望对大家有所帮助。
本文中并没有对异常进行处理，主要在讲原理。更多的数组以及对象的操作方法，可以参考`lodash`的源码，查看它的源码可以让你的js基础变得非常牢固。我也在学习中。

> 2017年10月31日补充，使用es6提供的扩展运算符的方法实现深拷贝，简单，高效。并且，对象的深拷贝不会像使用 `JSON` 方法深拷贝一样，丢失函数等信息，只能用来深拷贝 `JSON` 数据格式的对象。推荐大家使用。

### 补充一个数组去重的方法

```js
function dedupe(array) {
  return [...new Set(array)]
}
var arr = [1,2,2,3,3,4,4,5,5]
console.log(dedupe(arr))
```

运行结果如下：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/78/a5ac63771e4ca0a089ea879a9708b3.png)
版权申明：本文由FungLeo原创，允许转载，但转载必须附注首发链接。谢谢。


