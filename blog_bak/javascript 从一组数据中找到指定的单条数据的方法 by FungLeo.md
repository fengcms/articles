title: javascript 从一组数据中找到指定的单条数据的方法 by FungLeo
date: 2016-06-01 14:05:29 +0800
update: 2016-06-01 14:05:29 +0800
author: fungleo
tags:
    -javascript
    -json
    -数据
---

#从一组数据中找到指定的单条数据的方法

在一般情况下,我们会要求后端在列表的时候输出一堆列表的JSON数据给我们,然后我们把这堆数据循环,就能在前端上显示列表了.

而我们在内容页的时候,则要求输出一个内容页的JSON数据给我们,我们就可以做内容页了.

但是,有时候,数据并不是特别复杂,我们可能需要从列表的数据中指定其中的单条数据.怎么做呢?

##标准答案,find方法

```javascript
var json = [{"id":1,"name":"张三"},{"id":2,"name":"李四"},{"id":3,"name":"王五"}];
```
如上所示,`json`是一个典型的列表数据.我如何指定找到`ID=1`的这条数据呢?

```javascript
var data = json.find(function(e){return e.id == 1});
console.log(data);
```
通过这样的回调函数,就能找到列表数据中的单条数据了.

>这段代码用了一个find方法,并且使用了一个回调函数.很优雅的解决了这个问题.下面,我将给出我的原始方案.

##我的方案,for循环

上面的`find`方法是我通过搜索引擎找到的解决方法,点击此处: [Array.prototype.find()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/find) .而我的原始解决方案如下:

```javascript
var json = [{"id":1,"name":"张三"},{"id":2,"name":"李四"},{"id":3,"name":"王五"}];
var data = getJsonById(2,json);
function getJsonById(id,data){
	for (var i = 0; i < data.length; i++) {
		if (data[i].id==id) {
			return data[i];
		}
	};
}
```
原理非常简单.通过循环遍历,找到和条件一致的内容,然后返回它即可.

在实际的项目运用中,还是用标准答案比较好.但是,我的方案可能更加有助于你学习理解这段内容哦!

本文由FungLeo原创,允许转载.但转载必须署名作者,并保留文章首发链接.否则将追究法律责任.
首发地址:http://blog.csdn.net/FungLeo/article/details/51555510