title: javascript 学习小结 (二)新增小数取整各种方法 by FungLeo
date: 2016-05-20 14:30:35 +0800
update: 2016-05-20 14:30:35 +0800
author: fungleo
tags:
    -javascript
    -FungLeo
    -js学习小结
---

#javascript 学习小结 (二) by FungLeo

##前言
前面写过一个学习小结[javascript 学习小结 JS装逼技巧(一) by FungLeo](http://blog.csdn.net/fungleo/article/details/51378593) 那篇博文总结的东西还是比较多的.

但是JS有很多的内容,都是很有用的知识点,不可能一下子记住.因此,我的学习小结的会一直更新.

因为学习进度的不同,可能每篇博文的长短也不一样,有的学的东西多,就长点.

##查询某个字符串在某个数组中的索引值

**笨方法**

我的基础比较差,所以很多东西是记不住的.因此,我在需要这样做的时候,我写了如下代码

```javascript
var arr = ["a","b","c","d"];
var str = "b";
var index = 0;
for (var i = 0; i < arr.length; i++) {
	if (arr[i] == str){
		index = i;
	};
};
```

虽然写出来了,但是感觉这段代码还是脱裤子放屁的.问了下别人,别人回答我`indexOf`;

**indexOf方法**
```javascript
var arr = ["a","b","c","d"];
var str = "b";
var index = arr.indexOf(str);
```

这样写果然简单多了.

##替换字符串中的某个字符串内容

**替换第一个匹配字符串**

```javascript
var oldStr = "hi boy! hi girl!";
var newStr = "";
newStr = oldStr.replace("hi","hello");
console.log(newStr);
```
这样只能替换第一个,但是,我可能需要替换所有的.用这个方法就不行了.

**替换所有的匹配字符串**

```javascript
var oldStr = "hi boy! hi girl!";
var newStr = "";
newStr = oldStr.replace(/hi/g,"hello");
console.log(newStr);
```
这种方式是使用正则表达式的方式替换 g 代表全局替换

如果,替换的内容中是包含斜杠的,那么就需要加一个反斜杠来进行转义
```javascript
var oldStr = "<div><span></span></div>";
var newStr = "";
newStr = oldStr.replace(/<span><\/span>/g,"hello");
console.log(newStr);
```
如这个例子所示

##小数取整的各种方法

1.丢弃小数部分,保留整数部分
```javascript
parseInt(5/2)
```
2.向上取整,有小数就整数部分加1
```javascript
Math.ceil(5/2)
```
3,四舍五入.
```javascript
Math.round(5/2)
```
4,向下取整
```javascript
Math.floor(5/2)
```

>**Math 对象的方法**
>|方法|说明|
>|-
>|abs(x)|返回数的绝对值|
|acos(x)|返回数的反余弦值|
|asin(x)|返回数的反正弦值|
|atan(x)|以介于 -PI/2 与 PI/2 弧度之间的数值来返回 x 的反正切值|
|atan2(y,x)|返回从 x 轴到点 (x,y) 的角度（介于 -PI/2 与 PI/2 弧度之间）|
|ceil(x)|对一个数进行上舍入。|
|cos(x)|返回数的余弦|
|exp(x)|返回 e 的指数。|
|floor(x)|对一个数进行下舍入。|
|log(x)|返回数的自然对数（底为e）|
|max(x,y)|返回 x 和 y 中的最高值|
|min(x,y)|返回 x 和 y 中的最低值|
|pow(x,y)|返回 x 的 y 次幂|
|random()|返回 0 ~ 1 之间的随机数|
|round(x)|把一个数四舍五入为最接近的整数|
|sin(x)|返回数的正弦|
|sqrt(x)|返回数的平方根|
|tan(x)|返回一个角的正切|
|toSource()|代表对象的源代码|
|valueOf()|返回一个 Math 对象的原始值|

##小结

很多的基础知识不牢固,需要认证仔细的学习.希望与大家多多交流.

本文由FungLeo原创,允许转载.但转载必须署名作者,并保留文章首发链接.否则将追究法律责任.
首发地址: http://blog.csdn.net/FungLeo/article/details/51461420