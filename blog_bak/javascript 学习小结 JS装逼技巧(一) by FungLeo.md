title: javascript 学习小结 JS装逼技巧(一) by FungLeo
date: 2016-05-11 21:47:10 +0800
update: 2016-05-11 21:47:10 +0800
author: fungleo
tags:
    -javascript
    -jquery
---

#javascript 学习小结 JS装逼技巧(一) by FungLeo

##前言

最近一直在做javascript方面的工作.但是本身我的javascript水平比较低,因此在学习过程中比较困难.而最近又接触到了很多的知识点.好记性不如烂笔头,因此写这篇零碎的博文,记一记我学到的一些好玩的东西.

##简单的新建各种元素

创建各种元素都有相对应的方法,例如,创建一个数组可以这样写`var arr = new Array` 当然,这样做是对的,但是我英文很烂,并且不喜欢这样的代码.我喜欢的是下面这样的.

```javascript
// 创建一个数组
var arr = [];
// 创建一个对象
var obj = {};
// 创建一个空字符串
var str = "";
```
不用记忆一个英文单词,做到了.

##用感叹号将非布尔值转化为布尔值

```javascript
var str = "abc";
console.log(!str);
```
输出
```javascript
false
```

感叹号可以把所有的东西都变成布尔值,如下图所示:
![](https://raw.githubusercontent.com/fengcms/articles/master/image/f9/d1dd3176b2fe973a3ba92a6bb367ab.jpg)
这样我们在进行一些数据判断的时候非常有用,而且代码特别简短.当然,你必须对这些将会转化成什么有了解.
当然,如果你需要将内容转换为相反的,则使用两个感叹号即可.

```javascript
var str = "abc";
console.log(!!str);
```
输出
```javascript
true
```

##双波浪号的妙用(将内容转化为数字,或者小数取整)

这是最近看到的一段经典的代码里面学到的知识.这个用来装逼非常的合适.而实际上在使用中也会非常好用.

```javascript
var str = "123.123";
console.log(~~str);
```
输出
```javascript
123
```
如上,可以看到,使用双波浪号可以将字符串转化为数字,并且取整.

它的各种妙用如下图所示:
![](https://raw.githubusercontent.com/fengcms/articles/master/image/63/8f16608571c8e098060e5ef1837463.jpg)
如上图所示,波浪号可以将各种东西都转化为数字,为0或者-1.

需要注意的是,~~双波浪号的取整是直接去掉小数点后的小数,而并不是采用的四省五入的计算.

##解决jquery ajax调用远程接口的跨域问题

首先,接口必须允许远程调用.这是后端或者运维的事情.你必须保证你得到的一个接口是允许远程调用的.否则,就没啥了.

好,我们来看下如何解决
```javascript
$.ajax({
    type:'get',
    url:url,
    // 下面的两行代码,就是解决跨域的关键
    xhrFields: {withCredentials: true},
    crossDomain: true,
    // 就是上面的两行代码
    success: function(data){
    	// do something
    },
    error: function(data){
        // do something
    }
});
```

对于get 或者 post 均有效果的哦!
> 不要问我为什么,我只会用~

##利用jquery 创建 json 数据

首先,我想到的居然是字符串拼接的方法.被别人看到后笑话了半天,说你是真够笨的.
哎,没办法,谁叫我基础差呢.经过一番请教,终于知道怎么创建json数据是最方便的.

第一步,创建一个对象.
第二部,往对象里面写值.
第三步,将对象转化为json数据.

具体怎么做,看下图吧!

![](https://raw.githubusercontent.com/fengcms/articles/master/image/43/528fbbeba4835e2f23c94b8b0813e0.jpg)
关键代码如下:

```javascript
var obj = {};
JSON.stringify(obj);
```
##字符串截取

这个比较常用.但是我每次都需要从搜索引擎来找这个单词.就是`substring(0,1)`;

```javascript
var str = "abcdefg";
str.substring(str.length-1,str.length);
```
如上面这段代码,就会截取最后一位的字符.

字符串的截取很多地方都需要使用,例如url的截取.要善用各种组合,灵活运用,才能用得更好.

##数字保留小数点后N位

这个是比较常见的一种需求.例如,我们在计算一个数值,而这个数值很明显是一个很长的小数.那么我们在使用中就很有比较需要保留几位小数,然后使用.

怎么做呢?下面是我的做法:

```javascript
var num = 10 / 3;
~~(num*10000)/10000;
```

返回

```javascript
3.3333
```

这里,是不采用四省五入的方法的.如果需要四省五入,将`~~`替换成 `Math.round` 即可.

##创建一个随机整数

举个例子,我们需要创建一个0-100以内的随机整数.
```javascript
var randNum = ~~(Math.random()*100);
```

这样,我们就创建了一个随机数了.

##尽量少的去操作DOM结构

举个例子,我们可能经常会做的就是三级联动的省市县代码.而下拉菜单很显然需要我们去操作DOM结构.

下面是一个不良的示范.

```javascript
var $obj = $("#obj");
var data = [{"id":0,"name":"a"},{"id":1,"name":"b"}];
for (var i = 0; i < data.length; i++) {
	$obj.append('<option value="'+data[i].id+'">'+data[i].name+'</option>');
};
```
如上,有一条数据,就需要操作一次DOM,这样很浪费资源.虽然解决了问题.但是我不推荐这么做.同样的功能,我会这样来实现:
```javascript
var $obj = $("#obj");
var data = [{"id":0,"name":"a"},{"id":1,"name":"b"}];
var tempStr = "";
for (var i = 0; i < data.length; i++) {
	tempStr +=('<option value="'+data[i].id+'">'+data[i].name+'</option>');
};
$obj.html(tempStr);
```
如上,先把所有的结果全部放到一个临时字符串内.最后,再一次性把结果给插入到DOM中,这样,就只执行了一次DOM结构.性能就会大大提升了.

##小结

1. 命名一定要规范,不要尝试使用别人看不懂的命名.有时候,好的命名胜过一切.
2. 如果逻辑很复杂,尝试把复杂的逻辑拆解成一个一个的小逻辑,这样能够更加好的解决问题和排查问题.
3. 先用最笨的方法把效果实现了,然后再考虑优化代码.一开始就考虑太多,会发现问题很难解决,尤其是像我这样的初学者.
4. 一定要写注释!!!!
5. 耐心,遇到问题抽根烟,好好想一想.
6. 除非是很难,并且结果非常确定,并且搜索引擎解决不了.否则不要去群里问人.
7. 在群里讨论概念完全是浪费时间.

本文由FungLeo原创,允许转载.但转载必须署名作者,并保留文章首发链接.否则将追究法律责任.
首发地址:http://blog.csdn.net/FungLeo/article/details/51378593